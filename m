Return-Path: <linux-kernel+bounces-744681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8E5B10FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC051CE5D62
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691412EF9A7;
	Thu, 24 Jul 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPVHhyvb"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF62EB5DA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374842; cv=none; b=Xf1ZOMuc4NCHK0f8O9sDCUbvhjXqvoIROWCYqMpS76IEzJBA3LFusCuy3ZCVvlulxPM5VZwk2aWG74QDJrIGAy4Qk7MpzhyBZAjRI/+d+FiAoAWNOn8PJ8YiajPqgmWDGzI4r9oFpx+ULpN+6kWaUdmaARq2CTOekQNyQb7YklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374842; c=relaxed/simple;
	bh=B3goMpnbsjDr39b5KtiVKhjmweQme1UjU2wsV6E5F3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gOjPM5SuAkrKjiI3nVbPZ/qRhq+JiIqw8jeqAk4dsiogy/uPSBBnPmJ8ltk11qshodgeCmIR3sT1Hf0IDATNCDaXG0rUvr+sDdotRA6IFWBJp8zPd2XWDwhQ+x4vy+rYCvdJy9H6WC/i4yNL4/ssMdC50KNV9tN7bRJtcCGv0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPVHhyvb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235c897d378so12373815ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374840; x=1753979640; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clK8vcOX6E/bs4PxJyJSQn9+V4CD0DaLAQdF7P7NBBE=;
        b=qPVHhyvbDrVy5pWlqVE5Cr3XQNTi18SKU25ZGE2ln5DnZ51gmPMlqqFl1TNDEt7QKE
         YrUHbIiyJ1FgoQEcm05Xy4jhvVrNrnvO597AbB1ZGjcHOKyxU2+UH4+7hY6IHGYQet/x
         5KHnQMckDgAZeRDvAO7TwJUdbmL0679mpgMLDcUvb5BqX0d9UpLRGpKZkVjnt+DH7nfb
         IB/1lo19ibOALqv/tN6rUpYgOjnnzf7JgKxBVKd/mSPY4z+X4IyVzV7C3iBphEfgT+sB
         Rb9/osL88m8f6DIHg3U4sYtZfcp4wexst5B+umhYYE1MiziBTnF18zud2+YfkUseeiVx
         tzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374840; x=1753979640;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clK8vcOX6E/bs4PxJyJSQn9+V4CD0DaLAQdF7P7NBBE=;
        b=TMNcLbdiOuCK1EtjzTNvWBUrR2oCkzNjVALtPtCloh1x5/5aBxarInI+L+4nf4iwBl
         mqHJJB8hXctQXUTWwf6A/c9PwbAiwL+7xVtUjo1Uc3v/N4Wczr/uM2ecs1C9syCBM+8x
         L9LlgxrhpxZt3s+Vskhu8QhgRm6vipxGdbcF5K545DBTkEleewIDUw2mNAUTjfnwzlvs
         ARBv2o+WLj8fKlV7SJozeye3z0Hh+VjhQ02XoHxlKZ6RkO2tue29oZ8sME49khXZiw9p
         WiMtCrRhrouytlhpM0q1bG0IWR7mORsvoDTWJnU6f8bE97V6u6M6bThIbh+lrdHbsP62
         Y3pA==
X-Forwarded-Encrypted: i=1; AJvYcCWPyl63/m9Cwrm2tDRKfd3u1bq+BwI5Gu6jBNBfG36CGBXrq2/KCcu9cqhd+U8DHRRq2Pm/WbDGetBSYNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AfdfMwu6sQEZWv+ZQeXP8qFbsktSk+RU3agaHWpPr5OEDT3m
	8+9eZ2YV/IRWuwEtbWII048+N8Wwbo59BupO1eL2etyLmU65c4sssQxDbRs2k7M6F/owLKV/al9
	F5//HgChOdA==
X-Google-Smtp-Source: AGHT+IFs4cam1AaAoF/Vp4cWg0jO82CTqSj6HoFS+8xQ13Gbky/TFSjDAnLfzZQcuuJDQACSIrH5Tl7jnAOI
X-Received: from plch20.prod.google.com ([2002:a17:902:f2d4:b0:231:6301:a4a3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a8d:b0:234:d292:be7f
 with SMTP id d9443c01a7336-23f981bb9c5mr114213655ad.31.1753374840024; Thu, 24
 Jul 2025 09:34:00 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:58 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-19-irogers@google.com>
Subject: [PATCH v6 18/22] perf trace: Avoid global perf_env with evsel__env
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

There is no session in perf trace unless in replay mode, so in host
mode no session can be associated with the evlist. If the evsel__env
call fails resort to the host_env that's part of the trace. Remove
errno_to_name as it becomes a called once 1-line function once the
argument is turned into a perf_env, just call perf_env__arch_strerrno
directly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5b53571de400..fe737b3ac6e6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2898,13 +2898,6 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 	return sample__fprintf_callchain(sample, 38, print_opts, get_tls_callchain_cursor(), symbol_conf.bt_stop_list, trace->output);
 }
 
-static const char *errno_to_name(struct evsel *evsel, int err)
-{
-	struct perf_env *env = evsel__env(evsel);
-
-	return perf_env__arch_strerrno(env, err);
-}
-
 static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 			   union perf_event *event __maybe_unused,
 			   struct perf_sample *sample)
@@ -2990,8 +2983,9 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	} else if (ret < 0) {
 errno_print: {
 		char bf[STRERR_BUFSIZE];
-		const char *emsg = str_error_r(-ret, bf, sizeof(bf)),
-			   *e = errno_to_name(evsel, -ret);
+		struct perf_env *env = evsel__env(evsel) ?: &trace->host_env;
+		const char *emsg = str_error_r(-ret, bf, sizeof(bf));
+		const char *e = perf_env__arch_strerrno(env, err);
 
 		fprintf(trace->output, "-1 %s (%s)", e, emsg);
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog


