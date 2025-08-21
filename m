Return-Path: <linux-kernel+bounces-780758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E49B30900
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F497B2F66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23C52EBB8D;
	Thu, 21 Aug 2025 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwzuF2kb"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9F2DA76A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814730; cv=none; b=NCbQ98oQWzN/mnzRtRedrFazj6rnelZo+noqX/PnlbUyzmhyZOfFlhwPSpfqDTRzOyCrMQBsZhSS9AXQthoZl6mRqPtC9Hf4SOlcYxiXXxPWYKdvFLqHOc8gQmaRnBoHTUri+nJi/Ojz6hiuxsk0e8Ex3lXeSsmo1GyFBV3G3Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814730; c=relaxed/simple;
	bh=DHH2rU+Zp3WpjSOcFqndoLEJ1fs8EixAC2cPKeXp1bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=b2+9uGsEfCkMUR/YefDhNQjSE2Szwy7bOhIQxlvcqTY9GjIdufC9eARaUPam/5T1GZqIuq900jxyS2oOgpchvKHY3kKZR7Ioykz4RlcYlzdOdgmM6T70oJrzrrQsK5n81EI/I7//FJODTZq0kdtTQ0UXju71HTtuFlQbEfBHCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwzuF2kb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eb9bb19so2979349b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755814728; x=1756419528; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LS/TLPPn/kr4cah7f6KZL8HylpfPU2klxIkY6Orl+xQ=;
        b=vwzuF2kb/0z5sCi3jEnOUYynwTp6BYZbxlY8Gq5dm2EGZsisdzCG7cl197z0UBu828
         spDwVByu6DkzkpeR6do92HxSmuODRekYuY86UxdUS5rYTsw1FEvCDA7ftj3vkIM+i9QZ
         DBf4SqhYB0hIvYf2cIq74BxjI4Vzz1FuzCnD9NCH+vDxRE63CG1gRPPGAnc+1gAHAPpV
         cxOFfCa53oGU5QiC6Xm6yl+Dni8853Ff+r/9WogcgIFbAHGXvO4siZ9XIhWjzhGB8/KX
         61nEKpAb2OKKKXjUMSAXbWLXKAx8rf5uhFXbDd1G8LbUiro17nKbzsBtuARqB7W2HSfm
         3mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814728; x=1756419528;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LS/TLPPn/kr4cah7f6KZL8HylpfPU2klxIkY6Orl+xQ=;
        b=tos+qYhxg2OSUHkCaTGjKG1AtVzTNPRFrNyX9wXx9qJKQNcAXEdligydfAvuUpNYIB
         /Y81okjDF4IUtdsr8mfTB7mSC3roIZwficXxLob2CCM7UHNrZyqN6JBmN+N/ncRH59h+
         YGs+4LOcIY/PBnqxqbZ+1euce5sz8ZjeO9KPBy+MWXPW8PoNIwZk7sTCMzmnb8c8PDyc
         osaPIIZOb5k8eV0jGrbmfeIoCx0ShvWQouai9jVbXntr82RxvMqWo1SDP1jBnJiloKsL
         t5iTKaBPfGvBX3Y+50B1ohFtW4QcfNcULZh+1JJkAgE6kf22JIYvtEKcEfeVEp+3/ABO
         +bvg==
X-Forwarded-Encrypted: i=1; AJvYcCULTGaV21Og68nPRtrq/Dpm0cGMeLnJ0jR2PGiA6qCJgdZkzvV43e7J+4ne+yPqBZsgfHyrRKEdtuMo/G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI5KWrcflkPQ/DJwXsUxljxi7Y6OVh5dSBv2Q9D1DaX2SWvZvW
	6grVpZiNWp6tq1I/+a2YID10wTiDVnQsgwnZBlDtnJ1l2Y+TBCLJ/nsdX51JOFEACaBzXlj1/PK
	eBmZhLwf1uA==
