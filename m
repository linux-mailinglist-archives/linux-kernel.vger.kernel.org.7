Return-Path: <linux-kernel+bounces-771470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55381B287B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6BD14E1904
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C1D26059E;
	Fri, 15 Aug 2025 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwFiHrZU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A525A2C4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293748; cv=none; b=UYK0iAH/nVcUC/AAiwrvOYwI7qyX6kYVM0Vr0htnBbbYDfMn/HS0YgZPctfNc7zL6PpD1Wf5tp8+H7XYHwoJ8Th3C3fWG2tD6iqv77/mWbkoVgEBTAoyOzleb6YmF3X3uMXA7I/5jJX0nZouBPev15f0uLWHQGtd4jpjP4o8tIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293748; c=relaxed/simple;
	bh=ilZZDLKFtvjxpxoBhhniohVxQ7x9krgeaddVpbJsspM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sipwnUBDJHMFZahnZMVpydUnbQroZncWdVAA6vY3ZmCqWVxs1ZzSQN8so/Y9A6UxDZ2QA6sw/Eg75o8mBkUufLfDZ3ipFsRMCcc4K7CkBkrx5IrizE6toSHPbM67oIesKvipk/emb96X3nTFyREB3GfJq/r9pKt1yD12V+RCHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwFiHrZU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293747; x=1786829747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ilZZDLKFtvjxpxoBhhniohVxQ7x9krgeaddVpbJsspM=;
  b=QwFiHrZUy35tlZvHfiJ1OXVzPCJ8rWKyrK18rwGcAl8mqRdNeC7IeA5S
   3ST1Az9mw4Cwn2sTmNAsD+Lo6Xk7WZ/w1ZBxU+8Lu6vQtzGGFDdkmqGF3
   QkzyBRYH6IMMNPrSOInckZFCzAEk6RCAUHP7ZVPOl2m7gzWwTEId/Otti
   R8ynvCF1ddKUSfTMlIH7XlDmCuKNkBTA510S3nzezwyyk6r9Apfxyfyug
   Fui5UK8ZmVLJTr1nmDgwm93nepYhINoG63I1V0Olw72AThloFO4m+Onl0
   sG7JACazefgVKc+4vm5C9TWSEajmV717xB8XSTb4qCw+tY0GqvO9tYYtC
   w==;
X-CSE-ConnectionGUID: r0f6a4NXQriBNhtdmIs6YQ==
X-CSE-MsgGUID: +ctSlu5eRDmuZingnXWbVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707362"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707362"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:45 -0700
X-CSE-ConnectionGUID: kOxS3FTYTzWG+txuTn9ZSg==
X-CSE-MsgGUID: KqKz784DRy2CtXob8CBayA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319577"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:35:45 -0700
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
Subject: [PATCH V3 01/17] perf/x86: Use x86_perf_regs in the x86 nmi handler
Date: Fri, 15 Aug 2025 14:34:19 -0700
Message-Id: <20250815213435.1702022-2-kan.liang@linux.intel.com>
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

More and more regs will be supported in the overflow, e.g., more vector
registers, SSP, etc. The generic pt_regs struct cannot store all of
them. Use a X86 specific x86_perf_regs instead.

The struct pt_regs *regs is still passed to x86_pmu_handle_irq(). There
is no functional change for the existing code.

AMD IBS's NMI handler doesn't utilize the static call
x86_pmu_handle_irq(). The x86_perf_regs struct doesn't apply to the AMD
IBS. It can be added separately later when AMD IBS supports more regs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7610f26dfbd9..64a7a8aa2e38 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1752,6 +1752,7 @@ void perf_events_lapic_init(void)
 static int
 perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 {
+	struct x86_perf_regs x86_regs;
 	u64 start_clock;
 	u64 finish_clock;
 	int ret;
@@ -1764,7 +1765,8 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = static_call(x86_pmu_handle_irq)(regs);
+	x86_regs.regs = *regs;
+	ret = static_call(x86_pmu_handle_irq)(&x86_regs.regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
-- 
2.38.1


