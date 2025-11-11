Return-Path: <linux-kernel+bounces-896201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00976C4FD76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21C854FA364
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3480636402B;
	Tue, 11 Nov 2025 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5OT8e9t"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B343624D0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896166; cv=none; b=ocXS7vcFd+8nj8Emq9v8OuQvCXA0UhctZe1c2EUTSCBOiK4hjer5J8HJvp4clOvRGMTrNry8Whixwj6OgkaPvMDol6x84i2eLFciJUhWNvh0Gcff19igkQBpIMKp14QSUI9BKGCnU03KjgkCC6hqgOPtp5U4+Rl/RztG9amFlEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896166; c=relaxed/simple;
	bh=bWlWZmoSbjMlQJvhT1Kc+8bbCD51npTRBtHHE+YWJoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fFQwr+w/J0aBK9Qu6u+RUMJF/5IKoSwrJ4lXSKShsh11yhjqenHnJW6f6GY4MjhrjUh04QW74biWmjreSXpXlT0LW6wdmHXq5HPkYNZchiKls4ciKfiWdG7eigaSP1MexbdOzjHr84UEy335/p5yiv0vioDixcHBUBMMQSVhlN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5OT8e9t; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6ceeea4addso140233a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896164; x=1763500964; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja604hKaX8qDrZr8dkd1ADzyH8Os+oHlUQ1fcptNWsg=;
        b=w5OT8e9tMRTO0zgrnD7qH++n4x3h/B3TwUDz5xcsQz2HyQ8paJ08htIrUv3zGJ/dck
         G5C5vFXxIazTyfAhdY10MESkPPi3JQ8/+KcXNfB18n2ISUS5tlXmVr0nYKygFqPviS8V
         SSEr47wH9A3UAD6GiR3oEI9ZiMupvTkg5dGlGULX/wcyIE+b9zCzf5PewLsCNrYMvT73
         3I5pW/jnRx/TjbfIGSnkdeFdv8J7gSdt+635Vzzj0ZBCcihs04Pb/aoH9nHf1BUQDqJC
         xMRNH32EFEkAXgv/3Fx6UgstOnXTWiMUqWD9P6wghR8WNgGXjh9jP0gTqV0+d34GO+ot
         AdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896164; x=1763500964;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ja604hKaX8qDrZr8dkd1ADzyH8Os+oHlUQ1fcptNWsg=;
        b=e2dPBzOJQ+kh1EC7XOsZIowrh6Z9i6UhfVuHQQfrQD50l1YeXHwTZI63MWVdjUt7ih
         jASgreIGshqtz6l531KuBhL2jEryrHcP6/T1EFpe6nqf80WKkU6J0O2dvOsV9qZqu20V
         bHf1dHI2kZQULz1cskF2nL8UdJuw1Updv8Ukvae7Is5nuNk5hGglWHI3jFEtUJaToAR2
         ukJPR8iP9xW/JKb47JL+PNjwRR3/l7QaFO2fA6i7+r+NJ+tWndyc5dmgKjLQNqbUMNLn
         Mgr4lGaRPQKzKcwcoF7hKMCiwH8jJMWVxN9GmoL+QeSlDaedA9miTT5Wnasoix6lHQb6
         nWOw==
X-Forwarded-Encrypted: i=1; AJvYcCX4mdbPQU0GT7MWuiJusRX7jx7LKy5TeV+UsZCqeTH/U+pjlTJF+em4cAZ23Xsugebfiq1TsJQcahangN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqQeB9PivgrjgeaN3ey330hVqXaSG+pvg67BDwrxPUiAkU2ks
	OWIa/Rqz/PxwKulN4BPDI3i/r+iwjiQ2sPwS5EktKT3CLtt8FTKB44UkSbUm4pZSX+UflOVf6/H
	uCOrSI7/OtQ==
X-Google-Smtp-Source: AGHT+IET+Vtsb/qDGiS3OjCx61eGiBgrs1EbJ7lO78nAN72v3dQvb6ht1BzQ5pGIgDerZtX1PQtyhx2dv8+G
X-Received: from dlbvg27.prod.google.com ([2002:a05:7022:7f1b:b0:119:78ff:fe0f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f641:b0:294:def6:5961
 with SMTP id d9443c01a7336-2984edcc8acmr9403595ad.45.1762896164437; Tue, 11
 Nov 2025 13:22:44 -0800 (PST)
Date: Tue, 11 Nov 2025 13:22:02 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-15-irogers@google.com>
Subject: [PATCH v4 14/18] perf test metrics: Update all metrics for possibly
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


