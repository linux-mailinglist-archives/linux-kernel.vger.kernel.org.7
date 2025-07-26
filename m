Return-Path: <linux-kernel+bounces-746608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D9EB128F0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B7117A050
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78241F2BAD;
	Sat, 26 Jul 2025 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsjqXTc7"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D21FECB1
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504409; cv=none; b=EnxtC5LKAmCpyPDLEUpLcYY2uREc33jm2VS0x6U1jC9x9ZTcVlIijeOR8zaKZ5+pJKFJUoFZfYIhD8lkGDfdNCF7+VL8Id2NCDjRdpkmupdDK+8MFnT0pSZyGsz6h9M19Fi8qUYAy6T27EEY1Sf9fmBaxDryIEHbpl9kYiUbVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504409; c=relaxed/simple;
	bh=QR+87MBsf4OgmCpwKkmvsTI1JdBPdhj46JPSf6Yk5t0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=je0bCQK/46KBZcSkHVBMxIGJe16CbJPJqo7KikPp+WMlO4PCIy7wjG6r7JzY7EinY5U2STnD/h4YDwSkoCAgxFJHJH/ZGWYIJ6Ptd2ALMKxzvo4kgDHrysL9u3RmBP9rGIARB65+iqOCPYM7pw7FLoEQRsgYgj454DKRUqcE7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsjqXTc7; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7dfd667e539so297720685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504407; x=1754109207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6hYRrHT08oHtqOMqL9kRQfmrIHgkckvZt+rGGA91Bo=;
        b=SsjqXTc7Qmy8dmDku5XCFT8HCoLG92wgERA640RQyldzRDIowuCeM1N2w/PpvxQpRM
         1fvTf4SprH6c8Vbj7qYE0j8SSVtDrqYHBHRXIwoN6JGq0qhYW0XcNy84cLRPr+g+CXYY
         jLweTS6z1mAee4t+QrHQK09PafajZ3Xxy6p6a0543Oz6yGFh5NlmFgtxTzLNRZ6Bqs96
         Rk+UKIPfJ5ChiK9S/x6asJ+4WQHVD31TkUWVQciSPNjgjPt0lUORaLfsA7UTBwwc0geV
         AMGKnlj6wteTOypKNRwu+WyxyEdcNsOEDSWLs/NheSEvE/gjQTLygU2A9xaWD8ysXr0Y
         610A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504407; x=1754109207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6hYRrHT08oHtqOMqL9kRQfmrIHgkckvZt+rGGA91Bo=;
        b=G0QNEDKwtqaZrz8D7V01wyqUzUsob8sczNUMMsyHNPOcx4kCFXJDe4kYwsEMZnn4Nk
         Dqf46uf3p1e3r7cAD0WGar07b1iB81GHFUXJSqRITPqGEpu+JaRsEeAbvrwsd6A9MQN6
         Nr4Xc8SXy0CxylYykYcR1Wp2EDl1y6k6WXG303Zx9mGTVzGjPSfB54y/op60oVQuhne1
         Yot4Np16hKZjDg/w0GzwLwMlv0HlsV6rrKLbU+yzp3uiVXktL9x3/ieQclymnu8PU47Y
         uizX06+bAXMCXvNHIlkc9sknLfHTbNq4GlkCdyoGVHH96TmIwbnaUFuY/pY5UnzLYRT7
         rvYw==
X-Forwarded-Encrypted: i=1; AJvYcCUiT/DUno9qF/36WYwSMPXQ1piW2ztH+wQnCiLlY2Z4Ia1iyYu2A6W2/b3c4I57CxHkZivoQ3FaJt2L/tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpaALHF4zBNvqg3xik59S1f5p4Y1LyFmdg+YKHEMZOd6tItQc7
	+mjQyn2WdFfsmSP1Wilnl4uZktIRdPzJyQg/FRB3xhszbVGZTrqyA2M/
