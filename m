Return-Path: <linux-kernel+bounces-682087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 669E7AD5B77
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 18:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750D3188DBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 16:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1001E221D9E;
	Wed, 11 Jun 2025 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODcKAxfV"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEEA22156E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657757; cv=none; b=hQEMvJdfguBfDfvudgs6ss0uWZmR+dUrSR9peNrz/f3M5VrgGxfQzh9MBaspn1wzGKsLMLERiQq8FLS/k6p6gLdJy+vyaWt8S24b9LCXBttVDGAlYxuYIekOK5Qn4+CYW317xQ1bS3HMu8YVuI2ZyLLthkyl31T/BJpEPjVKQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657757; c=relaxed/simple;
	bh=bQeLV1BsJ2tvnezVsFH5HQWOoFaIkdLvkn0rDP/V1Ec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=P6sfTtjtTVTNK/fpRI6SHXD5fpbvSZQF4A4PA4O7XZamKWGyeVFuvOWjZZzf905nd5qEFFgx17wh3vmwlCCuPtlQNIVsT7qUtDByCcqBez/a4u8CdJtsWcy1/lJFW/nBDtECangaZRCAyEt0auoYVvw+OFDZ/j2wlNUAFOs3GH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODcKAxfV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73bfc657aefso25538b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749657754; x=1750262554; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxJrtp3uxGwwn+DeihPrvlrgDTT79b0N8a6G0RBrVtA=;
        b=ODcKAxfVojTntDCgq8HO6rIKhcJ+yQbTFI2dXryoylMNhhfVZvgI/gCL7I365tu7+t
         qjWodaszCCvcl+PMmHWMdelfRms506u5QUWI/Z0TVAUAmBfa/6QHYgkCsOvtiYlJR2VC
         iuX8tOKNX+g5Rn1djpcc1TC6P1tR0CDaVXhRXB/lKEIRRxKmVtHJqL9tAPkGAR++1LA1
         tuexgrAFpFRbJQBng4tfbYUZFSocKFnhPluQtWKUQ3343CwgyfGQIn0UImVi2frs4z4z
         hQT9+D4UZ1D5KjkMeD1DxuBbLVRzbhiqLllRAU2PnEklV4EKSyEA+8McNGftdBGtAxps
         v+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657754; x=1750262554;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxJrtp3uxGwwn+DeihPrvlrgDTT79b0N8a6G0RBrVtA=;
        b=TPH9qVBF+L9PV3k1BAiyAp/h7WQEoLwga78MjjYpNhogh5QcX9r6dO40KetP85Fpup
         zJoOng1awn+C2+KDKmpb8EvmyhqVV8ntfFjgFvbCs6LytAmM2VnPuGQ+ixSw7bVSjdQh
         S57rqmh2i7Iu29xqKMIve7ElAAfH8fHOW6DPO3K1ST4XmwmmOwIXrjKs0vn9aQn9KRtq
         K1KQZglcBXllQ8VnPkaA4EBojUl5dhKLIGkv8tD8DWyKCH5wmySSlXY003eADiLHT983
         GKF00m2ezsHMuzfW1Oul4Y/O97aW4ahalgmjH7CLYwWrNfs5RqO2/PyeCf3XR9U1cDX1
         6Qng==
X-Forwarded-Encrypted: i=1; AJvYcCU1l0AwqlZ+e6eVbsj9Ce5H/p+QJb2p7rtYc0/bqDyxgyJ3zGibSojmTkvJoMGe6MWZ7LdCZ7Box8tl6Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnccQxoS2LX2ixFot3IXTFEgDZk4F/3TqdLYcDFEWg7JQ39gj1
	fkSUwwCU9NH0lhmOalvtt5JOgH27VXo3AO+Gy7/dyIA6K24UlbGoGyVy0wSkDZs/YNjm/XKTk2h
	014eTZ88UBA==
