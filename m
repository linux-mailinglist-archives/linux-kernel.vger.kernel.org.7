Return-Path: <linux-kernel+bounces-875142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A975C184CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E09AD4FA7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51C82FB99F;
	Wed, 29 Oct 2025 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4kh14A8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6342F7ACD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716066; cv=none; b=CPJwlwoWUGgCRAp/a1aCgsf8kA1uApGgXsLTe3o7lXl2TqKD+7aipzQKwW/iXnDPU9jZR0v3J+jzwnAWF1N3xvBxL9j8dwtlAzXmobqwfIKfNELx2GgmkSMjIJVEisLQObrB7WfqCG80uynhj8aWmZ0vT0osQnCaunvtlUR5hkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716066; c=relaxed/simple;
	bh=rQBABjY2ZcI7bzoVi9MOUvkB6OWm9RvFP8qPtuA7Et4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Oq7RSK++Dg0nqQTSF4KM96bdvkbtvo59+Z13YeQ4caBCZXyaUAhfjdVfnjEopDjg5ayp0toOHjeM19lrOnLvEy4Jjj0v0A8t2m3BZh3i+zhZ9MtuGbngoZQtH+oMaqtIpzW6XzbE7D+RgN8JFzshAAfBF/ONHKAoRGR8PThrq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4kh14A8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3403e994649so284045a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716064; x=1762320864; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dR63+sQBngTuWGvF49cBTkLmw7RMYV8Fq7W7/Lk4BTE=;
        b=J4kh14A8l+7ozTUmnedfenDSYrxKa1+HC0wCXHViFnWgQXM6tpT+K0zt3LWiy1ExzN
         vOJITGYUSBUAjkFBwhFfHADSCEeMxuX+aJKnRWDLMGcbvmVQ37o6rldjIcSqwsUf7acH
         RfY0wNWA019xfo/7G01j05d9gVfFAAxzIjX1maPyzwIqWMACYgGYZ3wd2xzHItHVt1zy
         05HW13Da4UDm1ID3hZ3zRZUzaSrXT7g/yzobEQdHU9NHoEK5ZjNygVxMyT/yvYkZ9gU0
         6yaMF77/Ek/TBgMQ8U+x2gKDYXPm7lF7un9Raq36gi3kDwpQhJptUBACnTbxJu9BIps+
         P7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716064; x=1762320864;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dR63+sQBngTuWGvF49cBTkLmw7RMYV8Fq7W7/Lk4BTE=;
        b=MugvbqmI+PY1LcIR90xGUbndU8zck1tVHvlHyqT2OOwLjp3um13j6GXZDxiH6tdxAq
         UuFtL8XyYT6It/klvNMO5zvJhaNp+ZlCPT230JqNr23dHHlPj8xBT/zTDw+p53VGDqCk
         UfpDRrDEb0Hm0EyQp20ASUJkPjKOUUi0QOR1HhUOtEA3+joUwq32svfpylK4dGS4qdn5
         e+gNPw4xqxLWo5+9D0p+kTUX+5IakeP7tTO41VcnC3ECC11L/Bwcrx6YNlRPt+bZcbTp
         pFABmxOdHRIPnAaBCBz8G/X1IgNR/qPxrQUl9nSgO6YD9A4NLU96NfX2qgngyKpkWrGr
         rAug==
X-Forwarded-Encrypted: i=1; AJvYcCWvwbLv/WvQP764w7tv4zfTGmfXtu9ygFBB8p0z2k5B1bhwgoZQ9/1BKFCOHgYgbfpDZ+2A870z1t0umiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfLugYV6TIar5fPWYGqpbIizHSceApZIGZt57e68Enm+NOnVv
	PqF3NXCi2Bmld+QTJRPEsVQ48v3htUdBZe9zxkYFbdDI7SS41I0n47+F9Pnn7drtW+tNxNYMtIi
	Cru4E3p8l6w==
X-Google-Smtp-Source: AGHT+IFaRofd+fIISr/OLS3duPI/DGom8F/PI6KVPtolRQ7YsoC25vZxQqLqCVYXl7ckhJjYy4gcCkR4t4ba
X-Received: from pjbci8.prod.google.com ([2002:a17:90a:fc88:b0:33b:bf1b:2cfa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b09:b0:32e:e3af:45f6
 with SMTP id 98e67ed59e1d1-3403a265529mr1978753a91.10.1761716063765; Tue, 28
 Oct 2025 22:34:23 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:01 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-4-irogers@google.com>
Subject: [RFC PATCH v1 03/15] perf tests: Sort includes and add missed
 explicit dependencies
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #includes found while cleaning the evsel/evlist header
files. Sort the remaining header files for consistency with the rest
of the code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c  | 12 +++++++-----
 tools/perf/tests/mmap-basic.c | 13 ++++++++-----
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index 151f02701c8c..97ea036ebae6 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -1,14 +1,16 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-#include "debug.h"
-#include "evlist.h"
-#include "hwmon_pmu.h"
-#include "parse-events.h"
-#include "tests.h"
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include "debug.h"
+#include "evlist.h"
+#include "hwmon_pmu.h"
+#include "parse-events.h"
+#include "pmus.h"
+#include "tests.h"
+
 
 static const struct test_event {
 	const char *name;
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3c89d3001887..a622bb8d4cc8 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -5,21 +5,24 @@
 #include <stdlib.h>
 #include <perf/cpumap.h>
 
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <perf/evlist.h>
+#include <perf/mmap.h>
+
 #include "cpumap.h"
 #include "debug.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
+#include "pmu.h"
+#include "pmus.h"
 #include "thread_map.h"
 #include "tests.h"
 #include "util/affinity.h"
 #include "util/mmap.h"
 #include "util/sample.h"
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <perf/evlist.h>
-#include <perf/mmap.h>
 
 /*
  * This test will generate random numbers of calls to some getpid syscalls,
-- 
2.51.1.851.g4ebd6896fd-goog


