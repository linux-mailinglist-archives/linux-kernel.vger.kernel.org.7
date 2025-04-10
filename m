Return-Path: <linux-kernel+bounces-597320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C98A837F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 06:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32C43BE46B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 04:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13B1FBC8C;
	Thu, 10 Apr 2025 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWTHK1G3"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6791F2382
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744260352; cv=none; b=Vi+7Lhl1nPz5gsC9oo3hOTO/85L+z8aUUc5C36O8bn6bJ9EiEiK1X3dER7xPyuwv2jMRe3h0CZRwkgcvYQ4jvDhM0EdqPPisvyuV4e4ErYLGr4TcvAGR1Q5lJZN7Q7IetStLwZ79iurPl8fiQjv4kZ7EC3TIZ5QpTFadUmPsfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744260352; c=relaxed/simple;
	bh=5IWdSEs5RkgxPVslBBnAOjR4bNfmYgvr5rnu//KW2f8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=h/qIfjIubzCrTBFu0K1a0trgTeM4FGDDwQuJ8GfQhFHTximICWkauR1TZgZXI0fBj1K1fWPru33g4/KUcPSiBWyPApkJ1c7XqfYsl910k1ndNSeZr/UXPZn674aiM0/SGhxyy0xVBCTCFzYxTXRsWi/mBphu/R5jDOpKaEerLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWTHK1G3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225ab228a37so3790705ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Apr 2025 21:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744260350; x=1744865150; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcrobgRBNrn1wKrgLsSHY40XqyQBijRELNTpL5HXaa8=;
        b=RWTHK1G3GPc06uO9QRL6vA/N6SuV0l3oJ+x+8Ix3Nwy3juGo5aBlDSsRtOUbOFti0C
         JiUckLqmKOlAveBUTtLZycJppZ++CjKoqiJIr/RgM6YBm+JZTjzCz3nVOm6KKLVZhBmS
         5U63EryU8Uga8tD/GOWti6ioeE02sAryCF1r+V8ypDiv0fkx8c7nrHFWeOkMQrwCS2lp
         vGZGCN9rp6DsdHOn9JD9EoKo87/o/j157kEC120i+TCzHItNbN7ESE9h2zFCvewD+D5Z
         sfyf4PnwIIyEvtaONyyOvL9CP2NR6D1ebPKm2oxLRvk7dMzuVhBo6R9FoVewXNyxPlTr
         4+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744260350; x=1744865150;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcrobgRBNrn1wKrgLsSHY40XqyQBijRELNTpL5HXaa8=;
        b=I54J8hinpIB4N4sGVijoL68eMRGBFxrFzu9qre/zOydnaKolY51/tQwftpvSsBSFqQ
         GQfLbgkv8GTPYmPE8q+Y1tFny4Id7rNBSHV/j+U4YAVImZOK1b9ajWUmfQPJ4I8ouN+m
         W3ZZ20zFl4YfiUjp4/ofUELEfHaXRyF0nTwgXOWNB8Cnn6JmCBrQtrdNG2b/xwzJ55wo
         UxaYDQX+9oRua4hKkrNwQLSBbEkrK8LJNYml4qQ+uq9H1V9jWv4nBh3bgp1eVKQV1oUE
         1nheWOdj+5DmYr9wauJYU+gDmZ/RgmmflzjlgeQ/FCTFaED17rhGAECmo595GFyFuB+h
         NPlA==
X-Forwarded-Encrypted: i=1; AJvYcCUSTgFAzORJQOPvMscUwZwlKyX42eNumdd6Ci1BbctLflIIfwU9b9DB6Z7fKxDIJF40dw6y5MmIFq80248=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkaZs8tQ4e2Jyz3cS4DusQ09YHdq8vpn/Fo/3hrCOJTtKiP+BQ
	J9x1s7q7l1ZE0b9phEqiHSIokLUS18ovuvUobuPJ8lgTkNg5xcR/SQbzS/mfAJk5/v5iMiuYBOr
	8jEzK1Q==
X-Google-Smtp-Source: AGHT+IE1L1jhTV/Iqzj96GX/ADTgcRAasuICr/zf33xj4shXNQzNr2Gtp4uDqEcgLNtPkC9CEe/8mHnmT3oT
X-Received: from plblc7.prod.google.com ([2002:a17:902:fa87:b0:21f:40e5:a651])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db03:b0:223:35cb:e421
 with SMTP id d9443c01a7336-22b42c2e587mr18531705ad.49.1744260349994; Wed, 09
 Apr 2025 21:45:49 -0700 (PDT)
Date: Wed,  9 Apr 2025 21:45:31 -0700
In-Reply-To: <20250410044532.52017-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410044532.52017-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410044532.52017-3-irogers@google.com>
Subject: [PATCH v1 2/3] perf fncache: Switch to using hashmap
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The existing fncache can get large in testing situations. As the
bucket array is a fixed size this leads to it degrading to O(n)
performance. Use a regular hashmap that can dynamically reallocate its
array.

