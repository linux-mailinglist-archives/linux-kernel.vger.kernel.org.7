Return-Path: <linux-kernel+bounces-847885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B32BCBF3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBC5B351966
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0243275AF5;
	Fri, 10 Oct 2025 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7GDJ8/W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B33218AAF;
	Fri, 10 Oct 2025 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081996; cv=none; b=DQuOEIBbXhp2etcZaSP8KQhozxNcqB8FxG54XNj5uBryZ8/vk9s0qaAMualm8lIZ7Aked8kHEr+C30aahaV7R7vGwaeEpbiutU32wN90sDnTIUxZiXyuxhjOjunEJUJ7SI101IbILndnTnBGF+4KaecDQiZTPDg4Q9MfALuOgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081996; c=relaxed/simple;
	bh=TAkre2RsHL2EDpN2llo+FtugM5LnLwO+oR1iRAFwHnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNsy+dpqTB8Fsnmf0FlJaM07/Y+fW3UKr/L/UKyroZcCKOUnj+SGDMMoVV2pc7+JmAiiUJPy1kGGLsk6cdoTlk1nL2bfNb9+YHZwx2shQCYAvlEbpi6XX6MTaWLGJmzyL1EMDMY6SBhnxCLUdsOECDokLGA+R538sqf9luN7+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7GDJ8/W; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760081994; x=1791617994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAkre2RsHL2EDpN2llo+FtugM5LnLwO+oR1iRAFwHnM=;
  b=E7GDJ8/W/f51pK3wmAyQZ29MUpqEdbCoWFEtthGuMVTWNVLpghj01DWN
   Z8Q3ZlRTHvnsou7YeQUIu+j/hCFO53e70R/+APomdpVibCr0E44RLKN4s
   YrNG69mBA7KEbXhj2AnTAMMlkX/s3Yt+JFZUuGh9MtGNK1xf3gz8iYx7q
   ymXUh5wR69qMWj4waRGQ2TjIa6JKnbIZV4ooJVXkz/TSNpvvK8+Ymsha1
   N47/IsvAjyXsGvZcHrIWV0wkvjXY4xrZu9nd8JP/C8bT9m4SFZwgsHSOh
   sL74frU+bcmj65B78Q1EXSV3hnGObMvD4upZXLUdnrmjWXcVOtEpPUBpi
   g==;
X-CSE-ConnectionGUID: nffznzpET1GwWxoDUG8/TQ==
X-CSE-MsgGUID: tyEU8kSkRhq4eebV0rIhDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79942273"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="79942273"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 00:39:53 -0700
X-CSE-ConnectionGUID: eBv6KxYATpCxGHZ9eq96LA==
X-CSE-MsgGUID: GwWlZqxXScCa1g7sLUV6sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="180502306"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by orviesa009.jf.intel.com with ESMTP; 10 Oct 2025 00:39:48 -0700
From: Tianyou Li <tianyou.li@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	pan.deng@intel.com,
	zhiguo.zhou@intel.com,
	jiebin.sun@intel.com,
	thomas.falcon@intel.com,
	dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] perf tools c2c: Add annotation support to perf c2c report
Date: Fri, 10 Oct 2025 16:33:11 +0800
Message-ID: <20251010083313.1839179-1-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aOTOEcNOiUiEJ9tz@google.com>
References: <aOTOEcNOiUiEJ9tz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perf c2c report currently specified the code address and source:line
information in the cacheline browser, while it is lack of annotation
support like perf report to directly show the disassembly code for
the particular symbol shared that same cacheline. This patches add
a key 'a' binding to the cacheline browser which reuse the annotation
browser to show the disassembly view for easier analysis of cacheline
contentions.

Signed-off-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
Reviewed-by: Pan Deng <pan.deng@intel.com>
Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/Documentation/perf-c2c.txt |   7 ++
 tools/perf/builtin-c2c.c              | 137 +++++++++++++++++++++++++-
 2 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index f4af2dd6ab31..40b0f71a2c44 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -143,6 +143,13 @@ REPORT OPTIONS
 	feature, which causes cacheline sharing to behave like the cacheline
 	size is doubled.
 
