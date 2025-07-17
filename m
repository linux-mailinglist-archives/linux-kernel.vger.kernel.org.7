Return-Path: <linux-kernel+bounces-735977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C197B09637
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4159D7B8E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30FE22DFBE;
	Thu, 17 Jul 2025 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1pJDrG3e"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735B23ED6A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786174; cv=none; b=XP4QHWWLihSf/LRKUhB+5NfOzmnYxT89ZVv3LMiPKQLRIpDkfoF1TUbQobRVajYYyXTXFoiacstZOmRGNOzimEYAhmQO8YcRXvIjSwytIm6NIE5fLcPx2r2YqKYwGwV+Qu785EvqGohgcVsZPNScF/rkyDV7JNbX1RcQEddvopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786174; c=relaxed/simple;
	bh=q5gclP8enVIDgmFTy0uPjEoUXrIKoG7WxEpD69DREJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=po7oybsHD3f7UCHJCqaYammR/IQNNOyVaWY6qbIGwc+bQWFvJrvfN/fzTgxckR3khzS3WgCRARMZGuhRBeQmVjNR1Uig/UIOMSBKO6ijwDOnENVM2R79JCuulG7GYmr05oEquhZCw0zrENHo/hQ8i3RLpkY1KiHLMGhZM6ycNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1pJDrG3e; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2f3b9f042a6so1430241fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786171; x=1753390971; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9k2/D5iQ4L1OZOaKDLGd73SeKK5tMn2kJdyY+h5+RPA=;
        b=1pJDrG3enDpQ+hK4ypwhrXVLne8nRXF9kopAQD4eyXAMvl4KZiYnZXtgO2wCCvKoS7
         R8f2n6GnlscYha0CWgBpBLhY+DZdwvAnOhvmsji+BX3c87y9ZtLSTHq29NHBb0yFYFQS
         aQIll6JwdUhJ9qrLbEWBrk+APwHP7Iseg1p3RcbuDpbKyUD0u0xeNLyf986xeSqoS8+7
         LzGQOugF3XjqvV/4VRSjCZFLTN/ucWhoYG6N4abiKuOLSdAckXFyIjnHzvqYWL/cRb1E
         ywi2A47bVnWgNZr0x46qYdCBxMuWYXbo11bsnRnGzo9d9XOxUdeTJabImJq8PkcPIgRL
         iRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786171; x=1753390971;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9k2/D5iQ4L1OZOaKDLGd73SeKK5tMn2kJdyY+h5+RPA=;
        b=ZZ0t9TpS5q/n6A2gqZKFv+6CZuTM8h78mUwruY+DaUngkIU+CO86o+tVuPrmfurtRD
         RImGzSS+L3cq0rvETUZjJ/3JlYYo96pVqJRqA/Xl7qQl+jKAgElFRsaDGgfvR/HnmrJH
         f3X47OyU0acG3B9ZrtkvGaWsfkphOVsYS9W9prDFVFpcDYBwUxhksvxU8ecUgSJ8WNxu
         UsR+hUCULO0OO/RPwQT+g63fEjMXRxgTE9WQ2R2ZzY8wDGXx0stSCPgVUACER/OWDQ9h
         JvoxugkcUN3bVQXXi4obMd6Yb1UbiuLXuq2z5jTBn7EAJU4nVQJceMldZ5FruDALx5u7
         DuVA==
X-Forwarded-Encrypted: i=1; AJvYcCV1ghDp5BO0UHsKZ3/Uk4j+SU15OVfKoRmmHDqYU07QhFPN28K4xqGYK8KjOuIP4G2gmEFjfH0LrKJ37Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwedFpexreQw8+vt14bVdWkHuvCg+LXUrjecHeusnAJxE1DRCo8
	es6g1zhcvBSLFf+nTtlOvf4N6H4F3HVqLmJ4UvqTeeTJ2/IIUjC6oLpNZYn4JYn9TkmjY/dTULr
	6jakbpfOBgQ==
X-Google-Smtp-Source: AGHT+IHC9ZZCEmJyp8ykZmSgFWVo+Qs9NWZAEYYccPZ1/jBQqB5hEbwCXwo2B6OdDesRj9peeNspk9nfYpZI
X-Received: from oabla12.prod.google.com ([2002:a05:6871:410c:b0:2bc:757d:e145])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:3b83:b0:2ff:8ad9:f12
 with SMTP id 586e51a60fabf-2ffb23eee80mr5406266fac.22.1752786171572; Thu, 17
 Jul 2025 14:02:51 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:28 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-8-irogers@google.com>
Subject: [PATCH v2 07/12] libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
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

This allows the perf_evsel__exit to be called when the struct
perf_evsel is embedded inside another struct, such as struct evsel in
perf.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c                  | 7 ++++++-
 tools/lib/perf/include/internal/evsel.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 127abe7df63d..13a307fc75ae 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -40,7 +40,7 @@ struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
 	return evsel;
 }
 
-void perf_evsel__delete(struct perf_evsel *evsel)
+void perf_evsel__exit(struct perf_evsel *evsel)
 {
 	assert(evsel->fd == NULL);  /* If not fds were not closed. */
 	assert(evsel->mmap == NULL); /* If not munmap wasn't called. */
@@ -48,6 +48,11 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 	perf_cpu_map__put(evsel->cpus);
 	perf_cpu_map__put(evsel->pmu_cpus);
 	perf_thread_map__put(evsel->threads);
+}
+
+void perf_evsel__delete(struct perf_evsel *evsel)
+{
+	perf_evsel__exit(evsel);
 	free(evsel);
 }
 
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index b97dc8c92882..fefe64ba5e26 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -133,6 +133,7 @@ struct perf_evsel {
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx);
+void perf_evsel__exit(struct perf_evsel *evsel);
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__close_fd(struct perf_evsel *evsel);
 void perf_evsel__free_fd(struct perf_evsel *evsel);
-- 
2.50.0.727.gbf7dc18ff4-goog


