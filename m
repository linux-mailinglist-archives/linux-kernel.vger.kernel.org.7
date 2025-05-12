Return-Path: <linux-kernel+bounces-644842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A138AB4525
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D589B4A2EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 19:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC2242D6E;
	Mon, 12 May 2025 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPRXq5oX"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B3F298CDF
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747079196; cv=none; b=ALlFr0gWlDjCDUpVuyu57s6aSYt93iO4WENI1puHet/WljaVapkXVQAIOJryhmRn8wAKB2UGlShjfEM+2HQI8jhBn5Hm+MTx1VwY0bhwWjnzSwFgAiiLTslgre/1iCDlzmFXnvdfSxqXXdU/o0ar1zhQCI+gj5hYj1chsjaq9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747079196; c=relaxed/simple;
	bh=YTXjbo2l8ailvad8rbtlbmKkSPBNAlBjwdL9nEGBE6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NAkBKDsEZJ4ylQR/aT/baegpj3WSpoDb5ZIS5mggvRJDvB9LvukssSoM7Gbl20sawu9RLL4UCKp5lU7/0gOzvDDiu+QO8GIaYfU4FIfdEZqe5vz1KH0BwBh5vrJrsDLtLrsIvOWNq3lnt1J460RIWKaGUtc9x91WTBVK1b9/1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPRXq5oX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742512d307bso2878566b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 12:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747079193; x=1747683993; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4GgSiYcBGsJRco3Bv45eQpmd5dOH26B40zV/W7mrds=;
        b=sPRXq5oX8utnzgwMwuCIeoRSZWKcrpuFIL2UayGsb3N5Y9mIECaq1FZKVTOTE8rPG9
         VIuT5IKt7EeAH1mbngmeCh1Md4c75JUZVPx8h7JwNbmg1cTv1vgeUEW+ga4uy6E1+1Rj
         Yfmw+ir781z2OXDsOTMNj+/e7+0WFDf1Ao06kYdo9lJEtckAvSUD5wF1G9Us9Q0FE7v2
         gmxFVnoH1DbHwrm1SAAwJfs02mMOT1lz5RS2UEXQGr2VZWkBUbjKnvP89W0Hw1DEbDmG
         AFh0KTWzGoqJPCQe5EWrYjjNE3K/T/Ism3pKqkEhi8t586ERGMjcl+86N3aJJM+8VrBP
         lsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747079193; x=1747683993;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4GgSiYcBGsJRco3Bv45eQpmd5dOH26B40zV/W7mrds=;
        b=Zm495ZST1UaLnm4svE4WXigrz9wTw0yp+na8SDGGuU5w2lR1JPZqn/kjGUS6LfW0/A
         VtGYeRlk1qpoFuoTGDRtGCWWBQyagzFUj+v0rAx4YDWEMqkuMUlymwZFqQVmN03i9Fhd
         jUB9TI7Zyc47IUQLwgYoNuxCjw+RIlGUXsH0WObz/CDcjRogMDNZRmcsyPfocyUgE/t5
         hIlC12el36xnvOZkR/9dUF6/4OUlsw3RXQgNjrUVI6YrvkjD9PqoOgEUk0DnuKQs2kyA
         mMB66CQzu9/bX4pqGvHLa8VUN5paMGkzRxn4T+SsLnzASreL/fRoLS+infMSB9JYSVS4
         n8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW3LwgErIy8Wdbb/ziHh4o7mrPWjaMIZ5crSK4vl+XO3AVUhOepaA/rDkvTyMQKFlv4vklbmZsabAgUoOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzniNXeu1BzppvEXEVgzSvZWtYAFSzdcaDNSeP620yj5aSBf21Q
	/W1Q1ZTeHIt9egn7F/zPK8cBQfZMeh3vuvQPEa+KeuLlQPMyNdXvnZmC3NnxBynUmsePEHy1z0a
	oqEwMqA==
