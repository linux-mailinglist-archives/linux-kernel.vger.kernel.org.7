Return-Path: <linux-kernel+bounces-851500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E27DEBD6A06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A9A54F286C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618E30C603;
	Mon, 13 Oct 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElObqzwR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50563064B7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394850; cv=none; b=u2DS6pXupIATiqpb77yXrY6zovvO//6oxTWYWzFpckIdQD0/UmywuRmoUKQ4YiCXE1GiGJsGjLwvEwX07+t+MqZ0iilnxLqOPlESP6Dah7XRGG545cd2WqtRdBA/umvFKjep5gTRaLX6EV1Ej32qHNUhVCdGIu4iFaEw7q6EmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394850; c=relaxed/simple;
	bh=9RP78ZCyeuZdcOoGDz2lzNGdSFoAdp2DPblbuZ2TFK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj4DKu4xhu96gDODzINv9w+OmtQGJN8ZkFfRrcqjPdwXOcbEyvjcqDoElzcfaBEQltXAyEeAHSsu5BLLwudpKp+K2MI8Mi5N/YevjTw7uzqc7OcRaWU9jvAb+2fJlGqKnyg+leQNX+unsHOUo6US6ef///u1DWwkhVbmwNCEWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElObqzwR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760394848; x=1791930848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9RP78ZCyeuZdcOoGDz2lzNGdSFoAdp2DPblbuZ2TFK4=;
  b=ElObqzwRxH5tnDwMRybmlyGt3ZHj4wcd7OX/HlHNSw2zHEEzep+jSjb6
   i4ZNnI/GdJkXxw8pLmBLjZUsJ+DXJmzGA/5ufIkGcigLiJo2VeQRx+H/w
   3IkX1Yb3R+87VBYWLfEIPqP81yy+EgQZhY2de75uNeFZ7x7wfmbi/k1OP
   FcyscuIWpcEHjY+Ie6ESMqverQjIdb0oP2gWg8uej2sflQyBLhSCNTcWQ
   tgORN2bQZQr7LO4XY6yqyqGzyR2XnP2B6N2NK9BsIAXpE8sk1+UJoLNjQ
   SRcadrTTZeBZekn5zQo3rvS+EIOQI4nMwEDgwKXj3bvA824R4X5FTObjJ
   g==;
X-CSE-ConnectionGUID: WOuNewj+SYKlIGQMjOQU5A==
X-CSE-MsgGUID: l0vgBeefSsC59bkNY/YTuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="85168823"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="85168823"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:34:01 -0700
X-CSE-ConnectionGUID: a79fFP8oSYGcXLSQXyLOWQ==
X-CSE-MsgGUID: yTkeixyqQV+jSTxG1kupKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="182145289"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.222.79])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:34:01 -0700
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
Subject: [PATCH v12 12/31] x86,fs/resctrl: Add an architectural hook called for each mount
Date: Mon, 13 Oct 2025 15:33:26 -0700
Message-ID: <20251013223348.103390-13-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013223348.103390-1-tony.luck@intel.com>
References: <20251013223348.103390-1-tony.luck@intel.com>
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
index 7670ce7cdcf1..5b6af3b48de3 100644
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
index 6112e1b83b87..f9bfbdeecf94 100644
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


