Return-Path: <linux-kernel+bounces-838374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D0FBAF095
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503A1189BE03
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040D029B793;
	Wed,  1 Oct 2025 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+Obq61N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B7287519
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287318; cv=none; b=Qnm2TSf45vqmB9dxrN/FHqstrtW0RRiMtmWNCdRXlmfnfotlxXn+bx3keSMczhM/pqj/w5AcwWKlAtaer2Q8BoBT34TfQ+ba1p2C+v22Rdp7wcgXAjqul9OFPgnRdHJju3/Gn9JJc7F1OCYKXPxi5R2yf+jEv5n0nAXz/hMdh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287318; c=relaxed/simple;
	bh=ZqSLoqdV7WFix8gZ0ngNRZRoX6vNJSZh42f+sjIXDNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGAEHhOn1Muspw6TbO211fE9MX7ZVZMgoYuVHbF66Y0Dl9I5W7hWFchWSlE8aq+qdJ1Mm5AN3czVZtQ8GhMGODZH/9TBFmrIlzZq09iI3l3btSTfRAvEAu3iPks5O9CHV7C5s76cHZMc+uxD8qzzDkLS6sgxJi8Xts4i9U4/TVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+Obq61N; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287317; x=1790823317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZqSLoqdV7WFix8gZ0ngNRZRoX6vNJSZh42f+sjIXDNw=;
  b=c+Obq61Na/hzPTgALL8L7Q5LExehMZ17VBhHIWstS2tGs8Thv8vrOeLd
   zZ3tMO+PlCzH3K3WlLQnlSAkoTju0Au7o4NqSXTDYVB5ZPSNC6sFHTbp6
   uwbQBnQbRSZ/I87yYcqbZllCkq2NwNM2WoDvZKLqMmU1ruu9oGxDwWQ15
   fiUE6BadhUvVZ2JQd6+qBYj1NWG+fO4y6CUYmDGLFeLMz3HHckcOht8Lg
   x2DqcMxOdHPL1JxU26HVcQI5XkwMsGIDJQfF/q0cMM72qngW29cfzQyH5
   VWCEYV+MeFWsvxBr/ME9gJo/fRr+a63j2YCfk/OIWwORmWKJHXHjQ0IJS
   w==;
X-CSE-ConnectionGUID: gCdf14WoTn6iZxioAP+QJw==
X-CSE-MsgGUID: bAZdXM9pSea621Kye9MiTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662330"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662330"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:15 -0700
X-CSE-ConnectionGUID: Ddn54KrnSjavx3zX85ew4w==
X-CSE-MsgGUID: FmNWqG4UTr+snYAACtoH9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629181"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:14 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	reinette.chatre@intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	dan.j.williams@intel.com,
	yilun.xu@linux.intel.com,
	sagis@google.com,
	vannapurve@google.com,
	paulmck@kernel.org,
	nik.borisov@suse.com
Cc: Chao Gao <chao.gao@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 12/21] x86/virt/seamldr: Introduce skeleton for TDX Module updates
Date: Tue, 30 Sep 2025 19:52:56 -0700
Message-ID: <20251001025442.427697-13-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The P-SEAMLDR requires that no TDX Module SEAMCALLs are invoked during a
runtime TDX Module update.

But currently, TDX Module SEAMCALLs are invoked in various contexts and in
parallel across CPUs. Additionally, considering the need to force all vCPUs
out of guest mode, no single lock primitive, except for stop_machine(), can
meet this requirement.

Perform TDX Module updates within stop_machine() as it achieves the
P-SEAMLDR requirements and is an existing well understood mechanism.

TDX Module updates consist of several steps: shutting down the old
module, installing the new module, and initializing the new one and etc.
Some steps must be executed on a single CPU, others serially across all
CPUs, and some can be performed concurrently on all CPUs and there are
ordering requirements between steps. So, all CPUs need to perform the work
in a step-locked manner.

