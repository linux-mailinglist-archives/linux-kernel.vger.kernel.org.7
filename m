Return-Path: <linux-kernel+bounces-783032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BA4B32898
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A985E1BC6E03
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A7226CE0A;
	Sat, 23 Aug 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIBvGHGm"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259222641CA
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953026; cv=none; b=blxDw14YQ6wGfA2JLk6MWqhK//A//65ZrTfrc+OTKZNvwOEOzhaMt0DPzk+DekrkreloROmcfsXh82G1RnH3o9WdlSKqbVXhvRjyIBMK+IMwKExB7LufATCWwWHsucOV23INYsSCCF+aP7od5WEufMvPA1JhvVC052WNnfE2MiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953026; c=relaxed/simple;
	bh=yKqwH5a6Nz+pa77SkUNK6+bxeAf7vNAaaZiTcMwKWHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irgP+Bb3QrlD+TBzV0wqR9cDYUNCvVHqzNWhSn2UteabH7fzugJCt6M+85T/rV75fLLesYHx/3IVqRhGW0MGSZi6EWaPG7isDzoWe/8X3Blo0tHjfzJy3wrg6y3J0BBDsJRN6HUX1oQ1J6HZKP6I2f/1kae2n4rA8JZ+YCl8ECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIBvGHGm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb78da8a7so448941466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953022; x=1756557822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzIetETHYWHivxrw/pp5DLuF943UAIx59/qdlutf55Y=;
        b=JIBvGHGmFKvYxUizSHEcOiNrPp0k1SiwzpnTuGMBx69EP2vL4u+GB0QbjFEi9KoLiX
         pgzbJDSPycRAzNEFb/Jjs/LB8QXPQQZNgCWywVxOYUx4seBQLwwQXTJTUKXHWcWbzque
         dblPwntJRF9ab/SeWBVTw/CD4S8VNSyg3dBjoXzgFUHMsXiPdiiDG5umY1V0KLw9scHU
         Coxu82sEfxg5WY9maM2C5CZuikBqWont0utZJeEnId0XgISqILYZN/1DA5rHnkB/Gpim
         bPAQwJcmSPQdifS37geLXDd/sFbu3Kvn1GF2rR7Y4WMte+u56CUB2CtFcRXzoA484x2a
         GbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953022; x=1756557822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzIetETHYWHivxrw/pp5DLuF943UAIx59/qdlutf55Y=;
        b=lChu0BK5/OixADMXaHQ58M5k9xTnDQbzdkq7R8KPMQUQ/lqN5HSUDuoG1/aUTvaYCB
         MnMhjYusirGVE/LSgpFINzmEVBgIbRYwCBtFzFWRka5GN1E257kSWOFRFhVCvYAT1DZT
         55rHqPwLUjPwbEPq1IU/G7LKiHHTmbu1SNdIGUsfCx39ztu3QafcvceWYCExWaPHGFXm
         2RW2bKzt1jzGvzHCKw88VrnVAukvtlnq9uGDHi4E1UQkI/gAPZ3m8p+y2RnClovCLrA8
         /YrwaocxVjU8QfBL6Wm+us4uFIViwbnX8Q3gZVu6ZxKpBcqKq46fEN+hx+UKAwzz1gFE
         TKcg==
X-Forwarded-Encrypted: i=1; AJvYcCVXjNFbh/FqffA3E5H0fLWWomdINQR93XLJBKOTPg8IaIuKazCEquaupnKW06QFRgScuoZauSpxOqI7sO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOsVnZHklGZmyV1fyv0P+9v9VB/YP1rhcz2Ko+N4y2MBh6rS36
	WDyfL6xL36ZKpy0bo9Sxsjqmmt04yt1GBywbDyjcF5MidcOVqELCZL+J
X-Gm-Gg: ASbGncvybqqRO1UOY0XeKQ/XCJf4oGvqwBYMiDdMzLOLV0lgPTQoiODqBgBqdCzmn8b
	QpR95EGSfd25AqJnRFLKTe56sBsOy1GXifFaR828uktad+34FqcwqpHZV3EAlQ38jdemT0SK1dU
	2tp9cjjCmcbJ/hdpRmnxELU79LCG0ZQYQ3mkAtjeX5aMQmcBUbZiJnA4lXP9J0I2koOJKDQM9fX
	6w+RthdHP6f4LI+Q5CEgvGkgT7T4IljycFEUGA9HYg/2cumfVP8Nb92pz0jBvso0o6g3WZmj9hD
	L1r43wwClQySMsGHXZrXFOlyPJQe0Q0QZjMpsOfz1sg4HFFp+a8suUmYEkwRLbOmpVQYccp+G8M
	ImRt6/7bwOgTgU48b2FUd7PCEZg==
