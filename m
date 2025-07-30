Return-Path: <linux-kernel+bounces-750717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4169AB1602B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790507B309F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB5229E10A;
	Wed, 30 Jul 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bRr9xTR7"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438CF29E107
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753877854; cv=none; b=FSw8PFUBqlS7/D6jq1G94zeKMyJxieZ9IzaDXHs6vkzSKHIvRTJ0XSCz8vDYg9OtuZVRNpZP72ymTTkz5Wsc90gg1fnIQ0A3/7aEM0/aJYxnum7d9RWHeiruZ4XmCKL79JDZ3WhCXfyFN1ovDryu90kaIVkIdCbs4p/PiMhaKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753877854; c=relaxed/simple;
	bh=8QH1l6WhkxI25RXDqtdyvnQAdOa9RFZNwZRhHLcA25w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=AxkXssLQ9PCjwkUIcc7vA+iA8CDvrtxW192F8yo+TWIMr8P+FKsvuBvzNss15DGnUENGPDwGA1xIeW0XWte3FsHFMmuxHxoqMbZDNO8UfF0YglJafLB7FH60ktToos1fmTK0Rh2dihYrOgaYzGIrc+ZldFZHyOMMoaD7QojNkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bRr9xTR7; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250730121731epoutp01b6138e283f14d69ef7736ce978d81179~XBp0SO19d1980419804epoutp01S
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:17:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250730121731epoutp01b6138e283f14d69ef7736ce978d81179~XBp0SO19d1980419804epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753877851;
	bh=Lrv2ikBf3O5NwJGep2hXkTk6Ovkh45U+lUMsg7E/HGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bRr9xTR7qelx+n4LxKrchhFwJ3xIKKtbB64AKjY4gA0Qjpqt3kQAnp7zcb2HZPni7
	 xzXKoEUhTYwYFo+tEQ2mqfhG4MeexSQmRoiHR6qdqZkIilFLSZX8x/JThrHz7p9qdy
	 t4NVu+t/r+7WgJ9lgCoFVfetq6gLz0FXWBVCVDq4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250730121731epcas5p39f30ca6d1fa55a3224409a0fe355505e~XBpz2kEGk3063230632epcas5p3n;
	Wed, 30 Jul 2025 12:17:31 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bsWSB1MtCz6B9m5; Wed, 30 Jul
	2025 12:17:30 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250730121245epcas5p247b6675350f4f7e70e9b3c8465340e84~XBlpgDSSn0097600976epcas5p2e;
	Wed, 30 Jul 2025 12:12:45 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250730121243epsmtip10e9407f2877d1987b16f9f76abb0061f~XBlodhg7h0426504265epsmtip1B;
	Wed, 30 Jul 2025 12:12:43 +0000 (GMT)
From: Neeraj Kumar <s.neeraj@samsung.com>
To: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com
Cc: a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	Neeraj Kumar <s.neeraj@samsung.com>
Subject: [PATCH V2 17/20] cxl/pmem: Preserve region information into nd_set
Date: Wed, 30 Jul 2025 17:42:06 +0530
Message-Id: <20250730121209.303202-18-s.neeraj@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730121209.303202-1-s.neeraj@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250730121245epcas5p247b6675350f4f7e70e9b3c8465340e84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250730121245epcas5p247b6675350f4f7e70e9b3c8465340e84
References: <20250730121209.303202-1-s.neeraj@samsung.com>
	<CGME20250730121245epcas5p247b6675350f4f7e70e9b3c8465340e84@epcas5p2.samsung.com>

Save region information stored in cxlr to nd_set during
cxl_pmem_region_probe in nd_set. This saved region information is being
stored into LSA, which will be used for cxl region persistence

Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
---
 drivers/cxl/pmem.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index e197883690ef..38a5bcdc68ce 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -377,6 +377,7 @@ static int cxl_pmem_region_probe(struct device *dev)
 	struct nd_mapping_desc mappings[CXL_DECODER_MAX_INTERLEAVE];
 	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
 	struct cxl_region *cxlr = cxlr_pmem->cxlr;
+	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
 	struct cxl_pmem_region_info *info = NULL;
 	struct nd_interleave_set *nd_set;
@@ -465,12 +466,12 @@ static int cxl_pmem_region_probe(struct device *dev)
 	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
 	ndr_desc.mapping = mappings;
 
-	/*
-	 * TODO enable CXL labels which skip the need for 'interleave-set cookie'
-	 */
-	nd_set->cookie1 =
-		nd_fletcher64(info, sizeof(*info) * cxlr_pmem->nr_mappings, 0);
-	nd_set->cookie2 = nd_set->cookie1;
+	nd_set->uuid = p->uuid;
+	nd_set->interleave_ways = p->interleave_ways;
+	nd_set->interleave_granularity = p->interleave_granularity;
+	nd_set->res = p->res;
+	nd_set->nr_targets =  p->nr_targets;
+
 	ndr_desc.nd_set = nd_set;
 
 	cxlr_pmem->nd_region =
-- 
2.34.1


