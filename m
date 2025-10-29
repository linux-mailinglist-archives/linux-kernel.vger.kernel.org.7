Return-Path: <linux-kernel+bounces-875141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF8AC184C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A02D54F6693
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D052F9DBC;
	Wed, 29 Oct 2025 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCsHPE9o"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD52F83BB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716064; cv=none; b=YxRctwS1Shvi4VADwLQv52AZyQLbwDoL+cANQxAQ6YT7K5UDTwpetPx1UoO2vsRLYTxpZU3mwVRpV/z21ykGLIisPsrKXlSjxehJYBr9/FmFJSs0fndeuvdsjejIZhwpnYuavh5Buc0ALOdOKgu03fJu8mpS3lb0O6DDUCvUDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716064; c=relaxed/simple;
	bh=YFa6BrzuwE5/5cO1/PAM2OEPqhpeJKANuxeGrZoNU4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uH0s+O/olUiwhpeVEPHDLCm80sUNmXnGyxgiiLUYTNnEVETqOJPGLlBu8FwGSQMwCu4OJgjnbmj5Cb9Ha1htCgjfI3qutM7b3LXNxaixpA5ZwNB9q1bhzSPnN9CNwGtdlo7VHonlAStHR20CwW4s+UD9Qzyib3w64QfvL7eLZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HCsHPE9o; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso4342024a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716062; x=1762320862; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8oMwqNr4KsoGOxn51PlsqAlxOnnnA+qu7AX98PEqNWM=;
        b=HCsHPE9oocYo6eeRpotq6/FsNW4cCbnVkBbAcQnkCrHtU2ds/Szx5OU60UC2loQMBr
         zT9HwVNoza+diB+Pb+DdlM/DTF7acATAg1pBf6MCEZkXV1EhDcIOJuBPqwDryylkT2wl
         iJFNgwWY+gYkSk115Fjcjamq40vFXDVX5u8z5VxF47gaOhZGq+5MU4AY/j9Wl2BAlTyy
         2CnY7M9mZEbHpAVHb3ga/aBaD+QGAStD2eUeSVjW5XEEAzSot/teGTKcJXb/Eknw0NGL
         WUbwK9VWQSewimNj8AwfrNJ1fAn7XoeC08xWI4Yd5C6/CD2RpNB5duDs6zY3TGiwf+yk
         pujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716062; x=1762320862;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oMwqNr4KsoGOxn51PlsqAlxOnnnA+qu7AX98PEqNWM=;
        b=acwyRAi7/q7M0EAGL25gQRgDdDeqo2k8VlYqC9OdOBVn+4he5jLIWHKs9sFfNcggSw
         FOu9mKG94ZWNKUFsNoeWXLagnivRoRbNhI4PM+CAE+7tSexVQBTtfNa41JeNO0Vtgcu6
         GrgNuVYLY2ScUvH2U63PkfHgPt5c79olfEqrUqaAVG4etWgvXq06+b6mWLGialHLmOj4
         p0CucDzSQRLWJ6so6CKyK2EJjgM8SWXCSAL/GCur1c0IuXiUK7WRPf8DZrnj3R4rfr90
         7lQLDH4SajweFjvlruM25VBqrfyv2W1JpoH4oMjFa0GCiBBZYZVztQOfJlvC8i25KlUH
         C9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX7gEpdVHxNYh2AsIB7+auk3+uwLRCbgj1ufKJmYn94HuNqNkHhUcCryL411d79x0GMQ3kTfWn3cm3bDQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAVtSTSts8Fvky3QCOV3JPd4hVBbcPlYEyyLhkRErurjq1MqXw
	xiWZe73DbUIT5+ybMRs3jEoH0HwcqJqZDUXa8Gt5qltyp11+AGdBFdRDwCyzAgMZK4x4mpeOpsR
	l68BK08jtMA==
X-Google-Smtp-Source: AGHT+IGXe3xRWMqIyJ5Z6kbOfEqQsUFSZQt0QMui38JDXMLAHaq4dgc0lEfNTaG7EDI4peeaS1Y1wlOkAV2Q
X-Received: from pjvm7.prod.google.com ([2002:a17:90a:de07:b0:332:a4e1:42ec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380a:b0:32e:5646:d43f
 with SMTP id 98e67ed59e1d1-3403a297403mr2041709a91.19.1761716062019; Tue, 28
 Oct 2025 22:34:22 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:00 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-3-irogers@google.com>
Subject: [RFC PATCH v1 02/15] perf arch x86: Sort includes and add missed
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
 tools/perf/arch/x86/util/intel-bts.c | 14 +++++++------
 tools/perf/arch/x86/util/intel-pt.c  | 31 ++++++++++++++--------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 85c8186300c8..c778d3407bea 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -5,25 +5,27 @@
  */
 
 #include <errno.h>
+
+#include <internal/lib.h> // page_size
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/zalloc.h>
 
+#include "../../../util/auxtrace.h"
 #include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
 #include "../../../util/event.h"
-#include "../../../util/evsel.h"
 #include "../../../util/evlist.h"
+#include "../../../util/evsel.h"
+#include "../../../util/intel-bts.h"
 #include "../../../util/mmap.h"
-#include "../../../util/session.h"
+#include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
-#include "../../../util/debug.h"
 #include "../../../util/record.h"
+#include "../../../util/session.h"
 #include "../../../util/tsc.h"
-#include "../../../util/auxtrace.h"
-#include "../../../util/intel-bts.h"
-#include <internal/lib.h> // page_size
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 2d7c0dec86b0..9ca197cc396e 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -3,37 +3,38 @@
  * intel_pt.c: Intel Processor Trace support
  * Copyright (c) 2013-2015, Intel Corporation.
  */
-
+#include <cpuid.h>
 #include <errno.h>
 #include <stdbool.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
+
+#include <api/fs/fs.h>
+#include <internal/lib.h> // page_size
 #include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/types.h>
 #include <linux/zalloc.h>
-#include <linux/err.h>
-#include <cpuid.h>
+#include <subcmd/parse-options.h>
 
-#include "../../../util/session.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/config.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
 #include "../../../util/event.h"
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
 #include "../../../util/evsel_config.h"
-#include "../../../util/config.h"
-#include "../../../util/cpumap.h"
+#include "../../../util/intel-pt.h"
 #include "../../../util/mmap.h"
-#include <subcmd/parse-options.h>
 #include "../../../util/parse-events.h"
-#include "../../../util/pmus.h"
-#include "../../../util/debug.h"
-#include "../../../util/auxtrace.h"
 #include "../../../util/perf_api_probe.h"
+#include "../../../util/pmu.h"
+#include "../../../util/pmus.h"
 #include "../../../util/record.h"
+#include "../../../util/session.h"
 #include "../../../util/target.h"
 #include "../../../util/tsc.h"
-#include <internal/lib.h> // page_size
-#include "../../../util/intel-pt.h"
-#include <api/fs/fs.h>
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
-- 
2.51.1.851.g4ebd6896fd-goog


