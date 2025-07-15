Return-Path: <linux-kernel+bounces-732380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A94B065F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F02566AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0D2BE7AB;
	Tue, 15 Jul 2025 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUJ475Yn"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9F82BE628
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604114; cv=none; b=NYmO9JKtWrLRtgxYqcZKdFjBD3eXdVX4ugRPdMcsBhdxHDx0V93Wbq/E2tpaqlK85TM05nzyTfLf1MCwZd9yBe+es6zD5wU/QTwHFzQltGjRgDNdbT5fy7IOLPjkSge3yvG7TbuZjTIABV2F0h6zzcqAvwkJVSLR7ont3qSnhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604114; c=relaxed/simple;
	bh=rAExqxku3fpzgVaq3gFsYfqCvlE+NBd//fV0rFUcs0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYNdZJoxnvgPxTkT8cnoXrQ4uh68ReD8V9hNmIKflfxn+eB+PSeNeRMhdsERha0cQQSJTFOsOSe591ybXtnoxdisdsfGY6/MdVKOLQUSXKosrd4Y8OJwRlND3dnpwizduCaaueDJt4Lfpu14WEBdnXzBl1rVvZ6bLRCAVicu0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUJ475Yn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae361e8ec32so1086894166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604112; x=1753208912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TZKOmxyucIiBwjGXcjcpB7skbLwkFD749lNf87jbsk=;
        b=YUJ475YnfuZQ56MF9pzLUCl1v6TUlbgj4bhk+bT+FF7aQJmyzLccsayaKWOCxghVAA
         wHfMiI1qeFivN89be2MXBGIiI/iduIklmlbEs+mHyuC1Gl45oZ5H3WqZA5jfPyGeZ0ZW
         6BE6FqfTamJr/8BX3sCPYxELs0MA10CuWomADX3/YXaJOWkgBvJAd9SfSGQRKGwENDrK
         ucsKLPOlEVMzgUSFJq8/wwiCh6b5K5K/TiwRPrfdabnEkP8CkKPcxVwM8uV2CCyRgALf
         eQ1t+kkmbJJIofGPUdLC9JuszZVIxKCzqEWJmD/a3+ex7hRw5K7R4fe+UbpVZY3/JD+Z
         aArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604112; x=1753208912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TZKOmxyucIiBwjGXcjcpB7skbLwkFD749lNf87jbsk=;
        b=gC3dTt0us23p7UqZqRQCo+YvAYC4j32SI09Nk+pCug1vCAAygvwIVPm2WG5Z3p0eC/
         8cjdR/Up/d5t7OiGJj+w5Vp56MGyNAQT5wQH9AYX7n7hQlQ/rqpCYXNSlEOryXAK2ubU
         rYoNXj7eZV4MNusOX9Iwp8LhHcY8scAseo0D/EonSAX6+SFieUizGNYTO6cpbWp2uX31
         nOasList05h15A5QXDuFiqGaE40t+lL5tHxQ/G/RnnGlQy1tv8OXhOggYcXq18/yMmkA
         LmVSAil6EdudJy4mfKfBt2+HFTR+jM+M0OuTOOZS0yyUK9uJ3W+pFAbvoNZSS03u8SXY
         YP2w==
X-Forwarded-Encrypted: i=1; AJvYcCXnGdEYI5A/mVX9gB7PlDBUuO9Sye2zWrrjtOyPhi5O8tV3gIhl76ik7uAcd3g86bfYmArZ57w6qRf3KKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwHG5phcLnwk9n6FdweCVZF7tXHIcW4xNivQUPYmeuSk+pd/1W
	36yk9p/U326uelSbHkoUVqwnjeqbDkxS8O8FFSJnjdRKocU7XnrhXqaj
X-Gm-Gg: ASbGncvTx7e2SKLb0OBXXakyTU1sZV/4m+TyxsYTwHhHYCppthw76PXj3KchyKV92F1
	wMw2P2uX8RfyVO0z4AZiYDUBYhUt/d3t6xlf1Gl67NFsXnDHfScN/6DOOcF2acQYo2020OCJqbz
	JfAFaGc2MiSA81ciK0dRsWZSxypR9f5xgBlvEe3i4HTEQGMSipOWF/gregZTxqMyTKLuzpkOH9a
	hBCvpTSXjKzwDFeC8r//k2PprThb9XWOazI9A6cryl3K4NmvNbE9ybCKE7m3+QWjQOoyQQivTNv
	Yu5x+TYzfPEHAyFSZ8RU4aqU4++XY8NvX0sdgmMYvJxTZC7G+B1cJZ+dAae41657PKnmZ/hrzRp
	UEPF8MScRnTWG3KUxae1/p55nH9DALXeaqA==
X-Google-Smtp-Source: AGHT+IGSnG9IOxyVXkA7R8/Qogm83gwm3iuaSrJojr9FCLdL/3fM8Gwasfk6/jvEkT61eycE1U4GqQ==
X-Received: by 2002:a17:907:c248:b0:ad5:3a97:8438 with SMTP id a640c23a62f3a-ae9c9b5b350mr48423466b.41.1752604111582;
        Tue, 15 Jul 2025 11:28:31 -0700 (PDT)
Received: from tumbleweed ([95.90.185.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm1039562766b.158.2025.07.15.11.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:28:31 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/11] staging: rtl8723bs: remove function pointer hal_notch_filter
Date: Tue, 15 Jul 2025 20:28:06 +0200
Message-ID: <20250715182814.212708-4-straube.linux@gmail.com>
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

Remove function pointer hal_notch_filter and use hal_notch_filter_8723b
directly to reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index eb34e39f3c64..a168852cb6c7 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -292,8 +292,7 @@ s32 rtw_hal_xmit_thread_handler(struct adapter *padapter)
 
 void rtw_hal_notch_filter(struct adapter *adapter, bool enable)
 {
-	if (adapter->HalFunc.hal_notch_filter)
-		adapter->HalFunc.hal_notch_filter(adapter, enable);
+	hal_notch_filter_8723b(adapter, enable);
 }
 
 void rtw_hal_reset_security_engine(struct adapter *adapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index a6eab2819535..b746e3e05d16 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1267,7 +1267,7 @@ void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter)
 	rtw_write8(padapter, bcn_ctrl_reg, val8);
 }
 
-static void hal_notch_filter_8723b(struct adapter *adapter, bool enable)
+void hal_notch_filter_8723b(struct adapter *adapter, bool enable)
 {
 	if (enable)
 		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) | BIT1);
@@ -1316,7 +1316,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	pHalFunc->xmit_thread_handler = &hal_xmit_handler;
-	pHalFunc->hal_notch_filter = &hal_notch_filter_8723b;
 
 	pHalFunc->c2h_handler = c2h_handler_8723b;
 	pHalFunc->c2h_id_filter_ccx = c2h_id_filter_ccx_8723b;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 3626e1505848..72ae4cdcf0dd 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,7 +162,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
 	s32 (*xmit_thread_handler)(struct adapter *padapter);
-	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
 	void (*hal_reset_security_engine)(struct adapter *adapter);
 	s32 (*c2h_handler)(struct adapter *padapter, u8 *c2h_evt);
 	c2h_id_filter c2h_id_filter_ccx;
@@ -282,4 +281,5 @@ void Hal_ReadEFuse(struct adapter *padapter, u8 efuseType, u16 _offset,
 void Hal_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type,
 			    void *pOut, bool bPseudoTest);
 u16 Hal_EfuseGetCurrentSize(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
+void hal_notch_filter_8723b(struct adapter *adapter, bool enable);
 #endif /* __HAL_INTF_H__ */
-- 
2.50.1


