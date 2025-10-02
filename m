Return-Path: <linux-kernel+bounces-840547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7820BBB4AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C5419E33E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1466B23E25B;
	Thu,  2 Oct 2025 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkhw+Yf2"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6526B742
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425828; cv=none; b=QFp7ymJfbp2PousZf15ksoHi8RL/BRghMqCi1jULCyX5tSy8in9ChmVBl0iwCHHHGrxMztObKh3Zb5JnIV1uk3xkcIjkBwix7Zqb2VwWKETmKmhvj3w0hxWdUgatyFguCh91C3dG7D1LI1nC9/HbRlNdPFOdZFZ66gtwytTNM54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425828; c=relaxed/simple;
	bh=ePuarNrsY7EZZ9MM/Vvu/sp8x93Z+PMQeTCDUVCn+B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pI+g1G9WZU4jCIyHJQ53XGdyRn8tw/ncZVVW/oxs44qX5o13ezbRxVaVP4uLv5VOE4ycAZAXTJ7NwEQYbol5kmM04BYgSmojJv5AZDdgtWPovPALIl0t9SA8Dqst4xic4sbXrrCQP5bJaE4/CYYnCh9+5mTsruIMk/fxZDb6eLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkhw+Yf2; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-854cfde0ca2so175143985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425825; x=1760030625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gyvz2PnCihJepyklJ9V8WW8HGo6hsppNuPSL+nFTACs=;
        b=hkhw+Yf2w/6nT7N1bBDvBS56uwH1XP/ZfgiIqu7J2wUcfDMHG09Mo8/QLphNKlzW4Z
         /+VNX6PSr1Dm4FX3J2uMaYMd9LhbHMxfaUXoDv4/dgt+I1UjoWxZ2ycAXg3bQQcgy6LZ
         B2u8DmenvkQzQzjQwmN2F7DFDYejl4B9fp8Xv0abF42Khj2HxouP+338EwnBdE2mEYEa
         loqo+Z02jeICEMHWOmtWl1yzD2TnheIv7d6cvzfx0d5Rm8U/t+80B8l/LqDov4ojPoap
         zAvoj81KSlJBTbmPzTgCWhjeSrkxS3BboS4ugboqWGQFHqkds1hC2I37UEVM5pnow0BK
         2z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425825; x=1760030625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gyvz2PnCihJepyklJ9V8WW8HGo6hsppNuPSL+nFTACs=;
        b=e7fTWYeyPp89bFmQPfgQ3UnG104A/NFZ8L+KkBnuxPqUCOFKyB6TdXHXCZYYpNo8u/
         XVTzuRai6UHp6nQdeZXFSeqCxShmveIkKT8SCMvomENIF+pif3I5OoZdrjCgSK8JgmBC
         OsRT5M9ypLyKJWQfJl1GMhmNB7VaUznnpVkgG2+7w7pJrS8HuoiwmZzqpaVNeR+stbW9
         6SAM+sW6jHLp7JymYKRztK/RLRT43y1oUKshYFl9r8a27xgEDT1AA1EsbK2UsOqRk6E3
         P9DXfmDy/TrQ3OtKfVulm/tCJpIQ1E/4snRCMlqIMgFEUu7GiScwm7RdOhXmjS8YSMxZ
         Vh6w==
X-Forwarded-Encrypted: i=1; AJvYcCWt6AhYkGIqvzXNVgL7XiOCgCp0aRGrpNH4k0cP4ZvPQcJ2RKiCcIkBkFdu7xeBfewxKBcEPsNjntTqDBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLoV5xHfNFMnUZ++lBVr6LoZ0zZmEedYLiOMDR6o0wCRn0eFun
	vs4lwJ13ChTMdyQj8wiYpEwUD0+ZhazJBtSBguhR+T2UU9MCkuSuAca3hBhc1w==
X-Gm-Gg: ASbGnctR9AwHfdiPbD45CkP8jLB0rQr99CrhlL2aDkHbOmTqkNGF+TkHUAdkC8lu0i/
	+O6xuMOix4dZyspC1yftWFFaurA3VHBlp+MEg3Pu7bZVzrEODRtJvtHm2vQsN4BejyeGO09KUpN
	sw/cecFufgHtLyLwUaFtDZOGG095CGkGJrZo6CDxFrgfLjw/PI0lUbotf/6Bkd9MOwryO5l9jX7
	XiUszfbkS4Mc3A0FssdXB59qKSnmAq3XzEmS1j71q+RpBGvjW4vkeuNWBc0Yh7UcDrHnllJYCYc
	6N856BndS7pezx6EJ9fRWlirpnAMzJllDdLIIHSUNMxYm7/WeDHdzXdrVY+zeW2oKimH0zypTfz
	2gNnqJyb8AHbl/mBRNhPKgQY7/D4y2dNNpGWM3FDQtzVOR2lXrNlC6emO33xn97nhHgw1m0mTMM
	tb8k0x61DfaNA94R/qT7kY
