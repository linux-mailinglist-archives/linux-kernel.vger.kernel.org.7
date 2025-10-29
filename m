Return-Path: <linux-kernel+bounces-875146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2042C184E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7F35503CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FCC3019C5;
	Wed, 29 Oct 2025 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJmP08vb"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782EA2FFFAB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716073; cv=none; b=I0akQcH9Fk88Gmy11Ck/ZcWk/faq8SgERdPNa3gVhEb3PgMeXVYGh6bXQtl7+RHSSz0I4bMTkoyWSw+oU8/P65zw4QHg3gqBNO6LAA6HvBfF6kgjmofMyOWhOLHZMX3pKucYBQX9j9AdbfHhEybc8PDnoL9hilBcGaU6NgFMNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716073; c=relaxed/simple;
	bh=nxogn7CzCOcaoMnM/yWVx3HVxrL+JJuNtx6lpItOEXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ScenFU4ulTzLjRNZY88XGb5IcZ+QGqIBzIk/MCDoI+pZ9YdPSn7g23AvtNaFISgE5Gjsm+cu+GIRSoFbNpliHqiR3O5C7A7kpHt6zdW0eRtr6cEes/wO9WPqIudHwHZ2h6gpMYzLHvciokyQq43YGxQwMPXCcZYTCuFq4J06gb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJmP08vb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so14927592a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716071; x=1762320871; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/m+GGJEX4XS9igs9SnnZKBVhxyHpjFasFgfyaBk6K8=;
        b=XJmP08vbE3WlHd+L5ja0CmJMQii/AfjZfocrQ1yI9wgTjYH0ZPYK03M3ICiW47+wXN
         ySdQ+jNn4mTDsIkQBFWlghZ+R8nhnjyZrMOh+BBAJRICO61opn65ZLXDSv9eqAN8NT/K
         m1m9QU7Il1Nxsc3k2Y7c7vj2B7z7twG6cAV5rRrwDt5jOm2KgZ5giZ/1P6z2SJmAet31
         QqONK1zGG1j9PPRVQwlx3+Jadg9dDwxORxh4tyOPGxLYGLAk/iRLSMMR8ijW1+hZZpc0
         hOyWqlJP3ZvfRJrSmQJNyFYgs6xVZuZWjB3ZpwuuDxCVIjZG9DHpjjjYcHTgdB41viP9
         VCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716071; x=1762320871;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/m+GGJEX4XS9igs9SnnZKBVhxyHpjFasFgfyaBk6K8=;
        b=hctxsO9UPOgj9jG7rQtR91ZWXABIAHLFHzYfx9CDR/GVu1V9QYX827mJgVSMIZ/KSk
         LSkfuG8DOXSv3AwUa8Bh1TOIb5Ifi6bbfEB2IlkMHR1QOh4ry1WTfIyDEXHjez6GRo7s
         V1cJglWdsB51FAlarPOKxwF0sPxOW0zErdtS8dJnQeDtA7TY+iqEdXfPY6H/YEhYApK0
         h0EqRmCescKkScA/WEL1RNHI5v/iHuYr7EWa18QQnE59jMRkg3dxZD06f3dAvD6w9UpH
         fV0qvufKp8iWJCohaS7gRvsJszScoX/x4Xljvz2O/lpMqEvNRkxorPAkt9A+mUQAYj31
         x2mw==
X-Forwarded-Encrypted: i=1; AJvYcCUPgIqbh2CKbvewyRSDj++qpjA4baW+mCaz0Qrxw28ihR9cfuRMKZpxHUUegim3Z4dRcVMgaOCUOfpglbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Q6T1+xb6qtq7efEi4RxlJXYnpSQMOIROqbiAnV8cRqoPbPx6
	5m3+SIEUCLV5soagify09K3/eiTgg9oi73WfiYGWKBhI8Z+SMQR2tTZEnAXK/SaF+qHu7MBEjzj
	St8FXWJB5AQ==
X-Google-Smtp-Source: AGHT+IFa/+7mOOLGV31OTSxrEinUSkkcBJPH0/NM79JpffezlY8J1bwcb9IheSMk05AgTiw07XZTVKFycJDn
X-Received: from plhc9.prod.google.com ([2002:a17:903:2349:b0:288:e43f:73ce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2348:b0:25d:37fc:32df
 with SMTP id d9443c01a7336-294deedb5c6mr21426035ad.47.1761716070749; Tue, 28
 Oct 2025 22:34:30 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:05 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-8-irogers@google.com>
Subject: [RFC PATCH v1 07/15] perf evsel/evlist: Avoid unnecessary #includes
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

Use forward declarations and remove unnecessary #includes in evsel.h
and evlist.h. Sort the forward declaration.s

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.h | 16 +++++++++-------
 tools/perf/util/evsel.h  | 19 ++++++++++---------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 5e71e3dc6042..61acbb10d9a5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -2,28 +2,30 @@
 #ifndef __PERF_EVLIST_H
 #define __PERF_EVLIST_H 1
 
+#include <pthread.h>
+#include <signal.h>
+#include <unistd.h>
+
 #include <linux/compiler.h>
 #include <linux/kernel.h>
-#include <linux/refcount.h>
 #include <linux/list.h>
+#include <linux/refcount.h>
 #include <api/fd/array.h>
 #include <internal/evlist.h>
-#include <internal/evsel.h>
 #include <perf/evlist.h>
+
 #include "events_stats.h"
 #include "evsel.h"
 #include "rblist.h"
-#include <pthread.h>
-#include <signal.h>
-#include <unistd.h>
 
-struct pollfd;
-struct thread_map;
+struct evsel;
 struct perf_cpu_map;
 struct perf_stat_config;
+struct pollfd;
 struct record_opts;
 struct strbuf;
 struct target;
+struct thread_map;
 
 /*
  * State machine of bkw_mmap_state:
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index f8de0f9a719b..f4540920604e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -2,28 +2,29 @@
 #ifndef __PERF_EVSEL_H
 #define __PERF_EVSEL_H 1
 
-#include <linux/list.h>
 #include <stdbool.h>
 #include <sys/types.h>
+
+#include <internal/evsel.h>
+#include <linux/list.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
-#include <internal/evsel.h>
 #include <perf/evsel.h>
+
 #include "symbol_conf.h"
-#include "pmus.h"
-#include "pmu.h"
 
+struct bperf_follower_bpf;
+struct bperf_leader_bpf;
+struct bpf_counter_ops;
 struct bpf_object;
 struct cgroup;
+struct hashmap;
 struct perf_counts;
+struct perf_pmu;
 struct perf_stat_config;
 struct perf_stat_evsel;
-union perf_event;
-struct bpf_counter_ops;
 struct target;
-struct hashmap;
-struct bperf_leader_bpf;
-struct bperf_follower_bpf;
+union perf_event;
 
 typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
-- 
2.51.1.851.g4ebd6896fd-goog


