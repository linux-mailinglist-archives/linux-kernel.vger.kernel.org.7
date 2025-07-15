Return-Path: <linux-kernel+bounces-732388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30AB06601
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9F8566CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC22D0C7E;
	Tue, 15 Jul 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWLAZlMp"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676852C08C0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604120; cv=none; b=WbqM3NJp52qHTIwHpr6SOorHxSjZZiX6LFicrVeKMxcYUer88z6n/ChVaRjpEBJ7ZOYSlli8vS1Cz+ZHltuCbtSudcimRQZUDhx0itc3MeXYCefGT+Mkena98sAHbUWygaOUtZJe0+6aEuGPgCl7okgzqL9XII+CZZUAc6oRSZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604120; c=relaxed/simple;
	bh=mpU5R7KnzhOMbd4mN29cmChRyB3oADBmJ7JKuMhNmkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUtWEKeRAL0JmtXKgavkLs3qSRhLnxucJ8S+Pb9JTqattSMazdyE2Ji23vB8QLlO/oCJ2GEntU7M/WpoTcjjJL4zTgVyiJnQghHNvBixuGcbRQm4tM6/mu3Ag4QDsuk0DSYoRtK9S+/8cg3yg2VPtM8+e8YrDKyWxIvk8GnMib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWLAZlMp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so1121539366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604117; x=1753208917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DpYsszl2QuakqvLkMzTig3n2mo4OvaOkwLGvJ5A63Q=;
        b=SWLAZlMpZyno/vipbGirQiZ75vyKLU5IzyLuPUQtKbT0BXu0LiOMfZNgGFyoOJxcjv
         dxyJSj1A1OQTsSCoTGVJsTKhZzlFkyWBibgEyqlYdODlUwQKZapNLK4fQ/sGtPuUV3co
         DKnvlyjCcwYLYR3BoWioX13XuxAy7DZ8d3EBfW/EkO42+HxYVk/nfQO1wpvmLoaiJ7nD
         2xABD5o7VaH97EnCvtL5FnotR6sSkLn0y6ieLSmy4Spf01pjT+tiw/O4NX5hkIM+pclY
         /WNn/44u1wBmuLqd17KH4OdnMppj++Xv/xeEIRaG/uJTLBMBlDowDdlJJ7x8WY5F1kwn
         cg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604117; x=1753208917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DpYsszl2QuakqvLkMzTig3n2mo4OvaOkwLGvJ5A63Q=;
        b=k5pYU2+evZWdNT9n4oj0k2B0Tgx9740K29FF4jphxqwhX0kuDk0NIZ6d0Is6Mm0Huv
         qfyuk2Ml8cMjP3X9VENlBt54vwkrvCj5kwARit8E/IQW+o8Kjfz/lSzCTmL3pzFBk3La
         iYq9H2ePLgHvL6nFOeCZGhumLvGHGmmHbsiFXIW9EHDtx2/PcEXurmG9Vw0FLa13kLWj
         pZR7AZEbPMMVhNX3jerwaWl2cROgFyUKfweA/Gp9OGJUSABiWiV2SiP1ls/aawQxnEq8
         hMj/RjpM5oRP2thOPxEYaN9lsCvaRC0aU9MjlAHP9LeAoP95czvNmo8jO2/RdP/qwLJb
         McQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjvqCDb2mmFM6eV5C1Fp0WYgyxUWna9ZxLqZjOsXMaFydlsRrC9cn1MXOMccRRLzQeVogwezcUf+r+e2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrhMoKEepIdWMBykcRQnIKWRWe4K/Q2w4tjvE8iA9JMOdJUxo
	cSJ2vMBBRt9g4cd5CswiBK60xi5dE53L4TDBDL7iLOTDqviQdj1PbaiJ
X-Gm-Gg: ASbGncsCPA8bgk8n7AozMaOUll/uHOcnRIA/DNN4i0ot36xQfbPJLM6Yqk+gmzZ5BPC
	tc7/I0yVmR+90EmTotlJjbbTLgMljZuc72fxu7r4PR7yg2tcsHOA+X0Yiq7VV4GIyWLUEHvKFRB
	YC4VDeIQq4+W+x3uOeupCBxZclE7Ws0UgcVD7wMvb4xpdEG2u+6zIxDRRYZq2lxCmcmjtOgEv2Q
	QMxpyb16bnLekauy8IG8G/eVumwS+0/Bs4HacpAlvrmvjPg30amKqE8YpeceIY4YZKXq55leb/7
	CwmQDyw06uZres8F1qrjPceXa+p4cu7DDJH+mz9s3SAbYWUCZtbiV9CpHtCx64Y6LS+BQBAsoRF
	G4DR9eaC5IEWVZqXsE2bZWDw=
