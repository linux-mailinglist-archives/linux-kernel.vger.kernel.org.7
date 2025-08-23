Return-Path: <linux-kernel+bounces-783036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B17AFB3289F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEDE1C27599
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2157E273D8A;
	Sat, 23 Aug 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6NM5SkV"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8077D26CE36
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953029; cv=none; b=u5W+3Mc55qj93MCURPigpTm7Wg2ZbTRBx6GrZX3tx2rtVg+XUBoS0zhnRDLLzeelqyCL6TkDOm1XJX8DyTSHyFoZ7wGExQ0N4vPG9Pj8FeNAjyQsi1qyzu3VzNokXFq6sbs15IL9sq0no2c6NBVq3L+8xUmG5VvUSgMfXcF2dfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953029; c=relaxed/simple;
	bh=6TMKFvsgcOmBT4IWHGPu6ltkEHCP9W2kyxfMooXoo04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5J52goMR146R1awtxYzlPePzW7ihiWHCdQbK+dJxs6fzOfzxS/+Vss4M/1v2eIRqWlo5UDilMZo3GpLdGmfF8JjEitBCoVUGf2ECK5FqEWU0L/CVX0MAtJF7GZqwgvY/0i8a2LQM4IiahqL0WNDzYdn0fuLS57FOLgJXjF3iPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6NM5SkV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7abfc5cso466893366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953026; x=1756557826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKg6tpfTSdRmNVL9oWWx5/tJnTNrLO7MU62UoNru7CE=;
        b=W6NM5SkVBE8autsT7I/eLaXdvlVtqeBu6WEPzM6HYX68VgZxw6r97b0b3c55CVlCL9
         ByVjp7QOylUEzpLGSoL/e2gBQ0HhGA/tDZy4L2lpRBvvQ02SHHX6rMOw2jJyNa4qlcV0
         p59slPh5wlU/87PL0CW2q5LGGMbE+xMk/zJ5YgjWzTIvsGmAr+bsJtdk/xLnZnA5Q0UJ
         0AdG5ta/wg83hm794fFdl/XnoyvN869e5TrgSExQeuoIh2HdL3r/I+/KjWGLniljJup4
         Bfcn3chBw/4uUfrDwe4rtZcWg0Oxi91OTA0UlzKbYjPL8YZXDwO2jwPOnwTLcZveFGMZ
         N61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953026; x=1756557826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKg6tpfTSdRmNVL9oWWx5/tJnTNrLO7MU62UoNru7CE=;
        b=CdxgNPb+Bq0hbhCoh4Vwiy0mTEblvnLp9lqpKn67HUbDHeGfjAQ/z5tUf75QR6ca+u
         1OyjVVBXK7xECgf+3DrU0vJzFcLdi1h6fBs9bEXNN58edSe7iu0QN5HPE0+pf2c0l8Km
         ODpA+mD874PIbOIPbDSBleIgLTWZgipKPPQ/BP7N0IJJ7QM8U6imrs7dioNOMlBctGrw
         O0n9XdtfuLEGdalrx8BrzWfLZp+eJTczjrdNKgStC7g6NWiaQcqJBuJcO+CjqV7XaUpz
         0njzrnKdc0KG80WMx8BtG6E4rnF2nccV3vQOvN9dr73hDBXyF3Db4KKbWMWKNGrFb+Dp
         DJ/w==
X-Forwarded-Encrypted: i=1; AJvYcCWx6q1xxDGH6Z8+lvVkpFlYlXDMtUSLsK76+P2z5xHO4Eq6Clm3Fvy3ru1s0v5/iPN0VYIWmZoV2q0QFHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKN6achWMCP2Ivu5f/JIEv/7Ys82cROEPwwJieV+44eQMVT1I
	F5GAz3msKgvBEULYf1KhXSYEeqfarYijkajk8lIx+7xSS/jB7a4nAmmw
