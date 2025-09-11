Return-Path: <linux-kernel+bounces-812078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27369B532A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2FA1C80400
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E5322DDE;
	Thu, 11 Sep 2025 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xdV7qw7r"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F13322A0B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594724; cv=none; b=WdPXjBp51+0kmsgaQd5bLk09usomV5Zz/cmBUy7+/uZhaZX0iEUsYkvl7r9/qzIhaKinxcKp39jDVilPv2jIS9wIjoP1Nh1irMa05+VNWdq6bz638pVbJXIKSvLI0EmZBy58qpW0bF9K7f/MJU3jEp1rpztebJ5l2FTDCLY/mrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594724; c=relaxed/simple;
	bh=Y40KNJ4Iscv4xXvptbceaOSSvRBVQbTNlbKyTVagcfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oC5hmI/AJ5lrakzWaedhvHQYT4qA6K36n4v4B8aiaBiQIDnWdU2xH8oNaZMuqbR/r8sev1cfNFrBQ3+bRG9UmTGsosyM/OIg3fRWGxL4ko/VSluhuvMugH3imPzkiwsgkz1yyQv03E7R387jRGOj7Cux0rhdZ4YHUae3a/pEoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xdV7qw7r; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757594713; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KlBG/qJSG3l98wLLhwHdyPoQRBJrGWD1/8eAfLJKJ5A=;
	b=xdV7qw7rEac9kA/Q5FBtNwLHlQDc/lmqWZ+AnuAMPjV1mfnQ6Je/FMDKqYeUmBQMBlghNj8xKZ3Vd8QAWf6Yl5Dt3dNYyOVcgZU9Kch8H+W8fZ48VgXltr4F42H0SPjC93X92SmQabII/Gt8rD1YterbvaqLK89rUNsEV1LcB78=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WnmLJjN_1757594711 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Sep 2025 20:45:12 +0800
From: cp0613@linux.alibaba.com
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [RFC PATCH 3/4] tools: perf: Support perf record with aux buffer for riscv trace
Date: Thu, 11 Sep 2025 20:44:47 +0800
Message-ID: <20250911124448.1771-4-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911124448.1771-1-cp0613@linux.alibaba.com>
References: <20250911124448.1771-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

This patch implements AUXTRACE support for RISC-V Trace. The
corresponding driver needs to implement the setup_aux and free_aux
PMU driver ops.

The aux buffer is a type of ring buffer used in trace scenarios,
and RISC-V Trace should also reuse this capability.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 arch/riscv/events/riscv_trace.c          |  61 ++++++++
 arch/riscv/events/riscv_trace.h          |   8 +
 tools/perf/arch/riscv/util/Build         |   3 +
 tools/perf/arch/riscv/util/auxtrace.c    |  33 ++++
 tools/perf/arch/riscv/util/pmu.c         |  18 +++
 tools/perf/arch/riscv/util/riscv-trace.c | 183 +++++++++++++++++++++++
 tools/perf/arch/riscv/util/tsc.c         |  15 ++
 tools/perf/util/Build                    |   1 +
 tools/perf/util/auxtrace.c               |   4 +
 tools/perf/util/auxtrace.h               |   1 +
 tools/perf/util/riscv-trace.c            | 162 ++++++++++++++++++++
 tools/perf/util/riscv-trace.h            |  18 +++
 12 files changed, 507 insertions(+)
 create mode 100644 tools/perf/arch/riscv/util/auxtrace.c
 create mode 100644 tools/perf/arch/riscv/util/pmu.c
 create mode 100644 tools/perf/arch/riscv/util/riscv-trace.c
 create mode 100644 tools/perf/arch/riscv/util/tsc.c
 create mode 100644 tools/perf/util/riscv-trace.c
 create mode 100644 tools/perf/util/riscv-trace.h

diff --git a/arch/riscv/events/riscv_trace.c b/arch/riscv/events/riscv_trace.c
index e408d9a4034a..3ac4a3be5d3e 100644
--- a/arch/riscv/events/riscv_trace.c
+++ b/arch/riscv/events/riscv_trace.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/perf_event.h>
+#include <linux/vmalloc.h>
 
 #include "riscv_trace.h"
 
@@ -81,6 +82,9 @@ static void riscv_trace_event_start(struct perf_event *event, int flags)
 {
 	pr_info("%s:%d on_cpu=%d cpu=%d\n", __func__, __LINE__,
 		event->oncpu, event->cpu);
+	// TODO: Begin aux buffer
+	// struct xuantie_ntrace_aux_buf *buf;
+	// buf = perf_aux_output_begin(&riscv_trace_pmu.handle, event);
 	// TODO: Enable the trace component
 }
 
