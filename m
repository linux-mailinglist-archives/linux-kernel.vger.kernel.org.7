Return-Path: <linux-kernel+bounces-783034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12C7B32896
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A497B77BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547D2727F3;
	Sat, 23 Aug 2025 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM9P3J75"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8A6266EF1
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953028; cv=none; b=i97XOLsRy+B78nDog/o6bbRttQz9CxoZatOrxemkfKWV1EjyjiSJeDaPiRuSQiV6s0LfLq3osKw2TsWSjuHxxBLpcLWN1PWZ0BdPN4GcOikaGVNA5mamyAGrdRoExmC3832Isvd3Wk4X+hZGlOALIGAFZWuCawYxpcTUcR5YNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953028; c=relaxed/simple;
	bh=EHd+pho2CKEgo1TnShr+E4CGerzPl5OLtXmFsDyNtVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZ/6XtOTdnPq4vE/CWYMt/heywpceIKX85zm61HEpkDHFz9s4RZv45GbpmHPd77R5zequ8PubHUNqhCZarmPU8UqdCVTqTtNbmENl3G53bIDG0KbjrpXfp0JyFljrVv/21Ht5oYm3MIdcHtSJrbugytN1BhnoQgJ/rvZtxclVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dM9P3J75; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7acfde3so449098966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953024; x=1756557824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBzxzKnHxbIaunAwDeVnqD0gBKox3dXJJ/Rscg6vwsQ=;
        b=dM9P3J75uZOo6fm3sJI0PZW1bANL1fNHDDmJcc3a3pnuwd86avzmLbr0s9r6RIXqdu
         WCXmUnSDcC2i9m0Py1BD1HM39h/sVoFNkyKf+p41qpzSA5+nl/LtOQHUKmOINeQCGrQ/
         A4ihrKFY2segW2fOwNCt6V+RkC1SMgsjPmPG/GEC7dtybTZiqTWqwpAPCjnB8lQm6KZc
         ZyLwRyCRXwecVdUF6m8P1qR1I6OPji+1nx1+/hiw1d7G3fiVWCLBNdy/gR15Jayn3EZ/
         4SyNnxri+3tASx9rcBD8Q13d3Pt0Q2qU0oVjEVqYtHPSGIUfFRc8GWAewsB8QsxEn/BS
         DT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953024; x=1756557824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBzxzKnHxbIaunAwDeVnqD0gBKox3dXJJ/Rscg6vwsQ=;
        b=RgxPXWBwP9JgTG19iZB1NxSInU21+99tSKsIp6Yl1K+RUAlUDFhcyo2+fa4//7sz+b
         icTfTEIT8i8b/0oOKuM6MRHVfS6ogKDGiKlFdYsqo4MZxRBt1L3p2eYgjv8Gv4fMfGqo
         eKIEHfnhoeJcbUpRo3zMxuF/1NdbUw7ZMU4GirPS34QQuPXwZAzpv8FYYEVm+YjC6OZR
         cyVqcIT/7YYkrzEWh9lKXgIM6a/HAmiNjYzkqldX+ZFPTKvilGEn05ZGHDkkucOAhECv
         tXI4C0aJHgBenkvQvil/O5+vcYBDkNCNnu54uDQo/wBU5CfCTGdXIaAB7gT58sxRPvl9
         nn5w==
X-Forwarded-Encrypted: i=1; AJvYcCXaeH3kkAM7fgESEAzTTX8ACt/uHbIWecAFzrpwnovuqutKlptSiA+8aKfRY8tTqkeIAMTgKx2Li5t6eQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf0if9i1rJO2f5Ha689jbflpnq/bcHUZEZzTlP/q3Xo2lN1fyy
	Ytttxeaa+JDPaX2gK/AwYpdwefnnsG910NqVGeZeoxExIwUkuXt2Wufv
X-Gm-Gg: ASbGncuD9vqFregxF84EhXGLXUNIYCJGwp1U8DZUbPpjCRRIYPtNYuhQPA4Ykzl9N7E
	krc1XRm2iNNPQdmUEpocF9megarm+gKidUdTqj/RSbJKajHrYRqRelYO9/s4l2ae6kO+WN6dyRG
	bwdhzXJdIkfwU/0M+M5H+VrBhUPnGr15hMrrLn1dNiEokQv+XRI0Cznx5p8Lp1lbdxfWb5tUWks
	TzYvja1GSzxCAA2kTds2wItVlcvDcWzQHCypjg8TJQUl7cmAP1E4D0VvF71h8L0T5flfMZGtrzF
	/Ls0NRqUgdbCitsAauE/eXc3ZoW0CtRa9SyWNveyipizyL+oFFQvd/OowpoIOJBjnS/oM8iGkpN
	lNU4h5BBH1ZjiBbJ5VAe56juUNw==
