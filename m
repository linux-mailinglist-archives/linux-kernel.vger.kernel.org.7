Return-Path: <linux-kernel+bounces-627609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B67AA5315
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B499E4E20
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F12295522;
	Wed, 30 Apr 2025 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfDckrfa"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E36E295501
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035520; cv=none; b=fDP1YIFsAw+wwlJ4QUpD3cPEYvfEj7EazjALFWET6H7PECFnGZkI38TmTh573tvAySsRNFI4xRoL71dJ+H54U5gABCRQXw4QhowTYU1HISsrunngrQkDlhLov6oBn72XhnSTl6utsNYS6TY0NjgEhnQ/9V0o5FchxqUDiW7qsfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035520; c=relaxed/simple;
	bh=N9Bs69Q0gHmhI4eo8xMCY3Rp0tQZHLDjeB46JguulvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bfyYo1VkAmHs/rT8rn6AL+MQ7+KPPXjTYuERLj/e9Kez5vCCcpuaSF9GT/XhSj7vQESHr2l+IH1PY/xG40u2+ovu5VGV3h/SINMWAWFQB783xjY2D7Xe8CvQ+0sKb2ThSVHRAFZt9wRBs2+jn07hdK7XolXoLwzePR6/3yf2mBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HfDckrfa; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b15e08f1eb4so57360a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035518; x=1746640318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7DcJ1qi6x2GgioZqECz9ghmDuadJ5RenRHwjo+uvBnM=;
        b=HfDckrfazPrUzCPJh4dZ897C02A1scHNWj2beT6nTQZ52hVyNFXZksOhS1KybWX11p
         yXjLi9fhVYWQqQ3005lvS8IqqGmg3NIJLgFWFc2r4aK+mZlgRBJJd8FEDIPh9ULstFq7
         S7pUbzRZTkgVlzWpI0G9c/pWb48hZV/rZ027+emsbMDlrekEeO7cDXkkMrJNF/amUnVb
         fX8x2lNh0YyOoQ4etUbBB5xnqZSpDveWduXGObQYEdqUUmxobELLID5eYh08JPVbAqnP
         P81+H8WzzMRC1O0clK2ZHWRapBHkOyw2Ti1OjvPFwU8eTPURWO/gpiEPwSGCaemiU+C9
         0gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035518; x=1746640318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DcJ1qi6x2GgioZqECz9ghmDuadJ5RenRHwjo+uvBnM=;
        b=r5QaUPAQbombNWOcn5ZRB/RGS0ghMzJC5kXQFHI9I5HqWXPZ3+g+ePZ86ukKwL+eyJ
         rvehIQk4wjy0gv2GT82tRBL4ud+oNzYcV1BQU+J6BauuYkI+jvLkBRZDIwoIRzRxwtUy
         GN3JWtYyE/k4tZCL6R2jktzfOBT82/rm3weXaVP45TsJcMbZQigjZEpxYp9J7LUqN9jL
         q7+6h8zDFMwagybo9PIyryiaxCW0EV0J7CBgf6nhc5AOGYFPsNC7nuBlHFQmD/XvjHnN
         JKMiHfRCXfiokHD1xVKmGagRGJYHI71pP3c/GGH3t8R6eRFq/DzYk5AFjLncacjAKH6J
         Ewpw==
X-Forwarded-Encrypted: i=1; AJvYcCUuvV0FeN6vJXTHf60kTpQfykpSowQhx3DeZ2RD7ZP/Q2eeWKyv/4XNM7Q3G79+jpcgfRJfg5lNJQAvm08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx24dj8mX7KiqIafw12B8fL43dn0g2d45s/03ZXjLZBkOE/bYeu
	jtDEUAmJIgJB/nEvGgLDiR7OAufDIGgVAPbEWOksZq1bJPL17ncwjnfZeJNTW29z1bG+vZBh84c
	CdYJ9SA==
