Return-Path: <linux-kernel+bounces-584010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B9AA78243
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879C816806E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0075622652D;
	Tue,  1 Apr 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="heLSvOV2"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0D22759B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531964; cv=none; b=RiPixm2TSEZBAYjf8irylq9oxXdGybK1ybemHcKaM0TWDRGLdexEzkfy983C0wRKQkzU5Dri3OzqlIVBlXw6/mWZF5e04C8aBDuzEvVVJhXwKf8kIlGVPTkQAGNbxdf32OCFCOVre9zolziEq5ZCdC7XSxQc8+Elr8jFQJqdd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531964; c=relaxed/simple;
	bh=JQbIyor9Uz/RtWQr1UUzgydOg4ub7P7LYzitc96vXbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TJEw1GQf3dE4ZNRfbU34jwNbnMVU1YfgrWz0dTDSeh0Z3ieaEGGyTitor+yaS9dqLHqrWLsLhwLuRgEDTXyk7j+lyUDsqMHdUMKL7LolwKlwn41WrmsGmYauJ783fvrsvJbpXToeGZ+MERmfmuKTfgvSec1nIazOQDYXPO6oQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=heLSvOV2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242ce15cc3so109588735ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531962; x=1744136762; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHULpj+H3oi+FzjQgSQqTpXNSrGg7p6q4GuUxzwm0pE=;
        b=heLSvOV2uFRFbFQn+CH7BLVCmrh8kbaO2sarssM2znoXIXWCJVNx3V9WTAFYrd4Ew/
         zwD75oLSBfid0NxCh0swIiUycA+iCCWdUrGRIjqUmQ0sTSxKq3YQ/O4aBkM+oPRu/CqH
         lvsyWdDjW1TQJNldbYTfkLlCz7x95jvtT2H/u+s+2S/1o6laDDV4lbuiDdoGDoq86MDv
         dkuw/e1n6780eD9hLZTnDIKwe989GyBy/hzP6dFw9FiAEAb5txY44mDdoeov9OeXFlGU
         eJ9MQyhMTDe+SI+L7qH2dFJENefePoVgxTwCI5T3+jXCse+VcswoZwePptn2NBOJNLh1
         9JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531962; x=1744136762;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHULpj+H3oi+FzjQgSQqTpXNSrGg7p6q4GuUxzwm0pE=;
        b=mrDI9mMQ5PtKTP+u9AZsw02f4Uf19xDtsdxYDF28tGTJQtr6144swQOl+ccS/t2zCH
         /YZFVkX6FIdZIClXv7e3iBxo7Ld1toCJEgeCncw4ojT0q0NkdJfiseh1PEIxLZUQm0U0
         4jas7qe7+sIBLGEIDyGSxs4aaY8Z2Pmhmlw9doCwy5an0+Li9vLIPGyVub9phT9XeelL
         Q1F0wGnao/CSWkZf4cZaODacxqcFCGAygOU05SRcA0jGiPZ7RkcGCPpXFI1Bo6GMipOu
         4CCWW5shyBD0Ygqd70IizVYSpP2OKDEhAhDg+nj7nNuQ/MjQ3/xTiEBikCRu05H73CW0
         ujpA==
X-Forwarded-Encrypted: i=1; AJvYcCV+WXtBoDxs7IAVotNNkmixdSHAU0+AkG++tb257f2mpa3bi4AhFl4NPMWnfUu/B/rW1H+sXh1n1D0w6AM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxejr0EySON/Dy22qOrWyaHAoXIoUs+Wjg9dyMSV4mM3kcDDkN2
	qQVPkERLMrUGkJeZ++1nhXom+DSm5bBAqFtnl8BOOCbn8UwqOU0njewcuyZ2dUCf5xrNBbqaonM
	tARCvjA==
X-Google-Smtp-Source: AGHT+IHc1J/tLHnNQAMUxzKYcdtcAYe82KDst9YqDC4pcuDponTRkiDDZZDry2Fvl+/yYJUZ6LaDdz401DxW
X-Received: from pjbqo8.prod.google.com ([2002:a17:90b:3dc8:b0:2ff:6e58:89f7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce84:b0:21f:4649:fd49
 with SMTP id d9443c01a7336-2292fa0294emr209138475ad.49.1743531961690; Tue, 01
 Apr 2025 11:26:01 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:40 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-43-irogers@google.com>
Subject: [PATCH v1 42/48] perf diff: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-diff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ae490d58af92..9c21ea8f242a 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -243,7 +243,7 @@ static int setup_compute(const struct option *opt, const char *str,
 
 	option = strchr(str, ':');
 	if (option) {
-		unsigned len = option++ - str;
+		size_t len = option++ - str;
 
 		/*
 		 * The str data are not writeable, so we need
@@ -1148,7 +1148,7 @@ static int check_file_brstack(void)
 		d->session = perf_session__new(&d->data, &pdiff.tool);
 		if (IS_ERR(d->session)) {
 			pr_err("Failed to open %s\n", d->data.path);
-			return PTR_ERR(d->session);
+			return (int)PTR_ERR(d->session);
 		}
 
 		has_br_stack = perf_header__has_feat(&d->session->header,
@@ -1179,7 +1179,7 @@ static int __cmd_diff(void)
 	data__for_each_file(i, d) {
 		d->session = perf_session__new(&d->data, &pdiff.tool);
 		if (IS_ERR(d->session)) {
-			ret = PTR_ERR(d->session);
+			ret = (int)PTR_ERR(d->session);
 			pr_err("Failed to open %s\n", d->data.path);
 			goto out_delete;
 		}
@@ -1492,10 +1492,10 @@ static int print_cycles_spark(char *bf, int size, unsigned long *svals, u64 n)
 
 	if (n > NUM_SPARKS)
 		n = NUM_SPARKS;
-	if (all_zero(svals, n))
+	if (all_zero(svals, (int)n))
 		return 0;
 
-	printed = print_spark(bf, size, svals, n);
+	printed = print_spark(bf, size, svals, (int)n);
 	printed += scnprintf(bf + printed, size - printed, " ");
 	return printed;
 }
-- 
2.49.0.504.g3bcea36a83-goog


