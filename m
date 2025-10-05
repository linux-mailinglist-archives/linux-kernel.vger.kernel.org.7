Return-Path: <linux-kernel+bounces-842315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDE7BB97C7
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 15:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB918945D9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CB4288C30;
	Sun,  5 Oct 2025 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuqUha7N"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB00288530
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759672551; cv=none; b=GsiKffrUdm/zTwHpRHG/ow7o2BMkKuLWW0Q1uz00dFGFwUoUxpy6Lzqi4kQF4nZDuoJCO7Hy8+0RpZtdJMt2pWSSU5Z346q8MlefmstO41CdvC8o69rtmigioQNCnAmycELkdtkvhqIl8XELKU4LRnHv98bWV6z/cEx2dMztTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759672551; c=relaxed/simple;
	bh=egWQSM/CX6+iJi1x7nrjotH7wfe7pjWEeBRKidT+mqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baXNp89uC9zzbCe/s33clgxyNjza/sT8aBTKeGiQVPQQmhbo4cNek89sNQ4wKWQ/vhZYdYxNHLv2BggNnbRoQhB+FbmbcZCgVu1TMkwxTzdrJMDYjZWDpn1reow3ewn9AX4YV08hrwWS0s6/9vmtVnrXZbXgf1xSQ+eq/JUP3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuqUha7N; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so3321426b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759672548; x=1760277348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3nMlG2DUeGl6EJBKUMgcBcIThdWpePWUoIsQHblRkY=;
        b=QuqUha7NuhE6x91sfyxfToKZfKfSc5nW6Zrk3hezb6+rY9zyGKgzEVCWnUB3qYSZQm
         QPxSw/hKtzVMPglIlEvPTQsdXgoIn74LPg/HdxHtJg211grJPG7JBByxHHjJNdN8Wdmd
         +H7Y6GiDNsyppncy9s1R8g+QRpSBcJRKSnvIFJG7e4CzC7hfa8EJy3dUXhvuewvNqo5V
         nFchgBbgTu1dK22Ejj/t8DHjssTr0ynlSUhss9I1yDu0H0/NGUafYhVTQXRaIk7d7jHt
         9sWX83AZE/7yQIi1UPowhGOEAW0tM8e/HJ3FKVQE0m3r8PJisbGs+gX81nRL5/ay/Opn
         gSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759672548; x=1760277348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3nMlG2DUeGl6EJBKUMgcBcIThdWpePWUoIsQHblRkY=;
        b=Kk03Wq7jjQ1ioSr0aB8c7qXqc3WnA8sxp27xh47ws056t9Z/QzSCpo+y4spdpfCp4j
         Da/lTry3LISxcX5N9yPtOmWSHT/8UACbfcVcMwu3gjdxZo6PS9WhLvmAqUlo8RiF43Ho
         wA2ZDMxp/E90YD/us9+Tpio8UU3BH6JZDH9LMR4YfFN9RoyKjbtiuJYr4wtUMJf6Exaq
         ++1GRr+wyb3gyDteh7FIJkngytbhPvYIMJhIfptz2zZrT84m5wS+dc7unSAMLoVcDuFx
         Lr3T0jmlzHnaqUwdQP9T/UrhBErA4hTlbwEqVMGGYPZeuoEQ7/7/LUHgB+SvqxbQ2yKk
         4cJA==
X-Forwarded-Encrypted: i=1; AJvYcCUwC4IODaQvDorYYZO4RlF+G5pOJp/cV/7SLdw+c1mWjGL9gXMxjxZWGhZvfI06H7sfdkLwlXYpo6sd21w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcp9iizKhR4YcSTQlOE9o/1XYA94bQvB59UX7BmLZh5ZoCOAYt
	3CRXZpQ1tyhAcJmUpYHFSYgRDdc7tuDYxp2kDPBsmyaSZRnu2hRuhp9X
X-Gm-Gg: ASbGnctTEawgokmY2Dp1KA4L2XE2UNeIvPG4VTMEIP9L4Ni+ci9zTvbF3B3SrEKMl+A
	aVV+u5jk/86jd3OFr3n+o4kTWS+mUEXZZ/7HLg2JDSPmlqTQpQ0r0Ci3iWAD7IkHSGbgeYDGaFS
	87SiezSFKLdE6noD8FlqyP+Rr5kFM38Tasb4DJuI02W+QVS3ZOVQZ1RngklZRaG8qPhijT66wte
	Ny0gmHGnoQxE/VhobSoZbbltQAPSO3AtxH0GpzzQeqyG8CjuTdqqbOxj85ZBDXB945JvWC/SErj
	oZ4AFIxAVdIAmH58BxBa1r2d1d1Of0gxakYgg61R6zj7T+zY0ecOvbqltyhVLk9LTcyD7gYKvhn
	BUdRhOw4mtujfhRPpiVweZvmKbxBzqQoq5JUVz/1O4SLEfROxKAJ9jYzyFHk1l0O5b+cxRbA=
