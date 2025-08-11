Return-Path: <linux-kernel+bounces-761852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C09B1FF4D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49263B5423
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478C62D5C9F;
	Mon, 11 Aug 2025 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QInJRvrv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDFD2D29D5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893379; cv=none; b=lfKeQbeDr2MIZ4hkbbB1Aet9WALgH3Kq+OOedy/2rW6PaT11arYlcERwqt9iqlBdJG2uGOy8qxHuXTeDptrQIbqPg91F+EqxCRDFw5xuIeKtdWLI1uMHsL6uOkN5V5ZXqESDPj8KVQG3TTDHL4OQEzFhYMeUjVSE+6Ix54pvbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893379; c=relaxed/simple;
	bh=d2H9r5zq+s0Ic0TCptkRmZvTv/WYT5dvaiQGBvWG8Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XytI/bPYL624gY0hKpysUj76PP7rP9VLq2ERIr6APyQOta85pkt9DqvzADjaMLj0iq+YP6+CdsSeZov9DygGrkkYZjq2nJLuivHX8LVxgPx8WLmMguqG9X5Jwi1dexBvZniM1cemFl/juQHoW1z3yD7KqyC7I4VHGBu0/QeuO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QInJRvrv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7682560a2f2so3965562b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754893377; x=1755498177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NVF2rwVo6fz1lJ6PduOgKjlSqR/R+lFxyEfc5whr/Y=;
        b=QInJRvrvs6OVwX/8g4Rdb9qSHrsT4uqY5qqd9CGo5r4nTBAYDWZXvC3Vh/vcweWokx
         2e5F1JpCqyhOvKnqYg2wYXC3KvuAiYCjxHbjBx4YFz4VNaDXfrcZzByibhQe1bKq/GXq
         Ih4Auw5GuJT4mYwP/OsFu8YRkIbNy58/WbdSI4pw1depUgnpPL7YyYqMBlx0aSTD3ySN
         A1hUsSETKBsPzJWRdHYmjmU/I9P3BKzISWFN7KTYK41YDp1qETaGlz0E5s4biPiEQ4Fh
         b9YmhIhM7CS4smqoah1vs1dldh2aNofxXm1U6K2412S4QGU81lHLyFhon0i0Kx6aVbkv
         6lJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754893377; x=1755498177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NVF2rwVo6fz1lJ6PduOgKjlSqR/R+lFxyEfc5whr/Y=;
        b=woAlCtXEkpk/kD/7ampc5zPbTRsdvlIG07zXLqGo8dz39/goEJMKlfyrDZhNQD3DG9
         cEHQDE4cqM76Xszno3gqV2BwVXty8wswMlA3cNrUMWKVuHPkoOUwhYNv8xgHXt9xIAuA
         i6vFxyBSJqY4857X7mppPGMew3lvxQ7oniyDpLh/nQ3OOEh7r6WTtmsq3plM9ug6MVqj
         nQv1DVIJz+KcQfI/7z2YPZspH/iDKMHYQUblWMlT/L7nEulNQSdrVrZHZr2r68N9GsVP
         cgyk/UoNse4kAekN0WMPLxltUgcKSe2b9HToI/om1+GbYQHBVOZPwunVzuJZxtlu2vBR
         KlGA==
X-Forwarded-Encrypted: i=1; AJvYcCXyS/lA7hdOmqpA91ELnp7/XtJ74cGyPsCi3tN+pyqLFu+PjG1EDwf9lI0hv1dKhso+LuR1gC5YBlFSZCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBXPp3Zdw41sLfpz7TpVsYtkZNqM+Oh2msoIX7vT7xAhWYRs9s
	jcYYt4xAHjydoYaFKtOBl1yrBCSd2qLaXoQcf4kbbDelSZU3wvr0JMEF
X-Gm-Gg: ASbGncsrS66gif+10hLWSv5Gr9ZUso3EUD62ukgwoeiibL8JZfCWFOACqsjubdG+25K
	Suzn50D8WYGdV5t6qw24dJhuK/405OVv0l9hz5A9s8Kr3pQgtEXErT+s28LVfdFSt2SDm8f7rY3
	zqs1IK2Zkd4cF9ZaB5winaAggJQ5VnDQFzO6pD3qaW/AmgaExkMMzOaTjGDg5/GiAFGfgRoLX3e
	vaDIt3VFeOszUzOPZ4SnqJH4K2obHL9YsLJhNRn+huOTA6uaVs/dfIuOBO5kkEsXwO0WxBo7ety
	CaWSwJt8oo+nmF12DsQYSFk5Uwh1wGEwKgMXzT0cyOXsY2dAriDqI46p803LjdnTqC9OAlS0gj2
	57sljvjT033w8NJpdcbWFCC760BxSMD3yKNCB4gRsSEqBiXSIQjg9PLoHA+sD9pgiHY0Bt04TfP
	93kQylMJfvwWmJ85yTUfxrfcLRSwRDBzhLB6do0xDB
