Return-Path: <linux-kernel+bounces-790728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF4B3AC54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D812B9869EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447CC3469EB;
	Thu, 28 Aug 2025 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lao8KscN"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7C343D7D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414814; cv=none; b=dJby0Ucxa4Ttb31xOSFklKbKJ1A7ewRrtU+THFzJA+RodQ5KWl/tLhbYXyYe/7iiQvJN309BNK7X8YCsG3gvXFP+frtAIu8a32YzXqWQZ1F6sK1D83yA7B3Vf69HcNRwLn5AneSz6nbi+1h6DRB5o9SufsDvy1giAEAQi2jsaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414814; c=relaxed/simple;
	bh=cGiqp2609n1oTaANiwlFbzjTZ8N8XEsfL8XDZ3CpjoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bas8LC+yzSMJQNVAPkBN6R+rV05MYlVBXLdDO4rNCTsnA6jypt0IFLLHaFGxxkFw6EngPDklDDahs4OdyWXgmOoJ2oRnSset/aTd12ngvHPALiLVint+XNoSSiM9/wYK/o8sJjx03woOMbfhIPqQZBEJ2xj/jTHHtPEPn1NLm8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lao8KscN; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7720f59c0f6so1271963b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414812; x=1757019612; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SG69qC8TS2vqNH1d7JKnmusq8kEe14Kz1SV6vbtW3xk=;
        b=lao8KscNIZMk8QPfAH0kex1kbXTWQzvHgiXIICfKxVg0dq6HSwgn4emOG7gN15JIDB
         qi0yZGS0UoXZx1/fL+wrXyC6iKUQHOdqjb+Ozq9/MYmegKmKyn+oNwOQ2SJANcGMQLMz
         oahD4TecUygPCkyLNNy93LXRYahQ0tjWLvyedVgIiHI3XxABx00iGZuZzvio4W6b9QwL
         tpjwekPhBSsOOGgJX3hPtDKtZpxYF2XGs96rflQcC22hdaLPqos8DvUlSHWOwS8009HC
         niCO6tpf87AkZTLnHzfP8hVjd6igtZ4gZdIXmvWVLbL2Q6UyX8KJvpG8bWTVFaI/3M3O
         P6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414812; x=1757019612;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SG69qC8TS2vqNH1d7JKnmusq8kEe14Kz1SV6vbtW3xk=;
        b=HhsN/GIaZgYfNTnaTYX8kviSeqErzrBrx5t9k+rlogUGVeL9A9R5vFY10GHyqHdbAI
         CZ72PXrA6qhH9a07LRhiMSSexWsOIbWSqlvJj7mzodi6H5duwwLPrvfjJh3MkqgE5NhJ
         bY4xJdOM2jHWYmirPt/X4HV2Uc7OwyFhGb0nUNyfcA9U9YnzxzUGlG7wdnIZnGsxTprZ
         AfeYv6l5S1e9ZkMqajuC4r1P2PKM4ZaMUMrou/HNnMg14LupLwgHq1cVAcUqs+4j1IZk
         iqayUw9OYRtBz0P25rb53ccw9ftgq68iGHRxc/tgj4hYTVzN8eMjaIWpoxVnqdHRgUYE
         EY2A==
X-Forwarded-Encrypted: i=1; AJvYcCWuIKspEJUqfybHAKWhOX5jcZL5R0IShxQgoVj9OiGATHE8QCQgJiKa23T2UwpaQZINJc3U+zbT7Q41FgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6I6SVZjhetDAxGodPRv42lluN4uHcJIGynYy6xcwKPn9GjYu
	tPS5c073UcW3Nn6BUzYFvn5QIZhN1bT1q6ai4WGUHaR3845GfsvxsaOmXqT9keZFt87zZ6ZnH3u
	jtJLIAqjEaw==
X-Google-Smtp-Source: AGHT+IHnFEEKL1sMAzGRzVq+N+p0VPdoNCMM14ZHnaShzlsg6sP8SA7k1EC573zzCDGpitqSgdQFXaueaFTo
X-Received: from pjyf12.prod.google.com ([2002:a17:90a:ec8c:b0:325:b894:3c4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a124:b0:243:bb99:a0fc
 with SMTP id adf61e73a8af0-243bb99a3a7mr2524055637.47.1756414811671; Thu, 28
 Aug 2025 14:00:11 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:25 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-11-irogers@google.com>
Subject: [PATCH v3 10/15] perf jevents: Add legacy json terms and default_core
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
2.51.0.318.gd7df087d1a-goog


