Return-Path: <linux-kernel+bounces-783550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EC7B32EE1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1462041BA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858926CE32;
	Sun, 24 Aug 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxXFUOSu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A140269806
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756029523; cv=none; b=Zby6Scu4gw9vFQ1//DRmoh6LykOTY/VCJQbHdHQB0BlTSNatq/SPNgBL/92IZQiDUJittW70VS3X4lJzmK6NVIj25Ea0lNoDGl6sR9wY+z+FhRqw7+OWti9bgJ3meaPy7mEs2vF0bmm3t+lCQpUDbp0ak+Ig/Ibac8UNlbA1CG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756029523; c=relaxed/simple;
	bh=qCuohedTig+dBflD+bJqbTY8MVe0rkaexM5kYM0D4ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGk2U7kIbiMcXoLfXMYlgV8Oj3oP0cvIpmvNMojYXqG6EdUXFg/yk7otU+UlFfO90FrntFPQ0qDWsJRfmLCoOzSZwLS0ABED4/OC0cIPTUBw25aGWI9cd8sp42LY2g6/AvyoHhACrgIl50bQm9+qzGJ0mLchebLReHD9wTMH9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxXFUOSu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a0442bso553655566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 02:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756029519; x=1756634319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvYsuGKgwDJ3CdZTywUVsaFMO2gJDf2toz0PGf3ll9M=;
        b=FxXFUOSu640QA8VBpmhks0HmKGXVtBtaQ7rWaecww9ni7pk6Pyu0fe+BWKux5YG8b7
         pXuMoliOeYjIVxoCiVWDV/imsu+1UOP67hrfGYEj/wM+8P2y8VdJVTksfvmwRTPf7iZD
         6N3PJw5xryfQlpz0wFxw25VzV8T5+TqqcbOtM337OjgiHCyqlrdGArhEgVYBbe4hMEm4
         qEg3YUkS+2QziWRBljvzlVb9joKinsE6ZOYh9wanQTzvHFCPgxdQgpkHsPnM+rLg40Gl
         EjPa4ztQFJiXi6rGqaZDpPpyImct7Z4ecJesMnqelMgXowjQMM2/WLHH3O9OE0Qm4IK7
         Ct3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756029519; x=1756634319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvYsuGKgwDJ3CdZTywUVsaFMO2gJDf2toz0PGf3ll9M=;
        b=WAj5Is5/mryB9JJ8I/CTO3YqL5wUMJDBPz/kmST9wMc7kAap30dtn+ns34F+nEwTAg
         NIFydM8eLsE5m26xeddq+oulWKZ7tZ9jurQS4aJlISNc+eEz01CcyU3b4IUvxFMritq2
         BETSf74gVWIZe8zEJlHtApWHvr7XKximrz394dEq/PAwb6JroQPjY77yBzvurWnmaXg2
         CxSdreEn/BFU7aQknUSUTQVjb1MG9tmevulWvaqaRdn+DJ/vcsVGw5DkRCHTI4DyV010
         X3RQaZdCNH50T6arzNHD/W+dqhAVtQLwp7aXf+zmj14WPn7HHSYKzlMh9PNPaNYAydeM
         bfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrHeeEFVZzD2i5LFMtcxuqpKU9q6MI50csul8wDTx84DcI2bRimyiGRPmRZD4RoXfuSI2s6cH+AopNVU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+dpWm+T4TKGhCzfdo2dyxyQKm/tNG3rFYTDKBJMNicHp2aEwm
	lQiAv/E+dU4vO1wQFUB5yzfNO+MQBUjlh9Oos/fRbwuILPisdzqCOBR6jFb1eg==
X-Gm-Gg: ASbGncuCzx/+pQtfYYmkj/DhZRQ7u6WOYRYMfv/NB2H26LwEgLyQW/j50UjivqN1Oq2
	oy8EEqGPRPjL7FZ9nYL6t+aHH8A7UhLUv+vwFH8pArPIqpeYx4rmldp3nanEE1WPt7CVnW7ofrv
	/Q2jhCiEdGh1/Av5Bc3bLYK8k9Mwr85jPaUIMdaJT3SAtnz/EWTMnM1zlQO2hfn4lWyBq/DSIcR
	n/nhWo1P/5C3P9NXvgGIeK4AZPf77jzWkex8GKL2hkmTIcaIlBRlBb+RCO7Ghco6Lx2lCBwFcmT
	bjuNBQgrZxyKR8S3U36HnDQArFYCEy/x4HytxWng183sWLR9wmMiWkFNrtVwon7+RjRLVZtuIoP
	MHHYSMFuySRZDXDFQpXY9JnL+tw==
X-Google-Smtp-Source: AGHT+IHUgjHdJG8CmX711Go0qGjiVzBIzdUGCqALRPhnVIpluUA/K+SKc88aZMbU60nTK1rgX0/ztg==
X-Received: by 2002:a17:907:3f08:b0:ae6:f163:5d75 with SMTP id a640c23a62f3a-afe28ffbfcemr819307966b.11.1756029519535;
        Sun, 24 Aug 2025 02:58:39 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe79fba62dsm41314766b.100.2025.08.24.02.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 02:58:39 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8723bs: Hal_EfuseParseAntennaDiversity_8723B is empty
Date: Sun, 24 Aug 2025 11:58:30 +0200
Message-ID: <20250824095830.79233-5-straube.linux@gmail.com>
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

The function Hal_EfuseParseAntennaDiversity_8723B is empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 8 --------
 drivers/staging/rtl8723bs/hal/sdio_halinit.c      | 1 -
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h  | 2 --
 3 files changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 45cd2291f83d..18244adad9e0 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1511,14 +1511,6 @@ void Hal_EfuseParseCustomerID_8723B(
 		pHalData->EEPROMCustomerID = 0;
 }
 
-void Hal_EfuseParseAntennaDiversity_8723B(
-	struct adapter *padapter,
-	u8 *hwinfo,
-	bool AutoLoadFail
-)
-{
-}
-
 void Hal_EfuseParseXtal_8723B(
 	struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail
 )
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 73561a63401e..7fcb874d0eb3 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1071,7 +1071,6 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
 	Hal_EfuseParseChnlPlan_8723B(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
 	Hal_EfuseParseXtal_8723B(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
 	Hal_EfuseParseThermalMeter_8723B(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
-	Hal_EfuseParseAntennaDiversity_8723B(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
 	Hal_EfuseParseCustomerID_8723B(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
 
 	Hal_EfuseParseVoltage_8723B(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index 40ff96d3cf74..2ed1fc8549ec 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -210,8 +210,6 @@ void Hal_EfuseParseChnlPlan_8723B(struct adapter *padapter, u8 *hwinfo,
 				  bool AutoLoadFail);
 void Hal_EfuseParseCustomerID_8723B(struct adapter *padapter, u8 *hwinfo,
 				    bool AutoLoadFail);
-void Hal_EfuseParseAntennaDiversity_8723B(struct adapter *padapter, u8 *hwinfo,
-					  bool AutoLoadFail);
 void Hal_EfuseParseXtal_8723B(struct adapter *padapter, u8 *hwinfo,
 			      bool AutoLoadFail);
 void Hal_EfuseParseThermalMeter_8723B(struct adapter *padapter, u8 *hwinfo,
-- 
2.51.0


