Return-Path: <linux-kernel+bounces-736273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E5B09ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C03616EC97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56A1BD9F0;
	Fri, 18 Jul 2025 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="GnPlu2Wc"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB311185
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814962; cv=none; b=RtWxJxSfm4+iLlkleYW+Rg5G9fi1c8Vdfy6lWfeUUbtbmD3nAr5MfrDEyjee8eepAN3SdPI9g7Z+n1M9LFpxS8rwTyvSBLYnhquKKHYQ7G2LKNopHtFK51bd8Awo1shaz1//l5l7A+nbTvHxiSrgpCvzhl0dnIn62257nALTiA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814962; c=relaxed/simple;
	bh=CFx1IeDtZ+sN7mgMMepBTLN+tYrRYBQxlBPdHX6l2uY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jfxwQFgSH5gmoucrGEHaN7scz5D8jWrrfNxZui7AgYq4G1gaLWjhyHDtRLCY0QF+zI+uEGj+XNLJ2L/wrujnsqLlC3HFtACEOrMKEHpANh55THVhBpPooj4zbZrGh2IGmkmqXPsbet70XH9f/XcSRuuSFocN6gAu9f0uND2Wa0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=GnPlu2Wc; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 60CBD104C1E6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:24:33 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 60CBD104C1E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1752814473; bh=CFx1IeDtZ+sN7mgMMepBTLN+tYrRYBQxlBPdHX6l2uY=;
	h=Date:From:To:Cc:Subject:From;
	b=GnPlu2WcC27uQRQ06Fbdv44xHFOL6HTCNAf2upNDaRm76T8q4EokBfr1OWnj5MZZW
	 7DsKuex367kV4zDoxQ6jpw1XLITFrQXkEHWYdDeYDjwp2dlWPLC/bzM7seECfWXJOQ
	 em/qNuZ5hmpE4g2kfNzJRO0vyq7iVZL+YUod0pis=
Received: (qmail 32448 invoked by uid 510); 18 Jul 2025 10:24:33 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.55098 secs; 18 Jul 2025 10:24:33 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 18 Jul 2025 10:24:30 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 2A40236003F;
	Fri, 18 Jul 2025 10:24:30 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id E71351E814DD;
	Fri, 18 Jul 2025 10:24:29 +0530 (IST)
Date: Fri, 18 Jul 2025 10:24:14 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: gregkh@linuxfoundation.org, griffin@kroah.com, riyandhiman14@gmail.com,
	gagath@debian.org, pedropz1537@gmail.com
Cc: liyuesong@vivo.com, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org,
	akhilesh@ee.iitb.ac.in
Subject: [PATCH] staging: vme_user: fix spelling errors
Message-ID: <aHnTdicud7sW/Zis@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix spelling errors reported by codespell tool as below.
bewteen --> between
enty --> entry
Copntroller --> Controller

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/staging/vme_user/vme.c        | 4 ++--
 drivers/staging/vme_user/vme_tsi148.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 42304c9f83a2..a9bff27127a7 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -809,7 +809,7 @@ EXPORT_SYMBOL(vme_master_free);
  * @vdev: Pointer to VME device struct vme_dev assigned to driver instance.
  * @route: Required src/destination combination.
  *
- * Request a VME DMA controller with capability to perform transfers bewteen
+ * Request a VME DMA controller with capability to perform transfers between
  * requested source/destination combination.
  *
  * Return: Pointer to VME DMA resource on success, NULL on failure.
@@ -1045,7 +1045,7 @@ void vme_dma_free_attribute(struct vme_dma_attr *attributes)
 EXPORT_SYMBOL(vme_dma_free_attribute);
 
 /**
- * vme_dma_list_add - Add enty to a VME DMA list.
+ * vme_dma_list_add - Add entry to a VME DMA list.
  * @list: Pointer to VME list.
  * @src: Pointer to DMA list attribute to use as source.
  * @dest: Pointer to DMA list attribute to use as destination.
diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
index db246cbc54c3..f73ac92320bb 100644
--- a/drivers/staging/vme_user/vme_tsi148.h
+++ b/drivers/staging/vme_user/vme_tsi148.h
@@ -1347,7 +1347,7 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 #define TSI148_GCSR_GCTRL_LRST         BIT(15)	/* Local Reset */
 #define TSI148_GCSR_GCTRL_SFAILEN      BIT(14)	/* System Fail enable */
 #define TSI148_GCSR_GCTRL_BDFAILS      BIT(13)	/* Board Fail Status */
-#define TSI148_GCSR_GCTRL_SCON         BIT(12)	/* System Copntroller */
+#define TSI148_GCSR_GCTRL_SCON         BIT(12)	/* System Controller */
 #define TSI148_GCSR_GCTRL_MEN          BIT(11)	/* Module Enable (READY) */
 
 #define TSI148_GCSR_GCTRL_LMI3S        BIT(7)	/* Loc Monitor 3 Int Status */
-- 
2.34.1


