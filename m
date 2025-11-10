Return-Path: <linux-kernel+bounces-893631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A3C47EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3F444F0752
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8727B34F;
	Mon, 10 Nov 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b="dBdFQ+YF"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA8A27A461
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791839; cv=none; b=dd5jIKYNvppzS4BSCuUdvS/zP5Cf6lR0AzddGsmgZEiyDXWDAi2zs4erFLlYAsD9KrVuSCq6GM/w7JYgWZ/3bd94ytkPNoVrgJfspI/Hk6/j7WLAr7fhU4Q2MFauMjECpicuAzhGBfAJGtVRzIsBILdMZCVX8Ns5MKWzpBThMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791839; c=relaxed/simple;
	bh=4RmZvqPGteLpQaP+Rg8fY+CpJ27PemiIjQ+OhFYZB7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFX5+CdpkE1bYUkdleVj0fNm/gKRin+s7eySG9i4FCMHXxFROdJkEgtH2SU0t28UIJJAOl6NxAQYeKP+/ttXUZ4ZSIhrytaQ3Blju0CgN4ystCaoWhfJsQ19/9d0Yxs6100MMGrxuMlS8uu2DXEp53e73vx/179D+YgevpZg+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=dBdFQ+YF reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerlync.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297dd95ffe4so22856595ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1762791837; x=1763396637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lamLCycPvZ6qxMMSd5dWCjwQxGtQYpYj0GU4PEFC0tM=;
        b=dBdFQ+YF7wxvryTuu4l4C0AVQmmxMPbZHic8A4lUKXCfxCoBIPghsUM/EELbapNSjL
         K2hss9Ph6WyyMC6NmKLeCcKDWmdJj6Ex4bCrxmOIRug1OtShnPGsJrCAYOif8JFrmZZ8
         DmtC/43f84XgpQXLCyUIGkNCfqVg2WGy/Vi1a/RBeEWWWgMpNjOp/cAeP2za2pzh1fYr
         VjHEkHdx1Z83n1d3ttBkKmVfa68kK2dssrOZuEOUFHTNjBoTWZNI7YmB3jceNF+Sz++X
         BRk0HVHZz7MpXxKIIk9UtYpnmXtJ9JmtodXWiJp9zDcAqNH5sjM3xintdewUOe+bJPK1
         x8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762791837; x=1763396637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lamLCycPvZ6qxMMSd5dWCjwQxGtQYpYj0GU4PEFC0tM=;
        b=Mf8w0HfERrvu9+PAKHsFqtCeA4UelrfsAozw25XTUR8gJa3sfvgmOHt6SaUlo/W/rv
         sqH8eb4JBbSWtuNN5v+zgYisJ7tH1r4c0HLZ4p+7HZ3kDhXX0VpDjB+vNyGltxv7YO7P
         EYKpBTHLC6LRf61t2hq7nLbQqoNGgFOGORfvHMbxcMxWsV+8U0r5x/y8p+xCWwDpjkEy
         MDj9F7bkjNz0hHTVgeSlgmSbO0zZZ4+DORashTJbdDBMfAnpfgYKbLJ/4oyXXQXPX+IA
         TLnFdfO1IXnx9uMed6RNFzmfCvmvR1eCS4R9IvUQfxDpE+d3qpVRcra9wlvrCVbqhGLH
         ElQg==
X-Forwarded-Encrypted: i=1; AJvYcCWyutrb3UbolGfstObT3nU9TgYk+0sHMOIMPRAupnVLdE6LNF3fRrug7MDLfMDp59bkhHgdRKI+GPV6YnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1lZkpedvZu7kVeydTpzAIEcWyWa/Rln+NEb+EXA12gfYsVcoH
	43g+KSFaVlEI/WmwKjeTF/Rq8SUuIJDBAUMMOZfJAMUv+kbyKa/GUs222zcca9+YhnY=
