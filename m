Return-Path: <linux-kernel+bounces-878756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF3C216B3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA923B84BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867C36838C;
	Thu, 30 Oct 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLxGrbSz"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641A53678A7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844338; cv=none; b=lhvRO4eM2QtPLWPvhDml3laq1TcAx00+14Jdw7R/PEPD95Q8cPt+wwglfh89ghn8NkHqtiO12sg31MkIF/pqsPpEc9ybHqCGdqejef8G8sSdPTH5klBn31sJQE4FLLrliXq9P9JcIij26PcMrUrL+jKsQa8QimeY2AKd/g5Sp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844338; c=relaxed/simple;
	bh=btQzL2ZL/PLD+psnQSivSO5arjE2jQOSxVQpDVtS2L8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=YANyUtv9Ot3+SDZMaNRyZgxL1PVErLsgfLLVNScQf5ZiO/KHRmUGcPu6CuTPYgXMF4CdaNfEsggAM4hdMKfD8jFf7EOKeJeiR0jnuwMIa/cNyxHpkR7KxvD52JykBUJhFkv9BwH/GgQqYQ3sCiSC9qHt1NF3nkE8E4lRbpRw+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLxGrbSz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-294df925293so12097825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761844336; x=1762449136; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zdgUIWhxFpBO1eWPwkXjelAIvbaSYwWWLU1wd9xgw1s=;
        b=PLxGrbSzB4T5dYv8UKRjNJcEOfkDhhqXCaXJskItooFAn8q0FuRyJTjzU2cJcYn6VH
         exFiCvhGz8SN49fyANE7RQEm/gqG6sCzW1jixObmi2UdqTvn36GfLTql/0+a6wE92FT9
         UxhNGocEU0EDLM2mBhWMLPhc46NFKsRKG7ItoUSbdGrSsDj93gjJXgdDw1PVgi0YefPC
         /FKSulSPwzSEDbZ9WgbkxTKoeV30eYCQUD7JsAPW7v7KBcUPGjVk1XNE7bIzrBZMyJLN
         lgweQpRLNk9uT3Mi8mdWXeh8b00Nz53VMhdXV3L7YVeS0CJK3qOdJLbulxXe9gN3mnzq
         4fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761844336; x=1762449136;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdgUIWhxFpBO1eWPwkXjelAIvbaSYwWWLU1wd9xgw1s=;
        b=vUBnyq+HQV0Q5jNPwyM7lsSnTZxDfi3+Xv8xsUH5Ki/ibSRe4yqlrnn4+b/deAV42l
         vHq+I428OfsqUzj0/fskx+LmYvOzXHx+CU29mZ7o7CtT2wgfiV0hnPtAXs4HDho8yvqS
         H5LJmVLEfrVisa0dbnzIWiceGjTdGRxmzINK3+YOnbvswHSX/sreLiTExz924yYcqu9p
         SR8Yjs573riwrU8VKFjwS7T4i9IV9xpQEn0CN5JRlpEGhsiMkLwOanRQoQcz/AGvSc0s
         9iY62QZCmsU+DHIzNd8VWQRamWS6Mc/a3zk+XKz0cBYgIuaNklK8U9VcQ80DMbu2KnLh
         7AXA==
X-Forwarded-Encrypted: i=1; AJvYcCUK+E5acrC7/bysM+5xB1Xp5DGf62SfUCZ+8CvxffXYadvEvSjcbXCNna3ceF8YFZ4Iwn0gfylzkAZOeYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylqqepWhDi8yPRuzU6/kHdsluw0g/eGAZK72CkowkjLHFtWf4a
	iX0g3D32wyqerHxjbcllLwTdAeIzxYYMvp7+V/3i/5HHAB9lE53j6B70wATbtl5MatU6Vxht4ZJ
	qfCRBJSiONw==
X-Google-Smtp-Source: AGHT+IFqOe63wYQO+7Jrsp5fFjA9y7kyFxhqMfIHUQGb1bFWI5ah1MbT82aHXilcNfQcq6K8OX3UbTQ0w9Sd
X-Received: from pjsd13.prod.google.com ([2002:a17:90a:bf8d:b0:33b:c327:1273])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c10:b0:294:ccc6:ccfd
 with SMTP id d9443c01a7336-2951a3a2fcbmr5902745ad.24.1761844335727; Thu, 30
 Oct 2025 10:12:15 -0700 (PDT)
Date: Thu, 30 Oct 2025 10:12:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030171211.1109480-1-irogers@google.com>
Subject: [PATCH v1] perf s390-sample-raw: Cache counter names
From: Ian Rogers <irogers@google.com>
To: Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Searching all event names is slower now that legacy names are
included. Add a cache to avoid long iterative searches.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Closes: https://lore.kernel.org/linux-perf-users/09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/s390-sample-raw.c | 52 +++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 335217bb532b..2d0a0c4360e4 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -19,12 +19,14 @@
 
 #include <sys/stat.h>
 #include <linux/compiler.h>
+#include <linux/err.h>
 #include <asm/byteorder.h>
 
 #include "debug.h"
 #include "session.h"
 #include "evlist.h"
 #include "color.h"
+#include "hashmap.h"
 #include "sample-raw.h"
 #include "s390-cpumcf-kernel.h"
 #include "util/pmu.h"
@@ -133,7 +135,7 @@ static int get_counterset_start(int setnr)
 
 struct get_counter_name_data {
 	int wanted;
-	char *result;
+	const char *result;
 };
 
 static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
@@ -151,12 +153,22 @@ static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
 
 	rc = sscanf(event_str, "event=%x", &event_nr);
 	if (rc == 1 && event_nr == data->wanted) {
-		data->result = strdup(info->name);
+		data->result = info->name;
 		return 1; /* Terminate the search. */
 	}
 	return 0;
 }
 
+static size_t get_counter_name_hash_fn(long key, void *ctx __maybe_unused)
+{
+	return key;
+}
+
+static bool get_counter_name_hashmap_equal_fn(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
 /* Scan the PMU and extract the logical name of a counter from the event. Input
  * is the counter set and counter number with in the set. Construct the event
  * number and use this as key. If they match return the name of this counter.
@@ -164,17 +176,51 @@ static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
  */
 static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 {
+	static struct hashmap *cache;
+	static struct perf_pmu *cache_pmu;
 	struct get_counter_name_data data = {
 		.wanted = get_counterset_start(set) + nr,
 		.result = NULL,
 	};
+	long cache_key = (set << 16) | nr;
+	char *result = NULL;
 
 	if (!pmu)
 		return NULL;
 
+	if (cache_pmu == pmu && hashmap__find(cache, cache_key, &result))
+		return strdup(result);
+
 	perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/ true,
 				 &data, get_counter_name_callback);
-	return data.result;
+
+	if (data.result)
+		result = strdup(data.result);
+
+	if (cache_pmu == NULL) {
+		struct hashmap *tmp = hashmap__new(get_counter_name_hash_fn,
+						   get_counter_name_hashmap_equal_fn,
+						   /*ctx=*/NULL);
+
+		if (!IS_ERR(cache)) {
+			cache = tmp;
+			cache_pmu = pmu;
+		}
+	}
+
+	if (cache_pmu == pmu) {
+		char *old_value = NULL, *new_value = strdup(result);
+
+		if (new_value) {
+			hashmap__set(cache, cache_key, new_value, /*old_key=*/NULL, &old_value);
+			 /*
+			  * Free in case of a race, but resizing would be broken
+			  * in that case.
+			  */
+			free(old_value);
+		}
+	}
+	return result;
 }
 
 static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
-- 
2.51.1.930.gacf6e81ea2-goog


