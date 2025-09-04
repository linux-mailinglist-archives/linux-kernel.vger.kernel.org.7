Return-Path: <linux-kernel+bounces-799666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96262B42EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2427A17D5A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854BA1D7984;
	Thu,  4 Sep 2025 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp1BexGC"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A791DF248
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949196; cv=none; b=WUMv+pAS79kxVeCQX8TQ9aLimh+GPwQNJ7K8gC1FrJ+/9/HCFaXOK8jSUWNK1WCROD7qijAemSGzK+BhBIJsISHLlo4AjMaeGiLhY5C8Is4+h7ncNoc9rKGJrEMPQZOj/Qw2NyMTq9qletqRKW9mLafMeK/fWhSJHzljLLvdh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949196; c=relaxed/simple;
	bh=pxuJYO4CuqL53J68mJP4o7ZMOLhyShj9GKp5RB/NJ2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oOayTRSRLIdprhMpnUItE2uvwjNaOOboin1bgTsI394P3u8f3Jeh0vLwVq8HJGwgJTJguctUwhAB/krEGT8/Wl655KmB/9Thqoam34i8/4g9ig/flJSdb0Rx/IzLGcK956pZx7+fhZj7oZRr4+fQDxgiOVDAxQW4IS4elz1a5Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp1BexGC; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70dfcc589a6so5369856d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949193; x=1757553993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWg4lnTQiycKLRdpjUfi3OBrhYfBAONDfnqMgTxSEog=;
        b=cp1BexGCrxOUWn67xZVhIVbunosulC/6Tc3Hxu/+5U9nOaemD/Yt1G05zXQjGX15fX
         898AmEV00mVmzZ9DInQvbt60sbK+1m4KqsVhM2pOqYu+01XGTQ0xBUK1OoZudNNK5rGk
         wlTz3E6v2jBGXuS/f8iQCUOXfE1jb1epRbhX+o9OGB0foPX40FaMrIS5ld0qArJv0vpJ
         zX/de3iEYG126XbRpL9YK4mzGkk10OsBhxrdxcr9Upqu6S9PeMBJ2NEYXz5Jb7XicXKk
         hijinjZwyfjamKHg0/Va2b2D2kOnKNB7SXDgekkrwEL7mz/a4U/Lp0DVQnFCIkL3sUoa
         1xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949193; x=1757553993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWg4lnTQiycKLRdpjUfi3OBrhYfBAONDfnqMgTxSEog=;
        b=cU1YrnpE1WmQhcyaUGVvnB75XOc3nfjdg9rkFsTgkeeNj0han1R7CvEfX/687DQZdh
         3+jqQ2gQWeTvuTpehhF9rtPzAsPT/sLV2+WKMl03cVPwOO/Nt/XrLNzbaxr2bMf0B41k
         H6CUuycTUJ7dpQkreviA9UGSiHt7EAF4kN3YObHIufn7sWVLUF/db4IF/5bjzSI2kLDq
         ecwxrPbIzaDvXEPsQaFWpEr73DZOkZxN5C8v5ZQ2VJAcscpCATGkQKJfkIGY8Bx8T4Fp
         cpMyCpvXzke5KFaKwK9tkdP5wFl+6m+BEFEKhWITIuCdL/kcklwXtYt1nZ408QC615SQ
         nkhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr3wVBTKrvfdHKfTTXCKcndXLl+I9SuS6jkWivrEpU42Y1UM9+0zoub/l6K1sqM0GgC2/9IcLNJt2LG8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YysbhhfBLagpWaakALjjVrtXcTVwAAVwbuZMqXfMqnC5MxPfehG
	uxKq7UulkT8vuL9HaSUz11S64DpJWGdlpPebQo5KPoWwWavMTz6Qur+X
