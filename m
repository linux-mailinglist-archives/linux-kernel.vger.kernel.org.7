Return-Path: <linux-kernel+bounces-619164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F82A9B89D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 21:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4446D4A3F63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29086293B53;
	Thu, 24 Apr 2025 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ee5m52VV"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A11293B44
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524721; cv=none; b=G23WmVyfCc0CP2Ex5p7AVie1WdJd2wmK1i4NgMDTAXj/Xy1cxY2cK/TiDc3Mn9hHAeG9jWNPwMGiRfFXKgOKnnfTTFyZ8BfkJwh5/dG4yDqGs/eTInFRkIX4jd7PZgfkVGUaATX1bTPotnG/KUpGT3QvsGhlmKwE7iyefmhdKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524721; c=relaxed/simple;
	bh=V/+YIeqXyWe+VtI2AkO9avaTu+8PfbklD7Z5gyGY4Uw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=H0ewCyYJK28UkArvcB+WJ8FgPrcDrbvU4pMZs26bHHZyiSY+gfDnvv4g7uV1uLppN5nG+pWum8oZ9K7VRCQQAO6IujXXXvfA21G+haVo2+HfNYUNHhG0noO1xleiiNz3AuGPPMLklFFBzPzPIcbHaS1sfrKjWXnDWKTjjzVfiqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ee5m52VV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3087a704c6bso1452205a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745524719; x=1746129519; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIKGPOJtNTYeYYPtYxV7HNqMQQDAOFZ9Hntv87mu0iI=;
        b=Ee5m52VV4vdlbSeryeq2ihHrqGZNj8soB0jRLmUwWjoWdP3hJp1gg5en2nv8nmdNIF
         Doo7vId/eMBhE2Auvsjtzb4ka9ciPMfECzm3DxcTLEqRC02lcqFRWh8iaadSrI+W9l/K
         06z4vnvbi7H2cDQV+20ZVZOnniF96O3mlDEzFaSzQbsPEST53+W42addKjOE/FhbUiAS
         ysd1n4XhZX2PQ8O+Lkl6ZoDO3H9GDrpQlem7trtzo9AWvjv1GThN9FJizWN8SXEM9DJ5
         fPRPfVzR/g7Jg1Ks5mysKCRfnJLtUlmf5zgTRj3bVgvE1iCGp/6x335IYCnoIiN3rfF1
         h9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745524719; x=1746129519;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIKGPOJtNTYeYYPtYxV7HNqMQQDAOFZ9Hntv87mu0iI=;
        b=NoLQVhfP0fKdBYF9qUm7GIaQAuUIbJGaL8ICYddrOwuvEuiwmFPE0mEQdH19pdTePT
         CC0u7N1h85Rg3Vr6OeKmAkS/C19TWwXMNma6QVrrK4dCFp5nP8vNt3KHUl2B5is+98iw
         ZX2xdgjZVZKfHmBRBWNuu3fxH3PO3NqdEJdUwA8tSzo61gG0liQglQv3PI/gJ8ODunkS
         9JNgVTwHGl8YlKM925ECAB5aXdqiwB9WQykcjzJIf8JOmCQtvc6M4kRZO9tl1QMHNzaV
         EC0HfcvkKl+TN4/ShVAhEzdJQ6GxcvKmFqxEC29bS8R5kvqAKSG+mcgA44EDbxV4loGC
         Sn6Q==
X-Forwarded-Encrypted: i=1; AJvYcCURBl8HpqhKN5TnVgsDMLQjhBHoMpuXQiRAs38g8XQeE+QTGlgOwDfedVJW59sK0NijNnbuozeMQfqYD4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBE4d7FQjCmQCdmoINsbOrSK15CG16VhmsnXxgcyxKnc541b+C
	ZX9qQirHyE7tPtZ6/y57IbzPvpS28rUMeH9LRJt6S4guMTsMYWKwMnlKwSUPvwE1nreGJxTYDZA
	qlpXuOQ==
X-Google-Smtp-Source: AGHT+IHpI6N+hwPdiWTusoFuXWW6V5bErVcbyPVk7quV9c2Ci3OtmV1wT+h5SXqQ734pFr5OlPEeRufAxah9
X-Received: from pjbsf8.prod.google.com ([2002:a17:90b:51c8:b0:2ef:9b30:69d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50cf:b0:2ff:6e72:b8e9
 with SMTP id 98e67ed59e1d1-309f56b55cfmr1220579a91.25.1745524719071; Thu, 24
 Apr 2025 12:58:39 -0700 (PDT)
Date: Thu, 24 Apr 2025 12:58:25 -0700
In-Reply-To: <20250424195831.1767457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424195831.1767457-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250424195831.1767457-3-irogers@google.com>
Subject: [PATCH v2 2/8] perf jitdump: Directly mark the jitdump DSO
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, James Clark <james.clark@linaro.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The DSO being generated was being accessed through a thread's maps,
this is unnecessary as the dso can just be directly found. This avoids
problems with passing a NULL evsel which may be inspected to determine
properties of a callchain when using the buildid DSO marking code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/jitdump.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 624964f01b5f..b062b1f234b6 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -14,9 +14,9 @@
 #include <sys/mman.h>
 #include <linux/stringify.h>
 
-#include "build-id.h"
 #include "event.h"
 #include "debug.h"
+#include "dso.h"
 #include "evlist.h"
 #include "namespaces.h"
 #include "symbol.h"
@@ -531,9 +531,22 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 	/*
 	 * mark dso as use to generate buildid in the header
 	 */
-	if (!ret)
-		build_id__mark_dso_hit(tool, event, &sample, NULL, jd->machine);
-
+	if (!ret) {
+		struct dso_id dso_id = {
+			{
+				.maj = event->mmap2.maj,
+				.min = event->mmap2.min,
+				.ino = event->mmap2.ino,
+				.ino_generation = event->mmap2.ino_generation,
+			},
+			.mmap2_valid = true,
+			.mmap2_ino_generation_valid = true,
+		};
+		struct dso *dso = machine__findnew_dso_id(jd->machine, filename, &dso_id);
+
+		if (dso)
+			dso__set_hit(dso);
+	}
 out:
 	perf_sample__exit(&sample);
 	free(event);
-- 
2.49.0.850.g28803427d3-goog


