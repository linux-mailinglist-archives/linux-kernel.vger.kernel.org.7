Return-Path: <linux-kernel+bounces-790723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF4B3AC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9151C876B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA333A010;
	Thu, 28 Aug 2025 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GwHhH6+k"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F492E22AC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414806; cv=none; b=E5w8cKYQBKyrrYE9Oc9LjyKqeYe6n+QwSNONvQo8TBYw2dgvZ9KP/K2o1WouI4Om2dLbyO/gy+kFDOg66IqchLJo68SWRoA5AE02+AoQqbTVUNliWlE1os0WHSdMIUUJM7xEc+g4pep9JSUcXEqprrSXQxkhRcNcZ7Ote2RCyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414806; c=relaxed/simple;
	bh=5fGPF8a37Bc63SFyq54LzgZmq+IauFOX6mSRlHHajJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Gp522XiKIzzzqnKgCvy2YGwt4KWKaSjpeTW0aV+WlaT/zHNO+teA4tgLwUtnGkSx5QDUQ7AL/UfuhceG81lSbMhD8mwJCYmWEPU15uXrTHffkNsp+rITKapNXeKt/6haokuiBSw/LZV+VknaZF24kfsc1IHH7N4lDD6Hy02eloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GwHhH6+k; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246f49067bdso14133605ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414805; x=1757019605; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxmiEV+n+EnZWcWzOO8DsS1QQLLjGALvbroF38HXqIY=;
        b=GwHhH6+kfzNLbC3n6KicMco1s9NONAQjjyuqrmT2MPFt+sO3Ofz8bQu6TYmGAYVz5H
         yc9v8CC/563bQlw/Emxf9d6jiIA5ym0M/MhbHNebdTfqXl18iy+n16m3g67RPa+WSyeu
         2b6rxwAkUtVt9Y2wgNGVGBaOAxXCBkoSZeJwoDzCTUdxWT9HXl6p7MInOjxv47wyPUBG
         19ZGi7FyxJ5rv5oQlI0YRZLM03PF3HtOP1Un+75MX1+i7y/LUcOMREBWRCA9xhW1+SNB
         SLkHJ6fMI4ZTfObq7foBN8x5XM6iN3b/D2oA7i4splvmrlXH2QCnRElIImLX2CCH+NLL
         e6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414805; x=1757019605;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxmiEV+n+EnZWcWzOO8DsS1QQLLjGALvbroF38HXqIY=;
        b=xBWZUsadYSoYbI1PgXElwrM/drDjPsKE/HTgsHhXX40JI6z59DCxvmuvxMzuGk/lHT
         vBZgjNgkLQn0hxmJY/bQoIGBM0cqZAyDnf5XtV75uZ48zTG5FkhZIGsWZK2gmmiUWyQK
         1wsl4rEpSPspFBFY1OuhuBavsYdlROOCUZZYVuTmLMkAfzpA+p+IFzxhbOqRvzWioakZ
         pPqxhzKYk9QFNAls9zy8Sj9kM8qCtR1q2Pb65O4NYLDkAb8Wg9pmot1y3pvuOb36JWa7
         LEEhV62wWWwODGs7hcMxIQ8+eGuC93jb+/UH5SakGDCXJqSw1utocGgzc8ruSEWP0nwL
         BmTw==
X-Forwarded-Encrypted: i=1; AJvYcCXvZhNMKexHrcse4gle4ho9+kNm0ThbhnvyIrYZsCutgQPI6uijxwyfSOsOesLzzq4MEEELFUoookA91fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2npi68MYuTpi8UYVoTZLj/SPyuV/Fa1zCCL+/HktzTmYejaVO
	hN2BcwHPLZ4AxKkM22vO1QwiO8LN2Jckagqg1hCz6ll93xUEl3TTCmTcCe9blmRYn/+oleco/x7
	4uoybboRbCA==
