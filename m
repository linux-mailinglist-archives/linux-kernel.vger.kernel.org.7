Return-Path: <linux-kernel+bounces-744672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC0B10FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755CC7AF20E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9352ED845;
	Thu, 24 Jul 2025 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="civDJJ4q"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491A2ECE9B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374821; cv=none; b=gWGHZTvXjwKJlYhqttmGV9l3IsPyHs0WEnxkuLQ78rbBNviVXpXcjgJMOM/3r+nEofX+sx9VzTFF6s4K7T9KEZ+/AzijE23y7vtYE/qxQDsPyawVPTHi208tNoS8N8Yo053hXI4FfRZc8+3T/xpOUgZfOP1APPLhZCnkEw2S+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374821; c=relaxed/simple;
	bh=hWt/6YbpyonBX2+y7Dnsw4uX+EYw5js9GLR2q2lo/Sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rwmzI74fmr3g0dGxtRGOx+7/p9WUm8LeeDjj7VX2I9frIOEhSTF9S3r2qyF3FSXGnlWZR9yUzcigL81v/1OCvxJhxWjoRSgcGX5ryqLJTLnkfPB735KF7idaptXiRbmIfjKtKX/oMmJYUKOdScHX2BuOwHSAsJYXNEDj/UKy4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=civDJJ4q; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748e1e474f8so1962161b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374818; x=1753979618; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mO+rbRiTDR6FlQBr5ZxWVUFBcSyOj58M3QIN0WwdPfg=;
        b=civDJJ4qdljpF/GvLRASTpEQt44vwpWPwmW5rmrWEx7wezO6Dhc4yw9gUQQG/yjI7m
         X/1MHLcUHXqxzg98XWMHJmmMpXQkoLTDFM9e3nPlHJl5FVP29wXw71IsYSIKZ2AM3Od+
         siyqNcXPFu/cABAFWaOD9D780CiGlaHdyw958ZXWjnNqMdxuP1emipIjjoaIjxtc+/A3
         jdqxbzBjg8nAM2Dt1ekSUeyYUkSO/Z9QixFvkf6SuEGWTmzBvamysOTO8qb5+8A0Bq6z
         1lI3UzTjcdWp+GnT4VQlS566Q/01ydIrVaQW+r4ZhvEHa/mvadRM1xgdA/M4YdV/eaHs
         g3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374818; x=1753979618;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mO+rbRiTDR6FlQBr5ZxWVUFBcSyOj58M3QIN0WwdPfg=;
        b=hcbeffUPQCvpPMb/9FiYeOZODgWSHg3Bl36ZR8msGwsdcN2lJ1mQdFrRM8sgvHoMlu
         LBEtAONwV6FKc7bH+TjHGfGgHRJUNHDqRxnM4dkOocizTA5jQ/6zbYkY3LJqDO28gnIi
         6DtNS7cQopu3phix80A2oMRmzWOWQ5maonn/JWaydgK7HxUvcK95FB7CHYttJz66oyGd
         nJm80PT7nlV3dEf0tGpHtProwZOMC12UKWLi3aRqiPC/A0o5J1VN7QQVNlbvL533VWTz
         w0V7qCQN4kH6+qDyx2VJ5yAKbnRaLWZTb/9RO0ngEifLZhfkkenKQxhdENjlaIme/xIh
         0ZJg==
X-Forwarded-Encrypted: i=1; AJvYcCW8BQZpbV6Bb1DyBYXP/jIJ9nLGwaDEoqSCoxTB8RUNwcdIXNRJiNU321Z2hzcwCcTKwqcr4sY88HTJqEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzagAN2IHNv11D0cLFZnn7aefpxHOsT07df9fYhtM5QeXJ+h2os
	faOjKGm68P7bNV93EWMZu3P3w8/Yl95AIcTnATCcXVS0CDl+pQ6eSKc1Ljpy7D61KXSE8AUOaFt
	FPj1bz0TriQ==
