Return-Path: <linux-kernel+bounces-785561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA81CB34DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E16C4840B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782422EC562;
	Mon, 25 Aug 2025 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYhQ5UHR"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE929B233
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156335; cv=none; b=ERQmbC8vEJn2LrIpIQ1oIJiGHD1ct5ukD4M0UPFIqftEFIhN63HjKZ2em7nZyIq9TYIU0NKYDhavUOteRlyGBVFEGzS2nlCxS6H/u6EJyDMbD1Z3CDLB16MBRBDvuGXjKn4El+bPAiP+ZxlpBzLPnICooF13OLDbbdUfOlZ0pvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156335; c=relaxed/simple;
	bh=/EsLmYQedhPDEzjIH37S26bgfjjgEGeEs+W7gCUpg6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tasArfVSnvSSAjAoEzX6Cf2NNNogh4H8N+Zh58npMezN0HGNt6kFHESTSAcPOe/rTov3jkAZ9hHy5zCc0ULxMB35rfUxZiwiZp+4upbir2ssULKXkRLDQrfCU6AMIEUx1HX0/JcAl0N0PQBqdZHBUI0lkcYZUCCgT6fMuar6aZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYhQ5UHR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76ff2335c1eso3479877b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756156333; x=1756761133; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GvX8rYeRAib8iUkm2wWyP4g7MGr6ukV6SY2F6dE8Zk=;
        b=pYhQ5UHRYZwxDC9W4/jRUHu2bqn/RpyjywM45kOxleIfHg1aT5r5W/JdpBvIv4orZc
         y0Du0oJ/DryGZd07MneI04K4pW5UROJnC3CW4GtTYT55dTfnZao5szL+IegBV+BsRT9P
         MbeijM+j4hnUQ6PCSoYqePAS76Q3JHjO8R9pwuMwk3mHUsr+JOJFfcBkT83gdUeoxkS5
         fL6HZo2/froFIQbnlQN8gpEDr4zyiY9jZCsTfc6UumpIDHnwyeskMPefb6EA6GFlJpsu
         NDflP5vSBHjltjMpYVaHleZHWbi+JQYXVtVBnbMUIYR1WBPQtdgTt8GNoZYtu+ZCpZ/R
         E/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156333; x=1756761133;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GvX8rYeRAib8iUkm2wWyP4g7MGr6ukV6SY2F6dE8Zk=;
        b=H+q8GoGf/ZTM5oR/gKnqlvu4l8NiC2NLM7sKukR6wCrctOF8SiQXVAucEpXLoBjyNo
         4jClIehFzNdqT7Aw74DlMSkMjONooPlO/iQnTtnyqUY0dvKBp4lT2TvrlfqHffMaoCdR
         j7E7EfHQfSjmMni9iGzEezgkN9ZpvYhkiZbet8LlLmOCmwakrWsSUKNds13G4G2wPypx
         r93TBAlRFX129LamdOo3L0QLg9XBg2M6f/tRn4pNn48iwcfM21X/Sz6Azvd4nNEz8Ma2
         0gH3WgDLtjagN3NjdrepMfyja1PfcZBLDyKEDBAbJ5qg/0r30ISUrQYe6IAye8e/dAcc
         SGNg==
X-Forwarded-Encrypted: i=1; AJvYcCWG/Hr3wyTOkqG6RCI9p762tpaqs3CjhUxlFG963y33vHlK7gAbkbFZhG1UI3ydsym9AS9yIGXhRXDbsVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykz7HRHQAu2F6Q4fQrIn1OkpIDVe6mvYjFrGcja9DnewZuzxfh
	HAsrfvLWg22NerNcTSXPXkD0BWD3MJWeXJ2YuTDh6lwWTc/FrL1wwsBuIaHgC8Vt/GC4Sc53eUn
	hZH5hhIgjxg==
X-Google-Smtp-Source: AGHT+IFa1H5M7ycoC2jBKHnd/ngG3Chw2ze60hntesDA3TknECh9s8GT1d1pXgsWmJ/FHOPTT6lEOukgjms1
X-Received: from pfbln14.prod.google.com ([2002:a05:6a00:3cce:b0:76b:b0c5:347c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d4b:b0:76e:885a:c340
 with SMTP id d2e1a72fcca58-7702fb00564mr13695050b3a.30.1756156333164; Mon, 25
 Aug 2025 14:12:13 -0700 (PDT)
Date: Mon, 25 Aug 2025 14:12:02 -0700
In-Reply-To: <20250825211204.2784695-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825211204.2784695-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825211204.2784695-2-irogers@google.com>
Subject: [PATCH v1 1/3] perf evsel: Give warning for broken Intel topdown
 event grouping
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend arch_evsel__open_strerror from just AMD IBS events to Intel
core PMU events, to give a message when a slots event isn't a group
leader or when a perf metric event is duplicated within an event
group. As generating the warning happens after non-arch specific
warnings are generated, disable the missing system wide (-a) flag
warning for the core PMU. This assumes core PMU events should support
per-thread/process and system-wide.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evsel.c | 62 +++++++++++++++++++++++++++++---
 tools/perf/util/evsel.c          |  7 ++--
 tools/perf/util/evsel.h          |  2 +-
 3 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 9bc80fff3aa0..e67701d26f24 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/env.h"
 #include "util/pmu.h"
 #include "util/pmus.h"
+#include "util/stat.h"
+#include "util/strbuf.h"
 #include "linux/string.h"
 #include "topdown.h"
 #include "evsel.h"
@@ -102,13 +106,15 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
 	}
 }
 
