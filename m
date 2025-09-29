Return-Path: <linux-kernel+bounces-836179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9155BA8F11
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07307ADE95
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5272FDC38;
	Mon, 29 Sep 2025 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YoNAgrTs"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19580604
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143585; cv=none; b=djIeZyhzRG61/1Hl4H8fggwA+R4b8PldR7GztgNDfCczpoaePnVI+wtXtRG6P6YL8I6dY5NcZjYj2xPqHuiALhMDunis/2Jm4F47PLuaw3wFKlN1/BWFOr6Nn8VeQqyPb/i79ZA9OnjXVcVt17h1GHBdrPZJVC8Fs1S858PY3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143585; c=relaxed/simple;
	bh=tWDyDWTLQk8rjyF/vsJo4jjdofO3C3YB0xzyW1/0dDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=NhP4k2L4xZ0SSq/pZaw7JTjd2DdWFg9lzlixrrkPTPadV2ZJjmDqdBOJwlVIURHczGFP5SyOXVi4CPbmEPXQEY7Wf6JaDW5QqK4ztTA25yjOhJU3/sF3Q+mt0q7jLiPb/N/APVTtZ5m44EoH5ZG0MRHd7WDu9IEoR/YN044Jz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YoNAgrTs; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250929105938epoutp041bc93f08eeb270c88972577df74fbca1~pu8O_o04G0532105321epoutp04W
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:59:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250929105938epoutp041bc93f08eeb270c88972577df74fbca1~pu8O_o04G0532105321epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759143578;
	bh=EwjAsCHpAtEOfYR7kD9OlxbY41/aURUPUsKMYtCrtcQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=YoNAgrTsHeIEbiBqM8h9dBVc4gMKO9AyUrPtB+0O+gile4DIhNmXjgwI0A/D4NX0b
	 5kRJNuXNedG0RR1fCqIXNkdGJC6Iv08hv7CWr/YyDa4zHqukpmYDtuTPy2P5oRJWcx
	 prsgPDETPUivthTjYi3+g/k7xaiZbHMaP7XU2kss=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20250929105937epcas2p3119ec6e25d535bd5b9cddfeec7d8db21~pu8OB474j3158031580epcas2p3d;
	Mon, 29 Sep 2025 10:59:37 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.212]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cZyr93VWGz3hhT4; Mon, 29 Sep
	2025 10:59:37 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250929105936epcas2p1308a10b1ab51c5b543ea246bc3165fe4~pu8M4nOrh2261322613epcas2p1D;
	Mon, 29 Sep 2025 10:59:36 +0000 (GMT)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250929105936epsmtip271ab9cf68e318a2afd593d83165bd224~pu8MzaTb_0081300813epsmtip2V;
	Mon, 29 Sep 2025 10:59:36 +0000 (GMT)
From: HOYOUNG SEO <hy50.seo@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
	kwangwon.min@samsung.com, kwmad.kim@samsung.com, cpgs@samsung.com,
	h10.kim@samsung.com
Cc: "hy50.seo" <hy50.seo@samsung.com>
Subject: [PATCH v1] scsi: ufs: core: Introduce quirk to check UTP error
Date: Mon, 29 Sep 2025 19:58:00 +0900
Message-Id: <20250929105801.428105-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250929105936epcas2p1308a10b1ab51c5b543ea246bc3165fe4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250929105936epcas2p1308a10b1ab51c5b543ea246bc3165fe4
References: <CGME20250929105936epcas2p1308a10b1ab51c5b543ea246bc3165fe4@epcas2p1.samsung.com>

From: "hy50.seo" <hy50.seo@samsung.com>

If the UTP error occurs alone, the UFS is not recovered.
It does not check for error and only generates io timeout or OCS error.
This is because UTP error is not defined in error handler.
To fixed this, add UFS qurik about UTP error and this quirk is enable,
UFS reset is performed when a UTP error occurs.

