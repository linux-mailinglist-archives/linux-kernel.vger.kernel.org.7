Return-Path: <linux-kernel+bounces-730517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBA9B045C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9181A67779
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8272641CA;
	Mon, 14 Jul 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2tp9Pz3q"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281626463E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511462; cv=none; b=IXvkc5+vTZ/NGnfAei/yU1s/6hNBAh8ggkaxYN3Z3Yn/Atle9o6SS/IRUtAR3nbE1XkUSr6A8hKPwIVrvEprRcec/vhNhqMumAUXMaAk1JI98Gw9VXZBF12WZzm2IcBIzTeQkRi82Su4d45j1thh310Cm+FtCGe40sZ9SyzFfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511462; c=relaxed/simple;
	bh=hQokINY7w1ShrrgZa7yZzzTcBe2DFkxckj5lH340Cec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=m/etaNX7HYMA7uyMon/78bwREXUe9XGBiSgQwz4UyvY9yp+K0Sht/bl6JyIRH/fHHK921nDP8iFYUHqKZ6/D/JzV5nwl3FQ4xmrB6RdfKvsjGK1/5Jl/4AkKvTAKBrdlAo0ThJemX/E3TUYdXHqPdDplJTBdKZCzV/QnWJuejQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2tp9Pz3q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2369dd58602so43343365ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511460; x=1753116260; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlDQWnF9PwaPlaf+aejcqkoEmXJ/40GLuFVvGJ4bgdI=;
        b=2tp9Pz3qcFN9NsSQuanREtKYmZdphLN+44Whnqtg9V68VRFwp9WicewjRuxehaicuf
         0T2VkVkira8U4LM/9IYt9LDelQykgu3M/UzAe2kEDUZWpdgmw7CVrreDq98VTqjmLb6O
         8rn8eFmtRyqq4S140yzdft0iF5VebFDQ8amqUIZN7Is+st5Y5j0POleMq0KdPaWtRTEx
         j7QJnZ6uTuVtn/vkWTTEBdf5eMVqfK1X9OQUXgCAOYa/edll2bGXR+SpCUb2vfxp4/yc
         XUzbQAUQsU54FrbvXNb7Jbk1jXzJKWfyUldy70aWwbVcVogKCZRFGXkMTBx2ZfU78mlO
         qHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511460; x=1753116260;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlDQWnF9PwaPlaf+aejcqkoEmXJ/40GLuFVvGJ4bgdI=;
        b=hdLhNYw7as96g7gy3My9pTU+vC0kmezxvRVaDXEjw1pc42jR5MPr8/VPcOKutokYWt
         PQKbK/t65eaudmOKjlonbl50aDSsQlyfk5qHztPiC7GEs99vV62fV2kWghGtvBf0yhaW
         QaYq2RXgNzoVYEGKqHhJAqGyirapQt/fGOqG2HSaK0Bkxl/cAaKUDQZinjFxJNjJM9SN
         bzeaFtVL7OVu0EW0qaFqsV4hS9GWif+l+FAvWoNYFkESNKckAxX5IpxSXQDnZOjM9JaD
         04Hu8WnMeoqyGKiPdWd2LLLbFKT4s87wMyG0OHd2QKD02gF24inPxQHVZMyZy7EsE6Zl
         T7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLXDvieoOmpraJvmXIC56J+jX5yqO9Vh8JHHY2ouyZlRpPiEZVyT09e68+vVIputNNL9O/9F26I2JJKIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLRDwX01gP5yus9gz7aGHqo0AdQ0utLrSBzhSArcEfDSknOsC
	1pD9gEMUbVnqxyunNlwWS6y2a/5wcMvJqHfZBE1UWI4ZKhqmFMIQooYsoxPI7xUw0a0E8a9+OPf
	jR7ib0HtkRw==
