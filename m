Return-Path: <linux-kernel+bounces-746612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6244B128F4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B4BAC5DA4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A103920C480;
	Sat, 26 Jul 2025 04:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct8iFYAZ"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF420A5EA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504422; cv=none; b=Oa1hp3X/ay9YpW/VrGTdLbclKkGDw51MFDEtceavprrcF9QRYA3Ws1fyHLtOk+FQDGcGq5GXc8wifXLTEGhg4eseUHqOvuotnKSNC0LuWl1JVcBBTBAjiHCvOUmTOGGmDMyW5FwLT8wCsRuV0CmaYFT7wbJJEetea4XDX7fbrBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504422; c=relaxed/simple;
	bh=SRxtK0JH89F8hBmSzbGvdaaHXorHThTNvv+kEsGvH8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KF8CMV8J8stS6bZ+xH6ThWjawa1pkMOuqxa5pxeclnVgD+dYKJ6YqqHc0nvd8EU1ttM0RPQSf79QJ+LbBBYFmsZc8b61VYcpPJsNatdFt8kUUHuzXp+oKdqq6vpYX8P/kexIoBM13BzMjaIQ4zGQnlfXAeOQqeY+kZ6M6XIGGOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct8iFYAZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e32c95778aso138627485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504419; x=1754109219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+DVbx1MrURkCA8xTzQLnT2mXdd8wFgAshN4l3PzqwA=;
        b=ct8iFYAZ8rFoHzyKsTqF4v+vM4oxGrtOXnHpjKr4lcl5OSy7Zh8qC68ggfdWft8Gcm
         nmEGFGHexjeu5KFggR+AaM+im65dP0IGAPNlKkiWXklak+7Hre3Zj0CU0lPW8/qvbJo9
         dkpGcNGnBUNIuWolGDT75ft3j0jCD0yOqDhnycQDIF0YgaNy/+ymBD4kV+BSfgIchccs
         cKO++EPJqHm+VplzOGpIZVAEGrnCbxrJuawMFWHiEvKvqpXDJxUyHbIt71LTfYU0OySf
         NdrTemxm0SvCSYiPxV4JPGGvPVpxBQ1z0IerIbUO/4DK4hqmz9ycM4UExHGt29S1rIUQ
         iDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504419; x=1754109219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+DVbx1MrURkCA8xTzQLnT2mXdd8wFgAshN4l3PzqwA=;
        b=bZQxk1yzAek3MTf7qKwW3lZSJ0CysEmhA9nTAwvDHxz449JYYxtfKvi4mevbmRXSxv
         18KsxAeHRpMbHQTyZSG9fVqLyiRJB/Sqg5mlhnDriJjmkIW2b/g+fkzv4qRKQCZJ8neX
         2LdVkzaJINGP9xyXfduhERucJrxwpk5uGdNL/KOUQ3bEA9ZCORmgAZqugcU8xorexZHq
         8Hgu3m882pZLa0EPSGwKzNjgwvav4ybEsi9npknu3wwQ2JCG1faKv8sq7cGUR4XmQUAa
         UtbKUJhvG7bqz7kRKC21FvLe+9pFYXqL+KCUEw+OJjaIFbaRGLrJXjSAv+yoccQpJGZL
         7YXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxrNRQZMq6dunQ2DVfWEAZsd2C7hGDstnwIWWyGrtdsgEqbl4VJzxowHH2PnskmV+4I6d1Oiyesq6dWJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcekKSnU2bgVQ9fh2zpagL2e/EGISSYVeCeEPvexyF/ARqd2gG
	CBMSEimrjI3USP4ji8D+aS0voY6P/q7izntldr4Z6O73lOAIq74tt/J/