+-M::
+--disassembler-style=::
+	Set disassembler style for objdump.
+
+--objdump=<path>::
+        Path to objdump binary.
+
 C2C RECORD
 ----------
 The perf c2c record command setup options related to HITM cacheline analysis
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 9e9ff471ddd1..878913115b45 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -45,6 +45,8 @@
 #include "pmus.h"
 #include "string2.h"
 #include "util/util.h"
+#include "util/symbol.h"
+#include "util/annotate.h"
 
 struct c2c_hists {
 	struct hists		hists;
@@ -62,6 +64,7 @@ struct compute_stats {
 
 struct c2c_hist_entry {
 	struct c2c_hists	*hists;
+	struct evsel		*evsel;
 	struct c2c_stats	 stats;
 	unsigned long		*cpuset;
 	unsigned long		*nodeset;
@@ -225,6 +228,12 @@ he__get_c2c_hists(struct hist_entry *he,
 	return hists;
 }
 
+static void c2c_he__set_evsel(struct c2c_hist_entry *c2c_he,
+				struct evsel *evsel)
+{
+	c2c_he->evsel = evsel;
+}
+
 static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
 			    struct perf_sample *sample)
 {
@@ -334,6 +343,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 	c2c_he__set_cpu(c2c_he, sample);
 	c2c_he__set_node(c2c_he, sample);
+	c2c_he__set_evsel(c2c_he, evsel);
 
 	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 	ret = hist_entry__append_callchain(he, sample);
@@ -371,6 +381,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 		c2c_he__set_cpu(c2c_he, sample);
 		c2c_he__set_node(c2c_he, sample);
+		c2c_he__set_evsel(c2c_he, evsel);
 
 		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 		ret = hist_entry__append_callchain(he, sample);
@@ -1997,6 +2008,9 @@ static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name, stru
 	if (dim == &dim_dso)
 		hpp_list->dso = 1;
 
+	if (dim == &dim_symbol || dim == &dim_iaddr)
+		hpp_list->sym = 1;
+
 	perf_hpp_list__register_sort_field(hpp_list, &c2c_fmt->fmt);
 	return 0;
 }
@@ -2549,7 +2563,56 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 	print_pareto(out, perf_session__env(session));
 }
 
+/*
+ * Return true if annotation is possible. When list is NULL,
+ * it means that we are called at the c2c_browser level,
+ * in that case we allow annotation to be initialized. When list
+ * is non-NULL, it means that we are called at the cacheline_browser
+ * level, in that case we allow annotation only if use_browser
+ * is set and symbol information is available.
+ */
+static bool perf_c2c__has_annotation(struct perf_hpp_list *list)
+{
+	if (use_browser != 1)
+		return false;
+	return !list || list->sym;
+}
+
 #ifdef HAVE_SLANG_SUPPORT
+
+static int perf_c2c__toggle_annotation(struct hist_browser *browser)
+{
+	struct hist_entry *he = browser->he_selection;
+	struct symbol *sym = NULL;
+	struct annotated_source *src = NULL;
+	struct c2c_hist_entry *c2c_he = NULL;
+
+	if (!perf_c2c__has_annotation(he->hists->hpp_list)) {
+		ui_browser__help_window(&browser->b, "No annotation support");
+		return 0;
+	}
+
+	if (he == NULL) {
+		ui_browser__help_window(&browser->b, "No entry selected for annotation");
+		return 0;
+	}
+
+	sym = he->ms.sym;
+	if (sym == NULL) {
+		ui_browser__help_window(&browser->b, "Can not annotate, no symbol found");
+		return 0;
+	}
+
+	src = symbol__hists(sym, 0);
+	if (src == NULL) {
+		ui_browser__help_window(&browser->b, "Failed to initialize annotation source");
+		return 0;
+	}
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL);
+}
+
 static void c2c_browser__update_nr_entries(struct hist_browser *hb)
 {
 	u64 nr_entries = 0;
@@ -2617,6 +2680,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	" ENTER         Toggle callchains (if present) \n"
 	" n             Toggle Node details info \n"
 	" s             Toggle full length of symbol and source line columns \n"
+	" a             Toggle annotation view \n"
 	" q             Return back to cacheline list \n";
 
 	if (!he)
@@ -2651,6 +2715,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 			c2c.node_info = (c2c.node_info + 1) % 3;
 			setup_nodes_header();
 			break;
+		case 'a':
+			perf_c2c__toggle_annotation(browser);
+			break;
 		case 'q':
 			goto out;
 		case '?':
@@ -3006,6 +3073,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	const char *display = NULL;
 	const char *coalesce = NULL;
 	bool no_source = false;
+	const char *disassembler_style = NULL, *objdump_path = NULL;
 	const struct option options[] = {
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
@@ -3033,6 +3101,10 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
 		    "Enable LBR callgraph stitching approach"),
 	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
+	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
+		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
+	OPT_STRING(0, "objdump", &objdump_path, "path",
+		   "objdump binary to use for disassembly and annotations"),
 	OPT_PARENT(c2c_options),
 	OPT_END()
 	};
