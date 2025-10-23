Return-Path: <linux-kernel+bounces-867658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05782C03372
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A68E44E883D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B983F347BC3;
	Thu, 23 Oct 2025 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="il3KoVlt"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A13D1C84C0;
	Thu, 23 Oct 2025 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248782; cv=none; b=acSQrQzdw+Be66BXOXAn/55+KzElMqvpSd73+oEKFxcLgbxK3PagTU9P/+JMaWkaCpMRWF+R+wNeyrl4BaZZu/4xMSzdKCVypfW7qUL3ZWdt1gGKRkXsu2RXdQLdNypVI788t2D21/Oui1Q5keFsPSgXOhOJRhlFYoetRFBZi1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248782; c=relaxed/simple;
	bh=KKFSCrkYKiHFsGtOVseMby2CyZjFoxswfFb6ypbEFpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cyqnwrAlB4DcR9HMO2wuMmhd13PPzFzdI/LpyZtjNGH5XhFCV7hY9HFNPAvLYEJF6ynoFs2w+Qc9WYfeO/EbCNp6jBFkeyqErnC4wPPcq4hce3baO13DKpA2FRA728GECjfS69wnYPBtMbGT/xNQvhp0gq1Q0SJvNgc2DEGTxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=il3KoVlt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bpNI0HuA3PADHUPJY21BNj2h2p3hk8LZedpLkbW++zU=; b=il3KoVlta/gxNiStDgUViksEdI
	FNOqMM7f68LyfeUzuh0QWA/W8HOvLRYebqvy46ghkaRKlOrTYThXQ+6v+JLX4bCXVJ1ZBCGQSwraX
	FbORV3zKseL8K3so0WBFUL9PQKBdqHfyuiXKPwsdJEM4ECYXLIqfCnCG7znV8qjV/2FWMv1gk0MDy
	0r+texIR3p9VuKAcrg23EbsM/LWDS4Lv9/YIOSyjgHuS85SLHQZJkd3XJ4Xr9AMu36FicQdQwAb3J
	8qMIsFDvLnlwVqjE4jsI9uwF28gfibTJchSezJiUcj+hcvg+YiIVO+UglIgOkxYxopTRpi8syyzQK
	xqW5dqkw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC1GK-00000007P3s-24rJ;
	Thu, 23 Oct 2025 19:46:16 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: ISST: isst_if.h: fix all kernel-doc warnings
Date: Thu, 23 Oct 2025 12:46:14 -0700
Message-ID: <20251023194615.180824-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix all kernel-doc warnings in <uapi/linux/isst_if.h>:

- don't use "[]" in the variable name in kernel-doc
- add a few missing entries
- change "power_domain" to "power_domain_id" in kernel-doc to match
  the struct member name
- add a leading '@' on a few existing kernel-doc lines
- use '_' instead of '-' in struct member names

Examples (but not all 27 warnings):

Warning: include/uapi/linux/isst_if.h:63 struct member 'cpu_map'
 not described in 'isst_if_cpu_maps'
Warning: ../include/uapi/linux/isst_if.h:95 struct member 'req_count'
 not described in 'isst_if_io_regs'
Warning: include/uapi/linux/isst_if.h:132 struct member 'mbox_cmd'
 not described in 'isst_if_mbox_cmds'
Warning: ../include/uapi/linux/isst_if.h:183 struct member 'supported'
 not described in 'isst_core_power'
Warning: ../include/uapi/linux/isst_if.h:206 struct member
 'power_domain_id' not described in 'isst_clos_param'
Warning: ../include/uapi/linux/isst_if.h:239 struct member 'assoc_info'
 not described in 'isst_if_clos_assoc_cmds'
Warning: ../include/uapi/linux/isst_if.h:286 struct member 'sst_tf_support'
 not described in 'isst_perf_level_info'
Warning: ../include/uapi/linux/isst_if.h:375 struct member 'trl_freq_mhz'
 not described in 'isst_perf_level_data_info'
Warning: ../include/uapi/linux/isst_if.h:475 struct member 'max_buckets'
 not described in 'isst_turbo_freq_info'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Question:  struct sst_header (in isst_tpmi_core.c) says:
 * @cap_mask:		Bitmask of the supported sub features. 1=the sub feature is enabled.
 *			0=disabled.
 *			Bit[8]= SST_CP enable (1), disable (0)
 *			bit[9]= SST_PP enable (1), disable (0)
but cap_mask is a u8 field. Should these Bit numbers be 0 and 1?
The source code seems to use BIT(0) and BIT(1) for these.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
---
 include/uapi/linux/isst_if.h |   50 +++++++++++++++++----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

