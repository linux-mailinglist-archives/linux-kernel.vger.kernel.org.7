Return-Path: <linux-kernel+bounces-660013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12665AC17F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CF65075FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D7271A62;
	Thu, 22 May 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="D31tcYJ4"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9592D3236
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956385; cv=none; b=MVtRc/r19NHSD+oNBb5TDd1A2SV/VMZ0CsUWyr9lS35CjuPsooBtXM9TtFTwSRWI7pNeV4wH1egxY5SVLmLogbbFbYIDx5baCRn799XiOHPUOBZM4gQ1v3qe/USNXC5unFwyU4MUKMh9Tq7cI5CfeYYeN+EsqZxXpP3mG5aVMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956385; c=relaxed/simple;
	bh=HQlCiM1VZsjqb/niITpfgq1gwhQMuUn578fiz8Bl7N0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZi96OThhKRgmWX00ZVfprTwj78RDsPmKYZn8eX4OnXB2Vg1e5LYR1jAeAbfosggGpo2kuZxXsTiDVxd+fB1gmx1+CbWBC7p7G26uju2Yl0PW2D+JiqtSqkOvap0m2F3RSPx59bFpPXiS7D5gPM9LTewYIbIFWN4aYak5bA1hfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=D31tcYJ4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a366843fa6so3904978f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747956380; x=1748561180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnCGsMvvb/sl+WABzO40apajVfbKrxsfIXszsES8O4k=;
        b=D31tcYJ4vz80+6Xp1MDFau3bAquLRfg9Opk0b1kItM7H0P3MpZ7SxQnwvmhhoLQRmn
         hzBAZn8ExBzIkVe7aT3dFJcG0DLyK7/yzPD3rn/pvvuRaNr7K6RpgWQO+ergwYvSvpbT
         btL+Inf1cLEBN9WcXnWqRS4Aeb/2b37QSQsK9h8K4cz7SUkRmRqn4K3qA3lEX9FwP9Z5
         G+25/TwCo9a5rickimq61teUtgu8TNiJ5iB6ukUPRrYQ3jVmvY3WXBWomw/5yq/+o9W3
         w4PeS2CQdLOLRDce1V1HrF40xibDBQaU2UeUXLc4DmyAMFz9Zw2lBptTQvfbEqPidl7l
         1xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956380; x=1748561180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnCGsMvvb/sl+WABzO40apajVfbKrxsfIXszsES8O4k=;
        b=Sfd9lzpjdqbBu2EbUwaEixm+wqNRPppPiP0N+Wl9mii/Prgtzwo7GyA7uO6vUuPa2t
         Q4SPdvKqW5Pm83Pyl8sUcFh7Mw2I/dP6HPVx5YbUQtmrGGZSLL+spndxszK0s+hMgtbH
         hRlkKBeuhwQBUrGFzPbsXmtBNfKlYSIX4WBTI712e54HiOZU+ynJXQtTrwWqD4YyhB2J
         qJQUUq8RytmQJWOPjXlbGMQDnE1xHqJLpRGJtbaXX9Js35hrTFQYqbT2TOis4W93cpbp
         4pS5feLgng5/12bShiBr2ZNvolBfHYL4NHoSY2HvKLDJ2rSQSf0XfmjSmhmhSecITJMI
         W5yA==
X-Forwarded-Encrypted: i=1; AJvYcCU9AXE+A6oMduDDGALWhuQtgBiUo9StCnzCQxTwj3XiiuNuP0RSPAE8QZekhRAOVq7sfnCpulmy+dLVqfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TVMuUcHEeEZ3UITBpd547kjutj8B/cKJTq0kGxuFjJCbBB7R
	TKYL5RykvmswZzzCJ6HIjCL6oEGpN4smIPTuh4CTezc5WA7BkBDBqN2kM9bRV+kY2gE=
X-Gm-Gg: ASbGncvmh3xzVdUyZwmLgmuzn/zDWdHNKERM2k9txq33aG9GOkWwcqNbhUoX5ha6QNu
	Dqsd877jqYi1mY97cR5T8v9jDl7xbrfsRI7QS56tlJKU37iJLfiInv+aAOydz5Ba2lbvZh/ZvPK
	iSa6lhT7wcO3Naqd0GP8JglidMDkcJOkP3AGGqZMeVltLbIPnROSGWsp+hHQygAR/J+dKLmqfm+
	Ei5FmC39GinDRlXcunX8fyowhNT40926lME2d4IvxkLrZfqVc1ienasjKiErXPflJnBgd8gCDPZ
	XrWANW/ZTt1Z2Bou8dHPG1fSHtfDX8bTDPz09Xm7y9PbIc+MNr7raw==
