Return-Path: <linux-kernel+bounces-796992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B98A4B40A80
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5828B1BA1FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7AE32ED5D;
	Tue,  2 Sep 2025 16:25:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67AF312821;
	Tue,  2 Sep 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830325; cv=none; b=J8dJLS42FIc8Q4QUTosMh8/+iuBVjBrVfJGeBOaWnSy4RZMQEd1XZNsWxw0R0FknUYJqRDxiQ0zUHBo6bgPLWPD/RFalGQUqB0RdJ6QQPRQ9aSV3/VslrQeyp4ReAdsDslPqX1y5GmbCOdlRF+jh7Q1BnGLpxdn9FCoE/VMtmpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830325; c=relaxed/simple;
	bh=dSs3WF0K2H6JLzfs/EMbke8Qqva/JSXQlaLyFNDKIDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LIsr/KE30CPvq9ow6l2F7NjO3o0wiPL5WmQyBbWLFLr1X4y9Q8G94+inmYXmT+N73IX69Gi/AO0hhdddSPkJQ6rQ95SZj1CucMSN/fmb0rEW+WfBpPfw8UaGwQeB4EcxX/DFb0oIrew4Vr6LVNkCKvzXyZ8DOzVzD8GvMJUgri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2F24169C;
	Tue,  2 Sep 2025 09:25:14 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 025DE3F6A8;
	Tue,  2 Sep 2025 09:25:20 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be per-arch
Date: Tue,  2 Sep 2025 17:24:07 +0100
Message-Id: <20250902162507.18520-1-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The control value parser for the MB resource currently coerces the
memory bandwidth percentage value from userspace to be an exact
multiple of the bw_gran parameter.

On MPAM systems, this results in somewhat worse-than-worst-case
rounding, since bw_gran is in general only an approximation to the
actual hardware granularity on these systems, and the hardware
bandwidth allocation control value is not natively a percentage --
necessitating a further conversion in the resctrl_arch_update_domains()
path, regardless of the conversion done at parse time.

Allow the arch to provide its own parse-time conversion that is
appropriate for the hardware, and move the existing conversion to x86.
This will avoid accumulated error from rounding the value twice on MPAM
systems.

Clarify the documentation, but avoid overly exact promises.

Clamping to bw_min and bw_max still feels generic: leave it in the core
code, for now.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Based on v6.17-rc3.

Testing: the resctrl MBA and MBM tests pass on a random x86 machine (+
the other tests except for the NONCONT_CAT tests, which do not seem to
be supported in my configuration -- and have nothing to do with the
code touched by this patch).

Notes:

I put the x86 version out of line in order to avoid having to move
struct rdt_resource and its dependencies into resctrl_types.h -- which
would create a lot of diff noise.  Schemata writes from userspace have
a high overhead in any case.

For MPAM the conversion will be a no-op, because the incoming
percentage from the core resctrl code needs to be converted to hardware
representation in the driver anyway.

Perhaps _all_ the types should move to resctrl_types.h.

For now, I went for the smallest diffstat...

---
 Documentation/filesystems/resctrl.rst     | 7 +++----
 arch/x86/include/asm/resctrl.h            | 2 ++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 6 ++++++
 fs/resctrl/ctrlmondata.c                  | 2 +-
 include/linux/resctrl.h                   | 6 ++++++
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c7949dd44f2f..a1d0469d6dfb 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -143,12 +143,11 @@ with respect to allocation:
 		user can request.
 
 "bandwidth_gran":
-		The granularity in which the memory bandwidth
+		The approximate granularity in which the memory bandwidth
 		percentage is allocated. The allocated
 		b/w percentage is rounded off to the next
-		control step available on the hardware. The
-		available bandwidth control steps are:
-		min_bandwidth + N * bandwidth_gran.
+		control step available on the hardware. The available
+		steps are at least as small as this value.
 
 "delay_linear":
 		Indicates if the delay scale is linear or
diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index feb93b50e990..8bec2b9cc503 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -18,6 +18,8 @@
  */
 #define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
 
+struct rdt_resource;
+
 /**
  * struct resctrl_pqr_state - State cache for the PQR MSR
  * @cur_rmid:		The cached Resource Monitoring ID
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1189c0df4ad7..cf9b30b5df3c 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -16,9 +16,15 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/cpu.h>
+#include <linux/math.h>
 
 #include "internal.h"
 
+u32 resctrl_arch_round_bw(u32 val, const struct rdt_resource *r)
+{
+	return roundup(val, (unsigned long)r->membw.bw_gran);
+}
+
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index d98e0d2de09f..c5e73b75aaa0 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -69,7 +69,7 @@ static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 		return false;
 	}
 
-	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
+	*data = resctrl_arch_round_bw(bw, r);
 	return true;
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 6fb4894b8cfd..5b2a555cf2dd 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -416,6 +416,12 @@ static inline u32 resctrl_get_config_index(u32 closid,
 bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l);
 int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
+/*
+ * Round a bandwidth control value to the nearest value acceptable to
+ * the arch code for resource r:
+ */
+u32 resctrl_arch_round_bw(u32 val, const struct rdt_resource *r);
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.

base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.34.1


