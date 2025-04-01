Return-Path: <linux-kernel+bounces-583990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9FBA78228
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07AC16A988
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F86C2222D9;
	Tue,  1 Apr 2025 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufSITaLf"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33C92222BE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531923; cv=none; b=hDcoU4+g4ZQsWYO83hMs5LUeCXQPk4/rznz+7smEoq+8lm+elUZQhJF31QfxHJSLkqrqctVqQisKxT/ACBKyFxOG9DPVK6fF7w/LLJ1xuH63dbrI/MDDoGKQ0Yddzvys3tXLfslHVond6fq29GHtFo8aH0hOoYQwbXiih0DuSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531923; c=relaxed/simple;
	bh=4RVSKWGtcfQih+UknNAMb9Mk513Qf/LPLfe1Z5Wk/Hs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mETmtKXbQSXAOPVjvKIxd6+JySDPB0XO5+IfPryk38FHPD8YlY8t88tbMgj+wd9C0xLDoEbCHVpaLFAmHawpyhpcOdJlvLjmApqc7VHsDr/j7TQqC3bAlke/BTUXtjb8C6RDOMyk69+zT/c36/gQRcVHN6WS2qxriByItGQSRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufSITaLf; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2aa17fc59d1so5681963fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531921; x=1744136721; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N34/+E3ZGw12pVAa/alsyA6/izX5NgJHni0nGvXBgPQ=;
        b=ufSITaLfG1CDAZox6mIuEzrAfrQdC2t+8zHbe3lb6I6lmxl5VswSTWCoWKNYYuQMEZ
         XlTTlasHPq3W5DFgkubQ99e26ntSSdLND9NgMPKCeOUR3WYM2mtYE2JLRi1Q1BpEMxXN
         Lw8IxXjd9ytuFVWbmpqIJ/EFVXsgkXWPaN9jwZbGMWbIKbH6mg20BrIwXPqE5867sNTR
         fVnbgQChUqLmd5EpviC/neCxkCSm+Hu05Iu1Zhb5yCR6p1oAfTglPUkilOZ30NoaJOZq
         Stqa4uZWOJj8xwn7+fcwHlVCTO2X53NywdsbFtyCyFLAGH588i4+KaClYqP2ZC0fcWv9
         sj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531921; x=1744136721;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N34/+E3ZGw12pVAa/alsyA6/izX5NgJHni0nGvXBgPQ=;
        b=CQd0HS3NTQCDBFkl/ZgRKFPxWqfKHIdGVEY91q0LTjPpmsTQqZ84RgvSBBO2ac8lby
         Vz5h2UEQRbeLaTHwmYpSd2i/SIr0I7/BRVvCN9mJwA4rCbQ29VY73uc1to56n1LNze/2
         euApvuv1Gzyzyo2Bhc5b1Y4+lj+uUy3urPcueaz/yiBG63qPa0DwO303q9bWg0xmK0HZ
         9ExAx8aMUs+Be+mhaZrHW+DVmF+t7F9dI3bWFhgKSZO+DSzdnw1GunMdi4zWiClvtfDi
         dEfxu0QodKCqoY/aVWhLJ8iSjTtWOvj8xF9J68ggPtETioNG/LL3DjSZpdkQ5hRE41Ee
         e48A==
X-Forwarded-Encrypted: i=1; AJvYcCUZG4ZDmrZMLAytzCWfWfwn14z/KlpYbC2eZjq73m0HDjlpdttQ25P/CLeaE+VR0vZYkPG5aWrJuYXheCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYOX5Gfe+FfMqB2Lq+uXZsXaMulh5NZf+IaxyOmyNTo92uwVE
	uHtt6DejDTf3w9DAJm/kJIZ2rfj0TBisYjVezOyUp3qPHhHS4mcicPEcwbcO0UZjsDkiihOQ/BF
	wcO2CdA==
X-Google-Smtp-Source: AGHT+IHZQN/TkPazOpz69O2OfTzOMRhutI7f6IM7JKtjYAx4h6Oo/m6aJeCrTVl4+t7sC7yi/LtnKHYPftrK
X-Received: from oachx16.prod.google.com ([2002:a05:6871:5310:b0:2c2:5922:a060])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:6f14:b0:2a3:832e:5492
 with SMTP id 586e51a60fabf-2cc3822669emr2359419fac.25.1743531921129; Tue, 01
 Apr 2025 11:25:21 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:20 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-23-irogers@google.com>
