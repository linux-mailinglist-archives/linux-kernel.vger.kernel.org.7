Return-Path: <linux-kernel+bounces-836019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A560BA895D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8BD189DB23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1EB2C0F9C;
	Mon, 29 Sep 2025 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdYB71c6"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79579288525
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137751; cv=none; b=PqfK1q7gmTWoGMbQex5Tr3CotfMM2PUIjGa52yWzd3D2fqCgM1xE9twRqH+cXAUfVgRHI99Y1QS8j850rH69eNAoQ4Y+AtNys917lxZK92SzQDZXkqMdJT8JZxX3IvKumuWepxSjGDsMCQ0W4vnIqeofxmlSOxw0xGlSrmeqOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137751; c=relaxed/simple;
	bh=92LgpsC9S+J3KClZDsE1ZiYjCcrnI7wmdf0SpM6xyHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g52WMXnrx4U7Mp/I8aqJSz3RPp8y/+gqdbknFBj3ZTy86hPLD4HLh/CrttLj405djnwDdxycOGQgcBXhbomVKHsiB+vm+ucx9SCRyeXifwR3Xl4oiDfZ/AfDsk4IJM4PIuGQ6IK7ej5TdICH6o2gzou8HRRG4aVd6kDkpQGElbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdYB71c6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3b27b50090so304299266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137748; x=1759742548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k5FST/O+5lHGgu9ZsVOdWQJG6/wJtNjeDkBuwWUIAo=;
        b=SdYB71c6EfDxx4EcDCPekb7rlQQJGRv/KJszpPfW9aoVW8nPRXRvLc0ZOQ+hTP6YMp
         I2IOzo3gonuDuxRHNfTYsrGbma/ZksMmvUVJ0E2aibTnwVva0BfChyBO8qQbmJFz8GNn
         RPZoDTNF0W+0r2/vqawCG+NYw+19JzZ62nmZCvTFnXyLqxEpKhw/xsL7s7mDOpYS/Nce
         U9iVBT+f/f5E/UlBBs7RDvxZCOP1QPIeC4WfXDOxrTwrqLRseCaFuf8aVkcy09WLglQb
         ZiKLvRbREyYIo2AIq0kfEWkgRLkAaRuK3JfpqdaJCgoP77bFptdZ39N02HTU/x5lM1K5
         KcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137748; x=1759742548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7k5FST/O+5lHGgu9ZsVOdWQJG6/wJtNjeDkBuwWUIAo=;
        b=OZrWFsJ/UtuQa3GmYKFhGnbMToD2Wmvug6c1OTHMlWMGVvOiX9iwHnoP+IENN5Dhua
         lZxfvTEDeEkHxOoChJY2QnPOQrkqWwrJ8YSvEJWPdD+ItJw0N5Gx+xMVTJTAOsvkM8UK
         y/nsnF4GL54SEOgTU3Ozme1xyocZlxost2jYWJW+G5p2S5G/QY9m2YqPnAe95gIrql0R
         XzKfFSOsx5KoYRzFTHoV/0Yz4QMkQ5Xhz+U17B3IdrDgSl6iWQn2QK9SMaCIh84V42+V
         +QNixducbbD0SDV6qlAezG49ip92ABv0FQy3xaQbjR5dQ+BQibQYLMmUirO+CUQogotJ
         jICw==
X-Gm-Message-State: AOJu0YxyEOQPuWa6SUD5BHFpgh0bY0hDtOfQUuhyA+fJSN94fNDgUW3i
	O1kVLB4IlGnwxsE3KhZLFwWJ8UIMrX0RqGStrJ3MarzYDoHa6pLclwVf
X-Gm-Gg: ASbGncu0+AHlf6s7RZemyBYoYa0/rMJ3KeSt5w1XH3vJmfk7Comudir1D63cj3lCuvB
	FtVP+orM7pRC34IkoLUgPuDt+vUpFgL0Ywp8qL9o3cO4IDbcwX4RJISjDhnlDE5pazaZlg7qzxF
	H8eJTiUFKXMCoPphwlZudCBiSr/LdyXx+A+w21JIw4RhtBiuDXqI+CdMsy2MeZi9ZtVswgEVPna
	rXr4t7PATCUCFa+FKH4MZDaw6XJOK1WEkqqsxnN06SWUnlx40PD9T3W1P1L68j3qgTOIm/Mn7Kc
	r51Syvn7mKWSi4w/vFCBXBZGAR54g+6WjdXxZ3fUCj/lLzy/HZeZP7xSbxpTpbHOl3zl/fbUu9x
	Uzpn1zSuzrHZ4CtF9rrKFlbUwUDRx+g==
X-Google-Smtp-Source: AGHT+IEPElphIZVl7S3799FuvysqXTO6qLcHaSp2KgeBoPSdMH41LOb/sP7J/XpospKPVklkqFRv4Q==
X-Received: by 2002:a17:906:2713:b0:b3c:a161:683b with SMTP id a640c23a62f3a-b3ca1617c55mr460797566b.60.1759137747751;
        Mon, 29 Sep 2025 02:22:27 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:27 -0700 (PDT)
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
Subject: [RFC PATCH v3 06/24] sched/rt: Introduce HCBS specific structs in task_group
Date: Mon, 29 Sep 2025 11:22:03 +0200
Message-ID: <20250929092221.10947-7-yurand2000@gmail.com>
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

Each task_group manages a number of new objects:
- a sched_dl_entity/dl_server for each CPU
- a dl_bandwidth object to keep track of its allocated dl_bandwidth

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/sched.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2d373a1ba67..59a154505d8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -319,6 +319,13 @@ struct rt_bandwidth {
 	unsigned int		rt_period_active;
 };
 
+struct dl_bandwidth {
+	raw_spinlock_t          dl_runtime_lock;
+	u64                     dl_runtime;
+	u64                     dl_period;
+};
+
+
 static inline int dl_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
@@ -467,10 +474,17 @@ struct task_group {
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_RT_GROUP_SCHED
+	/*
+	 * Each task group manages a different scheduling entity per CPU, i.e. a
+	 * different deadline server, and a runqueue per CPU. All the dl-servers
+	 * share the same dl_bandwidth object.
+	 */
 	struct sched_rt_entity	**rt_se;
+	struct sched_dl_entity	**dl_se;
 	struct rt_rq		**rt_rq;
 
 	struct rt_bandwidth	rt_bandwidth;
+	struct dl_bandwidth	dl_bandwidth;
 #endif
 
 	struct scx_task_group	scx;
@@ -817,12 +831,12 @@ struct rt_rq {
 	raw_spinlock_t		rt_runtime_lock;
 
 	unsigned int		rt_nr_boosted;
-
-	struct rq		*rq; /* this is always top-level rq, cache? */
 #endif
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group	*tg; /* this tg has "this" rt_rq on given CPU for runnable entities */
 #endif
+
+	struct rq		*rq; /* cgroup's runqueue if the rt_rq entity belongs to a cgroup, otherwise top-level rq */
 };
 
 static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
-- 
2.51.0


