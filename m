Return-Path: <linux-kernel+bounces-761853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2895B1FF4E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4362D7A1460
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DC02D77E0;
	Mon, 11 Aug 2025 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhBNbjbq"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD552853EF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893381; cv=none; b=WXhteHzEpooiwY9j5igqGczilcNZrANKBwHoYvSAR7BoEpeNI/SwkViL6GpTF9OAEbpMxHnjxI5hcAAzAHfTkbZoEuqN8FrDNxKIqY8m62pwFhPHFvQ+CemB4Ny2Jv+OVsMKc4mTpbqYmp6sICbjz3fYn7Su4bu8iLJsU3oZoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893381; c=relaxed/simple;
	bh=AnaxUoK9gzxsFCBQgNja68/bicu3TmEoaEFFVMIYvJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVLGJQ8h/2HObRAy8gV6S+QcXnbv5pYmuT4sXsIqtKVaL0mcE5Ebt+pHL9aDS2WJ1zJs1ojpTOrnPXrO+JTcPqsftTbDUGJRpvEgH1de6WRN50UhEYBJXSMuyECpplpGnj7c+Sxo5lAkMsZO4iv52auqCkh2aSqdDONh7xqv0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhBNbjbq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bed310fa1so3247183b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754893379; x=1755498179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4h/8L43+V+oJvbDoQBPDW4FdKdpW4NfBoaQD3n9AqY=;
        b=NhBNbjbqfBUx/+Uo0+KxxDJocXSp0FpajL3gpklRXaU/k5Mi674HFOLQuJMhiiWuDO
         u9E/m64xCOVEAltV74oM3B4gmGO3txpQwOL3e8z9S5TVOv4KiMielz5E16KS+45iXOfN
         6AuW/trT65JaZDe7UfBURJKnVbZ+gWd1Qb5JUyKf/i6pw8pv9XIQt9NpD6iVs5boasLb
         y2dfiLU4TWx+k5mRx5OgSGtKBQRB0H/oB6E4P3mqQilzMOie1ThG+7IzNw0XPfWeT/NP
         3JaPTUdi7mvRpEGfGsr3DByCkX1pO1WgY0Ic+kjtM6cgsmmAsLGBgmFUvqPhTtji0Tir
         icEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754893379; x=1755498179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4h/8L43+V+oJvbDoQBPDW4FdKdpW4NfBoaQD3n9AqY=;
        b=XcNFDEQ+lZALJJh2H4YHFNQrc+Dt/z3rdAK0AVtBRGPTyz09+k1vDX4b2ZBeXwUudd
         jSx1LpHrWSDgIk47GxDPwq2ilOK/O4uv7AEDLe3e+6l6mJexKhIdz/NzJDOzHpZ6iP7S
         58h9YY8/mc1eGlT6nN9/f1assAzldZFepbFnsHLDdYiMSi3PncBJUQP+ptqDG0TXdrnd
         KV7pqoWbhq2Vq8coTVNDxlifvGyOWeCwv61Zyc7zhErAV7OOl0wFzLsHcbsbswnv1Bto
         +J+7CoO2YJW7jMwVZMbLqk54eFAE5ACX0+IyRm84/oUqSqD2EbhXTOb2iQAZ94ts+GcP
         p5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVcoZBCw+UQkLd139+QeN6ib1NnewVBuY6YONYwiIJL5CQaPMAzrV6El1Vc267A1rFwXuy1hXYhPAMfMzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtMm98mW7Ooqzf5csIugUGV3xh68Fqi5s2eh+McS148EH0BiGk
	BxNYLjy9Xw4aiFE3S58CcPPA9wCgfwqfiXA0bJjc4amZshwN2bK1tvzHP9SCL4VoqEY9yA==
X-Gm-Gg: ASbGncujZ4evLNOef0F7zXp6k8C1a0zycrg1S52uxVvJCHP8F1fLF42j5mKEXYjD+pP
	a5CWLy1x2PSO7rrJvJ/tnt3Xzgm2rIpVAsuBPvb6caDxpz+v43qp7P297BasXcFa/wjgYy9Glxx
	JIl+Z24viIdGIOb2sgSqMhF36i1d0C0CjJFmY9VpYIh1IrpQTR8sKo1gvf1lbDYmauOb/lNUnLu
	DDpeKisgz+wuhNqM30ZRgoNz8wINLDcc58uS9JPRAhD15xqqE8GVPdv76NrdAmuproDvNxGXBWo
	JlTwdBUMG9C55jk8+KeZBW/sgwB+OuEa7LJdyuD9Wehnjc58h3wwuIj6Ur5cLGwUjNLT/CYTaps
	sfgaIGcB5D5OHlPogf8vm/ilYuYzRE+bmSb5LJ5oDtX0A+g3bUurhNL3Lva9QzHlRgzi7vKCUj/
	525p3A3HorGKO8/vu8CbZ0/DoWBAgDHlxpPSJY6NMVGxCfPZ2OPbs=
X-Google-Smtp-Source: AGHT+IGZP3EUDv+evXSYZZ3v78r9tqVXonXmWXGdIhoU5USQNOsuGY2MlOzBJviOy2jzJKFjvFd20A==
X-Received: by 2002:a05:6a20:6305:b0:240:1ad8:1821 with SMTP id adf61e73a8af0-240550b7a59mr12227298637.19.1754893379325;
        Sun, 10 Aug 2025 23:22:59 -0700 (PDT)
