Return-Path: <linux-kernel+bounces-869332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805BDC079FF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9108F422C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8234C827;
	Fri, 24 Oct 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNq/FyEw"
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0934B433
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328774; cv=none; b=GjzmNpDc+beamLD7BqboshNTI+xzPtCwgGbAzshe+QRAczbeCxrYQ5HjQPnMDiUg4yqg3I/STHBAb0QYoDIHlNYQPNPDy5DjBV4xRg9+tBaTLpVpWOmr0xN7zIorG2wHw1+g//zndFrQwm3+3xiSZGS9CRgeNKzjNOpATsyl9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328774; c=relaxed/simple;
	bh=yMntZKYkgRZQFYoN31aa8lH7OuKk/lLDOw5E1rcZWpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YqwGrMAyj/2iilC+1idPeJIMOzkHLoLUI/vK72ZfNV/JBD50SUnGG7L/FyyCVsPyuvZp2l8UWUY6LVM7mH0RuBXcoHzZVQS+Pc//PK1fKPF6OmkcC/ep+FSFI7qhz26TQmplTUSjMZOn6kblaz6hmcjZmzLrBJkoQrdBmn0bXaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hNq/FyEw; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-63e2d3351abso2917850d50.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328771; x=1761933571; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+CZCPcXOtmhhwkMtz+KUve4ZRtL0G+pNivZyKPtADM=;
        b=hNq/FyEwvpjWaIF2vvHoqMJR0BUH8T+OjKhH7Jn8IotoGXLQe4v3gnqVMR1fA3wXfe
         /zJvdvVeMgLnDkBEn7gIN0NYH5hSd9fwxnypQ6tizVmU1FG0p8EoXQypyoexK7xyN18H
         CXdkkgBu8d18GDh5DLCfEurJdL+f146jDZUAFztpqXcBhLKrXMIN4TzVbCAb+D8h6EJi
         YYmC6uCGUWj7VwgX9FkORB24KptzUNmkkPJ1aQfn4EQTD6CfTdlZXw+gzpQ1Mvk3ZJVF
         7RbAEWCz616kAwGw+yxZcWoH5aESdP1dDRE2KfOYheEgYdgN4mdPcQgjyucsnv96+SPX
         V3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328771; x=1761933571;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+CZCPcXOtmhhwkMtz+KUve4ZRtL0G+pNivZyKPtADM=;
        b=BVPuRgd7Z+y5JHKa9cepQMKJsOaKMDM3pOJ8YO3pLPaXjkkpwogQBhZSzUWHYKZHWI
         SauB0Tpz8EGWzef7Grd0nd00+8L/wQKuEz7FW+LzzexIWKNERAkmihIJla2Vrkf4VokV
         qRu3gAX86J6Ro1ra/mTZaKpwcWlPRNsIhl9TvWL+6TQaceDyzE2G6PP6OLcIu1HIkRg0
         LO061hKTH6wSOoH9Z3uUVZtQrSX2CIjb3h+rirQmNuFv1xB6QE18CgCw81bzqLhWFNeL
         5JYLGb8Gqcezjzo2uuSy8CjdIsHNsNH7SBtLCX/VjJGWzvSlvTmTG6dTv2LQPtxspo5O
         L1cA==
X-Forwarded-Encrypted: i=1; AJvYcCXrnngWiAxnaZJgztKFbCpJUaEt6so+7t8j36U4BzmHq+fmd3zNkJZEKHJrVQ5uFwLe9QBrwW+MYvtTHE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6SBrnjfN+NCbeJ8+pRlQc8TuVEIK92i7Mk3Z6vWRWzxEzRCk
	vVXCfPCyq4fRdCTjA26l4x7r/ob+Sbt/t/gtE7P7+CkIf9qWSsI9k7VJeUL5Ucw91eHd6lKjtV0
	8dBwI4EJp8g==
