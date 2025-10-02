Return-Path: <linux-kernel+bounces-840725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E3FBB5191
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A1C3B01C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B8295DB8;
	Thu,  2 Oct 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdKXoKgQ"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8D28C2CE
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435572; cv=none; b=iFjEQPan1dedfrNLb2RvpSj1VxCtbC3LukE5RJ+xAw3oCRMawc2Owpz0gS526Bl/JIfcNaR02q/0SJhTNjNSyde7KT7F6MWGkJbrnd+fYb3Fm/OFZXnk/nQpmCLa/XOZ6N251G25MVa+vZ/LW7WEDNdRRQ5Q3/CgXMlweWwCURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435572; c=relaxed/simple;
	bh=nt+Gaen2KfUHaSCDHALN10gzNV/aP6n8zhzu6l75Ouc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pbWcVTNi0OzuK62nAVDYCekoVSzagvogpH8Q0ysTHmOFG7B6uO9zNc4DvIrPIOtIoi/+3L/3Znf+Qld/igEJQ+nDXNZeN3jk0TAJOOMfQS8d/WDKekMNUTYjaYAu2FCGGGyJEo+J9bK72gAWK6oDnuYblqp2ZEO6K6dH6HPVvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SdKXoKgQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26e4fcc744dso9152715ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759435570; x=1760040370; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3IdXujNTMNScto7HcvCbQENd4w+9Z61bkPPvlgDQoc=;
        b=SdKXoKgQTA6IuM/mbIdnjD7UbVUQMOWAW6yVH3n0DbiVJ+Qxr3OocyZPWUKC2EK8/0
         l+v2E4+Kikm39hGYEe2dEHkntsnuOgm0Uwz/r9FwX7dM8k6Xr1Wlk7DsHdkOKrcP6RH3
         Ilplf3oaY9brocqTuptVyHJOqpE947Unhk4sxxo1ElQPO8ryZPZgPli0KPN4FS7eNFYi
         y9p7EUTlmEqqI2z14TysH9E4OA8oACgEjMLU+EDgSOzYLitcs9OdUaH2zs1wjeUWECkF
         0mDN1usYH5tZQQllPtDBNvx2VdT80TK/1vkDm7t5y/cMVLxfO5nt6CCSg0xIaq/LmBY8
         zFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435570; x=1760040370;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3IdXujNTMNScto7HcvCbQENd4w+9Z61bkPPvlgDQoc=;
        b=reNPXQCr/NVBq2cgrgJ5Kz9hap0T6W+6wVSECRZVkgWMn+QA2Gvkrq9N+BpP3u4umk
         38DrbqjWDL6ojqnmVywp0VNd9c/Jm1YOxxcrooOjzDDXhRhWp45lnrdVtft/6VhTmkf1
         vrL3VWfYVPdWRRcAQkpsOmNQMvm219RMAvV3HIfUTgVCCBaJ0oastRcSyhrHFJJBfBKg
         tOQXM3fnYkhjAzA+CWEBEytbmmcCBmTS8qycoisY1sbux4b8KOLUzf6it87tymbmWUtL
         q1dYcmbU4hxPYKsQumOkpKZY19tFRs6XED85Ori54a5eiAxN2CU6oKdlt+YNKTEAB9VB
         eNog==
X-Forwarded-Encrypted: i=1; AJvYcCVqqqmbmHTCAq3uPSy+ZihdgFnUBdnbXoygffEup5cgKkOcuo1yJmRtDEn1YweeOFKqiVO3TaNHhLNQ1t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNtjtOgOdcRlBy195VSklfGZvfGgDlxImDTQuOC45jfDTnrmP
	5zQt+xuiEJt2Ge0lP5dLfo/1j1fjNLrt/HE30N2QG+TQf2iki+Mk7LoLfAcwenPsL87szzWPNX9
	5d7YtHAC3pA==
X-Google-Smtp-Source: AGHT+IFsJG6wxrd8qmtm0FpwXShdJYB+C0ju12LbT92z/NA4JIDb2DzD3ooKEA6UyAjO5zZxu7PLouTkNp5V
X-Received: from plbjw8.prod.google.com ([2002:a17:903:2788:b0:258:dc43:b015])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:287:b0:26d:d860:3db1
 with SMTP id d9443c01a7336-28e9a56700amr5704885ad.24.1759435569699; Thu, 02
 Oct 2025 13:06:09 -0700 (PDT)