X-Google-Smtp-Source: AGHT+IGOPYK8nbUxDZ882SzO7ZNhbK6L59vKLT7JZZ2ydjpaNIC9KyWvkjge3qksvdjnHlfHLmfpqg==
X-Received: by 2002:a17:907:ea8:b0:afd:e687:d280 with SMTP id a640c23a62f3a-afe295d7033mr515436866b.44.1755953023654;
        Sat, 23 Aug 2025 05:43:43 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:43 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/14] staging: rtl8723bs: remove bPseudoTest from hal_EfuseSwitchToBank
Date: Sat, 23 Aug 2025 14:43:18 +0200
Message-ID: <20250823124321.485910-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250823124321.485910-1-straube.linux@gmail.com>
References: <20250823124321.485910-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function hal_EfuseSwitchToBank is always called with bPseudoTest set to
false. Remove the pPseudoTest parameter and reomve resulting dead code to
reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 62 +++++++------------
 1 file changed, 24 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 0679f77e3498..014d94894de9 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -445,47 +445,33 @@ void rtl8723b_InitializeFirmwareVars(struct adapter *padapter)
 /* 				Efuse related code */
 /*  */
 static u8 hal_EfuseSwitchToBank(
-	struct adapter *padapter, u8 bank, bool bPseudoTest
+	struct adapter *padapter, u8 bank
 )
 {
 	u8 bRet = false;
 	u32 value32 = 0;
-#ifdef HAL_EFUSE_MEMORY
-	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
-	struct efuse_hal *pEfuseHal = &pHalData->EfuseHal;
-#endif
 
-
-	if (bPseudoTest) {
-#ifdef HAL_EFUSE_MEMORY
-		pEfuseHal->fakeEfuseBank = bank;
-#else
-		fakeEfuseBank = bank;
-#endif
-		bRet = true;
-	} else {
-		value32 = rtw_read32(padapter, EFUSE_TEST);
-		bRet = true;
-		switch (bank) {
-		case 0:
-			value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_WIFI_SEL_0);
-			break;
-		case 1:
-			value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_BT_SEL_0);
-			break;
-		case 2:
-			value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_BT_SEL_1);
-			break;
-		case 3:
-			value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_BT_SEL_2);
-			break;
-		default:
-			value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_WIFI_SEL_0);
-			bRet = false;
-			break;
-		}
-		rtw_write32(padapter, EFUSE_TEST, value32);
+	value32 = rtw_read32(padapter, EFUSE_TEST);
+	bRet = true;
+	switch (bank) {
+	case 0:
+		value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_WIFI_SEL_0);
+		break;
+	case 1:
+		value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_BT_SEL_0);
+		break;
+	case 2:
+		value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_BT_SEL_1);
+		break;
+	case 3:
+		value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_BT_SEL_2);
+		break;
+	default:
+		value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_WIFI_SEL_0);
+		bRet = false;
+		break;
 	}
+	rtw_write32(padapter, EFUSE_TEST, value32);
 
 	return bRet;
 }
@@ -692,7 +678,7 @@ static void hal_ReadEFuse_WiFi(
 	memset(efuseTbl, 0xFF, EFUSE_MAX_MAP_LEN);
 
 	/*  switch bank back to bank 0 for later BT and wifi use. */
-	hal_EfuseSwitchToBank(padapter, 0, false);
+	hal_EfuseSwitchToBank(padapter, 0);
 
 	while (AVAILABLE_EFUSE_ADDR(eFuse_Addr)) {
 		efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, false);
@@ -782,7 +768,7 @@ static void hal_ReadEFuse_BT(
 	Hal_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &total);
 
 	for (bank = 1; bank < 3; bank++) { /*  8723b Max bake 0~2 */
-		if (hal_EfuseSwitchToBank(padapter, bank, false) == false)
+		if (hal_EfuseSwitchToBank(padapter, bank) == false)
 			goto exit;
 
 		eFuse_Addr = 0;
@@ -833,7 +819,7 @@ static void hal_ReadEFuse_BT(
 	}
 
 	/*  switch bank back to bank 0 for later BT and wifi use. */
-	hal_EfuseSwitchToBank(padapter, 0, false);
+	hal_EfuseSwitchToBank(padapter, 0);
 
 	/*  Copy from Efuse map to output pointer memory!!! */
 	for (i = 0; i < _size_byte; i++)
-- 
2.51.0