-int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size)
+static int amd_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size)
 {
-	if (!x86__is_amd_cpu())
+	struct perf_pmu *pmu;
+
+	if (evsel->core.attr.precise_ip == 0)
 		return 0;
 
-	if (!evsel->core.attr.precise_ip &&
-	    !(evsel->pmu && !strncmp(evsel->pmu->name, "ibs", 3)))
+	pmu = evsel__find_pmu(evsel);
+	if (!pmu || strncmp(pmu->name, "ibs", 3))
 		return 0;
 
 	/* More verbose IBS errors. */
@@ -118,6 +124,54 @@ int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size)
 		return scnprintf(msg, size, "AMD IBS doesn't support privilege filtering. Try "
 				 "again without the privilege modifiers (like 'k') at the end.");
 	}
+	return 0;
+}
+
+static int intel_evsel__open_strerror(struct evsel *evsel, int err, char *msg, size_t size)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret;
+
+	if (err != EINVAL)
+		return 0;
 
+	if (!topdown_sys_has_perf_metrics())
+		return 0;
+
+	if (arch_is_topdown_slots(evsel)) {
+		if (!evsel__is_group_leader(evsel)) {
+			evlist__uniquify_evsel_names(evsel->evlist, &stat_config);
+			evlist__format_evsels(evsel->evlist, &sb, 2048);
+			ret = scnprintf(msg, size, "Topdown slots event can only be group leader "
+					"in '%s'.", sb.buf);
+			strbuf_release(&sb);
+			return ret;
+		}
+	} else if (arch_is_topdown_metrics(evsel)) {
+		struct evsel *pos;
+
+		evlist__for_each_entry(evsel->evlist, pos) {
+			if (pos == evsel || !arch_is_topdown_metrics(pos))
+				continue;
+
+			if (pos->core.attr.config != evsel->core.attr.config)
+				continue;
+
+			evlist__uniquify_evsel_names(evsel->evlist, &stat_config);
+			evlist__format_evsels(evsel->evlist, &sb, 2048);
+			ret = scnprintf(msg, size, "Perf metric event '%s' is duplicated "
+					"in the same group (only one event is allowed) in '%s'.",
+					evsel__name(evsel), sb.buf);
+			strbuf_release(&sb);
+			return ret;
+		}
+	}
 	return 0;
 }
+
+int arch_evsel__open_strerror(struct evsel *evsel, int err, char *msg, size_t size)
+{
+	return x86__is_amd_cpu()
+		? amd_evsel__open_strerror(evsel, msg, size)
+		: intel_evsel__open_strerror(evsel, err, msg, size);
+}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d264c143b592..796f3bf35f47 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3716,6 +3716,7 @@ static int dump_perf_event_processes(char *msg, size_t size)
 }
 
 int __weak arch_evsel__open_strerror(struct evsel *evsel __maybe_unused,
+				     int err __maybe_unused,
 				     char *msg __maybe_unused,
 				     size_t size __maybe_unused)
 {
@@ -3725,6 +3726,7 @@ int __weak arch_evsel__open_strerror(struct evsel *evsel __maybe_unused,
 int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 int err, char *msg, size_t size)
 {
+	struct perf_pmu *pmu;
 	char sbuf[STRERR_BUFSIZE];
 	int printed = 0, enforced = 0;
 	int ret;
@@ -3840,7 +3842,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "The 'aux_action' feature is not supported, update the kernel.");
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
-		if (!target__has_cpu(target))
+		pmu = evsel__find_pmu(evsel);
+		if (!pmu->is_core && !target__has_cpu(target))
 			return scnprintf(msg, size,
 	"Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
 					evsel__name(evsel));
@@ -3853,7 +3856,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 		break;
 	}
 
-	ret = arch_evsel__open_strerror(evsel, msg, size);
+	ret = arch_evsel__open_strerror(evsel, err, msg, size);
 	if (ret)
 		return ret;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5797a02e5d6a..e927a3a4fe0e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -341,7 +341,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 
 void arch_evsel__set_sample_weight(struct evsel *evsel);
 void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr);
-int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size);
+int arch_evsel__open_strerror(struct evsel *evsel, int err, char *msg, size_t size);
 
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
-- 
2.51.0.261.g7ce5a0a67e-goog