X-Gm-Gg: ASbGncunmbZb8kcrA7FjeZFX7j+j3F0qAhdqqCg5Xs3CiDT1EJOhw/2cEFUaC2ZV1gV
	y+XSI2kcow4TEIjdICmMhPCeq80RxLUrlT1/v/PEmq/TYQ6AAinS6RYuKu/zPme+NVJR3+tFZvE
	DZSRzrLLO+8Zh59ZnaDdB5ACa964YGH6jfYi1/hznoaSkboG7LdfTP07bOaqQ60Gfc6y9gCz7jp
	xgmUlzR0xMEE5tKq3ZRLpEmo+Rh+4OUxFRtbOPTMmk7r8EANYQhu4CPQkNpvu4O17jq2DXCtkVW
	VmmLRYgf6LghNO5s6rNJ82gzs/rQNcAof5UWi/8huklUqVsF26k6Y9JBxa9EJFpzqXtLakN71Uo
	MEfqbOX+Xh2qkMmm5kRkhFvDkevqA4LFE6bhETy6zK3WBt0+MRA0=
X-Google-Smtp-Source: AGHT+IHwvk+B9W8uYCycFDMT6p8Vu2V1fah6Knu6y7JULxBVIj9mj+jlK7uEwha8Km1Kn1alAtfMjg==
X-Received: by 2002:a05:620a:31a5:b0:7e0:e7b0:967e with SMTP id af79cd13be357-7e63bf5b671mr568167685a.7.1753504418915;
        Fri, 25 Jul 2025 21:33:38 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:38 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 06/20] staging: rtl8723bs: fix overlong lines and clarify lengthy comments
Date: Sat, 26 Jul 2025 04:32:04 +0000
Message-Id: <20250726043218.386738-7-vivek.balachandhar@gmail.com>
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

This commit addresses two main issues:

1. Fixed multiple instances of overlong lines in the code to conform with
   Linux kernel style guidelines, which recommend lines not exceed 80
   characters for better readability in various editors and tools.

2. Clarified a lengthy comment block by reformatting it into a more readable,
   multi-line style with proper indentation and phrasing. The updated comment
   now clearly explains the function's context, parameters, and behavior in
   a concise and structured manner, improving maintainability.

No functional changes were made; this is purely a code style and documentation
improvement.

Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 242 +++++++++++++++-------
 1 file changed, 166 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index f8680124ce24..fb1768284c2e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -22,7 +22,10 @@ int	rtw_init_mlme_priv(struct adapter *padapter)
 	pmlmepriv->pscanned = NULL;
 	pmlmepriv->fw_state = WIFI_STATION_STATE; /*  Must sync with rtw_wdev_alloc() */
 	pmlmepriv->cur_network.network.infrastructure_mode = Ndis802_11AutoUnknown;
-	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: passive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
+	/* 1: active, 0: passive. Maybe someday we should rename
+	 * this varable to "active_mode" (Jeff)
+	 */
+	pmlmepriv->scan_mode = SCAN_ACTIVE;
 
 	spin_lock_init(&pmlmepriv->lock);
 	INIT_LIST_HEAD(&pmlmepriv->free_bss_pool.queue);
@@ -95,7 +98,8 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv)
 	rtw_free_mlme_ie_data(&pmlmepriv->p2p_beacon_ie, &pmlmepriv->p2p_beacon_ie_len);
 	rtw_free_mlme_ie_data(&pmlmepriv->p2p_probe_req_ie, &pmlmepriv->p2p_probe_req_ie_len);
 	rtw_free_mlme_ie_data(&pmlmepriv->p2p_probe_resp_ie, &pmlmepriv->p2p_probe_resp_ie_len);
-	rtw_free_mlme_ie_data(&pmlmepriv->p2p_go_probe_resp_ie, &pmlmepriv->p2p_go_probe_resp_ie_len);
+	rtw_free_mlme_ie_data(&pmlmepriv->p2p_go_probe_resp_ie,
+			      &pmlmepriv->p2p_go_probe_resp_ie_len);
 	rtw_free_mlme_ie_data(&pmlmepriv->p2p_assoc_req_ie, &pmlmepriv->p2p_assoc_req_ie_len);
 }
 
@@ -346,7 +350,8 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 			(d_cap & WLAN_CAPABILITY_ESS));
 }
 
