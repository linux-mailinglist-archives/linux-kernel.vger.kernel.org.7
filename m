Return-Path: <linux-kernel+bounces-743325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C05B0FD4E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD28176C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929ED273D78;
	Wed, 23 Jul 2025 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cuc2yhxi"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA42737F0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312977; cv=none; b=rrmid3UArirzbRz6W0vQEuB3jmuNmz30Vk2dMQz6MR16oLENChYWBjj+hbUuKY/edjvBFeoIcYvaldvXtrj6LO6uZmz4iUp+y2nhSpATpcCRKHwV1p7reDrI4mXYAvjco6nu06eYCype4J49MyoiSOgbLlNZfXyPoXzCCqS2gS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312977; c=relaxed/simple;
	bh=tE74RNbYZV6qoUXLX6zP0wZBqh0cMN/lDuB25GJ9V7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jaHyILT8UijBQ1dXoAXaLLI7aboL8PwbUPW31jzmeY8y5SWPASn1t+O/JO2BIHbBGnbbRkBz/kuKrxBzPY3nv8OUSB6o9KNg7kdPS4deZLuPIjiVnnc71unzh1geyWD6xA04jpyV6LMavGC23K3MBq3zyRL2YhcxZC0gBSAbyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cuc2yhxi; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2355651d204so2772305ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753312975; x=1753917775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzAoY2/0bYYy0Y49MP8J/HVmXMXErIlx8RY6RE0UuMI=;
        b=Cuc2yhxitJcbgzEv2irwii5t7Pinv874tyfXJFH2GWwHZTBFFF5gfP5wFBDDCSqc0/
         JEek8ZrIIQaiSmMl+mPpvGtrTOjTpbrvVx47a+RVZxmm1Jgg4W8vadpcBzD0ohAH50K5
         FAWUKJYxvaxVG0YVGbzHHL0MpT27indesRBLKx/AiM3x+z6DsuqDtpCLjj2s7R/Lrljb
         OnNbmt6oLQRT3lBCDFiQ5gBL1I4ASCz72+zulksw/BhxH9D7T0QPzAoKOzxLTELMI55U
         OWNq2rqwRR107gfSRdGBmIe3SC11nTHRGBpYIALmxtKDHsDRqx+euZMcY+oQXlO4Tbek
         5fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312975; x=1753917775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzAoY2/0bYYy0Y49MP8J/HVmXMXErIlx8RY6RE0UuMI=;
        b=k3bGOi7cVsSDR5VRCCw02ENa/3EGKacql/+GiVF3d4Wzw7GnAJemYl5AUymzRSGzmb
         VOmOUa3DakzaqBhBA2b25xVwEhV/aBkx8yZQDYyYADBp8iokSII4R0KybznPOas3Nk15
         tWwr0UuxfHipx15cGROkxmmOExm40hoidwWwGIAx8ruLcWbDMGouMB6FCUh461JRG/hB
         hOHuoLF0AMttpfBbTY3Z+bhy2fvAnEIDKWKGxy03qxACVdd1WGB6ts/Eyo8y48QcDdu+
         wdCXL5wPfjXXs6ie4G0K3JGD4LgrsJJr/0lQt2cmQ/23S/3A59TaWt905JdYEoWcY+WF
         Ew0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6k4M4br7oogMdNErqLvIo4G1a8NuVJU/xua2Ja+SOKjDTeg7K9LhUxo2MgyX0CV8veBnPtaq2avZGKHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKeV8ZSkA60lYUE2di2DdAmOMkKiAHHBJ8qP1HpcO2LyNShL4
	H4frNbqDMy8LxQzHPXkZCQktzeIsmLIDmYmwGDTmOZQZLYSY0LDL+SU3eIgOxJR7kS8f6uIXl9p
	EGRfkS6B8kA==
X-Google-Smtp-Source: AGHT+IEEcX5zA+6fJGW9UrCkKhwKuMA/N428eLPKwCKCDmLU+9rn8YnffIF+aD57pwl0KO6WkIRxE9gKnmXA
X-Received: from plbmu14.prod.google.com ([2002:a17:903:b4e:b0:23f:8df8:e7af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:ac8:b0:220:ea90:191e
 with SMTP id d9443c01a7336-23f981468cbmr73059425ad.4.1753312974771; Wed, 23
 Jul 2025 16:22:54 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:05 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-5-irogers@google.com>
Subject: [PATCH v8 04/16] perf tp_pmu: Factor existing tracepoint logic to new file
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

Start the creation of a tracepoint PMU abstraction. Tracepoint events
don't follow the regular sysfs perf conventions. Eventually the new
PMU abstraction will bridge the gap so tracepoint events look more
like regular perf ones.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 12bc01c843b2..4959e7a990e4 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -88,6 +88,7 @@ perf-util-y += pmu-bison.o
 perf-util-y += drm_pmu.o
 perf-util-y += hwmon_pmu.o
 perf-util-y += tool_pmu.o
+perf-util-y += tp_pmu.o
 perf-util-y += svghelper.o
 perf-util-y += trace-event-info.o
 perf-util-y += trace-event-scripting.o
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3896a04d90af..5a1d19b4e5cd 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -59,6 +59,7 @@
 #include "drm_pmu.h"
 #include "hwmon_pmu.h"
 #include "tool_pmu.h"
+#include "tp_pmu.h"
 #include "rlimit.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
@@ -571,24 +572,6 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
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
@@ -622,7 +605,7 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool
 	event_attr_init(&attr);
 
 	if (format) {
-		id = trace_event__id(sys, name);
+		id = tp_pmu__id(sys, name);
 		if (id < 0) {
 			err = id;
 			goto out_free;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1ae481c9802b..f19541ca5268 100644
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
index 000000000000..42bd967a4530
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
+		if (!strcmp(events_ent->d_name, ".") ||
+		    !strcmp(events_ent->d_name, "..") ||
+		    !strcmp(events_ent->d_name, "enable") ||
+		    !strcmp(events_ent->d_name, "header_event") ||
+		    !strcmp(events_ent->d_name, "header_page"))
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
2.50.0.727.gbf7dc18ff4-goog


