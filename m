Return-Path: <linux-kernel+bounces-753073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127D4B17E58
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5F03AAEA6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA48221FCC;
	Fri,  1 Aug 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfuaTKs4"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1022621FF44
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037162; cv=none; b=torS6o3FhUGldopEJBLo2z/5xMCO6Die/qExkfwqJJTGuiXRUpcTfUfqZJYrdvZphRbIpFXXhrUyc0juauPdTWQwEr873Vqql+itqkjZpXZ0phHlhKucuwzL8gOnnLi7QWGVT8aQxTfFiHhpQOK60uUlZF/1OrHpc0Pgy4hmq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037162; c=relaxed/simple;
	bh=Ganb2QpLnyafKOMT5g+9k2Q7Ed/ovV4Up8+46CnLsUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWfqSeu//rxToIpUw2RCIO4Gvc+X7tc8NQgbasIpviaVPGkVflUPhQY+OYVjHu+BnRHRFNBbIYgB7uk3L/AMBrKJVKvFYUCYW4wRlpkh3vzIFgSlZKRrfJKxpD1xPLiZQooUz9AbXa/Z3MRRvcQRAwVfSlGeOourgeU2VTBrT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfuaTKs4; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-615c8ca53efso1748038a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754037159; x=1754641959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hir56biQJZn+xxylTDOOLZm1B/0sdMegpTfCz+mQfxM=;
        b=TfuaTKs4yBvVaSSQdxz3egdrQDIJy2mCbmk8IuMhiOr/6OJkxwjFeI2+ZDABXbPxrv
         hwSRcl6nLKR8yZXIiidUU3l5UbXF+4htiOvS98/m3rf2oxvL8BZ8+gYlyv52HvOafexo
         IUkK3Zj4SkNFrLV1G1+PwQd/ZbL8KRjgDrsRfcTU4HTSffXyP/3hgJd7yrwJl22Mb9FJ
         1IKEMYZ1yRfu/KMy9RtTYpSHCXDTAQHKC3NIjW0EmcUiJZE/R3xFsP7Ca31WCyjcG1le
         bZsfwimR34M81wi8HLgNwsXjQCxbrkZv9C5B/ShoLebPugNdegR7QqeQuHjlUDpBMfQI
         U5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037159; x=1754641959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hir56biQJZn+xxylTDOOLZm1B/0sdMegpTfCz+mQfxM=;
        b=CAR3D5QUjW7ZDZgipxsKMIYpu2hyWegLCkzkRgD7THN+b51fxcH1JAKRqL2QX3chtI
         B/wQG8yjymikh3mk/dyQkV3P3MnYL20LBzVBKP2AHi7Ux6aXS72fcATikYezaYkbGz+d
         vy48FE+MUNO673xZ1L5mM+mKxoVEG1wCA7iLBKyFRaBAgMLbn3zxY3yBvnC7I8ikhqEA
         ztBTXAFm/JbkPy0XpB2LSdPTne+iQIWhQgnx7NXzWTzRqetcaXFbXZtogmzh55NxwVXZ
         bWLY4VBE5N6gPLDVqRaI2JAlBAm7UQJgjTEdMWVkWsp1dAWicX4D8QJvsPMeObxy1Fg9
         aNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxXv9fIRrOTKOvUN8IHswf7qHrbk6Vx+/g2IVPbjkZluM+Bn3C2Jhb2RVi2aBDR8KzPwGdfjLs8wjeG5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyhrcuEr7bE/boCJm6RynkdvDUAfFIgmwwOizTNVDeiIGfgERX
	4hupo6z1ZzRspjIrLSMkfSLc1o/7o/KH3b7HMkDsN6EzEy4wYC6RIb9y
X-Gm-Gg: ASbGncuZazUYpRi00Zdjltw0ZOQCN+ErLrOkup6SP/PuUnX9Gw2n6LMftUajPRB59wO
	Ox7GiOOYmsulAJBXxq0Av+HQo07ahxvd9Zy1NKgdq900iLyuLrBsNQqoH90MmhquTNRze5ra3B+
	h2rE4B9Rnw/SScwT0LY8vlgx3QDiTvHQ9DMAlqiJsLQuNiP0Ircnt0Vc4NypOdO3wBihcT+jx/z
	RRw5r5F2t3ab+MczAGhxkhHgmI71Ev07cKn2LborzS4G33/WG9JeM+r/1ZALehFlD4YsgUDYSPa
	asxjB3B9SqthXpXAUfbd8zzIvMyzoYhff3cTH+x8VXFpyYX6sx7IHYOFyT/zBpN5Mgrsnhs7ZoL
	wsdwz1WCGVDXCpbf1Ip9vea1WdcSAep+fDU2VFDtbcb8OilhaI1E=
X-Google-Smtp-Source: AGHT+IFAUkqpznwVuXqoJimFFmaLnFKl/kGMRyRExyxQFtkGD492C+NwhNSINhu0USmY2WxK+oqUag==
X-Received: by 2002:a05:6402:5603:b0:615:d33c:5383 with SMTP id 4fb4d7f45d1cf-615d33c5759mr598535a12.16.1754037159085;
        Fri, 01 Aug 2025 01:32:39 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-2.web.vodafone.de. [77.25.33.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a59dsm2362735a12.62.2025.08.01.01.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:32:38 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/8] staging: rtl8723bs: remove wrapper init_addba_retry_timer
Date: Fri,  1 Aug 2025 10:31:27 +0200
Message-ID: <20250801083131.82915-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801083131.82915-1-straube.linux@gmail.com>
References: <20250801083131.82915-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function init_addba_retry_timer is just a wrapper around timer_setup.
Remove the wrapper and use timer_setup directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2: no changes

 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c     | 2 +-
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c    | 6 ------
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 1d2b53c76afc..4d51e6993ca2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -229,7 +229,7 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 		for (i = 0; i < 16; i++)
 			memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i], &wRxSeqInitialValue, 2);
 
-		init_addba_retry_timer(pstapriv->padapter, psta);
+		timer_setup(&psta->addba_retry_timer, addba_timer_hdl, 0);
 
 		/* for A-MPDU Rx reordering buffer control */
 		for (i = 0; i < 16 ; i++) {
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 58e2d8e159d6..53fac838c36a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -426,7 +426,6 @@ void init_mlme_default_rate_set(struct adapter *padapter);
 void init_mlme_ext_priv(struct adapter *padapter);
 int init_hw_mlme_ext(struct adapter *padapter);
 void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext);
-extern void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta);
 extern struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv);
 
 /* void fill_fwpriv(struct adapter *padapter, struct fw_priv *pfwpriv); */
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 5cb27ddab769..f85e17ae0e7f 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -128,9 +128,3 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 		kfree(buff);
 	}
 }
-
-void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta)
-{
-	timer_setup(&psta->addba_retry_timer, addba_timer_hdl, 0);
-}
-
-- 
2.50.1