X-Google-Smtp-Source: AGHT+IEumyglzF13znI16/JnGL4z6ULeGETsNW8iRhw3vAFOtvnDv51NsJv71Y/AaAVo1QsKvZonTJSgTaLz
X-Received: from plkq5.prod.google.com ([2002:a17:902:edc5:b0:234:9673:1d13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec3:b0:236:6f43:7047
 with SMTP id d9443c01a7336-23dee1888a4mr185523845ad.9.1752511459713; Mon, 14
 Jul 2025 09:44:19 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:43:51 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-4-irogers@google.com>
Subject: [PATCH v7 03/16] perf parse-events: Remove non-json software events
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

Remove the hard coded encodings from parse-events. This has the
consequence that software events are matched using the sysfs/json
priority, will be case insensitive and will be wildcarded across PMUs.
As there were software and hardware types in the parsing code, the
removal means software vs hardware logic can be removed and hardware
assumed.

Now the perf json provides detailed descriptions of software events,
remove the previous listing support that didn't contain event
descriptions. When globbing is required for the "sw" option in perf
list, use string PMU globbing as was done previously for the tool PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 19 ++++++-------
 tools/perf/util/parse-events.c | 51 ----------------------------------
 tools/perf/util/parse-events.h |  1 -
 tools/perf/util/parse-events.l | 38 +++++++++----------------
 tools/perf/util/parse-events.y | 29 ++++++++-----------
 tools/perf/util/print-events.c |  2 --
 6 files changed, 33 insertions(+), 107 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index e9b595d75df2..674bb0afbf93 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -623,16 +623,17 @@ int cmd_list(int argc, const char **argv)
 		else if (strcmp(argv[i], "sw") == 0 ||
 			 strcmp(argv[i], "software") == 0) {
 			char *old_pmu_glob = default_ps.pmu_glob;
+			static const char * const sw_globs[] = { "software", "tool" };
 
-			print_symbol_events(&print_cb, ps, PERF_TYPE_SOFTWARE,
-					event_symbols_sw, PERF_COUNT_SW_MAX);
-			default_ps.pmu_glob = strdup("tool");
-			if (!default_ps.pmu_glob) {
-				ret = -1;
-				goto out;
+			for (size_t j = 0; j < ARRAY_SIZE(sw_globs); j++) {
+				default_ps.pmu_glob = strdup(sw_globs[j]);
+				if (!default_ps.pmu_glob) {
+					ret = -1;
+					goto out;
+				}
+				perf_pmus__print_pmu_events(&print_cb, ps);
+				zfree(&default_ps.pmu_glob);
 			}
-			perf_pmus__print_pmu_events(&print_cb, ps);
-			zfree(&default_ps.pmu_glob);
 			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "cache") == 0 ||
 			 strcmp(argv[i], "hwcache") == 0)
@@ -679,8 +680,6 @@ int cmd_list(int argc, const char **argv)
 			default_ps.event_glob = s;
 			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
 					event_symbols_hw, PERF_COUNT_HW_MAX);
-			print_symbol_events(&print_cb, ps, PERF_TYPE_SOFTWARE,
-					event_symbols_sw, PERF_COUNT_SW_MAX);
 			print_hwcache_events(&print_cb, ps);
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			print_tracepoint_events(&print_cb, ps);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a59ae5ca0f89..1ae481c9802b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -84,57 +84,6 @@ const struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	},
 };
 
-const struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
-	[PERF_COUNT_SW_CPU_CLOCK] = {
-		.symbol = "cpu-clock",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_TASK_CLOCK] = {
-		.symbol = "task-clock",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_PAGE_FAULTS] = {
-		.symbol = "page-faults",
-		.alias  = "faults",
-	},
-	[PERF_COUNT_SW_CONTEXT_SWITCHES] = {
-		.symbol = "context-switches",
-		.alias  = "cs",
-	},
-	[PERF_COUNT_SW_CPU_MIGRATIONS] = {
-		.symbol = "cpu-migrations",
-		.alias  = "migrations",
-	},
-	[PERF_COUNT_SW_PAGE_FAULTS_MIN] = {
-		.symbol = "minor-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_PAGE_FAULTS_MAJ] = {
-		.symbol = "major-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_ALIGNMENT_FAULTS] = {
-		.symbol = "alignment-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_EMULATION_FAULTS] = {
-		.symbol = "emulation-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_DUMMY] = {
-		.symbol = "dummy",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_BPF_OUTPUT] = {
-		.symbol = "bpf-output",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_CGROUP_SWITCHES] = {
-		.symbol = "cgroup-switches",
-		.alias  = "",
-	},
-};
-
 static const char *const event_types[] = {
 	[PERF_TYPE_HARDWARE]	= "hardware",
 	[PERF_TYPE_SOFTWARE]	= "software",
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b47bf2810112..62dc7202e3ba 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -264,7 +264,6 @@ struct event_symbol {
 	const char	*alias;
 };
 extern const struct event_symbol event_symbols_hw[];
-extern const struct event_symbol event_symbols_sw[];
 
 char *parse_events_formats_error_string(char *additional_terms);
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4af7b9c1f44d..2034590eb789 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -117,12 +117,12 @@ do {								\
 	yyless(0);						\
 } while (0)
 
-static int sym(yyscan_t scanner, int type, int config)
+static int sym(yyscan_t scanner, int config)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 
-	yylval->num = (type << 16) + config;
-	return type == PERF_TYPE_HARDWARE ? PE_VALUE_SYM_HW : PE_VALUE_SYM_SW;
+	yylval->num = config;
+	return PE_VALUE_SYM_HW;
 }
 
 static int term(yyscan_t scanner, enum parse_events__term_type type)
