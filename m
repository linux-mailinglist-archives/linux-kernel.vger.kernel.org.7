Return-Path: <linux-kernel+bounces-773952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A884B2ACC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426197B0BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B579D2580DE;
	Mon, 18 Aug 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9jRvbPC"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDC24A063
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530994; cv=none; b=aUEh1vHpDHfnCZKvo49Zq67mb3DAYTROkjS7UA/+6EL+y0R3JBx2dDp6dIcdg/Wzc+CNAGJQH4GT42V1sru+/YsDVMs8/W9dbtafr9BOe0bRZ3LQZ+5BBpdCUF3T4WROaOpRNYqeiKzh0T5xpI0IELKrp6Um+JZpa4iN6Zzf3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530994; c=relaxed/simple;
	bh=yriGlQzcEMLleh7mWxR7vFguMsohOZ68CFtpSpS6ILs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DL6YAZLuKt1kp2PsaZxp3GZUa75Lh0d4eCAhB2Lv8K3/j7Cg+JfWFfyFiYRwULv3m362NsJAEM9Rvgk1OLr1ot3ORyjlbniVbKu/nxnmkvJxK/P25rk7Qc7mImrcJ1yvvLZA6+uYy+ENuuPwfJJEAU+zStmheLmYObhFvmW7uhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9jRvbPC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323266baa22so3304918a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755530992; x=1756135792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmAzhKxgIoC4PtMsSkpfRCV+yrZcsGB0TsbomWCMnMA=;
        b=m9jRvbPCKvxgvzf4IxINOy/Cl5q/baYyQwkMEyW7/RsEjiTLPjI5VNAkgdUSzNSMmq
         94WMwhcqUMBWAth9j4nb+cM3I0ZYA829GySsk5AlwqBvXiYmU0f8wkePuH5Lz1wEzwHS
         utY3GK47CuHwKV21YsI1/8d5NJsw39s38b3lGi5gP0F8DukHUxKNKOCuhGq5UK3y8TpR
         f75Kdlp5gxrI1D35TMwxOvj6gmvIqFYeimhge9Vqors8qcivgd3xyVJG2EOzdfsywgyD
         tBE2HnGFQZBJQcWyy96TF+dXjZw+6J8qezEf8NRG4IxLejtJ+uBKkWce3SJSi4drIn8A
         Km/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530992; x=1756135792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmAzhKxgIoC4PtMsSkpfRCV+yrZcsGB0TsbomWCMnMA=;
        b=oydFMq3azQRqTipNhG75skdcp6WHZRAT/k31ced3xgSO0c4IDo51mrzahKfJkPC35w
         7xHay0KisGeJ7Tdog/qafd+gnN9lys2P8UU1DKjczHlma4N64xHolxOSavfQx+0mvIN4
         J+RLO0ijI9bFz9TAPjIY5laoGHbmwAapCrCEPGQ/nDbneTFYJZVOun/jXsifbQFWAgka
         4J/r4Wdz0t2xSScXNF4LMg2Zp/OW+uxX3JMYNITzWJCfDTJt8fuLeJrBXIOC0p+aKxCR
         UyaagZtGwcQcy7T+kcE7PcxQL6KGXrKtOLUsVcVfMkbX+X4gA4OAqYpOF3jlJ1Nyy76B
         yHIg==
X-Forwarded-Encrypted: i=1; AJvYcCVhc7CJotIoOoyJ9I/h5MqpPQ0vMifXcOOUoTeWkMCYUK3kWvJE5YkFZflMhxuYmvIZhq7SSHFv9GXmwZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nsTQLLBpXSJoXtkuLbp6zXJnq2vHuU5NSTiGCdLSL6kX+Z6H
	63I7UN5GF2rxY7N+iyZltJnSH4lwwhySLlazQ6QFdOHZFwpIWAUsCnGmdzS7qZurONk=
