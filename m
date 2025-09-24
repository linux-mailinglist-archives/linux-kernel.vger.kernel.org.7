Return-Path: <linux-kernel+bounces-829901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2E5B98268
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E83719C7A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6B1226CFD;
	Wed, 24 Sep 2025 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MHtIr+he"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC12367D2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758685271; cv=none; b=QjnojFy1yKEU596C4WGEWAxGGccyd4ZFQHoKi5luCNH8PCv3vAAet8hKAleVN9eG5VxXxRqpuYxKRW0DXZChsCLL/kCNpJCkPMB3G9clIPtADeKkSSHi9PfRXsylbhX55K+KO5CtD/RtwZ232aDxWhF5tGov7gcPCfD963PHJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758685271; c=relaxed/simple;
	bh=spqI6rzBALnpSMNsrDVeCcve/oeu3eO31tW3HIY0PFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VCpP8/5502YTfIz8HjSo/dQ//Efsj6l3YiICrSO4cRkXFv+bVvdY02TiCm8i8Bwy8xim5wO8a+l0Axg0K9rGPS/6dSXoRoldSjJ8uyP7KN7/ArPO39vml+JUv1fshWNCaPDaWDBZBDzpad0SSysFNxyMDxea5J+FzK+ELN8xGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MHtIr+he; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-267facf9b58so46320555ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758685269; x=1759290069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHQ+DdEo33vc4KCDGuMUNzkfwefcdJo6mPASmdDLS5Q=;
        b=MHtIr+he5Duynx5X1HvjwOokS1IiiunLkGznIbqK3hfMULQsThQDbFodYmm0osKe05
         kyN0+UHk/6t6a5g8udpExpraPYl3wSQ+jXLGvv/7njZfTgp7u6jVPpeVdHhJjicsAuam
         pOM0BafW8Lntvo/ZuX7EOKOLQiC7B6BMFpmoCtauaEOeuvfb41csG0211e6gRWh2QRKn
         1B8lxpLYqqkVonRPXRnrr6L1o0T/NollK3YBGgeS4kcKvB47bV+6/Xe2RefAx5JlYg5M
         +dRXd727aSPhSqADHSA8a6D8lGfbep/dOoGCk3lAC7Vu7beNnbDZr7hNtsXydgnY/ljh
         6yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758685269; x=1759290069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHQ+DdEo33vc4KCDGuMUNzkfwefcdJo6mPASmdDLS5Q=;
        b=E9J6XD5DIQRxT3pM1OPDMUWJmOs/Ge/1ijpH3grXb9h6CaVWXr2A0b/lS0i0R3ufyU
         MJDR05uUW/nuPMIhbPASCOFq7bolc+/cjFNWzlGuAGVe7B4KGEnK1QTAmd74gfaKJNnP
         4mQHwvWaPHWHuVs07tosZSV7WCvyGVZ3y341ZfBd96hj3DS/xtgCVaPoPuIGTA094CkX
         PM/3YY3X5NwEvkGqoFtMqYuRaUD7Sk7v+rBtYeBosHkFOmt6dO3d1ejGBUSwaDQqDp7/
         b9ysjzcL0Rp9J6nAlViBg0g0tVU+NthdMVtLilDxyyvofcIdgzfKcon8pMSUG/q/ghC8
         yq5g==
X-Forwarded-Encrypted: i=1; AJvYcCVKmxoTnHnfjhIA9HlIMiSwYqYllpUlX1WmnQZ9sbAnjddP9LHru3Paom0RpvOzVKwvfHwuirNpYlPqF44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoJZse7xoU85QvSV75KlP2ubqZQ4aynyH1qxoJZ0D8SUR78pu
	LK7JomxmAB3f4LIrIK5dTJcBwXaYtbBs505mQTTWDSRVcifPhutGC18p9R32S37EdO4=
