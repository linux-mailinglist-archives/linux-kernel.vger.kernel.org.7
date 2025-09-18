Return-Path: <linux-kernel+bounces-815781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EDCB56B15
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6345A17B9C4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9BB2E3716;
	Sun, 14 Sep 2025 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wll3tEUL"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777122E229E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873509; cv=none; b=AxymB9KcFEJqZyJzqQx94+uZBEVoJ8qT64P/kKSreutwTksoFSaRGUpQvQwLEgVbMEpHghOHOHHGXc/6Ya3Ic+jHbLsEtM2AECSNJ52hhwmRBGIZ7KN7gAKeNfHQbC9u2hxw2WNCloJ0/x+e4fkbVc6xaSzTarrXuKlQDiZCjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873509; c=relaxed/simple;
	bh=eB9R+GWDlRkJi4fyLVcozFnCCRn55xiRSaHCnmxto/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HTdhPod1UlNvlmJb+YqGbh6Jbje7YE1lA5s2FEFgRE8a+vTlrZHLP3+PAT7GYkkr7AM7VhqM4+0YjGnSO7EZM0SEF8v69v16frTl028t6kLcRUhnj5kooUsh0q3ciogS0KqQXIMqXat82C6QsgPiII/zyMzjM+1GJD0SxLzkf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wll3tEUL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54abd7e048so1273850a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873506; x=1758478306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YoDyopsq7DcM4kqOS1D41oOKYJaF2Fp77KmpsjqBvM8=;
        b=Wll3tEULgA4G2nvBqbkBw6DK5xmlhgONAzkzmIKKdB5EPjQBDK3RBbrZlPx/2ajilF
         rLC679ScZGmUZEJk9vzL9Ic5u4M8tfQHsw2MxD1tFJ2u6S/CHflJD7027pZ8uUxQwZeA
         fMQ/dFTR2VM4AO7k1u7vN18Q99qUblBKKVKvEZTDrtweVUhse0uR0sjdJbvzcPQGelQA
         vB8/1TQ+YtCz3zUOzl8MRBkavXCO8+SfzFCPttR8swq9ekDrMHNPLRf3m0MXN+Fi3HJ6
         ewjiNC6o3Cb9Kd7GSpY9XijmGNR6IDq5sLWye3gtvlsWdPsMNxVrk6NsoEGuBpr7+U7P
         RZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873506; x=1758478306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoDyopsq7DcM4kqOS1D41oOKYJaF2Fp77KmpsjqBvM8=;
        b=tqvOvE8r+LOMEtUFBdQdR2BbtbkKRFLrlIwqgbslU3nc7SFbFdf5+kNdHkvZjWtn1L
         p6+c7M2gc7PL44zOW3PIlJmDJcjTIgsyagOxhVfYdvDHyQuA3nxDxE9M0NTnx0dVsHLN
         Sg1aV48M3S7CiDJANm7F77nnU4DzWsNYItLuk7Dvd+Uxb+3wSsHt8hU/5EkLPpvH4Bnx
         yZxIO9qBzdP1L/Z2VcumHmuekxW8c8cH1PDRrDHO3v3V6ndlMSctK7tJwlkrj+xzhqvm
         +U2CH3VnYPztPPQ2MXkSgqNev+ajrTtbYNCBkmwePV4lmxI1uCUGDGNoHgPoL5MH3Mff
         KM1g==
X-Forwarded-Encrypted: i=1; AJvYcCWe3bpTAZ5Ey0rHZuWsRLU7DBKIYeraz/WGep8Z5VNZ/dKAE/qarN18epE3XweoTLQkqDQD+SMdBCslRsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPnG/6fgufmz4ykxLd1HsLwP4iiBoZBrBy1CWPEXgvUvEY8tM
	LzfjrXOiv9gIjhflnm1jv8wYg04tfYjCzkREKS9Qt6ABhQ4sxozauqASyWZh0b+UPjLWuzKsb0q
	xnnRi32IMVg==
X-Google-Smtp-Source: AGHT+IHfaDrhjgj43Y4r5wrpLd/W23WcT7pPdYAyM/c9JqvqQCRih4RpE2FLxWV+dodmnrKwqW/QsIOV92RM
X-Received: from pjvp17.prod.google.com ([2002:a17:90a:df91:b0:32d:851f:b1f0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a12:b0:247:b1d9:774
 with SMTP id adf61e73a8af0-2602a49b103mr12840644637.5.1757873505820; Sun, 14
 Sep 2025 11:11:45 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:10 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-11-irogers@google.com>
Subject: [PATCH v4 10/21] perf jevents: Add legacy json terms and default_core
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
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Add json LegacyConfigCode and LegacyCacheCode values that translate to
legacy-hardware-config and legacy-cache-config event terms
respectively.

Add perf_pmu__default_core_events_table as a means to find a
default_core event table that will later contain legacy events.

In situations like hypervisors it is more likely that tables will be
NULL. Rather than testing in the calling PMU code, early exit in the
pmu-event.c routines.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 26 +++++++++++++++++++
 tools/perf/pmu-events/jevents.py         | 32 ++++++++++++++++++++++++
 tools/perf/pmu-events/pmu-events.h       |  1 +
 3 files changed, 59 insertions(+)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 041c598b16d8..2393b3a7a4c9 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -461,6 +461,8 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                                     pmu_event_iter_fn fn,
                                     void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -482,6 +484,8 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  pmu_event_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return PMU_EVENTS__NOT_FOUND;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -502,6 +506,8 @@ size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 {
         size_t count = 0;
 
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -580,6 +586,8 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
                                      pmu_metric_iter_fn fn,
                                      void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 int ret = pmu_metrics_table__for_each_metric_pmu(table, &table->pmus[i],
                                                                  fn, data);
@@ -596,6 +604,8 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
                                  pmu_metric_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -707,6 +717,22 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
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
index 168c044dd7cc..1f3917cbff87 100755
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
@@ -951,6 +957,8 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                                     pmu_event_iter_fn fn,
                                     void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -972,6 +980,8 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  pmu_event_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return PMU_EVENTS__NOT_FOUND;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -992,6 +1002,8 @@ size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 {
         size_t count = 0;
 
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -1070,6 +1082,8 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
                                      pmu_metric_iter_fn fn,
                                      void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 int ret = pmu_metrics_table__for_each_metric_pmu(table, &table->pmus[i],
                                                                  fn, data);
@@ -1086,6 +1100,8 @@ int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
                                  pmu_metric_iter_fn fn,
                                  void *data)
 {
+        if (!table)
+                return 0;
         for (size_t i = 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu = &table->pmus[i];
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
@@ -1197,6 +1213,22 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
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
2.51.0.384.g4c02a37b29-goog