X-Google-Smtp-Source: AGHT+IGLiDyky8i20Qh3XdHK3mXXV0ZaIrsmeC+zxfgQLwZg5pneQ8ZBZHhOkqSJB3CWCsliLWMUqQ==
X-Received: by 2002:a05:6a00:27a2:b0:76b:c68e:1001 with SMTP id d2e1a72fcca58-76c3729b600mr23444625b3a.5.1754893376578;
        Sun, 10 Aug 2025 23:22:56 -0700 (PDT)
Received: from wen-HP-ProBook-445-14-inch-G9-Notebook-PC.. (36-239-105-221.dynamic-ip.hinet.net. [36.239.105.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm25861623b3a.42.2025.08.10.23.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:22:56 -0700 (PDT)
From: Yao-Wen Chang <changyaowen19980629@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yao-Wen Chang <changyaowen19980629@gmail.com>
Subject: [PATCH 04/11] staging: rtl8723bs: Fix the line end with ( issue
Date: Mon, 11 Aug 2025 14:21:27 +0800
Message-ID: <20250811062132.102525-4-changyaowen19980629@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811062132.102525-1-changyaowen19980629@gmail.com>
References: <20250811062132.102525-1-changyaowen19980629@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit corrects function calls where the opening parenthesis was
at the end of a line.

Signed-off-by: Yao-Wen Chang <changyaowen19980629@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 160 +++++++++---------------
 1 file changed, 56 insertions(+), 104 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index fae557a0d143..0bbbf62a7097 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -481,13 +481,11 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 		/* check if sta supports rx ampdu */
 		phtpriv_sta->ampdu_enable = phtpriv_ap->ampdu_enable;
 
-		phtpriv_sta->rx_ampdu_min_spacing = (
-			phtpriv_sta->ht_cap.ampdu_params_info & IEEE80211_HT_CAP_AMPDU_DENSITY
-		) >> 2;
+		phtpriv_sta->rx_ampdu_min_spacing = (phtpriv_sta->ht_cap.ampdu_params_info &
+						     IEEE80211_HT_CAP_AMPDU_DENSITY) >> 2;
 
 		/*  bwmode */
-		if ((
-			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
+		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
 		) & cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH))
 			psta->bw_mode = CHANNEL_WIDTH_40;
 		else
@@ -499,14 +497,12 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 		phtpriv_sta->ch_offset = pmlmeext->cur_ch_offset;
 
 		/* check if sta support s Short GI 20M */
-		if ((
-			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
+		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
 		) & cpu_to_le16(IEEE80211_HT_CAP_SGI_20))
 			phtpriv_sta->sgi_20m = true;
 
 		/* check if sta support s Short GI 40M */
-		if ((
-			phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
+		if ((phtpriv_sta->ht_cap.cap_info & phtpriv_ap->ht_cap.cap_info
 		) & cpu_to_le16(IEEE80211_HT_CAP_SGI_40)) {
 			if (psta->bw_mode == CHANNEL_WIDTH_40) /* according to psta->bw_mode */
 				phtpriv_sta->sgi_40m = true;
@@ -626,8 +622,7 @@ static void update_hw_ht_param(struct adapter *padapter)
 	/*  */
 	/*  Config SM Power Save setting */
 	/*  */
-	pmlmeinfo->SM_PS = (le16_to_cpu(
-		pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
+	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
 	) & 0x0C) >> 2;
 
 	/*  */
@@ -783,10 +778,7 @@ void start_bss_network(struct adapter *padapter)
 	rtw_hal_set_hwreg(padapter, HW_VAR_BASIC_RATE, pnetwork->supported_rates);
 
 	/* update capability after cur_wireless_mode updated */
-	update_capinfo(
-		padapter,
-		rtw_get_capability((struct wlan_bssid_ex *)pnetwork)
-	);
+	update_capinfo(padapter, rtw_get_capability((struct wlan_bssid_ex *)pnetwork));
 
 	if (pmlmeext->bstart_bss) {
 		update_beacon(padapter, WLAN_EID_TIM, NULL, true);
@@ -854,8 +846,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	cap = get_unaligned_le16(ie);
 
 	/* SSID */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_SSID,
 		&ie_len,
 		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
@@ -869,11 +860,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/* channel */
 	channel = 0;
 	pbss_network->configuration.length = 0;
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
-		WLAN_EID_DS_PARAMS, &ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
-	);
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
+		       WLAN_EID_DS_PARAMS,
+		       &ie_len,
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_));
 	if (p && ie_len > 0)
 		channel = *(p + 2);
 
@@ -881,24 +871,20 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
 	/*  get supported rates */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_SUPP_RATES,
 		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
-	);
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_));
 	if (p) {
 		memcpy(supportRate, p + 2, ie_len);
 		supportRateNum = ie_len;
 	}
 
 	/* get ext_supported rates */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_EXT_SUPP_RATES,
 		&ie_len,
