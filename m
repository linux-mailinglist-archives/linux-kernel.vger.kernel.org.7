Return-Path: <linux-kernel+bounces-834917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51583BA5D44
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A472A28AD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06F62D8DA6;
	Sat, 27 Sep 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CrWO8Eor"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E725B2417E6;
	Sat, 27 Sep 2025 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758967708; cv=pass; b=dp0yg8ZK/DFc2bXQCUYUmcEsIPmRkm5RieEPgN9/fLp+59mGxEnLNMsjEoIYm7KP7DIt1syJE3zxFMFuyS9+HKmR9Gxpr/uzivst18swbpKp8BYtbnSHSvIRLUWKhlCsSrtila8RxsMRD4njo+Q5oK1NLjdAnLgfYodU+1tKrAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758967708; c=relaxed/simple;
	bh=kzPyvFQVOR/sEG8zq3P/u1hIdN2weJ3fwoYutthekLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UGe/2mo8d25l6UWZe5U3Nu5z6tmhMh9/cCCq3EBtDUPiOBBeAWv+dfxvxV03Mip9LizEbiqjLwBU2KCu1V8r61N80MtL5irxHBK2brIJ5uMzT5M698a7x122Tp927NeglZ32uNIB2XcVW0Zdf/ShdqnHVnpeymKdxBlBSKFcQmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CrWO8Eor; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1758967688; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EvGUmOQOnn66XNu4iQHDegIrnfPZOGwR8jHMfBKYArSG5BzFwhpFveTQ0Oya1QBCLUoDamt+NLTT0Gfant+Z25u+oKdMbMIkEmDjd9fpiJt8FSw/9+UOhnPnVv1DcWNe0lX0PxV3NqS4y6VwbTD0lT19h3aqrpzAFQZb5QlOWRg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758967688; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N7MPDYnwLs60xdJwy83QkaCYwGvfqrTmZM1T4hOllyk=; 
	b=iqvNDH/EU+wioxRvjAEUg/IRoe0+hpRAEPbLN3LHzWz+BEVWpwaXPoVJjwasho88t7cQt3/q98WdCRflET0sxcymNm4KQsRkBJtco8kwsrG3YmV+VMkRfoooOWciFvEqxH6+CrGWQC/AWM9ldDDioXnK7DIuKd7GAlGCBXY3ums=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758967688;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=N7MPDYnwLs60xdJwy83QkaCYwGvfqrTmZM1T4hOllyk=;
	b=CrWO8EorGL1cCYZGntjh+W1DZSdttUXmVrS65YFdD2YY2rtlNjsWvOwHeCLA/lIc
	GJTBXpx6Gw9nLk04Jg2cF2pnzc2ThVUGQkDPvCRmRZsigFHv/Ni1ca4obH4Nab3Iuak
	qw94czCokFxOsbm2ZBpVELI+SFfOtDYIYrTgbXmE=
Received: by mx.zohomail.com with SMTPS id 1758967686557981.6240117112845;
	Sat, 27 Sep 2025 03:08:06 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 1/1] cxl/port: Remove devm_cxl_port_enumerate_dports()
Date: Sat, 27 Sep 2025 18:07:09 +0800
Message-Id: <20250927100709.146507-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227a89b6348775ddca7e9d219170000b918d8ae3fe4a9f66be5bd2811329ec43e45c2fe9e681bbac1:zu08011227697cb977fa82f30c10e424250000bfd0fcc0df7a1eb2ccd13f6a0b9cc5900d004d722d83861ec5:rf0801122d259923f53310740e8b7ffbca000036567df504dccb85927602ead79f85170000ebae3934819914ff43bdbaf05b:ZohoMail
X-ZohoMailClient: External

devm_cxl_port_enumerate_dports() is not longer used after below commit
commit 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")

Delete it and the relevant interface implemented in cxl_test.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
base-commit: 46037455cbb748c5e85071c95f2244e81986eb58 cxl/next
---
 drivers/cxl/core/pci.c        | 87 ++++-------------------------------
 drivers/cxl/cxlpci.h          |  1 -
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/cxl.c  | 32 -------------
 tools/testing/cxl/test/mock.c | 15 ------
 tools/testing/cxl/test/mock.h |  1 -
 6 files changed, 8 insertions(+), 129 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 18825e1505d6..5b023a0178a4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -71,85 +71,6 @@ struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_dport_by_dev, "CXL");
 
