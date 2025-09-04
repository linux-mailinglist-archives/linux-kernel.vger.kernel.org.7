Return-Path: <linux-kernel+bounces-799665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB8FB42EC7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91871750A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D821D63C2;
	Thu,  4 Sep 2025 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0GQUUDF"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A855E1CEAB2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949195; cv=none; b=pXCEsohXd9bhEioKo3LOVB7HM8K8UX9eyF+updeM/UkUJuyIHsoMz56aVQiSDKXFsKWwVYwH82LrYNq4AuXVpSlHrUsylIcUe/+jIoaLt2iprQ6LAttqy0pHoLfqqUHxtl2RovAJOS0KrBfhlsITkgkvHXexydIxsfTDwNNp+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949195; c=relaxed/simple;
	bh=Xf0LccqCHjcRpc9m4rzbi0aDOX4yjEMRJ3TSSqCdCAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Es066d5DC0tngZbmCkmdr1VypgEANCEsDfkJUPbGmNnVhaeeEwqNkgaHfaJcohJ9CtBvk9+z3uXZiuMrHSHJaUDmAmSRe6FNVTnNcTi647cSPPgF6lFtcFsU/JQIW0FiC6vJLM9WLDrKmhbwcLfMUPmP3WjlESujkNrfAWdI0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0GQUUDF; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b33032b899so5493281cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949191; x=1757553991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDqO+UoPGgDbKDZcftZWgsNo4sXFXXjdDKh/zegscDg=;
        b=i0GQUUDFLEgJff7bh6oh3Hi/4LIc9nfn9vVIlawz3y2Qttq/JDE0EbwmgOzrrjTNA3
         23ol1XrWmVNnTXnPO79dQ9XnSYxMoSX+eXh1v4u9I7dnW+086gKfRXKDpl1Wc3RzbWbr
         29k2tgfU6HZJ4ASlprkGkd8VRFC/tqnzTcxDrXo2zkVN8sbP7LThUR33wpv0UqbW3umo
         mHqmfKs2zce+NggIlhGOuvkYTfYIb+tTgI6xgEmODl0ioZKbOkCWqCBCNx5AvV10HsaR
         JrOgpUAUVy+Q9vrDuarcn+VTxIo1gg7DjV5RJbkxB7j04G90fZKOwp/qCfBCHGhgqDYb
         sr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949191; x=1757553991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDqO+UoPGgDbKDZcftZWgsNo4sXFXXjdDKh/zegscDg=;
        b=uYikvB6viiBWDmu7WRsl1lhGEG0rN00qo1R1VNIpmFmkh4pAegSzTaBCztnIsMzcFz
         FldT+Z1IO474r/BgyTv3QsjyHJSQXWRmDqQWywSzFWOaAuXEgsGtW29IvD8fiAH5TNc/
         KAjQLH7SVX4YKaLAHD41/p/W1katn4BNgOdJ8YvKOnrlv/ke4z3tCJEPInwywE/mSN7I
         qY/F3JgE3jTV+wsCvEf+jew2daQ8nC1rW3q3vbln2I848624c12LjmhDwRW6vdZssOP4
         bw64RUGuZIWlVE3t71vNEuayPnWnbtFKUjFQ6aW2Vh8MJ2cqnCC+kp1kcVDl2Qx9UM9P
         dgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYas6rwMKnBavPYilpDQY74YBm8cWyy94NgNyYoTKq4GOHNHEvFlWYmNGnNPN+hAdYwoXj2Vw0zc6H1+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvy+O5RxeFdMfrF40LSiuhxRFAjfDadeKaiHeqN5JuN6YoTioC
	KDs+2Guk+PFJeeo/itBIfRu7dc6cm1NGLkyzU1JeHPc88Khb3r0RnM0S
