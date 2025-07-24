Return-Path: <linux-kernel+bounces-744680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A817B10FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2307BF0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0062EF644;
	Thu, 24 Jul 2025 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjDdZ5uN"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D12EF2AE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374840; cv=none; b=dJLWppE5fQcBNen6QXvGs8tdALVBAAYxs8b09tRw3byXYYFS6VAz0L2PZsrIUxxbVJuzhMZcgyGeJII75QEPU1HvUkLLeQwNUzf6lvfw7Np3gJUyff7LhIQE+ybPziYA8pKbyVPf4pOpJbzIeDJ/CEhCDo8me3iQ8Gwx6QFcpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374840; c=relaxed/simple;
	bh=t81xmNlXwmr3zilOlaXEyUvx+kcnM8s9RqOFn/g1kBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YuqBvn71VdZOKzbSyzgPE/WQgaV++5Rhr4C+atXELovPDMJCGVwlilR9JSevCmMjz+WRf7pT94mJgUc//U2LGMTyaHXYxpCu+HhK0rx8RpJZQoFYTWOE8SmAlbgZ+jWudpN/TERyeK9sSytMU+/dqQ7QV8YkWcdwwvHPe1e5zXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjDdZ5uN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23692793178so13002795ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374838; x=1753979638; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPfRZHTdYSHdPtlzDRqGTvzY0SLHPDTff14m/+O2q2c=;
        b=GjDdZ5uN0IVP9/YJc++FmIQrO1nSOelHehl/SrLVhygg1Dt0rwIrkxXk4XcTMT5Ck7
         HUV+ZNSOmvmEhxp/z+NRQVLa4YYrvJLMX4fXHtHgJn9s17pQgjVFZ3xBsw9l8ojfUzEs
         wb7uAi1FjMUUZwsD9aOglC3fpVZYTFMZ1gFhDL3t7Rt9Tkt1nsOBaVwlDXMcmSU+chho
         g5kTNKTpi2ZVxMA88BhWYn6y2WoUJIn3A6XvKw8AJEjdVo5MnFUMWEZzuMZ3lNLAI0ut
         hnuYUags4s3Yuw7ixB5iQ7rrnenGHNaEcVdhtn1WAmQsSRBHA6rixMYwoSHU5Yhu2tVP
         dmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374838; x=1753979638;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPfRZHTdYSHdPtlzDRqGTvzY0SLHPDTff14m/+O2q2c=;
        b=eL+ZbTrfwvLvKhFigNFBIctARSgszkBpHFnBuucdEXazCLPDUTdV5eFOPwvz1gLacU
         WYCt5bDTsfLbE0A63uHcr4Z6sjKiVyXrH1gdBaw9SnxdXMd5a0XiSut9FGXMw7YtyV9O
         9ebdKxuERbPCfXC3aMEpdDGNv7Uc3YODX51053SbwWOFdLcG/HAjpy2BWJkCZktdsaqW
         k351DA7IVzBeSe6ADGnpQHVa5XAbKAKOYltnxpNLiiDk+ltWYi1FexyGkB0+r6tOmgTR
         dnIj/WYNBQUwQLPL9POc7Y6p2ofewDydZ5dlzMcfUN3OBewWvXrI9PEqN4O9mdZLphOn
         XSsw==
X-Forwarded-Encrypted: i=1; AJvYcCWkUuBCNzVL5awOU2Vu7cnFarsFvrpZSH2xY2wc3zwR/nIPx0u7ly2GVep15q8IUXcBJysvFVmlaVx2qrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zhM5ikxt4I9ytPBmVFIn6FHIlPfthBy1J0NcX+JnAs+sQha9
	rTUqhZ5wJcCudtv+DOW28fZAw1SlZpPTSIu3NCypyKuykkJQlP2n9IOg6JwHoBahp2lU8zXYOGL
	Tf/QpLD7jUA==