X-Google-Smtp-Source: AGHT+IHtnmNRdfCGqStJ0TqWPul3dFG2M+jv02OtQnl6sKNpCpopF13wAyUpSNMo9xJuANuxI+0E9w==
X-Received: by 2002:a17:907:c8a8:b0:ad5:27f5:7183 with SMTP id a640c23a62f3a-ae9c9b1ca9bmr44967866b.39.1752604116436;
        Tue, 15 Jul 2025 11:28:36 -0700 (PDT)
Received: from tumbleweed ([95.90.185.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm1039562766b.158.2025.07.15.11.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:28:36 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/11] staging: rtl8723bs: remove struct hal_ops
Date: Tue, 15 Jul 2025 20:28:14 +0200
Message-ID: <20250715182814.212708-12-straube.linux@gmail.com>
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

After previous patches, struct hal_ops is finally empty now. Remove
the structure and related initialization functions.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
 drivers/staging/rtl8723bs/hal/sdio_halinit.c      | 8 --------
 drivers/staging/rtl8723bs/include/drv_types.h     | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h      | 3 ---
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h  | 1 -
 drivers/staging/rtl8723bs/include/sdio_hal.h      | 2 --
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c      | 2 --
 7 files changed, 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 1e9447633465..a9f33444aec2 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1312,11 +1312,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 	pdmpriv->INIDATA_RATE[mac_id] = psta->init_rate;
 }
 
-
-void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
-{
-}
-
 void rtl8723b_InitAntenna_Selection(struct adapter *padapter)
 {
 	u8 val;
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index af9a2b068796..35f48b564199 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1251,11 +1251,3 @@ u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariabl
 {
 	return SetHalDefVar8723B(Adapter, eVariable, pValue);
 }
-
-void rtl8723bs_set_hal_ops(struct adapter *padapter)
-{
-	struct hal_ops *pHalFunc = &padapter->HalFunc;
-
-	rtl8723b_set_hal_ops(pHalFunc);
-
-}
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 7b0e824e05a9..080c321665c0 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -350,7 +350,6 @@ struct adapter {
 
 	void *HalData;
 	u32 hal_data_sz;
-	struct hal_ops	HalFunc;
 
 	s32	bDriverStopped;
 	s32	bSurpriseRemoved;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 248f54f04c5e..67d51e55bd44 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -160,9 +160,6 @@ enum hal_intf_ps_func {
 
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
-struct hal_ops {
-};
-
 #define RF_CHANGE_BY_INIT	0
 #define RF_CHANGE_BY_IPS	BIT28
 #define RF_CHANGE_BY_PS		BIT29
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index a4a14474c35d..40ff96d3cf74 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -223,7 +223,6 @@ void Hal_EfuseParseVoltage_8723B(struct adapter *padapter, u8 *hwinfo,
 
 void C2HPacketHandler_8723B(struct adapter *padapter, u8 *pbuffer, u16 length);
 
-void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc);
 void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val);
 void GetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val);
 u8 SetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable,
diff --git a/drivers/staging/rtl8723bs/include/sdio_hal.h b/drivers/staging/rtl8723bs/include/sdio_hal.h
index 024acf9b530d..6538253765f1 100644
--- a/drivers/staging/rtl8723bs/include/sdio_hal.h
+++ b/drivers/staging/rtl8723bs/include/sdio_hal.h
@@ -11,6 +11,4 @@ u8 sd_int_isr(struct adapter *padapter);
 void sd_int_dpc(struct adapter *padapter);
 void rtw_set_hal_ops(struct adapter *padapter);
 
-void rtl8723bs_set_hal_ops(struct adapter *padapter);
-
 #endif /* __SDIO_HAL_H__ */
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index e735747f2000..f3caaa857c86 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -216,8 +216,6 @@ void rtw_set_hal_ops(struct adapter *padapter)
 {
 	/* alloc memory for HAL DATA */
 	rtw_hal_data_init(padapter);
-
-	rtl8723bs_set_hal_ops(padapter);
 }
 
 static void sd_intf_start(struct adapter *padapter)
-- 
2.50.1


