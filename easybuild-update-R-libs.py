#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
search for R libs updates
'''

import os
import commands
import urllib2

easyconfig = '/scicore/soft/apps/R/3.1.0-goolf-1.4.10/easybuild/R-3.1.0-goolf-1.4.10.eb'
    
if os.path.exists(easyconfig):
    
    f = open(easyconfig, "r")
    lines = f.readlines()
    f.close()
    
    # rewrite the easyconfig to remove non defined vars
    # and copy it to local dir
    f = open("./easyconfig.py", "w+")
    for line in lines:
        if "SOURCE_TAR_GZ" not in line:
            f.write(line)
    f.close()

    # import the easyconfig to fetch all the variables like exts_list
    from easyconfig import *

for ext in exts_list:
    #print ext
    if not type(ext) is tuple:
        continue
    else:
        ext_name = ext[0]
        ext_version = ext[1]
        ext_url = ext[2]['source_urls'][0]

    if "cran" in ext_url:
        cmd = "lynx -dump http://cran.r-project.org/web/packages/%s/index.html|grep -i version|awk {'print $2'}" % (ext_name)
        latest_version = commands.getoutput(cmd)
        print "('%s', '%s', ext_options)," % (ext_name, latest_version)       

    if "bioconductor" in ext_url:
        r_packages_url = 'http://www.bioconductor.org/packages/release/bioc/html/%s.html' % (ext_name)
        #print r_packages_url
        try:
            urllib2.urlopen(r_packages_url)
        except urllib2.HTTPError, e:
            pass
            #if e.code == 401:
            #    print 'not authorized'
            #elif e.code == 404:
            #    print 'not found'
            #elif e.code == 503:
            #    print 'service unavailable'
            #else:
            #    print 'unknown error: '
        else:
            cmd = "lynx -dump %s |grep Version | awk {'print $2'}" % (r_packages_url)
            latest_version = commands.getoutput(cmd)
            print "('%s', '%s', bioconductor_options)," % (ext_name, latest_version)       
            continue 

        r_annotation_url = "http://www.bioconductor.org/packages/release/data/annotation/html/%s.html" % (ext_name)
        try: 
            urllib2.urlopen(r_annotation_url)
        except urllib2.HTTPError, e:
            pass
        else: 
            cmd = "lynx -dump %s |grep Version | awk {'print $2'}" % (r_annotation_url)
            latest_version = commands.getoutput(cmd)
            print "('%s', '%s', bioconductor_options)," % (ext_name, latest_version)  
            continue

        r_experiment_url = "http://www.bioconductor.org/packages/release/data/experiment/html/%s.html" % (ext_name)     
        try:
            urllib2.urlopen(r_experiment_url)
        except urllib2.HTTPError, e:
            pass
        else:
            cmd = "lynx -dump %s |grep Version | awk {'print $2'}" % (r_experiment_url)
            latest_version = commands.getoutput(cmd)
            print "('%s', '%s', bioconductor_options)," % (ext_name, latest_version)  