X-Google-Smtp-Source: AGHT+IHk8/+NAcFZh2Wb9xOYFIlypRhZRhl9IF5IJNwhrNiC5zF54w1KI/Rd0Fsj1chyjvEwC8kJjpt3MV8G
X-Received: from pjbee6.prod.google.com ([2002:a17:90a:fc46:b0:2ff:852c:ceb8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5745:b0:2ea:a9ac:eee1
 with SMTP id 98e67ed59e1d1-30a332f6c1bmr6642182a91.10.1746035517863; Wed, 30
 Apr 2025 10:51:57 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:18 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-31-irogers@google.com>
Subject: [PATCH v2 30/47] perf mem: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-c2c.c     | 21 ++++++++++---------
 tools/perf/builtin-kmem.c    | 39 ++++++++++++++++++------------------
 tools/perf/builtin-mem.c     |  2 +-
 tools/perf/util/mem-events.c | 12 +++++------
 tools/perf/util/mem2node.c   |  2 +-
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e2e257bcc461..c99266b4f365 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1206,7 +1206,7 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 			break;
 		case 1:
 		{
-			int num = bitmap_weight(set, c2c.cpus_cnt);
+			int num = (int)bitmap_weight(set, c2c.cpus_cnt);
 			struct c2c_stats *stats = &c2c_he->node_stats[node];
 
 			ret = scnprintf(hpp->buf, hpp->size, "%2d{%2d ", node, num);
@@ -1249,7 +1249,7 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 			ret = scnprintf(hpp->buf, hpp->size, "%2d{", node);
 			advance_hpp(hpp, ret);
 
-			ret = bitmap_scnprintf(set, c2c.cpus_cnt, hpp->buf, hpp->size);
+			ret = (int)bitmap_scnprintf(set, c2c.cpus_cnt, hpp->buf, hpp->size);
 			advance_hpp(hpp, ret);
 
 			ret = scnprintf(hpp->buf, hpp->size, "}");
@@ -1911,7 +1911,7 @@ static int c2c_se_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			len = symbol_width(he->hists, dim->se);
 	}
 
-	return dim->se->se_snprintf(he, hpp->buf, hpp->size, len);
+	return dim->se->se_snprintf(he, hpp->buf, hpp->size, (unsigned int)len);
 }
 
 static int64_t c2c_se_cmp(struct perf_hpp_fmt *fmt,
@@ -2164,7 +2164,7 @@ static void set_node_width(struct c2c_hist_entry *c2c_he, int len)
 static int set_nodestr(struct c2c_hist_entry *c2c_he)
 {
 	char buf[30];
-	int len;
+	size_t len;
 
 	if (c2c_he->nodestr)
 		return 0;
@@ -2176,7 +2176,7 @@ static int set_nodestr(struct c2c_hist_entry *c2c_he)
 		len = scnprintf(buf, sizeof(buf), "N/A");
 	}
 
-	set_node_width(c2c_he, len);
+	set_node_width(c2c_he, (int)len);
 	c2c_he->nodestr = strdup(buf);
 	return c2c_he->nodestr ? 0 : -ENOMEM;
 }
@@ -2353,7 +2353,7 @@ static int hists__iterate_cb(struct hists *hists, hists__resort_cb_t cb)
 
 static void print_c2c__display_stats(FILE *out)
 {
-	int llc_misses;
+	uint64_t llc_misses;
 	struct c2c_stats *stats = &c2c.hists.stats;
 
 	llc_misses = get_load_llc_misses(stats);
@@ -2379,7 +2379,7 @@ static void print_c2c__display_stats(FILE *out)
 	fprintf(out, "  Load Remote DRAM                  : %10d\n", stats->rmt_dram);
 	fprintf(out, "  Load MESI State Exclusive         : %10d\n", stats->ld_excl);
 	fprintf(out, "  Load MESI State Shared            : %10d\n", stats->ld_shared);
-	fprintf(out, "  Load LLC Misses                   : %10d\n", llc_misses);
+	fprintf(out, "  Load LLC Misses                   : %10"PRIu64"\n", llc_misses);
 	fprintf(out, "  Load access blocked by data       : %10d\n", stats->blk_data);
 	fprintf(out, "  Load access blocked by address    : %10d\n", stats->blk_addr);
 	fprintf(out, "  Load HIT Local Peer               : %10d\n", stats->lcl_peer);
@@ -2738,9 +2738,10 @@ static void perf_c2c_display(struct perf_session *session)
 }
 #endif /* HAVE_SLANG_SUPPORT */
 
-static char *fill_line(const char *orig, int len)
+static char *fill_line(const char *orig, size_t len)
 {
-	int i, j, olen = strlen(orig);
+	size_t i, j;
+	size_t olen = strlen(orig);
 	char *buf;
 
 	buf = zalloc(len + 1);
@@ -3068,7 +3069,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	c2c.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &c2c.tool);
 	if (IS_ERR(session)) {
-		err = PTR_ERR(session);
+		err = (int)PTR_ERR(session);
 		pr_debug("Error creating perf session\n");
 		goto out;
 	}
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 67fb1946ef13..6a905161f21b 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -173,10 +173,10 @@ static int insert_caller_stat(unsigned long call_site,
 
 static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *sample)
 {
-	unsigned long ptr = evsel__intval(evsel, sample, "ptr"),
-		      call_site = evsel__intval(evsel, sample, "call_site");
-	int bytes_req = evsel__intval(evsel, sample, "bytes_req"),
-	    bytes_alloc = evsel__intval(evsel, sample, "bytes_alloc");
+	unsigned long ptr = evsel__intval(evsel, sample, "ptr");
+	unsigned long call_site = evsel__intval(evsel, sample, "call_site");
+	int bytes_req = (int)evsel__intval(evsel, sample, "bytes_req");
+	int bytes_alloc = (int)evsel__intval(evsel, sample, "bytes_alloc");
 
 	if (insert_alloc_stat(call_site, ptr, bytes_req, bytes_alloc, sample->cpu) ||
 	    insert_caller_stat(call_site, bytes_req, bytes_alloc))
@@ -202,7 +202,7 @@ static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *s
 		int node1, node2;
 
 		node1 = cpu__get_node((struct perf_cpu){.cpu = sample->cpu});
-		node2 = evsel__intval(evsel, sample, "node");
+		node2 = (int)evsel__intval(evsel, sample, "node");
 
 		/*
 		 * If the field "node" is NUMA_NO_NODE (-1), we don't take it
@@ -737,7 +737,7 @@ static char *compact_gfp_flags(char *gfp_flags)
 	return new_flags;
 }
 
-static char *compact_gfp_string(unsigned long gfp_flags)
+static char *compact_gfp_string(unsigned int gfp_flags)
 {
 	struct gfp_flag key = {
 		.flags = gfp_flags,
@@ -808,10 +808,9 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_sample *sample)
 {
 	u64 page;
-	unsigned int order = evsel__intval(evsel, sample, "order");
-	unsigned int gfp_flags = evsel__intval(evsel, sample, "gfp_flags");
-	unsigned int migrate_type = evsel__intval(evsel, sample,
-						       "migratetype");
+	unsigned int order = (unsigned int)evsel__intval(evsel, sample, "order");
+	unsigned int gfp_flags = (unsigned int)evsel__intval(evsel, sample, "gfp_flags");
+	unsigned int migrate_type = (unsigned int)evsel__intval(evsel, sample, "migratetype");
 	u64 bytes = kmem_page_size << order;
 	u64 callsite;
 	struct page_stat *pstat;
@@ -880,7 +879,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 static int evsel__process_page_free_event(struct evsel *evsel, struct perf_sample *sample)
 {
 	u64 page;
-	unsigned int order = evsel__intval(evsel, sample, "order");
+	unsigned int order = (unsigned int)evsel__intval(evsel, sample, "order");
 	u64 bytes = kmem_page_size << order;
 	struct page_stat *pstat;
 	struct page_stat this = {
@@ -1064,12 +1063,12 @@ static void __print_page_alloc_result(struct perf_session *session, int n_lines)
 	struct rb_node *next = rb_first(&page_alloc_sorted);
 	struct machine *machine = &session->machines.host;
 	const char *format;
-	int gfp_len = max(strlen("GFP flags"), max_gfp_len);
+	size_t gfp_len = max(strlen("GFP flags"), max_gfp_len);
 
 	printf("\n%.105s\n", graph_dotted_line);
 	printf(" %-16s | %5s alloc (KB) | Hits      | Order | Mig.type | %-*s | Callsite\n",
 	       use_pfn ? "PFN" : "Page", live_page ? "Live" : "Total",
-	       gfp_len, "GFP flags");
+		(int)gfp_len, "GFP flags");
 	printf("%.105s\n", graph_dotted_line);
 
 	if (use_pfn)
@@ -1102,7 +1101,7 @@ static void __print_page_alloc_result(struct perf_session *session, int n_lines)
 
 	if (n_lines == -1) {
 		printf(" ...              | ...              | ...       | ...   | ...      | %-*s | ...\n",
-		       gfp_len, "...");
+		       (int)gfp_len, "...");
 	}
 
 	printf("%.105s\n", graph_dotted_line);
@@ -1112,11 +1111,11 @@ static void __print_page_caller_result(struct perf_session *session, int n_lines
 {
 	struct rb_node *next = rb_first(&page_caller_sorted);
 	struct machine *machine = &session->machines.host;
-	int gfp_len = max(strlen("GFP flags"), max_gfp_len);
+	size_t gfp_len = max(strlen("GFP flags"), max_gfp_len);
 
 	printf("\n%.105s\n", graph_dotted_line);
 	printf(" %5s alloc (KB) | Hits      | Order | Mig.type | %-*s | Callsite\n",
-	       live_page ? "Live" : "Total", gfp_len, "GFP flags");
+	       live_page ? "Live" : "Total", (int)gfp_len, "GFP flags");
 	printf("%.105s\n", graph_dotted_line);
 
 	while (next && n_lines--) {
@@ -1137,14 +1136,14 @@ static void __print_page_caller_result(struct perf_session *session, int n_lines
 		       (unsigned long long)data->alloc_bytes / 1024,
 		       data->nr_alloc, data->order,
 		       migrate_type_str[data->migrate_type],
-		       gfp_len, compact_gfp_string(data->gfp_flags), caller);
+		       (int)gfp_len, compact_gfp_string(data->gfp_flags), caller);
 
 		next = rb_next(next);
 	}
 
 	if (n_lines == -1) {
 		printf(" ...              | ...       | ...   | ...      | %-*s | ...\n",
-		       gfp_len, "...");
+		       (int)gfp_len, "...");
 	}
 
 	printf("%.105s\n", graph_dotted_line);
@@ -1828,7 +1827,7 @@ static int parse_line_opt(const struct option *opt __maybe_unused,
 	if (!arg)
 		return -1;
 
-	lines = strtoul(arg, NULL, 10);
+	lines = (int)strtoul(arg, NULL, 10);
 
 	if (caller_flag > alloc_flag)
 		caller_lines = lines;
@@ -2001,7 +2000,7 @@ int cmd_kmem(int argc, const char **argv)
 
 	kmem_session = session = perf_session__new(&data, &perf_kmem);
 	if (IS_ERR(session))
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 
 	ret = -1;
 
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 5ec83cd85650..988b3877cde8 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -293,7 +293,7 @@ static int report_raw_events(struct perf_mem *mem)
 	session = perf_session__new(&data, &mem->tool);
 
 	if (IS_ERR(session))
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 
 	session->itrace_synth_opts = &itrace_synth_opts;
 
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 884d9aebce91..6ad99ace56e3 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -364,7 +364,7 @@ int perf_mem__tlb_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 	if (miss)
 		l += scnprintf(out + l, sz - l, " miss");
 
-	return l;
+	return (int)l;
 }
 
 static const char * const mem_lvl[] = {
@@ -476,7 +476,7 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 			l += scnprintf(out + l, sz - l, "Unknown level %d", lvl);
 
 		l += scnprintf(out + l, sz - l, " %s", hit_miss);
-		return l;
+		return (int)l;
 	}
 
 	lvl = data_src.mem_lvl;
@@ -499,7 +499,7 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 
 	if (printed) {
 		l += scnprintf(out + l, sz - l, " %s", hit_miss);
-		return l;
+		return (int)l;
 	}
 
 na:
@@ -559,7 +559,7 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 	if (*out == '\0')
 		l += scnprintf(out, sz - l, "N/A");
 
-	return l;
+	return (int)l;
 }
 
 int perf_mem__lck_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
@@ -593,14 +593,14 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 
 	if (!mask || (mask & PERF_MEM_BLK_NA)) {
 		l += scnprintf(out + l, sz - l, " N/A");
-		return l;
+		return (int)l;
 	}
 	if (mask & PERF_MEM_BLK_DATA)
 		l += scnprintf(out + l, sz - l, " Data");
 	if (mask & PERF_MEM_BLK_ADDR)
 		l += scnprintf(out + l, sz - l, " Addr");
 
-	return l;
+	return (int)l;
 }
 
 int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
index 03a7d7b27737..2d76626dec01 100644
--- a/tools/perf/util/mem2node.c
+++ b/tools/perf/util/mem2node.c
@@ -56,7 +56,7 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
 
 	for (i = 0; i < env->nr_memory_nodes; i++) {
 		n = &nodes[i];
-		max += bitmap_weight(n->set, n->size);
+		max += bitmap_weight(n->set, (unsigned int)n->size);
 	}
 
 	entries = zalloc(sizeof(*entries) * max);
-- 
2.49.0.906.g1f30a19c02-goog


