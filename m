Return-Path: <linux-kernel+bounces-820825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E9B7F6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BA4188A38F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E31E330D5B;
	Wed, 17 Sep 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qZERrcHp"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2332E742
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115855; cv=none; b=NmR25+/dm6uLTYZqorrUbZ38isKeVP/PNXbub1W54AhWx8mbhzloA8grUMQWz2EEW5Lq9sIBap0jSu0ySNVIRj7TgQrehNLesxLkfX0JJ3VsWzA9dWiiUjIZwGaUi49OYQhTpMgLpQt+b/CvesY40+iWeGdGGXPL9W2HwjjP+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115855; c=relaxed/simple;
	bh=sc2EE0+QmIXZUojuXWuZnjKPlj10YMGnzKhst0JuMJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=SGNVw/EF83DeF6eQR4deUa7dynSEqAV7dI+juz2/40myNmOhkcLJR1J8qWRECIhKy/+ipJVp4QDH+6suWMeqLq27m30ho0/ZBs3CZx5Qg/FoxMN6jVmX5slIOI3oKV8PZoTli/12GJv437ELdEUox9IVtHph5qWLs+j+tWnrGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qZERrcHp; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250917133050epoutp04ce701d0ea122b35ec52eebc268e0dd56~mFQ0ah1Gi2406724067epoutp04c
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:30:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250917133050epoutp04ce701d0ea122b35ec52eebc268e0dd56~mFQ0ah1Gi2406724067epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758115850;
	bh=Tzf++Z8J1+T9kRGY8CZ5Q8sYrCDb44hcVDm2fad7IJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZERrcHpJAOIc4l9PqmeELxoMXjQ4pnjj6kn7UHP7WWZNruvipp5bhWAniY+1iBGP
	 PNu7/TG04V/pzzgIcAniN9SnB7oNMTDaK3nl96DxvOGSfhkm6X60l1OdAm2hTlJBdf
	 jMMRH1m++qw0kgZg0+1+BHeQd1I5BO6gl50bxemE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250917133050epcas5p21eaf9802669468616589a243a74122cd~mFQ0HFNab1087610876epcas5p2g;
	Wed, 17 Sep 2025 13:30:50 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cRfm91ttjz2SSKZ; Wed, 17 Sep
	2025 13:30:49 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250917133048epcas5p182057ccd92859fe501c0296a9027e3cf~mFQyyaILG2308423084epcas5p1N;
	Wed, 17 Sep 2025 13:30:48 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250917133047epsmtip14797ff450e48b069913839cc8277afaf~mFQxqxNoN0522305223epsmtip1f;
	Wed, 17 Sep 2025 13:30:47 +0000 (GMT)
From: Neeraj Kumar <s.neeraj@samsung.com>
To: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com
Cc: a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	Neeraj Kumar <s.neeraj@samsung.com>
Subject: [PATCH V3 13/20] cxl/mem: Refactor cxl pmem region auto-assembling
Date: Wed, 17 Sep 2025 18:59:33 +0530
Message-Id: <20250917132940.1566437-14-s.neeraj@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917132940.1566437-1-s.neeraj@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917133048epcas5p182057ccd92859fe501c0296a9027e3cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917133048epcas5p182057ccd92859fe501c0296a9027e3cf
References: <20250917132940.1566437-1-s.neeraj@samsung.com>
	<CGME20250917133048epcas5p182057ccd92859fe501c0296a9027e3cf@epcas5p1.samsung.com>

In 84ec985944ef3, devm_cxl_add_nvdimm() sequence was changed and called
before devm_cxl_add_endpoint(). It's because cxl pmem region auto-assembly
used to get called at last in cxl_endpoint_port_probe(), which requires
cxl_nvd presence.

For cxl region persistency, region creation happens during nvdimm_probe
which need the completion of endpoint probe.

In order to accommodate both cxl pmem region auto-assembly and cxl region
persistency, refactored following