X-Gm-Gg: ASbGncvZ9xBCNLgN0iZchZrDtd+FgH6839W3Ozmkc75/319ZxCAuwmQr/yeI1QQi1Xi
	+0rceYrOvT5jXdgeu1v5Jcb3s4FlDDSy+oq9rM/gil2QQnCXMzT5mvOAi8n5xPnZQMNV6Uqm2g4
	Nb4b8xHVdZCxxY+IJ90QNyneHo5dZmT6oPFz/e1ntLHBSFLf09X/ZXVjvlWmFSOSo6wiaKOcTWr
	vghOuvEjWujIYqIXrdxzvo+mFzi53KWCdZmo6xelPPgy4XeQ6W6afPHhknKPEBjOHWbwGgHSZHE
	aB/m6DtrMxT2F5bQzX5cBJ9sqdtxUlfHYQm9SOW4MfvN/+tDv+TZtgOLEVWaRSb5Na/ANfcT7sv
	zeBX71LW0yakvmNyJpVflr1QUXw==
X-Google-Smtp-Source: AGHT+IG3MCS/XQ1i3zCJ1Ac6TjWBul2Y1v2qRKnCvZBiJ+c3h0j7SWN3xftK6mA1RE2UFwtjBHFnEQ==
X-Received: by 2002:a17:907:6e89:b0:af9:3116:e104 with SMTP id a640c23a62f3a-afe28ffcd72mr616727166b.3.1755953025569;
        Sat, 23 Aug 2025 05:43:45 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:45 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 14/14] staging: rtl8723bs: remove efuse_OneByteWrite
Date: Sat, 23 Aug 2025 14:43:21 +0200
Message-ID: <20250823124321.485910-15-straube.linux@gmail.com>
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

The function efuse_OneByteWrite is not used. Remove it and remove related
dead code, namely the function Efuse_Write1ByteToFakeContent.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 48 -------------------
 drivers/staging/rtl8723bs/include/rtw_efuse.h |  1 -
 2 files changed, 49 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index c4542e00c730..e39032b45c35 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -29,18 +29,6 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
 
-static bool
-Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)
-{
-	if (Offset >= EFUSE_MAX_HW_SIZE)
-		return false;
-	if (fakeEfuseBank == 0)
-		fakeEfuseContent[Offset] = Value;
-	else
-		fakeBTEfuseContent[fakeEfuseBank - 1][Offset] = Value;
-	return true;
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	Efuse_PowerSwitch
  *
@@ -183,42 +171,6 @@ u8	*data)
 	return bResult;
 }
 
-/*  11/16/2008 MH Write one byte to reald Efuse. */
-u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoTest)
-{
-	u8 tmpidx = 0;
-	u8 bResult = false;
-
-	if (bPseudoTest)
-		return Efuse_Write1ByteToFakeContent(addr, data);
-
-	/*  -----------------e-fuse reg ctrl --------------------------------- */
-	/* address */
-
-	/*  <20130227, Kordan> 8192E MP chip A-cut had better not set 0x34[11] until B-Cut. */
-
-	/*  <20130121, Kordan> For SMIC EFUSE specificatoin. */
-	/* 0x34[11]: SW force PGMEN input of efuse to high. (for the bank selected by 0x34[9:8]) */
-	/* PHY_SetMacReg(padapter, 0x34, BIT11, 1); */
-	rtw_write16(padapter, 0x34, rtw_read16(padapter, 0x34) | (BIT11));
-	rtw_write32(padapter, EFUSE_CTRL, 0x90600000 | ((addr << 8 | data)));
-
-	while ((0x80 &  rtw_read8(padapter, EFUSE_CTRL + 3)) && (tmpidx < 100)) {
-		mdelay(1);
-		tmpidx++;
-	}
-
-	if (tmpidx < 100)
-		bResult = true;
-	else
-		bResult = false;
-
-	/*  disable Efuse program enable */
-	PHY_SetMacReg(padapter, EFUSE_TEST, BIT(11), 0);
-
-	return bResult;
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	Efuse_ReadAllMap
  *
diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index 1cee7a8eedf2..5251ecc855d7 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -92,7 +92,6 @@ extern u8 fakeBTEfuseModifiedMap[];
 
 u8 Efuse_CalculateWordCnts(u8 word_en);
 u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data);
-u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool	 bPseudoTest);
 
 void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  PwrState);
 
-- 
2.51.0


