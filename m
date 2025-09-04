Return-Path: <linux-kernel+bounces-799727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF68CB42F8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0961A7BA70B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D362248BE;
	Thu,  4 Sep 2025 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DluuRg/L"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086F21638D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952115; cv=none; b=jR44x1VLgKGkG0H6pG4IVrfrC1QJzfjD5Dg/7SNw/qWf4sL/D/6HEXJGPlYkIJ7kXtxEO4ED+fmkYxqrBfNgZd3aofK8Fzr/JrMhfFdz1q8l5aJki1xVcYmxegc2Qa1mWgCHkwb14PcYm+51GFIp/he1YqSY/T8tw7SQacJ58N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952115; c=relaxed/simple;
	bh=WvsYf4htlmaRnQimGmB6zOdcA6l8TLaYGHRCyCVqilw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QW4Ftk4Je9JRquEzf0Q35X/+i6cQ5XtqVEeoQQxuvmyfbemcEwOwKTVn8khOo+4ABgN4jgF2yW7Q4g5/YRfxntLTFGKyNVY8xRHlybZY6Dva2FDNmuclFzOZqqQUiZVvAX8+iEg0PZhqp7Ekr+sw7iMyAXDXk8pSHfn3x+/rMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DluuRg/L; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70dfa0a9701so5859296d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952112; x=1757556912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgytSi7eWruZ4IgCQ9+woJWiBKve9B/1Gpbx5IGpnoY=;
        b=DluuRg/LPzdvkX3FPfoeOxydyj8QzArxxpKGc6ysgDxp01rXf5lrIRGkNFMS2DiyU1
         KBSQUp++gfZM4eZOWP8rgYO3B2EASjnLnkl+fw9hFHXrL7prfzmdkOXzdCU+/CESoTTo
         0illcF1X0UiBuJwD6A54vf4vpKmRZXK49fQMzewQRyl2cCT4jsrgr3gG9jSiK7Uie0A8
         OkHIm8CRYe1iohlHPcqudAS+yxwPtQWDAv8gfZ+aPKP3fDH46ePyEHjSp1NkrKzseYMG
         PY7yENgYuZF+gB9VyQ5PiOS61Gsvacu83zdi60/hYoJXUonNtc3+NVS6HZRlVg5UQSAE
         wYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952112; x=1757556912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgytSi7eWruZ4IgCQ9+woJWiBKve9B/1Gpbx5IGpnoY=;
        b=BAw0Aw8MbS70xY8/A7mYAaucIFcxUXTnAyK9Q3l0aeiVApza2msh9KNF23qRHnk/ID
         T3tHaxBI79rQKmjOawqZAOPHH9PR6jjx7FuHalUk+ah+OhjXLsZkkwShyC8QczmWj2Xy
         4QhQ8lwdKH19qVdW1XiYocbAgJUaBKHcpcEOZe78sBrMD4wtIDd2A+55HfRaKHlCZseN
         F/luPgXv28SIkmqcuk68Y+ppNNXURSt1AjUdv0fs7XKvWxseIPFjtdrpwaHho/pftynw
         6bimCv2f4uFK4Xsv4DywbHJavf9TcgY0BRdAKQ6hXIDgT/vofcSQBfkWYLwCwkseE6eL
         SRRw==
X-Forwarded-Encrypted: i=1; AJvYcCUkThjGSq9cUnYryFxRo6x5APPpsVp/cZj6ENc8YBYm2iAVKfF6DL9GcFNUXy7zjSY0S3fPVxnz9Pi6Nik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZj2lPITMzD0zsyPhs1iBrPO5TVzzKZADFAJhTvm39fjm1f1g1
	+Y6Sn+h0TkpRHAX/ky4Z6OqQMfRJOfJXHyctyectynMK7z29GcAcsYqa
X-Gm-Gg: ASbGncufCyKppSKpIz5pvOKMxytu5P010KqZvKaNkvj+5IAWLpvtcUC1n4rDtDyn7u7
	BCrqmSVdQx5wE4r1c7SM6E+Qd0ox3dY8Byb2qpEaxo6pzDpe3qnEaIh6TWr5N1Pptt7b1q2l3rX
	b/uiwuq3R/PxVy2UXDYiVFy4TkCABf4+8OK0Hv5SpiOMZTOMM8vu3Ygm1GJzum1BIpJ9j4pXzUn
	4uixunUlbFPViBxVREFmTMrViTAXioPqkoM6Po7VDLfMo9JOprH2OxsCGw7lyWC6pcxGB20Vy/r
	Ea9cctdYZji6cMSY2W4S4XU+yHvyXZl9ny7XIA6GJ9X/tFeR9tp9X1T0JzvQCtxHhWIfydLOEIu
	/HqVRAVvVMPGsNqw7Cnq2Rm+CrXByK/Tk0KeQwiW8YL1ixTc/IeY=
X-Google-Smtp-Source: AGHT+IH7XVMZzkg1jb98CxCDa1Hsqg+aNrQL0tORQU6Tn6SKAs7whG+6Fq5+0Mn0Xl6S5DwLgMBR5A==
X-Received: by 2002:a05:6214:1ccf:b0:70d:fa79:baf0 with SMTP id 6a1803df08f44-70fac88e924mr217252246d6.38.1756952111913;
        Wed, 03 Sep 2025 19:15:11 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:11 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 07/16] staging: rtl8723bs: adding asterisks in multi-line block comments
Date: Thu,  4 Sep 2025 02:14:39 +0000
Message-Id: <20250904021448.216461-8-vivek.balachandhar@gmail.com>
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