1. Re-Sequence devm_cxl_add_nvdimm() after devm_cxl_add_endpoint(). This
   will be called only after successful completion of endpoint probe.

2. Moved cxl pmem region auto-assembly from cxl_endpoint_port_probe() to
   cxl_mem_probe() after devm_cxl_add_nvdimm(). It gurantees both the
   completion of endpoint probe and cxl_nvd presence before its call.

Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
---
 drivers/cxl/core/region.c | 33 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  4 ++++
 drivers/cxl/mem.c         | 24 +++++++++++++++---------
 drivers/cxl/port.c        | 39 +--------------------------------------
 4 files changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7a0cead24490..c325aa827992 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3606,6 +3606,39 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
 
+static int discover_region(struct device *dev, void *unused)
+{
+	struct cxl_endpoint_decoder *cxled;
+	int rc;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
+		return 0;
+
+	if (cxled->state != CXL_DECODER_STATE_AUTO)
+		return 0;
+
+	/*
+	 * Region enumeration is opportunistic, if this add-event fails,
+	 * continue to the next endpoint decoder.
+	 */
+	rc = cxl_add_to_region(cxled);
+	if (rc)
+		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
+			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
+
+	return 0;
+}
+
+void cxl_region_discovery(struct cxl_port *port)
+{
+	device_for_each_child(&port->dev, NULL, discover_region);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_region_discovery, "CXL");
+
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
 {
 	struct cxl_region_ref *iter;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4fe3df06f57a..b57597e55f7e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -873,6 +873,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
+void cxl_region_discovery(struct cxl_port *port);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -895,6 +896,9 @@ static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
 {
 	return 0;
 }
+static inline void cxl_region_discovery(struct cxl_port *port)
+{
+}
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6e6777b7bafb..54501616ff09 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -152,15 +152,6 @@ static int cxl_mem_probe(struct device *dev)
 		return -ENXIO;
 	}
 
-	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
-		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
-		if (rc) {
-			if (rc == -ENODEV)
-				dev_info(dev, "PMEM disabled by platform\n");
-			return rc;
-		}
-	}
-
 	if (dport->rch)
 		endpoint_parent = parent_port->uport_dev;
 	else
@@ -184,6 +175,21 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
 
+	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
+		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
+		if (rc) {
+			if (rc == -ENODEV)
+				dev_info(dev, "PMEM disabled by platform\n");
+			return rc;
+		}
+	}
+
+	/*
+	 * Now that all endpoint decoders are successfully enumerated, try to
+	 * assemble region autodiscovery from committed decoders.
+	 */
+	cxl_region_discovery(cxlmd->endpoint);
+
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index cf32dc50b7a6..07bb909b7d2e 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -30,33 +30,6 @@ static void schedule_detach(void *cxlmd)
 	schedule_cxl_memdev_detach(cxlmd);
 }
 
-static int discover_region(struct device *dev, void *unused)
-{
-	struct cxl_endpoint_decoder *cxled;
-	int rc;
-
-	if (!is_endpoint_decoder(dev))
-		return 0;
-
-	cxled = to_cxl_endpoint_decoder(dev);
-	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
-		return 0;
-
-	if (cxled->state != CXL_DECODER_STATE_AUTO)
-		return 0;
-
-	/*
-	 * Region enumeration is opportunistic, if this add-event fails,
-	 * continue to the next endpoint decoder.
-	 */
-	rc = cxl_add_to_region(cxled);
-	if (rc)
-		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
-			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
-
-	return 0;
-}
-
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -121,17 +94,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
-	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
-	if (rc)
-		return rc;
-
-	/*
-	 * Now that all endpoint decoders are successfully enumerated, try to
-	 * assemble regions from committed decoders
-	 */
-	device_for_each_child(&port->dev, NULL, discover_region);
-
-	return 0;
+	return devm_cxl_enumerate_decoders(cxlhdm, &info);
 }
 
 static int cxl_port_probe(struct device *dev)
-- 
2.34.1


