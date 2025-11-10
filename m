Return-Path: <linux-kernel+bounces-893676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1AEC48147
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 816114F7BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB7931D376;
	Mon, 10 Nov 2025 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgN9V9tb"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122F31CA75
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792680; cv=none; b=EKZm5LgWci54uerJldL1o0zqDNRZObEx5Px7iSW7Y/MSs1E5xm2SUM0ScML20rQcrQQY3Pw4uZ/LGDPjtYoMEG9GF46zvBgDImxdECF/3lWvVDIUv7mZFIVxUuNroRRJjUTMICKHAp6Ly1S074Last7IiHTlwMxYBBorAyDgZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792680; c=relaxed/simple;
	bh=u5rYMDHG15I/cQVc25duuIIeZNrf7utvrw96eXmgPSk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMfBzw0VDe3hC/QgMRd9NjNNI3Al2E7mSdtC2hztVR6C7V5S23yTxOze4/hv5SgorpdlEJCZ2BuoQSnLfCd3uF2eKx53R9LzlQ3mGHTEmn+JmDwzWDoiZRW81xYTzZ6XyyVNNT84r8CJojlklzbraJbMvOjvrGT2gRN+nee9TzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgN9V9tb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29808a9a96aso13788535ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792678; x=1763397478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoYSCz9IZK+WTJVuSJ5kdqWuXYPyBcWSfVrsNGbuyIk=;
        b=jgN9V9tb1u2tX7EcLEJaOx8wVnAL8EdgrCnutPFBySuBe8TpcwF87l5bJQ05kv654B
         cRBwwUb7OcQ7aIzhsfrlsliFBLo+mwAO5bOIlAw7pABQSI22M5im1O7UsvfKKD3WPfIJ
         59xFuyiMRLSjUHiX/zWvMP2hKOzl+W18Lnibp77oIjYHMuf3ocBNME5HXl/QBIR8TG38
         z5fbBv+NGAXzYegr+TiiKlsjv9X0bCCDte2sTBJoL0gQAW8uoroPTAyGJq+iDottAPrO
         tUBL6mSsNOp2nUNd7s6m6GAnbNxJn8IRlo3LS6O248uqL8YUtliE1kDCunYS4RDkHcgr
         1YwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792678; x=1763397478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IoYSCz9IZK+WTJVuSJ5kdqWuXYPyBcWSfVrsNGbuyIk=;
        b=ETEQoCmLPZroAR0ejOiN5xbAryaSCe5fKqjUMiJWbEgsmy1pv/nn/iAwlIsUQjCpaH
         TRs9KzDMWcB16SDKfHHJ+UEr2uaTqQVMv7vcvF7AMaY+nl22BTN5+PUMqdpFrzqtF6sj
         YwBxLTJ6gticAi1Ay33IA6z0vSU0jmzRcwu0IU8H04z9ED7vGMTmfNxJTGHlzMGKXgp8
         zAuk0iFsFBb0vf1bIuu0m14ROaGUYjnjqcHocsHX2gZYue4r4g6Ej76o811ZFVtqZ3BS
         +DdfEQ1pZ7szxFXFukj8kTlqRCnWTAVofs9yzNH0EUHm46YCYUf+EXnbzaNN3GKNEtwb
         kjyg==
X-Forwarded-Encrypted: i=1; AJvYcCVnnlrSZzeiItVhjzjE6PKsZJNtNjLIIp0Dz+zBgYrDJcJ63/zcVuJ6QMxlBh2PbLvaHR7xRnWfQgtaVFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJhi64dsFQFgnGV8tnlEIjny/3gqE/y3StzrnAf8o1AmzQPZUo
	9TgzvgXjE6/bTpfB1ag0E8q2Zivq+JlsG+eZuGGS68WnqulQW1b1biYw