--- linux-next-20251022.orig/include/uapi/linux/isst_if.h
+++ linux-next-20251022/include/uapi/linux/isst_if.h
@@ -52,7 +52,7 @@ struct isst_if_cpu_map {
 /**
  * struct isst_if_cpu_maps - structure for CPU map IOCTL
  * @cmd_count:	Number of CPU mapping command in cpu_map[]
- * @cpu_map[]:	Holds one or more CPU map data structure
+ * @cpu_map:	Holds one or more CPU map data structure
  *
  * This structure used with ioctl ISST_IF_GET_PHY_ID to send
  * one or more CPU mapping commands. Here IOCTL return value indicates
@@ -82,8 +82,8 @@ struct isst_if_io_reg {
 
 /**
  * struct isst_if_io_regs - structure for IO register commands
- * @cmd_count:	Number of io reg commands in io_reg[]
- * @io_reg[]:	Holds one or more io_reg command structure
+ * @req_count:	Number of io reg commands in io_reg[]
+ * @io_reg:	Holds one or more io_reg command structure
  *
  * This structure used with ioctl ISST_IF_IO_CMD to send
  * one or more read/write commands to PUNIT. Here IOCTL return value
@@ -120,7 +120,7 @@ struct isst_if_mbox_cmd {
 /**
  * struct isst_if_mbox_cmds - structure for mailbox commands
  * @cmd_count:	Number of mailbox commands in mbox_cmd[]
- * @mbox_cmd[]:	Holds one or more mbox commands
+ * @mbox_cmd:	Holds one or more mbox commands
  *
  * This structure used with ioctl ISST_IF_MBOX_COMMAND to send
  * one or more mailbox commands to PUNIT. Here IOCTL return value
@@ -152,7 +152,7 @@ struct isst_if_msr_cmd {
 /**
  * struct isst_if_msr_cmds - structure for msr commands
  * @cmd_count:	Number of mailbox commands in msr_cmd[]
- * @msr_cmd[]:	Holds one or more msr commands
+ * @msr_cmd:	Holds one or more msr commands
  *
  * This structure used with ioctl ISST_IF_MSR_COMMAND to send
  * one or more MSR commands. IOCTL return value indicates number of
@@ -167,8 +167,9 @@ struct isst_if_msr_cmds {
  * struct isst_core_power - Structure to get/set core_power feature
  * @get_set:	0: Get, 1: Set
  * @socket_id:	Socket/package id
- * @power_domain: Power Domain id
+ * @power_domain_id: Power Domain id
  * @enable:	Feature enable status
+ * @supported:	Power domain supports SST_CP interface
  * @priority_type: Priority type for the feature (ordered/proportional)
  *
  * Structure to get/set core_power feature state using IOCTL
@@ -187,11 +188,11 @@ struct isst_core_power {
  * struct isst_clos_param - Structure to get/set clos praram
  * @get_set:	0: Get, 1: Set
  * @socket_id:	Socket/package id
- * @power_domain:	Power Domain id
- * clos:	Clos ID for the parameters
- * min_freq_mhz: Minimum frequency in MHz
- * max_freq_mhz: Maximum frequency in MHz
- * prop_prio:	Proportional priority from 0-15
+ * @power_domain_id:	Power Domain id
+ * @clos:	Clos ID for the parameters
+ * @min_freq_mhz: Minimum frequency in MHz
+ * @max_freq_mhz: Maximum frequency in MHz
+ * @prop_prio:	Proportional priority from 0-15
  *
  * Structure to get/set per clos property using IOCTL
  * ISST_IF_CLOS_PARAM.
@@ -209,7 +210,7 @@ struct isst_clos_param {
 /**
  * struct isst_if_clos_assoc - Structure to assign clos to a CPU
  * @socket_id:	Socket/package id
- * @power_domain:	Power Domain id
+ * @power_domain_id:	Power Domain id
  * @logical_cpu: CPU number
  * @clos:	Clos ID to assign to the logical CPU
  *
@@ -228,6 +229,7 @@ struct isst_if_clos_assoc {
  * @get_set:	Request is for get or set
  * @punit_cpu_map: Set to 1 if the CPU number is punit numbering not
  *		   Linux CPU number
+ * @assoc_info: CLOS data for this CPU
  *
  * Structure used to get/set associate CPUs to clos using IOCTL
  * ISST_IF_CLOS_ASSOC.
@@ -257,7 +259,7 @@ struct isst_tpmi_instance_count {
 /**
  * struct isst_perf_level_info - Structure to get information on SST-PP levels
  * @socket_id:	Socket/package id
- * @power_domain:	Power Domain id
+ * @power_domain_id:	Power Domain id
  * @logical_cpu: CPU number
  * @clos:	Clos ID to assign to the logical CPU
  * @max_level: Maximum performance level supported by the platform
@@ -267,8 +269,8 @@ struct isst_tpmi_instance_count {
  * @feature_state: SST-BF and SST-TF (enabled/disabled) status at current level
  * @locked: SST-PP performance level change is locked/unlocked
  * @enabled: SST-PP feature is enabled or not
- * @sst-tf_support: SST-TF support status at this level
- * @sst-bf_support: SST-BF support status at this level
+ * @sst_tf_support: SST-TF support status at this level
+ * @sst_bf_support: SST-BF support status at this level
  *
  * Structure to get SST-PP details using IOCTL ISST_IF_PERF_LEVELS.
  */
@@ -289,7 +291,7 @@ struct isst_perf_level_info {
 /**
  * struct isst_perf_level_control - Structure to set SST-PP level
  * @socket_id:	Socket/package id
- * @power_domain:	Power Domain id
+ * @power_domain_id:	Power Domain id
  * @level:	level to set
  *
  * Structure used change SST-PP level using IOCTL ISST_IF_PERF_SET_LEVEL.
@@ -303,7 +305,7 @@ struct isst_perf_level_control {
 /**
  * struct isst_perf_feature_control - Structure to activate SST-BF/SST-TF
  * @socket_id:	Socket/package id
- * @power_domain:	Power Domain id
+ * @power_domain_id:	Power Domain id
  * @feature:	bit 0 = SST-BF state, bit 1 = SST-TF state
  *
  * Structure used to enable SST-BF/SST-TF using IOCTL ISST_IF_PERF_SET_FEATURE.
@@ -320,7 +322,7 @@ struct isst_perf_feature_control {
 /**
  * struct isst_perf_level_data_info - Structure to get SST-PP level details
  * @socket_id:	Socket/package id
- * @power_domain:	Power Domain id
+ * @power_domain_id:	Power Domain id
  * @level:	SST-PP level for which caller wants to get information
  * @tdp_ratio: TDP Ratio
  * @base_freq_mhz: Base frequency in MHz
@@ -341,8 +343,8 @@ struct isst_perf_feature_control {
  * @pm_fabric_freq_mhz: Fabric (Uncore) minimum frequency
  * @max_buckets: Maximum trl buckets
  * @max_trl_levels: Maximum trl levels
- * @bucket_core_counts[TRL_MAX_BUCKETS]: Number of cores per bucket
- * @trl_freq_mhz[TRL_MAX_LEVELS][TRL_MAX_BUCKETS]: maximum frequency
+ * @bucket_core_counts: Number of cores per bucket
+ * @trl_freq_mhz: maximum frequency
  * for a bucket and trl level
  *
  * Structure used to get information on frequencies and TDP for a SST-PP
@@ -402,7 +404,7 @@ struct isst_perf_level_fabric_info {
 /**
  * struct isst_perf_level_cpu_mask - Structure to get SST-PP level CPU mask
  * @socket_id:	Socket/package id
- * @power_domain:	Power Domain id
+ * @power_domain_id:	Power Domain id
  * @level:	SST-PP level for which caller wants to get information
  * @punit_cpu_map: Set to 1 if the CPU number is punit numbering not
  *		   Linux CPU number. If 0 CPU buffer is copied to user space
@@ -430,7 +432,7 @@ struct isst_perf_level_cpu_mask {
 /**
  * struct isst_base_freq_info - Structure to get SST-BF frequencies
  * @socket_id:	Socket/package id
- * @power_domain:	Power Domain id
+ * @power_domain_id:	Power Domain id
  * @level:	SST-PP level for which caller wants to get information
  * @high_base_freq_mhz: High priority CPU base frequency
  * @low_base_freq_mhz: Low priority CPU base frequency
@@ -453,9 +455,11 @@ struct isst_base_freq_info {
 /**
  * struct isst_turbo_freq_info - Structure to get SST-TF frequencies
  * @socket_id:	Socket/package id
- * @power_domain:	Power Domain id
+ * @power_domain_id:	Power Domain id
  * @level:	SST-PP level for which caller wants to get information
  * @max_clip_freqs: Maximum number of low priority core clipping frequencies
+ * @max_buckets: Maximum trl buckets
+ * @max_trl_levels: Maximum trl levels
  * @lp_clip_freq_mhz: Clip frequencies per trl level
  * @bucket_core_counts: Maximum number of cores for a bucket
  * @trl_freq_mhz: Frequencies per trl level for each bucket

