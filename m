Return-Path: <linux-kernel+bounces-814807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB66B558EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F67C17AB15
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1B342CA3;
	Fri, 12 Sep 2025 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwOlTiU2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648E33CE98
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715072; cv=none; b=BFEwaPBI/bXrnJy7UE9+PAeMk/fZSg1Im1KGsoAIvXhikzsFUVBxetQ0jJie/lVRpA4RTvmnj+8wq/fvPy+zTpIKiI7JFgxUTC+5V4Q9pQr4++KBdnHIzhzAOdZmIKThyLLUUio5/POXsOFOJ3WbDESBKMPl5gq1aMOGJVfx37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715072; c=relaxed/simple;
	bh=gf7CpiVBMV8TkYcnM8i16uDQlFIz7QT1NCE3HrlDU7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMh7oQ8xxtXCnBF7CjdwQOSVXvS4T397P5BjGEojSkqlGhFZimMDT9W1E2MVRRbk7aZJSfWZNyx/g87TYUg0BRvm2R+WVOgoyFMVYLOX3Ia2RC0CfHQaG8v1cZSsZs/aUZ6y8hOXxBhih+QCBfdqRgMIG/fQMHsP8rqyuMBmOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwOlTiU2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757715070; x=1789251070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gf7CpiVBMV8TkYcnM8i16uDQlFIz7QT1NCE3HrlDU7U=;
  b=dwOlTiU27IXnWrn0WF2l7Jgg9RdUFNXJ7ZEfxID/imyWcBYxLzWg3QKh
   u9Kdx8/FuhAZ2c22o9Bu7ldAdfkiUAJwWpPCmCZFtheohaz57yA3keXv6
   snxTXLdlu17rgu1W2Qh0kxCqp4iBPHzedkSBxFoDUcSdB2JHBeFR+8Wtn
   jD9DbJK4+gz1/Cz33fTf6ZTnKZrxcY4Zy4W3x0w+tFnfZ1RoKWRv/dfKU
   tXlHEzztimre9cGXrHORmBamROeSRShc0ONAY9Z2to7ttLEjkhS5cUCBZ
   w7+BYMmEToksWTGh3gp/boXxWR4DVw44ro39urYvp47ZY5ZrQNZt1zy8Y
   g==;
X-CSE-ConnectionGUID: pStJBnHKQJyQ6MHfi3w3Ew==
X-CSE-MsgGUID: Wp8nXegCSXiQ20jJisGJuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="60002728"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="60002728"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:11:06 -0700
X-CSE-ConnectionGUID: ee8Xo1RhTsiIV2VrlerXAA==
X-CSE-MsgGUID: lCLnyLLsSJKH2BkZMgcvZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="179265172"
Received: from smoehrl-linux.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.221.49])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:11:06 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v10 12/28] x86,fs/resctrl: Add an architectural hook called for each mount
Date: Fri, 12 Sep 2025 15:10:33 -0700
Message-ID: <20250912221053.11349-13-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912221053.11349-1-tony.luck@intel.com>
References: <20250912221053.11349-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enumeration of Intel telemetry events is an asynchronous process involving
several mutually dependent drivers added as auxiliary devices during
the device_initcall() phase of Linux boot. The process finishes after
the probe functions of these drivers completes. But this happens after
resctrl_arch_late_init() is executed.

Tracing the enumeration process shows that it does complete a full seven
seconds before the earliest possible mount of the resctrl file system
(when included in /etc/fstab for automatic mount by systemd).

Add a hook at the beginning of the mount code that will be used
to check for telemetry events and initialize if any are found.

Call the hook on every attempted mount. Expectations are that
most actions (like enumeration) will only need to be performed
on the first call.

resctrl filesystem calls the hook with no locks held. Architecture code
is responsible for any required locking.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 include/linux/resctrl.h            | 6 ++++++
 arch/x86/kernel/cpu/resctrl/core.c | 9 +++++++++
 fs/resctrl/rdtgroup.c              | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index de66928e9430..6350064ac8be 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -511,6 +511,12 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *h
 void resctrl_online_cpu(unsigned int cpu);
 void resctrl_offline_cpu(unsigned int cpu);
 
+/*
+ * Architecture hook called at beginning of each file system mount attempt.
+ * No locks are held.
+ */
+void resctrl_arch_pre_mount(void);
+
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
  *			      for this resource and domain.
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7219004e896f..05b9fd415d78 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -720,6 +720,15 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
+void resctrl_arch_pre_mount(void)
+{
+	static atomic_t only_once = ATOMIC_INIT(0);
+	int old = 0;
+
+	if (!atomic_try_cmpxchg(&only_once, &old, 1))
+		return;
+}
+
 enum {
 	RDT_FLAG_CMT,
 	RDT_FLAG_MBM_TOTAL,
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 4f992b497092..223fd8b761e6 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2720,6 +2720,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	struct rdt_resource *r;
 	int ret;
 
+	resctrl_arch_pre_mount();
+
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 	/*
-- 
2.51.0


