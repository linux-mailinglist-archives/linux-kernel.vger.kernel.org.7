Return-Path: <linux-kernel+bounces-596860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6130A831F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 22:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6786446EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 20:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75342213E89;
	Wed,  9 Apr 2025 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpWFwzK5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC8A2163BD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744230582; cv=none; b=StJKmHtIhZiG8RXQcv/3VXsy/FwKFfOg2fPoW2Crza9gh9RtB0+puzGxfxmta6pfBVuQx9pNcmZbulFC1xKsiZ+DxS676kYAHzDnO2YESxrFs4x1K42UmxIF3ZvUbydr0kqN0WQ6E3MhmU3OxHbpMuBeRxKvq/o963bUEWQ+Biw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744230582; c=relaxed/simple;
	bh=0aqKpFzje+P0SsgfUvwJF0LxCb/4Z5qjaTLAd/CHGIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttnFB6aAtjHIsYirmkIWhaLMGg1R8TaG4NY3JbX7skqINIsEdNfvKNbAP8r2QmOjGTzKFk6J5lPetU+75dqA86mfwZyjIpj4LHAtdYDyW5O9E1ZzH3DPNQqLsfKF0ElxpX9rd8vPYA72/dfw+YSGYINS5QbjDxUdgfqgqF66wn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpWFwzK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10129C4CEEA;
	Wed,  9 Apr 2025 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744230582;
	bh=0aqKpFzje+P0SsgfUvwJF0LxCb/4Z5qjaTLAd/CHGIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WpWFwzK5SDoLl1R7QwrrX+LOCCQFxWTOgLBmAbuQu7n+yBJrpCNMTIjkuNcASe03N
	 Ijw13wi4/HX0x8ujhcBlT/mhapU+ZK/FjD5QTJiEzPeFDnptsmxqcc5jV4MyC2STQn
	 Kay8bl3xvNJfI63Zp9PHBD8HSiEKLASh1kHjdtHyUcqfLfTBzG0zrtHKZokedzDgIq
	 TiueEFkHvR0vZ9CVJlRo8YpGDc3bawZqOvdr5O10J87kL44IGZKY0DhKG+bCou2Aq4
	 UFytIfcKvPeRGlOt+k7CvrLemAMxEo5CHM8HSM2BvW8ZlDIdjzpic0igtk4RgvuJPb
	 NoN7wrysHuJQw==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Xin Li <xin@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 09/20] x86/msr: Rename 'rdmsrl_safe()' to 'rdmsrq_safe()'
Date: Wed,  9 Apr 2025 22:28:56 +0200
Message-ID: <20250409202907.3419480-10-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250409202907.3419480-1-mingo@kernel.org>
References: <20250409202907.3419480-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/events/amd/power.c                          |  2 +-
 arch/x86/events/core.c                               |  8 ++++----
 arch/x86/events/intel/core.c                         |  4 ++--
 arch/x86/events/probe.c                              |  2 +-
 arch/x86/events/rapl.c                               |  2 +-
 arch/x86/include/asm/apic.h                          |  2 +-
 arch/x86/include/asm/msr.h                           |  4 ++--
 arch/x86/include/asm/paravirt.h                      |  2 +-
 arch/x86/kernel/amd_nb.c                             |  2 +-
 arch/x86/kernel/cpu/amd.c                            |  6 +++---
 arch/x86/kernel/cpu/aperfmperf.c                     | 20 ++++++++++----------
 arch/x86/kernel/cpu/bus_lock.c                       |  2 +-
 arch/x86/kernel/cpu/common.c                         |  4 ++--
 arch/x86/kernel/cpu/feat_ctl.c                       |  2 +-
 arch/x86/kernel/cpu/hygon.c                          |  2 +-
 arch/x86/kernel/cpu/intel.c                          |  4 ++--
 arch/x86/kernel/cpu/mce/inject.c                     |  2 +-
 arch/x86/kernel/cpu/mce/intel.c                      |  2 +-
 arch/x86/kvm/vmx/sgx.c                               |  2 +-
 arch/x86/kvm/vmx/vmx.c                               |  2 +-
 arch/x86/kvm/x86.c                                   | 12 ++++++------
 arch/x86/lib/msr.c                                   |  2 +-
 arch/x86/power/cpu.c                                 |  4 ++--
 drivers/acpi/acpi_extlog.c                           |  2 +-
 drivers/acpi/acpi_lpit.c                             |  2 +-
 drivers/cpufreq/amd-pstate-ut.c                      |  4 ++--
 drivers/cpufreq/amd_freq_sensitivity.c               |  2 +-
 drivers/cpufreq/intel_pstate.c                       |  2 +-
 drivers/gpu/drm/i915/selftests/librapl.c             |  4 ++--
 drivers/hwmon/fam15h_power.c                         |  6 +++---
 drivers/platform/x86/intel/ifs/core.c                |  4 ++--
 drivers/platform/x86/intel/pmc/core.c                |  8 ++++----
 .../x86/intel/speed_select_if/isst_if_common.c       | 10 +++++-----
 .../x86/intel/speed_select_if/isst_if_mbox_msr.c     |  4 ++--
 drivers/platform/x86/intel/tpmi_power_domains.c      |  4 ++--
 drivers/platform/x86/intel/turbo_max_3.c             |  2 +-
 drivers/powercap/intel_rapl_msr.c                    |  2 +-
 .../intel/int340x_thermal/processor_thermal_device.c |  2 +-
 drivers/thermal/intel/intel_powerclamp.c             |  4 ++--
 drivers/thermal/intel/intel_tcc_cooling.c            |  4 ++--
 40 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 7e96f4652230..598a727d823a 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -272,7 +272,7 @@ static int __init amd_power_pmu_init(void)
 
 	cpu_pwr_sample_ratio = cpuid_ecx(0x80000007);
 
