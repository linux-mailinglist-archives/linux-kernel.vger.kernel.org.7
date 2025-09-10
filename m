Return-Path: <linux-kernel+bounces-811042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08867B52351
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E13E54E04CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF1930B50C;
	Wed, 10 Sep 2025 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df1YVkBo"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30743093B6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538540; cv=none; b=dlYOS/wma1fa2/aNgmWSTA4retrmbYsRb5tt5KWPMSbBB47sDvB5FJOwVFfWdXdF0xBYIaPW9tvCHHcI3cCxVSC3086WQyZxaoCslg+Uy5g2Bfmu7SbtgIj/EGlN3wn3ZDb0m1z3w7yOA5qGV601L5QzgRgH+55mgoeioUton1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538540; c=relaxed/simple;
	bh=xFDmu0xYJmBUwo/kHfB9/Ei7zaWhhPEWmqZzUwMQ6kQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MABhSIvQw1l7ZzA/6svBuWstvH4ItaZ1/e7O9HJsMhp7CFzVD6VWufGBGPv+BhgM3eQCzyZHjY7+akeoGotmQiUnkWt9OJLU+2AySavFYtjJCWYaOF1Ao3shHybo4yjlIMh5Ob8gOV2e9e4g6vOt0pHrGzmlmwjwf4AMofEKJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df1YVkBo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77238a3101fso39787b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757538538; x=1758143338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tImEZeEkqD6mBRr0o2dNQ4hso0/Nmu6+qn6NY4hdxng=;
        b=df1YVkBolM+km+1SznOm2Csnhv+ic5j2iHM3/OqByQaZCeDZhJovFkGScVTOhYHE0Y
         quBLATmaTgGTqBOf+x0xk/48uVZaLWyC9EHfKQUzGqqDhDT8yrE6wuqZIupnSTC6cxRx
         KD8pxW7Wy2BVkA1rtOiBPKmsxVBHONfazA8FMhY+PArwW+xaHR9uT7/2UXTlBb/WHCxQ
         dkQHqrmbHrtHOEKs7RoMKLVlxbcvUEBiueCzKQCa84pGFqa0ZbyWEDM5Vx/rZ8gP03pX
         4oVDk2lIZTXN9hxYJjGBqyr4msjf5OSsZTwZrzCXOTEof03qI9bpQMrP+p5wc+Gg6ssB
         R8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757538538; x=1758143338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tImEZeEkqD6mBRr0o2dNQ4hso0/Nmu6+qn6NY4hdxng=;
        b=f12C9WS2Wmn2+VQ8azQTxS25yN701dn/myDzRiUVcXrwwDkm9TRl6ZrInllt5BYzHe
         p+5uLn0ccwmuhP1Y7Kt3f9F0JA+lGH0VckEkM4Da8Tmc09z8gB/9QbMMSNaXkszDn0Jw
         CUEAPhz3we+SE5DR0yNt/nlFESK4pD7mIDOhfX/kT9kot7vc/nAT4RqmtpDjogDqaNoz
         2pBiLk+6Pnh+4C7hzuDFNoU0oVYmnGWLbfgfWUAnYJ1KEO9z0CW/2Cgrmo7XQBezbe2k
         IpvdfC9fqvKyX1V4kUvYznAMGE+v7NiWnlZhZCmHFj96PPW8gTmyrAT8TkJ092MLl/4y
         HZYg==
X-Forwarded-Encrypted: i=1; AJvYcCWFLfZ+ACGBP3KVatiTqiyCdTNcL53+CNK/Q5/81xa6nq6aKQmPnpEN7uOVEX59qVGdWrcvxfzEZZnbVWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZC79LeiHps0HKO4P3Q8lvF8S8Yi97Rl4g6FE9diEXq6Y9xOn
	YqohWPdElZL/CqF/oUyEKjUo+M2bqUA1Zb0RLHO+Tw5K+SxEn3RwgSLH
X-Gm-Gg: ASbGncuvfdH/yAdkPPaqLdF+IFZ9clvlmn8b3+diW1J7aui5NIuWYxvVGYhUZVSry2z
	Fw/z/Ak95xpEmz0eTkMk+SbPzMkspeAxLbycQ4hNQDvF0RoC06U2SdPh1S7TNBEk2ck+4oAu9Hw
	xe40qfjav/MDHt0ZxvNy9G+Kmz10ot8bmdOmowM+0wbIPcxXFz6H3PPaZzRnssU7h5/Jfsw7hxc
	JOxPcfxTIOdo5xPtUaaPShjLXSA4pn0kYqJW0TP57ZeKKnbz/CHuXQpE+nhCQnDqXdGOExFpbgm
	fP/eVepPQq6lpN2/eepyP4Db+BBHNAjNdpc2GoTB+BeI20AGR8a5qaE4BuNlgf5vJYoCLKKPBBz
	pJ/Lw06v3HgJhczX+c9m2fug0/N9W8e7M
X-Google-Smtp-Source: AGHT+IF8HCAtLL49DwEFGUoEpzBArdmeLKC+TOtfBQTFgszoh2I8q0/fBRcLD1iTVjV9RZkk3Tt52g==
X-Received: by 2002:a05:6a21:6d98:b0:252:f0b6:bd8 with SMTP id adf61e73a8af0-25343c5bf7dmr26150971637.36.1757538538137;
        Wed, 10 Sep 2025 14:08:58 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6bc792sm3508607a12.42.2025.09.10.14.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 14:08:57 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] group_cpus: don't call cpumask_weight() prematurely
Date: Wed, 10 Sep 2025 17:08:47 -0400
Message-ID: <20250910210850.404834-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910210850.404834-1-yury.norov@gmail.com>
References: <20250910210850.404834-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>

alloc_nodes_groups() and __group_cpus_evenly() call cpumask_weight()
unconditionally in the for_each() loops. cpumask_weight() is O(N), so
the complexity of the function becomes O(MAX_NUMNODES * nr_cpu_ids).

This call may be avoided if the nmsk is empty.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 lib/group_cpus.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 6d08ac05f371..6aae1560b796 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -142,15 +142,11 @@ static void alloc_nodes_groups(unsigned int numgrps,
 	}
 
 	for_each_node_mask(n, nodemsk) {
-		unsigned ncpus;
-
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
-		ncpus = cpumask_weight(nmsk);
-
-		if (!ncpus)
+		if (!cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]))
 			continue;
-		remaining_ncpus += ncpus;
-		node_groups[n].ncpus = ncpus;
+
+		node_groups[n].ncpus = cpumask_weight(nmsk);
+		remaining_ncpus += node_groups[n].ncpus;
 	}
 
 	numgrps = min_t(unsigned, remaining_ncpus, numgrps);
@@ -294,11 +290,10 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 			continue;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[nv->id]);
-		ncpus = cpumask_weight(nmsk);
-		if (!ncpus)
+		if (!cpumask_and(nmsk, cpu_mask, node_to_cpumask[nv->id]))
 			continue;
 
+		ncpus = cpumask_weight(nmsk);
 		WARN_ON_ONCE(nv->ngroups > ncpus);
 
 		/* Account for rounding errors */
-- 
2.43.0


