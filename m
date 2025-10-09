Return-Path: <linux-kernel+bounces-846222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4233CBC74F2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D6124E18CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45FB23BCE3;
	Thu,  9 Oct 2025 03:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYQ0MaPi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A52376FD;
	Thu,  9 Oct 2025 03:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980948; cv=none; b=c6Xz9OY/L8ABCI5PNxdsxcLF3Ch7OXcr3pTkrSuFyc80O8ihcCgaY/lSPJau9yLra/uPYzIlPH3w4pL6CUhXmnP/aZD6e14YjDxn4h5iocrF7PJAeOMeiSTYFpVZwK15m0nfs2ENXYxoykWbW9fZh9oRHIQR8JtXI2Hnd/wDFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980948; c=relaxed/simple;
	bh=TAkre2RsHL2EDpN2llo+FtugM5LnLwO+oR1iRAFwHnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7lc1mCzO5yPdRd0WuVlrHxrlow9mBfF0SINV3K6CXaNY5DO1WT7DTarGfHYjHQlYnUGGvbwNAsA+4fbgEiLFUiMm1jrP9e2LaaqduDoyntwDIDQUgGctU+vX2TYfMQZ/SbKqMZCxo7cmXIuAzEOkwKzj0DvYJORk7EHXUfvHdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYQ0MaPi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759980948; x=1791516948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAkre2RsHL2EDpN2llo+FtugM5LnLwO+oR1iRAFwHnM=;
  b=nYQ0MaPibJhJTcpPD5SwzLas6DRcGdvTRqFCAdRtNCx8lC477EFYckAq
   Xkx1o161455bp9kvFOxfeRZ+iKhtEpcb7t+tP2GYKlpcH66Uh+DmA1iE8
   nvZZOrTJcYM/FvWNe4HK9JkjUalhJkY5mwGyfgdY0rgrbpf+JtU4NNiq9
   fbgwy3SlbJrPYwgfohEnOHcXcr2jIYvuTEbr2pwcTt4gU43bCaYzhdYb1
   WDqUG3TzdDYMhHDwf6fiqf0LMogN1E71RifennSaum0IC74igRuD2ZGwa
   b6gGURo/fwnv5cOgmgAUiV8yT0K+jHLjocWKr4wCMSHUCm2Yzx0E3KePx
   A==;
X-CSE-ConnectionGUID: R7aUmUA6SVWyiTuVJwN+5Q==
X-CSE-MsgGUID: ffVsTetuR9CRgcCBYbWi7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65829448"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="65829448"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 20:35:47 -0700
X-CSE-ConnectionGUID: xRLa3U8IQWKA2pn5jd9Jeg==
X-CSE-MsgGUID: lh+AC33yTwuNHPjwk8YxHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="181014635"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by fmviesa008.fm.intel.com with ESMTP; 08 Oct 2025 20:35:42 -0700
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
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	pan.deng@intel.com,
	zhiguo.zhou@intel.com,
	jiebin.sun@intel.com,
	thomas.falcon@intel.com,
	dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] perf tools c2c: Add annotation support to perf c2c report
Date: Thu,  9 Oct 2025 12:28:39 +0800
Message-ID: <20251009042839.1643396-1-tianyou.li@intel.com>
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