X-Google-Smtp-Source: AGHT+IG6+ia0kBj02sRX6GO6EKmAB7RaQnFmeXL5btjoRO7fcOGW30hi+GIAoUJalldRRWByMtby2LvFuopm
X-Received: from pfbif3.prod.google.com ([2002:a05:6a00:8b03:b0:747:bd3b:4b63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b89:b0:736:3d7c:236c
 with SMTP id d2e1a72fcca58-760351dd745mr10559306b3a.14.1753374817557; Thu, 24
 Jul 2025 09:33:37 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:49 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-10-irogers@google.com>
Subject: [PATCH v6 09/22] perf session: Add accessor for session->header.env
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

The perf_env from the header in the session is frequently accessed,
add an accessor function rather than access directly. Cache the value
to avoid repeated calls. No behavioral change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c       |  4 +--
 tools/perf/builtin-buildid-cache.c  |  2 +-
 tools/perf/builtin-c2c.c            | 16 ++++++------
 tools/perf/builtin-inject.c         |  2 +-
 tools/perf/builtin-kmem.c           |  2 +-
 tools/perf/builtin-kvm.c            |  4 +--
 tools/perf/builtin-kwork.c          |  2 +-
 tools/perf/builtin-lock.c           |  4 +--
 tools/perf/builtin-mem.c            |  2 +-
 tools/perf/builtin-record.c         | 22 +++++++++--------
 tools/perf/builtin-report.c         |  8 +++---
 tools/perf/builtin-sched.c          |  8 +++---
 tools/perf/builtin-script.c         | 14 ++++++-----
 tools/perf/builtin-stat.c           | 23 ++++++++---------
 tools/perf/builtin-timechart.c      |  2 +-
 tools/perf/builtin-top.c            |  5 ++--
 tools/perf/builtin-trace.c          |  2 +-
 tools/perf/tests/topology.c         | 38 +++++++++++++----------------
 tools/perf/util/bpf-event.c         |  2 +-
 tools/perf/util/branch.c            |  2 +-
 tools/perf/util/data-convert-bt.c   | 16 ++++++------
 tools/perf/util/data-convert-json.c | 36 +++++++++++++--------------
 tools/perf/util/session.c           |  7 +++++-
 tools/perf/util/session.h           |  2 ++
 tools/perf/util/tool.c              |  2 +-
 25 files changed, 120 insertions(+), 107 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 9833c2c82a2f..326593862998 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -562,7 +562,7 @@ static int __cmd_annotate(struct perf_annotate *ann)
 	}
 
 	if (!annotate_opts.objdump_path) {
-		ret = perf_env__lookup_objdump(&session->header.env,
+		ret = perf_env__lookup_objdump(perf_session__env(session),
 					       &annotate_opts.objdump_path);
 		if (ret)
 			goto out;
@@ -896,7 +896,7 @@ int cmd_annotate(int argc, const char **argv)
 
 	symbol_conf.try_vmlinux_path = true;
 
-	ret = symbol__init(&annotate.session->header.env);
+	ret = symbol__init(perf_session__env(annotate.session));
 	if (ret < 0)
 		goto out_delete;
 
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index e936a34b7d37..c98104481c8a 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -453,7 +453,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 			return PTR_ERR(session);
 	}
 
-	if (symbol__init(session ? &session->header.env : NULL) < 0)
+	if (symbol__init(session ? perf_session__env(session) : NULL) < 0)
 		goto out;
 
 	setup_pager();
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e2e257bcc461..8cb36d9433f8 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2267,14 +2267,15 @@ static int setup_nodes(struct perf_session *session)
 	int node, idx;
 	struct perf_cpu cpu;
 	int *cpu2node;
+	struct perf_env *env = perf_session__env(session);
 
 	if (c2c.node_info > 2)
 		c2c.node_info = 2;
 
-	c2c.nodes_cnt = session->header.env.nr_numa_nodes;
-	c2c.cpus_cnt  = session->header.env.nr_cpus_avail;
+	c2c.nodes_cnt = env->nr_numa_nodes;
+	c2c.cpus_cnt  = env->nr_cpus_avail;
 
-	n = session->header.env.numa_nodes;
+	n = env->numa_nodes;
 	if (!n)
 		return -EINVAL;
 
@@ -3030,6 +3031,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	};
 	int err = 0;
 	const char *output_str, *sort_str = NULL;
+	struct perf_env *env;
 
 	argc = parse_options(argc, argv, options, report_c2c_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -3072,14 +3074,14 @@ static int perf_c2c__report(int argc, const char **argv)
 		pr_debug("Error creating perf session\n");
 		goto out;
 	}
-
+	env = perf_session__env(session);
 	/*
 	 * Use the 'tot' as default display type if user doesn't specify it;
 	 * since Arm64 platform doesn't support HITMs flag, use 'peer' as the
 	 * default display type.
 	 */
 	if (!display) {
-		if (!strcmp(perf_env__arch(&session->header.env), "arm64"))
+		if (!strcmp(perf_env__arch(env), "arm64"))
 			display = "peer";
 		else
 			display = "tot";
@@ -3109,7 +3111,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_session;
 	}
 
-	err = mem2node__init(&c2c.mem2node, &session->header.env);
+	err = mem2node__init(&c2c.mem2node, env);
 	if (err)
 		goto out_session;
 
@@ -3117,7 +3119,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (err)
 		goto out_mem2node;
 
-	if (symbol__init(&session->header.env) < 0)
+	if (symbol__init(env) < 0)
 		goto out_mem2node;
 
 	/* No pipe support at the moment. */
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 13bbb493141f..f73350a3417a 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2608,7 +2608,7 @@ int cmd_inject(int argc, const char **argv)
 		inject.tool.finished_round = perf_event__drop_oe;
 	}
 #endif
