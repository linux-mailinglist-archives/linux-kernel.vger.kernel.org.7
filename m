Return-Path: <linux-kernel+bounces-627598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B9DAA530B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AFE17DE43
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F5A2882C0;
	Wed, 30 Apr 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIVEqSQe"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119CC283FFA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035499; cv=none; b=JRaW8Ai/aKWwsq/9kYUDWdFiJ5rFNcLn/2ZE51JGPT8tDRQnhynazvSLCsyRfnHd42Bb1pHdh0yGia6FFpslsyefjwmSRLCnF56QKcjLnU2DovpDvQIcH07VyB2752KvjocHRnjeHdONUACu+bEaJ/s+hxRPu2kMm1DGo2qx41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035499; c=relaxed/simple;
	bh=gL0JsppexHfLgdpL9ybInupf5ODZNlBh95n4agspux4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mlUOB3yPG2NC5M6E431/p3ywfQduAX7uoWAbOilfIR0d1Pl+dv83Gj7L3UPTa8btxhzkAzAlbuuEgu9pFi6BMd8rVMup328WE3vQozBFGhVjL3sQTDew2S7dkO6lAFMp4lrwl7mGHkXihIhZsJ+LuHnfpDNHqca5r65R3rSylvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIVEqSQe; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a0a8ddcc4so159117a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035495; x=1746640295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAvYWpruCaKSQi/0IJYatNgrngaahUPrm34T+oxODBg=;
        b=DIVEqSQex2JJUwxW2WAAt8kT9M+jaEvSC7b82tpvjEUy8ESU2TShtzrT7w4F3AEPTS
         VZf8wJRs/n1PNeGINYBP37C5C+SNeaVVSWA8PRRXNcwdmKkL2K5WiitgeqB0M80rhVwL
         YfL8oa9p1BcQC/jAYUHeFv+xs6EKqAcZW5vuDNMWv72HH9PD680kLRESJwSknTgLEKOP
         YsoqXhyKMuccRPGiRnMZSiISEapvmOS+hLziVxZtQFxEaI+66RZzwuyxsO63Z3KNcqQh
         /hX6apcB+Rlkw9l0eVCeqAeQ7T1cjccig17KyHNraqrqwVzXLXjNkhys6uwKH8pc5Qks
         DFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035495; x=1746640295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAvYWpruCaKSQi/0IJYatNgrngaahUPrm34T+oxODBg=;
        b=Om6CKjiG5fjG/hVNl7FUfil502wDLLRiAKyQILCk5rdXS5oYjphK/SqZMKxdw8H+N2
         /qlX9kKbgBVH4NHj40MTjle4dAMEJNvYEQnZUJxs4j2ZsuTbta7mpXehyG/3HTrCU9Pk
         mMeIa2lHjbYEmS4W1Y3zNbmQsSgDiz841Ec4eT6eAfFUNPIdaSP0sOFG3VzAId73gyRT
         EVeVxeKX5KmugBqnQOC3JWvMkrpomhXFsKEnS2+q/QvSP1Jqtfl2mh1ZIQfIyQcT4GrR
         Ng8gzNdyPwOR1YqemCA8gfMV7zNATmfQg6SZv5U0aI7z0SSIq36oqhH00tnds/uaqMrL
         gIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtzGq0K1m1r0TZE/xFPYwHtJCxsiDmzwW0PFG9orh2ebueGNy8kml1RKhsE9eT/kheqzdyXSVf7zAqUHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYCWQoo7Tpse8rVjTQvNZNmfjnoT6MARPmIZiHdHHLGgaduQp
	ym3NLejUT+HyrOCImgTSHmRvH1KaHCKWeh+v023hcU+qxWnWxxluTfutN8uwd0XQnb26Iw1wSgu
	uIL+DdQ==
X-Google-Smtp-Source: AGHT+IFLW87NChKUpuru729ez+YTzQQPQ1zJZuAFZHyKX2/vqO6EiFywYU4NMbFp9eXaY3WEpeUQyVtWJ+aZ
X-Received: from pjbst3.prod.google.com ([2002:a17:90b:1fc3:b0:301:4260:4d23])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288a:b0:2fe:80cb:ac05
 with SMTP id 98e67ed59e1d1-30a332f75fcmr6116198a91.9.1746035495170; Wed, 30
 Apr 2025 10:51:35 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:07 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-20-irogers@google.com>
