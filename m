Return-Path: <linux-kernel+bounces-732379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B5B065F8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E130A566AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE12BE655;
	Tue, 15 Jul 2025 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaLLMBe4"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22692BE623
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604114; cv=none; b=Lac5ooLAuhfQLB6+V08KrdXcs6ghsgMnWG0+W9pj1/E3//RiWqUXPBWXBG1+0KLSNe88OV8XoYBfDVR7HicIwjiZYIr7466JKEvmFyuXNpnttV7RC03VDv87V7uA/VLT3hI3HYvgG3/ZJF/mYk7JBaDz2aOFZmllfdmisN9wTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604114; c=relaxed/simple;
	bh=ECgy4eTfac1zqO/5HUEbRVZsjHDefM0HEHpusxU2ALU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFDGMcJxbcdKgKVlWRRx/blootDFDD1Za6kXQXSZ/Wn4tbCIjhmAyEbPUVDduqb4Lip/GEyt3SX7ujulsRP6Ias6ITKrblhfY10o2hcMSui6VppMLE9kclDj2S5efuHhZYNJf9OpHZvZBwuK8ijRW/qDqt7Z1qQ7NXuO/Ynvyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaLLMBe4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so8455216a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604111; x=1753208911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+48D3Zf8xbVVJZn4wq+ACZZdbOHepuaxIXkDtYoSUY=;
        b=VaLLMBe44enr/7pVN2o39Ib2lD1oXAN39QbuTM1ZGePbG7SzOdXdFiKCP0BeAPxmX9
         SCU6K4VML9/kd18cYPSoMneRNCS82F4OVbs93LS71pP4uo58pBhcs/bRQJvG4UjnkGgd
         5ABClpD5QkH1Cya4j0s4ExLWOnIA3bmVfi75fEsrE7Kbca7mZ4Z0kEGrKzcxQgkQZvlZ
         GszL5Xkf15CIaAPZxzm4dIsXpIZrrrWrVdHT9/Xhta8tmd1yLbczRDPQbjfy0wnlxOw7
         q6IUzSQls20DHpwPn/jn+jzdFid5P/h2r2LBpSD4Ndaze7qUtETT4nPScQ/TnGKvn4Sf
         m4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604111; x=1753208911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+48D3Zf8xbVVJZn4wq+ACZZdbOHepuaxIXkDtYoSUY=;
        b=ko0+9BtQh698slRq3HbnRKxCJu7BuT+LN0rWssie4M1iMDvKF1Ad6OR/U4fQEOOj92
         SGLF1OQ8eMV8myfWMgDYjBXwvT7OAgUCeOBsPmfLpH1ZZYNUflxewr4Bt2z+Mz8cmNju
         qw9ErdpoX2oVHfPsUVYCPJCnbRS8u6Um2laOdNIuWBEaLAASLjmOMu38W1elLBJsaaXG
         vv78S0Latrh9biVOru74zX3XutV7SQHaTKLrlnijlAbIW76aMih2qa4uXcM+A0UPKskh
         CRFHoLQBllnM1Z6rLcP0Moak/Uq8a059ypdcxTH4Kc8Or1AUdrCZQlKBJrpnEZi9dFyz
         aQOA==
X-Forwarded-Encrypted: i=1; AJvYcCVvxJz26MXiPsu4St87SZJN7jAXH0ECs/8VkcQUU8li9XR2Dwa0e6KjtLjOSFa3mB/0Xo5rquT1SrkjIHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyu//q0TXyaE59wLwacV8xMfZiBc0F2LaDgTvJxiHA26IDBs+H
	buUT35ZwrDxeKP3kBuSWNES8gYDZ6sHMyIuzgeL9eDz+1oZEeL+qZOCU
X-Gm-Gg: ASbGncso7rswdnBnClUXHtYYOQqz6VatavKsiSnQGri8cftSRGdv4SUv0wCOnMrz3nQ
	FOeU45/Iup8D/1jVfvLrWmZKCRJhc42c6uk9HuHzMS+QvYMmisiDPX1gNRBYH78CtCjyYf7IBEy
	d1ipdP2wNzIvSIUuEF3BkAwf9C6ve3OdRg/j7JyPqo69WkKvKQavD6JPjPFeJo6x4HkoqKSFdbX
	p9c1Y7aGWuPVIe4LaCpszKoTWDEZqzCYaUYPHHSw/2KHc4+4UnqvD52yEYMORAsp+DWwtjEOBtO
	waaWnRAn9LgDAziFHfd1EmIIdcbj2fvFpNwXCNmsSvJ75XKPUvO8IhLCgo1u8xHaU/Z0nnuA9Qq
	lPqfaB3SiLz+BI7ivz/TUiBGPyq12mnXG0Q==
X-Google-Smtp-Source: AGHT+IELtnyR9k831DsLwjCiff8k5Se84nYTUQq8W20bGrQgtIzUresPNYgOEYpuqARkZHkHgdio7Q==
X-Received: by 2002:a17:907:7209:b0:ae0:d804:5bca with SMTP id a640c23a62f3a-ae9c998539emr55804066b.17.1752604111002;
        Tue, 15 Jul 2025 11:28:31 -0700 (PDT)
Received: from tumbleweed ([95.90.185.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm1039562766b.158.2025.07.15.11.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:28:30 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/11] staging: rtl8723bs: remove wrapper rtl8723b_SetHalODMVar
Date: Tue, 15 Jul 2025 20:28:05 +0200
Message-ID: <20250715182814.212708-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715182814.212708-1-straube.linux@gmail.com>
References: <20250715182814.212708-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the wrapper function rtl8723b_SetHalODMVar and use SetHalODMVar
directly to reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 84c64bd04598..eb34e39f3c64 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -129,7 +129,7 @@ u8 rtw_hal_get_def_var(struct adapter *padapter, enum hal_def_variable eVariable
 
 void rtw_hal_set_odm_var(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
 {
-	rtl8723b_SetHalODMVar(padapter, eVariable, pValue1, bSet);
+	SetHalODMVar(padapter, eVariable, pValue1, bSet);
 }
 
 void rtw_hal_enable_interrupt(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 8b7816e47131..a6eab2819535 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1267,11 +1267,6 @@ void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter)
 	rtw_write8(padapter, bcn_ctrl_reg, val8);
 }
 
-void rtl8723b_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
-{
-	SetHalODMVar(Adapter, eVariable, pValue1, bSet);
-}
-
 static void hal_notch_filter_8723b(struct adapter *adapter, bool enable)
 {
 	if (enable)
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index f9f169262fb4..3626e1505848 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -276,7 +276,6 @@ u8 GetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariabl
 u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level);
 void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter);
-void rtl8723b_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 void Hal_EfusePowerSwitch(struct adapter *padapter, u8 bWrite, u8 PwrState);
 void Hal_ReadEFuse(struct adapter *padapter, u8 efuseType, u16 _offset,
 		   u16 _size_byte, u8 *pbuf, bool bPseudoTest);
-- 
2.50.1