-struct wlan_network *_rtw_find_same_network(struct __queue *scanned_queue, struct wlan_network *network)
+struct wlan_network *_rtw_find_same_network(struct __queue *scanned_queue,
+					    struct wlan_network *network)
 {
 	struct list_head *phead, *plist;
 	struct wlan_network *found = NULL;
@@ -396,8 +401,11 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	u8 sq_final;
 	long rssi_final;
 
-	/* The rule below is 1/5 for sample value, 4/5 for history value */
-	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) && is_same_network(&padapter->mlmepriv.cur_network.network, src, 0)) {
+	/* The rule below is 1/5 for sample value,
+	 * 4/5 for history value
+	 */
+	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) &&
+	    is_same_network(&padapter->mlmepriv.cur_network.network, src, 0)) {
 		/* Take the recvpriv's value for the connected AP*/
 		ss_final = padapter->recvpriv.signal_strength;
 		sq_final = padapter->recvpriv.signal_qual;
@@ -408,11 +416,15 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 			rssi_final = rssi_ori;
 	} else {
 		if (sq_smp != 101) { /* from the right channel */
-			ss_final = ((u32)(src->phy_info.signal_strength) + (u32)(dst->phy_info.signal_strength) * 4) / 5;
-			sq_final = ((u32)(src->phy_info.signal_quality) + (u32)(dst->phy_info.signal_quality) * 4) / 5;
+			ss_final = ((u32)(src->phy_info.signal_strength) +
+				    (u32)(dst->phy_info.signal_strength) * 4) / 5;
+			sq_final = ((u32)(src->phy_info.signal_quality) +
+				    (u32)(dst->phy_info.signal_quality) * 4) / 5;
 			rssi_final = (src->rssi + dst->rssi * 4) / 5;
 		} else {
-			/* bss info not receiving from the right channel, use the original RX signal infos */
+			/* bss info not receiving from the right channel,
+			 * use the original RX signal infos
+			 */
 			ss_final = dst->phy_info.signal_strength;
 			sq_final = dst->phy_info.signal_quality;
 			rssi_final = dst->rssi;
@@ -439,10 +451,13 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 		&pmlmepriv->cur_network.network,
 		&pmlmepriv->cur_network.network);
 
-	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) && (is_same_network(&pmlmepriv->cur_network.network, pnetwork, 0))) {
+	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) &&
+	    (is_same_network(&pmlmepriv->cur_network.network, pnetwork, 0))) {
 		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
-		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
-								pmlmepriv->cur_network.network.ie_length);
+		rtw_update_protection(adapter,
+				      (pmlmepriv->cur_network.network.ies) +
+				      sizeof(struct ndis_802_11_fix_ie),
+				      pmlmepriv->cur_network.network.ie_length);
 	}
 }
 
@@ -577,7 +592,9 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	privacy = pnetwork->network.privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		if (rtw_get_wps_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, pnetwork->network.ie_length - _FIXED_IE_LENGTH_, NULL, &wps_ielen))
+		if (rtw_get_wps_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_,
+				   pnetwork->network.ie_length - _FIXED_IE_LENGTH_,
+				   NULL, &wps_ielen))
 			return true;
 		else
 			return false;
@@ -590,7 +607,8 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 			bselected = false;
 
 		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
-			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
+			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, WLAN_EID_RSN,
+				       &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
 			if (p && ie_len > 0)
 				bselected = true;
 			else
@@ -602,7 +620,8 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 		bselected = false;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
-		if (pnetwork->network.infrastructure_mode != pmlmepriv->cur_network.network.infrastructure_mode)
+		if (pnetwork->network.infrastructure_mode !=
+			pmlmepriv->cur_network.network.infrastructure_mode)
 			bselected = false;
 	}
 
