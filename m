Return-Path: <linux-kernel+bounces-663462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E3AC4889
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 08:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE091898B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 06:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133551F8ADD;
	Tue, 27 May 2025 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="peH6R5yU"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9301FC7C5
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328133; cv=none; b=pt769TVX0zetCjWjDQuYv2KFlYH+k2tzgm5OJTVgttkaWDlIhwi7cxZO0y9vKCEW3xqRwk8M6x8vepdUT17SrTeUpb5FZd27LxOK6ydYSbrfFp0tKKSTUzNTN1jQIT7fV0wbcAx+kqAXghA6Zw7yZ6BrVIl+BwxQokY3U5i32lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328133; c=relaxed/simple;
	bh=ZDm31FfHy0h9d3TWNNNiAXdOHpXi5vYqUedTkakDLOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uQ/2RjLuDyHNS6r/xsdSawXLuv4Pq0nof+9bXcVHh4jfkNMefO6uDmgKVnQB/qstlQdi2Yw9YqsJMtd3VLFQkXqWA8TG1fVKwRzu/fQjDl6mAJe2merOA1o3HZeBP54v0sn8yS8L1QwFSfKqCisb/mtq71DKF8kOvSteznNFOGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=peH6R5yU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234042bdcc5so19762745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 23:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748328130; x=1748932930; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDBpbpsYgqLkOcx3zNUIeqrEAl0fb06VtvHqHgTH7CQ=;
        b=peH6R5yU5zUKNAls1ZkYN9yuh/gsCIIvu5xaUKgnBoKDHx+sRONYvyU9wCOBryfaT7
         gs9wrFdFv9cHGe5HvpSS8qPEF4JK00Bb3MSVLgbFeGSxNoEAf2n42NuBGvostWBo+eVe
         C5BRaoKXg3tsHPkvDn+5q7PO7L9WSmOEPZauA43W3e6tiWxZsf0MhKEHTXrVhNjOMyGS
         M6FlPF85XpDMF/fHzhA+x+e6D1bnxgC5ntK3434s/FFycZLB9eQInhWgCwU+EAItLzSu
         Ogru1Shdmg2L4SHgZHgdCVAb+wG2tF9zrPbXzV1PEEztif+YzI4mgUQIo+IRGsNKi5PS
         7AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748328130; x=1748932930;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDBpbpsYgqLkOcx3zNUIeqrEAl0fb06VtvHqHgTH7CQ=;
        b=hDaH4+p/F7pGXoYszZ/lbrPQFhgZcf3eehO3Ymgse2EDJt4aGykNYpnCgSX3uWxrH+
         y+raw5/qt5uFPOAZON6xYywyVPCMkVrOYc93l0exW18kPGOQ8Tvzm599//axJuRQNnWR
         JNnUX+K4hJyHFCBEfxYHe3kLzrlZLMO0BTw3LPja6eBAb514W+aG7QkZaRQuDtGuywMe
         OhKm0bVD7ABm4KhEKwaq/Cc8TWJbQJatmfOP/AaqlvTnqhix//pE8Crfxxf61H3CdQco
         CLKdYLgqF/+/EcMMBsOQVN11kA5eeGclOsog9wAcNTBWxm5gf2c2Yalz6gJvPxFr36Tx
         tBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo+GCSa0HquvMmJwS93ajr+Qhshdx4iX8TRORAZc8RfWdg3gztaz83Vqg+SpEJfS4i9q9iE/BuLPS2YNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwENftZzjSFb5iNbO5eLUw70vLJacLujS2OA7nCxFyv7rBcX/En
	xrHWA7FXTSFlrAUlLVkZ1DDQ2sgYY1kXd/OZiLnhN1bGhSxAeKmYIijsEsrf/amLPBpKyE9mhlD
	E3pNDuzLWjQ==