Subject: [PATCH v1 22/48] perf ui: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/ui/hist.c       | 18 ++++++++----------
 tools/perf/ui/stdio/hist.c |  5 ++---
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index ae3b7fe1dadc..72f40984e2d3 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -233,7 +233,7 @@ static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry *b,
 static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 		       hpp_field_fn get_field)
 {
-	s64 ret;
+	int ret;
 	int i, nr_members;
 	struct evsel *evsel;
 	u64 *fields_a, *fields_b;
@@ -272,7 +272,7 @@ static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 static int __hpp__sort_acc(struct hist_entry *a, struct hist_entry *b,
 			   hpp_field_fn get_field)
 {
-	s64 ret = 0;
+	int ret = 0;
 
 	if (symbol_conf.cumulate_callchain) {
 		/*
@@ -287,7 +287,7 @@ static int __hpp__sort_acc(struct hist_entry *a, struct hist_entry *b,
 		    !hist_entry__has_callchains(a) || !symbol_conf.use_callchain)
 			return 0;
 
-		ret = b->callchain->max_depth - a->callchain->max_depth;
+		ret = field_cmp(b->callchain->max_depth, a->callchain->max_depth);
 		if (callchain_param.order == ORDER_CALLER)
 			ret = -ret;
 	}
@@ -299,6 +299,7 @@ static int hpp__width_fn(struct perf_hpp_fmt *fmt,
 			 struct hists *hists)
 {
 	int len = fmt->user_len ?: fmt->len;
+	int fmt_len = (int)strlen(fmt->name);
 	struct evsel *evsel = hists_to_evsel(hists);
 
 	if (symbol_conf.event_group) {
@@ -314,10 +315,7 @@ static int hpp__width_fn(struct perf_hpp_fmt *fmt,
 		len = max(len, nr * fmt->len);
 	}
 
-	if (len < (int)strlen(fmt->name))
-		len = strlen(fmt->name);
-
-	return len;
+	return len < fmt_len ? fmt_len : len;
 }
 
 static int hpp__header_fn(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -341,7 +339,7 @@ int hpp_color_scnprintf(struct perf_hpp *hpp, const char *fmt, ...)
 	ret = percent_color_len_snprintf(hpp->buf, hpp->size, fmt, len, percent);
 	va_end(args);
 
-	return (ret >= ssize) ? (ssize - 1) : ret;
+	return (ret >= ssize) ? (int)(ssize - 1) : ret;
 }
 
 static int hpp_entry_scnprintf(struct perf_hpp *hpp, const char *fmt, ...)
@@ -354,7 +352,7 @@ static int hpp_entry_scnprintf(struct perf_hpp *hpp, const char *fmt, ...)
 	ret = vsnprintf(hpp->buf, hpp->size, fmt, args);
 	va_end(args);
 
-	return (ret >= ssize) ? (ssize - 1) : ret;
+	return (ret >= ssize) ? (int)(ssize - 1) : ret;
 }
 
 #define __HPP_COLOR_PERCENT_FN(_type, _field, _fmttype)				\
@@ -914,7 +912,7 @@ void perf_hpp__set_user_width(const char *width_list_str)
 	perf_hpp_list__for_each_format(&perf_hpp_list, fmt) {
 		char *p;
 
-		int len = strtol(ptr, &p, 10);
+		int len = (int)strtol(ptr, &p, 10);
 		fmt->user_len = len;
 
 		if (*p == ',')
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 7ac4b98e28bc..6a981f95b4ec 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -450,7 +450,7 @@ int __hist_entry__snprintf(struct hist_entry *he, struct perf_hpp *hpp,
 		advance_hpp(hpp, ret);
 	}
 
-	return hpp->buf - start;
+	return (int)(hpp->buf - start);
 }
 
 static int hist_entry__snprintf(struct hist_entry *he, struct perf_hpp *hpp)
@@ -612,8 +612,7 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 	ret = fprintf(fp, "%s\n", bf);
 
 	if (hist_entry__has_callchains(he) && !ignore_callchains)
-		callchain_ret = hist_entry_callchain__fprintf(he, total_period,
-							      0, fp);
+		callchain_ret = (int)hist_entry_callchain__fprintf(he, total_period, 0, fp);
 
 	ret += callchain_ret;
 
-- 
2.49.0.504.g3bcea36a83-goog


