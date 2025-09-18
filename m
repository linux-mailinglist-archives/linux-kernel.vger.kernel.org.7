Return-Path: <linux-kernel+bounces-771919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E714B28CE2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9ADB04FE5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E279298CDA;
	Sat, 16 Aug 2025 10:28:44 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB2291C2D;
	Sat, 16 Aug 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755340123; cv=none; b=IULZpWRATuH29Qcp8k4XYebkmhY2D9RGeYcP7gZRE92F43vGYg9q8uk2stv/9wqE94bqryKlSBKHzeQJd8cQXTdQJe9Aywq/6LEQz4Y2TLI3bkd5qUGglN6QiDI4kezPCvgThdQcG8CQ/KBehwBtAOfCbiWjTCD6M+2L8zzxjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755340123; c=relaxed/simple;
	bh=1ATT0x7wW4/tRbhjzxR/5NfvE7Ees3+a5k9rw9gXpAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBq6ScsX+BbB6CFWYWoXp5vOzdPmF9gES8lkPzB0SeqXVI2ooXhXz+QmhO6Z8ds9TvQ2xIeBtmUXBQZJmsYqvshB6cGSQ3amu/6uV9Lz0RCAbvC2ymHqhiYdXD7r/LriKXIQZp+m3j78P/CKgbD51XftVZp0OPBmbpgae1OT5bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c3w9Y1d24z2VRG4;
	Sat, 16 Aug 2025 18:25:53 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 46CF518005F;
	Sat, 16 Aug 2025 18:28:37 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 16 Aug 2025 18:28:37 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 16 Aug 2025 18:28:36 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<liulongfang@huawei.com>, <shenyang39@huawei.com>, <qianweili@huawei.com>,
	<linwenkai6@hisilicon.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH 3/6] crypto: hisilicon - check the sva module status while enabling or disabling address prefetch
Date: Sat, 16 Aug 2025 18:28:31 +0800
Message-ID: <20250816102834.828655-4-huangchenghai2@huawei.com>
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

From: Weili Qian <qianweili@huawei.com>

After enabling address prefetch, check the sva module status. If all
previous prefetch requests from the sva module are not completed, then
disable the address prefetch to ensure normal execution of new task
operations. After disabling address prefetch, check if all requests
from the sva module have been completed.

Fixes: a5c164b195a8 ("crypto: hisilicon/qm - support address prefetching")
Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 43 +++++++++++-
 drivers/crypto/hisilicon/sec2/sec_main.c  | 48 +++++++++++++-
 drivers/crypto/hisilicon/zip/zip_main.c   | 79 +++++++++++++++++++----
 3 files changed, 154 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index dbe8f62f556b..e91d03e767da 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -78,6 +78,11 @@
 #define HPRE_PREFETCH_ENABLE		(~(BIT(0) | BIT(30)))
 #define HPRE_PREFETCH_DISABLE		BIT(30)
 #define HPRE_SVA_DISABLE_READY		(BIT(4) | BIT(8))
+#define HPRE_SVA_PREFTCH_DFX4		0x301144
+#define HPRE_WAIT_SVA_READY		500000
+#define HPRE_READ_SVA_STATUS_TIMES	3
+#define HPRE_WAIT_US_MIN		10
+#define HPRE_WAIT_US_MAX		20
 
 /* clock gate */
 #define HPRE_CLKGATE_CTL		0x301a10
@@ -466,6 +471,33 @@ struct hisi_qp *hpre_create_qp(u8 type)
 	return NULL;
 }
 
+static int hpre_wait_sva_ready(struct hisi_qm *qm)
+{
+	u32 val, try_times = 0;
+	u8 count = 0;
+
+	/*
+	 * Read the register value every 10-20us. If the value is 0 for three
+	 * consecutive times, the SVA module is ready.
+	 */
+	do {
+		val = readl(qm->io_base + HPRE_SVA_PREFTCH_DFX4);
+		if (val)
+			count = 0;
+		else if (++count == HPRE_READ_SVA_STATUS_TIMES)
+			break;
+
+		usleep_range(HPRE_WAIT_US_MIN, HPRE_WAIT_US_MAX);
+	} while (++try_times < HPRE_WAIT_SVA_READY);
+
+	if (try_times == HPRE_WAIT_SVA_READY) {
+		pci_err(qm->pdev, "failed to wait sva prefetch ready\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static void hpre_close_sva_prefetch(struct hisi_qm *qm)
 {
 	u32 val;
@@ -484,6 +516,8 @@ static void hpre_close_sva_prefetch(struct hisi_qm *qm)
 					 HPRE_REG_RD_TMOUT_US);
 	if (ret)
 		pci_err(qm->pdev, "failed to close sva prefetch\n");
+
+	(void)hpre_wait_sva_ready(qm);
 }
 
 static void hpre_open_sva_prefetch(struct hisi_qm *qm)
@@ -503,8 +537,15 @@ static void hpre_open_sva_prefetch(struct hisi_qm *qm)
 					 val, !(val & HPRE_PREFETCH_DISABLE),
 					 HPRE_REG_RD_INTVRL_US,
 					 HPRE_REG_RD_TMOUT_US);
-	if (ret)
+	if (ret) {
 		pci_err(qm->pdev, "failed to open sva prefetch\n");
+		hpre_close_sva_prefetch(qm);
+		return;
+	}
+
+	ret = hpre_wait_sva_ready(qm);
+	if (ret)
+		hpre_close_sva_prefetch(qm);
 }
 
 static void hpre_config_pasid(struct hisi_qm *qm)
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index ddb20f380b54..348f1f52956d 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -93,6 +93,16 @@
 #define SEC_PREFETCH_ENABLE		(~(BIT(0) | BIT(1) | BIT(11)))
 #define SEC_PREFETCH_DISABLE		BIT(1)
 #define SEC_SVA_DISABLE_READY		(BIT(7) | BIT(11))