@@ -89,6 +93,61 @@ static void riscv_trace_event_stop(struct perf_event *event, int flags)
 	pr_info("%s:%d on_cpu=%d cpu=%d\n", __func__, __LINE__,
 		event->oncpu, event->cpu);
 	// TODO: Disable the trace component
+	// TODO: End aux buffer
+	// struct xuantie_ntrace_aux_buf *buf;
+	// buf = perf_get_aux(&riscv_trace_pmu.handle);
+	// Fill aux buffer
+	// perf_aux_output_end(&riscv_trace_pmu.handle, size);
+}
+
+static void *riscv_trace_buffer_setup_aux(struct perf_event *event, void **pages,
+					 int nr_pages, bool overwrite)
+{
+	struct riscv_trace_aux_buf *buf;
+	struct page **pagelist;
+	int i;
+
+	if (overwrite) {
+		pr_warn("Overwrite mode is not supported\n");
+		return NULL;
+	}
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	pagelist = kcalloc(nr_pages, sizeof(*pagelist), GFP_KERNEL);
+	if (!pagelist)
+		goto err;
+
+	for (i = 0; i < nr_pages; i++)
+		pagelist[i] = virt_to_page(pages[i]);
+
+	buf->base = vmap(pagelist, nr_pages, VM_MAP, PAGE_KERNEL);
+	if (!buf->base) {
+		kfree(pagelist);
+		goto err;
+	}
+
+	buf->nr_pages = nr_pages;
+	buf->length = nr_pages * PAGE_SIZE;
+	buf->pos = 0;
+
+	pr_info("nr_pages=%d length=%d\n", buf->nr_pages, buf->length);
+
+	kfree(pagelist);
+	return buf;
+err:
+	kfree(buf);
+	return NULL;
+}
+
+static void riscv_trace_buffer_free_aux(void *aux)
+{
+	struct riscv_trace_aux_buf *buf = aux;
+
+	vunmap(buf->base);
+	kfree(buf);
 }
 
 static int __init riscv_trace_init(void)
@@ -128,6 +187,8 @@ static int __init riscv_trace_init(void)
 	riscv_trace_pmu.pmu.del          = riscv_trace_event_del;
 	riscv_trace_pmu.pmu.start        = riscv_trace_event_start;
 	riscv_trace_pmu.pmu.stop         = riscv_trace_event_stop;
+	riscv_trace_pmu.pmu.setup_aux    = riscv_trace_buffer_setup_aux;
+	riscv_trace_pmu.pmu.free_aux     = riscv_trace_buffer_free_aux;
 
 	return perf_pmu_register(&riscv_trace_pmu.pmu, "riscv_trace", -1);
 }
