Return-Path: <linux-kernel+bounces-835840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEB1BA82FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005EA7AA4B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4F62C08B0;
	Mon, 29 Sep 2025 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQxSk5PA"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA062C0290
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128642; cv=none; b=gpxrjKeJiK+H8PGNrAJscXDcdYygTRj0kUtNjq4ooL81+FE/Vy7d1WGq1mx+G1P4ExFhPRCTcTMnAz62KmBrb8yq7/aThLJZf4IW+Tz+XurVGKRL3pOxakO2hB6sFzpGKTywJG6Xv2dqYyhcbYeoM27adCQ9ZxgZJvIpCPD3cEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128642; c=relaxed/simple;
	bh=Xf0LccqCHjcRpc9m4rzbi0aDOX4yjEMRJ3TSSqCdCAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqHfsM0ugW64rHB6aq/Sjg9InOVgfbyZ2BJq6mfWoaDfgb+YsqdpDwljkS4R8QU5Z+llEd2ElE4NsYXXyLY3VsMWfbppiEagU1mDEmw02PZxmn+wO5yaK2xBvZwTqNX+/PplfOxwVSS0m2uorv5k2fk1CPICNra3cY0cPuzezUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQxSk5PA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4dfb1f481ecso18909551cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128640; x=1759733440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDqO+UoPGgDbKDZcftZWgsNo4sXFXXjdDKh/zegscDg=;
        b=EQxSk5PAYz0mkSWGdlVi295aQEJTdxmRCHR5WGzCVeaYjZgIgXRNi3dCsNQzuq3cIR
         B58HGvbtyFyE/grufTvijJCU+fHLa/d+MjsMNa7hiYxhC8qWi44F3K8eM5tKTBZdf9EX
         O97XrURA72lQPD/wJs4kVdHH++XMF9zJ+R8kS/juvEwjI75q/id7H/l2+eVJk33qurFG
         m9bngEqafbNnzSF61BHG91ECwEt+oFjLTzxr3MikQChhU9ZYbjaXVzSlLjqQ85DImp7X
         S7nwpugMBttcx3sQnJcO0fY4ZQx8yZ7ySilNygLlOa6gdpYnPEz/1xukCXJm64GEZ8gf
         K/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128640; x=1759733440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDqO+UoPGgDbKDZcftZWgsNo4sXFXXjdDKh/zegscDg=;
        b=R35Yf2V0sChkj17aGZReOF1iiqihJ9fOTNnNha09irbkFh7Xz6/NtpApmRTHJmkcxs
         ogTuTUJ0/KFwiYHIViI9mcUqJM8UDjalbdJmYUKEs8GeyKS3Jwv3nkEP5pR8JdqZWal+
         EigBXEV1/ax6OMlNTN7600GeEXulLj5Vj6I9C1prjceGU0RkvIYhfarHz0HAjD8Qhxtz
         hemLZC6zdvz/1WSuGtcQJ0rxAMs8Xh/G4AikAARPicO0xTsjixEpo/Gp7lMK8wTD9Crf
         1MExmEoSx+EFRwT97+omdilnAFUiAHzk01DXNXhbpvvo0RGfo0MGLKamoisoaLlgmNP2
         qY9g==
X-Forwarded-Encrypted: i=1; AJvYcCV3r0GxNH0JQIMlo8IqX3XFQsxal5X+o0ak2Dhyrkq1V3Tx4W9XWQQmUsfhlBIbqDvapwum8UMrs/YRLpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdWcOtWVB7/+Rp7LAEDeiGB254RvWRGozNqJADtLL+LptH397v
	s3KLmMWvPC3Cv4lxs8raUQ1YlYbg/rTyMS/T9hphoSHHotEW7QXPIEdp
X-Gm-Gg: ASbGncsUJ/cvNVjCAGnuEk9fnPclWmk2LMBGXE8mU3m+8HTvStDeREqSY80ObJ+Ldk1
	rw6tCOrIVus5jSZ04wWBffkNop09I6JDGxDsx7Q0CBZoS8sB+inAyQGaskWXQz+uxsqxmFe1fq/
	55ECFC1nuE9OXg17VYpT+Z4+Yye1M0FPLvZek9glPcsGfzELGWOVWLvTXaS/QtaftTVvoVXpGQl
	D6MZhHe2uvs77VaXIwBnirbtcqZAqUDwbnqvTvA8VnSaiczobZRANTudepzqM288TN3sRTXTc4k
	lXQ+f062I3ZDEObbul4XNdSV1KGTCqk+5bPknH4p5nHbxbQjXkk1hsCARNzlw23GNKDwLI0fWvu
	hFyow3Z2wbqSF9v9an+oz8TUvuJH8QfzTV7+PpmjVc7kxR+gYxrHEG2lIR9XTlg==
X-Google-Smtp-Source: AGHT+IHUjsC+DXPmkdpqDN4zrphAoma9KM4Zj9T0bAafUWB38L0LSNync7vKAsPrDChYP+vG9uDJiA==
X-Received: by 2002:a05:622a:1cc9:b0:4d8:afdb:1275 with SMTP id d75a77b69052e-4da4b80839cmr245230521cf.43.1759128639904;
        Sun, 28 Sep 2025 23:50:39 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:38 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 05/15] staging: rtl8723bs: fix logical continuation style by moving to previous line
Date: Mon, 29 Sep 2025 06:49:50 +0000
Message-Id: <20250929065000.1010848-6-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
References: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
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


