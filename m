Return-Path: <linux-kernel+bounces-783025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB24B3288F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6280EAA18B8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3403C25E814;
	Sat, 23 Aug 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlstgTwf"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C328241668
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953022; cv=none; b=XtenpcoRF2Wu+XaVCDiyXEzWDHFwFm5txweGt0vmwI0KcUZ8ir6lr4tWdAt9Rg2QF1bPAY1TU0cKKn7CTBc3PEjVpf220pqL0m2NzsTRO8KdDGKFKz68z7jYnYGpKm1mEOz5DYDnkA4BzvVgOWaAYZibqsgayvIHigDFSRRNnxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953022; c=relaxed/simple;
	bh=nznVPVV1oW8RI0ysSjFO0IF3ye9S9TcnQ8RsmxBEwJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLEUs10ZFmFuj10AkRBu5+U+d7T5ym1euUmivi23v918LPhzpcztdWz1IqzEfjWZygGfj+Yg2E+BnBzcTm/UJlro8TzKYdTwfWMb//eZBVFv0gCIxwODtP+0Fd3+uuI2S3mXBH5wl4OsR3nofsUV8wTF1+MnhBTqZp8CTGnQmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlstgTwf; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb61f6044so555329866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953017; x=1756557817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Z2TZ8sXO8/N8zS0gdcv8jeOIWY2VQYSICdu1a/1qRE=;
        b=DlstgTwfwZyIk4S5ILnEoPmGLvoyB5RrfFefANEM+XudEHxTz7fZ6xjq18y+rxNHaP
         TQw7Jm+t4ZrF/exQt4F8Wnupn/T4gpZhcnx6lLFu5aoyLgfgwVaxpRnAaL2XyWBjTS7L
         cM7p26nFRZW/1bG+r5AUNzoanS9mg99eP65QqaHeLCKckwM/MmonJ9xr6B/6N8JxJB6g
         5yjTwbjSQA/HXIyUXPaHINrYaHG8c+NUKd5c4hp2KLGGNwVT00cuNGP0z9YlosykuYH1
         68o+o9/iKPAMFL8Lru5MzVzIemiZeNfbnSPChGjB6ow7x/Gv3dTf4uGDYP290txX46Ux
         S/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953017; x=1756557817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Z2TZ8sXO8/N8zS0gdcv8jeOIWY2VQYSICdu1a/1qRE=;
        b=kFSXJJGC3yivDV1tWOcFjP7tJIrrGCTg9Gyvie4eeznh4rO+S+d/uBFI+gkN3PIEC3
         2KRW2uTd8ANuc7jd6VfWLgHYvvAN3FiGa1CJ1uhNDZUL3Q+lGtU97ngYFKR46KIOmmGk
         BW4F7ruv0GvTAHM36c8hlZVpCcK+WOHgYuFbaiexhTq/+ruDTlLlZlOx66ev3oHxetWN
         4EJS92pAMtI+h7+QXB0VKSeTVnQxoTsWZfU10JyRo0zDZjp0k9W8RLcEQHvbV6geWbNY
         SZXImFKRgIDyY8X3JIyG+dc6Uw3nQETtYbri1ee5Y5f441aegjgH2ke7a81Ipx0h1AXX
         Rw1w==
X-Forwarded-Encrypted: i=1; AJvYcCV46+Qeb0boG4hFgCRHeiECRWvSflPz7rQ50jLkx+HIWLV8hWmxR0J3j8vhrp+jb97gNoL1UIBiBR4n/As=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXogNeHF+HZAof87+/TLYVmkAI9fFpmBOKWJc22mTvVIAHDEGL
	XlqKXbg1aaOX3HrzRxj8PTMotfgfU5TmLDvq+YT+WJWns2jxaYd2G7r6
