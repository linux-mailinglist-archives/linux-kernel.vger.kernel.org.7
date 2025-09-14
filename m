Return-Path: <linux-kernel+bounces-815798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF2B56B35
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E3A189C07A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B895C2DE71B;
	Sun, 14 Sep 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJ/HxC1H"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CB1D95A3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874548; cv=none; b=CIcwp21Caje9gW/ptK2Dl/wuu/za+JLta5nLQfgP9JURwYSZ8zNcdEyOYTUswyYg0TrsO6qk9yt4u+TFlLHbSfclvmv/BGXiEMKi+vFl8Hka0IdDP8sO/K2wzHJ9D56KVTo5KfTb7GyQAElDf5xDKdRPHLo+IJBAPDZTAPNh8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874548; c=relaxed/simple;
	bh=+i4xQMP5N+7tTEJLjyp4Lzml52ZZB5eYnS6qu0gy9v4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KivvP+rnkHR+FkekHupnHGFIzeuYZZKovhjkHeA9yWcbKmCf6fnfj4LWuETmc52a5REu0zxYnSQbEdDD2TXMw1OzB0+CrRt9IREPNkMXGc9HEWLJehH3Af1t5NxXh40gwYakhvLhfmz/3rW7/mfbIm/vo+GbI0vmMuBpETqyT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJ/HxC1H; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2490768ee5fso26657745ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874546; x=1758479346; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HAiy3Nfgo/52bieljut+UzYUSPPtF1Iok2zeSkSwug=;
        b=gJ/HxC1HzC+beIGDqBSrl3LA2BA4UqboVMyWGWSae1UzLukO3d+FvWz5TV81egPBUF
         ZQ3ICgDXhsS6V4rqbdpftVcApTJR8mVUs+SJ5DTqwGpuG+GffU8+knVHKeY9DUrQNp21
         mHonehYRZOJU9rTPgaP0eofGxGAArXB9h9oCNC+j9Mt2lSj8UIgD6oKTkLJizSa25fLA
         YfyBzodNTxoE4eohyfIu/MpJ7S6lX3am5vWVvm0c98eG6gGkMn8+prD7DMWLczRRtoPm
         JDcFQvMBjD1PAugIWpFKpyxNHDwN0+aVdpQwKZOPJtSOLjj8eBj8LHQOHkVPcBgHijz/
         Mj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874546; x=1758479346;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HAiy3Nfgo/52bieljut+UzYUSPPtF1Iok2zeSkSwug=;
        b=wRkwN0uuiyKX2ADB76J9I6TMz0ICJ4gBO0ZHAhxwoSUTb79QKMMrUH8KWvLWrIz7E8
         7R1FNfGOk4mF0h5oHxZg7gtzbCnGvFLH3WCZss7j5E/rhAlC9qs1c5zDrWo5aG1aQqdZ
         EgrBcsjdrxKGCecigtdkfDwvDtbXuiGyW9pwFKg3WsI3iJhlnsTZp6aE0ts4oZ4xDuPf
         rUKHNYhSWzde8rvaFyyicGYNRssqFk3f1r4l+V0jbrUewKHG+5Y9wyPzaw08UkSeTUUg
         Oefzv+Ch0yfLc7prt36pOhz21gLqQsFCzcoZcsCMcGxVYyOjMOsKr3MTkQVNK11G0EMZ
         EOpw==
X-Forwarded-Encrypted: i=1; AJvYcCWxrLyCzdAYNt/3kbySgMG/87ehjq+M+8kN1mooz7QbetTCZ839aeX6L5t3SdQIAbI6usUIdnQn1bI/iKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyClzb2Qf8clEQtbz+D1C6CbKJE/sSIgtAKiDCAMWeaId/tRwfD
	CxuFQpIpJDal7sfsww5YqzS+ugx2g3NzDoNpKzl9rVYEtHNZr/MtRAE9/yy9y/X2arNSJ13T3tG
	k3hAasPBwEQ==
X-Google-Smtp-Source: AGHT+IHnyivzNtqrN3wSUVPkTq+iybkdIGO3uTylpMD8cdqzOFZYHwsBZlnbxQepi11eeRvtVPHlAeTVjPxF
X-Received: from plbmb8.prod.google.com ([2002:a17:903:988:b0:24c:b394:50e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78f:b0:25c:8005:3efb
 with SMTP id d9443c01a7336-25d2703b924mr126822205ad.54.1757874545977; Sun, 14
 Sep 2025 11:29:05 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:28:57 -0700
In-Reply-To: <20250914182900.1960567-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914182900.1960567-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182900.1960567-2-irogers@google.com>
Subject: [PATCH v1 1/4] perf test: Be tolerant of missing json metric none value
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

print_metric_only_json and print_metric_end in stat-display.c may
create a metric value of "none" which fails validation as isfloat. Add
a helper to properly validate metric numeric values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index c6750ef06c0f..ff90c23d1d62 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -43,6 +43,9 @@ def isint(num):
 def is_counter_value(num):
   return isfloat(num) or num == '<not counted>' or num == '<not supported>'
 
+def is_metric_value(num):
+  return isfloat(num) or num == 'none'
+
 def check_json_output(expected_items):
   checks = {
       'counters': lambda x: isfloat(x),
@@ -57,7 +60,7 @@ def check_json_output(expected_items):
       'event-runtime': lambda x: isfloat(x),
       'interval': lambda x: isfloat(x),
       'metric-unit': lambda x: True,
-      'metric-value': lambda x: isfloat(x),
+      'metric-value': lambda x: is_metric_value(x),
       'metric-threshold': lambda x: x in ['unknown', 'good', 'less good', 'nearly bad', 'bad'],
       'metricgroup': lambda x: True,
       'node': lambda x: True,
@@ -65,7 +68,7 @@ def check_json_output(expected_items):
       'socket': lambda x: True,
       'thread': lambda x: True,
       'unit': lambda x: True,
-      'insn per cycle': lambda x: isfloat(x),
+      'insn per cycle': lambda x: is_metric_value(x),
       'GHz': lambda x: True,  # FIXME: it seems unintended for --metric-only
   }
   input = '[\n' + ','.join(Lines) + '\n]'
-- 
2.51.0.384.g4c02a37b29-goog


