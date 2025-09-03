Return-Path: <linux-kernel+bounces-799285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B6B4298E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A078E1BC5424
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46C920EB;
	Wed,  3 Sep 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcQ5zTTh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECCD31354F;
	Wed,  3 Sep 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926719; cv=none; b=n5E/FCKrztGF91bcdHjPqgKdnjiNr/1WkDL8fcCmM/9mUaEKzTqw+6KC6+36bwtZvjNmOoSsPQ3cIZmzEGonx0GslvCiC7yPFTtJppd2cF7Q5kmsqUeFnag5MOpntMkezqPJC9S3CuMSV4JtlVTVA6Pg3XWBXdX3Z9/tjdvwCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926719; c=relaxed/simple;
	bh=hyfKl4l2BY6XBcrAZ/Yq/Yz5itwr8Le9qXuyvsd4mMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oq44Bx0Y8mid3Dik6+uzwcBmhSBFHqel7KSub+17eK53EDoxfxjr2sI3cpqjX/cBC+JXAcUBVHeLwBBBlTJckHoHQqlhSvhL+7E0tfbywlTlksf5vAEkmxHNkL4WOj/Z+wdJ5jvq911nBY7wAm1jwXL93p3zS980xOJoNVJdX4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcQ5zTTh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756926717; x=1788462717;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hyfKl4l2BY6XBcrAZ/Yq/Yz5itwr8Le9qXuyvsd4mMs=;
  b=fcQ5zTThZEKjXLGcr/OtHelHTmGPSYJC58dbubN+FaQSZGyYIG/7uq7g
   C2yMR5vOae2wAWDOqmZAR1oPHIETnYRHEKXB/Uk/ab1OVv5RHcOEMlP8r
   IMGICoC/krSzrSIrsGvss5nUZAS05gs/yz9ynmT+VERdk8ED1arUEIoIx
   7Ru9ejMmDXZBF5QLNh55i+ZOauKXDOh94JKqJqmKVF75rEuGLeUBsYwnK
   b1Lg/yPjjDDDCnisQVmxPgUSKJNiGd/RmGcUnuym23jIyjfbc7s1huufO
   lAWYbQBWRlxYB92yzXgOCdwp+pRbYM4ap4LPIiRrGrd/Imb/J/LGiGm7e
   w==;
X-CSE-ConnectionGUID: mzwfs8CHR1SAoy1CuhLp+w==
X-CSE-MsgGUID: buUZh/P2SJK15kpJVoDOvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="58285531"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="58285531"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 12:11:56 -0700
X-CSE-ConnectionGUID: zVtr/cu9QmSJu3oXqda6Sg==
X-CSE-MsgGUID: aOMavMB3Sx+TgX9JmpmsPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="176945273"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa005.jf.intel.com with ESMTP; 03 Sep 2025 12:11:56 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3] platform/x86/intel-uncore-freq: Present unique domain ID per package
Date: Wed,  3 Sep 2025 12:11:54 -0700
Message-ID: <20250903191154.1081159-1-srinivas.pandruvada@linux.intel.com>
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
v3:
-Fix comment
- when cdie range is 0 but more than one IO die, just start wherver there
 is a valid instance of IO instead of 0 always
v2:
- Add some comments
- Change update_domain_id() to set_domian_id() to set domain_id instead of update
- cluster_info->uncore_data.domain_id += * is changed to add multiple steps to
get to this equation
- Handle case when only when no compute dies in partition

 .../uncore-frequency/uncore-frequency-tpmi.c  | 74 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index cb4905bad89b..8007ad7c88da 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -369,6 +369,77 @@ static void uncore_set_agent_type(struct tpmi_uncore_cluster_info *cluster_info)
 	cluster_info->uncore_data.agent_type_mask = FIELD_GET(UNCORE_AGENT_TYPES, status);
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
+static void set_domain_id(int id,  int num_resources,
+			  struct oobmsm_plat_info *plat_info,
+			  struct tpmi_uncore_cluster_info *cluster_info)
+{
+	u8 part_io_index, cdie_range, pkg_io_index, max_dies;
+
+	if (plat_info->partition >= MAX_PARTITIONS) {
+		cluster_info->uncore_data.domain_id = id;
+		return;
+	}
+
+	if (cluster_info->uncore_data.agent_type_mask & AGENT_TYPE_CORE) {
+		cluster_info->uncore_data.domain_id = cluster_info->cdie_id;
+		return;
+	}
+
+	/* Unlikely but cdie_mask may have holes, so take range */
+	cdie_range = fls(plat_info->cdie_mask) - ffs(plat_info->cdie_mask) + 1;
+	max_dies = topology_max_dies_per_package();
+
+	/*
+	 * If the CPU doesn't enumerate dies, then use current cdie range
+	 * as the max.
+	 */
+	if (cdie_range > max_dies)
+		max_dies = cdie_range;
+
+	guard(mutex)(&domain_lock);
+
+	if (!io_die_index_next)
+		io_die_index_next = max_dies;
+
+	if (!io_die_start[plat_info->partition]) {
+		io_die_start[plat_info->partition] = io_die_index_next;
+		/*
+		 * number of IO dies = num_resources - cdie_range. Hence
+		 * next partition io_die_index_next is set after IO dies
+		 * in the current partition.
+		 */
+		io_die_index_next += (num_resources - cdie_range);
+	}
+
+	/*
+	 * Index from IO die start within the partition:
+	 * This is the first valid domain after the cdies.
+	 * For example the current resource index 5 and cdies end at
+	 * index 3 (cdie_cnt = 4). Then the IO only index 5 - 4 = 1.
+	 */
+	part_io_index = id - cdie_range;
+
+	/*
+	 * Add to the IO die start index for this partition in this package
+	 * to make unique in the package.
+	 */
+	pkg_io_index = io_die_start[plat_info->partition] + part_io_index;
+
+	/* Assign this to domain ID */
+	cluster_info->uncore_data.domain_id = pkg_io_index;
+}
+
 /* Callback for sysfs read for TPMI uncore values. Called under mutex locks. */
 static int uncore_read(struct uncore_data *data, unsigned int *value, enum uncore_index index)
 {
@@ -605,11 +676,12 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 			cluster_info->uncore_data.package_id = pkg;
 			/* There are no dies like Cascade Lake */
 			cluster_info->uncore_data.die_id = 0;
-			cluster_info->uncore_data.domain_id = i;
 			cluster_info->uncore_data.cluster_id = j;
 
 			set_cdie_id(i, cluster_info, plat_info);
 
+			set_domain_id(i, num_resources, plat_info, cluster_info);
+
 			cluster_info->uncore_root = tpmi_uncore;
 
 			if (TPMI_MINOR_VERSION(pd_info->ufs_header_ver) >= UNCORE_ELC_SUPPORTED_VERSION)
-- 
2.49.0


