Return-Path: <linux-kernel+bounces-842934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D0CBBE011
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00BA94EBC36
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADD327CCF0;
	Mon,  6 Oct 2025 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwqLiBN6"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39326ADD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753121; cv=none; b=OqgxsFHhNgLIFO6H2YZ/KPr4dtku9UubgVz/CWVinbEY0O7b9uYonhqrnTwth2RH6RgZ76Tgl8ZcNrMICuTXxF2ei2Sjf3stDD0Ms5PL+5UzNpfm70ECvgNIdCbQRRcx/SIiKDcqzsudTfM5tb8aLGs4xyeK+GtN0FTPljrYaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753121; c=relaxed/simple;
	bh=KsehnIz3zhaIRQ7nBGds+hNWCCyU0OXicbw+mHAQcbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqHWNW6s/Um9/Qm+4oxC0LgS9+8xrJ5sUcWM2QZ7EKukqciu4fv79fXRlqVMBHlY5bUaVJ0iivXzX6i1skKfyUULchMlH7yZUpB/yzMpKHmfCyxFK00xM3cOR4UmtVRSzm3SsIxGiHHDnn0cacLVvWv7goKAfh2pBpbEV2TIFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwqLiBN6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4393032b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759753119; x=1760357919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4JqL1nlgUvZ4Y+a9ncnNqpy2LNfdBYiZdaCXYGPWAqA=;
        b=YwqLiBN6ytNx+5bQGnE5Nxxdv36MdKJW1leg1FMAvUPXNpaj7BEE30HRbnjlu4sYNz
         GYgftPs/IjCBMDjed926XImxMfXOW+Ww34g16AWpZRI9qaqI18rwoW8h9AtA92AsiqjD
         0SSnGugla40s685YKOcjocirCh3n52wd0CE1ypyCjVyANgRVJuRPzIe+MfN1WuKMMsWf
         MysXzZRERq5NRMtACLJQ4KZqG7LWdrzWoV/lbSu/UswOukwkDODmUmVjwJh7BTbnFvMv
         5i6SHRUP3dycqeMHn6iPWRT33wad7GAqoF7lIbv81jRJO2HjaFfN1txZq4CnB3c5u5oh
         Vd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759753119; x=1760357919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JqL1nlgUvZ4Y+a9ncnNqpy2LNfdBYiZdaCXYGPWAqA=;
        b=HomD5VF3wGOz5+3kifrw7ZxKYug7lK6botaxj27YpkT5Pn5AvdSAjXCGWyE1yHuUv3
         Ufj1m5TAVQRVzN3+V+iC6R63eTw3EFCtIImh/Eg13Y4LdWGkTeSiYGH1Z9gkQ6VqfmBa
         8TNutH5g01xcXag65jnSSyBk0aeZSzWR2OaB05rR5l72zRwtjy1YrLOkBxUkzmpNqPR8
         gomwzdtsfdV07TD7x9W2IMBZE2p4R0NPzswt1itoiiOWls8HM31zCs65hOUuc4N2VCHE
         wLJTqo4tjWLBKPFqOV/znhDcGGJDc3N8efvJtp+IsF7WKv7/0U7fXK/IEwTJ4ClKXpjU
         ciHw==
X-Forwarded-Encrypted: i=1; AJvYcCVkVzjOWXCdhDD82C9UqXSv4idPWf779NTxFNU6iE69Q71WG0JMs6RqrOkcgWch20wnJsBdNVu74HLIB8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJe12p3oWb5xUE+hwFSkXuyxXQ+4h1VUxfHYa082hTL1nO6EoT
	IcS0dGkitOSz0u/QvMnVrYr7Dr3MrU3vRFb/tLnLrvz2gxWaKc1jpeJGDMuA2Q==
X-Gm-Gg: ASbGncsYNI7dEizBgM7JG4eUFHdlemHZhUYY2yQx4ep+mEm20+5Yv31M69sFqlNfuVH
	qbnaBA2ml1ae7o8O/NU+0jmk8b87XtI0DVBfKenOTGEcnE8kiCFk5ExyHgzpltUchez/qn8hOuC
	ilBdwCzQTzNqt+Pg0MWfQK4+v2KTAqdxqG5+NnaWaWRt6mJqbzGPTgi7d0gCgjPWZRwiyv2KIb6
	CNS1/azk+mwkG+zEMVKDvOu8KGcENSXCtu8JVqyG4HA5ypbmml33KDpGg28EdX9q7GfK77alb6u
	5gKGzatBsGt9YSQL6xF/4K0Fwe1camIBS9JEZokByFV4UQdDvIIxCFd4z7va8lmMbz876BxOnRq
	ZFyD/ABc49+O07GAvKW1GlhELT+bVWr37jrrI8EXTp0Gh9GjuO3UZ/zxpRQCC2oXOU6TWVcgJEW
	JVpzzonu6GB8j/r2c=
X-Google-Smtp-Source: AGHT+IEJlwikdDfuEqvB89md8pAfVXWDudGqoNcbE2zkbJKF7mMx2bYqTgGXO9agoUxrYeU07eF8fg==
X-Received: by 2002:a05:6a00:2349:b0:781:52f:f13c with SMTP id d2e1a72fcca58-78c98dd92a4mr13864940b3a.25.1759753119149;
        Mon, 06 Oct 2025 05:18:39 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:fa6f:67e6:9404:f1b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e809sm12540612b3a.71.2025.10.06.05.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 05:18:38 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Remove commented ifdef CONFIG_WAPI_SUPPORT
Date: Mon,  6 Oct 2025 09:15:41 -0300
Message-ID: <20251006121825.8114-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove ifdef CONFIG_WAPI_SUPPORT comment from rtw_ieee80211 since there
is no way to enable or use it. Also, there is no documentation about the
purpose of that config.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
I guess this stands for "Wireless Authentication and Privacy Infrastructure",
but that config is not used anywhere inside rtl8723bs driver. It was first added
at 2017 [1] in the same way, so there is no harm to remove it.
Tks and regards.

[1] https://github.com/torvalds/linux/commit/554c0a3abf216c991c5ebddcdb2c08689ecd290b#diff-2f54b83e0bd9062cc10a53a0a6ac9193744cfb4cad1bca851127012003a6a816
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 53d4c113b19c..027b2dd0a4b9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -560,7 +560,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 	return ret;
 }
 
-/* ifdef CONFIG_WAPI_SUPPORT */
 int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 {
 	int len = 0;
@@ -600,7 +599,6 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 
 	return len;
 }
-/* endif */
 
 void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie, u16 *wpa_len)
 {
-- 
2.48.1


