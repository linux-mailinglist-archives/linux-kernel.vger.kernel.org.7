Return-Path: <linux-kernel+bounces-783033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3371FB32897
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F903AD020
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A9026E71B;
	Sat, 23 Aug 2025 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzGPwrt1"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7226563F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953027; cv=none; b=ZEe6CVx5tMbjtoR2RIL0PfP+qZnYc+tY52Yv3UY602hzboYhHFtqGBqNn1smi96vsIvj7Cej/W/UMm8AG0CErbAfdQZssIV7vk30M4hXaz85TNzkb7b4f0Rnjq3H1GUV/TpiGaRTGBXcRCqW1I2hn1pn3BdQESk+QVF8uiB2cuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953027; c=relaxed/simple;
	bh=h6WCjiBW+6Abga5OJ3bJ1nYtqaNiePuXBUvjxd/SJ2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK8w/N2g4A8p61pgf1Omu74IkcJLCwV3XePxO151zuA1chn27G2cZpLXmVtsX4G/ijoDZr1EyBVqh1w8CokzsJ6VAinB8MKAZZrfSICup/wYhWCBu+RwoIz8M72nH1+P+D2Qv8KGPwIEwDLEZom0/aq+1ZYd/Jqa1VJHrozAqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzGPwrt1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7322da8so445824066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953023; x=1756557823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlbqi7N+RKHadOcJXN6QLsUwNa0JB43/lNVhOpXVRbM=;
        b=DzGPwrt1uCNnb5eRBHR3S/IqNorWPffqx2GINDYY7FAKIJ5EEYwAH7lVTiAAeoFp9j
         kz6QEw8s2vA2UVgIXMEsRzLVVKfMFA7+c42iFUyq2DU3FPCLf/TPDZbcSzGTy42hOmdu
         ElIeU01lM9aSUczcrFhJ9V4e3Y7MGJUoiPKhwn9u/rZ5UAM0Em+RMM+3MuQtceCcTlYp
         AyivYHt0Je/GHA6w/Zi9KNSZniR9ZUAk5VpILyRW3ZIZ3LdNfStS2gDh1xYaKE8j/lIB
         55maXRT2NhyAPSea76yW9uauTplN1X/fkXhGjAyHzqlXVA8u7xqEyaqp51wV9r1GBkYk
         bKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953023; x=1756557823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlbqi7N+RKHadOcJXN6QLsUwNa0JB43/lNVhOpXVRbM=;
        b=CUN5oemZCTFivN4S808xzXI93J6FdZfugwmejGC1Z5nYGdnlYoL8W/mXZ1Oi/gVMbJ
         z9SOHGqZXz5oms1TnLGUsl9btQelh8XlMBzF088K6bAGSjx8mONNL+8UufEX6w7fmp0h
         g5p2VLPEkuzvtYk1d8lwxFRLosLGXEmrvSuTvPBz23HzW9e4QZdNTitWEDplr9iICssW
         58VdTUtbVdrETqHylj/i4ExJzEiykUpu+/nKrabvOWSNtlAIYR3/+WO+q0aZ5BI5aVqx
         YUfhSn0MZofmwDNFoaUQeZ8gGe7rNSEcp4zg8w1g9py9LsHnL0yHDOd5oywLawDmIUqU
         plyg==
X-Forwarded-Encrypted: i=1; AJvYcCVTWOZb2IcOZQDeHxSvjrPBs+HlsVIws9MsWx8DBP5HfjHAGFjcrBXW+yojm5uqhnOKQP3zEa5E6H7gIrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSf+kl+S0kXF7+IcworeNi1kFqKfIin/kFq2fXmoytFX5nsKxr
	C1aBMjP129v0g9oHWn83/4qAhCVI556t/IO2OJrVnnxHqPPqMSC44R97OEq+xA==
