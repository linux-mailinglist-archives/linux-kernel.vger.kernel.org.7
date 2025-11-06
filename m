Return-Path: <linux-kernel+bounces-889504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F329CC3DC96
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1854E8326
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE41F358D01;
	Thu,  6 Nov 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNjDytRv"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A89357A3E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470957; cv=none; b=Q0apQvEY111ZXMAdILjvGI3TDpOsScooBlaKYcyNfNbnBgLDR5puFYwowc9eAEfa9HLTbPwlq0hMt96tth0vWGDizOdGCHcDIWK2aGerV0sAHWbRLiFKerJO4fZQBCdBEzaDpVHIjEvJCsWTXB9kzLZ0aXt47HhEkmXLG5JtwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470957; c=relaxed/simple;
	bh=cZF5rXK0ot4f5Ll54hzIMYMkIxY+GXfM/HIllfqaohs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kbFDDOxRSNhNJoKuW6AvFd0TrJxsxRvyTL/JWYmgXopCGvWEcSHzORrrJEDVtajDHmSYJZS/2m1X4KB6Sgc6/WNwbOxYhWJ+/qULJWLNKwvkWh7cflRI4W5QNp4gq/ZCrvoX/DT/JBxjz+ypvIxSVJNuzYcXf2cPyx1Dgi2O9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNjDytRv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29555415c09so2106105ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470954; x=1763075754; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJrFojSq6nlkAfypEMFi1zUKz5050bK3dx0VztPcSL4=;
        b=XNjDytRvdIKQ2VhEU4fJnQwqaJJY68nxei2eOgGweRFnFVTvjfIAsp0Z47m0GEEB1Q
         qch9Evp0eNOsDjraG27QTG4RxYLz9Z8TED7sNJS4gSXM1syq3FiRvlUn1bpcL482wKJC
         nXp/DZSldUBFxh+us4j4cqqnH62jf0ykIskTSG6K3jnb9yMiKEzcAg7h7MEvTc3tJlMA
         vKNk6tJdlsLP5fHrQ9CIHZ+sKsyIEKTAsGowLbdyxvxu5buJsnfqUuZwjQiqSJUV/039
         C9eG9HmXwmlru9lt9pN6WquTjVGlawCj2yNUUIOBRBUonkdiTI9xpnA2W0eZNum1FJN1
         jwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470954; x=1763075754;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJrFojSq6nlkAfypEMFi1zUKz5050bK3dx0VztPcSL4=;
        b=WDULxjsNB9vmQMp1pumMphRg1Gc3i1TzdXTKxZh8bMyMSIlLX9LjH4phA9OpBr/DJB
         juvP2BHZhT3+9lx6G17flroy96m6dgTU4w8r3QMYczPrKGJBwsJZ51jvCy5Na7n+4YA1
         rM+wQlzIRbAAaZoD4Sc4OQnZfCwZ0ePTyILAxEBmG09nZVubnIihhKOjdG6X42rWL3EO
         PyEQcEhenqNPwD2vE8AH7Zt/J3b3BDWGDCNEhN7aO3QAyZzfIGGRRNKJX/5aKkx7UrZP
         ZSnC7psin4tMg1YI/ajy0YALo09arb21B0EHiWq8QlWWOmUjNO1g+sGQI5krIkn5FT/h
         b4Kg==
X-Forwarded-Encrypted: i=1; AJvYcCU+o+5FUP62/goNutnWZO74uzjtWvuQ2Z185it33Kyu/y0aN8DWy7NwANmF0BY84kjXoO96wRGdJgVVT/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwizdWT/z7TMZUKPhOyC/DKVu/s6dfznim1j5itC7X2Y80xtMZ6
	3xsIb2+thQ1V0LsBTbBwuXw0HdpVehfyeLdIcdCL9gnWDtCUHp8IArBd592DpHl1V2V+BcfqVn8
	hDPq5rQI5Qw==
X-Google-Smtp-Source: AGHT+IHjH/Lc/zZixsXrrpT72ayLrbkOIrsLtdVoMrbt/bO0u2fvW5pbTn9CqdlIJUS6Wb5uI4ddoJtrc/nT
X-Received: from dlbcf37.prod.google.com ([2002:a05:7022:45a5:b0:119:b185:ea6c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8e:b0:272:c95c:866
 with SMTP id d9443c01a7336-297c03ab3f3mr17315715ad.20.1762470954099; Thu, 06
 Nov 2025 15:15:54 -0800 (PST)
Date: Thu,  6 Nov 2025 15:14:58 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-9-irogers@google.com>
Subject: [PATCH v2 08/18] perf stat: Fix default metricgroup display on hybrid
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