Date: Thu,  2 Oct 2025 13:06:04 -0700
In-Reply-To: <20251002200604.1792141-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251002200604.1792141-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002200604.1792141-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf stat: Refactor retry/skip/fatal error handling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For the sake of Intel topdown events commit 9eac5612da1c ("perf stat:
Don't skip failing group events") changed perf stat error handling
making it so that more errors were fatal and didn't report "<not
supported>" events. The change outside of topdown events was
unintentional.

The notion of "fatal" error handling was introduced in commit
e0e6a6ca3ac2 ("perf stat: Factor out open error handling") and refined
in commits like commit cb5ef60067c1 ("perf stat: Error out unsupported
group leader immediately) to be an approach for avoiding later
assertion failures in the code base. This change fixes those issues
and removes the notion of a fatal error on an event. If all events
fail to open then a fatal error occurs with the previous fatal error
message. This seems to best match the notion of supported events and
allowing some errors not to stop perf stat, while allowing the truly
fatal no event case to terminate the tool early.

The evsel->errored flag is only used in the stat code but always just
meaning !evsel->supported although there is a comment about it being
sticky. Force all evsels to be supported in evsel__init and then clear
this when evsel__open fails. When an event is tried the supported is
set to true again. This simplifies the notion of whether an evsel is
broken.

In the get_group_fd code, fail to get a group fd when the evsel isn't
supported. If the leader isn't supported then it is also expected that
there is no group_fd as the leader will have been skipped. Therefore
change the BUG_ON test to be on supported rather than skippable. This
corrects the assertion errors that were the reason for the previous
fatal error handling.

Fixes: 9eac5612da1c ("perf stat: Don't skip failing group events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
An earlier version of this fix exists in:
https://lore.kernel.org/lkml/20250923223312.238185-2-irogers@google.com/
This version is more thorough and tries to make the overall code base
more consistent.
---
 tools/perf/builtin-record.c |   2 -
 tools/perf/builtin-stat.c   | 121 +++++++++++++++---------------------
 tools/perf/util/evsel.c     |  40 +++++++-----
 tools/perf/util/evsel.h     |   1 -
 4 files changed, 74 insertions(+), 90 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7ea3a11aca70..d76f01956e33 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1408,8 +1408,6 @@ static int record__open(struct record *rec)
 			ui__error("%s\n", msg);
 			goto out;
 		}
-
-		pos->supported = true;
 	}
 
 	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 75b9979c6c05..01834ff8a782 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -610,22 +610,13 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times)
 enum counter_recovery {
 	COUNTER_SKIP,
 	COUNTER_RETRY,
-	COUNTER_FATAL,
 };
 
 static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 {
 	char msg[BUFSIZ];
 
-	if (counter->skippable) {
-		if (verbose > 0) {
-			ui__warning("skipping event %s that kernel failed to open .\n",
-				    evsel__name(counter));
-		}
-		counter->supported = false;
-		counter->errored = true;
-		return COUNTER_SKIP;
-	}
+	assert(!counter->supported);
 
 	/*
 	 * PPC returns ENXIO for HW counters until 2.6.37
@@ -636,19 +627,16 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
 		}
-		counter->supported = false;
-		/*
-		 * errored is a sticky flag that means one of the counter's
-		 * cpu event had a problem and needs to be reexamined.
-		 */
-		counter->errored = true;
-	} else if (evsel__fallback(counter, &target, err, msg, sizeof(msg))) {
+		return COUNTER_SKIP;
+	}
+	if (evsel__fallback(counter, &target, err, msg, sizeof(msg))) {
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
+		counter->supported = true;
 		return COUNTER_RETRY;
-	} else if (target__has_per_thread(&target) && err != EOPNOTSUPP &&
-		   evsel_list->core.threads &&
-		   evsel_list->core.threads->err_thread != -1) {
+	}
+	if (target__has_per_thread(&target) && err != EOPNOTSUPP &&
+	    evsel_list->core.threads && evsel_list->core.threads->err_thread != -1) {
 		/*
 		 * For global --per-thread case, skip current
 		 * error thread.
@@ -656,24 +644,17 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 		if (!thread_map__remove(evsel_list->core.threads,
 					evsel_list->core.threads->err_thread)) {
 			evsel_list->core.threads->err_thread = -1;
+			counter->supported = true;
 			return COUNTER_RETRY;
 		}
-	} else if (err == EOPNOTSUPP) {
-		if (verbose > 0) {
-			ui__warning("%s event is not supported by the kernel.\n",
-				    evsel__name(counter));
-		}
-		counter->supported = false;
-		counter->errored = true;
 	}
-
-	evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
-	ui__error("%s\n", msg);
-
-	if (child_pid != -1)
-		kill(child_pid, SIGTERM);
-
-	return COUNTER_FATAL;
+	if (verbose > 0) {
+		ui__warning(err == EOPNOTSUPP
+			? "%s event is not supported by the kernel.\n"
+			: "skipping event %s that kernel failed to open.\n",
+			evsel__name(counter));
+	}
+	return COUNTER_SKIP;
 }
 
 static int create_perf_stat_counter(struct evsel *evsel,
@@ -746,8 +727,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
 	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity saved_affinity, *affinity = NULL;
-	int err;
-	bool second_pass = false;
+	int err, open_err = 0;
+	bool second_pass = false, has_supported_counters;
 
 	if (forks) {
 		if (evlist__prepare_workload(evsel_list, &target, argv, is_pipe, workload_exec_failed_signal) < 0) {
@@ -787,14 +768,17 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (target.use_bpf)
 			break;
 
-		if (counter->reset_group || counter->errored)
+		if (counter->reset_group || !counter->supported)
 			continue;
 		if (evsel__is_bperf(counter))
 			continue;
-try_again:
-		if (create_perf_stat_counter(counter, &stat_config,
-					     evlist_cpu_itr.cpu_map_idx) < 0) {
 
+		while (true) {
+			if (create_perf_stat_counter(counter, &stat_config,
+						     evlist_cpu_itr.cpu_map_idx) == 0)
+				break;
+
+			open_err = errno;
 			/*
 			 * Weak group failed. We cannot just undo this here
 			 * because earlier CPUs might be in group mode, and the kernel
@@ -802,29 +786,18 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			 * it to later.
 			 * Don't close here because we're in the wrong affinity.
 			 */
-			if ((errno == EINVAL || errno == EBADF) &&
+			if ((open_err == EINVAL || open_err == EBADF) &&
 				evsel__leader(counter) != counter &&
 				counter->weak_group) {
 				evlist__reset_weak_group(evsel_list, counter, false);
 				assert(counter->reset_group);
 				second_pass = true;
-				continue;
-			}
-
-			switch (stat_handle_error(counter, errno)) {
-			case COUNTER_FATAL:
-				err = -1;
-				goto err_out;
-			case COUNTER_RETRY:
-				goto try_again;
-			case COUNTER_SKIP:
-				continue;
-			default:
 				break;
 			}
 
+			if (stat_handle_error(counter, open_err) != COUNTER_RETRY)
+				break;
 		}
-		counter->supported = true;
 	}
 
 	if (second_pass) {
@@ -837,7 +810,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
 			counter = evlist_cpu_itr.evsel;
 
-			if (!counter->reset_group && !counter->errored)
+			if (!counter->reset_group && counter->supported)
 				continue;
 
 			perf_evsel__close_cpu(&counter->core, evlist_cpu_itr.cpu_map_idx);
@@ -848,34 +821,29 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 			if (!counter->reset_group)
 				continue;
-try_again_reset:
-			pr_debug2("reopening weak %s\n", evsel__name(counter));
-			if (create_perf_stat_counter(counter, &stat_config,
-						     evlist_cpu_itr.cpu_map_idx) < 0) {
-
-				switch (stat_handle_error(counter, errno)) {
-				case COUNTER_FATAL:
-					err = -1;
-					goto err_out;
-				case COUNTER_RETRY:
-					goto try_again_reset;
-				case COUNTER_SKIP:
-					continue;
-				default:
+
+			while (true) {
+				pr_debug2("reopening weak %s\n", evsel__name(counter));
+				if (create_perf_stat_counter(counter, &stat_config,
+							     evlist_cpu_itr.cpu_map_idx) == 0)
+					break;
+
+				open_err = errno;
+				if (stat_handle_error(counter, open_err) != COUNTER_RETRY)
 					break;
-				}
 			}
-			counter->supported = true;
 		}
 	}
 	affinity__cleanup(affinity);
 	affinity = NULL;
 
