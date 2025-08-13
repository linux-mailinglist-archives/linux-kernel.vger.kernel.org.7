Return-Path: <linux-kernel+bounces-767266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63627B25219
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B419F1C21D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ACC2868A5;
	Wed, 13 Aug 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhzNoXLe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039F7287247
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106028; cv=none; b=bQiXK626yCjbtkG+62xO1Kb3XV44b/a08I/hfSSzgQQ+ZhUywQgpDsjccFzhnWyNfqiuIr2JZgBqx96fkkje8W+VpDYlClqhNw0qmVeN8KTqTXB51qJU0LyLb8RT+3pLamsoX8OSR1FuKmv0JV1dX75+mGVtayOQ0LrNFj0xhPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106028; c=relaxed/simple;
	bh=YBtgJINRq9CWupVyEhQDXVWYVFuj92uvEpfEeIJvJww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdSPzI78DDsnEBEBQLKxiqUZLLyaHxoydzrUy1uaOaoNYmjD96RHEjRUCw5RR1Gvn7fjMf4v900xi5yd/y9MoXZ2LdRrLHeUUyWLMKPt6E58kHKkbTrfKlk90WppuopbmBDYvGvZ98xYCT6UgV6PmFWnjUgMmNmiAEHCGVBqGVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhzNoXLe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755106028; x=1786642028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YBtgJINRq9CWupVyEhQDXVWYVFuj92uvEpfEeIJvJww=;
  b=JhzNoXLeyOm4mEpcN4Ozt8u3jHDGRCAf8lEV1NpHsOXXBRgG16h5os3Q
   70vMzpHvfsSyFC+liv+lMLgBnoJLPnco9fLrHhz1HNgbnu7nOPe9pbr+5
   I7C6DcP9we+fXB8e7cN8tKcojvKG2htY7OEuIUBTLIwpHMgrl48vlPvF0
   LYNbhGU2XrMyahcyvG1fqypfxRyou0N/09ib0qbTqKzg+bJLrqDTMEQdG
   2ZGaejDUOWeVsWJYbFHX/7OREfi1AfH0IuBOFh5RDLVQY6k5TastKAN4R
   LivJpIxW+LzQ+jVxbYZdMc6fRlb7SWM4b9HqPGFojIoiW2R8dQbxoX2BB
   w==;
X-CSE-ConnectionGUID: OHXsCw4QQ+uS16sm0M18TQ==
X-CSE-MsgGUID: y/soZd0rRz6fLyTOKhLnCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61255205"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61255205"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:27:07 -0700
X-CSE-ConnectionGUID: JqHXX5nXTUu6lUSrNdDDRg==
X-CSE-MsgGUID: IMnTRMzIQOWqF5lPvpnIbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167329701"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.193])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2025 10:27:06 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] x86/microcode: Introduce staging step to reduce late-loading time
Date: Wed, 13 Aug 2025 10:26:44 -0700
Message-ID: <20250813172649.15474-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813172649.15474-1-chang.seok.bae@intel.com>
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As microcode patch sizes continue to grow, late-loading latency spikes
can lead to timeouts and disruptions in running workloads. This trend of
increasing patch sizes is expected to continue, so a foundational
solution is needed to address the issue.

To mitigate the problem, a new staging feature is introduced. This option
processes most of the microcode update (excluding activation) on a
non-critical path, allowing CPUs to remain operational during the
majority of the update. By offloading work from the critical path,
staging can significantly reduces latency spikes.

Integrate staging as a preparatory step in late-loading. Introduce a new
callback for staging, which is invoked at the beginning of
load_late_stop_cpus(), before CPUs enter the rendezvous phase.

Staging follows an opportunistic model:

  *  If successful, it reduces CPU rendezvous time
  *  Even though it fails, the process falls back to the legacy path to
     finish the loading process but with potentially higher latency.

Extend struct microcode_ops to incorporate staging properties, which will
be implemented in the vendor code separately.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
---
There were discussions about whether staging success should be enforced
by a configurable option. That topic is identified as follow-up work,
separate from this series.
    https://lore.kernel.org/lkml/54308373-7867-4b76-be34-63730953f83c@intel.com/

V1 -> V2:
* Move invocation inside of load_late_stop_cpus() (Boris)
* Add more note about staging (Dave)
---
 arch/x86/kernel/cpu/microcode/core.c     | 11 +++++++++++
 arch/x86/kernel/cpu/microcode/internal.h |  4 +++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b92e09a87c69..34e569ee1db2 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -552,6 +552,17 @@ static int load_late_stop_cpus(bool is_safe)
 		pr_err("You should switch to early loading, if possible.\n");
 	}
 
+	/*
+	 * Pre-load the microcode image into a staging device. This
+	 * process is preemptible and does not require stopping CPUs.
+	 * Successful staging simplifies the subsequent late-loading
+	 * process, reducing rendezvous time.
+	 *
+	 * Even if the transfer fails, the update will proceed as usual.
+	 */
+	if (microcode_ops->use_staging)
+		microcode_ops->stage_microcode();
+
 	atomic_set(&late_cpus_in, num_online_cpus());
 	atomic_set(&offline_in_nmi, 0);
 	loops_per_usec = loops_per_jiffy / (TICK_NSEC / 1000);
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 50a9702ae4e2..adf02ebbf7a3 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -31,10 +31,12 @@ struct microcode_ops {
 	 * See also the "Synchronization" section in microcode_core.c.
 	 */
 	enum ucode_state	(*apply_microcode)(int cpu);
+	void			(*stage_microcode)(void);
 	int			(*collect_cpu_info)(int cpu, struct cpu_signature *csig);
 	void			(*finalize_late_load)(int result);
 	unsigned int		nmi_safe	: 1,
-				use_nmi		: 1;
+				use_nmi		: 1,
+				use_staging	: 1;
 };
 
 struct early_load_data {
-- 
2.48.1