X-Gm-Gg: ASbGncswdGEsot1FPmR/j1D80IHEMm+6RWI5UOTouQrvyKrvFuDfNO8JyeCACVjrz8g
	OD+rSnlYFFSZWZ9u2nXiPnhzfO8iFzQVeeX1x4f4GLZ/Sp3YrzGcZbmQtiO6O96km1jys1LLFau
	3iKe6cCmYokMgbN+9qQeZiQFIzT5FCBkkak/xqUI9F/BFiIwM0XGR+zLjfkf4/5UhkQKiERXenB
	uJg6droWuk5rzEDHoXQL6vh4DeCVYld5Nnqc8vVVBQZsiXoJ5NePSTRN+kzfy01lxjtKuJeqCzF
	3GxvRst7JZg6mrCbkusMDQdN/E3sJanY4yG4D96lGTS7Xbq638W00g6LBcXWS2hoVNZ1y8vyFzc
	RAkQJenGZM0n5BjWkq/qC7fQyug==
X-Google-Smtp-Source: AGHT+IHRpKv/D9CHOevfjwnioo0z/Iv1Zr9GBpRkzn1JcjAQVLITUj5WgDhgpwI81f4cG+vFjTQnaw==
X-Received: by 2002:a17:906:c145:b0:afd:eb4f:d5cc with SMTP id a640c23a62f3a-afe0b4ade1fmr866551266b.31.1755953017336;
        Sat, 23 Aug 2025 05:43:37 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:37 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/14] staging: rtl8723bs: remove bPseudoTest from EFUSE_ShadowMapUpdate
Date: Sat, 23 Aug 2025 14:43:08 +0200
Message-ID: <20250823124321.485910-2-straube.linux@gmail.com>
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

The function EFUSE_ShadowMapUpdate is always called with bPseudoTest set
to false. Remove the pPseudoTest parameter and replace its usage in the
function with false to reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c        | 6 +++---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 ++--
 drivers/staging/rtl8723bs/include/rtw_efuse.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 208373113a62..d28298fa2853 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -386,17 +386,17 @@ static void efuse_ShadowRead4Byte(struct adapter *padapter, u16 Offset, u32 *Val
  * 11/13/2008	MHC		Create Version 0.
  *
  */
-void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bPseudoTest)
+void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 	u16 mapLen = 0;
 
-	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, bPseudoTest);
+	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
 	else
-		Efuse_ReadAllMap(padapter, efuseType, pEEPROM->efuse_eeprom_data, bPseudoTest);
+		Efuse_ReadAllMap(padapter, efuseType, pEEPROM->efuse_eeprom_data, false);
 
 	/* PlatformMoveMemory((void *)&pHalData->EfuseMap[EFUSE_MODIFY_MAP][0], */
 	/* void *)&pHalData->EfuseMap[EFUSE_INIT_MAP][0], mapLen); */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 1608bc71bd71..4a0423182f9e 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1438,12 +1438,12 @@ void Hal_InitPGData(struct adapter *padapter, u8 *PROMContent)
 	if (!pEEPROM->bautoload_fail_flag) { /*  autoload OK. */
 		if (!pEEPROM->EepromOrEfuse) {
 			/*  Read EFUSE real map to shadow. */
-			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
+			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI);
 			memcpy((void *)PROMContent, (void *)pEEPROM->efuse_eeprom_data, HWSET_MAX_SIZE_8723B);
 		}
 	} else {/* autoload fail */
 		if (!pEEPROM->EepromOrEfuse)
-			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
+			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI);
 		memcpy((void *)PROMContent, (void *)pEEPROM->efuse_eeprom_data, HWSET_MAX_SIZE_8723B);
 	}
 }
diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index 669565fa1c69..7bc8de3af1f9 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -98,7 +98,7 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool	 bPseudo
 void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  PwrState);
 
 u8 EFUSE_Read1Byte(struct adapter *padapter, u16 Address);
-void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
+void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType);
 void EFUSE_ShadowRead(struct adapter *padapter, u8 Type, u16 Offset, u32 *Value);
 void Rtw_Hal_ReadMACAddrFromFile(struct adapter *padapter);
 u32 Rtw_Hal_readPGDataFromConfigFile(struct adapter *padapter);
-- 
2.51.0