X-Gm-Gg: ASbGncsKVA4bgUeY7adjom8cmeh9HtW3u7Ksu53mDPAy51ioBrTeZ5VbdCdv768zBO8
	0Q6ybOIzmN/klpoDVsYGR9+JlwfPbg0QHQzhDilvGn9jFQVMi6OOwqcnCahAGT1IpUqC/lwB/CF
	yV6GDjLKbZte/Oiem6Hytfu/RTIXSeddzgVKKZQh/ii2tEwdiPYB2jL3UrORobptH6wG8Lu1zx9
	NDNVH/jrrx37nmNyaeMW92hXWkjpXg+mu1CI6ix+aeXdk30aayN2PH/yQiydSQrU5YG9lHJRaVd
	Q68FOImLkQ3zNEgZou2zHTaM/U3uBqcZDECiWIDQPKsWstfwjp9Eh+JRRzLgzsvdnCicCgmpyPX
	L7is5RH/d/fAiTN/uDqN9CrTvL4jA+szcOOqpDb2xpo+QPbjCG5I=
X-Google-Smtp-Source: AGHT+IEvB5myWSkGQX6iGwDteC2wCyMcHleORlGWo9rIqgfFN+b9ih+3L+ScgvxVYpyZvv0tbfjIqQ==
X-Received: by 2002:a05:620a:2892:b0:7e6:21cb:c331 with SMTP id af79cd13be357-7e63be53012mr611666385a.5.1753504406978;
        Fri, 25 Jul 2025 21:33:26 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:26 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 02/20] staging: rtl8723bs: remove unnecessary blank lines around braces
Date: Sat, 26 Jul 2025 04:32:00 +0000
Message-Id: <20250726043218.386738-3-vivek.balachandhar@gmail.com>
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

The driver contained several unnecessary blank lines immediately
before or after opening and closing braces in function
definitions and control blocks.

These blank lines break the visual flow of the code and violate
the Linux kernel coding style, which discourages superfluous
vertical spacing.

This commit removes the extra blank lines to improve code
consistency and readability. No functional changes are introduced.

Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 29 -----------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index da64d5714237..24e505111f1f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -170,7 +170,6 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 
 void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
 {
-
 	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
@@ -225,11 +224,9 @@ void rtw_free_network_queue(struct adapter *padapter, u8 isfreeall)
 
 	phead = get_list_head(scanned_queue);
 	list_for_each_safe(plist, tmp, phead) {
-
 		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		_rtw_free_network(pmlmepriv, pnetwork, isfreeall);
-
 	}
 
 	spin_unlock_bh(&scanned_queue->lock);
@@ -318,7 +315,6 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 		ret = true;
 
 	return ret;
-
 }
 
 inline int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
@@ -348,7 +344,6 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 			(d_cap & WLAN_CAPABILITY_IBSS)) &&
 			((s_cap & WLAN_CAPABILITY_ESS) ==
 			(d_cap & WLAN_CAPABILITY_ESS));
-
 }
 
 struct wlan_network *_rtw_find_same_network(struct __queue *scanned_queue, struct wlan_network *network)
@@ -380,7 +375,6 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 	phead = get_list_head(scanned_queue);
 
 	list_for_each(plist, phead) {
-
 		pwlan = list_entry(plist, struct wlan_network, list);
 
 		if (!pwlan->fixed) {
@@ -389,7 +383,6 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 		}
 	}
 	return oldest;
-
 }
 
 void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
@@ -424,7 +417,6 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 			sq_final = dst->phy_info.signal_quality;
 			rssi_final = dst->rssi;
 		}
