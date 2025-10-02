Return-Path: <linux-kernel+bounces-840552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFF6BB4AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6354C7B0B3A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477CC275864;
	Thu,  2 Oct 2025 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw8uQVI+"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3DD2741B3
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425841; cv=none; b=mgFQEPOUzngQrefVc8SV91RegJNFEBG+TwevZUlLrKRNA4OiyC6jcf2crAjAuMQ1A5AMPA/0K7HDqUGO8FMCgimqiPZyGSyjo3McM+TlaaD39PZrFwUZFrtmA+0gj4o0xn7LyrnU2cob8/wjc+Xw9gthya9uiLwGCgZF2RmCmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425841; c=relaxed/simple;
	bh=1PC1+sAQ5+RudOHFOyziJUj9BmNGyBE9j6UashNsZzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKF1D6CQV2M/ikxpjGjx1GXcchTHhq1yvQ9ruqD6fAYIpuOfkeYAr30/S17Ux8UVltDfDxQ3qi2H9CaNMmkKfLEGMvZfSsie4mOZNwWvoo4Lfb5v9nxiwnxVDPOO48XTXn1O8WuSqL36RqqvhRnq8SNQnzgxUjQQ4hMaoZa1fFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw8uQVI+; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e4f8122660so12807641cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425839; x=1760030639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvBFaRtjx461qob9bhD15oHTSRVQ6nYQZ4Qc5hYd+vg=;
        b=fw8uQVI+Qooy/AiX5yEC2CLgDRjBx03KE6dd9cLLZRwYijM/PpSnYcyJNt2iG22iTE
         cEF0eQw5v8Ph+xX21Rav86d7GuNPZW7GvVyWioJHm2fgmT+4DxmxXbUqpVjLEGfmvvY0
         rViJou7kmQ0Srk2q/cvmrRJaiBEr6wf835F6olvQLP+AHrAvU33QHIYmhUlHJHqHoMSJ
         CsjVGutIO5gc+b9NW4fCvE88Udc1xy6uvl9qhY3y8iwpt70I2tHCExpF509ZY2yGsVAn
         aqAvwkdumCjopLgSZz0AOEtJ+oHovlBmqz6QsA1MTFJxrTxQEp7s3JkfjLeI0fgiBZUV
         xXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425839; x=1760030639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvBFaRtjx461qob9bhD15oHTSRVQ6nYQZ4Qc5hYd+vg=;
        b=LTB/DhQo5nW+fEpTeResau/02DitKpAZzo/j3zX6eW3Fd+9apv1rz0MEja+wPbZ9uP
         qcnnvzSMqhzJGl3jw7C9FUoGIuVHD206/bRPvv1cRq5XD+tv5fkirD6oPqbHYgeUMMcr
         a331g4vyG4A5lES+Th8XzUM/jg0wcFVBWRf6O5pP4FwLsOG2Dwr+dQjPjtajYqh7YyTn
         sQhg47anxTQMSXjI5aRzk4VPNviXmEHlevIYCM2a4OgXqCYANjOvctFOV7fXqpsWHAXk
         KFRqSuVBKzSAH7NL66R6ssYYFsEY8GzSWjdEVNUGgLpLyMREmEuxy/bbIOHr6YpT/qun
         ++mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1DDUsGU/ZwTypUug7kZMQKVLRsZDKz3RmlZ4qdsRLUNFxRqTWYAq1efwCfYUiG84qzPVb934MRp5Jz/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eEwH9WbZQxm+SfoWZyTAIpRJM0uoSbvifvdlGZz7M7FYQ8RW
	oxsHzrWYvv3PeQaZAsR2ViCOCqkBoof94cuM9z88psV/hASVMnnQ3J08
X-Gm-Gg: ASbGnct7NR7/7ZbnskT+1kJx53UU02CdEXSgDYzlWyoDd11an4raYT6HZjADIV1p0fA
	z8mmU5ZaJevEZvqY4+7I9Lbu/QgrLSlOc2Tvity9drwaad8Y8pBeL5hGRwI4C4/moprlvMbN4CU
	HFAsS8TOb0kd0tjhsAXJb49jlzuGFddq7owVl9qnM9WBfKYe5D66vGazwFh5Cb2a0qorcM0TKSq
	Xrjpqx9r1l4pUGQ/W0fwFlEGBdhjaZ3Y00DbINvbW/SLcrrbkKwUlpD2Do7ckC5YuN7JMrjkyTd
	SkAtCazQWDvltyL7JqLekDXEE7vYpTCi5SlInlCXWe6mhd6XcYHTDBgJeGwyns9anncUO9jagpK
	J0mtCLFlNM22UcyM+RrCaFzZBV0vnvbvulYJhLRD4lYXIjHfTjBVHkp/pOZxUWlwKRkVH1ISzMz
	FfIenG+jYDTF5cU4zS2RC+
X-Google-Smtp-Source: AGHT+IE+jU7SzzEavOn5JZUH3ibDHJskYyMLSKshCzyAsOgcjXufZCQx7zNwRQEQ34HAOXQjM0rYQA==
X-Received: by 2002:a05:622a:5a19:b0:4d8:1f72:ba60 with SMTP id d75a77b69052e-4e576a453b6mr1489481cf.14.1759425838559;
        Thu, 02 Oct 2025 10:23:58 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:23:57 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 06/16] staging: rtl8723bs: fix indentation to align with open parenthesis
Date: Thu,  2 Oct 2025 17:22:54 +0000
Message-Id: <20251002172304.1083601-7-vivek.balachandhar@gmail.com>
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

Adjust indentation of function arguments to align with the opening
parenthesis, following kernel coding style. This improves readability
and maintains consistent formatting.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 0296c2e9a7e1..ba77040a8d8d 100644
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


