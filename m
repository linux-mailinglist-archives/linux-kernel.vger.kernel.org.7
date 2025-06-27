Return-Path: <linux-kernel+bounces-707099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C101EAEBFBE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 21:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA251C47302
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8B22EE961;
	Fri, 27 Jun 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDgbipIk"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A22EE5EB
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052285; cv=none; b=l3NWC2801V/W8Gf2I1wTxnY91PMyvRIlr8wBWEa7d4sdAKqWQbSKKKSVBIebNH/wuAGnEnmHxNwgV6IaP7EtnGL0R+cGwmZCWkPJbYVRoZKy6YknmIXJSUg/YOZNr59RwId74wW2/mNn8FnOmxaUVOS/zYcV0cB1qqx9ouMtwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052285; c=relaxed/simple;
	bh=TmgYCTTGSJdKq7z8EdzJjt+Yp8LyqX4VI4Ic6NdyBsM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bN9jOWphJ24dvMG/FOJEevTZRJEaQY4MxcvYjOrY9zRltQy7fvDlUpeFXs6TpVtm9ZO9Vbx4C5RRoZaqddjgdRZqgCZ9UfBJz2IBiz4RQHo0ucevaT6/mDkOypV6gatxU4tZ8i0jFGhSr9x5dCRd40viThMCvE9Z5oO2i2rQVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDgbipIk; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2e92a214e2eso874723fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052283; x=1751657083; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFyT+8RU83ZXK59fsAUqw8r9gWLHShlARLFnNU9b/6g=;
        b=GDgbipIkPGQBmCJKE74L9wx/h1wvgkd/33kCLUjpcQFYxTJ/XL/irBKcY1JNF8cZ4X
         TL7vfoIGi1r/ZZVDlL0ksQpXMT+aBmZCuJ1Doz5FQ5I8s2QVEVmcl8lMNV+dTX6seELk
         LK9fagpAJPEqRH9srtUk0odlZpFMfgiD7wp6N8sv7Yt900lSHtTsiiMO0pgpbksV5Mrz
         MIzG9edAe21CzwFyBgdzEg2PnUb8EhESPubTQOjMUq0IZu8H3NVPrLkEkZU4fQZqCpJt
         pSKCVEhJTvj6ts2xvT+2c1QAunusUvBZfvpV246HrJiIOAL9cHybMqpfC2NRzMtZppFP
         XSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052283; x=1751657083;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFyT+8RU83ZXK59fsAUqw8r9gWLHShlARLFnNU9b/6g=;
        b=OYcvXD/dn8Si9eCcz4sipxgIv4mij7my6sd0RlCU85eBHM4OmJSdbIW9z6IV5DtrSA
         w3vfD6V48t8fWIlFfNbVoIPjnWEKpHENHZLIhlZlIvUZ6yu7Q18YTugznlorMDFp4D6i
         T+bQOvtI4Z71qJXaA7jgZYIwx5dvDQD0PHarILtXzYuj4ecHtFYvA0LQezVsYibc32Pi
         4IqR7JMX4CxV34QlOR85OjaE6hgmu+8abEQ4GNqmkGU+ciiPshUxH4Kra/QucYyHUYov
         paHjmBwDAT6PN0y3ElE13y+A5wE9HU7djR/JqKir5696TT1LEkDfb+RMe/1SGIV8UobF
         HTLg==
X-Forwarded-Encrypted: i=1; AJvYcCXMvG2A64+nG+eEmgRf4GzivphWTIC7tIP/l63M+46i1V6dgpuVHkZemDKovaYXqMIuZWu3B4egDtHeUts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKFIfb3t2OBvAVgiYGKV/oazNj0tTQvLCiTrF+Em+09K5rjTEF
	jaUsrlrmV6x892VHgvr43Xc2+rVXnVt44nwbu8p4O/rq5j18AES7MBqtPoL1dYbR4lfiyGKXE2l
	QVE9UI+5OtA==
X-Google-Smtp-Source: AGHT+IHPcRI4IStwL19Uepy2ZttTWHngKeBVZRUyOc+r75wj7tI5L0IQ5QjZmvYiblT/p1WFOLuKCX16y6tM
X-Received: from oabps10.prod.google.com ([2002:a05:6870:9e0a:b0:2c1:fc56:4d62])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:8312:b0:2d4:e96a:580d
 with SMTP id 586e51a60fabf-2efed4d9bd6mr2974016fac.16.1751052282906; Fri, 27
 Jun 2025 12:24:42 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:16 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-12-irogers@google.com>
Subject: [PATCH v1 11/12] perf evsel: Add evsel__open_per_cpu_and_thread
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

Add evsel__open_per_cpu_and_thread that combines the operation of
evsel__open_per_cpu and evsel__open_per_thread so that an event
without the "any" cpumask can be opened with its cpumask and with
threads it specifies. Change the implementation of evsel__open_per_cpu
and evsel__open_per_thread to use evsel__open_per_cpu_and_thread to
make the implementation of those functions clearer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 23 +++++++++++++++++++----
 tools/perf/util/evsel.h |  3 +++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1169aa60c5fc..9abc62635e76 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2741,17 +2741,32 @@ void evsel__close(struct evsel *evsel)
 	perf_evsel__free_id(&evsel->core);
 }
 
-int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu_map_idx)
+int evsel__open_per_cpu_and_thread(struct evsel *evsel,
+				   struct perf_cpu_map *cpus, int cpu_map_idx,
+				   struct perf_thread_map *threads)
 {
 	if (cpu_map_idx == -1)
-		return evsel__open_cpu(evsel, cpus, NULL, 0, perf_cpu_map__nr(cpus));
+		return evsel__open_cpu(evsel, cpus, threads, 0, perf_cpu_map__nr(cpus));
 
-	return evsel__open_cpu(evsel, cpus, NULL, cpu_map_idx, cpu_map_idx + 1);
+	return evsel__open_cpu(evsel, cpus, threads, cpu_map_idx, cpu_map_idx + 1);
+}
+
+int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu_map_idx)
+{
+	struct perf_thread_map *threads = thread_map__new_by_tid(-1);
+	int ret = evsel__open_per_cpu_and_thread(evsel, cpus, cpu_map_idx, threads);
+
+	perf_thread_map__put(threads);
+	return ret;
 }
 
 int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 {
-	return evsel__open(evsel, NULL, threads);
+	struct perf_cpu_map *cpus = perf_cpu_map__new_any_cpu();
+	int ret = evsel__open_per_cpu_and_thread(evsel, cpus, -1, threads);
+
+	perf_cpu_map__put(cpus);
+	return ret;
 }
 
 static int perf_evsel__parse_id_sample(const struct evsel *evsel,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8b5962a1e814..4099812d9548 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -349,6 +349,9 @@ int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx);
 
+int evsel__open_per_cpu_and_thread(struct evsel *evsel,
+				   struct perf_cpu_map *cpus, int cpu_map_idx,
+				   struct perf_thread_map *threads);
 int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu_map_idx);
 int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
-- 
2.50.0.727.gbf7dc18ff4-goog


