Return-Path: <linux-kernel+bounces-820880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E175B7F8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C935850D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C9F33B47F;
	Wed, 17 Sep 2025 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eCPREgEG"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674F33B47C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116527; cv=none; b=Y79JA52VLtLQ9O+JEaNnzcHtvv+C0q9A82BnUf7gjHF0II+YVY7bTtepr154UyZ5u44EPOQKfcOpTSA2qYzcHHzpvY31hF3SjyJRI2iolXfce9xK59weUfLvI5RApxzVELlAtGkhmJHOq6DPQQjShEygZWp/QYOsYBXWiJEa55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116527; c=relaxed/simple;
	bh=QxgrxiYPyfgIgdcckKir9l5MmECb0kuUk85QadtiF30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=DYlBJQtFBfz7cTkO3xo3+qZ5MLIHZIDRfDYska+we7WtbyJTu0Cvm92Xf7t3qMW0bcwU1PBAMCZY0u8DtyxXKTrRS2eNXCo3uYk2rHI0aN1vcXlHeiH5VwBO6q5DT4gZ/Y38DpD9485/aEEdW6j+njVtIbGz7tCRUSTOK3EM65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eCPREgEG; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250917134204epoutp049daea3829788c6d76ccc2366aa05f9ec~mFan-LRnI0545805458epoutp04R
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:42:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250917134204epoutp049daea3829788c6d76ccc2366aa05f9ec~mFan-LRnI0545805458epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758116524;
	bh=J/7DkBNdXlSoe7d+7pBkn1ckZK936GrNoSihihPioVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCPREgEG9MNIE5S6U3YSJ1PEZhVOKU7Ifv+2OosPMbBv1KSGK3WK4IHzDky/7wzyr
	 m9VvNMMBEuBRjEiYA4k+oXVHRKxd2kgTL9HKQZFlgzTLn3KLPXqUqLdsB0dhtFrYqf
	 OkJEGwWA4zde/TbtMx4KjwSNLTk4ax1yksT7QH9Y=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250917134204epcas5p2f4e766e991133c0decc2c8cea61fefab~mFanpbwR61141811418epcas5p2k;
	Wed, 17 Sep 2025 13:42:04 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cRg170hM8z3hhT4; Wed, 17 Sep
	2025 13:42:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250917134202epcas5p23f718742c74c5b519ecbbc1e04840c03~mFamD8tYo0912409124epcas5p2i;
	Wed, 17 Sep 2025 13:42:02 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250917134200epsmtip268b889eb80e785df75d3437e164a087e~mFakFR9C60862908629epsmtip2P;
	Wed, 17 Sep 2025 13:42:00 +0000 (GMT)
From: Neeraj Kumar <s.neeraj@samsung.com>
To: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com
Cc: a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com, Neeraj Kumar <s.neeraj@samsung.com>
Subject: [PATCH V3 15/20] cxl: Add a routine to find cxl root decoder on cxl
 bus using cxl port
Date: Wed, 17 Sep 2025 19:11:11 +0530
Message-Id: <20250917134116.1623730-16-s.neeraj@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917134116.1623730-1-s.neeraj@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917134202epcas5p23f718742c74c5b519ecbbc1e04840c03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917134202epcas5p23f718742c74c5b519ecbbc1e04840c03
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
	<CGME20250917134202epcas5p23f718742c74c5b519ecbbc1e04840c03@epcas5p2.samsung.com>

Add cxl_find_root_decoder_by_port() to find root decoder on cxl bus.
It is used to find root decoder using cxl port.

Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
---
 drivers/cxl/core/port.c | 27 +++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8f36ff413f5d..647d9ce32b64 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -518,6 +518,33 @@ struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_switch_decoder, "CXL");
 
+static int match_root_decoder(struct device *dev, const void *data)
+{
+	return is_root_decoder(dev);
+}
+
+/**
+ * cxl_find_root_decoder_by_port() - find a cxl root decoder on cxl bus
+ * @port: any descendant port in CXL port topology
+ */
+struct cxl_root_decoder *cxl_find_root_decoder_by_port(struct cxl_port *port)
+{
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+	struct device *dev;
+
+	if (!cxl_root)
+		return NULL;
+
+	dev = device_find_child(&cxl_root->port.dev, NULL, match_root_decoder);
+	if (!dev)
+		return NULL;
+
+	/* Release device ref taken via device_find_child() */
+	put_device(dev);
+	return to_cxl_root_decoder(dev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_find_root_decoder_by_port, "CXL");
+
 static void cxl_ep_release(struct cxl_ep *ep)
 {
 	put_device(ep->ep);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3abadc3dc82e..1eb1aca7c69f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -866,6 +866,7 @@ struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm(struct device *dev);
 int devm_cxl_add_nvdimm(struct cxl_port *parent_port, struct cxl_memdev *cxlmd);
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
+struct cxl_root_decoder *cxl_find_root_decoder_by_port(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
-- 
2.34.1