X-Gm-Gg: ASbGncu3Ik/UB0T2IpQKFy+twrjqxvdJuzLlr3QaXhPukXASsIBXS6dkCk6axwMZR23
	9fuHMFqKPmWtkcl6s9L6GcwSz0C4LEh0Y7bKCelRixxn27OvS3nYgqACzJLDBBAOKLnZ3SkBaV8
	gvkVPcrCqDZ2gIK7IodFqTOvBXaoyxgQhh52dEz67FRHAc2SSZOChVVfNv+WajvrGIzI04E3Wmu
	FjDErHd3vO4vnn6svK49vLIw9dRvBc1Bry1C2NZ2Xpd/g2qwW3LoMSiDSBzmzJrf8de8eG8Eqw2
	uiavZl02AGr5L6W7bj8dxcS2aF5Da3e/iwGhMJPXZuJbMqebdyUtz2xv9I8icWXAHyDbHAlFSvX
	tyXQ4oXyJ+NhQcbZx5PRLT4mrYWAhaCP5TxZ2ytYs5AUXBmhZmcHHD9EPZnWpXQ==
X-Google-Smtp-Source: AGHT+IGwYo4wjBNE7pDznPSzjQo+7efFZf3z0N82Wrt5NrLH1vL9wlDfXDDQFRNYVMxs3lkpjrMKrw==
X-Received: by 2002:a05:6214:29e9:b0:711:b9f3:1fc2 with SMTP id 6a1803df08f44-711b9f322ddmr192922156d6.26.1756949193103;
        Wed, 03 Sep 2025 18:26:33 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b682faf5sm38423266d6.65.2025.09.03.18.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:26:32 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 06/16] staging: rtl8723bs: fix indentation to align with open parenthesis
Date: Thu,  4 Sep 2025 01:25:26 +0000
Message-Id: <20250904012529.215521-7-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
References: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust indentation of function arguments to align with the opening
parenthesis, following kernel coding style. This improves readability
and maintains consistent formatting.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 2ed7f71e41d1..19bf6bb360f9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -183,7 +183,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 		return;
 
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
-		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true))
+	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true))
 		lifetime = 1;
 
 	if (!isfreeall) {
@@ -270,7 +270,7 @@ signed int rtw_if_up(struct adapter *padapter)
 	signed int res;
 
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
-		(check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false))
+	    (check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false))
 		res = false;
 	else
 		res =  true;
@@ -339,7 +339,7 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
 	if ((psecuritypriv->dot11PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.privacy == 0))
+	    (pnetwork->network.privacy == 0))
 		ret = false;
 	else if ((psecuritypriv->dot11PrivacyAlgrthm == _NO_PRIVACY_) &&
 		 (pnetwork->network.privacy == 1))
@@ -420,7 +420,7 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 }
 
 void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
-	struct adapter *padapter, bool update_ie)
+		    struct adapter *padapter, bool update_ie)
 {
 	long rssi_ori = dst->rssi;
 
@@ -474,9 +474,9 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	rtw_bug_check(&pmlmepriv->cur_network.network,
-		&pmlmepriv->cur_network.network,
-		&pmlmepriv->cur_network.network,
-		&pmlmepriv->cur_network.network);
+		      &pmlmepriv->cur_network.network,
+		      &pmlmepriv->cur_network.network,
+		      &pmlmepriv->cur_network.network);
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) &&
 	    (is_same_network(&pmlmepriv->cur_network.network, pnetwork, 0))) {
@@ -1438,7 +1438,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
-		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
 		if (adapter->stapriv.asoc_sta_count == 2) {
 			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue,
@@ -1537,7 +1537,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
-	      check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 		rtw_free_stainfo(adapter,  psta);
 
 		if (adapter->stapriv.asoc_sta_count == 1) {
@@ -2107,7 +2107,7 @@ static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
 
 	for (i = 0; i < NUM_PMKID_CACHE; i++)
 		if ((p->PMKIDList[i].bUsed) &&
-				(!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
+		    (!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
 			return i;
 	return -1;
 }
@@ -2694,8 +2694,8 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 signed int rtw_linked_check(struct adapter *padapter)
 {
 	if ((check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true) ||
-			(check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE |
-			 WIFI_ADHOC_MASTER_STATE) == true)) {
+	    (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE |
+			   WIFI_ADHOC_MASTER_STATE) == true)) {
 		if (padapter->stapriv.asoc_sta_count > 2)
 			return true;
 	} else {	/* Station mode */
-- 
2.39.5


