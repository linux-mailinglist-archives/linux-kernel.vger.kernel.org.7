Return-Path: <linux-kernel+bounces-701210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2BAAE7228
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 00:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5D63B4DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 22:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3529C24887E;
	Tue, 24 Jun 2025 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksJaTaO6"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F65182BC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750803351; cv=none; b=Grb31ahdZt+jwBFyrtTXK883OdWV4pW+g+L1BXiXzQV7S47isli0+li7w1NV38qNRB23zR/OwOtSoYsynUp09YrkRmtFBegQJIg1aiuuo8TfsvoybzA2rV4FnyLhivhb1RVbiZY1koD6g2zqqXMOwy1L1Gisi4x/e3Rmw+3vovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750803351; c=relaxed/simple;
	bh=gwlSQUo9b3loZtV5PPRtTwSVR7W7Hsv9ks2xYKkqm9Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GApIihtlFa90PC9C2R/APKmHMer9Pe2sE/7wXStvuk3Z/VgftftPeHIRi2jTjZb3v8hOzOaR2iPq+wT1/IStukl18sXU+wevSYb5gXDq0CX4betUh59Xfgmu+LvBaCD4FRUp8QQWzlPAzUdHLdUYSdZnRn+eSHesSK79h/QpGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksJaTaO6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311ae2b6647so819803a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750803349; x=1751408149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L9H8rsZhOzIt+UI6UH9Y+2ZDnDaptTpBgxdxZU1WPLg=;
        b=ksJaTaO6b5GibAQ6aXWFVxvaN3cFfC5SX55PR4X2p6FAA4kWzGJSVqbggEurokOZpI
         es5hXpdX7ZEMNR7hdun/j3mS3FHPdbDUu7kTXmYXlUXVMIgtztqbgfYWcwWegaKqysOZ
         mhlRqRNHxarH0dOUGA7uxByBSXUSvKu6T3vdOtY8j4d1kLJDNKeEjwc4Q70pxXd500Iq
         Da+ZJ2Hd3gTYYwB9mqpT18vvY8wqSqjUh6AdIqFJiS/4xAXbdz3HhN7cMoz2GqKPtpmL
         jEjrsjzO0qXgcZitHjbt/RsGDx+uKhSZEJZJLwzvFDswtPkTpoWMInvF84pb8OCoJME/
         3pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750803349; x=1751408149;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9H8rsZhOzIt+UI6UH9Y+2ZDnDaptTpBgxdxZU1WPLg=;
        b=SC0L1Bd4hHKEWQRaGWK8QLIvFgf0cdcYfR/ITkArMpp7u3cVVEx+QGrakeewNAFuxs
         /QPtQ64C933Np6brZWcsaFudLyLUA/ilcTRhI19RiSwOAeF9qEbiH+RLXP4fqJfdqMzT
         eH0vGcvIWCoxcOHyN+8de+pHhkIy592quRHWE+sfpRe/7ANDWcjAa6fc1ubHkdGLbaB9
         jgwyLlV/fJ213y14IdJgJa7cXPXXYOtwJ9zARoGj69p9ZbSGOFhPxBINYCoUDDaSNRO+
         W7DznRJbHzEbRO7x/2fUH1ztQ+jW7Rr45FjJ1U1CgTGJ+l6gvZ/Bpwk2sEUyO1iQifHI
         WS1g==
X-Gm-Message-State: AOJu0YxwON8ddp8EqyQTpARsL0HP7ebLnyq9YkBHXP1/5lkpCVs1z01d
	EZWPp61PJgpbyyD4JxQ+k5hpF5SlPtdZ+dXVbhWcZnxvSDVBoe9bxqylnaLd5RJ3S7bZQ88J2Mo
	yhjq6rn7yU/NqthgJ3VmyEqKhdgjdWESZxYpgR1AHHYzo+tGeJ9lg8Fxjikon91xHRnJ1ourhKM
	002DTH6W26aRl9d92G9AdSPJLVJBrS7dfaDI7Za3GPcpkU
