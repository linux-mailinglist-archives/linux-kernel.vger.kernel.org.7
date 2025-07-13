Return-Path: <linux-kernel+bounces-729019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A4B03091
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 12:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BDE17AF3B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B19F267705;
	Sun, 13 Jul 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB6QOEiR"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E5FF4FA
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752400979; cv=none; b=lAvcVxemhbUt1b9zQ6WkNTh70xUbNaTI0sh1Ksvqz2DXp9Zkmtc1Upg2xIeBa8t4u2Rt/ROyT/8pelzmd+xT9BUvSfn8NUCr4FJI/eWrRyY56AF+n8aYAqk19Yfl7YQMjzf69NwapOGUxevSOivmHqIBWe5dlS16gCuR8Jp3jgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752400979; c=relaxed/simple;
	bh=lsSI21PHcIe86RLoSJo2+tC0OQ01xW8aqHIJLeYsuF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKlLw94XKf3W2EjW94SHjQrKNAQo2SsX5CZUqcqk+O3qdfljvk7EPj9SFWqcVz++vNYoeK2VEW7d/4c04FgewXErU5sayuYKKyD3eOGh4AnITAVQRLX/40VIy+rEtzaT4VrG20h3arO72b81NXFW3T/Gn3wKSg7ZiKxcQ/fUpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB6QOEiR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0c4945c76so564474466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752400977; x=1753005777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkPCFyycutUQr5Aj7ZQhTxE1LLnUnb4qDuMCZemDDVs=;
        b=FB6QOEiRNUFx/LOr6oWQQOm31wYNcfGsNcnxfJvRmdEee/JXZvTH3QymxH/FlQYYZv
         lQN3VEO1gDS/krskFkCc2k/fP2LtZzfjpz5pv3eq9slivsC8U/FghQafQpA0grHd6pSg
         BurPOmf/FHkta1T7bNyMJvp+S5URBGiMO+85RAE9NlEsTTj+UrPnavBUPc+CM2OCzm+U
         0zq6q6D55ZimShYlvRBwcDDhZiqW0sbzkHSmjcITpDikQANlKXRvVlx2oJVC4ELrBhPa
         /4uAgi9R5o3NnvhANWsbapG81iXFoob75jTo8Ry9bQ+SdT154oUZ07F6wgHUgYY5KAsm
         /jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752400977; x=1753005777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkPCFyycutUQr5Aj7ZQhTxE1LLnUnb4qDuMCZemDDVs=;
        b=YF5PT0FzrQCXbtvgay65O1HsU9m4PIoygHhqpZLHhZDYhEvS7Q9bgEATAkhtgfIk2w
         /+DIQVaH7+a9plHlAjEcsPJDWglSR0RAfaxEHEfYacITcmcVvTQnBlCLnM15hMzEdQFX
         swZ12gIm6aX23bXq6ojJD53exmfM6iY/13UCTcT/kLm55d/m4MFEvbMdeMNaigah1lIU
         /1Ve+5Qr7nZANxozrezGTF28cGaSfd7cFjIkzdSPnGrGwIzDz8BpdK7wxAuGzaPhr7bS
         /H6GAGI+RhWldcj3ZCN9/8f8SiUdeWivg/ztFtDysQHsbEDhC1flqnvpCCGEOEY4Mub3
         R/9w==
X-Forwarded-Encrypted: i=1; AJvYcCW1yLLZROTS6kGKFFUeKAAY2n+mmp69B2Su3X4W60ciZE5hJABgKZY6G6lz+Ganz2cG7ypCz2ClgrZWseA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHppvyDuDUWAjKGgFR0wuG7Ei3KXH+AUQKKltdRJpbXs41Ttz+
	3W+SMarMO/IZ67RrpN4KJxXmTOozd0ADRjtQL8v3woyy26KFgc3O6g3I
X-Gm-Gg: ASbGncv4Qr/bz8N9tzZZfeIcXjIqblmeYRAwG4Di4lm5LRCuXlXgDLD6gI/NGgJK/FX
	uvpv19fhYLiJKsbaCdPl4SsjoMx6UrdRuzhcYkd58Dp2FxpfcJCbah4psmFEVozJD9ZrAqj8O6l
	dGrPQeuINP4DjDQaA4Dbn4TQgS+rTwySXpKhNbnb/nqPSCRxvNSmzfg/bpOjNNhZtZuxCG0E8OO
	d+9EQo8FUBIWnhV9hIoaWrjekPMyPsOUjy7IBADnOhviSK26qLdePG61xukf8lA/dlgeMo2CMw8
	sFiTHvS//sLt7yXo/Z4Oiswyo/uUZKjcq4EyPMWUM1WcH7Riu5v+LJAtH29JJXczRh8HUgqj3Z8
	v/JgKIBP0aME8B0V4BGWGIpvUgIxPWCBApJRXRk818ojHSALT862ZjKFUp2hFm/GjyHtK
X-Google-Smtp-Source: AGHT+IF5Hzm8qF5VUHzYLWfPpKYSIQ+0hoRs9MsoR7ik7rv56nc0ybeTXehygLOman2MMK5F4Rnnsg==
X-Received: by 2002:a17:907:1b08:b0:ae1:f1e3:ccea with SMTP id a640c23a62f3a-ae6fbf40993mr1009518866b.7.1752400976291;
        Sun, 13 Jul 2025 03:02:56 -0700 (PDT)
