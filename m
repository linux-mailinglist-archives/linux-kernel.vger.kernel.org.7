Return-Path: <linux-kernel+bounces-627605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DDAAA5312
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD0A9E365E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFC929373D;
	Wed, 30 Apr 2025 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTOTHOgF"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48E268688
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035512; cv=none; b=Zhv2jbnCJQffpNoF95HPc/pUscqklKTKh4Rosr8Ukw54LXe0ryKy3nka08OLd2oISS7cGtKSLg53WHtcFHSM+WH0t2WLdhkfZEQ/fKSkN3rSFlmhveA8ehzKsjE4FC0A0RloD6Rid/N2ns5YdYTHXjVYsut9Qll06bccUqsVdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035512; c=relaxed/simple;
	bh=fQPKb2tvExN0lDvsWfwtFVM9KmnDm0fiUGU2uLUv3bU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SRvJJ04inL0yDRXSh9Mtp9+QubeZvRI4A4xCNRUATdzLxrdAXlHG82H92ICZ7ehbiYOuuivb/DO3AGsgKJrtxO3jWv2dCZGaHezyAvnDhoxMkk6dKingphM8I4XrCCDf94hhDPeSbPcocZgLd1UAa8kla8sD2vXc8MYrmF3nT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTOTHOgF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b0b2de67d6aso107330a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035509; x=1746640309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JCXEeH2++brLGuPtaI9HX8GOKQIfJPPTyPL2HMhADPg=;
        b=bTOTHOgFpDl+XhHXCJQVPvI0mYY+SNajMuo8PUFJL3PMdtX43AZJvKMbUZgmamYoNA
         UYbUVrhVrceCRPAzjTvn4llJv+6/k15aga18vqsjeMgorEyZQpSt/9zGYqP79mUupNZS
         PrHh8d5yIrcnjf1rpaPalm/mD7316EiiUZCbLRSuXNwHdEoLs26d/zazeBbkMfrhqmu9
         ARWpmjN0baFMRnJfJl6ROCztcmfZbMHDOu7jEWByl2dgQ9w+tuYoOXT2ItTHWvGgyEmN
         Ql4nWP9oAgjcMULk06v7MlFfeMho0yC7ye+ERmpdLz6wUSQR6Ll9rRwFa3ratrpm6PcC
         HmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035509; x=1746640309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCXEeH2++brLGuPtaI9HX8GOKQIfJPPTyPL2HMhADPg=;
        b=rJZjjuqTj0fw6nBcWzZqY2XD0brfwjge/3pdfAQheMkLsF9hWc8XKCuu1d3aHmDK0T
         wvklroPXx4j4xnmkKgMB0DtUqi5AMRi7QkElSEWm8lc3j705lhS5HiE8+QIHpfx6ZxYk
         dsFyBdjzjQhmJZqoX9pZ6hj8JPfkrOKhRkxVg0iI9mvyNH1LORwNYXicPvlJqehyFowr
         7SFIcMhCCnQig33vwoKWIOsBvmqCN972UBUxHEEyW8mNRvYh5LqKDTgay6F6U8jRs2IR
         elr73Dsmia5NUEsh2t8DIdjhH9V6X8Mrj5N5YVNJIwv508OrddluTY15XQbPdFXeGKHy
         Cz7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6iMtdyNC1zP/7KXltGpLpkdZrPjCCialU8fNb5RSK7rGvwmeQQmLBgvawz7GEBJF9w4WasyGbvzFrJXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPyCIU/gPEM2T7m4CMejyTNEyUv1ZBRJL/pWD7jC8Xn/BfAAEY
	TsbxkvL1Gn8REmmt7VEIIlB587bhJbNTAThbK5szftCJ5dQSOV4St+nFyBS6ua9ScvgDqUICD6N
	PBatlvg==
