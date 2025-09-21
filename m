Return-Path: <linux-kernel+bounces-826453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1085DB8E92E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BBB178C4D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3AF2D130B;
	Sun, 21 Sep 2025 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cE5idx3n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28D25484D
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494928; cv=none; b=MYKtN8NM26rfiC9PZUKp881X7/TK7sz7e6aBrxZsWZhbKeAZNHsvpQs1dZVriFrV55hJg9ttSnptvrtWgpN4OvTdIJWD4gu9GFtMHBlyqVXJk8XB4flyafSWMjXea9aMJZOPXzvzGVHwbHsW8K67I110MyLu6RtxPJd5WSj6SB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494928; c=relaxed/simple;
	bh=pOVrhhQ6mK/M6vDmsI2cf95vb7d/hkxxWKX35sOaY50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKhk6IwCKK9is5yyTRqrB6HGFI0+hUN4cnT8Mj0I+w+UkQCiTr6rbqAHV/P9sO3YsCERfEraBN5XIdE6ZI5h6owC/NvzRP5Pz5rsj2HJv96pRWY08kqj2Hv6DicOuyQFjlckjSm8uRCiIKhDz4CLanHF24bW1E9ByLlr+Bsdl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cE5idx3n; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758494928; x=1790030928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pOVrhhQ6mK/M6vDmsI2cf95vb7d/hkxxWKX35sOaY50=;
  b=cE5idx3nYRE/g/aXXUKnU6Iby3wTk+H0X301qeZL36YqW/OGlUqe/yDi
   olmAipMLirVhCeg1IpEaozh6lNWiUEWZby9r8hXYMewbx/xLaodx0Q6Qi
   maI5h12G68Ax0v1bHe72F91R4mjf2bJxGRi9sEXkmR/CqtlE84lnbnWeL
   UYezq0YqMFJfmVXVWX1VD0BWLxCsk1TvcTWuOKIQ47WfpUDtppa6WnWta
   TvH/3yH1m2l3uWzE8uO6UQHiRqgvMtUwnAYFJVZnWxDdiYOram/qAFKlj
   xJ7VOEN8E17zXjei9LZK7fAJiDYhySyL3sBxegGA9eqGBU7zDuIPNGdOM
   g==;
X-CSE-ConnectionGUID: GprjOVFoSj65xdEnB6Ylzw==
X-CSE-MsgGUID: W8kaiCXGRcuvz5Te8TDCtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64562342"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64562342"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 15:48:47 -0700
X-CSE-ConnectionGUID: KnVV7BDrRnutGHR0jwdRbA==
X-CSE-MsgGUID: B2BXw2pqR2eTyqjGMdvybg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="177129787"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 15:48:46 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	tony.luck@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v6 2/7] x86/microcode: Introduce staging step to reduce late-loading time
Date: Sun, 21 Sep 2025 15:48:36 -0700
Message-ID: <20250921224841.3545-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250921224841.3545-1-chang.seok.bae@intel.com>
References: <20250921224841.3545-1-chang.seok.bae@intel.com>
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
staging can significantly reduce latency spikes.

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
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
V5 -> V6:
* Fix typo in changelog: reduces -> reduce (Boris)
* Collect Tony's review tag

V4 -> V5:
* Collect Chao's review tag

V1 -> V2:
* Move invocation inside of load_late_stop_cpus() (Boris)
* Add more note about staging (Dave)

There were discussions about whether staging success should be enforced
by a configurable option. That topic is identified as follow-up work,
separate from this series.
    https://lore.kernel.org/lkml/54308373-7867-4b76-be34-63730953f83c@intel.com/
---
 arch/x86/kernel/cpu/microcode/core.c     | 11 +++++++++++
 arch/x86/kernel/cpu/microcode/internal.h |  4 +++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index f75c140906d0..d7baec8ec0b4 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -589,6 +589,17 @@ static int load_late_stop_cpus(bool is_safe)
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
index ae8dbc2b908d..a10b547eda1e 100644
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


