Return-Path: <linux-kernel+bounces-746616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8149AB128F8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E694E3F90
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353FA217F34;
	Sat, 26 Jul 2025 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOF2BytB"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1435217654
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504431; cv=none; b=LVXQJShDOHz4ffk4SsMX/CFn8VdWFLJA1PPgvookfnrFKm0Es2WUxv1lxHN1/ALBjcKH0OLT5elJM2baHPoUR8bq4drHMYvWHw1qDYHmBMfChodqLVXVpR7kw134cXafokBbk98GVDc5/KdG0XM1wA+5ewQRCa2q7gx9fpInjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504431; c=relaxed/simple;
	bh=EdxnZO1mKNHaUo/FDta0WRFmI4czY7CItQeP/9UpgWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWkpVUW7bfGMzpxxyGswGztob7Cizv2cd0ZM++RqhgDbnHiExQX2vUKQHt5PIW8TFWun+ZUmPxTChvhfcEvCSkyb6EKaiUtrykHug2ozV9/2kUMRKzgvxnC2oxSf0O5IiNJITs+/5B9xhv7PlsCJHMTMPkHGR4VHFe5QezfKvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOF2BytB; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e32c9577ddso293916085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504429; x=1754109229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsGndhJCxr7LdkFb1HaNLZopmDj3oLL9w7okD1l9Vhs=;
        b=EOF2BytBYxKGcBwCb8Jw2UHwiFrNjLQyNBGBLyEWI9d/f11bSkdwYSrrGKpiV7DZ9T
         z4sD0NW4u1UtnPv1+qOjAjB3W+9TUyajt4LZM8LHOaVnNrr3ewTy3Aw+hZBpZd0ap2fI
         BbqVOqtTEZ6gYBg4alfLw45ufsOnLjbQ5da/xL7+ZGmoXKsfV5sFQ9ib6L2y35Ewtopy
         8Vnzaae3hbmwQO9+WFRD4VvKhvn6nsRPB615hfF7EqcfOp0OYAxJInbJHfjN1yiGyOs5
         K7LYXHxPbhiZ68u4Tzh5N9uvAJzba5qa46Cr8HTAkXhmcUuAlYa3zdDF3T4635CW8ldz
         izJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504429; x=1754109229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsGndhJCxr7LdkFb1HaNLZopmDj3oLL9w7okD1l9Vhs=;
        b=sz0G/QziXMU98hLHsJcf869IJmNSW7BeUOVBS2JbEz3baQZVIyLUpozepLi+p/CNkf
         iu5YWxLJ6NWyMAeARmg1+MJxLp72bdMZKtNpBrF4W/qhQQmy0xjEsbIwXNERYR1egWuo
         PYttYx4VMdehn29iH59VpALKH/KQKwZM/tHOkg9eKwCA4GIpVgv2SzXt65RAXDQIqFf0
         xTPsso1GtMwoGRPXoSpm0B8H1scmEYEzPcLIOQVYgHyYhvF2tl7AzOvUZAI/DMWI7cmJ
         5ij+olGK8zKQc6nYM3MkNQLflkQ5yiqu6SXEL8wt6QLiZHVfXA7GIU5yGBTH4cPeoIFF
         WXKw==
X-Forwarded-Encrypted: i=1; AJvYcCWPSEWOl8vQxAarS/Q1vlA2ITmBtvqZA/mW0d9BHVts/2p9+glaLm20sZp/rPULzwgloxl2rwO9SkdyJ7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf09STJWawcSm732fhIUJACwz5xd9Hmv1YVVjuEk0IkxIDI8wp
	wYF8HEILsttT7blJSq5iA1bZOEqJ0P2OUSVlU94a9xlEd/Mj2CkaUsst
X-Gm-Gg: ASbGncu3turuCaqAGF3sSVdtnJjJ8SiEkibbDwYBMVWnw0Y9M5or8kH4iDeEoL6f4f1
	i4Zqga0P95RcLiwkW6fnigPKON2VxtliHTRLJcvhIJ8wCiObfHKe11ELZ/XYay4hMkZQy2uggVM
	y9n2hNkZHvEKDu3gG+e5hymH2CUiuY+CXSQt9rMOfe3TSD7tf+cMHsBQZ7zA7UEXs+CiOaM6CIH
	OnmL2n6EUyaGLRvhTODMl5h6uJi2/Gn9PHAY2EAZLVDYmBoksUxT7cQ0EU97sW6+/B6PuRVtrTS
	5YOS8/Wk9IxNRFdF64V9vK1lGsPVurX9c6LomgfvFgO9+oZ9Iah9zeaKI4BFXDlYrDbHZc7av40
	qENxF5fGbG69PRZGRmpVPXPCGLg7QxolbhvalD2bUbocVBF8V8CQ=
X-Google-Smtp-Source: AGHT+IF2+YIkjcc41lC9v8+3waLzCwcvEeYt2B9BhrVe0lQnXFX6zEQdSM6Kzv0Z4ZzooYHlZ1Hn5Q==
X-Received: by 2002:ae9:ee18:0:b0:7e6:2faf:883a with SMTP id af79cd13be357-7e63bfa87c6mr386323785a.29.1753504428742;
        Fri, 25 Jul 2025 21:33:48 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:48 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 10/20] staging: rtl8723bs: adding asterisks in multi-line block comments
Date: Sat, 26 Jul 2025 04:32:08 +0000
Message-Id: <20250726043218.386738-11-vivek.balachandhar@gmail.com>
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

Formatted multi-line block comments by adding leading asterisks (*)
on each line, in accordance with kernel coding style guidelines.
This improves consistency and readability of the comments.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 33 ++++++++++++-----------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index e709a0bd24f3..161f149bf244 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -188,10 +188,10 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
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
@@ -293,10 +293,10 @@ void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnet
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
@@ -462,8 +462,8 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 }
 
 /*
-Caller must hold pmlmepriv->lock first.
-*/
+ * Caller must hold pmlmepriv->lock first.
+ */
 void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *target)
 {
 	struct list_head	*plist, *phead;
@@ -496,7 +496,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 	}
 
 	/* If we didn't find a match, then get a new network slot to initialize
-	 * with this beacon's information */
+	 * with this beacon's information
+	 */
 	if (!target_find) {
 		if (list_empty(&pmlmepriv->free_bss_pool.queue)) {
 			/* If there are no more slots, expire the oldest */
@@ -1794,11 +1795,11 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
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


