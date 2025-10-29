Return-Path: <linux-kernel+bounces-876258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ADCC1B77D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA84666C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C672D6E42;
	Wed, 29 Oct 2025 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eyap9SDC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E5355040;
	Wed, 29 Oct 2025 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745347; cv=none; b=URPQ3OdozPEXSSY0aPssUSAcdq3pAQ+6kZeYUj+1628APUz2432t5Vld8laDvlTaiQIgj/Ri1QAkTt37wvRxlcOOOzFRqUDbZEzRJ9qKecbQ3ZLRejvx2Buc9eVvkpHqm8wQAGOEVvNKzoM4HyDg/5HZl67GNL/n8ZOQgKqa1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745347; c=relaxed/simple;
	bh=OCDK4ln0/tF7+DJlLLZPwW4evrYYRU/m05fUyCVCWL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDNRE0j8SBU5t/OlqqYhL0ci37uqdDxXrTPt7tCv+hXTLVNo1H/LVgJZgbQirRJ7Tf/s0j7KTkOfuiPiFJOT0x0dw++21iqrBHqAo9GRc0YqKBgVBF0iAu0sb9hi4EZxr0+uZstJ67NmxhMroxved72/UdE3TncldC8M80Jur3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eyap9SDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A8CC4CEFD;
	Wed, 29 Oct 2025 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761745346;
	bh=OCDK4ln0/tF7+DJlLLZPwW4evrYYRU/m05fUyCVCWL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eyap9SDC821MidIm1Bpq1dcQxEv+gZE9jyqVa7uT9qCb95tYx7BI+e8wtk4UqJF8E
	 iXnsiBseTHSv5M0SVmXt6wLnXdwnb/YBysjQ6YO8IKSwn8kO406uaJudgxPaf/gzfx
	 /1+GBt5nkNnC9nql4Dqxj4D3mbkjJDCrIWMNpRTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.115
Date: Wed, 29 Oct 2025 14:41:48 +0100
Message-ID: <2025102948-swiftly-recliner-8ecb@gregkh>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2025102948-surgery-scribing-95c2@gregkh>
References: <2025102948-surgery-scribing-95c2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
index 9ea1e4cd0709..69be6affa9b5 100644
--- a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
@@ -85,13 +85,21 @@ required:
   - reg
   - "#address-cells"
   - "#size-cells"
-  - dma-ranges
   - ranges
   - clocks
   - clock-names
   - interrupts
   - power-domains
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: fsl,imx8mp-dwc3
+    then:
+      required:
+        - dma-ranges
+
 additionalProperties: false
 
 examples:
diff --git a/Makefile b/Makefile
index ad3952fb542d..85d8fa825695 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 114
+SUBLEVEL = 115
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
@@ -1358,11 +1358,11 @@ endif
 
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
+	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
 
 tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
+	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
 # ---------------------------------------------------------------------------
 # Kernel selftest
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0212129b13d0..92e43b3a10df 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -184,7 +184,8 @@ static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
-	pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
+	if (pte_sw_dirty(pte))
+		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
 	return pte;
 }
 
diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index e984af71df6b..d86aa744cb8f 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -329,12 +329,12 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 #include <asm-generic/bitops/ffz.h>
 #else
 
-static inline int find_first_zero_bit(const unsigned long *vaddr,
-				      unsigned size)
+static inline unsigned long find_first_zero_bit(const unsigned long *vaddr,
+						unsigned long size)
 {
 	const unsigned long *p = vaddr;
-	int res = 32;
-	unsigned int words;
+	unsigned long res = 32;
+	unsigned long words;
 	unsigned long num;
 
 	if (!size)
@@ -355,8 +355,9 @@ static inline int find_first_zero_bit(const unsigned long *vaddr,
 }
 #define find_first_zero_bit find_first_zero_bit
 
-static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
-				     int offset)
+static inline unsigned long find_next_zero_bit(const unsigned long *vaddr,
+					       unsigned long size,
+					       unsigned long offset)
 {
 	const unsigned long *p = vaddr + (offset >> 5);
 	int bit = offset & 31UL, res;
@@ -385,11 +386,12 @@ static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
 }
 #define find_next_zero_bit find_next_zero_bit
 
-static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
+static inline unsigned long find_first_bit(const unsigned long *vaddr,
+					   unsigned long size)
 {
 	const unsigned long *p = vaddr;
-	int res = 32;
-	unsigned int words;
+	unsigned long res = 32;
+	unsigned long words;
 	unsigned long num;
 
 	if (!size)
@@ -410,8 +412,9 @@ static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
 }
 #define find_first_bit find_first_bit
 
-static inline int find_next_bit(const unsigned long *vaddr, int size,
-				int offset)
+static inline unsigned long find_next_bit(const unsigned long *vaddr,
+					  unsigned long size,
+					  unsigned long offset)
 {
 	const unsigned long *p = vaddr + (offset >> 5);
 	int bit = offset & 31UL, res;
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 21cb3ac1237b..020c38e6c5de 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -47,7 +47,7 @@ static struct resource standard_io_resources[] = {
 		.name = "keyboard",
 		.start = 0x60,
 		.end = 0x6f,
-		.flags = IORESOURCE_IO | IORESOURCE_BUSY
+		.flags = IORESOURCE_IO
 	},
 	{
 		.name = "dma page reg",
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 8582ed965844..5308c7612281 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -147,6 +147,20 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 	*max_high = PFN_DOWN(memblock_end_of_DRAM());
 }
 
+static void __init adjust_lowmem_bounds(void)
+{
+	phys_addr_t block_start, block_end;
+	u64 i;
+	phys_addr_t memblock_limit = 0;
+
+	for_each_mem_range(i, &block_start, &block_end) {
+		if (block_end > memblock_limit)
+			memblock_limit = block_end;
+	}
+
+	memblock_set_current_limit(memblock_limit);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	console_verbose();
@@ -160,6 +174,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Keep a copy of command line */
 	*cmdline_p = boot_command_line;
 
+	adjust_lowmem_bounds();
 	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
 	max_mapnr = max_low_pfn;
 
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index d0ee46de248e..74502f91ed93 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -20,18 +20,6 @@ struct mm_struct;
 #include <asm/nohash/pgtable.h>
 #endif /* !CONFIG_PPC_BOOK3S */
 
-/*
- * Protection used for kernel text. We want the debuggers to be able to
- * set breakpoints anywhere, so don't write protect the kernel text
- * on platforms where such control is possible.
- */
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
-#else
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
-#endif
-
 /* Make modules code happy. We don't set RO yet */
 #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
 
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 850783cfa9c7..1b1848761a00 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -204,7 +204,7 @@ void mmu_mark_initmem_nx(void)
 
 	for (i = 0; i < nb - 1 && base < top;) {
 		size = bat_block_size(base, top);
-		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
+		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
 		base += size;
 	}
 	if (base < top) {
@@ -215,7 +215,7 @@ void mmu_mark_initmem_nx(void)
 				pr_warn("Some RW data is getting mapped X. "
 					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
 		}
-		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
+		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
 		base += size;
 	}
 	for (; i < nb; i++)
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 5c02fd08d61e..69fac96c2dcd 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -109,7 +109,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 	p = memstart_addr + s;
 	for (; s < top; s += PAGE_SIZE) {
 		ktext = core_kernel_text(v);
-		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
+		map_kernel_page(v, p, ktext ? PAGE_KERNEL_X : PAGE_KERNEL);
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
 	}
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 332a6bf72b1d..987cfe87e782 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -618,6 +618,8 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
+#define pgprot_dmacoherent pgprot_writecombine
+
 /*
  * THP functions
  */
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 88732abecd02..93e794d0e523 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -61,10 +61,8 @@ int __init riscv_early_of_processor_hartid(struct device_node *node, unsigned lo
 		return -ENODEV;
 	}
 
-	if (!of_device_is_available(node)) {
-		pr_info("CPU with hartid=%lu is not available\n", *hart);
+	if (!of_device_is_available(node))
 		return -ENODEV;
-	}
 
 	if (of_property_read_string(node, "riscv,isa-base", &isa))
 		goto old_interface;
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 2cb30d9c5b4a..e689e3981bd9 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -184,7 +184,7 @@ static bool need_sha_check(u32 cur_rev)
 	}
 
 	switch (cur_rev >> 8) {
-	case 0x80012: return cur_rev <= 0x800126f; break;
+	case 0x80012: return cur_rev <= 0x8001277; break;
 	case 0x80082: return cur_rev <= 0x800820f; break;
 	case 0x83010: return cur_rev <= 0x830107c; break;
 	case 0x86001: return cur_rev <= 0x860010e; break;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3a6c069614eb..976bdf15be22 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -241,11 +241,15 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;
 
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+
 	ret = __rmid_read(rmid, eventid, &msr_val);
-	if (ret)
+	if (ret) {
+		if (am && ret == -EINVAL)
+			am->prev_msr = 0;
 		return ret;
+	}
 
-	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
 		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
 						 hw_res->mbm_width);
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 58b02e4b254b..544964c9c530 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -95,6 +95,11 @@ acpi_tb_print_table_header(acpi_physical_address address,
 {
 	struct acpi_table_header local_header;
 
+#pragma GCC diagnostic push
+#if defined(__GNUC__) && __GNUC__ >= 11
+#pragma GCC diagnostic ignored "-Wstringop-overread"
+#endif
+
 	if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) {
 
 		/* FACS only has signature and length fields */
@@ -135,4 +140,5 @@ acpi_tb_print_table_header(acpi_physical_address address,
 			   local_header.asl_compiler_id,
 			   local_header.asl_compiler_revision));
 	}
+#pragma GCC diagnostic pop
 }
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 94f10c6eb336..e5096fcfad57 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -846,17 +846,8 @@ static int binder_inc_node_nilocked(struct binder_node *node, int strong,
 	} else {
 		if (!internal)
 			node->local_weak_refs++;
-		if (!node->has_weak_ref && list_empty(&node->work.entry)) {
-			if (target_list == NULL) {
-				pr_err("invalid inc weak node for %d\n",
-					node->debug_id);
-				return -EINVAL;
-			}
-			/*
-			 * See comment above
-			 */
+		if (!node->has_weak_ref && target_list && list_empty(&node->work.entry))
 			binder_enqueue_work_ilocked(&node->work, target_list);
-		}
 	}
 	return 0;
 }
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 2aa0c6425290..3a14ed36eb92 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -326,7 +326,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 		 * frequency (by keeping the initial capacity_freq_ref value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
+		if (!IS_ERR_OR_NULL(cpu_clk)) {
 			per_cpu(capacity_freq_ref, cpu) =
 				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
 			clk_put(cpu_clk);
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 7e2d1f0d903a..6e6bf8be0066 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -26,50 +26,46 @@ struct devcd_entry {
 	void *data;
 	size_t datalen;
 	/*
-	 * Here, mutex is required to serialize the calls to del_wk work between
-	 * user/kernel space which happens when devcd is added with device_add()
-	 * and that sends uevent to user space. User space reads the uevents,
-	 * and calls to devcd_data_write() which try to modify the work which is
-	 * not even initialized/queued from devcoredump.
+	 * There are 2 races for which mutex is required.
 	 *
+	 * The first race is between device creation and userspace writing to
+	 * schedule immediately destruction.
 	 *
+	 * This race is handled by arming the timer before device creation, but
+	 * when device creation fails the timer still exists.
 	 *
-	 *        cpu0(X)                                 cpu1(Y)
+	 * To solve this, hold the mutex during device_add(), and set
+	 * init_completed on success before releasing the mutex.
 	 *
-	 *        dev_coredump() uevent sent to user space
-	 *        device_add()  ======================> user space process Y reads the
-	 *                                              uevents writes to devcd fd
-	 *                                              which results into writes to
+	 * That way the timer will never fire until device_add() is called,
+	 * it will do nothing if init_completed is not set. The timer is also
+	 * cancelled in that case.
 	 *
-	 *                                             devcd_data_write()
-	 *                                               mod_delayed_work()
-	 *                                                 try_to_grab_pending()
-	 *                                                   del_timer()
-	 *                                                     debug_assert_init()
-	 *       INIT_DELAYED_WORK()
-	 *       schedule_delayed_work()
-	 *
-	 *
-	 * Also, mutex alone would not be enough to avoid scheduling of
-	 * del_wk work after it get flush from a call to devcd_free()
-	 * mentioned as below.
-	 *
-	 *	disabled_store()
-	 *        devcd_free()
-	 *          mutex_lock()             devcd_data_write()
-	 *          flush_delayed_work()
-	 *          mutex_unlock()
-	 *                                   mutex_lock()
-	 *                                   mod_delayed_work()
-	 *                                   mutex_unlock()
-	 * So, delete_work flag is required.
+	 * The second race involves multiple parallel invocations of devcd_free(),
+	 * add a deleted flag so only 1 can call the destructor.
 	 */
 	struct mutex mutex;
-	bool delete_work;
+	bool init_completed, deleted;
 	struct module *owner;
 	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen);
 	void (*free)(void *data);
+	/*
+	 * If nothing interferes and device_add() was returns success,
+	 * del_wk will destroy the device after the timer fires.
+	 *
+	 * Multiple userspace processes can interfere in the working of the timer:
+	 * - Writing to the coredump will reschedule the timer to run immediately,
+	 *   if still armed.
+	 *
+	 *   This is handled by using "if (cancel_delayed_work()) {
+	 *   schedule_delayed_work() }", to prevent re-arming after having
+	 *   been previously fired.
+	 * - Writing to /sys/class/devcoredump/disabled will destroy the
+	 *   coredump synchronously.
+	 *   This is handled by using disable_delayed_work_sync(), and then
+	 *   checking if deleted flag is set with &devcd->mutex held.
+	 */
 	struct delayed_work del_wk;
 	struct device *failing_dev;
 };
@@ -98,14 +94,27 @@ static void devcd_dev_release(struct device *dev)
 	kfree(devcd);
 }
 
+static void __devcd_del(struct devcd_entry *devcd)
+{
+	devcd->deleted = true;
+	device_del(&devcd->devcd_dev);
+	put_device(&devcd->devcd_dev);
+}
+
 static void devcd_del(struct work_struct *wk)
 {
 	struct devcd_entry *devcd;
+	bool init_completed;
 
 	devcd = container_of(wk, struct devcd_entry, del_wk.work);
 
-	device_del(&devcd->devcd_dev);
-	put_device(&devcd->devcd_dev);
+	/* devcd->mutex serializes against dev_coredumpm_timeout */
+	mutex_lock(&devcd->mutex);
+	init_completed = devcd->init_completed;
+	mutex_unlock(&devcd->mutex);
+
+	if (init_completed)
+		__devcd_del(devcd);
 }
 
 static ssize_t devcd_data_read(struct file *filp, struct kobject *kobj,
@@ -125,12 +134,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
-	mutex_lock(&devcd->mutex);
-	if (!devcd->delete_work) {
-		devcd->delete_work = true;
-		mod_delayed_work(system_wq, &devcd->del_wk, 0);
-	}
-	mutex_unlock(&devcd->mutex);
+	/*
+	 * Although it's tempting to use mod_delayed work here,
+	 * that will cause a reschedule if the timer already fired.
+	 */
+	if (cancel_delayed_work(&devcd->del_wk))
+		schedule_delayed_work(&devcd->del_wk, 0);
 
 	return count;
 }
