Return-Path: <linux-kernel+bounces-771472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A811B287BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C980A5634C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741CA272E71;
	Fri, 15 Aug 2025 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fhq/RApK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ADD25CC75
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293749; cv=none; b=edItErgSfiJKrpH20yLdjzJC412JA9CszpDjmaQiRxnae98fbVO0o1H7AhK48gMDvbJxcV/2k8WQ9JudmJ3dQHZDJHh0Xw4nUGhCcn7nolplXNQxA2ups3jQ5p3U9qcfh+XBqyUIAYsz0KGMmouGC2VHE2HqbIb/9oJ2W62XVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293749; c=relaxed/simple;
	bh=LCO5Fdp7rj+IB5i/Rg82/lrS2S+GA3QhWc5ciizjtWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtVMu5mS3rmmLzI+pOh2wrIbxyN29RdmxuMU6e10C2iVPK/fTfMUi6IwLY0ZIkQT/CrEFIZyCY8PcoF3/iIZjObWbrP9ib92qQpFxDjFb0oYAQaHiLuONSDtNBytSL3MG2nU0f0QcOttBR0b8KoB+jEsPFE3jDwZVwZXRPdnZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fhq/RApK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293748; x=1786829748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LCO5Fdp7rj+IB5i/Rg82/lrS2S+GA3QhWc5ciizjtWI=;
  b=Fhq/RApKL0191ePIxivFU4Z64PEf8bVbvQxk2wAMBl6+G3mO6Cn2am82
   7fampwbRQ5a5jfmXmBzF7UuAMSjVMmUQGBlwZ/8hSToG82uMJUkICJLkl
   hybcQr/UQr1g+Xz849w8EUwkh+XF2aWE72NtKrEXV7ViMsLv/gWXjfMVX
   qre1zEWcRCN0GJ1j1JpCsmQ768PdWJnjm4hW7JR7zLt/w/dx9ZBysTxMn
   sp9qKSH2geA7lGOxsCEEc4vlx+rdvPrWlpQScl96mPs/C8H83hIlUevbg
   fSlE+i5ImXvt/ge11NKNx7aMH+KU/KQDMDsFVwJs2MexKMnSQtHX3nNtF
   g==;
X-CSE-ConnectionGUID: CkYXCqX6Qm6T3QkOwBxqgA==
X-CSE-MsgGUID: KuwZuOEgTY+d+L8Hh2gbtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707378"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707378"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:45 -0700
X-CSE-ConnectionGUID: RBXpkExGSnq3UqtoDcj4vA==
X-CSE-MsgGUID: AE3FeR0SRMGlkMDdVjEyXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319584"
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
Subject: [PATCH V3 03/17] x86/fpu/xstate: Add xsaves_nmi
Date: Fri, 15 Aug 2025 14:34:21 -0700
Message-Id: <20250815213435.1702022-4-kan.liang@linux.intel.com>
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

There is a hardware feature (Intel PEBS XMMs group), which can handle
XSAVE "snapshots" from random code running. This just provides another
XSAVE data source at a random time.

Add an interface to retrieve the actual register contents when the NMI
hit. The interface is different from the other interfaces of FPU. The
other mechanisms that deal with xstate try to get something coherent.
But this interface is *in*coherent. There's no telling what was in the
registers when a NMI hits. It writes whatever was in the registers when
the NMI hit. It's the invoker's responsibility to make sure the contents
are properly filtered before exposing them to the end user.

The support of the supervisor state components is required. The
compacted storage format is preferred. So the XSAVES is used.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/fpu/xstate.h |  1 +
 arch/x86/kernel/fpu/xstate.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index b308a76afbb7..0c8b9251c29f 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -107,6 +107,7 @@ int xfeature_size(int xfeature_nr);
 
 void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
+void xsaves_nmi(struct xregs_state *xsave, u64 mask);
 
 int xfd_enable_feature(u64 xfd_err);
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9aa9ac8399ae..8602683fcb12 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1448,6 +1448,36 @@ void xrstors(struct xregs_state *xstate, u64 mask)
 	WARN_ON_ONCE(err);
 }
 
+/**
+ * xsaves_nmi - Save selected components to a kernel xstate buffer in NMI
+ * @xstate:	Pointer to the buffer
+ * @mask:	Feature mask to select the components to save
+ *
+ * The @xstate buffer must be 64 byte aligned.
+ *
+ * Caution: The interface is different from the other interfaces of FPU.
+ * The other mechanisms that deal with xstate try to get something coherent.
+ * But this interface is *in*coherent. There's no telling what was in the
+ * registers when a NMI hits. It writes whatever was in the registers when
+ * the NMI hit.
+ * The only user for the interface is perf_event. There is already a
+ * hardware feature (See Intel PEBS XMMs group), which can handle XSAVE
+ * "snapshots" from random code running. This just provides another XSAVE
+ * data source at a random time.
+ * This function can only be invoked in an NMI. It returns the *ACTUAL*
+ * register contents when the NMI hit.
+ */
+void xsaves_nmi(struct xregs_state *xstate, u64 mask)
+{
+	int err;
+
+	if (!in_nmi())
+		return;
+
+	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
+	WARN_ON_ONCE(err);
+}
+
 #if IS_ENABLED(CONFIG_KVM)
 void fpstate_clear_xstate_component(struct fpstate *fpstate, unsigned int xfeature)
 {
-- 
2.38.1


