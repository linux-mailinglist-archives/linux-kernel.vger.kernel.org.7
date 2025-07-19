Return-Path: <linux-kernel+bounces-737970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D4BB0B2B7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC04117F777
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB49D289371;
	Sat, 19 Jul 2025 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfCCF+o5"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C233FE4
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752966451; cv=none; b=oYLubv9xcCVN6Wfz2/JVanygyOClSHCXLPlDOAEgW2346YUFeQaFBKkZYxmFfVMogQMqN47bGxbBDou7MwUsbmTNz8riz6xghlk+3uP/STTcoFmlyoju+vrtzy/ANMFjUKzqc8pFDaDAJfk3m/2xnfwUyT485slJuwaIuXNE+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752966451; c=relaxed/simple;
	bh=IZl6VohGFdiqH87kzqBkbtjuI7Bb4PfO+xB+t7+2VNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m1KfYrsIX9UBHP4MrDQGqh76QHzNJcJBKA6/syQNyiOTl6kxgWsKMdXp+vANdMXNpt+nke/w/P3tGm+3x4TVp/tM2JhBpfaTMD7xNY+Fw6ycy1mplpogYaztotlZ6zv1JG6NPuxEyBaAbC3WMTncdWjH5bEmcU+2oqv46l+S6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfCCF+o5; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7050bc6bea9so24480696d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 16:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752966446; x=1753571246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSlPFFReNBhad2IsuuJVG/iNzQxl5C6fS+x3+oQo7l4=;
        b=mfCCF+o5y+0BFXS7ke0gF46X2dX64xUrhq5D1HFhrA1HtqsQrgQ/UDpJTMPcIVF2jd
         NOdykvDbUs4FAhMKV6wTl6Mvbnwe1ZQf/rj7EpG4kPlwyBQb1v2SrCuUB/KWYBrsxsLH
         /KqSkgziuGOXQe60+mWKr7K23MWdOS9Bi9Z6O9A0e9jgK5NitKEhLzZdWhoeZkBtOiey
         yoKq5vJV2Unf41aH09Vcck/eETeBfsyP6ZCo4omeACb1WPyt6owYDNW6MqLOpSK4WBQ7
         EU/1VNFnjGnstJCgIk4kEldkd5baAYxaPjpRFEu7WsDl8QGtgyNE2vojVuIo/GS6F/BQ
         946Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752966446; x=1753571246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSlPFFReNBhad2IsuuJVG/iNzQxl5C6fS+x3+oQo7l4=;
        b=KY/ZqN91cX0iVL+aOyVvYoyfBDoLhUJmgGlOTueX9mm6dwb0ayutMSNwMqrp0MQzU/
         AqADgaFV8dGBwOd8kSyLQLPu2TafT+8eNOVSYroAT4386iPRlx96LNjEmJGZgZy1Cp02
         jM77qLq7TFSIerRnvcliLuOgVteZ9x3bhF46qhgb1i0J6HMf2B0Ribv8iieSoYZOSV14
         vK0x013IOoa5imI1xTKI5PnCsswZLQ75xH/3GwyZd1cqTy6ZcUjAPZBswSoETCjH/hKN
         C3TW212ygMTYYG8OolzfOSpxyQo/HEcYTbKbGhZ4nYNIidRdBqogHSW7cmyl2lwB9QYC
         xF3A==
X-Forwarded-Encrypted: i=1; AJvYcCUguRlr/lEIezuk5Pmp9+WQtXMl0uhvuoMelnkFOSDcta+RxoIzr8WV7MkgA0/o/mCMiFFPsHrmgaedVYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNVCnTVTxI9bqylKF6VRc5i+unn9dUuqhkymhOasBpJ6GFUTkv
	aF122zIY8aL85G44rpm5x9FB4HjCZAJWnOUkaz7Dq9NBiO/42SV8JHOEH8/rYD8D
X-Gm-Gg: ASbGncv7D5trm0PouvhuIpnORL0vIENJFNpRafTi4PQIcomrKSr+to3PfiRnA2zRZX7
	0CdnF5emz+pXMTJWfaXfL8tDSJY54RbCefiSDt9Dh0bU/ZHknXLOUrduaRICKJFAvaY62Kujrmm
	T6rPYovBE6dzkboG1HsOOpIrdJ0vsmz4aosDq0juM2sBlGEhlAPFtuQJlJ37y/Jh/pW+lUYejfu
	becG3i/SztBg5vXiEd/iX2fjYM0lWBll3R/xB9vRUwDbejo5PdKa8JYU/Y0aouWZ47jrTyTKQGq
	F147KEVzl/3Cp1hQCbeWe7Kf7uVUJVy/UF64fDSU7CtJwrj3R8FJ2MkhoH4aKjUqyjwTJkOef/0
	Pmu7LFvTPASz8cvDAJK0YA31Wdcz0agU/cKmF22fFLgyzjPMlhxo=
X-Google-Smtp-Source: AGHT+IE+LWzXLJug5gFlDMPKzjDwhXTAg0zABDnIE1+SWiziege8Fxi1ar8baaAlCTWExMHFBF0fgQ==
X-Received: by 2002:ad4:5c4c:0:b0:6fd:a382:f86f with SMTP id 6a1803df08f44-704f6b2640amr269874946d6.34.1752966445021;
        Sat, 19 Jul 2025 16:07:25 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b90616asm23075736d6.35.2025.07.19.16.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 16:07:24 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH] staging: rtl8723bs: Improve indentation consistency in rtw_mlme.c
Date: Sat, 19 Jul 2025 23:07:07 +0000
Message-Id: <20250719230707.238377-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch cleans up inconsistent indentation in rtw_mlme.c to improve code
readability and align with kernel coding style.

This is a partial cleanup — other style issues like camelCase variables and
line wrapping in few nested loops will be addressed in future patches.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 595 ++++++++++++----------
 1 file changed, 329 insertions(+), 266 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 6301dbbcc472..3fbc1e22c10f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -22,7 +22,10 @@ int	rtw_init_mlme_priv(struct adapter *padapter)
 	pmlmepriv->pscanned = NULL;
 	pmlmepriv->fw_state = WIFI_STATION_STATE; /*  Must sync with rtw_wdev_alloc() */
 	pmlmepriv->cur_network.network.infrastructure_mode = Ndis802_11AutoUnknown;
