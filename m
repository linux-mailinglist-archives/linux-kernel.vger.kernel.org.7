Return-Path: <linux-kernel+bounces-750594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18B1B15E73
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27A1561FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10222989B3;
	Wed, 30 Jul 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBI25W6c"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0572949E0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872317; cv=none; b=GsNwZkI1Ufl8QIZunDFsZ2g7vxf+mIJ1UsjmvzJlnoaBqhNsIyr6F5/k/aMgCIV2+yyIyFU00zJzLJ0aL1OLvLkodKoos62YL3SN7KntFwyFGSoYiUtN7lc9g9SbI0o2yFKEALRXxxPUCCPiPDXZj2pJIdXUbIlPxvOELr/R5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872317; c=relaxed/simple;
	bh=fwh6BBb1oPpBjnAuFQhlbe/p9oFK7aX4uP4YTtMMkRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMtbWT7VxMympJGASpd86sSFTAiWeZeE90Tl4gmisXLNpaoxnXpED1Uft0Kw0XaB5XLD8p5vhg/amclMWWgANBL3OBT/u6dMhFPZXI/NGZLk608hFirkGiRpX9C72XuURSKXEdM7XJrTJjFw2DdQeBofs/MkFkhYNHDS0c20Mmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBI25W6c; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so4829579a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753872312; x=1754477112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gD7P+A/dPPOpT95JlWf4RUNkIaG+iReLqz+c8wdRhiw=;
        b=HBI25W6cw4RKllOMGRw4U677hJTwB6s1Rp8q8A0e1Ak5LH/CiwJAtxIM0KASgRe4rA
         kh0IsL8k/PBn4eiAUNLHHOGpsYIXMuf54/LmWFjSmJvZ1ivpPfjPKPtXtFuTIA7pf6y8
         qTz8ERgAt79Z1WBm3ccAq+p1FVspOH4Wf4Ve36wXUCD3yOtp9zNhOPyFFW3ucftXDJuG
         nbaCsTKomXXmr8MyhPxzenhSGu/ivxjgEllTDKG79IRspa0/leePayQtgZJlOWOzEy8D
         lbI+wx/Hne2Ly7D3ZrP4YAhU7+b1cEnWjYHTXZKdDGNXaXTMxOlnbEK4CaZtO97y9LwF
         6hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753872312; x=1754477112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gD7P+A/dPPOpT95JlWf4RUNkIaG+iReLqz+c8wdRhiw=;
        b=m40n+NBqLeFriTx6fqxLZ/7DBDbUF9Oj4hkmtD9AhLUkoWOqp9ahptfvl2reNWDGWF
         WrWqydDcxL5I7UGSR32e6V9LDnWZGrEO7ik624pYjASP3L50QUaJo/b1uOekGRYlRUdQ
         7lbMCVdXggcwXvJkAxloPCHd6Bo40tVJfAdmbpAPMOv61xp/qUzElvlbSDrPU0n6lVv9
         KQzNC/1i1/KQZH4VBSDP8+mwIOr/DEp8bvF9elQBMu+pTMBD0YA3iwKL87lAuClvzdew
         29Se6KM7v3VEOBt8rk6oOqcFJeMwL+hwtwu9GCfcf6BlhdS/ZCzqe4DEvKNzsgw0qBV+
         3xdg==
X-Forwarded-Encrypted: i=1; AJvYcCVeiNeLYg98svZkzu+y3pje01TSJGmBd3xU/D30aldxZ8aU9aNglBqxaVr99w8vVUEY1WCqLkXutmRcSD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxRmr4evzEOHL7xCqC5Ls1rjdumJNSFrRlzMF2iGDFyQfi7fK
	mfgyLastgs6rCfDG5A3X82Ex39fQ6I9ugNqkqtb6+/Vj4DeBqaMXa6y8
