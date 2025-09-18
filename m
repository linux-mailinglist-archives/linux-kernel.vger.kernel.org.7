Return-Path: <linux-kernel+bounces-771670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244C5B28A39
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42233BC1BF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F05C1DD0EF;
	Sat, 16 Aug 2025 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1kZrns5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E51D61AA;
	Sat, 16 Aug 2025 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314207; cv=none; b=oCkP0wQf2L26coZ1VlxN9RCdzz1tMFCeN94GqyMLq2iDg1s2TrCcMzzo2oAqCceAkjnx3dvirgz6oaaLLkA5477JE4e8Vq1939CPKmT+pblzFMP5FWxUT7beeWk5FYqP5xY0eZ7H4WW9J6jyWXeGfYnMkWwjWAu8hPFJiI8G0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314207; c=relaxed/simple;
	bh=XZjti3XHrCfQO6sBCH1rEoGQI33dDS/jESNitnkg8sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmTQSzk2dyakcajlDBfOLbKqLlC3iOijAnGsy7JpPb1dKJzOXKJOWsaO3OiJVkAr4D4koNs0y8kgJS7U4jEWE/7oCoh/8Z2wxHP701GAmFrPN1M6a4eUL3NnLK0TH+J+uu3CqGrm5zlxtNME1+wmA7fKeAaWytvmOf7WFfDlWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1kZrns5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D467BC4CEF7;
	Sat, 16 Aug 2025 03:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314207;
	bh=XZjti3XHrCfQO6sBCH1rEoGQI33dDS/jESNitnkg8sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1kZrns5iInf7ajEa1hUfZXInS8s231+tgMQ4BCH9X/Umo//hrBcWlw7Qru3tf9Xy
	 hxGF2a7jlrXG5976aIHNC63QFyp70wpCC2z2H335qdlamC0XTCoRshWjX/bDjBPnas
	 rADct71SOqizWIaIdVtyciaYckIyc1PuQgpXG3Fp1i1AIE/n7bWtJ8S8zvAmKz2rxd
	 6hwNZDjA1ihPqhel/Aky/mGRIXaPy9KATNsse7XbCNWeMq6J7kY3qC+ii33XM6DU1b
	 nIn5fnJSkHJVFNA1TkOHp+1ZlU2cYLo5guY1nxv82sSfY/RO6+mvcjQ+KcBGFpO2lP
	 we8vOMO8YKcAA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 04/12] perf annotate: Pass annotation_print_data to annotation_line__write()
Date: Fri, 15 Aug 2025 20:16:27 -0700
Message-ID: <20250816031635.25318-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816031635.25318-1-namhyung@kernel.org>
References: <20250816031635.25318-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will be used for data type display later.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 13 ++++++++++--
 tools/perf/util/annotate.c        | 33 ++++++++++++++++++-------------
 tools/perf/util/annotate.h        | 15 ++++++++++++--
 3 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 4d5cbb86cbb6d506..3e8b111e3f12b030 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -33,6 +33,8 @@ struct annotate_browser {
 	 * its lifetime.
 	 */
 	struct hist_entry	   *he;
+	struct debuginfo	   *dbg;
+	struct evsel		   *evsel;
 	bool			    searching_backwards;
 	char			    search_bf[128];
 };
@@ -116,12 +118,18 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		.printf			 = annotate_browser__printf,
 		.write_graph		 = annotate_browser__write_graph,
 	};
+	struct annotation_print_data apd = {
+		.he = ab->he,
+		.arch = ab->arch,
+		.evsel = ab->evsel,
+		.dbg = ab->dbg,
+	};
 
 	/* The scroll bar isn't being used */
 	if (!browser->navkeypressed)
 		ops.width += 1;
 
-	annotation_line__write(al, notes, &ops);
+	annotation_line__write(al, notes, &ops, &apd);
 
 	if (ops.current_entry)
 		ab->selection = al;
@@ -984,7 +992,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		}
 		case 'P':
-			map_symbol__annotation_dump(ms, evsel);
+			map_symbol__annotation_dump(ms, evsel, browser->he);
 			continue;
 		case 't':
 			if (symbol_conf.show_total_period) {
@@ -1069,6 +1077,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			.use_navkeypressed = true,
 		},
 		.he = he,
