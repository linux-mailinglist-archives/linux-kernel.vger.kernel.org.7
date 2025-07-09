Return-Path: <linux-kernel+bounces-724531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA751AFF405
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EB55A3282
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569672475CD;
	Wed,  9 Jul 2025 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8lTCzpa"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41124466F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097241; cv=none; b=DtRQWtYxcWerfbS0NwSujAy+41JQ4yLW+x/6eCstJqQ9Axcx2JqmnsJ5EJEOWNlccF0pmOMU3wcf5HYUVXC5ZYKhdunw/TZ2hls6t1/H/gQj21D0RjuqOjbYYO5p8rKEhJJh2jtbYkymtMxzqtmXBso9vgJxyEULuKMu678wR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097241; c=relaxed/simple;
	bh=4RhnUIdDBTq0pKyjxJeOi7qIuV8UBI3E2+4jD3YcP7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LhOT0LP33NYETJxN04Ymcjz30odt9EmyoQWpyp2GpR8ga5jf5YOmpGfY0XAbEFO9xLSKCqx/wXndwheYKHgP/9XZwnwwBBFVnfhQAc8M5tWPJw5n9p4ZvFKwHQMpJ6NjQLoDiCdpe8dSVvG099filp3XbEFnurZxEP3LEcdaAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8lTCzpa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235e3f93687so4281715ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097239; x=1752702039; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRZkm/myoY8JXQXFYiK3d6FXz7MSloychwQltzDxXbc=;
        b=o8lTCzpankEju9ZY/zHFZ2grfNnZExQK88ExddhOE0vAVt4O990tGW8znkvBQdODO+
         iVZgoJ6s/+K+jWeDumaFDeKYZv0F/4uTW0pQV7wUlf7+WIDdAL2boUGWSxJzeFKQYHL9
         c3cktyT1loomwDkTbCHCNSaYnwd5H+lzpSn/gXjXYatd3eBriK3OEs0Aeu2H15EX1vVa
         gwB9MFSJMQvHc8P5RnEmhreBsEewfQF15FctnDPo7qnTdicOWNlqhamVBBuIGaZn0tD4
         N+e2YVltPwOrIMEHvxdiOhnPtLnx+dc7uLY9Zk68jBIKVv89K2EI/SlPsV7YneV50kIe
         N3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097239; x=1752702039;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRZkm/myoY8JXQXFYiK3d6FXz7MSloychwQltzDxXbc=;
        b=hK5eWaD7PJ84T3Cu17zTn46N2dyXW69VgOrErjmTk5sJei1Q86BqNrwFX6CP63EHBj
         mNrqU1cwp/owN9F9dLsr1QDHolM9krQx6A9uZtjNijDZeVS9/mqQrytgg5Sd4pSaR1Dt
         MXVlrIgIldueMUu3Lw3oPtyGzpJp8k8s1p/CSQjUSoHCmNBBqHswTxxGQo2vtq+kLzzB
         sWigLmjNRE7YeOc3powQ427EDLuTaSVQwpPKrOd5vg81qytvkoDAdbetM9fAbxj2bFsk
         9qh45GuRi7YBYdfhLHKEudhMFcVOHq/D0/ZATUnjdZ3wmsP6fZrVbiMxxKlzDcEiB2JQ
         9Mrg==
X-Forwarded-Encrypted: i=1; AJvYcCWf2+WTHlVRGb5/lEh/LhkiC87t6JNOulqL5FaxCPcumajt6XJJ5H+P4eZL+s0cGXr9ArGH6X00ZyljFCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qy4bnhXLrVsA/wg0TfdJ/yowsTFVxLo89PCI1/Ff8bWUE0fg
	8vPW/0qxwg7Bb3U9WD1sJY0MrTvlKq/SafNcJuq5yQS7rqGlvc49ruVEyFxGWIvpt1NODBEmjPd
	WfGaxMss35g==
X-Google-Smtp-Source: AGHT+IGZ5grGeIuw5glQVkklBxNEKKxomcSYAQGiwSohPNNQHUy7vJojGsm5h6sCDpZq0PO+bkWJuZ69hg1F
X-Received: from pgar20.prod.google.com ([2002:a05:6a02:2e94:b0:b2e:c00e:65ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:240a:b0:236:9402:a622
 with SMTP id d9443c01a7336-23de4872c01mr289295ad.34.1752097239690; Wed, 09
 Jul 2025 14:40:39 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:20 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-4-irogers@google.com>
Subject: [PATCH v1 03/12] perf spark: Fix includes and add SPDX
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scnprintf is declared in linux/kernel.h, directly depend upon it.
Add missing SPDX comments.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/spark.c | 8 +++-----
 tools/perf/util/spark.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/spark.c b/tools/perf/util/spark.c
index 70272a8b81a6..65ca253cc22e 100644
--- a/tools/perf/util/spark.c
+++ b/tools/perf/util/spark.c
@@ -1,9 +1,7 @@
-#include <stdio.h>
-#include <limits.h>
-#include <string.h>
-#include <stdlib.h>
+// SPDX-License-Identifier: GPL-2.0
 #include "spark.h"
-#include "stat.h"
+#include <limits.h>
+#include <linux/kernel.h>
 
 #define SPARK_SHIFT 8
 
diff --git a/tools/perf/util/spark.h b/tools/perf/util/spark.h
index 25402d7d7a64..78597c38ef35 100644
--- a/tools/perf/util/spark.h
+++ b/tools/perf/util/spark.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef SPARK_H
 #define SPARK_H 1
 
-- 
2.50.0.727.gbf7dc18ff4-goog


