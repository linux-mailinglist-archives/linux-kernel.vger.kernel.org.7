Return-Path: <linux-kernel+bounces-783549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5DB32EE0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA08D2041E7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F526C383;
	Sun, 24 Aug 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGPTsY3+"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1D2620D2
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756029522; cv=none; b=Xp5dae8/w0kkDWZSn86FICBU7LubVRKMlCrgSHt6OINNcVucbsqvZynSxnGQ4TpYk54lZ2ctV4Syw9kSVxBDo58zM18Ba2F+8QLDG91gSnGgpWG5hFGCpEgyFPBSuTvVtB5RfHZg4ZllouQP37QOtZ4vQNVK7BP2VH/ZfxUrCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756029522; c=relaxed/simple;
	bh=9vKO6y/q0kB3TamnCzON4DvVOC9PmEnOciXyI0pj7zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKxiC7EUTmIAG5u9xIISscChifxtdOlNXZTwLDeSidyHFzEJNQ12BxacGMZPDZ/Q8mqbP4NPUkX61HHhpfX69AEDRgxGhxAkXdoVnrNoynoIzrhaZeFuby9WXXsrK+hObWoGpA2X4TDCZS4QdTqgUfHdk0k319RUMHHSAupeTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGPTsY3+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7af30a5so590226666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 02:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756029518; x=1756634318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZKX5iGNtzUg18kwP/R5sStYV/khRElhDeGAve6BvqI=;
        b=fGPTsY3+fgbb5xXBpUxjgv1975XRrVRrniblek+Ly5smK42gac4y7QYzhyYyJSQTgS
         uZTrt3m5Ao50liRGhnRTDfx6JFnCkFr4aua81+MBgTz9DBOOVgg3KTNRApeINFUKxBAZ
         6Q6tNhhD5+l5xKiznaXSDhoW0DwfJzwIfFrulYie+LQOhHKsoS8rghQP2bMZUMTI3PPz
         e/ZZJqRKLcx6yUrUQDDxwXIe6KsNn+E1OzK4CV5vDUzQB1/6+rsXbo7OJ+0Ieua6kIxz
         6QIHgaqgL7y9PBk1x2mHc6OIMBZTc+/3UcLdXyxMTnQssdwfUHQsgR4A/6Rw2DnHAENq
         xaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756029518; x=1756634318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZKX5iGNtzUg18kwP/R5sStYV/khRElhDeGAve6BvqI=;
        b=gREbC6lhL+dUhk9U9TNqViA057nVwZcWEeplRLaJrksxncrHKxEm39YZRvNl0ueGwq
         EloHn89t3q4fNimurvNrS5MSOYY+hxmWTgu9OQelPJ6B0Dq9S11advFROzcrV9Yamvud
         gXJEaQ+PjvKpS1iTLQVIM4ur7OF0/Lpsdomn1t5zTuB6zzVLEcQmYS0A6XnKwd/abXlj
         uBhjS+js3cMytx2fSlKiz3WsvBlSC7f5eMzYKkoF404AV9J1GK/2oc3DoyimS5kpND+1
         M4LTPvPxqEp6sjRTC8M70eC69dpbCPOmXR+46IUtOIc7X4Vk1XzlVgnfAqWdmklQmVG0
         tjdA==
X-Forwarded-Encrypted: i=1; AJvYcCXblzxcSJfprr8MUT8Nfa4+/0uXNN8awbOeDfbGLhar5bRpRXcVA+E8O0TZNSJrasbtyjD1GeSF2YYiT30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRT7+toHrOQcrARJBVA/CsttXFNvuTmVbyOFbsFcvczSh9FNK
	cz6r0Nv/yNp2vIQqigJI9r+TY6BT1Xv1bttRVEiUnZvr1XhUbFQGPyd5
