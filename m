Return-Path: <linux-kernel+bounces-783031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61899B32895
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46FD18990CA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AC426A0EB;
	Sat, 23 Aug 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYhXab7G"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771F25FA24
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953025; cv=none; b=BKnjkFD4RjKTYT8YBKe4gmdDjWTMu8+BU2QVUxMrn5cfuS354TZSvDp3RIh2T8Envjf7tqyvZ0hs4Qo20zkVs2lIpg4zUUReCsnWb/GHNLi4BDA4ue9eYJhBHKckll608IXcrhOGUnV7Wo1E8pyhWBcSPNl2wy5IAgsSDpj2Hi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953025; c=relaxed/simple;
	bh=PkXGQpIu3CT9MkDPjbhrfHERe13KeKCUlk4Eka85HsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8l6m2ekuGQ4h4yJnIb0ArO95fqHdowVy5RQ1QLnLj8CU2l05yE/G4D48NH0L/oMp0oA8Z3gluz/0L/kYYusQgPr34D+ZbKfN2MdQTVCOFSnfp5Pw8Pvddx5gwFmiCMKkTe2wXsRWfXNwzyhGsDVS4g+5n7ZMvxPm+KSBeZ1qNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYhXab7G; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb731ca8eso473013066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953022; x=1756557822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBvCvb23Z+9Bc2OcwtiN+FlqbAuREfquDJGcbDfAlSY=;
        b=EYhXab7GjBcbWuhcGvnOZK397CPKhwxX6MWZVxdnZiYukgi0pU8CWx/4taNJdV9+2+
         Akn+xaQC8psNfY1D2sBWU7IACZyEi1aHgsn+OVl078Xk5snGWRkon1nBKIQo31i9H32F
         OhVFyXdAKsuPeUb5vABnalkBsk2o0pTpmC+s3c3QOAilBchvWIywqU67PtDirbnHpoHm
         qbKLb3PZNacXdwlBqPQKA+TR4QKi4wt+q1m2ywWcqJqekB4/SEla3T28C17wf/2Yzv+M
         v0P26fU4vNMqMltDeBzQOePriqeIcsPIVbr2Qw9Tu4XP68UNqJY9POnaipsezilh48U5
         rdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953022; x=1756557822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBvCvb23Z+9Bc2OcwtiN+FlqbAuREfquDJGcbDfAlSY=;
        b=CGLz+FXIYXTIE4HyT2mXDdX7bfZXx+1j+jUrgQEmHZy0p/yAzgmP6cBclocHNzRyrQ
         wLAAu5pG809NiG/+pAd0L08mrE4FCdTJoL8XThfhHdWFiVfU+1zxj506r9fq2hhAUFHJ
         eY+95Xt9gKVj2O2fQnYhylJu/nAe0rNraV2OPsrVIMsObjbgME4hSSvXHFTnbVp3fVd+
         nikuD3SZwxp/5f7zhkOIU36S/eXJ0zDsPgSs+DYBBO6D+523oFEN8GbFyd+Dl4mXJibQ
         j3O3T8ph45ssJPGIBGE4Kq04pyNT2L56oWifHcyaIj2SLpKb2h1TozENrqp4DEop1m1l
         AFXA==
X-Forwarded-Encrypted: i=1; AJvYcCUTePr5+V8D+P1DM5Z9He8Z7qlIdh/3gmp/+oLVgs1uV25K4OlRnCPiDvgjU1CAgRw0HI+I90NTLwiw2Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTeiZ5Wupx3ZUje7DFA6BBhtzQfas+H/4AJ7xSZl5N7I9bimz3
	Fu07VPUBryiWfaCRSbATyz/k8eBNqtvmRGjY4Wp2MZL8dLPbQR3D2RhJ
X-Gm-Gg: ASbGncsQ039Nh1lgM/lrsgJTcnCK9D5n7cUKMvp8z1GIFBKjgwpON3gSZTwGuPLetU9
	13CZt/G7iNc4zsPli/IU/aBOFsu1bCRWpQkZU4mEsP1ni/wtAh/8wE004Q70lR6peBGvZHa3b1a
	9nO7C6OgsX1zhfNwXZE8YEC9JOK0hdwY85N5jYbDrZaNGwRmN/q20wMMjfgoeegCPHH0t1iD8j/
	0C0GWjlKEckceqYVEtWZiM0ruKCdjmpcKY+yzM1Uz/tFizApBexOO0a+Jd6fs3RJywBFMNczGwt
	d6b1lc+q0qMQa3TtPkw31Z/NWKBZn6Nyc+vn6fDuAKDYDNdgP+Nx6w0DsV9n9XZLDKJlIv6vXVA
	dH2NIeXyFwQ8WK6KwfbR7OM8UlA==