Before:
```
$ time perf test -v 10
 10: PMU JSON event tests                                            :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok

real    0m17.887s
user    0m17.525s
sys     0m3.310s
```

After:
```
$ time perf test -v 10
 10: PMU JSON event tests                                            :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok

real    0m15.551s
user    0m15.092s
sys     0m3.009s
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/fncache.c | 69 +++++++++++++++++++++------------------
 tools/perf/util/fncache.h |  1 -
 tools/perf/util/srccode.c |  4 +--
 3 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/fncache.c b/tools/perf/util/fncache.c
index 6225cbc52310..bf9559c55c63 100644
--- a/tools/perf/util/fncache.c
+++ b/tools/perf/util/fncache.c
@@ -1,53 +1,58 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Manage a cache of file names' existence */
+#include <pthread.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <string.h>
-#include <linux/list.h>
+#include <unistd.h>
+#include <linux/compiler.h>
 #include "fncache.h"
+#include "hashmap.h"
 
-struct fncache {
-	struct hlist_node nd;
-	bool res;
-	char name[];
-};
+static struct hashmap *fncache;
 
-#define FNHSIZE 61
+static size_t fncache__hash(long key, void *ctx __maybe_unused)
+{
+	return str_hash((const char *)key);
+}
 
-static struct hlist_head fncache_hash[FNHSIZE];
+static bool fncache__equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return strcmp((const char *)key1, (const char *)key2) == 0;
+}
 
-unsigned shash(const unsigned char *s)
+static void fncache__init(void)
 {
-	unsigned h = 0;
-	while (*s)
-		h = 65599 * h + *s++;
-	return h ^ (h >> 16);
+	fncache = hashmap__new(fncache__hash, fncache__equal, /*ctx=*/NULL);
+}
+
+static struct hashmap *fncache__get(void)
+{
+	static pthread_once_t fncache_once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&fncache_once, fncache__init);
+
+	return fncache;
 }
 
 static bool lookup_fncache(const char *name, bool *res)
 {
-	int h = shash((const unsigned char *)name) % FNHSIZE;
-	struct fncache *n;
-
-	hlist_for_each_entry(n, &fncache_hash[h], nd) {
-		if (!strcmp(n->name, name)) {
-			*res = n->res;
-			return true;
-		}
-	}
-	return false;
+	long val;
+
+	if (!hashmap__find(fncache__get(), name, &val))
+		return false;
+
+	*res = (val != 0);
+	return true;
 }
 
 static void update_fncache(const char *name, bool res)
 {
-	struct fncache *n = malloc(sizeof(struct fncache) + strlen(name) + 1);
-	int h = shash((const unsigned char *)name) % FNHSIZE;
-
-	if (!n)
-		return;
-	strcpy(n->name, name);
-	n->res = res;
-	hlist_add_head(&n->nd, &fncache_hash[h]);
+	char *old_key = NULL, *key = strdup(name);
+
+	if (key) {
+		hashmap__set(fncache__get(), key, res, &old_key, /*old_value*/NULL);
+		free(old_key);
+	}
 }
 
 /* No LRU, only use when bounded in some other way. */
diff --git a/tools/perf/util/fncache.h b/tools/perf/util/fncache.h
index fe020beaefb1..b6a0f209493e 100644
--- a/tools/perf/util/fncache.h
+++ b/tools/perf/util/fncache.h
@@ -1,7 +1,6 @@
 #ifndef _FCACHE_H
 #define _FCACHE_H 1
 
-unsigned shash(const unsigned char *s);
 bool file_available(const char *name);
 
 #endif
diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
index 476e99896d5e..0f4907843ac1 100644
--- a/tools/perf/util/srccode.c
+++ b/tools/perf/util/srccode.c
@@ -16,7 +16,7 @@
 #include "srccode.h"
 #include "debug.h"
 #include <internal/lib.h> // page_size
-#include "fncache.h"
+#include "hashmap.h"
 
 #define MAXSRCCACHE (32*1024*1024)
 #define MAXSRCFILES     64
@@ -92,7 +92,7 @@ static struct srcfile *find_srcfile(char *fn)
 	struct srcfile *h;
 	int fd;
 	unsigned long sz;
-	unsigned hval = shash((unsigned char *)fn) % SRC_HTAB_SZ;
+	size_t hval = str_hash(fn) % SRC_HTAB_SZ;
 
 	hlist_for_each_entry (h, &srcfile_htab[hval], hash_nd) {
 		if (!strcmp(fn, h->fn)) {
-- 
2.49.0.504.g3bcea36a83-goog