-	ret = symbol__init(&inject.session->header.env);
+	ret = symbol__init(perf_session__env(inject.session));
 	if (ret < 0)
 		goto out_delete;
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 67fb1946ef13..7929a5fa5f46 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -2024,7 +2024,7 @@ int cmd_kmem(int argc, const char **argv)
 		symbol_conf.use_callchain = true;
 	}
 
-	symbol__init(&session->header.env);
+	symbol__init(perf_session__env(session));
 
 	if (perf_time__parse_str(&ptime, time_str) != 0) {
 		pr_err("Invalid time string\n");
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index d75bd3684980..7b15b4a705e4 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1175,7 +1175,7 @@ static int cpu_isa_config(struct perf_kvm_stat *kvm)
 		}
 		cpuid = buf;
 	} else
-		cpuid = kvm->session->header.env.cpuid;
+		cpuid = perf_session__env(kvm->session)->cpuid;
 
 	if (!cpuid) {
 		pr_err("Failed to look up CPU type\n");
@@ -1561,7 +1561,7 @@ static int read_events(struct perf_kvm_stat *kvm)
 		return PTR_ERR(kvm->session);
 	}
 
-	symbol__init(&kvm->session->header.env);
+	symbol__init(perf_session__env(kvm->session));
 
 	if (!perf_session__has_traces(kvm->session, "kvm record")) {
 		ret = -EINVAL;
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index c41a68d073de..d2e08de5976d 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1804,7 +1804,7 @@ static int perf_kwork__read_events(struct perf_kwork *kwork)
 		return PTR_ERR(session);
 	}
 
-	symbol__init(&session->header.env);
+	symbol__init(perf_session__env(session));
 
 	if (perf_kwork__check_config(kwork, session) != 0)
 		goto out_delete;
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 3b3ade7a39ca..fd49703021fd 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1876,7 +1876,7 @@ static int __cmd_report(bool display_info)
 	}
 
 	symbol_conf.allow_aliases = true;
-	symbol__init(&session->header.env);
+	symbol__init(perf_session__env(session));
 
 	if (!data.is_pipe) {
 		if (!perf_session__has_traces(session, "lock record"))
@@ -2042,7 +2042,7 @@ static int __cmd_contention(int argc, const char **argv)
 		con.save_callstack = true;
 
 	symbol_conf.allow_aliases = true;
-	symbol__init(&session->header.env);
+	symbol__init(perf_session__env(session));
 
 	if (use_bpf) {
 		err = target__validate(&target);
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 5ec83cd85650..c6496adff3fe 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -304,7 +304,7 @@ static int report_raw_events(struct perf_mem *mem)
 			goto out_delete;
 	}
 
-	ret = symbol__init(&session->header.env);
+	ret = symbol__init(perf_session__env(session));
 	if (ret < 0)
 		goto out_delete;
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a59c4e15575c..8a829ddff6f2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2203,7 +2203,7 @@ static int record__setup_sb_evlist(struct record *rec)
 			}
 		}
 
-		if (evlist__add_bpf_sb_event(rec->sb_evlist, &rec->session->header.env)) {
+		if (evlist__add_bpf_sb_event(rec->sb_evlist, perf_session__env(rec->session))) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
 			return -1;
 		}
@@ -2222,15 +2222,16 @@ static int record__init_clock(struct record *rec)
 	struct perf_session *session = rec->session;
 	struct timespec ref_clockid;
 	struct timeval ref_tod;
+	struct perf_env *env = perf_session__env(session);
 	u64 ref;
 
 	if (!rec->opts.use_clockid)
 		return 0;
 
 	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
-		session->header.env.clock.clockid_res_ns = rec->opts.clockid_res_ns;
+		env->clock.clockid_res_ns = rec->opts.clockid_res_ns;
 
-	session->header.env.clock.clockid = rec->opts.clockid;
+	env->clock.clockid = rec->opts.clockid;
 
 	if (gettimeofday(&ref_tod, NULL) != 0) {
 		pr_err("gettimeofday failed, cannot set reference time.\n");
@@ -2245,12 +2246,12 @@ static int record__init_clock(struct record *rec)
 	ref = (u64) ref_tod.tv_sec * NSEC_PER_SEC +
 	      (u64) ref_tod.tv_usec * NSEC_PER_USEC;
 
-	session->header.env.clock.tod_ns = ref;
+	env->clock.tod_ns = ref;
 
 	ref = (u64) ref_clockid.tv_sec * NSEC_PER_SEC +
 	      (u64) ref_clockid.tv_nsec;
 
-	session->header.env.clock.clockid_ns = ref;
+	env->clock.clockid_ns = ref;
 	return 0;
 }
 
@@ -2396,6 +2397,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	int fd;
 	float ratio = 0;
 	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
