Return-Path: <linux-kernel+bounces-842354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48331BB991A
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 17:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EFC3A5949
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1AD2737FC;
	Sun,  5 Oct 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PguKwwd2"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1313B293
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759679980; cv=none; b=Kednt4TRJPbpgOeDyH06/Kbnb4z3iDqiAdcaOui/MOHkOiIWZJoe6Nkso/ZlljmHOTgAS3ant+pdPDj2XelnC9guN5EWITuV7GZcVG8gWpob42RiM7HsEFOLXExrRwYrOZqASYtOZDHMEtU32hLEpDF85X4UtF7VOjrZ/+eHBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759679980; c=relaxed/simple;
	bh=RQnExi60+yyNhWHLJfVnNYTm8RgxWx2nVA31vqvU/pY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cInXlGzSLtKlv2QHLUVNPZd1GOOfk5HSqPaDmBaXdp0dV59iw6M5xdVl8PveX9oFsMCpjU2Wl6CwtXXPAvNxdzVzhwTgSO7zAR8yFW6do1T5R/1YLnn/AtKySxU9PIBaTTiippN9Ly/n/cBOTDCepEOVj16NSTTV3RkwFKrsQyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PguKwwd2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3166613b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759679978; x=1760284778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnRnOQ1Pq38OkTR7TeUYBt0JNwY3+a4hWK0+AaDZnsE=;
        b=PguKwwd2iEzYFhTdJf0TrLex0+ZHEmdIg3b0y8Q6W5VKDsIzR/IqVhvq+aBJRFolwz
         l7WzLWfzK7t1NNPZuVWA0ZbGdZ4VWFhEOCco4hPNV5fYKLBGop4p8i5w7bU3RZVpgkUh
         UNsfLu9dlglesGjUt24ye50yOR5J38ZmIsOleoCKIje3LR1upoSHtfa2NFnA4xNUvwCG
         XB9NvEn/ouiKJ+ZoFWSSqe/6PEcfYkiUVADZqh03Hjqtb9UIZNQJ+8D6H2aInjr5ok5T
         gVdaMUT6z3oOOOSQKYQb401hbtKwvDeGGxOuEqOznBdqGcl1I3oPeHnnu72UFbAdPVtB
         y4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759679978; x=1760284778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnRnOQ1Pq38OkTR7TeUYBt0JNwY3+a4hWK0+AaDZnsE=;
        b=D5K1f7V2unCRRhV7Mz9q0n09t5MGOxSFiHVSmkxy6rF/RHXYVd34gMQ2HBgMLdTgY4
         LMs87O1PD7v8pNVXk4ammMeEmHNFCKlhg2KSpZjX7Nzbd7Af5jDLCGsv42EPb1d7NWY+
         tljpX48o4r1/y/5nCi77N6G2H+ijtx4ck5NCQkoNGozhjhO6aPvd5XItFSXtQFM+KY7f
         2JzeElrcsLqFVBp72dDS/1cg1jkxpnaNFg3EOWvzdK3Ncrwyl8cwcw/OCf96q8Ze5afC
         ZnBbQPyQpIP0VInT2f6IAjor/XwFOHQN51kkul2lQuC+BsY1YOqAoHUcIg/FCTHyGnED
         4AWA==
X-Forwarded-Encrypted: i=1; AJvYcCXKf1uQqMTG99lbLAQqscHDSJ0T0pp86xjoCi8yGTwCaTrjbXgfXmzOn/w0+bT9OGPjH46Hg92eZmYonB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTW/H0s8Fk7vQSR8GlrwXKdhF6yd3q9YuGdewMSsS0ddgyg9fD
	in5UlwtSKuL7hSdoQcwUqXsLrImgSH3dDtoT1BYfxEtE14iRFYfmOkWm
