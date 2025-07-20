Return-Path: <linux-kernel+bounces-738116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E280FB0B48F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232223A4FD4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE41DF75A;
	Sun, 20 Jul 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWM4R+JR"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC31C7013
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753003301; cv=none; b=gH2Z1MDlnlRvMuGhpVAXzopJudcoj9Ygn7GfY4WNlc7WlHEX0UKs/fmpEwGdw6XvYxXpiNeHPigulYGqL/tYlHRGxtYZzHTbMeekasVW5OkroyOWkpllnhUQpNLHMmaacZwHq+Q8029TwEh3PItG58u5gzvm7SHwmJS6gLNpNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753003301; c=relaxed/simple;
	bh=Dg6YvpZOBmX+gAuO97pzxwjEVkky8LMOxzQvl7Q2nYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmQYZbyJAii0ZuXJ69ExNW8s/BHjJz0faGa/cUrlW+W1VL2VbsPElQyJfSvgTf8z8LJVTCMy9O8SQrzL4iDbSn8RtoXjZMMrprqVLWnopuib1fm9On/7GYNcQPkYxqn4W+IXbpx2qo02xk65hMh1mhwDe/5i9CgazMM72d/byHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWM4R+JR; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4abd3627e7eso3833601cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753003298; x=1753608098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87nxXvys/RrNyU56e5lSusNevycvMdTPE63phLoHvtY=;
        b=iWM4R+JRsdYTlpfyiS4bl8cNgvvIzaQ3hWz961AI5APh12Y7Zqeg2hBuGtrseFsGtL
         W6tQiDPPPnTco/nMBmtnbOtfsZ/FnjA6s40xr/OyHZYdYuWmJWm323S7Oit3xDx6KjPs
         5eLze2Mg4aoYYG9F+qpy3ZvcTgOTnkHJ+8B2KkCIlYTh9r0VPo7wtmQchvceMy/xJNUI
         KLUDH0GfLqnsWXX421rjI0Fr9NvRG6utx8+NvsjQJHRNLTSCUbLjspVG/lLLKlGI1WPC
         mJwKMRoVslJ8onJsgRktZDuGBEhmXRPXJfsC51bs3VzCL343CxBRzDrMcWtyL53MtVtk
         S70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753003298; x=1753608098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87nxXvys/RrNyU56e5lSusNevycvMdTPE63phLoHvtY=;
        b=loyaAGJA1xCEZqRa3KG9C8mgRZ8rLn2PpQXYTisPfrIqNSGVMsEKehpH6nL4zNIavs
         dXORiVYANxVId/OIhneTOe03GtWYkfz1EqB0ijUu7vggQWxddTtdiQL5fzyYu8UycmWd
         TZUJjIVT96+kQ0VaBsmnl2nMp0bc/PbOnRgWFJdAA/kV2iGsftz2eDNnLrtZ+8GUK3b6
         25qBgd27AJiZS2tNjYBF0iRXW4slzkX2mXIJwAqwaVDAbcl2mIQBoa5sxIg4HArxKTtL
         qA1f/SiV5etHuELy1y0Tq0IjEYIF0woV1iy+/taz6DqTfZrsjI2vKsMdqzBgtmZhRjqP
         ISlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvTVxkqctFixJacziC6MtDQV/gZfXN25FFFM1xRZGPMt4PqOQqKNo/a/cQah24IK56GrX+GADyOlOGdpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1F94sasK2DWmUXL0LQHorTU5XKyXfS2q52VMMQ0ZT9hKKzGQ
	5dvnQ/W+wq6bpJqce94ozLC4Zx8837tEN8A/uEtWOiUcGcDGQvDXeNo2tHZyoOLT
