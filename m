Return-Path: <linux-kernel+bounces-603612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98FBA88A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 19:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6853717CDDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 17:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AD528BA9C;
	Mon, 14 Apr 2025 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dv/WpeWd"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218728B502
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652523; cv=none; b=jWSbkGYiAEaojso8oPMVN3q8p9Dis8p2R+wlWq7pA7tj8IojES0IJlr1C6dyUcGXQQw1EhjobRxMlH2SKqwTHqmgONgf9IcFMcyxtNFJCpzdiiFzC74HA/VjrAHJxxP+fYdIyGKmvWU9ELSieHo5+M5zinrQ4CSU9Nb0SOoZiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652523; c=relaxed/simple;
	bh=aAdzhzW38NjSMOvy9Z8oUVow8Z9ErhbvXK/Tehm7JYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NnXGPhWxtn1dR0dURqpvE5xajIVTAlfhAk1dis6X0ws1MBVxn9NDqQPAJmlT93TPTt1fOXzK2iEamKXzpXLhfrLDQZZlx6GXTsJ2iifDaT/qwEvcduwd2AKU14797+7DjtUj+qeKGSY7abTbY0stZkFq8QCZjKGxdDTXxtkwTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dv/WpeWd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-229170fbe74so38033545ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652521; x=1745257321; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rPTy94ffbUEhOKiK1IPtcVt4myAa/NejYMC0O4TJ2i8=;
        b=dv/WpeWdwBXaGMk39ivgRu5BqbUJnCRjxIT9W53FEFbCs098MZ+xsbWPUCObl8lNTb
         Toy6Lvfrl8WjC13qtNWPPtFc6RhgOdMdervxwO48IDhyvjd7EL2UqEhHtofKWa6+un6H
         ncuPMzr95N8cGd50149fTBVc1JPkc89BYYQgliwcbzl5AgqXdcg1hB0yV7QnDCqcm+l+
         nV3sOJ63ec/ziEwGkXbL3O2hxoJvtGVajc/Lqv555QubtOSyFl1WChYz58XmUTlt+3a1
         uTUzyDcUbfQP/wc8d6xKIX0ehADSvtfIXMhdRMFo22HQ+U/RpsCrxmETYFYW5eFX1C12
         4bKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652521; x=1745257321;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPTy94ffbUEhOKiK1IPtcVt4myAa/NejYMC0O4TJ2i8=;
        b=gNP1SueoEl8MOzKTxefc7tt1QaB6fCqKlhC6YooQ29ma1z8hMOtCyarcd4/MPbuOUy
         yimSJLwwI1VkePDw62QioFzyoIGY6uHo8r3HR8ng4leAjhQrH6T34jEip7WwBR2uezqO
         Q3039ovEe9s1szHeLgfX+6EB5aJJJZymEREo56p81D0X3Qr6gVXpOk/NI82X8so7K0jF
         eaZf6EOIuvYy0kGOkWxBB/7N+BVOyvYFzPTyzK2xlPSgd0FYfqtFNqkACYiXQC3cGsen
         cvrz/6IHx8fD0g5Jd5xYd9RSGZBi4uzig8QmK7/hO+o7ty/X8iPPcfqzAaoYckKNISs3
         o0KQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+OPczGataERWq3uDM47hfb8xee8Oj8IJWINlOuigxjEx72QPvNzk9+SqKedA8zWtRLIrHml24LzVokjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSIUL2iz+aIuVwDV6YA/aAKxAGBy6ZpptgtLLR/QLb/TrtZCZ
	re5d8MzB9NAj7/sf3SJymxerOUsMFDtabztRsH+RYHNX74XDUp6UDYW4qki49zYmFLVWdiGty8V
	gwZ3lig==
X-Google-Smtp-Source: AGHT+IG/gtBJJm+4WgoCQHddaWlnyMc8L5+ILxbIyEsaY8UY7mmKrwp+YEP7LUoIH2k4YQQ0A0Ws08PeGF+f
X-Received: from plbkg5.prod.google.com ([2002:a17:903:605:b0:21f:3ef1:c029])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230d:b0:223:fbc7:25f4
 with SMTP id d9443c01a7336-22bea4b70cbmr164437455ad.14.1744652521390; Mon, 14
 Apr 2025 10:42:01 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:21 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-4-irogers@google.com>
