Return-Path: <linux-kernel+bounces-583975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C391CA78218
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F0A7A4ADE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C3221C176;
	Tue,  1 Apr 2025 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RUeNIbkc"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904A21B199
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531893; cv=none; b=CnXpq1T6qDaxE5C/zVBI9rpvR2THLJ4scM1szqWUVOWBNwU72MjlavQmOglM34DWi3kL8kdOL+iLYzg/8VKVsX3H3iwFFm7NrDUy3+UW7GJB1JJSEXRrPe3JQ+wnSvFCgN2EiQUDUEArlaiAPPgAMzlxEohexxwO35bZ306lZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531893; c=relaxed/simple;
	bh=0P58XmLkpByBZvdI5TWdtrNeDfsj05v0r9rxb/JMquo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kA1g+o/KwMst8H1GGuLXGx3L2i8St5NmcQHeAisarbUsKtQ32iroASZfuUYjJdAJU0yrlTOSd6v3HetgzTiD508vDhLTkIrNjfGa/ty2KhGH/ZkA8sWcdVvEReavabsC9NhXypoR4qY+MmAP+6w1moAWdq4ZMvTZ5BswK6JQlFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RUeNIbkc; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2c24c595a08so4162804fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531891; x=1744136691; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J47yx8VBSVt15VBEKEnq1pVWwRSrja1JAZojE6DwMo8=;
        b=RUeNIbkccYmEtcHNR0OECELDLaz1sS0ZlZGsws4t8c6EpNb6GK0eYy6jYdcVyELeWq
         DUScYSXFBRqy2F66VbZDlS0itZYkWUT1cdPfB+4ydZF9iGKlmJ46im6KdZjilUX8/1GY
         zt1eo0JVWQuZLSNFzLI+vrFxkrgLpGT2V+UhzjtJX9whwu/RmmlWLkmOfTUzVzlF+AkK
         q9wB7chFLoC73RRNWEfK2/tL5QSuVIPL95D0tQy08sEYJHlYNu6Ceidw82zWwMGjhftB
         uIZlxaqTS4VlBn8Sq2Yl7Cc47Z1wg79MJ3dgdla146FeqMTjbtEXbNnuq0wDidC1+YTt
         RSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531891; x=1744136691;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J47yx8VBSVt15VBEKEnq1pVWwRSrja1JAZojE6DwMo8=;
        b=ib+jLNhR3FVGdFOoAQ2odchgu1r8YVI7O7xTA3j/mrM9KCLPf+dFhnbrJg3L8R/BiW
         aQeSToalcoWxYUBb+bW5fg6GR6FeavBKPoofgmSvtZwxses3aY+MI9oErkoz8Z1lG4RZ
         kG+0hW9LOmv2xuC8vwhmaycC2+WqK/L/Ze+DsDCHzUOUxgnG4Cz/hyEcvEwlILK7AMLh
         6ShOXjTq2oNj4EAqg7QMcepavhJ8mCFUjuOUIGzarA9/FqAC8o2ehaIEhly6v+pWkBag
         7Td6p+OHiQz9UjieIcDosb/eAuVNklvsPHaYbnAul3fcg28d28ivcDoTIGK0cUfuoWls
         A8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUQo03eAupjUKsvkiDfH790AmsY+jHHLQF4/j3CKq4fQ6pTap7CMTvxfiqTsi3fj3avAqd2TAASRujonjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ndjeM/UiROFHbUNhygPCXwUAinAtlOtH4AT5sOWSjya/q94v
	9zuC4rY8HyuYNJw9EX+aR9pCHpGmTC+7DiTERYL38dbpmepHI2w3UDKCF22mgj5Hf9h1KsKkSul
	rWzQPkg==
