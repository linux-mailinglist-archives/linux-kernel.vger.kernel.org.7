Return-Path: <linux-kernel+bounces-726423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E2BB00D08
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A953AB3E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8302FF46E;
	Thu, 10 Jul 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GcTzggQ0"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86082FEE2D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179125; cv=none; b=IuZCKHYKMOhgwmVYE8SfviSGvx4v+HuMG/Br035xt7qRawwL0XwhcFzA5gisZlIf24YnuULijFfgXyfFExirNjZM9eNBmxLOBaLIJknix8PfkTeOWal+g9Tho1Vi5azVI8J7YaZuEr21o4N27mtzpUDEeXfCiZdoM+6L3olPXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179125; c=relaxed/simple;
	bh=RZ/4wZ7BLS3RqD09YBHOjY7W3qZV5Jmx+MPGWahCs1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=j/2TPbeCysMlSgH/y9n5/Q5ktKYEGLChm1HszSkWl1C0WhyBBgTCaEH4QeVDP4nLnpIH6OYpqe2NiFPM2PZMtuNbVwqtRBLKQFhv0fKMdjKgKCNHRFXdEbuMUPnxiF0O4Tin6CXCvNJ1sxm5548ApBkoSBsG1fpj7KACuh5IUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GcTzggQ0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2356ce55d33so20416995ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179123; x=1752783923; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5/KtDdH9KZtizmnT+G+DMzo0YjRxsCsauFrBz7enXg=;
        b=GcTzggQ0faPfxZxG5oTO5sH8MQSiL1jSsUQ3BeCi4CG/fGdanT+Dv3loYPXpvrgMCY
         oXNf+upGID5XiLe1Hg91HRJAf4vSCzHUYBPdM9dGDZMKo9XcSamqdKWp5FPp7gReRpdD
         ZzWNMRY8oap4Rje7S5jH+gRXl3bK9mlWMNAjPivCGgYzKHtnKIiIainZ3cPUMl/Z7efK
         V5ZhTAx9X2VBxRfd20RpZCj9cZ2CA86yX/n0fGBlEHAQxi6jpYsr2nNjjbRsFuRYXE0j
         WrJ/JgQGkcm2rLhpqdWtMUxqD1DX+0RSmCo1wwJ0FZD+52335Id7ArJOFIjieyfDfqA3
         QL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179123; x=1752783923;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5/KtDdH9KZtizmnT+G+DMzo0YjRxsCsauFrBz7enXg=;
        b=XRYPojA0mg/pTKcR7tkSvZJfBK8NwnC/uU5E+X+OyvMtjzxXdh1Hq+D9QiH2lXXzyw
         3iN0Y2yQPaY9FOG+XkX44ZDMseNv9K8JOQBqyeD3a4m6truv3QZD4B1TbJLNTmuf5lDh
         dvEF2ZkZXJv4bRXQ5yKlf2/tUO1QKgcOg0U5W5tAdd6Q36rwCJR3zWJgqe0CZGZz+Hh9
         X3kC1ukX32lcSTvKpwUTkkeTy18jHRGbnfehd210EkJWzCwVzZ9/djgS38E9B7R+Yb8M
         d6HNer9hB3eEqZuVJoH5dh89Lu4+r08c+MjCzRmaVICnzF7R0L7lOAkwzge+sKfzTTm3
         anMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU4iSisgRyJ92HUmwaJIPqnN5qglx9pEty1Ut6ZtK822BxReFhGE+oz76XjvOJCab75jOzq0Q5pPZc5c4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6fI6DbhP/Tq1fzbACTNd4X4ukU+WPn9th1GMMpK35kEGks6cy
	jZ5EdHCS/BJjCiLidkXcaMT8vhLpGeCY35oqs7b+sCF0PRal6rhq0R7+hUgZg92c81y/5DLu3el
	A5ieZzoUASA==
X-Google-Smtp-Source: AGHT+IHaGeLOfBryMahOJzggF1DCw2HHiX14ouqhiqra3X86Gdz2fJYf6KlkbMisD9vqw5fj1CKc1+r0GrsO
X-Received: from plbkf11.prod.google.com ([2002:a17:903:5cb:b0:234:4c97:1e84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1247:b0:236:8db5:7e50
 with SMTP id d9443c01a7336-23dede2d0e8mr7155075ad.9.1752179123264; Thu, 10
 Jul 2025 13:25:23 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:24:46 -0700
In-Reply-To: <20250710202500.1959672-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710202500.1959672-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710202500.1959672-9-irogers@google.com>
Subject: [PATCH v5 04/14] perf tp_pmu: Add event APIs
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
Content-Type: text/plain; charset="UTF-8"

Add event APIs for the tracepoint PMU allowing things like perf list
to function using it. For perf list add the tracepoint format in the
long description (shown with -v).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c    |   7 +++
 tools/perf/util/tp_pmu.c | 114 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/tp_pmu.h |   7 +++
 3 files changed, 128 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b09b2ea2407a..dc05233e8232 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -24,6 +24,7 @@
 #include "hwmon_pmu.h"
 #include "pmus.h"
 #include "tool_pmu.h"
+#include "tp_pmu.h"
 #include <util/pmu-bison.h>
 #include <util/pmu-flex.h>
 #include "parse-events.h"
@@ -1983,6 +1984,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return false;
 	if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
 		return false;
+	if (perf_pmu__is_tracepoint(pmu))
+		return tp_pmu__have_event(pmu, name);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__have_event(pmu, name);
 	if (perf_pmu__is_drm(pmu))
@@ -1998,6 +2001,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
+	if (perf_pmu__is_tracepoint(pmu))
+		return tp_pmu__num_events(pmu);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__num_events(pmu);
 	if (perf_pmu__is_drm(pmu))
@@ -2068,6 +2073,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	struct hashmap_entry *entry;
 	size_t bkt;
 
+	if (perf_pmu__is_tracepoint(pmu))
+		return tp_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_drm(pmu))
diff --git a/tools/perf/util/tp_pmu.c b/tools/perf/util/tp_pmu.c
index fd83164f8763..9d68a1da17f6 100644
--- a/tools/perf/util/tp_pmu.c
+++ b/tools/perf/util/tp_pmu.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 #include "tp_pmu.h"
+#include "pmus.h"
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
 #include <api/io_dir.h>
@@ -93,3 +94,116 @@ int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb)
 	close(events_dir.dirfd);
 	return ret;
 }