-struct cxl_walk_context {
-	struct pci_bus *bus;
-	struct cxl_port *port;
-	int type;
-	int error;
-	int count;
-};
-
-static int match_add_dports(struct pci_dev *pdev, void *data)
-{
-	struct cxl_walk_context *ctx = data;
-	struct cxl_port *port = ctx->port;
-	int type = pci_pcie_type(pdev);
-	struct cxl_register_map map;
-	struct cxl_dport *dport;
-	u32 lnkcap, port_num;
-	int rc;
-
-	if (pdev->bus != ctx->bus)
-		return 0;
-	if (!pci_is_pcie(pdev))
-		return 0;
-	if (type != ctx->type)
-		return 0;
-	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
-				  &lnkcap))
-		return 0;
-
-	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
-	if (rc)
-		dev_dbg(&port->dev, "failed to find component registers\n");
-
-	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
-	if (IS_ERR(dport)) {
-		ctx->error = PTR_ERR(dport);
-		return PTR_ERR(dport);
-	}
-	ctx->count++;
-
-	return 0;
-}
-
-/**
- * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
- * @port: cxl_port whose ->uport_dev is the upstream of dports to be enumerated
- *
- * Returns a positive number of dports enumerated or a negative error
- * code.
- */
-int devm_cxl_port_enumerate_dports(struct cxl_port *port)
-{
-	struct pci_bus *bus = cxl_port_to_pci_bus(port);
-	struct cxl_walk_context ctx;
-	int type;
-
-	if (!bus)
-		return -ENXIO;
-
-	if (pci_is_root_bus(bus))
-		type = PCI_EXP_TYPE_ROOT_PORT;
-	else
-		type = PCI_EXP_TYPE_DOWNSTREAM;
-
-	ctx = (struct cxl_walk_context) {
-		.port = port,
-		.bus = bus,
-		.type = type,
-	};
-	pci_walk_bus(bus, match_add_dports, &ctx);
-
-	if (ctx.count == 0)
-		return -ENODEV;
-	if (ctx.error)
-		return ctx.error;
-	return ctx.count;
-}
-EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, "CXL");
-
 static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
@@ -1217,6 +1138,14 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
 	return 0;
 }
 
+struct cxl_walk_context {
+	struct pci_bus *bus;
+	struct cxl_port *port;
+	int type;
+	int error;
+	int count;
+};
+
 static int count_dports(struct pci_dev *pdev, void *data)
 {
 	struct cxl_walk_context *ctx = data;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 7ae621e618e7..1d526bea8431 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -127,7 +127,6 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
 }
 
-int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 0d5ce4b74b9f..3dae06ac7fba 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -4,7 +4,6 @@ ldflags-y += --wrap=is_acpi_device_node
 ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
-ldflags-y += --wrap=devm_cxl_port_enumerate_dports
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=devm_cxl_add_rch_dport
 ldflags-y += --wrap=cxl_rcd_component_reg_phys
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 2d135ca533d0..10f9b83a9443 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -995,37 +995,6 @@ static int get_port_array(struct cxl_port *port,
 	return 0;
 }
 
-static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
-{
-	struct platform_device **array;
-	int i, array_size;
-	int rc;
-
-	rc = get_port_array(port, &array, &array_size);
-	if (rc)
-		return rc;
-
-	for (i = 0; i < array_size; i++) {
-		struct platform_device *pdev = array[i];
-		struct cxl_dport *dport;
-
-		if (pdev->dev.parent != port->uport_dev) {
-			dev_dbg(&port->dev, "%s: mismatch parent %s\n",
-				dev_name(port->uport_dev),
-				dev_name(pdev->dev.parent));
-			continue;
-		}
-
-		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
-					   CXL_RESOURCE_NONE);
-
-		if (IS_ERR(dport))
-			return PTR_ERR(dport);
-	}
-
-	return 0;
-}
-
 static struct cxl_dport *mock_cxl_add_dport_by_dev(struct cxl_port *port,
 						   struct device *dport_dev)
 {
@@ -1114,7 +1083,6 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
 	.devm_cxl_switch_port_decoders_setup = mock_cxl_switch_port_decoders_setup,
 	.devm_cxl_endpoint_decoders_setup = mock_cxl_endpoint_decoders_setup,
-	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
 	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
 	.devm_cxl_add_dport_by_dev = mock_cxl_add_dport_by_dev,
 	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 995269a75cbd..6fd4edb9215c 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -172,21 +172,6 @@ int __wrap_devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_endpoint_decoders_setup, "CXL");
 
-int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
-{
-	int rc, index;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_port(port->uport_dev))
-		rc = ops->devm_cxl_port_enumerate_dports(port);
-	else
-		rc = devm_cxl_port_enumerate_dports(port);
-	put_cxl_mock_ops(index);
-
-	return rc;
-}
-EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_port_enumerate_dports, "CXL");
-
 int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 {
 	int rc, index;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 4ed932e76aae..580f38386224 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -19,7 +19,6 @@ struct cxl_mock_ops {
 	bool (*is_mock_bus)(struct pci_bus *bus);
 	bool (*is_mock_port)(struct device *dev);
 	bool (*is_mock_dev)(struct device *dev);
-	int (*devm_cxl_port_enumerate_dports)(struct cxl_port *port);
 	int (*devm_cxl_switch_port_decoders_setup)(struct cxl_port *port);
 	int (*devm_cxl_endpoint_decoders_setup)(struct cxl_port *port);
 	void (*cxl_endpoint_parse_cdat)(struct cxl_port *port);
-- 
2.34.1


