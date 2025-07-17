Return-Path: <linux-kernel+bounces-735982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B23AB0963C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0AE91894E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824125A352;
	Thu, 17 Jul 2025 21:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDpT/0+f"
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3688F253B64
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786182; cv=none; b=t6XNRWiOe/q+9UUdiAWULM346JAnTZXxUdolnmeCA4bS2lfX/yf+Iywg3hsPr9cpuZqYDr4K0q+HVlmdiDYmWF3CGc3ft90HW+CVVwSuvPrlgzLcXlwepkmkC3YPjlPgPkv3CYYt3ZmEzubjQfRe5cSmFkppQQvkFwFOymSn8N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786182; c=relaxed/simple;
	bh=IZ1dP4fsOOPT7GVDaxQeOs0A2G/SQ78gec0XJFeHBGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gZ5kfw8Nfj9rqEoCA48IcDKI+7nV6MCiWetJjO2fCZR7zn8Fo9b1OA2OnW6UJFCuRuoS167m3elRhnlvZUKjEb0j9x6Kc6cfxZwWBDR+XTNS/2spzdKhyHnnYYp3Rf9522YqKr+9WxnUQSG9n+1ylC1J0YEekP/jqH4Y40RE8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDpT/0+f; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fb5f70b93bso23724326d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786179; x=1753390979; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJyT4HLCqXHRxMmnshYz2066eN/wkiwo71q1NVZg9fs=;
        b=WDpT/0+fNkaA7es+A2c1XaGH6sqIi+MryPrgx2qAdi8tq96GQFOrC0J2AUsG9h8EqG
         5YWEBPrkvP0vt4jTWcolGBER/A7BPzbNQXfkxJUSdxGGaBnyV+4A78TjrqNf5Rdl+GPd
         lY0R7p2n2iwtXpykRfVMaClThlT7XSOFLGOR0FRCKIPDNkvmkaC6GUHvQ3WBfWg3Qx0H
         sggBi2x5WUvvI8S+stZmYI2waLdZrCTU3AuzoAohhjVvixJA2yObR2Hn8vUjwEn7VYaw
         V3MI4zYqVo+iRFKi2t9yIZEji9G7m3qBRfnkMfqi7kiI25v5+hcee8k5o9FV86WOC3hm
         VOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786179; x=1753390979;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJyT4HLCqXHRxMmnshYz2066eN/wkiwo71q1NVZg9fs=;
        b=JJ8162iUKSZGq9KOA0QZu9SChZ25AozZWT6fZb3A/OUNtyjExyQmIdzjnLGyYmXPDx
         qL/RvFiU8qkiBPiYtKLHaCQn7VyB5Jyf269pJnntGgRU3JcCt+a2XxVQ9CVJlQmdLigD
         a/IJCbGIfi9SOkicLbOPCA36uLEGYY59fg0exQ2FFh9aWO284ev6CQN1tXPZ98NKRUEH
         FaqIJ5KfdEbA+7O7bUK3bMdsNv2xrJjz0kV6f0vkTGgxNIQRLgAa+C8khbLvrIqZGefW
         SjsZ34NWhdcW5v8mr2xTInnnLFel0ZJvrzjdfR7grrPnyP7fDFIRWKLC8wjxZOQLXj07
         lV3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYNZAXFI/TQGdAQfwfcVKRR7G/5Y5kbFyDWJHoWmPeTiTIfXxrfdPS77TqQeOSFgOzE5KJGMJiXzoy3qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCG5eDMN2AESsn0OG6hArwkkUpQEsR3PlamKwxFFIl8+YKpSwL
	Sp+FfD3lFie0Ite3YstfXptAe/Vkv8sh3FwCokz31ZEzArybQ8sI3GEB9N1C2IyW6T26SB5RrGd
	oIiObpYupOA==
