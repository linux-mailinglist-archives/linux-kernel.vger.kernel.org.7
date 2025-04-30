Return-Path: <linux-kernel+bounces-627904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8194AA5656
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 23:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903E44E56ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 21:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81E12D5D14;
	Wed, 30 Apr 2025 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ1gf74L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9B2D269B;
	Wed, 30 Apr 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046556; cv=none; b=klnAQoD0jaeSoZ6N24IUjI5FXvLv/GSO8Fm4882DMlhE92gZRkoxuh0GjjOFkemCPXpZuJw8qlM+hYTbkjAh+t8I2GAj5WvyLVAGM8QFiE29TEkIVYcL72KuTXEjlyOl5p5z3/QsvivlPkufYlsHcD+vPdyKbzFedr137NbP+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046556; c=relaxed/simple;
	bh=Vxirz+95BbhjXKvR+TeypzcT+/wB8PdmqOQqpeCxrTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky4wxQGVto0AU9uEjdubszoFgxpO0U/C+oxlvk51aAW9/v9T+i21hgDbr/5Fmx/Otx5Co2HQvrAt8d6jTjHT4NgLHHQwDDFE92dyMgs8JikfMx4uuFzy5chI2dfMeKCn7n3KYJtUiTCk9zecHdmBfNIg/Yi8lJ7AGjp6OziCtPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ1gf74L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFE2C4CEE7;
	Wed, 30 Apr 2025 20:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046556;
	bh=Vxirz+95BbhjXKvR+TeypzcT+/wB8PdmqOQqpeCxrTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZ1gf74Ltvo9V3BdsnaTLPNEoGXCqrdfyvHb8WlSe5saWLSHy7HCK9xkW9uP/OPRl
	 doVNjf9AIlbMv7RPS8DLhPTn4YEbemAzFWmkOR7Zfbmm7pxtljACBGIxt+zFUOkNf+
	 5Ole8weKc0paJR3jqmFYAaXicYEggCYqkZak6K9FB6qIbz/6F7dDlDr70XKdHKtbrn
	 dxoQstH7PlWllBOLEzk0R0jQC3DM/ci330BeoDvrMUoagrpMGtB2TknNvCR/DsyBWI
	 N+Il92SEojylRuarfnzmLhGxPWHJZNQYzU/jUO8lJTkxAnAIdE3H5D99u6unfA1HTO
	 AyL5qYZ2DHwFg==
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
Subject: [PATCH 09/11] perf mem: Add 'cache' and 'memory' output fields
Date: Wed, 30 Apr 2025 13:55:46 -0700
Message-ID: <20250430205548.789750-10-namhyung@kernel.org>
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

This is a breakdown of perf_mem_data_src.mem_lvl_num.  But it's also
divided into two parts because the combination is bigger than 8.

Since there are many entries for different cache levels, 'cache' field
focuses on them.  I generalized buffers like LFB, MAB and MHB to L1-buf
and L2-buf.

The rest goes to 'memory' field which can be RAM, CXL, PMEM, IO, etc.

  $ perf mem report -F cache,mem,dso --stdio
  ...
  #
  # -------------- Cache --------------  --- Memory ---
  #      L1     L2     L3 L1-buf  Other      RAM  Other  Shared Object
  # ...................................  ..............  ....................................
  #
      53.9%   3.6%  16.2%  21.6%   4.8%     4.8%  95.2%  [kernel.kallsyms]
      64.7%   1.7%   3.5%  17.4%  12.8%    12.8%  87.2%  chrome (deleted)
      78.3%   2.8%   0.0%   1.0%  17.9%    17.9%  82.1%  libc.so.6
      39.6%   1.5%   0.0%   5.7%  53.2%    53.2%  46.8%  libxul.so
      26.2%   0.0%   0.0%   0.0%  73.8%    73.8%  26.2%  [unknown]
      85.5%   0.0%   0.0%  14.5%   0.0%     0.0% 100.0%  libspa-audioconvert.so
      66.3%   4.4%   0.0%  29.4%   0.0%     0.0% 100.0%  libglib-2.0.so.0.8200.1 (deleted)
       1.9%   0.0%   0.0%   0.0%  98.1%    98.1%   1.9%  libmutter-cogl-15.so.0.0.0 (deleted)
      10.6%   0.0%   0.0%  89.4%   0.0%     0.0% 100.0%  libpulsecommon-16.1.so
       0.0%   0.0%   0.0% 100.0%   0.0%     0.0% 100.0%  libfreeblpriv3.so (deleted)
       ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/hists.c |  6 +++
 tools/perf/ui/hist.c           | 10 +++++
 tools/perf/util/hist.h         |  2 +
 tools/perf/util/mem-events.c   | 71 +++++++++++++++++++++++++++++++++-
 tools/perf/util/mem-events.h   | 24 +++++++++++-
 tools/perf/util/sort.c         |  2 +
 6 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 66a4c769b2d76436..675dd64067747126 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1285,6 +1285,8 @@ __HPP_COLOR_PERCENT_FN(overhead_guest_us, period_guest_us, PERF_HPP_FMT_TYPE__PE
 __HPP_COLOR_ACC_PERCENT_FN(overhead_acc, period, PERF_HPP_FMT_TYPE__PERCENT)
 __HPP_COLOR_ACC_PERCENT_FN(latency_acc, latency, PERF_HPP_FMT_TYPE__LATENCY)
 __HPP_COLOR_MEM_STAT_FN(op, OP)
+__HPP_COLOR_MEM_STAT_FN(cache, CACHE)
+__HPP_COLOR_MEM_STAT_FN(memory, MEMORY)
 
 #undef __HPP_COLOR_PERCENT_FN
 #undef __HPP_COLOR_ACC_PERCENT_FN
@@ -1310,6 +1312,10 @@ void hist_browser__init_hpp(void)
 				hist_browser__hpp_color_latency_acc;
 	perf_hpp__format[PERF_HPP__MEM_STAT_OP].color =
 				hist_browser__hpp_color_mem_stat_op;
+	perf_hpp__format[PERF_HPP__MEM_STAT_CACHE].color =
+				hist_browser__hpp_color_mem_stat_cache;
+	perf_hpp__format[PERF_HPP__MEM_STAT_MEMORY].color =
+				hist_browser__hpp_color_mem_stat_memory;
 
 	res_sample_init();
 }
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 661922c4d7863224..7fc09c738ed02acb 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -348,6 +348,10 @@ static enum mem_stat_type hpp__mem_stat_type(struct perf_hpp_fmt *fmt)
 	switch (fmt->idx) {
 	case PERF_HPP__MEM_STAT_OP:
 		return PERF_MEM_STAT_OP;
+	case PERF_HPP__MEM_STAT_CACHE:
+		return PERF_MEM_STAT_CACHE;
+	case PERF_HPP__MEM_STAT_MEMORY:
+		return PERF_MEM_STAT_MEMORY;
 	default:
 		break;
 	}
