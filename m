Return-Path: <linux-kernel+bounces-829852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51757B980CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E7C4C2D11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CF123506F;
	Wed, 24 Sep 2025 02:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7Jazw+L"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A822173A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758679608; cv=none; b=jBOuIyYPISqBPqTv1hZNZ9hv2osKJvY+/FW0ugsut8qlqxjU+J+fP043+6hyoTbEBqrP541YojDUaUrcd4ChV7pQwsRLAA1nY1Dkk5IRo0KMXi+0ukkgZOCQWddF3rqr6lT5lW0wmaUh8YI51TY3KqAedc3Fyqe6ccHtka9oDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758679608; c=relaxed/simple;
	bh=j06FhP+kipsBirdtsi9W5187JT9Z+wgVUcWg7BEI980=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHwSj7+gPNOdxpwN8xkSW91vItIlrFjAUQBWnJv2e+hI3Bwcs++w/ybHq65i08V1P6Qg8dkqiAwVu/Crubwg8/2iKMbj3/3ItxuoaSCo+0jMovRS9H31eRgZkTD2p2I8BNef91ZtwQqox993eT2/yRyxBheFri8l/yD7ZhCh0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7Jazw+L; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so20196095ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758679606; x=1759284406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciePfvdtL+5lomPQDb47RhbqHcSVWA9My3xn0Ig9A5Q=;
        b=R7Jazw+LXRn1WbtlLQ3N796B3IM10r4Ax4YUW46Y7XMbxPAXFV7f99BfxwbxGqQaQe
         qcNfpKr56urf18dYNl3cIVirTaVyAq7e9Looe/K8WosrYZN4Bx1PqSXSLccabWsouKpQ
         /OWbU2+cob28iHOEGt7B/yDOqDoO/hlzno06n7XieYuMrjbrm0cuMwawnEqzYLQGU7fM
         qT4StRCtVlJbsdAn9BnLn1wZHxjVasgrdn4lQG3EHPlPy+2XINh/7HyE9VFhxK1Pf1+O
         alv/iN0O2lLSRzY9ad+2y+Ga0GM1eXW14p1+Bl8wjxUQZUbVQDIBiJSZeTOBXO4ClQfC
         ynFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758679606; x=1759284406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciePfvdtL+5lomPQDb47RhbqHcSVWA9My3xn0Ig9A5Q=;
        b=oKRaKCGneJc68TvUry/ZwV4enQp5E5P9ePvJKHMgxIYR+puUpR6FwnNIq4VW+dinPX
         5EElJ5wl5ovZ8pR/y7HCuF3hVP+v4jA1AlehPwXdpK3XK84Bm4qnDAUjZ4cpDammNiAz
         0FDaQBDLW/Klj5vX0J+TEz5P7Ivpydrxfd5bU9PUMvBQNDJGnzbdwtHgs84Vuqo7sBN5
         9Ulgf9DJGdMiqHj4qtILK1aQ08Om+EvIdl2FA4g0NicnsWuo9TiS8pkFLUxI1P0470xX
         0VLRl7HJoJIR19Tnz/vA/HwLl25VvlCJPL0LFvEaOP213QRVUbPYAwBZ1+EQ1TbzrKKA
         KWPA==
X-Gm-Message-State: AOJu0YwEn8/T7aUubnORDjPjamBSUoddgmxtPdUOEGNrxGus1/I7pIht
	xqH18tsy5LFOY6QcubtkdBbz1SaUj11j7k9DTskGXA8aOqklJwbY74a3
X-Gm-Gg: ASbGncvxFH595QQ19/U8cg/2Uh/jTJM68WSlfzJJP2dzP+OkDlKpnMiOku1D3zJ2FT9
	oZZdI0wEMCjTJ24vQOAULg2lQnA7qJKXrJ9Mj661IH2y+qAzB/9kByHtN9DjuxFzd/EOB44svr1
	J/Q/o725Hi7TZGuLZzv4Z1LxqH+Vs5Fv1ybO5y+oP6g4U185VeXnC8eJHO0NQPuR1qSH8lp9D3Z
	Nwc8+Sxr9ohlMihMYkluooT6C586i507xemLDrbyrqrhffVXRnc7aAyBvYFJBa1+6k0kVzrild7
	liYomodyz7rH6k1G1aUjlzvr3MZ99uEzqEQ++7WbMOgvuusAMhqVDH8B7tLvSwVhmGe6BoaBDnV
	rZxUP3ygwXxw2wMajbeClOI8SN1Y/Bo//