X-Google-Smtp-Source: AGHT+IHO/IJOenm9r+3vcPIbKjuRPniVjVJ6euqXR6BQMJGc/XTGQe8pUJuwORE8JFaQcMhTcnk7tQ==
X-Received: by 2002:a05:620a:4052:b0:84b:aaa4:aa1a with SMTP id af79cd13be357-87a38b2fdd2mr29778685a.83.1759425824903;
        Thu, 02 Oct 2025 10:23:44 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:23:44 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 01/16] staging: rtl8723bs: fix spacing around operators
Date: Thu,  2 Oct 2025 17:22:49 +0000
Message-Id: <20251002172304.1083601-2-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
References: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Standardize spacing around '+', '&&', '>>', '/', '|', '&', '<<'
and similar operators to follow kernel coding style. This improves
readability and maintainability.

No functional changes.
Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 72 +++++++++++------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index c06d990350e6..516e736d03f1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -283,8 +283,8 @@ void rtw_generate_random_ibss(u8 *pibss)
 	pibss[1] = 0x11;
 	pibss[2] = 0x87;
 	pibss[3] = (u8)(curtime & 0xff) ;/* p[0]; */
-	pibss[4] = (u8)((curtime>>8) & 0xff) ;/* p[1]; */
-	pibss[5] = (u8)((curtime>>16) & 0xff) ;/* p[2]; */
+	pibss[4] = (u8)((curtime >> 8) & 0xff) ;/* p[1]; */
+	pibss[5] = (u8)((curtime >> 16) & 0xff) ;/* p[2]; */
 }
 
 u8 *rtw_get_capability_from_ie(u8 *ie)
@@ -433,14 +433,14 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
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
+			ss_final = ((u32)(src->phy_info.signal_strength) + (u32)(dst->phy_info.signal_strength) * 4) / 5;
+			sq_final = ((u32)(src->phy_info.signal_quality) + (u32)(dst->phy_info.signal_quality) * 4) / 5;
+			rssi_final = (src->rssi + dst->rssi * 4) / 5;
 		} else {
 			/* bss info not receiving from the right channel, use the original RX signal infos */
 			ss_final = dst->phy_info.signal_strength;
@@ -609,7 +609,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	privacy = pnetwork->network.privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		if (rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
+		if (rtw_get_wps_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, pnetwork->network.ie_length - _FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
 			return false;
@@ -853,14 +853,14 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
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
@@ -915,7 +915,7 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING|WIFI_UNDER_WPS);
+	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING | WIFI_UNDER_WPS);
 
 	if (rtw_to_roam(padapter) > 0)
 		_clr_fwstate_(pmlmepriv, _FW_LINKED);
@@ -946,7 +946,7 @@ inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 
 	if ((!adapter_to_pwrctl(padapter)->bInSuspend) &&
 	    (!check_fwstate(&padapter->mlmepriv,
-			    WIFI_ASOC_STATE|WIFI_UNDER_LINKING))) {
+			    WIFI_ASOC_STATE | WIFI_UNDER_LINKING))) {
 		rtw_set_ips_deny(padapter, 0);
 		_set_timer(&padapter->mlmepriv.dynamic_chk_timer, 1);
 	}
@@ -1084,8 +1084,8 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	switch (pnetwork->network.infrastructure_mode) {
 	case Ndis802_11Infrastructure:
 
-			if (pmlmepriv->fw_state&WIFI_UNDER_WPS)
-				pmlmepriv->fw_state = WIFI_STATION_STATE|WIFI_UNDER_WPS;
+			if (pmlmepriv->fw_state & WIFI_UNDER_WPS)
+				pmlmepriv->fw_state = WIFI_STATION_STATE | WIFI_UNDER_WPS;
 			else
 				pmlmepriv->fw_state = WIFI_STATION_STATE;
 
@@ -1315,7 +1315,7 @@ void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta, u3
 	if (!psta)
 		return;
 
-	media_status_rpt = (u16)((psta->mac_id<<8)|mstatus); /*   MACID|OPMODE:1 connect */
+	media_status_rpt = (u16)((psta->mac_id << 8) | mstatus); /*   MACID|OPMODE:1 connect */
 	rtw_hal_set_hwreg(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status_rpt);
 }
 
@@ -1433,13 +1433,13 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
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
@@ -1613,7 +1613,7 @@ void rtw_mlme_reset_auto_scan_int(struct adapter *adapter)
 	if (pmlmeinfo->VHT_enable) /* disable auto scan when connect to 11AC AP */
 		mlme->auto_scan_int_ms = 0;
 	else if (adapter->registrypriv.wifi_spec && is_client_associated_to_ap(adapter) == true)
-		mlme->auto_scan_int_ms = 60*1000;
+		mlme->auto_scan_int_ms = 60 * 1000;
 	else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
 		if (check_fwstate(mlme, WIFI_STATION_STATE) && check_fwstate(mlme, _FW_LINKED))
 			mlme->auto_scan_int_ms = mlme->roam_scan_int_ms;