-	if (rdmsrl_safe(MSR_F15H_CU_MAX_PWR_ACCUMULATOR, &max_cu_acc_power)) {
+	if (rdmsrq_safe(MSR_F15H_CU_MAX_PWR_ACCUMULATOR, &max_cu_acc_power)) {
 		pr_err("Failed to read max compute unit power accumulator MSR\n");
 		return -ENODEV;
 	}
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0a16d6bc11fa..5a2eda65db0a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -269,7 +269,7 @@ bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
 	 */
 	for_each_set_bit(i, cntr_mask, X86_PMC_IDX_MAX) {
 		reg = x86_pmu_config_addr(i);
-		ret = rdmsrl_safe(reg, &val);
+		ret = rdmsrq_safe(reg, &val);
 		if (ret)
 			goto msr_fail;
 		if (val & ARCH_PERFMON_EVENTSEL_ENABLE) {
@@ -283,7 +283,7 @@ bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
 
 	if (*(u64 *)fixed_cntr_mask) {
 		reg = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
-		ret = rdmsrl_safe(reg, &val);
+		ret = rdmsrq_safe(reg, &val);
 		if (ret)
 			goto msr_fail;
 		for_each_set_bit(i, fixed_cntr_mask, X86_PMC_IDX_MAX) {
@@ -314,11 +314,11 @@ bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
 	 * (qemu/kvm) that don't trap on the MSR access and always return 0s.
 	 */
 	reg = x86_pmu_event_addr(reg_safe);
-	if (rdmsrl_safe(reg, &val))
+	if (rdmsrq_safe(reg, &val))
 		goto msr_fail;
 	val ^= 0xffffUL;
 	ret = wrmsrl_safe(reg, val);
-	ret |= rdmsrl_safe(reg, &val_new);
+	ret |= rdmsrq_safe(reg, &val_new);
 	if (ret || val != val_new)
 		goto msr_fail;
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3f4673708184..1e8c89f5f6ed 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5610,7 +5610,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 	 * matches, this is needed to detect certain hardware emulators
 	 * (qemu/kvm) that don't trap on the MSR access and always return 0s.
 	 */
-	if (rdmsrl_safe(msr, &val_old))
+	if (rdmsrq_safe(msr, &val_old))
 		return false;
 
 	/*
@@ -5622,7 +5622,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 		val_tmp = lbr_from_signext_quirk_wr(val_tmp);
 
 	if (wrmsrl_safe(msr, val_tmp) ||
-	    rdmsrl_safe(msr, &val_new))
+	    rdmsrq_safe(msr, &val_new))
 		return false;
 
 	/*
diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
index 600bf8d15c0c..fda35cf25528 100644
--- a/arch/x86/events/probe.c
+++ b/arch/x86/events/probe.c
@@ -43,7 +43,7 @@ perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 			if (msr[bit].test && !msr[bit].test(bit, data))
 				continue;
 			/* Virt sucks; you cannot tell if a R/O MSR is present :/ */
-			if (rdmsrl_safe(msr[bit].msr, &val))
+			if (rdmsrq_safe(msr[bit].msr, &val))
 				continue;
 
 			mask = msr[bit].mask;
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b7c256a2e201..7ff52c23d7a1 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -611,7 +611,7 @@ static int rapl_check_hw_unit(void)
 	int i;
 
 	/* protect rdmsrq() to handle virtualization */
-	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
+	if (rdmsrq_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
 		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 36e17988b7ba..1c136f54651c 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -120,7 +120,7 @@ static inline bool apic_is_x2apic_enabled(void)
 {
 	u64 msr;
 
-	if (rdmsrl_safe(MSR_IA32_APICBASE, &msr))
+	if (rdmsrq_safe(MSR_IA32_APICBASE, &msr))
 		return false;
 	return msr & X2APIC_ENABLE;
 }
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 2e456cd2c97e..58554b5e7911 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -279,7 +279,7 @@ static inline int wrmsr_safe(u32 msr, u32 low, u32 high)
 	__err;							\
 })
 
-static inline int rdmsrl_safe(u32 msr, u64 *p)
+static inline int rdmsrq_safe(u32 msr, u64 *p)
 {
 	int err;
 
@@ -381,7 +381,7 @@ static inline int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 }
 static inline int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
-	return rdmsrl_safe(msr_no, q);
+	return rdmsrq_safe(msr_no, q);
 }
 static inline int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 87c2597c68f2..86a77528792d 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -231,7 +231,7 @@ static inline void wrmsrq(unsigned msr, u64 val)
 	_err;						\
 })
 
-static inline int rdmsrl_safe(unsigned msr, u64 *p)
+static inline int rdmsrq_safe(unsigned msr, u64 *p)
 {
 	int err;
 
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 6d12a9b69432..dc389ca052b7 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -151,7 +151,7 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 
 	/* Assume CPUs from Fam10h have mmconfig, although not all VMs do */
 	if (boot_cpu_data.x86 < 0x10 ||
-	    rdmsrl_safe(MSR_FAM10H_MMIO_CONF_BASE, &msr))
+	    rdmsrq_safe(MSR_FAM10H_MMIO_CONF_BASE, &msr))
 		return NULL;
 
 	/* mmconfig is not enabled */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 7c7eca7451b6..3c49a92931e8 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -422,7 +422,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		 * Try to cache the base value so further operations can
 		 * avoid RMW. If that faults, do not enable SSBD.
 		 */
-		if (!rdmsrl_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
+		if (!rdmsrq_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
 			setup_force_cpu_cap(X86_FEATURE_LS_CFG_SSBD);
 			setup_force_cpu_cap(X86_FEATURE_SSBD);
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << bit;
@@ -788,7 +788,7 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 	 * Disable it on the affected CPUs.
 	 */
 	if ((c->x86_model >= 0x02) && (c->x86_model < 0x20)) {
-		if (!rdmsrl_safe(MSR_F15H_IC_CFG, &value) && !(value & 0x1E)) {
+		if (!rdmsrq_safe(MSR_F15H_IC_CFG, &value) && !(value & 0x1E)) {
 			value |= 0x1E;
 			wrmsrl_safe(MSR_F15H_IC_CFG, value);
 		}
@@ -838,7 +838,7 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 	 * suppresses non-branch predictions.
 	 */
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
-		if (!rdmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, &value)) {
+		if (!rdmsrq_safe(MSR_ZEN2_SPECTRAL_CHICKEN, &value)) {
 			value |= MSR_ZEN2_SPECTRAL_CHICKEN_BIT;
 			wrmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, value);
 		}
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index dca78650d99e..e99892aad628 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -99,7 +99,7 @@ static bool __init turbo_disabled(void)
 	u64 misc_en;
 	int err;
 
-	err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
+	err = rdmsrq_safe(MSR_IA32_MISC_ENABLE, &misc_en);
 	if (err)
 		return false;
 
@@ -110,11 +110,11 @@ static bool __init slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 {
 	int err;
 
-	err = rdmsrl_safe(MSR_ATOM_CORE_RATIOS, base_freq);
+	err = rdmsrq_safe(MSR_ATOM_CORE_RATIOS, base_freq);
 	if (err)
 		return false;
 
-	err = rdmsrl_safe(MSR_ATOM_CORE_TURBO_RATIOS, turbo_freq);
+	err = rdmsrq_safe(MSR_ATOM_CORE_TURBO_RATIOS, turbo_freq);
 	if (err)
 		return false;
 
@@ -152,13 +152,13 @@ static bool __init knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
 	int err, i;
 	u64 msr;
 
-	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
+	err = rdmsrq_safe(MSR_PLATFORM_INFO, base_freq);
 	if (err)
 		return false;
 
 	*base_freq = (*base_freq >> 8) & 0xFF;	    /* max P state */
 
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
+	err = rdmsrq_safe(MSR_TURBO_RATIO_LIMIT, &msr);
 	if (err)
 		return false;
 
@@ -190,17 +190,17 @@ static bool __init skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int s
 	u32 group_size;
 	int err, i;
 
-	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
+	err = rdmsrq_safe(MSR_PLATFORM_INFO, base_freq);
 	if (err)
 		return false;
 
 	*base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
 
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &ratios);
+	err = rdmsrq_safe(MSR_TURBO_RATIO_LIMIT, &ratios);
 	if (err)
 		return false;
 
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT1, &counts);
+	err = rdmsrq_safe(MSR_TURBO_RATIO_LIMIT1, &counts);
 	if (err)
 		return false;
 
@@ -220,11 +220,11 @@ static bool __init core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 	u64 msr;
 	int err;
 
-	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
+	err = rdmsrq_safe(MSR_PLATFORM_INFO, base_freq);
 	if (err)
 		return false;
 
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
+	err = rdmsrq_safe(MSR_TURBO_RATIO_LIMIT, &msr);
 	if (err)
 		return false;
 
diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index a96cfdcd94a0..18bd8a876bb8 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -95,7 +95,7 @@ static bool split_lock_verify_msr(bool on)
 {
 	u64 ctrl, tmp;
 
-	if (rdmsrl_safe(MSR_TEST_CTRL, &ctrl))
+	if (rdmsrq_safe(MSR_TEST_CTRL, &ctrl))
 		return false;
 	if (on)
 		ctrl |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a1f1be84a55f..dfccea1f120b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -148,7 +148,7 @@ static void ppin_init(struct cpuinfo_x86 *c)
 	 */
 	info = (struct ppin_info *)id->driver_data;
 
-	if (rdmsrl_safe(info->msr_ppin_ctl, &val))
+	if (rdmsrq_safe(info->msr_ppin_ctl, &val))
 		goto clear_ppin;
 
 	if ((val & 3UL) == 1UL) {
@@ -159,7 +159,7 @@ static void ppin_init(struct cpuinfo_x86 *c)
 	/* If PPIN is disabled, try to enable */
 	if (!(val & 2UL)) {
 		wrmsrl_safe(info->msr_ppin_ctl,  val | 2UL);
-		rdmsrl_safe(info->msr_ppin_ctl, &val);
+		rdmsrq_safe(info->msr_ppin_ctl, &val);
 	}
 
 	/* Is the enable bit set? */
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index edd41950a959..441174844e01 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -118,7 +118,7 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 	bool enable_vmx;
 	u64 msr;
 
-	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr)) {
+	if (rdmsrq_safe(MSR_IA32_FEAT_CTL, &msr)) {
 		clear_cpu_cap(c, X86_FEATURE_VMX);
 		clear_cpu_cap(c, X86_FEATURE_SGX);
 		return;
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 10eeda3ba6ae..21541e310c2c 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -110,7 +110,7 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 		 * Try to cache the base value so further operations can
 		 * avoid RMW. If that faults, do not enable SSBD.
 		 */
-		if (!rdmsrl_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
+		if (!rdmsrq_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
 			setup_force_cpu_cap(X86_FEATURE_LS_CFG_SSBD);
 			setup_force_cpu_cap(X86_FEATURE_SSBD);
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << 10;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 72a11040e2e1..86bdda022009 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -488,7 +488,7 @@ static void init_cpuid_fault(struct cpuinfo_x86 *c)
 {
 	u64 msr;
 
-	if (!rdmsrl_safe(MSR_PLATFORM_INFO, &msr)) {
+	if (!rdmsrq_safe(MSR_PLATFORM_INFO, &msr)) {
 		if (msr & MSR_PLATFORM_INFO_CPUID_FAULT)
 			set_cpu_cap(c, X86_FEATURE_CPUID_FAULT);
 	}
@@ -498,7 +498,7 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 {
 	u64 msr;
 
-	if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &msr))
+	if (rdmsrq_safe(MSR_MISC_FEATURES_ENABLES, &msr))
 		return;
 
 	/* Clear all MISC features */
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 75df35fca6a8..75ff605c8acc 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -748,7 +748,7 @@ static void check_hw_inj_possible(void)
 		toggle_hw_mce_inject(cpu, true);
 
 		wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), status);
-		rdmsrl_safe(mca_msr_reg(bank, MCA_STATUS), &status);
+		rdmsrq_safe(mca_msr_reg(bank, MCA_STATUS), &status);
 		wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), 0);
 
 		if (!status) {
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 28f04c663c95..9b9ef7d421dc 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -460,7 +460,7 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
 	case INTEL_SANDYBRIDGE_X:
 	case INTEL_IVYBRIDGE_X:
 	case INTEL_HASWELL_X:
-		if (rdmsrl_safe(MSR_ERROR_CONTROL, &error_control))
+		if (rdmsrq_safe(MSR_ERROR_CONTROL, &error_control))
 			return;
 		error_control |= 2;
 		wrmsrl_safe(MSR_ERROR_CONTROL, error_control);
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 3cf4ef659dbd..949864259ee6 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -411,7 +411,7 @@ void setup_default_sgx_lepubkeyhash(void)
 	 * MSRs exist but are read-only (locked and not writable).
 	 */
 	if (!enable_sgx || boot_cpu_has(X86_FEATURE_SGX_LC) ||
-	    rdmsrl_safe(MSR_IA32_SGXLEPUBKEYHASH0, &sgx_pubkey_hash[0])) {
+	    rdmsrq_safe(MSR_IA32_SGXLEPUBKEYHASH0, &sgx_pubkey_hash[0])) {
 		sgx_pubkey_hash[0] = 0xa6053e051270b7acULL;
 		sgx_pubkey_hash[1] = 0x6cfbe8ba8b3b413dULL;
 		sgx_pubkey_hash[2] = 0xc4916d99f2b3735dULL;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0e12a3a97439..9b221bdd3c51 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2850,7 +2850,7 @@ static int kvm_cpu_vmxon(u64 vmxon_pointer)
 
 fault:
 	WARN_ONCE(1, "VMXON faulted, MSR_IA32_FEAT_CTL (0x3a) = 0x%llx\n",
-		  rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr) ? 0xdeadbeef : msr);
+		  rdmsrq_safe(MSR_IA32_FEAT_CTL, &msr) ? 0xdeadbeef : msr);
 	cr4_clear_bits(X86_CR4_VMXE);
 
 	return -EFAULT;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 36504a170efc..134c4a186e9c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -590,7 +590,7 @@ static int kvm_probe_user_return_msr(u32 msr)
 	int ret;
 
 	preempt_disable();
-	ret = rdmsrl_safe(msr, &val);
+	ret = rdmsrq_safe(msr, &val);
 	if (ret)
 		goto out;
 	ret = wrmsrl_safe(msr, val);
@@ -630,7 +630,7 @@ static void kvm_user_return_msr_cpu_online(void)
 	int i;
 
 	for (i = 0; i < kvm_nr_uret_msrs; ++i) {
-		rdmsrl_safe(kvm_uret_msrs_list[i], &value);
+		rdmsrq_safe(kvm_uret_msrs_list[i], &value);
 		msrs->values[i].host = value;
 		msrs->values[i].curr = value;
 	}
@@ -1660,7 +1660,7 @@ static int kvm_get_feature_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 		*data = MSR_PLATFORM_INFO_CPUID_FAULT;
 		break;
 	case MSR_IA32_UCODE_REV:
-		rdmsrl_safe(index, data);
+		rdmsrq_safe(index, data);
 		break;
 	default:
 		return kvm_x86_call(get_feature_msr)(index, data);
@@ -9736,7 +9736,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	 * with an exception.  PAT[0] is set to WB on RESET and also by the
 	 * kernel, i.e. failure indicates a kernel bug or broken firmware.
 	 */
-	if (rdmsrl_safe(MSR_IA32_CR_PAT, &host_pat) ||
+	if (rdmsrq_safe(MSR_IA32_CR_PAT, &host_pat) ||
 	    (host_pat & GENMASK(2, 0)) != 6) {
 		pr_err("host PAT[0] is not WB\n");
 		return -EIO;
@@ -9770,7 +9770,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
 	}
 
-	rdmsrl_safe(MSR_EFER, &kvm_host.efer);
+	rdmsrq_safe(MSR_EFER, &kvm_host.efer);
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
 		rdmsrq(MSR_IA32_XSS, kvm_host.xss);
@@ -13652,7 +13652,7 @@ int kvm_spec_ctrl_test_value(u64 value)
 
 	local_irq_save(flags);
 
-	if (rdmsrl_safe(MSR_IA32_SPEC_CTRL, &saved_value))
+	if (rdmsrq_safe(MSR_IA32_SPEC_CTRL, &saved_value))
 		ret = 1;
 	else if (wrmsrl_safe(MSR_IA32_SPEC_CTRL, value))
 		ret = 1;
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 7b90f547b109..d533881ce9a0 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -41,7 +41,7 @@ static int msr_read(u32 msr, struct msr *m)
 	int err;
 	u64 val;
 
-	err = rdmsrl_safe(msr, &val);
+	err = rdmsrq_safe(msr, &val);
 	if (!err)
 		m->q = val;
 
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 78903d330bec..d5a7b3bc2453 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -125,7 +125,7 @@ static void __save_processor_state(struct saved_context *ctxt)
 	ctxt->cr2 = read_cr2();
 	ctxt->cr3 = __read_cr3();
 	ctxt->cr4 = __read_cr4();
-	ctxt->misc_enable_saved = !rdmsrl_safe(MSR_IA32_MISC_ENABLE,
+	ctxt->misc_enable_saved = !rdmsrq_safe(MSR_IA32_MISC_ENABLE,
 					       &ctxt->misc_enable);
 	msr_save_context(ctxt);
 }
@@ -414,7 +414,7 @@ static int msr_build_context(const u32 *msr_id, const int num)
 		u64 dummy;
 
 		msr_array[i].info.msr_no	= msr_id[j];
-		msr_array[i].valid		= !rdmsrl_safe(msr_id[j], &dummy);
+		msr_array[i].valid		= !rdmsrq_safe(msr_id[j], &dummy);
 		msr_array[i].info.reg.q		= 0;
 	}
 	saved_msrs->num   = total_num;
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index f7fb7205028d..8465822b6672 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -234,7 +234,7 @@ static int __init extlog_init(void)
 	u64 cap;
 	int rc;
 
-	if (rdmsrl_safe(MSR_IA32_MCG_CAP, &cap) ||
+	if (rdmsrq_safe(MSR_IA32_MCG_CAP, &cap) ||
 	    !(cap & MCG_ELOG_P) ||
 	    !extlog_get_l1addr())
 		return -ENODEV;
diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index 794962c5c88e..b8d98b1b48ae 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -39,7 +39,7 @@ static int lpit_read_residency_counter_us(u64 *counter, bool io_mem)
 		return 0;
 	}
 
-	err = rdmsrl_safe(residency_info_ffh.gaddr.address, counter);
+	err = rdmsrq_safe(residency_info_ffh.gaddr.address, counter);
 	if (!err) {
 		u64 mask = GENMASK_ULL(residency_info_ffh.gaddr.bit_offset +
 				       residency_info_ffh.gaddr. bit_width - 1,
diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index e671bc7d1550..4a1f5b1fbd84 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -90,9 +90,9 @@ static int amd_pstate_ut_check_enabled(u32 index)
 	if (get_shared_mem())
 		return 0;
 
-	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
+	ret = rdmsrq_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
 	if (ret) {
-		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d error!\n", __func__, ret);
+		pr_err("%s rdmsrq_safe MSR_AMD_CPPC_ENABLE ret=%d error!\n", __func__, ret);
 		return ret;
 	}
 
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index 59b19b9975e8..13fed4b9e02b 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -129,7 +129,7 @@ static int __init amd_freq_sensitivity_init(void)
 		pci_dev_put(pcidev);
 	}
 
-	if (rdmsrl_safe(MSR_AMD64_FREQ_SENSITIVITY_ACTUAL, &val))
+	if (rdmsrq_safe(MSR_AMD64_FREQ_SENSITIVITY_ACTUAL, &val))
 		return -ENODEV;
 
 	if (!(val >> CLASS_CODE_SHIFT))
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3883a2b3e599..a57f494f1032 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1877,7 +1877,7 @@ void notify_hwp_interrupt(void)
 	if (cpu_feature_enabled(X86_FEATURE_HWP_HIGHEST_PERF_CHANGE))
 		status_mask |= HWP_HIGHEST_PERF_CHANGE_STATUS;
 
-	rdmsrl_safe(MSR_HWP_STATUS, &value);
+	rdmsrq_safe(MSR_HWP_STATUS, &value);
 	if (!(value & status_mask))
 		return;
 
diff --git a/drivers/gpu/drm/i915/selftests/librapl.c b/drivers/gpu/drm/i915/selftests/librapl.c
index eb03b5b28bad..25b8726b9dff 100644
--- a/drivers/gpu/drm/i915/selftests/librapl.c
+++ b/drivers/gpu/drm/i915/selftests/librapl.c
@@ -22,12 +22,12 @@ u64 librapl_energy_uJ(void)
 	unsigned long long power;
 	u32 units;
 
-	if (rdmsrl_safe(MSR_RAPL_POWER_UNIT, &power))
+	if (rdmsrq_safe(MSR_RAPL_POWER_UNIT, &power))
 		return 0;
 
 	units = (power & 0x1f00) >> 8;
 
-	if (rdmsrl_safe(MSR_PP1_ENERGY_STATUS, &power))
+	if (rdmsrq_safe(MSR_PP1_ENERGY_STATUS, &power))
 		return 0;
 
 	return (1000000 * power) >> units; /* convert to uJ */
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 9ed2c4b6734e..8ecebea53651 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -143,8 +143,8 @@ static void do_read_registers_on_cu(void *_data)
 	 */
 	cu = topology_core_id(smp_processor_id());
 
-	rdmsrl_safe(MSR_F15H_CU_PWR_ACCUMULATOR, &data->cu_acc_power[cu]);
-	rdmsrl_safe(MSR_F15H_PTSC, &data->cpu_sw_pwr_ptsc[cu]);
+	rdmsrq_safe(MSR_F15H_CU_PWR_ACCUMULATOR, &data->cu_acc_power[cu]);
+	rdmsrq_safe(MSR_F15H_PTSC, &data->cpu_sw_pwr_ptsc[cu]);
 
 	data->cu_on[cu] = 1;
 }
@@ -424,7 +424,7 @@ static int fam15h_power_init_data(struct pci_dev *f4,
 	 */
 	data->cpu_pwr_sample_ratio = cpuid_ecx(0x80000007);
 
-	if (rdmsrl_safe(MSR_F15H_CU_MAX_PWR_ACCUMULATOR, &tmp)) {
+	if (rdmsrq_safe(MSR_F15H_CU_MAX_PWR_ACCUMULATOR, &tmp)) {
 		pr_err("Failed to read max compute unit power accumulator MSR\n");
 		return -ENODEV;
 	}
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 1ae50702bdb7..c4328a7ae083 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -115,13 +115,13 @@ static int __init ifs_init(void)
 	if (!m)
 		return -ENODEV;
 
-	if (rdmsrl_safe(MSR_IA32_CORE_CAPS, &msrval))
+	if (rdmsrq_safe(MSR_IA32_CORE_CAPS, &msrval))
 		return -ENODEV;
 
 	if (!(msrval & MSR_IA32_CORE_CAPS_INTEGRITY_CAPS))
 		return -ENODEV;
 
-	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
+	if (rdmsrq_safe(MSR_INTEGRITY_CAPS, &msrval))
 		return -ENODEV;
 
 	ifs_pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 7a1d11f2914f..ff7f64df7c09 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1082,7 +1082,7 @@ static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
 	unsigned int index;
 
 	for (index = 0; map[index].name ; index++) {
-		if (rdmsrl_safe(map[index].bit_mask, &pcstate_count))
+		if (rdmsrq_safe(map[index].bit_mask, &pcstate_count))
 			continue;
 
 		pcstate_count *= 1000;
@@ -1587,7 +1587,7 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 
 	/* Save PKGC residency for checking later */
 	for (i = 0; i < pmcdev->num_of_pkgc; i++) {
-		if (rdmsrl_safe(msr_map[i].bit_mask, &pmcdev->pkgc_res_cnt[i]))
+		if (rdmsrq_safe(msr_map[i].bit_mask, &pmcdev->pkgc_res_cnt[i]))
 			return -EIO;
 	}
 
@@ -1603,7 +1603,7 @@ static inline bool pmc_core_is_deepest_pkgc_failed(struct pmc_dev *pmcdev)
 	u32 deepest_pkgc_msr = msr_map[pmcdev->num_of_pkgc - 1].bit_mask;
 	u64 deepest_pkgc_residency;
 
-	if (rdmsrl_safe(deepest_pkgc_msr, &deepest_pkgc_residency))
+	if (rdmsrq_safe(deepest_pkgc_msr, &deepest_pkgc_residency))
 		return false;
 
 	if (deepest_pkgc_residency == pmcdev->pkgc_res_cnt[pmcdev->num_of_pkgc - 1])
@@ -1655,7 +1655,7 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev)
 		for (i = 0; i < pmcdev->num_of_pkgc; i++) {
 			u64 pc_cnt;
 
-			if (!rdmsrl_safe(msr_map[i].bit_mask, &pc_cnt)) {
+			if (!rdmsrq_safe(msr_map[i].bit_mask, &pc_cnt)) {
 				dev_info(dev, "Prev %s cnt = 0x%llx, Current %s cnt = 0x%llx\n",
 					 msr_map[i].name, pmcdev->pkgc_res_cnt[i],
 					 msr_map[i].name, pc_cnt);
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 31239a93dd71..1ebf5624139a 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -406,7 +406,7 @@ static int isst_if_cpu_online(unsigned int cpu)
 
 	isst_cpu_info[cpu].numa_node = cpu_to_node(cpu);
 
-	ret = rdmsrl_safe(MSR_CPU_BUS_NUMBER, &data);
+	ret = rdmsrq_safe(MSR_CPU_BUS_NUMBER, &data);
 	if (ret) {
 		/* This is not a fatal error on MSR mailbox only I/F */
 		isst_cpu_info[cpu].bus_info[0] = -1;
@@ -420,12 +420,12 @@ static int isst_if_cpu_online(unsigned int cpu)
 
 	if (isst_hpm_support) {
 
-		ret = rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
+		ret = rdmsrq_safe(MSR_PM_LOGICAL_ID, &data);
 		if (!ret)
 			goto set_punit_id;
 	}
 
-	ret = rdmsrl_safe(MSR_THREAD_ID_INFO, &data);
+	ret = rdmsrq_safe(MSR_THREAD_ID_INFO, &data);
 	if (ret) {
 		isst_cpu_info[cpu].punit_cpu_id = -1;
 		return ret;
@@ -831,8 +831,8 @@ static int __init isst_if_common_init(void)
 		u64 data;
 
 		/* Can fail only on some Skylake-X generations */
-		if (rdmsrl_safe(MSR_OS_MAILBOX_INTERFACE, &data) ||
-		    rdmsrl_safe(MSR_OS_MAILBOX_DATA, &data))
+		if (rdmsrq_safe(MSR_OS_MAILBOX_INTERFACE, &data) ||
+		    rdmsrq_safe(MSR_OS_MAILBOX_DATA, &data))
 			return -ENODEV;
 	}
 
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
index 0d4d67771afa..78989f649aea 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
@@ -176,11 +176,11 @@ static int __init isst_if_mbox_init(void)
 		return -ENODEV;
 
 	/* Check presence of mailbox MSRs */
-	ret = rdmsrl_safe(MSR_OS_MAILBOX_INTERFACE, &data);
+	ret = rdmsrq_safe(MSR_OS_MAILBOX_INTERFACE, &data);
 	if (ret)
 		return ret;
 
-	ret = rdmsrl_safe(MSR_OS_MAILBOX_DATA, &data);
+	ret = rdmsrq_safe(MSR_OS_MAILBOX_DATA, &data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c b/drivers/platform/x86/intel/tpmi_power_domains.c
index 2f01cd22a6ee..c21b3cb99b7c 100644
--- a/drivers/platform/x86/intel/tpmi_power_domains.c
+++ b/drivers/platform/x86/intel/tpmi_power_domains.c
@@ -157,7 +157,7 @@ static int tpmi_get_logical_id(unsigned int cpu, struct tpmi_cpu_info *info)
 	u64 data;
 	int ret;
 
-	ret = rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
+	ret = rdmsrq_safe(MSR_PM_LOGICAL_ID, &data);
 	if (ret)
 		return ret;
 
@@ -203,7 +203,7 @@ static int __init tpmi_init(void)
 		return -ENODEV;
 
 	/* Check for MSR 0x54 presence */
-	ret = rdmsrl_safe(MSR_PM_LOGICAL_ID, &data);
+	ret = rdmsrq_safe(MSR_PM_LOGICAL_ID, &data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/platform/x86/intel/turbo_max_3.c b/drivers/platform/x86/intel/turbo_max_3.c
index 79a0bcdeffb8..c411ec53145e 100644
--- a/drivers/platform/x86/intel/turbo_max_3.c
+++ b/drivers/platform/x86/intel/turbo_max_3.c
@@ -48,7 +48,7 @@ static int get_oc_core_priority(unsigned int cpu)
 	}
 
 	for (i = 0; i < OC_MAILBOX_RETRY_COUNT; ++i) {
-		ret = rdmsrl_safe(MSR_OC_MAILBOX, &value);
+		ret = rdmsrq_safe(MSR_OC_MAILBOX, &value);
 		if (ret) {
 			pr_debug("cpu %d OC mailbox read failed\n", cpu);
 			break;
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 2b81aabdb0db..9100300ff868 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -116,7 +116,7 @@ static void rapl_msr_update_func(void *info)
 	struct reg_action *ra = info;
 	u64 val;
 
-	ra->err = rdmsrl_safe(ra->reg.msr, &val);
+	ra->err = rdmsrq_safe(ra->reg.msr, &val);
 	if (ra->err)
 		return;
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index c868d8b7bd1c..b0249468b844 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -153,7 +153,7 @@ static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
 	u64 val;
 	int err;
 
-	err = rdmsrl_safe(MSR_PLATFORM_INFO, &val);
+	err = rdmsrq_safe(MSR_PLATFORM_INFO, &val);
 	if (err)
 		return err;
 
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 96a24df79686..9a4cec000910 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -340,7 +340,7 @@ static bool has_pkg_state_counter(void)
 
 	/* check if any one of the counter msrs exists */
 	while (info->msr_index) {
-		if (!rdmsrl_safe(info->msr_index, &val))
+		if (!rdmsrq_safe(info->msr_index, &val))
 			return true;
 		info++;
 	}
@@ -356,7 +356,7 @@ static u64 pkg_state_counter(void)
 
 	while (info->msr_index) {
 		if (!info->skip) {
-			if (!rdmsrl_safe(info->msr_index, &val))
+			if (!rdmsrq_safe(info->msr_index, &val))
 				count += val;
 			else
 				info->skip = true;
diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 9ff0ebdde0ef..0394897e83cf 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -81,14 +81,14 @@ static int __init tcc_cooling_init(void)
 	if (!id)
 		return -ENODEV;
 
-	err = rdmsrl_safe(MSR_PLATFORM_INFO, &val);
+	err = rdmsrq_safe(MSR_PLATFORM_INFO, &val);
 	if (err)
 		return err;
 
 	if (!(val & TCC_PROGRAMMABLE))
 		return -ENODEV;
 
-	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
+	err = rdmsrq_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
 	if (err)
 		return err;
 
-- 
2.45.2