@@ -391,28 +391,16 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 <<EOF>>			{ BEGIN(INITIAL); }
 }
 
-cpu-cycles|cycles				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES); }
-stalled-cycles-frontend|idle-cycles-frontend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
-stalled-cycles-backend|idle-cycles-backend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
-instructions					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS); }
-cache-references				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_REFERENCES); }
-cache-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_MISSES); }
-branch-instructions|branches			{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
-branch-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_MISSES); }
-bus-cycles					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BUS_CYCLES); }
-ref-cycles					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_REF_CPU_CYCLES); }
-cpu-clock					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_CLOCK); }
-task-clock					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_TASK_CLOCK); }
-page-faults|faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS); }
-minor-faults					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MIN); }
-major-faults					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
-context-switches|cs				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CONTEXT_SWITCHES); }
-cpu-migrations|migrations			{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_MIGRATIONS); }
-alignment-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
-emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
-dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
-bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
-cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
+cpu-cycles|cycles				{ return sym(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
+stalled-cycles-frontend|idle-cycles-frontend	{ return sym(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
+stalled-cycles-backend|idle-cycles-backend	{ return sym(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
+instructions					{ return sym(yyscanner, PERF_COUNT_HW_INSTRUCTIONS); }
+cache-references				{ return sym(yyscanner, PERF_COUNT_HW_CACHE_REFERENCES); }
+cache-misses					{ return sym(yyscanner, PERF_COUNT_HW_CACHE_MISSES); }
+branch-instructions|branches			{ return sym(yyscanner, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
+branch-misses					{ return sym(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
+bus-cycles					{ return sym(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
+ref-cycles					{ return sym(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
 
 {lc_type}			{ return str(yyscanner, PE_LEGACY_CACHE); }
 {lc_type}-{lc_op_result}	{ return str(yyscanner, PE_LEGACY_CACHE); }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f888cbb076d6..a2361c0040d7 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -55,7 +55,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %}
 
 %token PE_START_EVENTS PE_START_TERMS
-%token PE_VALUE PE_VALUE_SYM_HW PE_VALUE_SYM_SW PE_TERM
+%token PE_VALUE PE_VALUE_SYM_HW PE_TERM
 %token PE_EVENT_NAME
 %token PE_RAW PE_NAME
 %token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
@@ -66,10 +66,8 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_TERM_HW
 %type <num> PE_VALUE
 %type <num> PE_VALUE_SYM_HW
-%type <num> PE_VALUE_SYM_SW
 %type <mod> PE_MODIFIER_EVENT
 %type <term_type> PE_TERM
-%type <num> value_sym
 %type <str> PE_RAW
 %type <str> PE_NAME
 %type <str> PE_LEGACY_CACHE
@@ -306,24 +304,19 @@ PE_NAME sep_dc
 	$$ = list;
 }
 
-value_sym:
-PE_VALUE_SYM_HW
-|
-PE_VALUE_SYM_SW
-
 event_legacy_symbol:
-value_sym '/' event_config '/'
+PE_VALUE_SYM_HW '/' event_config '/'
 {
 	struct list_head *list;
-	int type = $1 >> 16;
-	int config = $1 & 255;
 	int err;
-	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
-	err = parse_events_add_numeric(_parse_state, list, type, config, $3, wildcard);
+	err = parse_events_add_numeric(_parse_state, list,
+				       PERF_TYPE_HARDWARE, $1,
+				       $3,
+				       /*wildcard=*/true);
 	parse_events_terms__delete($3);
 	if (err) {
 		free_list_evsel(list);
@@ -332,18 +325,18 @@ value_sym '/' event_config '/'
 	$$ = list;
 }
 |
-value_sym sep_slash_slash_dc
+PE_VALUE_SYM_HW sep_slash_slash_dc
 {
 	struct list_head *list;
-	int type = $1 >> 16;
-	int config = $1 & 255;
-	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 	int err;
 
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
-	err = parse_events_add_numeric(_parse_state, list, type, config, /*head_config=*/NULL, wildcard);
+	err = parse_events_add_numeric(_parse_state, list,
+				       PERF_TYPE_HARDWARE, $1,
+				       /*head_config=*/NULL,
+				       /*wildcard=*/true);
 	if (err)
 		PE_ABORT(err);
 	$$ = list;
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index e233bacaa641..c1a8708b55ab 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -521,8 +521,6 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
 			event_symbols_hw, PERF_COUNT_HW_MAX);
-	print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
-			event_symbols_sw, PERF_COUNT_SW_MAX);
 
 	print_hwcache_events(print_cb, print_state);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