@@ -2006,7 +2006,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	while (i < in_len) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) { /* WMM element ID and OUI */
+		if (in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 && in_ie[i + 3] == 0x50  && in_ie[i + 4] == 0xF2 && in_ie[i + 5] == 0x02 && i + 5 < in_len) { /* WMM element ID and OUI */
 			for (j = i; j < i + 9; j++) {
 				out_ie[ielength] = in_ie[j];
 				ielength++;
@@ -2018,7 +2018,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
-		i += (in_ie[i+1]+2); /*  to the next IE element */
+		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
 	return ielength;
@@ -2124,13 +2124,13 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 		authmode = WLAN_EID_RSN;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		memcpy(out_ie+ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
+		memcpy(out_ie + ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
 
 		ielength += psecuritypriv->wps_ie_len;
 	} else if ((authmode == WLAN_EID_VENDOR_SPECIFIC) || (authmode == WLAN_EID_RSN)) {
 		/* copy RSN or SSN */
-		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1]+2);
-		ielength += psecuritypriv->supplicant_ie[1]+2;
+		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1] + 2);
+		ielength += psecuritypriv->supplicant_ie[1] + 2;
 		rtw_report_sec_ie(adapter, authmode, psecuritypriv->supplicant_ie);
 	}
 
@@ -2298,7 +2298,7 @@ void rtw_build_wmm_ie_ht(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 
 	if (padapter->mlmepriv.qospriv.qos_option == 0) {
 		out_len = *pout_len;
-		rtw_set_ie(out_ie+out_len, WLAN_EID_VENDOR_SPECIFIC,
+		rtw_set_ie(out_ie + out_len, WLAN_EID_VENDOR_SPECIFIC,
 			   _WMM_IE_Length_, WMM_IE, pout_len);
 
 		padapter->mlmepriv.qospriv.qos_option = 1;
@@ -2342,7 +2342,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	} else {
 		p = rtw_get_ie(in_ie, WLAN_EID_HT_OPERATION, &ielen, in_len);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
-			struct HT_info_element *pht_info = (struct HT_info_element *)(p+2);
+			struct HT_info_element *pht_info = (struct HT_info_element *)(p + 2);
 
 			if (pht_info->infos[0] & BIT(2)) {
 				switch (pht_info->infos[0] & 0x3) {
@@ -2405,14 +2405,14 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
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
@@ -2421,7 +2421,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		p = rtw_get_ie(in_ie, WLAN_EID_HT_OPERATION, &ielen, in_len);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
 			out_len = *pout_len;
-			rtw_set_ie(out_ie+out_len, WLAN_EID_HT_OPERATION, ielen, p+2, pout_len);
+			rtw_set_ie(out_ie + out_len, WLAN_EID_HT_OPERATION, ielen, p + 2, pout_len);
 		}
 	}
 
@@ -2453,17 +2453,17 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 
 	/* check Max Rx A-MPDU Size */
 	len = 0;
-	p = rtw_get_ie(pie+sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_CAPABILITY, &len, ie_len-sizeof(struct ndis_802_11_fix_ie));
+	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_CAPABILITY, &len, ie_len - sizeof(struct ndis_802_11_fix_ie));
 	if (p && len > 0) {
-		pht_capie = (struct ieee80211_ht_cap *)(p+2);
+		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		max_ampdu_sz = (pht_capie->ampdu_params_info & IEEE80211_HT_CAP_AMPDU_FACTOR);
-		max_ampdu_sz = 1 << (max_ampdu_sz+3); /*  max_ampdu_sz (kbytes); */
+		max_ampdu_sz = 1 << (max_ampdu_sz + 3); /*  max_ampdu_sz (kbytes); */
 
 		phtpriv->rx_ampdu_maxlen = max_ampdu_sz;
 	}
 
 	len = 0;
-	p = rtw_get_ie(pie+sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_OPERATION, &len, ie_len-sizeof(struct ndis_802_11_fix_ie));
+	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_OPERATION, &len, ie_len - sizeof(struct ndis_802_11_fix_ie));
 	if (p && len > 0) {
 		/* todo: */
 	}
@@ -2542,8 +2542,8 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 	phtpriv = &psta->htpriv;
 
 	if (phtpriv->ht_option && phtpriv->ampdu_enable) {
-		issued = (phtpriv->agg_enable_bitmap>>priority)&0x1;
-		issued |= (phtpriv->candidate_tid_bitmap>>priority)&0x1;
+		issued = (phtpriv->agg_enable_bitmap >> priority) & 0x1;
+		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
 
 		if (issued == 0) {
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
@@ -2614,7 +2614,7 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 signed int rtw_linked_check(struct adapter *padapter)
 {
 	if ((check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true) ||
-			(check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE) == true)) {
+			(check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE) == true)) {
 		if (padapter->stapriv.asoc_sta_count > 2)
 			return true;
 	} else {	/* Station mode */
-- 
2.39.5


