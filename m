Return-Path: <linux-kernel+bounces-746555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33959B12832
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBF51C22523
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2515746E;
	Sat, 26 Jul 2025 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMy1RK62"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B34129E6E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490429; cv=none; b=sV2lB5ZVcXbb79cottil5aEoMLZSKJqDaMx56ZvxglDx0d6yaS1m2BL+75w3vK+jJrEwVS68DCJx6M5uSexdghC/aXuy7SaCly7aGmUt1uzZVJApFw0Qe6WWPMpfyto3Ay/L97UvIPLx054qKCnI4xPXS7g8Bx05ImXBa7bTqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490429; c=relaxed/simple;
	bh=n8D/edGFZL/hgNbZYwUtmezqHxp9oRlZEQVwjzRgobQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tjVPjLlKJ6p4yvtJE63uxK3A/SFUGkEZA12WAqr1/VTohDP4XRAjqtxN7AQO2ImJcMbDDnmDJATO/LolhF1OZiXthOUvzS58S3iBgoYkiSnO73ApvqW0dF4KnD+r7FBK7M4+dPQyiSEwy8Ly0dTSsHCSGgY77BM78o1S/OT2920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMy1RK62; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748f13ef248so2541860b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490427; x=1754095227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Zqr8X01SGutVjV/XNi7iN/97nh5Gk7Veb9QakNbtvc=;
        b=DMy1RK62tQPnRAgekk7WhgdtAX1l/XVigu2kmRxQCUGSpm6RU2e7WRRjsruS/swRy7
         l++hEVQ1NhI2AuMJBoeahRo/tQsLXHcjjSbs3tahT6myVe5gkxfabWdYLIMiY2QyZIbx
         HHlmA2oYBRafDPaOH6i6B6S+oKTJPnt9obQxrJOGOP/roqOZManW5E5mZyuzYa08TN96
         0QDJl5raj8JbglyqAWlb3RxzB4IIRBOCH+X6/CTUmwMRUWT8+mOQUOclFXDkpF4jHomU
         m7+z34z/SsEwFciZ/Czo4Wu1KVteVaNk/5Q6JDIzk9tPpKOZn3TzAkUDLXM1Vu271/ur
         QTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490427; x=1754095227;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Zqr8X01SGutVjV/XNi7iN/97nh5Gk7Veb9QakNbtvc=;
        b=nMJHKxekMsP7pvSdwTBhRM8HRzydhrbrLGXk6YOLZ3Nu0OlgwOnVLhZ6i+C69T3I3H
         zjJVXY5d7nNgaLTJEMJ5QVXxI9ZbGob9i0uC7YLS45Buf4RjKWE1QEkIjFuHayrVgCJU
         DrIJfm5ByVkhilnyPmtNac/apXU8E+hL0rQQABs6Rj65dH4k5kCp1iu2N+0IeoZKexw7
         o3GmHVJWaWa8svY5s0rY0N6FJel1VZJLqA3YCbmjzhXAkBbUMDeblk4NgAhxqVNYkn05
         8iN9p9mdvlCl0qHtz6CNQocKQ7RZwena8+3vfW2rtBTwGy0EeLpBWG4ozsZsA58Y6dcM
         opRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVJXXKgvBA1VoRPuSkDI9F5EI+pit6g3qIkxLwjv49KI9Fv8Ac2dFIwBTr1Va+7pgF5y26r1gQToItUek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSk2joCQxGx+rrtELEYb3xxxk+KBSeQgkXw9eHqT5aV6UXCif
	R4p+IdtahMrnd7aXvqYsIsk3M6LqvYbBi7EPE4rcO+hd+RRB3CYb9roFCaQE1Sa67QzpHk6ig7x
	kj8Wc473JQW1cdqQel/nF3Q==
X-Google-Smtp-Source: AGHT+IGSoo8WdGl+OGvbRnbs0+/8TM4wBhGm55waZ4GSl0VDmPb7RoWgx3X4IQSiC2YjsJugCZwIw0DRLCTKodF2
X-Received: from pfau2.prod.google.com ([2002:a05:6a00:aa82:b0:748:34d:6d4f])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1953:b0:748:2cbb:be45 with SMTP id d2e1a72fcca58-7633583028dmr5161224b3a.15.1753490427032;
 Fri, 25 Jul 2025 17:40:27 -0700 (PDT)
Date: Fri, 25 Jul 2025 17:40:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250726004023.3466563-1-blakejones@google.com>
Subject: [PATCH] Fix comment ordering.
From: Blake Jones <blakejones@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Blake Jones <blakejones@google.com>, 
	Collin Funk <collin.funk1@gmail.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit edf2cadf01e8f2620af25b337d15ebc584911b46 ("perf test: add test for
BPF metadata collection") overlooked a behavior of "perf test list",
causing it to print "SPDX-License-Identifier: GPL-2.0" as a description for
that test. This reorders the comments to fix that issue.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/perf/tests/shell/test_bpf_metadata.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tests/shell/test_bpf_metadata.sh
index bc9aef161664..69e3c2055134 100755
--- a/tools/perf/tests/shell/test_bpf_metadata.sh
+++ b/tools/perf/tests/shell/test_bpf_metadata.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+# BPF metadata collection test
 #
-# BPF metadata collection test.
+# SPDX-License-Identifier: GPL-2.0
 
 set -e
 
-- 
2.50.1.470.g6ba607880d-goog