+	struct perf_env *env;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -2437,7 +2439,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		pr_err("Perf session creation failed.\n");
 		return PTR_ERR(session);
 	}
-
+	env = perf_session__env(session);
 	if (record__threads_enabled(rec)) {
 		if (perf_data__is_pipe(&rec->data)) {
 			pr_err("Parallel trace streaming is not available in pipe mode.\n");
@@ -2471,8 +2473,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 #endif // HAVE_EVENTFD_SUPPORT
 
-	session->header.env.comp_type  = PERF_COMP_ZSTD;
-	session->header.env.comp_level = rec->opts.comp_level;
+	env->comp_type  = PERF_COMP_ZSTD;
+	env->comp_level = rec->opts.comp_level;
 
 	if (rec->opts.kcore &&
 	    !record__kcore_readable(&session->machines.host)) {
@@ -2525,7 +2527,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 	/* Debug message used by test scripts */
 	pr_debug3("perf record done opening and mmapping events\n");
-	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
+	env->comp_mmap_len = session->evlist->core.mmap_len;
 
 	if (rec->opts.kcore) {
 		err = record__kcore_copy(&session->machines.host, data);
@@ -2855,7 +2857,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
 		ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
-		session->header.env.comp_ratio = ratio + 0.5;
+		env->comp_ratio = ratio + 0.5;
 	}
 
 	if (forks) {
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 26186717fe9b..704576e46e4b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -447,7 +447,7 @@ static int report__setup_sample_type(struct report *rep)
 		}
 	}
 
-	callchain_param_setup(sample_type, perf_env__arch(&rep->session->header.env));
+	callchain_param_setup(sample_type, perf_env__arch(perf_session__env(rep->session)));
 
 	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
@@ -550,7 +550,7 @@ static int evlist__tui_block_hists_browse(struct evlist *evlist, struct report *
 	evlist__for_each_entry(evlist, pos) {
 		ret = report__browse_block_hists(&rep->block_reports[i++].hist,
 						 rep->min_percent, pos,
-						 &rep->session->header.env);
+						 perf_session__env(rep->session));
 		if (ret != 0)
 			return ret;
 	}
@@ -685,7 +685,7 @@ static int report__browse_hists(struct report *rep)
 		}
 
 		ret = evlist__tui_browse_hists(evlist, help, NULL, rep->min_percent,
-					       &session->header.env, true);
+					       perf_session__env(session), true);
 		/*
 		 * Usually "ret" is the last pressed key, and we only
 		 * care if the key notifies us to switch data file.
@@ -1842,7 +1842,7 @@ int cmd_report(int argc, const char **argv)
 		annotation_config__init();
 	}
 
-	if (symbol__init(&session->header.env) < 0)
+	if (symbol__init(perf_session__env(session)) < 0)
 		goto error;
 
 	if (report.time_str) {
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 34051ad23493..f166d6cbc083 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1939,7 +1939,7 @@ static int perf_sched__read_events(struct perf_sched *sched)
 		return PTR_ERR(session);
 	}
 
-	symbol__init(&session->header.env);
+	symbol__init(perf_session__env(session));
 
 	/* prefer sched_waking if it is captured */
 	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
@@ -3294,6 +3294,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	};
 
 	struct perf_session *session;
+	struct perf_env *env;
 	struct evlist *evlist;
 	int err = -1;
 
@@ -3318,6 +3319,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	env = perf_session__env(session);
 	if (cpu_list) {
 		err = perf_session__cpu_bitmap(session, cpu_list, cpu_bitmap);
 		if (err < 0)
@@ -3326,7 +3328,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 
 	evlist = session->evlist;
 
-	symbol__init(&session->header.env);
+	symbol__init(env);
 
 	if (perf_time__parse_str(&sched->ptime, sched->time_str) != 0) {
 		pr_err("Invalid time string\n");
@@ -3365,7 +3367,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 		goto out;
 
 	/* pre-allocate struct for per-CPU idle stats */
-	sched->max_cpu.cpu = session->header.env.nr_cpus_online;
+	sched->max_cpu.cpu = env->nr_cpus_online;
 	if (sched->max_cpu.cpu == 0)
 		sched->max_cpu.cpu = 4;
 	if (init_idle_threads(sched->max_cpu.cpu))
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 271f22962e32..31cce67217b0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -714,7 +714,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 		}
 	}
 
