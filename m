Return-Path: <linux-kernel+bounces-761055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93828B1F3CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A16563210
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76D2580CF;
	Sat,  9 Aug 2025 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paqOG+r0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54AD254AE7
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754732534; cv=none; b=TN4/Hsi32pao+wLk5A9Cim5iMv/Ok6v6SISuUkoQx6YiqPdNQZM9CXynGNCkwR2EWAACME7OjBX/0YIQGjvs0TQgVkUd1yygAXNxXbBWd5e7m96KUvyFxIHLVLgg5jnx4WEe1Re1R2CIgBjYMt2ARV25r6mTcRASHiA3+342S/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754732534; c=relaxed/simple;
	bh=cnqONiHBoRrmTHioMp4RU6JIOiAF3SAi/ctEt+NRIvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfYm6ouAlQ35AYxCK+S7SnHhulIVf9Pye9Na0meM4rsu0b9mqYE6lz9SNF/CD1n4RTpeg2mZ+/towv2yAttPElWD6A1Ly1G6hO0tX/tia1603cQ7s6gSyPvsAw46XS22MkA8PQjCWFtb5N/8e2rUU5QIalS4nhCUmJ/W7p0zWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paqOG+r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F4AC4CEF7;
	Sat,  9 Aug 2025 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754732534;
	bh=cnqONiHBoRrmTHioMp4RU6JIOiAF3SAi/ctEt+NRIvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=paqOG+r0cnGf0WJTK7kaNkAzpkJiML80m0y0pvPvovPTvyvQQEHM1FhbvOVuzmneR
	 D6dRbpiXOqKYKyKgyTcJILI5rZeW+GqORDR+VZF19HoX2C4Bw20Qo3+Lb3XB47Wakc
	 JUnlobfjskkW1rPoBLpIZ0TN+JKH0ODY+7tCBE61qt2uhIj2uTimccz1QkGmUwIxac
	 Tm9t0xR5oJLnriUQKSN/eAkOoqGmIWG8ExwA4CDLNLXmLaDCv3J1BqhnQXjIWOPFFk
	 A6iK78eepeUDMnimB9b4VuDsSpkeUSvoIPunuMHGbRLjZhCP1Gbr/rjryja7JjJyT6
	 MZs4suMDDOIFw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 2/2] x86/microcode: Add microcode loader debugging functionality
Date: Sat,  9 Aug 2025 11:42:06 +0200
Message-ID: <20250809094206.28028-3-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250809094206.28028-1-bp@kernel.org>
References: <20250809094206.28028-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Instead of adding ad-hoc debugging glue to the microcode loader each
time I need it, add debugging functionality which is not built by
default and when built-in, off by default so that it can only be enabled
explicitly on the command line.

Simulate all patch handling the loader does except the actual loading of
the microcode patch into the hw.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++
 arch/x86/Kconfig                              | 12 +++
 arch/x86/kernel/cpu/microcode/amd.c           | 88 ++++++++++++++-----
 arch/x86/kernel/cpu/microcode/core.c          | 25 +++++-
 arch/x86/kernel/cpu/microcode/internal.h      | 10 +++
 5 files changed, 119 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7c095177da85..fc002b1a9f57 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3770,6 +3770,13 @@
 	microcode=      [X86] Control the behavior of the microcode loader.
 	                Available options, comma separated:
 
+			dbg - Format: <bool>
+			enable debugging mode when run in a guest
+
+			base_rev=X - with <X> with format: <u32>
+			Set the base microcode revision of each thread when in
+			debug mode.
+
 			force_minrev
 			Enable or disable the microcode minimal revision
  			enforcement for the runtime microcode loader.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..462bf03aeda5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1360,6 +1360,18 @@ config MICROCODE_LATE_FORCE_MINREV
 
 	  If unsure say Y.
 
+config MICROCODE_DBG
+	bool "Enable microcode loader debugging"
+	default n
+	depends on MICROCODE
+	help
+	  Enable code which allows for debugging the microcode loader in
+	  a guest. Meaning the patch loading is simulated but everything else
+	  related to patch parsing and handling is done as on baremetal with
+	  the purpose of debugging solely the software side of things.
+
+	  You almost certainly want to say n here.
+
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
 	help
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 097e39327942..ced499789d64 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -249,15 +249,6 @@ static bool verify_sha256_digest(u32 patch_id, u32 cur_rev, const u8 *data, unsi
 	return true;
 }
 
-static u32 get_patch_level(void)
-{
-	u32 rev, dummy __always_unused;
-
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	return rev;
-}
-
 static union cpuid_1_eax ucode_rev_to_cpuid(unsigned int val)
 {
 	union zen_patch_rev p;
@@ -275,6 +266,45 @@ static union cpuid_1_eax ucode_rev_to_cpuid(unsigned int val)
 	return c;
 }
 
