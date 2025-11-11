Return-Path: <linux-kernel+bounces-896197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4789C4FD79
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E6C3B4E94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D28035E551;
	Tue, 11 Nov 2025 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPkkqJa1"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B796135CB67
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896160; cv=none; b=QJZdKZVfMClmyqtGGD3DSzJRy825+N6AqmB04D+/RSnhORH8F9XaHgHgRmwymJb+zOq9LDPyKPnSVw0/gYszw2V8lnJoJ9mVzyRnAZEjOHoekq5L57kh66mUZrw8hW6+/T3t4CHLn7B8aO6lwi3/A2lnyPRNqJKV1KGU9mFPMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896160; c=relaxed/simple;
	bh=3kfszh9GvrFi8Y4HcNCDpFFabOoNANjoDq9+KWDc9ZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=j+0Z+q/uL7Yp963LROtfsgu6/+dxuXso1rBOXnoPBPTA76G0aqiRwPCqZb28HxlSn7cC7ZwUUukIWWqL9lMY9Agt1QtT+6XH0EcFU+awTl6lw5T/wfQBHSw/8x5WbSbEJx9+0nLlGA6LB4VUkqUAYjSewWvOGl181G4f016Mf2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPkkqJa1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295595cd102so3055845ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896157; x=1763500957; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blAae1b4UuHw+1SOJAzDhtKVe5EnHpicO6Ta+cSn2vM=;
        b=tPkkqJa1RtVY+zJAZm91C85lkpfy9l8PJwOp0LRwrAap3QF5Ol5CXmc4dXzbt3qANg
         iMTmuW3uDMr4GkTSk4AMFVPzH6CxKLEUzN0MWtC8puJBLvzg3XYXgoMcGeTwEoZGc+2J
         1F52egISSozyyzltroRbU0X1WjCLKF4H6PRqTaukf46aN81VLn1JlLgi2CUt/vkXTzma
         MmSmR9+DQCivWjYwl9qHylmvsbRQV6iZRMKl2Ai1k1SP0qap2YEzeNEjmrH9YEToCv1A
         nwXlm8u5s0MzWqlnu5XBWMNSKY3Teoh/owWWUQWEBjMjICbFzXse4/VvWWo0xFcUUtr4
         SyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896157; x=1763500957;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blAae1b4UuHw+1SOJAzDhtKVe5EnHpicO6Ta+cSn2vM=;
        b=n5a25HFPNv6fewn7AiBQKAkKN6F1j9K0El7OBun+Rjoo5q4qKkiDG+aZ8VgyOcn06L
         RHdEYxN8qGMk4crFDKASiPLvTnT6Gq9khU3KwaDqrXS6cyw7k/vuf6IskvaCSEIKLY7U
         M1BWM+rPB73arq+yE28tlPcN8zDV36LSkxiIOv1OJ4FW8JE0E/d7bhXaVGHKHYCeddXn
         RsGh48Ic5RjYWuyNr83zbyoze/y3k2o1zqGYvoaM5cv0kWMRd7sVaAPw6UeKPkLebN91
         xH1LLVXvXDmzwIDcoorQCRvKCkdYmhzZUZZOThkSUuuQ/Iv/i6rP3kkTmmPjTE2FOLOx
         EwqA==
X-Forwarded-Encrypted: i=1; AJvYcCU0JaeIM6OFEkzAPJjB+5OaVIKkrPF/xWMsCL55Gfegkd21mWkMYbgCq+faqAT/Cw4blh232Zf6hboIJ44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3CiFNnm4dzWF1MqRyWr/7eF6GeRChEOmC+KgMGvrzYOGfKDtR
	NURW8qfnv4N63f5TgPZUp8C6GlfaMoWqfwbHgnY2rha2YfcxW2PwG/HUfsEDnNQjKeUvsAqAbyC
	PtkPDTAijwQ==