-		pbss_network->ie_length - _BEACON_IE_OFFSET_
-	);
+		       pbss_network->ie_length - _BEACON_IE_OFFSET_);
 	if (p) {
 		memcpy(supportRate + supportRateNum, p + 2, ie_len);
 		supportRateNum += ie_len;
@@ -909,12 +895,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	rtw_set_supported_rate(pbss_network->supported_rates, network_type);
 
 	/* parsing ERP_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_ERP_INFO,
 		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
-	);
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_));
 	if (p && ie_len > 0)
 		ERP_IE_handler(padapter, (struct ndis_80211_var_ie *)p);
 
@@ -930,15 +914,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	group_cipher = 0; pairwise_cipher = 0;
 	psecuritypriv->wpa2_group_cipher = _NO_PRIVACY_;
 	psecuritypriv->wpa2_pairwise_cipher = _NO_PRIVACY_;
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_RSN,
 		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
-	);
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_));
 	if (p && ie_len > 0) {
-		if (rtw_parse_wpa2_ie(
-			p,
+		if (rtw_parse_wpa2_ie(p,
 			ie_len + 2,
 			&group_cipher,
 			&pairwise_cipher,
@@ -960,15 +941,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	psecuritypriv->wpa_group_cipher = _NO_PRIVACY_;
 	psecuritypriv->wpa_pairwise_cipher = _NO_PRIVACY_;
 	for (p = ie + _BEACON_IE_OFFSET_; ; p += (ie_len + 2)) {
-		p = rtw_get_ie(
-			p,
+		p = rtw_get_ie(p,
 			WLAN_EID_VENDOR_SPECIFIC,
 			&ie_len,
-			(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
-		);
+			       (pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2)));
 		if ((p) && (!memcmp(p + 2, OUI1, 4))) {
-			if (rtw_parse_wpa_ie(
-				p,
+			if (rtw_parse_wpa_ie(p,
 				ie_len + 2,
 				&group_cipher,
 				&pairwise_cipher,
@@ -996,8 +974,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	pmlmepriv->qospriv.qos_option = 0;
 	if (pregistrypriv->wmm_enable) {
 		for (p = ie + _BEACON_IE_OFFSET_; ; p += (ie_len + 2)) {
-			p = rtw_get_ie(
-				p,
+			p = rtw_get_ie(p,
 				WLAN_EID_VENDOR_SPECIFIC,
 				&ie_len,
 				(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
@@ -1023,12 +1000,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	}
 
 	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_HT_CAPABILITY,
 		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
-	);
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_));
 	if (p && ie_len > 0) {
 		u8 max_rx_ampdu_factor = 0;
 		struct ieee80211_ht_cap *pht_cap = (struct ieee80211_ht_cap *)(p + 2);
@@ -1055,9 +1030,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		if (!TEST_FLAG(pmlmepriv->htpriv.stbc_cap, STBC_HT_ENABLE_RX))
 			pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_RX_STBC_3R));
 
-		pht_cap->ampdu_params_info &= ~(
-			IEEE80211_HT_CAP_AMPDU_FACTOR | IEEE80211_HT_CAP_AMPDU_DENSITY
-		);
+		pht_cap->ampdu_params_info &= ~(IEEE80211_HT_CAP_AMPDU_FACTOR |
+						IEEE80211_HT_CAP_AMPDU_DENSITY);
 
 		if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
 		    (psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_CCMP)) {
@@ -1068,13 +1042,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 						       0x00);
 		}
 
-		rtw_hal_get_def_var(
-			padapter,
+		rtw_hal_get_def_var(padapter,
 			HW_VAR_MAX_RX_AMPDU_FACTOR,
 			&max_rx_ampdu_factor
 		);
-		pht_cap->ampdu_params_info |= (
-			IEEE80211_HT_CAP_AMPDU_FACTOR & max_rx_ampdu_factor
+		pht_cap->ampdu_params_info |=
+			(IEEE80211_HT_CAP_AMPDU_FACTOR & max_rx_ampdu_factor
 		); /* set  Max Rx AMPDU size  to 64K */
 
 		pht_cap->mcs.rx_mask[0] = 0xff;
@@ -1084,12 +1057,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	}
 
 	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_HT_OPERATION,
 		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
-	);
+		       (pbss_network->ie_length - _BEACON_IE_OFFSET_));
 	if (p && ie_len > 0)
 		p_HT_info_ie = p;
 
@@ -1131,9 +1102,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		HT_info_handler(padapter, (struct ndis_80211_var_ie *)p_HT_info_ie);
 	}
 
