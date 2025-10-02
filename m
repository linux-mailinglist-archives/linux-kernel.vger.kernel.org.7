Return-Path: <linux-kernel+bounces-840553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45415BB4ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F161C0E5A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D8826FD86;
	Thu,  2 Oct 2025 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiDjafsl"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604D826F46F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425843; cv=none; b=rZB4QSqdntyW+FzQDY7c14h0R9b9zUuLewKfyRZ4QDJOMroWEpKPcrWnmBi2FzmmBY4p8EMO+bU6H+f6a8Eug6h6nKHuuUSmQeiq7rpZrEU4ktx0yNdKO0/x4JobVFhBtoZRtEHMpaIy7I/HeIMt7mYL4TwitodxmzAXJURHNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425843; c=relaxed/simple;
	bh=XLMY6ExyY6u6fV0WN7Z3qcEwjCdaVTdq/bJcMA4pmIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YNoI48Lo8PmrCToQJO56Xd5cP1xoZAF0PlWl9Xx/c3+7IiLU6S1xCwbQ5TaxOPX7oHQmcR7IvS4RZ+0fTakWlM8Qp8AtUE07mf2oNio+6s+2t8X1zLzYkIopQNG0XtUv7iTT2jbr6HPKxUXiRS2zQbLPM/lt7lHb7bL080Geb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiDjafsl; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4da894db6e9so11447501cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425840; x=1760030640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoZMG2H5XFtwBXCa7Edxt/CDBvIRhOXOvs0bduMCYtk=;
        b=RiDjafslA/0B7nOHyz1uFHgAuyJQ87HTudXxa/Cb5ehPYb6eQmG5fV9lW0UdZO3z1i
         19q2VBf1zfWxwwWPicjueDfwS9p8Oo/NLhgJMeHl9Ks+yIBzKuMXt7Emv4Bhj60mrRGY
         ZYtaUfiSnnVWCLwhyumaHZihbD++Bbo+/VR1TU1koBKjUAjwzgYd0QE1U3l+eFg2OkRC
         Rr9z6MRwgB5tzhrxAqJk5P9jJ++2OCyi4DcOYo+lGgbLd6m2HFULxbEJgZZLHh85n68f
         P72wKOcOfAyzp5FMcumJ9hiQvqDchHmAR84WaM9LK7UFDzK0pPnBoyVJeXMNtc2ggvcX
         bdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425840; x=1760030640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoZMG2H5XFtwBXCa7Edxt/CDBvIRhOXOvs0bduMCYtk=;
        b=hvLzfNOKW/vtIWYhSuTU29VlUADB9RDSOX68fQV7nMF94/ADYulXRoNYqZuZXiXNrs
         oO+iEQaUxmre0Lo0T3F1DP9C+upQ8BkH4LK5uc+wFcNMlVo1t+l+AMT1s3AD1EDkIpjq
         Zn7acinC32uaBObJemn8AhH/HOQRXCSfAvZGSt/SLa2xWij9LbkGyeHdh0AyhK+PwCy2
         u7CtxzKbZR88CuY3UyaH0s0szWosT5GIBF4W1vYO2uHXG5i7l4846JfV2Vi9cVS/u+rY
         onUe4UimURD6AvOFLz/QdHTeGdvJipulgyBEo0YZ7T4M+C6kH1T8xqplAgW5F4swYTMf
         0EQA==
X-Forwarded-Encrypted: i=1; AJvYcCUOKlkXiqYbR11KEVIlMpTxmpar9WIZ5dDfKq0ok1RzfvPLH4vZNXUijk6FVPw7d7ZYDae9lWD/OxnJRjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypdDx8kHlgYQ4y5Bn0bRB6jtYgeVH98+xI0XhO9xI4Fm9y8jYz
	tZQGMxf2U06ZlZunb/Bb9ZU7fLssXjD4RKTjWH8SZ+ZZaPbMsRjy6Hft
X-Gm-Gg: ASbGncscihnB9kofvu3HQDZFndtf7qxlpYqS6SkKM4fE8CUwyo7bJm9RzlAtfn35WZY
	bKuG9EcUXcTyulNIkitsSWiNmfIaQ2evPB0WUaWTZLXsc2o0RpFk8o4Aqr58PXKRg27vHJrLKPy
	LXW9MBmH0p5LegqwZcq6uRp4tHuab0tjaL5VASplCqTHYD0uyW7xpXyl8aenptHrgr4sJMTviku
	7cV6PRfPyxp50ZZnmu7dzlVgi7tQtPVwvB3f+DOg5YIYXGbbinAv5LLo24nzDmvzy02RL+dcVOe
	9kT/G01mpEfJlt0/kKvljDFoojJvNZ5h8xZVgGFP84p5SfvKXunwwoa7065EBOzS2MKKg2/GLZa
	XZ3GT1HUts63JFYYF8lJ/GzdGCxrTdaPdxuQLZYShdaouAi3gRoGFv2Zwt0OcJzXezubk68RL0/
	U=
X-Google-Smtp-Source: AGHT+IEb9ym2sEaLOwaU7JZLamaTF20zBlWyIBwnY70sa8szndTtJluJszAmcJXuglcryN7DFe8gZA==
X-Received: by 2002:ac8:57c3:0:b0:4b5:ea1f:77ec with SMTP id d75a77b69052e-4e57697253bmr1853621cf.0.1759425840226;
        Thu, 02 Oct 2025 10:24:00 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:23:59 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 07/16] staging: rtl8723bs: adding asterisks in multi-line block comments
Date: Thu,  2 Oct 2025 17:22:55 +0000
Message-Id: <20251002172304.1083601-8-vivek.balachandhar@gmail.com>
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
index ba77040a8d8d..ac313ec06587 100644
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


