Return-Path: <linux-kernel+bounces-744675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADDDB10FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99B554237B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A32EE27B;
	Thu, 24 Jul 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TpilkqaT"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32E2ED861
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374826; cv=none; b=KwVstRjkuCA/crpIzR6O9q/zE0Nw9+LNk3NmItBeQ+AOjDOI99zPgMTxplIaIqRYViPn76NLi/RdpT4kzI4a8jgduAlDTabRWF4adEkAZe5aTOwRnZXK5XAHXB8ZdxanUPOCeUPGIorMWYxkh0whx6KZIC3lG4Rxgg2XmR4RrVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374826; c=relaxed/simple;
	bh=7nZIiiIn++uSLOhLUk9vUxm/WKkVS4OwTThT0yMdM0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=l1l2loZHBdxViVtEW6HIHIMHw8+qhreVIPgW2kwFWyeS3Iubv5VZ1YbRZ6uX+tNAIveKY+wumMAnuFLLxR3kaOy9XykWpaAI0Rme3roUGdTxYkj5x+NrUiH5AblHwrz4bcyuGxZV8zDCA0VxtJjCdvcUAJ4Z8EhsQfxmdboEt4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TpilkqaT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311d670ad35so1106270a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374825; x=1753979625; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4ATCR3gS0GLP8ySUZk5tVezlk+x+k580IPZRgyjTI4=;
        b=TpilkqaTdbDDH09JCjiCEAC/Nq8x9xJjwblexJu2esFnjc4qGNRUcBq6yeTmg2goHA
         3aC1xRq269Oai10uaoEioAMZgmUSqYcxb/Bp9oPPl71vQS972v1HW9fGx09uhIX1/yhF
         gQPu5ubOYOo9+CBAGKc2apJFHGjHpW9y3le0C9IJiCSFV9p/mJQ1Rb4UbZ4HTPD8a2iH
         /hEVCnjdyc1RAS3dglMkihLxqz1bd5CFdtz0OfzAuwd21mcsqoq30++5keCmNuYa7jaK
         yVTRYs4ZEa73oeLcHVbf6y//jEoym+hcfWbp+Z7/jnVsXGokZC4IQp/FWC7KNtdIS2Do
         LFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374825; x=1753979625;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4ATCR3gS0GLP8ySUZk5tVezlk+x+k580IPZRgyjTI4=;
        b=hzr0gDwrJ8jhuqCuXsTNl4N6BRcxHRs8HhYe/LZtCVbozVp2j5CiNAfP2D+t5FkGYH
         keZyqIzxfrWjEE65w7QDDu9FgMK3gaQao0vJBfboQjd/Svz3Os6G1Kb9MUPbHl6EM7CR
         yV0wLAg6PylzK4rIk5Do4xymQOjXo6/V/2dwbyNWq8hg0p7rugjeCWO7tnTP6OVa4dwy
         Ci9XCSQNk4wpGen9VZl1ODYmsPcJygMDTK3+zSnzTY9a4mJUyPqm2c5Wu7gMY593zmae
         VMEUWV39vZ3b4VeYZH7jYkyG/rIOlL+3hpkg3agkEl101QgI1x08s0ua16WLwYyRdxTg
         XNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7goB9GtP3zbBUeXhKNxZxft0fTBkH85YkzFGp5+1P/NKlg/AAdc0HSgTklE8zHURID2JxiJMk/KKftZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJMCM6x/hv4MoCwc3CV6H/Bi4SguXnoH+FnI2gVpDvn9g7PjC
	wJ+jSzOygc5+ldWmpVYOpUZ8bhnAmlbQowxKuPYw632HLQ9eu8ldsrtFPNuMZhrxNMN0fdCHMb4
	wzKMvqk5SlA==
X-Google-Smtp-Source: AGHT+IG9P+0/1FRepvIABmSkJ3cwZnJnUD4EaW9KMNoS8pG7zfn4lxon2/8z1BpHnrz4L3+dyy5Bk56cT/Y1
X-Received: from pjbsd5.prod.google.com ([2002:a17:90b:5145:b0:311:485b:d057])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582e:b0:313:14b5:2538
 with SMTP id 98e67ed59e1d1-31e50859d80mr9985080a91.35.1753374824262; Thu, 24
 Jul 2025 09:33:44 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:52 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-13-irogers@google.com>
Subject: [PATCH v6 12/22] perf test: Avoid use perf_env
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

