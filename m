Return-Path: <linux-kernel+bounces-777985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DFFB2E015
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357F71C81310
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE22321F2C;
	Wed, 20 Aug 2025 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/lz1KJM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9292D3231;
	Wed, 20 Aug 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701795; cv=none; b=BA/TkzmGlMfSjOukO6Cdh6B4lyveUTOvz722keJAET3okoOG3Iabxtyrk3I7e67Ga67HHiinYZVcp2Kc4xz58A7haAeT4hYqt9oWGBjV7u9omhePhRxFHFoLAi5PEoLHch2VuBOKHnmSHD5b32TX5wIEEaZ4uDmQIJ4nB/uRqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701795; c=relaxed/simple;
	bh=bsvWlLsiwAXSsALmAJFw7fx/DntpOaz1JMs8wm09NR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WnIrNCQnwZ59hWsdQuHSWZ5k8vZjmWkmM5SwU+pxWRJdDQ1meiwbC+Y+V7ORT+4bEyVO+MPMIM/RUjoKtRoOCDwTIysvbkLmGREjbmMfzU7DgMtJVnPiZi7uM+WOtM1PCzA/KZJ3YpLNYmnCsQEWuYRF+IaMpKcPgTDC3hHkFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/lz1KJM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755701794; x=1787237794;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bsvWlLsiwAXSsALmAJFw7fx/DntpOaz1JMs8wm09NR8=;
  b=i/lz1KJMsfwacts9f8hDHWfDH6FXc/SWr75OrWSSjV9aliylLXszSSHz
   TTuPkod9UDoupBQypN3b9yuKjwUDyP6pYjM0tVsE5pI387Q7ZicsXanCc
   nGe5UWpCFrFtsd23EI+PrQwnZbMR0drK1IAmosJMlj3s5dCnRMWdnd/te
   eOU3NJdFaVxYUp1lFSZBKwFCeGjt+2sq6S6PajyQtBygBZXsmHZZgSbfd
   B/h5fyT036o0kju4FZAFNVKmdNu9U2stkjwv29deJ3ZRO4fCw+UPLlJrA
   wthCriwNEsJYD3YkkuN63C+QwE+SOb3P6SDGMMZtvgyeB9j9N9290C+Gn
   Q==;
X-CSE-ConnectionGUID: 7pE8jVwmQfugvTkkEAHyag==
X-CSE-MsgGUID: sBjY5EtQT1u2dB+H4+zHiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="83392643"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="83392643"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:56:33 -0700
X-CSE-ConnectionGUID: jJ2diAs/SiOPIe6qS2KRDw==
X-CSE-MsgGUID: 415JJfscSwK8eo0auHw4FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168498862"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.85])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:56:29 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "linux-cxl @ vger . kernel . org --cc=Davidlohr Bueso" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gregory Price <gourry@gourry.net>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v4] cxl: docs/driver-api/conventions resolve conflicts between CFMWS, LMH, Decoders
Date: Wed, 20 Aug 2025 16:55:58 +0200
Message-ID: <20250820145624.1170566-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation on how to resolve conflicts between CXL Fixed Memory
Windows, Platform Low Memory Holes, intermediate Switch and Endpoint
Decoders.

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---

v3 -> v4: Show and explain how CFMWS, Root Decoders, Intermediate
	  Switch and Endpoint Decoders match and attach Regions in
	  x86 platforms with Low Memory Holes (Dave, Gregory, Ira)
	  Remove a wrong argument about large interleaves (Jonathan)

v2 -> v3: Rework a few phrases for better clarity.
	  Fix grammar and syntactic errors (Randy, Alok).
	  Fix semantic errors ("size does not comply", Alok).
	  Fix technical errors ("decoder's total memory?", Alok).
	  
v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.

 Documentation/driver-api/cxl/conventions.rst | 111 +++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index da347a81a237..714240ed2e04 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -45,3 +45,114 @@ Detailed Description of the Change
 ----------------------------------
 
 <Propose spec language that corrects the conflict.>
