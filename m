Return-Path: <linux-kernel+bounces-728432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13436B02807
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F7B4A0FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025652472AB;
	Fri, 11 Jul 2025 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzv6E7Nn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C592459E5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278055; cv=none; b=uDo+u5t2+oARU5PDtT9bqD8dt3j0fgrM2EocM8Q1m84KH4LS6y1c7TseHT6FuU+TJZZhwlwizqMGLKobtXgl6YJswJeYxwIvHcSusZibNzPqHRe7oBKokX3R8Bac3OXFKPEt9m8MfCBw70wZehL5uTiLNJWgjzZpkYvkgceXO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278055; c=relaxed/simple;
	bh=ZPneEkIJJOCzcdWGWrCUTe/pkT9nAE3n5MkZo37ORro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYYTf7NtJjKw2PSU717x0kZFZEL7+10ypVsI7oK0OMUskjoH5iZX9IhliaogON/m0iIaRbKf5dYfpID21UopgpRFjjig9aE5C3GgDlM1HnbqWlswwskrxIAD85VWcEhViYjvv1EJNky5N3ARj/kGDq9DdjGJ3Pq8y/9EXpUaHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzv6E7Nn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752278053; x=1783814053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZPneEkIJJOCzcdWGWrCUTe/pkT9nAE3n5MkZo37ORro=;
  b=dzv6E7NnwPYUesRtwzDLJF81IHEBxz1W0xGq4ERJg8E6JwpmarZhZDMf
   sJIgcoCsXwTlxVL/vCSbZ52Dgi7CmYGFff2xV0B/3TwgeEyvcB3LdIFf/
   pM+KendsZOjOK8bhVGvUUqZrDx9EUIv7yLdeR4rMEoTP/e9SSOdc+P9E+
   KhGaej47+SsWc0cT0DsAgUHQDU+KbgisDoXhFzFQ/9/9h8yw1z7w3QKec
   d6jor/ei0U76i52Jdf4E5SW7CVhCYqrRgPpf4K2pv5Qu0wvN+lJnJO7VL
   M9VZnED3lQCmNEcvTRzBdu0iTkAscKSOcHEiAEDIMjgMxvX4FmNRy1KZs
   Q==;
X-CSE-ConnectionGUID: KPHXTtQ9RZuRuPVC4UlyrQ==
X-CSE-MsgGUID: 9W1zNL/HTCic9D95L8URGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54292812"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54292812"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:54:08 -0700
X-CSE-ConnectionGUID: wdBhUanqQ7i9Mc5y+JjNyg==
X-CSE-MsgGUID: C/qIcHGDQeOWz0RHwMfDBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="155902175"
Received: from agluck-desk3.sc.intel.com ([172.25.103.51])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:54:08 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 29/31] fs/resctrl: Provide interface to create architecture specific debugfs area
Date: Fri, 11 Jul 2025 16:53:36 -0700
Message-ID: <20250711235341.113933-30-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711235341.113933-1-tony.luck@intel.com>
References: <20250711235341.113933-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Architectures are constrained to just the file interfaces provided by
the file system for each resource. This does not allow for architecture
specific debug interfaces.

Add resctrl_debugfs_mon_info_arch_mkdir() which creates a directory in the
debugfs file system for a resource. Naming follows the layout of the
main resctrl hierarchy:

	/sys/kernel/debug/resctrl/info/{resource}_MON/{arch}

The {arch} last level directory name matches the output of
the user level "uname -m" command.

Architecture code may use this directory for debug information,
or for minor tuning of features. It must not be used for basic
feature enabling as debugfs may not be configured/mounted on
production systems.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h |  9 +++++++++
 fs/resctrl/rdtgroup.c   | 29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 74cd2979549b..ed5085eeee1b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -571,6 +571,15 @@ void resctrl_arch_reset_all_ctrls(struct rdt_resource *r);
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
+/**
+ * resctrl_debugfs_mon_info_arch_mkdir() - Create a debugfs info directory.
+ *					   Removed by resctrl_exit().
+ * @r:	Resource (must be mon_capable).
+ *
+ * Return: dentry pointer on success, or NULL on error.
+ */
+struct dentry *resctrl_debugfs_mon_info_arch_mkdir(struct rdt_resource *r);
+
 int resctrl_init(void);
 void resctrl_exit(void);
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 9e667d3a93ae..fdd6cf372d6c 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -24,6 +24,7 @@
 #include <linux/sched/task.h>
 #include <linux/slab.h>
 #include <linux/user_namespace.h>
+#include <linux/utsname.h>
 
 #include <uapi/linux/magic.h>
 
@@ -4350,6 +4351,33 @@ int resctrl_init(void)
 	return ret;
 }
 
+static struct dentry *debugfs_resctrl_info;
+
+/*
+ * Create /sys/kernel/debug/resctrl/info/{r->name}_MON/{arch} directory
+ * by request for architecture to use for debugging or minor tuning.
+ * Basic functionality of features must not be controlled by files
+ * added to this directory as debugs may not be configured/mounted
+ * on production systems.
+ */
+struct dentry *resctrl_debugfs_mon_info_arch_mkdir(struct rdt_resource *r)
+{
+	struct dentry *moninfodir;
+	char name[32];
+
+	if (!r->mon_capable)
+		return NULL;
+
+	if (!debugfs_resctrl_info)
+		debugfs_resctrl_info = debugfs_create_dir("info", debugfs_resctrl);
+
+	sprintf(name, "%s_MON", r->name);
+
+	moninfodir = debugfs_create_dir(name, debugfs_resctrl_info);
+
+	return debugfs_create_dir(utsname()->machine, moninfodir);
+}
+
 static bool resctrl_online_domains_exist(void)
 {
 	struct rdt_resource *r;
@@ -4401,6 +4429,7 @@ void resctrl_exit(void)
 
 	debugfs_remove_recursive(debugfs_resctrl);
 	debugfs_resctrl = NULL;
+	debugfs_resctrl_info = NULL;
 	unregister_filesystem(&rdt_fs_type);
 
 	/*
-- 
2.50.0


