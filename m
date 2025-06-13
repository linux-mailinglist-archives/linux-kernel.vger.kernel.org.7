Return-Path: <linux-kernel+bounces-684645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5D1AD7EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 00:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8086A1891302
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 22:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA6C2327A1;
	Thu, 12 Jun 2025 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KeW83kRC"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27381DED60
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749768882; cv=none; b=VGqa8KGiDTe49SgA3wlkk+gYI6MfDgyE1tbjPipqRzr6qBEdoARSMpPEYjSn9x7dPi5M/bsiBQBmWAAnRXPDPV+tEI1Y5KfhaZZcayYYjvyJoEo9tJMLQHt9EnztCpiWRbqbpeibh05Hsn04fJGM3IHNhWF/PrgNSUgQhNmMF2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749768882; c=relaxed/simple;
	bh=EUW310Tks3oY6xEDbNOSm8jNdZpiFtTu/X6ikUAR0kM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SR2m5QY1QavHyUi1Aub9Rln1KVPtdpCpj9Y1Wi6eBpdxxWfjgU+gEKIqTqW2/guf88QWVTcHkxw8pgxLJdgLVNMspL18cxuc/bCv3zrR3IE8bKu1TZHlQmKTJ9fYmxdni1Urohj2LHnD0G49qeaXH+Jqnw/Opwxrjrh9jM1IdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KeW83kRC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235f6b829cfso12282365ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 15:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749768880; x=1750373680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Lek1RqPzjiIRmq/d9EPRY5eQXVuNIdqGZHLp3YDsWk=;
        b=KeW83kRCxQeuJj/3Ai2jmR045bL8tgATSpoHNEGNhqX4LTzXc0Y9NGt7xT+3QHMYtE
         SdAbaG3rfxevhB2y6K/kEI27LwoKBRzQEnYvwkQrDEoazu8KBv6tW1ydLmLc8ROpo2MD
         uMn27wUkdoMO1E5EoP1eOxbqBYHuI/WUv5Gup+i87rAOhZcpUCLkmlZscUBJfIN+YlUU
         s1AlVcGkPC7sZgOxSQlTEeGdHzD8ck6DbD7230sEo/AuPk+kCjNHuO+WC4iXQmXCYMd2
         VbDMwcZm0TJNrNL3TO4l1jSu3DTIZC5b1Y+IwgR+aFc1C2FW6CqPMAEc6gaw49MHBwKO
         T1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749768880; x=1750373680;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Lek1RqPzjiIRmq/d9EPRY5eQXVuNIdqGZHLp3YDsWk=;
        b=qI+junz4OrXWgt7YeuB1hZ0ZiBB9e3T9A4x0ebT+wSB0j+O+cvDdqDRITXl954N/8f
         Q008gJGCLRmdKyoEQUKySgbd7JQ1hQa+2287t/BcwpJ6Vs6hG7w8+49WJP8NBICPYax+
         04OzH2whUj4g2xDe8DcXFvahLerxuA4EwDCPA3EAI7nvVgNPVw31Q7lXxaUxI43kaLHL
         mU81V8qeOjS9VeALnHpRIyydnjD+WOjxcOkV1QdQ2zLhNQHUASIBl/qYhxZCs9p7bnYj
         ZxtWomB+D7QyhXXrVTMnaBsAQ0B5KVB0nno3+43KnpcjPeXyVfn70sEsu+HEmj51+URY
         opzA==
X-Gm-Message-State: AOJu0Yzc3zHFfjEIZAAOKPoCLuz6VYkGcwMjUui4+AbG3SFjPjpt5dDx
	BHFSQ3GccbFXOlcEG6rlSIons5Abw+BiJmuCv6pMic8yE+f6qNmK9yhZ4kdvYnzBbJmkgZprLQ8
	gmvSQqerqy2dxMlFl4HM5iQTV5BE2l0KIOnjlkPFSblW6uAtASAVz7SQH8WxLgoMyAQ9NH0GP0+
	C3pkVUU3DuQR1hjMDKkQxGE/9ZS27H+6ArBo6686Tfhkk0
X-Google-Smtp-Source: AGHT+IHIzuoJVrRyapF5eu/Y238EX8BUt5qv+Yxm+E5eoD4vn7u3swxSZS4JdhER2uukk6CMv5cLalIVUd4=
X-Received: from plbjx17.prod.google.com ([2002:a17:903:1391:b0:234:2261:8333])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db05:b0:234:c2e7:a0e4
 with SMTP id d9443c01a7336-2365d88c276mr8820265ad.3.1749768880144; Thu, 12
 Jun 2025 15:54:40 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:52:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612225324.3315450-1-ctshao@google.com>
