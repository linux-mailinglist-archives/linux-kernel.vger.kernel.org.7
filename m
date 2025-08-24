Return-Path: <linux-kernel+bounces-783547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68D4B32EDE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6067B1B26BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEEF26B2AD;
	Sun, 24 Aug 2025 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxZx7ypw"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B82641FC
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756029522; cv=none; b=NFK3aBibTVyAgYJFQks2rr2V0KHWs9ojK89lT2Jfah0JZlByq7P6/A6geC2ndshCQuIzJkyPTUPKTUC6cOUz7y7eYZxbiAK3GVtWGYgGStb8ojayiIbczOddRfKyNctCwYkvfbg7nm1+FbdfZNGQmmL/E7MNRx8MeAzO68Ai47c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756029522; c=relaxed/simple;
	bh=ldbo9YYAOT7pxAUaEDrlbL+4YuIsDyCnu0vvNTDKWvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajIT9Z8jLnYA4zxA4Y8R0V0+z7CWuEwrFkjpj9ZGf1lVUQmH8PpUz5ImM5g/poZtoHDYszw9dh0rHU66qibOiDv6I1HXxTJ5kMxRlQ2uJw64a9ntJ9cnVJVbbVBiprua89yFl3AQGa845i5EyH6ii9Y5sX8XhcL95Co04VoaoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxZx7ypw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so472301466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756029518; x=1756634318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fGiG7/VSnTA1owBp74Wd5IB4bdDfmXxntCUjoYB1M8=;
        b=XxZx7ypweAJtSUoAuLKDCklawUhlrPfk14GlW0BlKF2pF2kR+urI/fcuqY5dlNBuoZ
         XiozCleb7KsgFFBC7qaf8Vs3gTCXM3SIoPzezzLqzwobEhJL3N9Z9Fz7HMwfbom5BD3s
         wfqU5VFEyBaD18e+jTnzKmlWYtCT8h+7lS5pLe0Ytqhe+0HcRLai8za4X+J1WJeU29J0
         qGgU1/tGgzYPf8Gwznzxme76xQtQtAiWR4UyTZiPE8EW0hV1jEGnuJrSy2UTb4dORh0C
         LVcnn8xi/ix53xdgTT+skhl8+TZ3iPQW9axzbObSjjFbyDmsUo6NIEoVjSBbPXtqrC36
         eW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756029518; x=1756634318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fGiG7/VSnTA1owBp74Wd5IB4bdDfmXxntCUjoYB1M8=;
        b=LY72VrgC+rwGxEzA0Y/walpLksd9qVWFYo+FHK2ujXeL4yYQaxhWfmPJVPBNanyULh
         W5UCxp/Qxsk82dlNlfCLfjcsofSad/rti7diXnXRp7+qSs90efbQeMWd86H5ER85Wg4Q
         1XFjYm3ZaoAM+C1tST91H5zwt0sGoJi7wVLUro7cdz8QeduezRCAequUYmKIuZmtZ/o2
         /3KmwSfvduZJBaERwFj8NPI6qnSnUl5Oia4GxaArUAtZ1zfB0f67bn0xtNyF7uuiTuDG
         8/trqzmFEPpPNvAlytNat8FDP+/r2rA7NkSMVsPMShkpXuRsP+ERCfzuDi2/iPpx0/zR
         x1lg==
X-Forwarded-Encrypted: i=1; AJvYcCUoHrbcn1cXoA2tYu0aYk9LhE47gxihkWoy+E0rjeCcom8jRn+d1GzjlS7w1d8vepMszufhF0NBHfFfS50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIYetqikLx5mFkuQvrrRw65H3C/LRwrTCBDGTt3BCgGf9x3fJ
	b5Vg88SH2fYWrz9KNjTKypo6iNLT0t1PlT9l5tKb5BzKDUgTRp0bl/CK
X-Gm-Gg: ASbGnct2CateZ77fvFVNf4cxvcF3nSS4/PK3ZFdYrsfEmL6RGxTy85PQpkugth2dfZ0
	E8K/EjTO2G1xstTbt8rrr7tGMcj3fsZxJIAPG1F1RJn1kDQ2Zdq37C2s1DYzBDVbNqVOPtezuXu
	b7Nrpng+Ng9Udi8syEVN4hBvpRJomz5wSnDnKjodwOQjYu0siNb0i0vz3pTHx60aRvz6d2YjU7Z
	X9baW4Wz62YVzleyTXBd1kA28iPLVWSxVodqvSVfftorKr3cuZjT2zNQnCpPKLhkYLcEgWxnSEx
	+AGzu18qkN/ZcAOk6jwjV8kT8yvxL1UK8ElUSBof7n0oIho0/m0rUahvlkGZYV2KjDU6ntuX51G
	B0/fNCFAy1K7HvtlNGGrkJlLJug==
