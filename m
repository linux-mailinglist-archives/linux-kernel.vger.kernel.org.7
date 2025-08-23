Return-Path: <linux-kernel+bounces-783028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEADB32892
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748CE5A87B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E51268C40;
	Sat, 23 Aug 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvt//Sai"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB09258CEF
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953023; cv=none; b=tgYaIdRdMJA26S4SMq1AN7+bgVX92XSZOTXPqc8X9HSudMVazx/n83uIshpI5DQDG40iSIDVvIMzaIOVTx3stnA/AG8vz9gz1c0UIq/bcXK46l9aO2raDfCO1RQk0beURqK/HOkqZG73qWHEMyYSQjMrKCJ0NvBC4JKGAZW8QYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953023; c=relaxed/simple;
	bh=B5WuxuwbtaSLBjDtJWQ/gsFwN7RDDeo7jZrKiyfSn6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i29jn+T1oybNssbLnDFXuED0ox6M2bGolbJfWn0wCrg4/JKE581UAiu7JWIYlF7vM+eTkYIvToXCayYD5s49oKhHahhrlgV8PWZWWiumVa5iuyBDjayn8zhq2ES1Y5rv8hqBYXLo7SZLSHIhPT8RIJv7m7DjX/BXrtnRUACpMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mvt//Sai; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb61f6044so555347266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953019; x=1756557819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9og3+uRw64r/MDppjSYN2NDzI0VJAzl5jXkEcD/Diyo=;
        b=Mvt//SaiQuq+J/Tp9HlLQJaQgZbmMw4Yni0NdRpFoHI4GaWpOXC7Phkp+ZgyJoyToJ
         mOYDZNPcq51nB/4Ws4P6sHft3o5hbSl8m+v4aiojP0yFzhYZq5REkffZQKUVGWKZX4V3
         B6Ph6GL+D6ZWxVmo6m5xnWlQbva5NNESU33DVDEToE37RQoqBirGMRP9tiqnmW7P3EHo
         Y1PY881gXpIYTqS/wCjk2BgyUDqmSxGw0bn3BbFvQYh3uvPopZHMn481TuVCIlqL4Wyu
         0K9DfZ6/YACDKxNpS5LfiyYbbWzJnWssYUFr+m8wJSLD33ZBP9QLn+V1sztmNdHOnw4s
         ZNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953019; x=1756557819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9og3+uRw64r/MDppjSYN2NDzI0VJAzl5jXkEcD/Diyo=;
        b=K84jB2LicQ8Ynwehx2VI1oEwjrG5vsY0iIjgGYCdeYAs+1MoiBAp5AF9gjkqsMLbm+
         1gnWh6cQ5MXL05Oi+IYE2Uz69JBJ2+StBHV9Zjuw7ohH5vLk2swF+SNDh8W0GFwC99Hi
         mVs7e3Zb582X/nYB1sJ/uHt7qGW229sRXzAF8LdGTonzmiHG/zt5lZB1zv9PvvGzPClI
         NNHpaoonogPescc68tC+nutsXJahHCJapPn7euoogKGehIk7XWwL5Z+jYj8OBzUGVD4g
         KMAmNSzdMc+v/u63XxkjXiid9a6rGGIaZQTQ7GNmhkqBXZ88MNIq8DNWyP9B0S9p7CQt
         m/eg==
X-Forwarded-Encrypted: i=1; AJvYcCUJg9XNhwKs9J+H4fzcPSAz4zrwaL2ZsyXzvisXPvwY8baYV/+Pl7O+dpSzWLly45QijmbXIig3TDpqcpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyam23iqgqiLeEAdFaYJ6VPL+YQ4R4Cx00U3FWZq6H3NG4xSSGB
	PGIdozo1gcWk4jOiHOv5f62RX9WGRpLGBVvAupN38Y3XBaob/J1jC5P0
X-Gm-Gg: ASbGncvUAjH+EJJ6Lb7kDxkxJlmT22pwYU3QZYTz/0GOl6yM4pRsWVfgcl0FKVbR4jO
	3KFtVWfLHJo4ZjEz/Z7sRT3jlvgqeJBm5bj5cUbIMUO+KnqQdvku3ZnWIdBTnOY7SPym3C9f0C0
	m2LHw71zG/TTIT38uYY8CcCS3eya75eegLSRfBZ98Qy8k5WT3VRXW0Nf2gkP8WDXRL0RKRKIGT3
	jVpNZM5jG9ZOfeKzBCtnsGMrqxcmdgPKIFrVfdW455ZZ7JcxAxv/2mlWiiTw/9eNw4y17hPIfgn
	01GtzVIhu4HW2ULieOtZ0NuOp0x6BvyrfuQMARKkSb6ZCvlZpQC26cRzgmZjnTWqKs6uhPgXViI
	xzwxdSILxoqWU4zpukVu1iSXSNg==
X-Google-Smtp-Source: AGHT+IEq8dkXUNPFJ4bVxwzfFI0ohs17PD6BvkhvEnlnS4v8bLD4YT9K9JDLzB01tdP1ORVEKWzggw==
X-Received: by 2002:a17:907:868c:b0:afc:a330:3318 with SMTP id a640c23a62f3a-afe0afff566mr876260066b.3.1755953018559;
        Sat, 23 Aug 2025 05:43:38 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:38 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/14] staging: rtl8723bs: remove bPseudoTest from Efuse_ReadAllMap
Date: Sat, 23 Aug 2025 14:43:10 +0200
Message-ID: <20250823124321.485910-4-straube.linux@gmail.com>
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

The function Efuse_ReadAllMap is always called with bPseudoTest set to
false. Remove the pPseudoTest parameter and replace its usage in the
function with false to reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 2c0dc55fb20e..e865f83c0967 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -303,15 +303,15 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
  * 11/11/2008	MHC		Create Version 0.
  *
  */
-static void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse, bool bPseudoTest)
+static void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse)
 {
 	u16 mapLen = 0;
 
 	Efuse_PowerSwitch(padapter, false, true);
 
-	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, bPseudoTest);
+	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
-	efuse_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse, bPseudoTest);
+	efuse_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse, false);
 
 	Efuse_PowerSwitch(padapter, false, false);
 }
@@ -390,7 +390,7 @@ void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType)
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
 	else
-		Efuse_ReadAllMap(padapter, efuseType, pEEPROM->efuse_eeprom_data, false);
+		Efuse_ReadAllMap(padapter, efuseType, pEEPROM->efuse_eeprom_data);
 
 	/* PlatformMoveMemory((void *)&pHalData->EfuseMap[EFUSE_MODIFY_MAP][0], */
 	/* void *)&pHalData->EfuseMap[EFUSE_INIT_MAP][0], mapLen); */
-- 
2.51.0