X-Gm-Gg: ASbGncuzmd+LqzPHMelx/lBI2vKlaKFZ/jXB6zIu3v/Oh2kLUrHaE6brZ6pVQcSZ5AL
	XEp0ve5K9r0LXJfWwFeGSCwOSjGB8kK1qtBR0k2YmnAKCzR0+N6XaApHfEjigIYLYFlcohx6yx5
	od+dog83qwIOgOZgl/Po2ukmYPoSTAfbbxokXtdCAQNgdc1OhKWbZsx7jdjOqlKbDFolL7TtP3M
	rbV2GcbhxWStbMVGMjrI0WbxnbJelajhOOMCfhJBgNWaLNnW3jY8yoKargk01pUoqod3mM52ZPt
	JKoT+YrfnV7gEFkbL3F/unnlqAsBsIXmhpPhm5hnVI3gb3ZEglYabNFsjc2oapcBuDMbLHnvIlk
	XFPEYEQTD0BjM+ySIWGbpNMcQkCRxsiUTy5Hqwn0CXJjCjFj+EKpkk8tAT+pvZNjNR2VTPnXYHW
	CSbS2kY/XWp06t2UItWEf/fBU7gevqAqychSufD4tJ1g==
X-Google-Smtp-Source: AGHT+IHS0J/P0Q+0p6kIWW6Bhuw9kC6oUUNrtxalYb1iLlJHS+ReMwxYzFG2U/cfVNoJ/ulOHlXG+Q==
X-Received: by 2002:a17:903:11c6:b0:295:7453:b58b with SMTP id d9443c01a7336-297e561c718mr103740675ad.4.1762791837344;
        Mon, 10 Nov 2025 08:23:57 -0800 (PST)
Received: from localhost.localdomain ([49.206.118.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm150058075ad.108.2025.11.10.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:23:57 -0800 (PST)
From: Sayooj K Karun <sayooj@aerlync.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sayooj@aerlync.com
Subject: [PATCH v2] mac80211: mesh: handle RMC cache allocation failure
Date: Mon, 10 Nov 2025 21:52:26 +0530
Message-ID: <20251110162228.15064-1-sayooj@aerlync.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251109114321.10120-1-sayooj@aerlync.com>
References: <20251109114321.10120-1-sayooj@aerlync.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow kmem_cache_create() in ieee80211s_init() to fail gracefully
when the mesh RMC slab cannot be created so multicast forwarding
continues even without duplicate filtering.

Signed-off-by: Sayooj K Karun <sayooj@aerlync.com>
---
Changes in v2:
 - Retitled the patch to “mac80211: mesh: handle RMC cache allocation failure”
 - Added more clarity to the commit message
 - dropped the extra pr_warn() after kmem_cache_create() failure

 net/mac80211/mesh.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index f37068a533f4..eae78d9528ac 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -2,8 +2,10 @@
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
  * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2025 Aerlync Labs Inc.
  * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
  * 	       Javier Cardona <javier@cozybit.com>
+ *	       Sayooj K Karun <sayooj@aerlync.com>
  */
 
 #include <linux/slab.h>
@@ -25,9 +27,12 @@ bool mesh_action_is_path_sel(struct ieee80211_mgmt *mgmt)
 
 void ieee80211s_init(void)
 {
-	mesh_allocated = 1;
 	rm_cache = kmem_cache_create("mesh_rmc", sizeof(struct rmc_entry),
 				     0, 0, NULL);
+	if (!rm_cache)
+		return;
+
+	mesh_allocated = 1;
 }
 
 void ieee80211s_stop(void)
@@ -35,6 +40,8 @@ void ieee80211s_stop(void)
 	if (!mesh_allocated)
 		return;
 	kmem_cache_destroy(rm_cache);
+	rm_cache = NULL;
+	mesh_allocated = 0;
 }
 
 static void ieee80211_mesh_housekeeping_timer(struct timer_list *t)
@@ -231,8 +238,8 @@ int mesh_rmc_check(struct ieee80211_sub_if_data *sdata,
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


