Return-Path: <linux-kernel+bounces-758234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D9FB1CCCE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D168818C4170
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B0E2C17B3;
	Wed,  6 Aug 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZMhPiND"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D0220458A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510261; cv=none; b=DMG8MtyI5jiXjUTldHrEg6nl9PPWpLkLmQaEcBH8leCfRXqDjNS+ZwYUumO6+2M3BWv8z35wSQ4/a+WF+nl2EA0PclH2NtuZ0P+bIla9HtBVZr+gJnnH0xakm4E+NEvAR3ESiVV1/WfrRHBTbaA/IiXNERNKZDx4gBmO8dn6bn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510261; c=relaxed/simple;
	bh=UrgGnFtSniCNk74J85bXS6weeSIBAARTVjsD4XCec00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hDKUgWCKWJPAhCEcYTYU1zB920eT6zoiOFx+WE1kyZBpIMki7UsHXnlCZELZ3MgnHVsdX7bKVwEQmxETPhQTPEk0CuYz/PzBGltrv0Y31UsGI7lRtKUQ3baIEVlBjMpzwLn1d9SCQPeiVOhOXSFOGAU5Mf0ayziEoYu0FHW5pGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZMhPiND; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so326467a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510255; x=1755115055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rYhmmFtojtIGRiNFVnTHHWtxjI2pG0Wx0DryIldmwBo=;
        b=2ZMhPiNDAErmnwI2zROGgL8Evr67rVZeucWYoBU1LCBpoSLaePFK67B1/KTPIt6A0q
         L0W474PI55LKgD+ls3PQ7OY59u8gHQ5LKgD4ZVVwMgPth6ke1rd0m4rKhBCma0piVHu8
         6+KyQIacbW20biYZMFHnrBzppzKJvVVFNY4hVLxCl4O7JGXAkVzdGTJsfgOaE4hUeYfO
         8Sp/veWbirp7nabFpeK8ovKmyqyRu4gXJ5CdjDW6UNmamzQ6Joqutt93IqG/gYwaT9R/
         kL2myaYT2pWAHEwpVtPHzYqF3BjkRpL3AyuXfC4nBmGgZZRUDosfj2AC8B2fCaOsoJFR
         VMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510255; x=1755115055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYhmmFtojtIGRiNFVnTHHWtxjI2pG0Wx0DryIldmwBo=;
        b=QgTDjlqTvQVf6I8R/jWuB2i0WB9SK9VCddJ8mJuLpK2+fooAZdfhEEhL5KyWZ/2QZC
         a/94GVidxBad80kXcKoU9FfeUXR1fXQUkQ2bDMTT4OTFfXNBEfe8NXXVsyw/5LjiRy4Z
         M6F1xWPlSjWHZ+tCM1FMFgwMySAbLBrnTMA3tGG99YtvcnKLyqi9bbl1Ck2dqLuD2KOG
         GzR+UAJ7x0VmTYROs/5gM8/IG6XfPSHypbSbuEv4RVNf0ESewTh2ek4rGkwixn0mZ99+
         B7fqE4m7+a0mQ5cpX9kgOrZrD+K3tDiE3N/MJKa8k7rWkY2ru0sCbzEgGH00Paqt/FIH
         SP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJN9Tp+rVLc4fnkrGP9BloDmOK6AiFCfk4dA0+8T8mHcbb7oy2JN5ZIR2rDeyN5Soh53Oa0i9Uk7zKzcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fRv0u/yNxEEscnkh7Mk0DDqofJx6la+m8y10kT8kdpaLzk9V
	akVObXbkONr3IOWS2s1+V1fZZXNY6IIrLD1b8eEKn6zEtopzenATqi7cqSx9HlIr7LuaRsvezKx
	Ugf6w5w==
