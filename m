Return-Path: <linux-kernel+bounces-780755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A9B308FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8E0607E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FC72EA75C;
	Thu, 21 Aug 2025 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaUGfGV7"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462602DECCB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814724; cv=none; b=r9wxrYBQsBSrVT30PkIYYKcng0MhkcSc8+DSAChfUzKYQ6vD9gQ+sEOp9nNnIyJV2q1UlBrK9Ktu8w9epHhfN84L2zDcKpPkXKamhB947AfL39iWaXXsl8AKBhF/TW6ocu0fhjj4EiaXrMOCQuwHKiCSjQIraFEJShYwvsZvnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814724; c=relaxed/simple;
	bh=J7ChrngqpcfMVz2fjEKux0G9mXXIk8ji2VlMy8Zpuqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Gnmp2NVnBh/RZTXhdHRDI7l3I37lIYovnxXk7X05L43s7AkSvKXyjE8Gmt+6TQXCYOEoLtqxBURFAx5C+ftbmVDGdifu4K8WegxoTJnD8CU0adbfP5aVJ7TfXREzeqj/PS9pxq5mbfbRve88lvuIpjLXVTVIaCYk+XCVo0/T+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kaUGfGV7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-324e4c3af5fso1660531a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755814722; x=1756419522; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+LcGUNRQ5RMIFxRYxYFNAWt5Jv3NM5GtSeI5RVke4w=;
        b=kaUGfGV7wGherh3zcrd2gLDql1rMqFWRGoVB9r7jrc8rguNkx3hPkOKIGiyLlPvSzp
         H+nFBnofdoAe34N0mPWz9FBCz6SVX4sBQShtKB0BYZoJKWOU5hdRzG/XlIS45ma+wS1M
         UqM5lBymgx6n6l6VvPTNP/nFg13j+KR4O414YCA6316a0AHwemqeGfL+BYQc+61FgXlN
         aZmZaOUP3o5RMQ38i3jALaK4mv2yn4ZBkQNSJkpBAaxzSbBOZ/vw7eYvwlRyuHVNs1Rd
         2Xs1B3Xbz/PNzTbJabZahP5ONWUZuKnoJGMkDB8BY971XczuAsXhVOFw3qALMFcY+6bd
         qCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814722; x=1756419522;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+LcGUNRQ5RMIFxRYxYFNAWt5Jv3NM5GtSeI5RVke4w=;
        b=aiK1njvaP8vfqIKE8AG4+GvvlxapiAoQLqc4jIRtdwHCv3Iv7ZXSKkjFfwBiazDvki
         95IWKdzw1t2ZU1wwqt1CQYTM7oWtX/Wd4YH6rQtakm1DtvmIm0my2T9fweI2mMjinOMc
         V3azk+q/o+uR55l4B2wRgy8zhLYO4EV3M/0SefudwC7ahOEPKelE8ZWmtqVCIZQUmM9G
         HPtdunXgcerjEdeQZjaSmEZ2idIKThRGsuAMqzv/K2w57Qhkn1Stm4w9/NleciRisoEy
         sFDGjGIrH/YDRyYFdd1EVbN5mYB0NxUeo55R+8YjYM/pu3lQHJ+WRUPcWliy7hpC86H+
         4Zbw==
X-Forwarded-Encrypted: i=1; AJvYcCX704T6yjLriOA3Z6Qd5kSWrmFMCgwznCHEMnzEJhSqGUQ7flwDgx8T7upQeLEhrpyqJIPFMa6XCcS8Kn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwckBSbYssr0d1k6evoFxh2s/X9lN4OWA9iGXDv3DRVzThXvjv
	pwQXhPC5i1ZTZccBE7wqIXPqCsN0G98jFk2jR2W5RUgHpWeoActogn4fWtFrXwXG8JBUiNaqKzk
	5FLNZbqYMfA==
X-Google-Smtp-Source: AGHT+IFRjX/YkmMOyRzOeSEN3Qyl0b3TIZqfvF6f2Y1S8hBFFf5SoflTeJWXoMaNozCBAlu/0mWo3kcVYOG3
X-Received: from pjyp4.prod.google.com ([2002:a17:90a:e704:b0:321:6924:af9a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d06:b0:324:e03a:662e
 with SMTP id 98e67ed59e1d1-32515eaeeecmr1419681a91.23.1755814722551; Thu, 21
 Aug 2025 15:18:42 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:18:31 -0700
In-Reply-To: <20250821221834.1312002-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821221834.1312002-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821221834.1312002-2-irogers@google.com>
Subject: [PATCH v1 1/4] perf test shell lbr: Avoid failures with perf event paranoia
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

When not running as root and with higher perf event paranoia values
the perf record LBR tests could fail rather than skipping the
problematic tests. Add the sensitivity to the test and confirm it
passes with paranoia values from -1 to 2.

Fixes: 32559b99e0f5 ("perf test: Add set of perf record LBR tests")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record_lbr.sh | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index 6fcb5e52b9b4..78a02e90ece1 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -4,6 +4,10 @@
 
 set -e
 
+ParanoidAndNotRoot() {
+  [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
+}
+
 if [ ! -f /sys/bus/event_source/devices/cpu/caps/branches ] &&
    [ ! -f /sys/bus/event_source/devices/cpu_core/caps/branches ]
 then
@@ -23,6 +27,7 @@ cleanup() {
 }
 
 trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
   cleanup
   exit 1
 }
@@ -123,8 +128,11 @@ lbr_test "-j ind_call" "any indirect call" 2
 lbr_test "-j ind_jmp" "any indirect jump" 100
 lbr_test "-j call" "direct calls" 2
 lbr_test "-j ind_call,u" "any indirect user call" 100
-lbr_test "-a -b" "system wide any branch" 2
-lbr_test "-a -j any_call" "system wide any call" 2
+if ! ParanoidAndNotRoot 1
+then
+  lbr_test "-a -b" "system wide any branch" 2
+  lbr_test "-a -j any_call" "system wide any call" 2
+fi
 
 # Parallel
 parallel_lbr_test "-b" "parallel any branch" 100 &
@@ -141,10 +149,16 @@ parallel_lbr_test "-j call" "parallel direct calls" 100 &
 pid6=$!
 parallel_lbr_test "-j ind_call,u" "parallel any indirect user call" 100 &
 pid7=$!
-parallel_lbr_test "-a -b" "parallel system wide any branch" 100 &
-pid8=$!
-parallel_lbr_test "-a -j any_call" "parallel system wide any call" 100 &
-pid9=$!
+if ParanoidAndNotRoot 1
+then
+  pid8=
+  pid9=
+else
+  parallel_lbr_test "-a -b" "parallel system wide any branch" 100 &
+  pid8=$!
+  parallel_lbr_test "-a -j any_call" "parallel system wide any call" 100 &
+  pid9=$!
+fi
 
 for pid in $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9
 do
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