X-Gm-Gg: ASbGncvFu4+cWAJhn5KL8LDQ79PBWQrFMxurOveui7SvWGcDCUOEv0ojeshwBAl3ekH
	mgQ/w8g96jbQdwsomfGpopRi4SXUVpPn+9NpgSyVlFNkRM//XXyNNnuw+TuKPdr9ZFb3/pO8Qht
	FxUxUHfRAHo3Hk0yRdV3hvRO1bG+wOKg90/A5kuL2doTn1OOvutmWvqkiVeZjvvxPfIaWaE2tfd
	4W2e75b3BG7Nkcg7C83rJtvOEKEUi2Y45kW1IV0fJ4jwnkRs8mTP2fQErdEVbp1XBagD26LdF2G
	E3R1abAC8p8dNn2DRw2yF2xjZ8USASvek7cJsHk/YZjoN7mZaMFG8Xdgx0GAWzKXHsMFdumZ+wh
	IBuRdzLpwFd1meYqBrfcmIflcsRov6CAtqGgOvV5JV+jxYWeCj54=
X-Google-Smtp-Source: AGHT+IEmVvqTrdgZyRMdMjEIq+2gdKXzmpgAg+AMSNdNMM5frpC/lbXkJjM8m4Nn0lwf+pn+pzofYA==
X-Received: by 2002:a05:622a:4cb:b0:4ab:6ef8:876 with SMTP id d75a77b69052e-4ab93c7f74dmr244212501cf.15.1753003297668;
        Sun, 20 Jul 2025 02:21:37 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4980305sm28445591cf.6.2025.07.20.02.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 02:21:37 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v2] staging: rtl8723bs: clean up redundant & parentheses
Date: Sun, 20 Jul 2025 09:21:25 +0000
Message-Id: <20250720092125.246844-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720083332.246512-1-vivek.balachandhar@gmail.com>
References: <20250720083332.246512-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleaned up redundant parentheses around the '&' (address-of)
operator in various expressions to improve code readability
and comply with kernel coding style guidelines.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
Changes in v2:
- Wrapped changelog text at 72 columns per review feedback.
- No code changes.
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 128 +++++++++++-----------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 6301dbbcc472..bb5ade8e306a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -119,7 +119,7 @@ struct	wlan_network *rtw_alloc_network(struct	mlme_priv *pmlmepriv)
 		pnetwork = NULL;
 		goto exit;
 	}
-	plist = get_next(&(free_queue->queue));
+	plist = get_next(&free_queue->queue);
 
 	pnetwork = container_of(plist, struct wlan_network, list);
 
@@ -141,7 +141,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 {
 	unsigned int delta_time;
 	u32 lifetime = SCANQUEUE_LIFETIME;
-	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
@@ -161,9 +161,9 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 
 	spin_lock_bh(&free_queue->lock);
 
-	list_del_init(&(pnetwork->list));
+	list_del_init(&pnetwork->list);
 
-	list_add_tail(&(pnetwork->list), &(free_queue->queue));
+	list_add_tail(&pnetwork->list, &free_queue->queue);
 
 	spin_unlock_bh(&free_queue->lock);
 }
@@ -171,7 +171,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
 {
 
-	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
@@ -179,9 +179,9 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 	if (pnetwork->fixed)
 		return;
 
-	list_del_init(&(pnetwork->list));
+	list_del_init(&pnetwork->list);
 
-	list_add_tail(&(pnetwork->list), get_list_head(free_queue));
+	list_add_tail(&pnetwork->list, get_list_head(free_queue));
 }
 
 /*
@@ -287,7 +287,7 @@ void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork);
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork)
 {
-	_rtw_free_network_nolock(&(padapter->mlmepriv), pnetwork);
+	_rtw_free_network_nolock(&padapter->mlmepriv, pnetwork);
 	rtw_cfg80211_unlink_bss(padapter, pnetwork);
 }
 
@@ -404,7 +404,7 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	long rssi_final;
 
 	/* The rule below is 1/5 for sample value, 4/5 for history value */
