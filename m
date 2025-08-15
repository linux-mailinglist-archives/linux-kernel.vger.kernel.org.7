Return-Path: <linux-kernel+bounces-771474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB558B287C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D9E5C3980
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD042D0C87;
	Fri, 15 Aug 2025 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOVqZnCX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960326B973
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293751; cv=none; b=A/gVHPiHE8myuJ8z4zfLZBvXRsnejmEc8KGBMZ8KPoRR7VYdJh9SDWKwsSOr5VF+uO5T3V60YsOsAbBz6/IMHFOvEexBx2KWCV6K66ZJe/ZvLGx/gKTBcpZkOORkGujy38OBNcKudxnPp3wvKvzvVShJOBz1CLm4m9jWjYGKNoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293751; c=relaxed/simple;
	bh=ldklq7t2qlJCP7YTem0KDZBrLnN7Ju8p02sHCq11DV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ceax0MCnnDRZdbv1R4ElzaSkhc6eZym8N3PC+niCB7ejhazgN5VK47S51H4mAPucZWtlLhEXE8F3cAUvP1BqFm40mGaodolA5Fv6V+k2vY1HGEZHa6xXkIu+xaEeD7MGka4Lde7OsDTNDYcRBF0PEqYOY9ZYsuULB9gDKR6PoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOVqZnCX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293749; x=1786829749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ldklq7t2qlJCP7YTem0KDZBrLnN7Ju8p02sHCq11DV8=;
  b=LOVqZnCXLJmXXeQO4rpALLJx0xoP42EkWfY/ecyuSgZjoI9jcbNsviyO
   ZGgVNFBRJR/Ultmtrc3nHJfZ0WPo7YGrhZYt+/tItMSQlBDPXNets/6tb
   4ez8iI1gSd1UWcPphiFOtyMOgLXPkMxWgQLx7gj3lCGvHqI5/XsqEukPr
   t2I4g2dw4WAOLHRs0c8HKYyks+WN8sBmI5OJRM5rnQUSdHRSyIhqkO+ba
   AhJTDfruI7ITMnwPpA1j6bCfJIxU4mtLH6wEOoKyW+D0WDeJ0udAGikBK
   pF2+prYT0za8omAirHFXIL6wLtO6O03vwecge0uLMI+/eX7gacl6JkevX
   w==;
X-CSE-ConnectionGUID: 9sIcmtWdTgWD1B9Y+rS9kA==
X-CSE-MsgGUID: DVLsoA2DQ1m765xZGJmw4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707402"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707402"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:46 -0700
X-CSE-ConnectionGUID: KhJt+R09SFuCB/TnpKnyxw==
X-CSE-MsgGUID: dcRfe1X9TFiIm9tMgUXceA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319595"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:35:46 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	ak@linux.intel.com,
	zide.chen@intel.com,
	mark.rutland@arm.com,
	broonie@kernel.org,
	ravi.bangoria@amd.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 06/17] perf: Support SIMD registers
Date: Fri, 15 Aug 2025 14:34:24 -0700
Message-Id: <20250815213435.1702022-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250815213435.1702022-1-kan.liang@linux.intel.com>
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The users may be interested in the SIMD registers in a sample while
profiling. The current sample_regs_XXX doesn't have enough space for all
SIMD registers.

Add sets of the sample_simd_{pred,vec}_reg_* in the
struct perf_event_attr to define a set of SIMD registers to dump on
samples.
The current X86 supports the XMM registers in sample_regs_XXX. To
utilize the new SIMD registers configuration method, the
sample_simd_regs_enabled should always be set. If so, the XMM space in
the sample_regs_XXX is reserved for other usage.

The SIMD registers are wider than 64. A new output format is introduced.
The number and width of SIMD registers will be dumped first, following
the register values. The number and width are the same as the user's
configuration now. If, for some reason (e.g., ARM) they are different,
an ARCH-specific perf_output_sample_simd_regs can be implemented later
separately.
Add a new ABI, PERF_SAMPLE_REGS_ABI_SIMD, to indicate the new format.
The enum perf_sample_regs_abi becomes a bitmap now. There should be no
impact on the existing tool, since the version and bitmap are the same
for 1 and 2.

Add three new __weak functions to retrieve the number of available
registers, validate the configuration of the SIMD registers, and
retrieve the SIMD registers. The ARCH-specific functions will be
implemented in the following patches.

Add a new flag PERF_PMU_CAP_SIMD_REGS to indicate that the PMU has the
capability to support SIMD registers dumping. Error out if the
sample_simd_{pred,vec}_reg_* mistakenly set for a PMU that doesn't have
the capability.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h      |  13 ++++
 include/linux/perf_regs.h       |   9 +++
 include/uapi/linux/perf_event.h |  47 +++++++++++++--
 kernel/events/core.c            | 101 +++++++++++++++++++++++++++++++-
 4 files changed, 162 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 444b162f3f92..205361b7de2e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -305,6 +305,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
 #define PERF_PMU_CAP_AUX_PAUSE		0x0200
 #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
