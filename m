Return-Path: <linux-kernel+bounces-735980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40AFB0963A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D69169EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBAD253359;
	Thu, 17 Jul 2025 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psJkS3Wr"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2C248871
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786179; cv=none; b=hQezbbfpVnYyxmWd32L0jWDFbC5nDujmgcP4ctLdD+41yGtN6Ulc7T0qsDYMYAbFPm+DiEbiIy3JyDP37p5tnnXUGOdJSYVqVKMJoKp60v0sxTofA+kKpLy/hBQd9LQnDrSexveX/5bV4EA2z89/P2UfkbLJ+pAtuaa7VVlSTjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786179; c=relaxed/simple;
	bh=jEgvDggwtQddGz/4ZXMmANkYODrHYVg1OL8Si0VZ5M0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dHWsN+5BD3wTb3laZTSRNDZWhBI65g675DmObFutUb200CfjmfN7x3fmAItzXA9fYt0Q/MQLfvm4kn1yJoYdoAflUSt1vCAxUcxtvRxwF6ta72PrwH7UlhTmFBweBiR6X+4eFZ/5BR6raHD/1riyLDJoyZxioID8YDR5tO8IeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psJkS3Wr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23507382e64so13167685ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786177; x=1753390977; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbO2FaLlRAtP3MPRgVDa/ZaeF16Ze9Vrmjj4VaK1jxk=;
        b=psJkS3Wryl1ErenAxSbplOvQsC6lh3SH6/5AN20Y4Y0IICjvc9qn3om11IoVP8gkyb
         JIP82BHZac/C7OFpLUQ+ExYbhGqLUYHmtuu7MrleH45UIDlGJwTt2Rw510haqijBcnGD
         vHapfkTGn0lRgJMfStxO3jqodaRJQQW14qgbLkn4PWSKJLUYMWC/kOVoQTV3+2ot1a2C
         gsCEpm49mb+N/fTQfbeA1IzjUKv+4eeDejaAYVnpsOvdqT2JS9jR8+oQlioQbpCE1NSE
         oRwYWNNOFSiEAAuS9JkyrxGY+J6PKmu49dXrWPa3zwMrTk5YuYZYQvJEvC3JZnqltngS
         23IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786177; x=1753390977;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbO2FaLlRAtP3MPRgVDa/ZaeF16Ze9Vrmjj4VaK1jxk=;
        b=Ln3ngZW8ynpg3WLVE0C2DtFhlHn2cEWEWXj3EDnoBrs3JweE3DNXj3rIkquYwiyH5j
         qLZkNf1FVZiy/jmLh1/PcJJT0IMIQRvfRtnMzSwUdiBbMAnbw9GZi0rAY9H4ntl0omED
         79vnDogPtMJRX3Y5+NpkAEAVgaIfJdPnVeayIYZsX50EqigzAOFmQxO/B4FUw0LER7ep
         QL0VCBhjw8CC/5phTz/F02dlhdox2x71yrIqATb9Ba6XLQbnNwbx0VvTAEAZhNrRZj4W
         WMjPuZaKLTDGzWV7ZxPKPqbGuV7Nx+IbjN5Ll5qWxJwZWO0FqCprqTFDUZggLWl+FeaA
         tckQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfn0wTRwJSGZfrkQpA6c/VNA+S/eUxxbu1gsJWr3Yp29YveANxx7y2MPb0e8MQ/j6FYYSDg18Ott5lLdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9sCYeh1Rktnz4dsvbGXkyRk33ThEOxFIxndj4gEOOdYhDym+E
	7ZtR7tjEILV2P3WPk0A1S+MMYfyRV9LIChSdkNB2FPSC4iFbf41bS2pQvswqeXwUZfuEWusju04
	f/qn61I33UA==
X-Google-Smtp-Source: AGHT+IHFQ4p2NE4UN0zqFuYQHDWTlKps6FGN31gpRHaNHLnqvCbh3RD+oVb8CVeMEb78YINYoKWK4Hl9ss6o
X-Received: from pjbqd16.prod.google.com ([2002:a17:90b:3cd0:b0:31a:aa02:8c50])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:985:b0:231:c9bb:60fd
 with SMTP id d9443c01a7336-23e2572aademr99943495ad.33.1752786177110; Thu, 17
 Jul 2025 14:02:57 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:31 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-11-irogers@google.com>