-	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: passive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
+	/* 1: active, 0: passive. Maybe someday we should
+	 * rename this varable to "active_mode" (Jeff)
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
 
@@ -119,7 +123,7 @@ struct	wlan_network *rtw_alloc_network(struct	mlme_priv *pmlmepriv)
 		pnetwork = NULL;
 		goto exit;
 	}
-	plist = get_next(&(free_queue->queue));
+	plist = get_next(&free_queue->queue);
 
 	pnetwork = container_of(plist, struct wlan_network, list);
 
@@ -141,7 +145,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 {
 	unsigned int delta_time;
 	u32 lifetime = SCANQUEUE_LIFETIME;
-	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
@@ -150,7 +154,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 		return;
 
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
-		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true))
+	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true))
 		lifetime = 1;
 
 	if (!isfreeall) {
@@ -161,17 +165,16 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 
 	spin_lock_bh(&free_queue->lock);
 
-	list_del_init(&(pnetwork->list));
+	list_del_init(&pnetwork->list);
 
-	list_add_tail(&(pnetwork->list), &(free_queue->queue));
+	list_add_tail(&pnetwork->list, &free_queue->queue);
 
 	spin_unlock_bh(&free_queue->lock);
 }
 
 void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
 {
-
-	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
@@ -179,16 +182,15 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 	if (pnetwork->fixed)
 		return;
 
-	list_del_init(&(pnetwork->list));
+	list_del_init(&pnetwork->list);
 
-	list_add_tail(&(pnetwork->list), get_list_head(free_queue));
+	list_add_tail(&pnetwork->list, get_list_head(free_queue));
 }
 
 /*
-	return the wlan_network with the matching addr
-
-	Shall be called under atomic context... to avoid possible racing condition...
-*/
+ * return the wlan_network with the matching addr
+ * Shall be called under atomic context... to avoid possible racing condition...
+ */
 struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct list_head	*phead, *plist;
@@ -225,11 +227,9 @@ void rtw_free_network_queue(struct adapter *padapter, u8 isfreeall)
 
 	phead = get_list_head(scanned_queue);
 	list_for_each_safe(plist, tmp, phead) {
-
 		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		_rtw_free_network(pmlmepriv, pnetwork, isfreeall);
-
 	}
 
 	spin_unlock_bh(&scanned_queue->lock);
@@ -240,7 +240,7 @@ signed int rtw_if_up(struct adapter *padapter)
 	signed int res;
 
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
-		(check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false))
+	    (check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false))
 		res = false;
 	else
 		res =  true;
@@ -256,8 +256,8 @@ void rtw_generate_random_ibss(u8 *pibss)
 	pibss[1] = 0x11;
 	pibss[2] = 0x87;
 	pibss[3] = (u8)(curtime & 0xff) ;/* p[0]; */
-	pibss[4] = (u8)((curtime>>8) & 0xff) ;/* p[1]; */
-	pibss[5] = (u8)((curtime>>16) & 0xff) ;/* p[2]; */
+	pibss[4] = (u8)((curtime >> 8) & 0xff) ;/* p[1]; */
+	pibss[5] = (u8)((curtime >> 16) & 0xff) ;/* p[2]; */
 }
 
 u8 *rtw_get_capability_from_ie(u8 *ie)
@@ -287,15 +287,14 @@ void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork);
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork)
 {
-	_rtw_free_network_nolock(&(padapter->mlmepriv), pnetwork);
+	_rtw_free_network_nolock(&padapter->mlmepriv, pnetwork);
 	rtw_cfg80211_unlink_bss(padapter, pnetwork);
 }
 
 /*
-	return the wlan_network with the matching addr
-
-	Shall be called under atomic context... to avoid possible racing condition...
-*/
+ *	return the wlan_network with the matching addr
+ *	Shall be called under atomic context... to avoid possible racing condition...
+ */
 struct	wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct	wlan_network *pnetwork = _rtw_find_network(scanned_queue, addr);
@@ -309,7 +308,7 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
 	if ((psecuritypriv->dot11PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.privacy == 0))
+	    (pnetwork->network.privacy == 0))
 		ret = false;
 	else if ((psecuritypriv->dot11PrivacyAlgrthm == _NO_PRIVACY_) &&
 		 (pnetwork->network.privacy == 1))
@@ -318,13 +317,12 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 		ret = true;
 
 	return ret;
-
 }
 
 inline int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
 {
-	return (a->ssid.ssid_length == b->ssid.ssid_length)
-		&&  !memcmp(a->ssid.ssid, b->ssid.ssid, a->ssid.ssid_length);
+	return (a->ssid.ssid_length == b->ssid.ssid_length) &&
+		!memcmp(a->ssid.ssid, b->ssid.ssid, a->ssid.ssid_length);
 }
 
 int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 feature)
@@ -348,10 +346,10 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 			(d_cap & WLAN_CAPABILITY_IBSS)) &&
 			((s_cap & WLAN_CAPABILITY_ESS) ==
 			(d_cap & WLAN_CAPABILITY_ESS));
-
 }
 
-struct wlan_network *_rtw_find_same_network(struct __queue *scanned_queue, struct wlan_network *network)
+struct wlan_network *_rtw_find_same_network(struct __queue *scanned_queue,
+					    struct wlan_network *network)
 {
 	struct list_head *phead, *plist;
 	struct wlan_network *found = NULL;
@@ -380,7 +378,6 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 	phead = get_list_head(scanned_queue);
 
 	list_for_each(plist, phead) {
-
 		pwlan = list_entry(plist, struct wlan_network, list);
 
 		if (!pwlan->fixed) {
@@ -389,11 +386,10 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 		}
 	}
 	return oldest;
-
 }
 
 void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
-	struct adapter *padapter, bool update_ie)
+		    struct adapter *padapter, bool update_ie)
 {
 	long rssi_ori = dst->rssi;
 
@@ -404,27 +400,31 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	long rssi_final;
 
 	/* The rule below is 1/5 for sample value, 4/5 for history value */
-	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) && is_same_network(&(padapter->mlmepriv.cur_network.network), src, 0)) {
+	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) &&
+	    is_same_network(&padapter->mlmepriv.cur_network.network, src, 0)) {
 		/* Take the recvpriv's value for the connected AP*/
 		ss_final = padapter->recvpriv.signal_strength;
 		sq_final = padapter->recvpriv.signal_qual;
 		/* the rssi value here is undecorated, and will be used for antenna diversity */
 		if (sq_smp != 101) /* from the right channel */
-			rssi_final = (src->rssi+dst->rssi*4)/5;
+			rssi_final = (src->rssi + dst->rssi * 4) / 5;
 		else
 			rssi_final = rssi_ori;
 	} else {
 		if (sq_smp != 101) { /* from the right channel */
-			ss_final = ((u32)(src->phy_info.signal_strength)+(u32)(dst->phy_info.signal_strength)*4)/5;
-			sq_final = ((u32)(src->phy_info.signal_quality)+(u32)(dst->phy_info.signal_quality)*4)/5;
-			rssi_final = (src->rssi+dst->rssi*4)/5;
+			ss_final = ((u32)(src->phy_info.signal_strength) +
+				    (u32)(dst->phy_info.signal_strength) * 4) / 5;
+			sq_final = ((u32)(src->phy_info.signal_quality) +
+				    (u32)(dst->phy_info.signal_quality) * 4) / 5;
+			rssi_final = (src->rssi + dst->rssi * 4) / 5;
 		} else {
-			/* bss info not receiving from the right channel, use the original RX signal infos */
+			/* bss info not receiving from the right channel,
+			 * use the original RX signal infos
+			 */
 			ss_final = dst->phy_info.signal_strength;
 			sq_final = dst->phy_info.signal_quality;
 			rssi_final = dst->rssi;
 		}
-
 	}
 
 	if (update_ie) {
@@ -440,29 +440,31 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 
 static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 {
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	rtw_bug_check(&(pmlmepriv->cur_network.network),
-		&(pmlmepriv->cur_network.network),
-		&(pmlmepriv->cur_network.network),
-		&(pmlmepriv->cur_network.network));
+	rtw_bug_check(&pmlmepriv->cur_network.network,
+		      &pmlmepriv->cur_network.network,
+		      &pmlmepriv->cur_network.network,
+		      &pmlmepriv->cur_network.network);
 
-	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) && (is_same_network(&(pmlmepriv->cur_network.network), pnetwork, 0))) {
-		update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
-		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
-								pmlmepriv->cur_network.network.ie_length);
+	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) &&
+	    (is_same_network(&pmlmepriv->cur_network.network, pnetwork, 0))) {
+		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
+		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) +
+				      sizeof(struct ndis_802_11_fix_ie),
+				      pmlmepriv->cur_network.network.ie_length);
 	}
 }
 
 /*
-Caller must hold pmlmepriv->lock first.
-*/
+ * Caller must hold pmlmepriv->lock first.
+ */
 void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *target)
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
@@ -475,22 +477,24 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 		rtw_bug_check(pnetwork, pnetwork, pnetwork, pnetwork);
 
