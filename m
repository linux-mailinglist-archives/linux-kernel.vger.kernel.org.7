Return-Path: <linux-kernel+bounces-815772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C13AEB56B01
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 243F54E1120
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195B52DEA7B;
	Sun, 14 Sep 2025 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TQaJkoSz"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4180A937
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873490; cv=none; b=AK4CTTZfQuZYb7rVTdkXpjaRMH82+aYSLwnXIiyBvwVQZI95MOXCffcorQlXd1cLvi57KTVwhLJcbcvAvzkiGvvawkjEoCVUuiXWwpzylFwAaGuh5deFAK+AtGmrs6ClxT3Lrq7VnBWc7xzGgIdkhwXC/fb5Oc9x531lCQ/kNzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873490; c=relaxed/simple;
	bh=2Fp9K5lRnDjeXfm0j58FOONo1oDEHRgY3uTpc8+ViFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gOSmhi51Nt3SgrKL2bYdIm1UqRJNndclaD7M6jaSOcUpqfgHOMgQuPLpxy2aWGSvtA1EQEA8O7v3MZrrRsTrzMeu85LBNdKVODuaV68pAUX6N053FbnZorQmdzWHH9ICg3T0Fb3SIlBkDeifEDKVEBlp9Ryd7TY5TZrz/NCbBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TQaJkoSz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458345f5dso41995335ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873488; x=1758478288; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUmW2o43VrQ3eloQIzto2DPXPSx8Xkzk5tS2vCBP2n4=;
        b=TQaJkoSzjg1BARaX30HyNo+cgtt9lJQ/e193pkZ4bVyqGujdC7KG1YKiM/CXJnQPrX
         Fz9rtQTfkz9DEElQutv89OlUyDwpvmnKLcUljqhQ3wBuq+Hm10c+PsUxM0fCYQD+UboR
         S4cQwT0wf22jBzgZ9k7esnQ7UCfMuVR5Ts4cneaJJjzAsIbuduYS1i5kfb3nv6vLU61S
         EZ9sj5MKYt1qdI7u1/WgdTF+HvARevDRBRXpmIcIcpUsUe49yxrue++WgybQr4KdWufr
         q99yZc99mMIpIDFdgCT3hiLG97fEogafPV8c5InS+5/OzupHdw+xjJzdlrLcV1FA/Hai
         oVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873488; x=1758478288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUmW2o43VrQ3eloQIzto2DPXPSx8Xkzk5tS2vCBP2n4=;
        b=kpAYD1kNfE2mWAsZTdTlemAS+qmb/jqxeD83k+zkwKJEXNKBINgm/FbcLa+9gfUEu3
         F35d034P7LFxzOwJqbXEFGgBfwF7bBb9Wr06+fMhTZ2625N7V6jllT5q2hASmJXXrYLQ
         HNyJn9+vGXFKTUs/lVefpYQVT2g3tQFcjPFl0sg4xb/Z9GTpNj9G05hF92mo+495oJvN
         dBiTQUsVj7kRu5qx+qy3phAgRHP7+M5QYWxTk8P1ZrwmAN/2Xp6ZwtK2N9HZm03BO9cx
         yAKEsQuWQXu+wIFpPc7fGAlxromjKlR6A5QK6w8C1WT6A6Hz7SV6L5FfX4enfQrgKVti
         qNFg==
X-Forwarded-Encrypted: i=1; AJvYcCXmzL6auNjba8NKqFw7exz1dCRqN8fa0oqPQ09+ogDfP0Kw+3vA/cVBNtOWcYXU5lY/ujynnqJ/VRzSwzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8c0yJZCOB6h9bKcLmoBqVAqJdWhaYQ9OOBBPOafBNBxDOuDe8
	32c1xACdUZ7uVvX0M1pFnA+1+pCACA/qN2mPVj/VTxUlNxw/4cZ8LV1tK7k2nVjjEr5A3nf0IkV
	hZhkFJ8mGmA==
X-Google-Smtp-Source: AGHT+IGpirfpgH4JfpMeQ4uvPzKzfmIjVCurGcnr9tA2KPKwbXILzZn15fsZUyemFtryTwSn4O0XedmBpNkY
X-Received: from pji13.prod.google.com ([2002:a17:90b:3fcd:b0:32e:3ff6:9d7a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1d2:b0:264:f714:8dce
 with SMTP id d9443c01a7336-264f714a550mr28629335ad.36.1757873488177; Sun, 14
 Sep 2025 11:11:28 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:01 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-2-irogers@google.com>
Subject: [PATCH v4 01/21] perf parse-events: Fix legacy cache events if event
 is duplicated in a PMU
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
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The term list when adding an event to a PMU is expected to have the
event name for the alias lookup. Also, set found_supported so that
-EINVAL isn't returned.

Fixes: 62593394f66a ("perf parse-events: Legacy cache names on all
PMUs and lower priority")

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/parse-events.c | 28 +++++++++++++++++++++++++++-
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y |  2 +-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8282ddf68b98..c219e3ffae65 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -465,8 +465,10 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms)
+			   struct parse_events_terms *parsed_terms,
+			   void *loc_)
 {
+	YYLTYPE *loc = loc_;
 	struct perf_pmu *pmu = NULL;
 	bool found_supported = false;
 	const char *config_name = get_config_name(parsed_terms);
@@ -487,12 +489,36 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			 * The PMU has the event so add as not a legacy cache
 			 * event.
 			 */
+			struct parse_events_terms temp_terms;
+			struct parse_events_term *term;
+			char *config = strdup(name);
+
+			if (!config)
+				goto out_err;
+
+			parse_events_terms__init(&temp_terms);
+			if (!parsed_terms)
+				parsed_terms = &temp_terms;
+
+			if (parse_events_term__num(&term,
+						    PARSE_EVENTS__TERM_TYPE_USER,
+						    config, /*num=*/1, /*novalue=*/true,
+						    loc, /*loc_val=*/NULL) < 0) {
+				zfree(&config);
+				goto out_err;
+			}
+			list_add(&term->list, &parsed_terms->terms);
+
 			ret = parse_events_add_pmu(parse_state, list, pmu,
 						   parsed_terms,
 						   first_wildcard_match,
 						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
+			list_del_init(&term->list);
+			parse_events_term__delete(term);
+			parse_events_terms__exit(&temp_terms);
 			if (ret)
 				goto out_err;
+			found_supported = true;
 			if (first_wildcard_match == NULL)
 				first_wildcard_match =
 					container_of(list->prev, struct evsel, core.node);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 62dc7202e3ba..c498d896badf 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -235,7 +235,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     bool wildcard);
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms);
+			   struct parse_events_terms *parsed_terms,
+			   void *loc);
 int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index a2361c0040d7..ced26c549c33 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -353,7 +353,7 @@ PE_LEGACY_CACHE opt_event_config
 	if (!list)
 		YYNOMEM;
 
-	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2, &@1);
 
 	parse_events_terms__delete($2);
 	free($1);
-- 
2.51.0.384.g4c02a37b29-goog