-	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) && is_same_network(&(padapter->mlmepriv.cur_network.network), src, 0)) {
+	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) && is_same_network(&padapter->mlmepriv.cur_network.network, src, 0)) {
 		/* Take the recvpriv's value for the connected AP*/
 		ss_final = padapter->recvpriv.signal_strength;
 		sq_final = padapter->recvpriv.signal_qual;
@@ -440,15 +440,15 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 
 static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 {
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	rtw_bug_check(&(pmlmepriv->cur_network.network),
-		&(pmlmepriv->cur_network.network),
-		&(pmlmepriv->cur_network.network),
-		&(pmlmepriv->cur_network.network));
+	rtw_bug_check(&pmlmepriv->cur_network.network,
+		&pmlmepriv->cur_network.network,
+		&pmlmepriv->cur_network.network,
+		&pmlmepriv->cur_network.network);
 
-	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) && (is_same_network(&(pmlmepriv->cur_network.network), pnetwork, 0))) {
-		update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
+	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) && (is_same_network(&pmlmepriv->cur_network.network, pnetwork, 0))) {
+		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
 		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
 								pmlmepriv->cur_network.network.ie_length);
 	}
@@ -461,8 +461,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 {
 	struct list_head	*plist, *phead;
 	u32 bssid_ex_sz;
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
-	struct __queue	*queue	= &(pmlmepriv->scanned_queue);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct __queue	*queue	= &pmlmepriv->scanned_queue;
 	struct wlan_network	*pnetwork = NULL;
 	struct wlan_network	*oldest = NULL;
 	int target_find = 0;
@@ -475,7 +475,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 		rtw_bug_check(pnetwork, pnetwork, pnetwork, pnetwork);
 
-		if (is_same_network(&(pnetwork->network), target, feature)) {
+		if (is_same_network(&pnetwork->network, target, feature)) {
 			target_find = 1;
 			break;
 		}
@@ -499,7 +499,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			if (!pnetwork)
 				goto exit;
 
-			memcpy(&(pnetwork->network), target,  get_wlan_bssid_ex_sz(target));
+			memcpy(&pnetwork->network, target,  get_wlan_bssid_ex_sz(target));
 			/*  variable initialize */
 			pnetwork->fixed = false;
 			pnetwork->last_scanned = jiffies;
@@ -521,7 +521,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
 			target->length = bssid_ex_sz;
-			memcpy(&(pnetwork->network), target, bssid_ex_sz);
+			memcpy(&pnetwork->network, target, bssid_ex_sz);
 
 			pnetwork->last_scanned = jiffies;
 
@@ -529,7 +529,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			if (pnetwork->network.phy_info.signal_quality == 101)
 				pnetwork->network.phy_info.signal_quality = 0;
 
-			list_add_tail(&(pnetwork->list), &(queue->queue));
+			list_add_tail(&pnetwork->list, &queue->queue);
 
 		}
 	} else {
@@ -553,7 +553,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			update_ie = false;
 		}
 
-		update_network(&(pnetwork->network), target, adapter, update_ie);
+		update_network(&pnetwork->network, target, adapter, update_ie);
 	}
 
 exit:
@@ -629,7 +629,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
 	u32 len;
 	struct wlan_bssid_ex *pnetwork;
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
@@ -641,18 +641,18 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  update IBSS_network 's timestamp */
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) {
-		if (!memcmp(&(pmlmepriv->cur_network.network.mac_address), pnetwork->mac_address, ETH_ALEN)) {
+		if (!memcmp(&pmlmepriv->cur_network.network.mac_address, pnetwork->mac_address, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
 			memcpy(pmlmepriv->cur_network.network.ies, pnetwork->ies, 8);
-			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,  pnetwork->mac_address);
 			if (ibss_wlan) {
 				memcpy(ibss_wlan->network.ies, pnetwork->ies, 8);
-				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 				goto exit;
 			}
-			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 		}
 	}
 
@@ -670,7 +670,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	spin_lock_bh(&pmlmepriv->lock);
 	if (pmlmepriv->wps_probe_req_ie) {
@@ -697,7 +697,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 				} else {
 					u8 ret = _SUCCESS;
-					struct wlan_bssid_ex    *pdev_network = &(adapter->registrypriv.dev_network);
+					struct wlan_bssid_ex    *pdev_network = &adapter->registrypriv.dev_network;
 					u8 *pibss = adapter->registrypriv.dev_network.mac_address;
 
 					/* pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;because don't set assoc_timer */
@@ -922,8 +922,8 @@ inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 void rtw_scan_abort(struct adapter *adapter)
 {
 	unsigned long start;
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(adapter->mlmeextpriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 
 	start = jiffies;
 	pmlmeext->scan_abort = true;
@@ -1029,8 +1029,8 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 /* ptarget_wlan: found from scanned_queue */
 static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_network *ptarget_wlan, struct wlan_network  *pnetwork)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct wlan_network  *cur_network = &pmlmepriv->cur_network;
 
 	/*  why not use ptarget_wlan?? */
 	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.length);
@@ -1086,9 +1086,9 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	static u8 __maybe_unused retry;
 	struct sta_info *ptarget_sta = NULL, *pcur_sta = NULL;
 	struct	sta_priv *pstapriv = &adapter->stapriv;
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct wlan_network	*pnetwork	= (struct wlan_network *)pbuf;
-	struct wlan_network	*cur_network = &(pmlmepriv->cur_network);
+	struct wlan_network	*cur_network = &pmlmepriv->cur_network;
 	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
 	unsigned int		the_same_macaddr = false;
 
@@ -1106,7 +1106,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	pmlmepriv->LinkDetectInfo.LowPowerTransitionCount = 0;
 
 	if (pnetwork->join_res > 0) {
-		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		retry = 0;
 		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
 			/* s1. find ptarget_wlan */
@@ -1143,7 +1143,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			} else {
 				netdev_dbg(adapter->pnetdev,
 					   "Can't find ptarget_wlan when joinbss_event callback\n");
-				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 				goto ignore_joinbss_callback;
 			}
 
@@ -1151,7 +1151,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
 				if (!ptarget_sta) {
-					spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+					spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 					goto ignore_joinbss_callback;
 				}
 			}
@@ -1169,7 +1169,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			timer_delete_sync(&pmlmepriv->assoc_timer);
 			spin_lock_bh(&pmlmepriv->lock);
 		} else {
-			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 		}
 	} else if (pnetwork->join_res == -4) {
 		rtw_reset_securitypriv(adapter);
@@ -1233,9 +1233,9 @@ void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta, u3
 void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 {
 	struct sta_info *psta;
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct stassoc_event	*pstassoc	= (struct stassoc_event *)pbuf;
-	struct wlan_network	*cur_network = &(pmlmepriv->cur_network);
+	struct wlan_network	*cur_network = &pmlmepriv->cur_network;
 	struct wlan_network	*ptarget_wlan = NULL;
 
 	if (rtw_access_ctrl(adapter, pstassoc->macaddr) == false)
@@ -1306,12 +1306,12 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
 		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
 		if (adapter->stapriv.asoc_sta_count == 2) {
-			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.mac_address);
 			pmlmepriv->cur_network_scanned = ptarget_wlan;
 			if (ptarget_wlan)
 				ptarget_wlan->fixed = true;
-			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			/*  a sta + bc/mc_stainfo (not Ibss_stainfo) */
 			rtw_indicate_connect(adapter);
 		}
@@ -1329,11 +1329,11 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network *pwlan = NULL;
 	struct wlan_bssid_ex    *pdev_network = NULL;
 	u8 *pibss = NULL;
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct	stadel_event *pstadel	= (struct stadel_event *)pbuf;
-	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
+	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	psta = rtw_get_stainfo(&adapter->stapriv, pstadel->macaddr);
 	if (psta)
@@ -1385,14 +1385,14 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 		rtw_free_assoc_resources(adapter, 1);
 		rtw_indicate_disconnect(adapter);
 
-		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		/*  remove the network entry in scanned_queue */
 		pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
 		if (pwlan) {
 			pwlan->fixed = false;
 			rtw_free_network_nolock(adapter, pwlan);
 		}
-		spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 
 		_rtw_roaming(adapter, roam_target);
 	}
