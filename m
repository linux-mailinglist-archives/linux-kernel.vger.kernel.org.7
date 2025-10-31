Return-Path: <linux-kernel+bounces-880892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75FEC26CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DC21897C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61273310762;
	Fri, 31 Oct 2025 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZm7Fwfi"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458311AF4D5
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939742; cv=none; b=iZrmdvngt0sSgu+QEkvqMeTiq78b78g6RcNP03dhckUIWOXogTEu+A1PTC2UXDWQ8gjm8W4cj/t8gRTlJWaB07CltI8P4GkNuAtzatnohO/moNkqKKXXSnlZjGE3RUIPbdPZ0nqyfWTT72XQDO/YcCVGedXl8E1Hvr1PdkyvXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939742; c=relaxed/simple;
	bh=82aBPTw4nAD0S7uZR++gRXJuMqWxM2qxpvikhp8S274=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=eXMVKOW/zwY3SoVz57cq9X3aBGLmkBL+r6X0n1NtV2RYJrC105e5RZZT2J2yCk8ugmfWL9h9VrqgexZedOzlUWVMPCkiNOLOA7KMmppthshr+ziSB/irXaHlu5EuuphVTFCd4YB+vxEcyF6BmQOzY8CHcG4PyiTXD+SoLzGEtT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZm7Fwfi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-294fb21b0e9so20654025ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761939740; x=1762544540; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bp6I5I4DuTfJ4CVISPFiYfryrJjJqDYIHDeQo3MNWD0=;
        b=IZm7FwfiVM4mDJ9TIN3sfNZF5qGlkh1QyGR5hmDOUeSr6BeqMFSrYz6j5lah97pG2m
         rRlCqCapr+GheybT1wAqK7523LQxGhjHuwqdVDEK2GkdIx7Y7raZzNWHAPJTliLnC7Jl
         a0RbDoaVP/C2gb15blwBWCZxskwnJAJPEiUuXroordIadFcGIb3lg3LGo+dphlXNwcZ0
         7C5PqU8byrbzrtWb5AIRk0XpjCPxbo5ukY0mOOi/+ek2IEVg+mWdOIvkpEDY2j7BtLDl
         qBkBKJjzE2ftlyfzgiZ9pk0OUtsZm10Hf6tY2oSkwyW9FATMvydkDxp9+7KHAe/VqqF0
         F3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761939740; x=1762544540;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bp6I5I4DuTfJ4CVISPFiYfryrJjJqDYIHDeQo3MNWD0=;
        b=qjp3YZFcSkUlFXxKU8GkVk7/7OVmuNfmfVIsnsttOTFdKYF2ebH2+BOGZFZa+XoupK
         CXJ4oRqX7Lfm8WV/2xLTJx/35tljlUQorD1emvWPd16IjSUtpM2/aFEfT7ubT6DSgxHi
         eX76SOqdsAfvYV+oTdboA6ZOktoxQQK1qZDNZ3Iq+DdmIO27mxsUQT6EBlg5H4aPVgWI
         yARDxQRSh4t8yYz5rBS/z/cILzOdDv3fxynlvkeZs7vYhjbSBruJTwENRaeWlscrXzv2
         gVszBJOCqIfzULNyxWyq3gIxDAbLfD8UNlJLicpNA3s4sm6MyTZ+MajSKM4nyUta8okn
         uSOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkmqKCalp4ZcoZudqev+K0AsSoOHhZk92Dr9dqfgKcNIUmobnrlGWzFu0SnoFBjITqJx1buWl9QV+82nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2N99CrZUAanxjprNGclo0OHXtRjX5lg4742mq+rePL8VkrMF
	lyQQqFQEsO0Kw4RvGg7Ctl6Euz8PENHZBilhyMUnhH8RNQttpB7w3cN5Mo9tXwsj35zxoqJT+KA
	HPtG+omP3+Q==
X-Google-Smtp-Source: AGHT+IGPSqxzD1iE4N1SB4IFZfSib3S04XhI1jpHw9sLosjIbaZkKdOvcl8DgLBv1kdvkkCw4YsjfV+5YGcq
X-Received: from pjbcl3.prod.google.com ([2002:a17:90a:f683:b0:340:9a37:91a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ce:b0:27e:ec72:f62
 with SMTP id d9443c01a7336-2951a35eb36mr74883535ad.6.1761939740620; Fri, 31
 Oct 2025 12:42:20 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:42:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031194216.1518072-1-irogers@google.com>
Subject: [PATCH v4] perf s390-sample-raw: Cache counter names
From: Ian Rogers <irogers@google.com>
To: Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Searching all event names is slower now that legacy names are
included. Add a cache to avoid long iterative searches. Note, the
cache isn't cleaned up and is as such a memory leak, however, globally
reachable leaks like this aren't treated as leaks by leak sanitizer.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Closes: https://lore.kernel.org/linux-perf-users/09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com/
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
v4: Fix testing cache not tmp (Namhyung). If the find fails store
    "<unknown>" so that future hashmap lookups will not repeat the
    failing find.
v3: Fix minor comment typo, add Thomas' tag.
v2: Small tweak to the cache_key, just make it match the wanted event value.
---
 tools/perf/util/s390-sample-raw.c | 55 ++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 335217bb532b..c6ae0ae8d86a 100644
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
@@ -132,8 +134,8 @@ static int get_counterset_start(int setnr)
 }
 
 struct get_counter_name_data {
-	int wanted;
-	char *result;
+	long wanted;
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
@@ -164,17 +176,50 @@ static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
  */
 static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 {
+	static struct hashmap *cache;
+	static struct perf_pmu *cache_pmu;
+	long cache_key = get_counterset_start(set) + nr;
 	struct get_counter_name_data data = {
-		.wanted = get_counterset_start(set) + nr,
+		.wanted = cache_key,
 		.result = NULL,
 	};
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
+	result = strdup(data.result ?: "<unknown>");
+
+	if (cache_pmu == NULL) {
+		struct hashmap *tmp = hashmap__new(get_counter_name_hash_fn,
+						   get_counter_name_hashmap_equal_fn,
+						   /*ctx=*/NULL);
+
+		if (!IS_ERR(tmp)) {
+			cache = tmp;
+			cache_pmu = pmu;
+		}
+	}
+
+	if (cache_pmu == pmu && result) {
+		char *old_value = NULL, *new_value = strdup(result);
+
+		if (new_value) {
+			hashmap__set(cache, cache_key, new_value, /*old_key=*/NULL, &old_value);
+			/*
+			 * Free in case of a race, but resizing would be broken
+			 * in that case.
+			 */
+			free(old_value);
+		}
+	}
+	return result;
 }
 
 static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
-- 
2.51.1.930.gacf6e81ea2-goog