X-Google-Smtp-Source: AGHT+IHXPNLlePi8gsgIbXWjR2tpQQEuG8eoufHyr+zgrODcuxIvK91rUyW+ILAqostE++FR034QpB1CchUS
X-Received: from pjb3.prod.google.com ([2002:a17:90b:2f03:b0:321:b969:1e5d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a10:b0:243:78a:82aa
 with SMTP id adf61e73a8af0-24340d5e73dmr1106028637.50.1755814727694; Thu, 21
 Aug 2025 15:18:47 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:18:34 -0700
In-Reply-To: <20250821221834.1312002-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821221834.1312002-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821221834.1312002-5-irogers@google.com>
Subject: [PATCH v1 4/4] perf test: Avoid uncore_imc/clockticks in
 uniquification test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The detection of uncore_imc may happen for free running PMUs and the
clockticks event may be present on uncore_clock. Rewrite the test to
detect duplicated/deduplicated events from perf list, not hardcoded to
uncore_imc.

Fixes: 070b315333ee ("perf test: Restrict uniquifying test to machines with 'uncore_imc'")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/stat+event_uniquifying.sh     | 105 ++++++++----------
 1 file changed, 44 insertions(+), 61 deletions(-)

diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
index bf54bd6c3e2e..9bc7a1f520f9 100755
--- a/tools/perf/tests/shell/stat+event_uniquifying.sh
+++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
@@ -4,74 +4,57 @@
 
 set -e
 
-stat_output=$(mktemp /tmp/__perf_test.stat_output.XXXXX)
-perf_tool=perf
 err=0
+stat_output=$(mktemp /tmp/__perf_test.stat_output.XXXXX)
 
-test_event_uniquifying() {
-  # We use `clockticks` in `uncore_imc` to verify the uniquify behavior.
-  pmu="uncore_imc"
-  event="clockticks"
-
-  # If the `-A` option is added, the event should be uniquified.
-  #
-  # $perf list -v clockticks
-  #
-  # List of pre-defined events (to be used in -e or -M):
-  #
-  #   uncore_imc_0/clockticks/                           [Kernel PMU event]
-  #   uncore_imc_1/clockticks/                           [Kernel PMU event]
-  #   uncore_imc_2/clockticks/                           [Kernel PMU event]
-  #   uncore_imc_3/clockticks/                           [Kernel PMU event]
-  #   uncore_imc_4/clockticks/                           [Kernel PMU event]
-  #   uncore_imc_5/clockticks/                           [Kernel PMU event]
-  #
-  #   ...
-  #
-  # $perf stat -e clockticks -A -- true
-  #
-  #  Performance counter stats for 'system wide':
-  #
-  # CPU0            3,773,018      uncore_imc_0/clockticks/
-  # CPU0            3,609,025      uncore_imc_1/clockticks/
-  # CPU0                    0      uncore_imc_2/clockticks/
-  # CPU0            3,230,009      uncore_imc_3/clockticks/
-  # CPU0            3,049,897      uncore_imc_4/clockticks/
-  # CPU0                    0      uncore_imc_5/clockticks/
-  #
-  #        0.002029828 seconds time elapsed
-
-  echo "stat event uniquifying test"
-  uniquified_event_array=()
-
-  # Skip if the machine does not have `uncore_imc` device.
-  if ! ${perf_tool} list pmu | grep -q ${pmu}; then
-    echo "Target does not support PMU ${pmu} [Skipped]"
-    err=2
-    return
-  fi
+cleanup() {
+  rm -f "${stat_output}"
 
-  # Check how many uniquified events.
-  while IFS= read -r line; do
-    uniquified_event=$(echo "$line" | awk '{print $1}')
-    uniquified_event_array+=("${uniquified_event}")
-  done < <(${perf_tool} list -v ${event} | grep ${pmu})
+  trap - EXIT TERM INT
+}
 
-  perf_command="${perf_tool} stat -e $event -A -o ${stat_output} -- true"
-  $perf_command
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
 
-  # Check the output contains all uniquified events.
-  for uniquified_event in "${uniquified_event_array[@]}"; do
-    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then
-      echo "Event is not uniquified [Failed]"
-      echo "${perf_command}"
-      cat "${stat_output}"
-      err=1
-      break
-    fi
+test_event_uniquifying() {
+  echo "Uniquification of PMU sysfs events test"
+
+  # Read events from perf list with and without -v. With -v the duplicate PMUs
+  # aren't deduplicated. Note, json events are listed by perf list without a
+  # PMU.
+  read -ra pmu_events <<< "$(perf list --raw pmu)"
+  read -ra pmu_v_events <<< "$(perf list -v --raw pmu)"
+  # For all non-deduplicated events.
+  for pmu_v_event in "${pmu_v_events[@]}"; do
+    # If the event matches an event in the deduplicated events then it musn't
+    # be an event with duplicate PMUs, continue the outer loop.
+    for pmu_event in "${pmu_events[@]}"; do
+      if [[ "$pmu_v_event" == "$pmu_event" ]]; then
+        continue 2
+      fi
+    done
+    # Strip the suffix from the non-deduplicated event's PMU.
+    event=$(echo "$pmu_v_event" | sed -E 's/_[0-9]+//')
+    for pmu_event in "${pmu_events[@]}"; do
+      if [[ "$event" == "$pmu_event" ]]; then
+        echo "Testing event ${event} is uniquified to ${pmu_v_event}"
+        perf stat -e "$event" -A -o ${stat_output} -- true
+        # Ensure the non-deduplicated event appears in the output.
+        if ! grep -q "${pmu_v_event}" "${stat_output}"; then
+          echo "Uniquification of PMU sysfs events test [Failed]"
+          cat "${stat_output}"
+          err=1
+        fi
+        break
+      fi
+    done
   done
 }
 
 test_event_uniquifying
-rm -f "${stat_output}"
+cleanup
 exit $err
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


