Return-Path: <linux-kernel+bounces-829726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F508B97B71
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF5E4C3FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA83112D2;
	Tue, 23 Sep 2025 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTSysUiC"
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581EF30FF10
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666805; cv=none; b=lFgDjrMMpkxSqTQfh36YdfMBAOWbl4UuQt4bzqVzTBQUY1gGEvboFc6GPHenKRamNPMGGxmiESYQ6FL8CBKfC2GhDW/4D07byBCH5xNzkunq8zL0XAwOH4mCfzZmlywzOcSu/+VOY2KM9o8T5bWsrUIF+9EEaVimv5aU5XHBk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666805; c=relaxed/simple;
	bh=L+pT+AcEatKTFNx03XP2+UW4uPwki5/m42f47BIrFO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YlzCUOZPqxljdHai+KjYqE/skt8MJPpt8I9KrYAM2kmIFfe5ArUafSS2Zsza51jT3hDFgtRBhIeL1y7ewbSWrym+CrY4Wp6sYZPWWBYaUsJIIkpiUxsDj3RJiYJiEaneiKySRvDSxOvYVLsovxvidgWUqps3zKg8l63pjPpH6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTSysUiC; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-43f3a0991f8so531240b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666802; x=1759271602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yU89r1Lif32XcTKVN3dVRhkhOuKCxo5EjEhuE/dx2oE=;
        b=kTSysUiCUz36DSQHH25yDHyuPCdLRtnQM305pC07kOK5PMCtBZFXIUVdy2CzJypV0i
         dOeTnluWEZaNB7NkfMZTyzMSBE8BdfzcNQ8QodCxXncQUeB7Dn9TFObqFaWXtBzhnB+T
         7T+9SVHR27ZZQMr+nunwGIaHwaeN0WDoGi3gdHfhdeW2X6JwML/rYS5dTM1Z5NGmdA/b
         PqFNt74dc/0plMLXnMJb3tzSl+IZe0amrB5lhDiQOaSu5PfxPo0oiRBUXbjAjNWWG6Df
         OgphXS8KBUJV/0sHqAWfRBhWO8xv1NqUvkNP8KdB5Owly9fMEAMINqSaWu974SgYCTM3
         KBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666802; x=1759271602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yU89r1Lif32XcTKVN3dVRhkhOuKCxo5EjEhuE/dx2oE=;
        b=m2uHK/G54ZLSjGappjyn3gkwM2LHMSZGmMvw+Q6CqU6xafdvwYr+WH6rkRUa8XSH16
         QyT80/z1h80oIQVpl2nwJdHk48amVaMTQUaY31um52ZuEiFge/e6uH2XC9F3k66EKu00
         ctYshNPIJ9q0F9ETdl384ldMnVDQ0mEKMZHbmRYoDgVoKtXak/qJA6ri+YB1sEjSZOBq
         RV3hcVIaY1JAshLmR3eDqveQuHB3EILtdhmZAFrH7hz54OBnNixHKE+ss3nZ1D3jesqc
         hFkY6nf8Cf7t6dhAEg+bIwGdIFd4Sy/kl4Zdx2bNN6owGQ0vneZxH3suGKbGNZmrwivU
         tYzg==
X-Forwarded-Encrypted: i=1; AJvYcCWmmqmsggn7J9K0xFwRSqAHB5bCIQ21lixwxMAuqPFR+TV3USTwzj9Au7GCgxQ23U20WiYQLVnwSy3aEcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwITqnpcszTrNhxL2lOu6XZDaN1lHcGRG3l4ufKOU09INZvU3HT
	dBsyxFOYSUdc98PX7thHLslCJNkaC5B6FlufQYt4RbyY0YHlSUcYb/KjMl1xs6OJeTjzBxWBbET
	xKTMFWvH8AA==
X-Google-Smtp-Source: AGHT+IHatC+m8sNoA4VhHyNYOrsySbTs5U9ed+8EmGTgAbuAHLBJcReCTXKuKmqfrsfIdbQj0PTCupxh4v57
X-Received: from oabmp7.prod.google.com ([2002:a05:6870:e07:b0:33f:acc9:ca36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1886:b0:43f:7f5:4981
 with SMTP id 5614622812f47-43f2d312c3cmr2528195b6e.5.1758666802334; Tue, 23
 Sep 2025 15:33:22 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:46 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-3-irogers@google.com>
Subject: [PATCH v6 02/28] perf parse-events: Fix legacy cache events if event
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
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The term list when adding an event to a PMU is expected to have the
event name for the alias lookup. Also, set found_supported so that
-EINVAL isn't returned.

Fixes: 62593394f66a ("perf parse-events: Legacy cache names on all
PMUs and lower priority")

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 28 +++++++++++++++++++++++++++-
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y |  2 +-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 452f12191f6e..d5675471afc5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -475,8 +475,10 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
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
@@ -497,12 +499,36 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
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
index a5c5fc39fd6f..be8d2ac1e4e4 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -236,7 +236,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
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
2.51.0.534.gc79095c0ca-goog


