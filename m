Return-Path: <linux-kernel+bounces-737518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AC3B0AD8D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0013D7BA827
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7404B1F91C8;
	Sat, 19 Jul 2025 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBJ4Osvu"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1821FBEB6
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894345; cv=none; b=EXvZF7pz1KmLFeKJsb6887M0qtZT+M5hfafcOQ6jQABf7MC1ZzsD5rjcVYDdwe4uj60VhyRJag9HFHnTBWxnQMvhE7m/5+VLtuDmZziNHBRArLnTEebMnDIO9QOa11fPEw1ehQN7TYlxqUKPdcltwyBXBeeq6vqsYikMHiq/mRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894345; c=relaxed/simple;
	bh=q5gclP8enVIDgmFTy0uPjEoUXrIKoG7WxEpD69DREJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tCu3g8kPvac0K7mBCrPAwVPzmKuoCxqIZcadXz+JKZbwSByBMwes/WMZrBBTTpcC0dPzIB8vhKWdfrjswSb90h2k8GX34/+pnAabwvWhaSdQWrjMJ0GGfVGlTajXHS+73+RutKSPhV43w9Z9cHpy6BNQvSdEYTq3iqn7IaFn2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBJ4Osvu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313f702d37fso2772860a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894344; x=1753499144; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9k2/D5iQ4L1OZOaKDLGd73SeKK5tMn2kJdyY+h5+RPA=;
        b=KBJ4OsvuGbbeL6cM9Jw+n5tVBd27xNlh1gdlqfrL7IZ+JPFwnMqqeeqywfMzMkEcim
         fZLoqSvcZrlu/Hp7+yDQOProUpCJtMi9UydaGKGU/GeccAaRd2dcrVYmjd2VBPQc9LT8
         exzBWbkzpZ4pe4eS7BO9FExJqezf2b2um1I/mAIJjJhUH/2+DNaK0DXU9IfKGYxkRDVw
         izaynF8K2UZEbi9mnuuILDoLPn58p/y09p1BaITtcsOnp01CzLp6F+mGk6K/YOfC/wa/
         9+hSi/t2uxJhj14CLfsXOcnoHvwKcHGpcB9FGuYaGAiBy+Jz6DbWdKJ8labT5VsqVsuM
         wViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894344; x=1753499144;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9k2/D5iQ4L1OZOaKDLGd73SeKK5tMn2kJdyY+h5+RPA=;
        b=ZXIncvfo4+EkCOMQJUWDxl5EmwNYsrxP3jlRGEJFzBp/du/r6iFIrUkPD7xBa9KXZX
         oyOE6Kclmo72bUtOp/C9uUa0xZxLtxsJWTF9wOzxsHw1EwVN5qz8Q/dSuXEbl6Drnb7g
         7PNdObeeeKRfMsM3gm30P7mkTk4gZVSkxZP/9Z10/A3I2ZSf5odnMnAU1EM2hfSkndTr
         FklV95URzoba4csSUmN9mPidqkC/4Z2KXpTcHyT500I3BE/poa77t2EUV0TvU70UoKH6
         C5Oh84oUsusamLAK4Y1g9IXmz30uqXZElcP6UMKvWpm2ixEZiWIgjjGhfXivKOONX3Wy
         suMA==
X-Forwarded-Encrypted: i=1; AJvYcCU5vWdGFam92fdOLHDekBn0TCx5mqiFyYoHVMYE4H1aBqVfd9SVEjuhBEs5seWWk6E1CYA+RMiJubqxOMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIAgO4pNUCVlUqavwMk8kAtZdsWnfhe7mH+WHuQ9gImHvI0r89
	bKX8wO+blAPaa7eXezBBTzG3CzmIjhQVgkd0gqpUHOo9JKNRhnyQq0f3+VuWVZrtnendBn9yGQI
	QQ+xJOvJevQ==
X-Google-Smtp-Source: AGHT+IGyCYdok/lnjluDg4zgG85RjuslrrMWd8I4POGHU0w7L3dN6jiZ4H8vv/OkrsxeSOuFVkwMORo0c8W5
X-Received: from pjtu4.prod.google.com ([2002:a17:90a:c884:b0:313:1c10:3595])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3901:b0:311:9c9a:58ca
 with SMTP id 98e67ed59e1d1-31c9f44a3d5mr19868019a91.8.1752894343705; Fri, 18
 Jul 2025 20:05:43 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:09 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-8-irogers@google.com>
Subject: [PATCH v3 07/15] libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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


