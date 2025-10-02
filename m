Return-Path: <linux-kernel+bounces-839863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCD2BB298C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405813AEBCC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6355D2D248B;
	Thu,  2 Oct 2025 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RYr7P7Yi"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A50299A87
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385366; cv=none; b=Q+Z1aI8pbXe/3uRTxXZ2MkFeApGHDpJJavArU0spQIzKJmlOCIYrzoPMozw72t9GhAw4x3Dq6TpwtVSngoXoLs3FHAm7KBHb8LNh7m0uUN+xmv7auZZB2zS/5FL726ZQhW+vPW98TTZcz/X6hbw/K4jziu6b6Z8nrixkHUkFujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385366; c=relaxed/simple;
	bh=xbV+rCfsZKYy3dRObZGeFxQK+7W/WDJNNtkZSU1JOQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEs0vKQGB/NswmMJn8KbkG5I4+ZK6OtvMFXIgqZlyNnhmalPDQIZT6EBVM90W2A/QtQjkdlix4BUjy4sAWMkpx7KP0o8PaZ+1tc20xAGYiKORw8qLhvLCMuOuYKNKnc/VYzupx4pTO9zfQCBce3QGu3QHR+FMUNbrSHjyTi8b7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RYr7P7Yi; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3307de086d8so663702a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759385364; x=1759990164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmROAtU6SgDhctC5OYUrxi6P8MiR5wW5dx2HxDTamiw=;
        b=RYr7P7YiFlMCSCASYInPkcN4OqdBfTXTowz4XG8zLzLqiEZVvc1jzs3uMHXPXaO5ua
         KSU3dqQwEmAq3aIgSYF5zq7oCuHdtaHR7qNO4cRGqi5sfICJaNh+YOolAYcY4Y9W+hza
         CM2fJFpOP8ucf1mvCVMoSVKp1DfnixAeiwc2cC1lD56D9WjZ+dfkxvG5bIH506sPAcUD
         jlG/tsdNTPBMgundltOgyMcGKJtyHhXNXyq9phuVNd1QmkY3T/nZ4+EikVKQQToQ1kwX
         MtcCgYrz25lBKoDKti8PADBcbBV6jtITuXbjSWV0eG9EBwGu/CxTgB3w0ceDXodf0KLG
         mxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759385364; x=1759990164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmROAtU6SgDhctC5OYUrxi6P8MiR5wW5dx2HxDTamiw=;
        b=Qqo7TnjQ1V40ndsrvPCWdX8AN7Mf32VzOjLX8Df+6PPLsQ19P9Xeoifcl8ixuWLeXH
         zm+4SkZPhncEp+x2vXojJPlKGkikLxDFfJKY7RLRVjg77ObSSeucWVWxt8MHtC9b7Q1F
         VuIeVkkzW0bNgkUR4/NxQ1kqBexpjPXJmc8CQWmxCUp0t2MY5KfqbNnhtLhNRiD0s1k4
         aft3zG40/4PDK94UuEaY9UUZ+4UUp+1XFisWL5xJsqP8zn0Q+hSalBg6WaW51l0SvpXw
         s3wQPEMCQVMNcyweBH04cSzI7a2MtYsv6N4aVMppWbtGAW6j31f9rMtMUNhiXUKT6cZX
         RXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2+KtqnKuySs4JW5eJZj8ds97AnwGXPBg37AD7ymY7d//8w/bfQ4hwO+xgDKmviMCacIacRdGbBsDixpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdAY7TNOel7GisLXk6Fc/Y3UjnAP2MvwklEYDRpDb0D/eD9vQc
	udlE5La3cHZXYAYH/HgHUL6faPZf/sdjkQmAS7CeAzEdTA+j5H3q0/0Tp8oct+PZ9bw=
X-Gm-Gg: ASbGncsdPlrTmc6PYP4jCSFgZspseM28C6xasKGYmgD6NKRRkQoiEgq2ANGHSi20mFw
	xfO3siXX6unSWE3NscHGwMkiwUvT36kGpszbhDSbaQc0WFIf++OEZncIuBr0Y3lA4OXlHHd830M
	bRa1+39AK2vYodfEHR5NC+4yw/M0IvmEOE7aEKqkTJzGlpSrbYiYB2jkKDz82wgpeMaivfQk66S
	n3ny+vjDd7XpoYwrZxv1PMPRQWHI2QQSk3NtH7goGJXpyXAM1zElV0uriKgBLT0pKUduV+DmS6q
	lgoxLQPByKe/2+/3rUbN3BVKIG+E51Pf9NL0ZWbLrUTX2dA4AeZkdzl5jPCPKrgVjGY9TWRIzLX
	IgJcUKjIfxb04JUnkqnT9dp7KQkIep9+vOJ2SXJLG6Po2hr5yyiow/ZvQ4vdVD3eifKkaEi0grF
	qMlgA=