The perf_env global variable holds the host perf_env data but its use
is hit and miss. Switch to using local perf_env variables and ensure
scoped perf_env__init and perf_env__exit. This loses command line
setting of the perf_env, but this doesn't matter for tests. So the
perf_env is fully initialized, clear it with memset in perf_env__init.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/code-reading.c  |  5 +++-
 tools/perf/tests/dlfilter-test.c | 50 ++++++++++++++++++--------------
 tools/perf/util/env.c            |  1 +
 3 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 6efb6b4bbcce..0ec7004f90fe 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -651,11 +651,13 @@ static int do_test_code_reading(bool try_kcore)
 	struct dso *dso;
 	const char *events[] = { "cycles", "cycles:u", "cpu-clock", "cpu-clock:u", NULL };
 	int evidx = 0;
+	struct perf_env host_env;
 
 	pid = getpid();
 
 	machine = machine__new_host();
-	machine->env = &perf_env;
+	perf_env__init(&host_env);
+	machine->env = &host_env;
 
 	ret = machine__create_kernel_maps(machine);
 	if (ret < 0) {
@@ -791,6 +793,7 @@ static int do_test_code_reading(bool try_kcore)
 	perf_cpu_map__put(cpus);
 	perf_thread_map__put(threads);
 	machine__delete(machine);
+	perf_env__exit(&host_env);
 
 	return err;
 }
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 54f59d1246bc..6427e3382711 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -319,11 +319,12 @@ static int run_perf_script(struct test_data *td)
 
 static int test__dlfilter_test(struct test_data *td)
 {
+	struct perf_env host_env;
 	u64 sample_type = TEST_SAMPLE_TYPE;
 	pid_t pid = 12345;
 	pid_t tid = 12346;
 	u64 id = 99;
-	int err;
+	int err = TEST_OK;
 
 	if (get_dlfilters_path(td->name, td->dlfilters, PATH_MAX))
 		return test_result("dlfilters not found", TEST_SKIP);
@@ -353,37 +354,42 @@ static int test__dlfilter_test(struct test_data *td)
 
 	pr_debug("Creating new host machine structure\n");
 	td->machine = machine__new_host();
-	td->machine->env = &perf_env;
+	perf_env__init(&host_env);
+	td->machine->env = &host_env;
 
 	td->fd = creat(td->perf_data_file_name, 0644);
 	if (td->fd < 0)
 		return test_result("Failed to create test perf.data file", TEST_FAIL);
 
 	err = perf_header__write_pipe(td->fd);
-	if (err < 0)
-		return test_result("perf_header__write_pipe() failed", TEST_FAIL);
-
+	if (err < 0) {
+		err = test_result("perf_header__write_pipe() failed", TEST_FAIL);
+		goto out;
+	}
 	err = write_attr(td, sample_type, &id);
-	if (err)
-		return test_result("perf_event__synthesize_attr() failed", TEST_FAIL);
-
-	if (write_comm(td->fd, pid, tid, "test-prog"))
-		return TEST_FAIL;
-
-	if (write_mmap(td->fd, pid, tid, MAP_START, 0x10000, 0, td->prog_file_name))
-		return TEST_FAIL;
-
-	if (write_sample(td, sample_type, id, pid, tid) != TEST_OK)
-		return TEST_FAIL;
-
+	if (err) {
+		err = test_result("perf_event__synthesize_attr() failed", TEST_FAIL);
+		goto out;
+	}
+	if (write_comm(td->fd, pid, tid, "test-prog")) {
+		err = TEST_FAIL;
+		goto out;
+	}
+	if (write_mmap(td->fd, pid, tid, MAP_START, 0x10000, 0, td->prog_file_name)) {
+		err = TEST_FAIL;
+		goto out;
+	}
+	if (write_sample(td, sample_type, id, pid, tid) != TEST_OK) {
+		err = TEST_FAIL;
+		goto out;
+	}
 	if (verbose > 1)
 		system_cmd("%s script -i %s -D", td->perf, td->perf_data_file_name);
 
-	err = run_perf_script(td);
-	if (err)
-		return TEST_FAIL;
-
-	return TEST_OK;
+	err = run_perf_script(td) ? TEST_FAIL : TEST_OK;
+out:
+	perf_env__exit(&host_env);
+	return err;
 }
 
 static void unlink_path(const char *path)
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index ee51378fb0d9..c09159083bf0 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -271,6 +271,7 @@ void perf_env__exit(struct perf_env *env)
 
 void perf_env__init(struct perf_env *env)
 {
+	memset(env, 0, sizeof(*env));
 #ifdef HAVE_LIBBPF_SUPPORT
 	env->bpf_progs.infos = RB_ROOT;
 	env->bpf_progs.btfs = RB_ROOT;
-- 
2.50.0.727.gbf7dc18ff4-goog


