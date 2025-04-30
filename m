Return-Path: <linux-kernel+bounces-627901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A54AA5653
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 23:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9D99A4048
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 21:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7682D269F;
	Wed, 30 Apr 2025 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SV99qIUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780F2D113A;
	Wed, 30 Apr 2025 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046555; cv=none; b=ZlPLKT1VcP1bsV79Vb9SCry+GKIpFtpLSQ6IlxjBt0WpNItonOL42MyrI2NVTW9SKTOFXK+pFjQ1YteuIEmUfbYK/mTJiibLEVxLnY3eoWjlVyUCNAggGcw0gLyNeykK1RSuWDz9Etk2w9a4ydjvHXkoAfZbCBAXnzS314w2F60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046555; c=relaxed/simple;
	bh=FXs7Rohm0pdrL2NM/hmA4w+IkGo+yWcS9CG3bdF8zvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTygKChqmuMg/aSmUXoHmBeFt0USkuCDfZqQLleXVP+Flkr9a7ssmLqsnZT6uNVPjddEg+qjv4wwrj9Wm9l5rK90zRSxbw2CQ28CWiOwCUj6ehUlEMhviLIVgjOBT3bWPnR2EOWoJ+uf3/P+4wxCHCrNdTbDx6bWfHzIs9K3Ow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SV99qIUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F4EC4CEEE;
	Wed, 30 Apr 2025 20:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046554;
	bh=FXs7Rohm0pdrL2NM/hmA4w+IkGo+yWcS9CG3bdF8zvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SV99qIULKxts2NspPjNzYzoV2ZXwjzYgIgjjHKHrSOqPSrUaZVwXcZf1RDRH7mbcG
	 kIecp0fAaNmzs/SHYlolFRphUZCebfjmr/gyOtWiCT5eClcyOMJ9A2u3YBtMiADIH+
	 7aliaEvVqZhBDfmsW5RcJl7DNwT58V1QJzuo4f7RY4XgsDszhYUyXrUzxEI8JgHe5L
	 XKeouwjkc19JmNHFu7TVthuzIo2fFvizeNx37x2NYDEgD6YJEQJzTr8q6QXHkQbXPu
	 SyEflHCcCbVN1i3YYEEMx/pXccvbdolwahv2tzMMr3WPIcmPo/EkqK+BAWOW1yELBL
	 xVEWgJewqEjfw==
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH 06/11] perf hist: Implement output fields for mem stats
Date: Wed, 30 Apr 2025 13:55:43 -0700
Message-ID: <20250430205548.789750-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430205548.789750-1-namhyung@kernel.org>
References: <20250430205548.789750-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparation for later changes to support mem_stat output.  The
new fields will need two lines for the header - the first line will show
type of mem stat and the second line will show the name of each item
which is returned by mem_stat_name().

Each element in the mem_stat array will be printed in percentage for the
hist_entry and their sum would be 100%.

Add new output field dimension only for SORT_MODE__MEM using mem_stat.
To handle possible name conflict with existing sort keys, move the order
of checking output field dimensions after the sort dimensions when it
looks for sort keys.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/hists.c |  11 +++
 tools/perf/ui/hist.c           | 158 ++++++++++++++++++++++++++++++++-
 tools/perf/util/hist.h         |   4 +
 tools/perf/util/mem-events.c   |  12 +++
 tools/perf/util/mem-events.h   |   3 +
 tools/perf/util/sort.c         |  26 ++++--
 6 files changed, 202 insertions(+), 12 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 67cbdec90d0bf0ea..f6ab1310a0bdd6c4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1266,6 +1266,16 @@ hist_browser__hpp_color_##_type(struct perf_hpp_fmt *fmt,		\
 			_fmttype);					\
 }
 
+#define __HPP_COLOR_MEM_STAT_FN(_name, _type)				\
+static int								\
+hist_browser__hpp_color_mem_stat_##_name(struct perf_hpp_fmt *fmt,	\
+					 struct perf_hpp *hpp,		\
+					 struct hist_entry *he)		\
+{									\
+	return hpp__fmt_mem_stat(fmt, hpp, he, PERF_MEM_STAT_##_type,	\
+				 " %5.1f%%", __hpp__slsmg_color_printf);\
+}
+
 __HPP_COLOR_PERCENT_FN(overhead, period, PERF_HPP_FMT_TYPE__PERCENT)
 __HPP_COLOR_PERCENT_FN(latency, latency, PERF_HPP_FMT_TYPE__LATENCY)
 __HPP_COLOR_PERCENT_FN(overhead_sys, period_sys, PERF_HPP_FMT_TYPE__PERCENT)
