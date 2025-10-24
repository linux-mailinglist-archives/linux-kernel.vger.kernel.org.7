Return-Path: <linux-kernel+bounces-869331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834DCC079F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98D44224BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF434BA2A;
	Fri, 24 Oct 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4uaIg2w"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96934AB12
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328772; cv=none; b=qnUsH4/tVobuddV4i+8mZ+Ckncgp/0EkHFzkbafvg/0IrO+LVlr+B/hlNfdhsu0U+cezUOKSVKootn3TLL56jkgjC8GkRw/b0sYOvjJSPw8R3aHLTeVYm3q+wcWu+i+6P/lj65kDAOdiRhYJzYTLHUCaXvpeRiCH/zOjC0fynCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328772; c=relaxed/simple;
	bh=0dW3EhwozZJdK9GyY7uSSqkQ3MrxnQx4/U/UjD7W3x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HibfsCwcEcd/6dwMXxPWijFVyfa9SaRAzHWyh3o+aVUjJiY+UGNDeJrl6Pom6xE61ClzH0CgrACtoreOph6TyFZV20WHDMl/LEEtb7rxrEbHJCoQiA+DTCv4wEZ6w97tx47NTraeW6k95YpAYuTPTyK1/GBegIkUrIUDBqCMLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4uaIg2w; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33d75897745so4822629a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328769; x=1761933569; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bmup4BIbkScoJHl2u6fwJbLlsa89q7qgBXlzEQqW1es=;
        b=T4uaIg2wrLxeRGdGaZp6X07cXDZHdzSqP/0sxkL3VBRIwD6gmgjQ7NTEis+KHeijI4
         OaJebFqgQh1ln6IBRUrJwlm7TBtDk11sjPx11ohjL73aOFLnjHcQak9RzFdy1LUSY7rG
         42r4jg50rFBODbx8zdgcfP2W2z5rnEOYs6whfT3XmRoJynQw+X3DDEMP9dHaZOCVRIyd
         Gv/lOErMOcczeyA1zG51j+s+tEYlc4aBrf65MX84bnE8i2mpG1+cDOtAVYI5BVmEnUWS
         I3PuCWiScx9gzNne+fxRCbfhpT5AHAqJjTPI7C51OAa8mM4kgQ1iDCBn6yRnvRYxbFNO
         nPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328769; x=1761933569;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmup4BIbkScoJHl2u6fwJbLlsa89q7qgBXlzEQqW1es=;
        b=WgfbBrq9KSPY2baXZiGu7oaPFjO3zYc/oYc/aViKQjPkkZjMy5d2EH+aJsAP1qBzCa
         vxAqyDvdX9rcKr2xF/XY/ckk5kbIoEjJmVRM8cShn0P2/TU8MSmZJCrvPjULo/a5xsxa
         Io1lPSycAlyIojyEXAiSDTLWceboqxmvzG5F2A+Vijfz5qiNh0dr+SlpfGVKrFrwF4yN
         gcUe7PkajEYc7E5KOCORPLEXWGpP1T4Ju0539z7pYmHP30Hv7/rIYSrDrJOes1s5ThXv
         CTpQgtUTNGZhm2Jh3Sek81YD3QZw5Qi5DiJ6hyD2sh6fKq7DKoi8R8PRT0jqMaVp1sxW
         523A==
X-Forwarded-Encrypted: i=1; AJvYcCX54NSRMKA6yhO+3WUso7qXEKMK3L+qq/KK1bnCnhbPtA5xjuVTgygb6I0SBDsxTzxR+QqDJSU58QqTi50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fXpImQZWbZvQmreN+09e99B+i/SbAsT3cW9yY0lv1qdm1LRM
	yw0aAoH7DI1Ma9fxun2L3pAHi7rzwxrL6B3/GhFcFT4/aVKIYQ7R+QqpxbLlIqGLIUMDHITuvGg
	BuZYomdFi+A==
X-Google-Smtp-Source: AGHT+IF8VrmJgUHc+N22FHVZeIKm9/dVMTRLTdCjZgNklBkTzpwDuzOlB+B1PvJ5QqZTPRwuwT2BrDja295a
X-Received: from pjob9.prod.google.com ([2002:a17:90a:8c89:b0:33b:8aa1:75ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3852:b0:33b:8ac4:1ac4
 with SMTP id 98e67ed59e1d1-33bcf91c61dmr41786364a91.35.1761328769046; Fri, 24
 Oct 2025 10:59:29 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:48 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-14-irogers@google.com>
Subject: [PATCH v1 13/22] perf stat: Fix default metricgroup display on hybrid
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
	linux-perf-users@vger.kernel.org
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
2.51.1.821.gb6fe4d2222-goog