X-Gm-Gg: ASbGncvcnJJhVlu0sPo7v4YHQVANKdnHSciQWfhGeMjmTVsKYzoDabSuOwFwsBs3Zbn
	z4YFaaSq82vRRXupnV4xsTi841lF4IY9nqElWddLotYyTH9p1IZmmR1dU47iW/m+9xc3niARI7b
	jXj88SdGt4NamRWjUTeKrZeNSIQgUbbIVjYaumqYjmUF9izI5ZTWgKmPsc1LPNwIZvbZEcUQTgY
	S43PntCy1a4aHFVW8LJa4nzmP/P+DnFiv52HegGP0h7+beM833ML/QT/UOzBd4vFnubzSfc3t3d
	avO6vGvDay9LPyHh9MO2OWzoL3ivKv4jHVpchSHU3/KzqyGjivfxmlTlbPnDfs3ydYRWZDIuSml
	jcymhlGoRc5276xlDGU/ptHDYvqyZ0PVs1XLX4dv25gdRuE9RkS4DEWUzk/211VZe/MxTyaXYRl
	CK3Q36Yeh9WH4=
X-Google-Smtp-Source: AGHT+IGNkULY4KbMreL+r3C6zKYa6LAZ6HejhCC3QQjkk4WrB7CidoZ7O068kW/SdXYru/ivG/AiRg==
X-Received: by 2002:a17:902:e80e:b0:271:479d:3de2 with SMTP id d9443c01a7336-297e5624c9fmr126791755ad.13.1762792677804;
        Mon, 10 Nov 2025 08:37:57 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec88sm150510135ad.107.2025.11.10.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:57 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 17/27] mm/ksw: add KSTACKWATCH_PROFILING to measure probe cost
Date: Tue, 11 Nov 2025 00:36:12 +0800
Message-ID: <20251110163634.3686676-18-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_KSTACKWATCH_PROFILING enables runtime measurement of KStackWatch
probe latencies. When profiling is enabled, KStackWatch collects
entry/exit latencies in its probe callbacks. When KStackWatch is
disabled by clearing its config file, the previously collected statistics
are printed.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/Kconfig |  10 +++
 mm/kstackwatch/stack.c | 185 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 183 insertions(+), 12 deletions(-)

diff --git a/mm/kstackwatch/Kconfig b/mm/kstackwatch/Kconfig
index 496caf264f35..3c9385a15c33 100644
--- a/mm/kstackwatch/Kconfig
+++ b/mm/kstackwatch/Kconfig
@@ -12,3 +12,13 @@ config KSTACKWATCH
 	  introduce minor overhead during runtime monitoring.
 
 	  If unsure, say N.
+
+config KSTACKWATCH_PROFILING
+	bool "KStackWatch profiling"
+	depends on KSTACKWATCH
+	help
+	  Measure probe latency and overhead in KStackWatch. It records
+	  entry/exit probe times (ns and cycles) and shows statistics when
+	  stopping. Useful for performance tuning, not for production use.
+
+	  If unsure, say N.
diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index 3455d1e70db9..72ae2d3adeec 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -6,7 +6,10 @@
 #include <linux/kprobes.h>
 #include <linux/kstackwatch.h>
 #include <linux/kstackwatch_types.h>
+#include <linux/ktime.h>
+#include <linux/percpu.h>
 #include <linux/printk.h>
+#include <linux/timex.h>
 
 #define MAX_CANARY_SEARCH_STEPS 128
 static struct kprobe entry_probe;
@@ -15,6 +18,120 @@ static struct fprobe exit_probe;
 static bool probe_enable;
 static u16 probe_generation;
 
