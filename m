Return-Path: <linux-kernel+bounces-624081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C086A9FE66
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 02:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9222188CA59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 00:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD621ABAE;
	Tue, 29 Apr 2025 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daog34a3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA35217F53
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886874; cv=none; b=rP587mNo3diDdbuhNZHn6rw9GxklG263LpbBMV2/xUNUKx7aYD6xPQYZCbuqyQCn7b6TW4Bnayhnhyc2UZdAKhSTW4esm3gXX1WinTwFsWP9BEHHgEpJS6UWdWeKw+MlHA64n0gMW3+2NC8Nkwla5XK/bo6dlrXe767Bcmf1Pgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886874; c=relaxed/simple;
	bh=YUTOhGbd6dZ07bX6i5x+8jR4iKqyRRJwMY4hLQXMO6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0P+z1RxN6VvtBFzRjfn01rrSEkcMmN2vctA4ZQUjAaZo8HI5aSZl1fm+w5evWABXYuqH/u4uFvxuxGtKMZIVY9Kusdi1xFwWgkYnv2KyLP1w4ZZL9fqdbYgv7PT02/NZWYaDZqmol2TvQyLkEZ8WT68hpbJb6gZ4REX8D9vSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daog34a3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745886872; x=1777422872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YUTOhGbd6dZ07bX6i5x+8jR4iKqyRRJwMY4hLQXMO6w=;
  b=daog34a3l0gIXVEbuctA2JYuogakXbjNU7ss0iZFy30W7Ixvyjrpy8+x
   9wAZXYt494FBO6jGxIQn8kdP99YKfvatWgf4sUs8KOrw6fIrXkjBHTAyg
   0/zdEfu7Xa+PAcQfzD2wo4k5+RHYFWpIIxTRLyNfMaCnAmW/V0AWIJwoa
   L9BiUMtHYr3ZdGOjdTs2SWYqKfzsI/don0jgPd/t/sX4xLrZjDTpOSe4v
   P5F1H8QxWyctj6X+PEzhqsFe0+3lEr90Ws8lFkxw83VtqiOdA8CwY/eph
   Q5iW9OO+fqj5G3PTo31NxBSmiwK45W9WbolBpv7rP0yZ4RELnPHDmV5pD
   g==;
X-CSE-ConnectionGUID: W8hkLjy+Q2qCLP+H40eiFw==
X-CSE-MsgGUID: rpaH3QhQRPCbn94y5Cj/NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58148316"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58148316"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:25 -0700
X-CSE-ConnectionGUID: mWOeDafiSPGZibV08Ym2wQ==
X-CSE-MsgGUID: rtUInqN9RcqmWFms5o5K3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133394087"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:24 -0700
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
Subject: [PATCH v4 29/31] fs/resctrl: Add interface for per-resource debug info files
Date: Mon, 28 Apr 2025 17:33:55 -0700
Message-ID: <20250429003359.375508-30-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429003359.375508-1-tony.luck@intel.com>
References: <20250429003359.375508-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some status registers on each of the telemetry aggregators.
Users may need to view these to understand unexpected event counter
values.

Add the file system support for a "status" file in each mon_capable
resource directory in the "info" directory. This will only be present if
the file system is mounted with the "-o debug" option. It will only have
content for resources that provide a rdt_resource::info_debug() routine.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h |  1 +
 fs/resctrl/rdtgroup.c   | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 3ae50b947a99..675cfbe3e6c6 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -299,6 +299,7 @@ struct rdt_resource {
 	struct list_head	evt_list;
 	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
+	void			(*info_debug)(struct seq_file *s);
 };
 
 /*
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 195e41eb73fb..5948e279b44c 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1022,6 +1022,17 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_info_debug_show(struct kernfs_open_file *of,
+				struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
+
+	if (r->info_debug)
+		r->info_debug(s);
+
+	return 0;
+}
+
 /*
  * rdt_bit_usage_show - Display current usage of resources
  *
@@ -1983,6 +1994,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_closid_show,
 		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
 	},
+	{
+		.name		= "status",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_info_debug_show,
+		.fflags		= RFTYPE_MON_INFO | RFTYPE_DEBUG,
+	},
 };
 
 static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
-- 
2.48.1