X-Gm-Gg: ASbGncv/T71qu6y8M0hJNl7x4WecB8bb9vY00GKyXNpsz2gT1eWJZ2+qaMgzyJYI2O5
	ea8qo+zTcHygHhdnfDOlQ02NOQmzBkBkh5hm5vgE9nDG6i77n0OBRk6r5ZsKW7v1TZbQyv3pTph
	ZqCQglhXrzo7K4qJl3pMRXvKVl1YHk8tNXIQwLT5pDiQCetVeipS2Rxqrl4x4xo9qG+kkDvOXsp
	N7kznPdLJ01zvcFn/i4YrXATl+0Loq1NnFallhqdnuncpx5UY7UHV2aNC5hUtfGkMvwDpMwbJvC
	vcSN5jYuzdGTS8/45NsO/ZAfWJTd6A9RcNPdoVb97MuXp7hoqCgB3u4KGomTOHaibN38mo2EOAn
	x5CqWYUe02nsL+CKHIWEkO2uEZw==
X-Google-Smtp-Source: AGHT+IElT045z23ULaqJLlbU6nriQbkGsElcteR0wlVYWXnPAJOezIwza8EGMC5PaY11b8LoP6Xbhg==
X-Received: by 2002:a17:907:6d27:b0:afd:d9e4:5a4b with SMTP id a640c23a62f3a-afe296bce93mr854042666b.63.1756029517762;
        Sun, 24 Aug 2025 02:58:37 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe79fba62dsm41314766b.100.2025.08.24.02.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 02:58:37 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: rtl8723bs: remove wrapper Efuse_PowerSwitch
Date: Sun, 24 Aug 2025 11:58:27 +0200
Message-ID: <20250824095830.79233-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250824095830.79233-1-straube.linux@gmail.com>
References: <20250824095830.79233-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function Efuse_PowerSwitch is just a wrapper around
Hal_EfusePowerSwitch. Remove the wrapper and use Hal_EfusePowerSwitch
directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 31 ++-----------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  4 +--
 drivers/staging/rtl8723bs/include/rtw_efuse.h |  2 --
 3 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index e39032b45c35..f0c705ccdbdc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -29,33 +29,6 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
 
-/*-----------------------------------------------------------------------------
- * Function:	Efuse_PowerSwitch
- *
- * Overview:	When we want to enable write operation, we should change to
- *			pwr on state. When we stop write, we should switch to 500k mode
- *			and disable LDO 2.5V.
- *
- * Input:       NONE
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- * When			Who		Remark
- * 11/17/2008	MHC		Create Version 0.
- *
- */
-void
-Efuse_PowerSwitch(
-struct adapter *padapter,
-u8 bWrite,
-u8 PwrState)
-{
-	Hal_EfusePowerSwitch(padapter, bWrite, PwrState);
-}
-
 /*  11/16/2008 MH Add description. Get current efuse area enabled word!!. */
 u8
 Efuse_CalculateWordCnts(u8 word_en)
@@ -191,13 +164,13 @@ static void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse)
 {
 	u16 mapLen = 0;
 
-	Efuse_PowerSwitch(padapter, false, true);
+	Hal_EfusePowerSwitch(padapter, false, true);
 
 	Hal_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen);
 
 	Hal_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse);
 
-	Efuse_PowerSwitch(padapter, false, false);
+	Hal_EfusePowerSwitch(padapter, false, false);
 }
 
 /*-----------------------------------------------------------------------------
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 94492743ea34..66ba3bcd22e4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1474,9 +1474,9 @@ void Hal_EfuseParsePackageType_8723B(
 	u8 package;
 	u8 efuseContent;
 
-	Efuse_PowerSwitch(padapter, false, true);
+	Hal_EfusePowerSwitch(padapter, false, true);
 	efuse_OneByteRead(padapter, 0x1FB, &efuseContent);
-	Efuse_PowerSwitch(padapter, false, false);
+	Hal_EfusePowerSwitch(padapter, false, false);
 
 	package = efuseContent & 0x7;
 	switch (package) {
diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index 5251ecc855d7..904369705ed7 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -93,8 +93,6 @@ extern u8 fakeBTEfuseModifiedMap[];
 u8 Efuse_CalculateWordCnts(u8 word_en);
 u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data);
 
-void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  PwrState);
-
 u8 EFUSE_Read1Byte(struct adapter *padapter, u16 Address);
 void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType);
 void EFUSE_ShadowRead(struct adapter *padapter, u8 Type, u16 Offset, u32 *Value);
-- 
2.51.0