-		if (is_same_network(&(pnetwork->network), target, feature)) {
+		if (is_same_network(&pnetwork->network, target, feature)) {
 			target_find = 1;
 			break;
 		}
 
 		if (rtw_roam_flags(adapter)) {
-			/* TODO: don't select network in the same ess as oldest if it's new enough*/
+			/* TODO: don't select network in the
+			 * same ess as oldest if it's new enough
+			 */
 		}
 
 		if (!oldest || time_after(oldest->last_scanned, pnetwork->last_scanned))
 			oldest = pnetwork;
-
 	}
 
 	/* If we didn't find a match, then get a new network slot to initialize
-	 * with this beacon's information */
+	 * with this beacon's information
+	 */
 	if (!target_find) {
 		if (list_empty(&pmlmepriv->free_bss_pool.queue)) {
 			/* If there are no more slots, expire the oldest */
@@ -499,7 +503,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			if (!pnetwork)
 				goto exit;
 
-			memcpy(&(pnetwork->network), target,  get_wlan_bssid_ex_sz(target));
+			memcpy(&pnetwork->network, target,  get_wlan_bssid_ex_sz(target));
 			/*  variable initialize */
 			pnetwork->fixed = false;
 			pnetwork->last_scanned = jiffies;
@@ -521,7 +525,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
 			target->length = bssid_ex_sz;
-			memcpy(&(pnetwork->network), target, bssid_ex_sz);
+			memcpy(&pnetwork->network, target, bssid_ex_sz);
 
 			pnetwork->last_scanned = jiffies;
 
@@ -529,8 +533,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			if (pnetwork->network.phy_info.signal_quality == 101)
 				pnetwork->network.phy_info.signal_quality = 0;
 
-			list_add_tail(&(pnetwork->list), &(queue->queue));
-
+			list_add_tail(&pnetwork->list, &queue->queue);
 		}
 	} else {
 		/* we have an entry and we are going to update it. But this entry may
@@ -553,7 +556,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			update_ie = false;
 		}
 
-		update_network(&(pnetwork->network), target, adapter, update_ie);
+		update_network(&pnetwork->network, target, adapter, update_ie);
 	}
 
 exit:
@@ -569,10 +572,10 @@ void rtw_add_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 
 /* select the desired network based on the capability of the (i)bss. */
 /*  check items: (1) security */
-/* 			   (2) network_type */
-/* 			   (3) WMM */
-/* 			   (4) HT */
-/*                      (5) others */
+/*		 (2) network_type */
+/*		 (3) WMM */
+/*		 (4) HT */
+/*               (5) others */
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork);
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
 {
@@ -587,11 +590,12 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	privacy = pnetwork->network.privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		if (rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
+		if (rtw_get_wps_ie(pnetwork->network.ies +
+		    _FIXED_IE_LENGTH_, pnetwork->network.ie_length - _FIXED_IE_LENGTH_,
+		    NULL, &wps_ielen))
 			return true;
 		else
 			return false;
-
 	}
 	if (adapter->registrypriv.wifi_spec == 1) { /* for  correct flow of 8021X  to do.... */
 		u8 *p = NULL;
@@ -601,7 +605,9 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 			bselected = false;
 
 		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
-			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
+			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_,
+				       WLAN_EID_RSN, &ie_len,
+				       (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
 			if (p && ie_len > 0)
 				bselected = true;
 			else
@@ -613,7 +619,8 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 		bselected = false;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
-		if (pnetwork->network.infrastructure_mode != pmlmepriv->cur_network.network.infrastructure_mode)
+		if (pnetwork->network.infrastructure_mode !=
+		    pmlmepriv->cur_network.network.infrastructure_mode)
 			bselected = false;
 	}
 
@@ -629,7 +636,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
 	u32 len;
 	struct wlan_bssid_ex *pnetwork;
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
@@ -641,18 +648,20 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  update IBSS_network 's timestamp */
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) {
-		if (!memcmp(&(pmlmepriv->cur_network.network.mac_address), pnetwork->mac_address, ETH_ALEN)) {
+		if (!memcmp(&pmlmepriv->cur_network.network.mac_address,
+			    pnetwork->mac_address, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
 			memcpy(pmlmepriv->cur_network.network.ies, pnetwork->ies, 8);
-			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
-			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,  pnetwork->mac_address);
+			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
+			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,
+						     pnetwork->mac_address);
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
 
@@ -670,7 +679,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	spin_lock_bh(&pmlmepriv->lock);
 	if (pmlmepriv->wps_probe_req_ie) {
@@ -689,7 +698,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
@@ -697,13 +706,17 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 				} else {
 					u8 ret = _SUCCESS;
-					struct wlan_bssid_ex    *pdev_network = &(adapter->registrypriv.dev_network);
+					struct wlan_bssid_ex *pdev_network =
+							&adapter->registrypriv.dev_network;
 					u8 *pibss = adapter->registrypriv.dev_network.mac_address;
 
-					/* pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;because don't set assoc_timer */
+					/* pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
+					 * because don't set assoc_timer
+					 */
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-					memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+					memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid,
+					       sizeof(struct ndis_802_11_ssid));
 
 					rtw_update_registrypriv_dev_network(adapter);
 					rtw_generate_random_ibss(pibss);
@@ -730,29 +743,31 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 				rtw_indicate_connect(adapter);
 			} else {
 				if (rtw_to_roam(adapter) != 0) {
-					if (rtw_dec_to_roam(adapter) == 0
-						|| _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)
-					) {
+					if (rtw_dec_to_roam(adapter) == 0 ||
+					    rtw_sitesurvey_cmd(adapter,
+							       &pmlmepriv->assoc_ssid,
+							       1, NULL, 0) != _SUCCESS) {
 						rtw_set_to_roam(adapter, 0);
 						rtw_free_assoc_resources(adapter, 1);
 						rtw_indicate_disconnect(adapter);
 					} else {
 						pmlmepriv->to_join = true;
 					}
-				} else
+				} else {
 					rtw_indicate_disconnect(adapter);
+				}
 
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 			}
 		}
 	} else {
 		if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
-			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
-				&& check_fwstate(pmlmepriv, _FW_LINKED)) {
-				if (rtw_select_roaming_candidate(pmlmepriv) == _SUCCESS) {
-					receive_disconnect(adapter, pmlmepriv->cur_network.network.mac_address
-						, WLAN_REASON_ACTIVE_ROAM);
-				}
+			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) &&
+			    check_fwstate(pmlmepriv, _FW_LINKED) &&
+			    rtw_select_roaming_candidate(pmlmepriv) == _SUCCESS) {
+				receive_disconnect(adapter,
+						   pmlmepriv->cur_network.network.mac_address,
+						   WLAN_REASON_ACTIVE_ROAM);
 			}
 		}
 	}
