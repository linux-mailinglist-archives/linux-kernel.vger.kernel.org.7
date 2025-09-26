Return-Path: <linux-kernel+bounces-833957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2FFBA369E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D2F3AA648
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0885A2F49E6;
	Fri, 26 Sep 2025 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="xfqFhOlj"
Received: from mx08-007fc201.pphosted.com (mx08-007fc201.pphosted.com [91.207.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BA1A0728;
	Fri, 26 Sep 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884295; cv=none; b=JIY57dTFQ+zLGFbTM5qw+8BpFzw1Hvca+v837yytUTPo1PzM0nBbgLb/qHAJq+w3cHzCbPpi4Ts9YkdNO5tBtzOVZAwsY9FPjLlwnvdxqXaHML4kaztuN3Z86wUjIMSa1pWna52/YsYvfaYSKktiHYtt6k5ALG8Sop2WVlsdcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884295; c=relaxed/simple;
	bh=OlwSIEhC6piVzlola9oc9MYitobW9lQy0i2CACSYXoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvZX9D9jhBHaeJRXDdsLU7747zCJMxdhah7f+ZK8X8+tDKnsf3ddCOVHcuadCJMvB8Uh4ciOidBhjZJ+iJNKCV1IR6iMPPuOOqiPLrXOD+CkiW2ImCcHw98+ua8T8zCeQLauiSQzwmCKn8GM+kP//3TI6qEHfkcIXVgnEO7iOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=xfqFhOlj; arc=none smtp.client-ip=91.207.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456229.ppops.net [127.0.0.1])
	by mx08-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58QAlYfk1885731;
	Fri, 26 Sep 2025 12:58:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp-2025; bh=py
	tvRdTcmloiBeFxyTpL2fDC7wHne6PunwfFuQabaO8=; b=xfqFhOljlpuA0B7kuQ
	j2k1W18lyVlw9Z7nLsFg640mtnDKBBTLon/pElfNPK+FQ7pa5vn/3yTKK5YUFMc+
	xLZ8j0josmFOP39sNMOTV5B/W0U6U16hjfYxYrkPVK+eZ/3CinimQM02W6M9Hj3r
	PY7PpCShKED1Fm/+g3AZvaTBCVRbx9AtWqlFpQLmZ6/AMlA7u+SEo89+Gd2URoKr
	vB6VLQpDNRSrG2hJam3ZaROsgjPvwyTQCwr4pZVgHI6af5sJmeLNmDE6frWta0Vp
	n3T2kh4ls6fBfYvXHjxt2pVb0UCerNYF+rT5XhWZk/itTpLuxggD8V8XlUsYXJb9
	IO4g==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx08-007fc201.pphosted.com (PPS) with ESMTPS id 49dbt4g848-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 12:58:05 +0200 (MEST)
Received: from KAN23-025.cab.de (10.10.3.180) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 26 Sep
 2025 12:58:21 +0200
From: Markus Heidelberg <m.heidelberg@cab.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Markus
 Heidelberg <m.heidelberg@cab.de>
Subject: [PATCH 1/3] docs: dt: fix grammar and spelling
Date: Fri, 26 Sep 2025 12:57:47 +0200
Message-ID: <20250926105749.209674-2-m.heidelberg@cab.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926105749.209674-1-m.heidelberg@cab.de>
References: <20250926105749.209674-1-m.heidelberg@cab.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Adranos.cab.de (10.10.1.54) To Adranos.cab.de (10.10.1.54)
X-Proofpoint-GUID: bjw4cfpp92Ppwy3qS5EPA8W0v-g9bAkI
X-Authority-Analysis: v=2.4 cv=XdWEDY55 c=1 sm=1 tr=0 ts=68d671bd cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=kldc_9v1VKEA:10 a=yJojWOMRYYMA:10 a=4qyJXJ5HrNyFQtBNG3wA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: bjw4cfpp92Ppwy3qS5EPA8W0v-g9bAkI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEwMCBTYWx0ZWRfX1aN6Dc3KD9pS
 dvvQ8HZWI8jBkhuLtsRuMXnfrMhk3yIMoK9baLWYIIgM/FUqDeAbW6VF5EMRkfu8tQOGNP4M8hH
 HdcKcHhuAFdbaCvUuMBic+kS+GH2g02H3jViZAzuyPOhI02HhEhgrbBXz1xmJlDvNLTmVxhyyYh
 03ScHYa+dl6P1wpE0ZTJ3zZtuNglwTfO3HKedBkgUaB6ukEYHNFaJVSIVRdZKRQtLKXoGqwtiTy
 hl8Q4bln5kKH5M4SOvkZTT2GIhno9YYlzzxQg+Cdz4qeDE+z3TiBs7QX3TGAz59AiFtyEf0FFrD
 +GXIOHGuY5s4vhc0gSvcSELWKSQ+kh8WSijU+8hLPs1zgTIDVfIbeY+h8ArwP+Vfu3oQo7Vu+XG
 +OHzeSoIxN6+ZS/8e/AmwtGESg5lXw==

Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
---
 Documentation/devicetree/of_unittest.rst   | 4 ++--
 Documentation/devicetree/overlay-notes.rst | 6 +++---
 Documentation/devicetree/usage-model.rst   | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/of_unittest.rst b/Documentation/devicetree/of_unittest.rst
index a6c05962add3..8b557acd29d1 100644
--- a/Documentation/devicetree/of_unittest.rst
+++ b/Documentation/devicetree/of_unittest.rst
@@ -56,7 +56,7 @@ drivers/of/unittest.c. See the content of the folder::
 
 for the Device Tree Source Include files (.dtsi) included in testcases.dts.
 
-When the kernel is build with CONFIG_OF_UNITTEST enabled, then the following make
+When the kernel is built with CONFIG_OF_UNITTEST enabled, then the following make
 rule::
 
     $(obj)/%.dtb: $(src)/%.dts FORCE
@@ -133,7 +133,7 @@ via the following kernel symbols::
     __dtb_testcases_end   - address marking the end of test data blob
 
 Secondly, it calls of_fdt_unflatten_tree() to unflatten the flattened
-blob. And finally, if the machine's device tree (i.e live tree) is present,
+blob. And finally, if the machine's device tree (i.e. live tree) is present,
 then it attaches the unflattened test data tree to the live tree, else it
 attaches itself as a live device tree.
 
diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
index 35e79242af9a..ba401ef850e7 100644
--- a/Documentation/devicetree/overlay-notes.rst
+++ b/Documentation/devicetree/overlay-notes.rst
@@ -14,11 +14,11 @@ How overlays work
 A Devicetree's overlay purpose is to modify the kernel's live tree, and
 have the modification affecting the state of the kernel in a way that
 is reflecting the changes.
-Since the kernel mainly deals with devices, any new device node that result
+Since the kernel mainly deals with devices, any new device node that results
 in an active device should have it created while if the device node is either
 disabled or removed all together, the affected device should be deregistered.
 
-Lets take an example where we have a foo board with the following base tree::
+Let's take an example where we have a foo board with the following base tree::
 
     ---- foo.dts ---------------------------------------------------------------
 	/* FOO platform */
@@ -111,7 +111,7 @@ The API is quite easy to use.
 1) Call of_overlay_fdt_apply() to create and apply an overlay changeset. The
    return value is an error or a cookie identifying this overlay.
 
-2) Call of_overlay_remove() to remove and cleanup the overlay changeset
+2) Call of_overlay_remove() to remove and clean up the overlay changeset
    previously created via the call to of_overlay_fdt_apply(). Removal of an
    overlay changeset that is stacked by another will not be permitted.
 
diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devicetree/usage-model.rst
index 0717426856b2..c6146c96ac56 100644
--- a/Documentation/devicetree/usage-model.rst
+++ b/Documentation/devicetree/usage-model.rst
@@ -46,7 +46,7 @@ The DT was originally created by Open Firmware as part of the
 communication method for passing data from Open Firmware to a client
 program (like to an operating system).  An operating system used the
 Device Tree to discover the topology of the hardware at runtime, and
-thereby support a majority of available hardware without hard coded
+thereby supported a majority of available hardware without hard coded
 information (assuming drivers were available for all devices).
 
 Since Open Firmware is commonly used on PowerPC and SPARC platforms,
@@ -128,7 +128,7 @@ successor, the BeagleBoard xM board might look like, respectively::
 	compatible = "ti,omap3-beagleboard-xm", "ti,omap3450", "ti,omap3";
 
 Where "ti,omap3-beagleboard-xm" specifies the exact model, it also
-claims that it compatible with the OMAP 3450 SoC, and the omap3 family
+claims that it is compatible with the OMAP 3450 SoC, and the omap3 family
 of SoCs in general.  You'll notice that the list is sorted from most
 specific (exact board) to least specific (SoC family).
 
@@ -205,7 +205,7 @@ platform-specific configuration data.
 
 During early boot, the architecture setup code calls of_scan_flat_dt()
 several times with different helper callbacks to parse device tree
-data before paging is setup.  The of_scan_flat_dt() code scans through
+data before paging is set up.  The of_scan_flat_dt() code scans through
 the device tree and uses the helpers to extract information required
 during early boot.  Typically the early_init_dt_scan_chosen() helper
 is used to parse the chosen node including kernel parameters,
-- 
2.43.0


