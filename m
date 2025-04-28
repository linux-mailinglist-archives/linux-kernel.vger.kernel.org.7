Return-Path: <linux-kernel+bounces-623902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1F5A9FC46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 23:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BA11711B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 21:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536DA214A81;
	Mon, 28 Apr 2025 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOmuHLiX"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6E20E323
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876069; cv=none; b=ZNOlJ8jIDjrEmtsKaxeecUBseRy1aa7WPUszWuxAwSrDBzkwoJeeaTzJ/12NHfkbIG59P1J2I+yfzLZ89bgJP/1QWDwDrM0+w+Ctnz3bBpKACXSKIl1hVfDsN90QfM/M0ke11YT1vn1FfStO4sX/mevvA0GFl9cr1b8ajjdx3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876069; c=relaxed/simple;
	bh=V40jgn89oCqUj2APh4IzT55mkyQEVKPYbZ7P8iJSJCA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=T17gQmrvml4lQgR6HvTS3vI9eG68BHKy31H53C68G5oz0l9XDStpgsq45HZjdkFZHynZ7B5ehkgLN6s0RUOfJYdXh2k+hb5ZbnjGxJ+ZTOpWOI1InFYVLtoPlP/1hZLhynidIqnt4dvB1goeF0NhQGTCCGii8pceeh9qKwQUPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOmuHLiX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30364fc706fso4238940a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745876067; x=1746480867; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xuESyA5cUoWs5jJqB9j/HDlv/ORhTzd9f0YGR++Z5O8=;
        b=EOmuHLiXyOf9f64AcXuZd4ygYCP3tiD8Uoi12dAox0UBmpa7MGe2FqQkoSdcoHXrXf
         2r88IEzI3JwWSyJxUUmlMHJ4nI8wrf0CFsCBwj0iOkMHyApAkhOfBvaAjiQW7alJIeBR
         n7a14YEqHfJqHm1wQ/D0/4xOJd+f+XOEjDzxdno1JhhQ1m7vZnou6m4mmRYtwcs6wc3V
         hH0jy8goTL99lth+bWyfsibykAylTSS+wdjCnbeETasx6VBsqZV+Yejf6v1TryIdgvcm
         kolhWy/duS/H+J1dDbWxF8ioRBXK3kAzOR3F/rFczChqKBblJHKG5WM7z+Bt+4WSKqRo
         Xyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745876067; x=1746480867;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuESyA5cUoWs5jJqB9j/HDlv/ORhTzd9f0YGR++Z5O8=;
        b=pKyOmMNHIcIT93iRBusQUEYbGr0nrpXXcdWRyg+o8ruzgOMKa2OVgBKi7JNeqeKUa3
         wfT8W0GGgLkwBLNRAIiXmlu73EK6DDB5AE/KrBzT7bpgSv13iDFGW8Cf7IP3xPgha6D3
         FdljbG4FmrNk5gs4qUNQHl2TZPmz2EPGFiedPPPuYw4z6VDvku0Jc1C2YJYKcRXCDYtR
         0wvE++BgfNXYRmozaTOolKlAy7aPFGI+SYO1p1Co1ifQk+IAxIFSmhfKDtbBSahDhkhL
         U6iDtzvwl8AfaS7DJg1MQGtplK8QAgS71rDk9oFEmPmW1/a6XkEVhjrXrqFcVZE51vfI
         i81A==
X-Forwarded-Encrypted: i=1; AJvYcCWP8KidAQZTjc/XsbNcSxke+NXc131Gmp4ikrM1IsSxxSDjPMEthq4kHTNbIR470ycABz1/2+1jeRranLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN9Yidi1ch6X1cBrPgvZnj0tl8TYPv4QKNRVA/3UeC/Qg9NJ/0
	m2U8H5Z1SENRJM59dolcRZcNoO1KfChJup0QforslLwMVKUZzu6QOI98Bp20FyrkGHqN/L6f08y
	kdWCwEg==
X-Google-Smtp-Source: AGHT+IFQ1/vv1A5xPiEdUGqODpwKWqIzLynqCqdF6Urj40CzB1mXE9SuSSMssTrB3nCrHwtPn4/85q2/eLLC
X-Received: from pjd16.prod.google.com ([2002:a17:90b:54d0:b0:2ea:5084:5297])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5403:b0:2f9:c139:b61f
 with SMTP id 98e67ed59e1d1-30a220c4f94mr1392825a91.14.1745876067485; Mon, 28
 Apr 2025 14:34:27 -0700 (PDT)
Date: Mon, 28 Apr 2025 14:34:07 -0700
In-Reply-To: <20250428213409.1417584-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250428213409.1417584-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250428213409.1417584-9-irogers@google.com>
Subject: [PATCH v3 8/9] perf jitdump: Directly mark the jitdump DSO
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
2.49.0.901.g37484f566f-goog


