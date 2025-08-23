Return-Path: <linux-kernel+bounces-783029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF48B32893
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA711AA1A63
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213D026A095;
	Sat, 23 Aug 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtOuupfr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29525C821
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953024; cv=none; b=f+XAuFb/bkah2MSZNWYXdt0h8eUtO8z3VAdU0X1HnlAYarnkdj6h6wi9/rgBtVouHlr7s4LvELl0RWuNQIEbyJFsM9vThUQnAYabzB32HD4eIg8xVOlof7CnTuzJ+3g67MWPIZRm7SXyRfLHPUDxobxk1bNDPrxIriEutJzf5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953024; c=relaxed/simple;
	bh=99WVo19afdz1JIRRG4oj49qBaDsrneCNsX5B1FHuSy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkcDPG55yoDXk5ax5dKrubDOPx6ZKCgK8QEUPOvDqEuWR1CGFdPvuc3C4uWuoeKnDcmAT7YISOU/T1mH5wipx4g3APAXd2yX7pmBJa9ItCmV2T0edwi/sMEZ3rUVHVsHPfVOmaiUYTcZ0DdMwrFCRN9f38yr5uqXgnrZsUmzGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtOuupfr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7acfde3so449094366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953020; x=1756557820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh3OTq9cM6mb9Y0x2jVB+Qtv+usV8rcusK90cvfpk5c=;
        b=TtOuupfr2B8vuDA2KVoQtvIr3Ve8oPgc+2v8l5CbR4+GkubBKKyTG6eBZ9oyGvg9Br
         Y6amyDCSzPiYJhkHOVplQ2DZa12udoU2sNhm8zUHYaaWEYAZVjw6CkmmXickJPwmHB/7
         CacPdTm+S44GnA1WacFUd0vnchdmw+A2aX24uucIP5JZtxO86rU/az+YrJ/eUou5Hcnh
         WhHurYFCF/D7lBBiHdixUm9qSG7eZ3o7eg2cz3VJ0eWpgI48udvUMn6/nbAN56tope97
         R+E+ye4k13OcbAMlKDqWSx4aBAar4uOfLEV4Zo6J+e8dG1KlyXpFa6QqJb2kD0ZgurFb
         IlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953020; x=1756557820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh3OTq9cM6mb9Y0x2jVB+Qtv+usV8rcusK90cvfpk5c=;
        b=sm6QGQaNfz0iOtRGpYgOrrlRUglsDiaGqjWNfyWq4DfhbQZ+3P848iTUpIRmo6W7DB
         WZcNp2/9PIQTSYsiyNwyp0u1pEdzXdan+YrPzI1Rn9NXMVCqFardJJnsEpBgx0gIOMk7
         kXrWwZSlSBa+nfo3v0KVylhT30Xj1OYaZzM0y2QHm0mVUiFlVxGpVtiyZth6yTqBI9Fu
         4IezyCJ7WCv6G1xDJgH4I/zYVB6wAKjMSb+ZNhqlZsTI1c9z5r4dwkqVn3jxi8HRT5jV
         9CHmqUlfFcpRhw/flH20w1wLTzSDSSUjnmf6vVG6/c8yQlAcni92keOLPCdJeP+QTl5z
         0SLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtPgIX0SquYIMecnl3JXxptwMXaN39l6Okyp+bNISETINIzlVqLeNKgL46QUjXsqtJ5qk6ZQbfXyD9wHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmwIz6AVk3+1EGf+rTyzcXHnIYNynIXplfQBkRf6naM1C1z2G
	zGsGaniapP6kV/N7hSEctwxrRbuRycs5SfURad7ckXkt2sMnqX66Pqng
X-Gm-Gg: ASbGncsgWPs1lv1Ly0/6PvbhiW7iwGCDj+ld8u8MP+24ZWe5DE03OG1DsW9JahxLeCs
	b7MUqwifzyCkBAb6bSAUDVUmlwJyBZ3n2CnBA9Y/XNDatjM/RYfcLN6JlQ6M13l37p1GVsEnn/l
	EPs+qJWnlXZdRYClnL4b6usSZrLpM2MkVfKZT/TYb7r5Z+bJFisJyLvQivyofD8oC6YuRAqDTAP
	rLryt1JdGFKtH8xt4PQGap2fXeQH+EVtAAYhRMFJex59KdelqW/ICeMDhDoR4eEs/tb6e1sz0en
	yAOcSxsj5whCy5LGSTqn09nPNFQyG7yAb6FAkbJqs/IvmbrNhHpGAAImSueGw5TK3aEuNxqrATR
	cHNsn85KUS8o9m21oMywDqWiE7+iIdFEDF9Rk
