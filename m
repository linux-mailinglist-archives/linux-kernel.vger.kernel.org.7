Return-Path: <linux-kernel+bounces-869339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B1BC07A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6A142373C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980B1346797;
	Fri, 24 Oct 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtkJoI7I"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259B934E759
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328789; cv=none; b=lSx9z+OMqf+8mvfA3oAj7dJG2+s3f815HJkPims2Tir+X5n+UyHO9qwLkgiH1sfwlQnP/Wh4mMcPgZh95EC6p+i4FwZmFjD1rUR4SDf1b0dTK8Y5JACrokzYvUuZUrPN6u3HA0Je1UOhlOi5w34IDSyweTXmKsxBgQdqAycBHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328789; c=relaxed/simple;
	bh=q1O8hLkBKOlhvk1PqTzz9AoGYbVsRGA0an5mkJTkoys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lUToIs1YNjcaF4qYP4nuiSAJ1tMNsa5Thg2EFrwTO10R0+OAgifq94w1YexI3mHWdihQnZIHHYpSBhgB+XfmApO4PMt1bQyEXJLBu4N/L96ljVJe4adx8Xj2M4Z1QxjYsWGLRl4ein3Nq5q9WFeaNuR5g8SunBe/Ju8JyVvLrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtkJoI7I; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so3500005a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328786; x=1761933586; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmyzXEiuEakA9tINxzGZRCYfGFH2n3X7HRR3W7fGH50=;
        b=jtkJoI7I7p/P6Q4D+f/Dis7rpvxBAJT2Ykr+4jhpUocsi6nwyQ3tP7jJaU/KdJo8Ua
         wlyOetOYn9h02TeCZZo2Tp4QFMGPh1ySdk2A7SBYU4en9dKjZKKJlvTsG2DKq48jiBXI
         ZAEYE1wQiW82Hcr8MpSQrz+V/F6/YiK9Q5QRlndOvMceifM4hXHHmVXIK4PSFb7q+Cu/
         BaZCTrpFUY6sNq3XtULNFA7OHfa7RlcoAJwgIHz0xdX8NFXVI5a3G5uIQs5bKAABZb9v
         gtCdab0MiBPg+JQpB0RXIQfCKNbP8+Bd5VMu88fERR7Dcyguxar9MSyB1anV7Q9OP1bP
         CDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328786; x=1761933586;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JmyzXEiuEakA9tINxzGZRCYfGFH2n3X7HRR3W7fGH50=;
        b=e5FmlwT9LqMNJlJJG0kXTzXwSxBi3zTLkfJRfY67vhof845zVj2yYo5vRIqQoWpbZV
         jNcjsuYJkpdg+fCn+Ij5GtX6i9hEl8APayerh8L5K2u7O9PmouCsuerbFjk6WBNk0THU
         LuAKjz+6mmqFHdXf6D39xoDVbwdxRI7iovCJJgTWg2woo3+wOOU0uiulAx7nk4NSZ9U7
         uC6UENqGZ0ieeoSa/t1nWUcN9qFUPlLYpDYwbtVVCmxuUanKn2Y8G+/cuO2et/MlrkNc
         InQ7VYgHJ3UPBFoFrSx2Qs5pNiR3w9gOFFqj9KGe89BdLZ5Pm9NTgpXflImoGIdqgSf8
         w0eg==
X-Forwarded-Encrypted: i=1; AJvYcCX1YvB5W3m1wVW+thgjIGaNkRiLkyJ/ckGcPsJSNk8vWJrXfVARVq4WLbiKF6dT+AawiJBf7ca7wkkh5B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8qk+tTOxaB12VYhQjqCfUmUg53y6vMgzs0EPDzZKTqe8rbDN
	Z48tCX8spmLXgRMcWdJ3SsjEbvtbyN7DsE/QIHnsB1lV/iszLm0eImQBguuIV5vsMkaWdQ+uPOu
	VKZkTg9qYGQ==
X-Google-Smtp-Source: AGHT+IH3T1XEJnZO2R7yqtTin61a3Kd5JkyUZzfnB4kDi6C1ujwkEp7c2F6yvCfiEiGjcWhl+v0wQOEZtd3X
X-Received: from pjbqn7.prod.google.com ([2002:a17:90b:3d47:b0:339:ee5f:ec32])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d0e:b0:32b:c9c0:2a11
 with SMTP id 98e67ed59e1d1-33bcf84e114mr40783160a91.4.1761328786458; Fri, 24
 Oct 2025 10:59:46 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:56 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-22-irogers@google.com>
Subject: [PATCH v1 21/22] perf test stat: Update test expectations and events
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
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

test_stat_record_report and test_stat_record_script used default
output which triggers a bug when sending metrics. As this isn't
relevant to the test switch to using named software events.

Update the match in test_hybrid as the cycles event is now cpu-cycles
to workaround potential ARM issues.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 8a100a7f2dc1..985adc02749e 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -18,7 +18,7 @@ test_default_stat() {
 
 test_stat_record_report() {
   echo "stat record and report test"
-  if ! perf stat record -o - true | perf stat report -i - 2>&1 | \
+  if ! perf stat record -e task-clock -o - true | perf stat report -i - 2>&1 | \
     grep -E -q "Performance counter stats for 'pipe':"
   then
     echo "stat record and report test [Failed]"
@@ -30,7 +30,7 @@ test_stat_record_report() {
 
 test_stat_record_script() {
   echo "stat record and script test"
-  if ! perf stat record -o - true | perf script -i - 2>&1 | \
+  if ! perf stat record -e task-clock -o - true | perf script -i - 2>&1 | \
     grep -E -q "CPU[[:space:]]+THREAD[[:space:]]+VAL[[:space:]]+ENA[[:space:]]+RUN[[:space:]]+TIME[[:space:]]+EVENT"
   then
     echo "stat record and script test [Failed]"
@@ -196,7 +196,7 @@ test_hybrid() {
   fi
 
   # Run default Perf stat
-  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/[uH]*|  cycles[:uH]*  " -c)
+  cycles_events=$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]*  " -c)
 
   # The expectation is that default output will have a cycles events on each
   # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
-- 
2.51.1.821.gb6fe4d2222-goog