X-Google-Smtp-Source: AGHT+IFvl8qTn5wPLStLonMQXuHNn5wuTPXihQ8/0C1V+YeHw5UxQDED+F0g9aj5SyAJaXew8lVy9yJvdxPI
X-Received: from pjbsc10.prod.google.com ([2002:a17:90b:510a:b0:311:a4ee:7c3d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2282:b0:236:6fbb:a5f3
 with SMTP id d9443c01a7336-23f9821c52amr105502325ad.40.1753374837903; Thu, 24
 Jul 2025 09:33:57 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:57 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-18-irogers@google.com>
Subject: [PATCH v6 17/22] perf auxtrace: Pass perf_env from session through to
 mmap read
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

 auxtrace_mmap__read and auxtrace_mmap__read_snapshot end up calling
 `evsel__env(NULL)` which returns the global perf_env variable for the
 host. Their only call is in perf record. Rather than use the global
 variable pass through the perf_env for `perf record`.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c |  8 ++++++--
 tools/perf/util/auxtrace.c  | 13 +++++++------
 tools/perf/util/auxtrace.h  |  6 ++++--
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8a829ddff6f2..7ea3a11aca70 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -775,7 +775,9 @@ static int record__auxtrace_mmap_read(struct record *rec,
 {
 	int ret;
 
-	ret = auxtrace_mmap__read(map, rec->itr, &rec->tool,
+	ret = auxtrace_mmap__read(map, rec->itr,
+				  perf_session__env(rec->session),
+				  &rec->tool,
 				  record__process_auxtrace);
 	if (ret < 0)
 		return ret;
@@ -791,7 +793,9 @@ static int record__auxtrace_mmap_read_snapshot(struct record *rec,
 {
 	int ret;
 
-	ret = auxtrace_mmap__read_snapshot(map, rec->itr, &rec->tool,
+	ret = auxtrace_mmap__read_snapshot(map, rec->itr,
+					   perf_session__env(rec->session),
+					   &rec->tool,
 					   record__process_auxtrace,
 					   rec->opts.auxtrace_snapshot_size);
 	if (ret < 0)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 03211c2623de..ebd32f1b8f12 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1890,7 +1890,7 @@ int __weak compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 }
 
 static int __auxtrace_mmap__read(struct mmap *map,
-				 struct auxtrace_record *itr,
+				 struct auxtrace_record *itr, struct perf_env *env,
 				 const struct perf_tool *tool, process_auxtrace_t fn,
 				 bool snapshot, size_t snapshot_size)
 {
@@ -1900,7 +1900,7 @@ static int __auxtrace_mmap__read(struct mmap *map,
 	size_t size, head_off, old_off, len1, len2, padding;
 	union perf_event ev;
 	void *data1, *data2;
-	int kernel_is_64_bit = perf_env__kernel_is_64_bit(evsel__env(NULL));
+	int kernel_is_64_bit = perf_env__kernel_is_64_bit(env);
 
 	head = auxtrace_mmap__read_head(mm, kernel_is_64_bit);
 
@@ -2002,17 +2002,18 @@ static int __auxtrace_mmap__read(struct mmap *map,
 }
 
 int auxtrace_mmap__read(struct mmap *map, struct auxtrace_record *itr,
-			const struct perf_tool *tool, process_auxtrace_t fn)
+			struct perf_env *env, const struct perf_tool *tool,
+			process_auxtrace_t fn)
 {
-	return __auxtrace_mmap__read(map, itr, tool, fn, false, 0);
+	return __auxtrace_mmap__read(map, itr, env, tool, fn, false, 0);
 }
 
 int auxtrace_mmap__read_snapshot(struct mmap *map,
-				 struct auxtrace_record *itr,
+				 struct auxtrace_record *itr, struct perf_env *env,
 				 const struct perf_tool *tool, process_auxtrace_t fn,
 				 size_t snapshot_size)
 {
-	return __auxtrace_mmap__read(map, itr, tool, fn, true, snapshot_size);
+	return __auxtrace_mmap__read(map, itr, env, tool, fn, true, snapshot_size);
 }
 
 /**
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index b0db84d27b25..f001cbb68f8e 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -23,6 +23,7 @@ union perf_event;
 struct perf_session;
 struct evlist;
 struct evsel;
+struct perf_env;
 struct perf_tool;
 struct mmap;
 struct perf_sample;
@@ -512,10 +513,11 @@ typedef int (*process_auxtrace_t)(const struct perf_tool *tool,
 				  size_t len1, void *data2, size_t len2);
 
 int auxtrace_mmap__read(struct mmap *map, struct auxtrace_record *itr,
-			const struct perf_tool *tool, process_auxtrace_t fn);
+			struct perf_env *env, const struct perf_tool *tool,
+			process_auxtrace_t fn);
 
 int auxtrace_mmap__read_snapshot(struct mmap *map,
-				 struct auxtrace_record *itr,
+				 struct auxtrace_record *itr, struct perf_env *env,
 				 const struct perf_tool *tool, process_auxtrace_t fn,
 				 size_t snapshot_size);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


