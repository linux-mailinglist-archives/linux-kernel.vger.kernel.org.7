Return-Path: <linux-kernel+bounces-842355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF19BB991E
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF6C3A412A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2553A18FDAF;
	Sun,  5 Oct 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ/IvGOn"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CC6A932
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759680017; cv=none; b=qrPfUuc/pl5vX/7UPjtGcGy9Ap3nGKu8cIduiWl27qgUl/WBJ2b3YMmelPknwUfMVrtXHSHRDzLE6oEK0IkdragWHl120w0FioirWHg3PM9+TsFze1l4dI/Bpbb1By5OIVo0SpgA1YNLwxvY0yMO88ZhwSihjtgQ5pdUUaMco8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759680017; c=relaxed/simple;
	bh=jVMu9c292Hlq3WKkOluTSygkvdfsT7ffY/+9CFLNX5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H092SfkWtnT+EfzriWXVmdJHEzYbVXDPDuD8t9GOkjfBAOmJeNua+K2y914K11l9VLRoltg0EZ9xD3L6qckcFQWGk98Qo/sGPFiLEfYjgJAytfNZl7jDN/e5VxIfpuBZi6uh3QbFB3kxfZWo7cER7+ODsdv3QZj6VHF/qZWW9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ/IvGOn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781010ff051so2830292b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759680014; x=1760284814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYHAIPzF8CpJ3RmQvVDEKQE90qk0XGRDf5ftiM2IYd4=;
        b=jQ/IvGOnyYsu+bEqk85RIoygjYe2KxfRJqMBcFmXEXpf2KL9SMwywblgFXQ3XtucZB
         3VJq/NL+beuK0/To66g9M82WJa9SMkXqXPV9bL026dfoCE8+Wspkpd/T5GTYr1maxSgJ
         UU6mOCYEs89gJqc+Pucatf8wwtDMkhv+Raji7HnUUrc2urLqbygFrJtQbP+10Qeid0Tb
         8aaDqnVsYxL2aakCjlKKVu77cRnWeyiJLw0jmA03/Ml7hDPAppUbVKhbZHRsT6oEpkgj
         wqfy4fNTKCEd80WWPZtK2nge47/lBNP+o6yp7Kh1CDoMeF0ht7K55Sj0jZMdaD23Sn6W
         YT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759680014; x=1760284814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYHAIPzF8CpJ3RmQvVDEKQE90qk0XGRDf5ftiM2IYd4=;
        b=szGcFduU0d3lHwAjLR3IW3hccR8nZn9gil8J10nNjj3cT7X2MGID4kJY+4YcvWQvQg
         IiR/iGvJpkoPT9NZ3NS6bJSPI9rKiTFTXh41TkZGjzmdlN6tu1m1rUUrUdMwLNH/TYFG
         2tLPgz+HEzhaJWYxuIlrPg4UhTbtG9IQV18n20EaLGfjO2I4D38+iC/7RYGdMHu8Mw/a
         /PBtoABo3MkzC7MEQbaViWPIU8VWsPjtUmq/ECIGslHBiLwMuBL1m8YlY0y3P69g5x/6
         i5RIGCVURMDD5OohRmshFlNBOfx6QwbsAVI4otzNiGFHmKZd2EDpQId341hr3LGzYma+
         +Otg==
X-Forwarded-Encrypted: i=1; AJvYcCWiBxIGpLagrD4pNt7ZIpmM7roH7+rLbexT6pfZwvpE1arYRmu/nSOGfoQ16nsjM8B41R7hLm0ivHWWDW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLWFTavJC8+FeYKULmvQD9DsQUn1UaHEl63SlgSLTVVAG64wg
	lUw0ZMrfcQ+xOn4SrjfkVfyUJh4RGfRpQXFFWgvXVe6WpAC6eMBGUicupFAxP8nIKPU=
X-Gm-Gg: ASbGncvqRwnqB0EreFMCo8JXAwJ6T39efuF5QXG6SZ+k3FOAYDPoyxz/KOZ7aP/ptrV
	nbEM4Sez9Fo+drFvEuke4cO5gJ0VbkHTAOtF3iJQmEaktQsawRUo45OaQxXTy3mwfA7HxjU377I
	WezLqm+MviCsDrmCPEq1SfxQROVPO6KL3XQZrCAcZgd30+tn649Hh/50YFcfRWqiS7/cGzPAXv3
	v6/RtcEZjobvRkQSDDO+C5GTxA5CzPHFG///weOHABpVscFUWN/SifzrxMKNqB0xIloSbwAmqhK
	1NKoXJhSONi/UbufWde/wHv7mZbMA9uGZB9VP2SNvbPb1guApbRSSLshbdGLX670BlFa2Ze/aw1
	C6djPHT7Lc2jbZltqVtj9zBAh5bAL6pg1zBNlf6tmCH0VxgYGgigHE80vsXkh
X-Google-Smtp-Source: AGHT+IGm8cGb21Zm31Pr9f5utsf6rU+oP5Tg78OqfknnSaU7DyLc7Fw7io8veZpCdTx0zaHqbaiNzA==
X-Received: by 2002:a05:6a00:9295:b0:780:f758:4133 with SMTP id d2e1a72fcca58-78c98a66d3cmr9520921b3a.10.1759680012392;
        Sun, 05 Oct 2025 09:00:12 -0700 (PDT)
Received: from Deathstar.anonymous ([172.56.42.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb3d95sm10145241b3a.32.2025.10.05.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 09:00:10 -0700 (PDT)
From: Rohan Tripathi <trohan2000@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rohan Tripathi <trohan2000@gmail.com>
Subject: [PATCH] staging: rtl8723bs: clean up style in rtw_ap.c
Date: Sun,  5 Oct 2025 11:59:17 -0400
Message-ID: <20251005155920.381334-2-trohan2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251005155920.381334-1-trohan2000@gmail.com>
References: <20251005155920.381334-1-trohan2000@gmail.com>
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
2.50.1


