Return-Path: <linux-kernel+bounces-737515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E5EB0AD8A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D39D4E8582
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CBC21D59B;
	Sat, 19 Jul 2025 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06DuwR5X"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288621CA13
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894340; cv=none; b=Yok/W7fu1gxfNkaDbI2nJHP7Lx3PbBs3SxWzG5kezVXuq6BjXlGkHgyP/nHwwy6yy1XR0ffQf+fXeEjQeD2wT9QJwk5VqZcUNRYdzcgahTgwdu8bEpTHrrX/SN/ALatYVllB+/F/Jh6RWApZwhsvGR63t6FonLwnAmlH247MEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894340; c=relaxed/simple;
	bh=3iqPS74Vm3U8TVu2LqxzGlONC7F3fEEx0C3HxO9oOX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kQX/LxOOyzu6qxQR8uehC6ux+CySsBuahIWTFm5ct+boPNs0fiRSt0y1Ppn5CCaDaLSAskRHAeP1jgXCo33xk0IIWqACqMi7tvbISN5gmPId7Bg+8iB98AlDPyV7SkOFi1Kz0y8djsrFp4oF4IG5/gYbRHl23sa41OKBMvdOUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=06DuwR5X; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-301ede1998aso851478fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894338; x=1753499138; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDJzHa5Jjh3EgodtOKHDgfY+ccZxVF0sXpFhOe3DuRk=;
        b=06DuwR5XH1SBSbVSYiDmmqGlh1MJODmI/qpFmHuYV68fisCSLyCLHgwQ4g5w3dTxZ6
         cBoBvTY7S+EhEcpwS2/memz69kCMNiaHfj4giRVRMt6GAl06EX+gZxnfeSPFUILNWfBw
         2HXZV4lbRb/PhiKVsq+/TbNq7kGbFMqR+orxlGw6M/Ng9EZIniGfWbfE8K+gzJTOF3R0
         Urt8fEYe+Zb3u9KHEaDQmSikcVUMxAFJOCBT9BKXQEejAjyMudyVXnpS+2kmY2KfsDFh
         JgLvsGIYfZZJNLoEZz4vgBmN894wRvyCN5xSSdgrePyOUUWcUiMOoqpPnvBch5eHqpkI
         1QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894338; x=1753499138;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDJzHa5Jjh3EgodtOKHDgfY+ccZxVF0sXpFhOe3DuRk=;
        b=vnGDWl8tPLwyhwcwdNArMQIXQ79fkrXujTqIeqjIKzdqrviw1d7YBBajkmKNLsLyHm
         hemmYOQxX952scU4bhe1tSmElVQgVEudnqVHb8Ulbxmx26LcEROTeV40kvw3icpTZQRj
         puO9sDkd2B/Kkq1fB72yPSLU7CGgTaejnZVIkrgu1iaE/ND/kqxx60jBfiPys4oPPd3O
         ZjbwYtqGBzSs62sgrZXQS1yIh/8/8TJdnMnjxAxxNUVjfjZGn7aHR7xzStzpHKqCrEIk
         6rGAeIMvlT5TI4SV1ZG47g2YU2lJNkd9YG6f8SCGn6M9G4SiFiCb/x5qs4K1aGQ3jp66
         cffw==
X-Forwarded-Encrypted: i=1; AJvYcCUt3om1xvSft5mIf8muZJuu9b1PVes4X35i/AIRt6BdMhR3pTyyQYWHctqUKhcIRKjCW/jqXh9zMqygI4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKWT81R8vTWEAPeORQ2SqY0O7f1G9oEQTSmJLAkkCz9cOZIBxn
	TGooCeO7jZbhcRjW9TrFffgc3JvJoGWPPnUCY/KNRzNpoo0tM6YXgYoLGGk8+wZQkxZ2dNTdfVb
	hVczEGrlo8A==
X-Google-Smtp-Source: AGHT+IHtAUqaMjqyTAyw5V9bMWgfhc/EuGmlDpdtDKfXE6b2gJq6gjfWRWQouDvDJvNd/3krYdZnxhu9NN3z
X-Received: from oabsa2.prod.google.com ([2002:a05:6871:2102:b0:2bc:65b9:2ace])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:7244:b0:2ff:9224:b1c8
 with SMTP id 586e51a60fabf-2ffaf5a4bc4mr10499853fac.36.1752894338080; Fri, 18
 Jul 2025 20:05:38 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:06 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-5-irogers@google.com>
Subject: [PATCH v3 04/15] perf parse-events: Allow the cpu term to be a PMU or
 CPU range
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On hybrid systems, events like msr/tsc/ will aggregate counts across
all CPUs. Often metrics only want a value like msr/tsc/ for the cores
on which the metric is being computed. Listing each CPU with terms
cpu=0,cpu=1.. is laborious and would need to be encoded for all
variations of a CPU model.

Allow the cpumask from a PMU to be an argument to the cpu term. For
example in the following the cpumask of the cstate_pkg PMU selects the
CPUs to count msr/tsc/ counter upon:
```
$ cat /sys/bus/event_source/devices/cstate_pkg/cpumask
0
$ perf stat -A -e 'msr/tsc,cpu=cstate_pkg/' -a sleep 0.1

 Performance counter stats for 'system wide':

CPU0          252,621,253      msr/tsc,cpu=cstate_pkg/

       0.101184092 seconds time elapsed
```

As the cpu term is now also allowed to be a string, allow it to encode
a range of CPUs (a list can't be supported as ',' is already a special
token).

The "event qualifiers" section of the `perf list` man page is updated
to detail the additional behavior.  The man page formatting is tidied
up in this section, as it was incorrectly appearing within the
"parameterized events" section.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 25 +++++++++-----
 tools/perf/util/parse-events.c         | 47 +++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index ce0735021473..28215306a78a 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -278,26 +278,33 @@ also be supplied. For example:
 
   perf stat -C 0 -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/' ...
 
-EVENT QUALIFIERS:
+EVENT QUALIFIERS
+----------------
 
 It is also possible to add extra qualifiers to an event:
 
 percore:
 
-Sums up the event counts for all hardware threads in a core, e.g.:
-
-
-  perf stat -e cpu/event=0,umask=0x3,percore=1/
+  Sums up the event counts for all hardware threads in a core, e.g.:
+    perf stat -e cpu/event=0,umask=0x3,percore=1/
 
 cpu:
 
-Specifies the CPU to open the event upon. The value may be repeated to
-specify opening the event on multiple CPUs:
+  Specifies a CPU or a range of CPUs to open the event upon. It may
+  also reference a PMU to copy the CPU mask from. The value may be
+  repeated to specify opening the event on multiple CPUs.
 
+  Example 1: to open the instructions event on CPUs 0 and 2, the
+  cycles event on CPUs 1 and 2:
+    perf stat -e instructions/cpu=0,cpu=2/,cycles/cpu=1-2/ -a sleep 1
 
-  perf stat -e instructions/cpu=0,cpu=2/,cycles/cpu=1,cpu=2/ -a sleep 1
-  perf stat -e data_read/cpu=0/,data_write/cpu=1/ -a sleep 1
+  Example 2: to open the data_read uncore event on CPU 0 and the
+  data_write uncore event on CPU 1:
+    perf stat -e data_read/cpu=0/,data_write/cpu=1/ -a sleep 1
 
+  Example 3: to open the software msr/tsc/ event only on the CPUs
+  matching those from the cpu_core PMU:
+    perf stat -e msr/tsc,cpu=cpu_core/ -a sleep 1
 
 EVENT GROUPS
 ------------
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3fd6cc0c2794..a337e4d22ff2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -187,10 +187,22 @@ static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms *head
 
 	list_for_each_entry(term, &head_terms->terms, list) {
 		if (term->type_term == PARSE_EVENTS__TERM_TYPE_CPU) {
-			struct perf_cpu_map *cpu = perf_cpu_map__new_int(term->val.num);
-
-			perf_cpu_map__merge(&cpus, cpu);
-			perf_cpu_map__put(cpu);
+			struct perf_cpu_map *term_cpus;
+
+			if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
+				term_cpus = perf_cpu_map__new_int(term->val.num);
+			} else {
+				struct perf_pmu *pmu = perf_pmus__find(term->val.str);
+
+				if (pmu && perf_cpu_map__is_empty(pmu->cpus))
+					term_cpus = pmu->is_core ? cpu_map__online() : NULL;
+				else if (pmu)
+					term_cpus = perf_cpu_map__get(pmu->cpus);
+				else
+					term_cpus = perf_cpu_map__new(term->val.str);
+			}
+			perf_cpu_map__merge(&cpus, term_cpus);
+			perf_cpu_map__put(term_cpus);
 		}
 	}
 
@@ -1048,15 +1060,32 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
-	case PARSE_EVENTS__TERM_TYPE_CPU:
-		CHECK_TYPE_VAL(NUM);
-		if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
+	case PARSE_EVENTS__TERM_TYPE_CPU: {
+		struct perf_cpu_map *map;
+
+		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
+			if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
+				parse_events_error__handle(err, term->err_val,
+							strdup("too big"),
+							/*help=*/NULL);
+				return -EINVAL;
+			}
+			break;
+		}
+		assert(term->type_val == PARSE_EVENTS__TERM_TYPE_STR);
+		if (perf_pmus__find(term->val.str) != NULL)
+			break;
+
+		map = perf_cpu_map__new(term->val.str);
+		if (!map) {
 			parse_events_error__handle(err, term->err_val,
-						strdup("too big"),
-						NULL);
+						   strdup("not a valid PMU or CPU number"),
+						   /*help=*/NULL);
 			return -EINVAL;
 		}
+		perf_cpu_map__put(map);
 		break;
+	}
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
-- 
2.50.0.727.gbf7dc18ff4-goog


