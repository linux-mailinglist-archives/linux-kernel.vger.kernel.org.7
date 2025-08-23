Return-Path: <linux-kernel+bounces-783030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A4BB32894
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8B4AA1BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A19626A0DB;
	Sat, 23 Aug 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIDR+w35"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427825E448
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953024; cv=none; b=XvbnhrHA+was2Gj2zbPLiVhLcp8LpDwkGbjUXW5/dicno256AvbFh9v1HOvuR75i9g3Orz82iBuWUEFDqLyVkU1HcSg9KvrHtOqehlresi4u/FxQiGp13w6HzXtBjXLxPgOSXhwiylLTVx3tMx0CIyqIfP0xKamru5Qk+omEtic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953024; c=relaxed/simple;
	bh=XYDT8ZOTnQxbxYmv/f6mFEmi+5cv/e0YHVfg05WEN7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiZCxz/LtlOMTlJCKGAGKIdPGml/WqheQPDOtegiUlFw3aRSIXagL0Dh1zhK07295w2bFa5J4GzVxCuVqS4VAUl0ij1XCdb3Q0Ja+0ISt0FYx6iTHFsfCNBxRrEVBxREZSksf2kB9AL6MKZ75/AgakYFFpWe3/nmtR9M9Bptpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIDR+w35; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb72d51dcso397998866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953021; x=1756557821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8yurgLbPr3IHtTft2ct/QRPqVcIbgbSyThd3cfoEIM=;
        b=OIDR+w35hSMvxOo5QZgGL5YzYtcRqAu6OKs5eoO8SqBlhZ4DRLWFZvYih1V5KbJfUq
         /5E3VaLTaRLluLyax8MmIsiXwOCXTTisw3aUuG/bSaJ27hKrnjaTdxtcbJy/7BjcYunz
         OmT38qb2G1sAQ6ZStgaV+1ebEdcuaI72zFpKjyBLqREAIWCln5zFRk54cwZoPwD3D9/r
         K8jsShQO+CwhGTjV0FJIZuKJta1arN7Q2VCUdUh9q2oPPN8hLJ6V53t6Fb1M0RWDF2OF
         tRzgLyfxqJtMIW6uhoGLzfuOvaK1c7lSLvdXqATFxlMCXeV9gxSBvd9dyIXngugpB8Iy
         5xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953021; x=1756557821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8yurgLbPr3IHtTft2ct/QRPqVcIbgbSyThd3cfoEIM=;
        b=cre9ZjF2g42WODgexRrHfK+K7sV0Kw/Zr4w5/xMJcI92NJPYS9ztuCveqOHgT3dpjU
         K6tTAcdUgDlBIOKlhhDRlkNcHafppvScM3lgi1rv8QDFn7UogzbaqIQP7cwdpknKwxHo
         O+E0ns/Gm6eblJ6wUpO5/kgdy3381T6XjxBHXMvtYcVDzmJCe/XkEj4ihniNMNUeV9CA
         aGlNB7TyCuW52BK3CliLBIotMXx+Z+KJc5Zrfl193rGz7MPxNGPFAdQsGVpcoYUQccTZ
         00DSTE4NOvtGasdgS2TFPZda0iOKCnE7yEn8PkAyMS0JIepE6QiW7vb0DJ52+FcqbdZY
         pMlA==
X-Forwarded-Encrypted: i=1; AJvYcCURJbRSKr6alqvBybBMA0ppgTlhqKRv2RA+uOc6DUPNzumgDD+VYUWl9BJlUN14PD3REwpMe8nsYquG08E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnp8olh8q6B59DAObYPJwNptOXKPPpesOftaEjSjvvYlgwgpLb
	rXFWPiwhTlIrPeGDi9948HE7vXUf8UsAMjG4w0XMRwcmKQgB7otCkGkQX+4fUQ==
X-Gm-Gg: ASbGncvEL5EYaCBCWVSDvOebzEmneskkvgb6OqpgT34fg2b7nT2tn2ZpFd6FTo9mciX
	7IoN79hTsSteqW5Nr8geV7ElEKNRZITLNFFDYzZ9AzkTq2QuT4RXYCEbiMywQiXdsKwxCgzPB2z
	AGK9e7tbaGPZn/Mxu0Z+OZb03wLPghajZmN6//512lvcFWNd4vIU9UEBWPI5i7Jb7MkZ9NgCntt
	o8eBePi6E35vge33e2faJmT1xaCrTDHfP5jt6nujjw79b4XdlZUU+ltdS7c2CBFVBAfNNRCZPGC
	RNt5rRg5AC+xkHUGu3BQoyV01d7HGHaCU34cZNJ3XxFeJ8xv00I/xWv3XzO16JI6rqWdeQQ2BQY
	5IKgEIR7JJc4FbiuXALEWBlQNSA==
