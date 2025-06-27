Return-Path: <linux-kernel+bounces-707098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A2EAEBFBD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 21:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661E61C4763B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 19:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF2C2EE5EA;
	Fri, 27 Jun 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKOmN2d7"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3982ED87B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052283; cv=none; b=T67guqcjuN4dSfxygV+OBTjmotqqeJnGVaxnJKNng2PvcmPF+u+bKah5xbA0PhSKF+H8YfwD5EyTIm4ledopfhC4L0m9dVVWUKX2pW0g9ih+F0SUULyqz0pjqDXK73suH8MY4z1Y9j60vsd67s6Z8GA8PCjCbmt1Zh48t0jC/CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052283; c=relaxed/simple;
	bh=XpwRfCj6BAPEzssrvIpf/rQ6k3usPqUG8SmEvpgxGL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GI8dUfJrzVelvAwpn8sx3Rm+9DgP4Zto571NyTGSuIsxTlluObZdnR0VwrUK8hg3/ahijFN0SQ4NDHXpoiMQxO9eyZcglIwxweyBcIsYzm2q3HPWAmXQjQP8KSPJVZO5/fEiFejM8E0KPfl2rw47CAlmMjfq6aOJBrgFb5RN5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UKOmN2d7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748e4637739so1863204b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052281; x=1751657081; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+g10moDhyR2co9xzcC7zCBnVEO9NfyRuR76f5YnO/4c=;
        b=UKOmN2d7BSCfSYaApvOMWkAo03UtTJ/HlgWmlViQxAIIoXfaz/8yGDu9bsPPbsYMQl
         OEAV1enHa5N3UMtcE5/1tQnC5ggRm95UxU0prqh1aQPc/bOvDh1gsrcQEC/Sa6Zbckpj
         NbuB0vBgaKMb9Fu6K0qCff9Nk+dGBlCoLzv5Ti6rloQ9m6Bga4co7Vbt74vaSdXA/JIX
         FeBGTnW0X+WxofGOPpUcA3zrPkaaN+1+JHlNzvlpaYN2fCviLBRd1qQm003JpWbe1+bg
         S0BwxMFDVtoesbZWS0Qt6fM6MLZ/HP36QaydwLMiDqH7xZqDaQDsA4JkNLG715BEajpl
         BYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052281; x=1751657081;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+g10moDhyR2co9xzcC7zCBnVEO9NfyRuR76f5YnO/4c=;
        b=UIdzygEvv2Tds30I2m/M4594r69St2VFOwaI+tDfcNCxPtGzgoMW7t3GIcLVSb7PBo
         68taYOdhh3hQrPFoyyXN39YQImyxtgjMgT+FLp856v2ZZNb0zjy3vSIe5IRFjdDYz2jq
         dlGaumwwoF3c62RD0e+U4mKrlNETNWmswAutkJQ2Qp1GF2wNfkbkEbk5Kt0kmnCF2Cp4
         YW7v+g/J9lvR2MhUQKpRnhbCfs+fWf3GLhB5fj+CEkjB55nmCgazgBI79+FSf0i1b7oO
         nGDj9ezKuC+2Wuq48x8CSceA/ZoHQrOxTMy+b3Ed0XOC0g7SxTVb61EhWmJwaEI0CLwM
         c/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUUsjMGxwTRKvibPN3onwFSmTvV/k+e0KyzUYUNiLixGwDnWspsJGT8gdAg0mi2GkvkGDtWaQKEJKZki+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7VVqatX9q7iZepsF60DuZLKK2VXRVYcPutNIhtDhxPU7vzY/h
	SrfHRM01/bLclDCukgExzT80/2vENGqDzMdqnsXGwSDxtHOi2IuEyD1ulu4hUVRB8DscqpKS68T
	fwn+ogkKfQg==
X-Google-Smtp-Source: AGHT+IEsr2LK+hyGE/leTX2OCfI09N2PU8GenufPYSLZAjAShc5sSuT02AOaq+FZ0iQ809ZM8XhsooVzXDU3
X-Received: from pfbdr2.prod.google.com ([2002:a05:6a00:4a82:b0:746:1857:3be6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8806:b0:746:195b:bf1c
 with SMTP id d2e1a72fcca58-74ae410c339mr8029997b3a.10.1751052280804; Fri, 27
 Jun 2025 12:24:40 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:15 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-11-irogers@google.com>
Subject: [PATCH v1 10/12] perf parse-events: Minor __add_event refactoring
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 69 +++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a78a4bc4e8fe..4092a43aa84e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -262,12 +262,12 @@ __add_event(struct list_head *list, int *idx,
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
@@ -291,8 +291,6 @@ __add_event(struct list_head *list, int *idx,
 	}
 
 	if (pmu) {
-		is_pmu_core = pmu->is_core;
-		cpus = perf_cpu_map__get(has_cpu_list ? cpu_list : pmu->cpus);
 		perf_pmu__warn_invalid_formats(pmu);
 		if (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX) {
 			perf_pmu__warn_invalid_config(pmu, attr->config, name,
@@ -304,48 +302,77 @@ __add_event(struct list_head *list, int *idx,
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


