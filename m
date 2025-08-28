Return-Path: <linux-kernel+bounces-790665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 879DDB3AB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450491BA868E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634902848BB;
	Thu, 28 Aug 2025 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGT6bNqr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595426E6FF;
	Thu, 28 Aug 2025 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412360; cv=none; b=kQSOoZxwQaUiYdvgWsdYy0n4q56dt8LaS+CLXyykMNCtI3jXlamkan06PAW2zC6I4Tvczu51ttD84ScQiA8veOrJpxVYAKxivZOuW2zZOmp7HApxc4JtcHbR4Ug+eLPGCbXxy1GURpWQPJQ4OliNOTN1DVHEuLMPyh7Xo69z/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412360; c=relaxed/simple;
	bh=Yrw/cbxvhCSbdXBWRtQWloqs7SVxlSCk7X7BnCsmO0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VX/dVl0yrr+y2rQz0CMSuVq9VgnQKAVp4ZMXtGDzvgwFfe6pJHWERGklSLrH6LCHlgbZ9m7fC9ilRBsqh9q058Zmfvm8dINV/0Hazxb8nS85NRl/cRO/W8+ciilRq49kGlPnt4HAnL1k1vE3YU5eqV7SRmIXRC/HyLm0vJ6O78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGT6bNqr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756412359; x=1787948359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yrw/cbxvhCSbdXBWRtQWloqs7SVxlSCk7X7BnCsmO0k=;
  b=YGT6bNqrTi0TTDzrpaE+5mNj2z8KVWK8XXKn6EaHCN0n8hvI4Ebfi1gl
   p/EWTvJOEEMPA8SVWsyISpV49KAqWCNRSwae+IioXfp7tO3RQ97St0lYs
   //wVok43AxUaShvQywMizl1qiGZb4ActmFZawphtn9y4iGr98btqscoXj
   pfB9ayTG87zG6fAKZDfO8HNvyYyYKRJ1fIeyCDJGerAgVDANcweZSidKw
   T1aADh5f5XbgSTr/OxWnMCSFG2ba8u78oVds0q2rUNtPDTLf6MIj4jYk/
   JaMgMnixjDBdr5F5DCojhS2cIsEx6XlXNrQ45DUsgBxFK8b5Z34H8k6wo
   w==;
X-CSE-ConnectionGUID: 8Ii9vqQaT7mHab8ul0K7oQ==
X-CSE-MsgGUID: fwwN1HdmQjKS0xOASCg7aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="70068197"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="70068197"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 13:19:17 -0700
X-CSE-ConnectionGUID: CF7KVz+dRQe9Z4SQomH26g==
X-CSE-MsgGUID: GOCKVrucS+SK4lQZ3yydLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170596519"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa009.fm.intel.com with ESMTP; 28 Aug 2025 13:19:17 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-hwmon@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: (coretemp) Replace x86_model checks with VFM ones
Date: Thu, 28 Aug 2025 13:17:29 -0700
Message-ID: <20250828201729.1145420-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

Intel CPUs have been using Family 6 for a while. The Family-model checks
in the coretemp driver implicitly assume Family 6. With the upcoming
Family 18 and 19 models, some of these checks fall apart.

While reading the temperature target MSR, cpu_has_tjmax() performs model
checks only to determine if a device warning should be printed. Instead
of expanding the checks, get rid of the function and print the warning
once unconditionally if the MSR read fails. The checks aren't worth
preventing a single line warning to dmesg.

Update the rest of the x86_model checks with VFM ones to make them more
robust. This automatically covers the upcoming Family 18 and 19 as well
as any future extended families.

Add a code comment to reflect that none of the CPUs in Family 5 or
Family 15 set X86_FEATURE_DTHERM. The VFM checks do not impact these
CPUs since the driver does not load on them.

Missing-signoff: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3:
 - Use the new VFM checks instead of the raw x86_model comparisons.
 - Simplify the MSR read warning and get rid of cpu_has_tjmax()
 - Posting this patch separately since the new family cleanup series
   was merged without it.
 - Setting Dave as the author since he provided most of code.