@@ -644,6 +648,8 @@ HPP_AVERAGE_FNS(weight2, weight2)
 HPP_AVERAGE_FNS(weight3, weight3)
 
 HPP_MEM_STAT_FNS(op, OP)
+HPP_MEM_STAT_FNS(cache, CACHE)
+HPP_MEM_STAT_FNS(memory, MEMORY)
 
 static int64_t hpp__nop_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 			    struct hist_entry *a __maybe_unused,
@@ -748,6 +754,8 @@ struct perf_hpp_fmt perf_hpp__format[] = {
 	HPP__PRINT_FNS("Weight2", weight2, WEIGHT2),
 	HPP__PRINT_FNS("Weight3", weight3, WEIGHT3),
 	HPP__MEM_STAT_PRINT_FNS("Mem Op", op, OP),
+	HPP__MEM_STAT_PRINT_FNS("Cache", cache, CACHE),
+	HPP__MEM_STAT_PRINT_FNS("Memory", memory, MEMORY),
 };
 
 struct perf_hpp_list perf_hpp_list = {
@@ -1103,6 +1111,8 @@ void perf_hpp__reset_width(struct perf_hpp_fmt *fmt, struct hists *hists)
 		break;
 
 	case PERF_HPP__MEM_STAT_OP:
+	case PERF_HPP__MEM_STAT_CACHE:
+	case PERF_HPP__MEM_STAT_MEMORY:
 		fmt->len = MEM_STAT_LEN * MEM_STAT_PRINT_LEN;
 		break;
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index fa5e886e5b04ec9b..9de50d929ad1268c 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -589,6 +589,8 @@ enum {
 	PERF_HPP__WEIGHT2,
 	PERF_HPP__WEIGHT3,
 	PERF_HPP__MEM_STAT_OP,
+	PERF_HPP__MEM_STAT_CACHE,
+	PERF_HPP__MEM_STAT_MEMORY,
 
 	PERF_HPP__MAX_INDEX
 };
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 1c44ccc026fe9974..6822815278a4b213 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -823,6 +823,40 @@ int mem_stat_index(const enum mem_stat_type mst, const u64 val)
 				return MEM_STAT_OP_EXEC;
 			return MEM_STAT_OP_OTHER;
 		}
