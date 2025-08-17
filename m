Return-Path: <linux-kernel+bounces-772353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC93B291AA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 07:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BEE1B25EF3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 05:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7561D88D0;
	Sun, 17 Aug 2025 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgXKvwz2"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5D3194A60
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 05:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755409335; cv=none; b=YSc5nkhwBM/k+FYBQXddjS5Y5WZZIYw3cUAfdhFsY2XiYS8S8zDnqMgMlZXtCE0+kgt9zzE6k9lf9Y8KI4cxfSkIocstWyEqNnIuzVmDen6o2E6/HBqg5Dd0Rne3sG+zQdR8A71nUcjbtPN6lhf6nAO8mcRc+ICjC9PIw/hICns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755409335; c=relaxed/simple;
	bh=+Z/mYmkjlGyP67pyAOekkR7e7NjNa85sfzlsmC09o7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XnKrZ2C12GM2ApxvBh1D0wrpnqlkmbwoSKaxox9pfm9HvNrJZnM4WftuiEohLZWQLtwy3Fxx+HGN9u1HJQvjZ1+R4LMBjpCVMdpsL3Wy8jWV5jLV5NyVyS0I+Jh5fLGxWa1SLSs372BHAIYoWjlbfla0emhQXYxhRiJSCQ5jDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgXKvwz2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e44537dccso1109723b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 22:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755409333; x=1756014133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lztrOR28v6KPQTHH6JN0VDxNFUFZdX/DljHltjGKunA=;
        b=bgXKvwz23oXhpbUKBaX/t9nibou8LEwReZQlbghnPLpa5SqtUbeDPO2QMOyeiqT/A7
         YWBHwEF9tpPKYZsIVLtY90nj8u2IWYivzM5ylxYZuZXIGOMtR/J0W+WjzPAVMCLgqZNM
         wxeUOO5yFIOtEHRAJ0d3oFvoLW5LGcFIZrXxP3cpGMcU+I51RibBx8aeeN99kRPLJ++p
         FER/hs0EcACeTzWxtqOY13ugDUVjiWOVBUFIHyBQFr0IoyPUnuQMATM7XOGDYh4aBz8n
         5E79KKZvMbJazah7ae8Bc4DCF1FrZ9UyqnMd+1812KAuXJKkeJ/DfyjVUP4tq8SFKz9f
         6TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755409333; x=1756014133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lztrOR28v6KPQTHH6JN0VDxNFUFZdX/DljHltjGKunA=;
        b=kw6Alo+C+rhLwQgogEiIXY/R1uzK5vx9o3UkFDoUfQh+tAXXeiyMQbjrHeKmOiiOMH
         zQZgR32HnoRJR9Je2r+Kkuli5tmyCeG3kZ/Kcw0bJzK28k/hJvVljpsSrdjeDeGSvjtC
         6dgqyVybY9ageOfup94uzrQ2cXYHw0kG3gYTmzQ/tkv7pt66FFv945ksKYwAvXebT/NL
         Jz3ASoP0a6rN6/p9ybGKLwikfPvwEpIKl8RwSKYpL1YTmkqpsdv9hIlgObx/Rm7Nm7Pf
         aycLX3VoesKNaQBLQQOr6qBBzO67Lj6cRcn87h+Xik0K1KlmyBdD7V14cLOQsfu9B0uO
         eHFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9T29HRwobhOBG7ErQW7TT7goDfBL3CeQhSTtCPev84eqZl/MHWjJo7QqVNStCWBOLnCo1NHKOMbHcyQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzsWcjlFsc1nI5sQbBEQbroIYOwZtPyILpVKH5Dse+i9ptgiO
	dcufNJm5QvB6z+3ez5d+LpqrP1+L3FLLHvyXPMy8ZxDT7eyfPP7c1mmwbIvye15krLE=