Received: from tumbleweed (ip5f5ab8dd.dynamic.kabel-deutschland.de. [95.90.184.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee48f6sm639830366b.55.2025.07.13.03.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 03:02:55 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Efuse_WordEnableDataWrite() is not used
Date: Sun, 13 Jul 2025 12:02:29 +0200
Message-ID: <20250713100229.13917-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function Efuse_WordEnableDataWrite() defined in rtw_efuse.c is not
used. Remove the function and code it is calling, i.e. the function
pointer (*Efuse_WordEnableDataWrite) in struct hal_ops and the function
Hal_EfuseWordEnableDataWrite() to which it points.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 12 ----
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 68 -------------------
 drivers/staging/rtl8723bs/include/hal_intf.h  |  3 -
 drivers/staging/rtl8723bs/include/rtw_efuse.h |  1 -
 4 files changed, 84 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 7a74b011dedc..51cbf62c8f7d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -286,18 +286,6 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 	return bResult;
 }
 
-u8
-Efuse_WordEnableDataWrite(struct adapter *padapter,
-						u16		efuse_addr,
-						u8 word_en,
-						u8 *data,
-						bool		bPseudoTest)
-{
-	return padapter->HalFunc.Efuse_WordEnableDataWrite(padapter, efuse_addr,
-							   word_en, data,
-							   bPseudoTest);
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	Efuse_ReadAllMap
  *
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 893cab0532ed..3541aac605f6 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1077,71 +1077,6 @@ u16 Hal_EfuseGetCurrentSize(
 	return ret;
 }
 
-static u8 Hal_EfuseWordEnableDataWrite(
-	struct adapter *padapter,
-	u16 efuse_addr,
-	u8 word_en,
-	u8 *data,
-	bool bPseudoTest
-)
-{
-	u16 tmpaddr = 0;
-	u16 start_addr = efuse_addr;
-	u8 badworden = 0x0F;
-	u8 tmpdata[PGPKT_DATA_SIZE];
-
-	memset(tmpdata, 0xFF, PGPKT_DATA_SIZE);
-
-	if (!(word_en & BIT(0))) {
-		tmpaddr = start_addr;
-		efuse_OneByteWrite(padapter, start_addr++, data[0], bPseudoTest);
-		efuse_OneByteWrite(padapter, start_addr++, data[1], bPseudoTest);
-
-		efuse_OneByteRead(padapter, tmpaddr, &tmpdata[0], bPseudoTest);
-		efuse_OneByteRead(padapter, tmpaddr+1, &tmpdata[1], bPseudoTest);
-		if ((data[0] != tmpdata[0]) || (data[1] != tmpdata[1])) {
-			badworden &= (~BIT(0));
-		}
-	}
-	if (!(word_en & BIT(1))) {
-		tmpaddr = start_addr;
-		efuse_OneByteWrite(padapter, start_addr++, data[2], bPseudoTest);
-		efuse_OneByteWrite(padapter, start_addr++, data[3], bPseudoTest);
-
-		efuse_OneByteRead(padapter, tmpaddr, &tmpdata[2], bPseudoTest);
-		efuse_OneByteRead(padapter, tmpaddr+1, &tmpdata[3], bPseudoTest);
-		if ((data[2] != tmpdata[2]) || (data[3] != tmpdata[3])) {
-			badworden &= (~BIT(1));
-		}
-	}
-
-	if (!(word_en & BIT(2))) {
-		tmpaddr = start_addr;
-		efuse_OneByteWrite(padapter, start_addr++, data[4], bPseudoTest);
-		efuse_OneByteWrite(padapter, start_addr++, data[5], bPseudoTest);
-
-		efuse_OneByteRead(padapter, tmpaddr, &tmpdata[4], bPseudoTest);
-		efuse_OneByteRead(padapter, tmpaddr+1, &tmpdata[5], bPseudoTest);
-		if ((data[4] != tmpdata[4]) || (data[5] != tmpdata[5])) {
-			badworden &= (~BIT(2));
-		}
-	}
-
-	if (!(word_en & BIT(3))) {
-		tmpaddr = start_addr;
-		efuse_OneByteWrite(padapter, start_addr++, data[6], bPseudoTest);
-		efuse_OneByteWrite(padapter, start_addr++, data[7], bPseudoTest);
-
-		efuse_OneByteRead(padapter, tmpaddr, &tmpdata[6], bPseudoTest);
-		efuse_OneByteRead(padapter, tmpaddr+1, &tmpdata[7], bPseudoTest);
-		if ((data[6] != tmpdata[6]) || (data[7] != tmpdata[7])) {
-			badworden &= (~BIT(3));
-		}
-	}
-
-	return badworden;
-}
-
 static struct hal_version ReadChipVersion8723B(struct adapter *padapter)
 {
 	u32 value32;
@@ -1390,9 +1325,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	/*  Efuse related function */
-	pHalFunc->Efuse_WordEnableDataWrite = &Hal_EfuseWordEnableDataWrite;
-
 	pHalFunc->SetHalODMVarHandler = &rtl8723b_SetHalODMVar;
 
 	pHalFunc->xmit_thread_handler = &hal_xmit_handler;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 5dddafe035c2..da4215841773 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,9 +162,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
-
-	u8 (*Efuse_WordEnableDataWrite)(struct adapter *padapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest);
-
 	s32 (*xmit_thread_handler)(struct adapter *padapter);
 	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
 	void (*hal_reset_security_engine)(struct adapter *adapter);
diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index d6ea8a4a856f..669565fa1c69 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -96,7 +96,6 @@ u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data, bool	 bPseudo
 u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool	 bPseudoTest);
 
 void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  PwrState);
-u8 Efuse_WordEnableDataWrite(struct adapter *padapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest);
 
 u8 EFUSE_Read1Byte(struct adapter *padapter, u16 Address);
 void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
-- 
2.50.1