Subject: [PATCH v5 03/16] perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Try to add more consistency to evsel by having tpebs_start renamed to
evsel__tpebs_open, passing the evsel that is being opened. The unusual
behavior of evsel__tpebs_open opening all events on the evlist is kept
and will be cleaned up further in later patches. The comments are
cleaned up as tpebs_start isn't called from evlist.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c       |  2 +-
 tools/perf/util/intel-tpebs.c | 33 ++++++++++++++++-----------------
 tools/perf/util/intel-tpebs.h |  2 +-
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1974395492d7..121283f2f382 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2595,7 +2595,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	struct perf_cpu cpu;
 
 	if (evsel__is_retire_lat(evsel))
-		return tpebs_start(evsel->evlist);
+		return evsel__tpebs_open(evsel);
 
 	err = __evsel__prepare_open(evsel, cpus, threads);
 	if (err)
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 74b43faab986..566e0ddcad88 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -12,6 +12,7 @@
 #include <linux/zalloc.h>
 #include <linux/err.h>
 #include "sample.h"
+#include "counts.h"
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -189,18 +190,16 @@ static int tpebs_stop(void)
 	return ret;
 }
 
-/*
- * tpebs_start - start tpebs execution.
- * @evsel_list: retire_latency evsels in this list will be selected and sampled
- * to get the average retire_latency value.
- *
- * This function will be called from evlist level later when evlist__open() is
- * called consistently.
+/**
+ * evsel__tpebs_open - starts tpebs execution.
+ * @evsel: retire_latency evsel, all evsels on its list will be selected. Each
+ *         evsel is sampled to get the average retire_latency value.
  */
-int tpebs_start(struct evlist *evsel_list)
+int evsel__tpebs_open(struct evsel *evsel)
 {
 	int ret = 0;
-	struct evsel *evsel;
+	struct evsel *pos;
+	struct evlist *evsel_list = evsel->evlist;
 	char cpumap_buf[50];
 
 	/*
@@ -215,25 +214,25 @@ int tpebs_start(struct evlist *evsel_list)
 	 * Prepare perf record for sampling event retire_latency before fork and
 	 * prepare workload
 	 */
-	evlist__for_each_entry(evsel_list, evsel) {
+	evlist__for_each_entry(evsel_list, pos) {
 		int i;
 		char *name;
 		struct tpebs_retire_lat *new;
 
-		if (!evsel->retire_lat)
+		if (!pos->retire_lat)
 			continue;
 
-		pr_debug("tpebs: Retire_latency of event %s is required\n", evsel->name);
-		for (i = strlen(evsel->name) - 1; i > 0; i--) {
-			if (evsel->name[i] == 'R')
+		pr_debug("tpebs: Retire_latency of event %s is required\n", pos->name);
+		for (i = strlen(pos->name) - 1; i > 0; i--) {
+			if (pos->name[i] == 'R')
 				break;
 		}
-		if (i <= 0 || evsel->name[i] != 'R') {
+		if (i <= 0 || pos->name[i] != 'R') {
 			ret = -1;
 			goto err;
 		}
 
-		name = strdup(evsel->name);
+		name = strdup(pos->name);
 		if (!name) {
 			ret = -ENOMEM;
 			goto err;
@@ -247,7 +246,7 @@ int tpebs_start(struct evlist *evsel_list)
 			goto err;
 		}
 		new->name = name;
-		new->tpebs_name = evsel->name;
+		new->tpebs_name = pos->name;
 		list_add_tail(&new->nd, &tpebs_results);
 		tpebs_event_size += 1;
 	}
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 63c16e759a71..cc98203719c8 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -10,7 +10,7 @@ struct evsel;
 
 extern bool tpebs_recording;
 
-int tpebs_start(struct evlist *evsel_list);
+int evsel__tpebs_open(struct evsel *evsel);
 void tpebs_delete(void);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
-- 
2.49.0.604.gff1f9ca942-goog


