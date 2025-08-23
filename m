Return-Path: <linux-kernel+bounces-783027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D0EB32891
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183781BC41DE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6E264614;
	Sat, 23 Aug 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz+OVDsS"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8225B1FF
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953023; cv=none; b=Q5jTSwJbUJnxaeMzUr6DefV3YsyqZnlMydlmGJ8F7mYoxLJt6kpUv7nngl6U2duTiTXtrWvfXpyb327ZWTzRPDPt8amomcZRJDnQsXMh7ToDkmbx39SqiVmSALuvcMp6df3SAqYo7ZNEnu8Mcn8utBaXy75sjybPe7zbHkVctCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953023; c=relaxed/simple;
	bh=roanaskB8oiM/AncCs6OPMtvzR+UvubYsGnl124M0yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6yrSPpIIAx2ITfHFPkP9atS1f9AI/SsqmjhgA1+AYTUG/ejY36eRg10ZyIpWO76ojp5xBLyooGIYG2PjLFLkz9YGIBsAIbcjYg56X+ioY3l/M7xMrvkwa0wXVmvvAujhE6IL9m9KSzQLn5theW3pw+NX2C7oXG0BhC73XCuylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz+OVDsS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a2befdso424518666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953020; x=1756557820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhPbh306uA+mZWGyZJvI2krS7O9T1n16n8YRZur58lw=;
        b=Nz+OVDsSseUnTdmLHR4hFCYDY2K6peVn43sF1OC/XlpDcENxAhhOMgdr/EnVscxGMB
         /ylX/8QQthX5RhsWFBtFohNzD1SmOO3D8NoGf95viif2FwRP9en0Wrf+xKDx82zVIvOS
         IG89L17mRleXPePJzCRGhweuTb5cp0R8zsgOQciseinQjDCJEt6DiFBczIaIC1Djvbpk
         3xgF2AkaDLiRuRpR6YDbX8mWxL3IIodoq2Kw6jtuezT4rjaCRUJmVjp9/XCqYHsHh5IX
         kCpDoqkyjFtD7OPoKOxegnX/DPaJuFSrFVXtRn+sB84pYkdsyFRyIs+1Ly/tgvH9T7wV
         tVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953020; x=1756557820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhPbh306uA+mZWGyZJvI2krS7O9T1n16n8YRZur58lw=;
        b=nxpKxB5kWjEv1+kZPcWGEe6bqGbV70+5gebVC7TFlb1NbRrFeEVWW6wm+kk9VBoyYA
         y3nlpNxBKsznN34IntExr8KlAwG4DWT8Obf52xaNvjMXGo/hP05OA5oEIpQmjlUVVpeu
         QZMvMyUYTrnFXIUz1STCvJ2Mirtqxuno7Yw5Faq6gvdHEmHUrWrgYgJjEJ7LNaEEWwHX
         HMSdFYgPOtrlezTvvB9RolX5/WHzh0WpXaL3a0QCUC01Hpcl4q3pwWx9i3r5I46c4SAC
         AKkndkH78lzd+mnbHGO4SzL3G1VFOM+lmCoATFE+aH0ZC1LZJ6qp7mamMwsp5AxEpLVJ
         SMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBcBzx/hq2iSws1E6yrNOip9bP/8+KsjCDsnEv1ZEcX5s1VWFe4hv2EokE+/bKdkdz4j95BQZXZx2TojA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy716dU3+j+56lJV1oYmagApqNXTqP16gUp6BwDVn5X9GGej27V
	Vk/0/fAjPFF5y99qmQb8alA72DV11BC+PAUnMSTfN/WmMQOQy1E4giKq
X-Gm-Gg: ASbGncu684QF/+RSFCukBWPWxYhxxaDunWa/eDkW+DH2rhZPdPSdNrkL9InIDOQt0/X
	j1THE6w4i+2+YMwGVH/05LcVnKIFo7kQqpP5LJ5Jdzz4t2K6YbGNTcW00bnQgdMsCc5eik3QUz2
	qCs8eqZfD4TvT0PLPGAHfBh8YsWDiN8NTqibXkXQNOWUL6QoRL+2pZP23KYjyuAv0JPmuArIo/P
	gXanpqP0lzY0hkFUbU60iXrI/MuVpIrD/AOHHAfBhPa2fIijbbqBv/ICWmgRgdM4023Mhos1IHN
	BdCb4R6ZsXMiBpd7Vn8ep+sLT5y5Ysttum9arnOyfZ7Ac4jJZNh8ejjHT+pvT+ND4uu1ye71RFh
	CuTCu64cj1sJefTvBE4K4LUdJEQ==
X-Google-Smtp-Source: AGHT+IF8QpcsQjg3wQz9UpkXvukBigrUxbie1Cl/dEgUT/7krFaNF7F4bkJeHH7UN63rH251d5SH+Q==
X-Received: by 2002:a17:906:c10d:b0:ae0:a590:bc64 with SMTP id a640c23a62f3a-afe294c7236mr550080266b.18.1755953019782;
        Sat, 23 Aug 2025 05:43:39 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:39 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/14] staging: rtl8723bs: remove bPseudoTest from Hal_ReadEFuse
Date: Sat, 23 Aug 2025 14:43:12 +0200
Message-ID: <20250823124321.485910-6-straube.linux@gmail.com>
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

The function Hal_ReadEFuse is always called with bPseudoTest set to false.
Remove the pPseudoTest parameter and replace its usage in the function with
false to reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c        | 2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 7 +++----
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 1079e2bc3287..388d885c938f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -271,7 +271,7 @@ static void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse)
 
 	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
-	Hal_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse, false);
+	Hal_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse);
 
 	Efuse_PowerSwitch(padapter, false, false);
 }
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 4a0423182f9e..002648a8fd81 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -883,14 +883,13 @@ void Hal_ReadEFuse(
 	u8 efuseType,
 	u16 _offset,
 	u16 _size_byte,
-	u8 *pbuf,
-	bool bPseudoTest
+	u8 *pbuf
 )
 {
 	if (efuseType == EFUSE_WIFI)
-		hal_ReadEFuse_WiFi(padapter, _offset, _size_byte, pbuf, bPseudoTest);
+		hal_ReadEFuse_WiFi(padapter, _offset, _size_byte, pbuf, false);
 	else
-		hal_ReadEFuse_BT(padapter, _offset, _size_byte, pbuf, bPseudoTest);
+		hal_ReadEFuse_BT(padapter, _offset, _size_byte, pbuf, false);
 }
 
 static u16 hal_EfuseGetCurrentSize_WiFi(
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 67d51e55bd44..2e97a918445c 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -267,7 +267,7 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level);
 void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter);
 void Hal_EfusePowerSwitch(struct adapter *padapter, u8 bWrite, u8 PwrState);
 void Hal_ReadEFuse(struct adapter *padapter, u8 efuseType, u16 _offset,
-		   u16 _size_byte, u8 *pbuf, bool bPseudoTest);
+		   u16 _size_byte, u8 *pbuf);
 void Hal_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type,
 			    void *pOut, bool bPseudoTest);
 u16 Hal_EfuseGetCurrentSize(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
-- 
2.51.0