diff --git a/arch/riscv/events/riscv_trace.h b/arch/riscv/events/riscv_trace.h
index ef0af0d0b2ee..c28216227006 100644
--- a/arch/riscv/events/riscv_trace.h
+++ b/arch/riscv/events/riscv_trace.h
@@ -75,6 +75,14 @@ extern struct list_head riscv_trace_controllers;
 struct riscv_trace_pmu {
 	struct pmu pmu;
 	struct riscv_trace_filter_attr filter_attr;
+	struct perf_output_handle handle;
+};
+
+struct riscv_trace_aux_buf {
+	u32 length;
+	u32 nr_pages;
+	void *base;
+	u32 pos;
 };
 
 static inline const char *riscv_trace_type2str(enum RISCV_TRACE_COMPONENT_TYPE
diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index 58a672246024..d1599b70ef2f 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -1,5 +1,8 @@
 perf-util-y += perf_regs.o
 perf-util-y += header.o
+perf-util-y += tsc.o
 
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+
+perf-util-$(CONFIG_AUXTRACE) += pmu.o auxtrace.o riscv-trace.o
diff --git a/tools/perf/arch/riscv/util/auxtrace.c b/tools/perf/arch/riscv/util/auxtrace.c
new file mode 100644
index 000000000000..51c8dac5ff61
--- /dev/null
+++ b/tools/perf/arch/riscv/util/auxtrace.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dirent.h>
+#include <stdbool.h>
+#include <linux/zalloc.h>
+#include <api/fs/fs.h>
+
+#include "../../../util/auxtrace.h"
+#include "../../../util/debug.h"
+#include "../../../util/evlist.h"
+#include "../../../util/pmu.h"
+#include "../../../util/pmus.h"
+#include "riscv-trace.h"
+
+struct auxtrace_record
+*auxtrace_record__init(struct evlist *evlist, int *err)
+{
+	struct perf_pmu	*riscv_trace_pmu = NULL;
+	struct evsel *evsel;
+	bool found_riscv_trace = false;
+
+	riscv_trace_pmu = perf_pmus__find(RISCV_TRACE_PMU_NAME);
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (riscv_trace_pmu && evsel->core.attr.type == riscv_trace_pmu->type)
+			found_riscv_trace = true;
+	}
+
+	if (found_riscv_trace)
+		return riscv_trace_recording_init(err, riscv_trace_pmu);
+
+	return NULL;
+}
diff --git a/tools/perf/arch/riscv/util/pmu.c b/tools/perf/arch/riscv/util/pmu.c
new file mode 100644
index 000000000000..921b083c4f6b
--- /dev/null
+++ b/tools/perf/arch/riscv/util/pmu.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <string.h>
+#include <linux/perf_event.h>
+#include <linux/string.h>
+
+#include "riscv-trace.h"
+#include "../../../util/pmu.h"
+
+void perf_pmu__arch_init(struct perf_pmu *pmu)
+{
+#ifdef HAVE_AUXTRACE_SUPPORT
+	if (!strcmp(pmu->name, RISCV_TRACE_PMU_NAME)) {
+		pmu->auxtrace = true;
+		pmu->selectable = true;
+	}
+#endif
+}
diff --git a/tools/perf/arch/riscv/util/riscv-trace.c b/tools/perf/arch/riscv/util/riscv-trace.c
new file mode 100644
index 000000000000..0632f1f43c15
--- /dev/null
+++ b/tools/perf/arch/riscv/util/riscv-trace.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#include "../../../util/pmu.h"
+#include "../../../util/record.h"
+#include "../../../util/session.h"
+#include "../../../util/tsc.h"
+#include "../../../util/riscv-trace.h"
+
+#define KiB(x) ((x) * 1024)
+#define MiB(x) ((x) * 1024 * 1024)
+
+struct riscv_trace_recording {
+	struct auxtrace_record	itr;
+	struct perf_pmu *riscv_trace_pmu;
+	struct evlist *evlist;
+};
+
+static size_t
+riscv_trace_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+			struct evlist *evlist __maybe_unused)
+{
+	return RISCV_TRACE_AUXTRACE_PRIV_SIZE;
+}
+
+static int riscv_trace_info_fill(struct auxtrace_record *itr,
+			      struct perf_session *session,
+			      struct perf_record_auxtrace_info *auxtrace_info,
+			      size_t priv_size)
+{
+	struct riscv_trace_recording *pttr =
+			container_of(itr, struct riscv_trace_recording, itr);
+	struct perf_pmu *riscv_trace_pmu = pttr->riscv_trace_pmu;
+
+	if (priv_size != RISCV_TRACE_AUXTRACE_PRIV_SIZE)
+		return -EINVAL;
+
+	if (!session->evlist->core.nr_mmaps)
+		return -EINVAL;
+
+	auxtrace_info->type = PERF_AUXTRACE_RISCV_TRACE;
+	auxtrace_info->priv[0] = riscv_trace_pmu->type;
+
+	return 0;
+}
+
+static int riscv_trace_set_auxtrace_mmap_page(struct record_opts *opts)
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
+			pr_err("Invalid mmap size for riscv trace: must be at least %zuKiB and a power of 2\n",
+			       min_sz / 1024);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int riscv_trace_recording_options(struct auxtrace_record *itr,
+				      struct evlist *evlist,
+				      struct record_opts *opts)
+{
+	struct riscv_trace_recording *pttr =
+			container_of(itr, struct riscv_trace_recording, itr);
+	struct perf_pmu *riscv_trace_pmu = pttr->riscv_trace_pmu;
+	struct evsel *evsel, *riscv_trace_evsel = NULL;
+	struct evsel *tracking_evsel;
+	int err;
+
+	pttr->evlist = evlist;
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type == riscv_trace_pmu->type) {
+			if (riscv_trace_evsel) {
+				pr_err("There may be only one " RISCV_TRACE_PMU_NAME "x event\n");
+				return -EINVAL;
+			}
+			evsel->core.attr.freq = 0;
+			evsel->core.attr.sample_period = 1;
+			evsel->needs_auxtrace_mmap = true;
+			riscv_trace_evsel = evsel;
+			opts->full_auxtrace = true;
+		}
+	}
+
+	err = riscv_trace_set_auxtrace_mmap_page(opts);
+	if (err)
+		return err;
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	evlist__to_front(evlist, riscv_trace_evsel);
+	evsel__set_sample_bit(riscv_trace_evsel, TIME);
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
+static u64 riscv_trace_reference(struct auxtrace_record *itr __maybe_unused)
+{
+	return rdtsc();
+}
+
+static void riscv_trace_recording_free(struct auxtrace_record *itr)
+{
+	struct riscv_trace_recording *pttr =
+			container_of(itr, struct riscv_trace_recording, itr);
+
+	free(pttr);
+}
+
+struct auxtrace_record *riscv_trace_recording_init(int *err,
+						struct perf_pmu *riscv_trace_pmu)
+{
+	struct riscv_trace_recording *pttr;
+
+	if (!riscv_trace_pmu) {
+		*err = -ENODEV;
+		return NULL;
+	}
+
+	pttr = zalloc(sizeof(*pttr));
+	if (!pttr) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	pttr->riscv_trace_pmu = riscv_trace_pmu;
+	pttr->itr.recording_options = riscv_trace_recording_options;
+	pttr->itr.info_priv_size = riscv_trace_info_priv_size;
+	pttr->itr.info_fill = riscv_trace_info_fill;
+	pttr->itr.free = riscv_trace_recording_free;
+	pttr->itr.reference = riscv_trace_reference;
+	pttr->itr.read_finish = auxtrace_record__read_finish;
+	pttr->itr.alignment = 0;
+
+	*err = 0;
+	return &pttr->itr;
+}
diff --git a/tools/perf/arch/riscv/util/tsc.c b/tools/perf/arch/riscv/util/tsc.c
new file mode 100644
index 000000000000..cf021e423f79
--- /dev/null
+++ b/tools/perf/arch/riscv/util/tsc.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/types.h>
+
+#include "../../../util/tsc.h"
+
+u64 rdtsc(void)
+{
+	u64 val;
+
+	// https://lore.kernel.org/all/YxIzgYP3MujXdqwj@aurel32.net/T/
+	asm volatile("rdtime %0" : "=r"(val));
+
+	return val;
+}
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4959e7a990e4..4726a100a156 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -136,6 +136,7 @@ perf-util-$(CONFIG_AUXTRACE) += arm-spe-decoder/
 perf-util-$(CONFIG_AUXTRACE) += hisi-ptt.o
 perf-util-$(CONFIG_AUXTRACE) += hisi-ptt-decoder/
 perf-util-$(CONFIG_AUXTRACE) += s390-cpumsf.o
