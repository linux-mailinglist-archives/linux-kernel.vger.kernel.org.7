Return-Path: <linux-kernel+bounces-835841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175B2BA8302
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6CB1C0AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5712C0F8C;
	Mon, 29 Sep 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi7l1nCB"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842D2C08AD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128645; cv=none; b=hOxuCyu6VUdxvkKvMJuiObHl5j1h1vd+CKCpYLZYappLK5vhddbLFuA3xR+I/OnfUEehV5nn//lvj9e/R/rQ4EghFh2Mov6JZpoUqHAdWkRlurv6Zlg01iaCS2vnq94jrO60wW2JFls6CKlgh8iw93VMvNDNUImjU735Imd3IKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128645; c=relaxed/simple;
	bh=pxuJYO4CuqL53J68mJP4o7ZMOLhyShj9GKp5RB/NJ2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8T8OVkgyAeKHujXtoQEd6ujRLMts+YiyqmAu43jke0QmlQF8w1QDk+H2lSWTpHdCOMaMw6Ljx6oWlbxA+LkKQvAbV9+sL5nlbqEwzIkKodnsCqKmcdNcqoVVTVVMaAqf6UwKsF5u0D2z1DJ/OMtQU9jGDir2ucj5u763AS7GiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi7l1nCB; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4db385e046dso35862841cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128642; x=1759733442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWg4lnTQiycKLRdpjUfi3OBrhYfBAONDfnqMgTxSEog=;
        b=Bi7l1nCB6jwenf6MziBJ5eB5TNSfCwq7UMfVTDt9HlQ45YJCRFUUyu+m8IVLtzZgPm
         gYYT+zzyDEibigXcA1pbWpc1WoDUBdKv95yXfLC2kC3Aqoff4bgM4Y0RKmf4FWfnB5aj
         OeotU2IRbMQ80okBHkvqgtZ4+Rdu2BItO17l7Agshbj3XecNRsKCU//FimJRKb/EkEvi
         XtLe4OFW6yQSpCuUkRuiVuEMXRw46BZDzFc9JMKcZkURByGkTWG1BlQ2n3jZqGk7/7pf
         VW3wT9PreG3Oyt3eKNu8xcJKGmjnphFviFG/tv3JBA8IHuFcqfNphqphXCThO6tPPulO
         SfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128642; x=1759733442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWg4lnTQiycKLRdpjUfi3OBrhYfBAONDfnqMgTxSEog=;
        b=Gql6u+5+uq1mCS8aMtPceuFYR+eAavq1XWCxXpNP6jxIuYM6rYspeuIV6IYTStIGf+
         3qg1xitqFngH9QJmt+71hB/T+iaCp0obUlcIW0eGGYbJ3/qZjARHpqLjVzIhKk7O/Jgk
         qkcYYrsZ2frJNKrcQzIV7R7UjiK3zXidgbrG4/l04+WrX6vlq+hTdLb1UTtpUd6Wq837
         ltt6/hJrYpvbRj+nz9GHfEhGE3/21hZ1mz2zeMhle8uk5UuforWble2se0sr6vsVqWPy
         ngJe6bBE/jNgP3zRGatvm8i1gGHozLN3LBW1YInL5TUQ3Bl8fkegfl6QWmGeCv2Jxos2
         nLHw==
X-Forwarded-Encrypted: i=1; AJvYcCW5d2AdPiwF973lVipdb6a9vg+idzBJtplVMzqmhIjd2XMtSyM+fh/yTOMdyuc5e5C1nQLU4WiELtGZH/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl6HzI9xPae5CWHAXZQ/ODvK+RnhhYbEWyyIIX/4iDwIFUkPXH
	de/aIzZE8qVifmAy7rIjP9R/lD7lBPSEy5Ybev2WxsvtLmMWaaRODuFr
X-Gm-Gg: ASbGncvJ7QHmRLSVq+zjOKOFwDNhE9/qTq9HwCnvpui82XnGdGHhwSfLMbh0GOltHGp
	iI8MDLgfQyxL1Vqymfa+PwNJN+4ATztKvydFtX/hiWdHg2lzAvs7l1Yhv0DfaTFyGQ6vsTlaTDR
	e5+U5GQ9+s+M7obmmSuBgNE0bZxsnknDxLesEekzRhPa/rbOU8JJZQW75ZrUQxzYvehQnWYpdji
	TRaPQwPNvHCNqnaG9XCcWMzGIHGL6LUP4N+YhBh7sHL5ld1x3F4l0+YhiZ/YzYwGg4/E7vtELHv
	Z3g51WEsRQdvreQx4yDnvrolkBTZnIaTODX+laSyL6hnXXJIg2g1las0au3H3g8P+lKhM8wfZqc
	2kgjTK5mRykyMeSHtM3ZEOPzSPvznnphP8APnr2FaxUvLHlj/zDI=
X-Google-Smtp-Source: AGHT+IFD6o45gYEmIpG1PaSfIBPIwybRJGtWPnj4vNP16R36MG7iSTAq9le1VX4I+4eDKHLBLdEOAw==
X-Received: by 2002:ac8:58c7:0:b0:4ce:f3ce:e9da with SMTP id d75a77b69052e-4da4782aae5mr275356391cf.16.1759128642339;
        Sun, 28 Sep 2025 23:50:42 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:42 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 06/15] staging: rtl8723bs: fix indentation to align with open parenthesis
Date: Mon, 29 Sep 2025 06:49:51 +0000
Message-Id: <20250929065000.1010848-7-vivek.balachandhar@gmail.com>
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


