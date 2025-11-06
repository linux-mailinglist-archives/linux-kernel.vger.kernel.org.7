Return-Path: <linux-kernel+bounces-889509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05580C3DCAF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B61F04E8C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC52735A14E;
	Thu,  6 Nov 2025 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6lfZtOY"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AF35A141
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470968; cv=none; b=luDxk4WKv3eM7m8KrIhwVWWS6Wu6UA6TR2vvtTihAe8A7M89avSk/knNvwKVQZ7NcWSuA4is2Hcj/3leNoTUhwXS2HweWcA2mV5DvxsRv1U+ZuwKcg98RMNbNjwZXNXmtEzejH7IhHjG2ZFubrQ0TcQbOmT4aThc3GzxdEg1iUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470968; c=relaxed/simple;
	bh=bWlWZmoSbjMlQJvhT1Kc+8bbCD51npTRBtHHE+YWJoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mNp4C9Ttuw3ZX47r9tDOskbiy+4SQQf9tXO0K6lqkBxXicMW2+PW16beeaPmcySGhwW7nR5I1ZF9ODGbxZTw2jAUqE4VF7AiT2x89jgIXQu1r47ngFxk5WaXp668Y+oG0HaIMW6c/DScFvt+CHiIOD3na6obE705zS6UpUd7TU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6lfZtOY; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6ceeea4addso159184a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470966; x=1763075766; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja604hKaX8qDrZr8dkd1ADzyH8Os+oHlUQ1fcptNWsg=;
        b=I6lfZtOY+vYKdpXfsWpCP0LB4JY1R3IB0Oyif8bh+EzrDzPGQuCAzFn48FoU8SVYpY
         KQbBl0BpbePp5N4J0+kzfZc8pdPR6vBccN7oFSX90CXEWxoqESXRR3uth43rh6XhvDQl
         XAbbZX+iGICvo06jNAMkkWcpwxx4HTkM9b7lDrJunQ50DGsgyGBQeYBf/4Esz7yRLbfY
         6RKNuK7VaEg7ueJDHttC5hwOEk7gedIixTd6Yx1GqZ7N1+AyWcErSW3mbxQkjkDKQ/Pz
         dklB/QhMgbTzOtw3cZGMSE3iDjsS7gl5eevYN73Ed2o9XQu/NWPjuYt+ioeWTYCsRzrr
         oA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470966; x=1763075766;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ja604hKaX8qDrZr8dkd1ADzyH8Os+oHlUQ1fcptNWsg=;
        b=CreGIsu+C9jb8baP/sr3diGIup2ALAFKj8G/CVs2B/Ghsk8ZSNOkO/fzJaV6TVZH+Z
         eVYNEWBmQVqs2yzdZvZkMu6WXNVCn6PW+TZ/QhotshbrVxu8oNGRJRaz5kw1qQbLlhz7
         ALmHERFRINT14zj9Y2TAZhSVyEtCJnPFojFvp/RqZTa+mbr5kFIku/DJvD/xHupIMzBf
         WgDZ04AA3J54nP/11hHScho0S+Pc6f2r3sq79pDlch9HpqjW7SKuvOruzsS7941Uw9MF
         BoX3Qf6Ar1SjaATYbk25sNspbQUOZv88xb4PpxYkVYaT1FqoX4QYMFNxlZEQxlCnMi6l
         QlpA==
X-Forwarded-Encrypted: i=1; AJvYcCUU+SNWZHh63hs3J2QVfVzVjDOHY45exeHl+M3/NU0iO3XXN6IQS7jFWyIyzPbBOxPytyWnA00koQ8YWT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9eZC7lBeKcLwd33EH/nA9hBdHcERsLMmxIPVP4ZOYv9eQAJVj
	2PrucnDIsHwgq6etQps0D1NUpJKlbync6Nb41sT/qxyt3mLGpOQjNbJqe+hGAuKO9jenMVsMOvo
	krmhWpUEzEQ==
X-Google-Smtp-Source: AGHT+IGlOsxlmvFm0qB6YZd991xh+uwXx3guS1pzc+tFdgny+jz5mNn6wDhurHuoiQ+/Bno1TZVtodykc9GF
X-Received: from dlk17.prod.google.com ([2002:a05:7022:111:b0:119:49ca:6b87])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8d:b0:295:7b8c:661c
 with SMTP id d9443c01a7336-297c03fe292mr15047305ad.26.1762470965861; Thu, 06
 Nov 2025 15:16:05 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:04 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-15-irogers@google.com>
Subject: [PATCH v2 14/18] perf test metrics: Update all metrics for possibly
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


