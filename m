Return-Path: <linux-kernel+bounces-783037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C01CAB328A2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2011C27AAE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9150274B56;
	Sat, 23 Aug 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eql9XZPy"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93362641D8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953029; cv=none; b=gC4LXVtKdBtaojZi+DuM0u+xJPLnp3FDZKTklF/W3dXiAZF0+KtuirefvxQpRqCgWGJ3hOkf9C5TO+swEaGQc1TVmri7EpsWuooWW7YqHOerDbdN2g8baHC43BD7pysonj4XTgfnf3Ii1/0NzAWUFP5ut2ov+Sgn8MxdwC/woGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953029; c=relaxed/simple;
	bh=1iD4N72zpEvrDT/vkabmBpqrXAD7v9kigY0P6Ya3BJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuiSnYnzJp6ZLwkJnd3SWbWaVscVgpLnkjDENckSzWnpRwrk/pRDIZNoYJEduy9F5LUEDt/vQ8E0zHlTSCq7XNR+evg6dFalEwb4xuqK3USYJqLt+Z+o2Zoacw+EwWmf9ZOie5ljrywZfCdNQ7K7EX4GKjZ8xnYq7jGllKRIkrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eql9XZPy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b6f501cso3335495a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953025; x=1756557825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OM/rkBuH9r5TAbmD24hZvuqqZlQB7lq4axdod89JEA=;
        b=eql9XZPy6cAxwTIDqpq1jWZRYxOOxekBHrJU7x1TFi64RWwDj1g2vTg2O6TbfzK1IW
         QVZktPcmpj13Rrr6tt7Og7ux2Puvntsntgk9s7N8bEEPnisnwtl8VJPl9hk39K+9VtrX
         lZO5afP5gElMc8rUUfy56JB6jkuXmYpoEqEkwzNW7c91dyHowK0PFyijbDOqzmn0rth7
         jlR9HTT3JljOG6ALkshVm8odSXvBMiM6mrqfwyy94s5sPbd0011A9sDSM3IkWzUxmCsj
         jRvhLokHFItPi+lkfy//BZZLuc86oYBwjfmeuZwRw5/NLzmLjWjakNoscWK5QY6jYd3J
         GQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953025; x=1756557825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OM/rkBuH9r5TAbmD24hZvuqqZlQB7lq4axdod89JEA=;
        b=eTMDapzBbV/5YIAN7tI3h84OkiZpV07eZvd7ojqwsB1/WqSxUmws9ur+sFfi6Qks5I
         iZeOENoPNN1jItNqk2Tw+hkwsi2vDuTBtb/BiV7ZKUhtvcavxy2hIbWmZARnaEifWwby
         gUXtJAR1f0dw0KN3cB4Qq7k+WWMqlpUFKGJAitGqvdnD2cltcvyJ3VsfCa8yMRBqrSQN
         83Ja7cIN8SeQoAXlwF3XdL/+G/PbJ5DLd7lAUpGRrJLdKsfJyY07R6PtiTbWmjpcVy+n
         ujkpZq2GUw2BbCQ1e++yau53F7XFkux5WZNxa5C3rAq/EI82SBO9va0FuoxjddvP5j3t
         hwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVje2BqQumW8aA/b28ZqVSYtWYbVVk5IPtjbbMFgvzwGULFfHmsEq7lUVb8tNU1TN+qyOMPHd7Wm7KeEMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1T9WifzVRK2gT6i0ssqwBmvOd82a4egYgL5LCwI4VaNmKiA1A
	pXeQhEl/Se6gjze9y1KW5CEOAahyc0UiCa71Ir/agW0eSTN9ARNEc6Cv
X-Gm-Gg: ASbGncsYF7P2EJwRS1SEhdDZKw5wmgSVOYH9bDZCnHfS73CJvWSkhmCURGIWk7Fz/MM
	bmoewrHFRMTv+ZRqFfcRiL6VqF6z/x7JuNa+BUtBconOpdDufppVL/wpB00a9ZJ5wy+3cqLKEUx
	pkJAvoM6V8iuJ+WkCu6LuIpETE1FGtQ9CneXSACgknF+NnEcofEntcJTb5byfhRCuCSv6MNSCzV
	IvHwLdtxvZ34lipS4n/G0NrfBPBkuxR+oRZfHHC3ZSFb0aa8NbOg4KXBLlBlJGCs7j3UWZa6bTo
	dAleNqXiYzCaL9o+q6U1NzsH5UnPag/TgkrQRYwh9I79B+KCFQzkgK0m/opp/32HcSkzQ2+EDL2
	jzTrQJFAiWEh85hKEHQOAQvHolfLaMPYeIM0B
X-Google-Smtp-Source: AGHT+IF+fUUJ00qonInRkhsPMbg8I8eHguAEM0CaE8rrqXu0ZRPWU8WGRNM2MArAExnDQI9PVF7R7w==
X-Received: by 2002:a17:906:c10f:b0:af6:3248:62bb with SMTP id a640c23a62f3a-afe29046a6amr581207866b.30.1755953024916;
        Sat, 23 Aug 2025 05:43:44 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:44 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 13/14] staging: rtl8723bs: remove bPseudoTest from efuse_OneByteRead