+#define SEC_SVA_PREFETCH_INFO		0x301ED4
+#define SEC_SVA_STALL_NUM		GENMASK(23, 8)
+#define SEC_SVA_PREFETCH_NUM		GENMASK(2, 0)
+#define SEC_WAIT_SVA_READY		500000
+#define SEC_READ_SVA_STATUS_TIMES	3
+#define SEC_WAIT_US_MIN			10
+#define SEC_WAIT_US_MAX			20
+#define SEC_WAIT_QP_US_MIN		1000
+#define SEC_WAIT_QP_US_MAX		2000
+#define SEC_MAX_WAIT_TIMES		2000
 
 #define SEC_DELAY_10_US			10
 #define SEC_POLL_TIMEOUT_US		1000
@@ -464,6 +474,33 @@ static void sec_set_endian(struct hisi_qm *qm)
 	writel_relaxed(reg, qm->io_base + SEC_CONTROL_REG);
 }
 
+static int sec_wait_sva_ready(struct hisi_qm *qm, __u32 offset, __u32 mask)
+{
+	u32 val, try_times = 0;
+	u8 count = 0;
+
+	/*
+	 * Read the register value every 10-20us. If the value is 0 for three
+	 * consecutive times, the SVA module is ready.
+	 */
+	do {
+		val = readl(qm->io_base + offset);
+		if (val & mask)
+			count = 0;
+		else if (++count == SEC_READ_SVA_STATUS_TIMES)
+			break;
+
+		usleep_range(SEC_WAIT_US_MIN, SEC_WAIT_US_MAX);
+	} while (++try_times < SEC_WAIT_SVA_READY);
+
+	if (try_times == SEC_WAIT_SVA_READY) {
+		pci_err(qm->pdev, "failed to wait sva prefetch ready\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static void sec_close_sva_prefetch(struct hisi_qm *qm)
 {
 	u32 val;
@@ -481,6 +518,8 @@ static void sec_close_sva_prefetch(struct hisi_qm *qm)
 					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
 	if (ret)
 		pci_err(qm->pdev, "failed to close sva prefetch\n");
+
+	(void)sec_wait_sva_ready(qm, SEC_SVA_PREFETCH_INFO, SEC_SVA_STALL_NUM);
 }
 
 static void sec_open_sva_prefetch(struct hisi_qm *qm)
@@ -499,8 +538,15 @@ static void sec_open_sva_prefetch(struct hisi_qm *qm)
 	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_PREFETCH_CFG,
 					 val, !(val & SEC_PREFETCH_DISABLE),
 					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
-	if (ret)
+	if (ret) {
 		pci_err(qm->pdev, "failed to open sva prefetch\n");
+		sec_close_sva_prefetch(qm);
+		return;
+	}
+
+	ret = sec_wait_sva_ready(qm, SEC_SVA_TRANS, SEC_SVA_PREFETCH_NUM);
+	if (ret)
+		sec_close_sva_prefetch(qm);
 }
 
 static void sec_engine_sva_config(struct hisi_qm *qm)
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 744f5a0197c3..7d55cd08cd1e 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -95,10 +95,16 @@
 #define HZIP_PREFETCH_ENABLE		(~(BIT(26) | BIT(17) | BIT(0)))
 #define HZIP_SVA_PREFETCH_DISABLE	BIT(26)
 #define HZIP_SVA_DISABLE_READY		(BIT(26) | BIT(30))
+#define HZIP_SVA_PREFETCH_NUM		GENMASK(18, 16)
+#define HZIP_SVA_STALL_NUM		GENMASK(15, 0)
 #define HZIP_SHAPER_RATE_COMPRESS	750
 #define HZIP_SHAPER_RATE_DECOMPRESS	140
-#define HZIP_DELAY_1_US		1
-#define HZIP_POLL_TIMEOUT_US	1000
+#define HZIP_DELAY_1_US			1
+#define HZIP_POLL_TIMEOUT_US		1000
+#define HZIP_WAIT_SVA_READY		500000
+#define HZIP_READ_SVA_STATUS_TIMES	3
+#define HZIP_WAIT_US_MIN		10
+#define HZIP_WAIT_US_MAX		20
 
 /* clock gating */
 #define HZIP_PEH_CFG_AUTO_GATE		0x3011A8
@@ -462,7 +468,34 @@ static void hisi_zip_set_high_perf(struct hisi_qm *qm)
 	writel(val, qm->io_base + HZIP_HIGH_PERF_OFFSET);
 }
 
-static void hisi_zip_open_sva_prefetch(struct hisi_qm *qm)
+static int hisi_zip_wait_sva_ready(struct hisi_qm *qm, __u32 offset, __u32 mask)
+{
+	u32 val, try_times = 0;
+	u8 count = 0;
+
+	/*
+	 * Read the register value every 10-20us. If the value is 0 for three
+	 * consecutive times, the SVA module is ready.
+	 */
+	do {
+		val = readl(qm->io_base + offset);
+		if (val & mask)
+			count = 0;
+		else if (++count == HZIP_READ_SVA_STATUS_TIMES)
+			break;
+
+		usleep_range(HZIP_WAIT_US_MIN, HZIP_WAIT_US_MAX);
+	} while (++try_times < HZIP_WAIT_SVA_READY);
+
+	if (try_times == HZIP_WAIT_SVA_READY) {
+		pci_err(qm->pdev, "failed to wait sva prefetch ready\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void hisi_zip_close_sva_prefetch(struct hisi_qm *qm)
 {
 	u32 val;
 	int ret;
@@ -470,19 +503,20 @@ static void hisi_zip_open_sva_prefetch(struct hisi_qm *qm)
 	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
 		return;
 
-	/* Enable prefetch */
 	val = readl_relaxed(qm->io_base + HZIP_PREFETCH_CFG);
-	val &= HZIP_PREFETCH_ENABLE;
+	val |= HZIP_SVA_PREFETCH_DISABLE;
 	writel(val, qm->io_base + HZIP_PREFETCH_CFG);
 
-	ret = readl_relaxed_poll_timeout(qm->io_base + HZIP_PREFETCH_CFG,
-					 val, !(val & HZIP_SVA_PREFETCH_DISABLE),
+	ret = readl_relaxed_poll_timeout(qm->io_base + HZIP_SVA_TRANS,
+					 val, !(val & HZIP_SVA_DISABLE_READY),
 					 HZIP_DELAY_1_US, HZIP_POLL_TIMEOUT_US);
 	if (ret)
-		pci_err(qm->pdev, "failed to open sva prefetch\n");
+		pci_err(qm->pdev, "failed to close sva prefetch\n");
+
+	(void)hisi_zip_wait_sva_ready(qm, HZIP_SVA_TRANS, HZIP_SVA_STALL_NUM);
 }
 
-static void hisi_zip_close_sva_prefetch(struct hisi_qm *qm)
+static void hisi_zip_open_sva_prefetch(struct hisi_qm *qm)
 {
 	u32 val;
 	int ret;
@@ -490,15 +524,23 @@ static void hisi_zip_close_sva_prefetch(struct hisi_qm *qm)
 	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
 		return;
 
+	/* Enable prefetch */
 	val = readl_relaxed(qm->io_base + HZIP_PREFETCH_CFG);
-	val |= HZIP_SVA_PREFETCH_DISABLE;
+	val &= HZIP_PREFETCH_ENABLE;
 	writel(val, qm->io_base + HZIP_PREFETCH_CFG);
 
-	ret = readl_relaxed_poll_timeout(qm->io_base + HZIP_SVA_TRANS,
-					 val, !(val & HZIP_SVA_DISABLE_READY),
+	ret = readl_relaxed_poll_timeout(qm->io_base + HZIP_PREFETCH_CFG,
+					 val, !(val & HZIP_SVA_PREFETCH_DISABLE),
 					 HZIP_DELAY_1_US, HZIP_POLL_TIMEOUT_US);
+	if (ret) {
+		pci_err(qm->pdev, "failed to open sva prefetch\n");
+		hisi_zip_close_sva_prefetch(qm);
+		return;
+	}
+
+	ret = hisi_zip_wait_sva_ready(qm, HZIP_SVA_TRANS, HZIP_SVA_PREFETCH_NUM);
 	if (ret)
-		pci_err(qm->pdev, "failed to close sva prefetch\n");
+		hisi_zip_close_sva_prefetch(qm);
 }
 
 static void hisi_zip_enable_clock_gate(struct hisi_qm *qm)
@@ -522,6 +564,7 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 	void __iomem *base = qm->io_base;
 	u32 dcomp_bm, comp_bm;
 	u32 zip_core_en;
+	int ret;
 
 	/* qm user domain */
 	writel(AXUSER_BASE, base + QM_ARUSER_M_CFG_1);
@@ -577,7 +620,15 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 
 	hisi_zip_enable_clock_gate(qm);
 
-	return hisi_dae_set_user_domain(qm);
+	ret = hisi_dae_set_user_domain(qm);
+	if (ret)
+		goto close_sva_prefetch;
+
+	return 0;
+
+close_sva_prefetch:
+	hisi_zip_close_sva_prefetch(qm);
+	return ret;
 }
 
 static void hisi_zip_master_ooo_ctrl(struct hisi_qm *qm, bool enable)
-- 
2.33.0