-
 	}
 
 	if (update_ie) {
@@ -486,7 +478,6 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 		if (!oldest || time_after(oldest->last_scanned, pnetwork->last_scanned))
 			oldest = pnetwork;
-
 	}
 
 	/* If we didn't find a match, then get a new network slot to initialize
@@ -530,7 +521,6 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 				pnetwork->network.phy_info.signal_quality = 0;
 
 			list_add_tail(&pnetwork->list, &queue->queue);
-
 		}
 	} else {
 		/* we have an entry and we are going to update it. But this entry may
@@ -591,7 +581,6 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 			return true;
 		else
 			return false;
-
 	}
 	if (adapter->registrypriv.wifi_spec == 1) { /* for  correct flow of 8021X  to do.... */
 		u8 *p = NULL;
@@ -868,7 +857,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 	pmlmepriv->to_join = false;
 
 	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
-
 		set_fwstate(pmlmepriv, _FW_LINKED);
 
 		rtw_os_indicate_connect(padapter);
@@ -876,7 +864,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 
 	rtw_set_to_roam(padapter, 0);
 	rtw_set_scan_deny(padapter, 3000);
-
 }
 
 /*
@@ -929,7 +916,6 @@ void rtw_scan_abort(struct adapter *adapter)
 	pmlmeext->scan_abort = true;
 	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)
 		&& jiffies_to_msecs(start) <= 200) {
-
 		if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 			break;
 
@@ -1022,7 +1008,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 	}
 
 	return psta;
-
 }
 
 /* pnetwork : returns from rtw_joinbss_event_callback */
@@ -1397,7 +1382,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
 	      check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-
 		rtw_free_stainfo(adapter,  psta);
 
 		if (adapter->stapriv.asoc_sta_count == 1) {/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
@@ -1431,7 +1415,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			if (ret != _SUCCESS)
 				goto unlock;
 		}
-
 	}
 
 unlock:
@@ -1490,7 +1473,6 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 
 		/* indicate disconnect for the case that join_timeout and check_fwstate != FW_LINKED */
 		rtw_cfg80211_indicate_disconnect(adapter);
-
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
@@ -1540,7 +1522,6 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 
 	if (pmlmepriv->auto_scan_int_ms != 0
 		&& jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time) > pmlmepriv->auto_scan_int_ms) {
-
 		if (!padapter->registrypriv.wifi_spec) {
 			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) == true)
 				goto exit;
@@ -1673,12 +1654,10 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 	phead = get_list_head(queue);
 
 	list_for_each(mlme->pscanned, phead) {
-
 		pnetwork = list_entry(mlme->pscanned, struct wlan_network,
 				      list);
 
 		rtw_check_roaming_candidate(mlme, &candidate, pnetwork);
-
 	}
 
 	if (!candidate) {
@@ -1770,14 +1749,11 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 	phead = get_list_head(queue);
 	list_for_each(pmlmepriv->pscanned, phead) {
-
 		pnetwork = list_entry(pmlmepriv->pscanned,
 				      struct wlan_network, list);
 
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
-
 	}
-
 	if (!candidate) {
 		ret = _FAIL;
 		goto exit;
@@ -1863,7 +1839,6 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 		adapter->securitypriv.key_mask |= BIT(psetkeyparm->keyid);
 
 	switch (psetkeyparm->algorithm) {
-
 	case _WEP40_:
 		keylen = 5;
 		memcpy(&psetkeyparm->key[0], &psecuritypriv->dot11DefKey[keyid].skey[0], keylen);
@@ -1939,7 +1914,6 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	}
 
 	return ielength;
-
 }
 
 /*  */
@@ -2311,7 +2285,6 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	}
 
 	return phtpriv->ht_option;
-
 }
 
 /* the function is > passive_level (in critical_section) */
@@ -2346,7 +2319,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 		max_ampdu_sz = 1 << (max_ampdu_sz + 3); /*  max_ampdu_sz (kbytes); */
 
 		phtpriv->rx_ampdu_maxlen = max_ampdu_sz;
-
 	}
 
 	len = 0;
@@ -2437,7 +2409,6 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 			rtw_addbareq_cmd(padapter, (u8) priority, pattrib->ra);
 		}
 	}
-
 }
 
 void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len)
-- 
2.39.5