@@ -630,12 +649,14 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  update IBSS_network 's timestamp */
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) {
-		if (!memcmp(&pmlmepriv->cur_network.network.mac_address, pnetwork->mac_address, ETH_ALEN)) {
+		if (!memcmp(&pmlmepriv->cur_network.network.mac_address,
+			    pnetwork->mac_address, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
 			memcpy(pmlmepriv->cur_network.network.ies, pnetwork->ies, 8);
 			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
-			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,  pnetwork->mac_address);
+			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,
+						     pnetwork->mac_address);
 			if (ibss_wlan) {
 				memcpy(ibss_wlan->network.ies, pnetwork->ies, 8);
 				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
@@ -686,13 +707,18 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 				} else {
 					u8 ret = _SUCCESS;
-					struct wlan_bssid_ex    *pdev_network = &adapter->registrypriv.dev_network;
+					struct wlan_bssid_ex *pdev_network =
+						&adapter->registrypriv.dev_network;
 					u8 *pibss = adapter->registrypriv.dev_network.mac_address;
 
-					/* pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;because don't set assoc_timer */
+					/*
+					 * pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
+					 * because don't set assoc_timer.
+					 */
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-					memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+					memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid,
+					       sizeof(struct ndis_802_11_ssid));
 
 					rtw_update_registrypriv_dev_network(adapter);
 					rtw_generate_random_ibss(pibss);
@@ -719,8 +745,11 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 				rtw_indicate_connect(adapter);
 			} else {
 				if (rtw_to_roam(adapter) != 0) {
-					if (rtw_dec_to_roam(adapter) == 0
-						|| _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)
+					if (rtw_dec_to_roam(adapter) == 0 ||
+					    _SUCCESS != rtw_sitesurvey_cmd(adapter,
+									   &pmlmepriv->assoc_ssid,
+									   1,
+									   NULL, 0)
 					) {
 						rtw_set_to_roam(adapter, 0);
 						rtw_free_assoc_resources(adapter, 1);
@@ -739,8 +768,9 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
 				&& check_fwstate(pmlmepriv, _FW_LINKED)) {
 				if (rtw_select_roaming_candidate(pmlmepriv) == _SUCCESS) {
-					receive_disconnect(adapter, pmlmepriv->cur_network.network.mac_address
-						, WLAN_REASON_ACTIVE_ROAM);
+					receive_disconnect(adapter,
+							   pmlmepriv->cur_network.network.mac_address,
+							   WLAN_REASON_ACTIVE_ROAM);
 				}
 			}
 		}
@@ -928,7 +958,8 @@ void rtw_scan_abort(struct adapter *adapter)
 	pmlmeext->scan_abort = false;
 }
 
-static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, struct wlan_network *pnetwork)
+static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter,
+						   struct wlan_network *pnetwork)
 {
 	int i;
 	struct sta_info *bmc_sta, *psta = NULL;
@@ -984,9 +1015,12 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			padapter->securitypriv.wps_ie_len = 0;
 		}
 
-		/* for A-MPDU Rx reordering buffer control for bmc_sta & sta_info */
-		/* if A-MPDU Rx is enabled, resetting  rx_ordering_ctrl wstart_b(indicate_seq) to default value = 0xffff */
-		/* todo: check if AP can send A-MPDU packets */
+		/*
+		 * for A-MPDU Rx reordering buffer control for bmc_sta & sta_info.
+		 * if A-MPDU Rx is enabled, resetting rx_ordering_ctrl wstart_b(indicate_seq)
+		 * to default value = 0xffff.
+		 * todo: check if AP can send A-MPDU packets.
+		 */
 		for (i = 0; i < 16 ; i++) {
 			preorder_ctrl = &psta->recvreorder_ctrl[i];
 			preorder_ctrl->enable = false;
@@ -1002,7 +1036,8 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
 				preorder_ctrl->wend_b = 0xffff;
-				preorder_ctrl->wsize_b = 64;/* max_ampdu_sz;ex. 32(kbytes) -> wsize_b =32 */
+				/* max_ampdu_sz;ex. 32(kbytes) -> wsize_b =32 */
+				preorder_ctrl->wsize_b = 64;
 			}
 		}
 	}
@@ -1012,7 +1047,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 
 /* pnetwork : returns from rtw_joinbss_event_callback */
 /* ptarget_wlan: found from scanned_queue */
