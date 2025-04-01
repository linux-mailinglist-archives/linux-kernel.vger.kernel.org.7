Return-Path: <linux-kernel+bounces-584002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D97A7823B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BC616E198
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B08E2253EE;
	Tue,  1 Apr 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onOvRPbn"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A801224AF6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531947; cv=none; b=evdcmYnf2NMo2LAN6mYMoiqeuTmplKL+gLV1z0MwxE2soItUgywdcpi7a2qyyLcF+I6Gtjx3haoYpCEPBh9gnhBxaYI/3inrpepGhshkhevzMy7ExZzmBWD+FtRQkhKnLoiC7O43rioimXGgWiLLFWyQPEFAfHO3gmYml7ezjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531947; c=relaxed/simple;
	bh=Qu3ENIwjPtRUy2H8z/5cBW7sG1RGzLF/ISAym7rxPVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hp8+a7dleokv6Pd9A6F/EQsy6Es0h+STiQiL1XS4RQUiLtA63fnCON306C0v7t6quZwsBPD2kTlRMXI6ECNd1s0M/qmuAZ6/MtAXoVVgHR3r2l7gELlAPv/G7gdGL+Sa/dDvLPU7knUJIbcUqrmdDTMe7ISu9/oDNTy1eMIHoW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=onOvRPbn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22403329f9eso104550925ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531945; x=1744136745; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvFsqXOQnMSY0FwcqTPMe5NcrPZKJkPdo6X7LXEIfzg=;
        b=onOvRPbnefm7XS3Bg/t+kW0L/KEFZzgttCvOrDb/1AKfj3Z13BPlJwBjlM4FdXFxIG
         fjMPaz/DM9ALlR5JK7yTc6FFdS/BI4hLEguIgwZJlGnNvK8sCz+x02UpSjXGKU0qtpkR
         10Y5+2GVMy9p/+VKGiR3Fw3i1Jvjd+JtKfBjAreEKXq1OyKVTpOiFhRVAqq3qHl0gMxV
         NwoTCTUi59/gqg6BlSZ4Yviy9QsffYSYNqocmhygcwkvUY3b41e4Fm7ki5Q9EgX+Mm/J
         9dhApM/EqyhekHu6q5kQv9ZpEsSoYpH5D6+pFPMzkD19f9KE7XLwwEDAS1WNmD/qjS/K
         qOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531945; x=1744136745;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvFsqXOQnMSY0FwcqTPMe5NcrPZKJkPdo6X7LXEIfzg=;
        b=S4GiqPwr9WEsNRply9wHrHHbMeLtVCg5R9NIkS1wM+PCjP+oXJiX6ojXMWhSwTEDY5
         p0EbqKvpKJ9AEC5ib1jDptG8eIh7XwwRluRMPYxikz+XayTe40YQVIApr2ipEeWNOlZO
         ONuBEIt9UqtfVvs22Jq48zdCHvUGnQtdPj3RUSOO3ER/ZP21gMCwbc1C7NzY8W4inG3r
         0T0c0b3fedEKCDb+fPYa3UzbxPowdX/gi3CBLinR13mkQVEYVNaTTxfFsrgd8Lx6H+dS
         +tW1AOGL+wnZIMgAHRU0s7a0fBVcsVkZDL2RWva6pGIAZ1RA4eEAwPvZTAPw76UALupO
         QXCg==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZYF9i7agkFw/AHiqAhfiVhMCfCjv9mStPlnLWqYAkOGzhPmRqGYvCzaiCFoYd46C1NZ6xlZQSj8b29c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Veictg3K7WdAIs6hP2RRPOkMxJ6wycAfSYSKKedITotaWiDm
	e/JqEYuN3sdU2J84ueIlNMlrux5IR9GC1GvXJO9WkRlbjneGN5tW0YiU9238MDUokk876MY9n3U
	nwGPipQ==
X-Google-Smtp-Source: AGHT+IHW/4wmxkq4+EIq5aHOMrmtVB2GZ7+Z/8jfNXSu21JgnRUTXtDc8Kcd6rJ8130lmEAYOc9SAvaid5cP
X-Received: from pfgs4.prod.google.com ([2002:a05:6a00:1784:b0:736:451f:b9f4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc7:b0:224:160d:3f54
 with SMTP id d9443c01a7336-2292f97caa0mr233931205ad.31.1743531944799; Tue, 01
 Apr 2025 11:25:44 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:32 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-35-irogers@google.com>
Subject: [PATCH v1 34/48] perf bpf_counter: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/bpf_counter.c        | 6 +++---
 tools/perf/util/bpf_counter_cgroup.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 73fcafbffc6a..3b1dbf1f5f66 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -177,7 +177,7 @@ static int bpf_program_profiler__load(struct evsel *evsel, struct target *target
 		return -1;
 
 	while ((tok = strtok_r(bpf_str, ",", &saveptr)) != NULL) {
-		prog_id = strtoul(tok, &p, 10);
+		prog_id = (unsigned int)strtoul(tok, &p, 10);
 		if (prog_id == 0 || prog_id == UINT_MAX ||
 		    (*p != '\0' && *p != ',')) {
 			pr_err("Failed to parse bpf prog ids %s\n",
@@ -418,7 +418,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	link = bpf_program__attach(skel->progs.on_switch);
 	if (IS_ERR(link)) {
 		pr_err("Failed to attach leader program\n");
-		err = PTR_ERR(link);
+		err = (int)PTR_ERR(link);
 		goto out;
 	}
 
@@ -459,7 +459,7 @@ static int bperf_attach_follower_program(struct bperf_follower_bpf *skel,
 	else {
 		link = bpf_program__attach(skel->progs.fexit_XXX);
 		if (IS_ERR(link))
-			err = PTR_ERR(link);
+			err = (int)PTR_ERR(link);
 	}
 
 	return err;
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 6ff42619de12..35d1b950e803 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -98,7 +98,7 @@ static int bperf_load_program(struct evlist *evlist)
 						      FD(cgrp_switch, i));
 		if (IS_ERR(link)) {
 			pr_err("Failed to attach cgroup program\n");
-			err = PTR_ERR(link);
+			err = (int)PTR_ERR(link);
 			goto out;
 		}
 	}
-- 
2.49.0.504.g3bcea36a83-goog


