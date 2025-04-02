Return-Path: <linux-kernel+bounces-585440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55484A79371
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 18:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C58316C6C3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6421A304A;
	Wed,  2 Apr 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEgWd9gA"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4919E83C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612453; cv=none; b=Vu2Mwf/MRW2Ir8G0dD+jf0CeA9pY+VR29tHlch4kHrM4syt0Qa6fOFh0XKwXyfCni8VsHodf0X1pHL9Aa4/OBYJcX5zHu/DKP26q0LlsN/3YCLpfJDoxZcnE4TNTnzhM8EPrLdpqj+X4fCVyJIt00t2vgYKyvnCbuVkhqiUE9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612453; c=relaxed/simple;
	bh=ceFQQBDmr9eZ5yU3Gt86zh2f8+RxL6DcgnNhvGpxxF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Ar19cLu2NWM0RJKvpDDNe9JdOjFiOJHwWH+vqIyALGmi79/3iLniCQrtMPDScqEkZfWU3Jk+lVKrvIDQPqV34WEGaeel6GzYHrka+SvpzdYVrijd87qaaLLCUsfmpNZ5v3dns0AnBFOD1rS6PYV5kYFua6WtJpBnzao2aWu33Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BEgWd9gA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224192ff68bso484755ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743612451; x=1744217251; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/Qfr113zCIU5rUe0KDXRj0KUMUinv6gA3VPY5V4Jtk=;
        b=BEgWd9gAjpDfrKcn45x/GdeERHbjnDcCKqTXhkASChHioy0u9mDuzdcXPtPmOyMS+H
         eCcA8C7l149W1Di8+zEHsj6kdPcIKfpK1YqDw/ioyotbhoEGvisNx9WTeSYlGBrphEMY
         97LTh6AMlP6NXWXj7hP7Nkx/yBVVFVOVjW0kcfjP63ZN5VBM45n2qEnu/vR1IiSJMy8i
         NXGh4p98qEdIcZ7on8UwFd1qiAXlnVdDdMWUSy21gQ89NnDg3sKM3E9pRXNo/XBtlXNy
         C30WilYH1P7HXUJjM8Z68VAl9VW2krwWW2gmNMFYvce1KodyLuKLfUiI9MqqlAYBoDUU
         znPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743612451; x=1744217251;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/Qfr113zCIU5rUe0KDXRj0KUMUinv6gA3VPY5V4Jtk=;
        b=C9+ZhaRedG5UNCrBaZcBmRmAaT7GX6X7sEYZ2GPDfSTuXS8aEvG5aPMahq/tIpUN5B
         5dJNwk10Lq7MpRhguWZ8gl9g3WoLIChx+BlTb7l6c3tEbm63/ixmpRR/gWsBH4xlf4MA
         mP0PbHFw4XMZ1gRedRmUIF+OevfvEytawrZYMFLP7GvnVMpclbtNku502fgYfcZHZeLo
         y9K1tVH1Q/hJKBC5bFXxMXvbjGM5m721pDeVv5jjpgZWXzSALM9leKdnjLLuZImlcdW4
         ZcAObe0TdbwZdP6TghJ0kHp342JNMBEvRNJBxYVJL++OMzk8NjsH2ovQ/JpW6emXUWlz
         10iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1u3k1lR9vRcPYa3POIvIUe2RKJW2Oz0SZvO+HhsnEPqHRnJpyedVrawzFQUxcB3nB2sC6xweduOqKxVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6pYBiv5cEwvhnZK9EMHgwzDoafuzCoXAZGsy6dWdt7fe9I9OS
	wVqsnWzllK7IK8d+EsQnl8j3k9hAI0W1iHTIRZ+gYt5fvn3mca5NRT4KN0j3592tKZFGjJjLTeP
	N5DgXuA==
X-Google-Smtp-Source: AGHT+IGhP8qElqcgJ4MyrXLm/aqq5o3XDeP+tTGfLtkiObvCW5hiKCTE3Ib7sJkQCsyZ3WFMN/lFRTtR3cPJ
X-Received: from pjd15.prod.google.com ([2002:a17:90b:54cf:b0:2fc:aac:e580])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60c:b0:223:5e76:637a
 with SMTP id d9443c01a7336-2296c688a9dmr40198615ad.23.1743612451174; Wed, 02
 Apr 2025 09:47:31 -0700 (PDT)
Date: Wed,  2 Apr 2025 09:47:18 -0700
In-Reply-To: <20250402164720.3847573-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402164720.3847573-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402164720.3847573-4-irogers@google.com>
Subject: [PATCH v2 3/5] perf evlist: Refactor evlist__scnprintf_evsels
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch output to using a strbuf so the storage can be resized. Add a
maximum size argument to avoid too much output that may happen for
uncore events. Rename as scnprintf is no longer used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c |  9 ++++++---
 tools/perf/util/evlist.c    | 21 ++++++++++++---------
 tools/perf/util/evlist.h    |  3 ++-
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba20bf7c011d..9a3f7d9f881d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -51,6 +51,7 @@
 #include "util/clockid.h"
 #include "util/off_cpu.h"
 #include "util/bpf-filter.h"
+#include "util/strbuf.h"
 #include "asm/bug.h"
 #include "perf.h"
 #include "cputopo.h"
@@ -2784,13 +2785,15 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__auxtrace_snapshot_exit(rec);
 
 	if (forks && workload_exec_errno) {
-		char msg[STRERR_BUFSIZE], strevsels[2048];
+		char msg[STRERR_BUFSIZE];
 		const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
+		struct strbuf sb = STRBUF_INIT;
 
-		evlist__scnprintf_evsels(rec->evlist, sizeof(strevsels), strevsels);
+		evlist__format_evsels(rec->evlist, &sb, 2048);
 
 		pr_err("Failed to collect '%s' for the '%s' workload: %s\n",
-			strevsels, argv[0], emsg);
+			sb.buf, argv[0], emsg);
+		strbuf_release(&sb);
 		err = -1;
 		goto out_child;
 	}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c1a04141aed0..ffb5be41a465 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -35,6 +35,7 @@
 #include "util/util.h"
 #include "util/env.h"
 #include "util/intel-tpebs.h"
+#include "util/strbuf.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
@@ -2468,23 +2469,25 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 	return NULL;
 }
 
-int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf)
+void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_length)
 {
 	struct evsel *evsel;
-	int printed = 0;
+	bool first = true;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel__is_dummy_event(evsel))
 			continue;
-		if (size > (strlen(evsel__name(evsel)) + (printed ? 2 : 1))) {
-			printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "," : "", evsel__name(evsel));
-		} else {
-			printed += scnprintf(bf + printed, size - printed, "%s...", printed ? "," : "");
-			break;
+
+		if (!first)
+			strbuf_addch(sb, ',');
+
+		if (sb->len > max_length) {
+			strbuf_addstr(sb, "...");
+			return;
 		}
+		strbuf_addstr(sb, evsel__name(evsel));
+		first = false;
 	}
-
-	return printed;
 }
 
 void evlist__check_mem_load_aux(struct evlist *evlist)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index edcbf1c10e92..21f6bff319fd 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -20,6 +20,7 @@ struct pollfd;
 struct thread_map;
 struct perf_cpu_map;
 struct record_opts;
+struct strbuf;
 struct target;
 
 /*
@@ -430,7 +431,7 @@ int event_enable_timer__process(struct event_enable_timer *eet);
 
 struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 
-int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
+void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb, size_t max_length);
 void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
 void evlist__uniquify_name(struct evlist *evlist);
-- 
2.49.0.504.g3bcea36a83-goog


