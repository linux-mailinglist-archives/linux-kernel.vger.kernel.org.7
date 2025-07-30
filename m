Return-Path: <linux-kernel+bounces-750590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD7B15E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC1718C4712
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283E42957AD;
	Wed, 30 Jul 2025 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOR5xh9N"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDD27EFE9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872314; cv=none; b=QwTl5ouftjYvq/p2gpRZCmUuDsaeH/3oz+FR2RVxmsHCJHxZKYjAnXXmvfwdgl+Xiu6v3TfgTBF6cztZz9hdvxW38iozKcBOgWDTnMj2ye37kTFTu5rZrrOP/EZQ7nqlK09qZuEmR9oGieZeLk7HclLzsKgdV4lAJAl9rzTWie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872314; c=relaxed/simple;
	bh=8qVfwXrBqCmLZDZqxF4HwJyyC4wmuBrsGi+vbFP9NzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWbiQCPJRTC31ODW7uB9MhgmGb3D3uhWoyvBnOl5KIQ6dEFhrBzLeG0ghw9E9PV6QimPQSEe4VyN88Azp685HNJPP1YyOdrVEh/fKGay55ri9MhLwUDhfwfhKPMiJtCdsvWVWYqBicVgLwjoMfDogvtwtjW5PV12tSQcXrzBjjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOR5xh9N; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so2346413a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753872311; x=1754477111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnv2SMLij4R2x+6MFia53n0KBrG4Etb1tcinc9nWT1k=;
        b=KOR5xh9Nq4nsyMQ4uK/qemB3tVBZqRgUWJNpZb92ueii2YYyzcVqr9unm9NiMXPY53
         RIW9EPFdYDmvQ80rq7D2eOQ5LXNuvsZUG3D+NeOG+GsEa2bd4Ph9dDJEpg9+GmcvtqeU
         bA6XEtPiyEant8RNXNTwmfcfhstYmxkNpfGF87A/XKYb2gRuTy8vdr1BAhi3Wym/vIMF
         31BgPp2P8vfrpYqXL3k7DAN4O5vy1pn0O10CSu8YqaSb446xxLkx8zQviopGX+Kna4WV
         iQsZ+IvEd83ysSzJ2AUT41jGSo2ERxyeGD2w0Cjfo99/jLt3hxOs7QoYXXgUuS0sG9kP
         b2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753872311; x=1754477111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnv2SMLij4R2x+6MFia53n0KBrG4Etb1tcinc9nWT1k=;
        b=I0h0+1B7QM+0WrmxXgfwv1ibHs3On2cUD327JOOR6e4bnvG+nTvANCbqqxP8hbcj82
         kpXo9WTRqo2feoPOpxRAoT1iXawnv7Rbz9EMtmu5eE31VrYhUmGX5OGbZ88DhfbLeaH5
         QE3/2M/sBLoQNd/83FsCdK03ey3o/prHuJi7RY1fX2TWXVTvR5pG52/PmxOAAOr4T1t0
         4mqi0VQdKGppL9K6VITyUegXzS672Jn4bSjNqjZJMAMV4BidDGPcbEczGFO+iha6rbVY
         6ITqGiofbXiw0Fdk3kKLjw3MkGFxDld9y1uTkY7Y+fr1lzDBZflGC0EWZNpVlWtTJ67U
         vPJw==
X-Forwarded-Encrypted: i=1; AJvYcCVcEwhQiEXaxxlAvJv4H5p9ulO+q4Wsopelh1IC8MdC/2XpeMylz1yvjdy14nnrau13Hy+AzZlyqRBO6vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN89L/J4qKjsLdHJJ0C0dbZNXxZZKK2bPves+Y524qXNvqXhGN
	FKgXyMNuxolQbQ7me2efXp591eVoD/TtUOwVcHNV2JrCaYg4/oKFF+1k
X-Gm-Gg: ASbGncs4ojh0EOmo1BdoM451w+qS44FNQOb/Skns9OCW6LK0IcwfsRSHjZBn4NQMxYc
	DK694lfwhnYDC/EyteT3lw6NsMwW7yhed5lATNKhFuyoYZhPPTh5qkYrxZYHJ1dAkyoDWX3KshO
	Wvedj1myW03jNieCCwiprzTZm24MqWFbQML8VdGnEhhn0Q3hXPVUc2qO3CsBb3yBlZq6//eJUdr
	G/0VSObQecmySAyztruBApJ2jf08C5ryPkzmOON2W5Pne8g+5IQvmunKkf2XYuOiAjIFDtcbNB7
	zjOY77LydrPjtwL6Rz/tBWSW8xp4yw6pFukEmsIlI7TEODiw6vpOe+jpmPJiHe4Uex9wm68cyie
	eLQus+cjg5xSJ02phOZ51ZxE7KWPXjDkh/vOtMVVRTkn8K1yVK1mHM67m
X-Google-Smtp-Source: AGHT+IGwYX8VOf2KNXwLlB+LqJ+dsXg5j0rCI21X0ePacfGNTJrhJYQk2+N4KAF/yr+aPDRG65amfA==
X-Received: by 2002:aa7:c453:0:b0:615:6138:f702 with SMTP id 4fb4d7f45d1cf-615871d33e4mr2720671a12.26.1753872310976;
        Wed, 30 Jul 2025 03:45:10 -0700 (PDT)
Received: from tumbleweed (ip-77-25-32-208.web.vodafone.de. [77.25.32.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157974fde0sm1582734a12.7.2025.07.30.03.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:45:10 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/8] staging: rtl8723bs: remove wrapper init_addba_retry_timer
Date: Wed, 30 Jul 2025 12:44:57 +0200
Message-ID: <20250730104501.150270-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730104501.150270-1-straube.linux@gmail.com>
References: <20250730104501.150270-1-straube.linux@gmail.com>
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