@@ -823,8 +838,8 @@ static void find_network(struct adapter *adapter)
 }
 
 /*
-*rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
-*/
+ *rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
+ */
 void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
@@ -832,14 +847,14 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 	struct dvobj_priv *psdpriv = adapter->dvobj;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
-	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_AP_STATE)) {
+	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_AP_STATE)) {
 		struct sta_info *psta;
 
 		psta = rtw_get_stainfo(&adapter->stapriv, tgt_network->network.mac_address);
 		rtw_free_stainfo(adapter,  psta);
 	}
 
-	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE|WIFI_AP_STATE)) {
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE | WIFI_AP_STATE)) {
 		struct sta_info *psta;
 
 		rtw_free_all_stainfo(adapter);
@@ -859,8 +874,8 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 }
 
 /*
-*rtw_indicate_connect: the caller has to lock pmlmepriv->lock
-*/
+ *rtw_indicate_connect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -868,7 +883,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 	pmlmepriv->to_join = false;
 
 	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
-
 		set_fwstate(pmlmepriv, _FW_LINKED);
 
 		rtw_os_indicate_connect(padapter);
@@ -876,23 +890,22 @@ void rtw_indicate_connect(struct adapter *padapter)
 
 	rtw_set_to_roam(padapter, 0);
 	rtw_set_scan_deny(padapter, 3000);
-
 }
 
 /*
-*rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
-*/
+ *rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING|WIFI_UNDER_WPS);
+	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING | WIFI_UNDER_WPS);
 
 	if (rtw_to_roam(padapter) > 0)
 		_clr_fwstate_(pmlmepriv, _FW_LINKED);
 
-	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED)
-		|| (rtw_to_roam(padapter) <= 0)
+	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) ||
+	    (rtw_to_roam(padapter) <= 0)
 	) {
 		rtw_os_indicate_disconnect(padapter);
 
@@ -913,7 +926,7 @@ inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 
 	if ((!adapter_to_pwrctl(padapter)->bInSuspend) &&
 	    (!check_fwstate(&padapter->mlmepriv,
-			    WIFI_ASOC_STATE|WIFI_UNDER_LINKING))) {
+			    WIFI_ASOC_STATE | WIFI_UNDER_LINKING))) {
 		rtw_set_ips_deny(padapter, 0);
 		_set_timer(&padapter->mlmepriv.dynamic_chk_timer, 1);
 	}
@@ -922,14 +935,13 @@ inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 void rtw_scan_abort(struct adapter *adapter)
 {
 	unsigned long start;
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(adapter->mlmeextpriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 
 	start = jiffies;
 	pmlmeext->scan_abort = true;
-	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)
-		&& jiffies_to_msecs(start) <= 200) {
-
+	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) &&
+	       jiffies_to_msecs(start) <= 200) {
 		if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 			break;
 
@@ -942,7 +954,8 @@ void rtw_scan_abort(struct adapter *adapter)
 	pmlmeext->scan_abort = false;
 }
 
-static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, struct wlan_network *pnetwork)
+static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter,
+						   struct wlan_network *pnetwork)
 {
 	int i;
 	struct sta_info *bmc_sta, *psta = NULL;
@@ -999,7 +1012,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 		}
 
 		/* for A-MPDU Rx reordering buffer control for bmc_sta & sta_info */
-		/* if A-MPDU Rx is enabled, resetting  rx_ordering_ctrl wstart_b(indicate_seq) to default value = 0xffff */
+		/* if A-MPDU Rx is enabled, resetting rx_ordering_ctrl wstart_b(indicate_seq)
+		 * to default value = 0xffff
+		 */
 		/* todo: check if AP can send A-MPDU packets */
 		for (i = 0; i < 16 ; i++) {
 			preorder_ctrl = &psta->recvreorder_ctrl[i];
@@ -1016,21 +1031,23 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
 				preorder_ctrl->wend_b = 0xffff;
-				preorder_ctrl->wsize_b = 64;/* max_ampdu_sz;ex. 32(kbytes) -> wsize_b =32 */
+				/* max_ampdu_sz;ex. 32(kbytes) -> wsize_b =32 */
+				preorder_ctrl->wsize_b = 64;
 			}
 		}
 	}
 
 	return psta;
-
 }
 
 /* pnetwork : returns from rtw_joinbss_event_callback */
 /* ptarget_wlan: found from scanned_queue */
-static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_network *ptarget_wlan, struct wlan_network  *pnetwork)
+static void rtw_joinbss_update_network(struct adapter *padapter,
+				       struct wlan_network *ptarget_wlan,
+				       struct wlan_network  *pnetwork)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct wlan_network  *cur_network = &pmlmepriv->cur_network;
 
 	/*  why not use ptarget_wlan?? */
 	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.length);
@@ -1044,8 +1061,11 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 
 	padapter->recvpriv.signal_strength = ptarget_wlan->network.phy_info.signal_strength;
 	padapter->recvpriv.signal_qual = ptarget_wlan->network.phy_info.signal_quality;
-	/* the ptarget_wlan->network.rssi is raw data, we use ptarget_wlan->network.phy_info.signal_strength instead (has scaled) */
-	padapter->recvpriv.rssi = translate_percentage_to_dbm(ptarget_wlan->network.phy_info.signal_strength);
+	/* the ptarget_wlan->network.rssi is raw data,
+	 * we use ptarget_wlan->network.phy_info.signal_strength instead (has scaled)
+	 */
+	padapter->recvpriv.rssi =
+		translate_percentage_to_dbm(ptarget_wlan->network.phy_info.signal_strength);
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
@@ -1053,8 +1073,8 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	switch (pnetwork->network.infrastructure_mode) {
 	case Ndis802_11Infrastructure:
 
-			if (pmlmepriv->fw_state&WIFI_UNDER_WPS)
-				pmlmepriv->fw_state = WIFI_STATION_STATE|WIFI_UNDER_WPS;
+			if (pmlmepriv->fw_state & WIFI_UNDER_WPS)
+				pmlmepriv->fw_state = WIFI_STATION_STATE | WIFI_UNDER_WPS;
 			else
 				pmlmepriv->fw_state = WIFI_STATION_STATE;
 
@@ -1067,18 +1087,28 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 			break;
 	}
 
