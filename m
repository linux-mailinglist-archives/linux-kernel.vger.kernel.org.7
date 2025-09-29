Return-Path: <linux-kernel+bounces-836029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22680BA8981
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FD7173652
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22B2D12EA;
	Mon, 29 Sep 2025 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huDRxXDW"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711882C2374
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137758; cv=none; b=aRrHRZkLtEXWgO2FH0Y8czbz1bDpLywyYosp1LOxIOi5Ce9tXz+i1U2LOifHAvZXDfDGTPUc23fIW9xZV/N4s6w41JsoAToNB8aH0KspUCIUcPbucwi78YzEX0BTRe+k2vmbzZNcSiV+jTRsY4lhzJ0D7KFT7VgWiPalsFcMor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137758; c=relaxed/simple;
	bh=wxJSKPgfMQikmHRdXw1g42BneE4R5D1ug59CyIN7q70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUjrZOjx45imFwucg5gMViqG0eb3nD0BK3o/0u11CBaEmLsD1HlvuDief92tAZfmEkOciwA9PljDVuX8ndMHzwM78IE59n4pO2RCd6madLrR1NhXhFiy8Qfw4JBGxBMO9MCtEU7GfeJS6/BzuX039XN+mQ30C5Q2GwIhFEgoZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huDRxXDW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b2ef8e00becso443211266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137755; x=1759742555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqDwEkWnkj1mNHsS4mS1Mt2o9FVfm/uK0s+31WopnJw=;
        b=huDRxXDW8PF3Op9kuwTpPDmtf3we9bv2TVIGZkrHl63aImM6lgBopYod+Zq6auzGKo
         bc+imC7Z8ybivX330LtQXcFWRpbpEzS2ZUf6pIZLttpwoRuCoiZLuocesNbJjFKLsmNo
         wxX0YNyNSI4wA72fyPBMvk2zHOxGzEqsBxG/KCHRn9g2LYzBNRm4U68dpIVCTED1DH9o
         MzLb1TyZYsxA7ZbsvwwEAhkYkSlINr8g7fzgpxbWJdDUQL+Y6r8xKq17RUivRj9ouinT
         QrW8xQlbQfc92uQfx4lAleiQdbiwkKikoImi6y0osaZVpXTnVcRsW0vJ4Q1v+bsZOpBs
         gbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137755; x=1759742555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqDwEkWnkj1mNHsS4mS1Mt2o9FVfm/uK0s+31WopnJw=;
        b=OpTToUejcDuT72MyxbjFpyEn1n4IqWVoSItweyLiMFq54fXdbahiCmcSKZkS3HzZdx
         mUs/gZab2MWssv2srohQiflzY7viX1xeOAc1ktErew3xOj8ykkjoKN7UIr+UIRnuVPr6
         9CGWXlDf6yOb9c1k2UmyQmSuOMRkLWP3IrZ956ZIl4yh4GtqWzldX/kyjLejAoPUZAZa
         Iyl5q8YsFA/ZOS3vTabZHLJTRgK0qHgcL9IB0uT78Q53YCV3zAN54RuYPKQQQzLbg6/a
         BgKY8M8qm/zBxEnigSwOkDYvyJc6av1RhxQos2VhM74rYFqRAs5zWVcchzzAtWPn0ouK
         ng7g==
X-Gm-Message-State: AOJu0YzfyGnsnwyhoNwBFfTdOjeSaL/IcFhMRhCniDj11y6ksAuhpg7X
	aRBFgHOpYji8zHJ5Q0MuGCsAkmvz79ktCxfwT7R4uVSEiIngUEzrg8lT
X-Gm-Gg: ASbGncs9aQJHxYMRaZ0yMj1NBk1zJCOpdSHXI26Hb66L3zhUFzmFyCCQ2K6M08Ysu+r
	uIlj5x4zQR7AVCYwNzSC2uCxL6ne0JEOnV2xBDa/3ysNLjVXXwVucfHyH5t2pZ8CXuFg3O5zubW
	DyXR8BUNfOOI/rDtnOp5zfqpj33VzGjRYdzkCguRy6T2O9v8LGqwI3cMNFeKtS6Sh2yoxwQy6Bm
	Bb3DSKgaS/DHykWlTuJNCZyNTNt2bB9fWySkrj5kEzbTPh76ZAnpOuPecpTxOV6nNmzt9E0dVXA
	MgHZ3HnyBrOynJP0orMxmWAhszP9SC7dfBGto3aDGNo8wyzh0iN9iqN11rrxb2F/tlbqfQMlf6d
	Y8dRPwt92OcixF86GlAk=
