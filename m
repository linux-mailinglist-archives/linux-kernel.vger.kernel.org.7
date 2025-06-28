Return-Path: <linux-kernel+bounces-707428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 014DCAEC3C9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 03:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAFD7B619B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 01:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EBD1DACA1;
	Sat, 28 Jun 2025 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwkNXDRS"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0A1B4121
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751073790; cv=none; b=jZUCSAcrzFvINSOQJNRxfaIZN5hNZ7hgSc/VjZNpLYIA0T+nupr8Z6u6BWFoOjs3eIVAcFc3sIY+W+21yfQPTOpnnjYLoU9opog20cbkjGU+/427StNVyDv2VJSU14gwJ0c1NcUkw663WNqnNbGM9dzMIdK+prmH86KjvOWt8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751073790; c=relaxed/simple;
	bh=lqVZ0ZdwJCNHNb8o/bTviZHUZ7f/m9OEvUrytqvCkrk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jVfYD34epx+RUDlPpUzjgjRcghdcOFcRZxaMBnjwHrE/Xc8NlkAucmWw1a5KuTz+0zbh41t+zUyEPclyY5liFXBqz1MkOI65ApyRRa9qMfLquGk7Z6A5oSVc9aJu27cZziHlMypJnIi174K4gz7WLaMm03ExMYULrrri6mTmO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bwkNXDRS; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2eb1763cb08so348082fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 18:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751073788; x=1751678588; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KimOLBQdrw3JPMQ2eWl+70T9Ddr6hT3KTKPVMBjlLvc=;
        b=bwkNXDRShcV+PrWFRnDK+Xk5MD8rRkCHsREsZmyhQuG/bYwUrDMEXfVI7RWNlbtWHH
         lfy7jV/2AjfpGLBUi2cDKhC15+gKYBZdwnvJabZ/JD1Ppyo4R88Loe0i7jZ0cd+jGuXT
         ynoxkIiFu/aH9CveLQeEZHVn0Yu1biMwVP38719EItOzS8hl/cfpcOEuBdx246Uju0/k
         mbTH3CioJfqkmwAAOSHSMkyXBjGkOFJQRDiDv8LmmEHGywvYiXx+V+Ecye7IKyfBOsbz
         VRAlfUWP0p2u+3MPKYB4lYsd+wO3yl71MHzVTw9418SlvD/H3S0rYHMfTlUhPG6rvM3M
         F0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751073788; x=1751678588;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KimOLBQdrw3JPMQ2eWl+70T9Ddr6hT3KTKPVMBjlLvc=;
        b=OieUWnNc2fssN/uJFyHCFgaDgOih2HjLAQZSkEf3ValpkC5IcCIaRQt3lhlIRArIYO
         m0FoVHmsrq0hZREeXUUkGxe5fE62Xn2gWRKmBF8wt7LNYBVh5lr2Yq6HR4avHGYc07fK
         /HGod+si1Ujhm9BWXawhuqli8WT5GvVK2PlPylE0XyBiQkZymX9Z2ZVYvbMAOyVkjOZi
         4yJRJ4CPYEx6sAmQQel8/YsUHePgIcK36lyoTgdUCfKjcJVIKe9xEdbqMjOGMx2OKxnJ
         7bajIHxJ2ixe6ZUHNO1dK7Xm5M7FuH7hlLnhrOv7jT2NrLmPcGLe1/r6j5roK28ndiEB
         s1wg==
X-Forwarded-Encrypted: i=1; AJvYcCVuA84sbT/HMgBkO3ezZG7K3g13yBXj4Uw4eZyYL51IXlJRPv+mPw4tvNDOMnZ6QhUjWetSPH+weE+1ctk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxngfgm4S+A4cc9T2Y0pSYZQM7artCJYGP4olWyngTFiwLM4Bm
	nNXLy3WOYpUgH2/mL1BsWKEDxTK6u7Xjys0Y7h66vsM8KAhAE/lmXJ9BXt8PbmN3cMV6kb5T9fW
	4XMaq68h50Q==
X-Google-Smtp-Source: AGHT+IET/LdfVyOGb1bWWHF3jZxWfBFJX/8Bn8I8ZCBykayKs7eINHZphS3XyP9WUBfmF6S/YqNztf/D7Cb2
X-Received: from oabqz3.prod.google.com ([2002:a05:6871:60c3:b0:2ea:1219:6873])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:2423:b0:296:b568:7901
 with SMTP id 586e51a60fabf-2efed4805d1mr3393489fac.16.1751073788265; Fri, 27
 Jun 2025 18:23:08 -0700 (PDT)
Date: Fri, 27 Jun 2025 18:23:02 -0700
In-Reply-To: <20250628012302.1242532-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628012302.1242532-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628012302.1242532-2-irogers@google.com>
Subject: [PATCH v3 2/2] perf test: Add sched latency and script shell tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add shell tests covering the `perf sched latency` and `perf sched
script` commands. The test creates 2 noploop processes on the same
forced CPU, it then checks that the process appears in the `perf
sched` output.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
v3: Avoid running taskset in the background as suggested by James
    Clark <james.clark@linaro.org>
v2: Skip the test if not root due to permissions.
---
 tools/perf/tests/shell/sched.sh | 93 +++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100755 tools/perf/tests/shell/sched.sh

diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sched.sh
new file mode 100755
index 000000000000..c030126d1a0c
--- /dev/null
+++ b/tools/perf/tests/shell/sched.sh
@@ -0,0 +1,93 @@
+#!/bin/bash
+# perf sched tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+if [ "$(id -u)" != 0 ]; then
+  echo "[Skip] No root permission"
+  exit 2
+fi
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test_sched.perf.data.XXXXX)
+PID1=0
+PID2=0
+
+cleanup() {
+  rm -f "${perfdata}"
+  rm -f "${perfdata}".old
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+start_noploops() {
+  # Start two noploop workloads on CPU0 to trigger scheduling.
+  perf test -w noploop 10 &
+  PID1=$!
+  taskset -pc 0 $PID1
+  perf test -w noploop 10 &
+  PID2=$!
+  taskset -pc 0 $PID2
+
+  if ! grep -q 'Cpus_allowed_list:\s*0$' "/proc/$PID1/status"
+  then
+    echo "Sched [Error taskset did not work for the 1st noploop ($PID1)]"
+    grep Cpus_allowed /proc/$PID1/status
+    err=1
+  fi
+
+  if ! grep -q 'Cpus_allowed_list:\s*0$' "/proc/$PID2/status"
+  then
+    echo "Sched [Error taskset did not work for the 2nd noploop ($PID2)]"
+    grep Cpus_allowed /proc/$PID2/status
+    err=1
+  fi
+}
+
+cleanup_noploops() {
+  kill "$PID1" "$PID2"
+}
+
+test_sched_latency() {
+  echo "Sched latency"
+
+  start_noploops
+
+  perf sched record --no-inherit -o "${perfdata}" sleep 1
+  if ! perf sched latency -i "${perfdata}" | grep -q perf-noploop
+  then
+    echo "Sched latency [Failed missing output]"
+    err=1
+  fi
+
+  cleanup_noploops
+}
+
+test_sched_script() {
+  echo "Sched script"
+
+  start_noploops
+
+  perf sched record --no-inherit -o "${perfdata}" sleep 1
+  if ! perf sched script -i "${perfdata}" | grep -q perf-noploop
+  then
+    echo "Sched script [Failed missing output]"
+    err=1
+  fi
+
+  cleanup_noploops
+}
+
+test_sched_latency
+test_sched_script
+
+cleanup
+exit $err
-- 
2.50.0.727.gbf7dc18ff4-goog


