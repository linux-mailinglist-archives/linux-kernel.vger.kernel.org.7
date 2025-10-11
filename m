Return-Path: <linux-kernel+bounces-849039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731E9BCF0F7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D294279D7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0537226D0C;
	Sat, 11 Oct 2025 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H41X36U+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CE223DC6;
	Sat, 11 Oct 2025 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167394; cv=none; b=R54onw4dQTNmEDptONKz0g9lfudNbac2AesYRMh/yerVGILdqCxbIE0V5X/RB9oxjYMPLxQfjrzslXku3n2eIjZW+2HZ8oma1QJHIJPmLR8CzaZia3eRbxZ4CRtfE+g51JVvJ9182hSx5GAWNMwyUpbKZ/jRLqZ4smRvKg74KhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167394; c=relaxed/simple;
	bh=uoOY0lPAUU1ewzS9mQj6hSvSCDavaMBzHcwM9wDmeA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvKGGZD7relAr1aViXerOrV4ekL3fCjfdooiREXJ9Fd5J+d4SoI2RFcPs/TTUP2Yb9rqwW0fj8vJCRxklqKL1U8NHv4r3V8To8AkEXylWo2bGUMJaTCl60JGsxcEC3A8aPmswMYPaGJdQcPV//M/gQ6536rggBmw8KhygnfG1Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H41X36U+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760167392; x=1791703392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uoOY0lPAUU1ewzS9mQj6hSvSCDavaMBzHcwM9wDmeA4=;
  b=H41X36U+IPoif2qtCeKCdK4meLLw+MwPnIfX/588Jyd8hBVM2j8zcKac
   FA+cMnFYNS0q9R7oqg3ukvc3ORNrMMIYsMJxYgrdY/S77L7pr4czYgVnX
   J8Ma7vDSRmwcdpI75y3R1ruVJO64qQSk2rSTc510+iuwpiVM3dn62aHfN
   epcdbxWWtSb7Rx2MoUDf9KTCzJEgg3Lj8IpoMwbwDvW3Kil7/gXv/w/DB
   C3wLMl6si8rwthl7ynDzQx1E8U8Mxo49sNIeBhSg/lPRtrOwIlhzB/CGo
   SS6zcQ3qk9Nutx8uP4n//nNVhI0tZ/HQ1TfS5A+BkuwgOmw66LtzbspXz
   g==;
X-CSE-ConnectionGUID: 0BqomM/qRpyEh25qFSPsiw==
X-CSE-MsgGUID: Ol5HPIUbThWS8+5+O9s3oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="73483602"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="73483602"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 00:23:12 -0700
X-CSE-ConnectionGUID: z6Oc5SOmS0mBsghBB4940g==
X-CSE-MsgGUID: 8kyh+UmiRVasvEz6A5OU9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="181577037"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by fmviesa008.fm.intel.com with ESMTP; 11 Oct 2025 00:23:07 -0700
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
Subject: [PATCH v7 2/2] perf tools c2c: Highlight the contention line in the annotate browser
Date: Sat, 11 Oct 2025 16:16:25 +0800
Message-ID: <20251011081625.1953652-2-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aOkFWaFD42Jy7V0f@google.com>
References: <aOkFWaFD42Jy7V0f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to highlight the contention line in the annotate browser,
use 'TAB'/'UNTAB' to refocus to the contention line.

Signed-off-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
Reviewed-by: Pan Deng <pan.deng@intel.com>
Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/builtin-annotate.c     |  2 +-
 tools/perf/builtin-c2c.c          |  6 +++-
 tools/perf/ui/browsers/annotate.c | 48 ++++++++++++++++++++++++++++---
 tools/perf/ui/browsers/hists.c    |  2 +-
 tools/perf/util/hist.h            |  6 ++--
 5 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 646f43b0f7c4..112b15952016 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
 			/* skip missing symbols */
 			nd = rb_next(nd);
 		} else if (use_browser == 1) {
-			key = hist_entry__tui_annotate(he, evsel, NULL);
+			key = hist_entry__tui_annotate(he, evsel, NULL, NO_ADDR);
 
 			switch (key) {
 			case -1:
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e4841cce55e6..1946c3409e9f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2588,6 +2588,7 @@ static int perf_c2c__toggle_annotation(struct hist_browser *browser)
 	struct symbol *sym = NULL;
 	struct annotated_source *src = NULL;
 	struct c2c_hist_entry *c2c_he = NULL;
+	u64 al_addr = NO_ADDR;
 
 	if (!perf_c2c__has_annotation(he->hists->hpp_list)) {
 		ui_browser__help_window(&browser->b, "No annotation support");
@@ -2611,8 +2612,11 @@ static int perf_c2c__toggle_annotation(struct hist_browser *browser)
 		return 0;
 	}
 
+	if (he->mem_info)
+		al_addr = mem_info__iaddr(he->mem_info)->al_addr;
+
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
-	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL);
+	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL, al_addr);
 }
 
 static void c2c_browser__update_nr_entries(struct hist_browser *hb)
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8fe699f98542..112fe6ad112e 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -605,7 +605,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
 	annotation__unlock(notes);