X-Google-Smtp-Source: AGHT+IHAzv1MMgc0gFfWXhwPq/A8HO45MupcnjPCPrRmtfDqTvL16u2WrA1HnUyNcdS27dCv2oYpNA==
X-Received: by 2002:a17:907:972a:b0:afd:d62f:939 with SMTP id a640c23a62f3a-afe29047b3emr565020366b.36.1755953021120;
        Sat, 23 Aug 2025 05:43:41 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:40 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/14] staging: rtl8723bs: remove bPseudoTest from hal_ReadEFuse_BT
Date: Sat, 23 Aug 2025 14:43:14 +0200
Message-ID: <20250823124321.485910-8-straube.linux@gmail.com>
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

The function hal_ReadEFuse_BT is always called with bPseudoTest set
to false. Remove the pPseudoTest parameter, replace its usage in the
function with false, and reomve resulting dead code to reduce code
complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 38 +++++++------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index c40d447c04d2..fe6a3dd84aca 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -755,14 +755,9 @@ static void hal_ReadEFuse_BT(
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
 	u8 *efuseTbl;
 	u8 bank;
 	u16 eFuse_Addr;
@@ -785,16 +780,16 @@ static void hal_ReadEFuse_BT(
 	/*  0xff will be efuse default value instead of 0x00. */
 	memset(efuseTbl, 0xFF, EFUSE_BT_MAP_LEN);
 
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &total, bPseudoTest);
+	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &total, false);
 
 	for (bank = 1; bank < 3; bank++) { /*  8723b Max bake 0~2 */
-		if (hal_EfuseSwitchToBank(padapter, bank, bPseudoTest) == false)
+		if (hal_EfuseSwitchToBank(padapter, bank, false) == false)
 			goto exit;
 
 		eFuse_Addr = 0;
 
 		while (AVAILABLE_EFUSE_ADDR(eFuse_Addr)) {
-			efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, bPseudoTest);
+			efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, false);
 			if (efuseHeader == 0xFF)
 				break;
 
@@ -802,7 +797,7 @@ static void hal_ReadEFuse_BT(
 			if (EXT_HEADER(efuseHeader)) { /* extended header */
 				offset = GET_HDR_OFFSET_2_0(efuseHeader);
 
-				efuse_OneByteRead(padapter, eFuse_Addr++, &efuseExtHdr, bPseudoTest);
+				efuse_OneByteRead(padapter, eFuse_Addr++, &efuseExtHdr, false);
 				if (ALL_WORDS_DISABLED(efuseExtHdr))
 					continue;
 
@@ -820,10 +815,10 @@ static void hal_ReadEFuse_BT(
 				for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
 					/*  Check word enable condition in the section */
 					if (!(wden & (0x01<<i))) {
-						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, bPseudoTest);
+						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, false);
 						efuseTbl[addr] = efuseData;
 
-						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, bPseudoTest);
+						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, false);
 						efuseTbl[addr+1] = efuseData;
 					}
 					addr += 2;
@@ -839,7 +834,7 @@ static void hal_ReadEFuse_BT(
 	}
 
 	/*  switch bank back to bank 0 for later BT and wifi use. */
-	hal_EfuseSwitchToBank(padapter, 0, bPseudoTest);
+	hal_EfuseSwitchToBank(padapter, 0, false);
 
 	/*  Copy from Efuse map to output pointer memory!!! */
 	for (i = 0; i < _size_byte; i++)
@@ -848,19 +843,12 @@ static void hal_ReadEFuse_BT(
 	/*  */
 	/*  Calculate Efuse utilization. */
 	/*  */
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total, bPseudoTest);
+	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total, false);
 	used = (EFUSE_BT_REAL_BANK_CONTENT_LEN*(bank-1)) + eFuse_Addr - 1;
 	efuse_usage = (u8)((used*100)/total);
-	if (bPseudoTest) {
-#ifdef HAL_EFUSE_MEMORY
-		pEfuseHal->fakeBTEfuseUsedBytes = used;
-#else
-		fakeBTEfuseUsedBytes = used;
-#endif
-	} else {
-		rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_BT_BYTES, (u8 *)&used);
-		rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_BT_USAGE, (u8 *)&efuse_usage);
-	}
+
+	rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_BT_BYTES, (u8 *)&used);
+	rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_BT_USAGE, (u8 *)&efuse_usage);
 
 exit:
 	kfree(efuseTbl);
@@ -877,7 +865,7 @@ void Hal_ReadEFuse(
 	if (efuseType == EFUSE_WIFI)
 		hal_ReadEFuse_WiFi(padapter, _offset, _size_byte, pbuf);
 	else
-		hal_ReadEFuse_BT(padapter, _offset, _size_byte, pbuf, false);
+		hal_ReadEFuse_BT(padapter, _offset, _size_byte, pbuf);
 }
 
 static u16 hal_EfuseGetCurrentSize_WiFi(
-- 
2.51.0


