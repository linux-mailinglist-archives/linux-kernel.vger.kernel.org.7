Return-Path: <linux-kernel+bounces-839887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F450BB2A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68BD1898280
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C6323ABAF;
	Thu,  2 Oct 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rIgYES2b"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398B32AD0C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759388468; cv=none; b=rly0swbZVwy+B1dWnHPapu7Jlle2n6iEayz9AhUZSDSXBQilDfQxeq18AN8k/51ivyXyq8xbTuxHUq/L9JA1nUeUhDDfk2IW3gK7OUZdB7V3oxNtkV5uSG/uJb1cSEAL10Lxop4DuwBOxHcxCcCltlw6tvEAwdusm/Ffuz4Mn9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759388468; c=relaxed/simple;
	bh=HwKwQBuPtqotHcc7YZfe+u1X0TJrSXxj2hiVF7dA3ts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=DkNeu7gFUu1WqAkU8POCgwN5FLt1FBLYkDESLJi70z7koakFgU8QR+vLBeEQhFqCDH5lipaCwHnpz8PowFSBmg6w7UalcQQ3+EIys/7HYC0p9+bEAvuVkMW4HUgDn1eHyj1FrTzwRHrEfYs/jqgJ6Xx4BYmBCNxasXnfwJlH4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rIgYES2b; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251002070058epoutp01b7b2b02a7ef18b8a0973a7ffe9a93b08~qmnsiZnn30341603416epoutp01Q
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:00:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251002070058epoutp01b7b2b02a7ef18b8a0973a7ffe9a93b08~qmnsiZnn30341603416epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759388458;
	bh=6yJbRfXN+8LHPax0u6/umb94/r0L9Ec+xmv3tMcbsHA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=rIgYES2bQvwF9NNOCl8fZxM4MX+dgbhF5HGXDV+2Q4RE1V5kJVHuf3QIPk+CXu6CU
	 fGiCWx0nHsuw2ys2NT9wfx2d7xL3A+G1EpJeYe+kCKKs3sAr7YhhWfL0hDv3vloC5K
	 GE39YQVxMRj6hiMECmJJzV5dpM23CDVquNUJqQkM=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20251002070057epcas1p154d79dd1bb022dbb4ede4da1f45c0c26~qmnsReyAO1717617176epcas1p1B;
	Thu,  2 Oct 2025 07:00:57 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.115]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ccjPP57RNz6B9mR; Thu,  2 Oct
	2025 07:00:57 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20251002070057epcas1p49ac487359f24f6813ba8f9f44bcf0924~qmnrqNQT51483914839epcas1p4W;
	Thu,  2 Oct 2025 07:00:57 +0000 (GMT)
Received: from wkk-400TFA-400SFA.. (unknown [10.253.99.106]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251002070057epsmtip2e968455d70721372572fce9f394f2b36~qmnrlsFt42374423744epsmtip2k;
	Thu,  2 Oct 2025 07:00:57 +0000 (GMT)
From: Wonkon Kim <wkon.kim@samsung.com>
To: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	peter.wang@mediatek.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wkon.kim@samsung.com
Subject: [PATCH] ufs: core: Initialize a variable mode for PA_PWRMODE
Date: Thu,  2 Oct 2025 16:00:27 +0900
Message-Id: <20251002070027.228638-1-wkon.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251002070057epcas1p49ac487359f24f6813ba8f9f44bcf0924
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251002070057epcas1p49ac487359f24f6813ba8f9f44bcf0924
References: <CGME20251002070057epcas1p49ac487359f24f6813ba8f9f44bcf0924@epcas1p4.samsung.com>

If ufshcd_dme_get() fails uic cmd error,
a variable mode has a garbage value.
It may return unintended result for pwr mode restore.

Initialize it as 0 and will return true when ufshcd_dme_get() fails,
because PA power mode 0 is not defined.

Signed-off-by: Wonkon Kim <wkon.kim@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9a43102b2b21..a4438a3cb73a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6581,7 +6581,7 @@ static inline void ufshcd_recover_pm_error(struct ufs_hba *hba)
 static bool ufshcd_is_pwr_mode_restore_needed(struct ufs_hba *hba)
 {
 	struct ufs_pa_layer_attr *pwr_info = &hba->pwr_info;
-	u32 mode;
+	u32 mode = 0;
 
 	ufshcd_dme_get(hba, UIC_ARG_MIB(PA_PWRMODE), &mode);
 
-- 
2.34.1


