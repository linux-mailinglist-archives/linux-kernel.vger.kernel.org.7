Return-Path: <linux-kernel+bounces-682088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5070EAD5B65
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B27B07AA46A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24D5221F29;
	Wed, 11 Jun 2025 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwM0Mxtm"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10B221723
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657759; cv=none; b=l4LCbT/p+0oyC8doBnJ6fC58lBOkWsgrjilUiHmG5SrEYV8LBIwyL11ACddr84KpzKdLWOpWFdHGwVR8i+VfqaK9A/1ERyGVUgtNzXndL3Qo0TK6q4fFsx2ssFi+We1hTs6Ux0MUgMEl+SAZMX7uegvEukG1kNbXmUzVwjyoU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657759; c=relaxed/simple;
	bh=6rTeHdvFj+TzP4fuOKw6JIv1YSRvOk1CUi7LJMnkhg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FCY8ROoJfOK1J7xg6+AH8eV6B1YwCIziO2/5O3FP13KDYOZTKkF+BgR/xAnCGkDVBOrBOb6kXeqRBw9dQlEZdRyjbs5Z/x5+PwQI+HVCJK9dtGHjEdFtYEjtNsuwuhpwHxICg77iApS9XuiTpVHm9WIBPugOLZWXVhgP8iRk/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwM0Mxtm; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2e8f1365181so4344015fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749657756; x=1750262556; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=liUhjcinB77Eb6jHKv87c9fMKbjh9O7i5zgWSFhgTn8=;
        b=vwM0Mxtm+/cXijz5XOzpP4D8Wx/+ZPgMymAVmJsg+mwKhfOGx2CL+rAago6iA/wN0T
         QnuQHiO7cNzLZw8RSO9K+/RIEBj2TMI7VREfZsXzpLDM5S7MfvJcD2f2FBIZ4AM82W9V
         UnK88jKYooHxosqP5fsmQUF2IKUM5riuLcZx19OVB4Abp3rtjFCk83KFNtDHLewL5Io4
         fHV4bFwKrkd/mdMR6IiNKuftsbkXB3OJt3jA7GRIkaoS1tThFAL/TdvbEEt7MqGy2qUP
         w34X+NWQ1JWcnm2nlKitfhCNKDG4UwrzaSbtSPh1O/ATGPzkIF9smSicc1yVoYxC7C4J
         GKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657756; x=1750262556;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liUhjcinB77Eb6jHKv87c9fMKbjh9O7i5zgWSFhgTn8=;
        b=LRIs0e+/HPaSOeSj5mEBXV7MWW3HOFSUIRFFMuG7ILyMxMdqtgMml3qj3oUxcINezh
         7dLfqWzMaPIo8a+021fQ35t6KtiT2Yv1cTmK8oSvyetBGQ2YZxSfUD6ZWsoDwTUaiuwk
         59LtJw9GVI0bKROv2Wf0DXeySvvHI+YWP0JY183mooZ3lvyc8oEJ7EEMHFjaODmVAXMR
         clRcY8B3DhYJxkELkZA45ScDhVEkWsHppIbQDsofaZo08S+ak+jUK2oDOF0509mSiJwU
         4MVWyJLt0eie79Cte/LuH0cKCerquK9LJNbEUksEWkRUL+KHP+zSPTDZgh1pDmn4UArd
         /bYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFumjNkB+2dX9aYow4UzcTSuRCEQeiczOGQbJHrOn4NaJ1HTYDB/LjwdGizm/iBb2QQPeEXDKiCUvpRnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xetn4nGcEZcpVlGCn8rEtowMOWVUDY16Wc2gaZoZiu/dPxeK
	G+81SKDpDyA5dVatrpIulS/dfNFlhxZN6WDLs0PCxnZqjPQxjhVvqOv1y6dWgiM/ighCpCg+Cll
	Exnqybj2iaQ==
X-Google-Smtp-Source: AGHT+IFf8zlSd0QMLB/u14p9zB/1c51Ng9p6/WgRWB+5l33Y+9FhY6Dexfl75URKWo8iuuswdZuVS7NRttjy
X-Received: from oabgu16.prod.google.com ([2002:a05:6870:ab10:b0:2b8:45b4:8afc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:d204:b0:2d4:ce45:698d
 with SMTP id 586e51a60fabf-2ea96c04e1amr2270089fac.4.1749657756561; Wed, 11
 Jun 2025 09:02:36 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:02:04 -0700
In-Reply-To: <20250611160206.552030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611160206.552030-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611160206.552030-14-irogers@google.com>
Subject: [PATCH v2 13/15] perf tp_pmu: Add event APIs
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
index c0c12880146a..2b7671d5bbb4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -23,6 +23,7 @@
 #include "hwmon_pmu.h"
 #include "pmus.h"
 #include "tool_pmu.h"
+#include "tp_pmu.h"
 #include <util/pmu-bison.h>
 #include <util/pmu-flex.h>
 #include "parse-events.h"
@@ -1976,6 +1977,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return false;
 	if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
 		return false;
+	if (perf_pmu__is_tracepoint(pmu))
+		return tp_pmu__have_event(pmu, name);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__have_event(pmu, name);
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
@@ -1989,6 +1992,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
+	if (perf_pmu__is_tracepoint(pmu))
+		return tp_pmu__num_events(pmu);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__num_events(pmu);
 
@@ -2057,6 +2062,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	struct hashmap_entry *entry;
 	size_t bkt;
 
+	if (perf_pmu__is_tracepoint(pmu))
+		return tp_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__for_each_event(pmu, state, cb);
 
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
2.50.0.rc0.642.g800a2b2222-goog


