Return-Path: <linux-kernel+bounces-799725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D1EB42F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533605669DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10901EDA0B;
	Thu,  4 Sep 2025 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grx3kw+2"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588701FF5F9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952113; cv=none; b=eljpuc/wwv3TOG3CliVE9h4zfDxb+tq2fuU78Bj7Bu3RnTX0sXItOsnnfpcVZ+Ypja9IKPfyPZhRcuIWRF/DAmIyfNTyKycTxM/QcfCxS5V/74RUKNj+QmnVliIlBjLByvFAjB4ghmOw+FncSvyysvOSgY7N3k647xikeKh+tvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952113; c=relaxed/simple;
	bh=Xf0LccqCHjcRpc9m4rzbi0aDOX4yjEMRJ3TSSqCdCAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgTFsRbk0FmdcUIqoRmJYTeGryIcPOSIGsEmiU9QAbkTCxAeYgswxpzTi8+UKrH14hz5thlLtq2qtszqHWs0No/7dlA+yWS6Q36c9bWgdsB4PH0jbTb8wgJqMmfVq+oM0R6LGHxHuDwL7wKmtnOsHo/DQ1k6huv2Lf5cEr8sdds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grx3kw+2; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-721c6ffab58so4529166d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952110; x=1757556910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDqO+UoPGgDbKDZcftZWgsNo4sXFXXjdDKh/zegscDg=;
        b=grx3kw+2w43qtEvizKCuSUeTRTo5oRdHalwgUSUTKb99lIehOzeQ6uyEmu9zSBc9hb
         +lscQaZ+dBKw1D1+Fva/2zINXawxd+yl9C+kFGN3yupxFlNfY9paXr6hq49H2hOZDGr3
         TcHYzIYDnmwAUGyBzZneQ7r0C/7OwaUBiEFd3g0ePe25Za9xcxIWsW+1y42J+VKjml1s
         uTtV8pBaMZRrjby3uYHqVhY7ee20/Wv48iEl/XibXXvmiXpQMLt6qRderEYJ4R9EmC2K
         f3Hj77cJThKOaKY4u3pvc48CApyRQ8QtHNMBA6F526Xp4D5LIMWTkZzBF9T4f3cI/HXZ
         fnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952110; x=1757556910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDqO+UoPGgDbKDZcftZWgsNo4sXFXXjdDKh/zegscDg=;
        b=V62wa0y2Z2z0TfzEr6MhRHz8SZwUu7ehBx0Msg4Lpk9l1hUKXdVRBAspW6ahiqdMcj
         CcIIX49jctLHUGLLk8QYr2nTJ02NGfLEhZQfZJWyfybUEBh/ZrHgsbrnI2uB3S5HDRaC
         p6gdS8u8C1rbrJBNs+w7SdV3uW7Zy7EFBpPwbVS/86HLZmF1MvFa8Jp+M5u2aDWVUjZ+
         EP2qiwMlFWk49dWuo0ax67th4k+d9ryhPLDYMOP/cB6zg041T37t7Jk2N1H8Vpx/+hCc
         lnvwEV9jAifQA0Eto2EK0PrMoWhQW4bD2B5daSt9wzDTLl3AbphpOkDmKWiKqwYj+W0F
         Amzw==
X-Forwarded-Encrypted: i=1; AJvYcCWazQ+Xna8wYpeMQaQaG4JoXcfMNgDBI6BDbRZIJ7oHAnnxJrgL0Os9NbR7A8P+UcTH3ToDLviNIqQ8noc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6S2Uadx+D5STOCXjz+N1RRHPtb3iabFPPSaQ98cTf9szSCfyH
	82shvtnosHO2Ymy7i+nXXUG7G7JJEAhZ+uhKV15zn0HP8dHW7paG5Gg2
X-Gm-Gg: ASbGncueuQ93Lapm5PCfciAYnmpaJMcv8dOY0uHenl3HNWnAqPigE7AI/wCjsZ1sz6J
	KpJC623N8sxvUBn8Py7Y3IhcGmocIeoeEvvZtBXGH+hBVDSyRmdpBhXcllD3JcKulpOGCHHhpvI
	oF2Zj8elJUcvhVKQmc8ZYjOXK1dWTv6uv+aHzjg9IjKn6RHvHlud30HyFOAXRXMv+3hwrT3wD69
	mm3OxIn+qAb0ElTfASVoB6gm9RMfyU3LA44B7fh71yi3XbCM/+fE+WmJfz7yoQ2IAIF+UaZwPfE
	XD4crNk1Mky3lvfFckZjCC9K+1+uu0UNXDDXyGiTNddv4dJTHBbN2136ZiHWHBt8jkxpKAjJd8h
	fsVLJfJDdVV/wTJAipY56EzYYQMRBDjzp2ndLq7BqWOObn8yfV3c=
X-Google-Smtp-Source: AGHT+IGeng4/Y0t+Er/V1I1daQN6O1gDkI/HO4MmnZunycC2bX7hbkFmgXVNheuXbC3UUKCpofhzOQ==
X-Received: by 2002:a05:6214:1307:b0:70f:aa71:15b3 with SMTP id 6a1803df08f44-70fac93979amr218166526d6.60.1756952109906;
        Wed, 03 Sep 2025 19:15:09 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:09 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 05/16] staging: rtl8723bs: fix logical continuation style by moving to previous line
Date: Thu,  4 Sep 2025 02:14:37 +0000
Message-Id: <20250904021448.216461-6-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
References: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
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


