Return-Path: <linux-kernel+bounces-750589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1F1B15E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95518547AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341B2E36F9;
	Wed, 30 Jul 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="attlNOJR"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044D1DE89A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872313; cv=none; b=murkbBKp7Q2xcec+XbBrZhSrYeHZWie8sMSj0bz4aVDkF6+8A0LIT/ntU/sJSTBvn3NAlOreTlznZt4bZi7Qh6xlq8RAs7kicP1/ddKIzmQ5PugxibTBEw/nH2x/JrTXt8Et57ukQHJQ1Vh1kjD5ujZ0VJkbhnsO4jB5usruODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872313; c=relaxed/simple;
	bh=lKDLjwohNLI+W0RVqk5eQdA2JB7DSrHHNZBj5lBAqxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn0ghYfzyiN6ObGxiBUWMMNBxq2dOJmQImbjIgNZp00VAB+S5oftWgigDnQSZeDO2ZQYQkRS3RIo3NLE8gLusLRbHOSskr499P2Lximk25k7fhIbl+bJk3uWgqLdTrVu/NFX97waN+2qmlRjBwFEmxpMNreOekbVl6MqnStR53k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=attlNOJR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so2346368a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753872310; x=1754477110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhMrTUsGLhgSJHPnPXfJtTefZZIZgXJlXwMrdVYHlCU=;
        b=attlNOJRtFvJwll8rBrnEkXDctF9M2d+/AVHXtWskdgMSW1Av5dR43b2URG2m51aZm
         FMeIb7YwTBvjQXOl8zQvQ7LKHxmFH45YQrGR4V/s9vk2d8tdPPPlUShIBeEuEJ5i5usu
         jCQPNnYWLAV0acmg4K0HiXh2EfMq7l5KrwJ6w/+uGSp7T4AgxclP9nGZObfdTNtikyHa
         L9Z1fmkOcd4EZBJ2hKrrEInfUcXAXe4Mu313jlUJ/KTtd2Q2629aqUgHVJJYlH6iZ56t
         ImVct+8IH2GSwG4ZJsmn+6KRM4U3ll/NWVp+lI0MAN9jibP/UUbgHOBec+z6N2LfUhcF
         DotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753872310; x=1754477110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhMrTUsGLhgSJHPnPXfJtTefZZIZgXJlXwMrdVYHlCU=;
        b=e6jNpfNeHeYT0JDIEQcuqQWWM9LpJJVL1IbYNCHPSbv8i0b8YSzq8TAbghZ7jjrzm6
         LNrNLtr7IY2x8+PVwu4CTPmP4fuIM0dj3QR3HIo8LHwmC4peEQbAT4QL5+d7Uj975sHx
         jMVN3bYOq5ITTKOMlq6ebPeBqwI5YJYheCpAvk9+kb8CKsJaQw8MFHwNf0z3i8/nbGWX
         L8CRgYAwR+NRsRCEwcvaAmRiYfWly/HR2JSq06A28H0KsM8mNt8Kzln4/EWwnb+WR5nQ
         s+qMd4HH1d7cDwrTIYqx2XVdp5Bd3y8FBHiV5FmjXWRMo27dU2TVDtdHHrcgG+3BCt6q
         M0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWObVVRPeDUjHK+02Uifupq01kNSK8h92avA7PF5gh4vc5RtcZeVl10O9DmSHW2kGIHCaSLSo/TZbaudS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJ3/ekuV3giMhW+u0K917rQXyUQ/2SkLN+6iG1DKoaAo4xF4c
	iFYoIYALoxYMC0HBKC8K+QgeJpKdKh7ZrRllDMnDJ/OV2dsxQGahn+TB
X-Gm-Gg: ASbGncvJAAnYr+33uJevq4fQWP/PFb//+jg896JpqRjoh4ToM718hp0x4ooIUa8FFTf
	TWpfq245jjldmKHtCXKIsS6SZJAodqo9p5W8Be1LSza3hLWcmyOdtzX2LQHBypGbl6Mvm3M+LZc
	s6vb+zOMFA3BDbAxuFII8cCjQWg0mXmYg/oozSdxAl/1NCAzQACJ8/1BBNJJsku13s0mian9cKT
	flUNTvnMBeIA+fXFWXuLPzBJNHWUSqkleJNuBsHJczTpEPQzADt36hCgFY1H2VT3dFQ1SXiG3pD
	vyg9fTFeTYs41wYB+80XfYXrrqVy6wTKT/QXbfv/egdciVWmMQokJfLCW6p2COkeuLjRhKZJ0M+
	SAy+ryrcUMCbxyxHOKayQHDuHTBGHM5gwFBHmxnaGZ1qiL7kRgaOVSaCR
X-Google-Smtp-Source: AGHT+IFl5bt0ZUUGxrvGIxVVDpix/kdV/nNNpynB66K5yBJja9o3i+UoUXrpiqXUsRGrAwqXDNHWRw==
X-Received: by 2002:a05:6402:647:b0:612:bfb2:386 with SMTP id 4fb4d7f45d1cf-615871d4abfmr2659229a12.28.1753872309609;
        Wed, 30 Jul 2025 03:45:09 -0700 (PDT)
Received: from tumbleweed (ip-77-25-32-208.web.vodafone.de. [77.25.32.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157974fde0sm1582734a12.7.2025.07.30.03.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:45:09 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/8] staging: rtl8723bs: move init_mlme_ext_timer to core/rtw_mlme_ext.c
Date: Wed, 30 Jul 2025 12:44:55 +0200
Message-ID: <20250730104501.150270-3-straube.linux@gmail.com>
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

Move the function init_mlme_ext_timer from os_dep/mlme_linux.c to
core/rtw_mlme_ext.c to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 +++++++++
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c    | 8 --------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index bc980d21d50e..0e685c0f2f2f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -374,6 +374,15 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 	return chanset_size;
 }
 
+static void init_mlme_ext_timer(struct adapter *padapter)
+{
+	struct	mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+
+	timer_setup(&pmlmeext->survey_timer, survey_timer_hdl, 0);
+	timer_setup(&pmlmeext->link_timer, link_timer_hdl, 0);
+	timer_setup(&pmlmeext->sa_query_timer, sa_query_timer_hdl, 0);
+}
+
 void init_mlme_ext_priv(struct adapter *padapter)
 {
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 2080408743ef..58e2d8e159d6 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -426,7 +426,6 @@ void init_mlme_default_rate_set(struct adapter *padapter);
 void init_mlme_ext_priv(struct adapter *padapter);
 int init_hw_mlme_ext(struct adapter *padapter);
 void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext);
-extern void init_mlme_ext_timer(struct adapter *padapter);
 extern void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta);
 extern struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 09bf363efa8b..d22d6cf3cb11 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -164,11 +164,3 @@ void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta)
 	timer_setup(&psta->addba_retry_timer, addba_timer_hdl, 0);
 }
 
-void init_mlme_ext_timer(struct adapter *padapter)
-{
-	struct	mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-
-	timer_setup(&pmlmeext->survey_timer, survey_timer_hdl, 0);
-	timer_setup(&pmlmeext->link_timer, link_timer_hdl, 0);
-	timer_setup(&pmlmeext->sa_query_timer, sa_query_timer_hdl, 0);
-}
-- 
2.50.1


