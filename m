Return-Path: <linux-kernel+bounces-783130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B9AB329DF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BAF171EF1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14F12E92C0;
	Sat, 23 Aug 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1Xs3BMr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C52222CA
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964343; cv=none; b=sFxbNyXlSDSF9k8FwnglR+j459JiFGo5HhetBp3udqYZDBha5P15c78hqWz7fj71/tuD2WVLMIaBSwc9TV6jr+Zm/70w0/q6EhDJiMWNt4y+SNh6HoT19D0anm0xHjHjuALGeHyOSHqr7P3ag3f/Ni6vCODsyx81LGEVowZI5xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964343; c=relaxed/simple;
	bh=L97mc+FM3e6R49U9cy769SVCezMA7UhyhVjow4A4W7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGA1HG+n7dBvhpDS7RW55vG8vgCnQguCV4jwpM8ugMst04uIi4PwCtAc04PZDV/zuFupJFlt+VJGJ/iVHKbutLyXtAzY2br5eacrnEMXN4K+iKt9NXJlXmrgVTh/n5diyamhiGUSWZuvx7jmyF49hv/IS5wgfFdNfJmpfRAfQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1Xs3BMr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755964342; x=1787500342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L97mc+FM3e6R49U9cy769SVCezMA7UhyhVjow4A4W7g=;
  b=S1Xs3BMr+vwXcTUIYnjmsCIly2Xbn0xfuicGyelv/vyl9FIfXMvtyVsz
   FjnikTYmDJZ0Yk9fyeQpl/N2assOnbgUVVlRkQf553OMbEG3+/HLtObr/
   XH/S3YyVQhxhbfEBHQfy8SbCRqRSFO7mlU+Z4O+jslkf2CAuylifVl2bT
   11lwNsa+g2J75uSaFLNAjuPbTxGxhGjKrzu9r8Q7P0mCs3N2MwcRYgQwj
   PNy4e/gFqoq3IcNoCPKXlieAAL1V6MlZVVlHsBx/U/Ac9AyUtTOc1lLv4
   RWTTd+J3dg8NtOPOvBVVXoAHtmLjLvxSXQqp5T7BewjywZ/cddJeuNiv4
   g==;
X-CSE-ConnectionGUID: OvPMYqK0QjyGVR71REH9wg==
X-CSE-MsgGUID: U29bAvHpQRCho3dI/nccCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="75832798"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75832798"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 08:52:20 -0700
X-CSE-ConnectionGUID: X/mmExHIRFmRqwUxaY6A8g==
X-CSE-MsgGUID: uRKG3OogTKKLdvPXRxun8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169748227"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.85.190])
  by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2025 08:52:20 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com
Subject: [PATCH v5 2/7] x86/microcode: Introduce staging step to reduce late-loading time
Date: Sat, 23 Aug 2025 08:52:05 -0700
Message-ID: <20250823155214.17465-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823155214.17465-1-chang.seok.bae@intel.com>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
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
Reviewed-by: Chao Gao <chao.gao@intel.com>
---
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