X-Google-Smtp-Source: AGHT+IGOg6vFWo5UC4mbvo1msbl/MOqcUGSOPdhiIHhmYncFpj5be1F9lexrCoDGvQar9VbrAedjdQ==
X-Received: by 2002:a17:903:1983:b0:24c:da3b:7376 with SMTP id d9443c01a7336-27cc2d8ef77mr57448685ad.26.1758679605713;
        Tue, 23 Sep 2025 19:06:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698005309bsm176147885ad.27.2025.09.23.19.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:06:41 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 946E441A2ED7; Wed, 24 Sep 2025 09:06:39 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v2 2/3] net: dns_resolver: Move dns_query() explanation out of code block
Date: Wed, 24 Sep 2025 09:06:24 +0700
Message-ID: <20250924020626.17073-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924020626.17073-1-bagasdotme@gmail.com>
References: <20250924020626.17073-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3856; i=bagasdotme@gmail.com; h=from:subject; bh=j06FhP+kipsBirdtsi9W5187JT9Z+wgVUcWg7BEI980=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmXA9OOXTp/TVZggteMNY/Oa01e/27b9L2FPKx3uK5xf Ji/2Ey2oKOUhUGMi0FWTJFlUiJf0+ldRiIX2tc6wsxhZQIZwsDFKQAT2RDG8E+R1bZB23d92C+5 Y85HdBU2Meew+X9ZW2101S+x31FYOIPhf2D7967Exc7akpP6dJn3Fq2Qyn097cG+jsNFU4O+O6y eyQYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Documentation for dns_query() is placed in the function's literal code
block snippet instead. Move it out of there.

Fixes: 9dfe1361261b ("docs: networking: convert dns_resolver.txt to ReST")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/dns_resolver.rst | 44 +++++++++++------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
index 5cec37bedf9950..fbbd2c4635cbd5 100644
--- a/Documentation/networking/dns_resolver.rst
+++ b/Documentation/networking/dns_resolver.rst
@@ -64,44 +64,42 @@ before the more general line given above as the first match is the one taken::
 Usage
 =====
 
-To make use of this facility, one of the following functions that are
-implemented in the module can be called after doing::
+To make use of this facility, first ``dns_resolver.h`` must be included::
 
 	#include <linux/dns_resolver.h>
 
-     ::
+Then queries may be made by calling::
 
 	int dns_query(const char *type, const char *name, size_t namelen,
 		     const char *options, char **_result, time_t *_expiry);
 
-     This is the basic access function.  It looks for a cached DNS query and if
-     it doesn't find it, it upcalls to userspace to make a new DNS query, which
-     may then be cached.  The key description is constructed as a string of the
-     form::
+This is the basic access function.  It looks for a cached DNS query and if
+it doesn't find it, it upcalls to userspace to make a new DNS query, which
+may then be cached.  The key description is constructed as a string of the
+form::
 
 		[<type>:]<name>
 
-     where <type> optionally specifies the particular upcall program to invoke,
-     and thus the type of query to do, and <name> specifies the string to be
-     looked up.  The default query type is a straight hostname to IP address
-     set lookup.
+where <type> optionally specifies the particular upcall program to invoke,
+and thus the type of query, and <name> specifies the string to be looked up.
+The default query type is a straight hostname to IP address set lookup.
 
-     The name parameter is not required to be a NUL-terminated string, and its
-     length should be given by the namelen argument.
+The name parameter is not required to be a NUL-terminated string, and its
+length should be given by the namelen argument.
 
-     The options parameter may be NULL or it may be a set of options
-     appropriate to the query type.
+The options parameter may be NULL or it may be a set of options
+appropriate to the query type.
 
-     The return value is a string appropriate to the query type.  For instance,
-     for the default query type it is just a list of comma-separated IPv4 and
-     IPv6 addresses.  The caller must free the result.
+The return value is a string appropriate to the query type.  For instance,
+for the default query type it is just a list of comma-separated IPv4 and
+IPv6 addresses.  The caller must free the result.
 
-     The length of the result string is returned on success, and a negative
-     error code is returned otherwise.  -EKEYREJECTED will be returned if the
-     DNS lookup failed.
+The length of the result string is returned on success, and a negative
+error code is returned otherwise.  -EKEYREJECTED will be returned if the
+DNS lookup failed.
 
-     If _expiry is non-NULL, the expiry time (TTL) of the result will be
-     returned also.
+If _expiry is non-NULL, the expiry time (TTL) of the result will be
+returned also.
 
 The kernel maintains an internal keyring in which it caches looked up keys.
 This can be cleared by any process that has the CAP_SYS_ADMIN capability by
-- 
An old man doll... just what I always wanted! - Clara