X-Gm-Gg: ASbGncsmz5VwmqHYqeNhVPhh3TNOJmsDBP/b+YSKHw95Ug0WqwYyjCZcQILtNPK0gYr
	slWhOFYyCz4D1TMrTVirno1eoFtA8+FztK5ytbS/OVnWQKXtxCI1eqyM2K6lIQCKZRohvSPHMkB
	xyy3cN5NVLvQip3ppLlDs8cebOvtEP1HUT7wtBPwqUI6NtSbocLgTNQ0cTx41RPJwRM/K0+njZi
	2XpemIgVAbEsy4nEK7usn4EUOtp8g6wmdWBJMsRh6yatdqNpggBTDgPXlKHJ7Q0V1m3+OarvBcV
	NADNk+71dOOqBn3i+rFKtIyFTUXj0LkJHSe3NmEN5IQ7QgTwfG012AqJphLG9Fkv60IYszuKD8z
	myuyr8cLgQAphDKL/YPsnWoVP/HUjTuQxH262IGMZD0hLAw74HXELsA==
X-Google-Smtp-Source: AGHT+IEIqGhn0GevJJjiuIsFvjkfIr9/VwS3/pEa6Jw90W4qz2RiTCGQkL2o3GnwuHovUN3YYGeaew==
X-Received: by 2002:a17:90b:4a10:b0:31e:8203:4b9d with SMTP id 98e67ed59e1d1-3234dc9ec09mr11916037a91.29.1755530992364;
        Mon, 18 Aug 2025 08:29:52 -0700 (PDT)
Received: from 100ask.localdomain ([116.234.47.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e3ecc64sm288282a91.15.2025.08.18.08.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 08:29:51 -0700 (PDT)
From: Nino Zhang <ninozhang001@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	straube.linux@gmail.com,
	Nino Zhang <ninozhang001@gmail.com>
Subject: [PATCH v3] staging: rtl8723bs: fix coding style issues in core/rtw_mlme.c
Date: Mon, 18 Aug 2025 23:26:41 +0800
Message-ID: <20250818152641.106740-1-ninozhang001@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix blank line issues in coding style:
- Remove unnecessary blank lines after an open brace '{'.
- Remove unnecessary blank lines before a closing brace '}'.
- Add missing blank lines after variable declarations.
- Add blank lines after function, struct, union, and enum declarations.

Signed-off-by: Nino Zhang <ninozhang001@gmail.com>
---
v2 -> v3:
- Fix the email format issue reported by the bot of Greg.
  (https://lore.kernel.org/all/2025081850-carpenter-radiation-8790@gregkh/)
Link to v2: https://lore.kernel.org/r/20250818071411.90159-2-ninozhang001@gmail.com/

v1 -> v2:
- Make modifications based on the staging-next branch.
Link to v1: https://lore.kernel.org/r/20250817054202.31171-1-ninozhang001@gmail.com/
---

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 29 ++---------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index fdf06b5253a7..c06d990350e6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -200,7 +200,6 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 
 void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
 {
-
 	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
@@ -255,11 +254,9 @@ void rtw_free_network_queue(struct adapter *padapter, u8 isfreeall)
 
 	phead = get_list_head(scanned_queue);
 	list_for_each_safe(plist, tmp, phead) {
-
 		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		_rtw_free_network(pmlmepriv, pnetwork, isfreeall);
-
 	}
 
 	spin_unlock_bh(&scanned_queue->lock);
@@ -348,7 +345,6 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 		ret = true;
 
 	return ret;
-
 }
 
 inline int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
@@ -378,7 +374,6 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 			(d_cap & WLAN_CAPABILITY_IBSS)) &&
 			((s_cap & WLAN_CAPABILITY_ESS) ==
 			(d_cap & WLAN_CAPABILITY_ESS));
-
 }
 
 struct wlan_network *_rtw_find_same_network(struct __queue *scanned_queue, struct wlan_network *network)
@@ -410,7 +405,6 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 	phead = get_list_head(scanned_queue);
 
 	list_for_each(plist, phead) {
-
 		pwlan = list_entry(plist, struct wlan_network, list);
 
 		if (!pwlan->fixed) {
@@ -419,7 +413,6 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 		}
 	}
 	return oldest;
-
 }
 
 void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
@@ -454,7 +447,6 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 			sq_final = dst->phy_info.signal_quality;
 			rssi_final = dst->rssi;
 		}
