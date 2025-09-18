Return-Path: <linux-kernel+bounces-790391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FEDB3A678
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FD97BB381
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A05133CE86;
	Thu, 28 Aug 2025 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2i02jBe"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3833CE85
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398783; cv=none; b=lD/Zd+7TLoRxv2mcHsCsLacagJDi3gZ8p6T/wY4zq5a5MaQ0McYf/MjHDSF3LiubJhuHkhskLhTwDfXE9L0jMq9gy5U3tUTfCSIp7lZv5UmDK8RESGWZrT9a14u1fhFTOJ9n070ZJix0Bz7C53OKNINjZgJCE4PEoprEwvqQXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398783; c=relaxed/simple;
	bh=5RNlpH94YmxwMoQ115+maASfaBgFk2Uk2E0i84yLtHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=I6hFnYpSGnO17VY4Dp3gsR48rcX4vQuh4mf2Kpb0YxMCMIH/Z4HOBwHbX7OhlIvtzrHYimJzlXjK9OaUOgn74PJ89r7dv7yU8N5JWImn7aGbriC0LmM2xovR4IpaFKx+msN96/MrANO81T8o6FLV9C/zJoBnVuAXjGz0O0cE8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2i02jBe; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77057266cd8so1047965b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398781; x=1757003581; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jncfgT/0bBfpzuhBE3b818JduGXNs7mcO/c+kLSIAAY=;
        b=L2i02jBeRWpnWTr3BnIV+3dceKzRb2C/Gx3oOzJZzbmUEBZtcVFKNxqV0OCPwMBCOT
         TIjIDBiCkSDYV0RcLvshhyF5kC9JG4kL3L2DiWFg0c6TeZshNtAkdMPOE6SRlN5yMUBL
         cWmir/91mp54bhXhq90Q1KcT6VRryfj5z/0zag6bcgtnr3+0eTbibE7HUCN09UkCon36
         kU9Xcyu9/A8bmxrf0k/ads3cw+uN8vARtHjsi8IAOLtMjARrJAQCaTcm093URmxkiDlx
         b97nHTwq8brx+8vaPSAgy57ff7piAMuVlvUXoMak/SJpHS8UuYA6qPfKC2FfsisWkHIf
         X4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398781; x=1757003581;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jncfgT/0bBfpzuhBE3b818JduGXNs7mcO/c+kLSIAAY=;
        b=GzTxnev+XuYUox+3M4B40Dgyb88T/rQxci0UeVUYPzpE9o3OJ2lLA6OVXCx95djrj0
         ILcH62lAThmlJqA8HR6GwvCS6WmCgofYfmEVb3yW+4r1rhwm/tDicw7dh7HfFE98qlAs
         qvDYVasiHvl5uLoqeoxRvqjwHmxqUOd8/m87AwTrH24BS4N/7fYZoL7rcIMHmsGWSXYP
         PlNkg0QhQnW0WBKvSzIcMV1qRWuA37XkkmJ2HKnoVCYxCmjOhHiOeKI+8ZGXRmtpBqvJ
         IOfQoj0Ar6bX9injqkOkzf747Wakhf+QPxFa/mEAHcURsiheq9L6+A3J5x3HbVYcuTJu
         7mSw==
X-Forwarded-Encrypted: i=1; AJvYcCVjwIHTNZMVIJruh4o+Tr9c5ve34+bWSqyMQ+0EUq9pHVlZluL9U8I3UGyxOT3e7+4WSVwVxEnyjaS3T5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlocaNqQDonuQn1YOpNnFDqObXeCaO6Eckd/FEyQkR++ac90K
	7wb3oEL+ysP7OYVgGo0ZchzEPAHPuYlQMMVmVIisow0sg+4SxCCvl2TTpjsZJbAfxnunE58LSwa
	WoKsSjX467g==
X-Google-Smtp-Source: AGHT+IFwPp04Jq0Q9xz8QtXa8V+EX5L5Q5gm6DvQZH5eGzMeMUoGKqBU2UF2P9XbjvXfUyFVTQxIU3NuLHV1
X-Received: from pfve11.prod.google.com ([2002:a05:6a00:1a8b:b0:76b:651e:a69c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:810:b0:771:fca5:cbc5
 with SMTP id d2e1a72fcca58-771fca5d224mr9876852b3a.20.1756398780843; Thu, 28
 Aug 2025 09:33:00 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:20 -0700
In-Reply-To: <20250828163225.3839073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828163225.3839073-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-11-irogers@google.com>
Subject: [PATCH v2 10/15] perf jevents: Add legacy json terms and default_core
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


