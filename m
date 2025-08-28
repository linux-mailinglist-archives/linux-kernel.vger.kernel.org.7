Return-Path: <linux-kernel+bounces-789333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394F1B39402
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37E46876A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645C429D28A;
	Thu, 28 Aug 2025 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcP/ZGtG"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BF229BD82
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363374; cv=none; b=g8fyoylvypLQ8H7xPswZAVu43xe5JXb3QMrs0rboiaajNVBQdEU2/SHhp/yeq0bvMYgyMLo3YImL/yv2akHt88Bfb7ebDEtkYonTzG/VmY9kazB2kp3oA2vqoAi6YDvEg7yPHfgFuWN0vpp5zcggZ2o/K9EzKaaT9l9ORTEfLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363374; c=relaxed/simple;
	bh=5RNlpH94YmxwMoQ115+maASfaBgFk2Uk2E0i84yLtHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jO/vqEXoawcZZtZW1LVggywzreLJwbQOnTBkaoNCalO0my9Kg6k+AY8qdMO9KW2PIRTIbzaJowGI9frIYGFYoWhdT4q/TKOXssR2wQI/EITlkDXSLyWb+XUBqqD0k+jV4vbvGVjbImMVNWwmhC7mX504HaR9RqDcw/+QWeSJ7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcP/ZGtG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3278bb34a68so650115a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363372; x=1756968172; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jncfgT/0bBfpzuhBE3b818JduGXNs7mcO/c+kLSIAAY=;
        b=dcP/ZGtG04uB7371QUtS7aj6sDQCtG0qXEZqOCdVm8UEIu6ImN2sKBiPfcVr5dHXAo
         UqL+7alKZc+kRZWEPh8l1sMu+Zy6eGoJtPtlkch37wr2de1kcYhFjKrpHZuMY7xwh2yz
         6IwQFVlD6YU1Hv5LRgwUKL+YDms2GJiADKYxnO6VsgXT0VCLeBE6VeG8DdITbRe1c2eV
         Z3f7mGO5BETzmqivkiozQdp9X+Jhspfh5qVqOQ2/M2KnUFs9Lri4XmhVpGVEeIox4Txg
         Fc7+K9V9s8pueuL8c3KMJIh5jG0Se1K2uCP4SDIlqRCBmg8hS2VSMKWUBMzKNgohw+bv
         oH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363372; x=1756968172;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jncfgT/0bBfpzuhBE3b818JduGXNs7mcO/c+kLSIAAY=;
        b=GGHYUWVjRNWhCrTruklCB5m9Z/1f/Yd8MAd1dPwqKTnFaQJM02FCfk90rhE6pxiWWa
         M6TN8AqK9SUtXXzk7OMxu6DAh4YpZTKlBbeHAl7UhdF9Ws6Tuqb1Z9vSP4/CL1YB86LH
         PL0tHxDzgp+94WpstmnkjinT288AWVQRYFI7pyekkRTe7KWth6VVcbumdKJ9D2SBiG6c
         7FrvDdteCOcAfFv/K6VRmmrVP+bf8b1Etj4dXUk5hY2dKt5/D2HNtKjOsH37aH1EP0xA
         U181KOVdJbyQ/BrROXtx/ZyNeg22BOJksqQ73dSpJ93L/oUfQFnlRvkX7jHNblyH8Xe/
         m5CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjoMkNmtuCE01CeHf3Vt/9ubdjp4+Ly2AnMORP2fpZN8hJYJUekJafajiK/rTppQ+6PB5QSKcT06aOzkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3G7xbusVoiUpdACxXKxDCTUXoDWTpDz33SLa+kG6/CtKCcUhC
	QSofQT6y5WmpR81Gm2pDTfRNourBZ3TCIRRWc9NXGhoGs6ZgXzFUF3hFFUuWhJj5jQcuzJ0RJ3k
	JSt7vxh8vCg==
