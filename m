Return-Path: <linux-kernel+bounces-787337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C8CB374D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CF75E1318
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD5281525;
	Tue, 26 Aug 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b92LmRKk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA812797B8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756246809; cv=none; b=OzlEXzQlcygcBEmQXIZ8Ra3l0ccIIRI6cbEeLT/01aLWpyhmWVZlxakJK3kJf2+vROj7D1NwV63nZQh+wgOhjkExuGhdJ8dZdTSn39U8+cKnWLEtpQwqvUk26cq8jhxdtyVbI2cCattdJy8iSW0BH7xOaPpCRhT12ZJjBAg5w6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756246809; c=relaxed/simple;
	bh=4GpQvqXHYCab9d1HPIQ+7ZM7GXSEQvaRwbK9UkY0u0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osJwN8M2mwmwtFZ3VbzzC5vryTQy/Yh3nbLUC5teNR8iSHXJEydYJn3q6tO3XK84fJhC2Z+wmNZf+pvJy6XRMws/fcipWmctv7KdLHnBnYrtPN4qxhNLd+jXTeGghIT0BhvogLQhRxogCoqigA7Kuus/DfxXGKB2SN6NX+9sG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b92LmRKk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756246808; x=1787782808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4GpQvqXHYCab9d1HPIQ+7ZM7GXSEQvaRwbK9UkY0u0g=;
  b=b92LmRKkWTtutWqyagf8fRNOInahDzQMMaQBZqdKEJiPfgdQP3LHyUwI
   ImVJSxrWgollyoA/nZ1pWr3hHWKIU3LPrD2CShiiuNIti0GAPq9gIFLma
   ksRmXwlh4LEWd/PPFJlN9jTTJREr4YxVKynDFk1RNAY7UBaf7gGrix9At
   G5pMmj6xbbHembbTcyaTfSwvPHV5zfoaN13EniBLpytMFRDgIzy4cckfP
   xYNf5cCLOsceVYwiTAsg7XjzRGoFzyQgbYnSkvdtmWov+wrIXez29cEpS
   +ds8jss3ZEhHs57MYrOEd6QL1SC0EMri8KarScoj1jHCkxhyCs7IpjeLK
   Q==;
X-CSE-ConnectionGUID: i2fH9dN7S3SXlOxoXLw0qA==
X-CSE-MsgGUID: Eb0IZU/URV+e+X5+lt5s+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69865487"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69865487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 15:20:07 -0700
X-CSE-ConnectionGUID: d1VbmbGSTKe0T0XRGyNFpw==
X-CSE-MsgGUID: UEMnFxp9R1mT8vDFbjPcGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169195286"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 15:20:07 -0700
From: Zide Chen <zide.chen@intel.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	artem.bityutskiy@linux.intel.com,
	rui.zhang@intel.com,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH] perf/x86/intel/cstate: Add Clearwater Forest support
Date: Tue, 26 Aug 2025 15:14:18 -0700
Message-ID: <20250826221418.18954-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenyu Wang <zhenyuw.linux@gmail.com>

Clearwater Forest is based on the Darkmont Atom microarchitecture.
From the perspective of C-state residency profiling, it supports the
same residency counters as Sierra Forest: CC1/CC6, PC2/PC6, and MC6.

Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index ae4ec16156bb..028557210e23 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -627,6 +627,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&srf_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&grr_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	&srf_cstates),
 
 	X86_MATCH_VFM(INTEL_ICELAKE_L,		&icl_cstates),
 	X86_MATCH_VFM(INTEL_ICELAKE,		&icl_cstates),
-- 
2.34.1


