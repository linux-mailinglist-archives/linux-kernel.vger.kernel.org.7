Return-Path: <linux-kernel+bounces-799726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2159EB42F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F22566A32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0462220F4F;
	Thu,  4 Sep 2025 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJcxJIJ2"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3621F0E55
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952114; cv=none; b=ZPoYln/rYPe6oL6Wj2aCJ7rDv7gAE679ZlF17I+i2dXoEuWc0QkPJ2jsTEkFvGBl2ItwI7n+fCCC/DDzozc0CQoiJxfupfMy/oIRO9jsk3Uv8njgb4OiZ5u8gL0wmWxoEXwLTCLE9Q1uVFOo0yDK5JG+TxbCyzo8mIPpIGDrkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952114; c=relaxed/simple;
	bh=pxuJYO4CuqL53J68mJP4o7ZMOLhyShj9GKp5RB/NJ2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkfcT9DQXzD1f0UNnohB9s3h1dwM0RtZd4C20jL1nhTe5l7hug5WsqKFqdhtaKzELqJhR5AME+shc6elW6sahJQylxnJDLK6CoTuuXrlFdFMZ4+hp6mEpSc2q4WVlWGCo451nziB06D+ox0tI5B+CSBIyOY9U5LGBQULH30uMi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJcxJIJ2; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-720f0dd2809so2621396d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952111; x=1757556911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWg4lnTQiycKLRdpjUfi3OBrhYfBAONDfnqMgTxSEog=;
        b=hJcxJIJ2yam7EqPL7Yiyt6HTg02CB5kP/vuzK1nvuwg5xZsrF3ysdQzg5ZYRVR/BNx
         Q/R1vDU/IvBnarcxie8/yF1h1Oi/B1eIFg8aOPK+LQ5cCZXQr1tddEB94ofN65pL0LyW
         xG+elL2SYtbXb79FDuDX27Wt26Ah2qRU/wUFTJn8EQKpZUjQA3VE10QlhWoi//nHmV8E
         8lJzqrSz7r/7oUYCfHrNeVR8uSZSoTYzrcCVUXJ8JH9oSqfRhBFQcJgBvCakETgHOR2S
         JRYt4i1mpcP3KK5QifgZudQrJo+wjBOH4lP106h/avID7yHlO6jYBM83q8afao0N8TRg
         UOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952111; x=1757556911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWg4lnTQiycKLRdpjUfi3OBrhYfBAONDfnqMgTxSEog=;
        b=ZSgiT2+XnorYkGrHwe5W43aJSoA/cS/EVInb2lWfYhi3jOrktunDmFmnBhAWUsb1cP
         riX3JHe2A4ZCgGLnaUW6giyRRhsGpRm57aG94Ha/i5OearJiO/fCRzv570EOWArYS+nf
         Cwij342A7P9vu11ZwuA+S28ybHDJy7p7NkfO52hNJJGH6pQc9XeyBKmPp/wlMkNrkzUi
         +cIeMtqmgDYX8TPAtyTewduoz8xm0J7LvDGzLSzFMyWstigUIMwszVtm1b3TiA99CXok
         P3/SsVwZRsuJ588eMX4vX32JpxolK6pIhkCoCeccHxdhWiZ3CjcnKIwF16HqY2PVmmVk
         HnNw==
X-Forwarded-Encrypted: i=1; AJvYcCVb5BjxCGzAbMpb26NCF1/3QGhtCvBecOiyp7Gwo6eTnGPEpVNqjy3Q5igbBgdZqCEWHDcG3qesUucO6A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJygz4Kz4ZszezjKx3ETj+4gVcaat7PrLZyV96GXDFuqgjLVU9
	OE2zTo91Ygpe5saXh/2HSwEUslAfXqj52Q5vDDdjHaX5UBjpnYYVqI89/fusMA==
X-Gm-Gg: ASbGnctjHQXtI0gdpDM5hUBpbdLQ220o/7eUSmup7/KNs6pbcbIZ8+81CuTNcT5Tjfc
	pcWjPSFUfOrU86JSJ2QqEnFh3rD8Cj5QzwTl5ana2Xi5yR73lERE01EPQwU14un7rXeOmOHQuWI
	nvdQrM2r50tQmp6sm6A7EN4YUNWunDzlMKZ01Xv8BEidvVKeAE8DGsXiGRDk7ITHX2BfpRCxjCu
	fK5uln1KbZi1KUiDOKEt6QNPw9RN/iZe1KIjp1sl8HNv2qnB8Ev/SSO5Obbdb+8DFaoSQ/jKYWO
	GOgu0w45qCz/dTC4apwXjZMDTv/0Y/+xiVKcoohPB/RafEveflV6Ku63s7qpXgQkbbbk3dmJAm1
	GU7AX27PlFOtOBUgkQpomZ4QXFOSEqYOwDOgLwvjD+BCbDwgzdXtvWXAG8RMy9w==
X-Google-Smtp-Source: AGHT+IF3Agr1d6gNeVc1AJ1OiiU3Bn1sTiAQGqvx/SormxN8dXKci+PskAoIUzX94Cyaw5HiAqKy0g==
X-Received: by 2002:a05:6214:2584:b0:727:c190:34ea with SMTP id 6a1803df08f44-727c1903594mr28399086d6.39.1756952110900;
        Wed, 03 Sep 2025 19:15:10 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:10 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 06/16] staging: rtl8723bs: fix indentation to align with open parenthesis
Date: Thu,  4 Sep 2025 02:14:38 +0000
Message-Id: <20250904021448.216461-7-vivek.balachandhar@gmail.com>
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


