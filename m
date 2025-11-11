Return-Path: <linux-kernel+bounces-894614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EBEC4B6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8B518945E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A085634B68F;
	Tue, 11 Nov 2025 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aelZsAfp"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7734C83A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833894; cv=none; b=SVkwDW/RZ0aMLjxEFRl7JzXwbcfoIuXbjQW7js1vWbf6qeo9oPnETwDiJTP6jjwezCGkk18lAFcd8AbgdILUFLbYY2bTq/kiI2Cq5pSLls2CQg37fwED6c6TE7yyq+qkAfPne+zOPg0Juy6LV41lL7yBcJLnzjHQDMDFdJfuWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833894; c=relaxed/simple;
	bh=bWlWZmoSbjMlQJvhT1Kc+8bbCD51npTRBtHHE+YWJoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qIMCvRpjuxbYy7z4V/bD8yzYRAJ8TKhBR0BL4OVk5/DRGBcwf3U/5e3IWRvEriJTY/Bfe44KuyLuRrNzEuquEJrm5EuhmcYdaWw+MPH5xHbvf3VcLdQQ88hd3Y2egRZjTlLxWFBhuikx2DvsWO5T2HYSX53GJVVGUhAM1rpuXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aelZsAfp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2958c80fcabso102676075ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833892; x=1763438692; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja604hKaX8qDrZr8dkd1ADzyH8Os+oHlUQ1fcptNWsg=;
        b=aelZsAfpOM3JxfqCQ/zPPvgLAjX2plnqRxNhPoYwHz2KsxCR3s5f2uu2afV3X7n7yi
         ee5vaZwb4zBKcLTeaBDHqjU1zTBxa3WFdGISgPuY/VsHyV5TzcXCdENKdpzM/njbtbqF
         RD5GvkdvF8otfYAB+Dhv+iI0YhnkJoUwkd/BiE/4z0LrUYr1I0pcwArcnALBnOm7Tv78
         6G2ezJpd6xo3wYaKSgJun16QASLJna6MV/wcW7NBra0Iw6LEPnRzde0kguiiS2dj0FyF
         2suU7KwwvnMG+SDyqBX81dJTMn1/FZzn2fBVoY1FnlsCiazqGXj1yBh7eEn83AqRq/xx
         OK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833892; x=1763438692;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ja604hKaX8qDrZr8dkd1ADzyH8Os+oHlUQ1fcptNWsg=;
        b=N8Bx6mPMskeoD56XwxThI/1P+mjJ9J4jWXJuJqdBv1RyQPkG2KmxhrsmXFZlz249D0
         IZA9qWawWCLmch7XvEZydWFMHwQBBSUmvp0N7mp9GUuZ+gl+uCVV7OkjA0BB565Jo4Bf
         lLFFmgISollJqNQz7KJq6qvpPUty7IBAMrzhBn6ZO2A2/3X9uW+K4ijH6PcSVvgpUeLQ
         y2nXOml4iVY0Z6ML78WkjTgp41P5wHGxjSYmM/uwYtBgDw17JDqtBtyytE8MTadT9hcZ
         4zWPz5zUreTJqze3ZEVYIpZZ8ReX5zNMlztXO6YJ0okXqs6b40Vlt0y//hqQ9bpYg/j9
         +ZjA==
X-Forwarded-Encrypted: i=1; AJvYcCUrHLsONYXU6VyodG6KTEXnc5TRYRLnKfsMBDq2yfENaGrdxPCNamHTX59ruHpfIlzpLViAIWIVGVB4LZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1Hy5Pn5rRYRRDti52pY/N6CTItD1ceXMExgKoC8ZCx21MP4i
	yWQ6EB8gEVOfa6yxqczHStgFEKXPFdwd7gr8rUxY1cvRysWLKvGtRHdYcPBtXYJ1NlnJFnbfZ9R
	DEtoZbtylgA==
X-Google-Smtp-Source: AGHT+IErWkHeqed2GrqiOy88wuRY0tqtNPYJOqc0LJ1kt+lmnAJczl2sta01fh79caMHsqjCpCPCmGcxFpwB
X-Received: from dybpf10.prod.google.com ([2002:a05:7301:410a:b0:2a4:6c32:42a2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d485:b0:294:f310:5218
 with SMTP id d9443c01a7336-297e4be8af6mr152083305ad.0.1762833891972; Mon, 10
 Nov 2025 20:04:51 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:13 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-15-irogers@google.com>
Subject: [PATCH v3 14/18] perf test metrics: Update all metrics for possibly
 failing default metrics
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

Default metrics may use unsupported events and be ignored. These
metrics shouldn't cause metric testing to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 6fa585a1e34c..a7edf01b3943 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -25,8 +25,13 @@ for m in $(perf list --raw-dump metrics); do
     # No error result and metric shown.
     continue
   fi
-  if [[ "$result" =~ "Cannot resolve IDs for" ]]
+  if [[ "$result" =~ "Cannot resolve IDs for" || "$result" =~ "No supported events found" ]]
   then
+    if [[ "$m" == @(l1_prefetch_miss_rate|stalled_cycles_per_instruction) ]]
+    then
+      # Default metrics that may use unsupported events.
+      continue
+    fi
     echo "Metric contains missing events"
     echo $result
     err=1 # Fail
-- 
2.51.2.1041.gc1ab5b90ca-goog