-	rtw_update_protection(padapter, (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
-									(cur_network->network.ie_length));
+	rtw_update_protection(padapter,
+			      (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
+			      (cur_network->network.ie_length));
 
-	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.ds_config);
+	rtw_update_ht_cap(padapter, cur_network->network.ies,
+			  cur_network->network.ie_length,
+			  (u8)cur_network->network.configuration.ds_config);
 }
 
 /* Notes: the function could be > passive_level (the same context as Rx tasklet) */
 /* pnetwork : returns from rtw_joinbss_event_callback */
 /* ptarget_wlan: found from scanned_queue */
-/* if join_res > 0, for (fw_state ==WIFI_STATION_STATE), we check if  "ptarget_sta" & "ptarget_wlan" exist. */
-/* if join_res > 0, for (fw_state ==WIFI_ADHOC_STATE), we only check if "ptarget_wlan" exist. */
-/* if join_res > 0, update "cur_network->network" from "pnetwork->network" if (ptarget_wlan != NULL). */
+/* if join_res > 0,
+ * for (fw_state == WIFI_STATION_STATE), we check if  "ptarget_sta" & "ptarget_wlan" exist.
+ */
+/* if join_res > 0,
+ * for (fw_state == WIFI_ADHOC_STATE), we only check if "ptarget_wlan" exist.
+ */
+/* if join_res > 0,
+ * update "cur_network->network" from "pnetwork->network"
+ * when ptarget_wlan is not NULL.
+ */
 /*  */
 /* define REJOIN */
 void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
@@ -1086,15 +1116,16 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
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
 
 	rtw_get_encrypt_decrypt_from_registrypriv(adapter);
 
-	the_same_macaddr = !memcmp(pnetwork->network.mac_address, cur_network->network.mac_address, ETH_ALEN);
+	the_same_macaddr = !memcmp(pnetwork->network.mac_address,
+				   cur_network->network.mac_address, ETH_ALEN);
 
 	pnetwork->network.length = get_wlan_bssid_ex_sz(&pnetwork->network);
 	if (pnetwork->network.length > sizeof(struct wlan_bssid_ex))
@@ -1106,7 +1137,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	pmlmepriv->LinkDetectInfo.LowPowerTransitionCount = 0;
 
 	if (pnetwork->join_res > 0) {
-		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		retry = 0;
 		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
 			/* s1. find ptarget_wlan */
@@ -1130,7 +1161,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 				}
 
 			} else {
-				ptarget_wlan = _rtw_find_same_network(&pmlmepriv->scanned_queue, pnetwork);
+				ptarget_wlan = _rtw_find_same_network(&pmlmepriv->scanned_queue,
+								      pnetwork);
 				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 					if (ptarget_wlan)
 						ptarget_wlan->fixed = true;
@@ -1143,15 +1175,17 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			} else {
 				netdev_dbg(adapter->pnetdev,
 					   "Can't find ptarget_wlan when joinbss_event callback\n");
-				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 				goto ignore_joinbss_callback;
 			}
 
-			/* s3. find ptarget_sta & update ptarget_sta after update cur_network only for station mode */
+			/* s3. find ptarget_sta & update ptarget_sta after update
+			 * cur_network only for station mode
+			 */
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
 				if (!ptarget_sta) {
-					spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+					spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 					goto ignore_joinbss_callback;
 				}
 			}
@@ -1169,7 +1203,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			timer_delete_sync(&pmlmepriv->assoc_timer);
 			spin_lock_bh(&pmlmepriv->lock);
 		} else {
-			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 		}
 	} else if (pnetwork->join_res == -4) {
 		rtw_reset_securitypriv(adapter);
@@ -1226,16 +1260,16 @@ void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta, u3
 	if (!psta)
 		return;
 
-	media_status_rpt = (u16)((psta->mac_id<<8)|mstatus); /*   MACID|OPMODE:1 connect */
+	media_status_rpt = (u16)((psta->mac_id << 8) | mstatus); /*   MACID|OPMODE:1 connect */
 	rtw_hal_set_hwreg(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status_rpt);
 }
 
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
@@ -1279,8 +1313,10 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
 	if (psta) {
 		/* the sta have been in sta_info_queue => do nothing */
-
-		return; /* between drv has received this event before and  fw have not yet to set key to CAM_ENTRY) */
+		/* between drv has received this event
+		 * before and fw have not yet to set key to CAM_ENTRY)
+		 */
+		return;
 	}
 
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
@@ -1304,14 +1340,15 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
-		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
 		if (adapter->stapriv.asoc_sta_count == 2) {
-			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
-			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.mac_address);
+			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
+			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue,
+							cur_network->network.mac_address);
 			pmlmepriv->cur_network_scanned = ptarget_wlan;
 			if (ptarget_wlan)
 				ptarget_wlan->fixed = true;
-			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			/*  a sta + bc/mc_stainfo (not Ibss_stainfo) */
 			rtw_indicate_connect(adapter);
 		}
@@ -1329,11 +1366,11 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
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
@@ -1344,13 +1381,13 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	if (mac_id >= 0) {
 		u16 media_status;
 
-		media_status = (mac_id<<8)|0; /*   MACID|OPMODE:0 means disconnect */
+		media_status = (mac_id << 8) | 0; /*   MACID|OPMODE:0 means disconnect */
 		/* for STA, AP, ADHOC mode, report disconnect stauts to FW */
 		rtw_hal_set_hwreg(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
 	}
 
 	/* if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) */
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)
 		return;
 
 	mlmeext_sta_del_event_callback(adapter);
@@ -1364,16 +1401,19 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
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
@@ -1385,40 +1425,45 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 		rtw_free_assoc_resources(adapter, 1);
 		rtw_indicate_disconnect(adapter);
 
-		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		/*  remove the network entry in scanned_queue */
-		pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
+		pwlan = rtw_find_network(&pmlmepriv->scanned_queue,
+					 tgt_network->network.mac_address);
 		if (pwlan) {
 			pwlan->fixed = false;
 			rtw_free_network_nolock(adapter, pwlan);
 		}
-		spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 
 		_rtw_roaming(adapter, roam_target);
 	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
-	      check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 		rtw_free_stainfo(adapter,  psta);
 