X-Gm-Gg: ASbGncsyOdUjAEODVljgYpJ57S5kUg9AXHrp+kEUZHLfqPs57FXs003TZmCjsoIx8Go
	er7otvr33xu/gXaRQom+0lB9fB0kp/mCsDWVtAD0cVjgKd8vMZp9O00JYGCCYgqrCtxdi2BrzUx
	hhcBYvNiIQXAm4QCdqwAiyZvJW9FRAm9KsbDsYl1l/3MhPHLc0ithA+NugnrGuv7QKu5zSbE86s
	dW9qYMel3/E/bAaJc5kz5OwwtWV7B73vMxsjYq//l0EK+P+1hbUS3pYQ+6l+P91lkYCRD1wuX6j
	yh1OfU5YVdNau1cgsnqCO95MbjuunzgyyGszl4Uk8VBacLrb7A3UOjEPvtS/lCT20TBhjUz/ANq
	X/wlfyl5Jioe4jfygAZrb7agy6j40j2sY07Rfo2ES7cYGC+hSzktVUnVkNBsl
X-Google-Smtp-Source: AGHT+IEP5dnxDhiyvftLa1P+fwU9YmxMr0ODWB/mu8Br8EPmSZ7mhfR5XfY8YDpHgj9fnNbbP0bcvg==
X-Received: by 2002:a05:6a00:6e9b:b0:781:1af:d3d9 with SMTP id d2e1a72fcca58-78b02204bcdmr11925982b3a.4.1759679977862;
        Sun, 05 Oct 2025 08:59:37 -0700 (PDT)
Received: from Deathstar.anonymous ([172.56.42.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb3d95sm10145241b3a.32.2025.10.05.08.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 08:59:37 -0700 (PDT)
From: Rohan Tripathi <trohan2000@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rohan Tripathi <trohan2000@gmail.com>
Subject: [PATCH 1/4] staging: rtl8723bs: clean up lines ending with '(' in rtw_ap.c
Date: Sun,  5 Oct 2025 11:59:16 -0400
Message-ID: <20251005155920.381334-1-trohan2000@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes coding style issues where lines ended with an opening
parenthesis. These expressions were reformatted so that opening
parentheses remain on the same line as the statement, with proper
alignment of continued arguments.

This is a coding style cleanup only. No functional changes.

Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 250 +++++++++++-------------
 1 file changed, 109 insertions(+), 141 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 0908f2234f67..93ab0015ca89 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -480,14 +480,13 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 		/* check if sta supports rx ampdu */
 		phtpriv_sta->ampdu_enable = phtpriv_ap->ampdu_enable;
 
-		phtpriv_sta->rx_ampdu_min_spacing = (
-			phtpriv_sta->ht_cap.ampdu_params_info & IEEE80211_HT_CAP_AMPDU_DENSITY
-		) >> 2;
+		phtpriv_sta->rx_ampdu_min_spacing =
+		(phtpriv_sta->ht_cap.ampdu_params_info &
+		 IEEE80211_HT_CAP_AMPDU_DENSITY) >> 2;
 
 		/*  bwmode */
-		if ((
-			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
-		) & cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH))
+		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info) &
+			cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH))
 			psta->bw_mode = CHANNEL_WIDTH_40;
 		else
 			psta->bw_mode = CHANNEL_WIDTH_20;
@@ -498,15 +497,13 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 		phtpriv_sta->ch_offset = pmlmeext->cur_ch_offset;
 
 		/* check if sta support s Short GI 20M */
-		if ((
-			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
-		) & cpu_to_le16(IEEE80211_HT_CAP_SGI_20))
+		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info) &
+		cpu_to_le16(IEEE80211_HT_CAP_SGI_20))
 			phtpriv_sta->sgi_20m = true;
 
 		/* check if sta support s Short GI 40M */
-		if ((
-			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
-		) & cpu_to_le16(IEEE80211_HT_CAP_SGI_40)) {
+		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info) &
+		cpu_to_le16(IEEE80211_HT_CAP_SGI_40)) {
 			if (psta->bw_mode == CHANNEL_WIDTH_40) /* according to psta->bw_mode */
 				phtpriv_sta->sgi_40m = true;
 			else
@@ -625,8 +622,7 @@ static void update_hw_ht_param(struct adapter *padapter)
 	/*  */
 	/*  Config SM Power Save setting */
 	/*  */
-	pmlmeinfo->SM_PS = (le16_to_cpu(
-		pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
+	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
 	) & 0x0C) >> 2;
 
 	/*  */
@@ -705,8 +701,7 @@ void start_bss_network(struct adapter *padapter)
 	rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_BK, (u8 *)(&acparm));
 
 	/* Set Security */