X-Google-Smtp-Source: AGHT+IFZwmVkFxWrcD3vFhWA7tYrdggKjAA5fO6kyTk0lgcxG7ZZ2p/E/k+2hko3twqqb9zVYTwrFA==
X-Received: by 2002:a05:6a20:2587:b0:249:ba7b:e361 with SMTP id adf61e73a8af0-32b620e88dcmr13479527637.49.1759672548147;
        Sun, 05 Oct 2025 06:55:48 -0700 (PDT)
Received: from Deathstar.anonymous ([172.56.42.228])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a0d501sm7959659a91.6.2025.10.05.06.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 06:55:47 -0700 (PDT)
From: Rohan Tripathi <trohan2000@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rohan Tripathi <trohan2000@gmail.com>
Subject: [PATCH] staging: rtl8723bs: clean up style in rtw_ap.c
Date: Sun,  5 Oct 2025 09:55:25 -0400
Message-ID: <20251005135525.314476-1-trohan2000@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes several coding style issues reported by checkpatch.pl
in rtw_ap.c. Changes include:
- Removed cases where lines ended with an opening parenthesis
- Broke long comments exceeding 100 characters
- Fixed alignment in multi-line function calls

These are coding style cleanups only. No functional changes.

Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 270 +++++++++++-------------
 1 file changed, 123 insertions(+), 147 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 0908f2234f67..9aa225bcf9d6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -391,7 +391,9 @@ void update_bmc_sta(struct adapter *padapter)
 
 		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
 
-		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
+		/* psta->dot118021XPrivacy = _NO_PRIVACY_;
+		 * remove it, because it has been set before this.
+		 */
 
 		/* prepare for add_RATid */
 		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
@@ -436,7 +438,6 @@ void update_bmc_sta(struct adapter *padapter)
 		spin_lock_bh(&psta->lock);
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
-
 	}
 }
 
@@ -480,14 +481,13 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 		/* check if sta supports rx ampdu */
 		phtpriv_sta->ampdu_enable = phtpriv_ap->ampdu_enable;
 
-		phtpriv_sta->rx_ampdu_min_spacing = (
-			phtpriv_sta->ht_cap.ampdu_params_info & IEEE80211_HT_CAP_AMPDU_DENSITY
+		phtpriv_sta->rx_ampdu_min_spacing = (phtpriv_sta->ht_cap.ampdu_params_info &
+		IEEE80211_HT_CAP_AMPDU_DENSITY
 		) >> 2;
 
 		/*  bwmode */
-		if ((
-			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
-		) & cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH))
+		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info) &
+			cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH))
 			psta->bw_mode = CHANNEL_WIDTH_40;
 		else
 			psta->bw_mode = CHANNEL_WIDTH_20;
@@ -498,15 +498,13 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
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
@@ -625,8 +623,7 @@ static void update_hw_ht_param(struct adapter *padapter)
 	/*  */
 	/*  Config SM Power Save setting */
 	/*  */
-	pmlmeinfo->SM_PS = (le16_to_cpu(
-		pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
+	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
 	) & 0x0C) >> 2;
 
 	/*  */
@@ -659,7 +656,10 @@ void start_bss_network(struct adapter *padapter)
 	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
 	/* check if there is wps ie, */
-	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
+	/* if there is wpsie in beacon,
+	 *the hostapd will update beacon
+	 *twice when stating hostapd,
+	 */
 	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
 	if (!rtw_get_wps_ie(pnetwork->ies + _FIXED_IE_LENGTH_,
 			    pnetwork->ie_length - _FIXED_IE_LENGTH_, NULL, NULL))
@@ -705,8 +705,7 @@ void start_bss_network(struct adapter *padapter)
 	rtw_hal_set_hwreg(padapter, HW_VAR_AC_PARAM_BK, (u8 *)(&acparm));
 
 	/* Set Security */
-	val8 = (
-		psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X
+	val8 = (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X
 	) ? 0xcc : 0xcf;
 	rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
 
@@ -782,9 +781,8 @@ void start_bss_network(struct adapter *padapter)
 	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, pnetwork->supported_rates);
 
 	/* update capability after cur_wireless_mode updated */
