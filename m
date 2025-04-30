Return-Path: <linux-kernel+bounces-627611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDC0AA531D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AA51C203B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F96296D00;
	Wed, 30 Apr 2025 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMMT5rDE"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D5295531
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035524; cv=none; b=YCS7EYwJsTzgzL8PwSPp8k6IyTTY7FQk3NFjjQzR2UKcmlkjAwp5nVzXew8fCQj+NSOHnR7lDEYVVN4pkh5MmLFjCoY7RWPVQabgTM+2eFxOWzepu4NbI+YabAYv219iHZ4ySE7lU/ToPPDJBuWs5ARyahMqjQ7FpME8FUScBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035524; c=relaxed/simple;
	bh=Nu64fgsUggtVqciky6DS55ECHqWe+JpaG3wU41WVZ8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MpscAf6JUN0GFsK4fiBTNDAPUK4FXgFGxpuTe1Zmapz/xn7vk4mA3vWeltvq/dS6XH9OX77QhoiytoLOandF+CglDCPJuflIySQQSiNsUFK7rhOFHanB1BdxcVrEU6r3bPvcBGj10zz1XZ9T1gbutQX24cBBswagnrdlzxqgPiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BMMT5rDE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso160156a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035522; x=1746640322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b94roP851Er7qs/qoq/Fr5lHIvpxhU3lVSn/ifYnsLI=;
        b=BMMT5rDEsht1Z3Yvc78Q3B11V4JrMyV3MyTGSaUIxSqNuLY0pDSau+feT+4h6uc0Ym
         qwJroUwxJggtzR+vDNSdCb0JgsTZdt/fyqmS/cY4+gOskvJSUMIyF7gN35gM1lTZ2vX8
         Kx+DuUcM3yarcjLCJuCqM9iNJkgoGJ0RDqWBGK+Lr98Jnaj2okBrqhXqJ5CJbfkJSUgn
         e+hHALL9K9TOLpoFSuHxzIVh7BDjO47J4cXg8G2Z8UVQ+Rzjl2zRRnjzt/cGATCJcyzG
         WrD1Eg1+bXZUvDT23n490n1zjwRiUXKBpLuFZdRD2ctDTRkQGpNtUgAs39jQmwr58Fpz
         84zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035522; x=1746640322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b94roP851Er7qs/qoq/Fr5lHIvpxhU3lVSn/ifYnsLI=;
        b=d0JH6zK8JIa8e+3FldvW2M5rpJVrMdY6xNVBqtU8/ms62sOZY0Iw5vFWctm0ZsM44H
         NUBWtNhqlftSgDi4T1+7Gd3dDuzXA2V6+3DHHSvX3CpObgpPZhz5SMIIvhe631xYNpSB
         lXQ5od2VSe64aEWbHqax3BQ0xgycoQfIzz9/vBQPHsb0f9NJ5EeNCMPt0MJGnRASxZnJ
         CQurM5Ie2b1mcdHKFoqFBAThZqt9GiRGFH0U1xNADmSxGtnP++QRV761r68KS4Rx2MrV
         CILXAChmHq7yx3eolYOWh5mzFjPArwfz5mFddEPiLt5BX5YkFTY8GtVgodERX+B2olpT
         9Fjw==
X-Forwarded-Encrypted: i=1; AJvYcCW4TM3DiV2Nj4YebMKGrw8Bdjy7moioHFldY6yym8lgDLgwtuepuVh7ut9IagdIoggY6zOhR5KnWn6+pps=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/88gO+Jhdh7e7V+pyY25JVV+2b+XcswU3XzGpt9Iw8JJGEG4
	dDsQPWu6lM2RCIqIhe2hCZ8hQL5bw8Q7jWDNwOrrMToeRUJbGcm65dQT0iNjH2Bl8s+JvhlIDJf
	h2MMAUA==
X-Google-Smtp-Source: AGHT+IFkyemDuf41ZeRelK0Jyrut7TlDmTPmMz4GlW9IeIakNxi5M3tcF17YTaGyuJnBR0tIvKx0crdkE8o+
X-Received: from pjboi8.prod.google.com ([2002:a17:90b:3a08:b0:308:64ce:7274])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ad2:b0:30a:2173:9f0b
 with SMTP id 98e67ed59e1d1-30a34467f57mr5271082a91.28.1746035521921; Wed, 30
 Apr 2025 10:52:01 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:20 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-33-irogers@google.com>
