Return-Path: <linux-kernel+bounces-896188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D83C4FD43
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 885A34EB500
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E232C95D;
	Tue, 11 Nov 2025 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0hTwjozp"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FEB326941
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896142; cv=none; b=ME7dMPCqK1y0r1HMYLFirNsQKtyp7uoWiodG1ql5WLooFKTP0MAK4ZPmMNIwdd44uaCzFjz+kMwPWGrlTXHSbtXUlb97hmn+s00YKx/ViemKBbNISO8nEAA9aQgT1e7S3jnFU0wlcTIktPgrAyLIANR2TKyJs0ZcoR2fjmZvM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896142; c=relaxed/simple;
	bh=5gugg7lkraj9TC0kZ6NwAUfMZ08oCZLBOSh79lmJK3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IG5u7YzPcdCjQ+auEeg5J2dwjBP8/yyloIv3wZ0Qca/lny/HDNTXAJFs1hUPn57kirQ4IKnzHaYpBlyC9MgoA6bCcWwBWRupCFygz2IriMdesPS1+jvBF21CQM+zv9A4roR0Zm5m58aj/jj1uSAry8qgkXRT30Iu4n7Ri7l9ulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0hTwjozp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297f587dc2eso1705845ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896140; x=1763500940; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/I124Vpc3AJUGEYy3T6Y6dhWjIbeIJN7sVjw18uSEg=;
        b=0hTwjozpGdxWjbFMV6w+UozK8zYddvSjiO2FOFF5U19V4oSjuGxITOwwSRfr8+Gp2e
         xYfyepruKHpb63PuS8SKy2/F/YQa51K3PCSrc3VGm8eJz4fv8dQLbBNtBDpej9kvpEXX
         rBosqACF8NLPkrB/X2ff//pKIa780XHTTygmQKZdn0ia/UKdjrooJ/uZL77U3gJWoumk
         a9AOY/SCEhQWPq7ACx42qT8/8Pgal+ov/XOyzuNizD6XEbS/Bl1PKZftQAjsTX5J3JCU
         4aRH+gIXM7+RftsbP5L6II344v4rrwdTXEusSt+LGUtJWuE4ivO+cpfVVOb/76o5Zgyz
         ez8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896140; x=1763500940;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/I124Vpc3AJUGEYy3T6Y6dhWjIbeIJN7sVjw18uSEg=;
        b=rQ5PCFZiYHDh+VTPtucVKOhJqHBTlDZMgXltivsqfHw46AQWWxoIAOWGvZjNpgf8ht
         Du3YzmIPfRAFAU+bj88S8+FxzRDAt6cb9VeiS6ec2Xy0qXwRY9Gm0SPx5NylFSMsUhkr
         yfzm/SqSysLIEF/PBmM4LztPLThDgzTSSHshN5/FvdEiC+HYIPyFNHSeYgvjYbwFV+9F
         jTBsyflTDu77ivltgSjD2YOOEadqEu47sf63fYJn2xfcqYzBI6Y7PAgoqBKfwtpyP+HP
         wSPeqCShwEGysNfVJr0Y2rNFGwD95GMnbXwZR67x/C26v95xQxHmMZwgJvnqW+QFS9lM
         yo3w==
X-Forwarded-Encrypted: i=1; AJvYcCXTQcmEi5ub79F7dBHc2q/BO3OMd8qlgAGEcWr6oyXfVQjLhzDgMDIx3bnbzun60YJZAG/ymYcjtj9R2+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7A+CjqSln1sWsw/ZXHzuDgIgZ7chsGX5aF1205dJo/gx7jZC
	s5MGgquM05CDXfOMZO8YuEu8NxfNnEG99bf+lDYj5ukNhbjWNr5q9TF0wI/BUndoeqNHrMdjny+
	vXnG5beSvfA==