-	val8 = (
-		psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X
+	val8 = (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X
 	) ? 0xcc : 0xcf;
 	rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
 
@@ -782,9 +777,8 @@ void start_bss_network(struct adapter *padapter)
 	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, pnetwork->supported_rates);
 
 	/* update capability after cur_wireless_mode updated */
-	update_capinfo(
-		padapter,
-		rtw_get_capability((struct wlan_bssid_ex *)pnetwork)
+	update_capinfo(padapter,
+		       rtw_get_capability((struct wlan_bssid_ex *)pnetwork)
 	);
 
 	if (pmlmeext->bstart_bss) {
@@ -851,11 +845,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	cap = get_unaligned_le16(ie);
 
 	/* SSID */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_SSID,
-		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_SSID,
+		       &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
 		memset(&pbss_network->ssid, 0, sizeof(struct ndis_802_11_ssid));
@@ -866,10 +859,9 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/* channel */
 	channel = 0;
 	pbss_network->configuration.length = 0;
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_DS_PARAMS, &ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_DS_PARAMS, &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
 		channel = *(p + 2);
@@ -878,11 +870,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
 	/*  get supported rates */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_SUPP_RATES,
-		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_SUPP_RATES,
+		       &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p) {
 		memcpy(supportRate, p + 2, ie_len);
@@ -890,11 +881,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	}
 
 	/* get ext_supported rates */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_EXT_SUPP_RATES,
-		&ie_len,
-		pbss_network->ie_length - _BEACON_IE_OFFSET_
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_EXT_SUPP_RATES,
+		       &ie_len,
+		       pbss_network->ie_length - _BEACON_IE_OFFSET_
 	);
 	if (p) {
 		memcpy(supportRate + supportRateNum, p + 2, ie_len);
@@ -906,11 +896,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	rtw_set_supported_rate(pbss_network->supported_rates, network_type);
 
 	/* parsing ERP_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_ERP_INFO,
-		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_ERP_INFO,
+		       &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
 		ERP_IE_handler(padapter, (struct ndis_80211_var_ie *)p);
@@ -927,19 +916,17 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	group_cipher = 0; pairwise_cipher = 0;
 	psecuritypriv->wpa2_group_cipher = _NO_PRIVACY_;
 	psecuritypriv->wpa2_pairwise_cipher = _NO_PRIVACY_;
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_RSN,
-		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_RSN,
+		       &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
-		if (rtw_parse_wpa2_ie(
-			p,
-			ie_len + 2,
-			&group_cipher,
-			&pairwise_cipher,
-			NULL
+		if (rtw_parse_wpa2_ie(p,
+				      ie_len + 2,
+				      &group_cipher,
+				      &pairwise_cipher,
+				      NULL
 		) == _SUCCESS) {
 			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 
@@ -957,19 +944,17 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	psecuritypriv->wpa_group_cipher = _NO_PRIVACY_;
 	psecuritypriv->wpa_pairwise_cipher = _NO_PRIVACY_;
 	for (p = ie + _BEACON_IE_OFFSET_; ; p += (ie_len + 2)) {
-		p = rtw_get_ie(
-			p,
-			WLAN_EID_VENDOR_SPECIFIC,
-			&ie_len,
-			(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
+		p = rtw_get_ie(p,
+			       WLAN_EID_VENDOR_SPECIFIC,
+			       &ie_len,
+			       (pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
 		);
 		if ((p) && (!memcmp(p + 2, OUI1, 4))) {
-			if (rtw_parse_wpa_ie(
-				p,
-				ie_len + 2,
-				&group_cipher,
-				&pairwise_cipher,
-				NULL
+			if (rtw_parse_wpa_ie(p,
+					     ie_len + 2,
+					     &group_cipher,
+					     &pairwise_cipher,
+					     NULL
 			) == _SUCCESS) {
 				psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 
@@ -993,11 +978,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	pmlmepriv->qospriv.qos_option = 0;
 	if (pregistrypriv->wmm_enable) {
 		for (p = ie + _BEACON_IE_OFFSET_; ; p += (ie_len + 2)) {
-			p = rtw_get_ie(
-				p,
-				WLAN_EID_VENDOR_SPECIFIC,
-				&ie_len,
-				(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
+			p = rtw_get_ie(p,
+				       WLAN_EID_VENDOR_SPECIFIC,
+				       &ie_len,
+				       (pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
 			);
 			if ((p) && !memcmp(p + 2, WMM_PARA_IE, 6)) {
 				pmlmepriv->qospriv.qos_option = 1;
@@ -1020,11 +1004,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	}
 
 	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_HT_CAPABILITY,
-		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_HT_CAPABILITY,
+		       &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0) {
 		u8 max_rx_ampdu_factor = 0;
@@ -1052,8 +1035,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		if (!TEST_FLAG(pmlmepriv->htpriv.stbc_cap, STBC_HT_ENABLE_RX))
 			pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_RX_STBC_3R));
 
-		pht_cap->ampdu_params_info &= ~(
-			IEEE80211_HT_CAP_AMPDU_FACTOR | IEEE80211_HT_CAP_AMPDU_DENSITY
+		pht_cap->ampdu_params_info &= ~(IEEE80211_HT_CAP_AMPDU_FACTOR |
+						IEEE80211_HT_CAP_AMPDU_DENSITY
 		);
 
 		if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
@@ -1065,13 +1048,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 						       0x00);
 		}
 
-		rtw_hal_get_def_var(
-			padapter,
-			HW_VAR_MAX_RX_AMPDU_FACTOR,
-			&max_rx_ampdu_factor
+		rtw_hal_get_def_var(padapter,
+				    HW_VAR_MAX_RX_AMPDU_FACTOR,
+				    &max_rx_ampdu_factor
 		);
-		pht_cap->ampdu_params_info |= (
-			IEEE80211_HT_CAP_AMPDU_FACTOR & max_rx_ampdu_factor
+		pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_FACTOR &
+					       max_rx_ampdu_factor
 		); /* set  Max Rx AMPDU size  to 64K */
 
 		pht_cap->mcs.rx_mask[0] = 0xff;
@@ -1081,11 +1063,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	}
 
 	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_HT_OPERATION,