-	update_capinfo(
-		padapter,
-		rtw_get_capability((struct wlan_bssid_ex *)pnetwork)
+	update_capinfo(padapter,
+		       rtw_get_capability((struct wlan_bssid_ex *)pnetwork)
 	);
 
 	if (pmlmeext->bstart_bss) {
@@ -841,7 +839,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	memcpy(pbss_network->mac_address, myid(&padapter->eeprompriv), ETH_ALEN);
 
 	/* beacon interval */
-	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
+	p = rtw_get_beacon_interval_from_ie(ie);
+	/* ie + 8;
+	 * 8: TimeStamp, 2: Beacon Interval 2:Capability
+	 */
 	/* pbss_network->configuration.beacon_period = le16_to_cpu(*(unsigned short*)p); */
 	pbss_network->configuration.beacon_period = get_unaligned_le16(p);
 
@@ -851,11 +852,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
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
@@ -866,10 +866,9 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
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
@@ -878,11 +877,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
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
@@ -890,11 +888,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
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
@@ -906,11 +903,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
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
@@ -927,19 +923,17 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
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
 
@@ -957,19 +951,17 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
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
 
@@ -993,11 +985,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
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
@@ -1020,11 +1011,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
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
@@ -1052,8 +1042,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		if (!TEST_FLAG(pmlmepriv->htpriv.stbc_cap, STBC_HT_ENABLE_RX))
 			pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_RX_STBC_3R));
 
-		pht_cap->ampdu_params_info &= ~(
-			IEEE80211_HT_CAP_AMPDU_FACTOR | IEEE80211_HT_CAP_AMPDU_DENSITY
+		pht_cap->ampdu_params_info &= ~(IEEE80211_HT_CAP_AMPDU_FACTOR |
+						IEEE80211_HT_CAP_AMPDU_DENSITY
 		);
 
 		if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
@@ -1065,13 +1055,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
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
@@ -1081,11 +1070,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
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
@@ -1128,8 +1116,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		HT_info_handler(padapter, (struct ndis_80211_var_ie *)pHT_info_ie);
 	}
 
-	pbss_network->length = get_wlan_bssid_ex_sz(
-		(struct wlan_bssid_ex  *)pbss_network
+	pbss_network->length = get_wlan_bssid_ex_sz((struct wlan_bssid_ex  *)pbss_network
 	);
 
 	/* issue beacon to start bss network */
@@ -1147,7 +1134,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/*  update AP's sta info */
 	update_ap_info(padapter, psta);
 
-	psta->state |= WIFI_AP_STATE;		/* Aries, add, fix bug of flush_cam_entry at STOP AP mode , 0724 */
+	psta->state |= WIFI_AP_STATE;
+	/* Aries, add, fix bug of flush_cam_entry at STOP AP mode , 0724 */
 	rtw_indicate_connect(padapter);
 
 	pmlmepriv->cur_network.join_res = true;/* for check if already set beacon */
@@ -1237,9 +1225,8 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
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
@@ -1252,7 +1239,6 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	}
 
 	spin_unlock_bh(&pacl_node_q->lock);
-
 }
 
 u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
@@ -1290,12 +1276,11 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
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
@@ -1360,12 +1345,11 @@ int rtw_ap_set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
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
@@ -1401,11 +1385,10 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
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
@@ -1413,9 +1396,8 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
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
@@ -1461,11 +1443,10 @@ static void update_bcn_wps_ie(struct adapter *padapter)
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
@@ -1490,7 +1471,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	wps_ielen = (uint)pwps_ie_src[1];/* to get ie data len */
 	if ((wps_offset + wps_ielen + 2 + remainder_ielen) <= MAX_IE_SZ) {
 		memcpy(pwps_ie, pwps_ie_src, wps_ielen + 2);
-		pwps_ie += (wps_ielen+2);
+		pwps_ie += (wps_ielen + 2);
 
 		if (pbackup_remainder_ie)
 			memcpy(pwps_ie, pbackup_remainder_ie, remainder_ielen);
@@ -1651,8 +1632,7 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	if (pmlmepriv->num_sta_no_ht ||
 	    (pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT))
 		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED;
-	else if (
-		(le16_to_cpu(phtpriv_ap->ht_cap.cap_info) & IEEE80211_HT_CAP_SUP_WIDTH)
+	else if ((le16_to_cpu(phtpriv_ap->ht_cap.cap_info) & IEEE80211_HT_CAP_SUP_WIDTH)
 		&& pmlmepriv->num_sta_ht_20mhz)
 		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_20MHZ;
 	else if (pmlmepriv->olbc_ht)
@@ -1874,11 +1854,10 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
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
@@ -1993,6 +1972,7 @@ void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta)
 		add_RATid(padapter, psta, 0);/* DM_RATR_STA_INIT */
 	}
 }
+
 /* restore hw setting from sw data structures */
 void rtw_ap_restore_network(struct adapter *padapter)
 {
@@ -2007,11 +1987,10 @@ void rtw_ap_restore_network(struct adapter *padapter)
 
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
@@ -2019,12 +1998,11 @@ void rtw_ap_restore_network(struct adapter *padapter)
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
 
@@ -2126,11 +2104,9 @@ void stop_ap_mode(struct adapter *padapter)
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
2.47.2