X-Gm-Gg: ASbGncu7Q//p9ju+xHRr7cq7m5lrEfGhzQn5D9q7iiZjvXSi2NWEYdHcizcQ4F7Z0VC
	qT8JKtQ7C6GYLWTniiD0LA8UmY6/8faRRkzp370Ft4w1KtpXm3efjZhQR4elZT6bgEF8VMJVsnQ
	hpEIZX3O39kTQ+/ba+4x94dCHlgvk2qm+ovS2s7gbtscurdxEClvPZkb/sKjux0EI/az7M+uIe8
	+WgAh0Wcfq0IAAFnuJo2zmm+PDbjm5N55EvU8hzAom8J7QUr5nSTE0Zh4+u3aU5uJa2DMKeAjZY
	8HpFnfG6yG/QrTPxBX3hkCNjKfIdr6ZG5JZmzc9iY6ILEj+vsdSgdaNv+7x/xovd9t2gN02OsRe
	EX9mABrkC8iBiSLLfrhF5DACiFQ==
X-Google-Smtp-Source: AGHT+IFEWdtvLaf9Gdw4oi4jZxvxE286Zlt9Kn5xDdd7umB2HylCgAGuay9Q64yUjphtsNAfkce+7A==
X-Received: by 2002:a17:907:94cf:b0:af9:c1f7:802 with SMTP id a640c23a62f3a-afe295d2502mr640932766b.31.1755953023059;
        Sat, 23 Aug 2025 05:43:43 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:42 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/14] staging: rtl8723bs: remove Hal_EfuseGetCurrentSize
Date: Sat, 23 Aug 2025 14:43:17 +0200
Message-ID: <20250823124321.485910-11-straube.linux@gmail.com>
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

The function Hal_EfuseGetCurrentSize is not used in the driver code,
remove it to get rid of dead code. As Hal_EfuseGetCurrentSize is the only
caller of hal_EfuseGetCurrentSize_WiFi and hal_EfuseGetCurrentSize_BT we
can remove these two functions as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 184 ------------------
 drivers/staging/rtl8723bs/include/hal_intf.h  |   1 -
 2 files changed, 185 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index af61730cff14..0679f77e3498 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -867,190 +867,6 @@ void Hal_ReadEFuse(
 		hal_ReadEFuse_BT(padapter, _offset, _size_byte, pbuf);
 }
 
