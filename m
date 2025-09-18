Return-Path: <linux-kernel+bounces-771920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477C3B28CE4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EF6B04CDC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5071929AAF0;
	Sat, 16 Aug 2025 10:28:47 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA5299A83;
	Sat, 16 Aug 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755340126; cv=none; b=ag0R19NCYUi/9frJAFNnmM2rIVzgeCwhBnbncEUnRSolj2byhOitwjvxXa7WpBWQbuFDpLEOexgH6pHXj+gDdfgqDw8BvLuZ4ING0Wtj/wg2B0htvZD1et/1HprWWtcYU6SdU0OOg/ztHdxw7r64tp1PuRV1zjhQiM8D3b9lK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755340126; c=relaxed/simple;
	bh=jxcxCv+UtSpKj1BcxQWYKJ6rQt9/PuHHt0gIdTKocwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZYIhYSlAsQYdDYAUeCUX6vYfF6GnxCZ61qeWA9Zv1oCAzE3ZeC3USQHhAJvUtiONp9jmzNAny11kgGNarxwzo1jWrIacmdo2ifAd2IZ5SEIXM0aQgw1F+OUu1oFyTsZB75AJRa4RGWnPRHBWlfvkn8rtAAPPobL7fnQTmD+aJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c3w9X5x1Pz2Dc0v;
	Sat, 16 Aug 2025 18:25:52 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B37A1A0188;
	Sat, 16 Aug 2025 18:28:36 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 16 Aug 2025 18:28:36 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 16 Aug 2025 18:28:35 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<liulongfang@huawei.com>, <shenyang39@huawei.com>, <qianweili@huawei.com>,
	<linwenkai6@hisilicon.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH 1/6] crypto: hisilicon - re-enable address prefetch after device resuming
Date: Sat, 16 Aug 2025 18:28:29 +0800
Message-ID: <20250816102834.828655-2-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250816102834.828655-1-huangchenghai2@huawei.com>
References: <20250816102834.828655-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200001.china.huawei.com (7.202.195.16)

When the device resumes from a suspended state, it will revert to its
initial state and requires re-enabling. Currently, the address prefetch
function is not re-enabled after device resuming. Move the address prefetch
enable to the initialization process. In this way, the address prefetch
can be enabled when the device resumes by calling the initialization
process.

Fixes: 607c191b371d ("crypto: hisilicon - support runtime PM for accelerator device")
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 86 +++++++++++------------
 drivers/crypto/hisilicon/qm.c             |  3 -
 drivers/crypto/hisilicon/sec2/sec_main.c  | 80 ++++++++++-----------
 drivers/crypto/hisilicon/zip/zip_main.c   |  2 +-
 4 files changed, 84 insertions(+), 87 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index f5b47e5ff48a..dbe8f62f556b 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -466,6 +466,47 @@ struct hisi_qp *hpre_create_qp(u8 type)
 	return NULL;
 }
 
+static void hpre_close_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
+		return;
+
+	val = readl_relaxed(qm->io_base + HPRE_PREFETCH_CFG);
+	val |= HPRE_PREFETCH_DISABLE;
+	writel(val, qm->io_base + HPRE_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + HPRE_SVA_PREFTCH_DFX,
+					 val, !(val & HPRE_SVA_DISABLE_READY),
+					 HPRE_REG_RD_INTVRL_US,
+					 HPRE_REG_RD_TMOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to close sva prefetch\n");
+}
+
+static void hpre_open_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
+		return;
+
+	/* Enable prefetch */
+	val = readl_relaxed(qm->io_base + HPRE_PREFETCH_CFG);
+	val &= HPRE_PREFETCH_ENABLE;
+	writel(val, qm->io_base + HPRE_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + HPRE_PREFETCH_CFG,
+					 val, !(val & HPRE_PREFETCH_DISABLE),
+					 HPRE_REG_RD_INTVRL_US,
+					 HPRE_REG_RD_TMOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to open sva prefetch\n");
+}
+
 static void hpre_config_pasid(struct hisi_qm *qm)
 {
 	u32 val1, val2;
@@ -484,6 +525,8 @@ static void hpre_config_pasid(struct hisi_qm *qm)
 	}
 	writel_relaxed(val1, qm->io_base + HPRE_DATA_RUSER_CFG);
 	writel_relaxed(val2, qm->io_base + HPRE_DATA_WUSER_CFG);
+
+	hpre_open_sva_prefetch(qm);
 }
 
 static int hpre_cfg_by_dsm(struct hisi_qm *qm)
@@ -563,47 +606,6 @@ static void disable_flr_of_bme(struct hisi_qm *qm)
 	writel(PEH_AXUSER_CFG_ENABLE, qm->io_base + QM_PEH_AXUSER_CFG_ENABLE);
 }
 