sd 0:0:0:0: [sda] tag#38 UNKNOWN(0x2003) Result: hostbyte=0x07
driverbyte=DRIVER_OK cmd_age=0s
sd 0:0:0:0: [sda] tag#38 CDB: opcode=0x28 28 00 00 51 24 e2 00 00 08 00
I/O error, dev sda, sector 42542864 op 0x0:(READ) flags 0x80700 phys_seg
8 prio class 2
OCS error from controller = 9 for tag 39
pa_err[1] = 0x80000010 at 2667224756 us
pa_err: total cnt=2
dl_err[0] = 0x80000002 at 2667148060 us
dl_err[1] = 0x80002000 at 2667282844 us
No record of nl_err
No record of tl_err
No record of dme_err
No record of auto_hibern8_err
fatal_err[0] = 0x804 at 2667282836 us

---------------------------------------------------
		REGISTER
---------------------------------------------------
                           NAME	      OFFSET	         VALUE
                    STD HCI SFR	  0xfffffff0	           0x0
                           AHIT	        0x18	         0x814
               INTERRUPT STATUS	        0x20	        0x1000
               INTERRUPT ENABLE	        0x24	       0x70ef5

Change-Id: I25156081c52a23dfe1223c18abcce9e9c6fe3868
Signed-off-by: hy50.seo <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 11 +++++++++++
 include/ufs/ufshcd.h      |  6 ++++++
 include/ufs/ufshci.h      |  3 ++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index cfc149f8238e..0421178000c1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6735,6 +6735,14 @@ static void ufshcd_err_handler(struct work_struct *work)
 		goto do_reset;
 	}
 
+	if ((hba->dev_quirks & UFSHCD_QUIRK_UTP_ERROR) && (hba->errors & UTP_ERROR)) {
+		ufshcd_print_host_state(hba);
+		ufshcd_print_evt_hist(hba);
+
+		needs_reset = true;
+		goto do_reset;
+	}
+
 	/*
 	 * If LINERESET was caught, UFS might have been put to PWM mode,
 	 * check if power mode restore is needed.
@@ -6941,6 +6949,9 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba, u32 intr_status)
 		queue_eh_work = true;
 	}
 
+	if ((hba->quirks & UFSHCD_QUIRK_UTP_ERROR) && (hba->errors & UTP_ERROR))
+		queue_eh_work = true;
+
 	if (hba->errors & UIC_ERROR) {
 		hba->uic_error = 0;
 		retval = ufshcd_update_uic_error(hba);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index ea0021f067c9..3ac6ac5fc7fb 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -688,6 +688,12 @@ enum ufshcd_quirks {
 	 * single doorbell mode.
 	 */
 	UFSHCD_QUIRK_BROKEN_LSDBS_CAP			= 1 << 25,
+
+	/*
+	 * This quirk indicated that report the error when UTP error occurs.
+	 * Enable this quirk will the error handler allows the ufs to be reocvery.
+	 */
+	UFSHCD_QUIRK_UTP_ERROR				= 1 << 26,
 };
 
 enum ufshcd_caps {
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 612500a7088f..79a052a50f91 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -180,6 +180,7 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 #define UTP_TASK_REQ_COMPL			0x200
 #define UIC_COMMAND_COMPL			0x400
 #define DEVICE_FATAL_ERROR			0x800
+#define UTP_ERROR				0x1000
 #define CONTROLLER_FATAL_ERROR			0x10000
 #define SYSTEM_BUS_FATAL_ERROR			0x20000
 #define CRYPTO_ENGINE_FATAL_ERROR		0x40000
@@ -193,7 +194,7 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 
 #define UFSHCD_UIC_MASK		(UIC_COMMAND_COMPL | UFSHCD_UIC_PWR_MASK)
 
-#define UFSHCD_ERROR_MASK	(UIC_ERROR | INT_FATAL_ERRORS)
+#define UFSHCD_ERROR_MASK	(UIC_ERROR | INT_FATAL_ERRORS | UTP_ERROR)
 
 #define INT_FATAL_ERRORS	(DEVICE_FATAL_ERROR |\
 				CONTROLLER_FATAL_ERROR |\
-- 
2.26.0