X-Google-Smtp-Source: AGHT+IFIvD/TGVwCuMeABFCgpn8+lbAS6QxuDhvf7qSI2NatW7LF3gsrGSse9+7/agcJceCONR03+Q==
X-Received: by 2002:a17:90b:3a91:b0:32e:dd8c:dd18 with SMTP id 98e67ed59e1d1-339a6f07273mr7438539a91.17.1759385363417;
        Wed, 01 Oct 2025 23:09:23 -0700 (PDT)
Received: from localhost.localdomain ([122.171.19.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm1205029a12.37.2025.10.01.23.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 23:09:22 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Mayuresh Chitale <mchitale@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 09/11] perf tools: Add RISC-V trace PMU record capabilities
Date: Thu,  2 Oct 2025 11:37:30 +0530
Message-ID: <20251002060732.100213-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002060732.100213-1-apatel@ventanamicro.com>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mayuresh Chitale <mchitale@ventanamicro.com>

Introduce the required auxiliary API functions allowing the perf core
to interact with RISC-V trace perf driver.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 tools/perf/arch/riscv/util/Build      |   1 +
 tools/perf/arch/riscv/util/auxtrace.c | 218 ++++++++++++++++++++++++++
 tools/perf/util/auxtrace.c            |   1 +
 tools/perf/util/auxtrace.h            |   1 +
 tools/perf/util/rvtrace.h             |  18 +++
 5 files changed, 239 insertions(+)
 create mode 100644 tools/perf/arch/riscv/util/auxtrace.c
 create mode 100644 tools/perf/util/rvtrace.h

diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index 58a672246024..2ba1fb98a0ad 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -3,3 +3,4 @@ perf-util-y += header.o
 
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
diff --git a/tools/perf/arch/riscv/util/auxtrace.c b/tools/perf/arch/riscv/util/auxtrace.c
new file mode 100644
index 000000000000..adc86bd38998
--- /dev/null
+++ b/tools/perf/arch/riscv/util/auxtrace.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Risc-V E-Trace support
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+#include <linux/zalloc.h>
+#include <time.h>
+
+#include <internal/lib.h> // page_size
+#include "../../../util/auxtrace.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
+#include "../../../util/event.h"
+#include "../../../util/evlist.h"
+#include "../../../util/evsel.h"
+#include "../../../util/rvtrace.h"
+#include "../../../util/pmu.h"
+#include "../../../util/record.h"
+#include "../../../util/session.h"
+#include "../../../util/tsc.h"
+
+#define RVTRACE_PMU_NAME "rvtrace"
+#define KiB(x) ((x) * 1024)
+#define MiB(x) ((x) * 1024 * 1024)
+
+struct rvtrace_recording {
+	struct auxtrace_record	itr;
+	struct perf_pmu *rvtrace_pmu;
+	struct evlist *evlist;
+};
+
+static size_t rvtrace_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+				     struct evlist *evlist __maybe_unused)
+{
+	return RVTRACE_AUXTRACE_PRIV_SIZE;
+}
+
+static int rvtrace_info_fill(struct auxtrace_record *itr, struct perf_session *session,
+			     struct perf_record_auxtrace_info *auxtrace_info, size_t priv_size)
+{
+	struct rvtrace_recording *ptr = container_of(itr, struct rvtrace_recording, itr);
+	struct perf_pmu *rvtrace_pmu = ptr->rvtrace_pmu;
+
+	if (priv_size != RVTRACE_AUXTRACE_PRIV_SIZE)
+		return -EINVAL;
+
+	if (!session->evlist->core.nr_mmaps)
+		return -EINVAL;
+
+	auxtrace_info->type = PERF_AUXTRACE_RISCV_TRACE;
+	auxtrace_info->priv[0] = rvtrace_pmu->type;
+
+	return 0;
+}
+
+static int rvtrace_set_auxtrace_mmap_page(struct record_opts *opts)
+{
+	bool privileged = perf_event_paranoid_check(-1);
+
+	if (!opts->full_auxtrace)
+		return 0;
+
+	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
+		if (privileged) {
+			opts->auxtrace_mmap_pages = MiB(16) / page_size;
+		} else {
+			opts->auxtrace_mmap_pages = KiB(128) / page_size;
+			if (opts->mmap_pages == UINT_MAX)
+				opts->mmap_pages = KiB(256) / page_size;
+		}
+	}
+
+	/* Validate auxtrace_mmap_pages */
+	if (opts->auxtrace_mmap_pages) {
+		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
+		size_t min_sz = KiB(8);
+
+		if (sz < min_sz || !is_power_of_2(sz)) {
+			pr_err("Invalid mmap size : must be at least %zuKiB and a power of 2\n",
+			       min_sz / 1024);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int rvtrace_recording_options(struct auxtrace_record *itr, struct evlist *evlist,
+				     struct record_opts *opts)
+{
+	struct rvtrace_recording *ptr = container_of(itr, struct rvtrace_recording, itr);
+	struct perf_pmu *rvtrace_pmu = ptr->rvtrace_pmu;
+	struct evsel *evsel, *rvtrace_evsel = NULL;
+	struct evsel *tracking_evsel;
+	int err;
+
+	ptr->evlist = evlist;
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type == rvtrace_pmu->type) {
+			if (rvtrace_evsel) {
+				pr_err("There may be only one " RVTRACE_PMU_NAME "x event\n");
+				return -EINVAL;
+			}
+			evsel->core.attr.freq = 0;
+			evsel->core.attr.sample_period = 1;
+			evsel->needs_auxtrace_mmap = true;
+			rvtrace_evsel = evsel;
+			opts->full_auxtrace = true;
+		}
+	}
+
+	err = rvtrace_set_auxtrace_mmap_page(opts);
+	if (err)
+		return err;
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	evlist__to_front(evlist, rvtrace_evsel);
+	evsel__set_sample_bit(rvtrace_evsel, TIME);
+
+	/* Add dummy event to keep tracking */
+	err = parse_event(evlist, "dummy:u");
+	if (err)
+		return err;
+
+	tracking_evsel = evlist__last(evlist);
+	evlist__set_tracking_event(evlist, tracking_evsel);
+
+	tracking_evsel->core.attr.freq = 0;
+	tracking_evsel->core.attr.sample_period = 1;
+	evsel__set_sample_bit(tracking_evsel, TIME);
+
+	return 0;
+}
+
+static u64 rvtrace_reference(struct auxtrace_record *itr __maybe_unused)
+{
+	return rdtsc();
+}
+
+static void rvtrace_recording_free(struct auxtrace_record *itr)
+{
+	struct rvtrace_recording *ptr =
+			container_of(itr, struct rvtrace_recording, itr);
+
+	free(ptr);
+}
+
+static struct auxtrace_record *rvtrace_recording_init(int *err, struct perf_pmu *rvtrace_pmu)
+{
+	struct rvtrace_recording *ptr;
+
+	if (!rvtrace_pmu) {
+		*err = -ENODEV;
+		return NULL;
+	}
+
+	ptr = zalloc(sizeof(*ptr));
+	if (!ptr) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	ptr->rvtrace_pmu = rvtrace_pmu;
+	ptr->itr.recording_options = rvtrace_recording_options;
+	ptr->itr.info_priv_size = rvtrace_info_priv_size;
+	ptr->itr.info_fill = rvtrace_info_fill;
+	ptr->itr.free = rvtrace_recording_free;
+	ptr->itr.reference = rvtrace_reference;
+	ptr->itr.read_finish = auxtrace_record__read_finish;
+	ptr->itr.alignment = 0;
+
+	*err = 0;
+	return &ptr->itr;
+}
+
+static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
+					   int pmu_nr, struct evsel *evsel)
+{
+	int i;
+
+	if (!pmus)
+		return NULL;
+
+	for (i = 0; i < pmu_nr; i++) {
+		if (evsel->core.attr.type == pmus[i]->type)
+			return pmus[i];
+	}
+
+	return NULL;
+}
+
+struct auxtrace_record *auxtrace_record__init(struct evlist *evlist, int *err)
+{
+	struct perf_pmu	*rvtrace_pmu = NULL;
+	struct perf_pmu *found_etm = NULL;
+	struct evsel *evsel;
+
+	if (!evlist)
+		return NULL;
+
+	rvtrace_pmu = perf_pmus__find(RVTRACE_PMU_NAME);
+	evlist__for_each_entry(evlist, evsel) {
+		if (rvtrace_pmu && !found_etm)
+			found_etm = find_pmu_for_event(&rvtrace_pmu, 1, evsel);
+	}
+
+	if (found_etm)
+		return rvtrace_recording_init(err, rvtrace_pmu);
+
+	*err = 0;
+	return NULL;
+}
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ebd32f1b8f12..735f6c360064 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1393,6 +1393,7 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
 	case PERF_AUXTRACE_HISI_PTT:
 		err = hisi_ptt_process_auxtrace_info(event, session);
 		break;
+	case PERF_AUXTRACE_RISCV_TRACE:
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index f001cbb68f8e..5b7ce4a99709 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -50,6 +50,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_ARM_SPE,
 	PERF_AUXTRACE_S390_CPUMSF,
 	PERF_AUXTRACE_HISI_PTT,
+	PERF_AUXTRACE_RISCV_TRACE,
 };
 
 enum itrace_period_type {
diff --git a/tools/perf/util/rvtrace.h b/tools/perf/util/rvtrace.h
new file mode 100644
index 000000000000..93c041db8660
--- /dev/null
+++ b/tools/perf/util/rvtrace.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(C) 2015 Linaro Limited. All rights reserved.
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
+ */
+
+#ifndef INCLUDE__UTIL_PERF_RVTRACE_H__
+#define INCLUDE__UTIL_PERF_RVTRACE_H__
+
+#include "debug.h"
+#include "auxtrace.h"
+#include "util/event.h"
+#include "util/session.h"
+#include <linux/bits.h>
+
+#define RVTRACE_AUXTRACE_PRIV_SIZE	sizeof(u64)
+
+#endif
-- 
2.43.0