X-Google-Smtp-Source: AGHT+IGoWn0EzUfWZg7qbR8GjlLBISJjayqiLGwRwZ01kRQx/zgS9Ft3sPxThIfe1JhSI6idF2vlyg==
X-Received: by 2002:a17:907:1b29:b0:afa:1b3f:37a2 with SMTP id a640c23a62f3a-afe295d2b84mr583479466b.37.1755953022331;
        Sat, 23 Aug 2025 05:43:42 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:42 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/14] staging: rtl8723bs: remove bPseudoTest from Hal_GetEfuseDefinition
Date: Sat, 23 Aug 2025 14:43:16 +0200
Message-ID: <20250823124321.485910-10-straube.linux@gmail.com>
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

The bPseudoTEst parameter is not used in Hal_GetEfuseDefinition. Remove the
unused parameter and adjust the function calls.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c        |  6 +++---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 13 ++++++-------
 drivers/staging/rtl8723bs/include/hal_intf.h      |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 25ec7278b815..9d065721c28a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -123,7 +123,7 @@ u16		Address)
 	u32 k = 0;
 	u16 contentLen = 0;
 
-	Hal_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
+	Hal_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen);
 
 	if (Address < contentLen) {/* E-fuse 512Byte */
 		/* Write E-fuse Register address bit0~7 */
@@ -257,7 +257,7 @@ static void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse)
 
 	Efuse_PowerSwitch(padapter, false, true);
 
-	Hal_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
+	Hal_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen);
 
 	Hal_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse);
 
@@ -333,7 +333,7 @@ void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType)
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 	u16 mapLen = 0;
 
-	Hal_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
+	Hal_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen);
 
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 5355bb80b676..af61730cff14 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -494,8 +494,7 @@ void Hal_GetEfuseDefinition(
 	struct adapter *padapter,
 	u8 efuseType,
 	u8 type,
-	void *pOut,
-	bool bPseudoTest
+	void *pOut
 )
 {
 	switch (type) {
@@ -741,7 +740,7 @@ static void hal_ReadEFuse_WiFi(
 		pbuf[i] = efuseTbl[_offset+i];
 
 	/*  Calculate Efuse utilization */
-	Hal_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total, false);
+	Hal_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total);
 	used = eFuse_Addr - 1;
 	efuse_usage = (u8)((used*100)/total);
 
@@ -780,7 +779,7 @@ static void hal_ReadEFuse_BT(
 	/*  0xff will be efuse default value instead of 0x00. */
 	memset(efuseTbl, 0xFF, EFUSE_BT_MAP_LEN);
 
-	Hal_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &total, false);
+	Hal_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &total);
 
 	for (bank = 1; bank < 3; bank++) { /*  8723b Max bake 0~2 */
 		if (hal_EfuseSwitchToBank(padapter, bank, false) == false)
@@ -843,7 +842,7 @@ static void hal_ReadEFuse_BT(
 	/*  */
 	/*  Calculate Efuse utilization. */
 	/*  */
-	Hal_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total, false);
+	Hal_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total);
 	used = (EFUSE_BT_REAL_BANK_CONTENT_LEN*(bank-1)) + eFuse_Addr - 1;
 	efuse_usage = (u8)((used*100)/total);
 
@@ -952,7 +951,7 @@ static u16 hal_EfuseGetCurrentSize_WiFi(
 
 error:
 	/*  report max size to prevent write efuse */
-	Hal_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &efuse_addr, bPseudoTest);
+	Hal_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &efuse_addr);
 
 exit:
 
@@ -984,7 +983,7 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 	efuse_addr = (u16)((btusedbytes%EFUSE_BT_REAL_BANK_CONTENT_LEN));
 	startBank = (u8)(1+(btusedbytes/EFUSE_BT_REAL_BANK_CONTENT_LEN));
 
-	Hal_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &retU2, bPseudoTest);
+	Hal_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &retU2);
 
 	for (bank = startBank; bank < 3; bank++) {
 		if (hal_EfuseSwitchToBank(padapter, bank, bPseudoTest) == false)
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 2e97a918445c..fbf0b01780ea 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -269,7 +269,7 @@ void Hal_EfusePowerSwitch(struct adapter *padapter, u8 bWrite, u8 PwrState);
 void Hal_ReadEFuse(struct adapter *padapter, u8 efuseType, u16 _offset,
 		   u16 _size_byte, u8 *pbuf);
 void Hal_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type,
-			    void *pOut, bool bPseudoTest);
+			    void *pOut);
 u16 Hal_EfuseGetCurrentSize(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
 void hal_notch_filter_8723b(struct adapter *adapter, bool enable);
 #endif /* __HAL_INTF_H__ */
-- 
2.51.0


