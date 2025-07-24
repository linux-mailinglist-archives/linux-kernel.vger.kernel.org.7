Return-Path: <linux-kernel+bounces-743327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BACEB0FD50
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE0CAA03FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05A2749C1;
	Wed, 23 Jul 2025 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+Qyj7MX"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF162586DA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312985; cv=none; b=YLzqxkl5pfsryKHE1flQdoN0WyMSa++smDg6Wj4FTHQZrZ4a+d5Uz3lK0wSYmg8QCDG9DefcNhO51eeKovGyCojpcUUpmHH/0IUnh0CP1mgkotaP6cWm7d4ZHpcW0mWwfHrewcMYeYTNVt1/SZwsAIpFTlvgHQKlE2yKCJDSvH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312985; c=relaxed/simple;
	bh=ITH+WGnIDk5Syvv1E7DWgL8Gj28bdzS/hdWom7U5GlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UktHeyAojGRH2VBv90dYh8q8UBFlSKNMcylG1dduUz7k8qvTDAKdL28IT2icG928OvMie+49/eD++UpjffIMtBHagTKRF9qV2HkxBYLlj8Nf84ws0pEvJRlF4+zGeTmv0hkrphgL4D7F9l2LlJIZw4Cf1GNR8bCHHa56AROW5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+Qyj7MX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748f30d56d1so162538b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753312983; x=1753917783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRH6HZKDKoaKwPBOk/dUfxHlkHKgENKAsBPm6OWaIbk=;
        b=N+Qyj7MXYz6fXP75H75woRUm6AIKp8mRpJ75x4bK47Bb7FpyhuSVFXotDo5PiyPwkG
         TqqHFHkFDfmRztF1jwwmbo9XnNp1ES2G0FxOAjQ/lu64hKzoQQf5GT0SCqg8ZZyEQKja
         FzoSXCUEaPWx7qHQeCUoKBDibERz5nh05Vk/2byCetilPjXo+2ju2wT17RjtTr7I9r/6
         9YncYdz5OOP9+OraErMYADOpWQ6ePVS702OBqxpRYJCjBwhS+oZ73zP00c5QcjBaTcsZ
         352lZFgx5P2ONpRpQy4iD35Zj9UHcnJ/qBeQ0TFh2bCAAyL1Dnxf43dAL1Cr8fFDoFdn
         ArCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312983; x=1753917783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRH6HZKDKoaKwPBOk/dUfxHlkHKgENKAsBPm6OWaIbk=;
        b=YoXbaevSxb9R2QI0Cdk6YvUsQ+qK5kF99sdvqM6eswLDFfcWFxU3XLys2pX5F8Dt0/
         dQw5O50QuQz34TQ+/VfxSuT6F8fI81WKzEFclCcEpxHmhwBiMY6Q1Mp1x6uJIDRyJofO
         k+pr30rVHVIJCh1JUktPjxSY+g54Sm5lGic0YiKvxAdKnO+BI9oO4doDmOWuASi8zGwm
         PFX4P5fKF22cRiMMOItWYU6GSA9WTWXYl1hJYXtAMwmcXKe2JQqyoMuhpjwTs4bZnw4w
         It5rKreXEInkNJkVIcKmQciUd1gnbTnglX3XcWtmyye5kLVaRhWTwkibsZ0VnmCksnuI
         7ljQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvoJEt7MgYBDiQ6jg/2oYyYqdkF4IEbGmzmedRieHwrkYcHE0ET+Evl86jN8ToWanPm9iS49QveKUCvb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29bdkWQOwePp66hWOmf0IZxIKdLchkZE3OURBSnX7/0YZbEBZ
	rE8vk/YtXgXDNWXQh7Ib3BX0/W5KXkObFiVaQ+/wI6dDqA/hxzSvoFxYkWsyj0doy/Bt8niI86y
	i2bsH2fOzaw==