+	case PERF_MEM_STAT_CACHE:
+		switch (src.mem_lvl_num) {
+		case PERF_MEM_LVLNUM_L1:
+			return MEM_STAT_CACHE_L1;
+		case PERF_MEM_LVLNUM_L2:
+			return MEM_STAT_CACHE_L2;
+		case PERF_MEM_LVLNUM_L3:
+			return MEM_STAT_CACHE_L3;
+		case PERF_MEM_LVLNUM_L4:
+			return MEM_STAT_CACHE_L4;
+		case PERF_MEM_LVLNUM_LFB:
+			return MEM_STAT_CACHE_L1_BUF;
+		case PERF_MEM_LVLNUM_L2_MHB:
+			return MEM_STAT_CACHE_L2_BUF;
+		default:
+			return MEM_STAT_CACHE_OTHER;
+		}
+	case PERF_MEM_STAT_MEMORY:
+		switch (src.mem_lvl_num) {
+		case PERF_MEM_LVLNUM_MSC:
+			return MEM_STAT_MEMORY_MSC;
+		case PERF_MEM_LVLNUM_RAM:
+			return MEM_STAT_MEMORY_RAM;
+		case PERF_MEM_LVLNUM_UNC:
+			return MEM_STAT_MEMORY_UNC;
+		case PERF_MEM_LVLNUM_CXL:
+			return MEM_STAT_MEMORY_CXL;
+		case PERF_MEM_LVLNUM_IO:
+			return MEM_STAT_MEMORY_IO;
+		case PERF_MEM_LVLNUM_PMEM:
+			return MEM_STAT_MEMORY_PMEM;
+		default:
+			return MEM_STAT_MEMORY_OTHER;
+		}
 	default:
 		break;
 	}
@@ -846,9 +880,44 @@ const char *mem_stat_name(const enum mem_stat_type mst, const int idx)
 		case MEM_STAT_OP_EXEC:
 			return "Exec";
 		case MEM_STAT_OP_OTHER:
+		default:
+			return "Other";
+		}
+	case PERF_MEM_STAT_CACHE:
+		switch (idx) {
+		case MEM_STAT_CACHE_L1:
+			return "L1";
+		case MEM_STAT_CACHE_L2:
+			return "L2";
+		case MEM_STAT_CACHE_L3:
+			return "L3";
+		case MEM_STAT_CACHE_L4:
+			return "L4";
+		case MEM_STAT_CACHE_L1_BUF:
+			return "L1-buf";
+		case MEM_STAT_CACHE_L2_BUF:
+			return "L2-buf";
+		case MEM_STAT_CACHE_OTHER:
+		default:
 			return "Other";
+		}
+	case PERF_MEM_STAT_MEMORY:
+		switch (idx) {
+		case MEM_STAT_MEMORY_RAM:
+			return "RAM";
+		case MEM_STAT_MEMORY_MSC:
+			return "MSC";
+		case MEM_STAT_MEMORY_UNC:
+			return "Uncach";
+		case MEM_STAT_MEMORY_CXL:
+			return "CXL";
+		case MEM_STAT_MEMORY_IO:
+			return "IO";
+		case MEM_STAT_MEMORY_PMEM:
+			return "PMEM";
+		case MEM_STAT_MEMORY_OTHER:
 		default:
-			break;
+			return "Other";
 		}
 	default:
 		break;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 55e5e2607fb732b4..002e2772400e3dda 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -91,8 +91,12 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add);
 
 enum mem_stat_type {
 	PERF_MEM_STAT_OP,
+	PERF_MEM_STAT_CACHE,
+	PERF_MEM_STAT_MEMORY,
 };
 
+#define MEM_STAT_PRINT_LEN  7  /* 1 space + 5 digits + 1 percent sign */
+
 enum mem_stat_op {
 	MEM_STAT_OP_LOAD,
 	MEM_STAT_OP_STORE,
@@ -102,7 +106,25 @@ enum mem_stat_op {
 	MEM_STAT_OP_OTHER,
 };
 
-#define MEM_STAT_PRINT_LEN  7  /* 1 space + 5 digits + 1 percent sign */
+enum mem_stat_cache {
+	MEM_STAT_CACHE_L1,
+	MEM_STAT_CACHE_L2,
+	MEM_STAT_CACHE_L3,
+	MEM_STAT_CACHE_L4,
+	MEM_STAT_CACHE_L1_BUF,
+	MEM_STAT_CACHE_L2_BUF,
+	MEM_STAT_CACHE_OTHER,
+};
+
+enum mem_stat_memory {
+	MEM_STAT_MEMORY_RAM,
+	MEM_STAT_MEMORY_MSC,
+	MEM_STAT_MEMORY_UNC,
+	MEM_STAT_MEMORY_CXL,
+	MEM_STAT_MEMORY_IO,
+	MEM_STAT_MEMORY_PMEM,
+	MEM_STAT_MEMORY_OTHER,
+};
 
 int mem_stat_index(const enum mem_stat_type mst, const u64 data_src);
 const char *mem_stat_name(const enum mem_stat_type mst, const int idx);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 53fcb9191ea0cdc3..2ad88f7de95a2247 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2624,6 +2624,8 @@ static struct hpp_dimension hpp_sort_dimensions[] = {
 	DIM(PERF_HPP__WEIGHT3, "p_stage_cyc"),
 	/* used for output only when SORT_MODE__MEM */
 	DIM_MEM(PERF_HPP__MEM_STAT_OP, "op"),
+	DIM_MEM(PERF_HPP__MEM_STAT_CACHE, "cache"),
+	DIM_MEM(PERF_HPP__MEM_STAT_MEMORY, "memory"),
 };
 
 #undef DIM_MEM
-- 
2.49.0.906.g1f30a19c02-goog