-		if (adapter->stapriv.asoc_sta_count == 1) {/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
+		if (adapter->stapriv.asoc_sta_count == 1) {
+			/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
 			u8 ret = _SUCCESS;
-			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+
+			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			/* free old ibss network */
-			pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
+			pwlan = rtw_find_network(&pmlmepriv->scanned_queue,
+						 tgt_network->network.mac_address);
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
 
-			memcpy(pdev_network, &tgt_network->network, get_wlan_bssid_ex_sz(&tgt_network->network));
+			memcpy(pdev_network, &tgt_network->network,
+			       get_wlan_bssid_ex_sz(&tgt_network->network));
 
-			memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+			memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid,
+			       sizeof(struct ndis_802_11_ssid));
 
 			rtw_update_registrypriv_dev_network(adapter);
 
@@ -1433,7 +1478,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			if (ret != _SUCCESS)
 				goto unlock;
 		}
-
 	}
 
 unlock:
@@ -1455,9 +1499,9 @@ void rtw_wmm_event_callback(struct adapter *padapter, u8 *pbuf)
 }
 
 /*
-* _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
-* @adapter: pointer to struct adapter structure
-*/
+ * _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
+ * @adapter: pointer to struct adapter structure
+ */
 void _rtw_join_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = timer_container_of(adapter, t,
@@ -1490,18 +1534,19 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 		rtw_indicate_disconnect(adapter);
 		free_scanqueue(pmlmepriv);/*  */
 
-		/* indicate disconnect for the case that join_timeout and check_fwstate != FW_LINKED */
+		/* indicate disconnect for the case that join_timeout
+		 * and check_fwstate != FW_LINKED
+		 */
 		rtw_cfg80211_indicate_disconnect(adapter);
-
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
 }
 
 /*
-* rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
-* @adapter: pointer to struct adapter structure
-*/
+ * rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
+ * @adapter: pointer to struct adapter structure
+ */
 void rtw_scan_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = timer_container_of(adapter, t,
@@ -1521,17 +1566,18 @@ void rtw_mlme_reset_auto_scan_int(struct adapter *adapter)
 {
 	struct mlme_priv *mlme = &adapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
-	if (pmlmeinfo->VHT_enable) /* disable auto scan when connect to 11AC AP */
+	if (pmlmeinfo->VHT_enable) { /* disable auto scan when connect to 11AC AP */
 		mlme->auto_scan_int_ms = 0;
-	else if (adapter->registrypriv.wifi_spec && is_client_associated_to_ap(adapter) == true)
-		mlme->auto_scan_int_ms = 60*1000;
-	else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
+	} else if (adapter->registrypriv.wifi_spec && is_client_associated_to_ap(adapter) == true) {
+		mlme->auto_scan_int_ms = 60 * 1000;
+	} else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
 		if (check_fwstate(mlme, WIFI_STATION_STATE) && check_fwstate(mlme, _FW_LINKED))
 			mlme->auto_scan_int_ms = mlme->roam_scan_int_ms;
-	} else
+	} else {
 		mlme->auto_scan_int_ms = 0; /* disabled */
+	}
 }
 
 static void rtw_auto_scan_handler(struct adapter *padapter)
@@ -1540,9 +1586,8 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 
 	rtw_mlme_reset_auto_scan_int(padapter);
 
-	if (pmlmepriv->auto_scan_int_ms != 0
-		&& jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time) > pmlmepriv->auto_scan_int_ms) {
-
+	if (pmlmepriv->auto_scan_int_ms != 0 &&
+	    jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time) > pmlmepriv->auto_scan_int_ms) {
 		if (!padapter->registrypriv.wifi_spec) {
 			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) == true)
 				goto exit;
@@ -1572,8 +1617,8 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 	if (adapter->net_closed)
 		return;
 