X-Google-Smtp-Source: AGHT+IEChKPlkeYc+u70DNblLlkC7GNSA1YYbKn+4HtbpIDoAJGxZs5hUdLvvGsztjC+LEpHLFdh4A==
X-Received: by 2002:a17:907:80c:b0:afd:d94b:830e with SMTP id a640c23a62f3a-afe29513a3amr629745866b.63.1756029518387;
        Sun, 24 Aug 2025 02:58:38 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe79fba62dsm41314766b.100.2025.08.24.02.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 02:58:38 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8723bs: remove bWrite from Hal_EfusePowerSwitch
Date: Sun, 24 Aug 2025 11:58:28 +0200
Message-ID: <20250824095830.79233-3-straube.linux@gmail.com>
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

The function Hal_EfusePowerSwitch is always called with bWrite set to
false. Remove the pWrite parameter and reomve resulting dead code to reduce
code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c    |  4 +--
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 25 +++----------------
 drivers/staging/rtl8723bs/include/hal_intf.h  |  2 +-
 3 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index f0c705ccdbdc..d5c53b614f61 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -164,13 +164,13 @@ static void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse)
 {
 	u16 mapLen = 0;
 
-	Hal_EfusePowerSwitch(padapter, false, true);
+	Hal_EfusePowerSwitch(padapter, true);
 
 	Hal_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen);
 
 	Hal_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse);
 
-	Hal_EfusePowerSwitch(padapter, false, false);
+	Hal_EfusePowerSwitch(padapter, false);
 }
 
 /*-----------------------------------------------------------------------------
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 66ba3bcd22e4..36680ecb5897 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -568,8 +568,6 @@ void Hal_GetEfuseDefinition(
 	}
 }
 
-#define VOLTAGE_V25		0x03
-
 /*  */
 /* 	The following is for compile ok */
 /* 	That should be merged with the original in the future */
@@ -578,7 +576,7 @@ void Hal_GetEfuseDefinition(
 #define REG_EFUSE_ACCESS_8723			0x00CF	/*  Efuse access protection for RTL8723 */
 
 void Hal_EfusePowerSwitch(
-	struct adapter *padapter, u8 bWrite, u8 PwrState
+	struct adapter *padapter, u8 PwrState
 )
 {
 	u8 tempval;
@@ -626,25 +624,8 @@ void Hal_EfusePowerSwitch(
 			tmpV16 |= (LOADER_CLK_EN | ANA8M);
 			rtw_write16(padapter, REG_SYS_CLKR, tmpV16);
 		}
-
-		if (bWrite) {
-			/*  Enable LDO 2.5V before read/write action */
-			tempval = rtw_read8(padapter, EFUSE_TEST+3);
-			tempval &= 0x0F;
-			tempval |= (VOLTAGE_V25 << 4);
-			rtw_write8(padapter, EFUSE_TEST+3, (tempval | 0x80));
-
-			/* rtw_write8(padapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON); */
-		}
 	} else {
 		rtw_write8(padapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_OFF);
-
-		if (bWrite) {
-			/*  Disable LDO 2.5V after read/write action */
-			tempval = rtw_read8(padapter, EFUSE_TEST+3);
-			rtw_write8(padapter, EFUSE_TEST+3, (tempval & 0x7F));
-		}
-
 	}
 }
 
@@ -1474,9 +1455,9 @@ void Hal_EfuseParsePackageType_8723B(
 	u8 package;
 	u8 efuseContent;
 
-	Hal_EfusePowerSwitch(padapter, false, true);
+	Hal_EfusePowerSwitch(padapter, true);
 	efuse_OneByteRead(padapter, 0x1FB, &efuseContent);
-	Hal_EfusePowerSwitch(padapter, false, false);
+	Hal_EfusePowerSwitch(padapter, false);
 
 	package = efuseContent & 0x7;
 	switch (package) {
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 4fe48cccb889..2fa2382ad5f3 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -265,7 +265,7 @@ u8 GetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariabl
 u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level);
 void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter);
-void Hal_EfusePowerSwitch(struct adapter *padapter, u8 bWrite, u8 PwrState);
+void Hal_EfusePowerSwitch(struct adapter *padapter, u8 PwrState);
 void Hal_ReadEFuse(struct adapter *padapter, u8 efuseType, u16 _offset,
 		   u16 _size_byte, u8 *pbuf);
 void Hal_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type,
-- 
2.51.0


