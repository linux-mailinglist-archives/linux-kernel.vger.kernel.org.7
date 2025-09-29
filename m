Return-Path: <linux-kernel+bounces-836024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB60DBA896C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1F7189DE73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E708E2C21DB;
	Mon, 29 Sep 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJp8Xscn"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1B2C11C5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137754; cv=none; b=R5FunJsnxVaoBYt5GwBDNIIrS7N7/deglizFTjkEw0KA4iuyIvr9V1FHrWHa64gUz7xlwvFgl//ya2Gw3PPMI9Bg/FgttaPDWjDMhEtghnh3YvScQN/WcVb9E8sn0HpKZZW7D1jMmV8rsN1qHLMKfLZabkLc6BUZdR9nARWDQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137754; c=relaxed/simple;
	bh=h/pz6zvc6qYAU8k60RuBoW4qESIFMe3VdTt5+BJwZ1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCYLv4fCRucUCvPebGRvvcBd3iWt79dsRptvqSgqY63a3TOE+b+iMi9Rh0swmPT2aRx/+7q0wqjEqnPPO817Estuo24pSSeNmHqh9kp8SHKHJMyWhGSH1oJyHu34qN1/Es0hwzOUc3qsxpAihW+PJXxY24qE/4mj/J+sFLkC1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJp8Xscn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6364eb32535so681488a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137751; x=1759742551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewFloRXAVA2+FWERqq7N2JT61DFtN9Zpod7cZzsTfrk=;
        b=gJp8XscnUNlx8uD+3wKFvzFoyLjZT9IImK/pqnGSRsxiaFYdl3S4MjXrBqL37/+uK3
         DmvooXhp0pPBoPW4V2cTef0HuMp66sR6qHzL96JgA0sTSqow+6LlvlgxO6kPLl6iYSvY
         mj4XXnbECx2TMo3G3wEtriGgnk3D1S65ioIYm0Z3fgix62hJfqIcV6Z86MLtPP27UaZf
         kRyAXUP+my143CA8vv6jy+eZrS/G4U6yoVPS00SuTANghw2uHHldiq11eGvFAjfUxepL
         3wh4HoW8Bms1u7boBbj4/+o1t7CZoQPvI+HbWlINE2cHmrMXcQKiApYYZqQSUBoNjUzE
         bDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137751; x=1759742551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewFloRXAVA2+FWERqq7N2JT61DFtN9Zpod7cZzsTfrk=;
        b=H0QNBZYj2cielAm7ha4c9jo2FccznXizBmSR9nGLEK3n+HhzH5vTC2SWN83teLIDTF
         cp6VSAhR4OhvgfoUQlUGPwLb+DSobewU93HSyZPmbN7LaunKRWnBqFA6N6ADuHpNlPfI
         5uYFU8nxVJPBu0Qkev0cL7i5yx/tSwffI7g2ZUMDtpdzGmDzwQGBnnuQw2aCrsZQA1nt
         l6iNwt+H17E2ROp6fDOf1s/eVQh2pFXLD+7yEv0rq7HxRB1BZLTgfu7feQfC5VSScM2V
         WBPLmJ2mnjGTAR5H4OCGxyMALzZVp0mV1owtKYCvZvqnPMHSD/YdPr2AqgRHj/pd/AU1
         uV1Q==
X-Gm-Message-State: AOJu0Ywe864J6r9HJ0cCoSFCgbeOyO4VY0tlQi0LTEVfxq7uOOAYu+pc
	w/G4mK0VSxbYEWPejDOHl1tCZ0Nlwj6lEHmmjEbA4K0Q01uOM2pNhCIz
X-Gm-Gg: ASbGncsG+sEAW0QjouPKgH7sNwPeYqJN9qeq6uUHFyK5Rpc1KbZWMMdXOtpZp6qtO+L
	VyMB/sRDh0QiwFaaQSBNhVZe7eDwARj/1WQ/wFWMxVjYFjx99LlPzCJSCNwSg5pddQXitArvlNl
	krqoHuUqaaK8P4+ZJZh5kgUqR7Gbw5R/iXrDs4pVsYmeLZ0nCTOUN1yUWj+3FpPpNnmcWjaeExd
	AlvMW1iXxlJqMAIXtTc3tL1VP424Vui0WTYF7S+quuOSVIfsreHONmrcO1xBFLZ6jkTyWQbd9OE
	+7U0cG7BO+70d/8x9Ch7FMTSB4hFusU6qgBzeFw/ju7nIGAkPYE/0YpqNi8baMsVMKlbgMyToHs
	lEZKOaBuldxoktBLCXO12PLnZ/RZp/A==
X-Google-Smtp-Source: AGHT+IHBWp+fRHg6YJhpsfypwX85hWi5tD2FmRz3bBtNRkCmaEIip3zV15sacPRM3XW5RsKr85Ce4g==
X-Received: by 2002:a17:907:3f87:b0:b32:2b60:f13 with SMTP id a640c23a62f3a-b34bf94d3f9mr1899327066b.54.1759137750656;
        Mon, 29 Sep 2025 02:22:30 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:30 -0700 (PDT)
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
Subject: [RFC PATCH v3 10/24] sched/deadline: Account rt-cgroups bandwidth in deadline tasks schedulability tests.
Date: Mon, 29 Sep 2025 11:22:07 +0200
Message-ID: <20250929092221.10947-11-yurand2000@gmail.com>
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

Account the rt-cgroups hierarchy's reserved bandwidth in the schedulability
test of deadline entities. This mechanism allows to completely reserve portion
of the rt-bandwidth to rt-cgroups even if they do not use all of it.

Account for the rt-cgroups' reserved bandwidth also when changing the total
dedicated bandwidth for real time tasks.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/deadline.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 34a1494d782..754bfe231b4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -213,8 +213,15 @@ void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
 static inline bool
 __dl_overflow(struct dl_bw *dl_b, unsigned long cap, u64 old_bw, u64 new_bw)
 {
+	u64 dl_groups_root = 0;
+
+#ifdef CONFIG_RT_GROUP_SCHED
+	dl_groups_root = to_ratio(root_task_group.dl_bandwidth.dl_period,
+				  root_task_group.dl_bandwidth.dl_runtime);
+#endif
 	return dl_b->bw != -1 &&
-	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
+	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw
+					+ cap_scale(dl_groups_root, cap);
 }
 
 static inline
@@ -3150,10 +3157,16 @@ int sched_dl_global_validate(void)
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
 	u64 cookie = ++dl_cookie;
+	u64 dl_groups_root = 0;
 	struct dl_bw *dl_b;
-	int cpu, cpus, ret = 0;
+	int cpu, cap, cpus, ret = 0;
 	unsigned long flags;
 
+#ifdef CONFIG_RT_GROUP_SCHED
+	dl_groups_root = to_ratio(root_task_group.dl_bandwidth.dl_period,
+				  root_task_group.dl_bandwidth.dl_runtime);
+#endif
+
 	/*
 	 * Here we want to check the bandwidth not being set to some
 	 * value smaller than the currently allocated bandwidth in
@@ -3166,10 +3179,12 @@ int sched_dl_global_validate(void)
 			goto next;
 
 		dl_b = dl_bw_of(cpu);
+		cap = dl_bw_capacity(cpu);
 		cpus = dl_bw_cpus(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw * cpus < dl_b->total_bw)
+		if (new_bw * cpus < dl_b->total_bw +
+				    cap_scale(dl_groups_root, cap))
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
-- 
2.51.0