Received: from wen-HP-ProBook-445-14-inch-G9-Notebook-PC.. (36-239-105-221.dynamic-ip.hinet.net. [36.239.105.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm25861623b3a.42.2025.08.10.23.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:22:58 -0700 (PDT)
From: Yao-Wen Chang <changyaowen19980629@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yao-Wen Chang <changyaowen19980629@gmail.com>
Subject: [PATCH 05/11] staging: rtl8723bs: Rmove unnecessary parentheses around the statement
Date: Mon, 11 Aug 2025 14:21:28 +0800
Message-ID: <20250811062132.102525-5-changyaowen19980629@gmail.com>
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

This commit removes the unnecessary parentheses around the statement.
This change will not modify the logic of the code.

Signed-off-by: Yao-Wen Chang <changyaowen19980629@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 28 ++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 0bbbf62a7097..919581965015 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -514,12 +514,12 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 
 		/*  B0 Config LDPC Coding Capability */
 		if (TEST_FLAG(phtpriv_ap->ldpc_cap, LDPC_HT_ENABLE_TX) &&
-		    GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap)))
+		    GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)&phtpriv_sta->ht_cap))
 			SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
 
 		/*  B7 B8 B9 Config STBC setting */
 		if (TEST_FLAG(phtpriv_ap->stbc_cap, STBC_HT_ENABLE_TX) &&
-		    GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap)))
+		    GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)&phtpriv_sta->ht_cap))
 			SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
 	} else {
 		phtpriv_sta->ampdu_enable = false;
@@ -575,11 +575,11 @@ static void update_ap_info(struct adapter *padapter, struct sta_info *psta)
 		/* phtpriv_ap->ampdu_enable = phtpriv_ap->ampdu_enable; */
 
 		/* check if sta support s Short GI 20M */
-		if ((phtpriv_ap->ht_cap.cap_info) & cpu_to_le16(IEEE80211_HT_CAP_SGI_20))
+		if (phtpriv_ap->ht_cap.cap_info & cpu_to_le16(IEEE80211_HT_CAP_SGI_20))
 			phtpriv_ap->sgi_20m = true;
 
 		/* check if sta support s Short GI 40M */
-		if ((phtpriv_ap->ht_cap.cap_info) & cpu_to_le16(IEEE80211_HT_CAP_SGI_40))
+		if (phtpriv_ap->ht_cap.cap_info & cpu_to_le16(IEEE80211_HT_CAP_SGI_40))
 			phtpriv_ap->sgi_40m = true;
 
 		psta->qos_option = true;
@@ -849,8 +849,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_SSID,
 		&ie_len,
-		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
-	);
+		       pbss_network->ie_length - _BEACON_IE_OFFSET_);
+
 	if (p && ie_len > 0) {
 		memset(&pbss_network->ssid, 0, sizeof(struct ndis_802_11_ssid));
 		memcpy(pbss_network->ssid.ssid, (p + 2), ie_len);
@@ -1667,8 +1667,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 
 			pmlmepriv->num_sta_no_short_preamble++;
 
-			if ((pmlmeext->cur_wireless_mode > WIRELESS_11B) &&
-			    (pmlmepriv->num_sta_no_short_preamble == 1)) {
+			if (pmlmeext->cur_wireless_mode > WIRELESS_11B &&
+			    pmlmepriv->num_sta_no_short_preamble == 1) {
 				beacon_updated = true;
 				update_beacon(padapter, 0xFF, NULL, true);
 			}
@@ -1679,8 +1679,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 
 			pmlmepriv->num_sta_no_short_preamble--;
 
-			if ((pmlmeext->cur_wireless_mode > WIRELESS_11B) &&
-			    (pmlmepriv->num_sta_no_short_preamble == 0)) {
+			if (pmlmeext->cur_wireless_mode > WIRELESS_11B &&
+			    pmlmepriv->num_sta_no_short_preamble == 0) {
 				beacon_updated = true;
 				update_beacon(padapter, 0xFF, NULL, true);
 			}
@@ -1717,8 +1717,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 
 			pmlmepriv->num_sta_no_short_slot_time++;
 
-			if ((pmlmeext->cur_wireless_mode > WIRELESS_11B) &&
-			    (pmlmepriv->num_sta_no_short_slot_time == 1)) {
+			if (pmlmeext->cur_wireless_mode > WIRELESS_11B &&
+			    pmlmepriv->num_sta_no_short_slot_time == 1) {
 				beacon_updated = true;
 				update_beacon(padapter, 0xFF, NULL, true);
 			}
@@ -1729,8 +1729,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 
 			pmlmepriv->num_sta_no_short_slot_time--;
 
-			if ((pmlmeext->cur_wireless_mode > WIRELESS_11B) &&
-			    (pmlmepriv->num_sta_no_short_slot_time == 0)) {
+			if (pmlmeext->cur_wireless_mode > WIRELESS_11B &&
+			    pmlmepriv->num_sta_no_short_slot_time == 0) {
 				beacon_updated = true;
 				update_beacon(padapter, 0xFF, NULL, true);
 			}
-- 
2.43.0