X-Gm-Gg: ASbGncuYEJi7KSsLe+xJTRyWLYpp1yBoxNnqIfVTTABOS6JaKeZCJmg7MuL/NOWKj8u
	zf1RvhUbmvAby08N7JjwkwIyaHTmpoWAaDxX28JSG6z2XpvQ5rjT3w3ZBLkY/Fa686qCKHN43BL
	hViyE4GWk0ZEPJtisFK8utw3S5VRcs6LbUDZ1wl5RBjAU+ZU9dkm7WA9xVnkDFaxMoLH018a7QC
	QqwPhUaPzhe2MW+YCTuXmmr+Ke6BvonsiazAGcODx6BKkzGCb/MDX5VDLgmLPCBD2JTv3QEqXN/
	hVS7S+tJXxlI1z+lFX8lK/4oQj9MWToBTJEPmxf+kU2KEOgY6QaJhFbVJlSuZ5SVnQRKRWBOtvF
	u8pjhezpdnywU+ReQNkt/JNXdiwm4b/63xlrPC2XSeSfLGkAzvYTCrirg7HV7/w==
X-Google-Smtp-Source: AGHT+IFcguj47NJvQCskQGxvudvLVBjK3M6W78q/3sb6x+7iqwaAVb9HjBH4w2kpk4LIWc+w731iYw==
X-Received: by 2002:ac8:58c4:0:b0:4b4:8fc1:cd2b with SMTP id d75a77b69052e-4b48fc1d9c6mr52381131cf.14.1756949191485;
        Wed, 03 Sep 2025 18:26:31 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b682faf5sm38423266d6.65.2025.09.03.18.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:26:31 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 05/16] staging: rtl8723bs: fix logical continuation style by moving to previous line
Date: Thu,  4 Sep 2025 01:25:25 +0000
Message-Id: <20250904012529.215521-6-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
References: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reformat logical continuation to same line as previous statement

Place the logical continuation on the same line as the previous
statement, as recommended by kernel coding style. This improves
readability and avoids unnecessary line breaks.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 24 ++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index cd41f713a52e..2ed7f71e41d1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -352,8 +352,8 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 
 inline int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
 {
-	return (a->ssid.ssid_length == b->ssid.ssid_length)
-		&&  !memcmp(a->ssid.ssid, b->ssid.ssid, a->ssid.ssid_length);
+	return (a->ssid.ssid_length == b->ssid.ssid_length) &&
+		!memcmp(a->ssid.ssid, b->ssid.ssid, a->ssid.ssid_length);
 }
 
 int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 feature)
@@ -792,8 +792,8 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 		}
 	} else {
 		if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
-			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
-				&& check_fwstate(pmlmepriv, _FW_LINKED)) {
+			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) &&
+			    check_fwstate(pmlmepriv, _FW_LINKED)) {
 				if (rtw_select_roaming_candidate(pmlmepriv) == _SUCCESS) {
 					receive_disconnect(adapter,
 							   pmlmepriv->cur_network.network.mac_address,
@@ -945,7 +945,8 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 	if (rtw_to_roam(padapter) > 0)
 		_clr_fwstate_(pmlmepriv, _FW_LINKED);
 
-	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) || rtw_to_roam(padapter) <= 0) {
+	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) ||
+	    rtw_to_roam(padapter) <= 0) {
 		/*  Do it first for tx broadcast pkt after disconnection issue! */
 		netif_carrier_off(padapter->pnetdev);
 
@@ -985,8 +986,8 @@ void rtw_scan_abort(struct adapter *adapter)
 
 	start = jiffies;
 	pmlmeext->scan_abort = true;
-	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)
-		&& jiffies_to_msecs(start) <= 200) {
+	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) &&
+	       jiffies_to_msecs(start) <= 200) {
 		if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 			break;
 
@@ -1714,8 +1715,8 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 	if (adapter->net_closed)
 		return;
 
-	if ((adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
-		&& !(hal_btcoex_IsBtControlLps(adapter))
+	if ((adapter_to_pwrctl(adapter)->fw_current_in_ps_mode) &&
+	    !(hal_btcoex_IsBtControlLps(adapter))
 		) {
 		u8 bEnterPS;
 
@@ -1873,8 +1874,9 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 		goto exit;
 
 	if (rtw_to_roam(adapter) > 0) {
-		if (jiffies_to_msecs(jiffies - competitor->last_scanned) >= mlme->roam_scanr_exp_ms
-			|| is_same_ess(&competitor->network, &mlme->cur_network.network) == false
+		if (jiffies_to_msecs(jiffies - competitor->last_scanned) >=
+		    mlme->roam_scanr_exp_ms ||
+		    is_same_ess(&competitor->network, &mlme->cur_network.network) == false
 		)
 			goto exit;
 	}
-- 
2.39.5