-	pbss_network->length = get_wlan_bssid_ex_sz(
-		(struct wlan_bssid_ex  *)pbss_network
-	);
+	pbss_network->length = get_wlan_bssid_ex_sz((struct wlan_bssid_ex  *)pbss_network);
 
 	/* issue beacon to start bss network */
 	/* start_bss_network(padapter, (u8 *)pbss_network); */
@@ -1242,8 +1211,7 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	list_for_each_safe(plist, tmp, phead) {
 		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
-		if (
-			!memcmp(paclnode->addr, addr, ETH_ALEN) ||
+		if (!memcmp(paclnode->addr, addr, ETH_ALEN) ||
 			is_broadcast_ether_addr(addr)
 		) {
 			if (paclnode->valid) {
@@ -1294,13 +1262,11 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
 	return res;
 }
 
-static int rtw_ap_set_key(
-	struct adapter *padapter,
+static int rtw_ap_set_key(struct adapter *padapter,
 	u8 *key,
 	u8 alg,
 	int keyid,
-	u8 set_tx
-)
+			  u8 set_tx)
 {
 	u8 keylen;
 	struct cmd_obj *pcmd;
@@ -1364,13 +1330,11 @@ int rtw_ap_set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
 	return rtw_ap_set_key(padapter, key, alg, keyid, 1);
 }
 
-int rtw_ap_set_wep_key(
-	struct adapter *padapter,
+int rtw_ap_set_wep_key(struct adapter *padapter,
 	u8 *key,
 	u8 keylen,
 	int keyid,
-	u8 set_tx
-)
+		       u8 set_tx)
 {
 	u8 alg;
 
@@ -1405,21 +1369,18 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 		return;
 
 	/* parsing ERP_IE */
-	p = rtw_get_ie(
-		ie + _BEACON_IE_OFFSET_,
+	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_ERP_INFO,
 		&len,
-		(pnetwork->ie_length - _BEACON_IE_OFFSET_)
-	);
+		       (pnetwork->ie_length - _BEACON_IE_OFFSET_));
 	if (p && len > 0) {
 		struct ndis_80211_var_ie *pIE = (struct ndis_80211_var_ie *)p;
 
 		if (pmlmepriv->num_sta_non_erp == 1)
 			pIE->data[0] |= RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION;
 		else
-			pIE->data[0] &= ~(
-				RTW_ERP_INFO_NON_ERP_PRESENT | RTW_ERP_INFO_USE_PROTECTION
-			);
+			pIE->data[0] &= ~(RTW_ERP_INFO_NON_ERP_PRESENT |
+					  RTW_ERP_INFO_USE_PROTECTION);
 
 		if (pmlmepriv->num_sta_no_short_preamble > 0)
 			pIE->data[0] |= RTW_ERP_INFO_BARKER_PREAMBLE_MODE;
@@ -1465,12 +1426,10 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	unsigned char *ie = pnetwork->ies;
 	u32 ielen = pnetwork->ie_length;
 
-	pwps_ie = rtw_get_wps_ie(
-		ie + _FIXED_IE_LENGTH_,
+	pwps_ie = rtw_get_wps_ie(ie + _FIXED_IE_LENGTH_,
 		ielen - _FIXED_IE_LENGTH_,
 		NULL,
-		&wps_ielen
-	);
+				 &wps_ielen);
 
 	if (!pwps_ie || wps_ielen == 0)
 		return;
@@ -1877,12 +1836,10 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 	return beacon_updated;
 }
 
-u8 ap_free_sta(
-	struct adapter *padapter,
+u8 ap_free_sta(struct adapter *padapter,
 	struct sta_info *psta,
 	bool active,
-	u16 reason
-)
+	       u16 reason)
 {
 	u8 beacon_updated = false;
 
@@ -2010,25 +1967,22 @@ void rtw_ap_restore_network(struct adapter *padapter)
 
 	rtw_setopmode_cmd(padapter, Ndis802_11APMode, false);
 
-	set_channel_bwmode(
-		padapter,
+	set_channel_bwmode(padapter,
+
 		pmlmeext->cur_channel,
 		pmlmeext->cur_ch_offset,
-		pmlmeext->cur_bwmode
-	);
+			   pmlmeext->cur_bwmode);
 
 	start_bss_network(padapter);
 
 	if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
 	    (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
 		/* restore group key, WEP keys is restored in ips_leave() */
-		rtw_set_key(
-			padapter,
+		rtw_set_key(padapter,
 			psecuritypriv,
 			psecuritypriv->dot118021XGrpKeyid,
 			0,
-			false
-		);
+			    false);
 	}
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
@@ -2129,11 +2083,9 @@ void stop_ap_mode(struct adapter *padapter)
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
2.43.0


