Return-Path: <linux-kernel+bounces-676740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69607AD106B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 01:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382893AD996
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jun 2025 23:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292EC21C17D;
	Sat,  7 Jun 2025 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVH7etjK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2E21B8EC;
	Sat,  7 Jun 2025 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749338743; cv=none; b=bvp6AssmlFNlbw49btWrgo9tLa9Jiyfj1cGq++W0fcO+RU32zG8jXLzGq/E5g5fI6puxmoQN40yCZ6g9kSq6fmgK78koPfQs6tVQ6wThQiKBxrtp68XKj21h973Lube1uvyLvdJ8hkUbCf2xffhFfbuSLCzFwfRHZrc4JzWZMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749338743; c=relaxed/simple;
	bh=T9yHFF1na2c2C7Aj2Vras/4GcEhsUttmbx2hwG6Kfoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foXcdWeLuEOQj4YBed60GjnmjisRz1qa79F6HjULA06OMKNujfQgLaEKmuVlcPAvl2t+hl+LD59drKIG0RLTSQREBHEg6nlubUu98/OfwpRmBfQxqo0eJBejB7U52m9K0YWKvzSrjqhLHCyAdXpx9/E3jMA/WSeqzLsPGID/fGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVH7etjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84976C4CEF2;
	Sat,  7 Jun 2025 23:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749338742;
	bh=T9yHFF1na2c2C7Aj2Vras/4GcEhsUttmbx2hwG6Kfoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVH7etjK1YlZFLEkaG1CF970K9A37ChhtrcjRNLHjBojmEsFB0ctrWSgPxVR/9GV0
	 YH0eVb6dWFZ+mEv5mSSaKXY8DNRvSHDmX9fWgrf4z2UQFru1ja2mqC/L250LQCYzF1
	 IJDTFw0O2Pz1o8GzesHqOMnxnGoETRWqdRlGD5OK5snI4amYPptq/JMv6QAPb3QU2U
	 tNy3T7L6FRtpyr5oJevseTCwV1OHFaARjVEX3q+8oivNnKDZiyDa0RH0nCA3MN3GTB
	 qLP159MSVLebsT7+1bKLW07xzmwEQmHLqkvovIXSTcNDYfos3X3+g55U1LmTr+Boni
	 JtWuWDn0koc7Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH v2 3/7] perf annotate: Pass annotation_print_data to annotation_line__write()
Date: Sat,  7 Jun 2025 16:25:36 -0700
Message-ID: <20250607232540.89488-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607232540.89488-1-namhyung@kernel.org>
References: <20250607232540.89488-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will be used for data type display later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 13 ++++++++++--
 tools/perf/util/annotate.c        | 35 +++++++++++++++++--------------
 tools/perf/util/annotate.h        | 15 +++++++++++--
 3 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index af3e52ce4da62eb9..0057fb485e85aaaf 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -28,6 +28,8 @@ struct annotate_browser {
 	struct annotation_line	   *selection;
 	struct arch		   *arch;
 	struct hist_entry	   *he;
+	struct debuginfo	   *dbg;
+	struct evsel		   *evsel;
 	bool			    searching_backwards;
 	char			    search_bf[128];
 };
@@ -108,12 +110,18 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
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
@@ -902,7 +910,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		}
 		case 'P':
-			map_symbol__annotation_dump(ms, evsel);
+			map_symbol__annotation_dump(ms, evsel, browser->he);
 			continue;
 		case 't':
 			if (symbol_conf.show_total_period) {
@@ -987,6 +995,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			.use_navkeypressed = true,
 		},
 		.he = he,
+		.evsel = evsel,
 	};
 	struct dso *dso;
 	int ret = -1, err;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 58c33c9a58765b95..2089feb7c700ac4d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -765,15 +765,6 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
 			    struct debuginfo *dbg, struct disasm_line *dl,
 			    int *type_offset);
 
-struct annotation_print_data {
-	struct hist_entry *he;
-	struct evsel *evsel;
-	struct arch *arch;
-	struct debuginfo *dbg;
-	u64 start;
-	int addr_fmt_width;
-};
-
 static int
 annotation_line__print(struct annotation_line *al, struct annotation_print_data *apd,
 		       struct annotation_options *opts, int printed,
@@ -1230,7 +1221,6 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 	struct annotation_print_data apd = {
 		.he = he,
 		.evsel = evsel,
-		.start = map__rip_2objdump(map, sym->start),
 	};
 	int printed = 2, queue_len = 0;
 	int more = 0;
@@ -1357,7 +1347,8 @@ static void FILE__write_graph(void *fp, int graph)
 	fputs(s, fp);
 }
 
-static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
+static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
+				     struct annotation_print_data *apd)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotation_write_ops wops = {
@@ -1374,7 +1365,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 	list_for_each_entry(al, &notes->src->source, node) {
 		if (annotation_line__filter(al))
 			continue;
-		annotation_line__write(al, notes, &wops);
+		annotation_line__write(al, notes, &wops, apd);
 		fputc('\n', fp);
 		wops.first_line = false;
 	}
@@ -1382,13 +1373,18 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
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
@@ -1404,7 +1400,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel)
 
 	fprintf(fp, "%s() %s\nEvent: %s\n\n",
 		ms->sym->name, dso__long_name(map__dso(ms->map)), ev_name);
-	symbol__annotate_fprintf2(ms->sym, fp);
+	symbol__annotate_fprintf2(ms->sym, fp, &apd);
 
 	fclose(fp);
 	err = 0;
@@ -1655,6 +1651,10 @@ int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel)
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 	struct hists *hists = evsel__hists(evsel);
+	struct annotation_print_data apd = {
+		.he = he,
+		.evsel = evsel,
+	};
 	char buf[1024];
 	int err;
 
@@ -1677,7 +1677,7 @@ int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel)
 	hists__scnprintf_title(hists, buf, sizeof(buf));
 	fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
 		buf, percent_type_str(annotate_opts.percent_type), sym->name, dso__long_name(dso));
-	symbol__annotate_fprintf2(sym, stdout);
+	symbol__annotate_fprintf2(sym, stdout, &apd);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
@@ -1935,7 +1935,8 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
 }
 
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *wops)
+			    struct annotation_write_ops *wops,
+			    struct annotation_print_data *apd)
 {
 	bool current_entry = wops->current_entry;
 	bool change_color = wops->change_color;
@@ -2113,6 +2114,8 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
 
 		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width - 3 - printed, bf);
+
+		(void)apd;
 	}
 
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 9cd723b8b987db1a..bc195bd0429e039d 100644
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
+	u64 start;
+	int addr_fmt_width;
+};
+
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *ops);
+			    struct annotation_write_ops *ops,
+			    struct annotation_print_data *apd);
 
 int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   char *bf, size_t size,
@@ -462,7 +472,8 @@ void symbol__annotate_zero_histogram(struct symbol *sym, struct evsel *evsel);
 void symbol__annotate_decay_histogram(struct symbol *sym, struct evsel *evsel);
 void annotated_source__purge(struct annotated_source *as);
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel);
+int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
+				struct hist_entry *he);
 
 bool ui__has_annotation(void);
 
-- 
2.49.0