Subject: [PATCH v2 32/47] perf evlist: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
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
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-evlist.c |  2 +-
 tools/perf/util/evlist.c    | 29 +++++++++++++++--------------
 tools/perf/util/evsel.c     | 35 ++++++++++++++---------------------
 3 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index a9bd7bbef5a9..d8888c46238a 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -44,7 +44,7 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 	tool.feature = process_header_feature;
 	session = perf_session__new(&data, &tool);
 	if (IS_ERR(session))
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 
 	if (data.is_pipe)
 		perf_session__process_events(session);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 0a21da4f990f..72af905bbc11 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -919,7 +919,7 @@ int __evlist__parse_mmap_pages(unsigned int *mmap_pages, const char *str)
 		return -1;
 	}
 
-	*mmap_pages = pages;
+	*mmap_pages = (unsigned int)pages;
 	return 0;
 }
 
@@ -1441,7 +1441,7 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
 	}
 
 	if (!evlist->workload.pid) {
-		int ret;
+		ssize_t ret;
 
 		if (pipe_output)
 			dup2(2, 1);
@@ -1481,7 +1481,7 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
 		if (ret != 1) {
 			if (ret == -1)
 				perror("unable to read pipe");
-			exit(ret);
+			exit((int)ret);
 		}
 
 		execvp(argv[0], (char **)argv);
@@ -1542,7 +1542,7 @@ int evlist__start_workload(struct evlist *evlist)
 {
 	if (evlist->workload.cork_fd >= 0) {
 		char bf = 0;
-		int ret;
+		ssize_t ret;
 		/*
 		 * Remove the cork, let it rip!
 		 */
@@ -1552,7 +1552,7 @@ int evlist__start_workload(struct evlist *evlist)
 
 		close(evlist->workload.cork_fd);
 		evlist->workload.cork_fd = -1;
-		return ret;
+		return (int)ret;
 	}
 
 	return 0;
@@ -1655,7 +1655,8 @@ int evlist__strerror_open(struct evlist *evlist, int err, char *buf, size_t size
 int evlist__strerror_mmap(struct evlist *evlist, int err, char *buf, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE], *emsg = str_error_r(err, sbuf, sizeof(sbuf));
-	int pages_attempted = evlist->core.mmap_len / 1024, pages_max_per_user, printed = 0;
+	int pages_attempted = (int)evlist->core.mmap_len / 1024;
+	int pages_max_per_user, printed = 0;
 
 	switch (err) {
 	case EPERM:
@@ -1940,7 +1941,7 @@ int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *c
 	if (strncmp(str, "fd:", 3))
 		return evlist__parse_control_fifo(str, ctl_fd, ctl_fd_ack, ctl_fd_close);
 
-	*ctl_fd = strtoul(&str[3], &endptr, 0);
+	*ctl_fd = (int)strtoul(&str[3], &endptr, 0);
 	if (endptr == &str[3])
 		return -EINVAL;
 
@@ -1949,7 +1950,7 @@ int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *c
 		if (endptr != comma)
 			return -EINVAL;
 
-		*ctl_fd_ack = strtoul(comma + 1, &endptr, 0);
+		*ctl_fd_ack = (int)strtoul(comma + 1, &endptr, 0);
 		if (endptr == comma + 1 || *endptr != '\0')
 			return -EINVAL;
 	}
@@ -2015,7 +2016,7 @@ int evlist__finalize_ctlfd(struct evlist *evlist)
 static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
 			      char *cmd_data, size_t data_size)
 {
-	int err;
+	ssize_t err;
 	char c;
 	size_t bytes_read = 0;
 
@@ -2069,12 +2070,12 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
 		}
 	}
 
-	return bytes_read ? (int)bytes_read : err;
+	return bytes_read ? (int)bytes_read : (int)err;
 }
 
 int evlist__ctlfd_ack(struct evlist *evlist)
 {
-	int err;
+	ssize_t err;
 
 	if (evlist->ctl_fd.ack == -1)
 		return 0;
@@ -2084,7 +2085,7 @@ int evlist__ctlfd_ack(struct evlist *evlist)
 	if (err == -1)
 		pr_err("failed to write to ctl_ack_fd %d: %m\n", evlist->ctl_fd.ack);
 
-	return err;
+	return (int)err;
 }
 
 static int get_cmd_arg(char *cmd_data, size_t cmd_size, char **arg)
@@ -2304,7 +2305,7 @@ static int str_to_delay(const char *str)
 	d = strtol(str, &endptr, 10);
 	if (*endptr || d > INT_MAX || d < -1)
 		return 0;
