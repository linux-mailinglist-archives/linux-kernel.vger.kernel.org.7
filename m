Return-Path: <linux-kernel+bounces-666481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FDCAC7743
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 06:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2DE1C0392C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 04:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484B025D547;
	Thu, 29 May 2025 04:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jh8sec3j"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C9254854
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 04:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493643; cv=none; b=T5+1FaiFEvx10+2bo8TlfeM6yrpiy5QjbHG6zogfuCTx1D6hMFci16wkJ/r16hGXA2D0uvoBR30xs02np/YJ192cfQOWuRBrflcK4nVa/X35JnicrDd74XZjwZErnH7rGHoo4yjwMbsnITxFBN2hZ2OMuBYM9+575CPc/9IAgYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493643; c=relaxed/simple;
	bh=tEPX+uZGCPtnbdtF9xb+Mc0WUL2DtIJaOpBwsvvjGGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Z5aAl+JtD0dT6iAZHEjtwggy/V+O40QAqI6FxWOiigMsE0Xds67j+4h9hYrm0FskaizHKuGn+FfUBTkEOzvHMaRCBpvbg7yhvNKThpYT4tPs8k0zUns0lySastpR1AyyqwBB6h6zECXeuuVz3zMVLDwpEUAKPfFwjG/tE+ygzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jh8sec3j; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742a969a4d0so421297b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 21:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493641; x=1749098441; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHcAoKcEAz6NjioNuyJCAtZJ04gYQ2Vd9rn/ckUmB94=;
        b=jh8sec3j3SgYgX6yw3bbcU2CZ32SuTF3IO0PMnz6ZbxcJwl1oLumkHoFoZ2unVx9u3
         qJyBvR3tPpTLfnoAR4rudexg4Sc61NMNuqfHmV9rTajqLDP2mHnGRyUYSobKPdEsHzcy
         C6EnfnfjcYNhipY9cUSz2DcgItol1LMWqMMEdxbZdPEe0bD6vVZVxS5eMi00JwwZkvv1
         V+xNzSN6x8Y5FqyBOHkeVFxxV7A8/EJtIFlzICtAXCF52CG2Nkl0ybXK9x4tuRDM2kIL
         X+yqytjrDYCShmIw5Xh3bv4CWJufqYRCoeib8qB2RlnhXNHfIuy0x5gpbtKQHyCQiqdk
         gqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493641; x=1749098441;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHcAoKcEAz6NjioNuyJCAtZJ04gYQ2Vd9rn/ckUmB94=;
        b=a0wO14viNSdCe7rDAFU/59TclK/aGqRr5u8U7JgQL3cUezUHibGLrldWv0OGW2P6/p
         p88xP2QTDvIe97BVP6GPJj1HjWubzZmZe4kFT8IwTfW5oE9eHzA4iKS11tIbTc2tja7Q
         X2CGJJpUL+tnURoKYZEJwygUY2CcBoJtpo4hgTTx7b6+WsGRjHzOtxGAYM5R2NWC+DK4
         cdBMfnDPb/brtf1fj4j25l7Z13U5bq1fZqAEAWHlvkzfueSaSh6bNa8EOtC6J4An5PT5
         nDOGS2fNgq+JlsP7a2SBK+b4zkyqqMQ+JMXaNcRKk4IqrIR4OiG4CwvSmlOc+i8ye0Xj
         Nmhg==
X-Forwarded-Encrypted: i=1; AJvYcCUhTUcnju32IfVO8Tz1IiDUGtTXKVYtzX4oQMOiH3CPUw/PmlIEFOk4vG+G1sYgbFtxb6VHkpPOYaxgxJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzep1iC2HH5gEojc4QvSkVemtTZl0G9VFWa6mWcUYxm5oHO+2cO
	FpqjMIfXWSSnGejoffUBCbKL2FfmKzfmlsY5EKFqqkfvir0FDYUE+KdflDFOaNXoYon4Zp8wyKV
	gu42NJlX93w==
X-Google-Smtp-Source: AGHT+IHsVej8VGf59PVoV/WsAbQv48c+JHrK5n0nxvTWAbXE+gZjkEjQI9js0iwRPBSyxm6B0zMWcwEzk/jC
X-Received: from pfbbd35.prod.google.com ([2002:a05:6a00:27a3:b0:737:30c9:fe46])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e13:b0:742:a77b:8c4
 with SMTP id d2e1a72fcca58-745fde79251mr29384777b3a.3.1748493640647; Wed, 28
 May 2025 21:40:40 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:53 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-18-irogers@google.com>
Subject: [PATCH v4 17/24] perf bench synthesize: Avoid use of global perf_env
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
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The benchmark doesn't use a data file and so the header perf_env isn't
used. Stack allocate a host perf_env for use to avoid the use of the
global perf_env.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/synthesize.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 9b333276cbdb..79d99ba50284 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -114,10 +114,13 @@ static int run_single_threaded(void)
 		.pid = "self",
 	};
 	struct perf_thread_map *threads;
+	struct perf_env host_env;
 	int err;
 
 	perf_set_singlethreaded();
-	session = perf_session__new(NULL, NULL);
+	perf_env__init(&host_env);
+	session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
+				      /*trace_event_repipe=*/false, &host_env);
 	if (IS_ERR(session)) {
 		pr_err("Session creation failed.\n");
 		return PTR_ERR(session);
@@ -144,6 +147,7 @@ static int run_single_threaded(void)
 		perf_thread_map__put(threads);
 
 	perf_session__delete(session);
+	perf_env__exit(&host_env);
 	return err;
 }
 
@@ -154,17 +158,21 @@ static int do_run_multi_threaded(struct target *target,
 	u64 runtime_us;
 	unsigned int i;
 	double time_average, time_stddev, event_average, event_stddev;
-	int err;
+	int err = 0;
 	struct stats time_stats, event_stats;
 	struct perf_session *session;
+	struct perf_env host_env;
 
+	perf_env__init(&host_env);
 	init_stats(&time_stats);
 	init_stats(&event_stats);
 	for (i = 0; i < multi_iterations; i++) {
-		session = perf_session__new(NULL, NULL);
-		if (IS_ERR(session))
-			return PTR_ERR(session);
-
+		session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
+					      /*trace_event_repipe=*/false, &host_env);
+		if (IS_ERR(session)) {
+			err = PTR_ERR(session);
+			goto err_out;
+		}
 		atomic_set(&event_count, 0);
 		gettimeofday(&start, NULL);
 		err = __machine__synthesize_threads(&session->machines.host,
@@ -173,10 +181,8 @@ static int do_run_multi_threaded(struct target *target,
 						process_synthesized_event,
 						true, false,
 						nr_threads_synthesize);
-		if (err) {
-			perf_session__delete(session);
-			return err;
-		}
+		if (err)
+			goto err_out;
 
 		gettimeofday(&end, NULL);
 		timersub(&end, &start, &diff);
@@ -198,7 +204,9 @@ static int do_run_multi_threaded(struct target *target,
 
 	printf("    Average time per event %.3f usec\n",
 		time_average / event_average);
-	return 0;
+err_out:
+	perf_env__exit(&host_env);
+	return err;
 }
 
 static int run_multi_threaded(void)
-- 
2.49.0.1204.g71687c7c1d-goog