X-Google-Smtp-Source: AGHT+IF7Cxz7AaDPPAUUIrREgDGAPeqQtLqphReGJwyQV9WsF3Fhys3bJS8QzmUdbTA44gbLMuaj5my/69zn
X-Received: from pfbhm16.prod.google.com ([2002:a05:6a00:6710:b0:740:b0f1:1ede])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9286:b0:736:3d7c:236c
 with SMTP id d2e1a72fcca58-7423be7d6d0mr18962036b3a.14.1747079193120; Mon, 12
 May 2025 12:46:33 -0700 (PDT)
Date: Mon, 12 May 2025 12:46:21 -0700
In-Reply-To: <20250512194622.33258-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512194622.33258-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512194622.33258-3-irogers@google.com>
Subject: [PATCH v2 2/3] perf pmu: Change aliases from list to hashmap
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding an alias for things like perf_pmu__have_event would need to
search the aliases list, whilst this happens relatively infrequently
it can be a significant overhead in testing. Switch to using a
hashmap. Move common initialization code to perf_pmu__init. Refactor
the test strct perf_pmu_test_pmu to not have perf pmu within it to
better support the perf_pmu__init function.

Before:
```
$ time perf test "Parsing of PMU event table metrics"
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

real    0m13.287s
user    0m13.026s
sys     0m0.532s
```

