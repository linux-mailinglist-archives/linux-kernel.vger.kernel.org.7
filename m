Return-Path: <linux-kernel+bounces-771473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BC9B287BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFC47B6396
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0666329C35F;
	Fri, 15 Aug 2025 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHOw3uvv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85C25F7B5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293750; cv=none; b=SxPTP82UkkXSsT45Hgl14KfXhaMHzvg29qyNb3tCJ1cJic+h1mBOYTqkLjglr33ZDmKLaantWhytatETVME0WrG2QrS6Htway2BHRhJoOeVrLXh3LJjIPAPTczlPtPvCBUDXNnyI9KRPNHNyoR+MHJoJWsDN0WUV0ZKXXqmJ5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293750; c=relaxed/simple;
	bh=BnOLccNSR36i9lhzHqgvKp4kyeZTq6EoNER9hwWqf/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mD4IdIuW8gY93+BPAu1hbcgAP/yS4xWslUknd+jZIxkmFoy0z5uPgVLxtkqcg+UvLiuSMuPoG1NGeWQtujzk4IjCgePvccJ2ujcf4Se73dGXXzfEonfC09MPcnZsFAROMo9+/QAMxNouMsePrZVpTFgiWub/zgUYrZ6RRSPXEOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHOw3uvv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293749; x=1786829749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BnOLccNSR36i9lhzHqgvKp4kyeZTq6EoNER9hwWqf/c=;
  b=dHOw3uvvD3KoNOiy0GJ6jhs1O0WFPK7EokzgomPtO6GFMM2PK/eXTkqP
   yPM2DEcFOiG7njCGJUXmgAbVpLiquDwhDURbmjILbYuHKqMb6AxI+IEaR
   m6a/jFW6XRddFn3KnTmGnP1rATSBI2LgCwjpimXoZdf8CRMgwAbX6mlXE
   eSOlK0naP7J+ouOOwTQE/o5hWMhdaxwAxWmYq5p/lzBx9cVsQrCE/qB6/
   sFAsjcgdqsiaxi7PgaI0ikKGxxpmzk4SbmkkQ5SPqOCYFQ1XaMVrOb2rG
   2gc32MdPfUgoQcP6wxtXSN9R+6pcd7U9r+mfEL2LqYTMlH1PKf/L1TTfy
   A==;
X-CSE-ConnectionGUID: +uHpw3LPQCiW7+Gb6PbVDw==
X-CSE-MsgGUID: rY9xASAuRsi9aTOzDQQA1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707386"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707386"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:46 -0700
X-CSE-ConnectionGUID: qG9ii2WORjGsqV+e1+v0zw==
X-CSE-MsgGUID: 8fr4+kCvSB+GRCNq8obEQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319588"
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
Subject: [PATCH V3 04/17] perf: Move has_extended_regs() to header file
Date: Fri, 15 Aug 2025 14:34:22 -0700
Message-Id: <20250815213435.1702022-5-kan.liang@linux.intel.com>
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

The function will also be used in the ARCH-specific code.

Rename it to follow the naming rule of the existing functions.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h | 8 ++++++++
 kernel/events/core.c       | 8 +-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ec9d96025683..444b162f3f92 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1526,6 +1526,14 @@ perf_event__output_id_sample(struct perf_event *event,
 extern void
 perf_log_lost_samples(struct perf_event *event, u64 lost);
 
+static inline bool event_has_extended_regs(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	return (attr->sample_regs_user & PERF_REG_EXTENDED_MASK) ||
+	       (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK);
+}
+
 static inline bool event_has_any_exclude_flag(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0db36b2b2448..95a7b6f5af09 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12527,12 +12527,6 @@ int perf_pmu_unregister(struct pmu *pmu)
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
-static inline bool has_extended_regs(struct perf_event *event)
-{
-	return (event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK) ||
-	       (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK);
-}
-
 static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 {
 	struct perf_event_context *ctx = NULL;
@@ -12567,7 +12561,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		goto err_pmu;
 
 	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
-	    has_extended_regs(event)) {
+	    event_has_extended_regs(event)) {
 		ret = -EOPNOTSUPP;
 		goto err_destroy;
 	}
-- 
2.38.1