X-Gm-Gg: ASbGncvVGH5BUCFAB9yX/O6+pPslsvqAl4N0MoQZ7lVoADCzf7vuTaQdor2m85IzSTG
	V5V2ofWVNH6DfrONghtbnr4mhNPTl5USNNiD/Iyw4eAZ6phPuD4mG8OLz7V86sy21sexmv5U7Qn
	h1Mlp7qeOsesfwBQpmskgassCHw0UUn9VGNBvv+xQgv57UVVJBPOvYFtUmY3vJMLN+vErISGTJz
	rCVCLpI4kJdvnBogGP6h3JfHe3MyXOer7uqv3DJGU9FINvwqRDSLfcywk6vbAoTFYnTLnp95HuL
	ii+A53Thwsb7CkzbETbZAdpz1JIfOxszhlg4wqq/+54UOJS1b7eSDG7gwT3r6WiQ7/FZ9ZPXh03
	ytnV3H6NNYE91YSoGU+ujnEFEo1PdqVY7
X-Google-Smtp-Source: AGHT+IE01vH1dOq4gN0RxZiU2IARw6GpSu64vihveNRXf2jRo5uHOkH57XR3v8v0OkH3XlAZ1ejViQ==
X-Received: by 2002:a17:902:e84f:b0:26a:589b:cf11 with SMTP id d9443c01a7336-27cc678387amr68942965ad.43.1758685269114;
        Tue, 23 Sep 2025 20:41:09 -0700 (PDT)
Received: from localhost ([106.38.226.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df76dsm172166575ad.74.2025.09.23.20.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 20:41:08 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	yangyicong@hisilicon.com,
	will@kernel.org,
	dianders@chromium.org,
	mingo@kernel.org,
	lihuafei1@huawei.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	peterz@infradead.org
Subject: [PATCH v2 1/2] hung_task: Introduce touch_hung_task_detector().
Date: Wed, 24 Sep 2025 11:40:59 +0800
Message-Id: <20250924034100.3701520-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924034100.3701520-1-sunjunchao@bytedance.com>
References: <20250924034100.3701520-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kernel, long waits can trigger hung task warnings. However, some
warnings are undesirable and unnecessary - for example, a hung task
warning triggered when a background kworker waits for writeback
completion during resource cleanup(like the context of
mem_cgroup_css_free()). This kworker does not affect any user behavior
and there is no erroneous behavior at the kernel code level, yet it
triggers an annoying hung task warning.

To eliminate such warnings, this patch introduces
touch_hung_task_detector() to allow some tasks ignored by hung task
detector.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Lance Yang <lance.yang@linux.dev>
---
 include/linux/nmi.h |  2 ++
 kernel/hung_task.c  | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index cf3c6ab408aa..61fc2ad234de 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -59,8 +59,10 @@ static inline void touch_all_softlockup_watchdogs(void) { }
 
 #ifdef CONFIG_DETECT_HUNG_TASK
 void reset_hung_task_detector(void);
+void touch_hung_task_detector(struct task_struct *t);
 #else
 static inline void reset_hung_task_detector(void) { }
+static inline void touch_hung_task_detector(struct task_struct *t) { }
 #endif
 
 /*
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a1205f82..6409d3d4bd36 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -184,6 +184,11 @@ static inline void debug_show_blocker(struct task_struct *task)
 }
 #endif
 
+void touch_hung_task_detector(struct task_struct *t)
+{
+	t->last_switch_count = ULONG_MAX;
+}
+
 static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
 	unsigned long switch_count = t->nvcsw + t->nivcsw;
@@ -203,6 +208,10 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	if (unlikely(!switch_count))
 		return;
 
+	/* The task doesn't want to trigger the hung task warning. */
+	if (unlikely(t->last_switch_count == ULONG_MAX))
+		return;
+
 	if (switch_count != t->last_switch_count) {
 		t->last_switch_count = switch_count;
 		t->last_switch_time = jiffies;
@@ -317,6 +326,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 		    !(state & TASK_WAKEKILL) &&
 		    !(state & TASK_NOLOAD))
 			check_hung_task(t, timeout);
+		else if (unlikely(t->last_switch_count == ULONG_MAX)) {
+			t->last_switch_count = t->nvcsw + t->nivcsw;
+			t->last_switch_time = jiffies;
+		}
 	}
  unlock:
 	rcu_read_unlock();
-- 
2.39.5