+		.evsel = evsel,
 	};
 	struct dso *dso;
 	int ret = -1, err;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7929f108e35b4e65..2544d83a52a0a596 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -765,14 +765,6 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
 			    struct debuginfo *dbg, struct disasm_line *dl,
 			    int *type_offset);
 
-struct annotation_print_data {
-	struct hist_entry *he;
-	struct evsel *evsel;
-	struct arch *arch;
-	struct debuginfo *dbg;
-	int addr_fmt_width;
-};
-
 static int
 annotation_line__print(struct annotation_line *al, struct annotation_print_data *apd,
 		       struct annotation_options *opts, int printed,
@@ -1355,7 +1347,8 @@ static void FILE__write_graph(void *fp, int graph)
 	fputs(s, fp);
 }
 
-static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
+static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
+				     struct annotation_print_data *apd)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotation_write_ops wops = {
@@ -1372,7 +1365,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 	list_for_each_entry(al, &notes->src->source, node) {
 		if (annotation_line__filter(al))
 			continue;
-		annotation_line__write(al, notes, &wops);
+		annotation_line__write(al, notes, &wops, apd);
 		fputc('\n', fp);
 		wops.first_line = false;
 	}
@@ -1380,13 +1373,18 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 	return 0;
 }
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel)
+int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
+				struct hist_entry *he)
 {
 	const char *ev_name = evsel__name(evsel);
 	char buf[1024];
 	char *filename;
 	int err = -1;
 	FILE *fp;
+	struct annotation_print_data apd = {
+		.he = he,
+		.evsel = evsel,
+	};
 
 	if (asprintf(&filename, "%s.annotation", ms->sym->name) < 0)
 		return -1;
@@ -1402,7 +1400,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel)
 
 	fprintf(fp, "%s() %s\nEvent: %s\n\n",
 		ms->sym->name, dso__long_name(map__dso(ms->map)), ev_name);
-	symbol__annotate_fprintf2(ms->sym, fp);
+	symbol__annotate_fprintf2(ms->sym, fp, &apd);
 
 	fclose(fp);
 	err = 0;
@@ -1654,6 +1652,10 @@ int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel)
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 	struct hists *hists = evsel__hists(evsel);
+	struct annotation_print_data apd = {
+		.he = he,
+		.evsel = evsel,
+	};
 	char buf[1024];
 	int err;
 
@@ -1676,7 +1678,7 @@ int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel)
 	hists__scnprintf_title(hists, buf, sizeof(buf));
 	fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
 		buf, percent_type_str(annotate_opts.percent_type), sym->name, dso__long_name(dso));
-	symbol__annotate_fprintf2(sym, stdout);
+	symbol__annotate_fprintf2(sym, stdout, &apd);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
@@ -1934,7 +1936,8 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
 }
 
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    const struct annotation_write_ops *wops)
+			    const struct annotation_write_ops *wops,
+			    struct annotation_print_data *apd)
 {
 	bool current_entry = wops->current_entry;
 	bool change_color = wops->change_color;
@@ -2112,6 +2115,8 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
 
 		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width - 3 - printed, bf);
+
+		(void)apd;
 	}
 
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 2e28a24fa13a736a..86e858f5bf173152 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -199,8 +199,18 @@ struct annotation_write_ops {
 	void (*write_graph)(void *obj, int graph);
 };
 
+struct annotation_print_data {
+	struct hist_entry *he;
+	struct evsel *evsel;
+	struct arch *arch;
+	struct debuginfo *dbg;
+	/* It'll be set in hist_entry__annotate_printf() */
+	int addr_fmt_width;
+};
+
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    const struct annotation_write_ops *ops);
+			    const struct annotation_write_ops *ops,
+			    struct annotation_print_data *apd);
 
 int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   char *bf, size_t size,
@@ -463,7 +473,8 @@ void symbol__annotate_zero_histogram(struct symbol *sym, struct evsel *evsel);
 void symbol__annotate_decay_histogram(struct symbol *sym, struct evsel *evsel);
 void annotated_source__purge(struct annotated_source *as);
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel);
+int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
+				struct hist_entry *he);
 
 bool ui__has_annotation(void);
 
-- 
2.50.1