X-Google-Smtp-Source: AGHT+IEVOyWL5lErXvTsU+x1O0b7GJrN1WG4ogAJh6rxs9wG0KFn5YcjwBDkKn09LP5xheIAeQUikL+kEw6U
X-Received: from pfbfa5.prod.google.com ([2002:a05:6a00:2d05:b0:746:24d7:a6aa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ace:b0:747:ee09:1fdf
 with SMTP id d2e1a72fcca58-7486cb9c05emr5223659b3a.4.1749657754349; Wed, 11
 Jun 2025 09:02:34 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:02:03 -0700
In-Reply-To: <20250611160206.552030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611160206.552030-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611160206.552030-13-irogers@google.com>
Subject: [PATCH v2 12/15] perf tp_pmu: Factor existing tracepoint logic to new file
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Start the creation of a tracepoint PMU abstraction. Tracepoint events
don't follow the regular sysfs perf conventions. Eventually the new
PMU abstraction will bridge the gap so tracepoint events look more
like regular perf ones.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build          |   1 +
 tools/perf/util/evsel.c        |  21 +----
 tools/perf/util/parse-events.c | 147 ++++++++++++++-------------------
 tools/perf/util/tp_pmu.c       |  95 +++++++++++++++++++++
 tools/perf/util/tp_pmu.h       |  12 +++
 5 files changed, 170 insertions(+), 106 deletions(-)
 create mode 100644 tools/perf/util/tp_pmu.c
 create mode 100644 tools/perf/util/tp_pmu.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 7910d908c814..a06ff82f9dd7 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -86,6 +86,7 @@ perf-util-y += pmu-flex.o
 perf-util-y += pmu-bison.o
 perf-util-y += hwmon_pmu.o
 perf-util-y += tool_pmu.o
+perf-util-y += tp_pmu.o
 perf-util-y += svghelper.o
 perf-util-y += trace-event-info.o
 perf-util-y += trace-event-scripting.o
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d55482f094bf..beab9710fbf5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -58,6 +58,7 @@
 #include "pmus.h"
 #include "hwmon_pmu.h"
 #include "tool_pmu.h"
+#include "tp_pmu.h"
 #include "rlimit.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
@@ -570,24 +571,6 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 	return NULL;
 }
 
-static int trace_event__id(const char *sys, const char *name)
-{
-	char *tp_dir = get_events_file(sys);
-	char path[PATH_MAX];
-	int id, err;
-
-	if (!tp_dir)
-		return -1;
-
-	scnprintf(path, PATH_MAX, "%s/%s/id", tp_dir, name);
-	put_events_file(tp_dir);
-	err = filename__read_int(path, &id);
-	if (err)
-		return err;
-
-	return id;
-}
-
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
@@ -621,7 +604,7 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool
 	event_attr_init(&attr);
 
 	if (format) {
-		id = trace_event__id(sys, name);
+		id = tp_pmu__id(sys, name);
 		if (id < 0) {
 			err = id;
 			goto out_free;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4dbae59dccb3..b3f56236fd60 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -17,13 +17,12 @@
 #include "string2.h"
 #include "strbuf.h"
 #include "debug.h"
-#include <api/fs/tracing_path.h>
-#include <api/io_dir.h>
 #include <perf/cpumap.h>
 #include <util/parse-events-bison.h>
 #include <util/parse-events-flex.h>
 #include "pmu.h"
 #include "pmus.h"
+#include "tp_pmu.h"
 #include "asm/bug.h"
 #include "ui/ui.h"
 #include "util/parse-branch-options.h"
@@ -33,6 +32,7 @@
 #include "util/stat.h"
 #include "util/util.h"
 #include "tracepoint.h"
+#include <api/fs/tracing_path.h>
 
 #define MAX_NAME_LEN 100
 
@@ -558,105 +558,82 @@ static int add_tracepoint(struct parse_events_state *parse_state,
 	return 0;
 }
 
-static int add_tracepoint_multi_event(struct parse_events_state *parse_state,
-				      struct list_head *list,
-				      const char *sys_name, const char *evt_name,
-				      struct parse_events_error *err,
-				      struct parse_events_terms *head_config, YYLTYPE *loc)
-{
-	char *evt_path;
-	struct io_dirent64 *evt_ent;
-	struct io_dir evt_dir;
-	int ret = 0, found = 0;
-
-	evt_path = get_events_file(sys_name);
-	if (!evt_path) {
-		tracepoint_error(err, errno, sys_name, evt_name, loc->first_column);
-		return -1;
-	}
-	io_dir__init(&evt_dir, open(evt_path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
-	if (evt_dir.dirfd < 0) {
-		put_events_file(evt_path);
-		tracepoint_error(err, errno, sys_name, evt_name, loc->first_column);
-		return -1;
-	}
+struct add_tracepoint_multi_args {
+	struct parse_events_state *parse_state;
+	struct list_head *list;
+	const char *sys_glob;
+	const char *evt_glob;
+	struct parse_events_error *err;
+	struct parse_events_terms *head_config;
+	YYLTYPE *loc;
+	int found;
+};
 
-	while (!ret && (evt_ent = io_dir__readdir(&evt_dir))) {
-		if (!strcmp(evt_ent->d_name, ".")
-		    || !strcmp(evt_ent->d_name, "..")
-		    || !strcmp(evt_ent->d_name, "enable")
-		    || !strcmp(evt_ent->d_name, "filter"))
-			continue;
+static int add_tracepoint_multi_event_cb(void *state, const char *sys_name, const char *evt_name)
+{
+	struct add_tracepoint_multi_args *args = state;
+	int ret;
 
-		if (!strglobmatch(evt_ent->d_name, evt_name))
-			continue;
+	if (!strglobmatch(evt_name, args->evt_glob))
+		return 0;
 
-		found++;
+	args->found++;
+	ret = add_tracepoint(args->parse_state, args->list, sys_name, evt_name,
+			     args->err, args->head_config, args->loc);
 
-		ret = add_tracepoint(parse_state, list, sys_name, evt_ent->d_name,
-				     err, head_config, loc);
-	}
+	return ret;
+}
 
-	if (!found) {
-		tracepoint_error(err, ENOENT, sys_name, evt_name, loc->first_column);
-		ret = -1;
+static int add_tracepoint_multi_event(struct add_tracepoint_multi_args *args, const char *sys_name)
+{
+	if (strpbrk(args->evt_glob, "*?") == NULL) {
+		/* Not a glob. */
+		args->found++;
+		return add_tracepoint(args->parse_state, args->list, sys_name, args->evt_glob,
+				      args->err, args->head_config, args->loc);
 	}
 
-	put_events_file(evt_path);
-	close(evt_dir.dirfd);
-	return ret;
+	return tp_pmu__for_each_tp_event(sys_name, args, add_tracepoint_multi_event_cb);
 }
 
-static int add_tracepoint_event(struct parse_events_state *parse_state,
-				struct list_head *list,
-				const char *sys_name, const char *evt_name,
-				struct parse_events_error *err,
-				struct parse_events_terms *head_config, YYLTYPE *loc)
+static int add_tracepoint_multi_sys_cb(void *state, const char *sys_name)
 {
-	return strpbrk(evt_name, "*?") ?
-		add_tracepoint_multi_event(parse_state, list, sys_name, evt_name,
-					   err, head_config, loc) :
-		add_tracepoint(parse_state, list, sys_name, evt_name,
-			       err, head_config, loc);
+	struct add_tracepoint_multi_args *args = state;
+
+	if (!strglobmatch(sys_name, args->sys_glob))
+		return 0;
+
+	return add_tracepoint_multi_event(args, sys_name);
 }
 
 static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
 				    struct list_head *list,
-				    const char *sys_name, const char *evt_name,
+				    const char *sys_glob, const char *evt_glob,
 				    struct parse_events_error *err,
 				    struct parse_events_terms *head_config, YYLTYPE *loc)
 {
-	struct io_dirent64 *events_ent;
-	struct io_dir events_dir;
-	int ret = 0;
-	char *events_dir_path = get_tracing_file("events");
+	struct add_tracepoint_multi_args args = {
+		.parse_state = parse_state,
+		.list = list,
+		.sys_glob = sys_glob,
+		.evt_glob = evt_glob,
+		.err = err,
+		.head_config = head_config,
+		.loc = loc,
+		.found = 0,
+	};
+	int ret;
 
-	if (!events_dir_path) {
-		tracepoint_error(err, errno, sys_name, evt_name, loc->first_column);
-		return -1;
+	if (strpbrk(sys_glob, "*?") == NULL) {
+		/* Not a glob. */
+		ret = add_tracepoint_multi_event(&args, sys_glob);
+	} else {
+		ret = tp_pmu__for_each_tp_sys(&args, add_tracepoint_multi_sys_cb);
 	}
-	io_dir__init(&events_dir, open(events_dir_path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
-	put_events_file(events_dir_path);
-	if (events_dir.dirfd < 0) {
-		tracepoint_error(err, errno, sys_name, evt_name, loc->first_column);
-		return -1;
+	if (args.found == 0) {
+		tracepoint_error(err, ENOENT, sys_glob, evt_glob, loc->first_column);
+		return -ENOENT;
 	}
-
-	while (!ret && (events_ent = io_dir__readdir(&events_dir))) {
-		if (!strcmp(events_ent->d_name, ".")
-		    || !strcmp(events_ent->d_name, "..")
-		    || !strcmp(events_ent->d_name, "enable")
-		    || !strcmp(events_ent->d_name, "header_event")
-		    || !strcmp(events_ent->d_name, "header_page"))
-			continue;
-
-		if (!strglobmatch(events_ent->d_name, sys_name))
-			continue;
-
-		ret = add_tracepoint_event(parse_state, list, events_ent->d_name,
-					   evt_name, err, head_config, loc);
-	}
-	close(events_dir.dirfd);
 	return ret;
 }
 
@@ -1348,12 +1325,8 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 			return -EINVAL;
 	}
 
-	if (strpbrk(sys, "*?"))
-		return add_tracepoint_multi_sys(parse_state, list, sys, event,
-						err, head_config, loc);
-	else
-		return add_tracepoint_event(parse_state, list, sys, event,
-					    err, head_config, loc);
+	return add_tracepoint_multi_sys(parse_state, list, sys, event,
+					err, head_config, loc);
 }
 
 static int __parse_events_add_numeric(struct parse_events_state *parse_state,
diff --git a/tools/perf/util/tp_pmu.c b/tools/perf/util/tp_pmu.c
new file mode 100644
index 000000000000..fd83164f8763
--- /dev/null
+++ b/tools/perf/util/tp_pmu.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "tp_pmu.h"
+#include <api/fs/fs.h>
+#include <api/fs/tracing_path.h>
+#include <api/io_dir.h>
+#include <linux/kernel.h>
+#include <errno.h>
+#include <string.h>
+
+int tp_pmu__id(const char *sys, const char *name)
+{
+	char *tp_dir = get_events_file(sys);
+	char path[PATH_MAX];
+	int id, err;
+
+	if (!tp_dir)
+		return -1;
+
+	scnprintf(path, PATH_MAX, "%s/%s/id", tp_dir, name);
+	put_events_file(tp_dir);
+	err = filename__read_int(path, &id);
+	if (err)
+		return err;
+
+	return id;
+}
+
+
+int tp_pmu__for_each_tp_event(const char *sys, void *state, tp_event_callback cb)
+{
+	char *evt_path;
+	struct io_dirent64 *evt_ent;
+	struct io_dir evt_dir;
+	int ret = 0;
+
+	evt_path = get_events_file(sys);
+	if (!evt_path)
+		return -errno;
+
+	io_dir__init(&evt_dir, open(evt_path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (evt_dir.dirfd < 0) {
+		ret = -errno;
+		put_events_file(evt_path);
+		return ret;
+	}
+	put_events_file(evt_path);
+
+	while (!ret && (evt_ent = io_dir__readdir(&evt_dir))) {
+		if (!strcmp(evt_ent->d_name, ".")
+		    || !strcmp(evt_ent->d_name, "..")
+		    || !strcmp(evt_ent->d_name, "enable")
+		    || !strcmp(evt_ent->d_name, "filter"))
+			continue;
+
+		ret = cb(state, sys, evt_ent->d_name);
+		if (ret)
+			break;
+	}
+	close(evt_dir.dirfd);
+	return ret;
+}
+
+int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb)
+{
+	struct io_dirent64 *events_ent;
+	struct io_dir events_dir;
+	int ret = 0;
+	char *events_dir_path = get_tracing_file("events");
+
+	if (!events_dir_path)
+		return -errno;
+
+	io_dir__init(&events_dir, open(events_dir_path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (events_dir.dirfd < 0) {
+		ret = -errno;
+		put_events_file(events_dir_path);
+		return ret;
+	}
+	put_events_file(events_dir_path);
+
+	while (!ret && (events_ent = io_dir__readdir(&events_dir))) {
+		if (!strcmp(events_ent->d_name, ".")
+		    || !strcmp(events_ent->d_name, "..")
+		    || !strcmp(events_ent->d_name, "enable")
+		    || !strcmp(events_ent->d_name, "header_event")
+		    || !strcmp(events_ent->d_name, "header_page"))
+			continue;
+
+		ret = cb(state, events_ent->d_name);
+		if (ret)
+			break;
+	}
+	close(events_dir.dirfd);
+	return ret;
+}
diff --git a/tools/perf/util/tp_pmu.h b/tools/perf/util/tp_pmu.h
new file mode 100644
index 000000000000..49537303bd73
--- /dev/null
+++ b/tools/perf/util/tp_pmu.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __TP_PMU_H
+#define __TP_PMU_H
+
+typedef int (*tp_sys_callback)(void *state, const char *sys_name);
+typedef int (*tp_event_callback)(void *state, const char *sys_name, const char *evt_name);
+
+int tp_pmu__id(const char *sys, const char *name);
+int tp_pmu__for_each_tp_event(const char *sys, void *state, tp_event_callback cb);
+int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb);
+
+#endif /* __TP_PMU_H */
-- 
2.50.0.rc0.642.g800a2b2222-goog