-	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
+	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_ADDR);
 
 	/*
 	 * The annotate_browser above changed the title with the target function
@@ -852,6 +852,16 @@ static void annotate_browser__debuginfo_warning(struct annotate_browser *browser
 	}
 }
 
+static s64 annotate_browser__curr_hot_offset(struct annotate_browser *browser)
+{
+	struct annotation_line *al = NULL;
+
+	if (browser->curr_hot)
+		al = rb_entry(browser->curr_hot, struct annotation_line, rb_node);
+
+	return al ? al->offset : 0;
+}
+
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct evsel *evsel,
 				 struct hist_browser_timer *hbt)
@@ -873,6 +883,11 @@ static int annotate_browser__run(struct annotate_browser *browser,
 
 	annotate_browser__calc_percent(browser, evsel);
 
+	if (browser->selection != NULL) {
+		browser->curr_hot = &browser->selection->rb_node;
+		browser->b.use_navkeypressed = false;
+	}
+
 	if (browser->curr_hot) {
 		annotate_browser__set_rb_top(browser, browser->curr_hot);
 		browser->b.navkeypressed = false;
@@ -969,8 +984,19 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			nd = browser->curr_hot;
 			break;
 		case 's':
+			struct annotation_line *al = NULL;
+			s64 offset = annotate_browser__curr_hot_offset(browser);
+
 			if (annotate_browser__toggle_source(browser, evsel))
 				ui_helpline__puts(help);
+
+			/* Update the annotation browser's rb_tree, and reset the nd */
+			annotate_browser__calc_percent(browser, evsel);
+			/* Try to find the same asm line as before */
+			al = annotated_source__get_line(notes->src, offset);
+			browser->curr_hot = al ? &al->rb_node : NULL;
+			nd = browser->curr_hot;
+
 			annotate__scnprintf_title(hists, title, sizeof(title));
 			annotate_browser__show(browser, title, help);
 			continue;
@@ -1106,19 +1132,19 @@ static int annotate_browser__run(struct annotate_browser *browser,
 }
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
-			     struct hist_browser_timer *hbt)
+			     struct hist_browser_timer *hbt, u64 al_addr)
 {
 	/* reset abort key so that it can get Ctrl-C as a key */
 	SLang_reset_tty();
 	SLang_init_tty(0, 0, 0);
 	SLtty_set_suspend_state(true);
 
-	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
+	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt, al_addr);
 }
 
 int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			       struct evsel *evsel,
-			       struct hist_browser_timer *hbt)
+			       struct hist_browser_timer *hbt, u64 al_addr)
 {
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
@@ -1188,6 +1214,20 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	if (annotate_opts.hide_src_code)
 		ui_browser__init_asm_mode(&browser.b);
 
+	/*
+	 * If al_addr is set, it means that there should be a line
+	 * intentionally selected, not based on the percentages
+	 * which caculated by the event sampling. In this case, we
+	 * convey this information into the browser selection, where
+	 * the selection in other cases should be empty.
+	 */
+	if (al_addr != NO_ADDR) {
+		struct annotation_line *al = annotated_source__get_line(notes->src,
+			al_addr - sym->start);
+
+		browser.selection = al;
+	}
+
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
 	debuginfo__delete(browser.dbg);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 487c0b08c003..08fecbe28a52 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2485,7 +2485,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 		evsel = hists_to_evsel(browser->hists);
 
 	he = hist_browser__selected_entry(browser);
-	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
+	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt, NO_ADDR);
 	/*
 	 * offer option to annotate the other branch source or target
 	 * (if they exists) when returning from annotate
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index c64005278687..6795816eee85 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -713,12 +713,14 @@ struct block_hist {
 #include "../ui/keysyms.h"
 void attr_to_script(char *buf, struct perf_event_attr *attr);
 
+#define NO_ADDR 0
+
 int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			       struct evsel *evsel,
-			       struct hist_browser_timer *hbt);
+			       struct hist_browser_timer *hbt, u64 al_addr);
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
-			     struct hist_browser_timer *hbt);
+			     struct hist_browser_timer *hbt, u64 al_addr);
 
 int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
 			     float min_pcnt, struct perf_env *env, bool warn_lost_event);
-- 
2.47.1