Subject: [PATCH v2] perf stat: Fix uncore aggregation number
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Follow up:
lore.kernel.org/CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com/

The patch adds unit aggregation during evsel merge the aggregated uncore
counters. Change the name of column to `aggr_nr` to align with json mode
which is using `aggregate-number`

Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] and
cpumask="0,120"
Before:
  perf stat -e clockticks -I 1000 --per-socket
  #           time socket cpus             counts unit events
       1.001085024 S0        1         9615386315      clockticks
       1.001085024 S1        1         9614287448      clockticks
  perf stat -e clockticks -I 1000 --per-node
  #           time node   cpus             counts unit events
       1.001029867 N0        1         3205726984      clockticks
       1.001029867 N1        1         3205444421      clockticks
       1.001029867 N2        1         3205234018      clockticks
       1.001029867 N3        1         3205224660      clockticks
       1.001029867 N4        1         3205207213      clockticks
       1.001029867 N5        1         3205528246      clockticks
After:
  perf stat -e clockticks -I 1000 --per-socket
  #           time socket aggr_nr             counts unit events
       1.001021890 S0          12         9620633814      clockticks
       1.001021890 S1          12         9618016899      clockticks
  perf stat -e clockticks -I 1000 --per-node
  #           time node   aggr_nr             counts unit events
       1.001027449 N0           4         3207251859      clockticks
       1.001027449 N1           4         3207315930      clockticks
       1.001027449 N2           4         3206981828      clockticks
       1.001027449 N3           4         3206566126      clockticks
       1.001027449 N4           4         3206032609      clockticks
       1.001027449 N5           4         3205651355      clockticks

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v2:
  Rename the column to `aggr_nr`.
  Remove unnecessary comment.

v1: https://lore.kernel.org/20250611233239.3098064-1-ctshao@google.com/

 tools/perf/util/stat-display.c | 22 +++++++++++-----------
 tools/perf/util/stat.c         |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 729ad5cd52cb..49c523b61dbb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -50,15 +50,15 @@ static int aggr_header_lens[] = {
 };

 static const char *aggr_header_csv[] = {
-	[AGGR_CORE] 	= 	"core,cpus,",
-	[AGGR_CACHE]	= 	"cache,cpus,",
-	[AGGR_CLUSTER]	= 	"cluster,cpus,",
-	[AGGR_DIE] 	= 	"die,cpus,",
-	[AGGR_SOCKET] 	= 	"socket,cpus,",
-	[AGGR_NONE] 	= 	"cpu,",
-	[AGGR_THREAD] 	= 	"comm-pid,",
-	[AGGR_NODE] 	= 	"node,",
-	[AGGR_GLOBAL] 	=	""
+	[AGGR_CORE]	=	"core,aggr_nr,",
+	[AGGR_CACHE]	=	"cache,aggr_nr,",
+	[AGGR_CLUSTER]	=	"cluster,aggr_nr,",
+	[AGGR_DIE]	=	"die,aggr_nr,",
+	[AGGR_SOCKET]	=	"socket,aggr_nr,",
+	[AGGR_NONE]	=	"cpu,",
+	[AGGR_THREAD]	=	"comm-pid,",
+	[AGGR_NODE]	=	"node,",
+	[AGGR_GLOBAL]	=	""
 };

 static const char *aggr_header_std[] = {
@@ -304,7 +304,7 @@ static void print_aggr_id_std(struct perf_stat_config *config,
 		return;
 	}

-	fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, 4, aggr_nr);
+	fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, /*strlen("aggr_nr")*/ 7, aggr_nr);
 }

 static void print_aggr_id_csv(struct perf_stat_config *config,
@@ -1317,7 +1317,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
 	case AGGR_CLUSTER:
 	case AGGR_CACHE:
 	case AGGR_CORE:
-		fprintf(output, "#%*s %-*s cpus",
+		fprintf(output, "#%*s %-*s aggr_nr",
 			INTERVAL_LEN - 1, "time",
 			aggr_header_lens[config->aggr_mode],
 			aggr_header_std[config->aggr_mode]);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 355a7d5c8ab8..b0205e99a4c9 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -526,7 +526,7 @@ static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
 		struct perf_counts_values *aggr_counts_a = &ps_a->aggr[i].counts;
 		struct perf_counts_values *aggr_counts_b = &ps_b->aggr[i].counts;

-		/* NB: don't increase aggr.nr for aliases */
+		ps_a->aggr[i].nr += ps_b->aggr[i].nr;

 		aggr_counts_a->val += aggr_counts_b->val;
 		aggr_counts_a->ena += aggr_counts_b->ena;
--
2.50.0.rc1.591.g9c95f17f64-goog


