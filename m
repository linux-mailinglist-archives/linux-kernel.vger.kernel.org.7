Return-Path: <linux-kernel+bounces-771471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DD0B287BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491531D051A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B3272E4E;
	Fri, 15 Aug 2025 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Op1Q0zA9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527E25B687
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293749; cv=none; b=RKBbBVB1IqDwG7oEutxl7hbkQL3JFHD8UukO7kkvsR5le85LWOgm4sOXGjBcxmebyBMAt16kFimCiMJjTvEgToFPoVjtu7EXCyHGC36v2UApL6kxrzwhyCQwGh8jI9wCMSU8KV4cbLBxEstO4lhKcjJ7eDBoJdAFTBUsUiukRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293749; c=relaxed/simple;
	bh=jiUU/CO/dIeSSSoaGHlhX1BWyie8LcKytE6z9fFLDBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xim7ANP4Ff42JIwogfr56FqowMpG7yEkF0j5/JuWe70cHy6SE5osjZVv8JBhEJoypFSKLA/8x9KjxwkRfjlds00EUFfpRo/lJCIvZss0fHw82a/0PICDO2KQAjvfEaywOKEBjMQ0lnZMKmwik1yez2ZtYn5IuEQOp3gQkm+B/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Op1Q0zA9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293748; x=1786829748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jiUU/CO/dIeSSSoaGHlhX1BWyie8LcKytE6z9fFLDBo=;
  b=Op1Q0zA9E4sMohziGdpRoT9cHS16GBEYXDveheGB7P6B0qPzGtI6SV2W
   1GQ/bGcbXUyEFd7UXUO3qNlL1MtzUbfaC4aFABLVkLxXc0A+yzxBZ4Ety
   rJxRqi7gztvsn6sYcbxKz9gnoKsgKtDX34wF8trR0lLVSzBdr4FMzyCDW
   +6uAvhl8UsuDb2al9PE+YPO/3EnEELkJ9cub0EcvQ/iY2BEyYt0/v6mi2
   IzPlS2XOiHtAO8J3TCCEL/RvkxBIQfPltaSO3BQ+wX2Sstkwc4hiEc1Pr
   SHDuCNBgorOT4R+GJ06mLuEIC750cvqBfd628o0BjYod1LGzokMSEUJ2K
   A==;
X-CSE-ConnectionGUID: T5iajYg+Q1KFD/nhY2shag==
X-CSE-MsgGUID: KdKzDMtgQoqxetB400E/HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707370"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707370"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:45 -0700
X-CSE-ConnectionGUID: 9JtFepHNQLqqGoDuZssjgg==
X-CSE-MsgGUID: kf71pVFEQxWyoJcTQFTKJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319581"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:35:46 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	ak@linux.intel.com,
	zide.chen@intel.com,
	mark.rutland@arm.com,
	broonie@kernel.org,
	ravi.bangoria@amd.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 02/17] perf/x86: Setup the regs data
Date: Fri, 15 Aug 2025 14:34:20 -0700
Message-Id: <20250815213435.1702022-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250815213435.1702022-1-kan.liang@linux.intel.com>
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The current code relies on the generic code to setup the regs data.
It will not work well when there are more regs introduced.
Introduce a X86-specific x86_pmu_setup_regs_data().
Now, it's the same as the generic code. More X86-specific codes will be
added later when the new regs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 32 ++++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c   |  4 +++-
 arch/x86/events/perf_event.h |  4 ++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 64a7a8aa2e38..c601ad761534 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1685,6 +1685,38 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	static_call_cond(x86_pmu_del)(event);
 }
 
+void x86_pmu_setup_regs_data(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs)
+{
+	u64 sample_type = event->attr.sample_type;
+
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		if (user_mode(regs)) {
+			data->regs_user.abi = perf_reg_abi(current);
+			data->regs_user.regs = regs;
+		} else if (!(current->flags & PF_KTHREAD)) {
+			perf_get_regs_user(&data->regs_user, regs);
+		} else {
+			data->regs_user.abi = PERF_SAMPLE_REGS_ABI_NONE;
+			data->regs_user.regs = NULL;
+		}
+		data->dyn_size += sizeof(u64);
+		if (data->regs_user.regs)
+			data->dyn_size += hweight64(event->attr.sample_regs_user) * sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_REGS_USER;
+	}
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		data->regs_intr.regs = regs;
+		data->regs_intr.abi = perf_reg_abi(current);
+		data->dyn_size += sizeof(u64);
+		if (data->regs_intr.regs)
+			data->dyn_size += hweight64(event->attr.sample_regs_intr) * sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
+	}
+}
+
 int x86_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct perf_sample_data data;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1c7594..e67d8a03ddfe 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2126,8 +2126,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			regs->flags &= ~PERF_EFLAGS_EXACT;
 		}
 
-		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
+		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
 			adaptive_pebs_save_regs(regs, gprs);
+			x86_pmu_setup_regs_data(event, data, regs);
+		}
 	}
 
 	if (format_group & PEBS_DATACFG_MEMINFO) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2b969386dcdd..12682a059608 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1278,6 +1278,10 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
+void x86_pmu_setup_regs_data(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs);
+
 void x86_pmu_show_pmu_cap(struct pmu *pmu);
 
 static inline int x86_pmu_num_counters(struct pmu *pmu)
-- 
2.38.1