-	if (tod && !session->header.env.clock.enabled) {
+	if (tod && !perf_session__env(session)->clock.enabled) {
 		pr_err("Can't provide 'tod' time, missing clock data. "
 		       "Please record with -k/--clockid option.\n");
 		return -1;
@@ -759,7 +759,7 @@ tod_scnprintf(struct perf_script *script, char *buf, int buflen,
 	if (buflen < 64 || !script)
 		return buf;
 
-	env = &script->session->header.env;
+	env = perf_session__env(script->session);
 	if (!env->clock.enabled) {
 		scnprintf(buf, buflen, "disabled");
 		return buf;
@@ -3863,6 +3863,7 @@ int cmd_script(int argc, const char **argv)
 		"perf script [<options>] <top-script> [script-args]",
 		NULL
 	};
+	struct perf_env *env;
 
 	perf_set_singlethreaded();
 
@@ -4109,6 +4110,7 @@ int cmd_script(int argc, const char **argv)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	env = perf_session__env(session);
 	if (header || header_only) {
 		script.tool.show_feat_hdr = SHOW_FEAT_HEADER;
 		perf_session__fprintf_info(session, stdout, show_full_info);
@@ -4118,17 +4120,17 @@ int cmd_script(int argc, const char **argv)
 	if (show_full_info)
 		script.tool.show_feat_hdr = SHOW_FEAT_HEADER_FULL_INFO;
 
-	if (symbol__init(&session->header.env) < 0)
+	if (symbol__init(env) < 0)
 		goto out_delete;
 
 	uname(&uts);
 	if (data.is_pipe) { /* Assume pipe_mode indicates native_arch */
 		native_arch = true;
-	} else if (session->header.env.arch) {
-		if (!strcmp(uts.machine, session->header.env.arch))
+	} else if (env->arch) {
+		if (!strcmp(uts.machine, env->arch))
 			native_arch = true;
 		else if (!strcmp(uts.machine, "x86_64") &&
-			 !strcmp(session->header.env.arch, "i386"))
+			 !strcmp(env->arch, "i386"))
 			native_arch = true;
 	}
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 77e2248fa7fc..8b0a0a9ef631 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1692,48 +1692,48 @@ static struct aggr_cpu_id perf_env__get_global_aggr_by_cpu(struct perf_cpu cpu _
 static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
 						     struct perf_cpu cpu)
 {
-	return perf_env__get_socket_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+	return perf_env__get_socket_aggr_by_cpu(cpu, perf_session__env(perf_stat.session));
 }
 static struct aggr_cpu_id perf_stat__get_die_file(struct perf_stat_config *config __maybe_unused,
 						  struct perf_cpu cpu)
 {
-	return perf_env__get_die_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+	return perf_env__get_die_aggr_by_cpu(cpu, perf_session__env(perf_stat.session));
 }
 
 static struct aggr_cpu_id perf_stat__get_cluster_file(struct perf_stat_config *config __maybe_unused,
 						      struct perf_cpu cpu)
 {
-	return perf_env__get_cluster_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+	return perf_env__get_cluster_aggr_by_cpu(cpu, perf_session__env(perf_stat.session));
 }
 
 static struct aggr_cpu_id perf_stat__get_cache_file(struct perf_stat_config *config __maybe_unused,
 						    struct perf_cpu cpu)
 {
-	return perf_env__get_cache_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+	return perf_env__get_cache_aggr_by_cpu(cpu, perf_session__env(perf_stat.session));
 }
 
 static struct aggr_cpu_id perf_stat__get_core_file(struct perf_stat_config *config __maybe_unused,
 						   struct perf_cpu cpu)
 {
-	return perf_env__get_core_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+	return perf_env__get_core_aggr_by_cpu(cpu, perf_session__env(perf_stat.session));
 }
 
 static struct aggr_cpu_id perf_stat__get_cpu_file(struct perf_stat_config *config __maybe_unused,
 						  struct perf_cpu cpu)
 {
-	return perf_env__get_cpu_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+	return perf_env__get_cpu_aggr_by_cpu(cpu, perf_session__env(perf_stat.session));
 }
 
 static struct aggr_cpu_id perf_stat__get_node_file(struct perf_stat_config *config __maybe_unused,
 						   struct perf_cpu cpu)
 {
-	return perf_env__get_node_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+	return perf_env__get_node_aggr_by_cpu(cpu, perf_session__env(perf_stat.session));
 }
 
 static struct aggr_cpu_id perf_stat__get_global_file(struct perf_stat_config *config __maybe_unused,
 						     struct perf_cpu cpu)
 {
-	return perf_env__get_global_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+	return perf_env__get_global_aggr_by_cpu(cpu, perf_session__env(perf_stat.session));
 }
 
 static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
@@ -1792,7 +1792,7 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
 
 static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 {
-	struct perf_env *env = &st->session->header.env;
+	struct perf_env *env = perf_session__env(st->session);
 	aggr_cpu_id_get_t get_id = aggr_mode__get_aggr_file(stat_config.aggr_mode);
 	bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
 
@@ -2115,8 +2115,9 @@ static int process_stat_round_event(struct perf_session *session,
 {
 	struct perf_record_stat_round *stat_round = &event->stat_round;
 	struct timespec tsh, *ts = NULL;
-	const char **argv = session->header.env.cmdline_argv;
-	int argc = session->header.env.nr_cmdline;
+	struct perf_env *env = perf_session__env(session);
+	const char **argv = env->cmdline_argv;
+	int argc = env->nr_cmdline;
 
 	process_counters();
 
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 068d297aaf44..22050c640dfa 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1618,7 +1618,7 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
-	symbol__init(&session->header.env);
+	symbol__init(perf_session__env(session));
 
 	(void)perf_header__process_sections(&session->header,
 					    perf_data__fd(session->data),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c77e195ea786..87d5742b7eb7 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -647,7 +647,8 @@ static void *display_thread_tui(void *arg)
 	}
 
 	ret = evlist__tui_browse_hists(top->evlist, help, &hbt, top->min_percent,
-				       &top->session->header.env, !top->record_opts.overwrite);
+				       perf_session__env(top->session),
+				       !top->record_opts.overwrite);
 	if (ret == K_RELOAD) {
 		top->zero = true;
 		goto repeat;
@@ -1253,7 +1254,7 @@ static int __cmd_top(struct perf_top *top)
 	int ret;
 
 	if (!annotate_opts.objdump_path) {
-		ret = perf_env__lookup_objdump(&top->session->header.env,
+		ret = perf_env__lookup_objdump(perf_session__env(top->session),
 					       &annotate_opts.objdump_path);
 		if (ret)
 			return ret;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bb2dbc1d2ffa..0261f4eefe6d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4701,7 +4701,7 @@ static int trace__replay(struct trace *trace)
 	if (trace->opts.target.tid)
 		symbol_conf.tid_list_str = strdup(trace->opts.target.tid);
 
-	if (symbol__init(&session->header.env) < 0)
+	if (symbol__init(perf_session__env(session)) < 0)
 		goto out;
 
 	trace->host = &session->machines.host;
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index a8cb5ba898ab..bc7d10630dad 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -69,9 +69,11 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	int i;
 	struct aggr_cpu_id id;
 	struct perf_cpu cpu;
+	struct perf_env *env;
 
 	session = perf_session__new(&data, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
+	env = perf_session__env(session);
 	cpu__setup_cpunode_map();
 
 	/* On platforms with large numbers of CPUs process_cpu_topology()
@@ -95,9 +97,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	 *  condition is true (see do_core_id_test in header.c). So always
 	 *  run this test on those platforms.
 	 */
-	if (!session->header.env.cpu
-			&& strncmp(session->header.env.arch, "s390", 4)
-			&& strncmp(session->header.env.arch, "aarch64", 7))
+	if (!env->cpu && strncmp(env->arch, "s390", 4) && strncmp(env->arch, "aarch64", 7))
 		return TEST_SKIP;
 
 	/*
@@ -106,20 +106,20 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	 * physical_package_id will be set to -1. Hence skip this
 	 * test if physical_package_id returns -1 for cpu from perf_cpu_map.
 	 */
-	if (!strncmp(session->header.env.arch, "ppc64le", 7)) {
+	if (!strncmp(env->arch, "ppc64le", 7)) {
 		if (cpu__get_socket_id(perf_cpu_map__cpu(map, 0)) == -1)
 			return TEST_SKIP;
 	}
 
-	TEST_ASSERT_VAL("Session header CPU map not set", session->header.env.cpu);
+	TEST_ASSERT_VAL("Session header CPU map not set", env->cpu);
 
-	for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
+	for (i = 0; i < env->nr_cpus_avail; i++) {
 		cpu.cpu = i;
 		if (!perf_cpu_map__has(map, cpu))
 			continue;
 		pr_debug("CPU %d, core %d, socket %d\n", i,
-			 session->header.env.cpu[i].core_id,
-			 session->header.env.cpu[i].socket_id);
+			 env->cpu[i].core_id,
+			 env->cpu[i].socket_id);
 	}
 
 	// Test that CPU ID contains socket, die, core and CPU
@@ -129,13 +129,12 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 				cpu.cpu == id.cpu.cpu);
 
 		TEST_ASSERT_VAL("Cpu map - Core ID doesn't match",
-			session->header.env.cpu[cpu.cpu].core_id == id.core);
+			env->cpu[cpu.cpu].core_id == id.core);
 		TEST_ASSERT_VAL("Cpu map - Socket ID doesn't match",
-			session->header.env.cpu[cpu.cpu].socket_id ==
-			id.socket);
+			env->cpu[cpu.cpu].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Cpu map - Die ID doesn't match",
-			session->header.env.cpu[cpu.cpu].die_id == id.die);
+			env->cpu[cpu.cpu].die_id == id.die);
 		TEST_ASSERT_VAL("Cpu map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Cpu map - Thread IDX is set", id.thread_idx == -1);
 	}
@@ -144,14 +143,13 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	perf_cpu_map__for_each_cpu(cpu, i, map) {
 		id = aggr_cpu_id__core(cpu, NULL);
 		TEST_ASSERT_VAL("Core map - Core ID doesn't match",
-			session->header.env.cpu[cpu.cpu].core_id == id.core);
+			env->cpu[cpu.cpu].core_id == id.core);
 
 		TEST_ASSERT_VAL("Core map - Socket ID doesn't match",
-			session->header.env.cpu[cpu.cpu].socket_id ==
-			id.socket);
+			env->cpu[cpu.cpu].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
-			session->header.env.cpu[cpu.cpu].die_id == id.die);
+			env->cpu[cpu.cpu].die_id == id.die);
 		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Core map - Thread IDX is set", id.thread_idx == -1);
 	}
@@ -160,11 +158,10 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	perf_cpu_map__for_each_cpu(cpu, i, map) {
 		id = aggr_cpu_id__die(cpu, NULL);
 		TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
-			session->header.env.cpu[cpu.cpu].socket_id ==
-			id.socket);
+			env->cpu[cpu.cpu].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
-			session->header.env.cpu[cpu.cpu].die_id == id.die);
+			env->cpu[cpu.cpu].die_id == id.die);
 
 		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Die map - Core is set", id.core == -1);