+perf-util-$(CONFIG_AUXTRACE) += riscv-trace.o
 
 ifdef CONFIG_LIBOPENCSD
 perf-util-$(CONFIG_AUXTRACE) += cs-etm.o
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ebd32f1b8f12..b4d8f3c5ebb1 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -54,6 +54,7 @@
 #include "arm-spe.h"
 #include "hisi-ptt.h"
 #include "s390-cpumsf.h"
+#include "riscv-trace.h"
 #include "util/mmap.h"
 
 #include <linux/ctype.h>
@@ -1393,6 +1394,9 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
 	case PERF_AUXTRACE_HISI_PTT:
 		err = hisi_ptt_process_auxtrace_info(event, session);
 		break;
+	case PERF_AUXTRACE_RISCV_TRACE:
+		err = riscv_trace_process_auxtrace_info(event, session);
+		break;
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
diff --git a/tools/perf/util/riscv-trace.c b/tools/perf/util/riscv-trace.c
new file mode 100644
index 000000000000..c9bc3f6a7857
--- /dev/null
+++ b/tools/perf/util/riscv-trace.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <byteswap.h>
+#include <endian.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/types.h>
+#include <linux/zalloc.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "auxtrace.h"
+#include "color.h"
+#include "debug.h"
+#include "evsel.h"
+#include "riscv-trace.h"
+#include "machine.h"
+#include "session.h"
+#include "tool.h"
+#include <internal/lib.h>
+
+struct riscv_trace {
+	struct auxtrace auxtrace;
+	u32 auxtrace_type;
+	struct perf_session *session;
+	struct machine *machine;
+	u32 pmu_type;
+};
+
+static void riscv_trace_dump(struct riscv_trace *trace __maybe_unused,
+			  unsigned char *buf, size_t len)
+{
+
+	const char *color = PERF_COLOR_BLUE;
+
+	color_fprintf(stdout, color, ". ... %s: buf=%p len=%zubytes\n", __func__, buf, len);
+	for (size_t i = 0; i < len; i++)
+		printf("%02x ", buf[i]);
+}
+
+static void riscv_trace_dump_event(struct riscv_trace *trace, unsigned char *buf,
+				size_t len)
+{
+	printf(".\n");
+
+	riscv_trace_dump(trace, buf, len);
+}
+
+static int riscv_trace_process_event(struct perf_session *session __maybe_unused,
+				  union perf_event *event __maybe_unused,
+				  struct perf_sample *sample __maybe_unused,
+				  const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int riscv_trace_process_auxtrace_event(struct perf_session *session,
+					   union perf_event *event,
+					   const struct perf_tool *tool __maybe_unused)
+{
+	struct riscv_trace *trace = container_of(session->auxtrace, struct riscv_trace,
+					    auxtrace);
+	int fd = perf_data__fd(session->data);
+	int size = event->auxtrace.size;
+	void *data = malloc(size);
+	off_t data_offset;
+	int err;
+
+	if (!data)
+		return -errno;
+
+	if (perf_data__is_pipe(session->data)) {
+		data_offset = 0;
+	} else {
+		data_offset = lseek(fd, 0, SEEK_CUR);
+		if (data_offset == -1) {
+			free(data);
+			return -errno;
+		}
+	}
+
+	err = readn(fd, data, size);
+	if (err != (ssize_t)size) {
+		free(data);
+		return -errno;
+	}
+
+	if (dump_trace)
+		riscv_trace_dump_event(trace, data, size);
+
+	free(data);
+	return 0;
+}
+
+static int riscv_trace_flush(struct perf_session *session __maybe_unused,
+			  const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void riscv_trace_free_events(struct perf_session *session __maybe_unused)
+{
+}
+
+static void riscv_trace_free(struct perf_session *session)
+{
+	struct riscv_trace *trace = container_of(session->auxtrace, struct riscv_trace,
+					    auxtrace);
+
+	session->auxtrace = NULL;
+	free(trace);
+}
+
+static bool riscv_trace_evsel_is_auxtrace(struct perf_session *session,
+				       struct evsel *evsel)
+{
+	struct riscv_trace *trace = container_of(session->auxtrace, struct riscv_trace, auxtrace);
+
+	return evsel->core.attr.type == trace->pmu_type;
+}
+
+static void riscv_trace_print_info(__u64 type)
+{
+	if (!dump_trace)
+		return;
+
+	fprintf(stdout, "  PMU Type           %" PRId64 "\n", (s64) type);
+}
+
+int riscv_trace_process_auxtrace_info(union perf_event *event,
+				   struct perf_session *session)
+{
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
+	struct riscv_trace *trace;
+
+	if (auxtrace_info->header.size < RISCV_TRACE_AUXTRACE_PRIV_SIZE +
+				sizeof(struct perf_record_auxtrace_info))
+		return -EINVAL;
+
+	trace = zalloc(sizeof(*trace));
+	if (!trace)
+		return -ENOMEM;
+
+	trace->session = session;
+	trace->machine = &session->machines.host; /* No kvm support */
+	trace->auxtrace_type = auxtrace_info->type;
+	trace->pmu_type = auxtrace_info->priv[0];
+
+	trace->auxtrace.process_event = riscv_trace_process_event;
+	trace->auxtrace.process_auxtrace_event = riscv_trace_process_auxtrace_event;
+	trace->auxtrace.flush_events = riscv_trace_flush;
+	trace->auxtrace.free_events = riscv_trace_free_events;
+	trace->auxtrace.free = riscv_trace_free;
+	trace->auxtrace.evsel_is_auxtrace = riscv_trace_evsel_is_auxtrace;
+	session->auxtrace = &trace->auxtrace;
+
+	riscv_trace_print_info(auxtrace_info->priv[0]);
+
+	return 0;
+}
diff --git a/tools/perf/util/riscv-trace.h b/tools/perf/util/riscv-trace.h
new file mode 100644
index 000000000000..4901ea323b77
--- /dev/null
+++ b/tools/perf/util/riscv-trace.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef INCLUDE__PERF_RISCV_TRACE_H__
+#define INCLUDE__PERF_RISCV_TRACE_H__
+
+#define RISCV_TRACE_PMU_NAME		"riscv_trace"
+#define RISCV_TRACE_AUXTRACE_PRIV_SIZE	sizeof(u64)
+
+union perf_event;
+struct perf_session;
+struct perf_pmu;
+
+struct auxtrace_record *riscv_trace_recording_init(int *err,
+						struct perf_pmu *riscv_ntrace_pmu);
+
+int riscv_trace_process_auxtrace_info(union perf_event *event,
+				   struct perf_session *session);
+
+#endif
-- 
2.49.0


