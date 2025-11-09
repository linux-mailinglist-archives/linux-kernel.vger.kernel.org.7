Return-Path: <linux-kernel+bounces-891774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 342ABC436F9
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 02:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72D2A347B62
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 01:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ADE2AD13;
	Sun,  9 Nov 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+9/m0hI"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A534D382
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762650022; cv=none; b=PRQ9udFONuybKcxU9zUWMxhcPxYeg7F9yEZJalowd0TXU9yEU0ESoAiL1dLi+XRmv0TL6cVsrWYbScx8oam5ztM8BsJ1aR1uMmiXEnd3jFcn7XV0ZGYr1nznwdNcaFB58557P8MLoRhEGUDNYgB6R7i8Gcl6iiZt8g8iSl/veDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762650022; c=relaxed/simple;
	bh=YxvCs03ewNiGwh/gYtnUX+8yvLdOX7TFWZC1mF8j6dY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ori9luKWq0xo0+TN/J0nZX5r+ufwF/auSwYGlUk4VdZm9999EZm/AZ1Tc0dT0ekOnm8ry9SzJi/yHMGtZAhuQoVhM1lhi/RuDgv9EBP6x8xkJ4Uw6gtyZG+yRJWnOosjWhRsoQwR1l6Nyx0rKj4OdnNPmsFrW/guIqPywqiC+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+9/m0hI; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ba4c6ac8406so1554804a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 17:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762650020; x=1763254820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y75WeVh9hJ6IVQUJoOC/gRSUs+/cPxFQm1jQqSfBWSE=;
        b=Q+9/m0hIIw4fyNV+RPotm9WBmFuE4YGCytF0hGG3gFbu/uP7eVZDqwPGPmJqlODYNx
         O8GPeOmFraiSSdMD6VnkE4rJN2B5u3MasDj/WQLdeglVpVpYW5kdRZlNBGCWdw178UVI
         uEu8+hLpBo3YY4A+roMjWHw9pl79F5jpWajDg0aysGaEV2L8BQ5KfuVPq690CZlBwGAj
         kLSRIpRCbF13rbTzxoN4Au9y2EJ4LVAYi7/9GbWtHL9+1oaBWBeqjtdkcdOROLazLUyt
         vbfDrdZeVBpsTCGme1LmBKKlhfwKvyxJmZdq7aO6mmv3d1EkdymnzsF5ZukNWZq3+0O9
         AolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762650020; x=1763254820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y75WeVh9hJ6IVQUJoOC/gRSUs+/cPxFQm1jQqSfBWSE=;
        b=SzDgaX+VyJoW468nL2eoRa8RK3SGJOAW8p8i7uxFxjoJ5b6EkZDg0IgJ/AiShNfSbe
         GXAwYK4sJDGbN6P9o83EIDm6Hq9GW9zAjL/1pb0P9VQkwQ4czmFTMw87SXz/caDH4ZYr
         RdnhAbmxYpDrwZNEm2aTWtS+gVKq13z4Wxlqeh6tsAmgtTZJSZor1YMOv8zJMzRH/j7r
         UtCV8n7YdhWZFtmIeBOAtDtXwtrI1fgXPFQrGWJo2uUtIKwel0dr8ogAKLgKHdq5KNcZ
         lH3k9Y2HBTLz0jCkBteZDaCQT+L3nMXn45C1gCh0PjGrhv59oKmi7x2cmhxS016ZjyWI
         msxg==
X-Forwarded-Encrypted: i=1; AJvYcCUaDxVam5C+TL8H3L3JpMfRGPaIIvk4SvCqZ+bNREsyG6DAG/xtRvPXLNqaphP0v5S3r6IA6irvyCbG5PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOd5jDp9UFb+EI40umfnyH/gDdHKqph+iJRSlH/i8uRKJLiojr
	6O6Pf8YPPhUvj8KIjeqyQNCeoOrw6oMV4qDkgPbMDFX97WGLDmJIWaB8L8RDmnVuhvO4a4yQNNd
	WTPP978S1Ag==
X-Google-Smtp-Source: AGHT+IFBWkwwvkk9VIwFOYjpj9Kza9G6P92OkFl1vCSi1xXLSNzNnEsJNGN3KkFU9gpd+OUj+2UuCJsfWjkC
X-Received: from pfay6.prod.google.com ([2002:a05:6a00:1806:b0:77f:6432:dc05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2396:b0:7ae:d1d:d500
 with SMTP id d2e1a72fcca58-7b225b5b53emr4981014b3a.4.1762650020018; Sat, 08
 Nov 2025 17:00:20 -0800 (PST)
Date: Sat,  8 Nov 2025 16:59:59 -0800
In-Reply-To: <20251109005959.2540616-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251109005959.2540616-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251109005959.2540616-2-irogers@google.com>
Subject: [PATCH v3 2/2] perf test: Add test that command line period overrides
 sysfs/json values
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The behavior of weak terms is subtle, add a test that they aren't
accidentally broken. The test finds an event with a weak 'period' and
then overrides it. In no such event is present then the test skips.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v3: Add workaround in case the raw event is matched (Namhyung).
v2: Add more comments to the test code and reduce the line length (Namhyung).
---
 tools/perf/tests/shell/record_weak_term.sh | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_weak_term.sh

diff --git a/tools/perf/tests/shell/record_weak_term.sh b/tools/perf/tests/shell/record_weak_term.sh
new file mode 100755
index 000000000000..811b00ffb47a
--- /dev/null
+++ b/tools/perf/tests/shell/record_weak_term.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# record weak terms
+# SPDX-License-Identifier: GPL-2.0
+# Test that command line options override weak terms from sysfs or inbuilt json.
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+# Find the first event with a specified period, such as
+# "cpu_core/event=0x24,period=200003,umask=0xff/"
+event=$(perf list --json | $PYTHON -c '
+import json, sys
+for e in json.load(sys.stdin):
+    if "EventName" not in e or "/modifier" in e["EventName"]:
+        continue
+    if "Encoding" in e and "period=" in e["Encoding"]:
+        print(e["EventName"])
+        break
+')
+if [[ "$event" = "" ]]
+then
+  echo "Skip: No sysfs/json events with inbuilt period."
+  exit 2
+fi
+
+echo "Testing that for $event the period is overridden with 1000"
+perf list --detail "$event"
+if ! perf record -c 1000 -vv -e "$event" -o /dev/null true 2>&1 | \
+  grep -q -F '{ sample_period, sample_freq }   1000'
+then
+  echo "Fail: Unexpected verbose output and sample period"
+  exit 1
+fi
+echo "Success"
+exit 0
-- 
2.51.2.1041.gc1ab5b90ca-goog