@@ -176,8 +173,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	perf_cpu_map__for_each_cpu(cpu, i, map) {
 		id = aggr_cpu_id__socket(cpu, NULL);
 		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
-			session->header.env.cpu[cpu.cpu].socket_id ==
-			id.socket);
+			env->cpu[cpu.cpu].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Socket map - Die ID is set", id.die == -1);
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index dc09a4730c50..664f361ef8c1 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -549,7 +549,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 	 * for perf-record and perf-report use header.env;
 	 * otherwise, use global perf_env.
 	 */
-	env = session->data ? &session->header.env : &perf_env;
+	env = session->data ? perf_session__env(session) : &perf_env;
 
 	arrays = 1UL << PERF_BPIL_JITED_KSYMS;
 	arrays |= 1UL << PERF_BPIL_JITED_FUNC_LENS;
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index ab760e267d41..3712be067464 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -46,7 +46,7 @@ const char *branch_new_type_name(int new_type)
 		"FAULT_DATA",
 		"FAULT_INST",
 /*
- * TODO: This switch should happen on 'session->header.env.arch'
+ * TODO: This switch should happen on 'perf_session__env(session)->arch'
  * instead, because an arm64 platform perf recording could be
  * opened for analysis on other platforms as well.
  */
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 5e7ff09fbc95..3d2e437e1354 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1338,14 +1338,14 @@ static void cleanup_events(struct perf_session *session)
 static int setup_streams(struct ctf_writer *cw, struct perf_session *session)
 {
 	struct ctf_stream **stream;
-	struct perf_header *ph = &session->header;
+	struct perf_env *env = perf_session__env(session);
 	int ncpus;
 
 	/*
 	 * Try to get the number of cpus used in the data file,
 	 * if not present fallback to the MAX_CPUS.
 	 */
-	ncpus = ph->env.nr_cpus_avail ?: MAX_CPUS;
+	ncpus = env->nr_cpus_avail ?: MAX_CPUS;
 
 	stream = zalloc(sizeof(*stream) * ncpus);
 	if (!stream) {
@@ -1371,7 +1371,7 @@ static void free_streams(struct ctf_writer *cw)
 static int ctf_writer__setup_env(struct ctf_writer *cw,
 				 struct perf_session *session)
 {
-	struct perf_header *header = &session->header;
+	struct perf_env *env = perf_session__env(session);
 	struct bt_ctf_writer *writer = cw->writer;
 
 #define ADD(__n, __v)							\
@@ -1380,11 +1380,11 @@ do {									\
 		return -1;						\
 } while (0)
 
-	ADD("host",    header->env.hostname);
+	ADD("host",    env->hostname);
 	ADD("sysname", "Linux");
-	ADD("release", header->env.os_release);
-	ADD("version", header->env.version);
-	ADD("machine", header->env.arch);
+	ADD("release", env->os_release);
+	ADD("version", env->version);
+	ADD("machine", env->arch);
 	ADD("domain", "kernel");
 	ADD("tracer_name", "perf");
 
@@ -1401,7 +1401,7 @@ static int ctf_writer__setup_clock(struct ctf_writer *cw,
 	int64_t offset = 0;
 
 	if (tod) {
-		struct perf_env *env = &session->header.env;
+		struct perf_env *env = perf_session__env(session);
 
 		if (!env->clock.enabled) {
 			pr_err("Can't provide --tod time, missing clock data. "
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index d9f805bf6fb0..9dc1e184cf3c 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -257,7 +257,8 @@ static int process_sample_event(const struct perf_tool *tool,
 static void output_headers(struct perf_session *session, struct convert_json *c)
 {
 	struct stat st;
-	struct perf_header *header = &session->header;
+	const struct perf_header *header = &session->header;
+	const struct perf_env *env = perf_session__env(session);
 	int ret;
 	int fd = perf_data__fd(session->data);
 	int i;
@@ -280,32 +281,32 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
 	output_json_key_format(out, true, 2, "data-size", "%" PRIu64, header->data_size);
 	output_json_key_format(out, true, 2, "feat-offset", "%" PRIu64, header->feat_offset);
 
-	output_json_key_string(out, true, 2, "hostname", header->env.hostname);
-	output_json_key_string(out, true, 2, "os-release", header->env.os_release);
-	output_json_key_string(out, true, 2, "arch", header->env.arch);
+	output_json_key_string(out, true, 2, "hostname", env->hostname);
+	output_json_key_string(out, true, 2, "os-release", env->os_release);
+	output_json_key_string(out, true, 2, "arch", env->arch);
 
-	if (header->env.cpu_desc)
-		output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
+	if (env->cpu_desc)
+		output_json_key_string(out, true, 2, "cpu-desc", env->cpu_desc);
 
-	output_json_key_string(out, true, 2, "cpuid", header->env.cpuid);
-	output_json_key_format(out, true, 2, "nrcpus-online", "%u", header->env.nr_cpus_online);
-	output_json_key_format(out, true, 2, "nrcpus-avail", "%u", header->env.nr_cpus_avail);
+	output_json_key_string(out, true, 2, "cpuid", env->cpuid);
+	output_json_key_format(out, true, 2, "nrcpus-online", "%u", env->nr_cpus_online);
+	output_json_key_format(out, true, 2, "nrcpus-avail", "%u", env->nr_cpus_avail);
 
-	if (header->env.clock.enabled) {
+	if (env->clock.enabled) {
 		output_json_key_format(out, true, 2, "clockid",
-				"%u", header->env.clock.clockid);
+				"%u", env->clock.clockid);
 		output_json_key_format(out, true, 2, "clock-time",
-				"%" PRIu64, header->env.clock.clockid_ns);
+				"%" PRIu64, env->clock.clockid_ns);
 		output_json_key_format(out, true, 2, "real-time",
-				"%" PRIu64, header->env.clock.tod_ns);
+				"%" PRIu64, env->clock.tod_ns);
 	}
 
-	output_json_key_string(out, true, 2, "perf-version", header->env.version);
+	output_json_key_string(out, true, 2, "perf-version", env->version);
 
 	output_json_key_format(out, true, 2, "cmdline", "[");
-	for (i = 0; i < header->env.nr_cmdline; i++) {
+	for (i = 0; i < env->nr_cmdline; i++) {
 		output_json_delimiters(out, i != 0, 3);
-		output_json_string(c->out, header->env.cmdline_argv[i]);
+		output_json_string(c->out, env->cmdline_argv[i]);
 	}
 	output_json_format(out, false, 2, "]");
 }
@@ -376,8 +377,7 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 		fprintf(stderr, "Error creating perf session!\n");
 		goto err_fclose;
 	}
-
-	if (symbol__init(&session->header.env) < 0) {
+	if (symbol__init(perf_session__env(session)) < 0) {
 		fprintf(stderr, "Symbol init error!\n");
 		goto err_session_delete;
 	}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 38075059086c..b09d157f7d04 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2558,7 +2558,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 {
 	int i, err = -1;
 	struct perf_cpu_map *map;
-	int nr_cpus = min(session->header.env.nr_cpus_avail, MAX_NR_CPUS);
+	int nr_cpus = min(perf_session__env(session)->nr_cpus_avail, MAX_NR_CPUS);
 	struct perf_cpu cpu;
 
 	for (i = 0; i < PERF_TYPE_MAX; ++i) {
@@ -2747,3 +2747,8 @@ int perf_session__dsos_hit_all(struct perf_session *session)
 
 	return 0;
 }
+
+struct perf_env *perf_session__env(struct perf_session *session)
+{
+	return &session->header.env;
+}
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index db1c120a9e67..e7f7464b838f 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -208,4 +208,6 @@ int perf_event__process_finished_round(const struct perf_tool *tool,
 				       union perf_event *event,
 				       struct ordered_events *oe);
 
+struct perf_env *perf_session__env(struct perf_session *session);
+
 #endif /* __PERF_SESSION_H */
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 204ec03071bc..e83c7ababc2a 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -20,7 +20,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	void *src;
 	size_t decomp_size, src_size;
 	u64 decomp_last_rem = 0;
-	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
+	size_t mmap_len, decomp_len = perf_session__env(session)->comp_mmap_len;
 	struct decomp *decomp, *decomp_last = session->active_decomp->decomp_last;
 
 	if (decomp_last) {
-- 
2.50.0.727.gbf7dc18ff4-goog


