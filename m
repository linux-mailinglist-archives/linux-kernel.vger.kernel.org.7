Return-Path: <linux-kernel+bounces-585442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02990A79373
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 18:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA2F1891799
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1BA1C84B9;
	Wed,  2 Apr 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIzUNnJT"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8A1ACED1
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612457; cv=none; b=jSsql2NMJbnSN0hGEl1VhS4NjN8KuIIVFXQkF0bIlIH5DUrzbt4qIKMq7J9RPGkP3M/vXj5oN2kdKSkLJ3dv3Lv4g9HqDXc/fma5A4n3Ls3OPglURCbitvJGeJ2m75ssOV/b1cZy9LSSGAYGh4HqwJU+H+rwf/GL8RHNShuKp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612457; c=relaxed/simple;
	bh=IoNk4f+pHHqP7GqFc1Z3S9xs2ShDQotfi0G7WwroLJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tWM2dWLRbGPWNxo3yjoEVXyhkt/8dRbmy/QDykQG3L3ynrJfarMBd0TYIy4G3MfbbASin/JPvSTeJviZLcQaHyt4C3cz0YhiQZ7XhCRJ1gj/OE464oTCOrQceQ/sCTezdwi4zLpEhpDuBqeTAr4A0fNLOqM4u8+6unEcOJTf1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIzUNnJT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224192ff68bso485285ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743612455; x=1744217255; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2uO9pmTjsejVD/zY6cyyd9PztZvdMOJJd4Zz+Pr1QE=;
        b=nIzUNnJTWSdpDMFyTDHhB7gcUH9rCFZk+/7QenY86iTiOxH5lktBr7V5eiDgkVDwKT
         3hEVHfSQpPlEFDclz9/Fw/7mooxmB/wdy2d6pmX3WkH7z1msTRAA/Lz351qgwHRomoZG
         ZKeWiLOGgeirjOmiv9rMrgcx0r2skOXV3pEN6JGCKBtMxFzQUEkBlzuZGY1lMCTJi/WB
         oC4QhUnzLMicP3ex6m4oyZmDEkWxdcsF1YbEyiDVjbviNLLwk2sT7pfidLU4JTFw8HKf
         9GHwdSqFLoQivgvjnUuLqnUI+uGu1icNU+HgUouk6T3wZh2FCyBve7aDVMHJZQ36piEL
         5RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743612455; x=1744217255;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2uO9pmTjsejVD/zY6cyyd9PztZvdMOJJd4Zz+Pr1QE=;
        b=v7KHB54T0XVOuN97XMkcccQRN/dA5NgHLpG9BH6Dz18m8/8ZxPqUVpyp/zYGrcvctm
         eQ1StYdqYJbjfedMWiiH2WnOW1oJss0kWfEFfnzAD0ag7DFhgOeS/JFvdJvSKEiqyKuo
         /nagsS0qOm5ieosNCkRzsFih+7B3WZtfjar0bsahrPRQ7jsRTwfD4bUwDWrywSZshJ0f
         AV/bj+MX1INZcvjprdEFY4si4GIypaAQtT+biERU/bdOCOcX5GV0a6yKRV/OlqSSffdv
         2iEaKpAR/xeKmYwipeApZnyKm5cHBpBe11yP+Mvs1EzHwvaKRwe7j+OvdSz1wumKnVIv
         PA0A==
X-Forwarded-Encrypted: i=1; AJvYcCUle/Dajoya8lzmgqdl4gf7r/qjGvdWEIH6vAxOIKdjdGeauWio9g7JuwusHa99fjnKWGlv3MWzBy6jgtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9U4V919Ivts9E9/RqbRCzlZoJc/U8OLsz8tTXXgIa/JRfrPdP
	g0wbxXva1hvfWa9yhXB2qKHlmvwPemQheceJSmqfHA5N2GIP+EIRJi8VmeDn3XUFEX6n93lQ3Vo
	lPfodHA==
X-Google-Smtp-Source: AGHT+IGzG/3y+ietfy34xtDoKHmB1Af67pToNGHEdvk/vvMUa8iuexUCdCA+6jNAoMtTewR2ka6+Lq6tSf3v
X-Received: from plks2.prod.google.com ([2002:a17:903:2c2:b0:223:49cb:8f99])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2312:b0:223:fb3a:8647
 with SMTP id d9443c01a7336-2296c8606e2mr41385685ad.41.1743612455185; Wed, 02
 Apr 2025 09:47:35 -0700 (PDT)
Date: Wed,  2 Apr 2025 09:47:20 -0700
In-Reply-To: <20250402164720.3847573-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402164720.3847573-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402164720.3847573-6-irogers@google.com>
Subject: [PATCH v2 5/5] perf parse-events: Add debug dump of evlist if reordered
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add debug verbose output to show how evsels were reordered by
parse_events__sort_events_and_fix_groups. For example:
```
$ perf record -v -e '{instructions,cycles}' true
Using CPUID GenuineIntel-6-B7-1
WARNING: events were regrouped to match PMUs
evlist after sorting/fixing: '{cpu_atom/instructions/,cpu_atom/cycles/},{cpu_core/instructions/,cpu_core/cycles/}'
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5152fd5a6ead..0f8fd5bee3a7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -28,6 +28,7 @@
 #include "util/evsel_config.h"
 #include "util/event.h"
 #include "util/bpf-filter.h"
+#include "util/stat.h"
 #include "util/util.h"
 #include "tracepoint.h"
 
@@ -2196,14 +2197,23 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	if (ret2 < 0)
 		return ret;
 
-	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus)
-		pr_warning("WARNING: events were regrouped to match PMUs\n");
-
 	/*
 	 * Add list to the evlist even with errors to allow callers to clean up.
 	 */
 	evlist__splice_list_tail(evlist, &parse_state.list);
 
+	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus) {
+		pr_warning("WARNING: events were regrouped to match PMUs\n");
+
+		if (verbose > 0) {
+			struct strbuf sb = STRBUF_INIT;
+
+			evlist__uniquify_name(evlist);
+			evlist__format_evsels(evlist, &sb, 1024);
+			pr_debug("evlist after sorting/fixing: '%s'\n", sb.buf);
+			strbuf_release(&sb);
+		}
+	}
 	if (!ret) {
 		struct evsel *last;
 
-- 
2.49.0.504.g3bcea36a83-goog


