Return-Path: <linux-kernel+bounces-740412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07DEB0D3E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5E93A233E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061A2E267B;
	Tue, 22 Jul 2025 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfPApN1r"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3662E0902
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170092; cv=none; b=hTXxOswRkq8/QG7nAD2N5SsP36mikcwhKmgytdN3FUa0VGrRb9Hk99fPIvQUjWNFBXzGCeIYgo87iSVRvRpgP/5Or2l2PYG6RYcdTCEYZIZai3wz69ms8ziUv0unTNsLQhYej+2atZ5Z1C8IHbArdWQsKuosCdstGgsnxfLA8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170092; c=relaxed/simple;
	bh=SyYOr2zV6XxG5xIVDOSbyAo9C7BbNCREXuZ/bamKzU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p78NW22eQitJ+jM1JyVfKhfvRDs02VnQr1HOpbIxaya4qCP5jcLC70nWreW8S1bCyRcphq5Az7rYaaxpQl/W4cuz6kyC8BGvO+2TVCzgHbCxkdb56xLwVA0feWc8EQ+jl68gFaZ1FEWh12YHZSy7VqCr0+LdWp02mzIl12+boLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfPApN1r; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aec46b50f33so890593766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753170088; x=1753774888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGU8KfFDM4IZZr2GDAlyAqDQq8y18Wqb22CKVd1xvY8=;
        b=QfPApN1rg8ULsiyHkY4M0PJmpR4ZK1+4c8bx5NqyJzOMDKPi7KBCwY8vDnvlq9W3m9
         +zfN1M3lLKOQOsfXz0gxC7SkyMvPiXsF/Bl7HGL/xh72ko0+OpytR+BhqhiNxdTCs/kL
         Z+8i2J9FPhUyTMTgZzhkb3QgPcZ8bW4z+uYmOLIqa9nui0kvdMcZbwq2mgfNFJLAi0XV
         oCh5ip3hhBuY1UdoSHS3zixda79CpdgiflCso7It3xzoUGt/v8abzTCPPwJFMRVz47Tn
         8FW/tqT2M3DDC7EO/7g6leeSc6/LyWZbf1hI2Up8oFRd04DTP6vdf7yDpAoL5Bg3zEiG
         iH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753170088; x=1753774888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGU8KfFDM4IZZr2GDAlyAqDQq8y18Wqb22CKVd1xvY8=;
        b=wSrirFudIlBeAREeZjJki5XA/NSofW6UIgnRpXp/JPgkWxB7cXTvR+rUOAEXOj+QTz
         TX8aSU9FSM/RlFgY2i1ua9xvXfB4JWYkgT7Q4uP2w4KatcbtwjPkVMbzyFeg0zMkISqD
         PEU9gCE+qU00rSX8LSDkdDKLrBDDsBdFJ9zikrnTNBzElvUb+YzJuorGWjDaKBymlGds
         8CbQt7n1PyAZFWW8bEmULXVl2YpEisX+HDnBrI7oG4Csiy/kdONwmrg8gna5Jn8vdi4r
         UJwr7ol8G3hB5UoU2Afh7ynY72Fd+k21M5kYnOMWP0xgRJkgTyUukK7YS+PYtSXwW25A
         6/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWolp7atfjv2lMUpLUWdr2rns+eUTZsnxUL9Ou8eLEnfTEpOlTTq7iZzEIvq1F5dvwb98KVXgJhzH9LTaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6GK95+MCjpW9kb6XBV+R+O5CzKI38tXBzeMuYkTAPjIECchp
	snY8Rtc++dVj9pHzjbjmL9Tm8Xp07fLW8850MUCCpT6g0AOgc0ylN34w
X-Gm-Gg: ASbGncuLqHGD4dSt4ZOo0IJXMdiQqiBkuHQqzX7Aph++DabpihUmofSRSaSfk07UpV7
	jLAZvM2LpZbS2oWcmcRaZ+NAIGam1y6JHnLmXCubNlP4OjY/6GjNIf3/PgbIBKchgd8Yj+GVxAd
	kTLQ+RP+kI9JhcReliUQ4LRe4sfOBUmUXhdLxt2qR+pxFvHouaG7+oBLEFceCrn93NPit1t7Qr4
	zbgsQC81DYZz8IyGCgr0g+6xHwqEh2SACbltFfoj6eBOYvgPsAh4Vw4DIelb8RgP/mKz2nMxMcQ
	Pp20jxFxSY2DjIBFcLNqyV6iNlRSpxgWJ2OeM2X9FdmJp+W0ern1fKXn6S+tcJhAMH6zfOBoXcC
	LHYmMd5MdW4f5G/zuAA/aALg=
