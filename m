Return-Path: <linux-kernel+bounces-840551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1C8BB4AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A232175A95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E015274671;
	Thu,  2 Oct 2025 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhaHTHhU"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E382737E1
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425839; cv=none; b=Psl6Dnu/GM0Zhx8pzXFyBL79zx3NHFL3cUl4X+3GXbEqQ90yxPVT3U1V891qlTp41UanbbrRwC4CrJm2PC8D17FMO8HUaeB+iy/9dvj5iGffQ1tcIoNUKxFpWqkNQvrbPHny0iCs9C+/wDNxcUim/WbSs4atvssWV/mpa+qPS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425839; c=relaxed/simple;
	bh=TH4+HNld9+i/MGM0f/5DEADdJZf7ly3KCW4Q2/9zRHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xee2POSvsDRaLuP9imHNOhHSAZSMXsa0BfSTOto5QLLmSM40BzAspMVIfG2Zc1/u+SsSJrnG7yYu3tWSxeecXTRMri7C51XR21jHSWH7olDY1oajDS33oxrQJfm0DNhBEVlnKtW68c89WXjdw0v+WUUEuXzKzxax1yU+IZ7YgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhaHTHhU; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4da894db6e9so11447081cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425837; x=1760030637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOkuukFAKfuNlA45spRenHQb3HrxxtKpHdC5Zz9bbRA=;
        b=VhaHTHhUX7IEKSyhiQ7Mmmxc4DGT8pckYjd/tBNt0gT/a3xJLGQeyeKGXm4QVzuoxh
         SjD61tIMIZ7aMHiLcYjpKFwO/2Zo3XGKf2UJob4s/Vd5pnXs8Jm7E+CDVSYnFXgHWZDC
         k6iyeenEOwsFKNOBkfPlWWSFu/R8zdAhYZF/2jXAYpUwo6KztK/L/IQ6/GLpdTLFvfQH
         xpfKMDU6qQGe2/kCDta2UJ06OMfHPE+bR5LyU3u4Sp6je+uY1ENU94FhxhQxveCkaE8r
         h8z42dq56os0s9/nZ0nzFH0AS/eQAprk1exC51M3MBAE7GOJF/owGPtLfbSQdLaFemBu
         9LpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425837; x=1760030637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOkuukFAKfuNlA45spRenHQb3HrxxtKpHdC5Zz9bbRA=;
        b=DsKZCqTrQWWMEBPp2bKGIBcaSUjl1R9SOw3ACSw5cb6hP2ssGq0OtB+DfCOl9MFDJJ
         2UEjqYQYytqdTRIvYlnrSAriT1QTYq0q2x76ItXMQ0ethqOTzjDr+QhxNniAirlmgtUF
         4wgkAIF5Y6Bafc7yZIsZomamMBs6ShYjYnvZjMLJB7/UB7uN+DXc2rxXuI23xwKbD1q/
         Vnl1PY/FA3u86JWPEToyH0r3mzXKhgat53UH9mwzgLVWgC4dC2Ivinf/71Cj+tuXrM3B
         /yYSXayTFCFBRWVhiI6pw/JL6dJaWDBoCH5p2jwNEE8NN36+pTlGcp71MkJXoFDT5euo
         gcKg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/UIL5FAymJEUIMJ3ZIgTDUVITCGNKcBsyA/1wGp1zU2+O5vsgRZ4B0of5qbWBkV/u86dti7taxln5qM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47CVEZ6LTBye0zayVbYCKCvOj2V2pdIaD5VGgZcJmuU/KRbbo
	rSNSB/7oABeDcPxunL/hEmxlKUVeU8YnJdTvsH1e90xmPtOSsLEpg+JW
X-Gm-Gg: ASbGncsm04n6QiIViPl8nIi4gkkGFZ9N0fCAE2Cfqbj+N3ijHzdZxELBClooyfgwiQ9
	vkzCcEQu9wyKf5drr1tQ0tuaF06r27OyKGDJn7bdxspGACbUt2+DroCTPjb1GXzKsDj2YwXnLbw
	pNXemSdwIbhc0oK9pmd6S4dFpsnRubMHcK43oCvpGfg60WA7ErBZhDRzTmi885s+YMhKWCF5cSc
	aCT74pignMyq5/9Gncx6anAO+EDQ8R2OS9bH6/CP8qKk0xRIj00XuEuP4TaI3xO2rXA+gVGjdKx
	iNTaLWeULPdclIbPSPSdyxxfutLk0J3Cd4vgdraWZ9L7r6bwrIMfC4jJQHT6cKBFkF/OydyoMU0
	d7RE4Eq6kihU0PL+X9K0mJVRBsYyfQgPOY7ZwSVmdtFYg+hUxG1bfzvDYTpnPxmY5OKim9WXlzv
	037mYcemMivUURGACJu+Y3
X-Google-Smtp-Source: AGHT+IEQGdKDqBPPATb2xXEI06t0K2DfncS/o9zfpqmAWWSdbxrstoOvzRuXs38SLSnyKjbvImWQvQ==
X-Received: by 2002:ac8:7d0a:0:b0:4e0:b72b:7f6d with SMTP id d75a77b69052e-4e576a7df6emr1380721cf.29.1759425836387;
        Thu, 02 Oct 2025 10:23:56 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:23:56 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 05/16] staging: rtl8723bs: fix logical continuation style by moving to previous line
Date: Thu,  2 Oct 2025 17:22:53 +0000
Message-Id: <20251002172304.1083601-6-vivek.balachandhar@gmail.com>
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
index c898c10f0813..0296c2e9a7e1 100644
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