-static void hpre_open_sva_prefetch(struct hisi_qm *qm)
-{
-	u32 val;
-	int ret;
-
-	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
-		return;
-
-	/* Enable prefetch */
-	val = readl_relaxed(qm->io_base + HPRE_PREFETCH_CFG);
-	val &= HPRE_PREFETCH_ENABLE;
-	writel(val, qm->io_base + HPRE_PREFETCH_CFG);
-
-	ret = readl_relaxed_poll_timeout(qm->io_base + HPRE_PREFETCH_CFG,
-					 val, !(val & HPRE_PREFETCH_DISABLE),
-					 HPRE_REG_RD_INTVRL_US,
-					 HPRE_REG_RD_TMOUT_US);
-	if (ret)
-		pci_err(qm->pdev, "failed to open sva prefetch\n");
-}
-
-static void hpre_close_sva_prefetch(struct hisi_qm *qm)
-{
-	u32 val;
-	int ret;
-
-	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
-		return;
-
-	val = readl_relaxed(qm->io_base + HPRE_PREFETCH_CFG);
-	val |= HPRE_PREFETCH_DISABLE;
-	writel(val, qm->io_base + HPRE_PREFETCH_CFG);
-
-	ret = readl_relaxed_poll_timeout(qm->io_base + HPRE_SVA_PREFTCH_DFX,
-					 val, !(val & HPRE_SVA_DISABLE_READY),
-					 HPRE_REG_RD_INTVRL_US,
-					 HPRE_REG_RD_TMOUT_US);
-	if (ret)
-		pci_err(qm->pdev, "failed to close sva prefetch\n");
-}
-
 static void hpre_enable_clock_gate(struct hisi_qm *qm)
 {
 	unsigned long offset;
@@ -1450,8 +1452,6 @@ static int hpre_pf_probe_init(struct hpre *hpre)
 	if (ret)
 		return ret;
 
-	hpre_open_sva_prefetch(qm);
-
 	hisi_qm_dev_err_init(qm);
 	ret = hpre_show_last_regs_init(qm);
 	if (ret)
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 2e4ee7ecfdfb..a5cc0ccd94f1 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4447,9 +4447,6 @@ static void qm_restart_prepare(struct hisi_qm *qm)
 {
 	u32 value;
 
-	if (qm->err_ini->open_sva_prefetch)
-		qm->err_ini->open_sva_prefetch(qm);
-
 	if (qm->ver >= QM_HW_V3)
 		return;
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 72cf48d1f3ab..ddb20f380b54 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -464,6 +464,45 @@ static void sec_set_endian(struct hisi_qm *qm)
 	writel_relaxed(reg, qm->io_base + SEC_CONTROL_REG);
 }
 
+static void sec_close_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
+		return;
+
+	val = readl_relaxed(qm->io_base + SEC_PREFETCH_CFG);
+	val |= SEC_PREFETCH_DISABLE;
+	writel(val, qm->io_base + SEC_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_SVA_TRANS,
+					 val, !(val & SEC_SVA_DISABLE_READY),
+					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to close sva prefetch\n");
+}
+
+static void sec_open_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
+		return;
+
+	/* Enable prefetch */
+	val = readl_relaxed(qm->io_base + SEC_PREFETCH_CFG);
+	val &= SEC_PREFETCH_ENABLE;
+	writel(val, qm->io_base + SEC_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_PREFETCH_CFG,
+					 val, !(val & SEC_PREFETCH_DISABLE),
+					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to open sva prefetch\n");
+}
+
 static void sec_engine_sva_config(struct hisi_qm *qm)
 {
 	u32 reg;
@@ -497,45 +536,7 @@ static void sec_engine_sva_config(struct hisi_qm *qm)
 		writel_relaxed(reg, qm->io_base +
 				SEC_INTERFACE_USER_CTRL1_REG);
 	}
-}
-
-static void sec_open_sva_prefetch(struct hisi_qm *qm)
-{
-	u32 val;
-	int ret;
-
-	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
-		return;
-
-	/* Enable prefetch */
-	val = readl_relaxed(qm->io_base + SEC_PREFETCH_CFG);
-	val &= SEC_PREFETCH_ENABLE;
-	writel(val, qm->io_base + SEC_PREFETCH_CFG);
-
-	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_PREFETCH_CFG,
-					 val, !(val & SEC_PREFETCH_DISABLE),
-					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
-	if (ret)
-		pci_err(qm->pdev, "failed to open sva prefetch\n");
-}
-
-static void sec_close_sva_prefetch(struct hisi_qm *qm)
-{
-	u32 val;
-	int ret;
-
-	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
-		return;
-
-	val = readl_relaxed(qm->io_base + SEC_PREFETCH_CFG);
-	val |= SEC_PREFETCH_DISABLE;
-	writel(val, qm->io_base + SEC_PREFETCH_CFG);
-
-	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_SVA_TRANS,
-					 val, !(val & SEC_SVA_DISABLE_READY),
-					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
-	if (ret)
-		pci_err(qm->pdev, "failed to close sva prefetch\n");
+	sec_open_sva_prefetch(qm);
 }
 
 static void sec_enable_clock_gate(struct hisi_qm *qm)
@@ -1152,7 +1153,6 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 	if (ret)
 		return ret;
 
-	sec_open_sva_prefetch(qm);
 	hisi_qm_dev_err_init(qm);
 	sec_debug_regs_clear(qm);
 	ret = sec_show_last_regs_init(qm);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index d8ba23b7cc7d..96687c78a8dc 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -565,6 +565,7 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 		writel(AXUSER_BASE, base + HZIP_DATA_WUSER_32_63);
 		writel(AXUSER_BASE, base + HZIP_SGL_RUSER_32_63);
 	}
+	hisi_zip_open_sva_prefetch(qm);
 
 	/* let's open all compression/decompression cores */
 
@@ -1255,7 +1256,6 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 	if (ret)
 		return ret;
 
-	hisi_zip_open_sva_prefetch(qm);
 	hisi_qm_dev_err_init(qm);
 	hisi_zip_debug_regs_clear(qm);
 
-- 
2.33.0


