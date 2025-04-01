Return-Path: <linux-kernel+bounces-583996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D63A78231
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D9F16E69F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D041B223711;
	Tue,  1 Apr 2025 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUMwJKE5"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65B22370D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531935; cv=none; b=inqSZ9fFf9wALmyQgwnAsI39PsJJOV6WYDhdbuUlUhx5BMQ3tUPaMGSDiR3XlVmRU3Ipvokslms659zomYVBIl8kIpsnCXB5qXTUM+QNApw47Mro6dr+nD6fDXbqLfNn/7MEOR8I2d6YXWaVDqj4JjViHWFGlnwQ+W5vv2QvC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531935; c=relaxed/simple;
	bh=6iSRMZZj3v5z7XPvnu1Z2u1YsIqNAF8ssFyQ2+0Z+Rc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OxELUYz+YIocA0FrqxQZwtH/WHbM9Awr1VbYtRoOVEVnKD6hWPP7tXMoMzrxw32+3FxYOZeb/6p/cqR6tZv7cyUSMI9T0iR6qBwwiDRX2bHKNPZ5YH7dO3JbcpkGvtpdq6H98oMOCHYR9Gigv+QIGH192bumzybQavDDD+O5OoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUMwJKE5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227ea16b03dso166701935ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531933; x=1744136733; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=az0IuCUiWa/ckJI17G7Uo5hKOqaliVyKlYqJwWzsWPo=;
        b=HUMwJKE5ehVtRk7II8imEDsX7r7G+KYAw+N2X9RJwuipdxqUtSfHH5KHWqj38z1k9u
         B+vmS5psPpRMz3XEyKsIowO4AsbTOyZWBM9T+N6QICkejp5HkoX9L5QU9G3yzPXa/DdI
         QgUMziLOAup3j8xwX2YQduNp1YI06Knhhi2O6tFKO7sEhWCiWOSQI6JN6oK6sGZoVozg
         ov+H4ChARSrMC/fEieb9RJMHrlDYPD4YS8Nyh7TbTJoQKPmD+9ZURgTy6qW8zMdJ8fYz
         FfhIrIT6vKAx1A/bAIdYlTfKZ2W26NuoYCAjI4vj0MUjoQr8tC0HPQsMD9jjrim6VhXs
         U4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531933; x=1744136733;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=az0IuCUiWa/ckJI17G7Uo5hKOqaliVyKlYqJwWzsWPo=;
        b=sDG64hG77tQyEsA/lEGe3xxcAmQh9PiEqBS0LNJi450Mpoj6w5LSxNVtO2RcX1jRSo
         XBbiIp3NamAhHm51OzHy4aNjDsjqMpmDpVSGxWH/e303gs/w4cw4lMU6fYUHYRT+acin
         BjdJeG3nb/ah0dKbrp6Hoki4Jvw5180Nt/2ZMKG1YElAaN6taqn23ukrq9jTsumfHXbv
         FQPbfU1b8Oy8DEkC69ZARDnIXjrYGaTpjyJg0sCPdZrMii2f+bT6Fp7dnimMBU6yIRJF
         tz8eSzOUMe/J9y4JgDEUjMigHCBIesm7zn9s0rv7K8EZ7HxViN+ZftBkcCKdENaG/qgO
         H2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgixXbie9YzHFWAVS7svHl8/PVDGZIkoc6JLqZeSjMotKotcZdTY4ASpaU5+QFKcvbxUiIrh5x91vWvPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYs4eOs2Heivxu4HKixdew+KlrMkw1AIf+MEP0YxjE4XWxtbx/
	cnhHuC+bQGiWMCG/q7nbH7gDrnrdSgttypNujLyF5ZNTh3+kFKrkSRZJOvozDQZXxj08A5OJFDA
	nohELtQ==
X-Google-Smtp-Source: AGHT+IHFPEAwrg2tiCWHHOiMEW4gbtvOV2RAPznerXo6Udh5LKZ1f2eE8NP4qr792/A9GrRaC2p4ssXFKeT3
X-Received: from pjbsp3.prod.google.com ([2002:a17:90b:52c3:b0:301:a339:b558])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e541:b0:221:7b4a:475a
 with SMTP id d9443c01a7336-2292fa0af62mr156948135ad.52.1743531932510; Tue, 01
 Apr 2025 11:25:32 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:26 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-29-irogers@google.com>
Subject: [PATCH v1 28/48] perf kwork: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kwork.c      | 11 +++++------
 tools/perf/util/bpf_kwork_top.c |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index c41a68d073de..cc5488cb98e4 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1574,8 +1574,7 @@ static void top_print_per_cpu_load(struct perf_kwork *kwork)
 		load = stat->cpus_runtime[i].load;
 		if (test_bit(i, stat->all_cpus_bitmap) && total) {
 			load_ratio = load * 10000 / total;
-			load_width = PRINT_CPU_USAGE_HIST_WIDTH *
-				load_ratio / 10000;
+			load_width = (int)(PRINT_CPU_USAGE_HIST_WIDTH * load_ratio / 10000);
 
 			printf("%%Cpu%-*d[%.*s%.*s %*.*f%%]\n",
 			       PRINT_CPU_WIDTH, i,
@@ -1595,7 +1594,7 @@ static void top_print_cpu_usage(struct perf_kwork *kwork)
 	u64 idle_time = stat->cpus_runtime[MAX_NR_CPUS].idle;
 	u64 hardirq_time = stat->cpus_runtime[MAX_NR_CPUS].irq;
 	u64 softirq_time = stat->cpus_runtime[MAX_NR_CPUS].softirq;
-	int cpus_nr = bitmap_weight(stat->all_cpus_bitmap, MAX_NR_CPUS);
+	int cpus_nr = (int)bitmap_weight(stat->all_cpus_bitmap, MAX_NR_CPUS);
 	u64 cpus_total_time = stat->cpus_runtime[MAX_NR_CPUS].total;
 
 	printf("Total  : %*.*f ms, %d cpus\n",
@@ -1801,7 +1800,7 @@ static int perf_kwork__read_events(struct perf_kwork *kwork)
 	session = perf_session__new(&data, &kwork->tool);
 	if (IS_ERR(session)) {
 		pr_debug("Error creating perf session\n");
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 	}
 
 	symbol__init(&session->header.env);
@@ -2088,8 +2087,8 @@ static void top_calc_cpu_usage(struct perf_kwork *kwork)
 
 		top_subtract_irq_runtime(kwork, work);
 
-		work->cpu_usage = work->total_runtime * 10000 /
-			stat->cpus_runtime[work->cpu].total;
+		work->cpu_usage = (u32)(work->total_runtime *
+					10000 / stat->cpus_runtime[work->cpu].total);
 
 		top_calc_idle_time(kwork, work);
 next:
diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwork_top.c
index b6f187dd9136..808d0c84d26d 100644
--- a/tools/perf/util/bpf_kwork_top.c
+++ b/tools/perf/util/bpf_kwork_top.c
@@ -219,7 +219,7 @@ static void read_task_info(struct kwork_work *work)
 	int fd;
 	struct task_data data;
 	struct task_key key = {
-		.pid = work->id,
+		.pid = (__u32)work->id,
 		.cpu = work->cpu,
 	};
 
-- 
2.49.0.504.g3bcea36a83-goog