X-Gm-Gg: ASbGnctKCMDEDoToPEi0/iU/GuyEm9Bsob/cYIjNnmSZIt2I0z2L5PIqJOBZ4cVB3Lr
	FmCWCbneuer/08d62GABqSgvz5NjzAt1q79TD8Sc1iozMHasaPibis0vfPwzcGjd+VPP4DigWzZ
	ligARk+/BSzqne3PyCQpahCLP5CW11zvGk+eA5mjOjT4d1xkvFh71I47rE7x/Ji6HrUzXJ/Th64
	CS/lXIoIGCHxN+4s6zlpm4Cozkul/fgBWAj1dFTNed1Aekz54V0/HjZk+A+HOxgec+Q3Ut9KP6l
	FyumsZY/CeTIyR9einV2E/nBKozuYmrPmaOC+/2B4lxjPSnb1I9CEJXC96129lqIc28DwaIE+vi
	ArE53byHEzU3dSyp3xcfS1t8ObbdnzjXZwBWp+mIJBsRY1Q==
X-Google-Smtp-Source: AGHT+IHEioWaeVG/U1soMmh47oMpljvSROQMIVcpZi5IAIHMOXfqp4999NtwZNER3LhvdbvVOZKztw==
X-Received: by 2002:a05:6a20:1594:b0:23d:ae11:e1e1 with SMTP id adf61e73a8af0-240d302fcb8mr10433573637.12.1755409333429;
        Sat, 16 Aug 2025 22:42:13 -0700 (PDT)
Received: from 100ask.localdomain ([116.234.47.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452663f0sm4374848b3a.21.2025.08.16.22.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 22:42:13 -0700 (PDT)
From: Nino Zhang <ninozhang001@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	straube.linux@gmail.com,
	Nino Zhang <ninozhang001@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix coding style issues in core/rtw_mlme.c
Date: Sun, 17 Aug 2025 13:42:02 +0800
Message-ID: <20250817054202.31171-1-ninozhang001@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes coding style problems in rtw_mlme.c:
- Delete unnecessary blank lines.

Signed-off-by: Nino Zhang <ninozhang001@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 692d0c2b766d..8ec039d832e9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -170,7 +170,6 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 
 void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
 {
-
 	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
@@ -225,7 +224,6 @@ void rtw_free_network_queue(struct adapter *padapter, u8 isfreeall)
 
 	phead = get_list_head(scanned_queue);
 	list_for_each_safe(plist, tmp, phead) {
-
 		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		_rtw_free_network(pmlmepriv, pnetwork, isfreeall);
@@ -380,7 +378,6 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 	phead = get_list_head(scanned_queue);
 
 	list_for_each(plist, phead) {
-
 		pwlan = list_entry(plist, struct wlan_network, list);
 
 		if (!pwlan->fixed) {
@@ -868,7 +865,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 	pmlmepriv->to_join = false;
 
 	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
-
 		set_fwstate(pmlmepriv, _FW_LINKED);
 
 		rtw_os_indicate_connect(padapter);
@@ -929,7 +925,6 @@ void rtw_scan_abort(struct adapter *adapter)
 	pmlmeext->scan_abort = true;
 	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)
 		&& jiffies_to_msecs(start) <= 200) {
-
 		if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 			break;
 
@@ -1397,7 +1392,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
 	      check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-
 		rtw_free_stainfo(adapter,  psta);
 
 		if (adapter->stapriv.asoc_sta_count == 1) {/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
@@ -1540,7 +1534,6 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 
 	if (pmlmepriv->auto_scan_int_ms != 0
 		&& jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time) > pmlmepriv->auto_scan_int_ms) {
-
 		if (!padapter->registrypriv.wifi_spec) {
 			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) == true)
 				goto exit;
@@ -1673,7 +1666,6 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 	phead = get_list_head(queue);
 
 	list_for_each(mlme->pscanned, phead) {
-
 		pnetwork = list_entry(mlme->pscanned, struct wlan_network,
 				      list);
 
@@ -1770,7 +1762,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 	phead = get_list_head(queue);
 	list_for_each(pmlmepriv->pscanned, phead) {
-
 		pnetwork = list_entry(pmlmepriv->pscanned,
 				      struct wlan_network, list);
 
@@ -1863,7 +1854,6 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 		adapter->securitypriv.key_mask |= BIT(psetkeyparm->keyid);
 
 	switch (psetkeyparm->algorithm) {
-
 	case _WEP40_:
 		keylen = 5;
 		memcpy(&psetkeyparm->key[0], &psecuritypriv->dot11DefKey[keyid].skey[0], keylen);
-- 
2.43.0


