Return-Path: <linux-kernel+bounces-746614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782C8B128F6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74ABB1763FF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C3214818;
	Sat, 26 Jul 2025 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaupvIy2"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09243159
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504426; cv=none; b=NOXBdBWIzlgeKTEWs3slxuHnX424EQPKmCK+MAEnIUS7WJ/ROyDyXy7PFcimguVT1o+4BT80qGrMKWojdeFBbAP72JjsIa21kMFzDBg+obgmpjcfECqKbn6tr4Ee+vGFAuQ1g8OGvCgQXpCf9ixwHCp4Uy8LsnKf6rkfnPpAI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504426; c=relaxed/simple;
	bh=P8blFKCskYmLJJ7VIQpCA1udM8xXbyCUuJ3KFZmm5I8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HYZSE2HbXOPZUmvQXIGsCaDb7WYp7UhMGILsLbDr/G7e8msKt+pAlR1yfCDqe8/AzBTCReww6SiKElNxtLWzRLxL2hzU+FERk39k8zmHmYW1hKuHQ5HCJvfLSBkOP4bT5cJnK0sDYHpEVgRaNREWWaKZ1p/NxPQTea69WeKZmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaupvIy2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e6399d0656so142652585a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504424; x=1754109224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiqQs9UeyD9dBqrMAhpgHRDznjYgytkYfxAEJHc3WqM=;
        b=UaupvIy24dK03VqjEN+70OHN++62zjOYkti1Ay+FlIdtDHPJIc9iIQZssBmT1aCQ3p
         hobAmAAtvThZVg4YOQ3qhyO2lPs7zVph4QfyIuWCGHTozyp0Qq35nRyfIm9pTxR7uZVB
         T/NmG0JMFL3tG4B6seZfA8H6NTt5mX+AJk6xs5J0v2hYBfvifrPmfRkSZZkfCEK4F1mq
         nbJYy3vqszy9FnyXzJCic/LbUtKbgrfRimAAkDCdgPNRiu1tSyryrtk3gHH6S9oO7LBE
         aeaREDseVLQ8dHUY5N8MYuYWed2SesfM+TgpHV7I7b5Kv5Ke3mP7zTpJlk0G/xo+OLY1
         DC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504424; x=1754109224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiqQs9UeyD9dBqrMAhpgHRDznjYgytkYfxAEJHc3WqM=;
        b=gER4I0qZkDSMIYGVUWW/B8zIcBixx/6h04c59lmL9IpjbOKkmeQNmaKi2mj8nlBIwU
         bkdBp/cnqhW1QZnZ3Bc6jfhVgBHyENC1z9pD9pGTWKCUrKvp+pVZdCzepDn3QHHORdCA
         +3wwKQVPMWT4XU4mlZEZST0I04p1VDqVQQHZhe8U3ulCL1hXy1MIuej8sL1nHXPiJqN1
         7tlVNSvqubgh31LkgPg01BzsG89rvf9ujewQJlsFznKpjL7/HveuJocu7rfdM6nDJQcI
         ZfqJHtJYS9KhaQ5MZbq0aVe/F+cld/UjJD2l52DGbFevx7a3kOSF8dZSK9x0GQoBoD4E
         uMvg==
X-Forwarded-Encrypted: i=1; AJvYcCXUE9aJSURgXLWWs18I/ciym9jbcDoK+qk8jaGiHXBizC8jMqh6UqG9d2QqUKSlQWv0CZgsWuoJbQ3apBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZmj6zaVwVVSMEB/Zn+SvtowL0kXEbyYLjzv6c/jAZIpCpu1s
	OvW8mfOXrGyNgVPv6WLLHdZRSErZHU7ZsKHP9nug4wqBjlPvGIataJ27