-static u16 hal_EfuseGetCurrentSize_WiFi(
-	struct adapter *padapter, bool bPseudoTest
-)
-{
-#ifdef HAL_EFUSE_MEMORY
-	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
-	struct efuse_hal *pEfuseHal = &pHalData->EfuseHal;
-#endif
-	u16 efuse_addr = 0;
-	u16 start_addr = 0; /*  for debug */
-	u8 hworden = 0;
-	u8 efuse_data, word_cnts = 0;
-	u32 count = 0; /*  for debug */
-
-
-	if (bPseudoTest) {
-#ifdef HAL_EFUSE_MEMORY
-		efuse_addr = (u16)pEfuseHal->fakeEfuseUsedBytes;
-#else
-		efuse_addr = (u16)fakeEfuseUsedBytes;
-#endif
-	} else
-		rtw_hal_get_hwreg(padapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
-
-	start_addr = efuse_addr;
-
-	/*  switch bank back to bank 0 for later BT and wifi use. */
-	hal_EfuseSwitchToBank(padapter, 0, bPseudoTest);
-
-	count = 0;
-	while (AVAILABLE_EFUSE_ADDR(efuse_addr)) {
-		if (efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest) == false)
-			goto error;
-
-		if (efuse_data == 0xFF)
-			break;
-
-		if ((start_addr != 0) && (efuse_addr == start_addr)) {
-			count++;
-
-			efuse_data = 0xFF;
-			if (count < 4) {
-				/*  try again! */
-
-				if (count > 2) {
-					/*  try again form address 0 */
-					efuse_addr = 0;
-					start_addr = 0;
-				}
-
-				continue;
-			}
-
-			goto error;
-		}
-
-		if (EXT_HEADER(efuse_data)) {
-			efuse_addr++;
-			efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest);
-			if (ALL_WORDS_DISABLED(efuse_data))
-				continue;
-
-			hworden = efuse_data & 0x0F;
-		} else {
-			hworden = efuse_data & 0x0F;
-		}
-
-		word_cnts = Efuse_CalculateWordCnts(hworden);
-		efuse_addr += (word_cnts*2)+1;
-	}
-
-	if (bPseudoTest) {
-#ifdef HAL_EFUSE_MEMORY
-		pEfuseHal->fakeEfuseUsedBytes = efuse_addr;
-#else
-		fakeEfuseUsedBytes = efuse_addr;
-#endif
-	} else
-		rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
-
-	goto exit;
-
-error:
-	/*  report max size to prevent write efuse */
-	Hal_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &efuse_addr);
-
-exit:
-
-	return efuse_addr;
-}
-
-static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
-{
-#ifdef HAL_EFUSE_MEMORY
-	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
-	struct efuse_hal *pEfuseHal = &pHalData->EfuseHal;
-#endif
-	u16 btusedbytes;
-	u16 efuse_addr;
-	u8 bank, startBank;
-	u8 hworden = 0;
-	u8 efuse_data, word_cnts = 0;
-	u16 retU2 = 0;
-
-	if (bPseudoTest) {
-#ifdef HAL_EFUSE_MEMORY
-		btusedbytes = pEfuseHal->fakeBTEfuseUsedBytes;
-#else
-		btusedbytes = fakeBTEfuseUsedBytes;
-#endif
-	} else
-		rtw_hal_get_hwreg(padapter, HW_VAR_EFUSE_BT_BYTES, (u8 *)&btusedbytes);
-
-	efuse_addr = (u16)((btusedbytes%EFUSE_BT_REAL_BANK_CONTENT_LEN));
-	startBank = (u8)(1+(btusedbytes/EFUSE_BT_REAL_BANK_CONTENT_LEN));
-
-	Hal_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &retU2);
-
-	for (bank = startBank; bank < 3; bank++) {
-		if (hal_EfuseSwitchToBank(padapter, bank, bPseudoTest) == false)
-			/* bank = EFUSE_MAX_BANK; */
-			break;
-
-		/*  only when bank is switched we have to reset the efuse_addr. */
-		if (bank != startBank)
-			efuse_addr = 0;
-
-		while (AVAILABLE_EFUSE_ADDR(efuse_addr)) {
-			if (efuse_OneByteRead(padapter, efuse_addr,
-					      &efuse_data, bPseudoTest) == false)
-				/* bank = EFUSE_MAX_BANK; */
-				break;
-
-			if (efuse_data == 0xFF)
-				break;
-
-			if (EXT_HEADER(efuse_data)) {
-				efuse_addr++;
-				efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest);
-
-				if (ALL_WORDS_DISABLED(efuse_data)) {
-					efuse_addr++;
-					continue;
-				}
-
-				hworden = efuse_data & 0x0F;
-			} else {
-				hworden =  efuse_data & 0x0F;
-			}
-
-			word_cnts = Efuse_CalculateWordCnts(hworden);
-			/* read next header */
-			efuse_addr += (word_cnts*2)+1;
-		}
-
-		/*  Check if we need to check next bank efuse */
-		if (efuse_addr < retU2)
-			break; /*  don't need to check next bank. */
-	}
-
-	retU2 = ((bank-1)*EFUSE_BT_REAL_BANK_CONTENT_LEN)+efuse_addr;
-	if (bPseudoTest) {
-		pEfuseHal->fakeBTEfuseUsedBytes = retU2;
-	} else {
-		pEfuseHal->BTEfuseUsedBytes = retU2;
-	}
-
-	return retU2;
-}
-
-u16 Hal_EfuseGetCurrentSize(
-	struct adapter *padapter, u8 efuseType, bool bPseudoTest
-)
-{
-	u16 ret = 0;
-
-	if (efuseType == EFUSE_WIFI)
-		ret = hal_EfuseGetCurrentSize_WiFi(padapter, bPseudoTest);
-	else
-		ret = hal_EfuseGetCurrentSize_BT(padapter, bPseudoTest);
-
-	return ret;
-}
-
 static struct hal_version ReadChipVersion8723B(struct adapter *padapter)
 {
 	u32 value32;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index fbf0b01780ea..4fe48cccb889 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -270,6 +270,5 @@ void Hal_ReadEFuse(struct adapter *padapter, u8 efuseType, u16 _offset,
 		   u16 _size_byte, u8 *pbuf);
 void Hal_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type,
 			    void *pOut);
-u16 Hal_EfuseGetCurrentSize(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
 void hal_notch_filter_8723b(struct adapter *adapter, bool enable);
 #endif /* __HAL_INTF_H__ */
-- 
2.51.0


