Return-Path: <linux-kernel+bounces-763402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CA1B21423
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CA63E3432
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532CF2E7645;
	Mon, 11 Aug 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZUhF0Zn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07F2E6105
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936274; cv=none; b=UVpJ96cCimaWzRkqrufA3P/E5btN1KR6w+Ihv82eJ6aVeSEki7xqhfubnh88SrdZVxGQbVFWv9vT6QzkU2U2cMo+hE+KD1U/tiHob6scOL48GCfrFdLV1gwhGORFvhOYUIFj2wEQcNFU8FBOmWsnI8JCxP7b6w3pFWiUGceD0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936274; c=relaxed/simple;
	bh=gKPqMlcKrpchqfWY2TEm0WmAYj3krKqq8dwDF38mFfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BR6B6vHqIxLPc87DYk73m6muOn1lnwKrBsFkqfJEwhZNEKgu+QfC9Lzs2JrHSLav2cEq4Uqkps5rc7ZNg3oc0lEM4G7xC6WEp2AiOLIt7K+E2HTOeXxP6VIJAZBgfLtY27VhKlCcbNF1GDlrtTraRqrByvM7zTIzoPQ5j3x1PG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZUhF0Zn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754936272; x=1786472272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gKPqMlcKrpchqfWY2TEm0WmAYj3krKqq8dwDF38mFfg=;
  b=BZUhF0Zn8fsgZbRw8Jf0KyRSg6rfhIQKEbdjsmn4Dmu2+j5x17HS3o+H
   g/oD5p0xH6NRg3eh0dcbf2ty731Ivqf8HONW7lmVdltyR6lX4/Z/CGg/V
   ioNYXjvqhrdzfzbJa91FpUQ+aWYemOjyBP2s6ipaaATq3zmnjfTY7jQPF
   3Ca762UdUZVyhNlaTsmsg8U/LDe+7fKaVGE8Tp+BHnObrUNbucNGMe+Ks
   phI7T8zviJTYldKCat7Xgl9/ZvcjO0kektv/+ydDisp3RMIb3nS+CDNeA
   bpDWvFKXqFzog9t/LMcHURAw9V2rGykoxipGPtswT8YY+jjKDovSwLNCv
   A==;
X-CSE-ConnectionGUID: xyR7qe7TTSuR7Lab1XIeaw==
X-CSE-MsgGUID: SR2qB3ZIS/m/xGGTrRdiOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68277596"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68277596"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:28 -0700
X-CSE-ConnectionGUID: vDECg1C4TAu3nfKZyCzbAg==
X-CSE-MsgGUID: oD4e0b4SSu+OJYiphBdpiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196825720"
Received: from puneetse-mobl.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.221.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:27 -0700
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
Subject: [PATCH v8 32/32] x86,fs/resctrl: Update Documentation for package events
Date: Mon, 11 Aug 2025 11:17:06 -0700
Message-ID: <20250811181709.6241-33-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811181709.6241-1-tony.luck@intel.com>
References: <20250811181709.6241-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each "mon_data" directory is now divided between L3 events and package
events.

The "info/PERF_PKG_MON" directory contains parameters for perf events.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/filesystems/resctrl.rst | 85 +++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c7949dd44f2f..065f9fdd8f95 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -167,7 +167,7 @@ with respect to allocation:
 			bandwidth percentages are directly applied to
 			the threads running on the core
 
-If RDT monitoring is available there will be an "L3_MON" directory
+If L3 monitoring is available there will be an "L3_MON" directory
 with the following files:
 
 "num_rmids":
@@ -261,6 +261,18 @@ with the following files:
 		bytes) at which a previously used LLC_occupancy
 		counter can be considered for re-use.
 
+If telemetry monitoring is available there will be an "PERF_PKG_MON" directory
+with the following files:
+
+"num_rmids":
+		The number of telemetry RMIDs supported. If this is different
+		from the number reported in the L3_MON directory the limit
+		on the number of "CTRL_MON" + "MON" directories is the
+		minimum of the values.
+
+"mon_features":
+		Lists the telemetry monitoring events that are enabled on this system.
+
 Finally, in the top level of the "info" directory there is a file
 named "last_cmd_status". This is reset with every "command" issued
 via the file system (making new directories or writing to any of the
@@ -366,15 +378,36 @@ When control is enabled all CTRL_MON groups will also contain:
 When monitoring is enabled all MON groups will also contain:
 
 "mon_data":
-	This contains a set of files organized by L3 domain and by
-	RDT event. E.g. on a system with two L3 domains there will
-	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
-	directories have one file per event (e.g. "llc_occupancy",
-	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
-	files provide a read out of the current value of the event for
-	all tasks in the group. In CTRL_MON groups these files provide
-	the sum for all tasks in the CTRL_MON group and all tasks in
-	MON groups. Please see example section for more details on usage.
+	This contains a set of directories, one for each instance
+	of an L3 cache, or of a processor package. The L3 cache
+	directories are named "mon_L3_00", "mon_L3_01" etc. The
+	package directories "mon_PERF_PKG_00", "mon_PERF_PKG_01" etc.
+
+	Within each directory there is one file per event. In
+	the L3 directories: "llc_occupancy", "mbm_total_bytes",
+	and "mbm_local_bytes". In the PERF_PKG directories: "core_energy",
+	"activity", etc.
+
+	"core_energy" reports a floating point number for the energy
+	(in Joules) used by CPUs for each RMID.
+
+	"activity" also reports a floating point value (in Farads).
+	This provides an estimate of work done independent of the
+	frequency that the CPUs used for execution.
+
+	Note that these two counters only measure energy/activity
+	in the "core" of the CPU (arithmetic units, TLB, L1 and L2
+	caches, etc.). They do not include L3 cache, memory, I/O
+	devices etc.
+
+	All other events report decimal integer values.
+
+	In a MON group these files provide a read out of the current
+	value of the event for all tasks in the group. In CTRL_MON groups
+	these files provide the sum for all tasks in the CTRL_MON group
+	and all tasks in MON groups. Please see example section for more
+	details on usage.
+
 	On systems with Sub-NUMA Cluster (SNC) enabled there are extra
 	directories for each node (located within the "mon_L3_XX" directory
 	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
@@ -1300,6 +1333,38 @@ Example with C::
     resctrl_release_lock(fd);
   }
 
+Debugfs
+=======
+In addition to the use of debugfs for tracing of pseudo-locking
+performance, architecture code may create debugfs directories
+associated with monitoring features for a specific resource.
+
+The full pathname for these is in the form:
+
+    /sys/kernel/debug/resctrl/info/{resource_name}_MON/{arch}/
+
+The prescence, names, and format of these files will vary
+between architectures even if the same resource is present.
+
+PERF_PKG_MON/x86_64
+-------------------
+Three files are present per telemetry aggregator instance
+that show when and how often the hardware has failed to
+collect and accumulate data from the CPUs.
+
+agg_data_loss_count:
+	This counts the number of times that this aggregator
+	failed to accumulate a counter value supplied by a CPU.
+
+agg_data_loss_timestamp:
+	This is a "timestamp" from a free running 25MHz uncore
+	timer indicating when the most recent data loss occurred.
+
+last_update_timestamp:
+	Another 25MHz timestamp indicating when the
+	most recent counter update was successfully applied.
+
+
 Examples for RDT Monitoring along with allocation usage
 =======================================================
 Reading monitored data
-- 
2.50.1