-static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_network *ptarget_wlan, struct wlan_network  *pnetwork)
+static void rtw_joinbss_update_network(struct adapter *padapter,
+				       struct wlan_network *ptarget_wlan,
+				       struct wlan_network  *pnetwork)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network  *cur_network = &pmlmepriv->cur_network;
@@ -1029,8 +1066,12 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 
 	padapter->recvpriv.signal_strength = ptarget_wlan->network.phy_info.signal_strength;
 	padapter->recvpriv.signal_qual = ptarget_wlan->network.phy_info.signal_quality;
-	/* the ptarget_wlan->network.rssi is raw data, we use ptarget_wlan->network.phy_info.signal_strength instead (has scaled) */
-	padapter->recvpriv.rssi = translate_percentage_to_dbm(ptarget_wlan->network.phy_info.signal_strength);
+	/* the ptarget_wlan->network.rssi is raw data,
+	 * we use ptarget_wlan->network.phy_info.signal_strength instead (has scaled)
+	 */
+	padapter->recvpriv.rssi =
+	translate_percentage_to_dbm(
+		ptarget_wlan->network.phy_info.signal_strength);
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
@@ -1052,20 +1093,30 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 			break;
 	}
 
-	rtw_update_protection(padapter, (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
-									(cur_network->network.ie_length));
+	rtw_update_protection(padapter,
+			      (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
+			      (cur_network->network.ie_length));
 
-	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8)cur_network->network.configuration.ds_config);
+	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length,
+			  (u8)cur_network->network.configuration.ds_config);
 }
 
-/* Notes: the function could be > passive_level (the same context as Rx tasklet) */
-/* pnetwork : returns from rtw_joinbss_event_callback */
-/* ptarget_wlan: found from scanned_queue */
-/* if join_res > 0, for (fw_state ==WIFI_STATION_STATE), we check if  "ptarget_sta" & "ptarget_wlan" exist. */
-/* if join_res > 0, for (fw_state ==WIFI_ADHOC_STATE), we only check if "ptarget_wlan" exist. */
-/* if join_res > 0, update "cur_network->network" from "pnetwork->network" if (ptarget_wlan != NULL). */
-/*  */
-/* define REJOIN */
+/*
+ * The function can be called at > PASSIVE_LEVEL (same context as Rx tasklet).
+ * 'pnetwork' is returned from rtw_joinbss_event_callback.
+ * 'ptarget_wlan' is found from scanned_queue.
+ *
+ * If join_res > 0 and fw_state == WIFI_STATION_STATE, we check whether
+ * 'ptarget_sta' and 'ptarget_wlan' exist.
+ *
+ * If join_res > 0 and fw_state == WIFI_ADHOC_STATE, we only check whether
+ * 'ptarget_wlan' exists.
+ *
+ * If join_res > 0 and 'ptarget_wlan' is not NULL, update
+ * cur_network->network from pnetwork->network.
+ *
+ * Define REJOIN.
+ */
 void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 {
 	static u8 __maybe_unused retry;
@@ -1077,7 +1128,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
 	unsigned int		the_same_macaddr = false;
 
-	the_same_macaddr = !memcmp(pnetwork->network.mac_address, cur_network->network.mac_address, ETH_ALEN);
+	the_same_macaddr = !memcmp(pnetwork->network.mac_address,
+				   cur_network->network.mac_address, ETH_ALEN);
 
 	pnetwork->network.length = get_wlan_bssid_ex_sz(&pnetwork->network);
 	if (pnetwork->network.length > sizeof(struct wlan_bssid_ex))
@@ -1130,7 +1182,9 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 				goto ignore_joinbss_callback;
 			}
 
-			/* s3. find ptarget_sta & update ptarget_sta after update cur_network only for station mode */
+			/* s3. find ptarget_sta & update ptarget_sta after update
+			 * cur_network only for station mode
+			 */
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
 				if (!ptarget_sta) {
@@ -1262,8 +1316,10 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
 	if (psta) {
 		/* the sta have been in sta_info_queue => do nothing */
-
-		return; /* between drv has received this event before and  fw have not yet to set key to CAM_ENTRY) */
+		/* between drv has received this event before and fw
+		 * have not yet to set key to CAM_ENTRY)
+		 */
+		return;
 	}
 
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
@@ -1290,7 +1346,8 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
 		if (adapter->stapriv.asoc_sta_count == 2) {
 			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
-			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.mac_address);
+			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue,
+							cur_network->network.mac_address);
 			pmlmepriv->cur_network_scanned = ptarget_wlan;
 			if (ptarget_wlan)
 				ptarget_wlan->fixed = true;