X-Google-Smtp-Source: AGHT+IHTm++YylY4VKtwtku/JVus+ogofV6k6Peu1O0a4DwUOXQqcMH5mJjDiBqTnYOU99Fh+YBBtPdWauuB
X-Received: from ybbhb8.prod.google.com ([2002:a05:6902:4588:b0:eb9:54fc:2b4b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:610e:b0:785:aedf:4ac6
 with SMTP id 00721157ae682-785aedf6aa2mr227642207b3.6.1761328771185; Fri, 24
 Oct 2025 10:59:31 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:49 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-15-irogers@google.com>
Subject: [PATCH v1 14/22] perf stat: Sort default events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To improve the readability of default events/metrics, sort the evsels
after the Default metric groups have be parsed.

Before:
```
$ perf stat -a sleep 1
 Performance counter stats for 'system wide':

            21,194      context-switches                 #    752.1 cs/sec  cs_per_second
             TopdownL1 (cpu_core)                 #      9.4 %  tma_bad_speculation
                                                  #     25.0 %  tma_frontend_bound
                                                  #     37.0 %  tma_backend_bound
                                                  #     28.7 %  tma_retiring
             6,371      page-faults                      #    226.1 faults/sec  page_faults_per_second
       734,456,525      cpu_atom/cpu-cycles/             #      0.0 GHz  cycles_frequency       (49.77%)
     1,679,085,181      cpu_core/cpu-cycles/             #      0.1 GHz  cycles_frequency
             TopdownL1 (cpu_atom)                 #     19.2 %  tma_bad_speculation
                                                  #     15.1 %  tma_retiring             (50.15%)
                                                  #     32.9 %  tma_backend_bound
                                                  #     32.9 %  tma_frontend_bound       (50.34%)
        86,758,824      cpu_atom/branches/               #      3.1 K/sec  branch_frequency     (60.26%)
       524,281,539      cpu_core/branches/               #     18.6 K/sec  branch_frequency
             1,458      cpu-migrations                   #     51.7 migrations/sec  migrations_per_second
    28,178,124,975      cpu-clock                        #     28.0 CPUs  CPUs_utilized
       776,037,182      cpu_atom/cpu-cycles/             #      0.6 instructions  insn_per_cycle  (60.18%)
     1,679,168,140      cpu_core/cpu-cycles/             #      1.8 instructions  insn_per_cycle
         4,045,615      cpu_atom/branches-misses/        #      5.3 %  branch_miss_rate         (49.65%)
         6,656,795      cpu_core/branches-misses/        #      1.3 %  branch_miss_rate

       1.007340329 seconds time elapsed

```
After:
```
$ perf stat -a sleep 1

 Performance counter stats for 'system wide':

            25,701      context-switches                 #    911.8 cs/sec  cs_per_second
    28,187,404,943      cpu-clock                        #     28.0 CPUs  CPUs_utilized
             2,053      cpu-migrations                   #     72.8 migrations/sec  migrations_per_second
            12,390      page-faults                      #    439.6 faults/sec  page_faults_per_second
       592,082,798      cpu_core/branches/               #     21.0 K/sec  branch_frequency
         7,762,204      cpu_core/branches-misses/        #      1.3 %  branch_miss_rate
     1,925,833,804      cpu_core/cpu-cycles/             #      0.1 GHz  cycles_frequency
     1,925,848,650      cpu_core/cpu-cycles/             #      1.7 instructions  insn_per_cycle
        95,449,119      cpu_atom/branches/               #      3.4 K/sec  branch_frequency     (59.78%)
         4,278,932      cpu_atom/branches-misses/        #      4.3 %  branch_miss_rate         (50.26%)
       980,441,753      cpu_atom/cpu-cycles/             #      0.0 GHz  cycles_frequency       (50.34%)
     1,091,626,599      cpu_atom/cpu-cycles/             #      0.6 instructions  insn_per_cycle  (50.37%)
             TopdownL1 (cpu_core)                 #      9.1 %  tma_bad_speculation
                                                  #     27.3 %  tma_frontend_bound
                                                  #     35.7 %  tma_backend_bound
                                                  #     27.9 %  tma_retiring
             TopdownL1 (cpu_atom)                 #     31.1 %  tma_backend_bound
                                                  #     34.3 %  tma_frontend_bound       (49.74%)
                                                  #     24.1 %  tma_bad_speculation
                                                  #     10.5 %  tma_retiring             (59.57%)
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c00d84a04593..4d15eabb4927 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -74,6 +74,7 @@
 #include "util/intel-tpebs.h"
 #include "asm/bug.h"
 
+#include <linux/list_sort.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 #include <api/fs/fs.h>
@@ -1853,6 +1854,35 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	return 0;
 }
 
+static int default_evlist_evsel_cmp(void *priv __maybe_unused,
+				    const struct list_head *l,
+				    const struct list_head *r)
+{
+	const struct perf_evsel *lhs_core = container_of(l, struct perf_evsel, node);
+	const struct evsel *lhs = container_of(lhs_core, struct evsel, core);
+	const struct perf_evsel *rhs_core = container_of(r, struct perf_evsel, node);
+	const struct evsel *rhs = container_of(rhs_core, struct evsel, core);
+
+	if (evsel__leader(lhs) == evsel__leader(rhs)) {
+		/* Within the same group, respect the original order. */
+		return lhs_core->idx - rhs_core->idx;
+	}
+
+	/* Sort default metrics evsels first, and default show events before those. */
+	if (lhs->default_metricgroup != rhs->default_metricgroup)
+		return lhs->default_metricgroup ? -1 : 1;
+
+	if (lhs->default_show_events != rhs->default_show_events)
+		return lhs->default_show_events ? -1 : 1;
+
+	/* Sort by PMU type (prefers legacy types first). */
+	if (lhs->pmu != rhs->pmu)
+		return lhs->pmu->type - rhs->pmu->type;
+
+	/* Sort by name. */
+	return strcmp(evsel__name((struct evsel *)lhs), evsel__name((struct evsel *)rhs));
+}
+
 /*
  * Add default events, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -2019,6 +2049,8 @@ static int add_default_events(void)
 							&metric_evlist->metric_events);
 			evlist__delete(metric_evlist);
 		}
+		list_sort(/*priv=*/NULL, &evlist->core.entries, default_evlist_evsel_cmp);
+
 	}
 out:
 	if (!ret) {
-- 
2.51.1.821.gb6fe4d2222-goog