After:
```
$ time perf test "Parsing of PMU event table metrics"
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

real    0m13.011s
user    0m12.885s
sys     0m0.485s
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 129 +++++++++++++-------------
 tools/perf/util/hwmon_pmu.c   |  43 ++++-----
 tools/perf/util/pmu.c         | 167 ++++++++++++++++++++++------------
 tools/perf/util/pmu.h         |   4 +-
 tools/perf/util/tool_pmu.c    |  17 +---
 5 files changed, 199 insertions(+), 161 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index db004d26fcb0..815b40097428 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -38,7 +38,9 @@ struct perf_pmu_test_event {
 };
 
 struct perf_pmu_test_pmu {
-	struct perf_pmu pmu;
+	const char *pmu_name;
+	bool pmu_is_uncore;
+	const char *pmu_id;
 	struct perf_pmu_test_event const *aliases[10];
 };
 
@@ -553,11 +555,10 @@ static int __test_core_pmu_event_aliases(const char *pmu_name, int *count)
 	if (!pmu)
 		return -1;
 
-	INIT_LIST_HEAD(&pmu->format);
-	INIT_LIST_HEAD(&pmu->aliases);
-	INIT_LIST_HEAD(&pmu->caps);
-	INIT_LIST_HEAD(&pmu->list);
-	pmu->name = strdup(pmu_name);
+	if (perf_pmu__init(pmu, PERF_PMU_TYPE_FAKE, pmu_name) != 0) {
+		perf_pmu__delete(pmu);
+		return -1;
+	}
 	pmu->is_core = true;
 
 	pmu->events_table = table;
@@ -594,14 +595,30 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 {
 	int alias_count = 0, to_match_count = 0, matched_count = 0;
 	struct perf_pmu_test_event const **table;
-	struct perf_pmu *pmu = &test_pmu->pmu;
-	const char *pmu_name = pmu->name;
+	struct perf_pmu *pmu;
 	const struct pmu_events_table *events_table;
 	int res = 0;
 
 	events_table = find_core_events_table("testarch", "testcpu");
 	if (!events_table)
 		return -1;
+
+	pmu = zalloc(sizeof(*pmu));
+	if (!pmu)
+		return -1;
+
+	if (perf_pmu__init(pmu, PERF_PMU_TYPE_FAKE, test_pmu->pmu_name) != 0) {
+		perf_pmu__delete(pmu);
+		return -1;
+	}
+	pmu->is_uncore = test_pmu->pmu_is_uncore;
+	if (test_pmu->pmu_id) {
+		pmu->id = strdup(test_pmu->pmu_id);
+		if (!pmu->id) {
+			perf_pmu__delete(pmu);
+			return -1;
+		}
+	}
 	pmu->events_table = events_table;
 	pmu_add_cpu_aliases_table(pmu, events_table);
 	pmu->cpu_aliases_added = true;
@@ -617,7 +634,8 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 
 	if (alias_count != to_match_count) {
 		pr_debug("testing aliases uncore PMU %s: mismatch expected aliases (%d) vs found (%d)\n",
-			 pmu_name, to_match_count, alias_count);
+			 pmu->name, to_match_count, alias_count);
+		perf_pmu__delete(pmu);
 		return -1;
 	}
 
@@ -630,9 +648,10 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 			.count = &matched_count,
 		};
 
-		if (strcmp(pmu_name, test_event.matching_pmu)) {
+		if (strcmp(pmu->name, test_event.matching_pmu)) {
 			pr_debug("testing aliases uncore PMU %s: mismatched matching_pmu, %s vs %s\n",
-					pmu_name, test_event.matching_pmu, pmu_name);
+					pmu->name, test_event.matching_pmu, pmu->name);
+			perf_pmu__delete(pmu);
 			return -1;
 		}
 
@@ -641,34 +660,32 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 		if (err) {
 			res = err;
 			pr_debug("testing aliases uncore PMU %s: could not match alias %s\n",
-				 pmu_name, event->name);
+				 pmu->name, event->name);
+			perf_pmu__delete(pmu);
 			return -1;
 		}
 	}
 
 	if (alias_count != matched_count) {
 		pr_debug("testing aliases uncore PMU %s: mismatch found aliases (%d) vs matched (%d)\n",
-			 pmu_name, matched_count, alias_count);
+			 pmu->name, matched_count, alias_count);
 		res = -1;
 	}
+	perf_pmu__delete(pmu);
 	return res;
 }
 
 static struct perf_pmu_test_pmu test_pmus[] = {
 	{
-		.pmu = {
-			.name = "hisi_sccl1_ddrc2",
-			.is_uncore = 1,
-		},
+		.pmu_name = "hisi_sccl1_ddrc2",
+		.pmu_is_uncore = 1,
 		.aliases = {
 			&uncore_hisi_ddrc_flux_wcmd,
 		},
 	},
 	{
-		.pmu = {
-			.name = "uncore_cbox_0",
-			.is_uncore = 1,
-		},
+		.pmu_name = "uncore_cbox_0",
+		.pmu_is_uncore = 1,
 		.aliases = {
 			&unc_cbo_xsnp_response_miss_eviction,
 			&uncore_hyphen,
@@ -676,88 +693,70 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 		},
 	},
 	{
-		.pmu = {
-			.name = "hisi_sccl3_l3c7",
-			.is_uncore = 1,
-		},
+		.pmu_name = "hisi_sccl3_l3c7",
+		.pmu_is_uncore = 1,
 		.aliases = {
 			&uncore_hisi_l3c_rd_hit_cpipe,
 		},
 	},
 	{
-		.pmu = {
-			.name = "uncore_imc_free_running_0",
-			.is_uncore = 1,
-		},
+		.pmu_name = "uncore_imc_free_running_0",
+		.pmu_is_uncore = 1,
 		.aliases = {
 			&uncore_imc_free_running_cache_miss,
 		},
 	},
 	{
-		.pmu = {
-			.name = "uncore_imc_0",
-			.is_uncore = 1,
-		},
+		.pmu_name = "uncore_imc_0",
+		.pmu_is_uncore = 1,
 		.aliases = {
 			&uncore_imc_cache_hits,
 		},
 	},
 	{
-		.pmu = {
-			.name = "uncore_sys_ddr_pmu0",
-			.is_uncore = 1,
-			.id = "v8",
-		},
+		.pmu_name = "uncore_sys_ddr_pmu0",
+		.pmu_is_uncore = 1,
+		.pmu_id = "v8",
 		.aliases = {
 			&sys_ddr_pmu_write_cycles,
 		},
 	},
 	{
-		.pmu = {
-			.name = "uncore_sys_ccn_pmu4",
-			.is_uncore = 1,
-			.id = "0x01",
-		},
+		.pmu_name = "uncore_sys_ccn_pmu4",
+		.pmu_is_uncore = 1,
+		.pmu_id = "0x01",
 		.aliases = {
 			&sys_ccn_pmu_read_cycles,
 		},
 	},
 	{
-		.pmu = {
-			.name = (char *)"uncore_sys_cmn_pmu0",
-			.is_uncore = 1,
-			.id = (char *)"43401",
-		},
+		.pmu_name = "uncore_sys_cmn_pmu0",
+		.pmu_is_uncore = 1,
+		.pmu_id = "43401",
 		.aliases = {
 			&sys_cmn_pmu_hnf_cache_miss,
 		},
 	},
 	{
-		.pmu = {
-			.name = (char *)"uncore_sys_cmn_pmu0",
-			.is_uncore = 1,
-			.id = (char *)"43602",
-		},
+		.pmu_name = "uncore_sys_cmn_pmu0",
+		.pmu_is_uncore = 1,
+		.pmu_id = "43602",
 		.aliases = {
 			&sys_cmn_pmu_hnf_cache_miss,
 		},
 	},
 	{
-		.pmu = {
-			.name = (char *)"uncore_sys_cmn_pmu0",
-			.is_uncore = 1,
-			.id = (char *)"43c03",
-		},
+		.pmu_name = "uncore_sys_cmn_pmu0",
+		.pmu_is_uncore = 1,
+		.pmu_id = "43c03",
 		.aliases = {
 			&sys_cmn_pmu_hnf_cache_miss,
 		},
 	},
 	{
-		.pmu = {
-			.name = (char *)"uncore_sys_cmn_pmu0",
-			.is_uncore = 1,
-			.id = (char *)"43a01",
-		},
+		.pmu_name = "uncore_sys_cmn_pmu0",
+		.pmu_is_uncore = 1,
+		.pmu_id = "43a01",
 		.aliases = {
 			&sys_cmn_pmu_hnf_cache_miss,
 		},
@@ -796,10 +795,6 @@ static int test__aliases(struct test_suite *test __maybe_unused,
 	for (i = 0; i < ARRAY_SIZE(test_pmus); i++) {
 		int res;
 
-		INIT_LIST_HEAD(&test_pmus[i].pmu.format);
-		INIT_LIST_HEAD(&test_pmus[i].pmu.aliases);
-		INIT_LIST_HEAD(&test_pmus[i].pmu.caps);
-
 		res = __test_uncore_pmu_event_aliases(&test_pmus[i]);
 		if (res)
 			return res;
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 3cce77fc8004..c25e7296f1c1 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -346,42 +346,43 @@ struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir, const cha
 {
 	char buf[32];
 	struct hwmon_pmu *hwm;
+	__u32 type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
+
+	if (type > PERF_PMU_TYPE_HWMON_END) {
+		pr_err("Unable to encode hwmon type from %s in valid PMU type\n", sysfs_name);
+		return NULL;
+	}
+
+	snprintf(buf, sizeof(buf), "hwmon_%s", name);
+	fix_name(buf + 6);
 
 	hwm = zalloc(sizeof(*hwm));
 	if (!hwm)
 		return NULL;
 
-	hwm->hwmon_dir_fd = hwmon_dir;
-	hwm->pmu.type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
-	if (hwm->pmu.type > PERF_PMU_TYPE_HWMON_END) {
-		pr_err("Unable to encode hwmon type from %s in valid PMU type\n", sysfs_name);
-		goto err_out;
+	if (perf_pmu__init(&hwm->pmu, type, buf) != 0) {
+		perf_pmu__delete(&hwm->pmu);
+		return NULL;
 	}
-	snprintf(buf, sizeof(buf), "hwmon_%s", name);
-	fix_name(buf + 6);
-	hwm->pmu.name = strdup(buf);
-	if (!hwm->pmu.name)
-		goto err_out;
+
+	hwm->hwmon_dir_fd = hwmon_dir;
 	hwm->pmu.alias_name = strdup(sysfs_name);
-	if (!hwm->pmu.alias_name)
-		goto err_out;
+	if (!hwm->pmu.alias_name) {
+		perf_pmu__delete(&hwm->pmu);
+		return NULL;
+	}
 	hwm->pmu.cpus = perf_cpu_map__new("0");
-	if (!hwm->pmu.cpus)
-		goto err_out;
+	if (!hwm->pmu.cpus) {
+		perf_pmu__delete(&hwm->pmu);
+		return NULL;
+	}
 	INIT_LIST_HEAD(&hwm->pmu.format);
-	INIT_LIST_HEAD(&hwm->pmu.aliases);
 	INIT_LIST_HEAD(&hwm->pmu.caps);
 	hashmap__init(&hwm->events, hwmon_pmu__event_hashmap_hash,
 		      hwmon_pmu__event_hashmap_equal, /*ctx=*/NULL);
 
 	list_add_tail(&hwm->pmu.list, pmus);
 	return &hwm->pmu;
-err_out:
-	free((char *)hwm->pmu.name);
-	free(hwm->pmu.alias_name);
-	free(hwm);
-	close(hwmon_dir);
-	return NULL;
 }
 
 void hwmon_pmu__exit(struct perf_pmu *pmu)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 798810704f5b..bc1178234d3b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -27,6 +27,7 @@
 #include <util/pmu-flex.h>
 #include "parse-events.h"
 #include "print-events.h"
+#include "hashmap.h"
 #include "header.h"
 #include "string2.h"
 #include "strbuf.h"
@@ -66,8 +67,6 @@ struct perf_pmu_alias {
 	char *topic;
 	/** @terms: Owned list of the original parsed parameters. */
 	struct parse_events_terms terms;
-	/** @list: List element of struct perf_pmu aliases. */
-	struct list_head list;
 	/**
 	 * @pmu_name: The name copied from the json struct pmu_event. This can
 	 * differ from the PMU name as it won't have suffixes.
@@ -418,25 +417,33 @@ static void perf_pmu__parse_snapshot(struct perf_pmu *pmu, struct perf_pmu_alias
 }
 
 /* Delete an alias entry. */
-static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
+static void perf_pmu_free_alias(struct perf_pmu_alias *alias)
 {
-	zfree(&newalias->name);
-	zfree(&newalias->desc);
-	zfree(&newalias->long_desc);
-	zfree(&newalias->topic);
-	zfree(&newalias->pmu_name);
-	parse_events_terms__exit(&newalias->terms);
-	free(newalias);
+	if (!alias)
+		return;
+
+	zfree(&alias->name);
+	zfree(&alias->desc);
+	zfree(&alias->long_desc);
+	zfree(&alias->topic);
+	zfree(&alias->pmu_name);
+	parse_events_terms__exit(&alias->terms);
+	free(alias);
 }
 
 static void perf_pmu__del_aliases(struct perf_pmu *pmu)
 {
-	struct perf_pmu_alias *alias, *tmp;
+	struct hashmap_entry *entry;
+	size_t bkt;
 
-	list_for_each_entry_safe(alias, tmp, &pmu->aliases, list) {
-		list_del(&alias->list);
-		perf_pmu_free_alias(alias);
-	}
+	if (!pmu->aliases)
+		return;
+
+	hashmap__for_each_entry(pmu->aliases, entry, bkt)
+		perf_pmu_free_alias(entry->pvalue);
+
+	hashmap__free(pmu->aliases);
+	pmu->aliases = NULL;
 }
 
 static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
@@ -444,35 +451,37 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 						   bool load)
 {
 	struct perf_pmu_alias *alias;
+	bool has_sysfs_event;
+	char event_file_name[FILENAME_MAX + 8];
 
-	if (load && !pmu->sysfs_aliases_loaded) {
-		bool has_sysfs_event;
-		char event_file_name[FILENAME_MAX + 8];
+	if (hashmap__find(pmu->aliases, name, &alias))
+		return alias;
 
-		/*
-		 * Test if alias/event 'name' exists in the PMU's sysfs/events
-		 * directory. If not skip parsing the sysfs aliases. Sysfs event
-		 * name must be all lower or all upper case.
-		 */
-		scnprintf(event_file_name, sizeof(event_file_name), "events/%s", name);
-		for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
-			event_file_name[i] = tolower(event_file_name[i]);
+	if (!load || pmu->sysfs_aliases_loaded)
+		return NULL;
 
-		has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
-		if (!has_sysfs_event) {
-			for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
-				event_file_name[i] = toupper(event_file_name[i]);
+	/*
+	 * Test if alias/event 'name' exists in the PMU's sysfs/events
+	 * directory. If not skip parsing the sysfs aliases. Sysfs event
+	 * name must be all lower or all upper case.
+	 */
+	scnprintf(event_file_name, sizeof(event_file_name), "events/%s", name);
+	for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
+		event_file_name[i] = tolower(event_file_name[i]);
 
-			has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
-		}
-		if (has_sysfs_event)
-			pmu_aliases_parse(pmu);
+	has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
+	if (!has_sysfs_event) {
+		for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
+			event_file_name[i] = toupper(event_file_name[i]);
 
+		has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
 	}
-	list_for_each_entry(alias, &pmu->aliases, list) {
-		if (!strcasecmp(alias->name, name))
+	if (has_sysfs_event) {
+		pmu_aliases_parse(pmu);
+		if (hashmap__find(pmu->aliases, name, &alias))
 			return alias;
 	}
+
 	return NULL;
 }
 
@@ -555,7 +564,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 				const char *desc, const char *val, FILE *val_fd,
 			        const struct pmu_event *pe, enum event_source src)
 {
-	struct perf_pmu_alias *alias;
+	struct perf_pmu_alias *alias, *old_alias;
 	int ret = 0;
 	const char *long_desc = NULL, *topic = NULL, *unit = NULL, *pmu_name = NULL;
 	bool deprecated = false, perpkg = false;
@@ -648,7 +657,8 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		break;
 
 	}
-	list_add_tail(&alias->list, &pmu->aliases);
+	hashmap__set(pmu->aliases, alias->name, alias, /*old_key=*/ NULL, &old_alias);
+	perf_pmu_free_alias(old_alias);
 	return 0;
 }
 
@@ -1136,43 +1146,77 @@ perf_pmu__arch_init(struct perf_pmu *pmu)
 		pmu->mem_events = perf_mem_events;
 }
 
+/* Variant of str_hash that does tolower on each character. */
+static size_t aliases__hash(long key, void *ctx __maybe_unused)
+{
+	const char *s = (const char *)key;
+	size_t h = 0;
+
+	while (*s) {
+		h = h * 31 + tolower(*s);
+		s++;
+	}
+	return h;
+}
+
+static bool aliases__equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return strcasecmp((const char *)key1, (const char *)key2) == 0;
+}
+
+int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
+{
+	pmu->type = type;
+	INIT_LIST_HEAD(&pmu->format);
+	INIT_LIST_HEAD(&pmu->caps);
+
+	pmu->name = strdup(name);
+	if (!pmu->name)
+		return -ENOMEM;
+
+	pmu->aliases = hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
+	if (!pmu->aliases)
+		return -ENOMEM;
+
+	return 0;
+}
+
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name,
 				  bool eager_load)
 {
 	struct perf_pmu *pmu;
-	__u32 type;
 
 	pmu = zalloc(sizeof(*pmu));
 	if (!pmu)
 		return NULL;
 
-	pmu->name = strdup(name);
-	if (!pmu->name)
-		goto err;
+	if (perf_pmu__init(pmu, PERF_PMU_TYPE_FAKE, name) != 0) {
+		perf_pmu__delete(pmu);
+		return NULL;
+	}
 
 	/*
 	 * Read type early to fail fast if a lookup name isn't a PMU. Ensure
 	 * that type value is successfully assigned (return 1).
 	 */
-	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &type) != 1)
-		goto err;
-
-	INIT_LIST_HEAD(&pmu->format);
-	INIT_LIST_HEAD(&pmu->aliases);
-	INIT_LIST_HEAD(&pmu->caps);
+	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &pmu->type) != 1) {
+		perf_pmu__delete(pmu);
+		return NULL;
+	}
 
 	/*
 	 * The pmu data we store & need consists of the pmu
 	 * type value and format definitions. Load both right
 	 * now.
 	 */
-	if (pmu_format(pmu, dirfd, name, eager_load))
-		goto err;
+	if (pmu_format(pmu, dirfd, name, eager_load)) {
+		perf_pmu__delete(pmu);
+		return NULL;
+	}
 
 	pmu->is_core = is_pmu_core(name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 
-	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(dirfd, name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
@@ -1194,10 +1238,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 		pmu_aliases_parse_eager(pmu, dirfd);
 
 	return pmu;
-err:
-	zfree(&pmu->name);
-	free(pmu);
-	return NULL;
 }
 
 /* Creates the PMU when sysfs scanning fails. */
@@ -1219,7 +1259,7 @@ struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pm
 	pmu->cpus = cpu_map__online();
 
 	INIT_LIST_HEAD(&pmu->format);
-	INIT_LIST_HEAD(&pmu->aliases);
+	pmu->aliases = hashmap__new(aliases__hash, aliases__equal, /*ctx=*/ NULL);
 	INIT_LIST_HEAD(&pmu->caps);
 	list_add_tail(&pmu->list, core_pmus);
 	return pmu;
@@ -1979,13 +2019,14 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 			     void *state, pmu_event_callback cb)
 {
 	char buf[1024];
-	struct perf_pmu_alias *event;
 	struct pmu_event_info info = {
 		.pmu = pmu,
 		.event_type_desc = "Kernel PMU event",
 	};
 	int ret = 0;
 	struct strbuf sb;
+	struct hashmap_entry *entry;
+	size_t bkt;
 
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__for_each_event(pmu, state, cb);
@@ -1993,7 +2034,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	strbuf_init(&sb, /*hint=*/ 0);
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
-	list_for_each_entry(event, &pmu->aliases, list) {
+	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
+		struct perf_pmu_alias *event = entry->pvalue;
 		size_t buf_used, pmu_name_len;
 
 		if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(event->name))
@@ -2461,6 +2503,9 @@ int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename,
 
 void perf_pmu__delete(struct perf_pmu *pmu)
 {
+	if (!pmu)
+		return;
+
 	if (perf_pmu__is_hwmon(pmu))
 		hwmon_pmu__exit(pmu);
 
@@ -2478,14 +2523,16 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 {
-	struct perf_pmu_alias *event;
+	struct hashmap_entry *entry;
+	size_t bkt;
 
 	if (!pmu)
 		return NULL;
 
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
-	list_for_each_entry(event, &pmu->aliases, list) {
+	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
+		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
 
 		int ret = perf_pmu__config(pmu, &attr, &event->terms, /*apply_hardcoded=*/true,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index a1fdd6d50c53..71b8636fd07d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -14,6 +14,7 @@
 #include "mem-events.h"
 
 struct evsel_config_term;
+struct hashmap;
 struct perf_cpu_map;
 struct print_callbacks;
 
@@ -125,7 +126,7 @@ struct perf_pmu {
 	 * event read from <sysfs>/bus/event_source/devices/<name>/events/ or
 	 * from json events in pmu-events.c.
 	 */
-	struct list_head aliases;
+	struct hashmap *aliases;
 	/**
 	 * @events_table: The events table for json events in pmu-events.c.
 	 */
@@ -294,6 +295,7 @@ int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 int perf_pmu__event_source_devices_fd(void);
 int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags);
 
+int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name);
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name,
 				  bool eager_load);
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 727a10e3f990..4630b8cc8e52 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -502,19 +502,12 @@ struct perf_pmu *tool_pmu__new(void)
 	struct perf_pmu *tool = zalloc(sizeof(struct perf_pmu));
 
 	if (!tool)
-		goto out;
-	tool->name = strdup("tool");
-	if (!tool->name) {
-		zfree(&tool);
-		goto out;
-	}
+		return NULL;
 
-	tool->type = PERF_PMU_TYPE_TOOL;
-	INIT_LIST_HEAD(&tool->aliases);
-	INIT_LIST_HEAD(&tool->caps);
-	INIT_LIST_HEAD(&tool->format);
+	if (perf_pmu__init(tool, PERF_PMU_TYPE_TOOL, "tool") != 0) {
+		perf_pmu__delete(tool);
+		return NULL;
+	}
 	tool->events_table = find_core_events_table("common", "common");
-
-out:
 	return tool;
 }
-- 
2.49.0.1045.g170613ef41-goog


