Return-Path: <linux-kernel+bounces-747294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38928B131F7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 23:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03CC3A6BE0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B1D23ABAA;
	Sun, 27 Jul 2025 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dtis562b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687F282EE;
	Sun, 27 Jul 2025 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753650655; cv=none; b=S/xabb/qALQW5J2mBg15YBnA2PFEHeD0Jxx3CRNWrk7+3zdtvgSTgcJKTkfLCQjsG2I5ewYWLKLRhbg9Ssrjx+O2RxV2DEFx+qJv/cABxV+aJ2PRx6L6C1HGadILtK3c8dYqGWNb4DviaULfyClyIaLbaK/EweJw3WVTh/7xsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753650655; c=relaxed/simple;
	bh=ac8BMLWgsuUgNlfOvqte+SV4ANt6fWIfSTBzT40459g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MooVgtVqw+WUVc9TRDiIH99FYJsgSXpBRNvLcL4IZR6s17gAl1x5N96MwMsAvZLUwVLUpQyWT36XLTQv0lpTpztMVx7QYqhWUN0c+kA4f/Lv4xl5L8dZbFhq0CGgcvksRwHwsj7+pp91ueky9BGaZwyBF0yW6jt79G+Zv4h5xGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dtis562b; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753650654; x=1785186654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ac8BMLWgsuUgNlfOvqte+SV4ANt6fWIfSTBzT40459g=;
  b=Dtis562b4Hz59iZiOE7DRCRa6ErycjEurfG/0wVCxRn174puBJLdpF2d
   GVoB8neu9s1q5D0/crRhLvdj9v9PDRKIcxLSvCRa5M5k8jexpeIwGNPNG
   V3Zq2c8zAR4x4eZTvJwJ/w4rnZ15ppLR7qcLswd11xM80pIAwqW5NLqCu
   oc3W8qDKoEJZCMB5Q+nPyp7vqBRkZP3ZrU0hpG65Ol+soZ+Jvfo73AtOg
   e4nLC/t7ryVhzA9HHYCI70IdDSiXNxcvQ0wzPabwa+XSUyQRntYItun25
   vnJWMj08AZ5iYyeynxc38/FiD6nRH37NQNygNH0yQKteSAXntC9Xnh42j
   w==;
X-CSE-ConnectionGUID: 8oZIxfhLTaSWc3/4eQjlNA==
X-CSE-MsgGUID: 7nmsRHXgTXCEDE2IsLX/fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55600579"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55600579"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 14:10:53 -0700
X-CSE-ConnectionGUID: 1U3O6xG4QACwDVZNUwCw1A==
X-CSE-MsgGUID: 9PYieeALRwejInvN13xcFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162314165"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa007.jf.intel.com with ESMTP; 27 Jul 2025 14:10:53 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86/intel-uncore-freq: Present unique domain ID per package
Date: Sun, 27 Jul 2025 14:10:51 -0700
Message-ID: <20250727211051.2898789-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In partitioned systems, the domain ID is unique in the partition and a
package can have multiple partitions.

Some user-space tools, such as turbostat, assume the domain ID is unique
per package. These tools map CPU power domains, which are unique to a
package. However, this approach does not work in partitioned systems.

There is no architectural definition of "partition" to present to user
space.

To support these tools, set the domain_id to be unique per package. For
compute die IDs, uniqueness can be achieved using the platform info
cdie_mask, mirroring the behavior observed in non-partitioned systems.

For IO dies, which lack a direct CPU relationship, any unique logical
ID can be assigned. Here domain IDs for IO dies are configured after all
compute domain IDs. During the probe, keep the index of the next IO
domain ID after the last IO domain ID of the current partition. Since
CPU packages are symmetric, partition information is same for all
packages.

The Intel Speed Select driver has already implemented a similar change
to make the domain ID unique, with compute dies listed first, followed
by I/O dies.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Rebased on
https://kernel.googlesource.com/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
for-next

 .../uncore-frequency/uncore-frequency-tpmi.c  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index bfcf92aa4d69..563e215b4076 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -411,6 +411,47 @@ static int uncore_read(struct uncore_data *data, unsigned int *value, enum uncor
 	return -EOPNOTSUPP;
 }
 
+#define MAX_PARTITIONS	2
+
+/* IO domain ID start index for a partition */
+static u8 io_die_start[MAX_PARTITIONS];
+
+/* Next IO domain ID index after the current partition IO die IDs */
+static u8 io_die_index_next;
+
+/* Lock to protect io_die_start, io_die_index_next */
+static DEFINE_MUTEX(domain_lock);
+
+static void update_domain_id(struct tpmi_uncore_cluster_info *cluster_info,
+			     struct oobmsm_plat_info *plat_info, int num_resource)
+{
+	u8 max_dies = topology_max_dies_per_package();
+	u8 cdie_cnt;
+
+	/* For non partitioned system or invalid partition number, return */
+	if (!plat_info->cdie_mask || max_dies <= 1 || plat_info->partition >= MAX_PARTITIONS)
+		return;
+
+	if (cluster_info->uncore_data.agent_type_mask & AGENT_TYPE_CORE) {
+		cluster_info->uncore_data.domain_id = cluster_info->cdie_id;
+		return;
+	}
+
+	cdie_cnt = fls(plat_info->cdie_mask) - ffs(plat_info->cdie_mask) + 1;
+
+	guard(mutex)(&domain_lock);
+
+	if (!io_die_index_next)
+		io_die_index_next = max_dies;
+
+	if (!io_die_start[plat_info->partition]) {
+		io_die_start[plat_info->partition] = io_die_index_next;
+		io_die_index_next += (num_resource - cdie_cnt);
+	}
+
+	cluster_info->uncore_data.domain_id += (io_die_start[plat_info->partition] - cdie_cnt);
+}
+
 /* Callback for sysfs write for TPMI uncore data. Called under mutex locks. */
 static int uncore_write(struct uncore_data *data, unsigned int value, enum uncore_index index)
 {
@@ -614,6 +655,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 			cluster_info->uncore_data.cluster_id = j;
 
 			set_cdie_id(i, cluster_info, plat_info);
+			update_domain_id(cluster_info, plat_info, num_resources);
 
 			cluster_info->uncore_root = tpmi_uncore;
 
-- 
2.49.0


