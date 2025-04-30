Return-Path: <linux-kernel+bounces-627600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1920CAA530E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077C71C07D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B49289E07;
	Wed, 30 Apr 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFTsgMcC"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020F2882D1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035501; cv=none; b=Uk0M6KgJtG5TrATsjLWfdIXAheE3NKYJq2B37nCxNP6DXb78yzPWa2bcnGV27wNnAflca/7mxiQd3ErRxCArxl9ySw2L0yiG0cF97zrNTvWmi5khM5BH/yIqXUNEjtopTtFG9KOIKIqJkJoJA0L2LEkBgcB261TY3nLcNodJeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035501; c=relaxed/simple;
	bh=71Fh1qtXfJOLrXvEBj1LTswa/5CQQRqQLFx8XbFD85k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H5Lc29z+wQh9L5G9dXA10Oz4/DxaxeM4EZ0Ta9hgWCj3UJv1v8OqF5G1y7FBPU1zmHu/9/AWojcZFva8cphY5+iJ1vFJvU8JaJ9P0UL+tLksNH8n7VsxgH0LOWiNutCcVJzE9WxFT4WfGCVf/sJ+L4nkbeoMqHIjxPOOHzgbUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFTsgMcC; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso206092b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035499; x=1746640299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzdcyVDs5KmZFcO+KePSm4+Ud/p9n76j0KYupv7ixbU=;
        b=FFTsgMcCBMz2M9DBe9g1jYrFNIaLrvOLAYWhBxBr5HBWg3YmC/8i5CeURSjPGnMCfL
         j9neb7wWVhxMcbHnsAuGChfkHu3p6eWN6jIlJcmaSqUFyDoc/W4t1OVq7zXQS4/KpLrz
         Ixw2FNLTcK//ZiDOKB4zwKLVjTGQwT4UQcfuwbj2yugGjzjnBqEY18zWrbep5IjUDSem
         sGWf+AFlgrSxEKTplqfWVeXZntXYcbCj9TcX4JHFsJ8+gJgv/xIx/0joLhfQxC43mcfj
         WV1W5yKL3jUl7DQT+Y1p1bCTG6hdzrYkaJ7iUVyMu11bgKW6G+Rt2tMaz84fvjvZxkbi
         ZxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035499; x=1746640299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzdcyVDs5KmZFcO+KePSm4+Ud/p9n76j0KYupv7ixbU=;
        b=XMzn3slN0pIRrGuMyVMwaZ6zhJG6b4+vgMg72LEE8VFMl4oUPHcmdXAzACah+/dECJ
         vF/3IA5rgIESwaSO/dajzpk7eMKp10EA8ncdwzNH3Y5VvZwn1leKljX2o9iymMGYw18f
         ajjnHZIvsHBLe4lhQnRnQzgAbphllmrtKzeiGpJI2Taj6HqS+jM3FAUAPgdaTmK0qvnD
         fKHWjSBm51pEtNjXr+AIPMIajhOV0gQYk6QfzImtd1ejOZX1wXNtnzCCpSbkQz1MG7H6
         K4r8FsqDKg4t1DJLZAtlabZ63dv1SGeKLicSy+1cXBDXNrazWtVjoxE4sXwCUcmZeyGI
         2Urg==
X-Forwarded-Encrypted: i=1; AJvYcCWdlT5WBWb32DUkHQCJx9NxD9PfXT7DxaVmfThPEarh14jUJ2Pa9q5FAX6AMSqiq4R8kC5w7Rr87jJvD2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0ql7qeLXpsehIuJVLOOPy7I2iPXxykOYbfHYtoJGmGW0IHHg
	daRhtJInHN2Xzl2XIURkA1Cb6oRXLLU17N5lm9sRPHMmjxjYUvI/zmL5qrkOxCDRSQKxh2h0uQ0
	OyC/Pww==
X-Google-Smtp-Source: AGHT+IFOPGbRFAxJkE+dEQP10DpVFZBKzSu9vIFxGxZ8r+laJ8avCeQVWaEft4PQXwRDgfVw41yAmv4ZGYUC
X-Received: from pgbdp2.prod.google.com ([2002:a05:6a02:f02:b0:b14:9a53:2226])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:394f:b0:1f5:8622:5ed5
 with SMTP id adf61e73a8af0-20ba6a18194mr167216637.3.1746035499179; Wed, 30
 Apr 2025 10:51:39 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:09 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-22-irogers@google.com>
Subject: [PATCH v2 21/47] perf demangle: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/demangle-java.c  | 4 ++--
 tools/perf/util/demangle-ocaml.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index ddf33d58bcd3..ee20f4d08765 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -42,9 +42,9 @@ static const char *base_types['Z' - 'A' + 1] = {
  *	error  : NULL
  */
 static char *
-__demangle_java_sym(const char *str, const char *end, char *buf, int maxlen, int mode)
+__demangle_java_sym(const char *str, const char *end, char *buf, size_t maxlen, int mode)
 {
-	int rlen = 0;
+	size_t rlen = 0;
 	int array = 0;
 	int narg = 0;
 	const char *q;
diff --git a/tools/perf/util/demangle-ocaml.c b/tools/perf/util/demangle-ocaml.c
index 9d707bb60b4b..25fe755df5ab 100644
--- a/tools/perf/util/demangle-ocaml.c
+++ b/tools/perf/util/demangle-ocaml.c
@@ -30,8 +30,7 @@ ocaml_demangle_sym(const char *sym)
 {
 	char *result;
 	int j = 0;
-	int i;
-	int len;
+	size_t i, len;
 
 	if (!ocaml_is_mangled(sym)) {
 		return NULL;
-- 
2.49.0.906.g1f30a19c02-goog