-
 	}
 
 	if (update_ie) {
@@ -516,7 +508,6 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 		if (!oldest || time_after(oldest->last_scanned, pnetwork->last_scanned))
 			oldest = pnetwork;
-
 	}
 
 	/* If we didn't find a match, then get a new network slot to initialize
@@ -560,7 +551,6 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 				pnetwork->network.phy_info.signal_quality = 0;
 
 			list_add_tail(&pnetwork->list, &queue->queue);
-
 		}
 	} else {
 		/* we have an entry and we are going to update it. But this entry may
@@ -623,7 +613,6 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 			return true;
 		else
 			return false;
-
 	}
 	if (adapter->registrypriv.wifi_spec == 1) { /* for  correct flow of 8021X  to do.... */
 		u8 *p = NULL;
@@ -900,7 +889,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 	pmlmepriv->to_join = false;
 
 	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
-
 		set_fwstate(pmlmepriv, _FW_LINKED);
 
 		if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
@@ -974,7 +962,6 @@ void rtw_scan_abort(struct adapter *adapter)
 	pmlmeext->scan_abort = true;
 	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)
 		&& jiffies_to_msecs(start) <= 200) {
-
 		if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 			break;
 
@@ -1067,7 +1054,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 	}
 
 	return psta;
-
 }
 
 /* pnetwork : returns from rtw_joinbss_event_callback */
@@ -1502,11 +1488,11 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
 	      check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-
 		rtw_free_stainfo(adapter,  psta);
 
 		if (adapter->stapriv.asoc_sta_count == 1) {/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
 			u8 ret = _SUCCESS;
+
 			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			/* free old ibss network */
 			pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
@@ -1536,7 +1522,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			if (ret != _SUCCESS)
 				goto unlock;
 		}
-
 	}
 
 unlock:
@@ -1595,7 +1580,6 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 
 		/* indicate disconnect for the case that join_timeout and check_fwstate != FW_LINKED */
 		rtw_cfg80211_indicate_disconnect(adapter);
-
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
@@ -1645,7 +1629,6 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 
 	if (pmlmepriv->auto_scan_int_ms != 0
 		&& jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time) > pmlmepriv->auto_scan_int_ms) {
-
 		if (!padapter->registrypriv.wifi_spec) {
 			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) == true)
 				goto exit;
@@ -1778,12 +1761,10 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 	phead = get_list_head(queue);
 
 	list_for_each(mlme->pscanned, phead) {
-
 		pnetwork = list_entry(mlme->pscanned, struct wlan_network,
 				      list);
 
 		rtw_check_roaming_candidate(mlme, &candidate, pnetwork);
-
 	}
 
 	if (!candidate) {
@@ -1875,12 +1856,10 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 	phead = get_list_head(queue);
 	list_for_each(pmlmepriv->pscanned, phead) {
-
 		pnetwork = list_entry(pmlmepriv->pscanned,
 				      struct wlan_network, list);
 
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
-
 	}
 
 	if (!candidate) {
@@ -1968,7 +1947,6 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 		adapter->securitypriv.key_mask |= BIT(psetkeyparm->keyid);
 
 	switch (psetkeyparm->algorithm) {
-
 	case _WEP40_:
 		keylen = 5;
 		memcpy(&psetkeyparm->key[0], &psecuritypriv->dot11DefKey[keyid].skey[0], keylen);
@@ -2044,7 +2022,6 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	}
 
 	return ielength;
-
 }
 
 /* Ported from 8185: IsInPreAuthKeyList(). 
@@ -2449,7 +2426,6 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	}
 
 	return phtpriv->ht_option;
-
 }
 
 /* the function is > passive_level (in critical_section) */
@@ -2484,7 +2460,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 		max_ampdu_sz = 1 << (max_ampdu_sz+3); /*  max_ampdu_sz (kbytes); */
 
 		phtpriv->rx_ampdu_maxlen = max_ampdu_sz;
-
 	}
 
 	len = 0;
@@ -2575,7 +2550,6 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 			rtw_addbareq_cmd(padapter, (u8) priority, pattrib->ra);
 		}
 	}
-
 }
 
 void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len)
@@ -2616,6 +2590,7 @@ void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	_rtw_roaming(padapter, tgt_network);
 	spin_unlock_bh(&pmlmepriv->lock);
 }
+
 void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.43.0