@@ -158,11 +167,21 @@ static int devcd_free(struct device *dev, void *data)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
+	/*
+	 * To prevent a race with devcd_data_write(), cancel work and
+	 * complete manually instead.
+	 *
+	 * We cannot rely on the return value of
+	 * cancel_delayed_work_sync() here, because it might be in the
+	 * middle of a cancel_delayed_work + schedule_delayed_work pair.
+	 *
+	 * devcd->mutex here guards against multiple parallel invocations
+	 * of devcd_free().
+	 */
+	cancel_delayed_work_sync(&devcd->del_wk);
 	mutex_lock(&devcd->mutex);
-	if (!devcd->delete_work)
-		devcd->delete_work = true;
-
-	flush_delayed_work(&devcd->del_wk);
+	if (!devcd->deleted)
+		__devcd_del(devcd);
 	mutex_unlock(&devcd->mutex);
 	return 0;
 }
@@ -186,12 +205,10 @@ static ssize_t disabled_show(const struct class *class, const struct class_attri
  *                                                                 put_device() <- last reference
  *             error = fn(dev, data)                           devcd_dev_release()
  *             devcd_free(dev, data)                           kfree(devcd)
- *             mutex_lock(&devcd->mutex);
  *
  *
- * In the above diagram, It looks like disabled_store() would be racing with parallely
- * running devcd_del() and result in memory abort while acquiring devcd->mutex which
- * is called after kfree of devcd memory  after dropping its last reference with
+ * In the above diagram, it looks like disabled_store() would be racing with parallelly
+ * running devcd_del() and result in memory abort after dropping its last reference with
  * put_device(). However, this will not happens as fn(dev, data) runs
  * with its own reference to device via klist_node so it is not its last reference.
  * so, above situation would not occur.
@@ -352,7 +369,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	devcd->read = read;
 	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
-	devcd->delete_work = false;
+	devcd->deleted = false;
 
 	mutex_init(&devcd->mutex);
 	device_initialize(&devcd->devcd_dev);
@@ -361,8 +378,14 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 		     atomic_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
-	mutex_lock(&devcd->mutex);
 	dev_set_uevent_suppress(&devcd->devcd_dev, true);
+
+	/* devcd->mutex prevents devcd_del() completing until init finishes */
+	mutex_lock(&devcd->mutex);
+	devcd->init_completed = false;
+	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
+	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
+
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -379,13 +402,20 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 
 	dev_set_uevent_suppress(&devcd->devcd_dev, false);
 	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
-	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
-	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
+
+	/*
+	 * Safe to run devcd_del() now that we are done with devcd_dev.
+	 * Alternatively we could have taken a ref on devcd_dev before
+	 * dropping the lock.
+	 */
+	devcd->init_completed = true;
 	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
-	put_device(&devcd->devcd_dev);
 	mutex_unlock(&devcd->mutex);
+	cancel_delayed_work_sync(&devcd->del_wk);
+	put_device(&devcd->devcd_dev);
+
  put_module:
 	module_put(owner);
  free:
diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 393966c09740..ef38e9ad98f6 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -368,7 +368,7 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
 	unsigned int count = 0;
 	const unsigned int num_sample_bytes = comedi_bytes_per_sample(s);
 
-	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA)) {
+	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA) || async->cmd.chanlist_len == 0) {
 		async->munge_count += num_bytes;
 		return num_bytes;
 	}
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 92f9c00ad5f9..cafe6eed3349 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -230,20 +230,17 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	 *
 	 * This can deal with workloads that have long pauses interspersed
 	 * with sporadic activity with a bunch of short pauses.
+	 *
+	 * However, if the number of remaining samples is too small to exclude
+	 * any more outliers, allow the deepest available idle state to be
+	 * selected because there are systems where the time spent by CPUs in
+	 * deep idle states is correlated to the maximum frequency the CPUs
+	 * can get to.  On those systems, shallow idle states should be avoided
+	 * unless there is a clear indication that the given CPU is most likley
+	 * going to be woken up shortly.
 	 */
-	if (divisor * 4 <= INTERVALS * 3) {
-		/*
-		 * If there are sufficiently many data points still under
-		 * consideration after the outliers have been eliminated,
-		 * returning without a prediction would be a mistake because it
-		 * is likely that the next interval will not exceed the current
-		 * maximum, so return the latter in that case.
-		 */
-		if (divisor >= INTERVALS / 2)
-			return max;
-
+	if (divisor * 4 <= INTERVALS * 3)
 		return UINT_MAX;
-	}
 
 	thresh = max - 1;
 	goto again;
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 6c2234871215..dc95652fff40 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -321,10 +321,28 @@ enum debug_counters {
 	SCMI_DEBUG_COUNTERS_LAST
 };
 
-static inline void scmi_inc_count(atomic_t *arr, int stat)
+/**
+ * struct scmi_debug_info  - Debug common info
+ * @top_dentry: A reference to the top debugfs dentry
+ * @name: Name of this SCMI instance
+ * @type: Type of this SCMI instance
+ * @is_atomic: Flag to state if the transport of this instance is atomic
+ * @counters: An array of atomic_c's used for tracking statistics (if enabled)
+ */
+struct scmi_debug_info {
+	struct dentry *top_dentry;
+	const char *name;
+	const char *type;
+	bool is_atomic;
+	atomic_t counters[SCMI_DEBUG_COUNTERS_LAST];
+};
+
+static inline void scmi_inc_count(struct scmi_debug_info *dbg, int stat)
 {
-	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS))
-		atomic_inc(&arr[stat]);
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS)) {
+		if (dbg)
+			atomic_inc(&dbg->counters[stat]);
+	}
 }
 
 enum scmi_bad_msg {
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index d1fd2e492909..fbe893734411 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -102,22 +102,6 @@ struct scmi_protocol_instance {
 
 #define ph_to_pi(h)	container_of(h, struct scmi_protocol_instance, ph)
 
-/**
- * struct scmi_debug_info  - Debug common info
- * @top_dentry: A reference to the top debugfs dentry
- * @name: Name of this SCMI instance
- * @type: Type of this SCMI instance
- * @is_atomic: Flag to state if the transport of this instance is atomic
- * @counters: An array of atomic_c's used for tracking statistics (if enabled)
- */
-struct scmi_debug_info {
-	struct dentry *top_dentry;
-	const char *name;
-	const char *type;
-	bool is_atomic;
-	atomic_t counters[SCMI_DEBUG_COUNTERS_LAST];
-};
-
 /**
  * struct scmi_info - Structure representing a SCMI instance
  *
@@ -643,6 +627,7 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 			hash_del(&xfer->node);
 			xfer->pending = false;
 		}
+		xfer->flags = 0;
 		hlist_add_head(&xfer->node, &minfo->free_xfers);
 	}
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
@@ -661,8 +646,6 @@ void scmi_xfer_raw_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
-	xfer->flags &= ~SCMI_XFER_FLAG_IS_RAW;
-	xfer->flags &= ~SCMI_XFER_FLAG_CHAN_SET;
 	return __scmi_xfer_put(&info->tx_minfo, xfer);
 }
 
@@ -856,7 +839,7 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_UNEXPECTED);
-		scmi_inc_count(info->dbg->counters, ERR_MSG_UNEXPECTED);
+		scmi_inc_count(info->dbg, ERR_MSG_UNEXPECTED);
 
 		return xfer;
 	}
@@ -884,7 +867,7 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 			msg_type, xfer_id, msg_hdr, xfer->state);
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_INVALID);
-		scmi_inc_count(info->dbg->counters, ERR_MSG_INVALID);
+		scmi_inc_count(info->dbg, ERR_MSG_INVALID);
 
 
 		/* On error the refcount incremented above has to be dropped */
@@ -930,7 +913,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 			PTR_ERR(xfer));
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_NOMEM);
-		scmi_inc_count(info->dbg->counters, ERR_MSG_NOMEM);
+		scmi_inc_count(info->dbg, ERR_MSG_NOMEM);
 
 		scmi_clear_channel(info, cinfo);
 		return;
@@ -946,7 +929,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
 			    xfer->hdr.id, "NOTI", xfer->hdr.seq,
 			    xfer->hdr.status, xfer->rx.buf, xfer->rx.len);
-	scmi_inc_count(info->dbg->counters, NOTIFICATION_OK);
+	scmi_inc_count(info->dbg, NOTIFICATION_OK);
 
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
 		    xfer->hdr.id, xfer->rx.buf, xfer->rx.len, ts);
@@ -1006,10 +989,10 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
 		scmi_clear_channel(info, cinfo);
 		complete(xfer->async_done);
-		scmi_inc_count(info->dbg->counters, DELAYED_RESPONSE_OK);
+		scmi_inc_count(info->dbg, DELAYED_RESPONSE_OK);
 	} else {
 		complete(&xfer->done);
-		scmi_inc_count(info->dbg->counters, RESPONSE_OK);
+		scmi_inc_count(info->dbg, RESPONSE_OK);
 	}
 
 	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
@@ -1117,7 +1100,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					"timed out in resp(caller: %pS) - polling\n",
 					(void *)_RET_IP_);
 				ret = -ETIMEDOUT;
-				scmi_inc_count(info->dbg->counters, XFERS_RESPONSE_POLLED_TIMEOUT);
+				scmi_inc_count(info->dbg, XFERS_RESPONSE_POLLED_TIMEOUT);
 			}
 		}
 
@@ -1142,7 +1125,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					    "RESP" : "resp",
 					    xfer->hdr.seq, xfer->hdr.status,
 					    xfer->rx.buf, xfer->rx.len);
-			scmi_inc_count(info->dbg->counters, RESPONSE_POLLED_OK);
+			scmi_inc_count(info->dbg, RESPONSE_POLLED_OK);
 
 			if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
 				struct scmi_info *info =
@@ -1160,7 +1143,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 			dev_err(dev, "timed out in resp(caller: %pS)\n",
 				(void *)_RET_IP_);
 			ret = -ETIMEDOUT;
-			scmi_inc_count(info->dbg->counters, XFERS_RESPONSE_TIMEOUT);
+			scmi_inc_count(info->dbg, XFERS_RESPONSE_TIMEOUT);
 		}
 	}
 
@@ -1244,13 +1227,13 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	    !is_transport_polling_capable(info->desc)) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
-		scmi_inc_count(info->dbg->counters, SENT_FAIL_POLLING_UNSUPPORTED);
+		scmi_inc_count(info->dbg, SENT_FAIL_POLLING_UNSUPPORTED);
 		return -EINVAL;
 	}
 
 	cinfo = idr_find(&info->tx_idr, pi->proto->id);
 	if (unlikely(!cinfo)) {
-		scmi_inc_count(info->dbg->counters, SENT_FAIL_CHANNEL_NOT_FOUND);
+		scmi_inc_count(info->dbg, SENT_FAIL_CHANNEL_NOT_FOUND);
 		return -EINVAL;
 	}
 	/* True ONLY if also supported by transport. */
@@ -1284,19 +1267,19 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	ret = info->desc->ops->send_message(cinfo, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "Failed to send message %d\n", ret);
-		scmi_inc_count(info->dbg->counters, SENT_FAIL);
+		scmi_inc_count(info->dbg, SENT_FAIL);
 		return ret;
 	}
 
 	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
 			    xfer->hdr.id, "CMND", xfer->hdr.seq,
 			    xfer->hdr.status, xfer->tx.buf, xfer->tx.len);
-	scmi_inc_count(info->dbg->counters, SENT_OK);
+	scmi_inc_count(info->dbg, SENT_OK);
 
 	ret = scmi_wait_for_message_response(cinfo, xfer);
 	if (!ret && xfer->hdr.status) {
 		ret = scmi_to_linux_errno(xfer->hdr.status);
-		scmi_inc_count(info->dbg->counters, ERR_PROTOCOL);
+		scmi_inc_count(info->dbg, ERR_PROTOCOL);
 	}
 
 	if (info->desc->ops->mark_txdone)
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ebd4e113dc26..de051a085e63 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1313,9 +1313,9 @@ config GPIO_KEMPLD
 
 config GPIO_LJCA
 	tristate "INTEL La Jolla Cove Adapter GPIO support"
-	depends on MFD_LJCA
+	depends on USB_LJCA
 	select GPIOLIB_IRQCHIP
-	default MFD_LJCA
+	default USB_LJCA
 	help
 	  Select this option to enable GPIO driver for the INTEL
 	  La Jolla Cove Adapter (LJCA) board.
diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index f03ccd0f534c..f60872d1e8a5 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -59,6 +59,7 @@ static const struct regmap_config idio_16_regmap_config = {
 	.reg_stride = 1,
 	.val_bits = 8,
 	.io_port = true,
+	.max_register = 0x5,
 	.wr_table = &idio_16_wr_table,
 	.rd_table = &idio_16_rd_table,
 	.volatile_table = &idio_16_rd_table,
diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
index 87863f0230f5..c3a595c6f6c7 100644
--- a/drivers/gpio/gpio-ljca.c
+++ b/drivers/gpio/gpio-ljca.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/dev_printk.h>
@@ -13,19 +14,18 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
-#include <linux/mfd/ljca.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/usb/ljca.h>
 
 /* GPIO commands */
-#define LJCA_GPIO_CONFIG	1
-#define LJCA_GPIO_READ		2
-#define LJCA_GPIO_WRITE		3
-#define LJCA_GPIO_INT_EVENT	4
-#define LJCA_GPIO_INT_MASK	5
-#define LJCA_GPIO_INT_UNMASK	6
+#define LJCA_GPIO_CONFIG		1
+#define LJCA_GPIO_READ			2
+#define LJCA_GPIO_WRITE			3
+#define LJCA_GPIO_INT_EVENT		4
+#define LJCA_GPIO_INT_MASK		5
+#define LJCA_GPIO_INT_UNMASK		6
 
 #define LJCA_GPIO_CONF_DISABLE		BIT(0)
 #define LJCA_GPIO_CONF_INPUT		BIT(1)
@@ -36,89 +36,93 @@
 #define LJCA_GPIO_CONF_INTERRUPT	BIT(6)
 #define LJCA_GPIO_INT_TYPE		BIT(7)
 
-#define LJCA_GPIO_CONF_EDGE	FIELD_PREP(LJCA_GPIO_INT_TYPE, 1)
-#define LJCA_GPIO_CONF_LEVEL	FIELD_PREP(LJCA_GPIO_INT_TYPE, 0)
+#define LJCA_GPIO_CONF_EDGE		FIELD_PREP(LJCA_GPIO_INT_TYPE, 1)
+#define LJCA_GPIO_CONF_LEVEL		FIELD_PREP(LJCA_GPIO_INT_TYPE, 0)
 
 /* Intentional overlap with PULLUP / PULLDOWN */
-#define LJCA_GPIO_CONF_SET	BIT(3)
-#define LJCA_GPIO_CONF_CLR	BIT(4)
+#define LJCA_GPIO_CONF_SET		BIT(3)
+#define LJCA_GPIO_CONF_CLR		BIT(4)
 
-struct gpio_op {
+#define LJCA_GPIO_BUF_SIZE		60u
+
+struct ljca_gpio_op {
 	u8 index;
 	u8 value;
 } __packed;
 
-struct gpio_packet {
+struct ljca_gpio_packet {
 	u8 num;
-	struct gpio_op item[];
+	struct ljca_gpio_op item[] __counted_by(num);
 } __packed;
 
-#define LJCA_GPIO_BUF_SIZE 60
 struct ljca_gpio_dev {
-	struct platform_device *pdev;
+	struct ljca_client *ljca;
 	struct gpio_chip gc;
 	struct ljca_gpio_info *gpio_info;
 	DECLARE_BITMAP(unmasked_irqs, LJCA_MAX_GPIO_NUM);
 	DECLARE_BITMAP(enabled_irqs, LJCA_MAX_GPIO_NUM);
 	DECLARE_BITMAP(reenable_irqs, LJCA_MAX_GPIO_NUM);
+	DECLARE_BITMAP(output_enabled, LJCA_MAX_GPIO_NUM);
 	u8 *connect_mode;
-	/* mutex to protect irq bus */
+	/* protect irq bus */
 	struct mutex irq_lock;
 	struct work_struct work;
-	/* lock to protect package transfer to Hardware */
+	/* protect package transfer to hardware */
 	struct mutex trans_lock;
 
 	u8 obuf[LJCA_GPIO_BUF_SIZE];
 	u8 ibuf[LJCA_GPIO_BUF_SIZE];
 };
 
-static int gpio_config(struct ljca_gpio_dev *ljca_gpio, u8 gpio_id, u8 config)
+static int ljca_gpio_config(struct ljca_gpio_dev *ljca_gpio, u8 gpio_id,
+			    u8 config)
 {
-	struct gpio_packet *packet = (struct gpio_packet *)ljca_gpio->obuf;
+	struct ljca_gpio_packet *packet =
+				(struct ljca_gpio_packet *)ljca_gpio->obuf;
 	int ret;
 
 	mutex_lock(&ljca_gpio->trans_lock);
+	packet->num = 1;
 	packet->item[0].index = gpio_id;
 	packet->item[0].value = config | ljca_gpio->connect_mode[gpio_id];
-	packet->num = 1;
 
-	ret = ljca_transfer(ljca_gpio->gpio_info->ljca, LJCA_GPIO_CONFIG, packet,
-			    struct_size(packet, item, packet->num), NULL, NULL);
+	ret = ljca_transfer(ljca_gpio->ljca, LJCA_GPIO_CONFIG, (u8 *)packet,
+			    struct_size(packet, item, packet->num), NULL, 0);
 	mutex_unlock(&ljca_gpio->trans_lock);
-	return ret;
+
+	return ret < 0 ? ret : 0;
 }
 
 static int ljca_gpio_read(struct ljca_gpio_dev *ljca_gpio, u8 gpio_id)
 {
-	struct gpio_packet *packet = (struct gpio_packet *)ljca_gpio->obuf;
-	struct gpio_packet *ack_packet = (struct gpio_packet *)ljca_gpio->ibuf;
-	unsigned int ibuf_len = LJCA_GPIO_BUF_SIZE;
+	struct ljca_gpio_packet *ack_packet =
+				(struct ljca_gpio_packet *)ljca_gpio->ibuf;
+	struct ljca_gpio_packet *packet =
+				(struct ljca_gpio_packet *)ljca_gpio->obuf;
 	int ret;
 
 	mutex_lock(&ljca_gpio->trans_lock);
 	packet->num = 1;
 	packet->item[0].index = gpio_id;
-	ret = ljca_transfer(ljca_gpio->gpio_info->ljca, LJCA_GPIO_READ, packet,
-			    struct_size(packet, item, packet->num), ljca_gpio->ibuf, &ibuf_len);
-	if (ret)
-		goto out_unlock;
-
-	if (!ibuf_len || ack_packet->num != packet->num) {
-		dev_err(&ljca_gpio->pdev->dev, "failed gpio_id:%u %u", gpio_id, ack_packet->num);
-		ret = -EIO;
+	ret = ljca_transfer(ljca_gpio->ljca, LJCA_GPIO_READ, (u8 *)packet,
+			    struct_size(packet, item, packet->num),
+			    ljca_gpio->ibuf, LJCA_GPIO_BUF_SIZE);
+
+	if (ret <= 0 || ack_packet->num != packet->num) {
+		dev_err(&ljca_gpio->ljca->auxdev.dev,
+			"read package error, gpio_id: %u num: %u ret: %d\n",
+			gpio_id, ack_packet->num, ret);
+		ret = ret < 0 ? ret : -EIO;
 	}
-
-out_unlock:
 	mutex_unlock(&ljca_gpio->trans_lock);
-	if (ret)
-		return ret;
-	return ack_packet->item[0].value > 0;
+
+	return ret < 0 ? ret : ack_packet->item[0].value > 0;
 }
 
-static int ljca_gpio_write(struct ljca_gpio_dev *ljca_gpio, u8 gpio_id,
-			   int value)
+static int ljca_gpio_write(struct ljca_gpio_dev *ljca_gpio, u8 gpio_id, int value)
 {
-	struct gpio_packet *packet = (struct gpio_packet *)ljca_gpio->obuf;
+	struct ljca_gpio_packet *packet =
+			(struct ljca_gpio_packet *)ljca_gpio->obuf;
 	int ret;
 
 	mutex_lock(&ljca_gpio->trans_lock);
@@ -126,10 +130,11 @@ static int ljca_gpio_write(struct ljca_gpio_dev *ljca_gpio, u8 gpio_id,
 	packet->item[0].index = gpio_id;
 	packet->item[0].value = value & 1;
 
-	ret = ljca_transfer(ljca_gpio->gpio_info->ljca, LJCA_GPIO_WRITE, packet,
-			    struct_size(packet, item, packet->num), NULL, NULL);
+	ret = ljca_transfer(ljca_gpio->ljca, LJCA_GPIO_WRITE, (u8 *)packet,
+			    struct_size(packet, item, packet->num), NULL, 0);
 	mutex_unlock(&ljca_gpio->trans_lock);
-	return ret;
+
+	return ret < 0 ? ret : 0;
 }
 
 static int ljca_gpio_get_value(struct gpio_chip *chip, unsigned int offset)
@@ -147,16 +152,24 @@ static void ljca_gpio_set_value(struct gpio_chip *chip, unsigned int offset,
 
 	ret = ljca_gpio_write(ljca_gpio, offset, val);
 	if (ret)
-		dev_err(chip->parent, "offset:%u val:%d set value failed %d\n", offset, val, ret);
+		dev_err(chip->parent,
+			"set value failed offset: %u val: %d ret: %d\n",
+			offset, val, ret);
 }
 
-static int ljca_gpio_direction_input(struct gpio_chip *chip,
-				     unsigned int offset)
+static int ljca_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct ljca_gpio_dev *ljca_gpio = gpiochip_get_data(chip);
 	u8 config = LJCA_GPIO_CONF_INPUT | LJCA_GPIO_CONF_CLR;
+	int ret;
 
-	return gpio_config(ljca_gpio, offset, config);
+	ret = ljca_gpio_config(ljca_gpio, offset, config);
+	if (ret)
+		return ret;
+
+	clear_bit(offset, ljca_gpio->output_enabled);
+
+	return 0;
 }
 
 static int ljca_gpio_direction_output(struct gpio_chip *chip,
@@ -166,14 +179,26 @@ static int ljca_gpio_direction_output(struct gpio_chip *chip,
 	u8 config = LJCA_GPIO_CONF_OUTPUT | LJCA_GPIO_CONF_CLR;
 	int ret;
 
-	ret = gpio_config(ljca_gpio, offset, config);
+	ret = ljca_gpio_config(ljca_gpio, offset, config);
 	if (ret)
 		return ret;
 
 	ljca_gpio_set_value(chip, offset, val);
+	set_bit(offset, ljca_gpio->output_enabled);
+
 	return 0;
 }
 
+static int ljca_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ljca_gpio_dev *ljca_gpio = gpiochip_get_data(chip);
+
+	if (test_bit(offset, ljca_gpio->output_enabled))
+		return GPIO_LINE_DIRECTION_OUT;
+
+	return GPIO_LINE_DIRECTION_IN;
+}
+
 static int ljca_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 				unsigned long config)
 {
@@ -197,7 +222,8 @@ static int ljca_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	return 0;
 }
 
-static int ljca_gpio_init_valid_mask(struct gpio_chip *chip, unsigned long *valid_mask,
+static int ljca_gpio_init_valid_mask(struct gpio_chip *chip,
+				     unsigned long *valid_mask,
 				     unsigned int ngpios)
 {
 	struct ljca_gpio_dev *ljca_gpio = gpiochip_get_data(chip);
@@ -208,15 +234,18 @@ static int ljca_gpio_init_valid_mask(struct gpio_chip *chip, unsigned long *vali
 	return 0;
 }
 
-static void ljca_gpio_irq_init_valid_mask(struct gpio_chip *chip, unsigned long *valid_mask,
+static void ljca_gpio_irq_init_valid_mask(struct gpio_chip *chip,
+					  unsigned long *valid_mask,
 					  unsigned int ngpios)
 {
 	ljca_gpio_init_valid_mask(chip, valid_mask, ngpios);
 }
 
-static int ljca_enable_irq(struct ljca_gpio_dev *ljca_gpio, int gpio_id, bool enable)
+static int ljca_enable_irq(struct ljca_gpio_dev *ljca_gpio, int gpio_id,
+			   bool enable)
 {
-	struct gpio_packet *packet = (struct gpio_packet *)ljca_gpio->obuf;
+	struct ljca_gpio_packet *packet =
+			(struct ljca_gpio_packet *)ljca_gpio->obuf;
 	int ret;
 
 	mutex_lock(&ljca_gpio->trans_lock);
@@ -224,18 +253,20 @@ static int ljca_enable_irq(struct ljca_gpio_dev *ljca_gpio, int gpio_id, bool en
 	packet->item[0].index = gpio_id;
 	packet->item[0].value = 0;
 
-	ret = ljca_transfer(ljca_gpio->gpio_info->ljca,
-			    enable ? LJCA_GPIO_INT_UNMASK : LJCA_GPIO_INT_MASK, packet,
-			    struct_size(packet, item, packet->num), NULL, NULL);
+	ret = ljca_transfer(ljca_gpio->ljca,
+			    enable ? LJCA_GPIO_INT_UNMASK : LJCA_GPIO_INT_MASK,
+			    (u8 *)packet, struct_size(packet, item, packet->num),
+			    NULL, 0);
 	mutex_unlock(&ljca_gpio->trans_lock);
-	return ret;
+
+	return ret < 0 ? ret : 0;
 }
 
 static void ljca_gpio_async(struct work_struct *work)
 {
-	struct ljca_gpio_dev *ljca_gpio = container_of(work, struct ljca_gpio_dev, work);
-	int gpio_id;
-	int unmasked;
+	struct ljca_gpio_dev *ljca_gpio =
+			container_of(work, struct ljca_gpio_dev, work);
+	int gpio_id, unmasked;
 
 	for_each_set_bit(gpio_id, ljca_gpio->reenable_irqs, ljca_gpio->gc.ngpio) {
 		clear_bit(gpio_id, ljca_gpio->reenable_irqs);
@@ -245,25 +276,19 @@ static void ljca_gpio_async(struct work_struct *work)
 	}
 }
 
-static void ljca_gpio_event_cb(void *context, u8 cmd, const void *evt_data, int len)
+static void ljca_gpio_event_cb(void *context, u8 cmd, const void *evt_data,
+			       int len)
 {
-	const struct gpio_packet *packet = evt_data;
+	const struct ljca_gpio_packet *packet = evt_data;
 	struct ljca_gpio_dev *ljca_gpio = context;
 	int i;
-	int irq;
 
 	if (cmd != LJCA_GPIO_INT_EVENT)
 		return;
 
 	for (i = 0; i < packet->num; i++) {
-		irq = irq_find_mapping(ljca_gpio->gc.irq.domain, packet->item[i].index);
-		if (!irq) {
-			dev_err(ljca_gpio->gc.parent, "gpio_id %u does not mapped to IRQ yet\n",
-				packet->item[i].index);
-			return;
-		}
-
-		generic_handle_domain_irq(ljca_gpio->gc.irq.domain, irq);
+		generic_handle_domain_irq(ljca_gpio->gc.irq.domain,
+					packet->item[i].index);
 		set_bit(packet->item[i].index, ljca_gpio->reenable_irqs);
 	}
 
@@ -299,18 +324,22 @@ static int ljca_irq_set_type(struct irq_data *irqd, unsigned int type)
 	ljca_gpio->connect_mode[gpio_id] = LJCA_GPIO_CONF_INTERRUPT;
 	switch (type) {
 	case IRQ_TYPE_LEVEL_HIGH:
-		ljca_gpio->connect_mode[gpio_id] |= (LJCA_GPIO_CONF_LEVEL | LJCA_GPIO_CONF_PULLUP);
+		ljca_gpio->connect_mode[gpio_id] |=
+			(LJCA_GPIO_CONF_LEVEL | LJCA_GPIO_CONF_PULLUP);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		ljca_gpio->connect_mode[gpio_id] |= (LJCA_GPIO_CONF_LEVEL | LJCA_GPIO_CONF_PULLDOWN);
+		ljca_gpio->connect_mode[gpio_id] |=
+			(LJCA_GPIO_CONF_LEVEL | LJCA_GPIO_CONF_PULLDOWN);
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
 		break;
 	case IRQ_TYPE_EDGE_RISING:
-		ljca_gpio->connect_mode[gpio_id] |= (LJCA_GPIO_CONF_EDGE | LJCA_GPIO_CONF_PULLUP);
+		ljca_gpio->connect_mode[gpio_id] |=
+			(LJCA_GPIO_CONF_EDGE | LJCA_GPIO_CONF_PULLUP);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		ljca_gpio->connect_mode[gpio_id] |= (LJCA_GPIO_CONF_EDGE | LJCA_GPIO_CONF_PULLDOWN);
+		ljca_gpio->connect_mode[gpio_id] |=
+			(LJCA_GPIO_CONF_EDGE | LJCA_GPIO_CONF_PULLDOWN);
 		break;
 	default:
 		return -EINVAL;
@@ -332,15 +361,14 @@ static void ljca_irq_bus_unlock(struct irq_data *irqd)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
 	struct ljca_gpio_dev *ljca_gpio = gpiochip_get_data(gc);
 	int gpio_id = irqd_to_hwirq(irqd);
-	int enabled;
-	int unmasked;
+	int enabled, unmasked;
 
 	enabled = test_bit(gpio_id, ljca_gpio->enabled_irqs);
 	unmasked = test_bit(gpio_id, ljca_gpio->unmasked_irqs);
 
 	if (enabled != unmasked) {
 		if (unmasked) {
-			gpio_config(ljca_gpio, gpio_id, 0);
+			ljca_gpio_config(ljca_gpio, gpio_id, 0);
 			ljca_enable_irq(ljca_gpio, gpio_id, true);
 			set_bit(gpio_id, ljca_gpio->enabled_irqs);
 		} else {
@@ -363,43 +391,48 @@ static const struct irq_chip ljca_gpio_irqchip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-static int ljca_gpio_probe(struct platform_device *pdev)
+static int ljca_gpio_probe(struct auxiliary_device *auxdev,
+			   const struct auxiliary_device_id *aux_dev_id)
 {
+	struct ljca_client *ljca = auxiliary_dev_to_ljca_client(auxdev);
 	struct ljca_gpio_dev *ljca_gpio;
 	struct gpio_irq_chip *girq;
 	int ret;
 
-	ljca_gpio = devm_kzalloc(&pdev->dev, sizeof(*ljca_gpio), GFP_KERNEL);
+	ljca_gpio = devm_kzalloc(&auxdev->dev, sizeof(*ljca_gpio), GFP_KERNEL);
 	if (!ljca_gpio)
 		return -ENOMEM;
 
-	ljca_gpio->gpio_info = dev_get_platdata(&pdev->dev);
-	ljca_gpio->connect_mode = devm_kcalloc(&pdev->dev, ljca_gpio->gpio_info->num,
-					       sizeof(*ljca_gpio->connect_mode), GFP_KERNEL);
+	ljca_gpio->ljca = ljca;
+	ljca_gpio->gpio_info = dev_get_platdata(&auxdev->dev);
+	ljca_gpio->connect_mode = devm_kcalloc(&auxdev->dev,
+					       ljca_gpio->gpio_info->num,
+					       sizeof(*ljca_gpio->connect_mode),
+					       GFP_KERNEL);
 	if (!ljca_gpio->connect_mode)
 		return -ENOMEM;
 
 	mutex_init(&ljca_gpio->irq_lock);
 	mutex_init(&ljca_gpio->trans_lock);
-	ljca_gpio->pdev = pdev;
 	ljca_gpio->gc.direction_input = ljca_gpio_direction_input;
 	ljca_gpio->gc.direction_output = ljca_gpio_direction_output;
+	ljca_gpio->gc.get_direction = ljca_gpio_get_direction;
 	ljca_gpio->gc.get = ljca_gpio_get_value;
 	ljca_gpio->gc.set = ljca_gpio_set_value;
 	ljca_gpio->gc.set_config = ljca_gpio_set_config;
 	ljca_gpio->gc.init_valid_mask = ljca_gpio_init_valid_mask;
 	ljca_gpio->gc.can_sleep = true;
-	ljca_gpio->gc.parent = &pdev->dev;
+	ljca_gpio->gc.parent = &auxdev->dev;
 
 	ljca_gpio->gc.base = -1;
 	ljca_gpio->gc.ngpio = ljca_gpio->gpio_info->num;
-	ljca_gpio->gc.label = ACPI_COMPANION(&pdev->dev) ?
-			      acpi_dev_name(ACPI_COMPANION(&pdev->dev)) :
-			      dev_name(&pdev->dev);
+	ljca_gpio->gc.label = ACPI_COMPANION(&auxdev->dev) ?
+			      acpi_dev_name(ACPI_COMPANION(&auxdev->dev)) :
+			      dev_name(&auxdev->dev);
 	ljca_gpio->gc.owner = THIS_MODULE;
 
-	platform_set_drvdata(pdev, ljca_gpio);
-	ljca_register_event_cb(ljca_gpio->gpio_info->ljca, ljca_gpio_event_cb, ljca_gpio);
+	auxiliary_set_drvdata(auxdev, ljca_gpio);
+	ljca_register_event_cb(ljca, ljca_gpio_event_cb, ljca_gpio);
 
 	girq = &ljca_gpio->gc.irq;
 	gpio_irq_chip_set_chip(girq, &ljca_gpio_irqchip);
@@ -413,7 +446,7 @@ static int ljca_gpio_probe(struct platform_device *pdev)
 	INIT_WORK(&ljca_gpio->work, ljca_gpio_async);
 	ret = gpiochip_add_data(&ljca_gpio->gc, ljca_gpio);
 	if (ret) {
-		ljca_unregister_event_cb(ljca_gpio->gpio_info->ljca);
+		ljca_unregister_event_cb(ljca);
 		mutex_destroy(&ljca_gpio->irq_lock);
 		mutex_destroy(&ljca_gpio->trans_lock);
 	}
@@ -421,34 +454,33 @@ static int ljca_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ljca_gpio_remove(struct platform_device *pdev)
+static void ljca_gpio_remove(struct auxiliary_device *auxdev)
 {
-	struct ljca_gpio_dev *ljca_gpio = platform_get_drvdata(pdev);
+	struct ljca_gpio_dev *ljca_gpio = auxiliary_get_drvdata(auxdev);
 
 	gpiochip_remove(&ljca_gpio->gc);
-	ljca_unregister_event_cb(ljca_gpio->gpio_info->ljca);
+	ljca_unregister_event_cb(ljca_gpio->ljca);
+	cancel_work_sync(&ljca_gpio->work);
 	mutex_destroy(&ljca_gpio->irq_lock);
 	mutex_destroy(&ljca_gpio->trans_lock);
-	return 0;
 }
 
-#define LJCA_GPIO_DRV_NAME "ljca-gpio"
-static const struct platform_device_id ljca_gpio_id[] = {
-	{ LJCA_GPIO_DRV_NAME, 0 },
-	{ /* sentinel */ }
+static const struct auxiliary_device_id ljca_gpio_id_table[] = {
+	{ "usb_ljca.ljca-gpio", 0 },
+	{ /* sentinel */ },
 };
-MODULE_DEVICE_TABLE(platform, ljca_gpio_id);
+MODULE_DEVICE_TABLE(auxiliary, ljca_gpio_id_table);
 
-static struct platform_driver ljca_gpio_driver = {
-	.driver.name = LJCA_GPIO_DRV_NAME,
+static struct auxiliary_driver ljca_gpio_driver = {
 	.probe = ljca_gpio_probe,
 	.remove = ljca_gpio_remove,
+	.id_table = ljca_gpio_id_table,
 };
-module_platform_driver(ljca_gpio_driver);
+module_auxiliary_driver(ljca_gpio_driver);
 
-MODULE_AUTHOR("Ye Xiang <xiang.ye@intel.com>");
-MODULE_AUTHOR("Wang Zhifeng <zhifeng.wang@intel.com>");
-MODULE_AUTHOR("Zhang Lixu <lixu.zhang@intel.com>");
+MODULE_AUTHOR("Wentong Wu <wentong.wu@intel.com>");
+MODULE_AUTHOR("Zhifeng Wang <zhifeng.wang@intel.com>");
+MODULE_AUTHOR("Lixu Zhang <lixu.zhang@intel.com>");
 MODULE_DESCRIPTION("Intel La Jolla Cove Adapter USB-GPIO driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(LJCA);
diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 44c0a21b1d1d..5827b18d190b 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -41,6 +41,7 @@ static const struct regmap_config idio_16_regmap_config = {
 	.reg_stride = 1,
 	.val_bits = 8,
 	.io_port = true,
+	.max_register = 0x7,
 	.wr_table = &idio_16_wr_table,
 	.rd_table = &idio_16_rd_table,
 	.volatile_table = &idio_16_rd_table,
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 79657910b79e..d8a86e60cf8c 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -288,24 +288,26 @@ static struct sht3x_data *sht3x_update_client(struct device *dev)
 	return data;
 }
 
-static int temp1_input_read(struct device *dev)
+static int temp1_input_read(struct device *dev, long *temp)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return data->temperature;
+	*temp = data->temperature;
+	return 0;
 }
 
-static int humidity1_input_read(struct device *dev)
+static int humidity1_input_read(struct device *dev, long *humidity)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return data->humidity;
+	*humidity = data->humidity;
+	return 0;
 }
 
 /*
@@ -703,6 +705,7 @@ static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long *val)
 {
 	enum sht3x_limits index;
+	int ret;
 
 	switch (type) {
 	case hwmon_chip:
@@ -717,10 +720,12 @@ static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_input:
-			*val = temp1_input_read(dev);
-			break;
+			return temp1_input_read(dev, val);
 		case hwmon_temp_alarm:
-			*val = temp1_alarm_read(dev);
+			ret = temp1_alarm_read(dev);
+			if (ret < 0)
+				return ret;
+			*val = ret;
 			break;
 		case hwmon_temp_max:
 			index = limit_max;
@@ -745,10 +750,12 @@ static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_humidity:
 		switch (attr) {
 		case hwmon_humidity_input:
-			*val = humidity1_input_read(dev);
-			break;
+			return humidity1_input_read(dev, val);
 		case hwmon_humidity_alarm:
-			*val = humidity1_alarm_read(dev);
+			ret = humidity1_alarm_read(dev);
+			if (ret < 0)
+				return ret;
+			*val = ret;
 			break;
 		case hwmon_humidity_max:
 			index = limit_max;
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a85442d74e09..c110fb606dfb 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -383,6 +383,8 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 	}
 	spin_unlock(&fl->lock);
 
+	dma_buf_put(buf);
+
 	return ret;
 }
 
diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index 015927665678..00ed2147113e 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -44,6 +44,9 @@ static void lkdtm_FORTIFY_STR_MEMBER(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+	if (!src)
+		return;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
@@ -109,6 +112,9 @@ static void lkdtm_FORTIFY_MEM_MEMBER(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+	if (!src)
+		return;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 4adfa5af162f..fcfc6c7e6dc8 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -120,6 +120,8 @@
 #define MEI_DEV_ID_PTL_H      0xE370  /* Panther Lake H */
 #define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
 
+#define MEI_DEV_ID_WCL_P      0x4D70  /* Wildcat Lake P */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 93b98a7f4c7f..1a1df0390a40 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -127,6 +127,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_H, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_WCL_P, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 485d5ca39951..988e33f27970 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -929,6 +929,10 @@ static void release_mdev(struct device *dev)
 {
 	struct most_dev *mdev = to_mdev_from_dev(dev);
 
+	kfree(mdev->busy_urbs);
+	kfree(mdev->cap);
+	kfree(mdev->conf);
+	kfree(mdev->ep_address);
 	kfree(mdev);
 }
 /**
@@ -1093,7 +1097,7 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 err_free_conf:
 	kfree(mdev->conf);
 err_free_mdev:
-	put_device(&mdev->dev);
+	kfree(mdev);
 	return ret;
 }
 
@@ -1121,13 +1125,6 @@ static void hdm_disconnect(struct usb_interface *interface)
 	if (mdev->dci)
 		device_unregister(&mdev->dci->dev);
 	most_deregister_interface(&mdev->iface);
-
-	kfree(mdev->busy_urbs);
-	kfree(mdev->cap);
-	kfree(mdev->conf);
-	kfree(mdev->ep_address);
-	put_device(&mdev->dci->dev);
-	put_device(&mdev->dev);
 }
 
 static int hdm_suspend(struct usb_interface *interface, pm_message_t message)
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f7ed129fc811..9aa328b958be 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2874,7 +2874,7 @@ static void bond_mii_monitor(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
 					    mii_work.work);
-	bool should_notify_peers = false;
+	bool should_notify_peers;
 	bool commit;
 	unsigned long delay;
 	struct slave *slave;
@@ -2886,30 +2886,33 @@ static void bond_mii_monitor(struct work_struct *work)
 		goto re_arm;
 
 	rcu_read_lock();
+
 	should_notify_peers = bond_should_notify_peers(bond);
 	commit = !!bond_miimon_inspect(bond);
-	if (bond->send_peer_notif) {
-		rcu_read_unlock();
-		if (rtnl_trylock()) {
-			bond->send_peer_notif--;
-			rtnl_unlock();
-		}
-	} else {
-		rcu_read_unlock();
-	}
 
-	if (commit) {
+	rcu_read_unlock();
+
+	if (commit || bond->send_peer_notif) {
 		/* Race avoidance with bond_close cancel of workqueue */
 		if (!rtnl_trylock()) {
 			delay = 1;
-			should_notify_peers = false;
 			goto re_arm;
 		}
 
-		bond_for_each_slave(bond, slave, iter) {
-			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
+		if (commit) {
+			bond_for_each_slave(bond, slave, iter) {
+				bond_commit_link_state(slave,
+						       BOND_SLAVE_NOTIFY_LATER);
+			}
+			bond_miimon_commit(bond);
+		}
+
+		if (bond->send_peer_notif) {
+			bond->send_peer_notif--;
+			if (should_notify_peers)
+				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
+							 bond->dev);
 		}
-		bond_miimon_commit(bond);
 
 		rtnl_unlock();	/* might sleep, hold no other locks */
 	}
@@ -2917,13 +2920,6 @@ static void bond_mii_monitor(struct work_struct *work)
 re_arm:
 	if (bond->params.miimon)
 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
-
-	if (should_notify_peers) {
-		if (!rtnl_trylock())
-			return;
-		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
-		rtnl_unlock();
-	}
 }
 
 static int bond_upper_dev_walk(struct net_device *upper,
diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index 49cf9682b925..247d02447fc3 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -842,7 +842,7 @@ static netdev_tx_t bxcan_start_xmit(struct sk_buff *skb,
 	u32 id;
 	int i, j;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (bxcan_tx_busy(priv))
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index abe8dc051d94..77d165ed0d53 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -285,7 +285,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_CAN_RESTART_MS]) {
-		if (!priv->do_set_mode) {
+		unsigned int restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+
+		if (restart_ms != 0 && !priv->do_set_mode) {
 			NL_SET_ERR_MSG(extack,
 				       "Device doesn't support restart from Bus Off");
 			return -EOPNOTSUPP;
@@ -294,7 +296,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
-		priv->restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+		priv->restart_ms = restart_ms;
 	}
 
 	if (data[IFLA_CAN_RESTART]) {
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 0d201a57d7e2..dd9c50d3ec0f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1310,7 +1310,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	}
 
 	if (xdp_flags & ENA_XDP_REDIRECT)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	return work_done;
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 81a99f4824d0..61bd2389ef4b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1077,8 +1077,7 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
 	dma_addr_t addr;
 
 	buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
-	aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
-				  DPAA2_ETH_TX_BUF_ALIGN);
+	aligned_start = PTR_ALIGN(buffer_start, DPAA2_ETH_TX_BUF_ALIGN);
 	if (aligned_start >= skb->head)
 		buffer_start = aligned_start;
 	else
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 0c09d82dbf00..7accf3a3e9f0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1246,6 +1246,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd;
 		struct sk_buff *skb;
@@ -1281,7 +1283,9 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		rx_byte_cnt += skb->len + ETH_HLEN;
 		rx_frm_cnt++;
 
+		enetc_unlock_mdio();
 		napi_gro_receive(napi, skb);
+		enetc_lock_mdio();
 	}
 
 	rx_ring->next_to_clean = i;
@@ -1289,6 +1293,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -1598,6 +1604,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd, *orig_rxbd;
 		int orig_i, orig_cleaned_cnt;
@@ -1657,7 +1665,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			if (unlikely(!skb))
 				goto out;
 
+			enetc_unlock_mdio();
 			napi_gro_receive(napi, skb);
+			enetc_lock_mdio();
 			break;
 		case XDP_TX:
 			tx_ring = priv->xdp_tx_ring[rx_ring->index];
@@ -1692,7 +1702,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			}
 			break;
 		case XDP_REDIRECT:
+			enetc_unlock_mdio();
 			err = xdp_do_redirect(rx_ring->ndev, &xdp_buff, prog);
+			enetc_lock_mdio();
 			if (unlikely(err)) {
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				rx_ring->stats.xdp_redirect_failures++;
@@ -1712,8 +1724,11 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
-	if (xdp_redirect_frm_cnt)
-		xdp_do_flush_map();
+	if (xdp_redirect_frm_cnt) {
+		enetc_unlock_mdio();
+		xdp_do_flush();
+		enetc_lock_mdio();
+	}
 
 	if (xdp_tx_frm_cnt)
 		enetc_update_tx_ring_tail(tx_ring);
@@ -1722,6 +1737,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
 				     rx_ring->xdp.xdp_tx_in_flight);
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -1740,6 +1757,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	for (i = 0; i < v->count_tx_rings; i++)
 		if (!enetc_clean_tx_ring(&v->tx_ring[i], budget))
 			complete = false;
+	enetc_unlock_mdio();
 
 	prog = rx_ring->xdp.prog;
 	if (prog)
@@ -1751,10 +1769,8 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	if (work_done)
 		v->rx_napi_work = true;
 
-	if (!complete) {
-		enetc_unlock_mdio();
+	if (!complete)
 		return budget;
-	}
 
 	napi_complete_done(napi, work_done);
 
@@ -1763,6 +1779,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 
 	v->rx_napi_work = false;
 
+	enetc_lock_mdio();
 	/* enable interrupts */
 	enetc_wr_reg_hot(v->rbier, ENETC_RBIER_RXTIE);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 860ecee302f1..dcf3e4b4e3f5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -41,7 +41,7 @@ struct enetc_tx_swbd {
 };
 
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
-#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
+#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
 #define ENETC_RXB_DMA_SIZE	\
 	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8352d9b6469f..64cd72c19478 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1904,7 +1904,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 	rxq->bd.cur = bdp;
 
 	if (xdp_result & FEC_ENET_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	return pkt_received;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 6a9b47b005d2..99604379c87b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2398,7 +2398,7 @@ void i40e_update_rx_stats(struct i40e_ring *rx_ring,
 void i40e_finalize_xdp_rx(struct i40e_ring *rx_ring, unsigned int xdp_res)
 {
 	if (xdp_res & I40E_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	if (xdp_res & I40E_XDP_TX) {
 		struct i40e_ring *xdp_ring =
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index c8322fb6f2b3..7e06373e14d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -450,7 +450,7 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
 	struct ice_tx_buf *tx_buf = &xdp_ring->tx_buf[first_idx];
 
 	if (xdp_res & ICE_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	if (xdp_res & ICE_XDP_TX) {
 		if (static_branch_unlikely(&ice_xdp_locking_key))
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f245f3df40fc..99876b765b08 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2421,7 +2421,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 	}
 
 	if (xdp_xmit & IXGBE_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	if (xdp_xmit & IXGBE_XDP_TX) {
 		struct ixgbe_ring *ring = ixgbe_determine_xdp_ring(adapter);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 7ef82c30e857..9fdd19acf224 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -351,7 +351,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 	}
 
 	if (xdp_xmit & IXGBE_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	if (xdp_xmit & IXGBE_XDP_TX) {
 		struct ixgbe_ring *ring = ixgbe_determine_xdp_ring(adapter);
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 165f76d1231c..2941721b6515 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2520,7 +2520,7 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		mvneta_xdp_put_buff(pp, rxq, &xdp_buf, -1);
 
 	if (ps.xdp_redirect)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	if (ps.rx_packets)
 		mvneta_update_stats(pp, &ps);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index fce57faf345c..aabc39f7690f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4055,7 +4055,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 	}
 
 	if (xdp_ret & MVPP2_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	if (ps.rx_packets) {
 		struct mvpp2_pcpu_stats *stats = this_cpu_ptr(port->stats);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index aefe2af6f01d..c843e6531449 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2221,7 +2221,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 	net_dim(&eth->rx_dim, dim_sample);
 
 	if (xdp_flush)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	return done;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 9cf33ae48c21..455d02b6500d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -519,6 +519,12 @@ struct mlx5e_xdpsq {
 	struct mlx5e_channel      *channel;
 } ____cacheline_aligned_in_smp;
 
+struct mlx5e_xdp_buff {
+	struct xdp_buff xdp;
+	struct mlx5_cqe64 *cqe;
+	struct mlx5e_rq *rq;
+};
+
 struct mlx5e_ktls_resync_resp;
 
 struct mlx5e_icosq {
@@ -717,6 +723,7 @@ struct mlx5e_rq {
 	struct mlx5e_xdpsq    *xdpsq;
 	DECLARE_BITMAP(flags, 8);
 	struct page_pool      *page_pool;
+	struct mlx5e_xdp_buff mxbuf;
 
 	/* AF_XDP zero-copy */
 	struct xsk_buff_pool  *xsk_pool;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index dcd5db907f10..9c22d64af685 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -98,7 +98,7 @@ u8 mlx5e_mpwrq_umr_entry_size(enum mlx5e_mpwrq_umr_mode mode)
 		return sizeof(struct mlx5_ksm) * 4;
 	}
 	WARN_ONCE(1, "MPWRQ UMR mode %d is not known\n", mode);
-	return 0;
+	return 1;
 }
 
 u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index b723ff5e5249..13c7ed1bb37e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -895,7 +895,7 @@ void mlx5e_xdp_rx_poll_complete(struct mlx5e_rq *rq)
 	mlx5e_xmit_xdp_doorbell(xdpsq);
 
 	if (test_bit(MLX5E_RQ_FLAG_XDP_REDIRECT, rq->flags)) {
-		xdp_do_flush_map();
+		xdp_do_flush();
 		__clear_bit(MLX5E_RQ_FLAG_XDP_REDIRECT, rq->flags);
 	}
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index ecfe93a479da..38e9ff6aa3ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -44,12 +44,6 @@
 	(MLX5E_XDP_INLINE_WQE_MAX_DS_CNT * MLX5_SEND_WQE_DS - \
 	 sizeof(struct mlx5_wqe_inline_seg))
 
-struct mlx5e_xdp_buff {
-	struct xdp_buff xdp;
-	struct mlx5_cqe64 *cqe;
-	struct mlx5e_rq *rq;
-};
-
 /* XDP packets can be transmitted in different ways. On completion, we need to
  * distinguish between them to clean up things in a proper way.
  */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 8278395ee20a..fcf7437174e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1697,17 +1697,17 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog) {
-		struct mlx5e_xdp_buff mxbuf;
+		struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 
 		net_prefetchw(va); /* xdp_frame data area */
 		mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-				 cqe_bcnt, &mxbuf);
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf))
+				 cqe_bcnt, mxbuf);
+		if (mlx5e_xdp_handle(rq, prog, mxbuf))
 			return NULL; /* page/packet was consumed by XDP */
 
-		rx_headroom = mxbuf.xdp.data - mxbuf.xdp.data_hard_start;
-		metasize = mxbuf.xdp.data - mxbuf.xdp.data_meta;
-		cqe_bcnt = mxbuf.xdp.data_end - mxbuf.xdp.data;
+		rx_headroom = mxbuf->xdp.data - mxbuf->xdp.data_hard_start;
+		metasize = mxbuf->xdp.data - mxbuf->xdp.data_meta;
+		cqe_bcnt = mxbuf->xdp.data_end - mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);
@@ -1726,11 +1726,11 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 			     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
 {
 	struct mlx5e_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
+	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 	struct mlx5e_wqe_frag_info *head_wi = wi;
 	u16 rx_headroom = rq->buff.headroom;
 	struct mlx5e_frag_page *frag_page;
 	struct skb_shared_info *sinfo;
-	struct mlx5e_xdp_buff mxbuf;
 	u32 frag_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
@@ -1750,8 +1750,8 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	net_prefetch(va + rx_headroom);
 
 	mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-			 frag_consumed_bytes, &mxbuf);
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+			 frag_consumed_bytes, mxbuf);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 	truesize = 0;
 
 	cqe_bcnt -= frag_consumed_bytes;
@@ -1763,8 +1763,9 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 		frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page,
-					       wi->offset, frag_consumed_bytes);
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp,
+					       frag_page, wi->offset,
+					       frag_consumed_bytes);
 		truesize += frag_info->frag_stride;
 
 		cqe_bcnt -= frag_consumed_bytes;
@@ -1773,31 +1774,46 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	}
 
 	prog = rcu_dereference(rq->xdp_prog);
-	if (prog && mlx5e_xdp_handle(rq, prog, &mxbuf)) {
-		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
-			struct mlx5e_wqe_frag_info *pwi;
+	if (prog) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
+			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT,
+						 rq->flags)) {
+				struct mlx5e_wqe_frag_info *pwi;
+
+				wi -= old_nr_frags - sinfo->nr_frags;
+
+				for (pwi = head_wi; pwi < wi; pwi++)
+					pwi->frag_page->frags++;
+			}
+			return NULL; /* page/packet was consumed by XDP */
+		}
 
-			for (pwi = head_wi; pwi < wi; pwi++)
-				pwi->frag_page->frags++;
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			wi -= nr_frags_free;
+			truesize -= nr_frags_free * frag_info->frag_stride;
 		}
-		return NULL; /* page/packet was consumed by XDP */
 	}
 
-	skb = mlx5e_build_linear_skb(rq, mxbuf.xdp.data_hard_start, rq->buff.frame0_sz,
-				     mxbuf.xdp.data - mxbuf.xdp.data_hard_start,
-				     mxbuf.xdp.data_end - mxbuf.xdp.data,
-				     mxbuf.xdp.data - mxbuf.xdp.data_meta);
+	skb = mlx5e_build_linear_skb(
+		rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
+		mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
+		mxbuf->xdp.data_end - mxbuf->xdp.data,
+		mxbuf->xdp.data - mxbuf->xdp.data_meta);
 	if (unlikely(!skb))
 		return NULL;
 
 	skb_mark_for_recycle(skb);
 	head_wi->frag_page->frags++;
 
-	if (xdp_buff_has_frags(&mxbuf.xdp)) {
+	if (xdp_buff_has_frags(&mxbuf->xdp)) {
 		/* sinfo->nr_frags is reset by build_skb, calculate again. */
 		xdp_update_skb_shared_info(skb, wi - head_wi - 1,
 					   sinfo->xdp_frags_size, truesize,
-					   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+					   xdp_buff_is_frag_pfmemalloc(
+						&mxbuf->xdp));
 
 		for (struct mlx5e_wqe_frag_info *pwi = head_wi + 1; pwi < wi; pwi++)
 			pwi->frag_page->frags++;
@@ -2003,11 +2019,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
+	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
-	struct mlx5e_xdp_buff mxbuf;
 	unsigned int truesize = 0;
+	u32 pg_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
 	u32 linear_frame_sz;
@@ -2052,20 +2069,23 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		}
 	}
 
-	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz, linear_data_len, &mxbuf);
+	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz,
+			 linear_data_len, mxbuf);
 
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
-		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
+		pg_consumed_bytes =
+			min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 			truesize += pg_consumed_bytes;
 		else
 			truesize += ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz));
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page, frag_offset,
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp,
+					       frag_page, frag_offset,
 					       pg_consumed_bytes);
 		byte_cnt -= pg_consumed_bytes;
 		frag_offset = 0;
@@ -2073,10 +2093,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	}
 
 	if (prog) {
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+		u32 len;
+
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
 
+				frag_page -= old_nr_frags - sinfo->nr_frags;
+
 				for (pfp = head_page; pfp < frag_page; pfp++)
 					pfp->frags++;
 
@@ -2086,10 +2111,20 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-		skb = mlx5e_build_linear_skb(rq, mxbuf.xdp.data_hard_start,
-					     linear_frame_sz,
-					     mxbuf.xdp.data - mxbuf.xdp.data_hard_start, 0,
-					     mxbuf.xdp.data - mxbuf.xdp.data_meta);
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			frag_page -= nr_frags_free;
+			truesize -= (nr_frags_free - 1) * PAGE_SIZE +
+				ALIGN(pg_consumed_bytes,
+				      BIT(rq->mpwqe.log_stride_sz));
+		}
+
+		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
+
+		skb = mlx5e_build_linear_skb(
+			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
+			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len,
+			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq, &wi->linear_page);
 			return NULL;
@@ -2099,29 +2134,34 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		wi->linear_page.frags++;
 		mlx5e_page_release_fragmented(rq, &wi->linear_page);
 
-		if (xdp_buff_has_frags(&mxbuf.xdp)) {
+		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
 			/* sinfo->nr_frags is reset by build_skb, calculate again. */
 			xdp_update_skb_shared_info(skb, frag_page - head_page,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+						   xdp_buff_is_frag_pfmemalloc(
+							&mxbuf->xdp));
 
 			pagep = head_page;
 			do
 				pagep->frags++;
 			while (++pagep < frag_page);
+
+			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
+					skb->data_len);
+			__pskb_pull_tail(skb, headlen);
 		}
