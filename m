Return-Path: <linux-kernel+bounces-829734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C25B97B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024A62E857E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0D313E22;
	Tue, 23 Sep 2025 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/EN9Tqp"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF2313522
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666820; cv=none; b=jkYg6B/Kw7L46DakRJLm4lvPWXF/YbV+IzHJV9/I8tB8eZ7lPbN2em2CWymYAek+yQUs3w0d5yQl6eE+CJTvKUeii7f5EY1+lwfI6/T34tHqdZflfPUL0UA/jVnnxfNQliMxWzJSbbh3iDEblq7wVXWJ7MfMct/gzjewxzNA57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666820; c=relaxed/simple;
	bh=032C1jzLqg1fZhcoAFb+FaDYwGLmXHO7CCdHxbknGq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jwBqAh3oZNYr3aHbXZVzUtAY+WRYt+exSK6yIJLYO9xM0Idfh8zJVx7Hp7AQQLFt0U+CBOhSQnY4joStdYm3MFFNtZ92+CUV0gMuYWC0j5wyCh03ZfIwuAzh5Db0pqtvKm4m1095f9nbG1gIedyNKNo1bUom6JJbo82pJ5tUYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/EN9Tqp; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-30cce8fa3b1so2352578fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666817; x=1759271617; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwMO8Ta7bp1LibQmtclIAbrG9qBpwQ1+Kt3cBbb/T8s=;
        b=S/EN9TqpjNtYiBW3ORRAL4SD6ouPVWihXFeXt7A6up3s9g0kGTN39/a90ODF23VQRZ
         JBUXxt2611P0r/H7dDd7fZpm2H6KeLECtdm/pNFJtJP+6GP4/KW89/LW6Za7/0/7RmUx
         F3ZDEEFhiRdAsAAgkgHhmVn9TxNXVTRtG8Yd1mQKEXpe6l27qvvi5OaPagu0sqbvjC/e
         UW4lDPe96xXANU5UDu2CcJ/w5ohAcolJ1CuN6Ky+puD72bt0W6tg7HANSZtegdAErH7Y
         x62CLO//cd1tz9zL4hcYdLkncipdRHNPaLxhph+gJZnxN6iHzU3vwptsJjsDrWX+0aeo
         bGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666817; x=1759271617;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwMO8Ta7bp1LibQmtclIAbrG9qBpwQ1+Kt3cBbb/T8s=;
        b=ll+izwpJva9fACD/MvIrZOptSN8xpUniH0+ngWsXJzP3f6BridGyWKoi4wWwthC/rv
         3xIxQIssMwj5k+oXbnLz40KDWqaMWbQWnQjGAWc8HM5narMLypxDOCoZmUFEJJzt60iL
         39fB3KaymMdtV5IydfW98/0mYLvbS/ef9rHIblh8rKB2t11USRvNn2+21sgbyIiAwYw8
         LSa9ftv/n75lcIgLFy9YyQCMR3ZIoaOmzMPIohNDlONP1Z1kiE8I2b8NYA5YSqsEDlQI
         Vt5UF27ICEBJbO3do3aRb0sGHQBB2vr8o80ioS+SxiTCMhPc+ihAI+ItcXxeUepQH6pB
         H3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXgdsyd/gMOZbVGdNG2IbrK1ZQCZBJpX9rqt7m41kEAhomgyA7ZFwBvljw/D3YuBVKXiFMY7RijHnWh9+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZfOC//igUMK9Zjzy659ZyUEAJ+6MmbdTSQxkHMVZ1azAHxtu
	GrFKvN5LmIrQYS5aIsQHo5QHVInVPtnwyRSsfT1NQFN4EGIQcjgC7shaL7xs+7VQg3h+eciY15S
	nC+alsJ+niA==
X-Google-Smtp-Source: AGHT+IFUkaxonbuSnKUDxlFH94XNe748/x+8o9XdhcVobBtzaq40h/9LEfVSbzPNzq2DKBRv9BbBiOfpcggf
X-Received: from oabqu3.prod.google.com ([2002:a05:6870:6e83:b0:2ef:de4a:375f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:a1e4:b0:331:15b8:802
 with SMTP id 586e51a60fabf-34c8478c793mr2650155fac.27.1758666817629; Tue, 23
 Sep 2025 15:33:37 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:54 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-11-irogers@google.com>
Subject: [PATCH v6 10/28] perf pmu: Factor term parsing into a perf_event_attr
 into a helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Factor existing functionality in perf_pmu__name_from_config into a
helper that will be used in later patches.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 818be59db2c6..36b880bf6bbf 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1763,6 +1763,24 @@ static int check_info_data(struct perf_pmu *pmu,
 	return 0;
 }
 
+static int perf_pmu__parse_terms_to_attr(struct perf_pmu *pmu, const char *terms_str,
+					 struct perf_event_attr *attr)
+{
+	struct parse_events_terms terms;
+	int ret;
+
+	parse_events_terms__init(&terms);
+	ret = parse_events_terms(&terms, terms_str);
+	if (ret) {
+		pr_debug("Failed to parse terms '%s': %d\n", terms_str, ret);
+		parse_events_terms__exit(&terms);
+		return ret;
+	}
+	ret = perf_pmu__config(pmu, attr, &terms, /*apply_hardcoded=*/true, /*err=*/NULL);
+	parse_events_terms__exit(&terms);
+	return ret;
+}
+
 /*
  * Find alias in the terms list and replace it with the terms
  * defined for the alias
@@ -2595,21 +2613,8 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	hashmap__for_each_entry(pmu->aliases, entry, bkt) {
 		struct perf_pmu_alias *event = entry->pvalue;
 		struct perf_event_attr attr = {.config = 0,};
-		struct parse_events_terms terms;
-		int ret;
+		int ret = perf_pmu__parse_terms_to_attr(pmu, event->terms, &attr);
 
-		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms);
-		if (ret) {
-			pr_debug("Failed to parse '%s' terms '%s': %d\n",
-				event->name, event->terms, ret);
-			parse_events_terms__exit(&terms);
-			continue;
-		}
-		ret = perf_pmu__config(pmu, &attr, &terms, /*apply_hardcoded=*/true,
-				       /*err=*/NULL);
-
-		parse_events_terms__exit(&terms);
 		if (ret == 0 && config == attr.config)
 			return event->name;
 	}
-- 
2.51.0.534.gc79095c0ca-goog


