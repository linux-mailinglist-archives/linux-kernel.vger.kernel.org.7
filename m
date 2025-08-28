Return-Path: <linux-kernel+bounces-790731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC513B3AC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4EA1C8730F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D369135084A;
	Thu, 28 Aug 2025 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1246Wa2L"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD234AB14
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414823; cv=none; b=sCEAMBPIa0exD/xOafoYQXWOsgpzgIGqIOHh0hkBINx770nc/SR3WVMYflNtitYCbu3p3klf3VkCSeXcJRPi4d2WmBCI/Ox3k9jyuN70bJQw3q8Xvg11f0STTyMtInfQbHvu2uZTe1o9Sgecjfvk25gwbaqEcBISUszIwY/JUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414823; c=relaxed/simple;
	bh=Pk7DpN8xsKdAvty0u/azfBO8zaFp7DfdslW1H1oSXOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lCkVaH4as4Yw/X7zBTtTSAsMYoFOsWiQFo51gHZCD6jnpLSCHTQ6fpeASmyyPADY3woVzsZFc/+SS9vMESDW+8jC7o1k7Jfb07SE1jpj/5j6M0y9AZaUVEyZAQq/2uXzwJOnfugbfg/TU/748gP1tzPg85qIvyLGZZVSLfIv2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1246Wa2L; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3276575ae5eso1494736a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414819; x=1757019619; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ixYR/EJENoJDeRWHEeNlXPxZRQHstYLdpFO5WomhWE=;
        b=1246Wa2LbbC/a6FH5Jrj3EEZ3LCi5dIytCEY1GfkH09kKNxW9bMhn6JFtITjIB17Vf
         YuKP3ScTlroVz5jS2qzm7bY4NcAO5qs5VMIpm78PP9K5MBAr/NbrhxKfU4H2fjeK0IMK
         HxIY5SB3VEmicyxxy+Neg9uUR42bCUbmLRxEOiHAlTWxnXp5bNWgxJd8GlzA6mkgOsKI
         An4rXTzYXf5zqDyTdU+m/t3JGaSJ7baAGNkoBbiJvlBDkHOwFjWsRdxLVGQfc67Sp1pK
         gLVmmx2QpBqCNzxoqjqPjMJcjApmMv/FWDeuctVyvkW3jsCx795kny8fjfVQqpoAPr8k
         xYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414819; x=1757019619;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ixYR/EJENoJDeRWHEeNlXPxZRQHstYLdpFO5WomhWE=;
        b=R6QSgxxwPzS+K7EJSmXaf0fo0HVojE4Eju0PLHA3kYrXjOAarkZWU3uIkHXZRAXi6N
         w2pTa+Izl5766woc5Nyfgvscrdmrat4XksyP8LjRsTbTUML7x6k/JsiqdT94ZT2RyLw5
         qbMUMhEwV7ox9rOKLrjGoF1hyYBJcHoD7F+M5IEdVfh9MZ9uGykQJmu4/rUoivUCg93k
         vjE6Y2JCGOA7pwm9ImifWWcMkudxoOhkpIouWsn4L5RWRjvTARzgqj/JsI3ojOYGrRLI
         cL2DqKC0V5vYRnm7JTMKbatwCsYQdgw3aVRQbGJpvKlyiW1vcUpiOWUVeocZcLwgwO0+
         YxCw==
X-Forwarded-Encrypted: i=1; AJvYcCXIFxDo4381xkIrFpE9LFi5X2DVpShzx9ib2d/VOJY08mGV35UyqNzqAJVQ9zvfgwFXtKkEDxCWOpOYAV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/ChiDzKziTldT+JskFtzaeIXbIoCkIXCHYfvaGxGxM1rw1SN
	6gny6jL4+aaraZpiFJirUQ0nauo3oT3Tx6KSdWm2h8lSzhCCqCR3bRt1LEA1KwVVnXxRHWK4lDI
	deJdZv657Ww==
X-Google-Smtp-Source: AGHT+IGqWWwATh3/W7sscyZOuLSMRFjv2mAZK+h1RVFTm2liAwMjIrJe3rKbMWMusNfNdoBoEwdgiZhYS4CQ
X-Received: from pjbsv14.prod.google.com ([2002:a17:90b:538e:b0:321:c23e:5e41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b11:b0:325:42f8:d73f
 with SMTP id 98e67ed59e1d1-32542f8d954mr31050082a91.17.1756414819303; Thu, 28
 Aug 2025 14:00:19 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:29 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-15-irogers@google.com>
Subject: [PATCH v3 14/15] perf print-events: Remove print_symbol_events
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

Now legacy hardware events are in json there's no need for a specific
printing routine that previously served for both hardware and software
events. The associated event_symbols_hw is also removed. To support
the previous filtered version use an event glob of "legacy hardware"
which matches the topic of the json events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 18 +++++++----
 tools/perf/util/parse-events.c | 43 -------------------------
 tools/perf/util/parse-events.h |  1 -
 tools/perf/util/print-events.c | 57 ----------------------------------
 tools/perf/util/print-events.h |  3 --
 5 files changed, 12 insertions(+), 110 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index b6720ef3adf6..16400366f827 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -633,10 +633,18 @@ int cmd_list(int argc, const char **argv)
 			zfree(&default_ps.pmu_glob);
 			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "hw") == 0 ||
-			 strcmp(argv[i], "hardware") == 0)
-			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
-					event_symbols_hw, PERF_COUNT_HW_MAX);
-		else if (strcmp(argv[i], "sw") == 0 ||
+			   strcmp(argv[i], "hardware") == 0) {
+			char *old_event_glob = default_ps.event_glob;
+
+			default_ps.event_glob = strdup("legacy hardware");
+			if (!default_ps.event_glob) {
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.event_glob);
+			default_ps.event_glob = old_event_glob;
+		} else if (strcmp(argv[i], "sw") == 0 ||
 			 strcmp(argv[i], "software") == 0) {
 			char *old_pmu_glob = default_ps.pmu_glob;
 			static const char * const sw_globs[] = { "software", "tool" };
@@ -714,8 +722,6 @@ int cmd_list(int argc, const char **argv)
 				continue;
 			}
 			default_ps.event_glob = s;