+#ifdef CONFIG_KSTACKWATCH_PROFILING
+struct measure_data {
+	u64 total_entry_with_watch_ns;
+	u64 total_entry_with_watch_cycles;
+	u64 total_entry_without_watch_ns;
+	u64 total_entry_without_watch_cycles;
+	u64 total_exit_with_watch_ns;
+	u64 total_exit_with_watch_cycles;
+	u64 total_exit_without_watch_ns;
+	u64 total_exit_without_watch_cycles;
+	u64 entry_with_watch_count;
+	u64 entry_without_watch_count;
+	u64 exit_with_watch_count;
+	u64 exit_without_watch_count;
+};
+
+static DEFINE_PER_CPU(struct measure_data, measure_stats);
+
+struct measure_ctx {
+	u64 ns_start;
+	u64 cycles_start;
+};
+
+static __always_inline void measure_start(struct measure_ctx *ctx)
+{
+	ctx->ns_start = ktime_get_ns();
+	ctx->cycles_start = get_cycles();
+}
+
+static __always_inline void measure_end(struct measure_ctx *ctx, u64 *total_ns,
+					u64 *total_cycles, u64 *count)
+{
+	u64 ns_end = ktime_get_ns();
+	u64 c_end = get_cycles();
+
+	*total_ns += ns_end - ctx->ns_start;
+	*total_cycles += c_end - ctx->cycles_start;
+	(*count)++;
+}
+
+static void show_measure_stats(void)
+{
+	int cpu;
+	struct measure_data sum = {};
+
+	for_each_possible_cpu(cpu) {
+		struct measure_data *md = per_cpu_ptr(&measure_stats, cpu);
+
+		sum.total_entry_with_watch_ns += md->total_entry_with_watch_ns;
+		sum.total_entry_with_watch_cycles +=
+			md->total_entry_with_watch_cycles;
+		sum.total_entry_without_watch_ns +=
+			md->total_entry_without_watch_ns;
+		sum.total_entry_without_watch_cycles +=
+			md->total_entry_without_watch_cycles;
+
+		sum.total_exit_with_watch_ns += md->total_exit_with_watch_ns;
+		sum.total_exit_with_watch_cycles +=
+			md->total_exit_with_watch_cycles;
+		sum.total_exit_without_watch_ns +=
+			md->total_exit_without_watch_ns;
+		sum.total_exit_without_watch_cycles +=
+			md->total_exit_without_watch_cycles;
+
+		sum.entry_with_watch_count += md->entry_with_watch_count;
+		sum.entry_without_watch_count += md->entry_without_watch_count;
+		sum.exit_with_watch_count += md->exit_with_watch_count;
+		sum.exit_without_watch_count += md->exit_without_watch_count;
+	}
+
+#define AVG(ns, cnt) ((cnt) ? ((ns) / (cnt)) : 0ULL)
+
+	pr_info("entry (with watch):    %llu ns, %llu cycles (%llu samples)\n",
+		AVG(sum.total_entry_with_watch_ns, sum.entry_with_watch_count),
+		AVG(sum.total_entry_with_watch_cycles,
+		    sum.entry_with_watch_count),
+		sum.entry_with_watch_count);
+
+	pr_info("entry (without watch): %llu ns, %llu cycles (%llu samples)\n",
+		AVG(sum.total_entry_without_watch_ns,
+		    sum.entry_without_watch_count),
+		AVG(sum.total_entry_without_watch_cycles,
+		    sum.entry_without_watch_count),
+		sum.entry_without_watch_count);
+
+	pr_info("exit (with watch):     %llu ns, %llu cycles (%llu samples)\n",
+		AVG(sum.total_exit_with_watch_ns, sum.exit_with_watch_count),
+		AVG(sum.total_exit_with_watch_cycles,
+		    sum.exit_with_watch_count),
+		sum.exit_with_watch_count);
+
+	pr_info("exit (without watch):  %llu ns, %llu cycles (%llu samples)\n",
+		AVG(sum.total_exit_without_watch_ns,
+		    sum.exit_without_watch_count),
+		AVG(sum.total_exit_without_watch_cycles,
+		    sum.exit_without_watch_count),
+		sum.exit_without_watch_count);
+}
+
+static void reset_measure_stats(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct measure_data *md = per_cpu_ptr(&measure_stats, cpu);
+
+		memset(md, 0, sizeof(*md));
+	}
+
+	pr_info("measure stats reset.\n");
+}
+
+#endif
+
 static void ksw_reset_ctx(void)
 {
 	struct ksw_ctx *ctx = &current->ksw_ctx;
@@ -159,25 +276,28 @@ static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 				    unsigned long flags)
 {
 	struct ksw_ctx *ctx = &current->ksw_ctx;
-	ulong stack_pointer;
-	ulong watch_addr;
+	ulong stack_pointer, watch_addr;
 	u16 watch_len;
 	int ret;
+#ifdef CONFIG_KSTACKWATCH_PROFILING
+	struct measure_ctx m;
+	struct measure_data *md = this_cpu_ptr(&measure_stats);
+	bool watched = false;
+
+	measure_start(&m);
+#endif
 
 	stack_pointer = kernel_stack_pointer(regs);
 
-	/*
-	 * triggered more than once, may be in a loop
-	 */
 	if (ctx->wp && ctx->sp == stack_pointer)
-		return;
+		goto out;
 
 	if (!ksw_stack_check_ctx(true))
-		return;
+		goto out;
 
 	ret = ksw_watch_get(&ctx->wp);
 	if (ret)
-		return;
+		goto out;
 
 	ret = ksw_stack_prepare_watch(regs, ksw_get_config(), &watch_addr,
 				      &watch_len);
@@ -185,17 +305,32 @@ static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 		ksw_watch_off(ctx->wp);
 		ctx->wp = NULL;
 		pr_err("failed to prepare watch target: %d\n", ret);
-		return;
+		goto out;
 	}
 
 	ret = ksw_watch_on(ctx->wp, watch_addr, watch_len);
 	if (ret) {
 		pr_err("failed to watch on depth:%d addr:0x%lx len:%u %d\n",
 		       ksw_get_config()->depth, watch_addr, watch_len, ret);
-		return;
+		goto out;
 	}
 
 	ctx->sp = stack_pointer;
