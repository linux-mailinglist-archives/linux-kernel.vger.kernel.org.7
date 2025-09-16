Return-Path: <linux-kernel+bounces-819074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ED3B59AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA79188185E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D43451DE;
	Tue, 16 Sep 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA37iMzT"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E4340DA6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034296; cv=none; b=YQwqpDslLS6yA38UBaSt303a9se3z4ciAJNb0qEEkKIMHeKt1N33dLa5wMhhkFmuIpATM3lMy3b4A5jWXFbIPRvt7zeTxflbloOZATln+zGf4ZQxk9PtoybP09+sqmn/lb9HbJucXjSw84EIGlcR+WJTaBne6f3/Le4dbrrJaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034296; c=relaxed/simple;
	bh=yOPhsR+6OpKcNKrqhey8Xj+vyqWvzKZzXBp3TDEgG/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBds+L+nYi0GpBznc6mccVH9cdGvyLYV+xVPU5xdg9n6/Qrs5pa3cYFMceyYn70jWXEeH5vbqBUbeNs+OSE7f1fPc0bmIT0c/c77lN3wrjuJ5FYn7Dfk+20n2ysK1NUoHF59j9HlUZoFhvgHu2SkpHAh5RzikgqX5K99NDCmkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA37iMzT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso4893021b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034293; x=1758639093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUdV9b+MUzYSykR4K0EUwi33bkRUh9yRXeB209qpl0M=;
        b=QA37iMzTTb+XkTNYawuCX+Du7cLne7bvEtd7sHXX/cvCS1g2Qpfj7E6l02msnxR03u
         tPdxz3FvQl1zVHP+sCnAoXLfo6C8tDjF49YuuhdpA3TuNj89+fnKSr3S00XDrNjklDyk
         6kVnB/QgrZ2g2y5DBQuNszENE5X4GN9RvqeLAuC7utEA3Q96kHmaA6nCbN4Tb+znNBE4
         YWUiS2w83Kmdgz2/wQ7nSr7kY6l1J+40hh5ghoyVhTQNMJXIOeOPpFvjDKVTb43Wc/rk
         jit5i292+a3jjJo8XAAGZt44LwqdNK/D6puUeGmcOodViqxMv4jE7ra7i2UXiXxFDXGQ
         XzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034293; x=1758639093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUdV9b+MUzYSykR4K0EUwi33bkRUh9yRXeB209qpl0M=;
        b=Wa4+PSTToITTB64jjB9Uw+9BtWxNgug6/QW1wWIUNnrfxnixoYkYThaX8AWdxquC8a
         BvbCzcLbP/OcK2xNogKbEhQxDhVOgNyRb4aQinvL9pyNxjRV0+57E6uDxxqQTHUCeeKx
         nB5UIQ1y5PJeKg4kSpH97gYBxEdcm1my1M0pxkOMgoxCyLqw2eXfxvopYOiXPlTh/Ssm
         ofHuVEw0EgXQkCOiZFOmNJhBaOi4uTKvkfSO5sk5vFiSv0jYmYL9gpIjnXuFhIyogySb
         74yBeQ06cuDrwU5PSn7l+BrnZgj08im7VNiVFvcypdsBp5LJrGVFJOeRdysDxeRnAy21
         ChCw==
X-Forwarded-Encrypted: i=1; AJvYcCXl7URfLO3F3TssqmEWzDs0HPbIs9vHIWCPvwHn6gE7/cvr2UzV7z9uX9MdMkia1PpcbwlksKwj7aCT9r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlM/nU7aXqwiL/nWwOnx7xfMhWwesE5/EUcy/T5WexL3aARSH
	9xfUhKDBNu8VNJw7zMvMzenvrhjdsBhFUWTe1G3RUVX1B2HUEBVCx70Q
X-Gm-Gg: ASbGnctEzcESrpJed6WM8G/3+SXP+8/5Lh9pznu0KF1uXcYFGAem0E9vu96/xPAtPYy
	5Em41lXl82LACfRtFaJfA7Z5aFK3ztUcLg0nLyC0EiXSVD8RqNgDRkChYcI5lXjaH5HPBkK9TqL
	HrZsduWDxl3sVQifDGYjx27klqRjzP5tDiDewCjQ/hrZZaCTAANGUYYya82hmoouHiQPwEZ0ZPO
	wXetPrw+sToeUXFlh8vbkaNimyMgLPeyYwtTqCR+s5z1kRn99Ktoowdohagj7vZDGE7dWqFT9aQ
	qKpKBCLsPK+Lug094vi1hUIpnaDrc7hS+6RjdyaRFsv69ipA1YEhfLCsw1EJrcXgpfyNErwCKrZ
	GWGAYXtOtlFkdSLLYjUhNE1FGsPew52ih6GLGyQx+7w==