X-Google-Smtp-Source: AGHT+IE8n4m+meZknAuGPSp9YYvhKmxlh6lB/MpTdULlL3Gv7pr7EZXuT1CXGj7hXfxa41kGFnpMQA==
X-Received: by 2002:a17:907:728d:b0:afd:d9e3:9540 with SMTP id a640c23a62f3a-afe296b1f49mr523921366b.64.1755953020458;
        Sat, 23 Aug 2025 05:43:40 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:40 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/14] staging: rtl8723bs: remove bPseudoTest from hal_ReadEFuse_WiFi
Date: Sat, 23 Aug 2025 14:43:13 +0200
Message-ID: <20250823124321.485910-7-straube.linux@gmail.com>
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

The function hal_ReadEFuse_WiFi is always called with bPseudoTest set
to false. Remove the pPseudoTest parameter, replace its usage in the
function with false, and reomve resulting dead code to reduce code
complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 34 ++++++-------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 002648a8fd81..c40d447c04d2 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -669,14 +669,9 @@ static void hal_ReadEFuse_WiFi(
 	struct adapter *padapter,
 	u16 _offset,
 	u16 _size_byte,
-	u8 *pbuf,
-	bool bPseudoTest
+	u8 *pbuf
 )
 {
-#ifdef HAL_EFUSE_MEMORY
-	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
-	struct efuse_hal *pEfuseHal = &pHalData->EfuseHal;
-#endif
 	u8 *efuseTbl = NULL;
 	u16 eFuse_Addr = 0;
 	u8 offset, wden;
@@ -698,10 +693,10 @@ static void hal_ReadEFuse_WiFi(
 	memset(efuseTbl, 0xFF, EFUSE_MAX_MAP_LEN);
 
 	/*  switch bank back to bank 0 for later BT and wifi use. */
-	hal_EfuseSwitchToBank(padapter, 0, bPseudoTest);
+	hal_EfuseSwitchToBank(padapter, 0, false);
 
 	while (AVAILABLE_EFUSE_ADDR(eFuse_Addr)) {
-		efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, bPseudoTest);
+		efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, false);
 		if (efuseHeader == 0xFF)
 			break;
 
@@ -709,7 +704,7 @@ static void hal_ReadEFuse_WiFi(
 		if (EXT_HEADER(efuseHeader)) { /* extended header */
 			offset = GET_HDR_OFFSET_2_0(efuseHeader);
 
-			efuse_OneByteRead(padapter, eFuse_Addr++, &efuseExtHdr, bPseudoTest);
+			efuse_OneByteRead(padapter, eFuse_Addr++, &efuseExtHdr, false);
 			if (ALL_WORDS_DISABLED(efuseExtHdr))
 				continue;
 
@@ -728,10 +723,10 @@ static void hal_ReadEFuse_WiFi(
 			for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
 				/*  Check word enable condition in the section */
 				if (!(wden & (0x01<<i))) {
-					efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, bPseudoTest);
+					efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, false);
 					efuseTbl[addr] = efuseData;
 
-					efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, bPseudoTest);
+					efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, false);
 					efuseTbl[addr+1] = efuseData;
 				}
 				addr += 2;
@@ -746,19 +741,12 @@ static void hal_ReadEFuse_WiFi(
 		pbuf[i] = efuseTbl[_offset+i];
 
 	/*  Calculate Efuse utilization */
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total, bPseudoTest);
+	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total, false);
 	used = eFuse_Addr - 1;
 	efuse_usage = (u8)((used*100)/total);
-	if (bPseudoTest) {
-#ifdef HAL_EFUSE_MEMORY
-		pEfuseHal->fakeEfuseUsedBytes = used;
-#else
-		fakeEfuseUsedBytes = used;
-#endif
-	} else {
-		rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_BYTES, (u8 *)&used);
-		rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_USAGE, (u8 *)&efuse_usage);
-	}
+
+	rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_BYTES, (u8 *)&used);
+	rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_USAGE, (u8 *)&efuse_usage);
 
 	kfree(efuseTbl);
 }
@@ -887,7 +875,7 @@ void Hal_ReadEFuse(
 )
 {
 	if (efuseType == EFUSE_WIFI)
-		hal_ReadEFuse_WiFi(padapter, _offset, _size_byte, pbuf, false);
+		hal_ReadEFuse_WiFi(padapter, _offset, _size_byte, pbuf);
 	else
 		hal_ReadEFuse_BT(padapter, _offset, _size_byte, pbuf, false);
 }
-- 
2.51.0


