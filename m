Return-Path: <linux-kernel+bounces-726659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E4B00FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C2B586594
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EBE3074A4;
	Thu, 10 Jul 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHsJ89L1"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5AE2F0E42
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191514; cv=none; b=URNMw2OUtw2ZDRcVPYulMqBbr1/kvg0chmhwfD5xCr47y025yLLOoXm4px2t9ehatS+XkxyEKo8MCPpDuBa3W53+3+xFsToWJwprJoOkrzi/kfQGdofJ8mAktWYYCzIPRl490mpDCf5V4oX/x0tFMJ0xP67OGghn44TsG9qw2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191514; c=relaxed/simple;
	bh=4RhnUIdDBTq0pKyjxJeOi7qIuV8UBI3E2+4jD3YcP7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UEsUH5wGnPD0RrwQOxVxvhQIyUSJnJWqrQNPF6pipjnkuw+DDcjpHOeuqHhXjIs4PxdzDkmMzFdAtrgvDSM6/E3DrxGutQTVaM3gS6WUEkFg3sMVnWDaRI7EecGpV5K+gqtkS7OqdpaF5e2p/k13GBgz4pWlrp4gpS+KScOngLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHsJ89L1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23638e1605dso11526505ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191512; x=1752796312; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRZkm/myoY8JXQXFYiK3d6FXz7MSloychwQltzDxXbc=;
        b=lHsJ89L1kDJvdPXp1LYvPU/cvGMxlERd5bJIycrz8YsKd0zBgTM9ZEX18R3Rm0NptA
         4G6klv4+J3oIgfwLLuV7iV/SrE5PU2Q58aW7/OHWbPoGoycGbU43flkv34+OKDkVIxur
         NxDe9Cq/Dx40OZh9MzyakPEBFggpaqri39PjI8Q3ecMBNpl1ybS2BmctxLj4rTHkFYrV
         8MzT7fkI1su0PEC8aFfkwzzxUyf/hkSTFOF5iqd2bRzWWVKAkjCy+xo1dnlAeBBl/ZsO
         nieXQQBUwUTP1YiGefDGVih9TYiPiBpLM6YPeQjYI7azJyHO1gU9OYdJnZpjPX43Lfd7
         4Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191512; x=1752796312;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRZkm/myoY8JXQXFYiK3d6FXz7MSloychwQltzDxXbc=;
        b=gitG+y52SCmnEFMjYzFeZ+tC93EKVRu9UsjYX0XOtRBftcUZXzQqkEGRehflG3EyUK
         Tzcw4oXlqd7i7euJ2GaRg5zcbXmjM/tkPxqifPoyhkZQfcHaUJdx9UUCG2bkGYiKk+Zg
         uBiSJMZxsmvgPgkim+yh3AWx94HPixqM/MMBDCOKtR1JDeUofOXcPXUs0lkpcrraMz+4
         2PyB+CQ9hfM9lv59AsN4W6VK5c+54UCZ32rjDEZ+a//fXqVQTYhuSKynVRsMSlyDwYI8
         vC0hmNkEUEkHQx3Lb3YsX1/EqAHL57UYKylyBXuc6zrQB5AIqZLFImIjcE3AqI/0GC6K
         lL7g==
X-Forwarded-Encrypted: i=1; AJvYcCVmHvx//owV6kU07KTAs6QhJgRbc7Y928e6jaOfRkhNMCgSd7274u/eDs+Mw59DlW+y4OAXxOaX/Xox+ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxECgDXrmzMoGpw0ewijB5OHUkDovmRsXXaaI1MS61J8cadOMkP
	Dzaq5ix675BCLkAPwfFK+jOnKE1zQDTSKfHF2Nzsuo1sa5CvY8etH1tCqgQXbpZEVx2rbr94uV8
	PhjrMOsrlBQ==
X-Google-Smtp-Source: AGHT+IGLTNBJqqNRFe03rtohHZtVjV3PGAjgEaeS1rjfmd9WiCQvjWw/Kq0cU8IwP5OHRC196EtcxUqGNwTt
X-Received: from pjbsi9.prod.google.com ([2002:a17:90b:5289:b0:311:485b:d057])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78d:b0:234:a139:1215
 with SMTP id d9443c01a7336-23dee28fa46mr12324755ad.35.1752191512306; Thu, 10
 Jul 2025 16:51:52 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:16 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-4-irogers@google.com>
Subject: [PATCH v2 03/13] perf spark: Fix includes and add SPDX
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
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
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