X-Google-Smtp-Source: AGHT+IH9TF6a9Za+QFK+0NwEXil1aoDVIeWgAtvvlgnFS46GTk2Nulmr0+GwbXErePRC9xssFmqUmA==
X-Received: by 2002:a17:907:9689:b0:b30:ed1f:894c with SMTP id a640c23a62f3a-b34be6d7425mr1846527766b.43.1759137754625;
        Mon, 29 Sep 2025 02:22:34 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:34 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v3 15/24] sched/rt: Remove old RT_GROUP_SCHED data structures
Date: Mon, 29 Sep 2025 11:22:12 +0200
Message-ID: <20250929092221.10947-16-yurand2000@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929092221.10947-1-yurand2000@gmail.com>
References: <20250929092221.10947-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luca abeni <luca.abeni@santannapisa.it>

Completely remove the old RT_GROUP_SCHED's functions and data structures.

Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 include/linux/sched.h |  4 ----
 kernel/sched/rt.c     |  1 -
 kernel/sched/sched.h  | 26 --------------------------
 3 files changed, 31 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5022ff99c5d..379923eba59 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -624,13 +624,9 @@ struct sched_rt_entity {
 	unsigned short			on_rq;
 	unsigned short			on_list;
 
-	struct sched_rt_entity		*back;
 #ifdef CONFIG_RT_GROUP_SCHED
-	struct sched_rt_entity		*parent;
 	/* rq on which this entity is (to be) queued: */
 	struct rt_rq			*rt_rq;
-	/* rq "owned" by this entity/group: */
-	struct rt_rq			*my_q;
 #endif
 } __randomize_layout;
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 94693093b70..1cdc699bbb7 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1,4 +1,3 @@
-#pragma GCC diagnostic ignored "-Wunused-function"
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Real-Time Scheduling Class (mapped to the SCHED_FIFO and SCHED_RR
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 97e1e779df9..fddb171145e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -310,15 +310,6 @@ struct rt_prio_array {
 	struct list_head queue[MAX_RT_PRIO];
 };
 
-struct rt_bandwidth {
-	/* nests inside the rq lock: */
-	raw_spinlock_t		rt_runtime_lock;
-	ktime_t			rt_period;
-	u64			rt_runtime;
-	struct hrtimer		rt_period_timer;
-	unsigned int		rt_period_active;
-};
-
 struct dl_bandwidth {
 	raw_spinlock_t          dl_runtime_lock;
 	u64                     dl_runtime;
@@ -485,7 +476,6 @@ struct task_group {
 	struct sched_dl_entity	**dl_se;
 	struct rt_rq		**rt_rq;
 
-	struct rt_bandwidth	rt_bandwidth;
 	struct dl_bandwidth	dl_bandwidth;
 #endif
 
@@ -801,11 +791,6 @@ struct scx_rq {
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
 
-static inline int rt_bandwidth_enabled(void)
-{
-	return 0;
-}
-
 /* RT IPI pull logic requires IRQ_WORK */
 #if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP)
 # define HAVE_RT_PUSH_IPI
@@ -823,17 +808,6 @@ struct rt_rq {
 	bool			overloaded;
 	struct plist_head	pushable_tasks;
 
-	int			rt_queued;
-
-#ifdef CONFIG_RT_GROUP_SCHED
-	int			rt_throttled;
-	u64			rt_time; /* consumed RT time, goes up in update_curr_rt */
-	u64			rt_runtime; /* allotted RT time, "slice" from rt_bandwidth, RT sharing/balancing */
-	/* Nests inside the rq lock: */
-	raw_spinlock_t		rt_runtime_lock;
-
-	unsigned int		rt_nr_boosted;
-#endif
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group	*tg; /* this tg has "this" rt_rq on given CPU for runnable entities */
 #endif
-- 
2.51.0