-		__pskb_pull_tail(skb, headlen);
 	} else {
 		dma_addr_t addr;
 
-		if (xdp_buff_has_frags(&mxbuf.xdp)) {
+		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
 			xdp_update_skb_shared_info(skb, sinfo->nr_frags,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+						   xdp_buff_is_frag_pfmemalloc(
+							&mxbuf->xdp));
 
 			pagep = frag_page - sinfo->nr_frags;
 			do
@@ -2171,20 +2211,20 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog) {
-		struct mlx5e_xdp_buff mxbuf;
+		struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 
 		net_prefetchw(va); /* xdp_frame data area */
 		mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-				 cqe_bcnt, &mxbuf);
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+				 cqe_bcnt, mxbuf);
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
 				frag_page->frags++;
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-		rx_headroom = mxbuf.xdp.data - mxbuf.xdp.data_hard_start;
-		metasize = mxbuf.xdp.data - mxbuf.xdp.data_meta;
-		cqe_bcnt = mxbuf.xdp.data_end - mxbuf.xdp.data;
+		rx_headroom = mxbuf->xdp.data - mxbuf->xdp.data_hard_start;
+		metasize =  mxbuf->xdp.data -  mxbuf->xdp.data_meta;
+		cqe_bcnt =  mxbuf->xdp.data_end -  mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);
diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c b/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
index 5d9db8c2a5b4..45be6954d5aa 100644
--- a/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
+++ b/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
@@ -256,7 +256,7 @@ nfp_nfd3_xsk_rx(struct nfp_net_rx_ring *rx_ring, int budget,
 	nfp_net_xsk_rx_ring_fill_freelist(r_vec->rx_ring);
 
 	if (xdp_redir)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	if (tx_ring->wr_ptr_add)
 		nfp_net_tx_xmit_more_flush(tx_ring);
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 58fdc4f8dd48..085d81576f1a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2038,15 +2038,35 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 		skb_tx_timestamp(skb);
 	}