X-Google-Smtp-Source: AGHT+IH77PgtCbJqxJY6j7wxvIM1OCk1GNbCoybLq2jRWIiFzzIPoEgt/LwNMf2l6xiRGSL/U3Zi+fPm3mUa
X-Received: from dyek27.prod.google.com ([2002:a05:7300:641b:b0:2a4:4d2a:a9ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:28c:b0:294:f70d:5e33
 with SMTP id d9443c01a7336-2984ed281b2mr9475375ad.12.1762896139956; Tue, 11
 Nov 2025 13:22:19 -0800 (PST)
Date: Tue, 11 Nov 2025 13:21:49 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-2-irogers@google.com>
Subject: [PATCH v4 01/18] perf metricgroup: Add care to picking the evsel for
 displaying a metric
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
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rather than using the first evsel in the matched events, try to find
the least shared non-tool evsel. The aim is to pick the first evsel
that typifies the metric within the list of metrics.

This addresses an issue where Default metric group metrics may lose
their counter value due to how the stat displaying hides counters for
default event/metric output.

For a metricgroup like TopdownL1 on an Intel Alderlake the change is,
before there are 4 events with metrics:
```
$ perf stat -M topdownL1 -a sleep 1

 Performance counter stats for 'system wide':

     7,782,334,296      cpu_core/TOPDOWN.SLOTS/          #     10.4 %  tma_bad_speculation
                                                  #     19.7 %  tma_frontend_bound
     2,668,927,977      cpu_core/topdown-retiring/       #     35.7 %  tma_backend_bound
                                                  #     34.1 %  tma_retiring
       803,623,987      cpu_core/topdown-bad-spec/
       167,514,386      cpu_core/topdown-heavy-ops/
     1,555,265,776      cpu_core/topdown-fe-bound/
     2,792,733,013      cpu_core/topdown-be-bound/
       279,769,310      cpu_atom/TOPDOWN_RETIRING.ALL/   #     12.2 %  tma_retiring
                                                  #     15.1 %  tma_bad_speculation
       457,917,232      cpu_atom/CPU_CLK_UNHALTED.CORE/  #     38.4 %  tma_backend_bound
                                                  #     34.2 %  tma_frontend_bound
       783,519,226      cpu_atom/TOPDOWN_FE_BOUND.ALL/
        10,790,192      cpu_core/INT_MISC.UOP_DROPPING/
       879,845,633      cpu_atom/TOPDOWN_BE_BOUND.ALL/
```

After there are 6 events with metrics:
```
$ perf stat -M topdownL1 -a sleep 1

 Performance counter stats for 'system wide':

     2,377,551,258      cpu_core/TOPDOWN.SLOTS/          #      7.9 %  tma_bad_speculation
                                                  #     36.4 %  tma_frontend_bound
       480,791,142      cpu_core/topdown-retiring/       #     35.5 %  tma_backend_bound
       186,323,991      cpu_core/topdown-bad-spec/
        65,070,590      cpu_core/topdown-heavy-ops/      #     20.1 %  tma_retiring
       871,733,444      cpu_core/topdown-fe-bound/
       848,286,598      cpu_core/topdown-be-bound/
       260,936,456      cpu_atom/TOPDOWN_RETIRING.ALL/   #     12.4 %  tma_retiring
                                                  #     17.6 %  tma_bad_speculation
       419,576,513      cpu_atom/CPU_CLK_UNHALTED.CORE/
       797,132,597      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #     38.0 %  tma_frontend_bound
         3,055,447      cpu_core/INT_MISC.UOP_DROPPING/
       671,014,164      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #     32.0 %  tma_backend_bound
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 48 ++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 48936e517803..76092ee26761 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1323,6 +1323,51 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 	return ret;
 }
 
+/* How many times will a given evsel be used in a set of metrics? */
+static int count_uses(struct list_head *metric_list, struct evsel *evsel)
+{
+	const char *metric_id = evsel__metric_id(evsel);
+	struct metric *m;
+	int uses = 0;
+
+	list_for_each_entry(m, metric_list, nd) {
+		if (hashmap__find(m->pctx->ids, metric_id, NULL))
+			uses++;
+	}
+	return uses;
+}
+
+/*
+ * Select the evsel that stat-display will use to trigger shadow/metric
+ * printing. Pick the least shared non-tool evsel, encouraging metrics to be
+ * with a hardware counter that is specific to them.
+ */
+static struct evsel *pick_display_evsel(struct list_head *metric_list,
+					struct evsel **metric_events)
+{
+	struct evsel *selected = metric_events[0];
+	size_t selected_uses;
+	bool selected_is_tool;
+
+	if (!selected)
+		return NULL;
+
+	selected_uses = count_uses(metric_list, selected);
+	selected_is_tool = evsel__is_tool(selected);
+	for (int i = 1; metric_events[i]; i++) {
+		struct evsel *candidate = metric_events[i];
+		size_t candidate_uses = count_uses(metric_list, candidate);
+
+		if ((selected_is_tool && !evsel__is_tool(candidate)) ||
+		    (candidate_uses < selected_uses)) {
+			selected = candidate;
+			selected_uses = candidate_uses;
+			selected_is_tool = evsel__is_tool(selected);
+		}
+	}
+	return selected;
+}
+
 static int parse_groups(struct evlist *perf_evlist,
 			const char *pmu, const char *str,
 			bool metric_no_group,
@@ -1430,7 +1475,8 @@ static int parse_groups(struct evlist *perf_evlist,
 			goto out;
 		}
 
-		me = metricgroup__lookup(&perf_evlist->metric_events, metric_events[0],
+		me = metricgroup__lookup(&perf_evlist->metric_events,
+					 pick_display_evsel(&metric_list, metric_events),
 					 /*create=*/true);
 
 		expr = malloc(sizeof(struct metric_expr));
-- 
2.51.2.1041.gc1ab5b90ca-goog