X-Google-Smtp-Source: AGHT+IGcDrKg1c3I3k2qWHrMI/GPriAUQeuJB2oG7JtfMQiUYFwCepN5YYM9fY0UzXW4NF+sHAPPMA==
X-Received: by 2002:a17:906:491:b0:afe:57e0:e421 with SMTP id a640c23a62f3a-afe57e0e9c1mr111976566b.26.1755953021752;
        Sat, 23 Aug 2025 05:43:41 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:41 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/14] staging: rtl8723bs: remove wrapper EFUSE_GetEfuseDefinition
Date: Sat, 23 Aug 2025 14:43:15 +0200
Message-ID: <20250823124321.485910-9-straube.linux@gmail.com>
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

The function EFUSE_GetEfuseDefinition is just a wrapper around
Hal_GetEfuseDefinition. Remove the wrapper and use Hal_GetEfuseDefinition
directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c     | 18 +++---------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c  | 10 +++++-----
 drivers/staging/rtl8723bs/include/rtw_efuse.h  |  1 -
 3 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 388d885c938f..25ec7278b815 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -97,18 +97,6 @@ Efuse_CalculateWordCnts(u8 word_en)
 	return word_cnts;
 }
 
-void
-EFUSE_GetEfuseDefinition(
-	struct adapter *padapter,
-	u8 efuseType,
-	u8 type,
-	void	*pOut,
-	bool		bPseudoTest
-	)
-{
-	Hal_GetEfuseDefinition(padapter, efuseType, type, pOut, bPseudoTest);
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	EFUSE_Read1Byte
  *
@@ -135,7 +123,7 @@ u16		Address)
 	u32 k = 0;
 	u16 contentLen = 0;
 
-	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
+	Hal_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
 
 	if (Address < contentLen) {/* E-fuse 512Byte */
 		/* Write E-fuse Register address bit0~7 */
@@ -269,7 +257,7 @@ static void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse)
 
 	Efuse_PowerSwitch(padapter, false, true);
 
-	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
+	Hal_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
 	Hal_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse);
 
@@ -345,7 +333,7 @@ void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType)
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 	u16 mapLen = 0;
 
-	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
+	Hal_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index fe6a3dd84aca..5355bb80b676 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -741,7 +741,7 @@ static void hal_ReadEFuse_WiFi(
 		pbuf[i] = efuseTbl[_offset+i];
 
 	/*  Calculate Efuse utilization */
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total, false);
+	Hal_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total, false);
 	used = eFuse_Addr - 1;
 	efuse_usage = (u8)((used*100)/total);
 
@@ -780,7 +780,7 @@ static void hal_ReadEFuse_BT(
 	/*  0xff will be efuse default value instead of 0x00. */
 	memset(efuseTbl, 0xFF, EFUSE_BT_MAP_LEN);
 
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &total, false);
+	Hal_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &total, false);
 
 	for (bank = 1; bank < 3; bank++) { /*  8723b Max bake 0~2 */
 		if (hal_EfuseSwitchToBank(padapter, bank, false) == false)
@@ -843,7 +843,7 @@ static void hal_ReadEFuse_BT(
 	/*  */
 	/*  Calculate Efuse utilization. */
 	/*  */
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total, false);
+	Hal_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total, false);
 	used = (EFUSE_BT_REAL_BANK_CONTENT_LEN*(bank-1)) + eFuse_Addr - 1;
 	efuse_usage = (u8)((used*100)/total);
 
@@ -952,7 +952,7 @@ static u16 hal_EfuseGetCurrentSize_WiFi(
 
 error:
 	/*  report max size to prevent write efuse */
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &efuse_addr, bPseudoTest);
+	Hal_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &efuse_addr, bPseudoTest);
 
 exit:
 
@@ -984,7 +984,7 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 	efuse_addr = (u16)((btusedbytes%EFUSE_BT_REAL_BANK_CONTENT_LEN));
 	startBank = (u8)(1+(btusedbytes/EFUSE_BT_REAL_BANK_CONTENT_LEN));
 
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &retU2, bPseudoTest);
+	Hal_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &retU2, bPseudoTest);
 
 	for (bank = startBank; bank < 3; bank++) {
 		if (hal_EfuseSwitchToBank(padapter, bank, bPseudoTest) == false)
diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index 7bc8de3af1f9..a5c338c67245 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -91,7 +91,6 @@ extern u8 fakeBTEfuseModifiedMap[];
 /*------------------------Export global variable----------------------------*/
 
 u8 Efuse_CalculateWordCnts(u8 word_en);
-void EFUSE_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type, void *pOut, bool bPseudoTest);
 u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data, bool	 bPseudoTest);
 u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool	 bPseudoTest);
 
-- 
2.51.0