Date: Sat, 23 Aug 2025 14:43:20 +0200
Message-ID: <20250823124321.485910-14-straube.linux@gmail.com>
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

The function efuse_OneByteRead is always called with bPseudoTest set to
false. Remove the pPseudoTest parameter and reomve resulting dead code to
reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c     | 18 +-----------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c  | 18 +++++++++---------
 drivers/staging/rtl8723bs/include/rtw_efuse.h  |  2 +-
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 9d065721c28a..c4542e00c730 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -29,18 +29,6 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
 
-static bool
-Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
-{
-	if (Offset >= EFUSE_MAX_HW_SIZE)
-		return false;
-	if (fakeEfuseBank == 0)
-		*Value = fakeEfuseContent[Offset];
-	else
-		*Value = fakeBTEfuseContent[fakeEfuseBank - 1][Offset];
-	return true;
-}
-
 static bool
 Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)
 {
@@ -158,16 +146,12 @@ u8
 efuse_OneByteRead(
 struct adapter *padapter,
 u16	addr,
-u8	*data,
-bool		bPseudoTest)
+u8	*data)
 {
 	u32 tmpidx = 0;
 	u8 bResult;
 	u8 readbyte;
 
-	if (bPseudoTest)
-		return Efuse_Read1ByteFromFakeContent(addr, data);
-
 	/*  <20130121, Kordan> For SMIC EFUSE specificatoin. */
 	/* 0x34[11]: SW force PGMEN input of efuse to high. (for the bank selected by 0x34[9:8]) */
 	/* PHY_SetMacReg(padapter, 0x34, BIT11, 0); */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index ab30d2598825..94492743ea34 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -679,7 +679,7 @@ static void hal_ReadEFuse_WiFi(
 	hal_EfuseSwitchToBank(padapter, 0);
 
 	while (AVAILABLE_EFUSE_ADDR(eFuse_Addr)) {
-		efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, false);
+		efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader);
 		if (efuseHeader == 0xFF)
 			break;
 
@@ -687,7 +687,7 @@ static void hal_ReadEFuse_WiFi(
 		if (EXT_HEADER(efuseHeader)) { /* extended header */
 			offset = GET_HDR_OFFSET_2_0(efuseHeader);
 
-			efuse_OneByteRead(padapter, eFuse_Addr++, &efuseExtHdr, false);
+			efuse_OneByteRead(padapter, eFuse_Addr++, &efuseExtHdr);
 			if (ALL_WORDS_DISABLED(efuseExtHdr))
 				continue;
 
@@ -706,10 +706,10 @@ static void hal_ReadEFuse_WiFi(
 			for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
 				/*  Check word enable condition in the section */
 				if (!(wden & (0x01<<i))) {
-					efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, false);
+					efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData);
 					efuseTbl[addr] = efuseData;
 
-					efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, false);
+					efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData);
 					efuseTbl[addr+1] = efuseData;
 				}
 				addr += 2;
@@ -772,7 +772,7 @@ static void hal_ReadEFuse_BT(
 		eFuse_Addr = 0;
 
 		while (AVAILABLE_EFUSE_ADDR(eFuse_Addr)) {
-			efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, false);
+			efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader);
 			if (efuseHeader == 0xFF)
 				break;
 
@@ -780,7 +780,7 @@ static void hal_ReadEFuse_BT(
 			if (EXT_HEADER(efuseHeader)) { /* extended header */
 				offset = GET_HDR_OFFSET_2_0(efuseHeader);
 
-				efuse_OneByteRead(padapter, eFuse_Addr++, &efuseExtHdr, false);
+				efuse_OneByteRead(padapter, eFuse_Addr++, &efuseExtHdr);
 				if (ALL_WORDS_DISABLED(efuseExtHdr))
 					continue;
 
@@ -798,10 +798,10 @@ static void hal_ReadEFuse_BT(
 				for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
 					/*  Check word enable condition in the section */
 					if (!(wden & (0x01<<i))) {
-						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, false);
+						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData);
 						efuseTbl[addr] = efuseData;
 
-						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, false);
+						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData);
 						efuseTbl[addr+1] = efuseData;
 					}
 					addr += 2;
@@ -1475,7 +1475,7 @@ void Hal_EfuseParsePackageType_8723B(
 	u8 efuseContent;
 
 	Efuse_PowerSwitch(padapter, false, true);
-	efuse_OneByteRead(padapter, 0x1FB, &efuseContent, false);
+	efuse_OneByteRead(padapter, 0x1FB, &efuseContent);
 	Efuse_PowerSwitch(padapter, false, false);
 
 	package = efuseContent & 0x7;
diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index a5c338c67245..1cee7a8eedf2 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -91,7 +91,7 @@ extern u8 fakeBTEfuseModifiedMap[];
 /*------------------------Export global variable----------------------------*/
 
 u8 Efuse_CalculateWordCnts(u8 word_en);
-u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data, bool	 bPseudoTest);
+u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data);
 u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool	 bPseudoTest);
 
 void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  PwrState);
-- 
2.51.0


