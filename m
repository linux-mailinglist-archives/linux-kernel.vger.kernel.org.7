Return-Path: <linux-kernel+bounces-799674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A30B42ED3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9F6540C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755C51E834E;
	Thu,  4 Sep 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc4Q7RDm"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620EC1DF248
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949360; cv=none; b=Z2KezaJZqspcktoStI/9k1vVV+cCFCMcTf0GRpsaTkUgAxwoNRpVtaBg5Zlmr0Gcuw3qBvH+2inCtytQCi4fS8ysrsfq7lT1DkYgmtrpEBpSMKDVokwYiDbpR7W4dmynHuCeMgUM7lchRjoiSXkMVZM0YKpj9k2wA8V1NpEF8/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949360; c=relaxed/simple;
	bh=4O6K2p+TRWmMSjZhkegRQtZOjebtpRx1fOy4QMy15Wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CbEMxy2csm5lzdMtuFUfJYP7hoAGtzPsTFK7UYhdy29W++p6BZDR4llcNJdY1a1lGv3d8RZnDRJuKlcixDDkZBUH2/AMJaEcYmFuzLR6qVQvM8qEuInl//4PE9A744h1oSrp5TQGyPsYjaRewbsQV0S3x1eXaIxULKtE7fZLEd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc4Q7RDm; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-80176a6aac0so146490485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949358; x=1757554158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYRXyWLfRH1eL49TjUg//MlDi5BSYCOb1YaJi8/zpww=;
        b=Xc4Q7RDmVIW7XMLhukbJPqpKDMZfCy+aQKS0w9nvBZsssm9RZNL0sY5bebv7Pdtbud
         3hiLvjZF5oInYz0PhivcCd7s+B+F0KPA/k5v2XCoBjq97LtJVQTraWVMtpjc7Itv4Wa9
         g0my43U7fqIJJdFoHK8W5OV4oplkmEkaNopuFrskYgFvffL8KjdXUDE+9eJu/TpL/gTv
         bQSwrCKaE62jj4+TFoiIoAEpg1oIxKXrHlVqGxSDMLiyA5ddVk50lhEoCyraVUERMPqX
         B2ztQMVncEgrPJPOhLwBxqP1EHaGwtxdXeTJdjH38e+vSXZQ+KN3BEJ51ATblXw+k7SL
         Dp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949358; x=1757554158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYRXyWLfRH1eL49TjUg//MlDi5BSYCOb1YaJi8/zpww=;
        b=muAknsHntO+hyBXEvyT4ir3lxvhFyav8GQnR7nfKvwtZBVzrvbu3zT5CNJitQZsFzl
         +TQTQQ9TbZGv9PxiUPSbPUJlB8roV1mUfiGbscGhKGvMIzR5TyxhtxyDaWPxUobnruMj
         dkcYbBbe/C+3OQJunB2Lr6uxuMNCDCfeTn7nItDNHToLuHpfcr8Pv6l2L4FoVaWkqCTf
         3ZQJm6WCiJfK1E0Bx2UMQ5uTn2hBfUErgG7cQ7n30hwdO/0Bpr8ygJcWILEcrRIPuiv9
         NnDHkrwlPY+pKfTyS09EqDUozJ5iBxiaG8pfU266rUhkRJcNren0TspA+hoD3GubFPMW
         JoMw==
X-Forwarded-Encrypted: i=1; AJvYcCWLpJfHPoNs+WdT0Fmag7OigNDmSYgOBHb47cD+aMfKn18r9nbBEZJOCRnPpS4O2l2T+AqzxcSzgQGBncg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhzsru1Tt8nFUDID8DogSjZEszEPEa/chr9WRq5VVfs0pnEo1o
	J4fUm45pjWUXXCuCw0BCYVvmfEtBDix/tRFFbP/OkeghQe8YFW+OwKXO
X-Gm-Gg: ASbGnct7aRxjyocbwI1XGDvrOgUxznKVVGoZsRcfb1df5DzpaQtoucE/0DXiCOvA/1L
	sqnRCO+J0MdoiHPWSW0kNbcI/zsZhSA8qU0PxOfienQhR9/iiJIzGzIshky0pe03zrZnPt0ZpTa
	JQAZ7ToiJ6n3Mg4NJJKZcDe/zwbogVZXNZH8wR41Q0VnzDCcSoAl2K7+Vx1mQGbJBmh7NZ3t3WM
	gSfI8mitbtHt4ZQ+MdfdgGXH4PhUsJVZvBspO905dPTIIoY98hP/Th+7tRF/38jmu5mgG9tjv/v
	Ldnnpic+m+ZVDY38Yhd/Ll3MPtNzVG5ISCEtY6mLiPy5gV2ZF2MgwXGmVIc1DlH0pqD1DXHDqmy
	ft2lJddoeu1py9FnEzLNQVbBYHPbXxvBHCpGMKtBa6IvUCnY9k8mbC9Ir8PEwmA==
X-Google-Smtp-Source: AGHT+IGakzKOEN4iyopngpGCFFOIB/r2XjG59O/AJW8fqmHDaQ361/ncmHr5+VvqIGVmr1ou2mqoZA==
X-Received: by 2002:a05:620a:4052:b0:80c:3418:c27f with SMTP id af79cd13be357-80c3418c66dmr340811585a.1.1756949358155;
        Wed, 03 Sep 2025 18:29:18 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f78757fsm20378921cf.43.2025.09.03.18.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:29:17 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 13/16] staging: rtl8723bs: add braces to all arms of conditional statement
Date: Thu,  4 Sep 2025 01:28:56 +0000
Message-Id: <20250904012859.215565-4-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904012859.215565-1-vivek.balachandhar@gmail.com>
References: <20250904012859.215565-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add braces consistently to all branches of conditional statements to
prevent potential future errors when modifying or extending logic.
This aligns with kernel coding style recommendations for clarity and
maintainability.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 27be46c11b65..25f333bb0816 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1667,11 +1667,11 @@ void rtw_mlme_reset_auto_scan_int(struct adapter *adapter)
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


