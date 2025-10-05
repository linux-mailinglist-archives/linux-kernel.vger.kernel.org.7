Return-Path: <linux-kernel+bounces-842357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 149A7BB9924
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 18:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D373C1895B8A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE3928B512;
	Sun,  5 Oct 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZm25aLB"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EEA3AC15
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759680026; cv=none; b=Yq9sjA+/2BPSzjyn6lh+el6USP87FLPl7x36x+XzkNythodg8D2cdxcvQPaJ286HMAj5pouRCKc56qLwa1Gu8Vt5WGBK0MkiR7kyYKehm/cSfp8HiJaiwAdphm4+8/1RGcZGKLhMVOLN0jSdHQqsDZrsT1KbD6q3GsjjpU5fpoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759680026; c=relaxed/simple;
	bh=TrDcUfuHZ7TJREmIthB+j55m+yVeaMzeFTZqozHwAPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tm+FJznGW5SeBz3+0wT81jcCz4TSah1/1l3jpXAhzngFXH/FU3mwFtBv4nQkxXWYrMKngNkKztngRJuzRV3WCJythmPvp045ePaewyWgtFj9lrT35YCq1p2vTRsCQhKw0Wz139u+h+FqZ5BY3mcR1IsXqDbU67IMJbFB/Do6rYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZm25aLB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3166855b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759680024; x=1760284824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CWusk2svzGl3MUuAZ2TzWoJhJSyuzuzfCNyygDsyss=;
        b=lZm25aLB2JUFQtFkmGZoK6hXAv0xrNW1c+Dp3yEn/OAzCQbTwjhSxZ+9fytmAaDs4M
         U3VWD801cIkP5FEmJcB5vlIx+4Kta56wURLUj+5nN23MtaEOdvHfszHr1XBgtV0gIEQ2
         0QTNjbXig1Ay3oFLu96vokWrGvL8JK4iVRnFqP403F3eJRatUw2HLEVbFJ5Nrx5fiaTx
         827AbFJywQGmB/tTSPAX9iKNe5VnmMTGEknJ3HzXK2yLAd0JGyYq5M/qjwFOQuBUzHo4
         eCmHHSWQblCtzZ/BZZf8qswjy+O+EbFBjgz9lP4ieqMB9sf3pQoLA+It+Gwiw02gQv3N
         C37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759680024; x=1760284824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CWusk2svzGl3MUuAZ2TzWoJhJSyuzuzfCNyygDsyss=;
        b=ps07M2+EndT7CdOvgb1iIAmFbrZStrZuZD6Dz/X978CZY56qVO+zgsZ7W1ds9flSqC
         NU6xvy01JkUc5uob8WoPuR1dfVQBiS3z0NMGpo2zEbuSnJx/miz2tamdYx21t3bXG9xT
         32bRB+mkOTWbmm7/D+NGrSUo/cHDqI0cqBdihhpRsRdRyJ9UBsPJvl7eBCcpcry98DUx
         ooe6W4WdqYKpnT+cluiveZX/GJeCrwElUa6/OBHoO0Szo3caBPocLj7fTteA98To3FUr
         26izpapq1P352XTHp9mMD1c/Ok7KwffYrBaBBBDKOavbOCLlfq8bh0v0WY3x7oAlQr/5
         lxgw==
X-Forwarded-Encrypted: i=1; AJvYcCWMdKWZ5Xb8cC5FkFaaMOryUlS3xNYiiIYmWPTe7fWY9pTa6TKgtq7VUFzo2Ywo2LKWQixpVwM6LoiYoJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyArIx1Y/aZ/OaAxuWiUBXGoXKIaIow/ZoQ/LDQPN7vwgiLQSF/
	pKWt5d5/qyv95f9thAyF0CG1ZacrNRImRuL5A0kXEihyM844i6T1x7ks
X-Gm-Gg: ASbGnctl6Lmky3S+IFloE35MG1XXHKSZ5VBGT/eH1bZGe51TrATZWDC1Zp6I5Dj4crQ
	S696haMI2p8dIJK6KAu6INmt53iibGD8tHrEGGuZbfqfJZAR5b6XR3ABWPHIZ7mYwxxItt+85cc
	wSeXFqfrSFUNz10TbJ+Tqq85+Jo4J4tnbzyG3Vwgaw6+Rogpcz946b8jFFBJlos4sLr7jqyxxzr
	7T4IpBqNkikgfdcp0fxaSMFPKIIT/2AXZMv0Ew3eJF+nvVHRBJNamJrn9FZQVHXzuzn9+w5p8En
	KSIN4lF+BGJ83QGhbp3kpth9dU10uKtgToBM/ORf3QFO/AoBBHxYi8ttpzaqvPfGdl7fw+9jbE/
	N9QO97tzvUpm7Qag/ERVlCqxSNR1094gYJxf4sos02cvuxiR3KZxDV3q3TP1OeWn51bsCiN0=
X-Google-Smtp-Source: AGHT+IGti/fd7mYfrNkxUVPAt+tdSYP7b25JCGnGraje9G92rstBWJc6SnI6rUiJFqb45UzxbxRacw==
X-Received: by 2002:a05:6a00:3c8c:b0:77e:d2f7:f307 with SMTP id d2e1a72fcca58-78c992116c7mr11208147b3a.9.1759680024483;
        Sun, 05 Oct 2025 09:00:24 -0700 (PDT)
Received: from Deathstar.anonymous ([172.56.42.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb3d95sm10145241b3a.32.2025.10.05.09.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 09:00:23 -0700 (PDT)
From: Rohan Tripathi <trohan2000@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rohan Tripathi <trohan2000@gmail.com>
Subject: [PATCH 3/4] staging: rtl8723bs: remove unnecessary blank lines in rtw_ap.c
Date: Sun,  5 Oct 2025 11:59:19 -0400
Message-ID: <20251005155920.381334-4-trohan2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251005155920.381334-1-trohan2000@gmail.com>
References: <20251005155920.381334-1-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes superfluous blank lines and adds missing ones where
appropriate to improve readability and match kernel coding style.

This is a coding style cleanup only. No functional changes.

Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 2c906c1137bf..dddb02c0f683 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -438,7 +438,6 @@ void update_bmc_sta(struct adapter *padapter)
 		spin_lock_bh(&psta->lock);
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
-
 	}
 }
 
@@ -1240,7 +1239,6 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	}
 
 	spin_unlock_bh(&pacl_node_q->lock);
-
 }
 
 u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
@@ -1974,6 +1972,7 @@ void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta)
 		add_RATid(padapter, psta, 0);/* DM_RATR_STA_INIT */
 	}
 }
+
 /* restore hw setting from sw data structures */
 void rtw_ap_restore_network(struct adapter *padapter)
 {
-- 
2.50.1