+	has_supported_counters = false;
 	evlist__for_each_entry(evsel_list, counter) {
 		if (!counter->supported) {
 			perf_evsel__free_fd(&counter->core);
 			continue;
 		}
+		has_supported_counters = true;
 
 		l = strlen(counter->unit);
 		if (l > stat_config.unit_width)
@@ -887,6 +855,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			goto err_out;
 		}
 	}
+	if (!has_supported_counters) {
+		evsel__open_strerror(counter, &target, open_err, msg, sizeof(msg));
+		ui__error("No supported events found.\n%s\n", msg);
+
+		if (child_pid != -1)
+			kill(child_pid, SIGTERM);
+		err = -1;
+		goto err_out;
+	}
 
 	if (evlist__apply_filters(evsel_list, &counter, &target)) {
 		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1a29d4f47bbf..fe93f11cf3d1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -407,6 +407,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->collect_stat  = false;
 	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
+	evsel->supported     = true;
 	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
 	evsel->script_output_type = -1; // FIXME: OUTPUT_TYPE_UNSET, see builtin-script.c
 }
@@ -1941,7 +1942,7 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 	struct evsel *leader = evsel__leader(evsel);
 	int fd;
 
-	if (evsel__is_group_leader(evsel))
+	if (!evsel->supported || evsel__is_group_leader(evsel))
 		return -1;
 
 	/*
@@ -1955,7 +1956,7 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 		return -1;
 
 	fd = FD(leader, cpu_map_idx, thread);
-	BUG_ON(fd == -1 && !leader->skippable);
+	BUG_ON(fd == -1 && leader->supported);
 
 	/*
 	 * When the leader has been skipped, return -2 to distinguish from no
@@ -2573,12 +2574,14 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	enum rlimit_action set_rlimit = NO_CHANGE;
 	struct perf_cpu cpu;
 
-	if (evsel__is_retire_lat(evsel))
-		return evsel__tpebs_open(evsel);
+	if (evsel__is_retire_lat(evsel)) {
+		err = evsel__tpebs_open(evsel);
+		goto out;
+	}
 
 	err = __evsel__prepare_open(evsel, cpus, threads);
 	if (err)
-		return err;
+		goto out;
 
 	if (cpus == NULL)
 		cpus = empty_cpu_map;
@@ -2598,19 +2601,22 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	display_attr(&evsel->core.attr);
 
 	if (evsel__is_tool(evsel)) {
-		return evsel__tool_pmu_open(evsel, threads,
-					    start_cpu_map_idx,
-					    end_cpu_map_idx);
+		err = evsel__tool_pmu_open(evsel, threads,
+					   start_cpu_map_idx,
+					   end_cpu_map_idx);
+		goto out;
 	}
 	if (evsel__is_hwmon(evsel)) {
-		return evsel__hwmon_pmu_open(evsel, threads,
-					     start_cpu_map_idx,
-					     end_cpu_map_idx);
+		err = evsel__hwmon_pmu_open(evsel, threads,
+					    start_cpu_map_idx,
+					    end_cpu_map_idx);
+		goto out;
 	}
 	if (evsel__is_drm(evsel)) {
-		return evsel__drm_pmu_open(evsel, threads,
-					   start_cpu_map_idx,
-					   end_cpu_map_idx);
+		err = evsel__drm_pmu_open(evsel, threads,
+					  start_cpu_map_idx,
+					  end_cpu_map_idx);
+		goto out;
 	}
 
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
@@ -2689,7 +2695,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		}
 	}
 
-	return 0;
+	err = 0;
+	goto out;
 
 try_fallback:
 	if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
@@ -2728,6 +2735,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		thread = nthreads;
 	} while (--idx >= 0);
 	errno = old_errno;
+out:
+	if (err)
+		evsel->supported = false;
 	return err;
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 03f9f22e3a0c..1ad0b3fcd559 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -121,7 +121,6 @@ struct evsel {
 	bool			forced_leader;
 	bool			cmdline_group_boundary;
 	bool			reset_group;
-	bool			errored;
 	bool			needs_auxtrace_mmap;
 	bool			default_metricgroup; /* A member of the Default metricgroup */
 	bool			needs_uniquify;
-- 
2.51.0.618.g983fd99d29-goog


