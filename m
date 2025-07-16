Return-Path: <linux-kernel+bounces-732852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010DCB06CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AB23A1919
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0A827AC5A;
	Wed, 16 Jul 2025 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ8S124k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A4279DB7;
	Wed, 16 Jul 2025 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642063; cv=none; b=VynDTkqWOOZjeyzwzfbHm0romaOh2iKzxM6UfclCnqAz2MsU0uc9sC9XtI+Bwucf5B0SB2uxdipVU3T/VIy8D0QZFsIq/2noyGJbGMIypbtH4+MhQoBYV9gutzs4CjiJWTVWMc87GJlgIusUGFQRFUiYAbH+svV34ukXGOtV5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642063; c=relaxed/simple;
	bh=Bw5Ss/Zw6SAJW9BPY7V2Pck+k/Id1jmEwAakql27frA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9Juug5ip5BR2VZj29OotxEbG3OJ1UOStedfazsaMX79Mq+b86RKArVPma6f1BNLE8z11Tb/dFXdL11fFnZvjtUvgN+BrBVNn0f2dJlH2bnxKBYs+d2mxzcOTL7wqUtpsxtjXZwZfRlbAPDZchWP4/MsFqrQQMfFxqYNs2hHsGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ8S124k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC8AC4CEFC;
	Wed, 16 Jul 2025 05:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752642062;
	bh=Bw5Ss/Zw6SAJW9BPY7V2Pck+k/Id1jmEwAakql27frA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZ8S124k99N9EDsEW3U+ZyGlq11Yj0cmMecedSmtjHVn9gZksl4no1d/ztupqJhJ4
	 NHhStApAaJMGZh9isn1Muy3nteaMK7E6SxYrgkM614apZjuO/ZgN8qgke8oMREnOPk
	 V3BatEV41K9d4IjqhGgr/QQOAHWrCNfb0zIiFRplUGkLUlf658HnTXZznTJ03gExz+
	 LjcmSNUywhFdZxjZNwPGc+TwA3wXPNbLwVLLlWv+5X0ZwlUfSntTqgMY+FB62ngNa/
	 LodcpVWnRMepVdzlQo0Jzjkcr5l6S+L/1crnuZVJqJE99fERO/y0FP7c7zFfJ/KSkQ
	 ErKZIFJExlzFA==
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
Subject: [PATCH v3 4/8] perf annotate: Simplify width calculation in annotation_line__write()
Date: Tue, 15 Jul 2025 22:00:50 -0700
Message-ID: <20250716050054.14130-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716050054.14130-1-namhyung@kernel.org>
References: <20250716050054.14130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The width is updated after each part is printed.  It can skip the output
processing if the total printed size is bigger than the width.

No function changes intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c21152710148b68c..d69e406c1bc289cd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1993,6 +1993,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 					   symbol_conf.show_nr_samples ? "Samples" : "Percent");
 		}
 	}
+	width -= pcnt_width;
 
 	if (notes->branch) {
 		if (al->cycles && al->cycles->ipc)
@@ -2056,11 +2057,12 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			obj__printf(obj, "%*s", ANNOTATION__AVG_IPC_WIDTH, bf);
 		}
 	}
+	width -= cycles_width;
 
 	obj__printf(obj, " ");
 
 	if (!*al->line)
-		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width, " ");
+		obj__printf(obj, "%-*s", width, " ");
 	else if (al->offset == -1) {
 		if (al->line_nr && annotate_opts.show_linenr)
 			printed = scnprintf(bf, sizeof(bf), "%-*d ",
@@ -2069,7 +2071,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			printed = scnprintf(bf, sizeof(bf), "%-*s  ",
 					    notes->src->widths.addr, " ");
 		obj__printf(obj, bf);
-		obj__printf(obj, "%-*s", width - printed - pcnt_width - cycles_width + 1, al->line);
+		obj__printf(obj, "%-*s", width - printed + 1, al->line);
 	} else {
 		u64 addr = al->offset;
 		int color = -1;
@@ -2112,9 +2114,11 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 		if (change_color)
 			obj__set_color(obj, color);
 
+		width -= printed + 3;
+
 		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
 
-		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width - 3 - printed, bf);
+		obj__printf(obj, "%-*s", width, bf);
 
 		(void)apd;
 	}
-- 
2.50.0