+#ifdef CONFIG_KSTACKWATCH_PROFILING
+	watched = true;
+#endif
+
+out:
+#ifdef CONFIG_KSTACKWATCH_PROFILING
+	if (watched)
+		measure_end(&m, &md->total_entry_with_watch_ns,
+			    &md->total_entry_with_watch_cycles,
+			    &md->entry_with_watch_count);
+	else
+		measure_end(&m, &md->total_entry_without_watch_ns,
+			    &md->total_entry_without_watch_cycles,
+			    &md->entry_without_watch_count);
+#endif
 }
 
 static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
@@ -203,15 +338,36 @@ static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
 				   struct ftrace_regs *regs, void *data)
 {
 	struct ksw_ctx *ctx = &current->ksw_ctx;
+#ifdef CONFIG_KSTACKWATCH_PROFILING
+	struct measure_ctx m;
+	struct measure_data *md = this_cpu_ptr(&measure_stats);
+	bool watched = false;
 
+	measure_start(&m);
+#endif
 	if (!ksw_stack_check_ctx(false))
-		return;
+		goto out;
 
 	if (ctx->wp) {
 		ksw_watch_off(ctx->wp);
 		ctx->wp = NULL;
 		ctx->sp = 0;
+#ifdef CONFIG_KSTACKWATCH_PROFILING
+		watched = true;
+#endif
 	}
+
+out:
+#ifdef CONFIG_KSTACKWATCH_PROFILING
+	if (watched)
+		measure_end(&m, &md->total_exit_with_watch_ns,
+			    &md->total_exit_with_watch_cycles,
+			    &md->exit_with_watch_count);
+	else
+		measure_end(&m, &md->total_exit_without_watch_ns,
+			    &md->total_exit_without_watch_cycles,
+			    &md->exit_without_watch_count);
+#endif
 }
 
 int ksw_stack_init(void)
@@ -239,7 +395,9 @@ int ksw_stack_init(void)
 		unregister_kprobe(&entry_probe);
 		return ret;
 	}
-
+#ifdef CONFIG_KSTACKWATCH_PROFILING
+	reset_measure_stats();
+#endif
 	WRITE_ONCE(probe_generation, READ_ONCE(probe_generation) + 1);
 	WRITE_ONCE(probe_enable, true);
 
@@ -252,4 +410,7 @@ void ksw_stack_exit(void)
 	WRITE_ONCE(probe_generation, READ_ONCE(probe_generation) + 1);
 	unregister_fprobe(&exit_probe);
 	unregister_kprobe(&entry_probe);
+#ifdef CONFIG_KSTACKWATCH_PROFILING
+	show_measure_stats();
+#endif
 }
-- 
2.43.0