v2: https://lore.kernel.org/lkml/20250211194407.2577252-8-sohil.mehta@intel.com/
---
 drivers/hwmon/coretemp.c | 76 +++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 40 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 1b9203b20d70..ad79db5a183e 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -122,29 +122,29 @@ static const struct tjmax tjmax_table[] = {
 };
 
 struct tjmax_model {
-	u8 model;
-	u8 mask;
+	u32 vfm;
+	u8 stepping_mask;
 	int tjmax;
 };
 
 #define ANY 0xff
 
 static const struct tjmax_model tjmax_model_table[] = {
-	{ 0x1c, 10, 100000 },	/* D4xx, K4xx, N4xx, D5xx, K5xx, N5xx */
-	{ 0x1c, ANY, 90000 },	/* Z5xx, N2xx, possibly others
-				 * Note: Also matches 230 and 330,
-				 * which are covered by tjmax_table
-				 */
-	{ 0x26, ANY, 90000 },	/* Atom Tunnel Creek (Exx), Lincroft (Z6xx)
-				 * Note: TjMax for E6xxT is 110C, but CPU type
-				 * is undetectable by software
-				 */
-	{ 0x27, ANY, 90000 },	/* Atom Medfield (Z2460) */
-	{ 0x35, ANY, 90000 },	/* Atom Clover Trail/Cloverview (Z27x0) */
-	{ 0x36, ANY, 100000 },	/* Atom Cedar Trail/Cedarview (N2xxx, D2xxx)
-				 * Also matches S12x0 (stepping 9), covered by
-				 * PCI table
-				 */
+	{ INTEL_ATOM_BONNELL,	      10,  100000 },	/* D4xx, K4xx, N4xx, D5xx, K5xx, N5xx */
+	{ INTEL_ATOM_BONNELL,	      ANY, 90000 },	/* Z5xx, N2xx, possibly others
+							 * Note: Also matches 230 and 330,
+							 * which are covered by tjmax_table
+							 */
+	{ INTEL_ATOM_BONNELL_MID,     ANY, 90000 },	/* Atom Tunnel Creek (Exx), Lincroft (Z6xx)
+							 * Note: TjMax for E6xxT is 110C, but CPU type
+							 * is undetectable by software
+							 */
+	{ INTEL_ATOM_SALTWELL_MID,    ANY, 90000 },	/* Atom Medfield (Z2460) */
+	{ INTEL_ATOM_SALTWELL_TABLET, ANY, 90000 },	/* Atom Clover Trail/Cloverview (Z27x0) */
+	{ INTEL_ATOM_SALTWELL,	      ANY, 100000 },	/* Atom Cedar Trail/Cedarview (N2xxx, D2xxx)
+							 * Also matches S12x0 (stepping 9), covered by
+							 * PCI table
+							 */
 };
 
 static bool is_pkg_temp_data(struct temp_data *tdata)
@@ -180,6 +180,11 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 	}
 	pci_dev_put(host_bridge);
 