X-Google-Smtp-Source: AGHT+IHJI/NN7gcvojhm6bF8524wJJ8DfgJq6mhLErGkLP9dpLpsSji2JGlhtHLKyvReHSgV5lGyshT5BPfK
X-Received: from plble6.prod.google.com ([2002:a17:902:fb06:b0:248:753f:cb3a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec2:b0:245:fe27:fe80
 with SMTP id d9443c01a7336-2462eeb004cmr308789885ad.26.1756363372114; Wed, 27
 Aug 2025 23:42:52 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:26 -0700
In-Reply-To: <20250828064231.1762997-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828064231.1762997-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-9-irogers@google.com>
Subject: [PATCH v1 08/13] perf jevents: Add legacy json terms and default_core
 event table helper
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
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Add json LegacyConfigCode and LegacyCacheCode values that translate to
legacy-hardware-config and legacy-cache-config event terms
respectively.

Add perf_pmu__default_core_events_table as a means to find a
default_core event table that will later contain legacy events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 18 ++++++++++++++++++
 tools/perf/pmu-events/jevents.py         | 24 ++++++++++++++++++++++++
 tools/perf/pmu-events/pmu-events.h       |  1 +
 3 files changed, 43 insertions(+)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 041c598b16d8..cbfa49320fd5 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -482,6 +482,8 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  pmu_event_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return PMU_EVENTS__NOT_FOUND;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -707,6 +709,22 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
         return NULL;
 }
 
+const struct pmu_events_table *perf_pmu__default_core_events_table(void)
+{
+        int i = 0;
+
+        for (;;) {
+                const struct pmu_events_map *map = &pmu_events_map[i++];
+
+                if (!map->arch)
+                        break;
+
+                if (!strcmp(map->cpuid, "common"))
+                        return &map->event_table;
+        }
+        return NULL;
+}
+
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
         struct perf_cpu cpu = {-1};
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 168c044dd7cc..c896108ee4cf 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -325,6 +325,8 @@ class JsonEvent:
       eventcode |= int(jd['ExtSel']) << 8
     configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
     eventidcode = int(jd['EventidCode'], 0) if 'EventidCode' in jd else None
+    legacy_hw_config = int(jd['LegacyConfigCode'], 0) if 'LegacyConfigCode' in jd else None
+    legacy_cache_config = int(jd['LegacyCacheCode'], 0) if 'LegacyCacheCode' in jd else None
     self.name = jd['EventName'].lower() if 'EventName' in jd else None
     self.topic = ''
     self.compat = jd.get('Compat')
@@ -370,6 +372,10 @@ class JsonEvent:
       event = f'config={llx(configcode)}'
     elif eventidcode is not None:
       event = f'eventid={llx(eventidcode)}'
+    elif legacy_hw_config is not None:
+      event = f'legacy-hardware-config={llx(legacy_hw_config)}'
+    elif legacy_cache_config is not None:
+      event = f'legacy-cache-config={llx(legacy_cache_config)}'
     else:
       event = f'event={llx(eventcode)}'
     event_fields = [
@@ -972,6 +978,8 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  pmu_event_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return PMU_EVENTS__NOT_FOUND;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -1197,6 +1205,22 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
         return NULL;
 }
 
+const struct pmu_events_table *perf_pmu__default_core_events_table(void)
+{
+        int i = 0;
+
+        for (;;) {
+                const struct pmu_events_map *map = &pmu_events_map[i++];
+
+                if (!map->arch)
+                        break;
+
+                if (!strcmp(map->cpuid, "common"))
+                        return &map->event_table;
+        }
+        return NULL;
+}
+
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
         struct perf_cpu cpu = {-1};
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index ea022ea55087..e0535380c0b2 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -125,6 +125,7 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
 				   void *data);
 
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
+const struct pmu_events_table *perf_pmu__default_core_events_table(void);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
 const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid);
-- 
2.51.0.268.g9569e192d0-goog


