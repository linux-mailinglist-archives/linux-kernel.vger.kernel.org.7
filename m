Return-Path: <linux-kernel+bounces-799667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651D2B42EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A44540961
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D651D416C;
	Thu,  4 Sep 2025 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNhIajzh"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3AD1E32DB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949198; cv=none; b=ANW2yBIsdu0Wbjq0DMfuNnvS7OA8pTOn5LzDzGoRg3jKvabyW45z2oBYHMM5+9WnPRbGvh0KsmNwFRENj83tLvJUxMDsssK58l+tdzEu6HnLwIfoq8iUvjsyLIo28Z3CXnWvrpGsTOBMuGkAtGzWKD/MCiZ3znU6i17NSZt293w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949198; c=relaxed/simple;
	bh=WvsYf4htlmaRnQimGmB6zOdcA6l8TLaYGHRCyCVqilw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hy1VABNFyfIr4ascgRcNUKpd1mTa/U/EEiktS8qfBTggPYrQ6gkSZTRWrh2xbLeqxNXRJjlPMV1UuE3zj1ebCsR2+pEnIEElehffmcdyN2hEdVdri4lnenGSMATxh2zpU74o/ZreZ4uIbnUOLXtJ3FD7dfczb7ygmbYpmukE+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNhIajzh; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7282a09a72aso4001696d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949195; x=1757553995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgytSi7eWruZ4IgCQ9+woJWiBKve9B/1Gpbx5IGpnoY=;
        b=MNhIajzhjoLK6A7LGCXkYjWhwLaqytOQBIXht9Jh6ik7Hy7Ci/R/DS+qHajAPWRn9K
         J5ISydeM9kHd1XoceJ7NcGrSVxKc2JNYuRfjzljK2FIuiZyEhuWraAn/03yGDHqrMIGs
         IWMurvcjycYG/WQ89XWfLzddagOJWmyejVC2pHHlyMVuanR5aICBXYRerpx5vGAFmdy2
         FwHz8w4gIVHnVw6EMHPVRDHaJQCuZk/1kkEKj9EBylbDsDAIDycLkRRmZWu6wqTYsuEP
         rx2LRUPgztvaWQhJqTn0dJmoMjXqRi3BeRAWMKlh2upVP4pIZU6q8K5tWdy++bFIhCFN
         dxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949195; x=1757553995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgytSi7eWruZ4IgCQ9+woJWiBKve9B/1Gpbx5IGpnoY=;
        b=oQexm2b9NLBzH18wzpNcruxBE3NG0DdrmH/59/hryHSWY4MYMbg9Elp4oJt+ud28Gu
         7a5AbHQWuXpNwcPXUJabSpk+UZsf0qV8nEp2uO1HZTkzrD0PA/3CLorCPANvpVIdH0ud
         qa4R7IEqPeyonQPRR53lKp4HQMakTH4sLIFAXeGLECqEpg09K7Q7NVuJpK+kNJpC8PWa
         eEmwi5ElZBz8p43o4LUoVXCfBEtr+iu5kh/+IJE6AU14ThmftSnCsmjoEDh6LW1UZUXU
         mHpH5BXrqws6y19cAqDfOiD32LVOPDXweIK9tXhO9w2h5WlPrE8OHIw4lfsNA4NsgkUZ
         vi/g==
X-Forwarded-Encrypted: i=1; AJvYcCXZaB1aZCIRNtaH4YgmY8O7I+pOxdWhnfKca9Adu14Li+9p2XG+Y9qgr9nRS+KguPgTZ3BNW8FGIWqzixA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypCTxU60eZCCJxzUc8nG1wWBG2q8llPiQQ3AG253YvMSY/rOXW
	2Ds4gzTkB2xerIejgx5yTYQiRF98eWNzsXvOeTUawMU2p303r0+2nNNe
X-Gm-Gg: ASbGncszPr97Yr6C7/repa6MzxswwbP9n0pEcLDveiozu45GIsS9xYQnw/2WbOnAwEn
	4SWbq+0ALfD3RCOLX6drmuRyvAF1UsekD+bBZIuxU4Rxl2OL4p+DydinM5wBtcx5RrEvipH8IL0
	qZSsDztWFavsTtXwCUOHreUbauWGPtxJA0zhNLLdN1Q/PkF1kCA/Z3o+ZgVXtF5N+kd6BEBAuck
	UZDQb7BCcdWsA0KFQR9QY3IbL1M89iGQSJOcaB6SbqhC1AKUvMcuCN9+Wa146fzo8MLp2DpE3/D
	zblbBzdm+q4qndcP3fBj1PmdjRyr0pXhS+Erf2DCqzqM9EB0mes5JiOYeVn2IEAOEQMz/IJQRQr
	vROuLkn/PAgOqf7oSaycy/XEUA07HQe37o32nKsiG0k6LOoPheuqIE7/rETp/4Q==
X-Google-Smtp-Source: AGHT+IHUfpDs915pAAEAG7aa0wvPmJUCO/l0dQ740JqmrtcMq3cL4s4Haa/dAQuVyhOuRDoReNLDsA==
X-Received: by 2002:a05:6214:493:b0:70d:ff6b:4299 with SMTP id 6a1803df08f44-70fac9656ebmr157787896d6.65.1756949194785;
        Wed, 03 Sep 2025 18:26:34 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b682faf5sm38423266d6.65.2025.09.03.18.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:26:34 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 07/16] staging: rtl8723bs: adding asterisks in multi-line block comments
Date: Thu,  4 Sep 2025 01:25:27 +0000
Message-Id: <20250904012529.215521-8-vivek.balachandhar@gmail.com>
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

Format multi-line block comments with leading asterisks

Add leading asterisks (*) on each line of multi-line block comments,
in accordance with kernel coding style. This improves consistency
and readability of the comments.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 33 ++++++++++++-----------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 19bf6bb360f9..ab626c88e7dd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -217,10 +217,10 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 }
 
 /*
-	return the wlan_network with the matching addr
-
-	Shall be called under atomic context... to avoid possible racing condition...
-*/
+ *	return the wlan_network with the matching addr
+ *
+ *	Shall be called under atomic context... to avoid possible racing condition...
+ */
 struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct list_head	*phead, *plist;
@@ -322,10 +322,10 @@ void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnet
 }
 
 /*
-	return the wlan_network with the matching addr
-
-	Shall be called under atomic context... to avoid possible racing condition...
-*/
+ *	return the wlan_network with the matching addr
+ *
+ *	Shall be called under atomic context... to avoid possible racing condition...
+ */
 struct	wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct	wlan_network *pnetwork = _rtw_find_network(scanned_queue, addr);
@@ -489,8 +489,8 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 }
 
 /*
-Caller must hold pmlmepriv->lock first.
-*/
+ * Caller must hold pmlmepriv->lock first.
+ */
 void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *target)
 {
 	struct list_head	*plist, *phead;
@@ -523,7 +523,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 	}
 
 	/* If we didn't find a match, then get a new network slot to initialize
-	 * with this beacon's information */
+	 * with this beacon's information
+	 */
 	if (!target_find) {
 		if (list_empty(&pmlmepriv->free_bss_pool.queue)) {
 			/* If there are no more slots, expire the oldest */
@@ -1891,11 +1892,11 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 }
 
 /*
-Calling context:
-The caller of the sub-routine will be in critical section...
-The caller must hold the following spinlock
-pmlmepriv->lock
-*/
+ * Calling context:
+ * The caller of the sub-routine will be in critical section...
+ * The caller must hold the following spinlock
+ * pmlmepriv->lock
+ */
 
 int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 {
-- 
2.39.5