X-Google-Smtp-Source: AGHT+IEAPIcFtYM4Tgsv9MlTn3dUZjmgON/3+kE5HDdsMMPWIynQV0odP8gmbR56f/uO+RLDFOXOwg==
X-Received: by 2002:a05:6000:178e:b0:3a0:b53a:bc06 with SMTP id ffacd0b85a97d-3a35fe5ba93mr22446826f8f.1.1747956380256;
        Thu, 22 May 2025 16:26:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a02:c7c:75ac:6300:c05a:35d:17ae:e731])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f04334sm117825395e9.10.2025.05.22.16.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 16:26:20 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Fri, 23 May 2025 00:25:10 +0100
Subject: [PATCH v3 4/7] riscv: pmu: Add infrastructure for Control Transfer
 Record
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-b4-ctr_upstream_v3-v3-4-ad355304ba1c@rivosinc.com>
References: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
In-Reply-To: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beeman Strong <beeman@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, Rajnesh Kanwal <rkanwal@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747956375; l=7051;
 i=rkanwal@rivosinc.com; s=20250522; h=from:subject:message-id;
 bh=HQlCiM1VZsjqb/niITpfgq1gwhQMuUn578fiz8Bl7N0=;
 b=44dyGW9sGFwk6vSzLsN7JNhG+rcehhGCISKRHtl7qiGT06vranNGoHavClp+64Oe2FooG8+aB
 hbd7PyOu11+Czw/bzOTiH4SgSmzUPxsOl2iTVI1jEeuNb2pSNEE6Q78
X-Developer-Key: i=rkanwal@rivosinc.com; a=ed25519;
 pk=aw8nvncslGKHEmTBTJqvkP/4tj6pijL8fwRRym/GuS8=

To support Control Transfer Records (CTR) extension, we need to extend the
riscv_pmu framework with some basic infrastructure for branch stack
sampling. Subsequent patches will use this to add support for CTR in the
riscv_pmu_dev driver.

With CTR, the branches are stored into a hardware FIFO, which will be
sampled by software when perf events overflow. A task may be
context-switched between overflows, and to avoid leaking samples we need
to clear the last task's records when a task is context-switched in.
To do this we will be using the pmu::sched_task() callback added in this
patch.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 drivers/perf/riscv_pmu_common.c | 22 ++++++++++++++++++++++
 drivers/perf/riscv_pmu_dev.c    | 17 +++++++++++++++++
 drivers/perf/riscv_pmu_legacy.c |  2 ++
 include/linux/perf/riscv_pmu.h  | 18 ++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/drivers/perf/riscv_pmu_common.c b/drivers/perf/riscv_pmu_common.c
index 7644147d50b46a79f349d6cb7e32554cc9a39a74..b2dc78cbbb93926964f81f30be9ef4a1c02501df 100644
--- a/drivers/perf/riscv_pmu_common.c
+++ b/drivers/perf/riscv_pmu_common.c
@@ -157,6 +157,19 @@ u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
 	return GENMASK_ULL(cwidth, 0);
 }
 
+static void riscv_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+				 bool sched_in)
+{
+	struct riscv_pmu *pmu;
+
+	if (!pmu_ctx)
+		return;
+
+	pmu = to_riscv_pmu(pmu_ctx->pmu);
+	if (pmu->sched_task)
+		pmu->sched_task(pmu_ctx, sched_in);
+}
+
 u64 riscv_pmu_event_update(struct perf_event *event)
 {
 	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
@@ -269,6 +282,8 @@ static int riscv_pmu_add(struct perf_event *event, int flags)
 	cpuc->events[idx] = event;
 	cpuc->n_events++;
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+	if (rvpmu->ctr_add)
+		rvpmu->ctr_add(event, flags);
 	if (flags & PERF_EF_START)
 		riscv_pmu_start(event, PERF_EF_RELOAD);
 
@@ -290,8 +305,13 @@ static void riscv_pmu_del(struct perf_event *event, int flags)
 	if (rvpmu->ctr_stop)
 		rvpmu->ctr_stop(event, RISCV_PMU_STOP_FLAG_RESET);
 	cpuc->n_events--;
+
+	if (rvpmu->ctr_del)
+		rvpmu->ctr_del(event, flags);
+
 	if (rvpmu->ctr_clear_idx)
 		rvpmu->ctr_clear_idx(event);
+
 	perf_event_update_userpage(event);
 	hwc->idx = -1;
 }
@@ -402,6 +422,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
 	for_each_possible_cpu(cpuid) {
 		cpuc = per_cpu_ptr(pmu->hw_events, cpuid);
 		cpuc->n_events = 0;
+		cpuc->ctr_users = 0;
 		for (i = 0; i < RISCV_MAX_COUNTERS; i++)
 			cpuc->events[i] = NULL;
 		cpuc->snapshot_addr = NULL;
@@ -416,6 +437,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
 		.start		= riscv_pmu_start,
 		.stop		= riscv_pmu_stop,
 		.read		= riscv_pmu_read,
+		.sched_task	= riscv_pmu_sched_task,
 	};
 
 	return pmu;
diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index cd2ac4cf34f12618a2df1895f1fab8522016d325..95e6dd272db69f53b679e5fc3450785e45d5e8b9 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -1035,6 +1035,12 @@ static void rvpmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
 	}
 }
 
+static void pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
+			   bool sched_in)
+{
+	/* Call CTR specific Sched hook. */
+}
+
 static int rvpmu_sbi_find_num_ctrs(void)
 {
 	struct sbiret ret;
@@ -1561,6 +1567,14 @@ static int rvpmu_deleg_ctr_get_idx(struct perf_event *event)
 	return -ENOENT;
 }
 
+static void rvpmu_ctr_add(struct perf_event *event, int flags)
+{
+}
+
+static void rvpmu_ctr_del(struct perf_event *event, int flags)
+{
+}
+
 static void rvpmu_ctr_start(struct perf_event *event, u64 ival)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -1979,6 +1993,8 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 	else
 		pmu->pmu.attr_groups = riscv_sbi_pmu_attr_groups;
 	pmu->cmask = cmask;
+	pmu->ctr_add = rvpmu_ctr_add;
+	pmu->ctr_del = rvpmu_ctr_del;
 	pmu->ctr_start = rvpmu_ctr_start;
 	pmu->ctr_stop = rvpmu_ctr_stop;
 	pmu->event_map = rvpmu_event_map;
@@ -1990,6 +2006,7 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 	pmu->event_mapped = rvpmu_event_mapped;
 	pmu->event_unmapped = rvpmu_event_unmapped;
 	pmu->csr_index = rvpmu_csr_index;
+	pmu->sched_task = pmu_sched_task;
 
 	ret = riscv_pm_pmu_register(pmu);
 	if (ret)
diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index 93c8e0fdb5898587e89115c10587d69380da19ec..bee6742d35fa54a9b82d4a4842b481efaa226765 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -115,6 +115,8 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
 		BIT(RISCV_PMU_LEGACY_INSTRET);
 	pmu->ctr_start = pmu_legacy_ctr_start;
 	pmu->ctr_stop = NULL;
+	pmu->ctr_add = NULL;
+	pmu->ctr_del = NULL;
 	pmu->event_map = pmu_legacy_event_map;
 	pmu->ctr_get_idx = pmu_legacy_ctr_get_idx;
 	pmu->ctr_get_width = pmu_legacy_ctr_get_width;
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index e58f8381198849ea6134a46e894d91064a1a6154..883781f12ae0be93d8292ae1a7e7b03fea3ea955 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -46,6 +46,13 @@
 	},								\
 }
 
+#define MAX_BRANCH_RECORDS 256
+
+struct branch_records {
+	struct perf_branch_stack branch_stack;
+	struct perf_branch_entry branch_entries[MAX_BRANCH_RECORDS];
+};
+
 struct cpu_hw_events {
 	/* currently enabled events */
 	int			n_events;
@@ -65,6 +72,12 @@ struct cpu_hw_events {
 	bool snapshot_set_done;
 	/* A shadow copy of the counter values to avoid clobbering during multiple SBI calls */
 	u64 snapshot_cval_shcopy[RISCV_MAX_COUNTERS];
+
+	/* Saved branch records. */
+	struct branch_records *branches;
+
+	/* Active events requesting branch records */
+	int ctr_users;
 };
 
 struct riscv_pmu {
@@ -78,6 +91,8 @@ struct riscv_pmu {
 	int		(*ctr_get_idx)(struct perf_event *event);
 	int		(*ctr_get_width)(int idx);
 	void		(*ctr_clear_idx)(struct perf_event *event);
+	void		(*ctr_add)(struct perf_event *event, int flags);
+	void		(*ctr_del)(struct perf_event *event, int flags);
 	void		(*ctr_start)(struct perf_event *event, u64 init_val);
 	void		(*ctr_stop)(struct perf_event *event, unsigned long flag);
 	int		(*event_map)(struct perf_event *event, u64 *config);
@@ -85,10 +100,13 @@ struct riscv_pmu {
 	void		(*event_mapped)(struct perf_event *event, struct mm_struct *mm);
 	void		(*event_unmapped)(struct perf_event *event, struct mm_struct *mm);
 	uint8_t		(*csr_index)(struct perf_event *event);
+	void		(*sched_task)(struct perf_event_pmu_context *ctx, bool sched_in);
 
 	struct cpu_hw_events	__percpu *hw_events;
 	struct hlist_node	node;
 	struct notifier_block   riscv_pm_nb;
+
+	unsigned int ctr_depth;
 };
 
 #define to_riscv_pmu(p) (container_of(p, struct riscv_pmu, pmu))

-- 
2.43.0