+	/*
+	 * This is literally looking for "CPU  XXX" in the model string.
+	 * Not checking it against the model as well. Just purely a
+	 * string search.
+	 */
 	for (i = 0; i < ARRAY_SIZE(tjmax_table); i++) {
 		if (strstr(c->x86_model_id, tjmax_table[i].id))
 			return tjmax_table[i].tjmax;
@@ -187,17 +192,18 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 
 	for (i = 0; i < ARRAY_SIZE(tjmax_model_table); i++) {
 		const struct tjmax_model *tm = &tjmax_model_table[i];
-		if (c->x86_model == tm->model &&
-		    (tm->mask == ANY || c->x86_stepping == tm->mask))
+		if (c->x86_vfm == tm->vfm &&
+		    (tm->stepping_mask == ANY ||
+		     tm->stepping_mask == c->x86_stepping))
 			return tm->tjmax;
 	}
 
 	/* Early chips have no MSR for TjMax */
 
-	if (c->x86_model == 0xf && c->x86_stepping < 4)
+	if (c->x86_vfm == INTEL_CORE2_MEROM && c->x86_stepping < 4)
 		usemsr_ee = 0;
 
-	if (c->x86_model > 0xe && usemsr_ee) {
+	if (c->x86_vfm > INTEL_CORE_YONAH && usemsr_ee) {
 		u8 platform_id;
 
 		/*
@@ -211,7 +217,8 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 				 "Unable to access MSR 0x17, assuming desktop"
 				 " CPU\n");
 			usemsr_ee = 0;
-		} else if (c->x86_model < 0x17 && !(eax & 0x10000000)) {
+		} else if (c->x86_vfm < INTEL_CORE2_PENRYN &&
+			   !(eax & 0x10000000)) {
 			/*
 			 * Trust bit 28 up to Penryn, I could not find any
 			 * documentation on that; if you happen to know
@@ -226,7 +233,7 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 			 * Mobile Penryn CPU seems to be platform ID 7 or 5
 			 * (guesswork)
 			 */
-			if (c->x86_model == 0x17 &&
+			if (c->x86_vfm == INTEL_CORE2_PENRYN &&
 			    (platform_id == 5 || platform_id == 7)) {
 				/*
 				 * If MSR EE bit is set, set it to 90 degrees C,
@@ -258,18 +265,6 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 	return tjmax;
 }
 
-static bool cpu_has_tjmax(struct cpuinfo_x86 *c)
-{
-	u8 model = c->x86_model;
-
-	return model > 0xe &&
-	       model != 0x1c &&
-	       model != 0x26 &&
-	       model != 0x27 &&
-	       model != 0x35 &&
-	       model != 0x36;
-}
-
 static int get_tjmax(struct temp_data *tdata, struct device *dev)
 {
 	struct cpuinfo_x86 *c = &cpu_data(tdata->cpu);
@@ -287,8 +282,7 @@ static int get_tjmax(struct temp_data *tdata, struct device *dev)
 	 */
 	err = rdmsr_safe_on_cpu(tdata->cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
 	if (err) {
-		if (cpu_has_tjmax(c))
-			dev_warn(dev, "Unable to read TjMax from CPU %u\n", tdata->cpu);
+		dev_warn_once(dev, "Unable to read TjMax from CPU %u\n", tdata->cpu);
 	} else {
 		val = (eax >> 16) & 0xff;
 		if (val)
@@ -460,7 +454,7 @@ static int chk_ucode_version(unsigned int cpu)
 	 * Readings might stop update when processor visited too deep sleep,
 	 * fixed for stepping D0 (6EC).
 	 */
-	if (c->x86_model == 0xe && c->x86_stepping < 0xc && c->microcode < 0x39) {
+	if (c->x86_vfm == INTEL_CORE_YONAH && c->x86_stepping < 0xc && c->microcode < 0x39) {
 		pr_err("Errata AE18 not fixed, update BIOS or microcode of the CPU!\n");
 		return -ENODEV;
 	}
@@ -580,7 +574,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	 * MSR_IA32_TEMPERATURE_TARGET register. Atoms don't have the register
 	 * at all.
 	 */
-	if (c->x86_model > 0xe && c->x86_model != 0x1c)
+	if (c->x86_vfm > INTEL_CORE_YONAH && c->x86_vfm != INTEL_ATOM_BONNELL)
 		if (get_ttarget(tdata, &pdev->dev) >= 0)
 			tdata->attr_size++;
 
@@ -793,7 +787,9 @@ static int __init coretemp_init(void)
 	/*
 	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
 	 * sensors. We check this bit only, all the early CPUs
-	 * without thermal sensors will be filtered out.
+	 * without thermal sensors will be filtered out. This
+	 * includes all the Family 5 and Family 15 (Pentium 4)
+	 * models, since they never set the CPUID bit.
 	 */
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
-- 
2.43.0


