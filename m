Return-Path: <linux-kernel+bounces-758233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539C6B1CCCA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7167856450E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C692BEFFA;
	Wed,  6 Aug 2025 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="krqFVzHx"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A22BE656
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510258; cv=none; b=KF4a44mch1F/OEAMAaCbL6r6HTEBrEj4UOPJKztjWXi7tuwAeDTv0CBrC+XQY8dYpHskRffUZ4Wffy5ZMDDf+CJ3dNomdFTbvyEXq4wkPR8kgYawx22GI8Gf9Bvjs8kgG2RI7DbbdfRU2QaSFZnjrkqeGGa0I9KTFu/RHQITlOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510258; c=relaxed/simple;
	bh=jUBl1OA0dbcCe9Exxx/O066eDYx/qkeyxg/XjKFA/3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bm6cyZwp747He5OUuqAhX9Fy3hw6U9u2HU3lw9MaLNJk02AqmM/8rA9xjTQHlpDjU5SyhJLtLP3QcbiuWwxGPQsL4i3u8EAd3UMnvkkQNfR5/JtQRKW1VRQODKTQGx3JLgX/gtGBqxBEyHQ/+SqxJqpTaCfMQL8zw9Xa4Ug1Pp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=krqFVzHx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bef13c254so290741b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510252; x=1755115052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3IAofGMjgJOHx6SdMcFjG4jFgSxJevKv5cJ/ErNkHsk=;
        b=krqFVzHx48sFUhkTmv5ZdxVvJJbo9yybHXbJml4FKAfQUxzOY4jH1x4IujuldA6FMr
         C0+zX0xKrvTclXv7jhBwPGfFMBwKz14JTJaEdBZ+70bCTbFbTQ5Xcu0limwYhQffnRT1
         FCaCbpNmWYehwuLFuoJuSmpfOfKEHjXyqoWRlcCcYUhWpxWox9SHW9jhq5ivmdwOnlOi
         M8VHe2C3cxVOVnnB16o4ieO9NP8RP8SSHnDvNPO8i3ftSat6W9nnq7VOVBrTtE1bSHEA
         GW1sz/GYRCc8mL0hoHmzkx1cVT3yt0t/1gWrYDYckq2x7Gw1de223JzLbu7xVcmqkXsS
         Ng6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510252; x=1755115052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IAofGMjgJOHx6SdMcFjG4jFgSxJevKv5cJ/ErNkHsk=;
        b=fFB+F1ILeyP5dPRiLEcXZGcxNeHSHXCinYWby+YxP+QXmYKoVBhjItyOsoBgiLLua0
         ICn6sSi2lRbxf77ETo6JsZNfITR9vhzskOiOpzIVs6bU1w8sq1+U3tEZwEN9jJ1M1JKN
         a4iFGBLwTJEdOKD2hjeWLPbuW48qNcKDRCfogSQJveK9cGRkM+iPOAugI25EivYpVDBA
         60Ti0yyfRwJMkBuHkzsyoNisdktQWjHoETstiU9L5xfJpQ1kT+BD985DBLKC/2B51J7M
         pVoyjLaFISpR99iy71R2yohVoDqWmoo0k9eLVJCO7/pbZ7NgoxnGtrFSgFtOgqvfhmfO
         V79Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtU8oRxWrHqso5Ek62L8HEEzF8YUXVGYP994IThMdPrzOZu2OO61Ik86rngZlwh79G0vBMcPQn2lrJHug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHr3hBfYmi9YedIKaf1lW+8VDQyik0lO2K7To1J6S9X69/piX
	qAjYc5OMs5bXsoyWLMsiZ/HN2ycTJCvcwQwiFUbuUz21jDERzXXu6tXmvI4IsHU1YxnaeArx2Sf
	xgPVeRw==
X-Google-Smtp-Source: AGHT+IGg8m1AYQ1T/bkneerdDiI2IWHPXHDhUcioTumR7faJkpYOSLNXQVSuuMxt1I5dkPrSi8WAHfNQ8i8=
X-Received: from pgc3.prod.google.com ([2002:a05:6a02:2f83:b0:b42:2da2:8848])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a103:b0:23f:f712:4103
 with SMTP id adf61e73a8af0-24041364f38mr1167741637.18.1754510252085; Wed, 06
 Aug 2025 12:57:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:24 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-3-seanjc@google.com>
Subject: [PATCH v5 02/44] perf: Add generic exclude_guest support
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Kan Liang <kan.liang@linux.intel.com>

Only KVM knows the exact time when a guest is entering/exiting. Expose
two interfaces to KVM to switch the ownership of the PMU resources.

All the pinned events must be scheduled in first. Extend the
perf_event_sched_in() helper to support extra flag, e.g., EVENT_GUEST.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/events/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d4528554528d..3a98e11d8efc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2866,14 +2866,15 @@ static void task_ctx_sched_out(struct perf_event_context *ctx,
 
 static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
 				struct perf_event_context *ctx,
-				struct pmu *pmu)
+				struct pmu *pmu,
+				enum event_type_t event_type)
 {
-	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED | event_type);
 	if (ctx)
-		 ctx_sched_in(ctx, pmu, EVENT_PINNED);
-	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
+		ctx_sched_in(ctx, pmu, EVENT_PINNED | event_type);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE | event_type);
 	if (ctx)
-		 ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE);
+		ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE | event_type);
 }
 
 /*
@@ -2929,7 +2930,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	else if (event_type & EVENT_PINNED)
 		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
 
-	perf_event_sched_in(cpuctx, task_ctx, pmu);
+	perf_event_sched_in(cpuctx, task_ctx, pmu, 0);
 
 	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
 		perf_pmu_enable(epc->pmu);
@@ -4147,7 +4148,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
 	}
 
-	perf_event_sched_in(cpuctx, ctx, NULL);
+	perf_event_sched_in(cpuctx, ctx, NULL, 0);
 
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, task, true);
 
-- 
2.50.1.565.gc32cd1483b-goog