X-Google-Smtp-Source: AGHT+IGlvk0Ir0z2hQxDkU2feXx3djGCYRZJ2m1lMdgreqJokqzXuwUOkvWY6DU16C+um4U8SNaWHMk1RUxE
X-Received: from dlbtu23.prod.google.com ([2002:a05:7022:3c17:b0:119:49ca:6ba9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84f:b0:295:19e:487b
 with SMTP id d9443c01a7336-2984ed7a164mr8888875ad.5.1762896157019; Tue, 11
 Nov 2025 13:22:37 -0800 (PST)
Date: Tue, 11 Nov 2025 13:21:58 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-11-irogers@google.com>
Subject: [PATCH v4 10/18] perf stat: Remove "unit" workarounds for metric-only
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Remove code that tested the "unit" as in KB/sec for certain hard coded
metric values and did workarounds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 47 ++++++----------------------------
 1 file changed, 8 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index eabeab5e6614..b3596f9f5cdd 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -592,42 +592,18 @@ static void print_metricgroup_header_std(struct perf_stat_config *config,
 	fprintf(config->output, "%*s", MGROUP_LEN - n - 1, "");
 }
 
-/* Filter out some columns that don't work well in metrics only mode */
-
-static bool valid_only_metric(const char *unit)
-{
-	if (!unit)
-		return false;
-	if (strstr(unit, "/sec") ||
-	    strstr(unit, "CPUs utilized"))
-		return false;
-	return true;
-}
-
-static const char *fixunit(char *buf, struct evsel *evsel,
-			   const char *unit)
-{
-	if (!strncmp(unit, "of all", 6)) {
-		snprintf(buf, 1024, "%s %s", evsel__name(evsel),
-			 unit);
-		return buf;
-	}
-	return unit;
-}
-
 static void print_metric_only(struct perf_stat_config *config,
 			      void *ctx, enum metric_threshold_classify thresh,
 			      const char *fmt, const char *unit, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
-	char buf[1024], str[1024];
+	char str[1024];
 	unsigned mlen = config->metric_only_len;
 	const char *color = metric_threshold_classify__color(thresh);
 
-	if (!valid_only_metric(unit))
-		return;
-	unit = fixunit(buf, os->evsel, unit);
+	if (!unit)
+		unit = "";
 	if (mlen < strlen(unit))
 		mlen = strlen(unit) + 1;
 
@@ -643,16 +619,15 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 				  void *ctx,
 				  enum metric_threshold_classify thresh __maybe_unused,
 				  const char *fmt,
-				  const char *unit, double val)
+				  const char *unit __maybe_unused, double val)
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[64], *vals, *ends;
-	char tbuf[1024];
 
-	if (!valid_only_metric(unit))
+	if (!unit)
 		return;
-	unit = fixunit(tbuf, os->evsel, unit);
+
 	snprintf(buf, sizeof(buf), fmt ?: "", val);
 	ends = vals = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
@@ -670,13 +645,9 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 {
 	struct outstate *os = ctx;
 	char buf[64], *ends;
-	char tbuf[1024];
 	const char *vals;
 
-	if (!valid_only_metric(unit))
-		return;
-	unit = fixunit(tbuf, os->evsel, unit);
-	if (!unit[0])
+	if (!unit || !unit[0])
 		return;
 	snprintf(buf, sizeof(buf), fmt ?: "", val);
 	vals = ends = skip_spaces(buf);
@@ -695,7 +666,6 @@ static void print_metric_header(struct perf_stat_config *config,
 				const char *unit, double val __maybe_unused)
 {
 	struct outstate *os = ctx;
-	char tbuf[1024];
 
 	/* In case of iostat, print metric header for first root port only */
 	if (config->iostat_run &&
@@ -705,9 +675,8 @@ static void print_metric_header(struct perf_stat_config *config,
 	if (os->evsel->cgrp != os->cgrp)
 		return;
 
-	if (!valid_only_metric(unit))
+	if (!unit)
 		return;
-	unit = fixunit(tbuf, os->evsel, unit);
 
 	if (config->json_output)
 		return;
-- 
2.51.2.1041.gc1ab5b90ca-goog