-	if ((adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
-		&& !(hal_btcoex_IsBtControlLps(adapter))
+	if ((adapter_to_pwrctl(adapter)->fw_current_in_ps_mode) &&
+	    !(hal_btcoex_IsBtControlLps(adapter))
 		) {
 		u8 bEnterPS;
 
@@ -1584,7 +1629,9 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 			/* rtw_lps_ctrl_wk_cmd(adapter, LPS_CTRL_ENTER, 1); */
 			rtw_hal_dm_watchdog_in_lps(adapter);
 		} else {
-			/* call rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_LEAVE, 1) in traffic_status_watchdog() */
+			/* call rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_LEAVE, 1)
+			 * in traffic_status_watchdog()
+			 */
 		}
 
 	} else {
@@ -1618,10 +1665,10 @@ void rtw_set_scan_deny(struct adapter *adapter, u32 ms)
 }
 
 /*
-* Select a new roaming candidate from the original @param candidate and @param competitor
-* @return true: candidate is updated
-* @return false: candidate is not updated
-*/
+ * Select a new roaming candidate from the original @param candidate and @param competitor
+ * @return true: candidate is updated
+ * @return false: candidate is not updated
+ */
 static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 	, struct wlan_network **candidate, struct wlan_network *competitor)
 {
@@ -1644,7 +1691,8 @@ static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 	if (jiffies_to_msecs(jiffies - competitor->last_scanned) >= mlme->roam_scanr_exp_ms)
 		goto exit;
 
-	if (competitor->network.rssi - mlme->cur_network_scanned->network.rssi < mlme->roam_rssi_diff_th)
+	if (competitor->network.rssi - mlme->cur_network_scanned->network.rssi <
+	    mlme->roam_rssi_diff_th)
 		goto exit;
 
 	if (*candidate && (*candidate)->network.rssi >= competitor->network.rssi)
@@ -1662,7 +1710,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 {
 	int ret = _FAIL;
 	struct list_head	*phead;
-	struct __queue	*queue	= &(mlme->scanned_queue);
+	struct __queue	*queue	= &mlme->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	struct	wlan_network	*candidate = NULL;
 
@@ -1671,16 +1719,14 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 		return ret;
 	}
 
-	spin_lock_bh(&(mlme->scanned_queue.lock));
+	spin_lock_bh(&mlme->scanned_queue.lock);
 	phead = get_list_head(queue);
 
 	list_for_each(mlme->pscanned, phead) {
-
 		pnetwork = list_entry(mlme->pscanned, struct wlan_network,
 				      list);
 
 		rtw_check_roaming_candidate(mlme, &candidate, pnetwork);
-
 	}
 
 	if (!candidate) {
@@ -1695,16 +1741,16 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 
 	ret = _SUCCESS;
 exit:
-	spin_unlock_bh(&(mlme->scanned_queue.lock));
+	spin_unlock_bh(&mlme->scanned_queue.lock);
 
 	return ret;
 }
 
 /*
-* Select a new join candidate from the original @param candidate and @param competitor
-* @return true: candidate is updated
-* @return false: candidate is not updated
-*/
+ * Select a new join candidate from the original @param candidate and @param competitor
+ * @return true: candidate is updated
+ * @return false: candidate is not updated
+ */
 static int rtw_check_join_candidate(struct mlme_priv *mlme
 	, struct wlan_network **candidate, struct wlan_network *competitor)
 {
@@ -1719,8 +1765,9 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 
 	/* check ssid, if needed */
 	if (mlme->assoc_ssid.ssid[0] && mlme->assoc_ssid.ssid_length) {
-		if (competitor->network.ssid.ssid_length != mlme->assoc_ssid.ssid_length
-			|| memcmp(competitor->network.ssid.ssid, mlme->assoc_ssid.ssid, mlme->assoc_ssid.ssid_length)
+		if (competitor->network.ssid.ssid_length != mlme->assoc_ssid.ssid_length ||
+		    memcmp(competitor->network.ssid.ssid, mlme->assoc_ssid.ssid,
+			   mlme->assoc_ssid.ssid_length)
 		)
 			goto exit;
 	}
@@ -1729,8 +1776,9 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 		goto exit;
 
 	if (rtw_to_roam(adapter) > 0) {
-		if (jiffies_to_msecs(jiffies - competitor->last_scanned) >= mlme->roam_scanr_exp_ms
-			|| is_same_ess(&competitor->network, &mlme->cur_network.network) == false
+		if (jiffies_to_msecs(jiffies - competitor->last_scanned) >=
+		    mlme->roam_scanr_exp_ms || is_same_ess(&competitor->network,
+							   &mlme->cur_network.network) == false
 		)
 			goto exit;
 	}
@@ -1745,24 +1793,24 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 }
 
 /*
-Calling context:
-The caller of the sub-routine will be in critical section...
-The caller must hold the following spinlock
-pmlmepriv->lock
-*/
+ * Calling context:
+ * The caller of the sub-routine will be in critical section...
+ * The caller must hold the following spinlock
+ * pmlmepriv->lock
+ */
 
 int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 {
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
@@ -1772,12 +1820,10 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 	phead = get_list_head(queue);
 	list_for_each(pmlmepriv->pscanned, phead) {
-
 		pnetwork = list_entry(pmlmepriv->pscanned,
 				      struct wlan_network, list);
 
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
-
 	}
 
 	if (!candidate) {
@@ -1800,7 +1846,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	ret = rtw_joinbss_cmd(adapter, candidate);
 
 exit:
-	spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+	spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 	return ret;
 }
 
@@ -1808,7 +1854,7 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
 {
 	struct	cmd_obj *pcmd;
 	struct	setauth_parm *psetauthparm;
-	struct	cmd_priv *pcmdpriv = &(adapter->cmdpriv);
+	struct	cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	signed int		res = _SUCCESS;
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
@@ -1840,12 +1886,13 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
 	return res;
 }
 
-signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, signed int keyid, u8 set_tx, bool enqueue)
+signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv,
+		       signed int keyid, u8 set_tx, bool enqueue)
 {
 	u8 keylen;
 	struct cmd_obj		*pcmd;
 	struct setkey_parm	*psetkeyparm;
-	struct cmd_priv 	*pcmdpriv = &(adapter->cmdpriv);
+	struct cmd_priv		*pcmdpriv = &adapter->cmdpriv;
 	signed int	res = _SUCCESS;
 
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
@@ -1865,14 +1912,13 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 		adapter->securitypriv.key_mask |= BIT(psetkeyparm->keyid);
 
 	switch (psetkeyparm->algorithm) {
-
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
@@ -1916,7 +1962,8 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 }
 
 /* adjust ies for rtw_joinbss_cmd in WMM */
-int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_len, uint initial_out_len)
+int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie,
+			uint in_len, uint initial_out_len)
 {
 	unsigned	int ielength = 0;
 	unsigned int i, j;
@@ -1925,7 +1972,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	while (i < in_len) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) { /* WMM element ID and OUI */
+		if (in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 &&
+		    in_ie[i + 3] == 0x50 && in_ie[i + 4] == 0xF2 &&
+		    in_ie[i + 5] == 0x02 && i + 5 < in_len) {
+			/* WMM element ID and OUI */
 			for (j = i; j < i + 9; j++) {
 				out_ie[ielength] = in_ie[j];
 				ielength++;
@@ -1937,11 +1987,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
-		i += (in_ie[i+1]+2); /*  to the next IE element */
+		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
 	return ielength;
-
 }
 
 /*  */
@@ -1950,8 +1999,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 /*  */
 /*  Search by BSSID, */
 /*  Return Value: */
-/* 		-1		:if there is no pre-auth key in the  table */
-/* 		>= 0		:if there is pre-auth key, and   return the entry id */
+/*		-1	:if there is no pre-auth key in the  table */
+/*		>= 0	:if there is pre-auth key, and   return the entry id */
 /*  */
 /*  */
 
@@ -1962,7 +2011,7 @@ static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
 
 	for (i = 0; i < NUM_PMKID_CACHE; i++)
 		if ((p->PMKIDList[i].bUsed) &&
-				(!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
+		    (!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
 			return i;
 	return -1;
 }
@@ -2011,13 +2060,14 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 		authmode = WLAN_EID_RSN;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		memcpy(out_ie+ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
+		memcpy(out_ie + ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
 
 		ielength += psecuritypriv->wps_ie_len;
 	} else if ((authmode == WLAN_EID_VENDOR_SPECIFIC) || (authmode == WLAN_EID_RSN)) {
 		/* copy RSN or SSN */
-		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1]+2);
-		ielength += psecuritypriv->supplicant_ie[1]+2;
+		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0],
+		       psecuritypriv->supplicant_ie[1] + 2);
+		ielength += psecuritypriv->supplicant_ie[1] + 2;
 		rtw_report_sec_ie(adapter, authmode, psecuritypriv->supplicant_ie);
 	}
 
@@ -2054,7 +2104,8 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	struct	security_priv *psecuritypriv = &adapter->securitypriv;
 	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
 
-	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ; /*  adhoc no 802.1x */
+	pdev_network->privacy =
+		(psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ; /*  adhoc no 802.1x */
 
 	pdev_network->rssi = 0;
 
@@ -2084,14 +2135,18 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
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
+	/* notes: translate ie_length & length after
+	 * assign the length to cmdsz in createbss_cmd();
+	 */
 	/* pdev_network->ie_length = cpu_to_le32(sz); */
 }
 
@@ -2105,9 +2160,12 @@ void rtw_joinbss_reset(struct adapter *padapter)
 	u8 threshold;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
-	/* todo: if you want to do something io/reg/hw setting before join_bss, please add code here */
+	/*
+	 * todo: if you want to do something io/reg/hw setting
+	 * before join_bss, please add code here
+	 */
 
 	pmlmepriv->num_FortyMHzIntolerant = 0;
 
@@ -2131,8 +2189,8 @@ void rtw_joinbss_reset(struct adapter *padapter)
 
 void rtw_ht_use_default_setting(struct adapter *padapter)
 {
-	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	bool		bHwLDPCSupport = false, bHwSTBCSupport = false;
 	bool		bHwSupportBeamformer = false, bHwSupportBeamformee = false;
@@ -2189,7 +2247,7 @@ void rtw_build_wmm_ie_ht(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 
 	if (padapter->mlmepriv.qospriv.qos_option == 0) {
 		out_len = *pout_len;
-		rtw_set_ie(out_ie+out_len, WLAN_EID_VENDOR_SPECIFIC,
+		rtw_set_ie(out_ie + out_len, WLAN_EID_VENDOR_SPECIFIC,
 			   _WMM_IE_Length_, WMM_IE, pout_len);
 
 		padapter->mlmepriv.qospriv.qos_option = 1;
@@ -2197,7 +2255,8 @@ void rtw_build_wmm_ie_ht(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 }
 
 /* the function is >= passive_level */
-unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_ie, uint in_len, uint *pout_len, u8 channel)
+unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie,
+				   u8 *out_ie, uint in_len, uint *pout_len, u8 channel)
 {
 	u32 ielen, out_len;
 	enum ieee80211_max_ampdu_length_exp max_rx_ampdu_factor;
@@ -2206,7 +2265,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	u8 cbw40_enable = 0, stbc_rx_enable = 0, operation_bw = 0;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	phtpriv->ht_option = false;
@@ -2227,13 +2286,14 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 			operation_bw = padapter->mlmeextpriv.cur_bwmode;
 			if (operation_bw > CHANNEL_WIDTH_40)
 				operation_bw = CHANNEL_WIDTH_40;
-		} else
+		} else {
 			/* TDLS: TODO 40? */
 			operation_bw = CHANNEL_WIDTH_40;
+		}
 	} else {
 		p = rtw_get_ie(in_ie, WLAN_EID_HT_OPERATION, &ielen, in_len);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
-			struct HT_info_element *pht_info = (struct HT_info_element *)(p+2);
+			struct HT_info_element *pht_info = (struct HT_info_element *)(p + 2);
 
 			if (pht_info->infos[0] & BIT(2)) {
 				switch (pht_info->infos[0] & 0x3) {
@@ -2283,7 +2343,8 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 
 	/* update default supported_mcs_set */
 	if (stbc_rx_enable)
-		ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_RX_STBC_1R);/* RX STBC One spatial stream */
+		ht_capie.cap_info |=
+			cpu_to_le16(IEEE80211_HT_CAP_RX_STBC_1R);/* RX STBC One spatial stream */
 
 	set_mcs_rate_by_mask(ht_capie.mcs.rx_mask, MCS_RATE_1R);
 
@@ -2301,14 +2362,14 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		rtw_hal_get_def_var(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR,
 				    &max_rx_ampdu_factor);
 
-	ht_capie.ampdu_params_info = (max_rx_ampdu_factor&0x03);
+	ht_capie.ampdu_params_info = (max_rx_ampdu_factor & 0x03);
 
 	if (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
-		ht_capie.ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY&(0x07<<2));
+		ht_capie.ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY & (0x07 << 2));
 	else
-		ht_capie.ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY&0x00);
+		ht_capie.ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY & 0x00);
 
-	rtw_set_ie(out_ie+out_len, WLAN_EID_HT_CAPABILITY,
+	rtw_set_ie(out_ie + out_len, WLAN_EID_HT_CAPABILITY,
 		   sizeof(struct ieee80211_ht_cap), (unsigned char *)&ht_capie, pout_len);
 
 	phtpriv->ht_option = true;
@@ -2317,12 +2378,11 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		p = rtw_get_ie(in_ie, WLAN_EID_HT_OPERATION, &ielen, in_len);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
 			out_len = *pout_len;
-			rtw_set_ie(out_ie+out_len, WLAN_EID_HT_OPERATION, ielen, p+2, pout_len);
+			rtw_set_ie(out_ie + out_len, WLAN_EID_HT_OPERATION, ielen, p + 2, pout_len);
 		}
 	}
 
 	return phtpriv->ht_option;