In preparation for adding concrete steps for TDX Module updates,
establish the framework by mimicking multi_cpu_stop(). Specifically, use a
global state machine to control the work done on each CPU and require all
CPUs to acknowledge completion before proceeding to the next stage.

Potential alternative to stop_machine()
=======================================
An alternative approach is to lock all KVM entry points and kick all
vCPUs.  Here, KVM entry points refer to KVM VM/vCPU ioctl entry points,
implemented in KVM common code (virt/kvm). Adding a locking mechanism
there would affect all architectures. And to lock only TDX vCPUs, new
logic would be needed to identify TDX vCPUs, which the common code
currently lacks. This would add significant complexity and maintenance
overhead for a TDX-specific use case.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
v2:
 - refine the changlog to follow context-problem-solution structure
 - move alternative discussions at the end of the changelog
 - add a comment about state machine transition
 - Move rcu_momentary_eqs() call to the else branch.
---
 arch/x86/virt/vmx/tdx/seamldr.c | 71 ++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 00a01acc15fd..b074630d42e3 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -11,7 +11,9 @@
 #include <linux/cpumask.h>
 #include <linux/irqflags.h>
 #include <linux/mm.h>
+#include <linux/nmi.h>
 #include <linux/slab.h>
+#include <linux/stop_machine.h>
 #include <linux/types.h>
 
 #include <asm/seamldr.h>
@@ -219,12 +221,75 @@ static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
 	return alloc_seamldr_params(module, module_size, sig, sig_size);
 }
 
+/*
+ * During a TDX Module update, all CPUs start from TDP_START and progress
+ * to TDP_DONE. Each state is associated with certain work. For some
+ * states, just one CPU needs to perform the work, while other CPUs just
+ * wait during those states.
+ */
+enum tdp_state {
+	TDP_START,
+	TDP_DONE,
+};
+
+static struct {
+	enum tdp_state state;
+	atomic_t thread_ack;
+} tdp_data;
+
+static void set_target_state(enum tdp_state state)
+{
+	/* Reset ack counter. */
+	atomic_set(&tdp_data.thread_ack, num_online_cpus());
+	/* Ensure thread_ack is updated before the new state */
+	smp_wmb();
+	WRITE_ONCE(tdp_data.state, state);
+}
+
+/* Last one to ack a state moves to the next state. */
+static void ack_state(void)
+{
+	if (atomic_dec_and_test(&tdp_data.thread_ack))
+		set_target_state(tdp_data.state + 1);
+}
+
+/*
+ * See multi_cpu_stop() from where this multi-cpu state-machine was
+ * adopted, and the rationale for touch_nmi_watchdog()
+ */
+static int do_seamldr_install_module(void *params)
+{
+	enum tdp_state newstate, curstate = TDP_START;
+	int ret = 0;
+
+	do {
+		/* Chill out and ensure we re-read tdp_data. */
+		cpu_relax();
+		newstate = READ_ONCE(tdp_data.state);
+
+		if (newstate != curstate) {
+			curstate = newstate;
+			switch (curstate) {
+			default:
+				break;
+			}
+			ack_state();
+		} else {
+			touch_nmi_watchdog();
+			rcu_momentary_eqs();
+		}
+	} while (curstate != TDP_DONE);
+
+	return ret;
+}
+
 DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
 	    if (!IS_ERR_OR_NULL(_T)) free_seamldr_params(_T))
 
 int seamldr_install_module(const u8 *data, u32 size)
 {
 	const struct seamldr_info *info = seamldr_get_info();
+	int ret;
 
 	if (!info)
 		return -EIO;
@@ -243,7 +308,11 @@ int seamldr_install_module(const u8 *data, u32 size)
 		return -EBUSY;
 	}
 
-	/* TODO: Update TDX Module here */
+	set_target_state(TDP_START + 1);
+	ret = stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL_FOR_MODULES(seamldr_install_module, "tdx-host");
-- 
2.47.3


