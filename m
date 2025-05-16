Return-Path: <linux-kernel+bounces-651770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44745ABA2D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 20:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2683EA24D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA2280321;
	Fri, 16 May 2025 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+sNjhe1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A5127FD5D;
	Fri, 16 May 2025 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420168; cv=none; b=MRSeEXiAakOUUxw520ujXfdPjO7UuqQO5uFfO5X73gfrO0XD1l8yI4u7laBGh7M2TWYQSA27lOD8V7ZwUnSe1esPqZ6vFkT/rGt22COX9cG9lJVrtcBs3HcUGJX34XZzcKuHip0tRMRdsJcScR27rkzR90x2oBS7UoMB50HMRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420168; c=relaxed/simple;
	bh=h551J25h8XFy68PU1OOtFou2mqDGDS+8kG2qd49H3XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUsQ/qRIjsb9LpnQLgLqDALL4CcEu5TpQOPwX/jfYqa3TQj0TXajsS5s0q+j5QzLw1DA6dFrCxWDaiwRhxKXCbbjjJwre6MGf0BGqvyyUWKvuMgv0gQSYQHq1nWI8jkNAFMK8CetSnFwFEKt4oBaZkutr3RiDTVhMBHvjaOeMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+sNjhe1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420166; x=1778956166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h551J25h8XFy68PU1OOtFou2mqDGDS+8kG2qd49H3XQ=;
  b=g+sNjhe1vxSbWmeMwqTvvD4Xkez4rbYBKPraduon+bd2AoXHK7G4z+Xf
   DgT8UZZJgnfb+JCtKFkHvpn83MW0XCZ6Hbnybt0Tg1RxXwInPkZDa+1xv
   1HAfOjD4jwTLP/BRcbISbTZxcGmP4WMhEPM9e9sWFTHdzDKzy4sxb4Pdt
   dlEnjPLWyywKiVJ83YuRUcWSsFUcFJJS0PRliJSwUEBuwmiY3Z45VQTCd
   3op0H2Y8k2A87FWKSOKLS1IcTFhkdIKzGYo1TZdE3SmSuj0o+YKix7N7p
   q+7zm+9sqY/QY8m5i94puTGmFyQGA4DDJrewfBQDt+G0lsiCZ2G4NkzMx
   w==;
X-CSE-ConnectionGUID: m2uGIzIfTk6jslczo1OrtA==
X-CSE-MsgGUID: qyPTBzewRFWIDeY9Pfrjbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328850"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328850"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:23 -0700
X-CSE-ConnectionGUID: YpKgUdNOSKafc5QR5vOhTw==
X-CSE-MsgGUID: 0OYYXZ76RIKEXecUK816yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802613"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:22 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH V3 08/16] perf/arm: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:45 -0700
Message-Id: <20250516182853.2610284-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250516182853.2610284-1-kan.liang@linux.intel.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring (Arm) <robh@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_pmuv3.c      | 3 +--
 drivers/perf/arm_v6_pmu.c     | 3 +--
 drivers/perf/arm_v7_pmu.c     | 3 +--
 drivers/perf/arm_xscale_pmu.c | 6 ++----
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index e506d59654e7..3db9f4ed17e8 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -887,8 +887,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		 * an irq_work which will be taken care of in the handling of
 		 * IPI_IRQ_WORK.
 		 */
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 	armv8pmu_start(cpu_pmu);
 
diff --git a/drivers/perf/arm_v6_pmu.c b/drivers/perf/arm_v6_pmu.c
index b09615bb2bb2..7cb12c8e06c7 100644
--- a/drivers/perf/arm_v6_pmu.c
+++ b/drivers/perf/arm_v6_pmu.c
@@ -276,8 +276,7 @@ armv6pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
diff --git a/drivers/perf/arm_v7_pmu.c b/drivers/perf/arm_v7_pmu.c
index 17831e1920bd..a1e438101114 100644
--- a/drivers/perf/arm_v7_pmu.c
+++ b/drivers/perf/arm_v7_pmu.c
@@ -930,8 +930,7 @@ static irqreturn_t armv7pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
diff --git a/drivers/perf/arm_xscale_pmu.c b/drivers/perf/arm_xscale_pmu.c
index 638fea9b1263..c2ac41dd9e19 100644
--- a/drivers/perf/arm_xscale_pmu.c
+++ b/drivers/perf/arm_xscale_pmu.c
@@ -186,8 +186,7 @@ xscale1pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	irq_work_run();
@@ -519,8 +518,7 @@ xscale2pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	irq_work_run();
-- 
2.38.1