X-Gm-Gg: ASbGnctc9ne9CQ9ZxqvLyP8XZ/viZ3uz7VorXdx+ttNJ9CUB6LCNuCGMbA0O6PQCJ0W
	/aES6yXGq8yOkxeXRr+UvNGw4GDirLppzWGlH6doJQ6QVVzR9oYaKZDD1udLSQ+c3x6dziMslrY
	4y5xhEx1CCJ/mJtlvKU1Vb0p2SyLf46/g685Mws4iQ87kyrSYTL5HnW3aTblfY7Yura3PF/MLxa
	yVgEzgek7qQuP7sqlGila8hF1++jjYpM6sk8zHb9wbwEfnRvEwvobkTmWekKzNoFrnDom9o7qqS
	6UfssWiYdaRA0baa9wjvemiSRhDrnKSUCH78Xb6JtWGbC0iIfxibCoBjkrogqrgNGKbXOgjMzIB
	C1dB5SeUgaU/GBgzCMBYSoNDcDhqtEMQhLkatqEaWvdcu+aXUSyk=
X-Google-Smtp-Source: AGHT+IFX9Vsx4swIGeE82fmmkBcCcRt9S8KkzP2tx9DgvyavfwY6YXizCOrgrpkDEs9yllbkh9T/OA==
X-Received: by 2002:a05:620a:6d85:b0:7d3:f3a5:71d7 with SMTP id af79cd13be357-7e63c1beb27mr348119785a.40.1753504423833;
        Fri, 25 Jul 2025 21:33:43 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:43 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 08/20] staging: rtl8723bs: fix logical continuation style by moving to previous line
Date: Sat, 26 Jul 2025 04:32:06 +0000
Message-Id: <20250726043218.386738-9-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reformatted a logical continuation to sit on the same line as the previous
statement, as per kernel coding style guidelines. This improves code
readability and avoids unnecessary line breaks.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 29 ++++++++++++-----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 0c985593ff0c..692d2526965f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -323,8 +323,8 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 
 inline int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
 {
-	return (a->ssid.ssid_length == b->ssid.ssid_length)
-		&&  !memcmp(a->ssid.ssid, b->ssid.ssid, a->ssid.ssid_length);
+	return (a->ssid.ssid_length == b->ssid.ssid_length) &&
+		!memcmp(a->ssid.ssid, b->ssid.ssid, a->ssid.ssid_length);
 }
 
 int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 feature)
@@ -765,8 +765,8 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
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
@@ -908,8 +908,8 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 	if (rtw_to_roam(padapter) > 0)
 		_clr_fwstate_(pmlmepriv, _FW_LINKED);
 
-	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED)
-		|| (rtw_to_roam(padapter) <= 0)
+	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) ||
+	    (rtw_to_roam(padapter) <= 0)
 	) {
 		rtw_os_indicate_disconnect(padapter);
 
@@ -944,8 +944,8 @@ void rtw_scan_abort(struct adapter *adapter)
 
 	start = jiffies;
 	pmlmeext->scan_abort = true;
-	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)
-		&& jiffies_to_msecs(start) <= 200) {
+	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) &&
+	       jiffies_to_msecs(start) <= 200) {
 		if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 			break;
 
@@ -1618,8 +1618,8 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 	if (adapter->net_closed)
 		return;
 
-	if ((adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
-		&& !(hal_btcoex_IsBtControlLps(adapter))
+	if ((adapter_to_pwrctl(adapter)->fw_current_in_ps_mode) &&
+	    !(hal_btcoex_IsBtControlLps(adapter))
 		) {
 		u8 bEnterPS;
 
@@ -1766,8 +1766,8 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 
 	/* check ssid, if needed */
 	if (mlme->assoc_ssid.ssid[0] && mlme->assoc_ssid.ssid_length) {
-		if (competitor->network.ssid.ssid_length != mlme->assoc_ssid.ssid_length
-			|| memcmp(competitor->network.ssid.ssid, mlme->assoc_ssid.ssid,
+		if (competitor->network.ssid.ssid_length != mlme->assoc_ssid.ssid_length ||
+		    memcmp(competitor->network.ssid.ssid, mlme->assoc_ssid.ssid,
 				  mlme->assoc_ssid.ssid_length)
 		)
 			goto exit;
@@ -1777,8 +1777,9 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
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


