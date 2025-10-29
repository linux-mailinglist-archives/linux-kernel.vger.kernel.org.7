Return-Path: <linux-kernel+bounces-876703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC1C1C111
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDDF1885E82
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26431351FAE;
	Wed, 29 Oct 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0KQ9Uti"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5A34FF78
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754897; cv=none; b=mTXVtulhO8myHyd0toQeAnz44DPPB4K/hJXWmGh7osRIl7kODZhY0b4Ac+h3cB7mLOEHXpLZhTN38HBBRgbpJ6hGmqsIZGsHZpxFLj34E585OIpsoiWkzunxz6xxf3oBn5CDgMCMVzzW7qBNYXG2T+VFMxLIK7lNHjftHrYNato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754897; c=relaxed/simple;
	bh=besaz890jtzjVt0kgHuI7dQ4aUz9CByTrzOdg471i0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0p5u5tu4j2l48WCmdJmWhBmwbjrQVZGKjA4vyTX8ixKpPdtcsRXQ1MmGcvrEH65jNueNtAPSBi7ZBIYX6GdfFT1kP24/58mSzGdyACWiz9HfCEbDN7MxAes5573bBLb+JOf0+rOkvAK6ycRrfHiFtqBUUFkABWU46wkC2Da08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0KQ9Uti; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754895; x=1793290895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=besaz890jtzjVt0kgHuI7dQ4aUz9CByTrzOdg471i0M=;
  b=K0KQ9Uti/z9IW1BpG/stCnlbgiPz3uTZPNTDWlp7CbTSTUY3WYG/lfnn
   XKC6tqva8DhDdosX4yRDYQrC2E/5USLee8rPlaAvMG/ZxKiHL30QWLjWA
   8JG6tRU7O4kU10b7IGT0nmL4TLVbMMjsUAtN1VJZe2IgSn3mP+Y3SXTDJ
   xJ880/FfgxQyQh7aNk6EPyz+vWenxN8z1VykuW4V/z1x5HS/hQsudkkVz
   MZLH6gESLJ/X+0sZllGsxNUYFy0+uKz+zMezDdmz2J2prCP4/mjeBkQo0
   FVBvYjeluvigm8eXrhq9fugqFOux51oe6c6Cf9RwF3p3HaKN7OgIMJ8oB
   w==;
X-CSE-ConnectionGUID: 3VRbI6l4TPW+LoB0M/fB+Q==
X-CSE-MsgGUID: POPtBL3dRbObX9hsnnAW9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331015"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331015"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:29 -0700
X-CSE-ConnectionGUID: UFhYpRuOSPaqsSKZMM0nRA==
X-CSE-MsgGUID: mPmxVy7NSqaIy6b4Dw50oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901341"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:29 -0700
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
Subject: [PATCH v13 13/32] x86,fs/resctrl: Add an architectural hook called for each mount
Date: Wed, 29 Oct 2025 09:20:56 -0700
Message-ID: <20251029162118.40604-14-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029162118.40604-1-tony.luck@intel.com>
References: <20251029162118.40604-1-tony.luck@intel.com>
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
index a7e5a546152d..1634db6176c3 100644
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
index c435319552be..980a4d9e5267 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -721,6 +721,15 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
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
index e0eb766c5cf4..a4d4d4080e87 100644
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