-
 }
 
 /* the function is > passive_level (in critical_section) */
@@ -2332,10 +2392,10 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	int len;
 	struct ieee80211_ht_cap *pht_capie;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 cbw40_enable = 0;
 
 	if (!phtpriv->ht_option)
@@ -2350,22 +2410,22 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 
 	/* check Max Rx A-MPDU Size */
 	len = 0;
-	p = rtw_get_ie(pie+sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_CAPABILITY, &len, ie_len-sizeof(struct ndis_802_11_fix_ie));
+	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_CAPABILITY,
+		       &len, ie_len - sizeof(struct ndis_802_11_fix_ie));
 	if (p && len > 0) {
-		pht_capie = (struct ieee80211_ht_cap *)(p+2);
+		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		max_ampdu_sz = (pht_capie->ampdu_params_info & IEEE80211_HT_CAP_AMPDU_FACTOR);
-		max_ampdu_sz = 1 << (max_ampdu_sz+3); /*  max_ampdu_sz (kbytes); */
+		max_ampdu_sz = 1 << (max_ampdu_sz + 3); /*  max_ampdu_sz (kbytes); */
 
 		phtpriv->rx_ampdu_maxlen = max_ampdu_sz;
-
 	}
 
 	len = 0;
-	p = rtw_get_ie(pie+sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_OPERATION, &len, ie_len-sizeof(struct ndis_802_11_fix_ie));
+	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_OPERATION,
+		       &len, ie_len - sizeof(struct ndis_802_11_fix_ie));
 	if (p && len > 0) {
 		/* todo: */
 	}
-
 	if (channel > 14) {
 		if ((pregistrypriv->bw_mode & 0xf0) > 0)
 			cbw40_enable = 1;
@@ -2382,7 +2442,8 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 
 		/* update the MCS set */
 		for (i = 0; i < 16; i++)
-			pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= pmlmeext->default_supported_mcs_set[i];
+			pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &=
+				pmlmeext->default_supported_mcs_set[i];
 
 		/* update the MCS rates */
 		set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_1R);
@@ -2445,21 +2506,20 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 	phtpriv = &psta->htpriv;
 
 	if (phtpriv->ht_option && phtpriv->ampdu_enable) {
-		issued = (phtpriv->agg_enable_bitmap>>priority)&0x1;
-		issued |= (phtpriv->candidate_tid_bitmap>>priority)&0x1;
+		issued = (phtpriv->agg_enable_bitmap >> priority) & 0x1;
+		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
 
 		if (issued == 0) {
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
-			rtw_addbareq_cmd(padapter, (u8) priority, pattrib->ra);
+			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
 	}
-
 }
 
 void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	u8 cap_content[8] = {0};
 
 	if (phtpriv->bss_coexist)
@@ -2494,13 +2554,15 @@ void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	_rtw_roaming(padapter, tgt_network);
 	spin_unlock_bh(&pmlmepriv->lock);
 }
+
 void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 
 	if (rtw_to_roam(padapter) > 0) {
-		memcpy(&pmlmepriv->assoc_ssid, &cur_network->network.ssid, sizeof(struct ndis_802_11_ssid));
+		memcpy(&pmlmepriv->assoc_ssid, &cur_network->network.ssid,
+		       sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
 
@@ -2517,7 +2579,8 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 signed int rtw_linked_check(struct adapter *padapter)
 {
 	if ((check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true) ||
-			(check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE) == true)) {
+	    (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE |
+			   WIFI_ADHOC_MASTER_STATE) == true)) {
 		if (padapter->stapriv.asoc_sta_count > 2)
 			return true;
 	} else {	/* Station mode */
-- 
2.39.5


