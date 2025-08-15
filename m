Return-Path: <linux-kernel+bounces-771483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF361B287D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2109DAC0098
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB8630F54D;
	Fri, 15 Aug 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJnxo00t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E793090F5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293756; cv=none; b=BmCNHRm8M+Sumw40vi7S+muran2s5lJXMwxrlOFmo44QaqZPzSBeSlgx/ony0j0K4+IOGy5tWjFSt/i/7DRS0IdmDJkEsiL2Uu1YsTK7LphWCio9sPThYoanzjW92powz9kB7Doq9e+zCszrES6SCogL3PcqMc7M8gzwIFgGL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293756; c=relaxed/simple;
	bh=LhzVdwsZBUx/g6yYRHBqACDVKMw4oc5Q0hwku9mvBbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtpfqofXJfHuhtsavVTiAnpxa93QI9am7Yf713yXaN55k6vbxdTK2MzVpuim1tNh2tLrmNeuIH3SNeOwgy3+a/5MGVuAjpGWfEzWZgiYL9o85v98WPd4Gei2gu2bi22/PAOK6ev9+fSU1+eThtjQkTqZCLn2YGjqkIrhV+rBrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJnxo00t; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293755; x=1786829755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LhzVdwsZBUx/g6yYRHBqACDVKMw4oc5Q0hwku9mvBbI=;
  b=NJnxo00tn9jyZ2Y+aEAgc/GRwfFXBBS1XGNqak5LbP8c16/MtONPJxkV
   CKH663EL7AtFjKJD9ZgT5nmIXUrd6l35YTfdXEO8DXvcUS9WHEBq1A2xY
   o+RF6Qn8iRzq8/7nMbK5cW3BZIvkHSr3zvdhXlyRkGIoZpjS8i8Z5E26Z
   vYnX+1qJ/v82qQS3eR52peyFfy4JnhDI4jkX+CpmVXe5w8N9MRc7Jtkd8
   ozMJ3912n/CklpxMu5fMcLsl0HdyIPY/iQEb+GoOXIuGvvAPdqSkob2i7
   iETxYPxqsFDrxJEpVZ5ZttIL+yp/ZnyWjLvvLFzeW//VMoyIJJI4EMkzl
   g==;
X-CSE-ConnectionGUID: 1fAi0ZdOT7qAqqhPJXH07A==
X-CSE-MsgGUID: goPDCqSTQBuJcrglQx9BiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707467"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707467"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:47 -0700
X-CSE-ConnectionGUID: i86zaBbSTBqHF6mU9C0KsQ==
X-CSE-MsgGUID: bFNnfVn7S4KUuaTFbPwqRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319624"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:35:48 -0700
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
Subject: [POC PATCH 14/17] perf/x86/regs: Only support legacy regs for the PT and PERF_REGS_MASK for now
Date: Fri, 15 Aug 2025 14:34:32 -0700
Message-Id: <20250815213435.1702022-15-kan.liang@linux.intel.com>
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

The PERF_REG_X86_64_MAX is going to be updated to support more regs,
e.g., eGPRs.
However, the PT and PERF_REGS_MASK will not be touched in the POC.
Using the PERF_REG_X86_R15 + 1 to replace PERF_REG_X86_64_MAX.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/include/perf_regs.h | 2 +-
 tools/perf/util/intel-pt.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index f209ce2c1dd9..793fb597b03f 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -17,7 +17,7 @@ void perf_regs_load(u64 *regs);
 		       (1ULL << PERF_REG_X86_ES) | \
 		       (1ULL << PERF_REG_X86_FS) | \
 		       (1ULL << PERF_REG_X86_GS))
-#define PERF_REGS_MASK (((1ULL << PERF_REG_X86_64_MAX) - 1) & ~REG_NOSUPPORT)
+#define PERF_REGS_MASK (((1ULL << (PERF_REG_X86_R15 + 1)) - 1) & ~REG_NOSUPPORT)
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_64
 #endif
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 9b1011fe4826..a9585524f2e1 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2181,7 +2181,7 @@ static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
 	u32 bit;
 	int i;
 
-	for (i = 0, bit = 1; i < PERF_REG_X86_64_MAX; i++, bit <<= 1) {
+	for (i = 0, bit = 1; i < PERF_REG_X86_R15 + 1; i++, bit <<= 1) {
 		/* Get the PEBS gp_regs array index */
 		int n = pebs_gp_regs[i] - 1;
 
-- 
2.38.1