-	/* Descriptor type must be set after all the above writes */
-	dma_wmb();
+
 	if (num_tx_desc > 1) {
 		desc->die_dt = DT_FEND;
 		desc--;
+		/* When using multi-descriptors, DT_FEND needs to get written
+		 * before DT_FSTART, but the compiler may reorder the memory
+		 * writes in an attempt to optimize the code.
+		 * Use a dma_wmb() barrier to make sure DT_FEND and DT_FSTART
+		 * are written exactly in the order shown in the code.
+		 * This is particularly important for cases where the DMA engine
+		 * is already running when we are running this code. If the DMA
+		 * sees DT_FSTART without the corresponding DT_FEND it will enter
+		 * an error condition.
+		 */
+		dma_wmb();
 		desc->die_dt = DT_FSTART;
 	} else {
+		/* Descriptor type must be set after all the above writes */
+		dma_wmb();
 		desc->die_dt = DT_FSINGLE;
 	}
+
+	/* Before ringing the doorbell we need to make sure that the latest
+	 * writes have been committed to memory, otherwise it could delay
+	 * things until the doorbell is rang again.
+	 * This is in replacement of the read operation mentioned in the HW
+	 * manuals.
+	 */
+	dma_wmb();
 	ravb_modify(ndev, TCCR, TCCR_TSRQ0 << q, TCCR_TSRQ0 << q);
 
 	priv->cur_tx[q] += num_tx_desc;
diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index 8d2d7ea2ebef..c9e17a8208a9 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -1260,7 +1260,7 @@ static int efx_poll(struct napi_struct *napi, int budget)
 
 	spent = efx_process_channel(channel, budget);
 
-	xdp_do_flush_map();
+	xdp_do_flush();
 
 	if (spent < budget) {
 		if (efx_channel_has_rx_queue(channel) &&
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index 1776f7f8a7a9..a7346e965bfe 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -1285,7 +1285,7 @@ static int efx_poll(struct napi_struct *napi, int budget)
 
 	spent = efx_process_channel(channel, budget);
 
-	xdp_do_flush_map();
+	xdp_do_flush();
 
 	if (spent < budget) {
 		if (efx_channel_has_rx_queue(channel) &&
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index f358ea003193..b834b129639f 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -780,7 +780,7 @@ static void netsec_finalize_xdp_rx(struct netsec_priv *priv, u32 xdp_res,
 				   u16 pkts)
 {
 	if (xdp_res & NETSEC_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
 
 	if (xdp_res & NETSEC_XDP_TX)
 		netsec_xdp_ring_tx_db(priv, pkts);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index d920a50dd16c..bab315517bad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1565,14 +1565,15 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 		}
 	} else {
 		if (bsp_priv->clk_enabled) {
+			if (bsp_priv->ops && bsp_priv->ops->set_clock_selection) {
+				bsp_priv->ops->set_clock_selection(bsp_priv,
+					      bsp_priv->clock_input, false);
+			}
+
 			clk_bulk_disable_unprepare(bsp_priv->num_clks,
 						   bsp_priv->clks);
 			clk_disable_unprepare(bsp_priv->clk_phy);
 
-			if (bsp_priv->ops && bsp_priv->ops->set_clock_selection)
-				bsp_priv->ops->set_clock_selection(bsp_priv,
-					      bsp_priv->clock_input, false);
-
 			bsp_priv->clk_enabled = false;
 		}
 	}
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index 0ec85635dfd6..764ed298b570 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -1360,7 +1360,7 @@ int cpsw_run_xdp(struct cpsw_priv *priv, int ch, struct xdp_buff *xdp,
 		 *  particular hardware is sharing a common queue, so the
 		 *  incoming device might change per packet.
 		 */
-		xdp_do_flush_map();
+		xdp_do_flush();
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(ndev, prog, act);
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 92add3daadbb..278e6cb6f4d9 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -685,9 +685,16 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 	rtl8150_t *dev = netdev_priv(netdev);
 	int count, res;
 
+	/* pad the frame and ensure terminating USB packet, datasheet 9.2.3 */
+	count = max(skb->len, ETH_ZLEN);
+	if (count % 64 == 0)
+		count++;
+	if (skb_padto(skb, count)) {
+		netdev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
 	netif_stop_queue(netdev);
-	count = (skb->len < 60) ? 60 : skb->len;
-	count = (count & 0x3f) ? count : count + 1;
 	dev->tx_skb = skb;
 	usb_fill_bulk_urb(dev->tx_urb, dev->udev, usb_sndbulkpipe(dev->udev, 2),
 		      skb->data, count, write_bulk_callback, dev);
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 04031450d5fe..c3013059cca8 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -212,7 +212,7 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	hisi_pmu = to_hisi_pmu(event->pmu);
-	if (event->attr.config > hisi_pmu->check_event)
+	if ((event->attr.config & HISI_EVENTID_MASK) > hisi_pmu->check_event)
 		return -EINVAL;
 
 	if (hisi_pmu->on_cpu == -1)
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index 92402aa69d70..67d1c3d3a41c 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -43,7 +43,8 @@
 		return FIELD_GET(GENMASK_ULL(hi, lo), event->attr.config);  \
 	}
 
-#define HISI_GET_EVENTID(ev) (ev->hw.config_base & 0xff)
+#define HISI_EVENTID_MASK		GENMASK(7, 0)
+#define HISI_GET_EVENTID(ev)		((ev)->hw.config_base & HISI_EVENTID_MASK)
 
 #define HISI_PMU_EVTYPE_BITS		8
 #define HISI_PMU_EVTYPE_SHIFT(idx)	((idx) % 4 * HISI_PMU_EVTYPE_BITS)
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 6b374026cd4f..3942aa492176 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1318,23 +1318,34 @@ void ccw_device_schedule_recovery(void)
 	spin_unlock_irqrestore(&recovery_lock, flags);
 }
 
-static int purge_fn(struct device *dev, void *data)
+static int purge_fn(struct subchannel *sch, void *data)
 {
-	struct ccw_device *cdev = to_ccwdev(dev);
-	struct ccw_dev_id *id = &cdev->private->dev_id;
-	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_device *cdev;
 
-	spin_lock_irq(cdev->ccwlock);
-	if (is_blacklisted(id->ssid, id->devno) &&
-	    (cdev->private->state == DEV_STATE_OFFLINE) &&
-	    (atomic_cmpxchg(&cdev->private->onoff, 0, 1) == 0)) {
-		CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x\n", id->ssid,
-			      id->devno);
+	spin_lock_irq(sch->lock);
+	if (sch->st != SUBCHANNEL_TYPE_IO || !sch->schib.pmcw.dnv)
+		goto unlock;
+
+	if (!is_blacklisted(sch->schid.ssid, sch->schib.pmcw.dev))
+		goto unlock;
+
+	cdev = sch_get_cdev(sch);
+	if (cdev) {
+		if (cdev->private->state != DEV_STATE_OFFLINE)
+			goto unlock;
+
+		if (atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
+			goto unlock;
 		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
-		css_sched_sch_todo(sch, SCH_TODO_UNREG);
 		atomic_set(&cdev->private->onoff, 0);
 	}
-	spin_unlock_irq(cdev->ccwlock);
+
+	css_sched_sch_todo(sch, SCH_TODO_UNREG);
+	CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x%s\n", sch->schid.ssid,
+		      sch->schib.pmcw.dev, cdev ? "" : " (no cdev)");
+
+unlock:
+	spin_unlock_irq(sch->lock);
 	/* Abort loop in case of pending signal. */
 	if (signal_pending(current))
 		return -EINTR;
@@ -1350,7 +1361,7 @@ static int purge_fn(struct device *dev, void *data)
 int ccw_purge_blacklisted(void)
 {
 	CIO_MSG_EVENT(2, "ccw: purging blacklisted devices\n");
-	bus_for_each_dev(&ccw_bus_type, NULL, NULL, purge_fn);
+	for_each_subchannel_staged(purge_fn, NULL, NULL);
 	return 0;
 }
 
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index bc6c086ddd43..731504ec7ef8 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -665,6 +665,12 @@ static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
 				   0, POLL_TOUT, true);
 	if (ret)
 		dev_warn(f->dev, "DLL lock failed, please fix it!\n");
+
+	/*
+	 * For ERR050272, DLL lock status bit is not accurate,
+	 * wait for 4us more as a workaround.
+	 */
+	udelay(4);
 }
 
 /*
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eaf4a907380a..57b27f9ea1f0 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -653,7 +653,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 27430fdd9e76..e79ee33d432c 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -33,6 +33,8 @@
 #define PCI_DEVICE_ID_ACCESSIO_COM_4SM		0x10db
 #define PCI_DEVICE_ID_ACCESSIO_COM_8SM		0x10ea
 
+#define PCI_DEVICE_ID_ADVANTECH_XR17V352	0x0018
+
 #define PCI_DEVICE_ID_COMMTECH_4224PCI335	0x0002
 #define PCI_DEVICE_ID_COMMTECH_4222PCI335	0x0004
 #define PCI_DEVICE_ID_COMMTECH_2324PCI335	0x000a
@@ -845,6 +847,12 @@ static const struct exar8250_board pbn_fastcom35x_8 = {
 	.exit		= pci_xr17v35x_exit,
 };
 
+static const struct exar8250_board pbn_adv_XR17V352 = {
+	.num_ports	= 2,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
 static const struct exar8250_board pbn_exar_XR17V4358 = {
 	.num_ports	= 12,
 	.setup		= pci_xr17v35x_setup,
@@ -914,6 +922,9 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	USR_DEVICE(XR17C152, 2980, pbn_exar_XR17C15x),
 	USR_DEVICE(XR17C152, 2981, pbn_exar_XR17C15x),
 
+	/* ADVANTECH devices */
+	EXAR_DEVICE(ADVANTECH, XR17V352, pbn_adv_XR17V352),
+
 	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
 	EXAR_DEVICE(EXAR, XR17C152, pbn_exar_XR17C15x),
 	EXAR_DEVICE(EXAR, XR17C154, pbn_exar_XR17C15x),
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 28f9a2679a20..c4a2a3e289c1 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -435,6 +435,7 @@ static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 	while
 		(serial_in(up, MTK_UART_DEBUG0));
 
+	clk_disable_unprepare(data->uart_clk);
 	clk_disable_unprepare(data->bus_clk);
 
 	return 0;
@@ -445,6 +446,7 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
 	clk_prepare_enable(data->bus_clk);
+	clk_prepare_enable(data->uart_clk);
 
 	return 0;
 }
@@ -475,13 +477,13 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 	int dmacnt;
 #endif
 
-	data->uart_clk = devm_clk_get(&pdev->dev, "baud");
+	data->uart_clk = devm_clk_get_enabled(&pdev->dev, "baud");
 	if (IS_ERR(data->uart_clk)) {
 		/*
 		 * For compatibility with older device trees try unnamed
 		 * clk when no baud clk can be found.
 		 */
-		data->uart_clk = devm_clk_get(&pdev->dev, NULL);
+		data->uart_clk = devm_clk_get_enabled(&pdev->dev, NULL);
 		if (IS_ERR(data->uart_clk)) {
 			dev_warn(&pdev->dev, "Can't get uart clock\n");
 			return PTR_ERR(data->uart_clk);
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index c0fd8ab3fe8f..c322d0c1d965 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -464,6 +464,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Huawei 4G LTE module */
 	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
+	{ USB_DEVICE(0x12d1, 0x15c1), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
 	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
 
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index ea106ad665a1..2deab4a6030d 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -620,8 +620,6 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
 		return ERR_PTR(-EINVAL);
 	if (!usb_raw_io_flags_valid(io->flags))
 		return ERR_PTR(-EINVAL);
-	if (io->length > PAGE_SIZE)
-		return ERR_PTR(-EINVAL);
 	if (get_from_user)
 		data = memdup_user(ptr + sizeof(*io), io->length);
 	else {
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 764657070883..bfd437269800 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -1319,8 +1319,15 @@ int xhci_dbc_suspend(struct xhci_hcd *xhci)
 	if (!dbc)
 		return 0;
 
-	if (dbc->state == DS_CONFIGURED)
+	switch (dbc->state) {
+	case DS_ENABLED:
+	case DS_CONNECTED:
+	case DS_CONFIGURED:
 		dbc->resume_required = 1;
+		break;
+	default:
+		break;
+	}
 
 	xhci_dbc_stop(dbc);
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index dca610369ca9..e9d0d8591a01 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -273,6 +273,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM05CN			0x0312
 #define QUECTEL_PRODUCT_EM05G_GR		0x0313
 #define QUECTEL_PRODUCT_EM05G_RS		0x0314
+#define QUECTEL_PRODUCT_RG255C			0x0316
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_RM520N			0x0801
@@ -617,6 +618,7 @@ static void option_instat_callback(struct urb *urb);
 #define UNISOC_VENDOR_ID			0x1782
 /* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
 #define TOZED_PRODUCT_LT70C			0x4055
+#define UNISOC_PRODUCT_UIS7720			0x4064
 /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
 #define LUAT_PRODUCT_AIR720U			0x4e00
 
@@ -1270,6 +1272,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0xff, 0x40) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
@@ -1398,10 +1403,14 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a2, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a3, 0xff),	/* Telit FN920C04 (ECM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a7, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a8, 0xff),	/* Telit FN920C04 (ECM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a9, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
@@ -2466,6 +2475,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, UNISOC_PRODUCT_UIS7720, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
 	  .driver_info = NCTRL(1) },
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5774b50eeaf7..2e39686e01c9 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6636,9 +6636,9 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->partner_desc.identity = &port->partner_ident;
 	port->port_type = port->typec_caps.type;
 
-	port->role_sw = usb_role_switch_get(port->dev);
+	port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
 	if (!port->role_sw)
-		port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
+		port->role_sw = usb_role_switch_get(port->dev);
 	if (IS_ERR(port->role_sw)) {
 		err = PTR_ERR(port->role_sw);
 		goto out_destroy_wq;
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 0455dddb0797..0b17657690d4 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -802,7 +802,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_device_deregister(ls);
 
-	if (force < 3 && dlm_user_daemon_available())
+	if (force != 3 && dlm_user_daemon_available())
 		do_uevent(ls, 0);
 
 	dlm_recoverd_stop(ls);
diff --git a/fs/exec.c b/fs/exec.c
index ee71a315cc51..a7dfac338a22 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -748,7 +748,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		    unsigned long stack_top,
 		    int executable_stack)
 {
-	unsigned long ret;
+	int ret;
 	unsigned long stack_shift;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0b84284ece98..387d43aa89e3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -634,7 +634,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		goto out_err;
 
 	err = -ENOMEM;
-	ff = fuse_file_alloc(fm);
+	ff = fuse_file_alloc(fm, true);
 	if (!ff)
 		goto out_put_forget_req;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 952c99fcb636..2055af1ffaf3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -55,7 +55,7 @@ struct fuse_release_args {
 	struct inode *inode;
 };
 
-struct fuse_file *fuse_file_alloc(struct fuse_mount *fm)
+struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
 {
 	struct fuse_file *ff;
 
@@ -64,11 +64,13 @@ struct fuse_file *fuse_file_alloc(struct fuse_mount *fm)
 		return NULL;
 
 	ff->fm = fm;
-	ff->release_args = kzalloc(sizeof(*ff->release_args),
-				   GFP_KERNEL_ACCOUNT);
-	if (!ff->release_args) {
-		kfree(ff);
-		return NULL;
+	if (release) {
+		ff->release_args = kzalloc(sizeof(*ff->release_args),
+					   GFP_KERNEL_ACCOUNT);
+		if (!ff->release_args) {
+			kfree(ff);
+			return NULL;
+		}
 	}
 
 	INIT_LIST_HEAD(&ff->write_entry);
@@ -104,14 +106,14 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
 	kfree(ra);
 }
 
-static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
+static void fuse_file_put(struct fuse_file *ff, bool sync)
 {
 	if (refcount_dec_and_test(&ff->count)) {
-		struct fuse_args *args = &ff->release_args->args;
+		struct fuse_release_args *ra = ff->release_args;
+		struct fuse_args *args = (ra ? &ra->args : NULL);
 
-		if (isdir ? ff->fm->fc->no_opendir : ff->fm->fc->no_open) {
-			/* Do nothing when client does not implement 'open' */
-			fuse_release_end(ff->fm, args, 0);
+		if (!args) {
+			/* Do nothing when server does not implement 'open' */
 		} else if (sync) {
 			fuse_simple_request(ff->fm, args);
 			fuse_release_end(ff->fm, args, 0);
@@ -131,15 +133,16 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
 	int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
+	bool open = isdir ? !fc->no_opendir : !fc->no_open;
 
-	ff = fuse_file_alloc(fm);
+	ff = fuse_file_alloc(fm, open);
 	if (!ff)
 		return ERR_PTR(-ENOMEM);
 
 	ff->fh = 0;
 	/* Default for no-open */
 	ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
-	if (isdir ? !fc->no_opendir : !fc->no_open) {
+	if (open) {
 		struct fuse_open_out outarg;
 		int err;
 
@@ -147,11 +150,13 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 		if (!err) {
 			ff->fh = outarg.fh;
 			ff->open_flags = outarg.open_flags;
-
 		} else if (err != -ENOSYS) {
 			fuse_file_free(ff);
 			return ERR_PTR(err);
 		} else {
+			/* No release needed */
+			kfree(ff->release_args);
+			ff->release_args = NULL;
 			if (isdir)
 				fc->no_opendir = 1;
 			else
@@ -273,7 +278,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 }
 
 static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
-				 unsigned int flags, int opcode)
+				 unsigned int flags, int opcode, bool sync)
 {
 	struct fuse_conn *fc = ff->fm->fc;
 	struct fuse_release_args *ra = ff->release_args;
@@ -291,6 +296,9 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 
 	wake_up_interruptible_all(&ff->poll_wait);
 
+	if (!ra)
+		return;
+
 	ra->inarg.fh = ff->fh;
 	ra->inarg.flags = flags;
 	ra->args.in_numargs = 1;
@@ -300,6 +308,13 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 	ra->args.nodeid = ff->nodeid;
 	ra->args.force = true;
 	ra->args.nocreds = true;
+
+	/*
+	 * Hold inode until release is finished.
+	 * From fuse_sync_release() the refcount is 1 and everything's
+	 * synchronous, so we are fine with not doing igrab() here.
+	 */
+	ra->inode = sync ? NULL : igrab(&fi->inode);
 }
 
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
@@ -309,14 +324,12 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	struct fuse_release_args *ra = ff->release_args;
 	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 
-	fuse_prepare_release(fi, ff, open_flags, opcode);
+	fuse_prepare_release(fi, ff, open_flags, opcode, false);
 
-	if (ff->flock) {
+	if (ra && ff->flock) {
 		ra->inarg.release_flags |= FUSE_RELEASE_FLOCK_UNLOCK;
 		ra->inarg.lock_owner = fuse_lock_owner_id(ff->fm->fc, id);
 	}
-	/* Hold inode until release is finished */
-	ra->inode = igrab(inode);
 
 	/*
 	 * Normally this will send the RELEASE request, however if
@@ -326,8 +339,14 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * Make the release synchronous if this is a fuseblk mount,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
+	 *
+	 * Always use the asynchronous file put because the current thread
+	 * might be the fuse server.  This can happen if a process starts some
+	 * aio and closes the fd before the aio completes.  Since aio takes its
+	 * own ref to the file, the IO completion has to drop the ref, which is
+	 * how the fuse server can end up closing its clients' files.
 	 */
-	fuse_file_put(ff, ff->fm->fc->destroy, isdir);
+	fuse_file_put(ff, false);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
@@ -362,12 +381,8 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 		       unsigned int flags)
 {
 	WARN_ON(refcount_read(&ff->count) > 1);
-	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE);
-	/*
-	 * iput(NULL) is a no-op and since the refcount is 1 and everything's
-	 * synchronous, we are fine with not doing igrab() here"
-	 */
-	fuse_file_put(ff, true, false);
+	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE, true);
+	fuse_file_put(ff, true);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
@@ -924,7 +939,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		put_page(page);
 	}
 	if (ia->ff)
-		fuse_file_put(ia->ff, false, false);
+		fuse_file_put(ia->ff, false);
 
 	fuse_io_free(ia);
 }
@@ -1666,7 +1681,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 		__free_page(ap->pages[i]);
 
 	if (wpa->ia.ff)
-		fuse_file_put(wpa->ia.ff, false, false);
+		fuse_file_put(wpa->ia.ff, false);
 
 	kfree(ap->pages);
 	kfree(wpa);
@@ -1914,7 +1929,7 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, false, false);
+		fuse_file_put(ff, false);
 
 	return err;
 }
@@ -2312,7 +2327,7 @@ static int fuse_writepages(struct address_space *mapping,
 		fuse_writepages_send(&data);
 	}
 	if (data.ff)
-		fuse_file_put(data.ff, false, false);
+		fuse_file_put(data.ff, false);
 
 	kfree(data.orig_pages);
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4ce1a6fdc94f..aa12ff6de706 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1036,7 +1036,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
  */
 int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
 
-struct fuse_file *fuse_file_alloc(struct fuse_mount *fm);
+struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
 void fuse_file_free(struct fuse_file *ff);
 void fuse_finish_open(struct inode *inode, struct file *file);
 
diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index 34e9804e0f36..e46f650b5e9c 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -21,7 +21,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
@@ -115,6 +115,12 @@ int hfs_brec_find(struct hfs_find_data *fd)
 	__be32 data;
 	int height, res;
 
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+
 	tree = fd->tree;
 	if (fd->bnode)
 		hfs_bnode_put(fd->bnode);
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 896396554bcc..b01db1fae147 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -179,6 +179,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *parent;
 	int end_off, rec_off, data_off, size;
+	int src, dst, len;
 
 	tree = fd->tree;
 	node = fd->bnode;
@@ -208,10 +209,14 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	}
 	hfs_bnode_write_u16(node, offsetof(struct hfs_bnode_desc, num_recs), node->num_recs);
 
-	if (rec_off == end_off)
-		goto skip;
 	size = fd->keylength + fd->entrylength;
 
+	if (rec_off == end_off) {
+		src = fd->keyoffset;
+		hfs_bnode_clear(node, src, size);
+		goto skip;
+	}
+
 	do {
 		data_off = hfs_bnode_read_u16(node, rec_off);
 		hfs_bnode_write_u16(node, rec_off + 2, data_off - size);
@@ -219,9 +224,23 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	} while (rec_off >= end_off);
 
 	/* fill hole */
-	hfs_bnode_move(node, fd->keyoffset, fd->keyoffset + size,
-		       data_off - fd->keyoffset - size);
+	dst = fd->keyoffset;
+	src = fd->keyoffset + size;
+	len = data_off - src;
+
+	hfs_bnode_move(node, dst, src, len);
+
+	src = dst + len;
+	len = data_off - src;
+
+	hfs_bnode_clear(node, src, len);
+
 skip:
+	/*
+	 * Remove the obsolete offset to free space.
+	 */
+	hfs_bnode_write_u16(node, end_off, 0);
+
 	hfs_bnode_dump(node);
 	if (!fd->record)
 		hfs_brec_update_parent(fd);
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 8082eb01127c..bf811347bb07 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -172,7 +172,7 @@ int hfs_mdb_get(struct super_block *sb)
 		pr_warn("continuing without an alternate MDB\n");
 	}
 