X-Gm-Gg: ASbGncu7uVdwNdOFCzjFFqiCoOOZ5a9+Yi+5YqutrZAh+Vj1VoYNurtmoSh9rpoYOaT
	a17k8E/3HTGbsbNRPtIJ7SQ6cnv78uIuDIxEidP11LMaG8NQtnvV1NLQgW3JtzXg62zWVrIftf3
	s+SIb+CfOJaw2g4N80Y50oj1z6FQDgsHbFRYEhxsgfGwtwPx88devFSw+MrbZiRHoYJhSjscwZZ
	iEzxvGGCgBnUadjWEc5020Hty1Bkh6X3ReFKnbQaRhf9dVPEtldXIdxV9tcfnetnL63VQMny0SU
	S1Zaeez0it86oC+KdCG1j+NX5XRm+Enfwqzgphf9xgPKTZbIwEKCjqgDVcI5NhkhsAlse/9jPUe
	0IxLIy6+bC9sCw6kj1/hYkaynxjpQsF9X0NEclKFNy9pT9MlJDf/kLoXv
X-Google-Smtp-Source: AGHT+IGpHLLmmk9Td6T7DijXaBzDDXhnBjG/5PT9Z+sbGUV25oV0DkzwZaprzzQBGuKKiMQcuzrwvw==
X-Received: by 2002:a05:6402:5108:b0:615:6481:d1c with SMTP id 4fb4d7f45d1cf-61586ec9a54mr2432690a12.1.1753872312170;
        Wed, 30 Jul 2025 03:45:12 -0700 (PDT)
Received: from tumbleweed (ip-77-25-32-208.web.vodafone.de. [77.25.32.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157974fde0sm1582734a12.7.2025.07.30.03.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:45:11 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/8] staging: rtl8723bs: merge rtw_os_indicate_disconnect into rtw_indicate_disconnect
Date: Wed, 30 Jul 2025 12:44:59 +0200
Message-ID: <20250730104501.150270-7-straube.linux@gmail.com>
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

Merge the functionality of the function rtw_os_indicate_disconnect into the
function rtw_indicate_disconnect to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c      | 12 ++++++++----
 drivers/staging/rtl8723bs/include/mlme_osdep.h |  1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c  | 12 ------------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 38238ea5ec99..27f775d8f9a8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -930,10 +930,14 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 	if (rtw_to_roam(padapter) > 0)
 		_clr_fwstate_(pmlmepriv, _FW_LINKED);
 
-	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED)
-		|| (rtw_to_roam(padapter) <= 0)
-	) {
-		rtw_os_indicate_disconnect(padapter);
+	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) || rtw_to_roam(padapter) <= 0) {
+		/*  Do it first for tx broadcast pkt after disconnection issue! */
+		netif_carrier_off(padapter->pnetdev);
+
+		rtw_cfg80211_indicate_disconnect(padapter);
+
+		/* modify for CONFIG_IEEE80211W, none 11w also can use the same command */
+		rtw_reset_securitypriv_cmd(padapter);
 
 		/* set ips_deny_time to avoid enter IPS before LPS leave */
 		rtw_set_ips_deny(padapter, 3000);
diff --git a/drivers/staging/rtl8723bs/include/mlme_osdep.h b/drivers/staging/rtl8723bs/include/mlme_osdep.h
index 00c0a44c125a..8e8b5de285dc 100644
--- a/drivers/staging/rtl8723bs/include/mlme_osdep.h
+++ b/drivers/staging/rtl8723bs/include/mlme_osdep.h
@@ -8,7 +8,6 @@
 #define __MLME_OSDEP_H_
 
 
-extern void rtw_os_indicate_disconnect(struct adapter *adapter);
 extern void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie);
 
 void rtw_reset_securitypriv(struct adapter *adapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 326acbd8dc84..d2f4855e9d9d 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -66,18 +66,6 @@ void rtw_reset_securitypriv(struct adapter *adapter)
 	spin_unlock_bh(&adapter->security_key_mutex);
 }
 
-void rtw_os_indicate_disconnect(struct adapter *adapter)
-{
-	/* struct rt_pmkid_list   backupPMKIDList[ NUM_PMKID_CACHE ]; */
-
-	netif_carrier_off(adapter->pnetdev); /*  Do it first for tx broadcast pkt after disconnection issue! */
-
-	rtw_cfg80211_indicate_disconnect(adapter);
-
-	/* modify for CONFIG_IEEE80211W, none 11w also can use the same command */
-	rtw_reset_securitypriv_cmd(adapter);
-}
-
 void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 {
 	uint	len;
-- 
2.50.1


