Return-Path: <linux-kernel+bounces-746615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF71B128F7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A04317534B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F86202990;
	Sat, 26 Jul 2025 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDi/asBl"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905621507F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504429; cv=none; b=YF3nylU6OVFyqKQI4LZPD2W192gF2feIQmAXpgUyksGP+nNGERBiHy0i3Tkkl6Qt9KkEaqVPFq8rFEDkRTKqpNNm2F51MdrsIaZeC4c0CC8ZKTeLjZf4XCvLAz1HlKkDyUNnXxhH1y3TCPFNLoCp3CHh3S/CaaAblg/NAhvkTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504429; c=relaxed/simple;
	bh=HbTYJpvbsizmO6AePks88UoqbxnEofkE+uZjPBDPOoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4Af4Q/ChGOFsucYYV6yOag0pJXvbo8mUfdTQfuUGnE5zKQ07z5Qqk3YDcC9qAZ1y9Ml69AdPxCXIlWwplQxya5OOj39mekj738kmw0zRmpppQN4E37tFpHIBIwuups5LVO02I1EYe849+tRWEtwASaSY97RZYdPMl9dhLMnP8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDi/asBl; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d45f5fde50so223632685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504426; x=1754109226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YINGwzP+WQ2B2pLZ+3JU3T3wxECudwibr/z31+tOBEA=;
        b=cDi/asBlTyOs5XN3gnUhlN/ouYrhYR1wGsfOTljZ9G08OEzzhIp35jx38Ov+HykNXA
         S7YBi8okE/z/1D7FlQh8nqpvNmA931PT/fzym1ava9jBBOd9VALoxJnAt/nwAxhkxRT/
         zgoyoRGqYR8asgA7Eu54lLYDOyplf9CQ4GHGga65PC32b1Y4DejE5WMDs6imP9sbwmzY
         EHsMO6isE2lJtsYFrrO/MbFx4Eh4S6Y7ILmWCrwandFlIEPFIunD+Nu6ruMFz6kg5G/v
         TqLPKf5yMwznkmEjh+d4O8z5pNnE8yt5F2mv3GG6dXWreVN9Bh9eKpExdpbHl2h/GLty
         pQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504426; x=1754109226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YINGwzP+WQ2B2pLZ+3JU3T3wxECudwibr/z31+tOBEA=;
        b=MMsXWBkLjW6yQNdjDcTgU0VT9ZzoSFEx7CUlzuLxdkmKhflS7Li3gdHkFRex3wYIGA
         BVy2KiYtycAuZ2hS9EZqKQwQV3Z9qay4N9nVRS2RjCRBo/QVYoOewVhLtKHZkATJVmv9
         BWQJRf7sYCO54n1tFMzgOtr7+f/CEJ9tiGMobEre0D/AtexN2TVDsIgd4Y75+eAij/Ep
         FvoiT0o+dvKmBBW87aguRYlo6s2jmeO08/CXOGg6DFnhMEAqUGgYQ1pieuzeD2zZ1IyY
         y4XAfvJHJQ5Zk2jaosq7FrgDWFWPd938iLRc2doHOuXL/7ztIr3HIWZ1tRzA2WAJTFn6
         +yNw==
X-Forwarded-Encrypted: i=1; AJvYcCVbd82n9DnB32CRRhyfTBYYnbC9LIzJX07DvMoSypd7uxbr2xunQuTvDuMrHFXszZJTpkRFlIO1hoo6qc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+lUy492mrp+V5zfM3aKLwpyY53g4Zm6GkL/K8W4HNpVjdh1Oa
	xcv4n+gEcdmG5AQmZ5tfje46Nzz0lr/YQ1vjZr5WME/tBSRQ7vE2+5KCIJUHcg==
X-Gm-Gg: ASbGncve23HWyaUzywSS0IdtQDqREIiMjfePAgAT18rUP6Ke3npnatOymoGz2yjAWWk
	dHhauD7AajtE0XWvLjbSKrHh+/iWsrMv7dqNFej0QOjdLNQdghPEfD0dVVzWFZWgrwu1sIwdLm7
	t5EUdW7SK/UAWJXX1HSZMdi5hAZao00Nm5UwxhROuH1atUvyIHLjujhK9BFcyLi7Pcxs0XphZKK
	3pCDHhh8Ghfm4yLLIlEx3w++8fTW7UzoGbsK0ru88ROepH473kWA/GB/+illTcwvPhqfI2YnZ5M
	hVgj4vIDgns1K6b14p4A03NmGBVFlYojDd7y1tt3XkFsRH5u0tKTJA5ZrAM5L0zaFPuW14lHvPV
	LFiGOsEjxbR5PFANp19MDoLZSKGdf1x4q0d6pMicJDwb89AVAqjQ=
X-Google-Smtp-Source: AGHT+IGrlpeDG+M1XFYNQBMVlA5m1LG8vzAaNYW0s67UXCoEigoyFT+rBXnmZPZoEYP8bDGeD73U6g==
X-Received: by 2002:a05:620a:5bd8:b0:7e3:3276:99f with SMTP id af79cd13be357-7e63bfae1d2mr537840285a.53.1753504426331;
        Fri, 25 Jul 2025 21:33:46 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:46 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 09/20] staging: rtl8723bs: fix indentation to align with open parenthesis
Date: Sat, 26 Jul 2025 04:32:07 +0000
Message-Id: <20250726043218.386738-10-vivek.balachandhar@gmail.com>
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

Adjusted indentation of function arguments to align with the
opening parenthesis, following kernel coding style guidelines.
This enhances readability and maintains consistent formatting.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 692d2526965f..e709a0bd24f3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -154,7 +154,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 		return;
 
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
-		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true))
+	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true))
 		lifetime = 1;
 
 	if (!isfreeall) {
@@ -241,7 +241,7 @@ signed int rtw_if_up(struct adapter *padapter)
 	signed int res;
 
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
-		(check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false))
+	    (check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false))
 		res = false;
 	else
 		res =  true;
@@ -310,7 +310,7 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
 	if ((psecuritypriv->dot11PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.privacy == 0))
+	    (pnetwork->network.privacy == 0))
 		ret = false;
 	else if ((psecuritypriv->dot11PrivacyAlgrthm == _NO_PRIVACY_) &&
 		 (pnetwork->network.privacy == 1))
@@ -391,7 +391,7 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 }
 
 void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
-	struct adapter *padapter, bool update_ie)
+		    struct adapter *padapter, bool update_ie)
 {
 	long rssi_ori = dst->rssi;
 
@@ -447,9 +447,9 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
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
@@ -1343,7 +1343,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
-		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
 		if (adapter->stapriv.asoc_sta_count == 2) {
 			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue,
@@ -1442,7 +1442,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
-	      check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 		rtw_free_stainfo(adapter,  psta);
 
 		if (adapter->stapriv.asoc_sta_count == 1) {
@@ -1768,7 +1768,7 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 	if (mlme->assoc_ssid.ssid[0] && mlme->assoc_ssid.ssid_length) {
 		if (competitor->network.ssid.ssid_length != mlme->assoc_ssid.ssid_length ||
 		    memcmp(competitor->network.ssid.ssid, mlme->assoc_ssid.ssid,
-				  mlme->assoc_ssid.ssid_length)
+			   mlme->assoc_ssid.ssid_length)
 		)
 			goto exit;
 	}
@@ -2010,7 +2010,7 @@ static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
 
 	for (i = 0; i < NUM_PMKID_CACHE; i++)
 		if ((p->PMKIDList[i].bUsed) &&
-				(!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
+		    (!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
 			return i;
 	return -1;
 }
-- 
2.39.5


