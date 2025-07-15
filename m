Return-Path: <linux-kernel+bounces-732377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01012B065F6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEF01AA7FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC412BE641;
	Tue, 15 Jul 2025 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd8LRlpX"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51873293C54
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604114; cv=none; b=imn3l7i/G6Jdmu2heMIDWrH6smD0Xlw9FGB4PAzKYbJlRBgwbSyFsXdZRmMhoutguBnVXMNgKoPYjaR8AR7HmKsm/UhUOTBWEj5eWE2yF1BNKUa/mWYl4ac8+xDZShFN5KmHFLMs0gYPX+L8dSRdKqB/zgmEc7oOvZG1Cmq1uCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604114; c=relaxed/simple;
	bh=RGMQ8EJRQNAP+O0nR/eluDRpL/DwO8M7+yfSc7ut35w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKTeMDc4tPs3XGy07hnK5tDBLi/5563ackI2b2AzcQ3x120x+2VzQ2pobQedctGioY+fGgJW5xyQm1zIiqARr7zlWjuFGDdaCXwJV5MbQ1iSBXPnLHQRzgSiImlsq5iZFzpRKg/MuESTWMXD2rq4DKXa/s9SqD6lEI4gPb3vWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd8LRlpX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae36e88a5daso1148522966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604111; x=1753208911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMmjaIlR4ZenTaxCD2MM6OSgv9kE1Hp4WFX2rahkbZw=;
        b=Sd8LRlpX+DclSi1QHotl6GaAftZ4U1NdpHYwJefinIPon1v45z2KPJbJsUVr7leq3F
         7Ki4HZPZD41WW5xk3G5zYHJ4rbYX2OVpFM2u5z5p5wnIaqLf6bpytd/Lqc3xLEKyFtwC
         V/J8hYJbdezkzmDw9p7WPhsbIo4bhr4Fwu62gHHzKjL8U1o/YuIZBZM+2wvWEvff2sbe
         jTej5Y5gsQo/24Bs6KxeUG8aS6IfaFYYcBf+T72JmTXlgtWq2nBgMLnq5ZqYy0z68O3H
         Unx7R46UlmaT+9CtppI3faxLeIUJ9GlmZ5lT02ltTTVjW9fSCIM8RJcgV50S0OAHag02
         gchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604111; x=1753208911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMmjaIlR4ZenTaxCD2MM6OSgv9kE1Hp4WFX2rahkbZw=;
        b=CHvxbYdqLrKpXc24NB4pgc5fzB7uPb1gP0/BV11mlYhM0OktNip4EWox1AbUbkojx+
         M/DQksp1ZSeUq0xKGk5IgAgnRI3FPIbB65qaXshHTHb0wVfbjvpnbMrw22q7D4jDYx3N
         AB8wkqZpVuxWNtXuIOBmNqBs11HdeSHO64E8FxHT3RaVl5fPreBv0CFR5bj/X7NwS7rc
         VzRHqRj4hskXWGBBsF+S0PdQFCuLp/nDo/A3CqXvF9+0DOV2cVdlVbxCwV2TZLgyaEEa
         4GExDo08XdpmYS5WVEzsJhU6nA8t4LCpeBgMCVqhh6eYNp9kH5INnMNlL4MScGT3HHxZ
         Xpdw==
X-Forwarded-Encrypted: i=1; AJvYcCURNh2bWFPfduihiDdeAI8EFH97u0dB6hqgd21fOcdDH/FTKxAmCVvjkb6O1uMqrj5zOvbPPsYBDSy+kpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybPsg6qnAlPFLaswbggRYreJLkGb/EfpAkJIuxfuZ0lJey+2J1
	nLDks92rRrB139kW0j+jFyPH7QGEL2TL4fl4lsX3ljmkHGLt30HS5j4R
