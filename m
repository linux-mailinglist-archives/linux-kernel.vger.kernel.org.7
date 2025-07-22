Return-Path: <linux-kernel+bounces-740406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFFDB0D3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C887D188A3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF5B1A256B;
	Tue, 22 Jul 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHvtb27a"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04E0225403
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170089; cv=none; b=t0bwbWeYRf8ZhVGB7hv7WnwrZ1063xyBjGWX9VfZxFaiQXWQZqTejBN4ZxRwQGY9giiwDtojjerhL8MJW+4nz/AtCBn/yiPQYhJ2McjXBXpJQj2C18YeO3tjYfFGHszoyh57NEEobweDMGynbzgKE1Vx344WtiNdLRZvMMfyOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170089; c=relaxed/simple;
	bh=09X1FYDd5bLS3DPuAiSRXnDoFN1mXNFisgGOgUL8+Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSKnDDZf6a1nzss5zyp2CnoE5RXngqGEJGlZBvHogqcSCSh7BdHtPMC0O/Kz3bapYrt4Vb0IcWmzehsog2c+eeFPnpQuDh8PeRNxIXA43MoK6xguwWGfjE5d8Lr/3LVYZmxJVu3I/0kvgyaVtws5BQqYrm+U3yWu+CPARZcjTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHvtb27a; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so981007966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753170085; x=1753774885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6W1FPOz9tSHUX2gqoRxUY9TCTbS2xN4Rbh5H0nxiSmc=;
        b=QHvtb27aE6UfWVc4z2bXJnGcJ+Ak1NxJzw4s0978iEW+LbGVSJnSkTHRTGrhn027//
         myZ3hjCFdiUItkSLtjwvguSRnlBykeCV85Hx7HPTUmQxBsZ71t5Z2OR0uMg2I6lHg/dp
         Hy7bOFVU2IPaVzm7uH+LvpfRwysDY4PdTsMJRDUi6adpYdeiYegEM5ej+yVQBhlTE1T7
         FtxD3xHyWMxKqDoStaqDJUihjVZirtnxhuypAcRCWI6Yi6h6F1P3X3MEAhz5c8ClJ/hR
         wC5KaZvCjm+KX3Z2XdTdZsqi1FPB/ZneKzljjqM2nfT7bRC35CLZo5ZXsXPziw2lF/PG
         zGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753170085; x=1753774885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W1FPOz9tSHUX2gqoRxUY9TCTbS2xN4Rbh5H0nxiSmc=;
        b=Zc8BDeGa9TXlzWvvbDJUmtfwp5BhRvGc02/WHlBMeVAeWJKzsD/TFVqimIJEqvU/Y0
         c9yOb7o/6wiBzegw/gbFALDcz6Gb4F0RnbPXppYXFkmOpOokifwlAo4xjukP7XntmjgI
         2hrsH2W1s9WWcFbGctPotd6y4HR6608bJ8JDLr7MzDA1lkFytMS+S0RCI+8bdLUIwv30
         6/teTSAfvAuD+xhUOWqgqwZzx8oNKeqj8r6R2JG3l4l/s6jKRzEJV/8GfELkYVAljGn5
         8Jtxm6bToFpkUyK/ikykvUF15uQTANfokXtDMjIBnZV3pQgH/h2X5Mq920sIo68PU33f
         3Jug==
X-Forwarded-Encrypted: i=1; AJvYcCU1YbdmNvABfw3kWGWW6igfnNL78khXGrjO0iHBmbn7jmgT3Z7PWTee9A0J87dyYehOo6nw0SoEhvpObj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPS5nUtU32rkmgbZs8+I6dwnRr9lEuqvVdbU4xrr7xG/Kr9t00
	d3adtqy1eoilU0JTpM2m5ueugCXSccLCcr4n1KGD7MLq4PBt26F3dXkt
