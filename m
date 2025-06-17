Return-Path: <linux-kernel+bounces-690162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 242DCADCC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 15:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922F11886CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EC42EB5CE;
	Tue, 17 Jun 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Dtp1MO7R"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9992E92BE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165389; cv=none; b=S/BU6FDk7Ff8U8QpXOmD0Yi7+iFLZr6u4GCSFqRa6Qg3NiGcO77quYwBtA2MuMlIZ6+5soQHFTIbEpaPVYmC8pulbeRzN23T69zvoOpgn/1TVQYRzzNdPxe1RQOiqNmUDwOpgH8d10kU1I5QdriXYZKZIlu5xUvQDqWGgud6NBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165389; c=relaxed/simple;
	bh=t04sO4CQuE/QA2zudIv29/n48I3vMnDMu5F1XTFWpfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=uKiWKBs/xd/rxfa0UyBCsaf8uo3Ji63ntRTslxckDzYusPJWtsAG915TDQk+8rKCbm76/YjyeenaewTikhCL/sii4s+CF0/6urYgx2F95ZhOWoDF7Evcw9jLbD/cw8ed4Ny0T7GbgByeA/JtqLh6T9SKk2whRzGlh4L+B5mjzpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Dtp1MO7R; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250617130303epoutp045fb84f228843c22e23971452d3a5a15a~J1iTBUvp82709227092epoutp04E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 13:03:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250617130303epoutp045fb84f228843c22e23971452d3a5a15a~J1iTBUvp82709227092epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750165383;
	bh=UdtcVI3vLbZlhF9JG5xPbvAx7ji2FXSMT/iyxSokjDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dtp1MO7RAGp8B0VCovmvkHGHnv+EeEsXyFYbb1LwW1E712VBYZtuA+Ilr1R6Z/UOd
	 t/R4bDh+osldFP+nACM0OGZ+yiHQcq10lhUooyo69WlT9wPzf4gfK9wS3TrLcqyFDP
	 42IzNc1s88gtmHwXdMgZua8qHG/J/hrVDA/0Vnmg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250617130302epcas5p3e03a5d2f173eb8b918bde9df33e3c8bc~J1iSCqiSO0463204632epcas5p3Z;
	Tue, 17 Jun 2025 13:03:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bM6VZ3MmCz6B9m6; Tue, 17 Jun
	2025 13:03:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250617124046epcas5p16a45d2afe3b41ca08994a5cca09bfb68~J1O14nozG0034200342epcas5p16;
	Tue, 17 Jun 2025 12:40:46 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250617124043epsmtip24debb5e4d9bc7c585786bcca32a7e49b~J1OzPOjY62545625456epsmtip2l;
	Tue, 17 Jun 2025 12:40:43 +0000 (GMT)
From: Neeraj Kumar <s.neeraj@samsung.com>
To: dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: a.manzanares@samsung.com, nifan.cxl@gmail.com, anisa.su@samsung.com,
	vishak.g@samsung.com, krish.reddy@samsung.com, arun.george@samsung.com,
	alok.rathore@samsung.com, s.neeraj@samsung.com, neeraj.kernel@gmail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, gost.dev@samsung.com, cpgs@samsung.com
Subject: [RFC PATCH 14/20] cxl/region: Add cxl pmem region creation routine
 for region persistency
Date: Tue, 17 Jun 2025 18:09:38 +0530
Message-Id: <1691538257.61750165382463.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617123944.78345-1-s.neeraj@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250617124046epcas5p16a45d2afe3b41ca08994a5cca09bfb68
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250617124046epcas5p16a45d2afe3b41ca08994a5cca09bfb68
References: <20250617123944.78345-1-s.neeraj@samsung.com>
	<CGME20250617124046epcas5p16a45d2afe3b41ca08994a5cca09bfb68@epcas5p1.samsung.com>

Added exported cxl_create_pmem_region routine to create cxl pmem region
from LSA parsed cxl region information.
Inspirition for the function is taken from ndctl device attribute
(_store) call. It allocates cxlr and fills information parsed from LSA
and calls device_add(&cxlr->dev) to initiates further region creation
porbes

Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
---
 drivers/cxl/core/port.c   |   6 ++
 drivers/cxl/core/region.c | 208 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  11 ++
 3 files changed, 225 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bca668193c49..2452f7c15b2d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2150,6 +2150,12 @@ void cxl_bus_drain(void)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_bus_drain, "CXL");
 