@@ -1347,16 +1404,19 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 		if (adapter->registrypriv.wifi_spec == 1) {
 			roam = false;
-		} else if (reason == WLAN_REASON_EXPIRATION_CHK && rtw_chk_roam_flags(adapter, RTW_ROAM_ON_EXPIRED)) {
+		} else if (reason == WLAN_REASON_EXPIRATION_CHK &&
+			   rtw_chk_roam_flags(adapter, RTW_ROAM_ON_EXPIRED)) {
 			roam = true;
-		} else if (reason == WLAN_REASON_ACTIVE_ROAM && rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
+		} else if (reason == WLAN_REASON_ACTIVE_ROAM &&
+			   rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
 			roam = true;
 			roam_target = pmlmepriv->roam_network;
 		}
 
 		if (roam) {
 			if (rtw_to_roam(adapter) > 0)
-				rtw_dec_to_roam(adapter); /* this stadel_event is caused by roaming, decrease to_roam */
+				/* this stadel_event is caused by roaming, decrease to_roam */
+				rtw_dec_to_roam(adapter);
 			else if (rtw_to_roam(adapter) == 0)
 				rtw_set_to_roam(adapter, adapter->registrypriv.max_roaming_times);
 		} else {
@@ -1370,7 +1430,8 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		/*  remove the network entry in scanned_queue */
-		pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
+		pwlan = rtw_find_network(&pmlmepriv->scanned_queue,
+					 tgt_network->network.mac_address);
 		if (pwlan) {
 			pwlan->fixed = false;
 			rtw_free_network_nolock(adapter, pwlan);
@@ -1384,11 +1445,13 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	      check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 		rtw_free_stainfo(adapter,  psta);
 
-		if (adapter->stapriv.asoc_sta_count == 1) {/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
+		if (adapter->stapriv.asoc_sta_count == 1) {
+			/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
 			u8 ret = _SUCCESS;
 			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			/* free old ibss network */
-			pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
+			pwlan = rtw_find_network(&pmlmepriv->scanned_queue,
+						 tgt_network->network.mac_address);
 			if (pwlan) {
 				pwlan->fixed = false;
 				rtw_free_network_nolock(adapter, pwlan);
@@ -1398,9 +1461,11 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			pdev_network = &adapter->registrypriv.dev_network;
 			pibss = adapter->registrypriv.dev_network.mac_address;
 
-			memcpy(pdev_network, &tgt_network->network, get_wlan_bssid_ex_sz(&tgt_network->network));
+			memcpy(pdev_network, &tgt_network->network,
+			       get_wlan_bssid_ex_sz(&tgt_network->network));
 
-			memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+			memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid,
+			       sizeof(struct ndis_802_11_ssid));
 
 			rtw_update_registrypriv_dev_network(adapter);
 
@@ -1471,7 +1536,9 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 		rtw_indicate_disconnect(adapter);
 		free_scanqueue(pmlmepriv);/*  */
 
-		/* indicate disconnect for the case that join_timeout and check_fwstate != FW_LINKED */
+		/* indicate disconnect for the case that
+		 * join_timeout and check_fwstate != FW_LINKED
+		 */
 		rtw_cfg80211_indicate_disconnect(adapter);
 	}
 
@@ -1520,8 +1587,8 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 
 	rtw_mlme_reset_auto_scan_int(padapter);
 
-	if (pmlmepriv->auto_scan_int_ms != 0
-		&& jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time) > pmlmepriv->auto_scan_int_ms) {
+	if (pmlmepriv->auto_scan_int_ms != 0 &&
+	    jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time) > pmlmepriv->auto_scan_int_ms) {
 		if (!padapter->registrypriv.wifi_spec) {
 			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) == true)
 				goto exit;
@@ -1563,7 +1630,9 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 			/* rtw_lps_ctrl_wk_cmd(adapter, LPS_CTRL_ENTER, 1); */
 			rtw_hal_dm_watchdog_in_lps(adapter);
 		} else {
-			/* call rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_LEAVE, 1) in traffic_status_watchdog() */
+			/* call rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_LEAVE, 1)
+			 * in traffic_status_watchdog()
+			 */
 		}
 
 	} else {
@@ -1623,7 +1692,8 @@ static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 	if (jiffies_to_msecs(jiffies - competitor->last_scanned) >= mlme->roam_scanr_exp_ms)
 		goto exit;
 
-	if (competitor->network.rssi - mlme->cur_network_scanned->network.rssi < mlme->roam_rssi_diff_th)
+	if (competitor->network.rssi - mlme->cur_network_scanned->network.rssi <
+								mlme->roam_rssi_diff_th)
 		goto exit;
 
 	if (*candidate && (*candidate)->network.rssi >= competitor->network.rssi)
@@ -1697,7 +1767,8 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 	/* check ssid, if needed */
 	if (mlme->assoc_ssid.ssid[0] && mlme->assoc_ssid.ssid_length) {
 		if (competitor->network.ssid.ssid_length != mlme->assoc_ssid.ssid_length
-			|| memcmp(competitor->network.ssid.ssid, mlme->assoc_ssid.ssid, mlme->assoc_ssid.ssid_length)
+			|| memcmp(competitor->network.ssid.ssid, mlme->assoc_ssid.ssid,
+				  mlme->assoc_ssid.ssid_length)
 		)
 			goto exit;
 	}
@@ -1814,7 +1885,8 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
 	return res;
 }
 
-signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, signed int keyid, u8 set_tx, bool enqueue)
+signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv,
+		       signed int keyid, u8 set_tx, bool enqueue)
 {
 	u8 keylen;
 	struct cmd_obj		*pcmd;
@@ -1889,7 +1961,8 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 }
 
 /* adjust ies for rtw_joinbss_cmd in WMM */
-int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_len, uint initial_out_len)
+int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie,
+			uint in_len, uint initial_out_len)
 {
 	unsigned	int ielength = 0;
 	unsigned int i, j;
@@ -1898,7 +1971,9 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	while (i < in_len) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 && in_ie[i + 3] == 0x50  && in_ie[i + 4] == 0xF2 && in_ie[i + 5] == 0x02 && i + 5 < in_len) { /* WMM element ID and OUI */
+		if (in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 && in_ie[i + 3] == 0x50  &&
+		    in_ie[i + 4] == 0xF2 && in_ie[i + 5] == 0x02 && i + 5 < in_len) {
+			/* WMM element ID and OUI */
 			for (j = i; j < i + 9; j++) {
 				out_ie[ielength] = in_ie[j];
 				ielength++;
@@ -1988,7 +2063,8 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 		ielength += psecuritypriv->wps_ie_len;
 	} else if ((authmode == WLAN_EID_VENDOR_SPECIFIC) || (authmode == WLAN_EID_RSN)) {
 		/* copy RSN or SSN */
-		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1] + 2);
+		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0],
+		       psecuritypriv->supplicant_ie[1] + 2);
 		ielength += psecuritypriv->supplicant_ie[1] + 2;
 		rtw_report_sec_ie(adapter, authmode, psecuritypriv->supplicant_ie);
 	}
@@ -2026,7 +2102,8 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	struct	security_priv *psecuritypriv = &adapter->securitypriv;
 	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
 
-	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ; /*  adhoc no 802.1x */
+	/*  adhoc no 802.1x */
+	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ;
 
 	pdev_network->rssi = 0;
 
@@ -2056,14 +2133,18 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	/*  1. Supported rates */
 	/*  2. IE */
 