@@ -3040,6 +3112,12 @@ static int perf_c2c__report(int argc, const char **argv)
 	const char *output_str, *sort_str = NULL;
 	struct perf_env *env;
 
+	annotation_options__init();
+
+	err = hists__init();
+	if (err < 0)
+		goto out;
+
 	argc = parse_options(argc, argv, options, report_c2c_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	if (argc)
@@ -3052,6 +3130,27 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (c2c.stats_only)
 		c2c.use_stdio = true;
 
+	/**
+	 * Annotation related options disassembler_style, objdump_path are set
+	 * in the c2c_options, so we can use them here.
+	 */
+	if (disassembler_style) {
+		annotate_opts.disassembler_style = strdup(disassembler_style);
+		if (!annotate_opts.disassembler_style) {
+			err = -ENOMEM;
+			pr_err("Failed to allocate memory for annotation options\n");
+			goto out;
+		}
+	}
+	if (objdump_path) {
+		annotate_opts.objdump_path = strdup(objdump_path);
+		if (!annotate_opts.objdump_path) {
+			err = -ENOMEM;
+			pr_err("Failed to allocate memory for annotation options\n");
+			goto out;
+		}
+	}
+
 	err = symbol__validate_sym_arguments();
 	if (err)
 		goto out;
@@ -3126,6 +3225,38 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (err)
 		goto out_mem2node;
 
+	if (c2c.use_stdio)
+		use_browser = 0;
+	else
+		use_browser = 1;
+
+	/*
+	 * Only in the TUI browser we are doing integrated annotation,
+	 * so don't allocate extra space that won't be used in the stdio
+	 * implementation.
+	 */
+	if (perf_c2c__has_annotation(NULL)) {
+		int ret = symbol__annotation_init();
+
+		if (ret < 0)
+			goto out_mem2node;
+		/*
+		 * For searching by name on the "Browse map details".
+		 * providing it only in verbose mode not to bloat too
+		 * much struct symbol.
+		 */
+		if (verbose > 0) {
+			/*
+			 * XXX: Need to provide a less kludgy way to ask for
+			 * more space per symbol, the u32 is for the index on
+			 * the ui browser.
+			 * See symbol__browser_index.
+			 */
+			symbol_conf.priv_size += sizeof(u32);
+		}
+		annotation_config__init();
+	}
+
 	if (symbol__init(env) < 0)
 		goto out_mem2node;
 
@@ -3135,11 +3266,6 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_mem2node;
 	}
 
-	if (c2c.use_stdio)
-		use_browser = 0;
-	else
-		use_browser = 1;
-
 	setup_browser(false);
 
 	err = perf_session__process_events(session);
@@ -3210,6 +3336,7 @@ static int perf_c2c__report(int argc, const char **argv)
 out_session:
 	perf_session__delete(session);
 out:
+	annotation_options__exit();
 	return err;
 }
 
-- 
2.47.1