+#define PERF_PMU_CAP_SIMD_REGS		0x0800
 
 /**
  * pmu::scope
@@ -1526,6 +1527,18 @@ perf_event__output_id_sample(struct perf_event *event,
 extern void
 perf_log_lost_samples(struct perf_event *event, u64 lost);
 
+static inline bool event_has_simd_regs(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	return attr->sample_simd_regs_enabled != 0 ||
+	       attr->sample_simd_pred_reg_intr != 0 ||
+	       attr->sample_simd_pred_reg_user != 0 ||
+	       attr->sample_simd_vec_reg_qwords != 0 ||
+	       attr->sample_simd_vec_reg_intr != 0 ||
+	       attr->sample_simd_vec_reg_user != 0;
+}
+
 static inline bool event_has_extended_regs(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index f632c5725f16..0172682b18fd 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -9,6 +9,15 @@ struct perf_regs {
 	struct pt_regs	*regs;
 };
 
+int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
+			   u16 pred_qwords, u32 pred_mask);
+u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
+			u16 qwords_idx, bool pred);
+void perf_simd_reg_check(struct pt_regs *regs,
+			 u64 mask, u16 *nr_vectors, u16 *vec_qwords,
+			 u16 pred_mask, u16 *nr_pred, u16 *pred_qwords);
+
+
 #ifdef CONFIG_HAVE_PERF_REGS
 #include <asm/perf_regs.h>
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 78a362b80027..2e9b16acbed6 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -313,9 +313,10 @@ enum {
  * Values to determine ABI of the registers dump.
  */
 enum perf_sample_regs_abi {
-	PERF_SAMPLE_REGS_ABI_NONE		= 0,
-	PERF_SAMPLE_REGS_ABI_32			= 1,
-	PERF_SAMPLE_REGS_ABI_64			= 2,
+	PERF_SAMPLE_REGS_ABI_NONE		= 0x00,
+	PERF_SAMPLE_REGS_ABI_32			= 0x01,
+	PERF_SAMPLE_REGS_ABI_64			= 0x02,
+	PERF_SAMPLE_REGS_ABI_SIMD		= 0x04,
 };
 
 /*
@@ -382,6 +383,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
 #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
+#define PERF_ATTR_SIZE_VER9			168	/* Add: sample_simd_{pred,vec}_reg_* */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -543,6 +545,25 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+
+	/*
+	 * Defines set of SIMD registers to dump on samples.
+	 * The sample_simd_regs_enabled !=0 implies the
+	 * set of SIMD registers is used to config all SIMD registers.
+	 * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
+	 * config some SIMD registers on X86.
+	 */
+	union {
+		__u16 sample_simd_regs_enabled;
+		__u16 sample_simd_pred_reg_qwords;
+	};
+	__u32 sample_simd_pred_reg_intr;
+	__u32 sample_simd_pred_reg_user;
+	__u16 sample_simd_vec_reg_qwords;
+	__u64 sample_simd_vec_reg_intr;
+	__u64 sample_simd_vec_reg_user;
+	__u32 __reserved_4;
 };
 
 /*
@@ -1016,7 +1037,15 @@ enum perf_event_type {
 	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 *	{ u64			abi; # enum perf_sample_regs_abi
-	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
+	 *	  u64			regs[weight(mask)];
+	 *	  struct {
+	 *		u16 nr_vectors;
+	 *		u16 vector_qwords;
+	 *		u16 nr_pred;
+	 *		u16 pred_qwords;
+	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+	 *	} && PERF_SAMPLE_REGS_USER
 	 *
 	 *	{ u64			size;
 	 *	  char			data[size];
@@ -1043,7 +1072,15 @@ enum perf_event_type {
 	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
 	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
 	 *	{ u64			abi; # enum perf_sample_regs_abi
-	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
+	 *	  u64			regs[weight(mask)];
+	 *	  struct {
+	 *		u16 nr_vectors;
+	 *		u16 vector_qwords;
+	 *		u16 nr_pred;
+	 *		u16 pred_qwords;
+	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
+	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
+	 *	} && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			cgroup;} && PERF_SAMPLE_CGROUP
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95a7b6f5af09..dd8cf3c7fb7a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7408,6 +7408,47 @@ perf_output_sample_regs(struct perf_output_handle *handle,
 	}
 }
 
+static void
+perf_output_sample_simd_regs(struct perf_output_handle *handle,
+			     struct perf_event *event,
+			     struct pt_regs *regs,
+			     u64 mask, u16 pred_mask)
+{
+	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
+	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
+	u16 nr_pred = hweight16(pred_mask);
+	u16 nr_vectors = hweight64(mask);
+	int bit;
+	u64 val;
+	u16 i;
+
+	/* Get the number of available regs */
+	perf_simd_reg_check(regs, mask, &nr_vectors, &vec_qwords,
+			    pred_mask, &nr_pred, &pred_qwords);
+
+	perf_output_put(handle, nr_vectors);
+	perf_output_put(handle, vec_qwords);
+	perf_output_put(handle, nr_pred);
+	perf_output_put(handle, pred_qwords);
+
+	if (nr_vectors) {
+		for_each_set_bit(bit, (unsigned long *)&mask, sizeof(mask) * BITS_PER_BYTE) {
+			for (i = 0; i < vec_qwords; i++) {
+				val = perf_simd_reg_value(regs, bit, i, false);
+				perf_output_put(handle, val);
+			}
+		}
+	}
+	if (nr_pred) {
+		for_each_set_bit(bit, (unsigned long *)&pred_mask, sizeof(pred_mask) * BITS_PER_BYTE) {
+			for (i = 0; i < pred_qwords; i++) {
+				val = perf_simd_reg_value(regs, bit, i, true);
+				perf_output_put(handle, val);
+			}
+		}
+	}
+}
+
 static void perf_sample_regs_user(struct perf_regs *regs_user,
 				  struct pt_regs *regs)
 {
@@ -7429,6 +7470,25 @@ static void perf_sample_regs_intr(struct perf_regs *regs_intr,
 	regs_intr->abi  = perf_reg_abi(current);
 }
 
+int __weak perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
+				  u16 pred_qwords, u32 pred_mask)
+{
+	return vec_qwords || vec_mask || pred_qwords || pred_mask ? -ENOSYS : 0;
+}
+
+u64 __weak perf_simd_reg_value(struct pt_regs *regs, int idx,
+			       u16 qwords_idx, bool pred)
+{
+	return 0;
+}
+
+void __weak perf_simd_reg_check(struct pt_regs *regs,
+				u64 mask, u16 *nr_vectors, u16 *vec_qwords,
+				u16 pred_mask, u16 *nr_pred, u16 *pred_qwords)
+{
+	*nr_vectors = 0;
+	*nr_pred = 0;
+}
 
 /*
  * Get remaining task size from user stack pointer.
@@ -7961,10 +8021,17 @@ void perf_output_sample(struct perf_output_handle *handle,
 		perf_output_put(handle, abi);
 
 		if (abi) {
-			u64 mask = event->attr.sample_regs_user;
+			struct perf_event_attr *attr = &event->attr;
+			u64 mask = attr->sample_regs_user;
 			perf_output_sample_regs(handle,
 						data->regs_user.regs,
 						mask);
+			if (abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				perf_output_sample_simd_regs(handle, event,
+							     data->regs_user.regs,
+							     attr->sample_simd_vec_reg_user,
+							     attr->sample_simd_pred_reg_user);
+			}
 		}
 	}
 
@@ -7992,11 +8059,18 @@ void perf_output_sample(struct perf_output_handle *handle,
 		perf_output_put(handle, abi);
 
 		if (abi) {
-			u64 mask = event->attr.sample_regs_intr;
+			struct perf_event_attr *attr = &event->attr;
+			u64 mask = attr->sample_regs_intr;
 
 			perf_output_sample_regs(handle,
 						data->regs_intr.regs,
 						mask);
+			if (abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				perf_output_sample_simd_regs(handle, event,
+							     data->regs_intr.regs,
+							     attr->sample_simd_vec_reg_intr,
+							     attr->sample_simd_pred_reg_intr);
+			}
 		}
 	}
 
@@ -12560,6 +12634,12 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 	if (ret)
 		goto err_pmu;
 
+	if (!(pmu->capabilities & PERF_PMU_CAP_SIMD_REGS) &&
+	    event_has_simd_regs(event)) {
+		ret = -EOPNOTSUPP;
+		goto err_destroy;
+	}
+
 	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
 	    event_has_extended_regs(event)) {
 		ret = -EOPNOTSUPP;
@@ -13101,6 +13181,12 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 		ret = perf_reg_validate(attr->sample_regs_user);
 		if (ret)
 			return ret;
+		ret = perf_simd_reg_validate(attr->sample_simd_vec_reg_qwords,
+					     attr->sample_simd_vec_reg_user,
+					     attr->sample_simd_pred_reg_qwords,
+					     attr->sample_simd_pred_reg_user);
+		if (ret)
+			return ret;
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_STACK_USER) {
@@ -13121,8 +13207,17 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (!attr->sample_max_stack)
 		attr->sample_max_stack = sysctl_perf_event_max_stack;
 
-	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
+	if (attr->sample_type & PERF_SAMPLE_REGS_INTR) {
 		ret = perf_reg_validate(attr->sample_regs_intr);
+		if (ret)
+			return ret;
+		ret = perf_simd_reg_validate(attr->sample_simd_vec_reg_qwords,
+					     attr->sample_simd_vec_reg_intr,
+					     attr->sample_simd_pred_reg_qwords,
+					     attr->sample_simd_pred_reg_intr);
+		if (ret)
+			return ret;
+	}
 
 #ifndef CONFIG_CGROUP_PERF
 	if (attr->sample_type & PERF_SAMPLE_CGROUP)
-- 
2.38.1