-		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_HT_OPERATION,
+		       &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
 		pHT_info_ie = p;
@@ -1128,8 +1109,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		HT_info_handler(padapter, (struct ndis_80211_var_ie *)pHT_info_ie);
 	}
 
-	pbss_network->length = get_wlan_bssid_ex_sz(
-		(struct wlan_bssid_ex  *)pbss_network
+	pbss_network->length = get_wlan_bssid_ex_sz((struct wlan_bssid_ex  *)pbss_network
 	);
 
 	/* issue beacon to start bss network */
@@ -1237,9 +1217,8 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	list_for_each_safe(plist, tmp, phead) {
 		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
-		if (
-			!memcmp(paclnode->addr, addr, ETH_ALEN) ||
-			is_broadcast_ether_addr(addr)
+		if (!memcmp(paclnode->addr, addr, ETH_ALEN) ||
+		    is_broadcast_ether_addr(addr)
 		) {
 			if (paclnode->valid) {
 				paclnode->valid = false;
@@ -1290,12 +1269,11 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
 	return res;
 }
 
-static int rtw_ap_set_key(
-	struct adapter *padapter,
-	u8 *key,
-	u8 alg,
-	int keyid,
-	u8 set_tx
+static int rtw_ap_set_key(struct adapter *padapter,
+			  u8 *key,
+			  u8 alg,
+			  int keyid,
+			  u8 set_tx
 )
 {
 	u8 keylen;
@@ -1360,12 +1338,11 @@ int rtw_ap_set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
 	return rtw_ap_set_key(padapter, key, alg, keyid, 1);
 }
 
-int rtw_ap_set_wep_key(
-	struct adapter *padapter,
-	u8 *key,
-	u8 keylen,
-	int keyid,
-	u8 set_tx
+int rtw_ap_set_wep_key(struct adapter *padapter,
+		       u8 *key,
+		       u8 keylen,
+		       int keyid,
+		       u8 set_tx
 )
 {
 	u8 alg;
@@ -1401,11 +1378,10 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 		return;
 
 	/* parsing ERP_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_ERP_INFO,
-		&len,
-		(pnetwork->ie_length - _BEACON_IE_OFFSET_)
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_ERP_INFO,
+		       &len,
+		       (pnetwork->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p && len > 0) {
 		struct ndis_80211_var_ie *pIE = (struct ndis_80211_var_ie *)p;
@@ -1413,9 +1389,8 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 		if (pmlmepriv->num_sta_non_erp == 1)
 			pIE->data[0] |= RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION;
 		else
-			pIE->data[0] &= ~(
-				RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION
-			);
+			pIE->data[0] &= ~(RTW_ERP_INFO_NON_ERP_PRESENT |
+			RTW_ERP_INFO_USE_PROTECTION);
 
 		if (pmlmepriv->num_sta_no_short_preamble > 0)
 			pIE->data[0] |= RTW_ERP_INFO_BARKER_PREAMBLE_MODE;
@@ -1461,11 +1436,10 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	unsigned char *ie = pnetwork->ies;
 	u32 ielen = pnetwork->ie_length;
 
-	pwps_ie = rtw_get_wps_ie(
-		ie + _FIXED_IE_LENGTH_,
-		ielen - _FIXED_IE_LENGTH_,
-		NULL,
-		&wps_ielen
+	pwps_ie = rtw_get_wps_ie(ie + _FIXED_IE_LENGTH_,
+				 ielen - _FIXED_IE_LENGTH_,
+				 NULL,
+				 &wps_ielen
 	);
 
 	if (!pwps_ie || wps_ielen == 0)
@@ -1651,8 +1625,7 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	if (pmlmepriv->num_sta_no_ht ||
 	    (pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT))
 		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED;
-	else if (
-		(le16_to_cpu(phtpriv_ap->ht_cap.cap_info) & IEEE80211_HT_CAP_SUP_WIDTH)
+	else if ((le16_to_cpu(phtpriv_ap->ht_cap.cap_info) & IEEE80211_HT_CAP_SUP_WIDTH)
 		&& pmlmepriv->num_sta_ht_20mhz)
 		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_20MHZ;
 	else if (pmlmepriv->olbc_ht)
@@ -1874,11 +1847,10 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 	return beacon_updated;
 }
 
-u8 ap_free_sta(
-	struct adapter *padapter,
-	struct sta_info *psta,
-	bool active,
-	u16 reason
+u8 ap_free_sta(struct adapter *padapter,
+	       struct sta_info *psta,
+	       bool active,
+	       u16 reason
 )
 {
 	u8 beacon_updated = false;
@@ -2007,11 +1979,10 @@ void rtw_ap_restore_network(struct adapter *padapter)
 
 	rtw_setopmode_cmd(padapter, Ndis802_11APMode, false);
 
-	set_channel_bwmode(
-		padapter,
-		pmlmeext->cur_channel,
-		pmlmeext->cur_ch_offset,
-		pmlmeext->cur_bwmode
+	set_channel_bwmode(padapter,
+			   pmlmeext->cur_channel,
+			   pmlmeext->cur_ch_offset,
+			   pmlmeext->cur_bwmode
 	);
 
 	start_bss_network(padapter);
@@ -2019,12 +1990,11 @@ void rtw_ap_restore_network(struct adapter *padapter)
 	if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
 	    (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
 		/* restore group key, WEP keys is restored in ips_leave() */
-		rtw_set_key(
-			padapter,
-			psecuritypriv,
-			psecuritypriv->dot118021XGrpKeyid,
-			0,
-			false
+		rtw_set_key(padapter,
+			    psecuritypriv,
+			    psecuritypriv->dot118021XGrpKeyid,
+			    0,
+			    false
 		);
 	}
 
@@ -2126,11 +2096,9 @@ void stop_ap_mode(struct adapter *padapter)
 	pmlmeext->bstart_bss = false;
 
 	/* reset and init security priv , this can refine with rtw_reset_securitypriv */
-	memset(
-		(unsigned char *)&padapter->securitypriv,
-		0,
-		sizeof(struct security_priv)
-	);
+	memset((unsigned char *)&padapter->securitypriv,
+	       0,
+	       sizeof(struct security_priv));
 	padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 	padapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
 
-- 
2.50.1