X-Google-Smtp-Source: AGHT+IEfUWrcjNsU0ffRE3xfCfQBJUVEGiO9SdsAEQnnMSUi7Qwz6JGDA0vDAX4/+G9g5F2zB5NK4DSVmE8v
X-Received: from pgcv17.prod.google.com ([2002:a05:6a02:5311:b0:af0:e359:c50a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3292:b0:1f5:8eec:e517
 with SMTP id adf61e73a8af0-20ba6a18158mr146417637.9.1746035509372; Wed, 30
 Apr 2025 10:51:49 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:14 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-27-irogers@google.com>
Subject: [PATCH v2 26/47] perf probe: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/probe-event.c | 13 +++++++------
 tools/perf/util/probe-file.c  | 12 +++++++-----
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 307ad6242a4e..55bc68e5bd97 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1336,7 +1336,7 @@ static int parse_line_num(char **ptr, int *val, const char *what)
 	const char *start = *ptr;
 
 	errno = 0;
-	*val = strtol(*ptr, ptr, 0);
+	*val = (int)strtol(*ptr, ptr, 0);
 	if (errno || *ptr == start) {
 		semantic_error("'%s' is not a valid number.\n", what);
 		return -EINVAL;
@@ -1620,7 +1620,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 		}
 		switch (c) {
 		case ':':	/* Line number */
-			pp->line = strtoul(arg, &tmp, 0);
+			pp->line = (int)strtoul(arg, &tmp, 0);
 			if (*tmp != '\0') {
 				semantic_error("There is non-digit char"
 					       " in line number.\n");
@@ -2065,8 +2065,8 @@ char *synthesize_perf_probe_arg(struct perf_probe_arg *pa)
 static char *synthesize_perf_probe_point(struct perf_probe_point *pp)
 {
 	struct strbuf buf;
-	char *tmp, *ret = NULL;
-	int len, err = 0;
+	char *ret = NULL;
+	int err = 0;
 
 	if (strbuf_init(&buf, 64) < 0)
 		return NULL;
@@ -2084,8 +2084,9 @@ static char *synthesize_perf_probe_point(struct perf_probe_point *pp)
 			goto out;
 	}
 	if (pp->file) {
-		tmp = pp->file;
-		len = strlen(tmp);
+		char *tmp = pp->file;
+		size_t len = strlen(tmp);
+
 		if (len > 30) {
 			tmp = strchr(pp->file + len - 30, '/');
 			tmp = tmp ? tmp + 1 : pp->file + len - 30;
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index ec8ac242fedb..2d84002710f3 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -167,7 +167,7 @@ int probe_file__open_both(int *kfd, int *ufd, int flag)
 /* Get raw string list of current kprobe_events  or uprobe_events */
 struct strlist *probe_file__get_rawlist(int fd)
 {
-	int ret, idx, fddup;
+	int ret, fddup;
 	FILE *fp;
 	char buf[MAX_CMDLEN];
 	char *p;
@@ -189,6 +189,8 @@ struct strlist *probe_file__get_rawlist(int fd)
 		goto out_close_fddup;
 
 	while (!feof(fp)) {
+		size_t idx;
+
 		p = fgets(buf, MAX_CMDLEN, fp);
 		if (!p)
 			break;
@@ -307,7 +309,7 @@ static int __del_trace_probe_event(int fd, struct str_node *ent)
 	*p = '/';
 
 	pr_debug("Writing event: %s\n", buf);
-	ret = write(fd, buf, strlen(buf));
+	ret = (int)write(fd, buf, strlen(buf));
 	if (ret < 0) {
 		ret = -errno;
 		goto error;
@@ -962,7 +964,7 @@ static int probe_cache_entry__write(struct probe_cache_entry *entry, int fd)
 	iov[0].iov_base = (void *)prefix; iov[0].iov_len = 1;
 	iov[1].iov_base = entry->spev; iov[1].iov_len = strlen(entry->spev);
 	iov[2].iov_base = (void *)"\n"; iov[2].iov_len = 1;
-	ret = writev(fd, iov, 3);
+	ret = (int)writev(fd, iov, 3);
 	if (ret < (int)iov[1].iov_len + 2)
 		goto rollback;
 
@@ -970,7 +972,7 @@ static int probe_cache_entry__write(struct probe_cache_entry *entry, int fd)
 		iov[0].iov_base = (void *)snode->s;
 		iov[0].iov_len = strlen(snode->s);
 		iov[1].iov_base = (void *)"\n"; iov[1].iov_len = 1;
-		ret = writev(fd, iov, 2);
+		ret = (int)writev(fd, iov, 2);
 		if (ret < (int)iov[0].iov_len + 1)
 			goto rollback;
 	}
@@ -992,7 +994,7 @@ int probe_cache__commit(struct probe_cache *pcache)
 	int ret = 0;
 
 	/* TBD: if we do not update existing entries, skip it */
-	ret = lseek(pcache->fd, 0, SEEK_SET);
+	ret = (int)lseek(pcache->fd, 0, SEEK_SET);
 	if (ret < 0)
 		goto out;
 
-- 
2.49.0.906.g1f30a19c02-goog


