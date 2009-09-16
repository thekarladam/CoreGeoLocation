//
//  CGLXML.h
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.15.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import <libxml/parser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>


xmlNodePtr cgl_xmlNodeGetChildNodeNamed(xmlNodePtr parentNode, const char *soughtNodeName);
