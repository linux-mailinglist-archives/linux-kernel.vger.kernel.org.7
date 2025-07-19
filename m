Return-Path: <linux-kernel+bounces-737522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21623B0AD91
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA0CA7BC99B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB7A22F76C;
	Sat, 19 Jul 2025 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1KmgzzwL"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A3520ADF8
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894356; cv=none; b=E/mFwrM3mP++YMWheLHDzt5vw+/rqAhdTveMq6eYrl3X1mIIYE4OkqwWVM/WLdqJUqXWUV1sPAQmuaHSorT/LBv6Dm6geNlDIpuzTZrswSCt+QzDteKCa9W4Ws/wlQRXq4fOBJRefIoQIRtf64hn93D0VAokNnlR1FubARCvkJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894356; c=relaxed/simple;
	bh=7V57mrxclma+L6i7A+s/RUZqSr9To26yFbxOIRG9Ic8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=n42uMMEv5CjyWxMZDgpmdGg1yCNROuF6x+4gbtR6rjpu//NQ86Ntu4o5YnaqWYtUjU9nHjJEYNyjndOZvKecOBEk++jHQaG49bIfe6yxEYUc6Yo99E0zhQ3s3lqjFAy8kXLniF+hmkJDBrK1ljkkzLgh7CSe5LDT5tZH7pPLNeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1KmgzzwL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313fab41f4bso3616194a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752894354; x=1753499154; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxK32ZV3/TwHJ48GSqnT12vEqhtnY89NH3NlvQCfpOQ=;
        b=1KmgzzwL/r3AVd9PKK9u2XF3aS85LtaiP/g11RDqe5dzP4+/R01rqzLjZnHTibG0an
         cSoYHxI14is6CyMgilzEgoksS33p47FYvki+LmmVy6TX0gXJ5n0nA6W94jgs0NgQZlur
         5VExYtpGSeK1PG9SrO8JI+FDNeIGTbCKLP+pVrjzOqEZG40LY4M6CEPD1aoZe5hdPS2Y
         2/wWg4XLyMVldXIKfJ7+RUu2Bt1ZDoYeCgvBqx0YXRBZ2sj/DGbCbAw0kYoE4atjy5ah
         wiYYfjarsFnlsYN2yKlGuEO+RqEBHefTI678Jz6FBfEB2StFFK+T+saE16UhbbduqsyH
         taiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894354; x=1753499154;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxK32ZV3/TwHJ48GSqnT12vEqhtnY89NH3NlvQCfpOQ=;
        b=QX+8CgNUAeBG7HZ4lGjToSvXsclLquRUmKameb7G3SJ/T10kHbbwouqae/hWf6LQZ0
         c4aN4i9gD0uA1aNJUuglfliEY+3TDlprYFUJ5vLXdDvIy3krlS5RBJNm0fRt4GoT7PKV
         dK5LeA73Jb+zUMXY0Guo0wAeSCSDtfMkPFIWwA/v8Fsz/A9xvOJhvBdLTDT+2tbTVyXT
         POvcqUUcrH4ixUoWf9zoFg/v4M6NKAhJ7UcJKS3UCboSS1vtN4FoagTc7ZLbeDyUZxb0
         Z2tsoJwghexAXm0uYwI4dqrtbl80gjcePH4m7oK/KQqh4i7uZWJ6gJSFRL+Qx+Gr7MCl
         6UUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvBQPjJ/g3bLeIB22+4E3F/nV4yEay+NxiqypWnS/KoBjXQhiUL4NDSoQVpOmhGvU70s3aOzQhLgTFbNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVF4TOY50raWw75lmj0ICKXHtqNGoCLUpnQgrzx116YGs93A48
	2VjbxwpN7k9P9LGrvLK2FKJwvnF/brvt9AinO4pRfRSJisAy4zvWCEk9vdLzUpskISVi1F0nK/6
	ABV3wZuBF9Q==
X-Google-Smtp-Source: AGHT+IGog4H16tvEQwiT1AI891pwhJQ9A4BVEfNjMEJyKJU2RSnd/ONsvz2K6wIehr6NTjys2vAEPGX8XNto
X-Received: from pjqq12.prod.google.com ([2002:a17:90b:584c:b0:314:2a3f:89c5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b43:b0:311:e8cc:4253
 with SMTP id 98e67ed59e1d1-31caf82168bmr13625383a91.2.1752894353867; Fri, 18
 Jul 2025 20:05:53 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:05:13 -0700
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719030517.1990983-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719030517.1990983-12-irogers@google.com>
Subject: [PATCH v3 11/15] perf evsel: Add evsel__open_per_cpu_and_thread
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


