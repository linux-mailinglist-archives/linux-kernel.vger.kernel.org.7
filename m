Return-Path: <linux-kernel+bounces-744678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B93B10FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A341CE5BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01DE2EB5B4;
	Thu, 24 Jul 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7nKQ4ET"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAB52EE981
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374834; cv=none; b=F0ipMHByrfU1pyA1rI3Oi9GGJ9dP65rYqZFbNw6GBCabZZjnvuOJ33YU6ldU3mzuyRaEKntPgNnKgbOjO6x0emYjDEmlJjcn4hdhLCI2JC7ygnmfCN+v1rdI/IvBpR4GYN5ckQkl2EdJ8yPIASkZ6QW1F89knaYVojhRm1brmpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374834; c=relaxed/simple;
	bh=f7Cr96NR+m4Torc47Lz6ejudcvRm2aLJBuMaEPZby/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GklvoPLUBNDbyLx4ZFGtraUcRWI5uMAjXECdCXi2fzKDBNChjrqxIDPZptAu9KxG9lq/G8rRRkgX6hmwIGbPWZQtcqCPaNqjySk1/2EiZFJWAxEepPaSQUzlTHyruURjMQIyeEXyf7sTQsylHmJ6ubgPD1JlGvoldlb7icB6Tng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y7nKQ4ET; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2349fe994a9so9709665ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374832; x=1753979632; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ura5wcTj4QWPpkbDlo4EPw9VccDPgu2z7OWMW7MfOzQ=;
        b=Y7nKQ4ETf0uza2fHSGYhzu4ZleH8MtNH/7hMdDOVohjDoeBII6x5P2r7A3dYxG03l8
         K/6Z12FMrbcE9BnVPYabFLJHNvdBFg+u0WB+VApT6Il8+zaVitqwNIhK26m22WScd8Bz
         TgStLEZVD2j0lg0PmIYdI/GNxqKxIo6c52CcAguDCULbl3ys0sTqZaYV8Ecs+wwd6XbZ
         j5OoGXBmJfbAQugdcb+UF66koBUFZ2BvDTHXuI2mu/AAukRDLOS9vDVPshlfq1L0+/Jo
         P0Z/xotxX9P2OVcmQrUlk3i5gVEcelQWq8igbVsCc/reWc4Xv477u/+Vqn1nDcUgGgb0
         1sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374832; x=1753979632;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ura5wcTj4QWPpkbDlo4EPw9VccDPgu2z7OWMW7MfOzQ=;
        b=cfFXySmVemiKKl1D6ihMkOFF5ZYlJm+v8eS/Zsaze8VboKifOhU54N01RhJUukXF+J
         flO9jez7qN4bQPEVFN7VhwU569nEVVKcSwWxHxUxCSAM0PMC/4DkX1zrjlB9qF5nILEY
         eAa25xubtyDCm+cU5IOSOaoHccg05FNPTEHaLrtMPWhF83QD3HGPdt5qbZaOmI4jAF7v
         xillo/aXoJzL6AlPusRpXHGDvBvAtqn7Jsxl/eglmeQa378mpQbeJe3jWpc0SBc9vHu0
         TMVTK8GKmGn/PckCOQjq250yWw2DUnaUbFM7MX2Tlb8hqDtDYOq+UiydObE3iij/dtZS
         HnIg==
X-Forwarded-Encrypted: i=1; AJvYcCXpwTDiD2lUgXco6UeVsWl/YWIxUpVdXrQIZTuW3JCBPN4vAqVd5RBw+59V52DZStWTOnWrqfjpsjPlxco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpztiPsBHgbnuPkQ2oK2ZvPYkGaQTCKM7J1Y5rvxuuPeZ39Jzz
	3riTlNACNUZG9d+kdc16A4LzcjKEmdNwpO0eLIRVvs4isvxGHdVwwshRs4qTQY7B5Rf9O9RDh1b
	af249OhIyUw==
X-Google-Smtp-Source: AGHT+IHpJd6vabYrSSti1Ja3w2Nm1/rMVDMaLq5NhuCPyXaWwsOvdwEXKWZ70ntOL4K2e/f5gEFFDX3xUsOO
X-Received: from plbmn7.prod.google.com ([2002:a17:903:a47:b0:234:c5eb:fe1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:906:b0:235:779:edfd
 with SMTP id d9443c01a7336-23f981cd5cfmr103606605ad.39.1753374831951; Thu, 24
 Jul 2025 09:33:51 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:55 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-16-irogers@google.com>
Subject: [PATCH v6 15/22] perf bench synthesize: Avoid use of global perf_env
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

The benchmark doesn't use a data file and so the header perf_env isn't
used. Stack allocate a host perf_env for use to avoid the use of the
global perf_env.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/synthesize.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 9b333276cbdb..b3d493697675 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -114,12 +114,16 @@ static int run_single_threaded(void)
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
+		perf_env__exit(&host_env);
 		return PTR_ERR(session);
 	}
 	threads = thread_map__new_by_pid(getpid());
@@ -144,6 +148,7 @@ static int run_single_threaded(void)
 		perf_thread_map__put(threads);
 
 	perf_session__delete(session);
+	perf_env__exit(&host_env);
 	return err;
 }
 
@@ -154,17 +159,21 @@ static int do_run_multi_threaded(struct target *target,
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
@@ -175,7 +184,7 @@ static int do_run_multi_threaded(struct target *target,
 						nr_threads_synthesize);
 		if (err) {
 			perf_session__delete(session);
-			return err;
+			goto err_out;
 		}
 
 		gettimeofday(&end, NULL);
@@ -198,7 +207,9 @@ static int do_run_multi_threaded(struct target *target,
 
 	printf("    Average time per event %.3f usec\n",
 		time_average / event_average);
-	return 0;
+err_out:
+	perf_env__exit(&host_env);
+	return err;
 }
 
 static int run_multi_threaded(void)
-- 
2.50.0.727.gbf7dc18ff4-goog