X-Google-Smtp-Source: AGHT+IFvJUdN2LoRlCp7zjevHjV8W0jDJbhWqJ+H1qjSiTAF99L0cjVkdvAxGZJH83D2GJXVolUxKi7VVswZ
X-Received: from pjbst15.prod.google.com ([2002:a17:90b:1fcf:b0:313:221f:6571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f87:b0:311:abba:53d2
 with SMTP id 98e67ed59e1d1-31caf8db642mr6789448a91.17.1752786159527; Thu, 17
 Jul 2025 14:02:39 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:22 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-2-irogers@google.com>
Subject: [PATCH v2 01/12] perf parse-events: Warn if a cpu term is unsupported
 by a CPU
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Factor requested CPU warning out of evlist and into evsel. At the end
of adding an event, perform the warning check. To avoid repeatedly
testing if the cpu_list is empty, add a local variable.

```
$ perf stat -e cpu_atom/cycles,cpu=1/ -a true
WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cpu_atom/cycles/'

 Performance counter stats for 'system wide':

   <not supported>      cpu_atom/cycles/

       0.000781511 seconds time elapsed
```

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c       | 15 +--------------
 tools/perf/util/evsel.c        | 24 ++++++++++++++++++++++++
 tools/perf/util/evsel.h        |  2 ++
 tools/perf/util/parse-events.c | 12 ++++++++----
 4 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 995ad5f654d0..80d8387e6b97 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2549,20 +2549,7 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 		return;
 
 	evlist__for_each_entry(evlist, pos) {
-		struct perf_cpu_map *intersect, *to_test, *online = cpu_map__online();
-		const struct perf_pmu *pmu = evsel__find_pmu(pos);
-
-		to_test = pmu && pmu->is_core ? pmu->cpus : online;
-		intersect = perf_cpu_map__intersect(to_test, user_requested_cpus);
-		if (!perf_cpu_map__equal(intersect, user_requested_cpus)) {
-			char buf[128];
-
-			cpu_map__snprint(to_test, buf, sizeof(buf));
-			pr_warning("WARNING: A requested CPU in '%s' is not supported by PMU '%s' (CPUs %s) for event '%s'\n",
-				cpu_list, pmu ? pmu->name : "cpu", buf, evsel__name(pos));
-		}
-		perf_cpu_map__put(intersect);
-		perf_cpu_map__put(online);
+		evsel__warn_user_requested_cpus(pos, user_requested_cpus);
 	}
 	perf_cpu_map__put(user_requested_cpus);
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3896a04d90af..d9b6bf78d67b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4091,3 +4091,27 @@ void evsel__uniquify_counter(struct evsel *counter)
 		counter->uniquified_name = false;
 	}
 }
+
+void evsel__warn_user_requested_cpus(struct evsel *evsel, struct perf_cpu_map *user_requested_cpus)
+{
+	struct perf_cpu_map *intersect, *online = NULL;
+	const struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+	if (pmu && pmu->is_core) {
+		intersect = perf_cpu_map__intersect(pmu->cpus, user_requested_cpus);
+	} else {
+		online = cpu_map__online();
+		intersect = perf_cpu_map__intersect(online, user_requested_cpus);
+	}
+	if (!perf_cpu_map__equal(intersect, user_requested_cpus)) {
+		char buf1[128];
+		char buf2[128];
+
+		cpu_map__snprint(user_requested_cpus, buf1, sizeof(buf1));
+		cpu_map__snprint(online ?: pmu->cpus, buf2, sizeof(buf2));
+		pr_warning("WARNING: A requested CPU in '%s' is not supported by PMU '%s' (CPUs %s) for event '%s'\n",
+			   buf1, pmu ? pmu->name : "cpu", buf2, evsel__name(evsel));
+	}
+	perf_cpu_map__put(intersect);
+	perf_cpu_map__put(online);
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index b84ee274602d..cefa8e64c0d5 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -574,4 +574,6 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 
 bool evsel__is_offcpu_event(struct evsel *evsel);
 
+void evsel__warn_user_requested_cpus(struct evsel *evsel, struct perf_cpu_map *user_requested_cpus);
+
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a59ae5ca0f89..3fd6cc0c2794 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -252,6 +252,7 @@ __add_event(struct list_head *list, int *idx,
 	struct evsel *evsel;
 	bool is_pmu_core;
 	struct perf_cpu_map *cpus;
+	bool has_cpu_list = !perf_cpu_map__is_empty(cpu_list);
 
 	/*
 	 * Ensure the first_wildcard_match's PMU matches that of the new event
@@ -276,7 +277,7 @@ __add_event(struct list_head *list, int *idx,
 
 	if (pmu) {
 		is_pmu_core = pmu->is_core;
-		cpus = perf_cpu_map__get(perf_cpu_map__is_empty(cpu_list) ? pmu->cpus : cpu_list);
+		cpus = perf_cpu_map__get(has_cpu_list ? cpu_list : pmu->cpus);
 		perf_pmu__warn_invalid_formats(pmu);
 		if (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX) {
 			perf_pmu__warn_invalid_config(pmu, attr->config, name,
@@ -291,10 +292,10 @@ __add_event(struct list_head *list, int *idx,
 	} else {
 		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
 			       attr->type == PERF_TYPE_HW_CACHE);
-		if (perf_cpu_map__is_empty(cpu_list))
-			cpus = is_pmu_core ? perf_cpu_map__new_online_cpus() : NULL;
-		else
+		if (has_cpu_list)
 			cpus = perf_cpu_map__get(cpu_list);
+		else
+			cpus = is_pmu_core ? cpu_map__online() : NULL;
 	}
 	if (init_attr)
 		event_attr_init(attr);
@@ -326,6 +327,9 @@ __add_event(struct list_head *list, int *idx,
 	if (list)
 		list_add_tail(&evsel->core.node, list);
 
+	if (has_cpu_list)
+		evsel__warn_user_requested_cpus(evsel, cpu_list);
+
 	return evsel;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