X-Google-Smtp-Source: AGHT+IHN0X75O1jyQ0O5RrXXUq94SnNifv8XciuoFnzyWufKBYKYIO8kqQ/AmI4Lk1cbTKzSMkhD5VoerdI=
X-Received: from pjbsz14.prod.google.com ([2002:a17:90b:2d4e:b0:2fc:2c9c:880])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2709:b0:313:2adc:b4c4
 with SMTP id 98e67ed59e1d1-315f26b2ebdmr706693a91.24.1750803349222; Tue, 24
 Jun 2025 15:15:49 -0700 (PDT)
Date: Tue, 24 Jun 2025 15:14:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624221545.1711008-1-ctshao@google.com>
Subject: [PATCH v3] perf stat: Fix uncore aggregation number
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: wy.shih90@gmail.com, Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Follow up:
lore.kernel.org/CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com/

The patch adds unit aggregation during evsel merge the aggregated uncore
counters. Change the name of the column to `ctrs` and `counters` for
json mode.

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
  #           time socket ctrs             counts unit events
       1.001026071 S0       12         9619677996      clockticks
       1.001026071 S1       12         9618612614      clockticks
  perf stat -e clockticks -I 1000 --per-node
  #           time node   ctrs             counts unit events
       1.001027449 N0        4         3207251859      clockticks
       1.001027449 N1        4         3207315930      clockticks
       1.001027449 N2        4         3206981828      clockticks
       1.001027449 N3        4         3206566126      clockticks
       1.001027449 N4        4         3206032609      clockticks
       1.001027449 N5        4         3205651355      clockticks

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v3:
  Rename the column to `ctrs` and `counters` in json mode.

v2: https://lore.kernel.org/20250612225324.3315450-1-ctshao@google.com/
  Rename the column to `aggr_nr`.
  Remove unnecessary comment.

v1: https://lore.kernel.org/20250611233239.3098064-1-ctshao@google.com/

 tools/perf/util/stat-display.c | 34 +++++++++++++++++-----------------
 tools/perf/util/stat.c         |  2 +-
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 729ad5cd52cb..9cb5245a92aa 100644
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
+	[AGGR_CORE]	=	"core,ctrs,",
+	[AGGR_CACHE]	=	"cache,ctrs,",
+	[AGGR_CLUSTER]	=	"cluster,ctrs,",
+	[AGGR_DIE]	=	"die,ctrs,",
+	[AGGR_SOCKET]	=	"socket,ctrs,",
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
+	fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, /*strlen("ctrs")*/ 4, aggr_nr);
 }

 static void print_aggr_id_csv(struct perf_stat_config *config,
@@ -366,27 +366,27 @@ static void print_aggr_id_json(struct perf_stat_config *config, struct outstate
 {
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
-		json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"counters\" : %d",
 			id.socket, id.die, id.core, aggr_nr);
 		break;
 	case AGGR_CACHE:
-		json_out(os, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"counters\" : %d",
 			id.socket, id.die, id.cache_lvl, id.cache, aggr_nr);
 		break;
 	case AGGR_CLUSTER:
-		json_out(os, "\"cluster\" : \"S%d-D%d-CLS%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"cluster\" : \"S%d-D%d-CLS%d\", \"counters\" : %d",
 			id.socket, id.die, id.cluster, aggr_nr);
 		break;
 	case AGGR_DIE:
-		json_out(os, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"die\" : \"S%d-D%d\", \"counters\" : %d",
 			id.socket, id.die, aggr_nr);
 		break;
 	case AGGR_SOCKET:
-		json_out(os, "\"socket\" : \"S%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"socket\" : \"S%d\", \"counters\" : %d",
 			id.socket, aggr_nr);
 		break;
 	case AGGR_NODE:
-		json_out(os, "\"node\" : \"N%d\", \"aggregate-number\" : %d",
+		json_out(os, "\"node\" : \"N%d\", \"counters\" : %d",
 			id.node, aggr_nr);
 		break;
 	case AGGR_NONE:
@@ -1317,7 +1317,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
 	case AGGR_CLUSTER:
 	case AGGR_CACHE:
 	case AGGR_CORE:
-		fprintf(output, "#%*s %-*s cpus",
+		fprintf(output, "#%*s %-*s ctrs",
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
2.50.0.714.g196bf9f422-goog