X-Google-Smtp-Source: AGHT+IFbktdPc4EqMVUHFkxbKhOxMWhYPSzPPMPttQJuIG02RbiHk4MphqSQaB7uAgigA6m1vE8+hZ5rQgVO
X-Received: from oabwh31.prod.google.com ([2002:a05:6871:a69f:b0:2ba:b7af:e2be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:6120:b0:2b6:16f7:6488
 with SMTP id 586e51a60fabf-2cbcf7e0959mr8992443fac.34.1743531891042; Tue, 01
 Apr 2025 11:24:51 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:05 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-8-irogers@google.com>
Subject: [PATCH v1 07/48] tools subcmd: Silence -Wshorten-64-to-32 warnings
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

Move mput_char out of header file to its only use in help.c, while
changing its argument types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/help.c          | 28 ++++++++++++++++------------
 tools/lib/subcmd/help.h          |  6 ------
 tools/lib/subcmd/parse-options.c | 16 ++++++++--------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 8561b0f01a24..555b91ada0f9 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -125,13 +125,11 @@ static void get_term_dimensions(struct winsize *ws)
 	ws->ws_col = 80;
 }
 
-static void pretty_print_string_list(struct cmdnames *cmds, int longest)
+static void pretty_print_string_list(struct cmdnames *cmds, size_t longest)
 {
-	int cols = 1, rows;
-	int space = longest + 1; /* min 1 SP between words */
+	size_t cols = 1, rows, max_cols;
+	size_t space = longest + 1; /* min 1 SP between words */
 	struct winsize win;
-	int max_cols;
-	int i, j;
 
 	get_term_dimensions(&win);
 	max_cols = win.ws_col - 1; /* don't print *on* the edge */
@@ -140,12 +138,12 @@ static void pretty_print_string_list(struct cmdnames *cmds, int longest)
 		cols = max_cols / space;
 	rows = (cmds->cnt + cols - 1) / cols;
 
-	for (i = 0; i < rows; i++) {
+	for (size_t i = 0; i < rows; i++) {
 		printf("  ");
 
-		for (j = 0; j < cols; j++) {
-			unsigned int n = j * rows + i;
-			unsigned int size = space;
+		for (size_t j = 0; j < cols; j++) {
+			size_t n = j * rows + i;
+			int size = (int)space;
 
 			if (n >= cmds->cnt)
 				break;
@@ -180,7 +178,7 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 					 const char *path,
 					 const char *prefix)
 {
-	int prefix_len;
+	size_t prefix_len;
 	DIR *dir = opendir(path);
 	struct dirent *de;
 	char *buf = NULL;
@@ -194,7 +192,7 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 	astrcatf(&buf, "%s/", path);
 
 	while ((de = readdir(dir)) != NULL) {
-		int entlen;
+		size_t entlen;
 
 		if (!strstarts(de->d_name, prefix))
 			continue;
@@ -250,10 +248,16 @@ void load_command_list(const char *prefix,
 	exclude_cmds(other_cmds, main_cmds);
 }
 
+static void mput_char(char c, size_t num)
+{
+	while (num--)
+		putchar(c);
+}
+
 void list_commands(const char *title, struct cmdnames *main_cmds,
 		   struct cmdnames *other_cmds)
 {
-	unsigned int i, longest = 0;
+	size_t i, longest = 0;
 
 	for (i = 0; i < main_cmds->cnt; i++)
 		if (longest < main_cmds->names[i]->len)
diff --git a/tools/lib/subcmd/help.h b/tools/lib/subcmd/help.h
index 355c066c8d49..258b3a143cbc 100644
--- a/tools/lib/subcmd/help.h
+++ b/tools/lib/subcmd/help.h
@@ -14,12 +14,6 @@ struct cmdnames {
 	} **names;
 };
 
-static inline void mput_char(char c, unsigned int num)
-{
-	while(num--)
-		putchar(c);
-}
-
 void load_command_list(const char *prefix,
 		struct cmdnames *main_cmds,
 		struct cmdnames *other_cmds);
diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 555d617c1f50..add46b81a131 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -201,7 +201,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return 0;
 
 	case OPTION_SET_UINT:
-		*(unsigned int *)opt->value = unset ? 0 : opt->defval;
+		*(unsigned int *)opt->value = unset ? 0 : (unsigned int)opt->defval;
 		return 0;
 
 	case OPTION_SET_PTR:
@@ -256,12 +256,12 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return 0;
 		}
 		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
-			*(int *)opt->value = opt->defval;
+			*(int *)opt->value = (int)opt->defval;
 			return 0;
 		}
 		if (get_arg(p, opt, flags, &arg))
 			return -1;
-		*(int *)opt->value = strtol(arg, (char **)&s, 10);
+		*(int *)opt->value = (int)strtol(arg, (char **)&s, 10);
 		if (*s)
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
@@ -272,14 +272,14 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return 0;
 		}
 		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
-			*(unsigned int *)opt->value = opt->defval;
+			*(unsigned int *)opt->value = (unsigned int)opt->defval;
 			return 0;
 		}
 		if (get_arg(p, opt, flags, &arg))
 			return -1;
 		if (arg[0] == '-')
 			return opterror(opt, "expects an unsigned numerical value", flags);
-		*(unsigned int *)opt->value = strtol(arg, (char **)&s, 10);
+		*(unsigned int *)opt->value = (unsigned int)strtol(arg, (char **)&s, 10);
 		if (*s)
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
@@ -770,9 +770,9 @@ static void print_option_help(const struct option *opts, int full)
 		break;
 	}
 
-	if (pos <= USAGE_OPTS_WIDTH)
-		pad = USAGE_OPTS_WIDTH - pos;
-	else {
+	if (pos <= USAGE_OPTS_WIDTH) {
+		pad = (int)(USAGE_OPTS_WIDTH - pos);
+	} else {
 		fputc('\n', stderr);
 		pad = USAGE_OPTS_WIDTH;
 	}
-- 
2.49.0.504.g3bcea36a83-goog


