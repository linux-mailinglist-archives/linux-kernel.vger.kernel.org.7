Return-Path: <linux-kernel+bounces-835842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC5BA8308
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DAC3C36E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DF42C11CC;
	Mon, 29 Sep 2025 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY/jI+zV"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275932C0F64
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128646; cv=none; b=F1FzK28haCXfeh25WmfLd5CLmQ/w0DtaoqaJMMRM7M2ceI0J77tFfpf+R3+XYcDBVBaE4jbl03VB+hCfYrqkQXx2dQwuR8IYquBTTUJt02svT/ea9NA/gJAsTLbdFe0/ShVCbZX7rrwbfzXYrnKXMMdxctLzUzWM5aE7yRywcEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128646; c=relaxed/simple;
	bh=WvsYf4htlmaRnQimGmB6zOdcA6l8TLaYGHRCyCVqilw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=giEPNZ6rvAB+Hey4CHyPcsoBBEEGyLY32WvlWv20EAKtskwwHaVajBAEu+0A7JumgZBB/w78bTj5YBxH3M0oeXNz9jYmBNYDMci01eIqXbk6GwuyxTmyKVnIqrqH7iWmPI8SM4pdJAcco7kRx1pDtAsj9B1uVgyrjDzLenm6c8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY/jI+zV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-86278558cdeso304461585a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128644; x=1759733444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgytSi7eWruZ4IgCQ9+woJWiBKve9B/1Gpbx5IGpnoY=;
        b=HY/jI+zVUAeVTg9BPdsKbqnQD7itsdzPviXy9hm0nNzq3+VkhKSPJvuL0e04pDNjCG
         2WJeagC8TLtMkRHFsC6/PZq9Kg9Tmfg0NvKKEQjfAavdHDV04jHfS6ZK0CuO/z5sbXUV
         KJpfmnjcSUjK4ZlZwVv8idigTmjOWRQi+AcJKzV8+z15MCcUkaCq/OESIUPZgIkcrzvj
         gIQ/nH1hdMZ8OmSGqe0vFPZxYQw/2J5Ur2gqd2I2B+R6gdnPRVEUTUryheIiJu6QBPNI
         qXGYT4GlvKjIp7wuhKTAuR2GAFvYrGFUmD9HnlRQUl1ajaZCTX1xUtP+iTJiGdlJfx3X
         PnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128644; x=1759733444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgytSi7eWruZ4IgCQ9+woJWiBKve9B/1Gpbx5IGpnoY=;
        b=USRYu7tLEhbZEIVEqUZFI5vhagm+/ESyNXsDTS7txSOl3JvnXnbk0xi59gwcP3AzlJ
         sge1pm51cZ/1TPZuDV4bGNIFBr/OqdG4y6wj34maBQPxBkzwm+Pi2wfs3fNlyCD06M50
         RJpZKr5Kl5Q1c0Gj1a+firekxVAiaAEcdhkLFZWfmNgwi3Nx2uwY8avVNWXCQfAFmgpZ
         N/I/P0B8NW6o3vk3sHDi20fxurK741xyjm6wAl9O/nBiZAOnahIEZzyu+PWvztkClU5U
         4ESWAnhARLuimV1fKC+zH1C4f8B0QloRiVGidD1o2REgzcmMf1vVJPmjhlPoF3OQhiza
         BzTw==
X-Forwarded-Encrypted: i=1; AJvYcCUpj9Zza2S31TOLG9Xasbe3cTBrlULp0tUZVQ/LzPjV/BsI5VobKqocvtcXVvCNpp6u9xXmpEBmNKUv9GE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1KchtwZGNJopfs35S51WzZ7sEYReX1r63uCN5fuAoTbk8AnKN
	hhAJqeNFPXPCCnDfoKU36oOHE0ZJfl9jWXMYCnAZJ2vyB+Cjq/sUZ3Kz
X-Gm-Gg: ASbGncuUVWgsg0nJrl1zriCNjG2/JnUPhyjmi70PgsQEck2TXEqXtcDll/Ef2LHukWX
	b61ARCrnqUtgb7ANxxCOWZQ7eHNMONBUL2I84drRf7RjzynAY/Be/sz1yBXu7ZEiSsG8r0ipK2h
	vfi9dlab+Yn1R6y9OrMg/VTCORi3/5BzJxUM0bdXuOcF1QNlw2VvDvZMCXzocMgo1nRuoqVX/ew
	JxGLex5SZ8Ifqx5v8Wkt+H0lR1GRjH9XIOlrhJVXv7aOlSvk2Ld5GMRGYTDt4Y9p+gvI7y+1YuR
	pQfcdZ/43zkJYKBSjzesIMjt4HLUefvPFE30gn36ar9LJpl7zBItn7zRC9LExyVxP3hiA8gy6ap
	gPFqtxMauHQCu1+Jo/3ncdy9OtaBGAQeK0H2FSPr7AlBoLhgk6mM=
X-Google-Smtp-Source: AGHT+IHSra+J8XmrdkJXal7HIXXGUrIc2BNqj+IcsYKupPcSVxWC2FXEcXs7hQkwzDPqFjgbu8Vavw==
X-Received: by 2002:a05:620a:6281:b0:855:ad28:7931 with SMTP id af79cd13be357-85aec2bec40mr2283842385a.39.1759128644013;
        Sun, 28 Sep 2025 23:50:44 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:43 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 07/15] staging: rtl8723bs: adding asterisks in multi-line block comments
Date: Mon, 29 Sep 2025 06:49:52 +0000
Message-Id: <20250929065000.1010848-8-vivek.balachandhar@gmail.com>
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