X-Google-Smtp-Source: AGHT+IHnm4FCK6Te/CibvzapeGhIkDjpDqsd9Sk7/lgMPhn0W5OUMZuiBGRdKNd0yHfUApRIAYjXUQ==
X-Received: by 2002:a05:6a00:13a5:b0:772:5165:3f68 with SMTP id d2e1a72fcca58-77612194091mr20274566b3a.27.1758034293145;
        Tue, 16 Sep 2025 07:51:33 -0700 (PDT)
Received: from localhost ([194.50.154.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b18371sm16676053b3a.49.2025.09.16.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:51:32 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Doug Anderson <dianders@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	kees@kernel.org,
	masahiroy@kernel.org,
	aliceryhl@google.com,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	xur@google.com,
	ruanjinjie@huawei.com,
	gshan@redhat.com,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com,
	gautam@linux.ibm.com,
	arnd@arndb.de,
	zhao.xichao@vivo.com,
	rppt@kernel.org,
	lihuafei1@huawei.com,
	coxu@redhat.com,
	jpoimboe@kernel.org,
	yaozhenguo1@gmail.com,
	luogengkun@huaweicloud.com,
	max.kellermann@ionos.com,
	tj@kernel.org,
	yury.norov@gmail.com,
	thorsten.blum@linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
Date: Tue, 16 Sep 2025 22:50:10 +0800
Message-ID: <20250916145122.416128-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <https://lore.kernel.org/all/20250915035355.10846-1-cuiyunhui@bytedance.com/>
References: <https://lore.kernel.org/all/20250915035355.10846-1-cuiyunhui@bytedance.com/>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the hard lockup detector is selected at compile time via
Kconfig, which requires a kernel rebuild to switch implementations.
This is inflexible, especially on systems where a perf event may not
be available or may be needed for other tasks.

This commit refactors the hard lockup detector to replace a rigid
compile-time choice with a flexible build-time and boot-time solution.
The patch supports building the kernel with either detector
independently, or with both. When both are built, a new boot parameter
`hardlockup_detector="perf|buddy"` allows the selection at boot time.
This is a more robust and user-friendly design.

This patch is a follow-up to the discussion on the kernel mailing list
regarding the preference and future of the hard lockup detectors. It
implements a flexible solution that addresses the community's need to
select an appropriate detector at boot time.

The core changes are:
- The `perf` and `buddy` watchdog implementations are separated into
  distinct functions (e.g., `watchdog_perf_hardlockup_enable`).
- Global function pointers are introduced (`watchdog_hardlockup_enable_ptr`)
  to serve as a single API for the entire feature.
- A new `hardlockup_detector=` boot parameter is added to allow the
  user to select the desired detector at boot time.
- The Kconfig options are simplified by removing the complex
  `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both detectors to be
  built without mutual exclusion.
- The weak stubs are updated to call the new function pointers,
  centralizing the watchdog logic.

Link: https://lore.kernel.org/all/20250915035355.10846-1-cuiyunhui@bytedance.com/
Link: https://lore.kernel.org/all/CAD=FV=WWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo6W7q6jRCkg@mail.gmail.com/

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++
 include/linux/nmi.h                           |  6 +++
 kernel/watchdog.c                             | 46 ++++++++++++++++++-
 kernel/watchdog_buddy.c                       |  7 +--
 kernel/watchdog_perf.c                        | 10 ++--
 lib/Kconfig.debug                             | 37 +++++++--------
 6 files changed, 85 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5a7a83c411e9..0af214ee566c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1828,6 +1828,13 @@
 			backtraces on all cpus.
 			Format: 0 | 1
 
+	hardlockup_detector=
+			[perf, buddy] Selects the hard lockup detector to use at
+			boot time.
+			Format: <string>
+			- "perf": Use the perf-based detector.
+			- "buddy": Use the buddy-based detector.
+
 	hash_pointers=
 			[KNL,EARLY]
 			By default, when pointers are printed to the console
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index cf3c6ab408aa..9298980ce572 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -100,6 +100,9 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
+void watchdog_perf_hardlockup_enable(unsigned int cpu);
+void watchdog_perf_hardlockup_disable(unsigned int cpu);
+extern int watchdog_perf_hardlockup_probe(void);
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
 extern void hardlockup_config_perf_event(const char *str);
@@ -120,6 +123,9 @@ void watchdog_hardlockup_disable(unsigned int cpu);
 void lockup_detector_reconfigure(void);
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_BUDDY
+void watchdog_buddy_hardlockup_enable(unsigned int cpu);
+void watchdog_buddy_hardlockup_disable(unsigned int cpu);
+int watchdog_buddy_hardlockup_probe(void);
 void watchdog_buddy_check_hardlockup(int hrtimer_interrupts);
 #else
 static inline void watchdog_buddy_check_hardlockup(int hrtimer_interrupts) {}
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 80b56c002c7f..85451d24a77d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -55,6 +55,37 @@ unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+/* The global function pointers */
+void (*watchdog_hardlockup_enable_ptr)(unsigned int cpu) = watchdog_perf_hardlockup_enable;
+void (*watchdog_hardlockup_disable_ptr)(unsigned int cpu) = watchdog_perf_hardlockup_disable;
+int (*watchdog_hardlockup_probe_ptr)(void) = watchdog_perf_hardlockup_probe;
+#elif defined(CONFIG_HARDLOCKUP_DETECTOR_BUDDY)
+void (*watchdog_hardlockup_enable_ptr)(unsigned int cpu) = watchdog_buddy_hardlockup_enable;
+void (*watchdog_hardlockup_disable_ptr)(unsigned int cpu) = watchdog_buddy_hardlockup_disable;
+int (*watchdog_hardlockup_probe_ptr)(void) = watchdog_buddy_hardlockup_probe;
+#endif
+
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_MULTIPLE
+static char *hardlockup_detector_type = "perf"; /* Default to perf */
+static int __init set_hardlockup_detector_type(char *str)
+{
+	if (!strncmp(str, "perf", 4)) {
+		watchdog_hardlockup_enable_ptr = watchdog_perf_hardlockup_enable;
+		watchdog_hardlockup_disable_ptr = watchdog_perf_hardlockup_disable;
+		watchdog_hardlockup_probe_ptr = watchdog_perf_hardlockup_probe;
+	} else if (!strncmp(str, "buddy", 5)) {
+		watchdog_hardlockup_enable_ptr = watchdog_buddy_hardlockup_enable;
+		watchdog_hardlockup_disable_ptr = watchdog_buddy_hardlockup_disable;
+		watchdog_hardlockup_probe_ptr = watchdog_buddy_hardlockup_probe;
+	}
+	return 1;
+}
+
+__setup("hardlockup_detector=", set_hardlockup_detector_type);
+
+#endif
+
 # ifdef CONFIG_SMP
 int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
 # endif /* CONFIG_SMP */
@@ -262,9 +293,17 @@ static inline void watchdog_hardlockup_kick(void) { }
  * softlockup watchdog start and stop. The detector must select the
  * SOFTLOCKUP_DETECTOR Kconfig.
  */
-void __weak watchdog_hardlockup_enable(unsigned int cpu) { }
+void __weak watchdog_hardlockup_enable(unsigned int cpu)
+{
+	if (watchdog_hardlockup_enable_ptr)
+		watchdog_hardlockup_enable_ptr(cpu);
+}
 
-void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
+void __weak watchdog_hardlockup_disable(unsigned int cpu)
+{
+	if (watchdog_hardlockup_disable_ptr)
+		watchdog_hardlockup_disable_ptr(cpu);
+}
 
 /*
  * Watchdog-detector specific API.
@@ -275,6 +314,9 @@ void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
  */
 int __weak __init watchdog_hardlockup_probe(void)
 {
+	if (watchdog_hardlockup_probe_ptr)
+		return watchdog_hardlockup_probe_ptr();
+
 	return -ENODEV;
 }
 
diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
index ee754d767c21..390d89bfcafa 100644
--- a/kernel/watchdog_buddy.c
+++ b/kernel/watchdog_buddy.c
@@ -19,15 +19,16 @@ static unsigned int watchdog_next_cpu(unsigned int cpu)
 	return next_cpu;
 }
 
-int __init watchdog_hardlockup_probe(void)
+int __init watchdog_buddy_hardlockup_probe(void)
 {
 	return 0;
 }
 
-void watchdog_hardlockup_enable(unsigned int cpu)
+void watchdog_buddy_hardlockup_enable(unsigned int cpu)
 {
 	unsigned int next_cpu;
 
+	pr_info("ddddd %s\n", __func__);
 	/*
 	 * The new CPU will be marked online before the hrtimer interrupt
 	 * gets a chance to run on it. If another CPU tests for a
@@ -58,7 +59,7 @@ void watchdog_hardlockup_enable(unsigned int cpu)
 	cpumask_set_cpu(cpu, &watchdog_cpus);
 }
 
-void watchdog_hardlockup_disable(unsigned int cpu)
+void watchdog_buddy_hardlockup_disable(unsigned int cpu)
 {
 	unsigned int next_cpu = watchdog_next_cpu(cpu);
 
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 9c58f5b4381d..270110e58f20 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -153,10 +153,12 @@ static int hardlockup_detector_event_create(void)
  * watchdog_hardlockup_enable - Enable the local event
  * @cpu: The CPU to enable hard lockup on.
  */
-void watchdog_hardlockup_enable(unsigned int cpu)
+void watchdog_perf_hardlockup_enable(unsigned int cpu)
 {
 	WARN_ON_ONCE(cpu != smp_processor_id());
 
+	pr_info("ddddd %s\n", __func__);
+
 	if (hardlockup_detector_event_create())
 		return;
 
@@ -172,7 +174,7 @@ void watchdog_hardlockup_enable(unsigned int cpu)
  * watchdog_hardlockup_disable - Disable the local event
  * @cpu: The CPU to enable hard lockup on.
  */
-void watchdog_hardlockup_disable(unsigned int cpu)
+void watchdog_perf_hardlockup_disable(unsigned int cpu)
 {
 	struct perf_event *event = this_cpu_read(watchdog_ev);
 
@@ -257,10 +259,12 @@ bool __weak __init arch_perf_nmi_is_available(void)
 /**
  * watchdog_hardlockup_probe - Probe whether NMI event is available at all
  */
-int __init watchdog_hardlockup_probe(void)
+int __init watchdog_perf_hardlockup_probe(void)
 {
 	int ret;
 
+	pr_info("ddddd %s\n", __func__);
+
 	if (!arch_perf_nmi_is_available())
 		return -ENODEV;
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dc0e0c6ed075..443353fad1c1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1167,36 +1167,33 @@ config HARDLOCKUP_DETECTOR
 #
 # Note that arch-specific variants are always preferred.
 #
-config HARDLOCKUP_DETECTOR_PREFER_BUDDY
-	bool "Prefer the buddy CPU hardlockup detector"
-	depends on HARDLOCKUP_DETECTOR
-	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETECTOR_BUDDY
-	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
-	help
-	  Say Y here to prefer the buddy hardlockup detector over the perf one.
-
-	  With the buddy detector, each CPU uses its softlockup hrtimer
-	  to check that the next CPU is processing hrtimer interrupts by
-	  verifying that a counter is increasing.
-
-	  This hardlockup detector is useful on systems that don't have
-	  an arch-specific hardlockup detector or if resources needed
-	  for the hardlockup detector are better used for other things.
-
 config HARDLOCKUP_DETECTOR_PERF
-	bool
+	bool "Enable perf-based hard lockup detector (preferred)"
 	depends on HARDLOCKUP_DETECTOR
-	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
+	depends on HAVE_HARDLOCKUP_DETECTOR_PERF
 	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
+	help
+	  This detector uses a perf event on the CPU to detect when a CPU
+	  has become non-maskable interrupt (NMI) stuck. This is the
+	  preferred method on modern systems as it can detect lockups on
+	  all CPUs at the same time.
 
 config HARDLOCKUP_DETECTOR_BUDDY
-	bool
+	bool "Enable buddy-based hard lockup detector"
 	depends on HARDLOCKUP_DETECTOR
 	depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
-	depends on !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_PREFER_BUDDY
 	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
+	help
+	  This is an alternative lockup detector that uses a heartbeat
+	  mechanism between CPUs to detect when one has stopped responding.
+	  It is less precise than the perf-based detector and cannot detect
+	  all-CPU lockups, but it does not require a perf counter.
+
+config CONFIG_HARDLOCKUP_DETECTOR_MULTIPLE
+	bool
+	depends on HARDLOCKUP_DETECTOR_PERF && HARDLOCKUP_DETECTOR_BUDDY
 
 config HARDLOCKUP_DETECTOR_ARCH
 	bool
-- 
2.43.0


