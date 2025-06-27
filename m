Return-Path: <linux-kernel+bounces-707097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E31AEBFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 21:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A81C4A78D7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 19:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395792EE27B;
	Fri, 27 Jun 2025 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WpF7uTs"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5B52ED16B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052281; cv=none; b=o5N/pnM84b0zCb6aJHQVPTy7T+wjTW8iRDPKBwKpRGobwbl1d2mxpk2EJeTFKFEnMWa+DlWMLQni+ZlPYoevV45o7Ks6Mpr4/xXz+FGW3S+YDytUQvv2Vt8DBidF9hFdUzeHiHTfSxx/19iTyUdsZ9fHkaf3UE1tZDbyYUJRgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052281; c=relaxed/simple;
	bh=aNMN2DWhRyU+2RMpyUjUFGngTzlUnjuyhGY6JPjW1Eo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IstC5vOOoHB1S8b71rrv3WXHMhtQ7AdOfLZxG9AwwCKhv4FV22d5AOIBhk/SPXh9ZMmYE25hdR3r4CPAjnkLvrrdE0uQ1NeEO4dvYJNT+MI3yQLfnbKlwT536Bndb3wrMqM4sWIYR8ma/pTlHlPCsIFsj9tngrop4CVGkr5YpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WpF7uTs; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2d9e7fbff93so2514191fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052279; x=1751657079; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y648qPWPFyBd60sW81F/WAt0bQS91tJJCKmWVX/1yDk=;
        b=2WpF7uTsZWSOWHDNmMCdPl3WuQT/JGiF0vETmMnX0TnfxEpajkmrINYeK3q87yu+3q
         LrebpuUOLdiUrei9UtDv3A9ajnyu8voNNzFbxo6Cm+JoM44whOxbiokJYjkoEO4GRdHz
         em/H2UOhNcuDF8I7xQKCSmbZYhct8A+XV9RY+5uEck27p24LrKBTY0EYPlzV4EfLmCyb
         Afyl8v6g0E5yMIXwdsVMpa82Z5F914lNj2RWDO9CEdWy4+aJBIJPVqTCXpV7xk0OoCdq
         hzH4lxLJNYrbBupdcsaPSiEU+vqKuFuvR6TKi8qhtrla9yXcOR44tGQuQz7A/eDHJ+Lr
         JTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052279; x=1751657079;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y648qPWPFyBd60sW81F/WAt0bQS91tJJCKmWVX/1yDk=;
        b=O4bd5h4bnYgH3avc7PhKS9LutIJ++BbqrM1YeWAXJnDzLd5FXTNGATroTjOJrZ1/HJ
         8wNPSzMAyZEbFx/Y57odKWc7tycNYqu5/rCN4jtkZZgt6cUkWQia9HRVfxrEVmfcTC09
         Gdv2rnj+IH3Y/g4QfcgxTenLPKOLdqncopZAWVxFvF8iWlatJvFt/DNT2KzTbkxhBiMU
         WGBoOLBOBGPdxX+oIeewsp2tJNPmABeUoaokJSAIe/NsZ50ykOa7UlfLJuox/fG6HfFR
         H8acnRcyvpRKswdVylnaFGF2/+08nJ30QVttaI7VCHPKRrr2tK1JBoeftonmM/9slpLe
         hjUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8M0gHMxSWpVXadYQ6cl7QEkQ9X2Ts7yp/2ho+oal4gpaAyWoxKzUD3NIIee5q1asVc3LfB+E+EnOiP5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHZUGoQ+JiPsRnTc0h2xkwA1dIexgJp7ZvpaaDR7vbbgXFMac
	9ItY8P5QI1f4FSrKhnOWibGozf3R6Y1PXsc5ZeH+Gsbfm8QwljT56NUvlZBqNMbKxWi3pFaA0L6
	4bksto1VnAg==
X-Google-Smtp-Source: AGHT+IEl0ZSGGe1ulHNJcLJqY9IP+npGVG5iV/pYKzVba8MHXlliSCOPcJXopnVaaMUpJL7mwG+wscVnaTwb
X-Received: from oabvp16.prod.google.com ([2002:a05:6871:a010:b0:2d5:7c74:78d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:f60f:b0:2e9:95cc:b855
 with SMTP id 586e51a60fabf-2efed7553a2mr3126222fac.34.1751052279003; Fri, 27
 Jun 2025 12:24:39 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:14 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-10-irogers@google.com>
Subject: [PATCH v1 09/12] perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
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

Allow a PMU to be found by a perf_event_attr, useful when creating
evsels.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 29 +++++++++++++++++------------
 tools/perf/util/pmus.h |  2 ++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3bbd26fec78a..8bf698badaa7 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -715,24 +715,18 @@ bool perf_pmus__supports_extended_type(void)
 	return perf_pmus__do_support_extended_type;
 }
 
-struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
+struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr)
 {
-	struct perf_pmu *pmu = evsel->pmu;
-	bool legacy_core_type;
-
-	if (pmu)
-		return pmu;
+	struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
+	u32 type = attr->type;
+	bool legacy_core_type = type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE;
 
-	pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-	legacy_core_type =
-		evsel->core.attr.type == PERF_TYPE_HARDWARE ||
-		evsel->core.attr.type == PERF_TYPE_HW_CACHE;
 	if (!pmu && legacy_core_type && perf_pmus__supports_extended_type()) {
-		u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+		type = attr->config >> PERF_PMU_TYPE_SHIFT;
 
 		pmu = perf_pmus__find_by_type(type);
 	}
-	if (!pmu && (legacy_core_type || evsel->core.attr.type == PERF_TYPE_RAW)) {
+	if (!pmu && (legacy_core_type || type == PERF_TYPE_RAW)) {
 		/*
 		 * For legacy events, if there was no extended type info then
 		 * assume the PMU is the first core PMU.
@@ -743,6 +737,17 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 		 */
 		pmu = perf_pmus__find_core_pmu();
 	}
+	return pmu;
+}
+
+struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
+{
+	struct perf_pmu *pmu = evsel->pmu;
+
+	if (pmu)
+		return pmu;
+
+	pmu = perf_pmus__find_by_attr(&evsel->core.attr);
 	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
 }
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 8def20e615ad..09590b1057ef 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+struct perf_event_attr;
 struct perf_pmu;
 struct print_callbacks;
 
@@ -16,6 +17,7 @@ void perf_pmus__destroy(void);
 
 struct perf_pmu *perf_pmus__find(const char *name);
 struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
+struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr);
 
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
-- 
2.50.0.727.gbf7dc18ff4-goog