X-Gm-Gg: ASbGncutIdsN4dDcR6tTVS08spPpQzigD7PPcvjNZ+1G2rR+PmNXirj8lgxLY1v+tDS
	64EEY14qZQJfP9o4FuE+vJ3Zpk7KQDtL4gC8HEbI7EO+Z/RPaxBwWOhdO21wtQxXJBZ/szjfs2D
	nqbgsiXqxWAfqy04XH4JfSnQRt2Udxi0ZUnHUJyWal9u6ge9iBXkEXXUsJxdjdOGU+ReUMIDmwd
	CEECFCAV7G0WIFXgbcDhHrJTjQsPLNjC9rDdtcML3tL62HuzHeAZhkkjs4xDpOjAXbBpwsfhA5p
	Atr7KsfXi/tqmXgKpZh5PQz71WJ2EinHM6/ZX88FvpVIOpMPuO3cmaSZJm2p83sFnhSLcgYTo86
	yPh5OE0XsRGDIlLirw3SoQZ8=
X-Google-Smtp-Source: AGHT+IGPSGEgzME5Asjigl248gpzG65M9tdsmmmrjez5T1volOyNNvzre0xWUF6TuXh91rCAHDkfAw==
X-Received: by 2002:a17:907:971b:b0:ae7:f389:c751 with SMTP id a640c23a62f3a-af14f24210bmr252751666b.0.1753170084965;
        Tue, 22 Jul 2025 00:41:24 -0700 (PDT)
Received: from tumbleweed ([95.90.185.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79d6c6sm821224666b.32.2025.07.22.00.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:41:24 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/7] staging: rtl8723bs: CheckFwRsvdPageContent is empty
Date: Tue, 22 Jul 2025 09:41:09 +0200
Message-ID: <20250722074115.35044-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722074115.35044-1-straube.linux@gmail.com>
References: <20250722074115.35044-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function CheckFwRsvdPageContent is empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c      | 9 ---------
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 --
 drivers/staging/rtl8723bs/include/rtl8723b_cmd.h  | 2 --
 3 files changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 56526056dd1d..3c5d516cb3af 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -287,15 +287,6 @@ static void ConstructNullFunctionData(
 	*pLength = pktlen;
 }
 
-/*
- * To check if reserved page content is destroyed by beacon because beacon
- * is too large.
- */
-/* 2010.06.23. Added by tynli. */
-void CheckFwRsvdPageContent(struct adapter *Adapter)
-{
-}
-
 static void rtl8723b_set_FwRsvdPage_cmd(struct adapter *padapter, struct rsvdpage_loc *rsvdpageloc)
 {
 	u8 u1H2CRsvdPageParm[H2C_RSVDPAGE_LOC_LEN] = {0};
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index a9f33444aec2..1608bc71bd71 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1196,8 +1196,6 @@ static void StopTxBeacon(struct adapter *padapter)
 	rtw_write8(padapter, REG_TBTT_PROHIBIT+1, 0x64);
 	pHalData->RegReg542 &= ~BIT(0);
 	rtw_write8(padapter, REG_TBTT_PROHIBIT+2, pHalData->RegReg542);
-
-	CheckFwRsvdPageContent(padapter);  /*  2010.06.23. Added by tynli. */
 }
 
 static void _BeaconFunctionEnable(struct adapter *padapter, u8 Enable, u8 Linked)
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_cmd.h b/drivers/staging/rtl8723bs/include/rtl8723b_cmd.h
index 0665c4955936..6b2d79e19088 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_cmd.h
@@ -175,8 +175,6 @@ void rtl8723b_set_FwMediaStatusRpt_cmd(struct adapter *padapter, u8 mstatus, u8
 void rtl8723b_download_rsvd_page(struct adapter *padapter, u8 mstatus);
 void rtl8723b_download_BTCoex_AP_mode_rsvd_page(struct adapter *padapter);
 
-void CheckFwRsvdPageContent(struct adapter *padapter);
-
 void rtl8723b_set_FwPwrModeInIPS_cmd(struct adapter *padapter, u8 cmd_param);
 
 s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer);
-- 
2.50.1