-	return d;
+	return (int)d;
 }
 
 int evlist__parse_event_enable_time(struct evlist *evlist, struct record_opts *opts,
@@ -2325,7 +2326,7 @@ int evlist__parse_event_enable_time(struct evlist *evlist, struct record_opts *o
 
 	ret = parse_event_enable_times(str, NULL);
 	if (ret < 0)
-		return ret;
+		return (int)ret;
 
 	times_cnt = ret;
 	if (times_cnt == 0)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1d79ffecd41f..6cdb9313778a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -655,12 +655,12 @@ struct tep_event *evsel__tp_format(struct evsel *evsel)
 		return NULL;
 
 	if (!evsel->tp_sys)
-		tp_format = trace_event__tp_format_id(evsel->core.attr.config);
+		tp_format = trace_event__tp_format_id((int)evsel->core.attr.config);
 	else
 		tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
 
 	if (IS_ERR(tp_format)) {
-		int err = -PTR_ERR(evsel->tp_format);
+		int err = (int)-PTR_ERR(evsel->tp_format);
 
 		pr_err("Error getting tracepoint format '%s' '%s'(%d)\n",
 			evsel__name(evsel), strerror(err), err);
@@ -688,7 +688,7 @@ char *evsel__bpf_counter_events;
 
 bool evsel__match_bpf_counter_events(const char *name)
 {
-	int name_len;
+	size_t name_len;
 	bool match;
 	char *ptr;
 
@@ -1154,7 +1154,7 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 				evsel__reset_sample_bit(evsel, BRANCH_STACK);
 			break;
 		case EVSEL__CONFIG_TERM_STACK_USER:
-			dump_size = term->val.stack_user;
+			dump_size = (u32)term->val.stack_user;
 			break;
 		case EVSEL__CONFIG_TERM_MAX_STACK:
 			max_stack = term->val.max_stack;
@@ -1770,7 +1770,7 @@ static u64 evsel__group_read_size(struct evsel *leader)
 	u64 read_format = leader->core.attr.read_format;
 	int entry = sizeof(u64); /* value */
 	int size = 0;
-	int nr = 1;
+	u64 nr = 1;
 
 	if (!evsel__group_has_tpebs(leader))
 		return perf_evsel__read_size(&leader->core);
@@ -1834,7 +1834,7 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 {
 	struct perf_stat_evsel *ps = leader->stats;
 	u64 read_format = leader->core.attr.read_format;
-	int size = evsel__group_read_size(leader);
+	size_t size = evsel__group_read_size(leader);
 	u64 *data = ps->group_data;
 
 	if (!(read_format & PERF_FORMAT_ID))
@@ -2176,31 +2176,27 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 static bool __has_attr_feature(struct perf_event_attr *attr,
 			       struct perf_cpu cpu, unsigned long flags)
 {
-	int fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, cpu.cpu,
-			 /*group_fd=*/-1, flags);
+	int fd = sys_perf_event_open(attr, /*pid=*/0, cpu.cpu, /*group_fd=*/-1, flags);
 	close(fd);
 
 	if (fd < 0) {
 		attr->exclude_kernel = 1;
 
-		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, cpu.cpu,
-			     /*group_fd=*/-1, flags);
+		fd = sys_perf_event_open(attr, /*pid=*/0, cpu.cpu, /*group_fd=*/-1, flags);
 		close(fd);
 	}
 
 	if (fd < 0) {
 		attr->exclude_hv = 1;
 
-		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, cpu.cpu,
-			     /*group_fd=*/-1, flags);
+		fd = sys_perf_event_open(attr, /*pid=*/0, cpu.cpu, /*group_fd=*/-1, flags);
 		close(fd);
 	}
 
 	if (fd < 0) {
 		attr->exclude_guest = 1;
 
-		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, cpu.cpu,
-			     /*group_fd=*/-1, flags);
+		fd = sys_perf_event_open(attr, /*pid=*/0, cpu.cpu, /*group_fd=*/-1, flags);
 		close(fd);
 	}
 
@@ -3464,7 +3460,7 @@ char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const cha
 	 * We can change this if we have a good reason in the future.
 	 */
 	val = evsel__intval(evsel, sample, name);
-	bit = val ? ffs(val) : 0;
+	bit = val ? ffs((int)val) : 0;
 	state = (!bit || bit > strlen(states)) ? 'R' : states[bit-1];
 	return state;
 }
@@ -3809,18 +3805,15 @@ struct perf_env *evsel__env(struct evsel *evsel)
 
 static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 {
-	int cpu_map_idx, thread;
-
 	if (evsel__is_retire_lat(evsel))
 		return 0;
 
-	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->core.fd); cpu_map_idx++) {
-		for (thread = 0; thread < xyarray__max_y(evsel->core.fd);
-		     thread++) {
+	for (size_t cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->core.fd); cpu_map_idx++) {
+		for (size_t thread = 0; thread < xyarray__max_y(evsel->core.fd); thread++) {
 			int fd = FD(evsel, cpu_map_idx, thread);
 
 			if (perf_evlist__id_add_fd(&evlist->core, &evsel->core,
-						   cpu_map_idx, thread, fd) < 0)
+						   (int)cpu_map_idx, (int)thread, fd) < 0)
 				return -1;
 		}
 	}
-- 
2.49.0.906.g1f30a19c02-goog