-			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
-					event_symbols_hw, PERF_COUNT_HW_MAX);
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index be3e86e7b157..72cc59cfc46d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -42,49 +42,6 @@ static int parse_events_terms__copy(const struct parse_events_terms *src,
 				    struct parse_events_terms *dest);
 static int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb);
 
-const struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
-	[PERF_COUNT_HW_CPU_CYCLES] = {
-		.symbol = "cpu-cycles",
-		.alias  = "cycles",
-	},
-	[PERF_COUNT_HW_INSTRUCTIONS] = {
-		.symbol = "instructions",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_CACHE_REFERENCES] = {
-		.symbol = "cache-references",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_CACHE_MISSES] = {
-		.symbol = "cache-misses",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = {
-		.symbol = "branch-instructions",
-		.alias  = "branches",
-	},
-	[PERF_COUNT_HW_BRANCH_MISSES] = {
-		.symbol = "branch-misses",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_BUS_CYCLES] = {
-		.symbol = "bus-cycles",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = {
-		.symbol = "stalled-cycles-frontend",
-		.alias  = "idle-cycles-frontend",
-	},
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = {
-		.symbol = "stalled-cycles-backend",
-		.alias  = "idle-cycles-backend",
-	},
-	[PERF_COUNT_HW_REF_CPU_CYCLES] = {
-		.symbol = "ref-cycles",
-		.alias  = "",
-	},
-};
-
 static const char *const event_types[] = {
 	[PERF_TYPE_HARDWARE]	= "hardware",
 	[PERF_TYPE_SOFTWARE]	= "software",
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index a64f0741cb4b..32bde974c9f5 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -264,7 +264,6 @@ struct event_symbol {
 	const char	*symbol;
 	const char	*alias;
 };
-extern const struct event_symbol event_symbols_hw[];
 
 char *parse_events_formats_error_string(char *additional_terms);
 
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 91a5d9c7882b..8f3ed83853a9 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -186,60 +186,6 @@ bool is_event_supported(u8 type, u64 config)
 	return ret;
 }
 
-void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
-			 unsigned int type, const struct event_symbol *syms,
-			 unsigned int max)
-{
-	struct strlist *evt_name_list = strlist__new(NULL, NULL);
-	struct str_node *nd;
-
-	if (!evt_name_list) {
-		pr_debug("Failed to allocate new strlist for symbol events\n");
-		return;
-	}
-	for (unsigned int i = 0; i < max; i++) {
-		/*
-		 * New attr.config still not supported here, the latest
-		 * example was PERF_COUNT_SW_CGROUP_SWITCHES
-		 */
-		if (syms[i].symbol == NULL)
-			continue;
-
-		if (!is_event_supported(type, i))
-			continue;
-
-		if (strlen(syms[i].alias)) {
-			char name[MAX_NAME_LEN];
-
-			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms[i].symbol, syms[i].alias);
-			strlist__add(evt_name_list, name);
-		} else
-			strlist__add(evt_name_list, syms[i].symbol);
-	}
-
-	strlist__for_each_entry(nd, evt_name_list) {
-		char *alias = strstr(nd->s, " OR ");
-
-		if (alias) {
-			*alias = '\0';
-			alias += 4;
-		}
-		print_cb->print_event(print_state,
-				/*topic=*/NULL,
-				/*pmu_name=*/NULL,
-				type,
-				nd->s,
-				alias,
-				/*scale_unit=*/NULL,
-				/*deprecated=*/false,
-				event_type_descriptors[type],
-				/*desc=*/NULL,
-				/*long_desc=*/NULL,
-				/*encoding_desc=*/NULL);
-	}
-	strlist__delete(evt_name_list);
-}
-
 /** struct mep - RB-tree node for building printing information. */
 struct mep {
 	/** nd - RB-tree element. */
@@ -378,9 +324,6 @@ void metricgroup__print(const struct print_callbacks *print_cb, void *print_stat
  */
 void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
-	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
-			event_symbols_hw, PERF_COUNT_HW_MAX);
-
 	perf_pmus__print_pmu_events(print_cb, print_state);
 
 	print_cb->print_event(print_state,
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 44e5dbd91400..eabba5d4a1fd 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -33,9 +33,6 @@ struct print_callbacks {
 /** Print all events, the default when no options are specified. */
 void print_events(const struct print_callbacks *print_cb, void *print_state);
 void print_sdt_events(const struct print_callbacks *print_cb, void *print_state);
-void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
-			 unsigned int type, const struct event_symbol *syms,
-			 unsigned int max);
 void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
 bool is_event_supported(u8 type, u64 config);
 
-- 
2.51.0.318.gd7df087d1a-goog


