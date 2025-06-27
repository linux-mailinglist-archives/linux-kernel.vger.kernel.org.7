Return-Path: <linux-kernel+bounces-707092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21358AEBFB6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 21:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B5F4A6C37
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BA62EAB8B;
	Fri, 27 Jun 2025 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgld8tfy"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2E20A5DD
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052271; cv=none; b=RZQY7BS5L5Ea5aKO+1keA6i6YXnPI+Ar21/rkKORMZ1pUp9ys7BnNfAxL15LpdoJfyfnWfB1aFkAbK+bx3r2qnh8Y7oBegV9ZKIkZlgl79wc+V+VK/JY3jQZupL+6XRAdublnum2cCobvUEyZlV+/z0QU/iZGTNLRZueaUkJtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052271; c=relaxed/simple;
	bh=dVViqCmusnN5RUFVuc4ZulRAN9goYmkUJllZ6fYirJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=piWz7MLje+RaHIYxgljn7oX/Gvlm+6FMCO2l0J9RNYlvSakDJmM3BFkdKMSHIx0sm12crYG0x+KwdlTgFr0Ip0lGaM03K7ehD9KBgqZoxHUV/fwm9g+6Gz9nurVRzoEGsF3Vjrbm0i2vEZe8j/hb1pYd/YjQNxTbwnQRy9D7uVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgld8tfy; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2ef38fe89d9so1530333fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 12:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052269; x=1751657069; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nV5bVvayoyTyNMPh50De+OAEo7DL4+9cdaEzSi+im0=;
        b=mgld8tfyvOg1uGjED4mzwWuu9eFV7L/ct+qqdg1Ahy8IAD+TumNhHAk/MTYM8eDql6
         +zW+0CVWlQljv2putpqjsg1b5X8aX0FAZx9ZvKzXEBvmskc8q/aDG2ca9V9oe9b6wvOB
         vuAOHepZ0esUAQzOheV+TET45rK2g1c1TrCbJIw8k+EFi9XkynHp4eN0eHyc/qV8jEck
         51qw/wjx2ppz9ZXaWfUuT/k8xC3slbkBLRWsuFFRyi/4t165XP+AerTDt5gapvIZFvIQ
         duZnheKFeTbNzoQIOKQuViv743fDIJXlrFrELeajGn24qiDkKXbXmBUtLi4wR+x+0+dm
         FCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052269; x=1751657069;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nV5bVvayoyTyNMPh50De+OAEo7DL4+9cdaEzSi+im0=;
        b=euqnOrHbY136PYrHitzE3tmiCcPqYl+Ca3SWoQbSLE5nVXkHFQou7GL1T3s9bHVh+t
         6cgKmOLzl/Aa6NGJtTkadymNQ7TCPt8TOXDpXq7gnd/6apN8IZ7x7SJtrMulosdheQ+E
         m7PmiWBo8LqQHJPS0aAcilvXDEevUkahnLmzm4npHy5TS05X5aassOSgsVPwfVOu/InB
         2MiVs4bXJmKrzhZwoz7D2a4W+yveEctRJwKyWA+69hU8Ah1HSdTuqFPgsEYDDJGVGlgo
         yEkBZ6QyQOVC1CXibIGqMb9Hy89tre9NMqq9OCs1MCkMvyfAa4za4NwXs1xGos5WtKq/
         wfKg==
X-Forwarded-Encrypted: i=1; AJvYcCUQqxFVn5Cj3yRftouVBP3kQNeezsHqBaphJw3X5VWiEvyxOqooDNm4YwSPEUjnju1ndWJGJfBCiR8a4Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyshZh+TXJessa61C4Ed3759u2szoGznng8Q3hFQwkDwOQexUKW
	IQsmDmnjhf3arOFhooimToWJP+qHCFwGPFv1OB4wXl+wRSnT0HHHdxw5YrVNLLYfTmXNHXLYO60
	zbD6S6JZpbw==
X-Google-Smtp-Source: AGHT+IFNCUxEUiyLdVvcT9lNT2EQpgKf5ie5NGJ4wgyjmV1TUh8aP4lQE4E6/WPuYgaTNMQG/UaaM/LTBCSK
X-Received: from oabqp4.prod.google.com ([2002:a05:6870:ff84:b0:2b8:4b50:daff])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:4e44:b0:29e:559b:d694
 with SMTP id 586e51a60fabf-2efed7297f5mr3001891fac.32.1751052269450; Fri, 27
 Jun 2025 12:24:29 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:09 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-5-irogers@google.com>
Subject: [PATCH v1 04/12] perf parse-events: Allow the cpu term to be a PMU
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On hybrid systems, events like msr/tsc/ will aggregate counts across
all CPUs. Often metrics only want a value like msr/tsc/ for the cores
on which the metric is being computed. Listing each CPU with terms
cpu=0,cpu=1.. is laborious and would need to be encoded for all
variations of a CPU model.

Allow the cpumask from a PMU to be an argument to the cpu term. For
example in the following the cpumask of the cstate_pkg PMU selects the
CPUs to count msr/tsc/ counter upon:
```
$ cat /sys/bus/event_source/devices/cstate_pkg/cpumask
0
$ perf stat -A -e 'msr/tsc,cpu=cstate_pkg/' -a sleep 0.1

 Performance counter stats for 'system wide':

CPU0          252,621,253      msr/tsc,cpu=cstate_pkg/

       0.101184092 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 37 +++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7a32d5234a64..ef38eb082342 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -192,10 +192,20 @@ static struct perf_cpu_map *get_config_cpu(const struct parse_events_terms *head
 
 	list_for_each_entry(term, &head_terms->terms, list) {
 		if (term->type_term == PARSE_EVENTS__TERM_TYPE_CPU) {
-			struct perf_cpu_map *cpu = perf_cpu_map__new_int(term->val.num);
+			struct perf_cpu_map *term_cpus;
 
-			perf_cpu_map__merge(&cpus, cpu);
-			perf_cpu_map__put(cpu);
+			if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
+				term_cpus = perf_cpu_map__new_int(term->val.num);
+			} else {
+				struct perf_pmu *pmu = perf_pmus__find(term->val.str);
+
+				if (perf_cpu_map__is_empty(pmu->cpus))
+					term_cpus = pmu->is_core ? cpu_map__online() : NULL;
+				else
+					term_cpus = perf_cpu_map__get(pmu->cpus);
+			}
+			perf_cpu_map__merge(&cpus, term_cpus);
+			perf_cpu_map__put(term_cpus);
 		}
 	}
 
@@ -1054,12 +1064,21 @@ do {									   \
 		}
 		break;
 	case PARSE_EVENTS__TERM_TYPE_CPU:
-		CHECK_TYPE_VAL(NUM);
-		if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
-			parse_events_error__handle(err, term->err_val,
-						strdup("too big"),
-						NULL);
-			return -EINVAL;
+		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
+			if (term->val.num >= (u64)cpu__max_present_cpu().cpu) {
+				parse_events_error__handle(err, term->err_val,
+							strdup("too big"),
+							/*help=*/NULL);
+				return -EINVAL;
+			}
+		} else {
+			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_STR);
+			if (perf_pmus__find(term->val.str) == NULL) {
+				parse_events_error__handle(err, term->err_val,
+							strdup("not a valid PMU"),
+							/*help=*/NULL);
+				return -EINVAL;
+			}
 		}
 		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
-- 
2.50.0.727.gbf7dc18ff4-goog