X-Gm-Gg: ASbGncv5kuHG4I2axXqxOMjsSIUjm1FWrt+nuXAwWaWqHMj3qus8bXgvHY1GxZmrdHc
	LK9wMdbak6Hp8+pBb1swkxvSBvr7XG2dqmKn6+wo79ZJc3dsaxIekon92nNHU7cyMN2H6mbuFdf
	Fg94QWaj/PFE9ZLAX5BsjeCs0WlEaRrJJhS8w+DmdYn8VshBL+U7boj4opnkUxAWF9LCH4ic0Ys
	DzCF3jdnnWybCVZ7nLyfuQzJxCM3HXett+qYMgXJEU3/Y1dz0ySw5VxmpZXtDN9zPSpTn12LOMd
	MvuM4hA9g47W+AFYnJRCFH4qlgG1/tle3sOkv0AoKCw+vObXaKDRcNQ7q99CNKzzgTvL+M7B4sq
	0Snqlm4lxyCqYGZHxl8/kGwMInCqBeg7lXw==
X-Google-Smtp-Source: AGHT+IG5BvDjN1LsfM9YL+RrdxBZ0+b+WKjzMqa27BPTAumF3Q75BMkOiFaKsae3DdxTFNE9xviL6w==
X-Received: by 2002:a17:907:7b0a:b0:ae3:7b53:31bd with SMTP id a640c23a62f3a-ae9c9b18672mr57537866b.28.1752604110415;
        Tue, 15 Jul 2025 11:28:30 -0700 (PDT)
Received: from tumbleweed ([95.90.185.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm1039562766b.158.2025.07.15.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:28:30 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/11] staging: rtl8723bs: remove function pointer SetHalODMVarHandler
Date: Tue, 15 Jul 2025 20:28:04 +0200
Message-ID: <20250715182814.212708-2-straube.linux@gmail.com>
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

Remove function pointer SetHalODMVarHandler and use rtl8723b_SetHalODMVar
directly to reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 9 +--------
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 +-
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 6fb1e81dde42..84c64bd04598 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -129,8 +129,7 @@ u8 rtw_hal_get_def_var(struct adapter *padapter, enum hal_def_variable eVariable
 
 void rtw_hal_set_odm_var(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
 {
-	if (padapter->HalFunc.SetHalODMVarHandler)
-		padapter->HalFunc.SetHalODMVarHandler(padapter, eVariable, pValue1, bSet);
+	rtl8723b_SetHalODMVar(padapter, eVariable, pValue1, bSet);
 }
 
 void rtw_hal_enable_interrupt(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index b74d916ebbe1..8b7816e47131 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1267,12 +1267,7 @@ void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter)
 	rtw_write8(padapter, bcn_ctrl_reg, val8);
 }
 
-static void rtl8723b_SetHalODMVar(
-	struct adapter *Adapter,
-	enum hal_odm_variable eVariable,
-	void *pValue1,
-	bool bSet
-)
+void rtl8723b_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
 {
 	SetHalODMVar(Adapter, eVariable, pValue1, bSet);
 }
@@ -1325,8 +1320,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->SetHalODMVarHandler = &rtl8723b_SetHalODMVar;
-
 	pHalFunc->xmit_thread_handler = &hal_xmit_handler;
 	pHalFunc->hal_notch_filter = &hal_notch_filter_8723b;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index da4215841773..f9f169262fb4 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -161,7 +161,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 	s32 (*xmit_thread_handler)(struct adapter *padapter);
 	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
 	void (*hal_reset_security_engine)(struct adapter *adapter);
@@ -277,6 +276,7 @@ u8 GetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariabl
 u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level);
 void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter);
+void rtl8723b_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 void Hal_EfusePowerSwitch(struct adapter *padapter, u8 bWrite, u8 PwrState);
 void Hal_ReadEFuse(struct adapter *padapter, u8 efuseType, u16 _offset,
 		   u16 _size_byte, u8 *pbuf, bool bPseudoTest);
-- 
2.50.1


