Return-Path: <linux-kernel+bounces-746621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5B2B128FD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86184E4E32
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1D521B9FE;
	Sat, 26 Jul 2025 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2HQish+"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCB21C184
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504445; cv=none; b=SsvatFsoNLhf/GagQqeyMxVTf/4PXI8M401kXKoV7ILRQzEmzw9cmZ7baTfHEcSepqWIH8VXZmual4ZT2wenbKrqRpj50eDX/C+nOozPu9u9uGN6I/fijD7ajpEb+0P/CB11U4QoPMaXLDSIN7e7GStVsYEP8wjfwmtnl7aM3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504445; c=relaxed/simple;
	bh=bM0Vvx92cKEQOLfqkhukRo406X8XLDfUAl5uTTOBuYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6H2Qv7wPstaIG0CJ7IBOB8uH+diQcHMeOCMIsuMf2aaS85HBEM0LBdfYhWp+wnO8NuYX7/zPQFJ08MHZNuA8qa76L/n7EigQwCoW9x1R9wszwF5xZCfOpXUsiIcEplsCsUvW2/l/eJPYJv4+qA9Wml5aoVIZib80/72eEj7Vww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2HQish+; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e62a1cbf82so168415185a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504442; x=1754109242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFyIKyxFfSvkenjutTa3WXgF+K78uS/6Wm5w41WWk5k=;
        b=K2HQish+7zHayWYshK//UcdD3DJR0atYXo1YI/7kcWA5UCz2Vhjnkx60B96UZvSnZ/
         /P2KYDLemySzalGhjMgMzF+6ZbdVGhhsLgpBC8edIQdtbXZXO4RGATL+O1bYe+yLw8LU
         f6BkCeWFXd0Q6EExY8riK0F2x6ZpoLFPf4RM/sp3CXeerjH8QrWz7IjM6fUbgTWSpJnn
         dAS3eTMVvLpYgOqZg5YRmw1DRzLI0C675XrpDLmtHididANEVHV0tb6Vrf1UgT+fH96b
         DW2nLKRad0mtfgemJnzK//M+3aOKNL56zM7fCQ/Et7rIDhyW6zzJ8rAiT9z1oROfVpT6
         MXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504442; x=1754109242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFyIKyxFfSvkenjutTa3WXgF+K78uS/6Wm5w41WWk5k=;
        b=H+iKs+BBmYH7w1KPiJf8Go3vOO+FKCtR8G7BGRqHM4a0ovA3LhcnN3syyS7wkE429l
         ZgtjLd9An/88i7qzVfe0XHkdWCOA2Chv0lZD6+5SLNkkl1W+PaFzVB0w+c5ZdavL0/8b
         C7N7vOuwZ5p8H0wxLV0WoFIkLRcgABdY+/TS5rtoLffP+8eMsEsbzhpLIdNu23FPdCrW
         7QV4/EqvNTCzna4MtZkoQ0MF0+vl2UWiKTsChTyjOLd5HOuOUG6jpTB8yKKTqwmwuZFL
         pG+GjFit7qYNvKVNQmnYejRsyaAkkc/uItV0wMAnVc4i1YqqIhqM2QpT2NH/EYs/1M52
         Q95w==
X-Forwarded-Encrypted: i=1; AJvYcCWa3hLUdLbiagHiqsMS/wHkcdvAB8Tmo1pIrHBVFknGJblaEvtCQ6Ndr1/CKT0UhkCchzeij1Lo9P3natw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHOTYMA0dD+KYTfPLL8mlVNOtb9425nMAgHlzF/J/vUt02bTgy
	VIm8eCzSdxlpLSn68BKP3mYs7ddpatQMTdONzDEuy9TzjD7RmCQW1FJD
X-Gm-Gg: ASbGncswECW4LVD2/teAR0ABsfn/8+Ealnco3wHcc0OYU3BIh/MVwLcP9aYwmm/fVNt
	u/RnOnIBHSUL9OvfGenyPVAvM1hhY5PFL4aJ8HURWAZ40n5PNPljR7QRNL5ORfmtPny1UEOkNuy
	fzsHyE0zwYjUV1yU8os2IKDd1AdkirtMcyMeeVDw+O8U9AwqAOZFakFnlmEKRMKHxsxet7iEXb7
	0GYKeDkmjc/j2BdrVzu4cm3tcfX9a4R+KQYh8nwxM9nAl9uHF3fC97AaiZQnZWfz7kYEpVp/zx2
	H7pwbm1pQ2ngd9G3tYDSG58LzyiogI5XHU/Y0mUu0rtI1ZdolT940UxM+nMGSXUWt0wlCv6sPlb
	iRivP9mGfQklT+lx19D0/tdNLRGsy8F7ilPeZaHx6K/+TxYmyJIE=
X-Google-Smtp-Source: AGHT+IFpFHZe0lJfxuzoFTC3VS+z3g4wsWyK4qBicXrUgk9/6HYdXvu+ijC0mv83e++I4g7KoxuBsw==
X-Received: by 2002:a05:620a:2552:b0:7e3:426d:f45f with SMTP id af79cd13be357-7e63bfb09b8mr357945985a.34.1753504442457;
        Fri, 25 Jul 2025 21:34:02 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:34:02 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 15/20] staging: rtl8723bs: remove unnecessary braces for single statement blocks
Date: Sat, 26 Jul 2025 04:32:13 +0000
Message-Id: <20250726043218.386738-16-vivek.balachandhar@gmail.com>
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

Removed braces from conditional blocks that contain only a single statement,
as per Linux kernel coding style guidelines. This enhances code clarity
and reduces visual clutter.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index d845eaecd615..fb7ab7eceb54 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -487,9 +487,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			break;
 		}
 
-		if (rtw_roam_flags(adapter)) {
+		if (rtw_roam_flags(adapter))
 			/* TODO: don't select network in the same ess as oldest if it's new enough*/
-		}
 
 		if (!oldest || time_after(oldest->last_scanned, pnetwork->last_scanned))
 			oldest = pnetwork;
@@ -2415,9 +2414,8 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	len = 0;
 	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_OPERATION, &len,
 		       ie_len - sizeof(struct ndis_802_11_fix_ie));
-	if (p && len > 0) {
+	if (p && len > 0)
 		/* todo: */
-	}
 
 	if ((pregistrypriv->bw_mode & 0x0f) > 0)
 		cbw40_enable = 1;
-- 
2.39.5