X-Google-Smtp-Source: AGHT+IEBQmFOYJpk7Vc0ebapw8BkruPXjwGsNAnot1LFhemYBwzPPibAyobqm5RTp2kHLpNHNEWBdbUQkP6O
X-Received: from pftb15.prod.google.com ([2002:a05:6a00:2cf:b0:746:2d8f:cac1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a91:b0:757:51d:9dd9
 with SMTP id d2e1a72fcca58-76035de66bdmr6476770b3a.17.1753312983098; Wed, 23
 Jul 2025 16:23:03 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:07 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-7-irogers@google.com>
Subject: [PATCH v8 06/16] perf list: Remove tracepoint printing code
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Now that the tp_pmu can iterate and describe events remove the custom
tracepoint printing logic, this avoids perf list showing the
tracepoint events twice.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-list.c      | 29 ++++++++---
 tools/perf/util/print-events.c | 93 ----------------------------------
 tools/perf/util/print-events.h |  2 -
 3 files changed, 23 insertions(+), 101 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 674bb0afbf93..3a4061d02f6c 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -614,9 +614,18 @@ int cmd_list(int argc, const char **argv)
 	for (i = 0; i < argc; ++i) {
 		char *sep, *s;
 
-		if (strcmp(argv[i], "tracepoint") == 0)
-			print_tracepoint_events(&print_cb, ps);
-		else if (strcmp(argv[i], "hw") == 0 ||
+		if (strcmp(argv[i], "tracepoint") == 0) {
+			char *old_pmu_glob = default_ps.pmu_glob;
+
+			default_ps.pmu_glob = strdup("tracepoint");
+			if (!default_ps.pmu_glob) {
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.pmu_glob);
+			default_ps.pmu_glob = old_pmu_glob;
+		} else if (strcmp(argv[i], "hw") == 0 ||
 			 strcmp(argv[i], "hardware") == 0)
 			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
 					event_symbols_hw, PERF_COUNT_HW_MAX);
@@ -658,6 +667,7 @@ int cmd_list(int argc, const char **argv)
 #endif
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			char *old_pmu_glob = default_ps.pmu_glob;
+			char *old_event_glob = default_ps.event_glob;
 
 			default_ps.event_glob = strdup(argv[i]);
 			if (!default_ps.event_glob) {
@@ -665,13 +675,21 @@ int cmd_list(int argc, const char **argv)
 				goto out;
 			}
 
-			print_tracepoint_events(&print_cb, ps);
+			default_ps.pmu_glob = strdup("tracepoint");
+			if (!default_ps.pmu_glob) {
+				zfree(&default_ps.event_glob);
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.pmu_glob);
+			default_ps.pmu_glob = old_pmu_glob;
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
 			default_ps.metricgroups = true;
 			metricgroup__print(&print_cb, ps);
 			zfree(&default_ps.event_glob);
-			default_ps.pmu_glob = old_pmu_glob;
+			default_ps.event_glob = old_event_glob;
 		} else {
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
 				printf("Critical: Not enough memory! Trying to continue...\n");
@@ -682,7 +700,6 @@ int cmd_list(int argc, const char **argv)
 					event_symbols_hw, PERF_COUNT_HW_MAX);
 			print_hwcache_events(&print_cb, ps);
 			perf_pmus__print_pmu_events(&print_cb, ps);
-			print_tracepoint_events(&print_cb, ps);
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
 			default_ps.metricgroups = true;
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index c1a8708b55ab..3a5e5e7bae13 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -44,97 +44,6 @@ static const char * const event_type_descriptors[] = {
 	"Hardware breakpoint",
 };
 
-/*
- * Print the events from <debugfs_mount_point>/tracing/events
- */
-void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unused, void *print_state __maybe_unused)
-{
-	char *events_path = get_tracing_file("events");
-	int events_fd = open(events_path, O_PATH);
-	struct dirent **sys_namelist = NULL;
-	int sys_items;
-
-	if (events_fd < 0) {
-		pr_err("Error: failed to open tracing events directory\n");
-		pr_err("%s: %s\n", events_path, strerror(errno));
-		return;
-	}
-	put_tracing_file(events_path);
-
-	sys_items = tracing_events__scandir_alphasort(&sys_namelist);
-
-	for (int i = 0; i < sys_items; i++) {
-		struct dirent *sys_dirent = sys_namelist[i];
-		struct dirent **evt_namelist = NULL;
-		int dir_fd;
-		int evt_items;
-
-		if (sys_dirent->d_type != DT_DIR ||
-		    !strcmp(sys_dirent->d_name, ".") ||
-		    !strcmp(sys_dirent->d_name, ".."))
-			goto next_sys;
-
-		dir_fd = openat(events_fd, sys_dirent->d_name, O_PATH);
-		if (dir_fd < 0)
-			goto next_sys;
-
-		evt_items = scandirat(events_fd, sys_dirent->d_name, &evt_namelist, NULL, alphasort);
-		for (int j = 0; j < evt_items; j++) {
-			/*
-			 * Buffer sized at twice the max filename length + 1
-			 * separator + 1 \0 terminator.
-			 */
-			char buf[NAME_MAX * 2 + 2];
-			/* 16 possible hex digits and 22 other characters and \0. */
-			char encoding[16 + 22];
-			struct dirent *evt_dirent = evt_namelist[j];
-			struct io id;
-			__u64 config;
-
-			if (evt_dirent->d_type != DT_DIR ||
-			    !strcmp(evt_dirent->d_name, ".") ||
-			    !strcmp(evt_dirent->d_name, ".."))
-				goto next_evt;
-
-			snprintf(buf, sizeof(buf), "%s/id", evt_dirent->d_name);
-			io__init(&id, openat(dir_fd, buf, O_RDONLY), buf, sizeof(buf));
-
-			if (id.fd < 0)
-				goto next_evt;
-
-			if (io__get_dec(&id, &config) < 0) {
-				close(id.fd);
-				goto next_evt;
-			}
-			close(id.fd);
-
-			snprintf(buf, sizeof(buf), "%s:%s",
-				 sys_dirent->d_name, evt_dirent->d_name);
-			snprintf(encoding, sizeof(encoding), "tracepoint/config=0x%llx/", config);
-			print_cb->print_event(print_state,
-					/*topic=*/NULL,
-					/*pmu_name=*/NULL, /* really "tracepoint" */
-					/*event_name=*/buf,
-					/*event_alias=*/NULL,
-					/*scale_unit=*/NULL,
-					/*deprecated=*/false,
-					"Tracepoint event",
-					/*desc=*/NULL,
-					/*long_desc=*/NULL,
-					encoding);
-next_evt:
-			free(evt_namelist[j]);
-		}
-		close(dir_fd);
-		free(evt_namelist);
-next_sys:
-		free(sys_namelist[i]);
-	}
-
-	free(sys_namelist);
-	close(events_fd);
-}
-
 void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	struct strlist *bidlist, *sdtlist;
@@ -552,8 +461,6 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 			/*long_desc=*/NULL,
 			/*encoding_desc=*/NULL);
 
-	print_tracepoint_events(print_cb, print_state);
-
 	print_sdt_events(print_cb, print_state);
 
 	metricgroup__print(print_cb, print_state);
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 48682e2d166d..4d95b8257e23 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -37,8 +37,6 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
 			 unsigned int max);
-
-void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state);
 void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
 bool is_event_supported(u8 type, u64 config);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