+void cxl_wq_flush(void)
+{
+	flush_workqueue(cxl_bus_wq);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_wq_flush, "CXL");
+
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 {
 	return queue_work(cxl_bus_wq, &cxlmd->detach_work);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b98b1ccffd1c..8990e3c3474d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2522,6 +2522,214 @@ static ssize_t create_ram_region_show(struct device *dev,
 	return __create_region_show(to_cxl_root_decoder(dev), buf);
 }
 
+static ssize_t update_region_size(struct cxl_region *cxlr, u64 val)
+{
+	int rc;
+
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	if (val)
+		rc = alloc_hpa(cxlr, val);
+	else
+		rc = free_hpa(cxlr);
+	up_write(&cxl_region_rwsem);
+
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static ssize_t update_region_dpa_size(struct cxl_region *cxlr,
+		struct cxl_decoder *cxld,
+		unsigned long long size)
+{
+	int rc;
+	struct cxl_endpoint_decoder *cxled =
+		to_cxl_endpoint_decoder(&cxld->dev);
+
+	if (!IS_ALIGNED(size, SZ_256M))
+		return -EINVAL;
+
+	rc = cxl_dpa_free(cxled);
+	if (rc)
+		return rc;
+
+	if (size == 0)
+		return 0;
+
+	rc = cxl_dpa_alloc(cxled, size);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static ssize_t update_region_dpa_mode(struct cxl_region *cxlr,
+		struct cxl_decoder *cxld)
+{
+	int rc;
+	struct cxl_endpoint_decoder *cxled =
+		to_cxl_endpoint_decoder(&cxld->dev);
+
+	rc = cxl_dpa_set_mode(cxled, CXL_DECODER_PMEM);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static size_t attach_region_target(struct cxl_region *cxlr,
+		struct cxl_decoder *cxld, int pos)
+{
+	int rc;
+	struct cxl_endpoint_decoder *cxled =
+		to_cxl_endpoint_decoder(&cxld->dev);
+
+	rc = attach_target(cxlr, cxled, pos, TASK_INTERRUPTIBLE);
+
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+static ssize_t commit_region(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	ssize_t rc;
+
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	/* Already in the requested state? */
+	if (p->state >= CXL_CONFIG_COMMIT)
+		goto out;
+
+	/* Not ready to commit? */
+	if (p->state < CXL_CONFIG_ACTIVE) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	/*
+	 * Invalidate caches before region setup to drop any speculative
+	 * consumption of this address space
+	 */
+	rc = cxl_region_invalidate_memregion(cxlr);
+	if (rc)
+		goto out;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc == 0)
+		p->state = CXL_CONFIG_COMMIT;
+out:
+	up_write(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+	return 0;
+}
+
+static struct cxl_region *
+devm_cxl_pmem_add_region(struct cxl_root_decoder *cxlrd,
+		struct cxl_decoder *cxld,
+		struct cxl_pmem_region_params *params, int id,
+		enum cxl_decoder_mode mode, enum cxl_decoder_type type)
+{
+	struct cxl_port *port;
+	struct cxl_region *cxlr;
+	struct cxl_region_params *p;
+	struct device *dev;
+	int rc;
+
+	if (!cxlrd)
+		return ERR_PTR(-EINVAL);
+
+	port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
+
+	cxlr = cxl_region_alloc(cxlrd, id);
+	if (IS_ERR(cxlr))
+		return cxlr;
+	cxlr->mode = mode;
+	cxlr->type = type;
+
+	dev = &cxlr->dev;
+	rc = dev_set_name(dev, "region%d", id);
+	if (rc)
+		goto err;
+
+	p = &cxlr->params;
+	p->uuid = params->uuid;
+	p->interleave_ways = params->nlabel;
+	p->interleave_granularity = params->ig;
+
+	/* Update region size */
+	if (update_region_size(cxlr, params->rawsize))
+		goto err;
+
+	/* Flush cxl wq */
+	cxl_wq_flush();
+
+	/* Clear DPA Size */
+	if (update_region_dpa_size(cxlr, cxld, 0))
+		goto err;
+
+	/* Update DPA mode */
+	if (update_region_dpa_mode(cxlr, cxld))
+		goto err;
+
+	/* Update DPA Size */
+	if (update_region_dpa_size(cxlr, cxld, params->rawsize))
+		goto err;
+
+	/* Attach region targets */
+	if (attach_region_target(cxlr, cxld, params->position))
+		goto err;
+
+	/* Commit Region */
+	if (commit_region(cxlr))
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
+	if (rc)
+		return ERR_PTR(rc);
+
+	dev_dbg(port->uport_dev, "%s: created %s\n",
+		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
+	return cxlr;
+
+err:
+	put_device(dev);
+	return ERR_PTR(rc);
+}
+
+struct cxl_region *cxl_create_pmem_region(struct cxl_root_decoder *cxlrd,
+		struct cxl_decoder *cxld,
+		struct cxl_pmem_region_params *params, int id)
+{
+	int rc;
+
+	rc = memregion_alloc(GFP_KERNEL);
+	if (rc < 0)
+		return ERR_PTR(rc);
+
+	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
+		memregion_free(rc);
+		return ERR_PTR(-EBUSY);
+	}
+
+	return devm_cxl_pmem_add_region(cxlrd, cxld, params, id,
+			CXL_DECODER_PMEM, CXL_DECODER_HOSTONLYMEM);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_pmem_region, "CXL");
+
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 					  enum cxl_decoder_mode mode, int id)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9423ea3509ad..30c80e04cb27 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -759,6 +759,7 @@ DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
+void cxl_wq_flush(void);
 struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 				   struct cxl_dport **dport);
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
@@ -877,6 +878,9 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_port *root,
 		      struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
+struct cxl_region *cxl_create_pmem_region(struct cxl_root_decoder *cxlrd,
+		struct cxl_decoder *cxld,
+		struct cxl_pmem_region_params *params, int id);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -895,6 +899,13 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 {
 	return NULL;
 }
+static inline struct cxl_region *cxl_create_pmem_region(
+		struct cxl_root_decoder *cxlrd,
+		struct cxl_decoder *cxld,
+		struct cxl_pmem_region_params *params, int id)
+{
+	return NULL;
+}
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
-- 
2.34.1