-	/* rtw_set_supported_rate(pdev_network->supported_rates, pregistrypriv->wireless_mode) ;  will be called in rtw_generate_ie */
+	/* rtw_set_supported_rate(pdev_network->supported_rates, pregistrypriv->wireless_mode);
+	 * will be called in rtw_generate_ie
+	 */
 	sz = rtw_generate_ie(pregistrypriv);
 
 	pdev_network->ie_length = sz;
 
 	pdev_network->length = get_wlan_bssid_ex_sz((struct wlan_bssid_ex  *)pdev_network);
 
-	/* notes: translate ie_length & length after assign the length to cmdsz in createbss_cmd(); */
+	/* notes: translate ie_length & length after assign
+	 * the length to cmdsz in createbss_cmd();
+	 */
 	/* pdev_network->ie_length = cpu_to_le32(sz); */
 }
 
@@ -2075,7 +2156,9 @@ void rtw_joinbss_reset(struct adapter *padapter)
 
 	struct ht_priv	*phtpriv = &pmlmepriv->htpriv;
 
-	/* todo: if you want to do something io/reg/hw setting before join_bss, please add code here */
+	/* todo: if you want to do something io/reg/hw setting before
+	 * join_bss, please add code here
+	 */
 
 	pmlmepriv->num_FortyMHzIntolerant = 0;
 
@@ -2165,7 +2248,8 @@ void rtw_build_wmm_ie_ht(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 }
 
 /* the function is >= passive_level */
-unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_ie, uint in_len, uint *pout_len, u8 channel)
+unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie,
+				   u8 *out_ie, uint in_len, uint *pout_len, u8 channel)
 {
 	u32 ielen, out_len;
 	enum ieee80211_max_ampdu_length_exp max_rx_ampdu_factor;
@@ -2246,7 +2330,8 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 
 	/* update default supported_mcs_set */
 	if (stbc_rx_enable)
-		ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_RX_STBC_1R);/* RX STBC One spatial stream */
+		/* RX STBC One spatial stream */
+		ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_RX_STBC_1R);
 
 	set_mcs_rate_by_mask(ht_capie.mcs.rx_mask, MCS_RATE_1R);
 
@@ -2312,7 +2397,8 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 
 	/* check Max Rx A-MPDU Size */
 	len = 0;
-	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_CAPABILITY, &len, ie_len - sizeof(struct ndis_802_11_fix_ie));
+	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_CAPABILITY, &len,
+		       ie_len - sizeof(struct ndis_802_11_fix_ie));
 	if (p && len > 0) {
 		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		max_ampdu_sz = (pht_capie->ampdu_params_info & IEEE80211_HT_CAP_AMPDU_FACTOR);
@@ -2322,7 +2408,8 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	}
 
 	len = 0;
-	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_OPERATION, &len, ie_len - sizeof(struct ndis_802_11_fix_ie));
+	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_OPERATION, &len,
+		       ie_len - sizeof(struct ndis_802_11_fix_ie));
 	if (p && len > 0) {
 		/* todo: */
 	}
@@ -2338,7 +2425,8 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 
 		/* update the MCS set */
 		for (i = 0; i < 16; i++)
-			pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= pmlmeext->default_supported_mcs_set[i];
+			pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &=
+							pmlmeext->default_supported_mcs_set[i];
 
 		/* update the MCS rates */
 		set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_1R);
@@ -2456,7 +2544,8 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 
 	if (rtw_to_roam(padapter) > 0) {
-		memcpy(&pmlmepriv->assoc_ssid, &cur_network->network.ssid, sizeof(struct ndis_802_11_ssid));
+		memcpy(&pmlmepriv->assoc_ssid, &cur_network->network.ssid,
+		       sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
 
@@ -2473,7 +2562,8 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 signed int rtw_linked_check(struct adapter *padapter)
 {
 	if ((check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true) ||
-			(check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE) == true)) {
+	    (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE |
+			   WIFI_ADHOC_MASTER_STATE) == true)) {
 		if (padapter->stapriv.asoc_sta_count > 2)
 			return true;
 	} else {	/* Station mode */
-- 
2.39.5