@@ -1404,16 +1404,16 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 		if (adapter->stapriv.asoc_sta_count == 1) {/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
 			u8 ret = _SUCCESS;
-			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			/* free old ibss network */
 			pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
 			if (pwlan) {
 				pwlan->fixed = false;
 				rtw_free_network_nolock(adapter, pwlan);
 			}
-			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			/* re-create ibss */
-			pdev_network = &(adapter->registrypriv.dev_network);
+			pdev_network = &adapter->registrypriv.dev_network;
 			pibss = adapter->registrypriv.dev_network.mac_address;
 
 			memcpy(pdev_network, &tgt_network->network, get_wlan_bssid_ex_sz(&tgt_network->network));
@@ -1521,7 +1521,7 @@ void rtw_mlme_reset_auto_scan_int(struct adapter *adapter)
 {
 	struct mlme_priv *mlme = &adapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeinfo->VHT_enable) /* disable auto scan when connect to 11AC AP */
 		mlme->auto_scan_int_ms = 0;
@@ -1662,7 +1662,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 {
 	int ret = _FAIL;
 	struct list_head	*phead;
-	struct __queue	*queue	= &(mlme->scanned_queue);
+	struct __queue	*queue	= &mlme->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	struct	wlan_network	*candidate = NULL;
 
@@ -1671,7 +1671,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 		return ret;
 	}
 
-	spin_lock_bh(&(mlme->scanned_queue.lock));
+	spin_lock_bh(&mlme->scanned_queue.lock);
 	phead = get_list_head(queue);
 
 	list_for_each(mlme->pscanned, phead) {
@@ -1695,7 +1695,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 
 	ret = _SUCCESS;
 exit:
-	spin_unlock_bh(&(mlme->scanned_queue.lock));
+	spin_unlock_bh(&mlme->scanned_queue.lock);
 
 	return ret;
 }
@@ -1756,13 +1756,13 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	int ret;
 	struct list_head	*phead;
 	struct adapter *adapter;
-	struct __queue	*queue	= &(pmlmepriv->scanned_queue);
+	struct __queue	*queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	struct	wlan_network	*candidate = NULL;
 
 	adapter = (struct adapter *)pmlmepriv->nic_hdl;
 
-	spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 
 	if (pmlmepriv->roam_network) {
 		candidate = pmlmepriv->roam_network;
@@ -1800,7 +1800,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	ret = rtw_joinbss_cmd(adapter, candidate);
 
 exit:
-	spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+	spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 	return ret;
 }
 
@@ -1808,7 +1808,7 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
 {
 	struct	cmd_obj *pcmd;
 	struct	setauth_parm *psetauthparm;
-	struct	cmd_priv *pcmdpriv = &(adapter->cmdpriv);
+	struct	cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	signed int		res = _SUCCESS;
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
@@ -1845,7 +1845,7 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 	u8 keylen;
 	struct cmd_obj		*pcmd;
 	struct setkey_parm	*psetkeyparm;
-	struct cmd_priv 	*pcmdpriv = &(adapter->cmdpriv);
+	struct cmd_priv 	*pcmdpriv = &adapter->cmdpriv;
 	signed int	res = _SUCCESS;
 
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
@@ -1868,11 +1868,11 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 
 	case _WEP40_:
 		keylen = 5;
-		memcpy(&(psetkeyparm->key[0]), &(psecuritypriv->dot11DefKey[keyid].skey[0]), keylen);
+		memcpy(&psetkeyparm->key[0], &psecuritypriv->dot11DefKey[keyid].skey[0], keylen);
 		break;
 	case _WEP104_:
 		keylen = 13;
-		memcpy(&(psetkeyparm->key[0]), &(psecuritypriv->dot11DefKey[keyid].skey[0]), keylen);
+		memcpy(&psetkeyparm->key[0], &psecuritypriv->dot11DefKey[keyid].skey[0], keylen);
 		break;
 	case _TKIP_:
 		keylen = 16;
@@ -2335,7 +2335,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 cbw40_enable = 0;
 
 	if (!phtpriv->ht_option)
-- 
2.39.5