+static u32 cpuid_to_ucode_rev(unsigned int val)
+{
+	union zen_patch_rev p = {};
+	union cpuid_1_eax c;
+
+	c.full = val;
+
+	p.stepping  = c.stepping;
+	p.model     = c.model;
+	p.ext_model = c.ext_model;
+	p.ext_fam   = c.ext_fam;
+
+	return p.ucode_rev;
+}
+
+static u32 get_patch_level(void)
+{
+	u32 rev, dummy __always_unused;
+
+	if (IS_ENABLED(CONFIG_MICROCODE_DBG)) {
+		int cpu = smp_processor_id();
+
+		if (!microcode_rev[cpu]) {
+			if (!base_rev)
+				base_rev = cpuid_to_ucode_rev(bsp_cpuid_1_eax);
+
+			microcode_rev[cpu] = base_rev;
+
+			ucode_dbg("CPU%d, base_rev: 0x%x\n", cpu, base_rev);
+		}
+
+		return microcode_rev[cpu];
+	}
+
+	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
+
+	return rev;
+}
+
 static u16 find_equiv_id(struct equiv_cpu_table *et, u32 sig)
 {
 	unsigned int i;
@@ -304,13 +334,13 @@ static bool verify_container(const u8 *buf, size_t buf_size)
 	u32 cont_magic;
 
 	if (buf_size <= CONTAINER_HDR_SZ) {
-		pr_debug("Truncated microcode container header.\n");
+		ucode_dbg("Truncated microcode container header.\n");
 		return false;
 	}
 
 	cont_magic = *(const u32 *)buf;
 	if (cont_magic != UCODE_MAGIC) {
-		pr_debug("Invalid magic value (0x%08x).\n", cont_magic);
+		ucode_dbg("Invalid magic value (0x%08x).\n", cont_magic);
 		return false;
 	}
 
@@ -335,8 +365,8 @@ static bool verify_equivalence_table(const u8 *buf, size_t buf_size)
 
 	cont_type = hdr[1];
 	if (cont_type != UCODE_EQUIV_CPU_TABLE_TYPE) {
-		pr_debug("Wrong microcode container equivalence table type: %u.\n",
-			 cont_type);
+		ucode_dbg("Wrong microcode container equivalence table type: %u.\n",
+			  cont_type);
 		return false;
 	}
 
@@ -345,7 +375,7 @@ static bool verify_equivalence_table(const u8 *buf, size_t buf_size)
 	equiv_tbl_len = hdr[2];
 	if (equiv_tbl_len < sizeof(struct equiv_cpu_entry) ||
 	    buf_size < equiv_tbl_len) {
-		pr_debug("Truncated equivalence table.\n");
+		ucode_dbg("Truncated equivalence table.\n");
 		return false;
 	}
 
@@ -365,7 +395,7 @@ static bool __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize
 	const u32 *hdr;
 
 	if (buf_size < SECTION_HDR_SIZE) {
-		pr_debug("Truncated patch section.\n");
+		ucode_dbg("Truncated patch section.\n");
 		return false;
 	}
 
@@ -374,13 +404,13 @@ static bool __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize
 	p_size = hdr[1];
 
 	if (p_type != UCODE_UCODE_TYPE) {
-		pr_debug("Invalid type field (0x%x) in container file section header.\n",
-			 p_type);
+		ucode_dbg("Invalid type field (0x%x) in container file section header.\n",
+			  p_type);
 		return false;
 	}
 
 	if (p_size < sizeof(struct microcode_header_amd)) {
-		pr_debug("Patch of size %u too short.\n", p_size);
+		ucode_dbg("Patch of size %u too short.\n", p_size);
 		return false;
 	}
 
@@ -457,12 +487,12 @@ static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 	 * size sh_psize, as the section claims.
 	 */
 	if (buf_size < sh_psize) {
-		pr_debug("Patch of size %u truncated.\n", sh_psize);
+		ucode_dbg("Patch of size %u truncated.\n", sh_psize);
 		return -1;
 	}
 
 	if (!__verify_patch_size(sh_psize, buf_size)) {
-		pr_debug("Per-family patch size mismatch.\n");
+		ucode_dbg("Per-family patch size mismatch.\n");
 		return -1;
 	}
 
@@ -476,6 +506,9 @@ static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 
 	proc_id	= mc_hdr->processor_rev_id;
 	patch_fam = 0xf + (proc_id >> 12);
+
+	ucode_dbg("Patch-ID 0x%08x: family: 0x%x\n", mc_hdr->patch_id, patch_fam);
+
 	if (patch_fam != family)
 		return 1;
 
@@ -546,9 +579,14 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		}
 
 		mc = (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
+
+		ucode_dbg("patch_id: 0x%x\n", mc->hdr.patch_id);
+
 		if (mc_patch_matches(mc, eq_id)) {
 			desc->psize = patch_size;
 			desc->mc = mc;
+
+			ucode_dbg(" match: size: %d\n", patch_size);
 		}
 
 skip:
@@ -619,8 +657,14 @@ static bool __apply_microcode_amd(struct microcode_amd *mc, u32 *cur_rev,
 			invlpg(p_addr_end);
 	}
 
+	if (IS_ENABLED(CONFIG_MICROCODE_DBG))
+		microcode_rev[smp_processor_id()] = mc->hdr.patch_id;
+
 	/* verify patch application was successful */
 	*cur_rev = get_patch_level();
+
+	ucode_dbg("updated rev: 0x%x\n", *cur_rev);
+
 	if (*cur_rev != mc->hdr.patch_id)
 		return false;
 
@@ -1008,7 +1052,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 	patch->patch_id  = mc_hdr->patch_id;
 	patch->equiv_cpu = proc_id;
 
-	pr_debug("%s: Adding patch_id: 0x%08x, proc_id: 0x%04x\n",
+	ucode_dbg("%s: Adding patch_id: 0x%08x, proc_id: 0x%04x\n",
 		 __func__, patch->patch_id, proc_id);
 
 	/* ... and add to cache. */
@@ -1151,7 +1195,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device)
 		snprintf(fw_name, sizeof(fw_name), "amd-ucode/microcode_amd_fam%.2xh.bin", c->x86);
 
 	if (request_firmware_direct(&fw, (const char *)fw_name, device)) {
-		pr_debug("failed to load file %s\n", fw_name);
+		ucode_dbg("failed to load file %s\n", fw_name);
 		goto out;
 	}
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 351a51861f00..3a4e210f6cf3 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -47,6 +47,18 @@ static bool dis_ucode_ldr;
 
 bool force_minrev = false;
 
+/*
+ * Those below should be behind CONFIG_MICROCODE_DBG ifdeffery but in
+ * order to not uglify the code with ifdeffery and use IS_ENABLED()
+ * instead, leave them in. When microcode debugging is not enabled,
+ * those are meaningless anyway.
+ */
+/* enable loader debugging */
+bool dbg;
+/* base microcode revision for debugging */
+u32 base_rev;
+u32 microcode_rev[NR_CPUS] = {};
+
 /*
  * Synchronization.
  *
@@ -118,7 +130,7 @@ bool __init microcode_loader_disabled(void)
 	 *    overwritten.
 	 */
 	if (!cpuid_feature() ||
-	    native_cpuid_ecx(1) & BIT(31) ||
+	    ((native_cpuid_ecx(1) & BIT(31)) && !dbg) ||
 	    amd_check_current_patch_level())
 		dis_ucode_ldr = true;
 
@@ -132,6 +144,17 @@ static void early_parse_cmdline(void)
 
 	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, 64) > 0) {
 		while ((s = strsep(&p, ","))) {
+			if (IS_ENABLED(CONFIG_MICROCODE_DBG)) {
+				if (!strcmp(s, "dbg"))
+					dbg = true;
+
+				if (strstr(s, "base_rev=")) {
+					/* advance to the option arg */
+					strsep(&s, "=");
+					if (kstrtouint(s, 16, &base_rev)) { ; }
+				}
+			}
+
 			if (IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV)) {
 				if (!strcmp("force_minrev", s))
 					force_minrev = true;
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 50a9702ae4e2..bca806dd1aac 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -44,6 +44,10 @@ struct early_load_data {
 
 extern struct early_load_data early_data;
 extern struct ucode_cpu_info ucode_cpu_info[];
+extern u32 microcode_rev[NR_CPUS];
+extern u32 base_rev;
+extern bool dbg;
+
 struct cpio_data find_microcode_in_initrd(const char *path);
 
 #define MAX_UCODE_COUNT 128
@@ -122,4 +126,10 @@ static inline void reload_ucode_intel(void) { }
 static inline struct microcode_ops *init_intel_microcode(void) { return NULL; }
 #endif  /* !CONFIG_CPU_SUP_INTEL */
 
+#define ucode_dbg(fmt, ...)					\
+({								\
+	if (dbg)						\
+		pr_info(fmt, ##__VA_ARGS__);			\
+})
+
 #endif /* _X86_MICROCODE_INTERNAL_H */
-- 
2.43.0