X-Google-Smtp-Source: AGHT+IE1JXMzx+3+mEhB/aRAtKWF6tsabKOHfV9vXr8D6RhEuIeRQytpFLmD0EN42AoRsIYuN8o0xUeAxdE=
X-Received: from pjbso3.prod.google.com ([2002:a17:90b:1f83:b0:311:1a09:11ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac1:b0:31e:f193:1822
 with SMTP id 98e67ed59e1d1-32166ccac82mr5176638a91.28.1754510255466; Wed, 06
 Aug 2025 12:57:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:26 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-5-seanjc@google.com>
Subject: [PATCH v5 04/44] perf: Add APIs to create/release mediated guest vPMUs
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

Currently, exposing PMU capabilities to a KVM guest is done by emulating
guest PMCs via host perf events, i.e. by having KVM be "just" another user
of perf.  As a result, the guest and host are effectively competing for
resources, and emulating guest accesses to vPMU resources requires
expensive actions (expensive relative to the native instruction).  The
overhead and resource competition results in degraded guest performance
and ultimately very poor vPMU accuracy.

To address the issues with the perf-emulated vPMU, introduce a "mediated
vPMU", where the data plane (PMCs and enable/disable knobs) is exposed
directly to the guest, but the control plane (event selectors and access
to fixed counters) is managed by KVM (via MSR interceptions).  To allow
host perf usage of the PMU to (partially) co-exist with KVM/guest usage
of the PMU, KVM and perf will coordinate to a world switch between host
perf context and guest vPMU context near VM-Enter/VM-Exit.

Add two exported APIs, perf_{create,release}_mediated_pmu(), to allow KVM
to create and release a mediated PMU instance (per VM).  Because host perf
context will be deactivated while the guest is running, mediated PMU usage
will be mutually exclusive with perf analysis of the guest, i.e. perf
events that do NOT exclude the guest will not behave as expected.

To avoid silent failure of !exclude_guest perf events, disallow creating a
mediated PMU if there are active !exclude_guest events, and on the perf
side, disallowing creating new !exclude_guest perf events while there is
at least one active mediated PMU.

Exempt PMU resources that do not support mediated PMU usage, i.e. that are
outside the scope/view of KVM's vPMU and will not be swapped out while the
guest is running.

Guard mediated PMU with a new kconfig to help readers identify code paths
that are unique to mediated PMU support, and to allow for adding arch-
specific hooks without stubs.  KVM x86 is expected to be the only KVM
architecture to support a mediated PMU in the near future (e.g. arm64 is
trending toward a partitioned PMU implementation), and KVM x86 will select
PERF_GUEST_MEDIATED_PMU unconditionally, i.e. won't need stubs.

Immediately select PERF_GUEST_MEDIATED_PMU when KVM x86 is enabled so that
all paths are compile tested.  Full KVM support is on its way...

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: add kconfig and WARNing, rewrite changelog, swizzle patch ordering]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig       |  1 +
 include/linux/perf_event.h |  6 +++
 init/Kconfig               |  4 ++
 kernel/events/core.c       | 82 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 2c86673155c9..ee67357b5e36 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -37,6 +37,7 @@ config KVM_X86
 	select SCHED_INFO
 	select PERF_EVENTS
 	select GUEST_PERF_EVENTS
+	select PERF_GUEST_MEDIATED_PMU
 	select HAVE_KVM_MSI
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_NO_POLL
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ec9d96025683..63097beb5f02 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -305,6 +305,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
 #define PERF_PMU_CAP_AUX_PAUSE		0x0200
 #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
+#define PERF_PMU_CAP_MEDIATED_VPMU	0x0800
 
 /**
  * pmu::scope
@@ -1914,6 +1915,11 @@ extern int perf_event_account_interrupt(struct perf_event *event);
 extern int perf_event_period(struct perf_event *event, u64 value);
 extern u64 perf_event_pause(struct perf_event *event, bool reset);
 
+#ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
+int perf_create_mediated_pmu(void);
+void perf_release_mediated_pmu(void);
+#endif
+
 #else /* !CONFIG_PERF_EVENTS: */
 
 static inline void *
diff --git a/init/Kconfig b/init/Kconfig
index 666783eb50ab..1e3c90c3f24f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1955,6 +1955,10 @@ config GUEST_PERF_EVENTS
 	bool
 	depends on HAVE_PERF_EVENTS
 
+config PERF_GUEST_MEDIATED_PMU
+	bool
+	depends on GUEST_PERF_EVENTS
+
 config PERF_USE_VMALLOC
 	bool
 	help
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1753a97638a3..bf0347231bd9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5651,6 +5651,8 @@ static void __free_event(struct perf_event *event)
 	call_rcu(&event->rcu_head, free_event_rcu);
 }
 
