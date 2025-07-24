Return-Path: <linux-kernel+bounces-744667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE7B10FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0931CE0EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE2E2EBDD9;
	Thu, 24 Jul 2025 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjM5KkS9"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9442EBBAC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374808; cv=none; b=CHhaiCKgcdzbusErq3WJxx+VeZMQhxBdmY43F2+QqUtflVFa1l2KWf5VWrY1TcrRjJoxPewbSvNZUOizd94KDk3HzyM4AQ3X8TYvZif8V3Jc6leRXfk2m9n1+GbjRj/K7Nf3hGWvPREmn9ULKlA0/+e81ALV3XrDwSNIGU+a9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374808; c=relaxed/simple;
	bh=i87jvX210l24c7RqxS+bUYqmgL8+oZvqMbe8qDfav9Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=J4ivDgiWPcA5S3NRMeLxV9lZl1sS9w5ctmDit+KgCXV33bQu5ZLUolytP6U+zMGhfImX7/EEz+02VUh8t4p6KrBSaI1/ubtosgcQSHLGwGpbK2WlL9Bxo202Q40sOHOKjjQ1XXmu9Hy33sd8YgBWcwCd1c7Py3r9NN4L9q1HP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XjM5KkS9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-756a4884dfcso1257230b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374806; x=1753979606; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62dSX49aFLikEjIUMEVRlCmIJbHK4eeNScGSo/Mzprs=;
        b=XjM5KkS9vBcw5ali616l9FMbzTggDUX60SKh6sdl4g3HEcwSmVVeoY4mWb8AOBRITC
         r5HcghPWgfWOscXnZ4XeuSHSweuudWilg6KWATrilLU3IjPTtoJJY8pEJvpUwXRFQJpQ
         eHVv+4i+fMOUQucr+vNQy4TmCM6R/Oxx5GdMX8DjSoXQMjSsDL+mgCIIF0JJcvIOLOnD
         nW3CPHG+QTmYk5sw6ulwdDWx4Ak9nuTqyxPNBJWoc3r6jFudxyGTblqhIJsJbBXsALQT
         zzjeiQL57iIvZskL+MQAfv6T2LgaOWdvREw3SbtYaCfRJC/mjzLL9qsA0GoErxfBctzy
         ykVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374806; x=1753979606;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62dSX49aFLikEjIUMEVRlCmIJbHK4eeNScGSo/Mzprs=;
        b=CSS/DnB+Sq1XJovLDQVhXF2jOfUoHfLQp6/evD8XQyCKQ+a/X1CukRbA+YlOeVAiFV
         QojhXPk4GCPT/k7pICCvwRI/h9PGycwnWdnU1dn24+8J4PotZkUzFVOvssPQLSWHBLA7
         TXRvnAJcRrslyibCyY05tzP7H0J5iw0J/XIVe93pNn8rWAx1A1ReYjRkPpGtO4GcNKCo
         s556ZSD1YrtHOlHOS/tgHKhenKhyiUjAGa8CZ/AZahaEbWFtxdrgP5QqxYTpw6odYLr0
         6GRzNq+7WD98Uop253EbcZaNoAY3pUDip3cE37o9JNI3n/+iBpuyBKecj601wiOgK6JR
         Ac3A==
X-Forwarded-Encrypted: i=1; AJvYcCXhyFF9NwKRxttLIliR4ImYf+0xImyhhK6WkKDcxGvTCY2C1cEm7V5TqdXAWj2u4HLnNE0oCs5sixAWYzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywR8KGd2SMdhJSYJNJ70ASRQgB1KzSBV4f5mojvKcQpAFIC2Qc
	rqHrfN1MEbe6RKxzqkTxghtiDZ0Wg9FTpZtn7yUUcYo/8dsWN9gNRr9clVsStnZxgpORYRy9PMf
	B1Jmd6+wtLw==
X-Google-Smtp-Source: AGHT+IFZCjFgmdaI3NnelSKPac8n0knclpKXQWik2c3NFOqFyfb4a3FQ6KRAvAGmmyaW3sKiM5KoSl2FkuwJ
X-Received: from pfvf6.prod.google.com ([2002:a05:6a00:1ac6:b0:747:a8e8:603e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d80f:b0:220:82c7:309c
 with SMTP id adf61e73a8af0-23d48fe74b2mr12168299637.7.1753374805136; Thu, 24
 Jul 2025 09:33:25 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:44 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-5-irogers@google.com>
Subject: [PATCH v6 04/22] perf build-id: Mark DSO in sample callchains
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously only the sample IP's map DSO would be marked hit for the
purposes of populating the build ID cache. Walk the call chain to mark
all IPs and DSOs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index aa35dceace90..3386fa8e1e7e 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -42,10 +42,20 @@
 
 static bool no_buildid_cache;
 
+static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data __maybe_unused)
+{
+	struct map *map = node->ms.map;
+
+	if (map)
+		dso__set_hit(map__dso(map));
+
+	return 0;
+}
+
 int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 			   union perf_event *event,
 			   struct perf_sample *sample,
-			   struct evsel *evsel __maybe_unused,
+			   struct evsel *evsel,
 			   struct machine *machine)
 {
 	struct addr_location al;
@@ -63,6 +73,11 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 		dso__set_hit(map__dso(al.map));
 
 	addr_location__exit(&al);
+
+	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
+					/*symbols=*/false, mark_dso_hit_callback, /*data=*/NULL);
+
+
 	thread__put(thread);
 	return 0;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