Subject: [PATCH v2 19/47] perf stat: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-stat.c      |  6 +++---
 tools/perf/util/metricgroup.c  | 15 +++++++--------
 tools/perf/util/stat-display.c | 10 +++++-----
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 300b6393bb41..8c6bf194bba0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -831,7 +831,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		l = strlen(counter->unit);
 		if (l > stat_config.unit_width)
-			stat_config.unit_width = l;
+			stat_config.unit_width = (unsigned int)l;
 
 		if (evsel__should_store_id(counter) &&
 		    evsel__store_ids(counter, evsel_list)) {
@@ -2099,7 +2099,7 @@ static int __cmd_record(const struct option stat_options[], struct opt_aggr_mode
 	session = perf_session__new(data, NULL);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed\n");
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 	}
 
 	init_features(session);
@@ -2281,7 +2281,7 @@ static int __cmd_report(int argc, const char **argv)
 
 	session = perf_session__new(&perf_stat.data, &perf_stat.tool);
 	if (IS_ERR(session))
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 
 	perf_stat.session  = session;
 	stat_config.output = stderr;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 46920ebadfd1..1e07dcaed3d7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -256,12 +256,10 @@ static struct metric *metric__new(const struct pmu_metric *pm,
 	return NULL;
 }
 
-static bool contains_metric_id(struct evsel **metric_events, int num_events,
+static bool contains_metric_id(struct evsel **metric_events, size_t num_events,
 			       const char *metric_id)
 {
-	int i;
-
-	for (i = 0; i < num_events; i++) {
+	for (size_t i = 0; i < num_events; i++) {
 		if (!strcmp(evsel__metric_id(metric_events[i]), metric_id))
 			return true;
 	}
@@ -355,7 +353,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 
 static bool match_metric(const char *metric_or_groups, const char *sought)
 {
-	int len;
+	size_t len;
 	char *m;
 
 	if (!sought)
@@ -570,7 +568,7 @@ static int encode_metric_id(struct strbuf *sb, const char *x)
 			if (ret)
 				break;
 
-			ret = strbuf_addch(sb, '0' + (c - code_characters));
+			ret = strbuf_addch(sb, '0' + (int)(c - code_characters));
 			if (ret)
 				break;
 		} else {
@@ -1145,7 +1143,8 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 	const struct metric *left = container_of(l, struct metric, nd);
 	const struct metric *right = container_of(r, struct metric, nd);
 	struct expr_id_data *data;
-	int i, left_count, right_count;
+	int i;
+	size_t left_count, right_count;
 
 	left_count = hashmap__size(left->pctx->ids);
 	tool_pmu__for_each_event(i) {
@@ -1159,7 +1158,7 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 			right_count--;
 	}
 
-	return right_count - left_count;
+	return (int)right_count - (int)left_count;
 }
 
 /**
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e852ac0d9847..0aa172cf5e39 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -622,7 +622,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[1024], str[1024];
-	unsigned mlen = config->metric_only_len;
+	size_t mlen = config->metric_only_len;
 	const char *color = metric_threshold_classify__color(thresh);
 
 	if (!valid_only_metric(unit))
@@ -635,7 +635,7 @@ static void print_metric_only(struct perf_stat_config *config,
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
 	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
-	fprintf(out, "%*s ", mlen, str);
+	fprintf(out, "%*s ", (int)mlen, str);
 	os->first = false;
 }
 
@@ -954,7 +954,7 @@ static void evsel__uniquify_counter(struct evsel *counter)
 
 	config = strchr(name, '/');
 	if (config) {
-		int len = config - name;
+		int len = (int)(config - name);
 
 		if (config[1] == '/') {
 			/* case: event// */
@@ -967,7 +967,7 @@ static void evsel__uniquify_counter(struct evsel *counter)
 		config = strchr(name, ':');
 		if (config) {
 			/* case: event:.. */
-			int len = config - name;
+			int len = (int)(config - name);
 
 			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
 		} else {
@@ -1493,7 +1493,7 @@ static int get_precision(double num)
 	if (num > 1)
 		return 0;
 
-	return lround(ceil(-log10(num)));
+	return (int)lround(ceil(-log10(num)));
 }
 
 static void print_table(struct perf_stat_config *config,
-- 
2.49.0.906.g1f30a19c02-goog


