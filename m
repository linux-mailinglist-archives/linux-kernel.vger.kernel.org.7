Return-Path: <linux-kernel+bounces-778772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991B0B2EACA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14C57AE617
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878A25487C;
	Thu, 21 Aug 2025 01:38:18 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B90242D62;
	Thu, 21 Aug 2025 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740297; cv=none; b=UaEhMSiTVKFMZj7z2rFoq7otsBLvc58LQ//Tua7qCzGGwkxTEPBVKEgVmetysOnOLfdpFCZPyD1IBlkAC+QTOvD6OWtp2WyLNZYFTbRIH/cZuO7ctcP0W6ZaQZAW0T0V8OqjjyGSCRRVl29NBrl92VY7Qvt0i0iaVnwW7CJuM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740297; c=relaxed/simple;
	bh=xf8WH8RCUDuZrcaSE24CIkhh+Cz+7tz+HvYj0wY3rmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CygOtObTXfp0kDu1kRKQlOvEn4V0hEQu+qHqDz1sP5IrttspfFLd24Hd7gxpMR13YjSTi74Vr9PHsxuQnWsLnlGazafbQdIeblj6neLX8nNH2KqsngXDf8pHcyU2LXSzRpFxnOFrmUkx1THxBOvOcfh4p38ziwbZHuZCmYNpthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c6m964dx6z2TTH7;
	Thu, 21 Aug 2025 09:35:22 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BF331A016C;
	Thu, 21 Aug 2025 09:38:12 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 09:38:12 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 09:38:11 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linuxarm@openeuler.org>, <liulongfang@huawei.com>, <qianweili@huawei.com>,
	<linwenkai6@hisilicon.com>, <wangzhou1@hisilicon.com>,
	<yinzhushuai@huawei.com>
Subject: [PATCH v2 5/6] crypto: hisilicon/qm - request reserved interrupt for virtual function
Date: Thu, 21 Aug 2025 09:38:08 +0800
Message-ID: <20250821013809.4016506-6-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250821013809.4016506-1-huangchenghai2@huawei.com>
References: <20250821013809.4016506-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200001.china.huawei.com (7.202.195.16)

From: Weili Qian <qianweili@huawei.com>

The device interrupt vector 3 is an error interrupt for
physical function and a reserved interrupt for virtual function.
However, the driver has not registered the reserved interrupt for
virtual function. When allocating interrupts, the number of interrupts
is allocated based on powers of two, which includes this interrupt.
When the system enables GICv4 and the virtual function passthrough
to the virtual machine, releasing the interrupt in the driver
triggers a warning.

The WARNING report is:
WARNING: CPU: 62 PID: 14889 at arch/arm64/kvm/vgic/vgic-its.c:852 its_free_ite+0x94/0xb4

Therefore, register a reserved interrupt for VF and set the
IRQF_NO_AUTOEN flag to avoid that warning.

Fixes: 3536cc55cada ("crypto: hisilicon/qm - support get device irq information from hardware registers")
Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 38 +++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 408e201a7af2..3a12d291c086 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4732,6 +4732,15 @@ void hisi_qm_reset_done(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(hisi_qm_reset_done);
 
+static irqreturn_t qm_rsvd_irq(int irq, void *data)
+{
+	struct hisi_qm *qm = data;
+
+	dev_info(&qm->pdev->dev, "Reserved interrupt, ignore!\n");
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t qm_abnormal_irq(int irq, void *data)
 {
 	struct hisi_qm *qm = data;
@@ -5015,7 +5024,7 @@ static void qm_unregister_abnormal_irq(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	u32 irq_vector, val;
 
-	if (qm->fun_type == QM_HW_VF)
+	if (qm->fun_type == QM_HW_VF && qm->ver < QM_HW_V3)
 		return;
 
 	val = qm->cap_tables.qm_cap_table[QM_ABNORMAL_IRQ].cap_val;
@@ -5032,17 +5041,28 @@ static int qm_register_abnormal_irq(struct hisi_qm *qm)
 	u32 irq_vector, val;
 	int ret;
 
-	if (qm->fun_type == QM_HW_VF)
-		return 0;
-
 	val = qm->cap_tables.qm_cap_table[QM_ABNORMAL_IRQ].cap_val;
 	if (!((val >> QM_IRQ_TYPE_SHIFT) & QM_ABN_IRQ_TYPE_MASK))
 		return 0;
-
 	irq_vector = val & QM_IRQ_VECTOR_MASK;
+
+	/* For VF, this is a reserved interrupt in V3 version. */
+	if (qm->fun_type == QM_HW_VF) {
+		if (qm->ver < QM_HW_V3)
+			return 0;
+
+		ret = request_irq(pci_irq_vector(pdev, irq_vector), qm_rsvd_irq,
+				  IRQF_NO_AUTOEN, qm->dev_name, qm);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request reserved irq, ret = %d!\n", ret);
+			return ret;
+		}
+		return 0;
+	}
+
 	ret = request_irq(pci_irq_vector(pdev, irq_vector), qm_abnormal_irq, 0, qm->dev_name, qm);
 	if (ret)
-		dev_err(&qm->pdev->dev, "failed to request abnormal irq, ret = %d", ret);
+		dev_err(&qm->pdev->dev, "failed to request abnormal irq, ret = %d!\n", ret);
 
 	return ret;
 }
@@ -5408,6 +5428,12 @@ static int hisi_qm_pci_init(struct hisi_qm *qm)
 	pci_set_master(pdev);
 
 	num_vec = qm_get_irq_num(qm);
+	if (!num_vec) {
+		dev_err(dev, "Device irq num is zero!\n");
+		ret = -EINVAL;
+		goto err_get_pci_res;
+	}
+	num_vec = roundup_pow_of_two(num_vec);
 	ret = pci_alloc_irq_vectors(pdev, num_vec, num_vec, PCI_IRQ_MSI);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable MSI vectors!\n");
-- 
2.33.0