Subject: [PATCH v2 10/12] perf parse-events: Minor __add_event refactoring
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rename cpu_list to user_cpus. If a PMU isn't given, find it early from
the perf_event_attr. Make the pmu_cpus more explicitly a copy from the
PMU (except when user_cpus are given). Derive the cpus from pmu_cpus
and user_cpus as appropriate. Handle strdup errors on name and
metric_id.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 69 +++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d506f9943506..bd2d831d5123 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -259,12 +259,12 @@ __add_event(struct list_head *list, int *idx,
 	    bool init_attr,
 	    const char *name, const char *metric_id, struct perf_pmu *pmu,
 	    struct list_head *config_terms, struct evsel *first_wildcard_match,
-	    struct perf_cpu_map *cpu_list, u64 alternate_hw_config)
+	    struct perf_cpu_map *user_cpus, u64 alternate_hw_config)
 {
 	struct evsel *evsel;
 	bool is_pmu_core;
-	struct perf_cpu_map *cpus;
-	bool has_cpu_list = !perf_cpu_map__is_empty(cpu_list);
+	struct perf_cpu_map *cpus, *pmu_cpus;
+	bool has_user_cpus = !perf_cpu_map__is_empty(user_cpus);
 
 	/*
 	 * Ensure the first_wildcard_match's PMU matches that of the new event
@@ -288,8 +288,6 @@ __add_event(struct list_head *list, int *idx,
 	}
 
 	if (pmu) {
-		is_pmu_core = pmu->is_core;
-		cpus = perf_cpu_map__get(has_cpu_list ? cpu_list : pmu->cpus);
 		perf_pmu__warn_invalid_formats(pmu);
 		if (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX) {
 			perf_pmu__warn_invalid_config(pmu, attr->config, name,
@@ -301,48 +299,77 @@ __add_event(struct list_head *list, int *idx,
 			perf_pmu__warn_invalid_config(pmu, attr->config3, name,
 						PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
 		}
+	}
+	/*
+	 * If a PMU wasn't given, such as for legacy events, find now that
+	 * warnings won't be generated.
+	 */
+	if (!pmu)
+		pmu = perf_pmus__find_by_attr(attr);
+
+	if (pmu) {
+		is_pmu_core = pmu->is_core;
+		pmu_cpus = perf_cpu_map__get(pmu->cpus);
 	} else {
 		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
 			       attr->type == PERF_TYPE_HW_CACHE);
-		if (has_cpu_list)
-			cpus = perf_cpu_map__get(cpu_list);
-		else
-			cpus = is_pmu_core ? cpu_map__online() : NULL;
+		pmu_cpus = is_pmu_core ? cpu_map__online() : NULL;
+	}
+
+	if (has_user_cpus) {
+		cpus = perf_cpu_map__get(user_cpus);
+		/* Existing behavior that pmu_cpus matches the given user ones. */
+		perf_cpu_map__put(pmu_cpus);
+		pmu_cpus = perf_cpu_map__get(user_cpus);
+	} else {
+		cpus = perf_cpu_map__get(pmu_cpus);
 	}
+
 	if (init_attr)
 		event_attr_init(attr);
 
 	evsel = evsel__new_idx(attr, *idx);
-	if (!evsel) {
-		perf_cpu_map__put(cpus);
-		return NULL;
+	if (!evsel)
+		goto out_err;
+
+	if (name) {
+		evsel->name = strdup(name);
+		if (!evsel->name)
+			goto out_err;
+	}
+
+	if (metric_id) {
+		evsel->metric_id = strdup(metric_id);
+		if (!evsel->metric_id)
+			goto out_err;
 	}
 
 	(*idx)++;
 	evsel->core.cpus = cpus;
-	evsel->core.pmu_cpus = perf_cpu_map__get(cpus);
+	evsel->core.pmu_cpus = pmu_cpus;
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->core.is_pmu_core = is_pmu_core;
 	evsel->pmu = pmu;
 	evsel->alternate_hw_config = alternate_hw_config;
 	evsel->first_wildcard_match = first_wildcard_match;
 
-	if (name)
-		evsel->name = strdup(name);
-
-	if (metric_id)
-		evsel->metric_id = strdup(metric_id);
-
 	if (config_terms)
 		list_splice_init(config_terms, &evsel->config_terms);
 
 	if (list)
 		list_add_tail(&evsel->core.node, list);
 
-	if (has_cpu_list)
-		evsel__warn_user_requested_cpus(evsel, cpu_list);
+	if (has_user_cpus)
+		evsel__warn_user_requested_cpus(evsel, user_cpus);
 
 	return evsel;
+out_err:
+	perf_cpu_map__put(cpus);
+	perf_cpu_map__put(pmu_cpus);
+	zfree(&evsel->name);
+	zfree(&evsel->metric_id);
+	free(evsel);
+	return NULL;
 }
 
 struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
-- 
2.50.0.727.gbf7dc18ff4-goog


