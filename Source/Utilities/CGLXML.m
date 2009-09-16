//
//  CGLXML.m
//  CoreGeoLocation
//
//  Created by Karl Adam on 09.09.15.
//  Copyright 2009 Karl Adam. BSD Licensed, check ReadMe.markdown for details
//

#import "CGLXML.h"
#import <string.h>


xmlNodePtr cgl_xmlNodeGetChildNodeNamed(xmlNodePtr inParentNode, const char *soughtNodeName) {
	xmlNodePtr foundNode = NULL;

	if (inParentNode) {
		xmlNodePtr currentNode = inParentNode->children;
		
		for ( ; currentNode; currentNode = currentNode->next) {
			if (strcmp(soughtNodeName, (const char *)currentNode->name) == 0) {
				foundNode = currentNode;
				break;
			}
		}
	}

	return foundNode;	
}
