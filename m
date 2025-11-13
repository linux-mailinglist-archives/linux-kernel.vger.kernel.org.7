Return-Path: <linux-kernel+bounces-899445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD862C57C86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A617344E81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0191FF7C7;
	Thu, 13 Nov 2025 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WNXl5/hu"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164721DDC0B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041397; cv=none; b=ayABlufAoKiJDWPAbY/Kbkp+G/RlRVFlcaqpB4SLeTWhIIw34h71fw90gkzxwT7etEc+waP4+IRy1q26dirKLMQ1UcdDFvUvT9htQ8XtrNqLRVyfFYWyeocoCYiEh+nvpILCDVvCQFbU6bZWknHYc/sI3fJKIt1mFqltu9i9pdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041397; c=relaxed/simple;
	bh=M9TkP7hD5lRtI+leApsVC9r5vjHZoxpXRpSG3T9jQdY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LSJWoZKQQa3wdDGQWGLDa/anrtx35pyc1heD2DZSc5kPwYn1O4lHoY7ZOLuOH2hwd1GgcNRl+ZoweAaPAh2H5iIUUsY4+4XcYMuI0S9UgqtHZCU4GWeZYH7/ajRmEXCHAXE20BnRW31l0BUlB18HEOS8VK7jmcmjaQT9XmTv1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WNXl5/hu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763041396; x=1794577396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M9TkP7hD5lRtI+leApsVC9r5vjHZoxpXRpSG3T9jQdY=;
  b=WNXl5/huag2euNHGuprMHwE4I42MCzmPkx0wDGeg0Y9kEdkHplbnc5Ls
   0XJIGyQvBCWXuyEFPEDxbAZpQbGXIXMnk/hDC8YNTQxigVitwDTB6uSVB
   jxLcxiVCtqZIP7OJRHM/UkBi/nOG+NRu5tdS1h9sDdFMrnE75tTukNOjK
   Bm1BrHqTZFOVct6oDcNhPGxlvcgHi0tA6yQ8wePoDVvORX6kZfEsQi5pR
   /nS9h9aDaDH31mQoyvEHnE98wfFohUj177kcFzP0/GRzfCENzHFW8xgKi
   ds2RfTCld6vWFdo01p8+QIGPwEtvZmV03gOzF3gPFl97BW2/83dVn4geR
   A==;
X-CSE-ConnectionGUID: xr02S9ULRG6UVhFcjxknRw==
X-CSE-MsgGUID: RLecDC9PQs2D+j8Hm2jUhQ==
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="280440670"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2025 06:43:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 13 Nov 2025 06:42:34 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 13 Nov 2025 06:42:33 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <jassisinghbrar@gmail.com>, <conor.dooley@microchip.com>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] mailbox: mchp-ipc-sbi: fix out-of-bounds access in mchp_ipc_get_cluster_aggr_irq()
Date: Thu, 13 Nov 2025 13:49:22 +0000
Message-ID: <20251113134922.2546283-1-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The cluster_cfg array is dynamically allocated to hold per-CPU
configuration structures, with its size based on the number of online
CPUs. Previously, this array was indexed using hartid, which may be
non-contiguous or exceed the bounds of the array, leading to
out-of-bounds access.
Switch to using cpuid as the index, as it is guaranteed to be within
the valid range provided by for_each_online_cpu().

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 drivers/mailbox/mailbox-mchp-ipc-sbi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/mailbox-mchp-ipc-sbi.c b/drivers/mailbox/mailbox-mchp-ipc-sbi.c
index a6e52009a424..d444491a584e 100644
--- a/drivers/mailbox/mailbox-mchp-ipc-sbi.c
+++ b/drivers/mailbox/mailbox-mchp-ipc-sbi.c
@@ -180,20 +180,20 @@ static irqreturn_t mchp_ipc_cluster_aggr_isr(int irq, void *data)
 	/* Find out the hart that originated the irq */
 	for_each_online_cpu(i) {
 		hartid = cpuid_to_hartid_map(i);
-		if (irq == ipc->cluster_cfg[hartid].irq)
+		if (irq == ipc->cluster_cfg[i].irq)
 			break;
 	}
 
 	status_msg.cluster = hartid;
-	memcpy(ipc->cluster_cfg[hartid].buf_base, &status_msg, sizeof(struct mchp_ipc_status));
+	memcpy(ipc->cluster_cfg[i].buf_base, &status_msg, sizeof(struct mchp_ipc_status));
 
-	ret = mchp_ipc_sbi_send(SBI_EXT_IPC_STATUS, ipc->cluster_cfg[hartid].buf_base_addr);
+	ret = mchp_ipc_sbi_send(SBI_EXT_IPC_STATUS, ipc->cluster_cfg[i].buf_base_addr);
 	if (ret < 0) {
 		dev_err_ratelimited(ipc->dev, "could not get IHC irq status ret=%d\n", ret);
 		return IRQ_HANDLED;
 	}
 
-	memcpy(&status_msg, ipc->cluster_cfg[hartid].buf_base, sizeof(struct mchp_ipc_status));
+	memcpy(&status_msg, ipc->cluster_cfg[i].buf_base, sizeof(struct mchp_ipc_status));
 
 	/*
 	 * Iterate over each bit set in the IHC interrupt status register (IRQ_STATUS) to identify
@@ -385,21 +385,21 @@ static int mchp_ipc_get_cluster_aggr_irq(struct mchp_ipc_sbi_mbox *ipc)
 		if (ret <= 0)
 			continue;
 
-		ipc->cluster_cfg[hartid].irq = ret;
-		ret = devm_request_irq(ipc->dev, ipc->cluster_cfg[hartid].irq,
+		ipc->cluster_cfg[cpuid].irq = ret;
+		ret = devm_request_irq(ipc->dev, ipc->cluster_cfg[cpuid].irq,
 				       mchp_ipc_cluster_aggr_isr, IRQF_SHARED,
 				       "miv-ihc-irq", ipc);
 		if (ret)
 			return ret;
 
-		ipc->cluster_cfg[hartid].buf_base = devm_kmalloc(ipc->dev,
-								 sizeof(struct mchp_ipc_status),
-								 GFP_KERNEL);
+		ipc->cluster_cfg[cpuid].buf_base = devm_kmalloc(ipc->dev,
+								sizeof(struct mchp_ipc_status),
+								GFP_KERNEL);
 
-		if (!ipc->cluster_cfg[hartid].buf_base)
+		if (!ipc->cluster_cfg[cpuid].buf_base)
 			return -ENOMEM;
 
-		ipc->cluster_cfg[hartid].buf_base_addr = __pa(ipc->cluster_cfg[hartid].buf_base);
+		ipc->cluster_cfg[cpuid].buf_base_addr = __pa(ipc->cluster_cfg[cpuid].buf_base);
 
 		irq_found = true;
 	}
-- 
2.34.1