-	HFS_SB(sb)->bitmap = kmalloc(8192, GFP_KERNEL);
+	HFS_SB(sb)->bitmap = kzalloc(8192, GFP_KERNEL);
 	if (!HFS_SB(sb)->bitmap)
 		goto out;
 
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 901e83d65d20..26ebac4c6042 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
@@ -158,6 +158,12 @@ int hfs_brec_find(struct hfs_find_data *fd, search_strategy_t do_key_compare)
 	__be32 data;
 	int height, res;
 
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+
 	tree = fd->tree;
 	if (fd->bnode)
 		hfs_bnode_put(fd->bnode);
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 14f4995588ff..407d5152eb41 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -18,47 +18,6 @@
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
-static inline
-bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
-{
-	bool is_valid = off < node->tree->node_size;
-
-	if (!is_valid) {
-		pr_err("requested invalid offset: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off);
-	}
-
-	return is_valid;
-}
-
-static inline
-int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
-{
-	unsigned int node_size;
-
-	if (!is_bnode_offset_valid(node, off))
-		return 0;
-
-	node_size = node->tree->node_size;
-
-	if ((off + len) > node_size) {
-		int new_len = (int)node_size - off;
-
-		pr_err("requested length has been corrected: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, "
-		       "requested_len %d, corrected_len %d\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off, len, new_len);
-
-		return new_len;
-	}
-
-	return len;
-}
 
 /* Copy a specified range of bytes from the raw data of a node */
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 9e1732a2b92a..fe6a54c4083c 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -393,6 +393,12 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	len = hfs_brec_lenoff(node, 2, &off16);
 	off = off16;
 
+	if (!is_bnode_offset_valid(node, off)) {
+		hfs_bnode_put(node);
+		return ERR_PTR(-EIO);
+	}
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	data = kmap_local_page(*pagep);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 1473b04fc0f3..e67b35cb5ccc 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -574,6 +574,48 @@ hfsplus_btree_lock_class(struct hfs_btree *tree)
 	return class;
 }
 
+static inline
+bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
+{
+	bool is_valid = off < node->tree->node_size;
+
+	if (!is_valid) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off);
+	}
+
+	return is_valid;
+}
+
+static inline
+int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
+{
+	unsigned int node_size;
+
+	if (!is_bnode_offset_valid(node, off))
+		return 0;
+
+	node_size = node->tree->node_size;
+
+	if ((off + len) > node_size) {
+		int new_len = (int)node_size - off;
+
+		pr_err("requested length has been corrected: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, "
+		       "requested_len %d, corrected_len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
+
 /* compatibility */
 #define hfsp_mt2ut(t)		(struct timespec64){ .tv_sec = __hfsp_mt2ut(t) }
 #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 1986b4f18a90..7e889820a63d 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -67,13 +67,26 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
-	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
-	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
-	mutex_init(&HFSPLUS_I(inode)->extents_lock);
-	HFSPLUS_I(inode)->flags = 0;
+	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
+	HFSPLUS_I(inode)->first_blocks = 0;
+	HFSPLUS_I(inode)->clump_blocks = 0;
+	HFSPLUS_I(inode)->alloc_blocks = 0;
+	HFSPLUS_I(inode)->cached_start = U32_MAX;
+	HFSPLUS_I(inode)->cached_blocks = 0;
+	memset(HFSPLUS_I(inode)->first_extents, 0, sizeof(hfsplus_extent_rec));
+	memset(HFSPLUS_I(inode)->cached_extents, 0, sizeof(hfsplus_extent_rec));
 	HFSPLUS_I(inode)->extent_state = 0;
+	mutex_init(&HFSPLUS_I(inode)->extents_lock);
 	HFSPLUS_I(inode)->rsrc_inode = NULL;
-	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
+	HFSPLUS_I(inode)->create_date = 0;
+	HFSPLUS_I(inode)->linkid = 0;
+	HFSPLUS_I(inode)->flags = 0;
+	HFSPLUS_I(inode)->fs_blocks = 0;
+	HFSPLUS_I(inode)->userflags = 0;
+	HFSPLUS_I(inode)->subfolders = 0;
+	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
+	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
+	HFSPLUS_I(inode)->phys_size = 0;
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID ||
 	    inode->i_ino == HFSPLUS_ROOT_CNID) {
@@ -525,7 +538,7 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
 	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
 		hfs_find_exit(&fd);
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
-			err = -EINVAL;
+			err = -EIO;
 			goto out_put_root;
 		}
 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 26655572975d..1aa7de55094c 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -17,6 +17,7 @@
 #include "fanotify/fanotify.h"
 #include "fdinfo.h"
 #include "fsnotify.h"
+#include "../internal.h"
 
 #if defined(CONFIG_PROC_FS)
 
@@ -50,7 +51,12 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	f.handle.handle_bytes = sizeof(f.pad);
 	size = f.handle.handle_bytes >> 2;
 
+	if (!super_trylock_shared(inode->i_sb))
+		return;
+
 	ret = exportfs_encode_fid(inode, (struct fid *)f.handle.f_handle, &size);
+	up_read(&inode->i_sb->s_umount);
+
 	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
 
diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 1f9ed117e78b..2f34074f0078 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -868,6 +868,11 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
 			mlog_errno(ret);
 			goto out;
 		}
+		/*
+		 * Invalidate extent cache after moving/defragging to prevent
+		 * stale cached data with outdated extent flags.
+		 */
+		ocfs2_extent_map_trunc(inode, cpos);
 
 		context->clusters_moved += alloc_size;
 next:
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 4bafb1adfb22..6168c6d62b5e 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -703,7 +703,7 @@ struct TCP_Server_Info {
 	bool nosharesock;
 	bool tcp_nodelay;
 	bool terminate;
-	unsigned int credits;  /* send no more requests at once */
+	int credits;  /* send no more requests at once */
 	unsigned int max_credits; /* can override large 32000 default at mnt */
 	unsigned int in_flight;  /* number of requests on the wire to server */
 	unsigned int max_in_flight; /* max number of requests that were on wire */
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 354f7144c590..36e1e52c30a0 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -249,10 +249,16 @@ static void ipc_msg_handle_free(int handle)
 
 static int handle_response(int type, void *payload, size_t sz)
 {
-	unsigned int handle = *(unsigned int *)payload;
+	unsigned int handle;
 	struct ipc_msg_table_entry *entry;
 	int ret = 0;
 
+	/* Prevent 4-byte read beyond declared payload size */
+	if (sz < sizeof(unsigned int))
+		return -EINVAL;
+
+	handle = *(unsigned int *)payload;
+
 	ipc_update_last_active();
 	down_read(&ipc_msg_table_lock);
 	hash_for_each_possible(ipc_msg_table, entry, ipc_table_hlist, handle) {
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 31c1ac256e1b..91e85a1a154f 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -938,12 +938,15 @@ static int smb_direct_flush_send_list(struct smb_direct_transport *t,
 			       struct smb_direct_sendmsg,
 			       list);
 
+	if (send_ctx->need_invalidate_rkey) {
+		first->wr.opcode = IB_WR_SEND_WITH_INV;
+		first->wr.ex.invalidate_rkey = send_ctx->remote_key;
+		send_ctx->need_invalidate_rkey = false;
+		send_ctx->remote_key = 0;
+	}
+
 	last->wr.send_flags = IB_SEND_SIGNALED;
 	last->wr.wr_cqe = &last->cqe;
-	if (is_last && send_ctx->need_invalidate_rkey) {
-		last->wr.opcode = IB_WR_SEND_WITH_INV;
-		last->wr.ex.invalidate_rkey = send_ctx->remote_key;
-	}
 
 	ret = smb_direct_post_send(t, &first->wr);
 	if (!ret) {
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index a726fbba49e4..9038e82fc605 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1230,16 +1230,25 @@ suffix_kstrtoint(
 static inline void
 xfs_fs_warn_deprecated(
 	struct fs_context	*fc,
-	struct fs_parameter	*param,
-	uint64_t		flag,
-	bool			value)
+	struct fs_parameter	*param)
 {
-	/* Don't print the warning if reconfiguring and current mount point
-	 * already had the flag set
+	/*
+	 * Always warn about someone passing in a deprecated mount option.
+	 * Previously we wouldn't print the warning if we were reconfiguring
+	 * and current mount point already had the flag set, but that was not
+	 * the right thing to do.
+	 *
+	 * Many distributions mount the root filesystem with no options in the
+	 * initramfs and rely on mount -a to remount the root fs with the
+	 * options in fstab.  However, the old behavior meant that there would
+	 * never be a warning about deprecated mount options for the root fs in
+	 * /etc/fstab.  On a single-fs system, that means no warning at all.
+	 *
+	 * Compounding this problem are distribution scripts that copy
+	 * /proc/mounts to fstab, which means that we can't remove mount
+	 * options unless we're 100% sure they have only ever been advertised
+	 * in /proc/mounts in response to explicitly provided mount options.
 	 */
-	if ((fc->purpose & FS_CONTEXT_FOR_RECONFIGURE) &&
-            !!(XFS_M(fc->root->d_sb)->m_features & flag) == value)
-		return;
 	xfs_warn(fc->s_fs_info, "%s mount option is deprecated.", param->key);
 }
 
@@ -1378,19 +1387,19 @@ xfs_fs_parse_param(
 #endif
 	/* Following mount options will be removed in September 2025 */
 	case Opt_ikeep:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_IKEEP, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_IKEEP;
 		return 0;
 	case Opt_noikeep:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_IKEEP, false);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features &= ~XFS_FEAT_IKEEP;
 		return 0;
 	case Opt_attr2:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_ATTR2, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_ATTR2;
 		return 0;
 	case Opt_noattr2:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_NOATTR2, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_NOATTR2;
 		return 0;
 	default:
diff --git a/io_uring/filetable.c b/io_uring/filetable.c
index 6e86e6188dbe..ff74d41d9e53 100644
--- a/io_uring/filetable.c
+++ b/io_uring/filetable.c
@@ -62,7 +62,7 @@ void io_free_file_tables(struct io_file_table *table)
 
 static int io_install_fixed_file(struct io_ring_ctx *ctx, struct file *file,
 				 u32 slot_index)
-	__must_hold(&req->ctx->uring_lock)
+	__must_hold(&ctx->uring_lock)
 {
 	struct io_fixed_file *file_slot;
 	int ret;
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 958d4aa77dca..ca2e8153bd1c 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -23,6 +23,7 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/swiotlb.h>
 #include <asm/sections.h>
 #include "debug.h"
 
@@ -601,7 +602,9 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+		     is_swiotlb_active(entry->dev))) {
 		err_printk(entry->dev, entry,
 			"cacheline tracking EEXIST, overlapping mappings aren't supported\n");
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f7cb505ab337..64634314a89c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3435,11 +3435,9 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	struct cpumask *cpumask;
 	int cid;
 
 	lockdep_assert_rq_held(rq);
-	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
 		mm_cid_snapshot_time(rq, mm);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 26c520d1af6e..161356313203 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4383,9 +4383,6 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err;
 	u16 vid;
 
-	if (!netlink_capable(skb, CAP_NET_ADMIN))
-		return -EPERM;
-
 	if (!del_bulk) {
 		err = nlmsg_parse_deprecated(nlh, sizeof(*ndm), tb, NDA_MAX,
 					     NULL, extack);
diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 5c1652181805..f5a7d5a38755 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -169,13 +169,14 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 				chunk->head_skb = chunk->skb;
 
 			/* skbs with "cover letter" */
-			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
+			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len) {
+				if (WARN_ON(!skb_shinfo(chunk->skb)->frag_list)) {
+					__SCTP_INC_STATS(dev_net(chunk->skb->dev),
+							 SCTP_MIB_IN_PKT_DISCARDS);
+					sctp_chunk_free(chunk);
+					goto next_chunk;
+				}
 				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
-
-			if (WARN_ON(!chunk->skb)) {
-				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
-				sctp_chunk_free(chunk);
-				goto next_chunk;
 			}
 		}
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f95ac11a7e0d..64790062cfa2 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -486,12 +486,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
-	if (vsk->transport) {
-		if (vsk->transport == new_transport) {
-			ret = 0;
-			goto err;
-		}
+	if (vsk->transport && vsk->transport == new_transport) {
+		ret = 0;
+		goto err;
+	}
 
+	/* We increase the module refcnt to prevent the transport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
+
+	if (vsk->transport) {
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
 		 * have already held the sock lock. In the other cases, this
@@ -511,20 +525,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		vsk->peer_shutdown = 0;
 	}
 
-	/* We increase the module refcnt to prevent the transport unloading
-	 * while there are open sockets assigned to it.
-	 */
-	if (!new_transport || !try_module_get(new_transport->module)) {
-		ret = -ENODEV;
-		goto err;
-	}
-
-	/* It's safe to release the mutex after a successful try_module_get().
-	 * Whichever transport `new_transport` points at, it won't go away until
-	 * the last module_put() below or in vsock_deassign_transport().
-	 */
-	mutex_unlock(&vsock_register_mutex);
-
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
 		    !new_transport->seqpacket_allow(remote_cid)) {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9a907d8260c9..d30314532bb7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3737,7 +3737,7 @@ endpoint_tests()
 	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
 	if reset "implicit EP" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -3762,7 +3762,7 @@ endpoint_tests()
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3
@@ -3910,7 +3910,7 @@ endpoint_tests()
 
 	# flush and re-add
 	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 2
 		# broadcast IP: no packet for this address will be received on ns1
diff --git a/tools/testing/selftests/net/sctp_hello.c b/tools/testing/selftests/net/sctp_hello.c
index f02f1f95d227..a04dac0b8027 100644
--- a/tools/testing/selftests/net/sctp_hello.c
+++ b/tools/testing/selftests/net/sctp_hello.c
@@ -29,7 +29,6 @@ static void set_addr(struct sockaddr_storage *ss, char *ip, char *port, int *len
 static int do_client(int argc, char *argv[])
 {
 	struct sockaddr_storage ss;
-	char buf[] = "hello";
 	int csk, ret, len;
 
 	if (argc < 5) {
@@ -56,16 +55,10 @@ static int do_client(int argc, char *argv[])
 
 	set_addr(&ss, argv[3], argv[4], &len);
 	ret = connect(csk, (struct sockaddr *)&ss, len);
-	if (ret < 0) {
-		printf("failed to connect to peer\n");
+	if (ret < 0)
 		return -1;
-	}
 
-	ret = send(csk, buf, strlen(buf) + 1, 0);
-	if (ret < 0) {
-		printf("failed to send msg %d\n", ret);
-		return -1;
-	}
+	recv(csk, NULL, 0, 0);
 	close(csk);
 
 	return 0;
@@ -75,7 +68,6 @@ int main(int argc, char *argv[])
 {
 	struct sockaddr_storage ss;
 	int lsk, csk, ret, len;
-	char buf[20];
 
 	if (argc < 2 || (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
 		printf("%s server|client ...\n", argv[0]);
@@ -125,11 +117,6 @@ int main(int argc, char *argv[])
 		return -1;
 	}
 
-	ret = recv(csk, buf, sizeof(buf), 0);
-	if (ret <= 0) {
-		printf("failed to recv msg %d\n", ret);
-		return -1;
-	}
 	close(csk);
 	close(lsk);
 
diff --git a/tools/testing/selftests/net/sctp_vrf.sh b/tools/testing/selftests/net/sctp_vrf.sh
index c721e952e5f3..667b211aa8a1 100755
--- a/tools/testing/selftests/net/sctp_vrf.sh
+++ b/tools/testing/selftests/net/sctp_vrf.sh
@@ -6,13 +6,11 @@
 #                                                  SERVER_NS
 #       CLIENT_NS2 (veth1) <---> (veth2) -> vrf_s2
 
-CLIENT_NS1="client-ns1"
-CLIENT_NS2="client-ns2"
+source lib.sh
 CLIENT_IP4="10.0.0.1"
 CLIENT_IP6="2000::1"
 CLIENT_PORT=1234
 
-SERVER_NS="server-ns"
 SERVER_IP4="10.0.0.2"
 SERVER_IP6="2000::2"
 SERVER_PORT=1234
@@ -20,13 +18,11 @@ SERVER_PORT=1234
 setup() {
 	modprobe sctp
 	modprobe sctp_diag
-	ip netns add $CLIENT_NS1
-	ip netns add $CLIENT_NS2
-	ip netns add $SERVER_NS
+	setup_ns CLIENT_NS1 CLIENT_NS2 SERVER_NS
 
-	ip net exec $CLIENT_NS1 sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
-	ip net exec $CLIENT_NS2 sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
-	ip net exec $SERVER_NS sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
+	ip net exec $CLIENT_NS1 sysctl -wq net.ipv6.conf.default.accept_dad=0
+	ip net exec $CLIENT_NS2 sysctl -wq net.ipv6.conf.default.accept_dad=0
+	ip net exec $SERVER_NS sysctl -wq net.ipv6.conf.default.accept_dad=0
 
 	ip -n $SERVER_NS link add veth1 type veth peer name veth1 netns $CLIENT_NS1
 	ip -n $SERVER_NS link add veth2 type veth peer name veth1 netns $CLIENT_NS2
@@ -66,19 +62,40 @@ setup() {
 }
 
 cleanup() {
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
-	ip netns del "$CLIENT_NS1"
-	ip netns del "$CLIENT_NS2"
-	ip netns del "$SERVER_NS"
+	wait_client $CLIENT_NS1
+	wait_client $CLIENT_NS2
+	stop_server
+	cleanup_ns $CLIENT_NS1 $CLIENT_NS2 $SERVER_NS
 }
 
-wait_server() {
+start_server() {
 	local IFACE=$1
 	local CNT=0
 
-	until ip netns exec $SERVER_NS ss -lS src $SERVER_IP:$SERVER_PORT | \
-		grep LISTEN | grep "$IFACE" 2>&1 >/dev/null; do
-		[ $((CNT++)) = "20" ] && { RET=3; return $RET; }
+	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP $SERVER_PORT $IFACE &
+	disown
+	until ip netns exec $SERVER_NS ss -SlH | grep -q "$IFACE"; do
+		[ $((CNT++)) -eq 30 ] && { RET=3; return $RET; }
+		sleep 0.1
+	done
+}
+
+stop_server() {
+	local CNT=0
+
+	ip netns exec $SERVER_NS pkill sctp_hello
+	while ip netns exec $SERVER_NS ss -SaH | grep -q .; do
+		[ $((CNT++)) -eq 30 ] && break
+		sleep 0.1
+	done
+}
+
+wait_client() {
+	local CLIENT_NS=$1
+	local CNT=0
+
+	while ip netns exec $CLIENT_NS ss -SaH | grep -q .; do
+		[ $((CNT++)) -eq 30 ] && break
 		sleep 0.1
 	done
 }
@@ -87,14 +104,12 @@ do_test() {
 	local CLIENT_NS=$1
 	local IFACE=$2
 
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE || return $RET
+	start_server $IFACE || return $RET
 	timeout 3 ip netns exec $CLIENT_NS ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT
 	RET=$?
+	wait_client $CLIENT_NS
+	stop_server
 	return $RET
 }
 
@@ -102,25 +117,21 @@ do_testx() {
 	local IFACE1=$1
 	local IFACE2=$2
 
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE1 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE1 || return $RET
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE2 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE2 || return $RET
+	start_server $IFACE1 || return $RET
+	start_server $IFACE2 || return $RET
 	timeout 3 ip netns exec $CLIENT_NS1 ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null && \
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT && \
 	timeout 3 ip netns exec $CLIENT_NS2 ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT
 	RET=$?
+	wait_client $CLIENT_NS1
+	wait_client $CLIENT_NS2
+	stop_server
 	return $RET
 }
 
 testup() {
-	ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=1 2>&1 >/dev/null
+	ip netns exec $SERVER_NS sysctl -wq net.sctp.l3mdev_accept=1
 	echo -n "TEST 01: nobind, connect from client 1, l3mdev_accept=1, Y "
 	do_test $CLIENT_NS1 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
@@ -129,7 +140,7 @@ testup() {
 	do_test $CLIENT_NS2 && { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 
-	ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=0 2>&1 >/dev/null
+	ip netns exec $SERVER_NS sysctl -wq net.sctp.l3mdev_accept=0
 	echo -n "TEST 03: nobind, connect from client 1, l3mdev_accept=0, N "
 	do_test $CLIENT_NS1 && { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
@@ -166,7 +177,7 @@ testup() {
 	do_testx vrf-1 vrf-2 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 
-	echo -n "TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N "
+	echo -n "TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, Y "
 	do_testx vrf-2 vrf-1 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 }

