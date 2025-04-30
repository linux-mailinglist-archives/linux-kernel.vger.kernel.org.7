Return-Path: <linux-kernel+bounces-627597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6774AAA530A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11911C075C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B872882A1;
	Wed, 30 Apr 2025 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M04sND9f"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E0283FC5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035495; cv=none; b=a3wWpjs+O5DuE9wRd1t+LhevkYs4k1x3Cb+5f2f7OjJVXYPS71v066vGga/LdZNG3jZzz2VJl3s4LL/HMiaZMh2OiYc/GjHwZACuW21EWjC1Z5XrV4jUwdeo7n/8RQILqyVSLs8js1wK6lgb+kUMKbN3sppAZ4fOQGRl/y0hMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035495; c=relaxed/simple;
	bh=cp0P51KwzrQ+Mjg/P4ac9gDsHX7GCamGMmhwvEtvUlo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LrM56Sjs+CoC/c7AwelY8LWKyC+IeD7UCiwe4zBjFRPiresVmqg3BKMsoJdssGlPHIVbXG2xnvJGArqrGbVIYgX0r4ylFtn6XkOcEGYbosk/LtiEdlk8m8P4RtZvpSRppxugFTHjZHr8YLrSgYWbPGIT3fC9VgFbTCN3uYYwp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M04sND9f; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af2f03fcc95so110607a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035493; x=1746640293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wuN9qKRFDFtBJobOBAdIGFoGTc/43v/0O/4skBFN2io=;
        b=M04sND9fzW6IAinJCiccQGFSGJYjjgOlHFQLg+wvAp+az573kD9QLG1XUs60ksva1r
         Bde2ewXo70UAOjWE3dIaYwoC1WEnx6BbfY/TgTeIaoY5t4EWvyr42Ovy3oo5TRnTfbb5
         7R16vLVcA+Q9LfhqREv0wlVTTCtzxrfoAKd7Bgwzmv6NQLQRlllnTFfyslJKCvhKUamc
         +CrVw0JTelGKZISwLByHgxLPAO8BTTK4noVVzqxmhs6hR/8Gm2R36gI3UrcWnlqrw1h4
         K1KA2uxGqlJRS6HwxI6RqCDsmLEdt0TvbhRuTDmZbS+ADlgygFVhrHlc8S8v5CW7hSZi
         cXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035493; x=1746640293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuN9qKRFDFtBJobOBAdIGFoGTc/43v/0O/4skBFN2io=;
        b=ntPZhTwTG6nuwW0Z1AKSMIQTgDfar4KQt19iJkfCXaR5xHU3hmYEddKgMU8vOQHnuT
         UfxzWtyaSKmr2Ro43HqqE3glIZFhW7OUKSIsGaxzKw8tko2nr+0H7K7fOISOHe4fumGn
         F/5NYMAnHvdy8QmWgzJjQEfbN6HuKnvd+RDBgRXMvHJL5KRdd/OmZgUGg4TepaG5B6Hq
         rgyDMl4f2uCC0gcJGvaUrUyIe2aJBmmhVKKFBINwPCfAjDF2LgdudQiJ+DEjdEPyKsWS
         JavPxklIM6u9Hq/yU55vFWlnHUolktZ+0AsUOVLjjJTtqtAunuhQTCN6QvnFOWCMGIay
         cINw==
X-Forwarded-Encrypted: i=1; AJvYcCWPi6wwAAKD7v1Xz/v32XnEyVXCDfb5F/zl/i4YzTfhpo4B2waFPGir4toBIFaskQGKNC06K/PoZzPqzn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrvz/8toJbWk15wkWLJ9f61yRZU5n2uufIFjrDX2jmfcCighi+
	zKw07FVQ9QqXeNhNZ/Itg7QIfLs/l6mYxKi4+09F7Oi/bKdD0JQCzVmIj5+ZVX9NxYmf7VZowBX
	eoyqQ7A==
X-Google-Smtp-Source: AGHT+IHZuoAutCnkqXKOqoB1Twe8axOI+2YNX17mOyaNmeN3q84jfpFRgUiiLaKZ42UMBrF2XItVc4dh15Mg
X-Received: from pjz16.prod.google.com ([2002:a17:90b:56d0:b0:2fa:284f:adb2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b06:b0:309:fd87:820e
 with SMTP id 98e67ed59e1d1-30a33354fd4mr4996209a91.26.1746035493121; Wed, 30
 Apr 2025 10:51:33 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:06 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-19-irogers@google.com>
Subject: [PATCH v2 18/47] perf cs-etm: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/cs-etm-base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
index 4abe416e3feb..3aa1ccc9e452 100644
--- a/tools/perf/util/cs-etm-base.c
+++ b/tools/perf/util/cs-etm-base.c
@@ -101,7 +101,7 @@ static int cs_etm__print_cpu_metadata_v1(u64 *val, int *offset)
 
 	magic = val[i + CS_ETM_MAGIC];
 	/* total params to print is NR_PARAMS + common block size for v1 */
-	total_params = val[i + CS_ETM_NR_TRC_PARAMS] + CS_ETM_COMMON_BLK_MAX_V1;
+	total_params = (int)val[i + CS_ETM_NR_TRC_PARAMS] + CS_ETM_COMMON_BLK_MAX_V1;
 
 	if (magic == __perf_cs_etmv3_magic) {
 		for (j = 0; j < total_params; j++, i++) {
@@ -140,7 +140,7 @@ static void cs_etm__print_auxtrace_info(u64 *val, int num)
 {
 	int i, cpu = 0, version, err;
 
-	version = val[0];
+	version = (int)val[0];
 
 	for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
 		fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
-- 
2.49.0.906.g1f30a19c02-goog


