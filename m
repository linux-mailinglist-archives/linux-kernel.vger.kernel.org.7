Return-Path: <linux-kernel+bounces-896203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6ABC4FD67
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EE6189CB30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DE0364059;
	Tue, 11 Nov 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0XAGdG6b"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5C364044
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896170; cv=none; b=LrvxB/myAf5ugttkJlcNT4aecwHNCNLl106eulnUEKDH4FvVHVd0j1oWIOCbKfgPYnEGFIC5gHdq3vSt5yM+r7pnwFz4YKTr/sXlJ1dC5mgDoEWuDlVUGK3F8acOTGreF0UC2M01TtNvCcSEvpmCyvEK4dVJvtoWwoX2753fILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896170; c=relaxed/simple;
	bh=LLn9FDAlPcwSWZjUFvp9EB4XY1jJAmyC35CaM/eue2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fYAXD6sKxDbq1yFBQE6cj62zUjwqh0+875WPtWdK+6IQdG6j9HB+RA+qzfzGoRL7BsNTZ9DK79a5lxOF4WotegvgCbEk3X/q8khZcx9bQcjt+5npow9Qiv4GOTWzDcc1VUbbF+x3pBgL4jD4BT51mqibbgDBECcedKibwwbt89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0XAGdG6b; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2958a134514so1781985ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896168; x=1763500968; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Et4hjqXaxJjcCbzTA1Cjej6Oy43GlvxgQk6XgvQSd0=;
        b=0XAGdG6bR3FNFnH5ISFm+6Msr8l8PKPOxJNmWy84C0xDLr9dLJUfOfwC54f/Te00tS
         mgslhO1rnRKeUWyydSZjjQ7GHJ7pB/p1vis1Ym58eQeIamznWGDBqr64tFd5fozXsf6S
         AZIEqQUKjLoqcgsZHbFFp7nHIDJ7OmpOdefhNwaXdEQ1kpumhrob2vausRx1SfeoAuxs
         kxsVPYLTQ/HHEA8lJG+6YZkbrIsltNmYiMgcAH4Qn63zw18/qrpSh1lPlJ9xQmuypXx2
         TtL1PZxkdjaue2AfGbPH+vl4dBJlmcuy5Ov1MlGSy5JFx111yv98fxFSndOJRNFP2OlT
         YVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896168; x=1763500968;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Et4hjqXaxJjcCbzTA1Cjej6Oy43GlvxgQk6XgvQSd0=;
        b=jz8+GK4BHlsc6+i/UPnUeqKVF/487T0WhdyfG7g8UP7InDG5OcgVBw9fxUY/zUut7D
         jnegXhQ1PMXRjRokuFq71hNQIg/TpE6KzVzZzq3G0FC/CFoFoJFA8GL6u+3p/Usid4nw
         8OspdyTZP3cY/lvPAykhBQRSlpi+Wu1CvipsGDpG8vLSWqeWji5PKWWRA4XI2P/6kuxf
         4avW5LoimqQZ9glOkO1mIgrjrFKeBceYkOCBt58qyZ918bVva4U2z0wLTfi5EONyJOpc
         wQREX92OqS2C8talHNDqKB345foz7tSK7SqmiTqSCykb3fKJlcc2Tp8H3j77ZrOel/d4
         dFqw==
X-Forwarded-Encrypted: i=1; AJvYcCXca1Fr8swvsL/Cf81FHURSMtmOch52o2atkcbFqMK2fLsBIFd8E/riu5Z3O9CRKgvW3BBPngATvrycG6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbLmPNCeBWcQyVItw81MXzR6pEEE0n4W0jsjiUwzcnz9zPQ7M
	Mfqj5dF0Tm4mKjJVaZJxNCRdK8OPcwT7SLT0wwUOsz6KbeWxcF1KXSgnJhwnaAZfKznSL+ha2S1
	qLdo3otrEQA==
X-Google-Smtp-Source: AGHT+IFUIAwe2oi4qnLmR99SfxqD2ZGgqsUaIMupxRi/QGSnfoVg5YJfkVgFLJQ1I2aFRT5lOflt/dAxANXt
X-Received: from dycnh23.prod.google.com ([2002:a05:7300:ce97:b0:2a4:603a:d424])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0a:b0:295:24ab:fb06
 with SMTP id d9443c01a7336-2984ed92172mr9538725ad.22.1762896168147; Tue, 11
 Nov 2025 13:22:48 -0800 (PST)
Date: Tue, 11 Nov 2025 13:22:04 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-17-irogers@google.com>
Subject: [PATCH v4 16/18] perf test stat: Update test expectations and events
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
2.51.2.1041.gc1ab5b90ca-goog