X-Google-Smtp-Source: AGHT+IGDSya8s9ywgwmIycnqxfqEdjtBFsT7b2LHbPorWjslOCCpbtsVDGoOXd2sca4tKDRZhAtDKA==
X-Received: by 2002:a17:907:cca3:b0:ae9:bf1c:50a4 with SMTP id a640c23a62f3a-ae9ce078f47mr1615975666b.36.1753170088409;
        Tue, 22 Jul 2025 00:41:28 -0700 (PDT)
Received: from tumbleweed ([95.90.185.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79d6c6sm821224666b.32.2025.07.22.00.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:41:28 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/7] staging: rtl8723bs: DoIQK_8723B is empty
Date: Tue, 22 Jul 2025 09:41:15 +0200
Message-ID: <20250722074115.35044-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722074115.35044-1-straube.linux@gmail.com>
References: <20250722074115.35044-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function DoIQK_8723B is empty, remove the function and code that
uses it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf.h       |  2 --
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c | 10 ----------
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.h |  7 -------
 3 files changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf.h b/drivers/staging/rtl8723bs/hal/HalPhyRf.h
index fdbdd68edf2a..1e79ab9cb773 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf.h
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf.h
@@ -15,7 +15,6 @@ enum pwrtrack_method {
 };
 
 typedef void (*FuncSetPwr)(struct dm_odm_t *, enum pwrtrack_method, u8, u8);
-typedef void (*FuncIQK)(struct dm_odm_t *, u8, u8, u8);
 typedef void (*FuncLCK)(struct dm_odm_t *);
 typedef void (*FuncSwing)(struct dm_odm_t *, u8 **, u8 **, u8 **, u8 **);
 
@@ -27,7 +26,6 @@ struct txpwrtrack_cfg {
 	u8 RfPathCount;
 	u32 ThermalRegAddr;
 	FuncSetPwr ODM_TxPwrTrackSetPwr;
-	FuncIQK DoIQK;
 	FuncLCK PHY_LCCalibrate;
 	FuncSwing GetDeltaSwingTable;
 };
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 81149ab81904..34692cca33f5 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -142,15 +142,6 @@ static void setCCKFilterCoefficient(struct dm_odm_t *pDM_Odm, u8 CCKSwingIndex)
 	}
 }
 
-void DoIQK_8723B(
-	struct dm_odm_t *pDM_Odm,
-	u8 DeltaThermalIndex,
-	u8 ThermalValue,
-	u8 Threshold
-)
-{
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	odm_TxPwrTrackSetPwr88E()
  *
@@ -353,7 +344,6 @@ void ConfigureTxpowerTrack_8723B(struct txpwrtrack_cfg *pConfig)
 	pConfig->ThermalRegAddr = RF_T_METER_8723B;
 
 	pConfig->ODM_TxPwrTrackSetPwr = ODM_TxPwrTrackSetPwr_8723B;
-	pConfig->DoIQK = DoIQK_8723B;
 	pConfig->PHY_LCCalibrate = PHY_LCCalibrate_8723B;
 	pConfig->GetDeltaSwingTable = GetDeltaSwingTable_8723B;
 }
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.h b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.h
index 775095ad0921..c83442917f9d 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.h
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.h
@@ -18,13 +18,6 @@
 
 void ConfigureTxpowerTrack_8723B(struct txpwrtrack_cfg *pConfig);
 
-void DoIQK_8723B(
-	struct dm_odm_t *pDM_Odm,
-	u8 DeltaThermalIndex,
-	u8 ThermalValue,
-	u8 Threshold
-);
-
 void ODM_TxPwrTrackSetPwr_8723B(
 	struct dm_odm_t *pDM_Odm,
 	enum pwrtrack_method Method,
-- 
2.50.1