+
+
+Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
+============================================================================
+
+Document
+--------
+
+CXL Revision 3.2, Version 1.0
+
+License
+-------
+
+SPDX-License Identifier: CC-BY-4.0
+
+Creator/Contributors
+--------------------
+
+Fabio M. De Francesco, Intel
+Dan J. Williams, Intel
+Mahesh Natu, Intel
+
+Summary of the Change
+---------------------
+
+According to the current CXL Specifications (Revision 3.2, Version 1.0),
+the CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
+Physical Address (HPA) windows associated with each CXL Host Bridge. Each
+window represents a contiguous HPA range that may be interleaved across
+one or more targets, including CXL Host Bridges. Each window has a set of
+restrictions that govern its usage. It is the OSPM’s responsibility to
+utilize each window for the specified use.
+
+Table 9-22 states the Window Size field contains the total number of
+consecutive bytes of HPA this window represents. This value must be a
+multiple of the Number of Interleave Ways * 256 MB.
+
+Platform Firmware (BIOS) might reserve physical addresses below 4 GB,
+such as the Low Memory Hole for PCIe MMIO. In such cases, the CFMWS Range
+Size may not adhere to the NIW * 256 MB rule.
+
+On these systems, BIOS publishes CFMWS to communicate the active System
+Physical Address (SPA) ranges that map to a subset of the Host Physical
+Address (HPA) ranges. The SPA range trims out the hole, resulting in lost
+capacity in the endpoint with no SPA to map to the CXL HPA range that
+exceeds the matching CFMWS range.
+
+E.g, a real x86 platform with two CFMWS, 384 GB total memory, and LMH
+starting at 2 GB:
+
+Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size | Ways | Granularity
+  0    |   0 GB     |     2 GB   |      0 GB        |       3 GB       |  12  |    256
+  1    |   4 GB     |   380 GB   |      0 GB        |     380 GB       |  12  |    256
+
+HDM decoder base and HDM decoder size represent all the 12 Endpoint
+Decoders of a 12 way region and all the intermediate Switch Decoders.
+They are configured by the BIOS according to the NIW * 256MB rule,
+resulting in a HPA range size of 3GB.
+
+The CFMWS Base and CFMWS Size are used to configure the Root Decoder HPA
+range base and size. CFMWS cannot intersect Memory Holes, then the CFMWS[0]
+size is smaller (2GB) than that of the Switch and Endpoint Decoders that
+make the hierarchy (3GB).
+
+On that platform, only the first 2GB will be potentially usable but,
+because of the current specs, Linux fails to make them available to the
+users. The driver expects that Root Decoder HPA size, which is equal to
+the CFMWS from which it is configured, to be greater or equal to the
+matching Switch and Endpoint HDM Decoders.
+
+The CXL driver fails to construct Regions and to attach Endpoint and
+intermediate Switch Decoders to those Regions after their construction.
+
+In order to succeed with Region construction and Decoders attachment,
+Linux must construct Regions with Root Decoders size, and then attach to
+them all the intermediate Switch and Endpoint Decoders that are part of the
+hierarchy, even though the Decoders HPA range sizes may be larger than
+those Regions whose sizes are trimmed by Low Memory Holes.
+
+Benefits of the Change
+----------------------
+
+Without this change, the OSPM wouldn't match Intermediate and Endpoint
+Decoders with Root Decoders configured with CFMWS HPA sizes that don't
+align with the NIW * 256MB constraint, leading to lost memdev capacity.
+This change allows the OSPM to construct Regions and attach Intermediate
+Switch and Endpoint Decoders to them, so that the addressable part of the
+memory devices total capacity is not lost.
+
+References
+----------
+
+Compute Express Link Specification Revision 3.2, Version 1.0
+<https://www.computeexpresslink.org/>
+
+Detailed Description of the Change
+----------------------------------
+
+The description of the Window Size field in table 9-22 needs to account
+for platforms with Low Memory Holes, where SPA ranges might be subsets of
+the endpoints' HPA. Therefore, it has to be changed to the following:
+
+"The total number of consecutive bytes of HPA this window represents.
+This value shall be a multiple of NIW * 256 MB. On platforms that reserve
+physical addresses below 4 GB, such as the Low Memory Hole for PCIe MMIO
+on x86 or a requirement for greater than 8-way interleave CXL Regions
+starting at address 0, an instance of CFMWS whose Base HPA is 0 might have
+a window size that doesn't align with the NIW * 256 MB constraint. Note
+that the matching intermediate Switch and Endpoint Decoders' HPA range
+sizes must still align to the above-mentioned rule, but the memory capacity
+that exceeds the CFMWS window size will not be accessible."
-- 
2.50.1