+static void mediated_pmu_unaccount_event(struct perf_event *event);
+
 DEFINE_FREE(__free_event, struct perf_event *, if (_T) __free_event(_T))
 
 /* vs perf_event_alloc() success */
@@ -5660,6 +5662,7 @@ static void _free_event(struct perf_event *event)
 	irq_work_sync(&event->pending_disable_irq);
 
 	unaccount_event(event);
+	mediated_pmu_unaccount_event(event);
 
 	if (event->rb) {
 		/*
@@ -6182,6 +6185,81 @@ u64 perf_event_pause(struct perf_event *event, bool reset)
 }
 EXPORT_SYMBOL_GPL(perf_event_pause);
 
+#ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
+static atomic_t nr_include_guest_events __read_mostly;
+
+static atomic_t nr_mediated_pmu_vms __read_mostly;
+static DEFINE_MUTEX(perf_mediated_pmu_mutex);
+
+/* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
+static inline bool is_include_guest_event(struct perf_event *event)
+{
+	if ((event->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&
+	    !event->attr.exclude_guest)
+		return true;
+
+	return false;
+}
+
+static int mediated_pmu_account_event(struct perf_event *event)
+{
+	if (!is_include_guest_event(event))
+		return 0;
+
+	guard(mutex)(&perf_mediated_pmu_mutex);
+
+	if (atomic_read(&nr_mediated_pmu_vms))
+		return -EOPNOTSUPP;
+
+	atomic_inc(&nr_include_guest_events);
+	return 0;
+}
+
+static void mediated_pmu_unaccount_event(struct perf_event *event)
+{
+	if (!is_include_guest_event(event))
+		return;
+
+	atomic_dec(&nr_include_guest_events);
+}
+
+/*
+ * Currently invoked at VM creation to
+ * - Check whether there are existing !exclude_guest events of PMU with
+ *   PERF_PMU_CAP_MEDIATED_VPMU
+ * - Set nr_mediated_pmu_vms to prevent !exclude_guest event creation on
+ *   PMUs with PERF_PMU_CAP_MEDIATED_VPMU
+ *
+ * No impact for the PMU without PERF_PMU_CAP_MEDIATED_VPMU. The perf
+ * still owns all the PMU resources.
+ */
+int perf_create_mediated_pmu(void)
+{
+	guard(mutex)(&perf_mediated_pmu_mutex);
+	if (atomic_inc_not_zero(&nr_mediated_pmu_vms))
+		return 0;
+
+	if (atomic_read(&nr_include_guest_events))
+		return -EBUSY;
+
+	atomic_inc(&nr_mediated_pmu_vms);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(perf_create_mediated_pmu);
+
+void perf_release_mediated_pmu(void)
+{
+	if (WARN_ON_ONCE(!atomic_read(&nr_mediated_pmu_vms)))
+		return;
+
+	atomic_dec(&nr_mediated_pmu_vms);
+}
+EXPORT_SYMBOL_GPL(perf_release_mediated_pmu);
+#else
+static int mediated_pmu_account_event(struct perf_event *event) { return 0; }
+static void mediated_pmu_unaccount_event(struct perf_event *event) {}
+#endif
+
 /*
  * Holding the top-level event's child_mutex means that any
  * descendant process that has inherited this event will block
@@ -13024,6 +13102,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (err)
 		return ERR_PTR(err);
 
+	err = mediated_pmu_account_event(event);
+	if (err)
+		return ERR_PTR(err);
+
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
-- 
2.50.1.565.gc32cd1483b-goog


