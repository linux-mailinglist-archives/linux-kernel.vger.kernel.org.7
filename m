Return-Path: <linux-kernel+bounces-815773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C170B56B02
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81670189B5B2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FE42DF130;
	Sun, 14 Sep 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+no/hoQ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4B2DCC01
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873492; cv=none; b=o6Wnf1eXp91na7JJOEaazVc9DxFStLnf6fdk32OmUQ2brOeAWNUFfHGHC11LNNcafD4Go4JN5rVofrNf7k/YMxtuCjw4bPaNJUDLhGImrYn2Z1FPfyKAXbvlF2zOwYTK6NjpLeMPGRF59S7uFwqhUekuKYM+G8HIYT5yxMMp/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873492; c=relaxed/simple;
	bh=MzbOrRB81V3a/DICE3YLMrKiA/UYkoE3SQM5vtH5Elc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uJaeDZgeHidx5876Y1zaVs61f/ZDalY0I5PYHERGEjevgb/Vw5g47xyFaPHyguabOU/AzODhMaeuHBnTAKbBUS+HPQ+qUarzbVZA3hA5APGOMkD4Qa2DcP/XH28KguzJnXKvC3gk5LYovdUBIrMEb4crbrnljweCRKUsAObpBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+no/hoQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-26472a98ab8so4218245ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873490; x=1758478290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/8NzEKabySeuJN7szepE2Zk6AAtH+l92Sib06TJNws=;
        b=j+no/hoQNjaXzKoaVchiN9Ws8oqRSc7yQ8AYM0vG8a2NybgdHPSeqUoOIwMOVaRuIG
         aYqu/eJ6vyMd8rPIX7hjAHULxxqt9N0gWgaGLBVTYOwqrEDUTTA5yUIWQbZjq9fipNWj
         VCjN0nwOhY8vdywvuR3O3IlYB/6UYNYEGSablP9iIspb992E9wNxbue2a9WoP1CITHvc
         0b7jhPbXuHSG9xrfSrxHfGCl+lwn3OXJAae2spoyARqX+ZSON7XlYoQLYj8+1AOv9N8b
         fvBs6aRi8IYaUDruGmqlcYB2TtgASjxDy1kd+dgjiXMXkCS8G4dDL/IBHDALZtlmW/Iy
         soqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873490; x=1758478290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/8NzEKabySeuJN7szepE2Zk6AAtH+l92Sib06TJNws=;
        b=Qo99T4ZVxVaq2wd6Km8+fdq1Mv3V8PMm6bllBont6tdTPtLux6LSxnUbyBDt7oiaAq
         yabcITGWj9CjZyoehoexmymfLiKI/WeynhPnh5c5O5kz6JDuqug96lEfFFkyyee8u8Ni
         E5O53ku8Q4CyTZfofnmwiMLU/3kJ3225EAd4+libIymgyHZ7ZjDz8Pr6V0rYji8fHL+B
         gihRhG+FbUZYX6y4laC+sv18d/QHr4oqDKW4+civ8mdtpt9OAaS55tFYDVa5XKisQVCf
         ZB6n0KE8pwNGx/jTwmj02JedenAaGsudhOez7u62Ep3iurAq94W++N8Y00t6/v5GZI6j
         kvng==
X-Forwarded-Encrypted: i=1; AJvYcCVVgxRgH6q5uLjey2KvH4aj0XMH78mF3LvTdSEhiajNEdr/BVX/6fFR7toMeuLOXturYRLUXW0wrbTXNAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziI90wkQ+xzybN1mnA8F9+KUlgVVwSvr9IsPgA6ezah1SwWz97
	/bYANtalfEGjasP1DiQjGHgXEBctL2RM79Tl0mrkpruZbjRHwS9zx/NwIYRYlD8UX/FHHCr6c/S
	Pbp95lmP1Fw==
X-Google-Smtp-Source: AGHT+IGT+j3eO3ei941mw44W7Tk+ylCm/sa/Sg9HVaFHN2KYQYZ7DRkpOyH5nEeymXKlLYoO47ew63TgMD2q
X-Received: from plok6.prod.google.com ([2002:a17:903:3bc6:b0:266:d686:956a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d50b:b0:25b:9879:cbd6
 with SMTP id d9443c01a7336-25bab92d3cemr147906915ad.4.1757873490075; Sun, 14
 Sep 2025 11:11:30 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:02 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-3-irogers@google.com>
Subject: [PATCH v4 02/21] perf perf_api_probe: Avoid scanning all PMUs, try
 software PMU first
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Scan the software PMU first rather than last as it is the least likely
to fail the probe. Specifying the software PMU by name was enabled by
commit 9957d8c801fe ("perf jevents: Add common software event
json"). For hardware events, add core PMU names when getting events to
probe so that not all PMUs are scanned. For example, when legacy
events support wildcards and for the event "cycles:u" on x86, we want
to only scan the "cpu" PMU and not all uncore PMUs for the event too.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/perf_api_probe.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 1de3b69cdf4a..6ecf38314f01 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -59,10 +59,10 @@ static int perf_do_probe_api(setup_probe_fn_t fn, struct perf_cpu cpu, const cha
 
 static bool perf_probe_api(setup_probe_fn_t fn)
 {
-	const char *try[] = {"cycles:u", "instructions:u", "cpu-clock:u", NULL};
+	struct perf_pmu *pmu;
 	struct perf_cpu_map *cpus;
 	struct perf_cpu cpu;
-	int ret, i = 0;
+	int ret = 0;
 
 	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
@@ -70,12 +70,23 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	cpu = perf_cpu_map__cpu(cpus, 0);
 	perf_cpu_map__put(cpus);
 
-	do {
-		ret = perf_do_probe_api(fn, cpu, try[i++]);
-		if (!ret)
-			return true;
-	} while (ret == -EAGAIN && try[i]);
-
+	ret = perf_do_probe_api(fn, cpu, "software/cpu-clock/u");
+	if (!ret)
+		return true;
+
+	pmu = perf_pmus__scan_core(/*pmu=*/NULL);
+	if (pmu) {
+		const char *try[] = {"cycles", "instructions", NULL};
+		char buf[256];
+		int i = 0;
+
+		while (ret == -EAGAIN && try[i]) {
+			snprintf(buf, sizeof(buf), "%s/%s/u", pmu->name, try[i++]);
+			ret = perf_do_probe_api(fn, cpu, buf);
+			if (!ret)
+				return true;
+		}
+	}
 	return false;
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


