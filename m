Return-Path: <linux-kernel+bounces-896195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB88C4FD5B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 756BD4F7AED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE51332692A;
	Tue, 11 Nov 2025 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3q0bWQvd"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F1352F89
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896155; cv=none; b=F9Lep2bpRmuVPBwpP11sOCb1SYNKOXPWTPWdid7wBGa/N0KPAYY9b6BdfQvpjgvWYmrf2y28bfCbl4fVkM/EUhRJovrefvdHhM+Lv8QN9uEwhxriY4Blth9EfmKotJ4Iiw7Iz91d/r2kmkY8sVlhZvpZuS+wkDpMWoeUpqkWkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896155; c=relaxed/simple;
	bh=cZF5rXK0ot4f5Ll54hzIMYMkIxY+GXfM/HIllfqaohs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PAgK2Q5rtYtFXzc9ge+YNQUT7ZSuCDEPXIduyD7m+VuZ2LXMU2W5ssMKA0BagpWu8toYsJGO/vbxQdlIC0eJk3qgoNrmvk2IsBL6mq1L9X2wl855/U42UMy0VNkksIqGbMxp4JxhiZiPOVZzyXPJ+S4JWZmApZQe8d2leQ4+6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3q0bWQvd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so133819a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896153; x=1763500953; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJrFojSq6nlkAfypEMFi1zUKz5050bK3dx0VztPcSL4=;
        b=3q0bWQvd2V3gwfLOqCpl6NPtZdZf1q4o0YzVt7eUJE2NY/gUw8heCqnDDTwR+GvBAA
         mx2emtdx6mE6JkqJbAzOoXXOw0tvhY+sSaOYnBunNvDWXkW19lLB4IGmKgwDjEwTM+61
         WVdw6Y0OchDLg0om9ILTZ+grvrJOG7KZwx1+3VljZYNbvylrSh1QuguNo1KtAn87+Nse
         K+MJB3TZi1fNciAW9EHIIQxttg1zXDxrEHUN52qI+ZKHNh1+wwwBpJi6lrhAs5ev0N7p
         JYo2haRYYbQ+m1f8qc8m+GyKVlV8yCTR3lJFSdFsC2Djn2LtJ7LXCGj2GxbYwNGLP2Qm
         JM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896153; x=1763500953;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJrFojSq6nlkAfypEMFi1zUKz5050bK3dx0VztPcSL4=;
        b=pG+SeVJ1+wz25lS6sDUgtBRH6vWizg7SP+Y86hEUElyH58ATkIfwZNemgZJW70aLbN
         JHcMRqz1pd8xSrtygqLs2y5ymySPK9v0sjXJhgbz74FONUtatWDfzLCf6auKiYHJQnUd
         FJcytGMO23dZWC8dvNZGW+Y3WSHUPOVT9GtYhUanLhfo0ctO2+02aW5NVF6jBMXZ3SEe
         5AN9eLLaeZnd+n7N8WlLXHXKic9hWVe+RBvK5q9QMNXyP7gRO04UNnrTzugpqTjz3rjr
         8ErPU94Sti6TCeus1lfDf9g8QQWShvewrMluryULTSQ7cQcqVjJwPBLZsEUREoD1/fo5
         44cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPI4I2zjI2007fJSYSmHJxTuG+nggg/R7UxemHVsdIiO2R4A9vfMhI6TKGq0IPbeWX5PYD6Jcwb1TJPt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNLHJG/cR0CKOC9jiZs5zH4U5E1yXzKaXtpHAp4aexMz3t4Ayk
	onyRLnLygAW7bMjxY3OeZak93iP1ds2EJZSXtGXGiBN3qzkirbo1MDjSq3wrMZO7fWXxUaMQ18E
	HKtLm0dpOlQ==
X-Google-Smtp-Source: AGHT+IH6SklwH9YG/Fpz7J/2c69oWEZ1JiC5d5Ldsoq69XheBMKExIYotoNlTRiUXcBI0bRhhBQqdriiC33/
X-Received: from dldnz10.prod.google.com ([2002:a05:701a:ca0a:b0:119:b185:ea6f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef45:b0:295:738f:73fe
 with SMTP id d9443c01a7336-2984edec698mr7998595ad.30.1762896153459; Tue, 11
 Nov 2025 13:22:33 -0800 (PST)
Date: Tue, 11 Nov 2025 13:21:56 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-9-irogers@google.com>
Subject: [PATCH v4 08/18] perf stat: Fix default metricgroup display on hybrid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The logic to skip output of a default metric line was firing on
Alderlake and not displaying 'TopdownL1 (cpu_atom)'. Remove the
need_full_name check as it is equivalent to the different PMU test in
the cases we care about, merge the 'if's and flip the evsel of the PMU
test. The 'if' is now basically saying, if the output matches the last
printed output then skip the output.

Before:
```
             TopdownL1 (cpu_core)                 #     11.3 %  tma_bad_speculation
                                                  #     24.3 %  tma_frontend_bound
             TopdownL1 (cpu_core)                 #     33.9 %  tma_backend_bound
                                                  #     30.6 %  tma_retiring
                                                  #     42.2 %  tma_backend_bound
                                                  #     25.0 %  tma_frontend_bound       (49.81%)
                                                  #     12.8 %  tma_bad_speculation
                                                  #     20.0 %  tma_retiring             (59.46%)
```
After:
```
             TopdownL1 (cpu_core)                 #      8.3 %  tma_bad_speculation
                                                  #     43.7 %  tma_frontend_bound
                                                  #     30.7 %  tma_backend_bound
                                                  #     17.2 %  tma_retiring
             TopdownL1 (cpu_atom)                 #     31.9 %  tma_backend_bound
                                                  #     37.6 %  tma_frontend_bound       (49.66%)
                                                  #     18.0 %  tma_bad_speculation
                                                  #     12.6 %  tma_retiring             (59.58%)
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index afbc49e8cb31..c1547128c396 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -256,11 +256,9 @@ static void perf_stat__print_metricgroup_header(struct perf_stat_config *config,
 	 * event. Only align with other metics from
 	 * different metric events.
 	 */
-	if (last_name && !strcmp(last_name, name)) {
-		if (!need_full_name || last_pmu != evsel->pmu) {
-			out->print_metricgroup_header(config, ctxp, NULL);
-			return;
-		}
+	if (last_name && !strcmp(last_name, name) && last_pmu == evsel->pmu) {
+		out->print_metricgroup_header(config, ctxp, NULL);
+		return;
 	}
 
 	if (need_full_name && evsel->pmu)
-- 
2.51.2.1041.gc1ab5b90ca-goog


