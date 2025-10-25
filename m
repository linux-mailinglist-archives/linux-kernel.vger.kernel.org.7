Return-Path: <linux-kernel+bounces-869978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C62EC092BA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FC21B27E1F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F129C30277D;
	Sat, 25 Oct 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRm4cCB0"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E192E8DF3
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761406364; cv=none; b=c9d6rv8YQeQ7p+Qdan00bahTZHKakJwKbFYZiBCwNa2oaA8oXJGqzCEFtTpP0K1HVRZOhMUGZ/vlCntw9I/4wZys35OELTeQXhx5KKdPTIC1+ro4UEeUkJrrYe/hAOLf9B+FGY/WjSFIiXOD0SAzsQEojAiMejsRc+e8oJqhuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761406364; c=relaxed/simple;
	bh=hWDeiL3W9fWYqMezt71RAU3HPaOUiLMJ4gsoEP1hTnU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=I6ZV9fr3W39wO1P1tAIZxMxo/jFe6Bl0vHty+KwJ9Wvy63jSVt5sdkXqzADnvMDQUDeh08bi1Ri8fhToqzWq4O3/f6x5BV5nlDTvHheCFIU4LuNMSamzUxB2/fKM4mfTbt0IuOuPDWVAYMcKRkNd8gp4n7XgOTqusPTI7SzmLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRm4cCB0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso5675360a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761406362; x=1762011162; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yO2mWFSLhq6NqYN6b4GFq0YvrG3c9t/f/H9KA1+pHEU=;
        b=KRm4cCB0wtstsueCzRDz4TR0/HNalMz4vSiTf36zyk6EEm3/EyBwOcs52l7U4LTVgE
         QOZ9mZZqEtf1oFCUB5+wvfHTgXUB13ks1eG/a4tue6qzF6TK29DlGwr7za74Qj/nsXHn
         k4GvgMKlApdw+blhElfex4NNwMPhEn7FA0rXv4YAAiKWLe3McTf8WQqW1fP2dp8JVnHk
         fjtcsY5DEVIQBlSEO8Jhn3vhFNll+4lGrMLpya4jxnmOSHA8Wr9Et1L4qPIzVeEa3Ceq
         gAfEdJ+m+HZauZqmBz8TrESlCL3YlynweMgg3sIn/3imatJ5tIaJKQmP9fUshIYEjmMc
         v3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761406362; x=1762011162;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yO2mWFSLhq6NqYN6b4GFq0YvrG3c9t/f/H9KA1+pHEU=;
        b=lalJzPJ4tuMpTJNFltFYlnUPCkUidLpt5lypvTM3Z+pg7h31WI3FCTlL0UWUZYaei+
         rA1FVVNQlLd4+rYLm48BpssiOM3GS3LI6soS+qVSBOrw5bZhZ/H9cDYb+BdTPvrzIyBh
         y2/vKlyd1IzvEj+lSYV1Gm1brM6VcdCU4B1iRsIHCDldUH1Onee6VQA9bZiMvfJtBC3E
         caKK/KuGIhNp5a5+rw6aoY+uHNBdPQKmd/cDiwqj/RIaEHPvhyMJso3zTtg/diIxQ1+/
         PCgk5GgtpsRDVYUGpVTIKGWx4pNNbQXtRFUWN/l0JrUIn9I3cTX1sMHi0paUfb050rnt
         OUyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEeUtKKiK1yhMBdbBF/c+J+dalgJsqeHnFRB1LzNB04P2TSPORYm9aFjtRrEtgyvkNmCHfaSA+A4x48kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKEX/MBdUmonInf7FejdXlKBrRb10xJpv6EfeFyyXFiox7XkX
	rM8S0bRIt0TDy2w9Zzah65W6LuaII5F2eEPUhEmfekmCB+b4bw0Pz70wxak2YsO3tL31if8CeJu
	T3UdWUdczNw==
X-Google-Smtp-Source: AGHT+IEMHNT2jZoKx91/ee2Eojn/oUOJwBe81BYnxPFDlFIqEupCxCnYx80mYOFWVk+J/Gqt7zCmjVDg5w32
X-Received: from pjzm22.prod.google.com ([2002:a17:90b:696:b0:339:ee20:f620])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a1:b0:334:a915:f403
 with SMTP id adf61e73a8af0-33dea08a733mr7071510637.2.1761406361815; Sat, 25
 Oct 2025 08:32:41 -0700 (PDT)
Date: Sat, 25 Oct 2025 08:32:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251025153231.1090855-1-irogers@google.com>
Subject: [PATCH v1] perf stat: Add/fix bperf cgroup max events workarounds
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit b8308511f6e0 bumped the max events to 1024 but this results in
BPF verifier issues if the number of command line events is too
large. Workaround this by:

1) moving the constants to a header file to share between BPF and perf
   C code,
2) testing that the maximum number of events doesn't cause BPF
   verifier issues in debug builds,
3) lower the max events from 1024 to 128,
4) in perf stat, if there are more events than the BPF counters can
   support then disable BPF counter usage.

The rodata setup is factored into its own function to avoid
duplicating it in the testing code.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: b8308511f6e0 ("perf stat bperf cgroup: Increase MAX_EVENTS from 32 to 1024")
---
 tools/perf/builtin-stat.c                   | 13 +++-
 tools/perf/util/bpf_counter_cgroup.c        | 79 +++++++++++++++------
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 18 +++--
 3 files changed, 76 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3c3188a57016..130515f87ee0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -96,6 +96,10 @@
 #include <perf/evlist.h>
 #include <internal/threadmap.h>
 
+#ifdef HAVE_BPF_SKEL
+#include "util/bpf_skel/bperf_cgroup.h"
+#endif
+
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"bus/event_source/devices/cpu/freeze_on_smi"
 
@@ -2852,7 +2856,14 @@ int cmd_stat(int argc, const char **argv)
 			goto out;
 		}
 	}
-
+#ifdef HAVE_BPF_SKEL
+	if (target.use_bpf &&
+	    (evsel_list->core.nr_entries / nr_cgroups) > BPERF_CGROUP__MAX_EVENTS) {
+		pr_warning("Disabling BPF counters due to more events (%d) than the max (%d)\n",
+			   evsel_list->core.nr_entries / nr_cgroups, BPERF_CGROUP__MAX_EVENTS);
+		target.use_bpf = false;
+	}
+#endif // HAVE_BPF_SKEL
 	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
 
 	evlist__for_each_entry(evsel_list, counter) {
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 690be3ce3e11..68bd994c8880 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -27,6 +27,7 @@
 #include "cpumap.h"
 #include "thread_map.h"
 
+#include "bpf_skel/bperf_cgroup.h"
 #include "bpf_skel/bperf_cgroup.skel.h"
 
 static struct perf_event_attr cgrp_switch_attr = {
@@ -42,6 +43,55 @@ static struct bperf_cgroup_bpf *skel;
 
 #define FD(evt, cpu) (*(int *)xyarray__entry(evt->core.fd, cpu, 0))
 
+static void setup_rodata(struct bperf_cgroup_bpf *sk, int evlist_size)
+{
+	int map_size, total_cpus = cpu__max_cpu().cpu;
+
+	sk->rodata->num_cpus = total_cpus;
+	sk->rodata->num_events = evlist_size / nr_cgroups;
+
+	if (cgroup_is_v2("perf_event") > 0)
+		sk->rodata->use_cgroup_v2 = 1;
+
+	BUG_ON(evlist_size % nr_cgroups != 0);
+
+	/* we need one copy of events per cpu for reading */
+	map_size = total_cpus * evlist_size / nr_cgroups;
+	bpf_map__set_max_entries(sk->maps.events, map_size);
+	bpf_map__set_max_entries(sk->maps.cgrp_idx, nr_cgroups);
+	/* previous result is saved in a per-cpu array */
+	map_size = evlist_size / nr_cgroups;
+	bpf_map__set_max_entries(sk->maps.prev_readings, map_size);
+	/* cgroup result needs all events (per-cpu) */
+	map_size = evlist_size;
+	bpf_map__set_max_entries(sk->maps.cgrp_readings, map_size);
+}
+
+static void test_max_events_program_load(void)
+{
+#ifndef NDEBUG
+	/*
+	 * Test that the program verifies with the maximum number of events. If
+	 * this test fails unfortunately perf needs recompiling with a lower
+	 * BPERF_CGROUP__MAX_EVENTS to avoid BPF verifier issues.
+	 */
+	int err, max_events = BPERF_CGROUP__MAX_EVENTS * nr_cgroups;
+	struct bperf_cgroup_bpf *test_skel = bperf_cgroup_bpf__open();
+
+	if (!test_skel) {
+		pr_err("Failed to open cgroup skeleton\n");
+		return;
+	}
+	setup_rodata(test_skel, max_events);
+	err = bperf_cgroup_bpf__load(test_skel);
+	if (err) {
+		pr_err("Failed to load cgroup skeleton with max events %d.\n",
+			BPERF_CGROUP__MAX_EVENTS);
+	}
+	bperf_cgroup_bpf__destroy(test_skel);
+#endif
+}
+
 static int bperf_load_program(struct evlist *evlist)
 {
 	struct bpf_link *link;
@@ -50,35 +100,18 @@ static int bperf_load_program(struct evlist *evlist)
 	int i, j;
 	struct perf_cpu cpu;
 	int total_cpus = cpu__max_cpu().cpu;
-	int map_size, map_fd;
-	int prog_fd, err;
+	int map_fd, prog_fd, err;
+
+	set_max_rlimit();
+
+	test_max_events_program_load();
 
 	skel = bperf_cgroup_bpf__open();
 	if (!skel) {
 		pr_err("Failed to open cgroup skeleton\n");
 		return -1;
 	}
-
-	skel->rodata->num_cpus = total_cpus;
-	skel->rodata->num_events = evlist->core.nr_entries / nr_cgroups;
-
-	if (cgroup_is_v2("perf_event") > 0)
-		skel->rodata->use_cgroup_v2 = 1;
-
-	BUG_ON(evlist->core.nr_entries % nr_cgroups != 0);
-
-	/* we need one copy of events per cpu for reading */
-	map_size = total_cpus * evlist->core.nr_entries / nr_cgroups;
-	bpf_map__set_max_entries(skel->maps.events, map_size);
-	bpf_map__set_max_entries(skel->maps.cgrp_idx, nr_cgroups);
-	/* previous result is saved in a per-cpu array */
-	map_size = evlist->core.nr_entries / nr_cgroups;
-	bpf_map__set_max_entries(skel->maps.prev_readings, map_size);
-	/* cgroup result needs all events (per-cpu) */
-	map_size = evlist->core.nr_entries;
-	bpf_map__set_max_entries(skel->maps.cgrp_readings, map_size);
-
-	set_max_rlimit();
+	setup_rodata(skel, evlist->core.nr_entries);
 
 	err = bperf_cgroup_bpf__load(skel);
 	if (err) {
diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index 18ab4d9b49ff..c2298a2decc9 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -1,14 +1,12 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2021 Facebook
 // Copyright (c) 2021 Google
+#include "bperf_cgroup.h"
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
-#define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
-#define MAX_EVENTS  1024  // max events per cgroup: arbitrary
-
 // NOTE: many of map and global data will be modified before loading
 //       from the userspace (perf tool) using the skeleton helpers.
 
@@ -97,7 +95,7 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
 	cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_subsys_id], cgroup);
 	level = BPF_CORE_READ(cgrp, level);
 
-	for (cnt = 0; i < MAX_LEVELS; i++) {
+	for (cnt = 0; i < BPERF_CGROUP__MAX_LEVELS; i++) {
 		__u64 cgrp_id;
 
 		if (i > level)
@@ -123,7 +121,7 @@ static inline int get_cgroup_v2_idx(__u32 *cgrps, int size)
 	__u32 *elem;
 	int cnt;
 
-	for (cnt = 0; i < MAX_LEVELS; i++) {
+	for (cnt = 0; i < BPERF_CGROUP__MAX_LEVELS; i++) {
 		__u64 cgrp_id = bpf_get_current_ancestor_cgroup_id(i);
 
 		if (cgrp_id == 0)
@@ -148,17 +146,17 @@ static int bperf_cgroup_count(void)
 	register int c = 0;
 	struct bpf_perf_event_value val, delta, *prev_val, *cgrp_val;
 	__u32 cpu = bpf_get_smp_processor_id();
-	__u32 cgrp_idx[MAX_LEVELS];
+	__u32 cgrp_idx[BPERF_CGROUP__MAX_LEVELS];
 	int cgrp_cnt;
 	__u32 key, cgrp;
 	long err;
 
 	if (use_cgroup_v2)
-		cgrp_cnt = get_cgroup_v2_idx(cgrp_idx, MAX_LEVELS);
+		cgrp_cnt = get_cgroup_v2_idx(cgrp_idx, BPERF_CGROUP__MAX_LEVELS);
 	else
-		cgrp_cnt = get_cgroup_v1_idx(cgrp_idx, MAX_LEVELS);
+		cgrp_cnt = get_cgroup_v1_idx(cgrp_idx, BPERF_CGROUP__MAX_LEVELS);
 
-	for ( ; idx < MAX_EVENTS; idx++) {
+	for ( ; idx < BPERF_CGROUP__MAX_EVENTS; idx++) {
 		if (idx == num_events)
 			break;
 
@@ -186,7 +184,7 @@ static int bperf_cgroup_count(void)
 			delta.enabled = val.enabled - prev_val->enabled;
 			delta.running = val.running - prev_val->running;
 
-			for (c = 0; c < MAX_LEVELS; c++) {
+			for (c = 0; c < BPERF_CGROUP__MAX_LEVELS; c++) {
 				if (c == cgrp_cnt)
 					break;
 
-- 
2.51.1.821.gb6fe4d2222-goog