@@ -1277,6 +1287,7 @@ __HPP_COLOR_ACC_PERCENT_FN(latency_acc, latency, PERF_HPP_FMT_TYPE__LATENCY)
 
 #undef __HPP_COLOR_PERCENT_FN
 #undef __HPP_COLOR_ACC_PERCENT_FN
+#undef __HPP_COLOR_MEM_STAT_FN
 
 void hist_browser__init_hpp(void)
 {
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 2aad46bbd2ed4d93..2a5c9f2b328b2c5c 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -12,6 +12,7 @@
 #include "../util/evsel.h"
 #include "../util/evlist.h"
 #include "../util/mem-events.h"
+#include "../util/string2.h"
 #include "../util/thread.h"
 #include "../util/util.h"
 
@@ -151,6 +152,45 @@ int hpp__fmt_acc(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return hpp__fmt(fmt, hpp, he, get_field, fmtstr, print_fn, fmtype);
 }
 
+int hpp__fmt_mem_stat(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
+		      struct hist_entry *he, enum mem_stat_type mst,
+		      const char *fmtstr, hpp_snprint_fn print_fn)
+{
+	struct hists *hists = he->hists;
+	int mem_stat_idx = -1;
+	char *buf = hpp->buf;
+	size_t size = hpp->size;
+	u64 total = 0;
+	int ret = 0;
+
+	for (int i = 0; i < hists->nr_mem_stats; i++) {
+		if (hists->mem_stat_types[i] == mst) {
+			mem_stat_idx = i;
+			break;
+		}
+	}
+	assert(mem_stat_idx != -1);
+
+	for (int i = 0; i < MEM_STAT_LEN; i++)
+		total += he->mem_stat[mem_stat_idx].entries[i];
+	assert(total != 0);
+
+	for (int i = 0; i < MEM_STAT_LEN; i++) {
+		u64 val = he->mem_stat[mem_stat_idx].entries[i];
+
+		ret += hpp__call_print_fn(hpp, print_fn, fmtstr, 100.0 * val / total);
+	}
+
+	/*
+	 * Restore original buf and size as it's where caller expects
+	 * the result will be saved.
+	 */
+	hpp->buf = buf;
+	hpp->size = size;
+
+	return ret;
+}
+
 static int field_cmp(u64 field_a, u64 field_b)
 {
 	if (field_a > field_b)
@@ -295,6 +335,23 @@ static int __hpp__sort_acc(struct hist_entry *a, struct hist_entry *b,
 	return ret;
 }
 
+static bool perf_hpp__is_mem_stat_entry(struct perf_hpp_fmt *fmt);
+
+static enum mem_stat_type hpp__mem_stat_type(struct perf_hpp_fmt *fmt)
+{
+	if (!perf_hpp__is_mem_stat_entry(fmt))
+		return -1;
+
+	pr_debug("Should not reach here\n");
+	return -1;
+}
+
+static int64_t hpp__sort_mem_stat(struct perf_hpp_fmt *fmt __maybe_unused,
+				  struct hist_entry *a, struct hist_entry *b)
+{
+	return a->stat.period - b->stat.period;
+}
+
 static int hpp__width_fn(struct perf_hpp_fmt *fmt,
 			 struct perf_hpp *hpp __maybe_unused,
 			 struct hists *hists)
@@ -334,6 +391,45 @@ static int hpp__header_fn(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return scnprintf(hpp->buf, hpp->size, "%*s", len, hdr);
 }
 
+static int hpp__header_mem_stat_fn(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+				   struct hists *hists, int line,
+				   int *span __maybe_unused)
+{
+	char *buf = hpp->buf;
+	int ret = 0;
+	int len;
+	enum mem_stat_type mst = hpp__mem_stat_type(fmt);
+
+	(void)hists;
+	if (line == 0) {
+		int left, right;
+
+		len = fmt->len;
+		left = (len - strlen(fmt->name)) / 2 - 1;
+		right = len - left - strlen(fmt->name) - 2;
+
+		if (left < 0)
+			left = 0;
+		if (right < 0)
+			right = 0;
+
+		return scnprintf(hpp->buf, hpp->size, "%.*s %s %.*s",
+				 left, graph_dotted_line, fmt->name, right, graph_dotted_line);
+	}
+
+	len = hpp->size;
+	for (int i = 0; i < MEM_STAT_LEN; i++) {
+		int printed;
+
+		printed = scnprintf(buf, len, "%*s", MEM_STAT_PRINT_LEN,
+				    mem_stat_name(mst, i));
+		ret += printed;
+		buf += printed;
+		len -= printed;
+	}
+	return ret;
+}
+
 int hpp_color_scnprintf(struct perf_hpp *hpp, const char *fmt, ...)
 {
 	va_list args;
@@ -459,6 +555,23 @@ static int64_t hpp__sort_##_type(struct perf_hpp_fmt *fmt __maybe_unused, 	\
 	return __hpp__sort(a, b, he_get_##_field);				\
 }
 
+#define __HPP_COLOR_MEM_STAT_FN(_name, _type)					\
+static int hpp__color_mem_stat_##_name(struct perf_hpp_fmt *fmt,		\
+				       struct perf_hpp *hpp,			\
+				       struct hist_entry *he)			\
+{										\
+	return hpp__fmt_mem_stat(fmt, hpp, he, PERF_MEM_STAT_##_type,		\
+				 " %5.1f%%", hpp_color_scnprintf);		\
+}
+
+#define __HPP_ENTRY_MEM_STAT_FN(_name, _type)					\
+static int hpp__entry_mem_stat_##_name(struct perf_hpp_fmt *fmt, 		\
+				       struct perf_hpp *hpp,			\
+				       struct hist_entry *he)			\
+{										\
+	return hpp__fmt_mem_stat(fmt, hpp, he, PERF_MEM_STAT_##_type,		\
+				 " %5.1f%%", hpp_entry_scnprintf);		\
+}
 
 #define HPP_PERCENT_FNS(_type, _field, _fmttype)			\
 __HPP_COLOR_PERCENT_FN(_type, _field, _fmttype)				\
@@ -478,6 +591,10 @@ __HPP_SORT_RAW_FN(_type, _field)
 __HPP_ENTRY_AVERAGE_FN(_type, _field)					\
 __HPP_SORT_AVERAGE_FN(_type, _field)
 
+#define HPP_MEM_STAT_FNS(_name, _type)					\
+__HPP_COLOR_MEM_STAT_FN(_name, _type)					\
+__HPP_ENTRY_MEM_STAT_FN(_name, _type)
+
 HPP_PERCENT_FNS(overhead, period, PERF_HPP_FMT_TYPE__PERCENT)
 HPP_PERCENT_FNS(latency, latency, PERF_HPP_FMT_TYPE__LATENCY)
 HPP_PERCENT_FNS(overhead_sys, period_sys, PERF_HPP_FMT_TYPE__PERCENT)
@@ -494,6 +611,8 @@ HPP_AVERAGE_FNS(weight1, weight1)
 HPP_AVERAGE_FNS(weight2, weight2)
 HPP_AVERAGE_FNS(weight3, weight3)
 
+HPP_MEM_STAT_FNS(unknown, UNKNOWN)  /* placeholder */
+
 static int64_t hpp__nop_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 			    struct hist_entry *a __maybe_unused,
 			    struct hist_entry *b __maybe_unused)
