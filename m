Return-Path: <linux-kernel+bounces-746622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A2BB128FE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BE5AC7EF5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5E721D3E4;
	Sat, 26 Jul 2025 04:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5W075o2"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F921CC79
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504447; cv=none; b=ukeSGZl5rp++AWvG8gFCkPwlW26E5VonULyzl9xscbemEcMapatvGnicrPPNdhUd/PWrou04LARJqrRnfvUg4BbEKb05p3wkqVEINqS6thPsmyb1MJchpA0spqvTmvw47eMq+WgGspA9uRT00TVRctWKRAp8arSlORPhjScPWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504447; c=relaxed/simple;
	bh=95tRCUajd2YWzthjvIMZXiLAW0pTk6LVGoVuxLw9wO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DU7rqMHwqmiYYXOdz9Ih07lbm0BXjPzSRotoGehEyLyKl9rIWAanuyEVamaSMCd+dUIIH+83PjuDvkkKrU/x7c9Ms+yFxEF1HcvfwKUa0c1FzSdbadEn12n3Gtlh+O1YYF3j/x8QBfZOH2oVS/I092zEhZkssn7WvxWxIRTGv7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5W075o2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e62a1cbf83so274961085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504445; x=1754109245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+oh4R8+Xz4P49bJ6RR1wQypz80s2da0SdRPMOzyOPc=;
        b=X5W075o2yz8dkSn6wL9QwLJyTcD5vGLdzUZPTRXHsuoOfxIEPJ+mi0odVowRuQBsz4
         b5W3beNv2u6Dk3PpwjQ7bmoDWpb3T7s4aWsrafOeENb+FSAYJQ3GwMzPrNty2PxFvK/z
         w6ptlXk89k/CME1YVbwp0OdlVpyudk3YDlGWaMigzrzg38mk07ixqcJurumRekVQhDGt
         6judQBHn6xaNK7TvNyqWtPhV1OFexLOp0rKB22DxfCXh4vF2BCW/wMA+m/aFBPiPh37G
         XOeHJfBpWln4tdP58+k6BpYgYOCBRkftbuoWk2nZDdvDrL9KnErlVCiWYv9YB6vrHpA5
         r4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504445; x=1754109245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+oh4R8+Xz4P49bJ6RR1wQypz80s2da0SdRPMOzyOPc=;
        b=WLo+KSjs3NDgC4vVY8S/0+Sh8OtgtXoaDWN3iKYdirZ9MzigRtNby5b0+BUM3iQ7RO
         ombbMqCnJTlyAcchCL9mb6UjsFTiMX55QX5LRoZGy+h1WHjkVMvBSR3ZIBXmV3FGS+KR
         8EFETFKTeySwqZXUrwNM6Oi0uN86BQd1vxQjstGHc50ukR0ca0IHAw8bC3Lpo6Jaxiqy
         HW+NrhsCzNg/U2a+/ojPf89i/d6MI2VkuhzxWPu7LnyRvI33Ef8/vxn3K6rNQtEHbWto
         EH4Hzu75CQyV/0vJnISg1U2e1rhw13fmfS1yrWRzRiP4c/o23Yx0O3Sz+uNDL2x1NTPi
         7b9A==
X-Forwarded-Encrypted: i=1; AJvYcCUK5IEilPHNkxWa+GFcUUw/lZVPkxS8Ox4YqVOGe9y/LeiyV1v+Ffsz1CovDlGcQ4syZ82duCMscZLVWrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrZiMmnwSl/NjAVXwWbWmPkxAeFOpoX7IroaVmqwtwayap8u61
	wNq3yvwgZfS3bpF1ilhISGAnTxxAagNh0RjCtpG9FwueP/8uWnms2lQbP5qapA==
X-Gm-Gg: ASbGnctO49VezmpKdCK52SqPby7Bzo4YQwS9V6p38rIEhj+1CvcEg+jw/WuKSYavAP+
	gYcjG8JbyT9C4fl0yUiZBzF0gbrM+UiLedVRQlls4AqT+x07BR2Wd3hDjSGQ1xw6on9Du7TVZVa
	prNWrC02nadop75HK8b0uvy21EatcnUbzZxWy0PuLKdpKJ9YoY8EEbz/P4slIYRaQEsJt6b5cMI
	rdZ8VA/rofa0fOwmlUmCrmu65TaHTfjkJHinY5lb/FisOJgoebpR+ukuA0vz2KRd+7CUYA2IrU2
	nn8QEG8MgMsKOMNjvxMNICOniOiXns12QhDq6O26nfspY9Ftrk1iY3oDaKxyrN9BIplmOFN2sG2
	9mVKMiIu6J62ZwplkUrkmG/qscXSeGuEfSn5BMpfbomyVbqW94zo=
X-Google-Smtp-Source: AGHT+IENcPolz2NGbAdveExhQu7dx7/c6T6biciIaJRVqa3hpe/07ZSgoIvG0LIF/sal83OsbxKm5Q==
X-Received: by 2002:a05:620a:109a:b0:7e6:28e8:2dab with SMTP id af79cd13be357-7e63bf8c5b4mr442052285a.40.1753504445233;
        Fri, 25 Jul 2025 21:34:05 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:34:04 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 16/20] staging: rtl8723bs: add braces to all arms of conditional statement
Date: Sat, 26 Jul 2025 04:32:14 +0000
Message-Id: <20250726043218.386738-17-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added braces to all branches of conditional statements for consistency
and to prevent potential future errors when modifying or extending logic.

This aligns with kernel coding style recommendations for clarity
and maintainability.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index fb7ab7eceb54..7552f7e4d14a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1571,11 +1571,11 @@ void rtw_mlme_reset_auto_scan_int(struct adapter *adapter)
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
-	if (pmlmeinfo->VHT_enable) /* disable auto scan when connect to 11AC AP */
+	if (pmlmeinfo->VHT_enable) { /* disable auto scan when connect to 11AC AP */
 		mlme->auto_scan_int_ms = 0;
-	else if (adapter->registrypriv.wifi_spec && is_client_associated_to_ap(adapter) == true)
+	} else if (adapter->registrypriv.wifi_spec && is_client_associated_to_ap(adapter) == true) {
 		mlme->auto_scan_int_ms = 60 * 1000;
-	else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
+	} else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
 		if (check_fwstate(mlme, WIFI_STATION_STATE) && check_fwstate(mlme, _FW_LINKED))
 			mlme->auto_scan_int_ms = mlme->roam_scan_int_ms;
 	} else {
-- 
2.39.5