X-Google-Smtp-Source: AGHT+IGMXvuiR1zerHk3aQo+rgRobZgtLILUogGw7uq9DS/VlrJI0H6VM+HSxBsgDTEpNX/0OCWvgMYdst7A
X-Received: from pllk4.prod.google.com ([2002:a17:902:7604:b0:234:3f28:4851])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c8:b0:223:f9a4:3f99
 with SMTP id d9443c01a7336-23414f9f230mr185352785ad.29.1748328130225; Mon, 26
 May 2025 23:42:10 -0700 (PDT)
Date: Mon, 26 May 2025 23:41:45 -0700
In-Reply-To: <20250527064153.149939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527064153.149939-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250527064153.149939-4-irogers@google.com>
Subject: [PATCH v1 03/11] perf evlist: Change env variable to session
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The session holds a perf_env pointer env. In UI code container_of is
used to turn the env to a session, but this assumes the session
header's env is in use. Rather than a dubious container_of, hold the
session in the evlist and derive the env from the session with
evsel__env, perf_session__env, etc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c      |  6 +++++-
 tools/perf/builtin-script.c      |  2 +-
 tools/perf/builtin-top.c         |  2 +-
 tools/perf/tests/topology.c      |  1 +
 tools/perf/ui/browser.h          |  4 ++--
 tools/perf/ui/browsers/header.c  |  4 +---
 tools/perf/ui/browsers/hists.c   |  2 +-
 tools/perf/util/amd-sample-raw.c |  2 +-
 tools/perf/util/arm-spe.c        |  2 +-
 tools/perf/util/evlist.h         |  2 +-
 tools/perf/util/evsel.c          | 12 +++++++++---
 tools/perf/util/evsel.h          |  1 +
 tools/perf/util/header.c         |  2 +-
 tools/perf/util/s390-cpumsf.c    |  2 +-
 tools/perf/util/sample-raw.c     |  7 ++++---
 tools/perf/util/sample-raw.h     |  2 +-
 tools/perf/util/session.c        |  4 +++-
 17 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 9238cb993015..9b7bf1dcaa1b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1264,6 +1264,8 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 			union perf_event *event,
 			struct evlist **pevlist)
 {
+	struct perf_session *session;
+	struct perf_env *env;
 	u64 sample_type;
 	int err;
 
@@ -1276,7 +1278,9 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(*pevlist);
-	callchain_param_setup(sample_type, perf_env__arch((*pevlist)->env));
+	session = (*pevlist)->session;
+	env = perf_session__env(session);
+	callchain_param_setup(sample_type, perf_env__arch(env));
 	return 0;
 }
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 55b7c5ed8245..165668d67a6a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2533,7 +2533,7 @@ static int process_attr(const struct perf_tool *tool, union perf_event *event,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(evlist);
-	callchain_param_setup(sample_type, perf_env__arch((*pevlist)->env));
+	callchain_param_setup(sample_type, perf_env__arch(perf_session__env(scr->session)));
 
 	/* Enable fields for callchain entries */
 	if (symbol_conf.use_callchain &&
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0427dc027519..3c89568dd6d0 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1654,7 +1654,6 @@ int cmd_top(int argc, const char **argv)
 			"Couldn't read the cpuid for this machine: %s\n",
 			str_error_r(errno, errbuf, sizeof(errbuf)));
 	}
-	top.evlist->env = &perf_env;
 
 	argc = parse_options(argc, argv, options, top_usage, 0);
 	if (argc)
@@ -1827,6 +1826,7 @@ int cmd_top(int argc, const char **argv)
 		top.session = NULL;
 		goto out_delete_evlist;
 	}
+	top.session->env = &perf_env;
 
 	if (!evlist__needs_bpf_sb_event(top.evlist))
 		top.record_opts.no_bpf_event = true;
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index bc7d10630dad..ec01150d208d 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -43,6 +43,7 @@ static int session_write_header(char *path)
 
 	session->evlist = evlist__new_default();
 	TEST_ASSERT_VAL("can't get evlist", session->evlist);
