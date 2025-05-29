Return-Path: <linux-kernel+bounces-666484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592A2AC7746
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 06:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B24A16FC4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 04:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C8325DCFD;
	Thu, 29 May 2025 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwUjkLUO"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09021254874
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 04:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493647; cv=none; b=PbvRz3wTDZ2yc7X9o8W1aZCLeRPDx16CLOUP4WJQdoofBaLFw92+IchhUeSV0q+tZDztjg7bkK67aP6z5XU1hTZSiMfOOKV8pAXoN27VJrJgcZahNXr9pjkLuRVJOFIS1xRu3Is11vLI6hP8Xo1N8Z2VzMhhYrKfJCbM8d66/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493647; c=relaxed/simple;
	bh=NhBnndhX4LB3FdD/5uU6ADp0ctkOaFvPvX0vjbVMVao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=M7YRjmFvYNYUEuyt+WScNsTAZhIwNq+XPXIyx/egaCZsvHjXJ0eSHS9YP3M4imyzWG3KvhgNcb5JwcC+t9RJFbIR5LeHrRupC/yE2TVFONoUFfVYC/VgberXBEUnYgaZS+CORqDSzizjGvHm2DBF2FQ8kB/PxjmFv+aqJTGc+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SwUjkLUO; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-8610d7ec4d3so62467939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 21:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493645; x=1749098445; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTFefAgt9Bv9s2Cr7lm07Jxj+8FhXrOqCFlDv/Ji6B0=;
        b=SwUjkLUOBM1wQcHJj5trvG6hoRoRgIencmPZdclCncxXQfo8CD9poGUt3fgsoYOvBd
         9q4BxEju8RmC6Q3ysFvEVedYjr/eg4f0knDdLRHrPalzZTjccI9dYwjAp5lT/UQTIMJh
         W6ZfOIoZNQtnuOLBKUFcZKwrUTwL6s0aySvHWnLFWOK/1MjtypnWeUl8Rvdm5xSDRMaR
         3+GbI/0yf2c4sAHOMG6yKvdF1la6JBxFyb3c4JyEGF4aIxjpDF3xjoSSfQV9nVkV1+tM
         yjNaU4EJN+eWLjvpVdffJb+mZlndm9pGOXggrlurBfm1NY47ZdiWM0hAEc42r/5B65P4
         ZmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493645; x=1749098445;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTFefAgt9Bv9s2Cr7lm07Jxj+8FhXrOqCFlDv/Ji6B0=;
        b=FOiv6dkG59X95nBeZH4ZIwJYlMKqEkma2brYm/JkB1YSI9KH+oCHjBEX4VnkxpzYmC
         OMvv2Hhm6FDX1CGpxPSQ19oS4ziwBNzYSWV1HvUlkcujoqJhpxCAE9xjXwk3CZT1zNuY
         lyuVaidrA2XfY1eaSWBdVIeUnO08fRDxn8glARxYAKOQ52u6+HEheXQ6iC4MMtICkfIE
         CL9hSXOK8t5xhG2GApVgHhrli7aGLWsjOnW7CzfbFzDGeRAHiLU3G6f3F432ED+fiTfb
         jIcQ3+wBFjoaQDQVDtExkONh0PVN37qhXgyU44A9tlhMhPGLB//S5EOyq4ofhuBzfhZN
         r+nA==
X-Forwarded-Encrypted: i=1; AJvYcCWfw39G6So8ujTY/lBJzUU075V4sZeD3eVlyq5NYCOLsLdmwSx3rBX17KQ7UrJJwauqTab/aUmNQegpX0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP12UE5kdhABhB5ECDbaeKNXNeFg5zq9k781IwmLn7ytlySueE
	9o5S8OlXWzvYOOT8lIfBrWr/tEvm/1c0oI4FA6DtsuMa3dcTj9zIf/dZzYtrnHayPoMwCb+3yZl
	R8MJ97b8trg==
X-Google-Smtp-Source: AGHT+IGqGjVVd1/AU5tRIDnawLBLmOW4y1o6ndEZIT+0P2/Zh+/TYbYaHsUFRdKXyFoVVQail0QCj/KDDLmJ
X-Received: from pjbdb8.prod.google.com ([2002:a17:90a:d648:b0:311:9b25:8e87])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ec3:b0:311:d258:3470
 with SMTP id 98e67ed59e1d1-311d2583572mr9642907a91.13.1748493634483; Wed, 28
 May 2025 21:40:34 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:50 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-15-irogers@google.com>
Subject: [PATCH v4 14/24] perf test: Avoid use perf_env
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
index cf6edbe697b2..4b2461e93b2b 100644
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
@@ -798,6 +800,7 @@ static int do_test_code_reading(bool try_kcore)
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
index 36411749e007..b363c933e782 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -254,6 +254,7 @@ void perf_env__exit(struct perf_env *env)
 
 void perf_env__init(struct perf_env *env)
 {
+	memset(env, 0, sizeof(*env));
 #ifdef HAVE_LIBBPF_SUPPORT
 	env->bpf_progs.infos = RB_ROOT;
 	env->bpf_progs.btfs = RB_ROOT;
-- 
2.49.0.1204.g71687c7c1d-goog