@@ -503,8 +622,7 @@ static int64_t hpp__nop_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 
 static bool perf_hpp__is_mem_stat_entry(struct perf_hpp_fmt *fmt)
 {
-	(void)fmt;
-	return false;
+	return fmt->sort == hpp__sort_mem_stat;
 }
 
 static bool perf_hpp__is_hpp_entry(struct perf_hpp_fmt *a)
@@ -520,6 +638,14 @@ static bool hpp__equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
 	return a->idx == b->idx;
 }
 
+static bool hpp__equal_mem_stat(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
+{
+	if (!perf_hpp__is_mem_stat_entry(a) || !perf_hpp__is_mem_stat_entry(b))
+		return false;
+
+	return a->entry == b->entry;
+}
+
 #define HPP__COLOR_PRINT_FNS(_name, _fn, _idx)		\
 	{						\
 		.name   = _name,			\
@@ -561,6 +687,20 @@ static bool hpp__equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
 		.equal	= hpp__equal,			\
 	}
 
+#define HPP__MEM_STAT_PRINT_FNS(_name, _fn, _type)	\
+	{						\
+		.name   = _name,			\
+		.header	= hpp__header_mem_stat_fn,	\
+		.width	= hpp__width_fn,		\
+		.color	= hpp__color_mem_stat_ ## _fn,	\
+		.entry	= hpp__entry_mem_stat_ ## _fn,	\
+		.cmp	= hpp__nop_cmp,			\
+		.collapse = hpp__nop_cmp,		\
+		.sort	= hpp__sort_mem_stat,		\
+		.idx	= PERF_HPP__MEM_STAT_ ## _type,	\
+		.equal	= hpp__equal_mem_stat,		\
+	}
+
 struct perf_hpp_fmt perf_hpp__format[] = {
 	HPP__COLOR_PRINT_FNS("Overhead", overhead, OVERHEAD),
 	HPP__COLOR_PRINT_FNS("Latency", latency, LATENCY),
@@ -575,6 +715,7 @@ struct perf_hpp_fmt perf_hpp__format[] = {
 	HPP__PRINT_FNS("Weight1", weight1, WEIGHT1),
 	HPP__PRINT_FNS("Weight2", weight2, WEIGHT2),
 	HPP__PRINT_FNS("Weight3", weight3, WEIGHT3),
+	HPP__MEM_STAT_PRINT_FNS("Unknown", unknown, UNKNOWN),  /* placeholder */
 };
 
 struct perf_hpp_list perf_hpp_list = {
@@ -586,11 +727,13 @@ struct perf_hpp_list perf_hpp_list = {
 #undef HPP__COLOR_PRINT_FNS
 #undef HPP__COLOR_ACC_PRINT_FNS
 #undef HPP__PRINT_FNS
+#undef HPP__MEM_STAT_PRINT_FNS
 
 #undef HPP_PERCENT_FNS
 #undef HPP_PERCENT_ACC_FNS
 #undef HPP_RAW_FNS
 #undef HPP_AVERAGE_FNS
+#undef HPP_MEM_STAT_FNS
 
 #undef __HPP_HEADER_FN
 #undef __HPP_WIDTH_FN
@@ -600,6 +743,9 @@ struct perf_hpp_list perf_hpp_list = {
 #undef __HPP_ENTRY_ACC_PERCENT_FN
 #undef __HPP_ENTRY_RAW_FN
 #undef __HPP_ENTRY_AVERAGE_FN
+#undef __HPP_COLOR_MEM_STAT_FN
+#undef __HPP_ENTRY_MEM_STAT_FN
+
 #undef __HPP_SORT_FN
 #undef __HPP_SORT_ACC_FN
 #undef __HPP_SORT_RAW_FN
@@ -924,6 +1070,10 @@ void perf_hpp__reset_width(struct perf_hpp_fmt *fmt, struct hists *hists)
 		fmt->len = 8;
 		break;
 
+	case PERF_HPP__MEM_STAT_UNKNOWN:  /* placeholder */
+		fmt->len = MEM_STAT_LEN * MEM_STAT_PRINT_LEN;
+		break;
+
 	default:
 		break;
 	}
@@ -1042,12 +1192,14 @@ int perf_hpp__alloc_mem_stats(struct perf_hpp_list *list, struct evlist *evlist)
 			continue;
 
 		assert(nr_mem_stats < ARRAY_SIZE(mst));
-		mst[nr_mem_stats++] = PERF_MEM_STAT_UNKNOWN;
+		mst[nr_mem_stats++] = hpp__mem_stat_type(fmt);
 	}
 
 	if (nr_mem_stats == 0)
 		return 0;
 
+	list->nr_header_lines = 2;
+
 	evlist__for_each_entry(evlist, evsel) {
 		struct hists *hists = evsel__hists(evsel);
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 509af09691b84e10..18c696d8d568a9fa 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -587,6 +587,7 @@ enum {
 	PERF_HPP__WEIGHT1,
 	PERF_HPP__WEIGHT2,
 	PERF_HPP__WEIGHT3,
+	PERF_HPP__MEM_STAT_UNKNOWN,  /* placeholder */
 
 	PERF_HPP__MAX_INDEX
 };
@@ -656,6 +657,9 @@ int hpp__fmt_acc(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		 struct hist_entry *he, hpp_field_fn get_field,
 		 const char *fmtstr, hpp_snprint_fn print_fn,
 		 enum perf_hpp_fmt_type fmtype);
+int hpp__fmt_mem_stat(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		      struct hist_entry *he, enum mem_stat_type mst,
+		      const char *fmtstr, hpp_snprint_fn print_fn);
 
 static inline void advance_hpp(struct perf_hpp *hpp, int inc)
 {
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 1bc60ad3dc312542..a4c1e42de30f8307 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -817,3 +817,15 @@ int mem_stat_index(const enum mem_stat_type mst, const u64 val)
 	(void)val;
 	return -1;
 }
+
+/* To align output, returned string should be shorter than MEM_STAT_PRINT_LEN */
+const char *mem_stat_name(const enum mem_stat_type mst, const int idx)
+{
+	switch (mst) {
+	case PERF_MEM_STAT_UNKNOWN:
+	default:
+		break;
+	}
+	(void)idx;
+	return "N/A";
+}
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 2604464f985815f6..7aeb4c5fefc89698 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -93,6 +93,9 @@ enum mem_stat_type {
 	PERF_MEM_STAT_UNKNOWN,  /* placeholder */
 };
 
+#define MEM_STAT_PRINT_LEN  7  /* 1 space + 5 digits + 1 percent sign */
+
 int mem_stat_index(const enum mem_stat_type mst, const u64 data_src);
+const char *mem_stat_name(const enum mem_stat_type mst, const int idx);
 
 #endif /* __PERF_MEM_EVENTS_H */
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 6024f588f66f3156..7c669ea27af247e5 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2598,9 +2598,11 @@ struct hpp_dimension {
 	struct perf_hpp_fmt	*fmt;
 	int			taken;
 	int			was_taken;
+	int			mem_mode;
 };
 
 #define DIM(d, n) { .name = n, .fmt = &perf_hpp__format[d], }
+#define DIM_MEM(d, n) { .name = n, .fmt = &perf_hpp__format[d], .mem_mode = 1, }
 
 static struct hpp_dimension hpp_sort_dimensions[] = {
 	DIM(PERF_HPP__OVERHEAD, "overhead"),
@@ -2620,8 +2622,11 @@ static struct hpp_dimension hpp_sort_dimensions[] = {
 	DIM(PERF_HPP__WEIGHT2, "ins_lat"),
 	DIM(PERF_HPP__WEIGHT3, "retire_lat"),
 	DIM(PERF_HPP__WEIGHT3, "p_stage_cyc"),
+	/* used for output only when SORT_MODE__MEM */
+	DIM_MEM(PERF_HPP__MEM_STAT_UNKNOWN, "unknown"),  /* placeholder */
 };
 
+#undef DIM_MEM
 #undef DIM
 
 struct hpp_sort_entry {
@@ -3608,15 +3613,6 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 		return __sort_dimension__add(sd, list, level);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(hpp_sort_dimensions); i++) {
-		struct hpp_dimension *hd = &hpp_sort_dimensions[i];
-
-		if (strncasecmp(tok, hd->name, strlen(tok)))
-			continue;
-
-		return __hpp_dimension__add(hd, list, level);
-	}
-
 	for (i = 0; i < ARRAY_SIZE(bstack_sort_dimensions); i++) {
 		struct sort_dimension *sd = &bstack_sort_dimensions[i];
 
@@ -3658,6 +3654,15 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 		return 0;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(hpp_sort_dimensions); i++) {
+		struct hpp_dimension *hd = &hpp_sort_dimensions[i];
+
+		if (strncasecmp(tok, hd->name, strlen(tok)))
+			continue;
+
+		return __hpp_dimension__add(hd, list, level);
+	}
+
 	if (!add_dynamic_entry(evlist, tok, level))
 		return 0;
 
@@ -4020,6 +4025,9 @@ int output_field_add(struct perf_hpp_list *list, const char *tok, int *level)
 		if (!strcasecmp(tok, "weight"))
 			ui__warning("--fields weight shows the average value unlike in the --sort key.\n");
 
+		if (hd->mem_mode && sort__mode != SORT_MODE__MEMORY)
+			continue;
+
 		return __hpp_dimension__add_output(list, hd, *level);
 	}
 
-- 
2.49.0.906.g1f30a19c02-goog


