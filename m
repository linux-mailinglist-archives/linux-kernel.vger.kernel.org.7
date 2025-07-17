Return-Path: <linux-kernel+bounces-735981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A6BB0963B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22FA1894E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0911725A340;
	Thu, 17 Jul 2025 21:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stxozxnO"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7E253F21
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786182; cv=none; b=R2r+gBvvhmWta5gx5vvmqDabjKh5YnV5DECW7bJIdM1JODxTm1k8gfm9aBbxwaTzjsfQVmmNYy9wq0VK0bOG9hEgA3pFGhiL64f8e7jYDjjWTHBS6MmjMuIYrxsJrDGSinFe9pz7z5XpWvBBExAXTpCQGSY0Bvj8NpIq4IwK4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786182; c=relaxed/simple;
	bh=7V57mrxclma+L6i7A+s/RUZqSr9To26yFbxOIRG9Ic8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SZvsUnJwIOXl3ASjhG7iQKFneMIZMsOJ4a5tEmvQdi1qGejM+ecx+4U/OfKmA1EuYJRCuDmL9FKIr8rJI4JPSgvvxrjfTzfqs+KZ8/OzoBsBpH0A15mR7I9qII+BN3MyClQ7DtLCDka97zu14KjXp2U/TM/CmKu6npjUlmehxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stxozxnO; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2ff9bf5ce1aso2367417fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786179; x=1753390979; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxK32ZV3/TwHJ48GSqnT12vEqhtnY89NH3NlvQCfpOQ=;
        b=stxozxnOpPXY3REDH7IRmXb8E6OC389QWhcniKGNZoOak1f21aOv8gOnib6xXpkhQn
         i4u/BMIwtwJfXiNpo1ghtOWwIBzCIGLjk8BMs60i1Dhb/uC85AFREuyZIhrHTJBmM3I6
         paueMsMaB/tUANxC3O1+EGoV2J0li8eyrNzIUpbuPwsv9vxgDQcXL/P+5dXudoW+EPAZ
         2tIJcpk8X+2yAS5Y32YWSKRHg423BJXIILe1wJ/MeVxdcDVh7QZfPcCo/Mjs40jO6ehk
         gkdo7ZrTdVIgCiWQfo0PrCRFyvhe4og2EvnCDtKc16xjVPC4eX9NHudem8PO/DI8Yimn
         TOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786179; x=1753390979;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxK32ZV3/TwHJ48GSqnT12vEqhtnY89NH3NlvQCfpOQ=;
        b=GjiXpM/uCb6O5I7kwBoTv0GR8Voin1pZRkmwFPP6lQnmHnR4/qqDGLYf6aPbq+PZwv
         gWXcn1P/Fro5jyu8WII/lbzAi9kQJeTg6pYpFF7XLzoYYyiKdQS3nwJCoPMjQcRhDbZC
         0f3aSVhhZXlmsR54LRfNFj6/WdATiy2yAqHawVVCPq9Ro20ZgigUSHdNylXvia8/DenM
         5qkVBk1eaRVdn+ltTt32OoSFSONlX8Oe8nTLb66VIYx90xDENS3eiQsrM5v1faXP63aK
         MaVujXk9tY8lyhx+fl/JDyRBblOPUq3ajTXnZWQ3V1szVkCJYThp+PP22/Q88iVoIFXf
         C+PA==
X-Forwarded-Encrypted: i=1; AJvYcCXWd4DnGCT7TFxCkiu2EJbv1wbOsBZY382BCYAxNi3DZAr4sB1HkevxerJyA/f5ndChg0McdOkq9T3cFlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5tzUV5DfS6KVnLj3c4Ck9eYSlqc8ZD5yWuR/uGEjM5EPtjJl
	sfKfyuFjklTy2zuP7yufu6krNentkinzkv0sOAOIv07kCJVGuYy4bNupqkQOkdljzno2Zg1+S4c
	zWFq8ff1MEA==
X-Google-Smtp-Source: AGHT+IHcIFzwFnn+SjPmcIqyplDWuJDsGtXSmp5dZf0+tUKV7Fw7+u0UQJPZHt4hNF01UTe3QJIM+mWzCi3d
X-Received: from oacdz3.prod.google.com ([2002:a05:6871:ac03:b0:2bc:69a2:7ea5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:687c:2f22:b0:2ff:8e7d:1d9f
 with SMTP id 586e51a60fabf-2ffb2285801mr7054112fac.13.1752786179445; Thu, 17
 Jul 2025 14:02:59 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:32 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-12-irogers@google.com>
Subject: [PATCH v2 11/12] perf evsel: Add evsel__open_per_cpu_and_thread
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

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 23 +++++++++++++++++++----
 tools/perf/util/evsel.h |  3 +++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index af2b26c6456a..ae11df1e7902 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2761,17 +2761,32 @@ void evsel__close(struct evsel *evsel)
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
index cefa8e64c0d5..8e79eb6d41b3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -351,6 +351,9 @@ int evsel__enable(struct evsel *evsel);
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