X-Google-Smtp-Source: AGHT+IEh5wwCa4kjo3hh2NHGYV1Od3wnRgVSmp2S3X1/VNFxNw2rCvan9mH9iQrug7WOwaH7vLAhfKoXyzOR
X-Received: from pjbhl14.prod.google.com ([2002:a17:90b:134e:b0:327:7322:3ac0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2281:b0:245:f777:d4b3
 with SMTP id d9443c01a7336-2462ef03858mr275836685ad.33.1756414804555; Thu, 28
 Aug 2025 14:00:04 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:21 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-7-irogers@google.com>
Subject: [PATCH v3 06/15] perf parse-events: Remove unused FILE input argument
 to scanner
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Now the events file isn't directly parsed from a FILE but stored in a
string prior to parsing, remove the FILE argument to the associated
scanner functions as they only ever pass NULL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-pt.c |  2 +-
 tools/perf/tests/parse-events.c     |  2 +-
 tools/perf/tests/pmu.c              |  3 +--
 tools/perf/util/parse-events.c      | 18 ++++++------------
 tools/perf/util/parse-events.h      |  3 +--
 tools/perf/util/pmu.c               |  6 +++---
 6 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index add33cb5d1da..2d7c0dec86b0 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -72,7 +72,7 @@ static int intel_pt_parse_terms_with_default(const struct perf_pmu *pmu,
 	int err;
 
 	parse_events_terms__init(&terms);
-	err = parse_events_terms(&terms, str, /*input=*/ NULL);
+	err = parse_events_terms(&terms, str);
 	if (err)
 		goto out_free;
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index bb8004397650..4e55b0d295bd 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2556,7 +2556,7 @@ static int test_term(const struct terms_test *t)
 
 
 	parse_events_terms__init(&terms);
-	ret = parse_events_terms(&terms, t->str, /*input=*/ NULL);
+	ret = parse_events_terms(&terms, t->str);
 	if (ret) {
 		pr_debug("failed to parse terms '%s', err %d\n",
 			 t->str , ret);
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 4a9f8e090cf4..cbded2c6faa4 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -169,8 +169,7 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
 	parse_events_terms__init(&terms);
 	if (parse_events_terms(&terms,
 				"krava01=15,krava02=170,krava03=1,krava11=27,krava12=1,"
-				"krava13=2,krava21=119,krava22=11,krava23=2",
-				NULL)) {
+				"krava13=2,krava21=119,krava22=11,krava23=2")) {
 		pr_err("Term parsing failed\n");
 		goto err_out;
 	}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cc677d9b2d5a..37aa392ddaf2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1956,7 +1956,6 @@ int parse_events__set_default_name(struct list_head *list, char *name)
 }
 
 static int parse_events__scanner(const char *str,
-				 FILE *input,
 				 struct parse_events_state *parse_state)
 {
 	YY_BUFFER_STATE buffer;
@@ -1967,10 +1966,7 @@ static int parse_events__scanner(const char *str,
 	if (ret)
 		return ret;
 
-	if (str)
-		buffer = parse_events__scan_string(str, scanner);
-	else
-	        parse_events_set_in(input, scanner);
+	buffer = parse_events__scan_string(str, scanner);
 
 #ifdef PARSER_DEBUG
 	parse_events_debug = 1;
@@ -1978,10 +1974,8 @@ static int parse_events__scanner(const char *str,
 #endif
 	ret = parse_events_parse(parse_state, scanner);
 
-	if (str) {
-		parse_events__flush_buffer(buffer, scanner);
-		parse_events__delete_buffer(buffer, scanner);
-	}
+	parse_events__flush_buffer(buffer, scanner);
+	parse_events__delete_buffer(buffer, scanner);
 	parse_events_lex_destroy(scanner);
 	return ret;
 }
@@ -1989,7 +1983,7 @@ static int parse_events__scanner(const char *str,
 /*
  * parse event config string, return a list of event terms.
  */
-int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *input)
+int parse_events_terms(struct parse_events_terms *terms, const char *str)
 {
 	struct parse_events_state parse_state = {
 		.terms  = NULL,
@@ -1997,7 +1991,7 @@ int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *
 	};
 	int ret;
 
-	ret = parse_events__scanner(str, input, &parse_state);
+	ret = parse_events__scanner(str, &parse_state);
 	if (!ret)
 		list_splice(&parse_state.terms->terms, &terms->terms);
 
@@ -2302,7 +2296,7 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	};
 	int ret, ret2;
 
-	ret = parse_events__scanner(str, /*input=*/ NULL, &parse_state);
+	ret = parse_events__scanner(str, &parse_state);
 
 	if (!ret && list_empty(&parse_state.list)) {
 		WARN_ONCE(true, "WARNING: event parser found nothing\n");
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 34a5ec21d5e8..660303e591ad 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -9,7 +9,6 @@
 #include <stdbool.h>
 #include <linux/types.h>
 #include <linux/perf_event.h>
-#include <stdio.h>
 #include <string.h>
 #include <sys/types.h>
 
@@ -198,7 +197,7 @@ void parse_events_term__delete(struct parse_events_term *term);
 void parse_events_terms__delete(struct parse_events_terms *terms);
 void parse_events_terms__init(struct parse_events_terms *terms);
 void parse_events_terms__exit(struct parse_events_terms *terms);
-int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *input);
+int parse_events_terms(struct parse_events_terms *terms, const char *str);
 
 struct parse_events_modifier {
 	u8 precise;	/* Number of repeated 'p' for precision. */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ddcd4918832d..b44dfe4c73fc 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -777,7 +777,7 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms
 	int ret;
 
 	parse_events_terms__init(&alias_terms);
-	ret = parse_events_terms(&alias_terms, alias->terms, /*input=*/NULL);
+	ret = parse_events_terms(&alias_terms, alias->terms);
 	if (ret) {
 		pr_err("Cannot parse '%s' terms '%s': %d\n",
 		       alias->name, alias->terms, ret);
@@ -2045,7 +2045,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 	}
 
 	parse_events_terms__init(&terms);
-	ret = parse_events_terms(&terms, alias->terms, /*input=*/NULL);
+	ret = parse_events_terms(&terms, alias->terms);
 	if (ret) {
 		pr_err("Failure to parse '%s' terms '%s': %d\n",
 			alias->name, alias->terms, ret);
@@ -2602,7 +2602,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 		int ret;
 
 		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms, /*input=*/NULL);
+		ret = parse_events_terms(&terms, event->terms);
 		if (ret) {
 			pr_debug("Failed to parse '%s' terms '%s': %d\n",
 				event->name, event->terms, ret);
-- 
2.51.0.318.gd7df087d1a-goog


