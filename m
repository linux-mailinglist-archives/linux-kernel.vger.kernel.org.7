Return-Path: <linux-kernel+bounces-891911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E267C43CCE
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB47D4E4BC5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA562DC79A;
	Sun,  9 Nov 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b="aSiTYxvl"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753311CA9
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762688684; cv=none; b=AQaQKgbu1yGtrqtBbOGhRe2aQKfG1nRHZ1FGD0EipVvuqtHHlrpPEdqxyH3b9jVhtGoT0exAe62kS0zASDTfsol69RKorQ/rWRy6TkLY1//jCuxRuMo4vb3ekgcf/GSkpnA3hSnVzr9t+KL9emctS1pbWTwDePlpYMad+KZt2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762688684; c=relaxed/simple;
	bh=lU2Pn+X9ZqNJ0QUXQEP/kMjGySaAD5tEPnrnOt/Pa78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzY9AaEFSSBgkqNy3FrnUJ0KR38XrYXaDxOHa+nMaQGCPhg6xYB961jqrcJchW6/pC7ciWnDCSseepct4YhUzfTTy/tuK5D/cjNG2uJdVPMh2W3k5D8Mj90Bzz+cE8kQVcHkZV8kcJjSy7+sHrtF2PcGx21nyrjrlLtutyMdgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=aSiTYxvl reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerlync.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34381ec9197so435013a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 03:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1762688680; x=1763293480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+DsiEsh4eUVH04bD394mJEOkHiS+PFJy/C7fcUmjwIg=;
        b=aSiTYxvl9dXf8CUrfJGJPsv2n2ECkkJRv6Vt1GfyzoLImvOQzDzG+M6ddCIQvnHNQ1
         ZpBDnNLsjuDWJjAPE8rJ4g46ZD8Z5l3wZfrbfxQOaGbXWFsAxqm2d4La0f7mLb8NAkij
         JxPLLCGRjcATu4B3YahymtKS5OsKZzZt9QZK+FDDrk2Cn90WQ55st71j5iSen+owg5Bl
         YZfdSt2ANaq1+QrOslXe6T8w/2hmaikVv4IHEE4qHL8bAFTqYruGd41IFzS5W8aW053C
         lw48W4gCf/aOguyyU4DGlW5hv7ILlNvofAR/3PMvqYvJ+ve2edAGj05xnhCN4SDpLoSm
         50hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762688680; x=1763293480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DsiEsh4eUVH04bD394mJEOkHiS+PFJy/C7fcUmjwIg=;
        b=JyqMeFtyEqpYKhxz5c/lqPKrK++wSDq96YSmvCdFsoQLNLqVPxV26So8emhpBHJigf
         jEPs0Ea8vWX0qYJ5n+9CCOML+eC9XKoVodD8UiU/5Lb4p3CkSS4PN6VDrgmVjbD0jGu2
         OhB6jiuXXnY/qVtsuSkbQOmX/SSkNR56mRY3CN/cF1g2U4Mh5v2XN0oLUohuUyIiv4lc
         MSafJ93zRGrmeNjisRBv/eeG23ovZnaA2up3c3RBWhJ5JuBk/uBLA75pFqsqade+9+0m
         fAbkLNTmD511DxSifnz0R6QglejojNu0dfTzCGhi2YNbdnECNtrFcwB+Njyau4Qnlapq
         QnSw==
X-Forwarded-Encrypted: i=1; AJvYcCXRikjJi/ICSxsY3UNyX5whrfvBIY3LdigUXMrtrxcnF6c+K9imXCywudsfjCfWo0YnDi/iHDC6qLcJQU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9jHJ1sGJLkSqcqXjuUKG7/79/1kiNJiTOpokVyIdSoERwE3u
	ZhTOHZyPMNcPZ9YDuGgXi/vjZqyoxDWdW/RGO0bvYXeuxGwR1rV7KF3nr8RWZN49iOE=