+
+bool perf_pmu__is_tracepoint(const struct perf_pmu *pmu)
+{
+	return pmu->type == PERF_TYPE_TRACEPOINT;
+}
+
+struct for_each_event_args {
+	void *state;
+	pmu_event_callback cb;
+	const struct perf_pmu *pmu;
+};
+
+static int for_each_event_cb(void *state, const char *sys_name, const char *evt_name)
+{
+	struct for_each_event_args *args = state;
+	char name[2 * FILENAME_MAX + 2];
+	/* 16 possible hex digits and 22 other characters and \0. */
+	char encoding[16 + 22];
+	char *format = NULL;
+	size_t format_size;
+	struct pmu_event_info info = {
+		.pmu = args->pmu,
+		.pmu_name = args->pmu->name,
+		.event_type_desc = "Tracepoint event",
+	};
+	char *tp_dir = get_events_file(sys_name);
+	char path[PATH_MAX];
+	int id, err;
+
+	if (!tp_dir)
+		return -1;
+
+	scnprintf(path, sizeof(path), "%s/%s/id", tp_dir, evt_name);
+	err = filename__read_int(path, &id);
+	if (err == 0) {
+		snprintf(encoding, sizeof(encoding), "tracepoint/config=0x%x/", id);
+		info.encoding_desc = encoding;
+	}
+
+	scnprintf(path, sizeof(path), "%s/%s/format", tp_dir, evt_name);
+	put_events_file(tp_dir);
+	err = filename__read_str(path, &format, &format_size);
+	if (err == 0) {
+		info.long_desc = format;
+		for (size_t i = 0 ; i < format_size; i++) {
+			/* Swap tabs to spaces due to some rendering issues. */
+			if (format[i] == '\t')
+				format[i] = ' ';
+		}
+	}
+	snprintf(name, sizeof(name), "%s:%s", sys_name, evt_name);
+	info.name = name;
+	err = args->cb(args->state, &info);
+	free(format);
+	return err;
+}
+
+static int for_each_event_sys_cb(void *state, const char *sys_name)
+{
+	return tp_pmu__for_each_tp_event(sys_name, state, for_each_event_cb);
+}
+
+int tp_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
+{
+	struct for_each_event_args args = {
+		.state = state,
+		.cb = cb,
+		.pmu = pmu,
+	};
+
+	return tp_pmu__for_each_tp_sys(&args, for_each_event_sys_cb);
+}
+
+static int num_events_cb(void *state, const char *sys_name __maybe_unused,
+			 const char *evt_name __maybe_unused)
+{
+	size_t *count = state;
+
+	(*count)++;
+	return 0;
+}
+
+static int num_events_sys_cb(void *state, const char *sys_name)
+{
+	return tp_pmu__for_each_tp_event(sys_name, state, num_events_cb);
+}
+
+size_t tp_pmu__num_events(struct perf_pmu *pmu __maybe_unused)
+{
+	size_t count = 0;
+
+	tp_pmu__for_each_tp_sys(&count, num_events_sys_cb);
+	return count;
+}
+
+bool tp_pmu__have_event(struct perf_pmu *pmu __maybe_unused, const char *name)
+{
+	char *dup_name, *colon;
+	int id;
+
+	if (strchr(name, ':') == NULL)
+		return false;
+
+	dup_name = strdup(name);
+	if (!dup_name)
+		return false;
+
+	colon = strchr(dup_name, ':');
+	*colon = '\0';
+	id = tp_pmu__id(dup_name, colon + 1);
+	free(dup_name);
+	return id >= 0;
+}
diff --git a/tools/perf/util/tp_pmu.h b/tools/perf/util/tp_pmu.h
index 49537303bd73..30456bd6943d 100644
--- a/tools/perf/util/tp_pmu.h
+++ b/tools/perf/util/tp_pmu.h
@@ -2,6 +2,8 @@
 #ifndef __TP_PMU_H
 #define __TP_PMU_H
 
+#include "pmu.h"
+
 typedef int (*tp_sys_callback)(void *state, const char *sys_name);
 typedef int (*tp_event_callback)(void *state, const char *sys_name, const char *evt_name);
 
@@ -9,4 +11,9 @@ int tp_pmu__id(const char *sys, const char *name);
 int tp_pmu__for_each_tp_event(const char *sys, void *state, tp_event_callback cb);
 int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb);
 
+bool perf_pmu__is_tracepoint(const struct perf_pmu *pmu);
+int tp_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+size_t tp_pmu__num_events(struct perf_pmu *pmu);
+bool tp_pmu__have_event(struct perf_pmu *pmu, const char *name);
+
 #endif /* __TP_PMU_H */
-- 
2.50.0.727.gbf7dc18ff4-goog