+	session->evlist->session = session;
 
 	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
 	perf_header__set_feat(&session->header, HEADER_NRCPUS);
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index f59ad4f14d33..9d4404f9b87f 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -71,8 +71,8 @@ int ui_browser__help_window(struct ui_browser *browser, const char *text);
 bool ui_browser__dialog_yesno(struct ui_browser *browser, const char *text);
 int ui_browser__input_window(const char *title, const char *text, char *input,
 			     const char *exit_msg, int delay_sec);
-struct perf_env;
-int tui__header_window(struct perf_env *env);
+struct perf_session;
+int tui__header_window(struct perf_session *session);
 
 void ui_browser__argv_seek(struct ui_browser *browser, off_t offset, int whence);
 unsigned int ui_browser__argv_refresh(struct ui_browser *browser);
diff --git a/tools/perf/ui/browsers/header.c b/tools/perf/ui/browsers/header.c
index 2213b4661600..5b5ca32e3eef 100644
--- a/tools/perf/ui/browsers/header.c
+++ b/tools/perf/ui/browsers/header.c
@@ -93,16 +93,14 @@ static int ui__list_menu(int argc, char * const argv[])
 	return list_menu__run(&menu);
 }
 
-int tui__header_window(struct perf_env *env)
+int tui__header_window(struct perf_session *session)
 {
 	int i, argc = 0;
 	char **argv;
-	struct perf_session *session;
 	char *ptr, *pos;
 	size_t size;
 	FILE *fp = open_memstream(&ptr, &size);
 
-	session = container_of(env, struct perf_session, header.env);
 	perf_header__fprintf_info(session, fp, true);
 	fclose(fp);
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index d26b925e3d7f..d9d3fb44477a 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3233,7 +3233,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 		case 'i':
 			/* env->arch is NULL for live-mode (i.e. perf top) */
 			if (env->arch)
-				tui__header_window(env);
+				tui__header_window(evsel__session(evsel));
 			continue;
 		case 'F':
 			symbol_conf.filter_relative ^= 1;
diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index 022c9eb39509..ac24b4cb4a91 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -354,7 +354,7 @@ static void parse_cpuid(struct perf_env *env)
  */
 bool evlist__has_amd_ibs(struct evlist *evlist)
 {
-	struct perf_env *env = evlist->env;
+	struct perf_env *env = perf_session__env(evlist->session);
 	int ret, nr_pmu_mappings = perf_env__nr_pmu_mappings(env);
 	const char *pmu_mapping = perf_env__pmu_mappings(env);
 	char name[sizeof("ibs_fetch")];
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2a9775649cc2..2d36c062e71d 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -760,7 +760,7 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 		const char *cpuid;
 
 		pr_warning_once("Old SPE metadata, re-record to improve decode accuracy\n");
-		cpuid = perf_env__cpuid(spe->session->evlist->env);
+		cpuid = perf_env__cpuid(perf_session__env(spe->session));
 		midr = strtol(cpuid, NULL, 16);
 	} else {
 		/* CPU ID is -1 for per-thread mode */
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 85859708393e..121879aef60f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -70,7 +70,7 @@ struct evlist {
 	struct mmap *overwrite_mmap;
 	struct evsel *selected;
 	struct events_stats stats;
-	struct perf_env	*env;
+	struct perf_session *session;
 	void (*trace_event_sample_raw)(struct evlist *evlist,
 				       union perf_event *event,
 				       struct perf_sample *sample);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d55482f094bf..24c93ea5ba0a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -48,6 +48,7 @@
 #include "record.h"
 #include "debug.h"
 #include "trace-event.h"
+#include "session.h"
 #include "stat.h"
 #include "string2.h"
 #include "memswap.h"
@@ -3839,11 +3840,16 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
 }
 
+struct perf_session *evsel__session(struct evsel *evsel)
+{
+	return evsel && evsel->evlist ? evsel->evlist->session : NULL;
+}
+
 struct perf_env *evsel__env(struct evsel *evsel)
 {
-	if (evsel && evsel->evlist && evsel->evlist->env)
-		return evsel->evlist->env;
-	return &perf_env;
+	struct perf_session *session = evsel__session(evsel);
+
+	return session ? perf_session__env(session) : &perf_env;
 }
 
 static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6dbc9690e0c9..847acf9f6795 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -537,6 +537,7 @@ static inline bool evsel__is_dummy_event(struct evsel *evsel)
 	       (evsel->core.attr.config == PERF_COUNT_SW_DUMMY);
 }
 
+struct perf_session *evsel__session(struct evsel *evsel);
 struct perf_env *evsel__env(struct evsel *evsel);
 
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e3cdc3b7b4ab..c3621f718cb3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4228,7 +4228,7 @@ int perf_session__read_header(struct perf_session *session)
 	if (session->evlist == NULL)
 		return -ENOMEM;
 
-	session->evlist->env = &header->env;
+	session->evlist->session = session;
 	session->machines.host.env = &header->env;
 
 	/*
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 0ce52f0280b8..c17dbe232c54 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1142,7 +1142,7 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	sf->machine = &session->machines.host; /* No kvm support */
 	sf->auxtrace_type = auxtrace_info->type;
 	sf->pmu_type = PERF_TYPE_RAW;
-	sf->machine_type = s390_cpumsf_get_type(session->evlist->env->cpuid);
+	sf->machine_type = s390_cpumsf_get_type(perf_session__env(session)->cpuid);
 
 	sf->auxtrace.process_event = s390_cpumsf_process_event;
 	sf->auxtrace.process_auxtrace_event = s390_cpumsf_process_auxtrace_event;
diff --git a/tools/perf/util/sample-raw.c b/tools/perf/util/sample-raw.c
index f3f6bd9d290e..bcf442574d6e 100644
--- a/tools/perf/util/sample-raw.c
+++ b/tools/perf/util/sample-raw.c
@@ -6,15 +6,16 @@
 #include "env.h"
 #include "header.h"
 #include "sample-raw.h"
+#include "session.h"
 
 /*
  * Check platform the perf data file was created on and perform platform
  * specific interpretation.
  */
-void evlist__init_trace_event_sample_raw(struct evlist *evlist)
+void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct perf_env *env)
 {
-	const char *arch_pf = perf_env__arch(evlist->env);
-	const char *cpuid = perf_env__cpuid(evlist->env);
+	const char *arch_pf = perf_env__arch(env);
+	const char *cpuid = perf_env__cpuid(env);
 
 	if (arch_pf && !strcmp("s390", arch_pf))
 		evlist->trace_event_sample_raw = evlist__s390_sample_raw;
diff --git a/tools/perf/util/sample-raw.h b/tools/perf/util/sample-raw.h
index ea01c5811503..896e9a87e373 100644
--- a/tools/perf/util/sample-raw.h
+++ b/tools/perf/util/sample-raw.h
@@ -11,5 +11,5 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 bool evlist__has_amd_ibs(struct evlist *evlist);
 void evlist__amd_sample_raw(struct evlist *evlist, union perf_event *event,
 			    struct perf_sample *sample);
-void evlist__init_trace_event_sample_raw(struct evlist *evlist);
+void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct perf_env *env);
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 3af518243daf..beb74d9fcc07 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -177,7 +177,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 				perf_session__set_comm_exec(session);
 			}
 
-			evlist__init_trace_event_sample_raw(session->evlist);
+			evlist__init_trace_event_sample_raw(session->evlist, &session->header.env);
 
 			/* Open the directory data. */
 			if (data->is_dir) {
@@ -193,6 +193,8 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 	} else  {
 		session->machines.host.env = &perf_env;
 	}
+	if (session->evlist)
+		session->evlist->session = session;
 
 	session->machines.host.single_address_space =
 		perf_env__single_address_space(session->machines.host.env);
-- 
2.49.0.1151.ga128411c76-goog