X-Gm-Gg: ASbGncv6OrGgX9X0VR0pX3g7LNKau9OWnrs8RzRTe1Zdc5hJPNsrsTGAAPKSPjsS0LA
	Lg9CRltHGDHSSVSfRjTUDEB+cs5PTZlgq98l37tZZTf+oJpVsQYCxs7T099dx9g6SmQfgh/UfKA
	LicazfbEYtnqu70j65PTrGLIdyGBTHdaSQbFI5zuaTq4PJg8U8i+qtEDnuNcf+5cA7+ycck0pgn
	Kle3d3w/q3OIn3L7ENmAELtoC8GyqUm6n0KwhKqXnPMIT4Q3EWkRlxM8yGUad0yPJh1JXSzbm33
	vAabBcHxhzDyAHmONIhVqFtWJju66zIE5ihqAZVzl1mnos52tZgQclTcGca9AQWhmYi/d8d1Bur
	oIAky9kFpM/fHbHP43IAxtFE71NlbreEsIeM2wbk11rPea4VgD4KvVD705D/SzMEaFD+AJkGebF
	BfbQU2/ypQYRqUEd1XSywVFEY9ip05pg9RbnFexsOdqQ==
X-Google-Smtp-Source: AGHT+IF8kFwPjHl6+kry3//l7rLiQTHcRxA0nIv6IbtckHMItUDmmc9mA5ysz9x49+Adwd6XP8gc2Q==
X-Received: by 2002:a17:90b:2f47:b0:341:8491:472a with SMTP id 98e67ed59e1d1-3436cb0d183mr6010243a91.4.1762688680411;
        Sun, 09 Nov 2025 03:44:40 -0800 (PST)
Received: from localhost.localdomain ([49.206.115.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c332f1csm7656552a91.11.2025.11.09.03.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:44:40 -0800 (PST)
From: Sayooj K Karun <sayooj@aerlync.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sayooj@aerlync.com
Subject: [PATCH] mac80211: mesh: tolerate missing mesh RMC cache
Date: Sun,  9 Nov 2025 17:13:21 +0530
Message-ID: <20251109114321.10120-1-sayooj@aerlync.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow kmem_cache_create() to fail gracefully when the mesh RMC slab
cannot be created so multicast forwarding continues even without
duplicate filtering.

Signed-off-by: Sayooj K Karun <sayooj@aerlync.com>
---
 net/mac80211/mesh.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index f37068a533f4..20f25226d2f2 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -2,10 +2,13 @@
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
  * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2025 Aerlync Labs Inc.
  * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
  * 	       Javier Cardona <javier@cozybit.com>
+ *	       Sayooj K Karun <sayooj@aerlync.com>
  */
 
+#include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 #include <net/sock.h>
@@ -25,9 +28,14 @@ bool mesh_action_is_path_sel(struct ieee80211_mgmt *mgmt)
 
 void ieee80211s_init(void)
 {
-	mesh_allocated = 1;
 	rm_cache = kmem_cache_create("mesh_rmc", sizeof(struct rmc_entry),
 				     0, 0, NULL);
+	if (!rm_cache) {
+		pr_warn("mac80211: failed to allocate mesh RMC cache; duplicate filtering disabled\n");
+		return;
+	}
+
+	mesh_allocated = 1;
 }
 
 void ieee80211s_stop(void)
@@ -35,6 +43,8 @@ void ieee80211s_stop(void)
 	if (!mesh_allocated)
 		return;
 	kmem_cache_destroy(rm_cache);
+	rm_cache = NULL;
+	mesh_allocated = 0;
 }
 
 static void ieee80211_mesh_housekeeping_timer(struct timer_list *t)
@@ -231,8 +241,8 @@ int mesh_rmc_check(struct ieee80211_sub_if_data *sdata,
 	struct rmc_entry *p;
 	struct hlist_node *n;
 
-	if (!rmc)
-		return -1;
+	if (!rmc || !rm_cache)
+		return 0;
 
 	/* Don't care about endianness since only match matters */
 	memcpy(&seqnum, &mesh_hdr->seqnum, sizeof(mesh_hdr->seqnum));
-- 
2.43.0


