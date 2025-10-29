Return-Path: <linux-kernel+bounces-876256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2982C1B194
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA5762195F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0A355809;
	Wed, 29 Oct 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sL5aU4D+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2641B354AF3;
	Wed, 29 Oct 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745338; cv=none; b=bGHTxpQLqxHXMKig8Wuy0tfgxEJIWXf9r8Jf9RKE/kngu7g3J8IZC+tEYTCfX+pd43VkFZRnW8hBNbpTFKyv++ZEhOQbPQKCq7SP23fxSy/6Bl8qur3y3cCuD7YZ6kwdsWag9XdJzBsczImR+iklbHTjR1xL82PbmjIqNGvPWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745338; c=relaxed/simple;
	bh=Ko2aovxieStJirG0Q2b9xaKEHh8c6Wl1Qg2mUtwBEck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDQkc4s4WbYaKN6dflRhJ8zpuDPSCwKmiqHsM3ty2VmiQlIdQELcsVIsDui1wtRjQmXNEQiR47qE5E3WScEubnZ5WCTOhkDu8ALg8jnwGlr/dyzKck9chQ9i98sUsTBtd8goaq8ngffk8xzBv0X6q5hcIP1s/j1Okn5GXC2JtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sL5aU4D+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60801C4CEF7;
	Wed, 29 Oct 2025 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761745337;
	bh=Ko2aovxieStJirG0Q2b9xaKEHh8c6Wl1Qg2mUtwBEck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sL5aU4D+4m6nfseeDxnVe+bqtPH+P3bKyl464K09V/Hg0E1jPDQE501Oyj57jfOgq
	 iXA+SKggP+h6v8YGagjUVLv+ZvA2UAeLNE68mCERjIizAlYY4QDMLWLRAMSKkx7/F3
	 ZZdo3qv73WYzzy++et2AvtU2grdao2zK9+IoNxP0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.158
Date: Wed, 29 Oct 2025 14:41:39 +0100
Message-ID: <2025102939-rubbed-outsource-f99e@gregkh>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2025102939-cataract-remission-7107@gregkh>
References: <2025102939-cataract-remission-7107@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index a0f8164c8513..49387d823619 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any attempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding mod_timer() must be dealt
-with via del_timer_sync() or similar.
+with via timer_shutdown_sync() or similar.
 
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke call_rcu(), the callback function is eventually going to be
diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index e7b50babd0d5..a8eddcf24231 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -181,6 +181,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982,1209401| N/A                         |
diff --git a/Documentation/core-api/local_ops.rst b/Documentation/core-api/local_ops.rst
index 2ac3f9f29845..0b42ceaaf3c4 100644
--- a/Documentation/core-api/local_ops.rst
+++ b/Documentation/core-api/local_ops.rst
@@ -191,7 +191,7 @@ Here is a sample module which implements a basic per cpu counter using
 
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            timer_shutdown_sync(&test_timer);
     }
 
     module_init(test_init);
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 6805ae6e86e6..3bbb11ba647a 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -967,7 +967,7 @@ you might do the following::
 
             while (list) {
                     struct foo *next = list->next;
-                    del_timer(&list->timer);
+                    timer_delete(&list->timer);
                     kfree(list);
                     list = next;
             }
@@ -981,7 +981,7 @@ the lock after we spin_unlock_bh(), and then try to free
 the element (which has already been freed!).
 
 This can be avoided by checking the result of
-del_timer(): if it returns 1, the timer has been deleted.
+timer_delete(): if it returns 1, the timer has been deleted.
 If 0, it means (in this case) that it is currently running, so we can
 do::
 
@@ -990,7 +990,7 @@ do::
 
                     while (list) {
                             struct foo *next = list->next;
-                            if (!del_timer(&list->timer)) {
+                            if (!timer_delete(&list->timer)) {
                                     /* Give timer a chance to delete this */
                                     spin_unlock_bh(&list_lock);
                                     goto retry;
@@ -1005,9 +1005,12 @@ do::
 Another common problem is deleting timers which restart themselves (by
 calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
-use del_timer_sync() (``include/linux/timer.h``) to
-handle this case. It returns the number of times the timer had to be
-deleted before we finally stopped it from adding itself back in.
+use timer_delete_sync() (``include/linux/timer.h``) to
+
+Before freeing a timer, timer_shutdown() or timer_shutdown_sync() should be
+called which will keep it from being rearmed. Any subsequent attempt to
+rearm the timer will be silently ignored by the core code.
+
 
 Locking Speed
 =============
@@ -1335,7 +1338,7 @@ lock.
 
 -  kfree()
 
--  add_timer() and del_timer()
+-  add_timer() and timer_delete()
 
 Mutex API reference
 ===================
diff --git a/Documentation/networking/seg6-sysctl.rst b/Documentation/networking/seg6-sysctl.rst
index 07c20e470baf..1b6af4779be1 100644
--- a/Documentation/networking/seg6-sysctl.rst
+++ b/Documentation/networking/seg6-sysctl.rst
@@ -25,6 +25,9 @@ seg6_require_hmac - INTEGER
 
 	Default is 0.
 
+/proc/sys/net/ipv6/seg6_* variables:
+====================================
+
 seg6_flowlabel - INTEGER
 	Controls the behaviour of computing the flowlabel of outer
 	IPv6 header in case of SR T.encaps
diff --git a/Documentation/timers/hrtimers.rst b/Documentation/timers/hrtimers.rst
index c1c20a693e8f..7ac448908d1f 100644
--- a/Documentation/timers/hrtimers.rst
+++ b/Documentation/timers/hrtimers.rst
@@ -118,7 +118,7 @@ existing timer wheel code, as it is mature and well suited. Sharing code
 was not really a win, due to the different data structures. Also, the
 hrtimer functions now have clearer behavior and clearer names - such as
 hrtimer_try_to_cancel() and hrtimer_cancel() [which are roughly
-equivalent to del_timer() and del_timer_sync()] - so there's no direct
+equivalent to timer_delete() and timer_delete_sync()] - so there's no direct
 1:1 mapping between them on the algorithmic level, and thus no real
 potential for code sharing either.
 
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 51af37f2d621..b8ecf41273c5 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -990,7 +990,7 @@ potreste fare come segue::
 
             while (list) {
                     struct foo *next = list->next;
-                    del_timer(&list->timer);
+                    timer_delete(&list->timer);
                     kfree(list);
                     list = next;
             }
@@ -1003,7 +1003,7 @@ e prenderà il *lock* solo dopo spin_unlock_bh(), e cercherà
 di eliminare il suo oggetto (che però è già stato eliminato).
 
 Questo può essere evitato controllando il valore di ritorno di
-del_timer(): se ritorna 1, il temporizzatore è stato già
+timer_delete(): se ritorna 1, il temporizzatore è stato già
 rimosso. Se 0, significa (in questo caso) che il temporizzatore è in
 esecuzione, quindi possiamo fare come segue::
 
@@ -1012,7 +1012,7 @@ esecuzione, quindi possiamo fare come segue::
 
                     while (list) {
                             struct foo *next = list->next;
-                            if (!del_timer(&list->timer)) {
+                            if (!timer_delete(&list->timer)) {
                                     /* Give timer a chance to delete this */
                                     spin_unlock_bh(&list_lock);
                                     goto retry;
@@ -1026,10 +1026,8 @@ esecuzione, quindi possiamo fare come segue::
 Un altro problema è l'eliminazione dei temporizzatori che si riavviano
 da soli (chiamando add_timer() alla fine della loro esecuzione).
 Dato che questo è un problema abbastanza comune con una propensione
-alle corse critiche, dovreste usare del_timer_sync()
-(``include/linux/timer.h``) per gestire questo caso. Questa ritorna il
-numero di volte che il temporizzatore è stato interrotto prima che
-fosse in grado di fermarlo senza che si riavviasse.
+alle corse critiche, dovreste usare timer_delete_sync()
+(``include/linux/timer.h``) per gestire questo caso.
 
 Velocità della sincronizzazione
 ===============================
@@ -1374,7 +1372,7 @@ contesto, o trattenendo un qualsiasi *lock*.
 
 -  kfree()
 
--  add_timer() e del_timer()
+-  add_timer() e timer_delete()
 
 Riferimento per l'API dei Mutex
 ===============================
diff --git a/Documentation/translations/zh_CN/core-api/local_ops.rst b/Documentation/translations/zh_CN/core-api/local_ops.rst
index 41e4525038e8..eb5423f60f17 100644
--- a/Documentation/translations/zh_CN/core-api/local_ops.rst
+++ b/Documentation/translations/zh_CN/core-api/local_ops.rst
@@ -185,7 +185,7 @@ UP之间没有不同的行为，在你的架构的 ``local.h`` 中包括 ``asm-g
 
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            timer_shutdown_sync(&test_timer);
     }
 
     module_init(test_init);
diff --git a/Makefile b/Makefile
index 8e4848eaaed4..d8625400c281 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 157
+SUBLEVEL = 158
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index e979e2197f8e..5371c824786d 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -90,7 +90,7 @@ static void __init spear_clocksource_init(void)
 		200, 16, clocksource_mmio_readw_up);
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void spear_timer_shutdown(struct clock_event_device *evt)
 {
 	u16 val = readw(gpt_base + CR(CLKEVT));
 
@@ -101,7 +101,7 @@ static inline void timer_shutdown(struct clock_event_device *evt)
 
 static int spear_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static int spear_set_oneshot(struct clock_event_device *evt)
 	u16 val;
 
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	val = readw(gpt_base + CR(CLKEVT));
 	val |= CTRL_ONE_SHOT;
@@ -126,7 +126,7 @@ static int spear_set_periodic(struct clock_event_device *evt)
 	u16 val;
 
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
 
 	period = clk_get_rate(gpt_clk) / HZ;
 	period >>= CTRL_PRESCALER16;
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6bb23a041e32..d889a466468c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1027,6 +1027,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Neoverse-V1 erratum 3324341
 	  * ARM Neoverse V2 erratum 3324336
 	  * ARM Neoverse-V3 erratum 3312417
+	  * ARM Neoverse-V3AE erratum 3312417
 
 	  On affected cores "MSR SSBS, #0" instructions may not affect
 	  subsequent speculative instructions, which may permit unexepected
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 41612b03af63..8e4bdd91856a 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -93,6 +93,7 @@
 #define ARM_CPU_PART_NEOVERSE_V2	0xD4F
 #define ARM_CPU_PART_CORTEX_A720	0xD81
 #define ARM_CPU_PART_CORTEX_X4		0xD82
+#define ARM_CPU_PART_NEOVERSE_V3AE	0xD83
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
 #define ARM_CPU_PART_CORTEX_X925	0xD85
 #define ARM_CPU_PART_CORTEX_A725	0xD87
@@ -173,6 +174,7 @@
 #define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
 #define MIDR_CORTEX_A720 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720)
 #define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
+#define MIDR_NEOVERSE_V3AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3AE)
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 426c3cb3e3bb..62326f249aa7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -183,7 +183,8 @@ static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
 static inline pte_t pte_mkwrite(pte_t pte)
 {
 	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
-	pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
+	if (pte_sw_dirty(pte))
+		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
 	return pte;
 }
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 78aea409b092..f527e9590e11 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -457,6 +457,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
 	{}
 };
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5d2322eeee47..547c47358133 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2068,17 +2068,21 @@ static void bti_enable(const struct arm64_cpu_capabilities *__unused)
 #ifdef CONFIG_ARM64_MTE
 static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 {
+	static bool cleared_zero_page = false;
+
 	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
 
 	mte_cpu_setup();
 
 	/*
 	 * Clear the tags in the zero page. This needs to be done via the
-	 * linear map which has the Tagged attribute.
+	 * linear map which has the Tagged attribute. Since this page is
+	 * always mapped as pte_special(), set_pte_at() will not attempt to
+	 * clear the tags or set PG_mte_tagged.
 	 */
-	if (!page_mte_tagged(ZERO_PAGE(0))) {
+	if (!cleared_zero_page) {
+		cleared_zero_page = true;
 		mte_clear_page_tags(lm_alias(empty_zero_page));
-		set_page_mte_tagged(ZERO_PAGE(0));
 	}
 
 	kasan_init_hw_tags_cpu();
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index e20af03b4cdf..da0f93c5e675 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -456,7 +456,7 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 			put_page(page);
 			break;
 		}
-		WARN_ON_ONCE(!page_mte_tagged(page));
+		WARN_ON_ONCE(!page_mte_tagged(page) && !is_zero_page(page));
 
 		/* limit access to the end of the page */
 		offset = offset_in_page(addr);
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
index 40bc8fb75e0b..e2fc4b59d93e 100644
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
index 9972626ddaf6..eda12ceacb55 100644
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
index bb19a643c5c2..1a94e633c144 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -555,6 +555,8 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
+#define pgprot_dmacoherent pgprot_writecombine
+
 /*
  * THP functions
  */
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 0f76181dc634..e642b3dc42d2 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -32,10 +32,8 @@ int riscv_of_processor_hartid(struct device_node *node, unsigned long *hart)
 		return -ENODEV;
 	}
 
-	if (!of_device_is_available(node)) {
-		pr_info("CPU with hartid=%lu is not available\n", *hart);
+	if (!of_device_is_available(node))
 		return -ENODEV;
-	}
 
 	if (of_property_read_string(node, "riscv,isa", &isa)) {
 		pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index cca2b3a2135a..f4836ef13e9b 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -48,10 +48,15 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	post_kprobe_handler(p, kcb, regs);
 }
 
-static bool __kprobes arch_check_kprobe(struct kprobe *p)
+static bool __kprobes arch_check_kprobe(unsigned long addr)
 {
-	unsigned long tmp  = (unsigned long)p->addr - p->offset;
-	unsigned long addr = (unsigned long)p->addr;
+	unsigned long tmp, offset;
+
+	/* start iterating at the closest preceding symbol */
+	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
+		return false;
+
+	tmp = addr - offset;
 
 	while (tmp <= addr) {
 		if (tmp == addr)
@@ -70,7 +75,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if ((unsigned long)insn & 0x1)
 		return -EILSEQ;
 
-	if (!arch_check_kprobe(p))
+	if (!arch_check_kprobe((unsigned long)p->addr))
 		return -EILSEQ;
 
 	/* copy instruction */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index b9adb707750c..19a27a0f2a93 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -224,11 +224,15 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
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
index 595547db28c0..5100bc9ce383 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -94,6 +94,11 @@ acpi_tb_print_table_header(acpi_physical_address address,
 {
 	struct acpi_table_header local_header;
 
+#pragma GCC diagnostic push
+#if defined(__GNUC__) && __GNUC__ >= 11
+#pragma GCC diagnostic ignored "-Wstringop-overread"
+#endif
+
 	if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) {
 
 		/* FACS only has signature and length fields */
@@ -134,6 +139,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
 			   local_header.asl_compiler_id,
 			   local_header.asl_compiler_revision));
 	}
+#pragma GCC diagnostic pop
 }
 
 /*******************************************************************************
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 931aa2609f3b..a109dec62a99 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -845,17 +845,8 @@ static int binder_inc_node_nilocked(struct binder_node *node, int strong,
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
index e7d6e6657ffa..b97c5a240cc9 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -327,7 +327,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 		 * frequency (by keeping the initial freq_factor value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
+		if (!IS_ERR_OR_NULL(cpu_clk)) {
 			per_cpu(freq_factor, cpu) =
 				clk_get_rate(cpu_clk) / 1000;
 			clk_put(cpu_clk);
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f3bd9f104bd1..48754841fd86 100644
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
@@ -186,12 +205,10 @@ static ssize_t disabled_show(struct class *class, struct class_attribute *attr,
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
@@ -353,7 +370,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	devcd->read = read;
 	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
-	devcd->delete_work = false;
+	devcd->deleted = false;
 
 	mutex_init(&devcd->mutex);
 	device_initialize(&devcd->devcd_dev);
@@ -362,8 +379,14 @@ void dev_coredumpm(struct device *dev, struct module *owner,
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
 
@@ -380,13 +403,20 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 
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
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 61d8ebc2de59..d26171bb7c84 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1512,6 +1512,32 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+static void pm_runtime_set_suspended_action(void *data)
+{
+	pm_runtime_set_suspended(data);
+}
+
+/**
+ * devm_pm_runtime_set_active_enabled - set_active version of devm_pm_runtime_enable.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_set_active_enabled(struct device *dev)
+{
+	int err;
+
+	err = pm_runtime_set_active(dev);
+	if (err)
+		return err;
+
+	err = devm_add_action_or_reset(dev, pm_runtime_set_suspended_action, dev);
+	if (err)
+		return err;
+
+	return devm_pm_runtime_enable(dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_set_active_enabled);
+
 static void pm_runtime_disable_action(void *data)
 {
 	pm_runtime_dont_use_autosuspend(data);
@@ -1534,6 +1560,24 @@ int devm_pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
 
+static void pm_runtime_put_noidle_action(void *data)
+{
+	pm_runtime_put_noidle(data);
+}
+
+/**
+ * devm_pm_runtime_get_noresume - devres-enabled version of pm_runtime_get_noresume.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_get_noresume(struct device *dev)
+{
+	pm_runtime_get_noresume(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_put_noidle_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_get_noresume);
+
 /**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 66f416f59a8d..204ba1de624d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -710,9 +710,15 @@ static int qca_close(struct hci_uart *hu)
 	skb_queue_purge(&qca->tx_wait_q);
 	skb_queue_purge(&qca->txq);
 	skb_queue_purge(&qca->rx_memdump_q);
+	/*
+	 * Shut the timers down so they can't be rearmed when
+	 * destroy_workqueue() drains pending work which in turn might try
+	 * to arm a timer.  After shutdown rearm attempts are silently
+	 * ignored by the timer core code.
+	 */
+	timer_shutdown_sync(&qca->tx_idle_timer);
+	timer_shutdown_sync(&qca->wake_retrans_timer);
 	destroy_workqueue(qca->workqueue);
-	del_timer_sync(&qca->tx_idle_timer);
-	del_timer_sync(&qca->wake_retrans_timer);
 	qca->hu = NULL;
 
 	kfree_skb(qca->rx_skb);
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fee1c4bf1021..ddcbf2b19651 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -687,8 +687,8 @@ static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
 	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
 }
 
-static __always_inline int timer_shutdown(const int access,
-					  struct clock_event_device *clk)
+static __always_inline int arch_timer_shutdown(const int access,
+					       struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 
@@ -701,22 +701,22 @@ static __always_inline int timer_shutdown(const int access,
 
 static int arch_timer_shutdown_virt(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
 }
 
 static __always_inline void set_next_event(const int access, unsigned long evt,
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index e6a87f4af2b5..cd1916c05325 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -155,14 +155,14 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void evt_timer_shutdown(struct clock_event_device *evt)
 {
 	writel(0, common_clkevt->ctrl);
 }
 
 static int sp804_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	return 0;
 }
 
@@ -171,7 +171,7 @@ static int sp804_set_periodic(struct clock_event_device *evt)
 	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
 			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	writel(common_clkevt->reload, common_clkevt->load);
 	writel(ctrl, common_clkevt->ctrl);
 	return 0;
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
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index d77e4aa209d9..cfad08189382 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -338,6 +338,16 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
+static unsigned int __cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
+{
+	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
+
+	if (transition_latency_ns == CPUFREQ_ETERNAL)
+		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
+
+	return transition_latency_ns / NSEC_PER_USEC;
+}
+
 /*
  * The PCC subspace describes the rate at which platform can accept commands
  * on the shared PCC channel (including READs which do not count towards freq
@@ -360,12 +370,12 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 			return 10000;
 		}
 	}
-	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+	return __cppc_cpufreq_get_transition_delay_us(cpu);
 }
 #else
 static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 {
-	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+	return __cppc_cpufreq_get_transition_delay_us(cpu);
 }
 #endif
 
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 0b3c917d505d..2aa87ce37a90 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -256,20 +256,17 @@ static unsigned int get_typical_interval(struct menu_device *data,
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
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index edd40e16a3f0..087b7c41c58d 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -236,10 +236,9 @@ static int rk_hash_unprepare(struct crypto_engine *engine, void *breq)
 {
 	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
-	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
 	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
 
-	dma_unmap_sg(tctx->dev->dev, areq->src, rctx->nrsg, DMA_TO_DEVICE);
+	dma_unmap_sg(tctx->dev->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d486f5dc052e..6595c044e4ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2268,10 +2268,9 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 					  struct kfd_vm_fault_info *mem)
 {
-	if (atomic_read(&adev->gmc.vm_fault_info_updated) == 1) {
+	if (atomic_read_acquire(&adev->gmc.vm_fault_info_updated) == 1) {
 		*mem = *adev->gmc.vm_fault_info;
-		mb(); /* make sure read happened */
-		atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0bc21106d9e8..e22eaf9d450d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1959,7 +1959,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	}
 
 	ret = psp_ta_load(psp, &psp->securedisplay_context.context);
-	if (!ret) {
+	if (!ret && !psp->securedisplay_context.context.resp_status) {
 		psp->securedisplay_context.context.initialized = true;
 		mutex_init(&psp->securedisplay_context.mutex);
 	} else
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 12411f4c1b9a..1e1a8a828ea3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1067,7 +1067,7 @@ static int gmc_v7_0_sw_init(void *handle)
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1299,7 +1299,7 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1315,8 +1315,7 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index cec9926e8bdd..c17a36504d17 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1189,7 +1189,7 @@ static int gmc_v8_0_sw_init(void *handle)
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1480,7 +1480,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1496,8 +1496,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 530888c475be..d13ab986a5c2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5435,8 +5435,7 @@ static int smu7_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		thermal_data->max = table_info->cac_dtp_table->usSoftwareShutdownTemp *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	else if (hwmgr->pp_table_version == PP_TABLE_V0)
-		thermal_data->max = data->thermal_temp_setting.temperature_shutdown *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		thermal_data->max = data->thermal_temp_setting.temperature_shutdown;
 
 	thermal_data->sw_ctf_threshold = thermal_data->max;
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 933ca028d612..fd581160d95e 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -121,8 +121,7 @@ static int lt9211_read_chipid(struct lt9211 *ctx)
 	}
 
 	/* Test for known Chip ID. */
-	if (chipid[0] != REG_CHIPID0_VALUE || chipid[1] != REG_CHIPID1_VALUE ||
-	    chipid[2] != REG_CHIPID2_VALUE) {
+	if (chipid[0] != REG_CHIPID0_VALUE || chipid[1] != REG_CHIPID1_VALUE) {
 		dev_err(ctx->dev, "Unknown Chip ID: 0x%02x 0x%02x 0x%02x\n",
 			chipid[0], chipid[1], chipid[2]);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index e52f72cc000e..c1602e7c2434 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -52,7 +52,6 @@ struct decon_context {
 	void __iomem			*regs;
 	unsigned long			irq_flags;
 	bool				i80_if;
-	bool				suspended;
 	wait_queue_head_t		wait_vsync_queue;
 	atomic_t			wait_vsync_event;
 
@@ -82,13 +81,30 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 	DRM_PLANE_TYPE_CURSOR,
 };
 
-static void decon_wait_for_vblank(struct exynos_drm_crtc *crtc)
+/**
+ * decon_shadow_protect_win() - disable updating values from shadow registers at vsync
+ *
+ * @ctx: display and enhancement controller context
+ * @win: window to protect registers for
+ * @protect: 1 to protect (disable updates)
+ */
+static void decon_shadow_protect_win(struct decon_context *ctx,
+				     unsigned int win, bool protect)
 {
-	struct decon_context *ctx = crtc->ctx;
+	u32 bits, val;
 
-	if (ctx->suspended)
-		return;
+	bits = SHADOWCON_WINx_PROTECT(win);
+
+	val = readl(ctx->regs + SHADOWCON);
+	if (protect)
+		val |= bits;
+	else
+		val &= ~bits;
+	writel(val, ctx->regs + SHADOWCON);
+}
 
+static void decon_wait_for_vblank(struct decon_context *ctx)
+{
 	atomic_set(&ctx->wait_vsync_event, 1);
 
 	/*
@@ -101,25 +117,33 @@ static void decon_wait_for_vblank(struct exynos_drm_crtc *crtc)
 		DRM_DEV_DEBUG_KMS(ctx->dev, "vblank wait timed out.\n");
 }
 
-static void decon_clear_channels(struct exynos_drm_crtc *crtc)
+static void decon_clear_channels(struct decon_context *ctx)
 {
-	struct decon_context *ctx = crtc->ctx;
 	unsigned int win, ch_enabled = 0;
+	u32 val;
 
 	/* Check if any channel is enabled. */
 	for (win = 0; win < WINDOWS_NR; win++) {
-		u32 val = readl(ctx->regs + WINCON(win));
+		val = readl(ctx->regs + WINCON(win));
 
 		if (val & WINCONx_ENWIN) {
+			decon_shadow_protect_win(ctx, win, true);
+
 			val &= ~WINCONx_ENWIN;
 			writel(val, ctx->regs + WINCON(win));
 			ch_enabled = 1;
+
+			decon_shadow_protect_win(ctx, win, false);
 		}
 	}
 
+	val = readl(ctx->regs + DECON_UPDATE);
+	val |= DECON_UPDATE_STANDALONE_F;
+	writel(val, ctx->regs + DECON_UPDATE);
+
 	/* Wait for vsync, as disable channel takes effect at next vsync */
 	if (ch_enabled)
-		decon_wait_for_vblank(ctx->crtc);
+		decon_wait_for_vblank(ctx);
 }
 
 static int decon_ctx_initialize(struct decon_context *ctx,
@@ -127,7 +151,7 @@ static int decon_ctx_initialize(struct decon_context *ctx,
 {
 	ctx->drm_dev = drm_dev;
 
-	decon_clear_channels(ctx->crtc);
+	decon_clear_channels(ctx);
 
 	return exynos_drm_register_dma(drm_dev, ctx->dev, &ctx->dma_priv);
 }
@@ -156,9 +180,6 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
 	u32 val, clkdiv;
 
-	if (ctx->suspended)
-		return;
-
 	/* nothing to do if we haven't set the mode yet */
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return;
@@ -220,9 +241,6 @@ static int decon_enable_vblank(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	u32 val;
 
-	if (ctx->suspended)
-		return -EPERM;
-
 	if (!test_and_set_bit(0, &ctx->irq_flags)) {
 		val = readl(ctx->regs + VIDINTCON0);
 
@@ -245,9 +263,6 @@ static void decon_disable_vblank(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	u32 val;
 
-	if (ctx->suspended)
-		return;
-
 	if (test_and_clear_bit(0, &ctx->irq_flags)) {
 		val = readl(ctx->regs + VIDINTCON0);
 
@@ -344,36 +359,11 @@ static void decon_win_set_colkey(struct decon_context *ctx, unsigned int win)
 	writel(keycon1, ctx->regs + WKEYCON1_BASE(win));
 }
 
-/**
- * decon_shadow_protect_win() - disable updating values from shadow registers at vsync
- *
- * @ctx: display and enhancement controller context
- * @win: window to protect registers for
- * @protect: 1 to protect (disable updates)
- */
-static void decon_shadow_protect_win(struct decon_context *ctx,
-				     unsigned int win, bool protect)
-{
-	u32 bits, val;
-
-	bits = SHADOWCON_WINx_PROTECT(win);
-
-	val = readl(ctx->regs + SHADOWCON);
-	if (protect)
-		val |= bits;
-	else
-		val &= ~bits;
-	writel(val, ctx->regs + SHADOWCON);
-}
-
 static void decon_atomic_begin(struct exynos_drm_crtc *crtc)
 {
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	for (i = 0; i < WINDOWS_NR; i++)
 		decon_shadow_protect_win(ctx, i, true);
 }
@@ -393,9 +383,6 @@ static void decon_update_plane(struct exynos_drm_crtc *crtc,
 	unsigned int cpp = fb->format->cpp[0];
 	unsigned int pitch = fb->pitches[0];
 
-	if (ctx->suspended)
-		return;
-
 	/*
 	 * SHADOWCON/PRTCON register is used for enabling timing.
 	 *
@@ -483,9 +470,6 @@ static void decon_disable_plane(struct exynos_drm_crtc *crtc,
 	unsigned int win = plane->index;
 	u32 val;
 
-	if (ctx->suspended)
-		return;
-
 	/* protect windows */
 	decon_shadow_protect_win(ctx, win, true);
 
@@ -504,9 +488,6 @@ static void decon_atomic_flush(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	for (i = 0; i < WINDOWS_NR; i++)
 		decon_shadow_protect_win(ctx, i, false);
 	exynos_crtc_handle_event(crtc);
@@ -534,9 +515,6 @@ static void decon_atomic_enable(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int ret;
 
-	if (!ctx->suspended)
-		return;
-
 	ret = pm_runtime_resume_and_get(ctx->dev);
 	if (ret < 0) {
 		DRM_DEV_ERROR(ctx->dev, "failed to enable DECON device.\n");
@@ -550,8 +528,6 @@ static void decon_atomic_enable(struct exynos_drm_crtc *crtc)
 		decon_enable_vblank(ctx->crtc);
 
 	decon_commit(ctx->crtc);
-
-	ctx->suspended = false;
 }
 
 static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
@@ -559,9 +535,6 @@ static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	/*
 	 * We need to make sure that all windows are disabled before we
 	 * suspend that connector. Otherwise we might try to scan from
@@ -571,8 +544,6 @@ static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
 		decon_disable_plane(crtc, &ctx->planes[i]);
 
 	pm_runtime_put_sync(ctx->dev);
-
-	ctx->suspended = true;
 }
 
 static const struct exynos_drm_crtc_ops decon_crtc_ops = {
@@ -693,7 +664,6 @@ static int decon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctx->dev = dev;
-	ctx->suspended = true;
 
 	i80_if_timings = of_get_child_by_name(dev->of_node, "i80-if-timings");
 	if (i80_if_timings)
diff --git a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
index 9ec9c43971df..3f1148636f06 100644
--- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
@@ -385,7 +385,10 @@ static int rcar_mipi_dsi_startup(struct rcar_mipi_dsi *dsi,
 	udelay(10);
 	rcar_mipi_dsi_clr(dsi, CLOCKSET1, CLOCKSET1_UPDATEPLL);
 
-	ppisetr = PPISETR_DLEN_3 | PPISETR_CLEN;
+	rcar_mipi_dsi_clr(dsi, TXSETR, TXSETR_LANECNT_MASK);
+	rcar_mipi_dsi_set(dsi, TXSETR, dsi->lanes - 1);
+
+	ppisetr = ((BIT(dsi->lanes) - 1) & PPISETR_DLEN_MASK) | PPISETR_CLEN;
 	rcar_mipi_dsi_write(dsi, PPISETR, ppisetr);
 
 	rcar_mipi_dsi_set(dsi, PHYSETUP, PHYSETUP_SHUTDOWNZ);
diff --git a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h
index 1f1eb46c721f..a04e9c6614dc 100644
--- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h
@@ -12,6 +12,9 @@
 #define LINKSR_LPBUSY			(1 << 1)
 #define LINKSR_HSBUSY			(1 << 0)
 
+#define TXSETR				0x100
+#define TXSETR_LANECNT_MASK		(0x3 << 0)
+
 /*
  * Video Mode Register
  */
@@ -80,10 +83,7 @@
  * PHY-Protocol Interface (PPI) Registers
  */
 #define PPISETR				0x700
-#define PPISETR_DLEN_0			(0x1 << 0)
-#define PPISETR_DLEN_1			(0x3 << 0)
-#define PPISETR_DLEN_2			(0x7 << 0)
-#define PPISETR_DLEN_3			(0xf << 0)
+#define PPISETR_DLEN_MASK		(0xf << 0)
 #define PPISETR_CLEN			(1 << 8)
 
 #define PPICLCR				0x710
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 6efa0a51b7d6..e14557d80efc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -983,7 +983,7 @@ static int vop2_plane_atomic_check(struct drm_plane *plane,
 		return format;
 
 	if (drm_rect_width(src) >> 16 < 4 || drm_rect_height(src) >> 16 < 4 ||
-	    drm_rect_width(dest) < 4 || drm_rect_width(dest) < 4) {
+	    drm_rect_width(dest) < 4 || drm_rect_height(dest) < 4) {
 		drm_err(vop2->drm, "Invalid size: %dx%d->%dx%d, min size is 4x4\n",
 			drm_rect_width(src) >> 16, drm_rect_height(src) >> 16,
 			drm_rect_width(dest), drm_rect_height(dest));
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index dbdd00c61315..a80001350411 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -719,13 +719,14 @@ int drm_sched_job_add_implicit_dependencies(struct drm_sched_job *job,
 
 	dma_resv_for_each_fence(&cursor, obj->resv, dma_resv_usage_rw(write),
 				fence) {
-		/* Make sure to grab an additional ref on the added fence */
-		dma_fence_get(fence);
-		ret = drm_sched_job_add_dependency(job, fence);
-		if (ret) {
-			dma_fence_put(fence);
+		/*
+		 * As drm_sched_job_add_dependency always consumes the fence
+		 * reference (even when it fails), and dma_resv_for_each_fence
+		 * is not obtaining one, we need to grab one before calling.
+		 */
+		ret = drm_sched_job_add_dependency(job, dma_fence_get(fence));
+		if (ret)
 			return ret;
-		}
 	}
 	return 0;
 }
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index cd9d03185843..59ec20542175 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -636,7 +636,10 @@ static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
 		return;
 	}
 
-	if (value == 0 || value < dev->battery_min || value > dev->battery_max)
+	if ((usage & HID_USAGE_PAGE) == HID_UP_DIGITIZER && value == 0)
+		return;
+
+	if (value < dev->battery_min || value > dev->battery_max)
 		return;
 
 	capacity = hidinput_scale_battery_capacity(dev, value);
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a85581cd511f..b9e67b408a4b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -83,9 +83,8 @@ enum latency_mode {
 	HID_LATENCY_HIGH = 1,
 };
 
-#define MT_IO_FLAGS_RUNNING		0
-#define MT_IO_FLAGS_ACTIVE_SLOTS	1
-#define MT_IO_FLAGS_PENDING_SLOTS	2
+#define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
+#define MT_IO_FLAGS_RUNNING		32
 
 static const bool mtrue = true;		/* default for true */
 static const bool mfalse;		/* default for false */
@@ -161,7 +160,11 @@ struct mt_device {
 	struct mt_class mtclass;	/* our mt device class */
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_device *hdev;	/* hid_device we're attached to */
-	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
+	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING)
+					 * first 8 bits are reserved for keeping the slot
+					 * states, this is fine because we only support up
+					 * to 250 slots (MT_MAX_MAXCONTACT)
+					 */
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
 	bool is_buttonpad;	/* is this device a button pad? */
@@ -936,6 +939,7 @@ static void mt_release_pending_palms(struct mt_device *td,
 
 	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
 		clear_bit(slotnum, app->pending_palm_slots);
+		clear_bit(slotnum, &td->mt_io_flags);
 
 		input_mt_slot(input, slotnum);
 		input_mt_report_slot_inactive(input);
@@ -967,12 +971,6 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
 
 	app->num_received = 0;
 	app->left_button_state = 0;
-
-	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
-		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
-	else
-		clear_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
-	clear_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
 }
 
 static int mt_compute_timestamp(struct mt_application *app, __s32 value)
@@ -1147,7 +1145,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
-		set_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
+		set_bit(slotnum, &td->mt_io_flags);
+	} else {
+		clear_bit(slotnum, &td->mt_io_flags);
 	}
 
 	return 0;
@@ -1282,7 +1282,7 @@ static void mt_touch_report(struct hid_device *hid,
 	 * defect.
 	 */
 	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
-		if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+		if (td->mt_io_flags & MT_IO_SLOTS_MASK)
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
 		else
@@ -1658,6 +1658,7 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	case HID_CP_CONSUMER_CONTROL:
 	case HID_GD_WIRELESS_RADIO_CTLS:
 	case HID_GD_SYSTEM_MULTIAXIS:
+	case HID_DG_PEN:
 		/* already handled by hid core */
 		break;
 	case HID_DG_TOUCHSCREEN:
@@ -1729,6 +1730,7 @@ static void mt_release_contacts(struct hid_device *hid)
 			for (i = 0; i < mt->num_slots; i++) {
 				input_mt_slot(input_dev, i);
 				input_mt_report_slot_inactive(input_dev);
+				clear_bit(i, &td->mt_io_flags);
 			}
 			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
@@ -1751,7 +1753,7 @@ static void mt_expired_timeout(struct timer_list *t)
 	 */
 	if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
-	if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+	if (td->mt_io_flags & MT_IO_SLOTS_MASK)
 		mt_release_contacts(hdev);
 	clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 7a0f5cfd9417..06ff9c2db04a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -748,7 +748,8 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 	const int8_t *temp;
 	unsigned int odr;
 	int64_t ts_val;
-	struct inv_icm42600_accel_buffer buffer;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_accel_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -767,8 +768,6 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
 							 st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index f955c3d01fef..0833dece8f9e 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -550,20 +550,12 @@ static void inv_icm42600_disable_vdd_reg(void *_data)
 static void inv_icm42600_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42600_state *st = _data;
-	const struct device *dev = regmap_get_device(st->map);
-	int ret;
-
-	ret = regulator_disable(st->vddio_supply);
-	if (ret)
-		dev_err(dev, "failed to disable vddio error %d\n", ret);
-}
+	struct device *dev = regmap_get_device(st->map);
 
-static void inv_icm42600_disable_pm(void *_data)
-{
-	struct device *dev = _data;
+	if (pm_runtime_status_suspended(dev))
+		return;
 
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
+	regulator_disable(st->vddio_supply);
 }
 
 int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
@@ -660,16 +652,14 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 		return ret;
 
 	/* setup runtime power management */
-	ret = pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
 		return ret;
-	pm_runtime_get_noresume(dev);
-	pm_runtime_enable(dev);
+
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42600_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_put(dev);
 
-	return devm_add_action_or_reset(dev, inv_icm42600_disable_pm, dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(inv_icm42600_core_probe);
 
@@ -680,17 +670,15 @@ EXPORT_SYMBOL_GPL(inv_icm42600_core_probe);
 static int __maybe_unused inv_icm42600_suspend(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
 	st->suspended.gyro = st->conf.gyro.mode;
 	st->suspended.accel = st->conf.accel.mode;
 	st->suspended.temp = st->conf.temp_en;
-	if (pm_runtime_suspended(dev)) {
-		ret = 0;
+	if (pm_runtime_suspended(dev))
 		goto out_unlock;
-	}
 
 	/* disable FIFO data streaming */
 	if (st->fifo.on) {
@@ -722,10 +710,13 @@ static int __maybe_unused inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	struct inv_icm42600_timestamp *gyro_ts = iio_priv(st->indio_gyro);
 	struct inv_icm42600_timestamp *accel_ts = iio_priv(st->indio_accel);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
+	if (pm_runtime_suspended(dev))
+		goto out_unlock;
+
 	ret = inv_icm42600_enable_regulator_vddio(st);
 	if (ret)
 		goto out_unlock;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 4fb796e11486..aad8899ef873 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -760,7 +760,8 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 	const int8_t *temp;
 	unsigned int odr;
 	int64_t ts_val;
-	struct inv_icm42600_gyro_buffer buffer;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_gyro_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -779,8 +780,6 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 			inv_icm42600_timestamp_apply_odr(ts, st->fifo.period,
 							 st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 665bcd366d89..85e4a7058ea2 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -363,6 +363,8 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
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
index 17648443a419..98fae8d0f2eb 100644
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
index 73258b24fea7..ff47e8397ec3 100644
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
index 69ea7db784fd..cefe37c447a2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2821,7 +2821,7 @@ static void bond_mii_monitor(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
 					    mii_work.work);
-	bool should_notify_peers = false;
+	bool should_notify_peers;
 	bool commit;
 	unsigned long delay;
 	struct slave *slave;
@@ -2833,30 +2833,33 @@ static void bond_mii_monitor(struct work_struct *work)
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
@@ -2864,13 +2867,6 @@ static void bond_mii_monitor(struct work_struct *work)
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
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 7425db9d34dd..69dfb7767238 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -252,7 +252,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_CAN_RESTART_MS]) {
-		if (!priv->do_set_mode) {
+		unsigned int restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+
+		if (restart_ms != 0 && !priv->do_set_mode) {
 			NL_SET_ERR_MSG(extack,
 				       "Device doesn't support restart from Bus Off");
 			return -EOPNOTSUPP;
@@ -261,7 +263,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
-		priv->restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+		priv->restart_ms = restart_ms;
 	}
 
 	if (data[IFLA_CAN_RESTART]) {
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index de6d8e01bf2e..71cf3662128a 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -170,7 +170,7 @@ static int m_can_plat_remove(struct platform_device *pdev)
 	struct m_can_classdev *mcan_class = &priv->cdev;
 
 	m_can_class_unregister(mcan_class);
-
+	pm_runtime_disable(mcan_class->dev);
 	m_can_class_free_dev(mcan_class->net);
 
 	return 0;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 34d45cebefb5..b4d57da71de2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1172,7 +1172,6 @@ static void xgbe_free_rx_data(struct xgbe_prv_data *pdata)
 
 static int xgbe_phy_reset(struct xgbe_prv_data *pdata)
 {
-	pdata->phy_link = -1;
 	pdata->phy_speed = SPEED_UNKNOWN;
 
 	return pdata->phy_if.phy_reset(pdata);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 19fed56b6ee3..ebb8b3e5b9a8 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1636,6 +1636,7 @@ static int xgbe_phy_init(struct xgbe_prv_data *pdata)
 		pdata->phy.duplex = DUPLEX_FULL;
 	}
 
+	pdata->phy_link = 0;
 	pdata->phy.link = 0;
 
 	pdata->phy.pause_autoneg = pdata->pause_autoneg;
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 95d460237835..8e5236142aac 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -5814,7 +5814,7 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 	u32 current_speed = SPEED_UNKNOWN;
 	u8 current_duplex = DUPLEX_UNKNOWN;
 	bool current_link_up = false;
-	u32 local_adv, remote_adv, sgsr;
+	u32 local_adv = 0, remote_adv = 0, sgsr;
 
 	if ((tg3_asic_rev(tp) == ASIC_REV_5719 ||
 	     tg3_asic_rev(tp) == ASIC_REV_5720) &&
@@ -5955,9 +5955,6 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 		else
 			current_duplex = DUPLEX_HALF;
 
-		local_adv = 0;
-		remote_adv = 0;
-
 		if (bmcr & BMCR_ANENABLE) {
 			u32 common;
 
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index bf58181589bf..2221d5b7eeba 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -498,25 +498,34 @@ static int alloc_list(struct net_device *dev)
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		/* Allocated fixed size of skbuff */
 		struct sk_buff *skb;
+		dma_addr_t addr;
 
 		skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
 		np->rx_skbuff[i] = skb;
-		if (!skb) {
-			free_list(dev);
-			return -ENOMEM;
-		}
+		if (!skb)
+			goto err_free_list;
+
+		addr = dma_map_single(&np->pdev->dev, skb->data,
+				      np->rx_buf_sz, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&np->pdev->dev, addr))
+			goto err_kfree_skb;
 
 		np->rx_ring[i].next_desc = cpu_to_le64(np->rx_ring_dma +
 						((i + 1) % RX_RING_SIZE) *
 						sizeof(struct netdev_desc));
 		/* Rubicon now supports 40 bits of addressing space. */
-		np->rx_ring[i].fraginfo =
-		    cpu_to_le64(dma_map_single(&np->pdev->dev, skb->data,
-					       np->rx_buf_sz, DMA_FROM_DEVICE));
+		np->rx_ring[i].fraginfo = cpu_to_le64(addr);
 		np->rx_ring[i].fraginfo |= cpu_to_le64((u64)np->rx_buf_sz << 48);
 	}
 
 	return 0;
+
+err_kfree_skb:
+	dev_kfree_skb(np->rx_skbuff[i]);
+	np->rx_skbuff[i] = NULL;
+err_free_list:
+	free_list(dev);
+	return -ENOMEM;
 }
 
 static void rio_hw_init(struct net_device *dev)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index dbc40e4514f0..3c19be56af22 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1046,8 +1046,7 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
 	dma_addr_t addr;
 
 	buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
-	aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
-				  DPAA2_ETH_TX_BUF_ALIGN);
+	aligned_start = PTR_ALIGN(buffer_start, DPAA2_ETH_TX_BUF_ALIGN);
 	if (aligned_start >= skb->head)
 		buffer_start = aligned_start;
 	else
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index c6d8cc15c270..aacdfe98b65a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -40,7 +40,7 @@ struct enetc_tx_swbd {
 };
 
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
-#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
+#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
 #define ENETC_RXB_DMA_SIZE	\
 	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index 5f08779c0e4e..e177d1d58696 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef _IXGBEVF_DEFINES_H_
 #define _IXGBEVF_DEFINES_H_
@@ -16,6 +16,9 @@
 #define IXGBE_DEV_ID_X550_VF_HV		0x1564
 #define IXGBE_DEV_ID_X550EM_X_VF_HV	0x15A9
 
+#define IXGBE_DEV_ID_E610_VF		0x57AD
+#define IXGBE_SUBDEV_ID_E610_VF_HV	0x00FF
+
 #define IXGBE_VF_IRQ_CLEAR_MASK		7
 #define IXGBE_VF_MAX_TX_QUEUES		8
 #define IXGBE_VF_MAX_RX_QUEUES		8
@@ -25,6 +28,7 @@
 
 /* Link speed */
 typedef u32 ixgbe_link_speed;
+#define IXGBE_LINK_SPEED_UNKNOWN	0
 #define IXGBE_LINK_SPEED_1GB_FULL	0x0020
 #define IXGBE_LINK_SPEED_10GB_FULL	0x0080
 #define IXGBE_LINK_SPEED_100_FULL	0x0008
diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index 74c121d7abc9..9e92c7732c7b 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -269,6 +269,9 @@ static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs)
 	adapter = netdev_priv(dev);
 	ipsec = adapter->ipsec;
 
+	if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+		return -EOPNOTSUPP;
+
 	if (xs->id.proto != IPPROTO_ESP && xs->id.proto != IPPROTO_AH) {
 		netdev_err(dev, "Unsupported protocol 0x%04x for IPsec offload\n",
 			   xs->id.proto);
@@ -394,6 +397,9 @@ static void ixgbevf_ipsec_del_sa(struct xfrm_state *xs)
 	adapter = netdev_priv(dev);
 	ipsec = adapter->ipsec;
 
+	if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+		return;
+
 	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
 		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
 
@@ -622,6 +628,10 @@ void ixgbevf_init_ipsec_offload(struct ixgbevf_adapter *adapter)
 	size_t size;
 
 	switch (adapter->hw.api_version) {
+	case ixgbe_mbox_api_17:
+		if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+			return;
+		break;
 	case ixgbe_mbox_api_14:
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 149c733fcc2b..1e25598cc778 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef _IXGBEVF_H_
 #define _IXGBEVF_H_
@@ -366,6 +366,13 @@ struct ixgbevf_adapter {
 	/* Interrupt Throttle Rate */
 	u32 eitr_param;
 
+	u32 pf_features;
+#define IXGBEVF_PF_SUP_IPSEC		BIT(0)
+#define IXGBEVF_PF_SUP_ESX_MBX		BIT(1)
+
+#define IXGBEVF_SUPPORTED_FEATURES	(IXGBEVF_PF_SUP_IPSEC | \
+					IXGBEVF_PF_SUP_ESX_MBX)
+
 	struct ixgbevf_hw_stats stats;
 
 	unsigned long state;
@@ -418,6 +425,8 @@ enum ixgbevf_boards {
 	board_X550EM_x_vf,
 	board_X550EM_x_vf_hv,
 	board_x550em_a_vf,
+	board_e610_vf,
+	board_e610_vf_hv,
 };
 
 enum ixgbevf_xcast_modes {
@@ -434,11 +443,13 @@ extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_info;
 extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops;
 extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops_legacy;
 extern const struct ixgbevf_info ixgbevf_x550em_a_vf_info;
+extern const struct ixgbevf_info ixgbevf_e610_vf_info;
 
 extern const struct ixgbevf_info ixgbevf_82599_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X540_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_hv_info;
+extern const struct ixgbevf_info ixgbevf_e610_vf_hv_info;
 extern const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops;
 
 /* needed by ethtool.c */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index e338fa572793..290207f15808 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 /******************************************************************************
  Copyright (c)2006 - 2007 Myricom, Inc. for some LRO specific code
@@ -39,7 +39,7 @@ static const char ixgbevf_driver_string[] =
 	"Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver";
 
 static char ixgbevf_copyright[] =
-	"Copyright (c) 2009 - 2018 Intel Corporation.";
+	"Copyright (c) 2009 - 2024 Intel Corporation.";
 
 static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
 	[board_82599_vf]	= &ixgbevf_82599_vf_info,
@@ -51,6 +51,8 @@ static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
 	[board_X550EM_x_vf]	= &ixgbevf_X550EM_x_vf_info,
 	[board_X550EM_x_vf_hv]	= &ixgbevf_X550EM_x_vf_hv_info,
 	[board_x550em_a_vf]	= &ixgbevf_x550em_a_vf_info,
+	[board_e610_vf]         = &ixgbevf_e610_vf_info,
+	[board_e610_vf_hv]      = &ixgbevf_e610_vf_hv_info,
 };
 
 /* ixgbevf_pci_tbl - PCI Device ID Table
@@ -71,6 +73,9 @@ static const struct pci_device_id ixgbevf_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF), board_X550EM_x_vf },
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF_HV), board_X550EM_x_vf_hv},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_VF), board_x550em_a_vf },
+	{PCI_VDEVICE_SUB(INTEL, IXGBE_DEV_ID_E610_VF, PCI_ANY_ID,
+			 IXGBE_SUBDEV_ID_E610_VF_HV), board_e610_vf_hv},
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_VF), board_e610_vf},
 	/* required last entry */
 	{0, }
 };
@@ -2263,10 +2268,36 @@ static void ixgbevf_init_last_counter_stats(struct ixgbevf_adapter *adapter)
 	adapter->stats.base_vfmprc = adapter->stats.last_vfmprc;
 }
 
+/**
+ * ixgbevf_set_features - Set features supported by PF
+ * @adapter: pointer to the adapter struct
+ *
+ * Negotiate with PF supported features and then set pf_features accordingly.
+ */
+static void ixgbevf_set_features(struct ixgbevf_adapter *adapter)
+{
+	u32 *pf_features = &adapter->pf_features;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int err;
+
+	err = hw->mac.ops.negotiate_features(hw, pf_features);
+	if (err && err != -EOPNOTSUPP)
+		netdev_dbg(adapter->netdev,
+			   "PF feature negotiation failed.\n");
+
+	/* Address also pre API 1.7 cases */
+	if (hw->api_version == ixgbe_mbox_api_14)
+		*pf_features |= IXGBEVF_PF_SUP_IPSEC;
+	else if (hw->api_version == ixgbe_mbox_api_15)
+		*pf_features |= IXGBEVF_PF_SUP_ESX_MBX;
+}
+
 static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	static const int api[] = {
+		ixgbe_mbox_api_17,
+		ixgbe_mbox_api_16,
 		ixgbe_mbox_api_15,
 		ixgbe_mbox_api_14,
 		ixgbe_mbox_api_13,
@@ -2286,7 +2317,9 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 		idx++;
 	}
 
-	if (hw->api_version >= ixgbe_mbox_api_15) {
+	ixgbevf_set_features(adapter);
+
+	if (adapter->pf_features & IXGBEVF_PF_SUP_ESX_MBX) {
 		hw->mbx.ops.init_params(hw);
 		memcpy(&hw->mbx.ops, &ixgbevf_mbx_ops,
 		       sizeof(struct ixgbe_mbx_operations));
@@ -2643,6 +2676,8 @@ static void ixgbevf_set_num_queues(struct ixgbevf_adapter *adapter)
 		case ixgbe_mbox_api_13:
 		case ixgbe_mbox_api_14:
 		case ixgbe_mbox_api_15:
+		case ixgbe_mbox_api_16:
+		case ixgbe_mbox_api_17:
 			if (adapter->xdp_prog &&
 			    hw->mac.max_tx_queues == rss)
 				rss = rss > 3 ? 2 : 1;
@@ -4636,6 +4671,8 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE -
 				  (ETH_HLEN + ETH_FCS_LEN);
 		break;
@@ -4686,6 +4723,9 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mac_X540_vf:
 		dev_info(&pdev->dev, "Intel(R) X540 Virtual Function\n");
 		break;
+	case ixgbe_mac_e610_vf:
+		dev_info(&pdev->dev, "Intel(R) E610 Virtual Function\n");
+		break;
 	case ixgbe_mac_82599_vf:
 	default:
 		dev_info(&pdev->dev, "Intel(R) 82599 Virtual Function\n");
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.h b/drivers/net/ethernet/intel/ixgbevf/mbx.h
index 835bbcc5cc8e..a8ed23ee66aa 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.h
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.h
@@ -66,6 +66,8 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_13,	/* API version 1.3, linux/freebsd VF driver */
 	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
 	ixgbe_mbox_api_15,	/* API version 1.5, linux/freebsd VF driver */
+	ixgbe_mbox_api_16,      /* API version 1.6, linux/freebsd VF driver */
+	ixgbe_mbox_api_17,	/* API version 1.7, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -102,6 +104,12 @@ enum ixgbe_pfvf_api_rev {
 
 #define IXGBE_VF_GET_LINK_STATE 0x10 /* get vf link state */
 
+/* mailbox API, version 1.6 VF requests */
+#define IXGBE_VF_GET_PF_LINK_STATE	0x11 /* request PF to send link info */
+
+/* mailbox API, version 1.7 VF requests */
+#define IXGBE_VF_FEATURES_NEGOTIATE	0x12 /* get features supported by PF*/
+
 /* length of permanent address message returned from PF */
 #define IXGBE_VF_PERMADDR_MSG_LEN	4
 /* word in permanent address message with the current multicast type */
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 1641d00d8ed3..65257107dfc8 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #include "vf.h"
 #include "ixgbevf.h"
@@ -313,6 +313,8 @@ int ixgbevf_get_reta_locked(struct ixgbe_hw *hw, u32 *reta, int num_rx_queues)
 	 * is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
+	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -382,6 +384,8 @@ int ixgbevf_get_rss_key_locked(struct ixgbe_hw *hw, u8 *rss_key)
 	 * or if the operation is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
+	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -552,6 +556,8 @@ static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -624,6 +630,85 @@ static s32 ixgbevf_hv_get_link_state_vf(struct ixgbe_hw *hw, bool *link_state)
 	return -EOPNOTSUPP;
 }
 
+/**
+ * ixgbevf_get_pf_link_state - Get PF's link status
+ * @hw: pointer to the HW structure
+ * @speed: link speed
+ * @link_up: indicate if link is up/down
+ *
+ * Ask PF to provide link_up state and speed of the link.
+ *
+ * Return: IXGBE_ERR_MBX in the case of mailbox error,
+ * -EOPNOTSUPP if the op is not supported or 0 on success.
+ */
+static int ixgbevf_get_pf_link_state(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+				     bool *link_up)
+{
+	u32 msgbuf[3] = {};
+	int err;
+
+	switch (hw->api_version) {
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	msgbuf[0] = IXGBE_VF_GET_PF_LINK_STATE;
+
+	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
+					 ARRAY_SIZE(msgbuf));
+	if (err || (msgbuf[0] & IXGBE_VT_MSGTYPE_FAILURE)) {
+		err = IXGBE_ERR_MBX;
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+		/* No need to set @link_up to false as it will be done by
+		 * ixgbe_check_mac_link_vf().
+		 */
+	} else {
+		*speed = msgbuf[1];
+		*link_up = msgbuf[2];
+	}
+
+	return err;
+}
+
+/**
+ * ixgbevf_negotiate_features_vf - negotiate supported features with PF driver
+ * @hw: pointer to the HW structure
+ * @pf_features: bitmask of features supported by PF
+ *
+ * Return: IXGBE_ERR_MBX in the  case of mailbox error,
+ * -EOPNOTSUPP if the op is not supported or 0 on success.
+ */
+static int ixgbevf_negotiate_features_vf(struct ixgbe_hw *hw, u32 *pf_features)
+{
+	u32 msgbuf[2] = {};
+	int err;
+
+	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	msgbuf[0] = IXGBE_VF_FEATURES_NEGOTIATE;
+	msgbuf[1] = IXGBEVF_SUPPORTED_FEATURES;
+
+	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
+					 ARRAY_SIZE(msgbuf));
+
+	if (err || (msgbuf[0] & IXGBE_VT_MSGTYPE_FAILURE)) {
+		err = IXGBE_ERR_MBX;
+		*pf_features = 0x0;
+	} else {
+		*pf_features = msgbuf[1];
+	}
+
+	return err;
+}
+
 /**
  *  ixgbevf_set_vfta_vf - Set/Unset VLAN filter table address
  *  @hw: pointer to the HW structure
@@ -658,6 +743,58 @@ static s32 ixgbevf_set_vfta_vf(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 	return err;
 }
 
+/**
+ * ixgbe_read_vflinks - Read VFLINKS register
+ * @hw: pointer to the HW structure
+ * @speed: link speed
+ * @link_up: indicate if link is up/down
+ *
+ * Get linkup status and link speed from the VFLINKS register.
+ */
+static void ixgbe_read_vflinks(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+			       bool *link_up)
+{
+	u32 vflinks = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+
+	/* if link status is down no point in checking to see if PF is up */
+	if (!(vflinks & IXGBE_LINKS_UP)) {
+		*link_up = false;
+		return;
+	}
+
+	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
+	 * before the link status is correct
+	 */
+	if (hw->mac.type == ixgbe_mac_82599_vf) {
+		for (int i = 0; i < 5; i++) {
+			udelay(100);
+			vflinks = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+
+			if (!(vflinks & IXGBE_LINKS_UP)) {
+				*link_up = false;
+				return;
+			}
+		}
+	}
+
+	/* We reached this point so there's link */
+	*link_up = true;
+
+	switch (vflinks & IXGBE_LINKS_SPEED_82599) {
+	case IXGBE_LINKS_SPEED_10G_82599:
+		*speed = IXGBE_LINK_SPEED_10GB_FULL;
+		break;
+	case IXGBE_LINKS_SPEED_1G_82599:
+		*speed = IXGBE_LINK_SPEED_1GB_FULL;
+		break;
+	case IXGBE_LINKS_SPEED_100_82599:
+		*speed = IXGBE_LINK_SPEED_100_FULL;
+		break;
+	default:
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+	}
+}
+
 /**
  * ixgbevf_hv_set_vfta_vf - * Hyper-V variant - just a stub.
  * @hw: unused
@@ -702,10 +839,10 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 				     bool *link_up,
 				     bool autoneg_wait_to_complete)
 {
+	struct ixgbevf_adapter *adapter = hw->back;
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 	struct ixgbe_mac_info *mac = &hw->mac;
 	s32 ret_val = 0;
-	u32 links_reg;
 	u32 in_msg = 0;
 
 	/* If we were hit with a reset drop the link */
@@ -715,43 +852,21 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mac->get_link_status)
 		goto out;
 
-	/* if link status is down no point in checking to see if pf is up */
-	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
-	if (!(links_reg & IXGBE_LINKS_UP))
-		goto out;
-
-	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
-	 * before the link status is correct
-	 */
-	if (mac->type == ixgbe_mac_82599_vf) {
-		int i;
-
-		for (i = 0; i < 5; i++) {
-			udelay(100);
-			links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
-
-			if (!(links_reg & IXGBE_LINKS_UP))
-				goto out;
-		}
-	}
-
-	switch (links_reg & IXGBE_LINKS_SPEED_82599) {
-	case IXGBE_LINKS_SPEED_10G_82599:
-		*speed = IXGBE_LINK_SPEED_10GB_FULL;
-		break;
-	case IXGBE_LINKS_SPEED_1G_82599:
-		*speed = IXGBE_LINK_SPEED_1GB_FULL;
-		break;
-	case IXGBE_LINKS_SPEED_100_82599:
-		*speed = IXGBE_LINK_SPEED_100_FULL;
-		break;
+	if (hw->mac.type == ixgbe_mac_e610_vf) {
+		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
+		if (ret_val)
+			goto out;
+	} else {
+		ixgbe_read_vflinks(hw, speed, link_up);
+		if (*link_up == false)
+			goto out;
 	}
 
 	/* if the read failed it could just be a mailbox collision, best wait
 	 * until we are called again and don't report an error
 	 */
 	if (mbx->ops.read(hw, &in_msg, 1)) {
-		if (hw->api_version >= ixgbe_mbox_api_15)
+		if (adapter->pf_features & IXGBEVF_PF_SUP_ESX_MBX)
 			mac->get_link_status = false;
 		goto out;
 	}
@@ -951,6 +1066,8 @@ int ixgbevf_get_queues(struct ixgbe_hw *hw, unsigned int *num_tcs,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return 0;
@@ -1005,6 +1122,7 @@ static const struct ixgbe_mac_operations ixgbevf_mac_ops = {
 	.setup_link		= ixgbevf_setup_mac_link_vf,
 	.check_link		= ixgbevf_check_mac_link_vf,
 	.negotiate_api_version	= ixgbevf_negotiate_api_version_vf,
+	.negotiate_features	= ixgbevf_negotiate_features_vf,
 	.set_rar		= ixgbevf_set_rar_vf,
 	.update_mc_addr_list	= ixgbevf_update_mc_addr_list_vf,
 	.update_xcast_mode	= ixgbevf_update_xcast_mode,
@@ -1076,3 +1194,13 @@ const struct ixgbevf_info ixgbevf_x550em_a_vf_info = {
 	.mac = ixgbe_mac_x550em_a_vf,
 	.mac_ops = &ixgbevf_mac_ops,
 };
+
+const struct ixgbevf_info ixgbevf_e610_vf_info = {
+	.mac                    = ixgbe_mac_e610_vf,
+	.mac_ops                = &ixgbevf_mac_ops,
+};
+
+const struct ixgbevf_info ixgbevf_e610_vf_hv_info = {
+	.mac            = ixgbe_mac_e610_vf,
+	.mac_ops        = &ixgbevf_hv_mac_ops,
+};
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index b4eef5b6c172..4f19b8900c29 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef __IXGBE_VF_H__
 #define __IXGBE_VF_H__
@@ -26,6 +26,7 @@ struct ixgbe_mac_operations {
 	s32 (*stop_adapter)(struct ixgbe_hw *);
 	s32 (*get_bus_info)(struct ixgbe_hw *);
 	s32 (*negotiate_api_version)(struct ixgbe_hw *hw, int api);
+	int (*negotiate_features)(struct ixgbe_hw *hw, u32 *pf_features);
 
 	/* Link */
 	s32 (*setup_link)(struct ixgbe_hw *, ixgbe_link_speed, bool, bool);
@@ -54,6 +55,8 @@ enum ixgbe_mac_type {
 	ixgbe_mac_X550_vf,
 	ixgbe_mac_X550EM_x_vf,
 	ixgbe_mac_x550em_a_vf,
+	ixgbe_mac_e610,
+	ixgbe_mac_e610_vf,
 	ixgbe_num_macs
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 33cc53f221e0..542cc017e64c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -94,7 +94,7 @@ u8 mlx5e_mpwrq_umr_entry_size(enum mlx5e_mpwrq_umr_mode mode)
 		return sizeof(struct mlx5_ksm) * 4;
 	}
 	WARN_ONCE(1, "MPWRQ UMR mode %d is not known\n", mode);
-	return 0;
+	return 1;
 }
 
 u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6346821d480b..6879660e44fa 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4950,8 +4950,9 @@ static int rtl8169_resume(struct device *device)
 	if (!device_may_wakeup(tp_to_dev(tp)))
 		clk_prepare_enable(tp->clk);
 
-	/* Reportedly at least Asus X453MA truncates packets otherwise */
-	if (tp->mac_version == RTL_GIGA_MAC_VER_37)
+	/* Some chip versions may truncate packets without this initialization */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_37 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_46)
 		rtl_init_rxcfg(tp);
 
 	return rtl8169_runtime_resume(device);
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 705010ea1d56..fe9d1461f6ea 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2054,15 +2054,35 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index cf682a9e3fff..34198d95c68b 100644
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
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 0f1c9009d793..42f8fc71baee 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1940,13 +1940,19 @@ static const struct ethtool_ops lan78xx_ethtool_ops = {
 	.get_regs	= lan78xx_get_regs,
 };
 
-static void lan78xx_init_mac_address(struct lan78xx_net *dev)
+static int lan78xx_init_mac_address(struct lan78xx_net *dev)
 {
 	u32 addr_lo, addr_hi;
 	u8 addr[6];
+	int ret;
+
+	ret = lan78xx_read_reg(dev, RX_ADDRL, &addr_lo);
+	if (ret < 0)
+		return ret;
 
-	lan78xx_read_reg(dev, RX_ADDRL, &addr_lo);
-	lan78xx_read_reg(dev, RX_ADDRH, &addr_hi);
+	ret = lan78xx_read_reg(dev, RX_ADDRH, &addr_hi);
+	if (ret < 0)
+		return ret;
 
 	addr[0] = addr_lo & 0xFF;
 	addr[1] = (addr_lo >> 8) & 0xFF;
@@ -1979,14 +1985,26 @@ static void lan78xx_init_mac_address(struct lan78xx_net *dev)
 			  (addr[2] << 16) | (addr[3] << 24);
 		addr_hi = addr[4] | (addr[5] << 8);
 
-		lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
-		lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+		ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+		if (ret < 0)
+			return ret;
 	}
 
-	lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
-	lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
+	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
+	if (ret < 0)
+		return ret;
 
 	eth_hw_addr_set(dev->net, addr);
+
+	return 0;
 }
 
 /* MDIO read and write wrappers for phylib */
@@ -2910,8 +2928,6 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		}
 	} while (buf & HW_CFG_LRST_);
 
-	lan78xx_init_mac_address(dev);
-
 	/* save DEVID for later usage */
 	ret = lan78xx_read_reg(dev, ID_REV, &buf);
 	if (ret < 0)
@@ -2920,6 +2936,10 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	dev->chipid = (buf & ID_REV_CHIP_ID_MASK_) >> 16;
 	dev->chiprev = buf & ID_REV_CHIP_REV_MASK_;
 
+	ret = lan78xx_init_mac_address(dev);
+	if (ret < 0)
+		return ret;
+
 	/* Respond to the IN token with a NAK */
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
 	if (ret < 0)
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index c2b715541989..63f418299c3e 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9952,7 +9952,12 @@ static int __init rtl8152_driver_init(void)
 	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
 	if (ret)
 		return ret;
-	return usb_register(&rtl8152_driver);
+
+	ret = usb_register(&rtl8152_driver);
+	if (ret)
+		usb_deregister_device_driver(&rtl8152_cfgselector_driver);
+
+	return ret;
 }
 
 static void __exit rtl8152_driver_exit(void)
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
diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index a82f845cc4b5..c0b325b54bfe 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -46,6 +46,7 @@ enum link_status {
 #define LANE_COUNT_MASK			BIT(8)
 #define LANE_COUNT(n)			((n) << 8)
 
+#define ACSPCIE_PAD_DISABLE_MASK	GENMASK(1, 0)
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
 
 #define MAX_LANES			2
@@ -218,6 +219,36 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 	return ret;
 }
 
+static int j721e_enable_acspcie_refclk(struct j721e_pcie *pcie,
+				       struct regmap *syscon)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct device_node *node = dev->of_node;
+	u32 mask = ACSPCIE_PAD_DISABLE_MASK;
+	struct of_phandle_args args;
+	u32 val;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(node,
+					       "ti,syscon-acspcie-proxy-ctrl",
+					       1, 0, &args);
+	if (ret) {
+		dev_err(dev,
+			"ti,syscon-acspcie-proxy-ctrl has invalid arguments\n");
+		return ret;
+	}
+
+	/* Clear PAD IO disable bits to enable refclk output */
+	val = ~(args.args[0]);
+	ret = regmap_update_bits(syscon, 0, mask, val);
+	if (ret) {
+		dev_err(dev, "failed to enable ACSPCIE refclk: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 {
 	struct device *dev = pcie->cdns_pcie->dev;
@@ -239,6 +270,25 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 	if (!ret)
 		offset = args.args[0];
 
+	/*
+	 * The PCIe Controller's registers have different "reset-values"
+	 * depending on the "strap" settings programmed into the PCIEn_CTRL
+	 * register within the CTRL_MMR memory-mapped register space.
+	 * The registers latch onto a "reset-value" based on the "strap"
+	 * settings sampled after the PCIe Controller is powered on.
+	 * To ensure that the "reset-values" are sampled accurately, power
+	 * off the PCIe Controller before programming the "strap" settings
+	 * and power it on after that. The runtime PM APIs namely
+	 * pm_runtime_put_sync() and pm_runtime_get_sync() will decrement and
+	 * increment the usage counter respectively, causing GENPD to power off
+	 * and power on the PCIe Controller.
+	 */
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power off PCIe Controller\n");
+		return ret;
+	}
+
 	ret = j721e_pcie_set_mode(pcie, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set pci mode\n");
@@ -257,7 +307,19 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return ret;
 	}
 
-	return 0;
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power on PCIe Controller\n");
+		return ret;
+	}
+
+	/* Enable ACSPCIE refclk output if the optional property exists */
+	syscon = syscon_regmap_lookup_by_phandle_optional(node,
+						"ti,syscon-acspcie-proxy-ctrl");
+	if (!syscon)
+		return 0;
+
+	return j721e_enable_acspcie_refclk(pcie, syscon);
 }
 
 static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 55bbc75c660b..0dca4baad0da 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1949,6 +1949,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void tegra_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+};
+
 static int tegra_pcie_ep_raise_legacy_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
 	/* Tegra194 supports only INTA */
@@ -2022,6 +2031,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = tegra_pcie_ep_init,
 	.raise_irq = tegra_pcie_ep_raise_irq,
 	.get_features = tegra_pcie_ep_get_features,
 };
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 3d1faaff50c9..7670e3e2ecc5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -186,9 +186,15 @@ static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
+
+	/* We read PCI_EXP_LNKCAP, so we need the device to be accessible. */
+	pci_config_pm_runtime_get(pdev);
+	ret = sysfs_emit(buf, "%s\n",
+			 pci_speed_string(pcie_get_speed_cap(pdev)));
+	pci_config_pm_runtime_put(pdev);
 
-	return sysfs_emit(buf, "%s\n",
-			  pci_speed_string(pcie_get_speed_cap(pdev)));
+	return ret;
 }
 static DEVICE_ATTR_RO(max_link_speed);
 
diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index 3dfdfb33cd0a..d65a7aeefe79 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -31,6 +31,7 @@
 
 #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
 #define DPHY_CMN_SSM_EN			BIT(0)
+#define DPHY_CMN_SSM_CAL_WAIT_TIME	GENMASK(8, 1)
 #define DPHY_CMN_TX_MODE_EN		BIT(9)
 
 #define DPHY_CMN_PWM			DPHY_PMA_CMN(0x40)
@@ -80,6 +81,7 @@ struct cdns_dphy_cfg {
 	u8 pll_ipdiv;
 	u8 pll_opdiv;
 	u16 pll_fbdiv;
+	u32 hs_clk_rate;
 	unsigned int nlanes;
 };
 
@@ -100,6 +102,8 @@ struct cdns_dphy_ops {
 	void (*set_pll_cfg)(struct cdns_dphy *dphy,
 			    const struct cdns_dphy_cfg *cfg);
 	unsigned long (*get_wakeup_time_ns)(struct cdns_dphy *dphy);
+	int (*wait_for_pll_lock)(struct cdns_dphy *dphy);
+	int (*wait_for_cmn_ready)(struct cdns_dphy *dphy);
 };
 
 struct cdns_dphy {
@@ -109,6 +113,8 @@ struct cdns_dphy {
 	struct clk *pll_ref_clk;
 	const struct cdns_dphy_ops *ops;
 	struct phy *phy;
+	bool is_configured;
+	bool is_powered;
 };
 
 /* Order of bands is important since the index is the band number. */
@@ -155,6 +161,9 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
 					  cfg->pll_ipdiv,
 					  pll_ref_hz);
 
+	cfg->hs_clk_rate = div_u64((u64)pll_ref_hz * cfg->pll_fbdiv,
+				   2 * cfg->pll_opdiv * cfg->pll_ipdiv);
+
 	return 0;
 }
 
@@ -192,6 +201,16 @@ static unsigned long cdns_dphy_get_wakeup_time_ns(struct cdns_dphy *dphy)
 	return dphy->ops->get_wakeup_time_ns(dphy);
 }
 
+static int cdns_dphy_wait_for_pll_lock(struct cdns_dphy *dphy)
+{
+	return dphy->ops->wait_for_pll_lock ? dphy->ops->wait_for_pll_lock(dphy) : 0;
+}
+
+static int cdns_dphy_wait_for_cmn_ready(struct cdns_dphy *dphy)
+{
+	return  dphy->ops->wait_for_cmn_ready ? dphy->ops->wait_for_cmn_ready(dphy) : 0;
+}
+
 static unsigned long cdns_dphy_ref_get_wakeup_time_ns(struct cdns_dphy *dphy)
 {
 	/* Default wakeup time is 800 ns (in a simulated environment). */
@@ -233,7 +252,6 @@ static unsigned long cdns_dphy_j721e_get_wakeup_time_ns(struct cdns_dphy *dphy)
 static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
 					const struct cdns_dphy_cfg *cfg)
 {
-	u32 status;
 
 	/*
 	 * set the PWM and PLL Byteclk divider settings to recommended values
@@ -250,13 +268,6 @@ static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
 
 	writel(DPHY_TX_J721E_WIZ_LANE_RSTB,
 	       dphy->regs + DPHY_TX_J721E_WIZ_RST_CTRL);
-
-	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL, status,
-			   (status & DPHY_TX_WIZ_PLL_LOCK), 0, POLL_TIMEOUT_US);
-
-	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_STATUS, status,
-			   (status & DPHY_TX_WIZ_O_CMN_READY), 0,
-			   POLL_TIMEOUT_US);
 }
 
 static void cdns_dphy_j721e_set_psm_div(struct cdns_dphy *dphy, u8 div)
@@ -264,6 +275,23 @@ static void cdns_dphy_j721e_set_psm_div(struct cdns_dphy *dphy, u8 div)
 	writel(div, dphy->regs + DPHY_TX_J721E_WIZ_PSM_FREQ);
 }
 
+static int cdns_dphy_j721e_wait_for_pll_lock(struct cdns_dphy *dphy)
+{
+	u32 status;
+
+	return readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL, status,
+			       status & DPHY_TX_WIZ_PLL_LOCK, 0, POLL_TIMEOUT_US);
+}
+
+static int cdns_dphy_j721e_wait_for_cmn_ready(struct cdns_dphy *dphy)
+{
+	u32 status;
+
+	return readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_STATUS, status,
+			       status & DPHY_TX_WIZ_O_CMN_READY, 0,
+			       POLL_TIMEOUT_US);
+}
+
 /*
  * This is the reference implementation of DPHY hooks. Specific integration of
  * this IP may have to re-implement some of them depending on how they decided
@@ -279,6 +307,8 @@ static const struct cdns_dphy_ops j721e_dphy_ops = {
 	.get_wakeup_time_ns = cdns_dphy_j721e_get_wakeup_time_ns,
 	.set_pll_cfg = cdns_dphy_j721e_set_pll_cfg,
 	.set_psm_div = cdns_dphy_j721e_set_psm_div,
+	.wait_for_pll_lock = cdns_dphy_j721e_wait_for_pll_lock,
+	.wait_for_cmn_ready = cdns_dphy_j721e_wait_for_cmn_ready,
 };
 
 static int cdns_dphy_config_from_opts(struct phy *phy,
@@ -298,6 +328,7 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 	if (ret)
 		return ret;
 
+	opts->hs_clk_rate = cfg->hs_clk_rate;
 	opts->wakeup = cdns_dphy_get_wakeup_time_ns(dphy) / 1000;
 
 	return 0;
@@ -335,21 +366,36 @@ static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
 static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
-	struct cdns_dphy_cfg cfg = { 0 };
-	int ret, band_ctrl;
-	unsigned int reg;
+	int ret;
 
-	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
-	if (ret)
-		return ret;
+	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &dphy->cfg);
+	if (!ret)
+		dphy->is_configured = true;
+
+	return ret;
+}
+
+static int cdns_dphy_power_on(struct phy *phy)
+{
+	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	int ret;
+	u32 reg;
+
+	if (!dphy->is_configured || dphy->is_powered)
+		return -EINVAL;
+
+	clk_prepare_enable(dphy->psm_clk);
+	clk_prepare_enable(dphy->pll_ref_clk);
 
 	/*
 	 * Configure the internal PSM clk divider so that the DPHY has a
 	 * 1MHz clk (or something close).
 	 */
 	ret = cdns_dphy_setup_psm(dphy);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_err(&dphy->phy->dev, "Failed to setup PSM with error %d\n", ret);
+		goto err_power_on;
+	}
 
 	/*
 	 * Configure attach clk lanes to data lanes: the DPHY has 2 clk lanes
@@ -364,40 +410,61 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	 * Configure the DPHY PLL that will be used to generate the TX byte
 	 * clk.
 	 */
-	cdns_dphy_set_pll_cfg(dphy, &cfg);
+	cdns_dphy_set_pll_cfg(dphy, &dphy->cfg);
 
-	band_ctrl = cdns_dphy_tx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
-	if (band_ctrl < 0)
-		return band_ctrl;
+	ret = cdns_dphy_tx_get_band_ctrl(dphy->cfg.hs_clk_rate);
+	if (ret < 0) {
+		dev_err(&dphy->phy->dev, "Failed to get band control value with error %d\n", ret);
+		goto err_power_on;
+	}
 
-	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
-	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
+	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, ret) |
+	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, ret);
 	writel(reg, dphy->regs + DPHY_BAND_CFG);
 
-	return 0;
-}
+	/* Start TX state machine. */
+	reg = readl(dphy->regs + DPHY_CMN_SSM);
+	writel((reg & DPHY_CMN_SSM_CAL_WAIT_TIME) | DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
+	       dphy->regs + DPHY_CMN_SSM);
 
-static int cdns_dphy_power_on(struct phy *phy)
-{
-	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	ret = cdns_dphy_wait_for_pll_lock(dphy);
+	if (ret) {
+		dev_err(&dphy->phy->dev, "Failed to lock PLL with error %d\n", ret);
+		goto err_power_on;
+	}
 
-	clk_prepare_enable(dphy->psm_clk);
-	clk_prepare_enable(dphy->pll_ref_clk);
+	ret = cdns_dphy_wait_for_cmn_ready(dphy);
+	if (ret) {
+		dev_err(&dphy->phy->dev, "O_CMN_READY signal failed to assert with error %d\n",
+			ret);
+		goto err_power_on;
+	}
 
-	/* Start TX state machine. */
-	writel(DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
-	       dphy->regs + DPHY_CMN_SSM);
+	dphy->is_powered = true;
 
 	return 0;
+
+err_power_on:
+	clk_disable_unprepare(dphy->pll_ref_clk);
+	clk_disable_unprepare(dphy->psm_clk);
+
+	return ret;
 }
 
 static int cdns_dphy_power_off(struct phy *phy)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	u32 reg;
 
 	clk_disable_unprepare(dphy->pll_ref_clk);
 	clk_disable_unprepare(dphy->psm_clk);
 
+	/* Stop TX state machine. */
+	reg = readl(dphy->regs + DPHY_CMN_SSM);
+	writel(reg & ~DPHY_CMN_SSM_EN, dphy->regs + DPHY_CMN_SSM);
+
+	dphy->is_powered = false;
+
 	return 0;
 }
 
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index bdf5a50bd931..1873c865b4d6 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1309,23 +1309,34 @@ void ccw_device_schedule_recovery(void)
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
@@ -1341,7 +1352,7 @@ static int purge_fn(struct device *dev, void *data)
 int ccw_purge_blacklisted(void)
 {
 	CIO_MSG_EVENT(2, "ccw: purging blacklisted devices\n");
-	bus_for_each_dev(&ccw_bus_type, NULL, NULL, purge_fn);
+	for_each_subchannel_staged(purge_fn, NULL, NULL);
 	return 0;
 }
 
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 72f9aab75ab1..c9ea85476477 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -638,7 +638,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index b5ae6ec61c9f..bbca9c501c60 100644
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
@@ -841,6 +843,12 @@ static const struct exar8250_board pbn_fastcom35x_8 = {
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
@@ -910,6 +918,9 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	USR_DEVICE(XR17C152, 2980, pbn_exar_XR17C15x),
 	USR_DEVICE(XR17C152, 2981, pbn_exar_XR17C15x),
 
+	/* ADVANTECH devices */
+	EXAR_DEVICE(ADVANTECH, XR17V352, pbn_adv_XR17V352),
+
 	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
 	EXAR_DEVICE(EXAR, XR17C152, pbn_exar_XR17C15x),
 	EXAR_DEVICE(EXAR, XR17C154, pbn_exar_XR17C15x),
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
 
diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/function/f_acm.c
index cb523f118f04..c84826c7cdc7 100644
--- a/drivers/usb/gadget/function/f_acm.c
+++ b/drivers/usb/gadget/function/f_acm.c
@@ -11,12 +11,15 @@
 
 /* #define VERBOSE_DEBUG */
 
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/err.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_serial.h"
 
 
@@ -612,6 +615,7 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_string	*us;
 	int			status;
 	struct usb_ep		*ep;
+	struct usb_request	*request __free(free_usb_request) = NULL;
 
 	/* REVISIT might want instance-specific strings to help
 	 * distinguish instances ...
@@ -629,7 +633,7 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs, and patch descriptors */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	acm->ctrl_id = status;
 	acm_iad_descriptor.bFirstInterface = status;
 
@@ -638,40 +642,38 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	acm->data_id = status;
 
 	acm_data_interface_desc.bInterfaceNumber = status;
 	acm_union_desc.bSlaveInterface0 = status;
 	acm_call_mgmt_descriptor.bDataInterface = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->port.in = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->port.out = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->notify = ep;
 
 	/* allocate notification */
-	acm->notify_req = gs_alloc_req(ep,
-			sizeof(struct usb_cdc_notification) + 2,
-			GFP_KERNEL);
-	if (!acm->notify_req)
-		goto fail;
+	request = gs_alloc_req(ep,
+			       sizeof(struct usb_cdc_notification) + 2,
+			       GFP_KERNEL);
+	if (!request)
+		return -ENODEV;
 
-	acm->notify_req->complete = acm_cdc_notify_complete;
-	acm->notify_req->context = acm;
+	request->complete = acm_cdc_notify_complete;
+	request->context = acm;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -688,7 +690,9 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, acm_fs_function, acm_hs_function,
 			acm_ss_function, acm_ss_function);
 	if (status)
-		goto fail;
+		return status;
+
+	acm->notify_req = no_free_ptr(request);
 
 	dev_dbg(&cdev->gadget->dev,
 		"acm ttyGS%d: %s speed IN/%s OUT/%s NOTIFY/%s\n",
@@ -698,14 +702,6 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 		acm->port.in->name, acm->port.out->name,
 		acm->notify->name);
 	return 0;
-
-fail:
-	if (acm->notify_req)
-		gs_free_req(acm->notify, acm->notify_req);
-
-	ERROR(cdev, "%s/%p: can't bind, err %d\n", f->name, f, status);
-
-	return status;
 }
 
 static void acm_unbind(struct usb_configuration *c, struct usb_function *f)
diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index ffe2486fce71..35ec50685b49 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -8,12 +8,15 @@
 
 /* #define VERBOSE_DEBUG */
 
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/etherdevice.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_ether.h"
 #include "u_ether_configfs.h"
 #include "u_ecm.h"
@@ -689,6 +692,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 
 	struct f_ecm_opts	*ecm_opts;
+	struct usb_request	*request __free(free_usb_request) = NULL;
 
 	if (!can_support_ecm(cdev->gadget))
 		return -EINVAL;
@@ -726,7 +730,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ecm->ctrl_id = status;
 	ecm_iad_descriptor.bFirstInterface = status;
 
@@ -735,24 +739,22 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ecm->data_id = status;
 
 	ecm_data_nop_intf.bInterfaceNumber = status;
 	ecm_data_intf.bInterfaceNumber = status;
 	ecm_union_desc.bSlaveInterface0 = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->port.out_ep = ep;
 
 	/* NOTE:  a status/notification endpoint is *OPTIONAL* but we
@@ -761,20 +763,18 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	 */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->notify = ep;
 
-	status = -ENOMEM;
-
 	/* allocate notification request and buffer */
-	ecm->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
-	if (!ecm->notify_req)
-		goto fail;
-	ecm->notify_req->buf = kmalloc(ECM_STATUS_BYTECOUNT, GFP_KERNEL);
-	if (!ecm->notify_req->buf)
-		goto fail;
-	ecm->notify_req->context = ecm;
-	ecm->notify_req->complete = ecm_notify_complete;
+	request = usb_ep_alloc_request(ep, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->buf = kmalloc(ECM_STATUS_BYTECOUNT, GFP_KERNEL);
+	if (!request->buf)
+		return -ENOMEM;
+	request->context = ecm;
+	request->complete = ecm_notify_complete;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -793,7 +793,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, ecm_fs_function, ecm_hs_function,
 			ecm_ss_function, ecm_ss_function);
 	if (status)
-		goto fail;
+		return status;
 
 	/* NOTE:  all that is done without knowing or caring about
 	 * the network link ... which is unavailable to this code
@@ -803,22 +803,14 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	ecm->port.open = ecm_open;
 	ecm->port.close = ecm_close;
 
+	ecm->notify_req = no_free_ptr(request);
+
 	DBG(cdev, "CDC Ethernet: %s speed IN/%s OUT/%s NOTIFY/%s\n",
 			gadget_is_superspeed(c->cdev->gadget) ? "super" :
 			gadget_is_dualspeed(c->cdev->gadget) ? "dual" : "full",
 			ecm->port.in_ep->name, ecm->port.out_ep->name,
 			ecm->notify->name);
 	return 0;
-
-fail:
-	if (ecm->notify_req) {
-		kfree(ecm->notify_req->buf);
-		usb_ep_free_request(ecm->notify, ecm->notify_req);
-	}
-
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 static inline struct f_ecm_opts *to_f_ecm_opts(struct config_item *item)
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index b267ed9dc6d9..ba99f2bce646 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2008 Nokia Corporation
  */
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -19,6 +20,7 @@
 #include <linux/crc32.h>
 
 #include <linux/usb/cdc.h>
+#include <linux/usb/gadget.h>
 
 #include "u_ether.h"
 #include "u_ether_configfs.h"
@@ -1437,18 +1439,18 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 	struct f_ncm_opts	*ncm_opts;
 
+	struct usb_os_desc_table	*os_desc_table __free(kfree) = NULL;
+	struct usb_request		*request __free(free_usb_request) = NULL;
+
 	if (!can_support_ecm(cdev->gadget))
 		return -EINVAL;
 
 	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
 
 	if (cdev->use_os_string) {
-		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
-					   GFP_KERNEL);
-		if (!f->os_desc_table)
+		os_desc_table = kzalloc(sizeof(*os_desc_table), GFP_KERNEL);
+		if (!os_desc_table)
 			return -ENOMEM;
-		f->os_desc_n = 1;
-		f->os_desc_table[0].os_desc = &ncm_opts->ncm_os_desc;
 	}
 
 	mutex_lock(&ncm_opts->lock);
@@ -1458,16 +1460,15 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	mutex_unlock(&ncm_opts->lock);
 
 	if (status)
-		goto fail;
+		return status;
 
 	ncm_opts->bound = true;
 
 	us = usb_gstrings_attach(cdev, ncm_strings,
 				 ARRAY_SIZE(ncm_string_defs));
-	if (IS_ERR(us)) {
-		status = PTR_ERR(us);
-		goto fail;
-	}
+	if (IS_ERR(us))
+		return PTR_ERR(us);
+
 	ncm_control_intf.iInterface = us[STRING_CTRL_IDX].id;
 	ncm_data_nop_intf.iInterface = us[STRING_DATA_IDX].id;
 	ncm_data_intf.iInterface = us[STRING_DATA_IDX].id;
@@ -1477,55 +1478,47 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ncm->ctrl_id = status;
 	ncm_iad_desc.bFirstInterface = status;
 
 	ncm_control_intf.bInterfaceNumber = status;
 	ncm_union_desc.bMasterInterface0 = status;
 
-	if (cdev->use_os_string)
-		f->os_desc_table[0].if_id =
-			ncm_iad_desc.bFirstInterface;
-
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ncm->data_id = status;
 
 	ncm_data_nop_intf.bInterfaceNumber = status;
 	ncm_data_intf.bInterfaceNumber = status;
 	ncm_union_desc.bSlaveInterface0 = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ncm->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ncm->port.out_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ncm->notify = ep;
 
-	status = -ENOMEM;
-
 	/* allocate notification request and buffer */
-	ncm->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
-	if (!ncm->notify_req)
-		goto fail;
-	ncm->notify_req->buf = kmalloc(NCM_STATUS_BYTECOUNT, GFP_KERNEL);
-	if (!ncm->notify_req->buf)
-		goto fail;
-	ncm->notify_req->context = ncm;
-	ncm->notify_req->complete = ncm_notify_complete;
+	request = usb_ep_alloc_request(ep, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->buf = kmalloc(NCM_STATUS_BYTECOUNT, GFP_KERNEL);
+	if (!request->buf)
+		return -ENOMEM;
+	request->context = ncm;
+	request->complete = ncm_notify_complete;
 
 	/*
 	 * support all relevant hardware speeds... we expect that when
@@ -1545,7 +1538,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, ncm_fs_function, ncm_hs_function,
 			ncm_ss_function, ncm_ss_function);
 	if (status)
-		goto fail;
+		return status;
 
 	/*
 	 * NOTE:  all that is done without knowing or caring about
@@ -1559,25 +1552,20 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	hrtimer_init(&ncm->task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	ncm->task_timer.function = ncm_tx_timeout;
 
+	if (cdev->use_os_string) {
+		os_desc_table[0].os_desc = &ncm_opts->ncm_os_desc;
+		os_desc_table[0].if_id = ncm_iad_desc.bFirstInterface;
+		f->os_desc_table = no_free_ptr(os_desc_table);
+		f->os_desc_n = 1;
+	}
+        ncm->notify_req = no_free_ptr(request);
+
 	DBG(cdev, "CDC Network: %s speed IN/%s OUT/%s NOTIFY/%s\n",
 			gadget_is_superspeed(c->cdev->gadget) ? "super" :
 			gadget_is_dualspeed(c->cdev->gadget) ? "dual" : "full",
 			ncm->port.in_ep->name, ncm->port.out_ep->name,
 			ncm->notify->name);
 	return 0;
-
-fail:
-	kfree(f->os_desc_table);
-	f->os_desc_n = 0;
-
-	if (ncm->notify_req) {
-		kfree(ncm->notify_req->buf);
-		usb_ep_free_request(ncm->notify, ncm->notify_req);
-	}
-
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 static inline struct f_ncm_opts *to_f_ncm_opts(struct config_item *item)
diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index ee95e8f5f9d4..1dbda4e98ac4 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -19,6 +19,8 @@
 
 #include <linux/atomic.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_ether.h"
 #include "u_ether_configfs.h"
 #include "u_rndis.h"
@@ -675,6 +677,8 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 
 	struct f_rndis_opts *rndis_opts;
+	struct usb_os_desc_table        *os_desc_table __free(kfree) = NULL;
+	struct usb_request		*request __free(free_usb_request) = NULL;
 
 	if (!can_support_rndis(c))
 		return -EINVAL;
@@ -682,12 +686,9 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	rndis_opts = container_of(f->fi, struct f_rndis_opts, func_inst);
 
 	if (cdev->use_os_string) {
-		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
-					   GFP_KERNEL);
-		if (!f->os_desc_table)
+		os_desc_table = kzalloc(sizeof(*os_desc_table), GFP_KERNEL);
+		if (!os_desc_table)
 			return -ENOMEM;
-		f->os_desc_n = 1;
-		f->os_desc_table[0].os_desc = &rndis_opts->rndis_os_desc;
 	}
 
 	rndis_iad_descriptor.bFunctionClass = rndis_opts->class;
@@ -705,16 +706,14 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 		gether_set_gadget(rndis_opts->net, cdev->gadget);
 		status = gether_register_netdev(rndis_opts->net);
 		if (status)
-			goto fail;
+			return status;
 		rndis_opts->bound = true;
 	}
 
 	us = usb_gstrings_attach(cdev, rndis_strings,
 				 ARRAY_SIZE(rndis_string_defs));
-	if (IS_ERR(us)) {
-		status = PTR_ERR(us);
-		goto fail;
-	}
+	if (IS_ERR(us))
+		return PTR_ERR(us);
 	rndis_control_intf.iInterface = us[0].id;
 	rndis_data_intf.iInterface = us[1].id;
 	rndis_iad_descriptor.iFunction = us[2].id;
@@ -722,36 +721,30 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	rndis->ctrl_id = status;
 	rndis_iad_descriptor.bFirstInterface = status;
 
 	rndis_control_intf.bInterfaceNumber = status;
 	rndis_union_desc.bMasterInterface0 = status;
 
-	if (cdev->use_os_string)
-		f->os_desc_table[0].if_id =
-			rndis_iad_descriptor.bFirstInterface;
-
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	rndis->data_id = status;
 
 	rndis_data_intf.bInterfaceNumber = status;
 	rndis_union_desc.bSlaveInterface0 = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->port.out_ep = ep;
 
 	/* NOTE:  a status/notification endpoint is, strictly speaking,
@@ -760,21 +753,19 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	 */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->notify = ep;
 
-	status = -ENOMEM;
-
 	/* allocate notification request and buffer */
-	rndis->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
-	if (!rndis->notify_req)
-		goto fail;
-	rndis->notify_req->buf = kmalloc(STATUS_BYTECOUNT, GFP_KERNEL);
-	if (!rndis->notify_req->buf)
-		goto fail;
-	rndis->notify_req->length = STATUS_BYTECOUNT;
-	rndis->notify_req->context = rndis;
-	rndis->notify_req->complete = rndis_response_complete;
+	request = usb_ep_alloc_request(ep, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->buf = kmalloc(STATUS_BYTECOUNT, GFP_KERNEL);
+	if (!request->buf)
+		return -ENOMEM;
+	request->length = STATUS_BYTECOUNT;
+	request->context = rndis;
+	request->complete = rndis_response_complete;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -791,7 +782,7 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, eth_fs_function, eth_hs_function,
 			eth_ss_function, eth_ss_function);
 	if (status)
-		goto fail;
+		return status;
 
 	rndis->port.open = rndis_open;
 	rndis->port.close = rndis_close;
@@ -802,9 +793,18 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	if (rndis->manufacturer && rndis->vendorID &&
 			rndis_set_param_vendor(rndis->params, rndis->vendorID,
 					       rndis->manufacturer)) {
-		status = -EINVAL;
-		goto fail_free_descs;
+		usb_free_all_descriptors(f);
+		return -EINVAL;
+	}
+
+	if (cdev->use_os_string) {
+		os_desc_table[0].os_desc = &rndis_opts->rndis_os_desc;
+		os_desc_table[0].if_id = rndis_iad_descriptor.bFirstInterface;
+		f->os_desc_table = no_free_ptr(os_desc_table);
+		f->os_desc_n = 1;
+
 	}
+	rndis->notify_req = no_free_ptr(request);
 
 	/* NOTE:  all that is done without knowing or caring about
 	 * the network link ... which is unavailable to this code
@@ -817,21 +817,6 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 			rndis->port.in_ep->name, rndis->port.out_ep->name,
 			rndis->notify->name);
 	return 0;
-
-fail_free_descs:
-	usb_free_all_descriptors(f);
-fail:
-	kfree(f->os_desc_table);
-	f->os_desc_n = 0;
-
-	if (rndis->notify_req) {
-		kfree(rndis->notify_req->buf);
-		usb_ep_free_request(rndis->notify, rndis->notify_req);
-	}
-
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 void rndis_borrow_net(struct usb_function_instance *f, struct net_device *net)
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
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 5adb6e831126..d98da3c44ff5 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -194,6 +194,9 @@ struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
 
 	req = ep->ops->alloc_request(ep, gfp_flags);
 
+	if (req)
+		req->ep = ep;
+
 	trace_usb_ep_alloc_request(ep, req, req ? 0 : -ENOMEM);
 
 	return req;
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 1963d9a45b67..3666b2fa179a 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -1136,8 +1136,15 @@ int xhci_dbc_suspend(struct xhci_hcd *xhci)
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
index 6f32842e24d5..6235eb9344af 100644
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
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 14bdb241ff6b..9e966e8876f5 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1102,14 +1102,15 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	 * If ret is 1 (no key found), it means this is an empty block group,
 	 * without any extents allocated from it and there's no block group
 	 * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
-	 * because we are using the block group tree feature, so block group
-	 * items are stored in the block group tree. It also means there are no
-	 * extents allocated for block groups with a start offset beyond this
-	 * block group's end offset (this is the last, highest, block group).
+	 * because we are using the block group tree feature (so block group
+	 * items are stored in the block group tree) or this is a new block
+	 * group created in the current transaction and its block group item
+	 * was not yet inserted in the extent tree (that happens in
+	 * btrfs_create_pending_block_groups() -> insert_block_group_item()).
+	 * It also means there are no extents allocated for block groups with a
+	 * start offset beyond this block group's end offset (this is the last,
+	 * highest, block group).
 	 */
-	if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
-		ASSERT(ret == 0);
-
 	start = block_group->start;
 	end = block_group->start + block_group->length;
 	while (ret == 0) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 46eddca596ae..3fdf5519336f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3915,6 +3915,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 /*
  * Mark start of chunk relocation that is cancellable. Check if the cancellation
  * has been requested meanwhile and don't start in that case.
+ * NOTE: if this returns an error, reloc_chunk_end() must not be called.
  *
  * Return:
  *   0             success
@@ -3931,10 +3932,8 @@ static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
 
 	if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
 		btrfs_info(fs_info, "chunk relocation canceled on start");
-		/*
-		 * On cancel, clear all requests but let the caller mark
-		 * the end after cleanup operations.
-		 */
+		/* On cancel, clear all requests. */
+		clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
 		atomic_set(&fs_info->reloc_cancel_req, 0);
 		return -ECANCELED;
 	}
@@ -3943,9 +3942,11 @@ static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
 
 /*
  * Mark end of chunk relocation that is cancellable and wake any waiters.
+ * NOTE: call only if a previous call to reloc_chunk_start() succeeded.
  */
 static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
 {
+	ASSERT(test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags));
 	/* Requested after start, clear bit first so any waiters can continue */
 	if (atomic_read(&fs_info->reloc_cancel_req) > 0)
 		btrfs_info(fs_info, "chunk relocation canceled during operation");
@@ -4158,9 +4159,9 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 	if (err && rw)
 		btrfs_dec_block_group_ro(rc->block_group);
 	iput(rc->data_inode);
+	reloc_chunk_end(fs_info);
 out_put_bg:
 	btrfs_put_block_group(bg);
-	reloc_chunk_end(fs_info);
 	free_reloc_control(rc);
 	return err;
 }
@@ -4350,8 +4351,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		err = ret;
 out_unset:
 	unset_reloc_control(rc);
-out_end:
 	reloc_chunk_end(fs_info);
+out_end:
 	free_reloc_control(rc);
 out:
 	free_reloc_roots(&reloc_roots);
diff --git a/fs/dax.c b/fs/dax.c
index ca7138bb1d54..2ebe70de35ec 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1524,7 +1524,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iov_iter_rw(iter) == WRITE) {
 		lockdep_assert_held_write(&iomi.inode->i_rwsem);
 		iomi.flags |= IOMAP_WRITE;
-	} else {
+	} else if (!sb_rdonly(iomi.inode->i_sb)) {
 		lockdep_assert_held(&iomi.inode->i_rwsem);
 	}
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 49461353ac37..15fba39b8919 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1862,6 +1862,8 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	__dget_dlock(parent);
 	dentry->d_parent = parent;
 	list_add(&dentry->d_child, &parent->d_subdirs);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		dentry->d_flags |= DCACHE_DISCONNECTED;
 	spin_unlock(&parent->d_lock);
 
 	return dentry;
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 23cf9b8f31b7..e7372d56c13f 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -825,7 +825,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_device_deregister(ls);
 
-	if (force < 3 && dlm_user_daemon_available())
+	if (force != 3 && dlm_user_daemon_available())
 		do_uevent(ls, 0);
 
 	dlm_recoverd_stop(ls);
diff --git a/fs/exec.c b/fs/exec.c
index b65af8f9a4f9..a4d21a67723d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -750,7 +750,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		    unsigned long stack_top,
 		    int executable_stack)
 {
-	unsigned long ret;
+	int ret;
 	unsigned long stack_shift;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 8e1fb18f465e..af1ef24d673f 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -271,9 +271,16 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 		  bh, is_metadata, inode->i_mode,
 		  test_opt(inode->i_sb, DATA_FLAGS));
 
-	/* In the no journal case, we can just do a bforget and return */
+	/*
+	 * In the no journal case, we should wait for the ongoing buffer
+	 * to complete and do a forget.
+	 */
 	if (!ext4_handle_valid(handle)) {
-		bforget(bh);
+		if (bh) {
+			clear_buffer_dirty(bh);
+			wait_on_buffer(bh);
+			__bforget(bh);
+		}
 		return 0;
 	}
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1a7f8f9af08d..1cb9dd4982ca 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4968,6 +4968,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 	ext4_set_inode_flags(inode, true);
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, function, line, 0,
+			"inode has both inline data and extents flags");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
 	inode->i_blocks = ext4_inode_blocks(raw_inode, ei);
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl_lo);
 	if (ext4_has_feature_64bit(sb))
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ab99197ee22e..b563c2e59227 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2415,7 +2415,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 					struct ext4_fs_context *m_ctx)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *s_mount_opts = NULL;
+	char s_mount_opts[65];
 	struct ext4_fs_context *s_ctx = NULL;
 	struct fs_context *fc = NULL;
 	int ret = -ENOMEM;
@@ -2423,15 +2423,11 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
-				sizeof(sbi->s_es->s_mount_opts),
-				GFP_KERNEL);
-	if (!s_mount_opts)
-		return ret;
+	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts, sizeof(s_mount_opts));
 
 	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-		goto out_free;
+		return -ENOMEM;
 
 	s_ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
 	if (!s_ctx)
@@ -2463,11 +2459,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	ret = 0;
 
 out_free:
-	if (fc) {
-		ext4_fc_free(fc);
-		kfree(fc);
-	}
-	kfree(s_mount_opts);
+	ext4_fc_free(fc);
+	kfree(fc);
 	return ret;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ac7d0ed3fb89..3f67b04fdb74 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1192,7 +1192,7 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 	return err;
 }
 
-int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
+static int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
 {
 	struct extent_info ei = {0, };
 	struct inode *inode = dn->inode;
@@ -1432,7 +1432,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	return 0;
 }
 
-void f2fs_do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
+static void f2fs_do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
 {
 	if (flag == F2FS_GET_BLOCK_PRE_AIO) {
 		if (lock)
@@ -1447,13 +1447,59 @@ void f2fs_do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
 	}
 }
 
+int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	int err;
+
+	f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
+	err = f2fs_get_block(dn, index);
+	f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+
+	return err;
+}
+
+static bool f2fs_map_blocks_cached(struct inode *inode,
+		struct f2fs_map_blocks *map, int flag)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int maxblocks = map->m_len;
+	pgoff_t pgoff = (pgoff_t)map->m_lblk;
+	struct extent_info ei = {};
+
+	if (!f2fs_lookup_read_extent_cache(inode, pgoff, &ei))
+		return false;
+
+	map->m_pblk = ei.blk + pgoff - ei.fofs;
+	map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgoff);
+	map->m_flags = F2FS_MAP_MAPPED;
+	if (map->m_next_extent)
+		*map->m_next_extent = pgoff + map->m_len;
+
+	/* for hardware encryption, but to avoid potential issue in future */
+	if (flag == F2FS_GET_BLOCK_DIO)
+		f2fs_wait_on_block_writeback_range(inode,
+					map->m_pblk, map->m_len);
+
+	if (f2fs_allow_multi_device_dio(sbi, flag)) {
+		int bidx = f2fs_target_device_index(sbi, map->m_pblk);
+		struct f2fs_dev_info *dev = &sbi->devs[bidx];
+
+		map->m_bdev = dev->bdev;
+		map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
+		map->m_pblk -= dev->start_blk;
+	} else {
+		map->m_bdev = inode->i_sb->s_bdev;
+	}
+	return true;
+}
+
 /*
  * f2fs_map_blocks() tries to find or build mapping relationship which
  * maps continuous logical blocks to physical blocks, and return such
  * info via f2fs_map_blocks structure.
  */
-int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
-						int create, int flag)
+int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 {
 	unsigned int maxblocks = map->m_len;
 	struct dnode_of_data dn;
@@ -1463,7 +1509,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	int err = 0, ofs = 1;
 	unsigned int ofs_in_node, last_ofs_in_node;
 	blkcnt_t prealloc;
-	struct extent_info ei = {0, };
 	block_t blkaddr;
 	unsigned int start_pgofs;
 	int bidx = 0;
@@ -1471,6 +1516,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	if (!maxblocks)
 		return 0;
 
+	if (!map->m_may_create && f2fs_map_blocks_cached(inode, map, flag))
+		goto out;
+
 	map->m_bdev = inode->i_sb->s_bdev;
 	map->m_multidev_dio =
 		f2fs_allow_multi_device_dio(F2FS_I_SB(inode), flag);
@@ -1482,39 +1530,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	pgofs =	(pgoff_t)map->m_lblk;
 	end = pgofs + maxblocks;
 
-	if (!create && f2fs_lookup_read_extent_cache(inode, pgofs, &ei)) {
-		if (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
-							map->m_may_create)
-			goto next_dnode;
-
-		map->m_pblk = ei.blk + pgofs - ei.fofs;
-		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
-		map->m_flags = F2FS_MAP_MAPPED;
-		if (map->m_next_extent)
-			*map->m_next_extent = pgofs + map->m_len;
-
-		/* for hardware encryption, but to avoid potential issue in future */
-		if (flag == F2FS_GET_BLOCK_DIO)
-			f2fs_wait_on_block_writeback_range(inode,
-						map->m_pblk, map->m_len);
-
-		if (map->m_multidev_dio) {
-			block_t blk_addr = map->m_pblk;
-
-			bidx = f2fs_target_device_index(sbi, map->m_pblk);
-
-			map->m_bdev = FDEV(bidx).bdev;
-			map->m_pblk -= FDEV(bidx).start_blk;
-			map->m_len = min(map->m_len,
-				FDEV(bidx).end_blk + 1 - map->m_pblk);
-
-			if (map->m_may_create)
-				f2fs_update_device_state(sbi, inode->i_ino,
-							blk_addr, map->m_len);
-		}
-		goto out;
-	}
-
 next_dnode:
 	if (map->m_may_create)
 		f2fs_do_map_lock(sbi, flag, true);
@@ -1577,7 +1592,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			set_inode_flag(inode, FI_APPEND_WRITE);
 		}
 	} else {
-		if (create) {
+		if (map->m_may_create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
 				goto sync_out;
@@ -1752,7 +1767,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
 out:
-	trace_f2fs_map_blocks(inode, map, create, flag, err);
+	trace_f2fs_map_blocks(inode, map, flag, err);
 	return err;
 }
 
@@ -1774,7 +1789,7 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
 
 	while (map.m_lblk < last_lblk) {
 		map.m_len = last_lblk - map.m_lblk;
-		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DEFAULT);
 		if (err || map.m_len == 0)
 			return false;
 		map.m_lblk += map.m_len;
@@ -1948,7 +1963,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		map.m_len = cluster_size - count_in_cluster;
 	}
 
-	ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
+	ret = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_FIEMAP);
 	if (ret)
 		goto out;
 
@@ -2081,7 +2096,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	map->m_lblk = block_in_file;
 	map->m_len = last_block - block_in_file;
 
-	ret = f2fs_map_blocks(inode, map, 0, F2FS_GET_BLOCK_DEFAULT);
+	ret = f2fs_map_blocks(inode, map, F2FS_GET_BLOCK_DEFAULT);
 	if (ret)
 		goto out;
 got_it:
@@ -3838,7 +3853,7 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 		map.m_next_pgofs = NULL;
 		map.m_seg_type = NO_CHECK_TYPE;
 
-		if (!f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_BMAP))
+		if (!f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_BMAP))
 			blknr = map.m_pblk;
 	}
 out:
@@ -3946,7 +3961,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 		map.m_seg_type = NO_CHECK_TYPE;
 		map.m_may_create = false;
 
-		ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
+		ret = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_FIEMAP);
 		if (ret)
 			goto out;
 
@@ -4175,8 +4190,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (flags & IOMAP_WRITE)
 		map.m_may_create = true;
 
-	err = f2fs_map_blocks(inode, &map, flags & IOMAP_WRITE,
-			      F2FS_GET_BLOCK_DIO);
+	err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);
 	if (err)
 		return err;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ad7bc58ce0a4..d8a32a02bcbc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3783,7 +3783,7 @@ void f2fs_set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
 int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
 int f2fs_reserve_new_block(struct dnode_of_data *dn);
-int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index);
+int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index);
 int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
 struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 			blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs);
@@ -3794,9 +3794,7 @@ struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
 struct page *f2fs_get_new_data_page(struct inode *inode,
 			struct page *ipage, pgoff_t index, bool new_i_size);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
-void f2fs_do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock);
-int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
-			int create, int flag);
+int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len);
 int f2fs_encrypt_one_page(struct f2fs_io_info *fio);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5e2a0cb8d24d..7411416fa51e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -113,10 +113,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	if (need_alloc) {
 		/* block allocation */
-		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = f2fs_get_block(&dn, page->index);
-		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+		err = f2fs_get_block_locked(&dn, page->index);
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -1802,7 +1800,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		f2fs_unlock_op(sbi);
 
 		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
-		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRE_DIO);
 		file_dont_truncate(inode);
 
 		f2fs_up_write(&sbi->pin_sem);
@@ -1815,7 +1813,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 
 		map.m_len = expanded;
 	} else {
-		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRE_AIO);
 		expanded = map.m_len;
 	}
 out_err:
@@ -2712,7 +2710,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	 */
 	while (map.m_lblk < pg_end) {
 		map.m_len = pg_end - map.m_lblk;
-		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DEFAULT);
 		if (err)
 			goto out;
 
@@ -2759,7 +2757,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 do_map:
 		map.m_len = pg_end - map.m_lblk;
-		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DEFAULT);
 		if (err)
 			goto clear_out;
 
@@ -3354,7 +3352,7 @@ int f2fs_precache_extents(struct inode *inode)
 		map.m_len = end - map.m_lblk;
 
 		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
-		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_PRECACHE);
+		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRECACHE);
 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 		if (err)
 			return err;
@@ -4637,7 +4635,7 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 		flag = F2FS_GET_BLOCK_PRE_AIO;
 	}
 
-	ret = f2fs_map_blocks(inode, &map, 1, flag);
+	ret = f2fs_map_blocks(inode, &map, flag);
 	/* -ENOSPC|-EDQUOT are fine to report the number of allocated blocks. */
 	if (ret < 0 && !((ret == -ENOSPC || ret == -EDQUOT) && map.m_len > 0))
 		return ret;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0dbacdd7bb0d..e54d70a42519 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -584,7 +584,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		goto out_err;
 
 	err = -ENOMEM;
-	ff = fuse_file_alloc(fm);
+	ff = fuse_file_alloc(fm, true);
 	if (!ff)
 		goto out_put_forget_req;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index db5ba56a837a..dd1864c95d07 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -54,7 +54,7 @@ struct fuse_release_args {
 	struct inode *inode;
 };
 
-struct fuse_file *fuse_file_alloc(struct fuse_mount *fm)
+struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
 {
 	struct fuse_file *ff;
 
@@ -63,11 +63,13 @@ struct fuse_file *fuse_file_alloc(struct fuse_mount *fm)
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
@@ -103,14 +105,14 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
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
@@ -130,15 +132,16 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
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
 
@@ -146,11 +149,13 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
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
@@ -272,7 +277,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 }
 
 static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
-				 unsigned int flags, int opcode)
+				 unsigned int flags, int opcode, bool sync)
 {
 	struct fuse_conn *fc = ff->fm->fc;
 	struct fuse_release_args *ra = ff->release_args;
@@ -290,6 +295,9 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 
 	wake_up_interruptible_all(&ff->poll_wait);
 
+	if (!ra)
+		return;
+
 	ra->inarg.fh = ff->fh;
 	ra->inarg.flags = flags;
 	ra->args.in_numargs = 1;
@@ -299,6 +307,13 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
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
@@ -308,14 +323,12 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
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
@@ -325,8 +338,14 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
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
@@ -361,12 +380,8 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
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
 
@@ -923,7 +938,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		put_page(page);
 	}
 	if (ia->ff)
-		fuse_file_put(ia->ff, false, false);
+		fuse_file_put(ia->ff, false);
 
 	fuse_io_free(ia);
 }
@@ -1670,7 +1685,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 		__free_page(ap->pages[i]);
 
 	if (wpa->ia.ff)
-		fuse_file_put(wpa->ia.ff, false, false);
+		fuse_file_put(wpa->ia.ff, false);
 
 	kfree(ap->pages);
 	kfree(wpa);
@@ -1918,7 +1933,7 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, false, false);
+		fuse_file_put(ff, false);
 
 	return err;
 }
@@ -2316,7 +2331,7 @@ static int fuse_writepages(struct address_space *mapping,
 		fuse_writepages_send(&data);
 	}
 	if (data.ff)
-		fuse_file_put(data.ff, false, false);
+		fuse_file_put(data.ff, false);
 
 	kfree(data.orig_pages);
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6c3ec70c1b70..d280ef6e346b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1022,7 +1022,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
  */
 int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
 
-struct fuse_file *fuse_file_alloc(struct fuse_mount *fm);
+struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
 void fuse_file_free(struct fuse_file *ff);
 void fuse_finish_open(struct inode *inode, struct file *file);
 
diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..6d37b4c75903 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
@@ -112,6 +112,12 @@ int hfs_brec_find(struct hfs_find_data *fd)
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
index 3227436f3a4a..e13da1fe2c2a 100644
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
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 36b6cf2a3abb..ebd326799f35 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -40,6 +40,18 @@ int hfsplus_strcasecmp(const struct hfsplus_unistr *s1,
 	p1 = s1->unicode;
 	p2 = s2->unicode;
 
+	if (len1 > HFSPLUS_MAX_STRLEN) {
+		len1 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s1->length), len1);
+	}
+
+	if (len2 > HFSPLUS_MAX_STRLEN) {
+		len2 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s2->length), len2);
+	}
+
 	while (1) {
 		c1 = c2 = 0;
 
@@ -74,6 +86,18 @@ int hfsplus_strcmp(const struct hfsplus_unistr *s1,
 	p1 = s1->unicode;
 	p2 = s2->unicode;
 
+	if (len1 > HFSPLUS_MAX_STRLEN) {
+		len1 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s1->length), len1);
+	}
+
+	if (len2 > HFSPLUS_MAX_STRLEN) {
+		len2 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s2->length), len2);
+	}
+
 	for (len = min(len1, len2); len > 0; len--) {
 		c1 = be16_to_cpu(*p1);
 		c2 = be16_to_cpu(*p2);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index ca6f3f8729f3..25e450bf94ff 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1668,6 +1668,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 	int drop_reserve = 0;
 	int err = 0;
 	int was_modified = 0;
+	int wait_for_writeback = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -1791,18 +1792,22 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 		}
 
 		/*
-		 * The buffer is still not written to disk, we should
-		 * attach this buffer to current transaction so that the
-		 * buffer can be checkpointed only after the current
-		 * transaction commits.
+		 * The buffer has not yet been written to disk. We should
+		 * either clear the buffer or ensure that the ongoing I/O
+		 * is completed, and attach this buffer to current
+		 * transaction so that the buffer can be checkpointed only
+		 * after the current transaction commits.
 		 */
 		clear_buffer_dirty(bh);
+		wait_for_writeback = 1;
 		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
 		spin_unlock(&journal->j_list_lock);
 	}
 drop:
 	__brelse(bh);
 	spin_unlock(&jh->b_state_lock);
+	if (wait_for_writeback)
+		wait_on_buffer(bh);
 	jbd2_journal_put_journal_head(jh);
 	if (drop_reserve) {
 		/* no need to reserve log space for this block -bzzz */
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 01d7fd108cf3..59f119cce3dc 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -117,7 +117,6 @@ static __be32
 nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
@@ -127,9 +126,9 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
 	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
 
-	if (new_size > i_size_read(inode)) {
+	if (lcp->lc_size_chg) {
 		iattr.ia_valid |= ATTR_SIZE;
-		iattr.ia_size = new_size;
+		iattr.ia_size = lcp->lc_newsize;
 	}
 
 	error = inode->i_sb->s_export_op->commit_blocks(inode, iomaps,
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 1ed2f691ebb9..dd35c472eb37 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -29,8 +29,7 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(len);
 	*p++ = cpu_to_be32(1);		/* we always return a single extent */
 
-	p = xdr_encode_opaque_fixed(p, &b->vol_id,
-			sizeof(struct nfsd4_deviceid));
+	p = svcxdr_encode_deviceid4(p, &b->vol_id);
 	p = xdr_encode_hyper(p, b->foff);
 	p = xdr_encode_hyper(p, b->len);
 	p = xdr_encode_hyper(p, b->soff);
@@ -145,9 +144,7 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
 
-		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
-		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
-
+		p = svcxdr_decode_deviceid4(p, &bex.vol_id);
 		p = xdr_decode_hyper(p, &bex.foff);
 		if (bex.foff & (block_size - 1)) {
 			dprintk("%s: unaligned offset 0x%llx\n",
diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 3ca5304440ff..0bc52e6bec39 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -125,6 +125,13 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
 	return 0;
 }
 
+static __be32
+nfsd4_ff_proc_layoutcommit(struct inode *inode,
+		struct nfsd4_layoutcommit *lcp)
+{
+	return nfs_ok;
+}
+
 const struct nfsd4_layout_ops ff_layout_ops = {
 	.notify_types		=
 			NOTIFY_DEVICEID4_DELETE | NOTIFY_DEVICEID4_CHANGE,
@@ -133,4 +140,5 @@ const struct nfsd4_layout_ops ff_layout_ops = {
 	.encode_getdeviceinfo	= nfsd4_ff_encode_getdeviceinfo,
 	.proc_layoutget		= nfsd4_ff_proc_layoutget,
 	.encode_layoutget	= nfsd4_ff_encode_layoutget,
+	.proc_layoutcommit	= nfsd4_ff_proc_layoutcommit,
 };
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index bb205328e043..223a10f37898 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -54,8 +54,7 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(1);			/* single mirror */
 	*p++ = cpu_to_be32(1);			/* single data server */
 
-	p = xdr_encode_opaque_fixed(p, &fl->deviceid,
-			sizeof(struct nfsd4_deviceid));
+	p = svcxdr_encode_deviceid4(p, &fl->deviceid);
 
 	*p++ = cpu_to_be32(1);			/* efficiency */
 
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index e8a80052cb1b..308214378fd3 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -120,7 +120,6 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 	id->fsid_idx = fhp->fh_export->ex_devid_map->idx;
 	id->generation = device_generation;
-	id->pad = 0;
 	return 0;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f9354c3713ac..11f906067943 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2261,7 +2261,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct inode *inode;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
@@ -2276,18 +2275,20 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		goto out;
 	inode = d_inode(current_fh->fh_dentry);
 
-	nfserr = nfserr_inval;
-	if (new_size <= seg->offset) {
-		dprintk("pnfsd: last write before layout segment\n");
-		goto out;
-	}
-	if (new_size > seg->offset + seg->length) {
-		dprintk("pnfsd: last write beyond layout segment\n");
-		goto out;
-	}
-	if (!lcp->lc_newoffset && new_size > i_size_read(inode)) {
-		dprintk("pnfsd: layoutcommit beyond EOF\n");
-		goto out;
+	lcp->lc_size_chg = false;
+	if (lcp->lc_newoffset) {
+		loff_t new_size = lcp->lc_last_wr + 1;
+
+		nfserr = nfserr_inval;
+		if (new_size <= seg->offset)
+			goto out;
+		if (new_size > seg->offset + seg->length)
+			goto out;
+
+		if (new_size > i_size_read(inode)) {
+			lcp->lc_size_chg = true;
+			lcp->lc_newsize = new_size;
+		}
 	}
 
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
@@ -2304,13 +2305,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	/* LAYOUTCOMMIT does not require any serialization */
 	mutex_unlock(&ls->ls_mutex);
 
-	if (new_size > i_size_read(inode)) {
-		lcp->lc_size_chg = 1;
-		lcp->lc_newsize = new_size;
-	} else {
-		lcp->lc_size_chg = 0;
-	}
-
 	nfserr = ops->proc_layoutcommit(inode, lcp);
 	nfs4_put_stid(&ls->ls_stid);
 out:
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 071c8103f6c3..5073fa77cd76 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -566,18 +566,6 @@ nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
 }
 
 #ifdef CONFIG_NFSD_PNFS
-static __be32
-nfsd4_decode_deviceid4(struct nfsd4_compoundargs *argp,
-		       struct nfsd4_deviceid *devid)
-{
-	__be32 *p;
-
-	p = xdr_inline_decode(argp->xdr, NFS4_DEVICEID4_SIZE);
-	if (!p)
-		return nfserr_bad_xdr;
-	memcpy(devid, p, sizeof(*devid));
-	return nfs_ok;
-}
 
 static __be32
 nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
@@ -1733,7 +1721,7 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 	__be32 status;
 
 	memset(gdev, 0, sizeof(*gdev));
-	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
+	status = nfsd4_decode_deviceid4(argp->xdr, &gdev->gd_devid);
 	if (status)
 		return status;
 	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_layout_type) < 0)
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 9bd1ade6ba54..c2765619edd4 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -459,9 +459,43 @@ struct nfsd4_reclaim_complete {
 struct nfsd4_deviceid {
 	u64			fsid_idx;
 	u32			generation;
-	u32			pad;
 };
 
+static inline __be32 *
+svcxdr_encode_deviceid4(__be32 *p, const struct nfsd4_deviceid *devid)
+{
+	__be64 *q = (__be64 *)p;
+
+	*q = (__force __be64)devid->fsid_idx;
+	p += 2;
+	*p++ = (__force __be32)devid->generation;
+	*p++ = xdr_zero;
+	return p;
+}
+
+static inline __be32 *
+svcxdr_decode_deviceid4(__be32 *p, struct nfsd4_deviceid *devid)
+{
+	__be64 *q = (__be64 *)p;
+
+	devid->fsid_idx = (__force u64)(*q);
+	p += 2;
+	devid->generation = (__force u32)(*p++);
+	p++; /* NFSD does not use the remaining octets */
+	return p;
+}
+
+static inline __be32
+nfsd4_decode_deviceid4(struct xdr_stream *xdr, struct nfsd4_deviceid *devid)
+{
+	__be32 *p = xdr_inline_decode(xdr, NFS4_DEVICEID4_SIZE);
+
+	if (unlikely(!p))
+		return nfserr_bad_xdr;
+	svcxdr_decode_deviceid4(p, devid);
+	return nfs_ok;
+}
+
 struct nfsd4_layout_seg {
 	u32			iomode;
 	u64			offset;
diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index b1e32ec4a9d4..866d57dfe9f7 100644
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
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index f3ed5134ecfa..51d38449ca85 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2106,8 +2106,10 @@ cifs_do_rename(const unsigned int xid, struct dentry *from_dentry,
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
 
-	if (!server->ops->rename)
-		return -ENOSYS;
+	if (!server->ops->rename) {
+		rc = -ENOSYS;
+		goto do_rename_exit;
+	}
 
 	/* try path-based rename first */
 	rc = server->ops->rename(xid, tcon, from_path, to_path, cifs_sb);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 99a0a1fe6618..13bfab36c04a 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -866,6 +866,14 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 	char *data_end;
 	struct dfs_referral_level_3 *ref;
 
+	if (rsp_size < sizeof(*rsp)) {
+		cifs_dbg(VFS | ONCE,
+			 "%s: header is malformed (size is %u, must be %zu)\n",
+			 __func__, rsp_size, sizeof(*rsp));
+		rc = -EINVAL;
+		goto parse_DFS_referrals_exit;
+	}
+
 	*num_of_nodes = le16_to_cpu(rsp->NumberOfReferrals);
 
 	if (*num_of_nodes < 1) {
@@ -875,6 +883,15 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		goto parse_DFS_referrals_exit;
 	}
 
+	if (sizeof(*rsp) + *num_of_nodes * sizeof(REFERRAL3) > rsp_size) {
+		cifs_dbg(VFS | ONCE,
+			 "%s: malformed buffer (size is %u, must be at least %zu)\n",
+			 __func__, rsp_size,
+			 sizeof(*rsp) + *num_of_nodes * sizeof(REFERRAL3));
+		rc = -EINVAL;
+		goto parse_DFS_referrals_exit;
+	}
+
 	ref = (struct dfs_referral_level_3 *) &(rsp->referrals);
 	if (ref->VersionNumber != cpu_to_le16(3)) {
 		cifs_dbg(VFS, "Referrals of V%d version are not supported, should be V3\n",
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 4dd5b2e04886..497417a98397 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3323,8 +3323,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
 	if (!utf16_path) {
 		rc = -ENOMEM;
-		free_xid(xid);
-		return ERR_PTR(rc);
+		goto put_tlink;
 	}
 
 	oparms = (struct cifs_open_parms) {
@@ -3356,6 +3355,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	}
 
+put_tlink:
 	cifs_put_tlink(tlink);
 	free_xid(xid);
 
@@ -3396,8 +3396,7 @@ set_smb2_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
 	if (!utf16_path) {
 		rc = -ENOMEM;
-		free_xid(xid);
-		return rc;
+		goto put_tlink;
 	}
 
 	oparms = (struct cifs_open_parms) {
@@ -3418,6 +3417,7 @@ set_smb2_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	}
 
+put_tlink:
 	cifs_put_tlink(tlink);
 	free_xid(xid);
 	return rc;
diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index d3c0b985eb8c..475de7289e22 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -107,8 +107,9 @@ struct ksmbd_startup_request {
 	__u32	smb2_max_credits;	/* MAX credits */
 	__u32	smbd_max_io_size;	/* smbd read write size */
 	__u32	max_connections;	/* Number of maximum simultaneous connections */
+	__s8	bind_interfaces_only;
 	__u32	max_ip_connections;	/* Number of maximum connection per ip address */
-	__u32	reserved[125];		/* Reserved room */
+	__s8	reserved[499];		/* Reserved room */
 	__u32	ifc_list_sz;		/* interfaces list size */
 	__s8	____payload[];
 } __packed;
diff --git a/fs/smb/server/server.h b/fs/smb/server/server.h
index 2cb1b855a39e..3cdeda5d0c20 100644
--- a/fs/smb/server/server.h
+++ b/fs/smb/server/server.h
@@ -45,6 +45,7 @@ struct ksmbd_server_config {
 	unsigned int		max_ip_connections;
 
 	char			*conf[SERVER_CONF_WORK_GROUP + 1];
+	bool			bind_interfaces_only;
 };
 
 extern struct ksmbd_server_config server_conf;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5cf14a910d5b..d2dca5d2f17c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -37,6 +37,7 @@
 #include "mgmt/user_session.h"
 #include "mgmt/ksmbd_ida.h"
 #include "ndr.h"
+#include "transport_tcp.h"
 
 static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
 {
@@ -7423,6 +7424,9 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		if (netdev->type == ARPHRD_LOOPBACK)
 			continue;
 
+		if (!ksmbd_find_netdev_name_iface_list(netdev->name))
+			continue;
+
 		flags = dev_get_flags(netdev);
 		if (!(flags & IFF_RUNNING))
 			continue;
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 3ca820d0b8d6..15c393ef6607 100644
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
@@ -324,6 +330,7 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	ret = ksmbd_set_netbios_name(req->netbios_name);
 	ret |= ksmbd_set_server_string(req->server_string);
 	ret |= ksmbd_set_work_group(req->work_group);
+	server_conf.bind_interfaces_only = req->bind_interfaces_only;
 	ret |= ksmbd_tcp_set_interfaces(KSMBD_STARTUP_CONFIG_INTERFACES(req),
 					req->ifc_list_sz);
 out:
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index af1c41f922bb..81da8a5c1e0d 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -933,12 +933,15 @@ static int smb_direct_flush_send_list(struct smb_direct_transport *t,
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
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 4ef032e737f3..f07b9e147fe2 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -544,30 +544,37 @@ static int create_socket(struct interface *iface)
 	return ret;
 }
 
+struct interface *ksmbd_find_netdev_name_iface_list(char *netdev_name)
+{
+	struct interface *iface;
+
+	list_for_each_entry(iface, &iface_list, entry)
+		if (!strcmp(iface->name, netdev_name))
+			return iface;
+	return NULL;
+}
+
 static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 			      void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
 	struct interface *iface;
-	int ret, found = 0;
+	int ret;
 
 	switch (event) {
 	case NETDEV_UP:
 		if (netif_is_bridge_port(netdev))
 			return NOTIFY_OK;
 
-		list_for_each_entry(iface, &iface_list, entry) {
-			if (!strcmp(iface->name, netdev->name)) {
-				found = 1;
-				if (iface->state != IFACE_STATE_DOWN)
-					break;
-				ret = create_socket(iface);
-				if (ret)
-					return NOTIFY_OK;
-				break;
-			}
+		iface = ksmbd_find_netdev_name_iface_list(netdev->name);
+		if (iface && iface->state == IFACE_STATE_DOWN) {
+			ksmbd_debug(CONN, "netdev-up event: netdev(%s) is going up\n",
+					iface->name);
+			ret = create_socket(iface);
+			if (ret)
+				return NOTIFY_OK;
 		}
-		if (!found && bind_additional_ifaces) {
+		if (!iface && bind_additional_ifaces) {
 			iface = alloc_iface(kstrdup(netdev->name, GFP_KERNEL));
 			if (!iface)
 				return NOTIFY_OK;
@@ -577,19 +584,19 @@ static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 		}
 		break;
 	case NETDEV_DOWN:
-		list_for_each_entry(iface, &iface_list, entry) {
-			if (!strcmp(iface->name, netdev->name) &&
-			    iface->state == IFACE_STATE_CONFIGURED) {
-				tcp_stop_kthread(iface->ksmbd_kthread);
-				iface->ksmbd_kthread = NULL;
-				mutex_lock(&iface->sock_release_lock);
-				tcp_destroy_socket(iface->ksmbd_socket);
-				iface->ksmbd_socket = NULL;
-				mutex_unlock(&iface->sock_release_lock);
-
-				iface->state = IFACE_STATE_DOWN;
-				break;
-			}
+		iface = ksmbd_find_netdev_name_iface_list(netdev->name);
+		if (iface && iface->state == IFACE_STATE_CONFIGURED) {
+			ksmbd_debug(CONN, "netdev-down event: netdev(%s) is going down\n",
+					iface->name);
+			tcp_stop_kthread(iface->ksmbd_kthread);
+			iface->ksmbd_kthread = NULL;
+			mutex_lock(&iface->sock_release_lock);
+			tcp_destroy_socket(iface->ksmbd_socket);
+			iface->ksmbd_socket = NULL;
+			mutex_unlock(&iface->sock_release_lock);
+
+			iface->state = IFACE_STATE_DOWN;
+			break;
 		}
 		break;
 	}
@@ -658,18 +665,6 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 	int sz = 0;
 
 	if (!ifc_list_sz) {
-		struct net_device *netdev;
-
-		rtnl_lock();
-		for_each_netdev(&init_net, netdev) {
-			if (netif_is_bridge_port(netdev))
-				continue;
-			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL))) {
-				rtnl_unlock();
-				return -ENOMEM;
-			}
-		}
-		rtnl_unlock();
 		bind_additional_ifaces = 1;
 		return 0;
 	}
diff --git a/fs/smb/server/transport_tcp.h b/fs/smb/server/transport_tcp.h
index e338bebe322f..8c9aa624cfe3 100644
--- a/fs/smb/server/transport_tcp.h
+++ b/fs/smb/server/transport_tcp.h
@@ -7,6 +7,7 @@
 #define __KSMBD_TRANSPORT_TCP_H__
 
 int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz);
+struct interface *ksmbd_find_netdev_name_iface_list(char *netdev_name);
 int ksmbd_tcp_init(void);
 void ksmbd_tcp_destroy(void);
 
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 269573c82808..e267fc9d3108 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -171,12 +171,40 @@ typedef struct xlog_rec_header {
 	__be32	  h_prev_block; /* block number to previous LR		:  4 */
 	__be32	  h_num_logops;	/* number of log operations in this LR	:  4 */
 	__be32	  h_cycle_data[XLOG_HEADER_CYCLE_SIZE / BBSIZE];
-	/* new fields */
+
+	/* fields added by the Linux port: */
 	__be32    h_fmt;        /* format of log record                 :  4 */
 	uuid_t	  h_fs_uuid;    /* uuid of FS                           : 16 */
+
+	/* fields added for log v2: */
 	__be32	  h_size;	/* iclog size				:  4 */
+
+	/*
+	 * When h_size added for log v2 support, it caused structure to have
+	 * a different size on i386 vs all other architectures because the
+	 * sum of the size ofthe  member is not aligned by that of the largest
+	 * __be64-sized member, and i386 has really odd struct alignment rules.
+	 *
+	 * Due to the way the log headers are placed out on-disk that alone is
+	 * not a problem becaue the xlog_rec_header always sits alone in a
+	 * BBSIZEs area, and the rest of that area is padded with zeroes.
+	 * But xlog_cksum used to calculate the checksum based on the structure
+	 * size, and thus gives different checksums for i386 vs the rest.
+	 * We now do two checksum validation passes for both sizes to allow
+	 * moving v5 file systems with unclean logs between i386 and other
+	 * (little-endian) architectures.
+	 */
+	__u32	  h_pad0;
 } xlog_rec_header_t;
 
+#ifdef __i386__
+#define XLOG_REC_SIZE		offsetofend(struct xlog_rec_header, h_size)
+#define XLOG_REC_SIZE_OTHER	sizeof(struct xlog_rec_header)
+#else
+#define XLOG_REC_SIZE		sizeof(struct xlog_rec_header)
+#define XLOG_REC_SIZE_OTHER	offsetofend(struct xlog_rec_header, h_size)
+#endif /* __i386__ */
+
 typedef struct xlog_rec_ext_header {
 	__be32	  xh_cycle;	/* write cycle of log			: 4 */
 	__be32	  xh_cycle_data[XLOG_HEADER_CYCLE_SIZE / BBSIZE]; /*	: 256 */
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index ce6b303484cf..f4af42b3887d 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1804,13 +1804,13 @@ xlog_cksum(
 	struct xlog		*log,
 	struct xlog_rec_header	*rhead,
 	char			*dp,
-	int			size)
+	unsigned int		hdrsize,
+	unsigned int		size)
 {
 	uint32_t		crc;
 
 	/* first generate the crc for the record header ... */
-	crc = xfs_start_cksum_update((char *)rhead,
-			      sizeof(struct xlog_rec_header),
+	crc = xfs_start_cksum_update((char *)rhead, hdrsize,
 			      offsetof(struct xlog_rec_header, h_crc));
 
 	/* ... then for additional cycle data for v2 logs ... */
@@ -2074,7 +2074,7 @@ xlog_sync(
 
 	/* calculcate the checksum */
 	iclog->ic_header.h_crc = xlog_cksum(log, &iclog->ic_header,
-					    iclog->ic_datap, size);
+			iclog->ic_datap, XLOG_REC_SIZE, size);
 	/*
 	 * Intentionally corrupt the log record CRC based on the error injection
 	 * frequency, if defined. This facilitates testing log recovery in the
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index 1bd2963e8fbd..3a73e39f017e 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -498,8 +498,8 @@ xlog_recover_finish(
 extern void
 xlog_recover_cancel(struct xlog *);
 
-extern __le32	 xlog_cksum(struct xlog *log, struct xlog_rec_header *rhead,
-			    char *dp, int size);
+__le32	 xlog_cksum(struct xlog *log, struct xlog_rec_header *rhead,
+		char *dp, unsigned int hdrsize, unsigned int size);
 
 extern struct kmem_cache *xfs_log_ticket_cache;
 struct xlog_ticket *xlog_ticket_alloc(struct xlog *log, int unit_bytes,
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index e009bb23d8a2..20e4c3c3b9e7 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2854,20 +2854,34 @@ xlog_recover_process(
 	int			pass,
 	struct list_head	*buffer_list)
 {
-	__le32			old_crc = rhead->h_crc;
-	__le32			crc;
+	__le32			expected_crc = rhead->h_crc, crc, other_crc;
 
-	crc = xlog_cksum(log, rhead, dp, be32_to_cpu(rhead->h_len));
+	crc = xlog_cksum(log, rhead, dp, XLOG_REC_SIZE,
+			be32_to_cpu(rhead->h_len));
+
+	/*
+	 * Look at the end of the struct xlog_rec_header definition in
+	 * xfs_log_format.h for the glory details.
+	 */
+	if (expected_crc && crc != expected_crc) {
+		other_crc = xlog_cksum(log, rhead, dp, XLOG_REC_SIZE_OTHER,
+				be32_to_cpu(rhead->h_len));
+		if (other_crc == expected_crc) {
+			xfs_notice_once(log->l_mp,
+	"Fixing up incorrect CRC due to padding.");
+			crc = other_crc;
+		}
+	}
 
 	/*
 	 * Nothing else to do if this is a CRC verification pass. Just return
 	 * if this a record with a non-zero crc. Unfortunately, mkfs always
-	 * sets old_crc to 0 so we must consider this valid even on v5 supers.
-	 * Otherwise, return EFSBADCRC on failure so the callers up the stack
-	 * know precisely what failed.
+	 * sets expected_crc to 0 so we must consider this valid even on v5
+	 * supers.  Otherwise, return EFSBADCRC on failure so the callers up the
+	 * stack know precisely what failed.
 	 */
 	if (pass == XLOG_RECOVER_CRCPASS) {
-		if (old_crc && crc != old_crc)
+		if (expected_crc && crc != expected_crc)
 			return -EFSBADCRC;
 		return 0;
 	}
@@ -2878,11 +2892,11 @@ xlog_recover_process(
 	 * zero CRC check prevents warnings from being emitted when upgrading
 	 * the kernel from one that does not add CRCs by default.
 	 */
-	if (crc != old_crc) {
-		if (old_crc || xfs_has_crc(log->l_mp)) {
+	if (crc != expected_crc) {
+		if (expected_crc || xfs_has_crc(log->l_mp)) {
 			xfs_alert(log->l_mp,
 		"log record CRC mismatch: found 0x%x, expected 0x%x.",
-					le32_to_cpu(old_crc),
+					le32_to_cpu(expected_crc),
 					le32_to_cpu(crc));
 			xfs_hex_dump(dp, 32);
 		}
diff --git a/fs/xfs/xfs_ondisk.h b/fs/xfs/xfs_ondisk.h
index 9737b5a9f405..cbeec878ca96 100644
--- a/fs/xfs/xfs_ondisk.h
+++ b/fs/xfs/xfs_ondisk.h
@@ -142,6 +142,8 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_STRUCT_SIZE(struct xfs_rud_log_format,	16);
 	XFS_CHECK_STRUCT_SIZE(struct xfs_map_extent,		32);
 	XFS_CHECK_STRUCT_SIZE(struct xfs_phys_extent,		16);
+	XFS_CHECK_STRUCT_SIZE(struct xlog_rec_header,		328);
+	XFS_CHECK_STRUCT_SIZE(struct xlog_rec_ext_header,	260);
 
 	XFS_CHECK_OFFSET(struct xfs_bui_log_format, bui_extents,	16);
 	XFS_CHECK_OFFSET(struct xfs_cui_log_format, cui_extents,	16);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 2ef331132fca..8752eb58d036 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1201,16 +1201,25 @@ suffix_kstrtoint(
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
 
@@ -1349,19 +1358,19 @@ xfs_fs_parse_param(
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
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d87a0d024693..89f226f1b4ec 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -32,6 +32,9 @@
  */
 
 #define CPUFREQ_ETERNAL			(-1)
+
+#define CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS	NSEC_PER_MSEC
+
 #define CPUFREQ_NAME_LEN		16
 /* Print length for names. Extra 1 space for accommodating '\n' in prints */
 #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3bf7823e1097..44381ffaf34b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -316,7 +316,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
 #define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
 #define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
-#define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
+#define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
 
 #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
 #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59dfa59d6d59..ea50d050d021 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1026,6 +1026,20 @@ static inline struct pci_driver *to_pci_driver(struct device_driver *drv)
 	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0
 
+/**
+ * PCI_VDEVICE_SUB - describe a specific PCI device/subdevice in a short form
+ * @vend: the vendor name
+ * @dev: the 16 bit PCI Device ID
+ * @subvend: the 16 bit PCI Subvendor ID
+ * @subdev: the 16 bit PCI Subdevice ID
+ *
+ * Generate the pci_device_id struct layout for the specific PCI
+ * device/subdevice. Private data may follow the output.
+ */
+#define PCI_VDEVICE_SUB(vend, dev, subvend, subdev) \
+	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
+	.subvendor = (subvend), .subdevice = (subdev), 0, 0
+
 /**
  * PCI_DEVICE_DATA - macro used to describe a specific PCI device in very short form
  * @vend: the vendor name (without PCI_VENDOR_ID_ prefix)
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index b79a1a20d0d9..5aa46e97903c 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -95,7 +95,9 @@ extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);
 
+int devm_pm_runtime_set_active_enabled(struct device *dev);
 extern int devm_pm_runtime_enable(struct device *dev);
+int devm_pm_runtime_get_noresume(struct device *dev);
 
 /**
  * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
@@ -292,7 +294,9 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline int devm_pm_runtime_set_active_enabled(struct device *dev) { return 0; }
 static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+static inline int devm_pm_runtime_get_noresume(struct device *dev) { return 0; }
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
diff --git a/include/linux/timer.h b/include/linux/timer.h
index e338e173ce8b..9162f275819a 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -184,6 +184,8 @@ extern void add_timer(struct timer_list *timer);
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
 extern int timer_delete(struct timer_list *timer);
+extern int timer_shutdown_sync(struct timer_list *timer);
+extern int timer_shutdown(struct timer_list *timer);
 
 /**
  * del_timer_sync - Delete a pending timer and wait for a running callback
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 705b76f8dddb..2cae3af9742d 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -15,6 +15,7 @@
 #ifndef __LINUX_USB_GADGET_H
 #define __LINUX_USB_GADGET_H
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -31,6 +32,7 @@ struct usb_ep;
 
 /**
  * struct usb_request - describes one i/o request
+ * @ep: The associated endpoint set by usb_ep_alloc_request().
  * @buf: Buffer used for data.  Always provide this; some controllers
  *	only use PIO, or don't use DMA for some endpoints.
  * @dma: DMA address corresponding to 'buf'.  If you don't set this
@@ -96,6 +98,7 @@ struct usb_ep;
  */
 
 struct usb_request {
+	struct usb_ep		*ep;
 	void			*buf;
 	unsigned		length;
 	dma_addr_t		dma;
@@ -288,6 +291,28 @@ static inline void usb_ep_fifo_flush(struct usb_ep *ep)
 
 /*-------------------------------------------------------------------------*/
 
+/**
+ * free_usb_request - frees a usb_request object and its buffer
+ * @req: the request being freed
+ *
+ * This helper function frees both the request's buffer and the request object
+ * itself by calling usb_ep_free_request(). Its signature is designed to be used
+ * with DEFINE_FREE() to enable automatic, scope-based cleanup for usb_request
+ * pointers.
+ */
+static inline void free_usb_request(struct usb_request *req)
+{
+	if (!req)
+		return;
+
+	kfree(req->buf);
+	usb_ep_free_request(req->ep, req);
+}
+
+DEFINE_FREE(free_usb_request, struct usb_request *, free_usb_request(_T))
+
+/*-------------------------------------------------------------------------*/
+
 struct usb_dcd_config_params {
 	__u8  bU1devExitLat;	/* U1 Device exit Latency */
 #define USB_DEFAULT_U1_DEV_EXIT_LAT	0x01	/* Less then 1 microsec */
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 84751313b826..e93db837412b 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -481,6 +481,21 @@ struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
 int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
 			  int headroom, bool reply);
 
+static inline void ip_tunnel_adj_headroom(struct net_device *dev,
+					  unsigned int headroom)
+{
+	/* we must cap headroom to some upperlimit, else pskb_expand_head
+	 * will overflow header offsets in skb_headers_offset_update().
+	 */
+	const unsigned int max_allowed = 512;
+
+	if (headroom > max_allowed)
+		headroom = max_allowed;
+
+	if (headroom > READ_ONCE(dev->needed_headroom))
+		WRITE_ONCE(dev->needed_headroom, headroom);
+}
+
 int iptunnel_handle_offloads(struct sk_buff *skb, int gso_type_mask);
 
 static inline int iptunnel_pull_offloads(struct sk_buff *skb)
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 9f0883e9ab3e..e341ea2fc979 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -564,10 +564,10 @@ TRACE_EVENT(f2fs_file_write_iter,
 );
 
 TRACE_EVENT(f2fs_map_blocks,
-	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map,
-				int create, int flag, int ret),
+	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int flag,
+		 int ret),
 
-	TP_ARGS(inode, map, create, flag, ret),
+	TP_ARGS(inode, map, flag, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -579,7 +579,6 @@ TRACE_EVENT(f2fs_map_blocks,
 		__field(int,	m_seg_type)
 		__field(bool,	m_may_create)
 		__field(bool,	m_multidev_dio)
-		__field(int,	create)
 		__field(int,	flag)
 		__field(int,	ret)
 	),
@@ -594,7 +593,6 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->m_seg_type	= map->m_seg_type;
 		__entry->m_may_create	= map->m_may_create;
 		__entry->m_multidev_dio	= map->m_multidev_dio;
-		__entry->create		= create;
 		__entry->flag		= flag;
 		__entry->ret		= ret;
 	),
@@ -602,7 +600,7 @@ TRACE_EVENT(f2fs_map_blocks,
 	TP_printk("dev = (%d,%d), ino = %lu, file offset = %llu, "
 		"start blkaddr = 0x%llx, len = 0x%llx, flags = %u, "
 		"seg_type = %d, may_create = %d, multidevice = %d, "
-		"create = %d, flag = %d, err = %d",
+		"flag = %d, err = %d",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->m_lblk,
 		(unsigned long long)__entry->m_pblk,
@@ -611,7 +609,6 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->m_seg_type,
 		__entry->m_may_create,
 		__entry->m_multidev_dio,
-		__entry->create,
 		__entry->flag,
 		__entry->ret)
 );
diff --git a/io_uring/filetable.c b/io_uring/filetable.c
index a64b4df0ac9c..f9e59c650e89 100644
--- a/io_uring/filetable.c
+++ b/io_uring/filetable.c
@@ -62,7 +62,7 @@ void io_free_file_tables(struct io_file_table *table)
 
 static int io_install_fixed_file(struct io_ring_ctx *ctx, struct file *file,
 				 u32 slot_index)
-	__must_hold(&req->ctx->uring_lock)
+	__must_hold(&ctx->uring_lock)
 {
 	bool needs_switch = false;
 	struct io_fixed_file *file_slot;
diff --git a/kernel/padata.c b/kernel/padata.c
index b3f79f23060c..d49f97abe086 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -282,7 +282,11 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
 	if (remove_object) {
 		list_del_init(&padata->list);
 		++pd->processed;
-		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
+		/* When sequence wraps around, reset to the first CPU. */
+		if (unlikely(pd->processed == 0))
+			pd->cpu = cpumask_first(pd->cpumask.pcpu);
+		else
+			pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
 	}
 
 	spin_unlock(&reorder->lock);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2deb896883d3..b6795bf15211 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4261,7 +4261,7 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 	return cfs_rq->avg.load_avg;
 }
 
-static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
+static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf);
 
 static inline unsigned long task_util(struct task_struct *p)
 {
@@ -4590,7 +4590,7 @@ attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void
 detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 
-static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
+static inline int sched_balance_newidle(struct rq *rq, struct rq_flags *rf)
 {
 	return 0;
 }
@@ -7575,7 +7575,7 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (rq->nr_running)
 		return 1;
 
-	return newidle_balance(rq, rf) != 0;
+	return sched_balance_newidle(rq, rf) != 0;
 }
 #endif /* CONFIG_SMP */
 
@@ -7908,21 +7908,21 @@ done: __maybe_unused;
 	return p;
 
 idle:
-	if (!rf)
-		return NULL;
-
-	new_tasks = newidle_balance(rq, rf);
+	if (rf) {
+		new_tasks = sched_balance_newidle(rq, rf);
 
-	/*
-	 * Because newidle_balance() releases (and re-acquires) rq->lock, it is
-	 * possible for any higher priority task to appear. In that case we
-	 * must re-start the pick_next_entity() loop.
-	 */
-	if (new_tasks < 0)
-		return RETRY_TASK;
+		/*
+		 * Because sched_balance_newidle() releases (and re-acquires)
+		 * rq->lock, it is possible for any higher priority task to
+		 * appear. In that case we must re-start the pick_next_entity()
+		 * loop.
+		 */
+		if (new_tasks < 0)
+			return RETRY_TASK;
 
-	if (new_tasks > 0)
-		goto again;
+		if (new_tasks > 0)
+			goto again;
+	}
 
 	/*
 	 * rq is about to be idle, check if we need to update the
@@ -10786,7 +10786,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	ld_moved = 0;
 
 	/*
-	 * newidle_balance() disregards balance intervals, so we could
+	 * sched_balance_newidle() disregards balance intervals, so we could
 	 * repeatedly reach this code, which would lead to balance_interval
 	 * skyrocketing in a short amount of time. Skip the balance_interval
 	 * increase logic to avoid that.
@@ -11548,7 +11548,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
- * newidle_balance is called by schedule() if this_cpu is about to become
+ * sched_balance_newidle is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  *
  * Returns:
@@ -11556,7 +11556,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  *     0 - failed, no new tasks
  *   > 0 - success, new (fair) tasks present
  */
-static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
+static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e09852be4e63..4f39025ac933 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1017,7 +1017,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	unsigned int idx = UINT_MAX;
 	int ret = 0;
 
-	BUG_ON(!timer->function);
+	debug_assert_init(timer);
 
 	/*
 	 * This is a common optimization triggered by the networking code - if
@@ -1044,6 +1044,14 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		 * dequeue/enqueue dance.
 		 */
 		base = lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function)
+			goto out_unlock;
+
 		forward_timer_base(base);
 
 		if (timer_pending(timer) && (options & MOD_TIMER_REDUCE) &&
@@ -1070,6 +1078,14 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		}
 	} else {
 		base = lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function)
+			goto out_unlock;
+
 		forward_timer_base(base);
 	}
 
@@ -1128,8 +1144,12 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
  * mod_timer_pending() is the same for pending timers as mod_timer(), but
  * will not activate inactive timers.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * Return:
- * * %0 - The timer was inactive and not modified
+ * * %0 - The timer was inactive and not modified or was in
+ *	  shutdown state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires
  */
 int mod_timer_pending(struct timer_list *timer, unsigned long expires)
@@ -1155,8 +1175,12 @@ EXPORT_SYMBOL(mod_timer_pending);
  * same timer, then mod_timer() is the only safe way to modify the timeout,
  * since add_timer() cannot modify an already running timer.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded. In this case the return value is 0 and meaningless.
+ *
  * Return:
- * * %0 - The timer was inactive and started
+ * * %0 - The timer was inactive and started or was in shutdown
+ *	  state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires or
  *	  the timer was active and not modified because @expires did
  *	  not change the effective expiry time
@@ -1176,8 +1200,12 @@ EXPORT_SYMBOL(mod_timer);
  * modify an enqueued timer if that would reduce the expiration time. If
  * @timer is not enqueued it starts the timer.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * Return:
- * * %0 - The timer was inactive and started
+ * * %0 - The timer was inactive and started or was in shutdown
+ *	  state and the operation was discarded
  * * %1 - The timer was active and requeued to expire at @expires or
  *	  the timer was active and not modified because @expires
  *	  did not change the effective expiry time such that the
@@ -1200,6 +1228,9 @@ EXPORT_SYMBOL(timer_reduce);
  * The @timer->expires and @timer->function fields must be set prior
  * to calling this function.
  *
+ * If @timer->function == NULL then the start operation is silently
+ * discarded.
+ *
  * If @timer->expires is already in the past @timer will be queued to
  * expire at the next timer tick.
  *
@@ -1208,7 +1239,8 @@ EXPORT_SYMBOL(timer_reduce);
  */
 void add_timer(struct timer_list *timer)
 {
-	BUG_ON(timer_pending(timer));
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
 	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
 }
 EXPORT_SYMBOL(add_timer);
@@ -1227,7 +1259,10 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	struct timer_base *new_base, *base;
 	unsigned long flags;
 
-	BUG_ON(timer_pending(timer) || !timer->function);
+	debug_assert_init(timer);
+
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
 
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
@@ -1237,6 +1272,13 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	 * wrong base locked.  See lock_timer_base().
 	 */
 	base = lock_timer_base(timer, &flags);
+	/*
+	 * Has @timer been shutdown? This needs to be evaluated while
+	 * holding base lock to prevent a race against the shutdown code.
+	 */
+	if (!timer->function)
+		goto out_unlock;
+
 	if (base != new_base) {
 		timer->flags |= TIMER_MIGRATING;
 
@@ -1250,25 +1292,27 @@ void add_timer_on(struct timer_list *timer, int cpu)
 
 	debug_timer_activate(timer);
 	internal_add_timer(base, timer);
+out_unlock:
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
 
 /**
- * timer_delete - Deactivate a timer
+ * __timer_delete - Internal function: Deactivate a timer
  * @timer:	The timer to be deactivated
+ * @shutdown:	If true, this indicates that the timer is about to be
+ *		shutdown permanently.
  *
- * The function only deactivates a pending timer, but contrary to
- * timer_delete_sync() it does not take into account whether the timer's
- * callback function is concurrently executed on a different CPU or not.
- * It neither prevents rearming of the timer. If @timer can be rearmed
- * concurrently then the return value of this function is meaningless.
+ * If @shutdown is true then @timer->function is set to NULL under the
+ * timer base lock which prevents further rearming of the time. In that
+ * case any attempt to rearm @timer after this function returns will be
+ * silently ignored.
  *
  * Return:
  * * %0 - The timer was not pending
  * * %1 - The timer was pending and deactivated
  */
-int timer_delete(struct timer_list *timer)
+static int __timer_delete(struct timer_list *timer, bool shutdown)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1276,33 +1320,90 @@ int timer_delete(struct timer_list *timer)
 
 	debug_assert_init(timer);
 
-	if (timer_pending(timer)) {
+	/*
+	 * If @shutdown is set then the lock has to be taken whether the
+	 * timer is pending or not to protect against a concurrent rearm
+	 * which might hit between the lockless pending check and the lock
+	 * aquisition. By taking the lock it is ensured that such a newly
+	 * enqueued timer is dequeued and cannot end up with
+	 * timer->function == NULL in the expiry code.
+	 *
+	 * If timer->function is currently executed, then this makes sure
+	 * that the callback cannot requeue the timer.
+	 */
+	if (timer_pending(timer) || shutdown) {
 		base = lock_timer_base(timer, &flags);
 		ret = detach_if_pending(timer, base, true);
+		if (shutdown)
+			timer->function = NULL;
 		raw_spin_unlock_irqrestore(&base->lock, flags);
 	}
 
 	return ret;
 }
+
+/**
+ * timer_delete - Deactivate a timer
+ * @timer:	The timer to be deactivated
+ *
+ * The function only deactivates a pending timer, but contrary to
+ * timer_delete_sync() it does not take into account whether the timer's
+ * callback function is concurrently executed on a different CPU or not.
+ * It neither prevents rearming of the timer.  If @timer can be rearmed
+ * concurrently then the return value of this function is meaningless.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending and deactivated
+ */
+int timer_delete(struct timer_list *timer)
+{
+	return __timer_delete(timer, false);
+}
 EXPORT_SYMBOL(timer_delete);
 
 /**
- * try_to_del_timer_sync - Try to deactivate a timer
+ * timer_shutdown - Deactivate a timer and prevent rearming
+ * @timer:	The timer to be deactivated
+ *
+ * The function does not wait for an eventually running timer callback on a
+ * different CPU but it prevents rearming of the timer. Any attempt to arm
+ * @timer after this function returns will be silently ignored.
+ *
+ * This function is useful for teardown code and should only be used when
+ * timer_shutdown_sync() cannot be invoked due to locking or context constraints.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending
+ */
+int timer_shutdown(struct timer_list *timer)
+{
+	return __timer_delete(timer, true);
+}
+EXPORT_SYMBOL_GPL(timer_shutdown);
+
+/**
+ * __try_to_del_timer_sync - Internal function: Try to deactivate a timer
  * @timer:	Timer to deactivate
+ * @shutdown:	If true, this indicates that the timer is about to be
+ *		shutdown permanently.
  *
- * This function tries to deactivate a timer. On success the timer is not
- * queued and the timer callback function is not running on any CPU.
+ * If @shutdown is true then @timer->function is set to NULL under the
+ * timer base lock which prevents further rearming of the timer. Any
+ * attempt to rearm @timer after this function returns will be silently
+ * ignored.
  *
- * This function does not guarantee that the timer cannot be rearmed right
- * after dropping the base lock. That needs to be prevented by the calling
- * code if necessary.
+ * This function cannot guarantee that the timer cannot be rearmed
+ * right after dropping the base lock if @shutdown is false. That
+ * needs to be prevented by the calling code if necessary.
  *
  * Return:
  * * %0  - The timer was not pending
  * * %1  - The timer was pending and deactivated
  * * %-1 - The timer callback function is running on a different CPU
  */
-int try_to_del_timer_sync(struct timer_list *timer)
+static int __try_to_del_timer_sync(struct timer_list *timer, bool shutdown)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1314,11 +1415,34 @@ int try_to_del_timer_sync(struct timer_list *timer)
 
 	if (base->running_timer != timer)
 		ret = detach_if_pending(timer, base, true);
+	if (shutdown)
+		timer->function = NULL;
 
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 
 	return ret;
 }
+
+/**
+ * try_to_del_timer_sync - Try to deactivate a timer
+ * @timer:	Timer to deactivate
+ *
+ * This function tries to deactivate a timer. On success the timer is not
+ * queued and the timer callback function is not running on any CPU.
+ *
+ * This function does not guarantee that the timer cannot be rearmed right
+ * after dropping the base lock. That needs to be prevented by the calling
+ * code if necessary.
+ *
+ * Return:
+ * * %0  - The timer was not pending
+ * * %1  - The timer was pending and deactivated
+ * * %-1 - The timer callback function is running on a different CPU
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
+{
+	return __try_to_del_timer_sync(timer, false);
+}
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
 #ifdef CONFIG_PREEMPT_RT
@@ -1395,45 +1519,28 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
 #endif
 
 /**
- * timer_delete_sync - Deactivate a timer and wait for the handler to finish.
+ * __timer_delete_sync - Internal function: Deactivate a timer and wait
+ *			 for the handler to finish.
  * @timer:	The timer to be deactivated
+ * @shutdown:	If true, @timer->function will be set to NULL under the
+ *		timer base lock which prevents rearming of @timer
  *
- * Synchronization rules: Callers must prevent restarting of the timer,
- * otherwise this function is meaningless. It must not be called from
- * interrupt contexts unless the timer is an irqsafe one. The caller must
- * not hold locks which would prevent completion of the timer's callback
- * function. The timer's handler must not call add_timer_on(). Upon exit
- * the timer is not queued and the handler is not running on any CPU.
- *
- * For !irqsafe timers, the caller must not hold locks that are held in
- * interrupt context. Even if the lock has nothing to do with the timer in
- * question.  Here's why::
+ * If @shutdown is not set the timer can be rearmed later. If the timer can
+ * be rearmed concurrently, i.e. after dropping the base lock then the
+ * return value is meaningless.
  *
- *    CPU0                             CPU1
- *    ----                             ----
- *                                     <SOFTIRQ>
- *                                       call_timer_fn();
- *                                       base->running_timer = mytimer;
- *    spin_lock_irq(somelock);
- *                                     <IRQ>
- *                                        spin_lock(somelock);
- *    timer_delete_sync(mytimer);
- *    while (base->running_timer == mytimer);
+ * If @shutdown is set then @timer->function is set to NULL under timer
+ * base lock which prevents rearming of the timer. Any attempt to rearm
+ * a shutdown timer is silently ignored.
  *
- * Now timer_delete_sync() will never return and never release somelock.
- * The interrupt on the other CPU is waiting to grab somelock but it has
- * interrupted the softirq that CPU0 is waiting to finish.
- *
- * This function cannot guarantee that the timer is not rearmed again by
- * some concurrent or preempting code, right after it dropped the base
- * lock. If there is the possibility of a concurrent rearm then the return
- * value of the function is meaningless.
+ * If the timer should be reused after shutdown it has to be initialized
+ * again.
  *
  * Return:
  * * %0	- The timer was not pending
  * * %1	- The timer was pending and deactivated
  */
-int timer_delete_sync(struct timer_list *timer)
+static int __timer_delete_sync(struct timer_list *timer, bool shutdown)
 {
 	int ret;
 
@@ -1463,7 +1570,7 @@ int timer_delete_sync(struct timer_list *timer)
 		lockdep_assert_preemption_enabled();
 
 	do {
-		ret = try_to_del_timer_sync(timer);
+		ret = __try_to_del_timer_sync(timer, shutdown);
 
 		if (unlikely(ret < 0)) {
 			del_timer_wait_running(timer);
@@ -1473,8 +1580,97 @@ int timer_delete_sync(struct timer_list *timer)
 
 	return ret;
 }
+
+/**
+ * timer_delete_sync - Deactivate a timer and wait for the handler to finish.
+ * @timer:	The timer to be deactivated
+ *
+ * Synchronization rules: Callers must prevent restarting of the timer,
+ * otherwise this function is meaningless. It must not be called from
+ * interrupt contexts unless the timer is an irqsafe one. The caller must
+ * not hold locks which would prevent completion of the timer's callback
+ * function. The timer's handler must not call add_timer_on(). Upon exit
+ * the timer is not queued and the handler is not running on any CPU.
+ *
+ * For !irqsafe timers, the caller must not hold locks that are held in
+ * interrupt context. Even if the lock has nothing to do with the timer in
+ * question.  Here's why::
+ *
+ *    CPU0                             CPU1
+ *    ----                             ----
+ *                                     <SOFTIRQ>
+ *                                       call_timer_fn();
+ *                                       base->running_timer = mytimer;
+ *    spin_lock_irq(somelock);
+ *                                     <IRQ>
+ *                                        spin_lock(somelock);
+ *    timer_delete_sync(mytimer);
+ *    while (base->running_timer == mytimer);
+ *
+ * Now timer_delete_sync() will never return and never release somelock.
+ * The interrupt on the other CPU is waiting to grab somelock but it has
+ * interrupted the softirq that CPU0 is waiting to finish.
+ *
+ * This function cannot guarantee that the timer is not rearmed again by
+ * some concurrent or preempting code, right after it dropped the base
+ * lock. If there is the possibility of a concurrent rearm then the return
+ * value of the function is meaningless.
+ *
+ * If such a guarantee is needed, e.g. for teardown situations then use
+ * timer_shutdown_sync() instead.
+ *
+ * Return:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
+ */
+int timer_delete_sync(struct timer_list *timer)
+{
+	return __timer_delete_sync(timer, false);
+}
 EXPORT_SYMBOL(timer_delete_sync);
 
+/**
+ * timer_shutdown_sync - Shutdown a timer and prevent rearming
+ * @timer: The timer to be shutdown
+ *
+ * When the function returns it is guaranteed that:
+ *   - @timer is not queued
+ *   - The callback function of @timer is not running
+ *   - @timer cannot be enqueued again. Any attempt to rearm
+ *     @timer is silently ignored.
+ *
+ * See timer_delete_sync() for synchronization rules.
+ *
+ * This function is useful for final teardown of an infrastructure where
+ * the timer is subject to a circular dependency problem.
+ *
+ * A common pattern for this is a timer and a workqueue where the timer can
+ * schedule work and work can arm the timer. On shutdown the workqueue must
+ * be destroyed and the timer must be prevented from rearming. Unless the
+ * code has conditionals like 'if (mything->in_shutdown)' to prevent that
+ * there is no way to get this correct with timer_delete_sync().
+ *
+ * timer_shutdown_sync() is solving the problem. The correct ordering of
+ * calls in this case is:
+ *
+ *	timer_shutdown_sync(&mything->timer);
+ *	workqueue_destroy(&mything->workqueue);
+ *
+ * After this 'mything' can be safely freed.
+ *
+ * This obviously implies that the timer is not required to be functional
+ * for the rest of the shutdown operation.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending
+ */
+int timer_shutdown_sync(struct timer_list *timer)
+{
+	return __timer_delete_sync(timer, true);
+}
+EXPORT_SYMBOL_GPL(timer_shutdown_sync);
+
 static void call_timer_fn(struct timer_list *timer,
 			  void (*fn)(struct timer_list *),
 			  unsigned long baseclk)
@@ -1539,6 +1735,12 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 
 		fn = timer->function;
 
+		if (WARN_ON_ONCE(!fn)) {
+			/* Should never happen. Emphasis on should! */
+			base->running_timer = NULL;
+			continue;
+		}
+
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
@@ -2047,8 +2249,6 @@ int timers_dead_cpu(unsigned int cpu)
 	struct timer_base *new_base;
 	int b, i;
 
-	BUG_ON(cpu_online(cpu));
-
 	for (b = 0; b < NR_BASES; b++) {
 		old_base = per_cpu_ptr(&timer_bases[b], cpu);
 		new_base = get_cpu_ptr(&timer_bases[b]);
@@ -2065,7 +2265,8 @@ int timers_dead_cpu(unsigned int cpu)
 		 */
 		forward_timer_base(new_base);
 
-		BUG_ON(old_base->running_timer);
+		WARN_ON_ONCE(old_base->running_timer);
+		old_base->running_timer = NULL;
 
 		for (i = 0; i < WHEEL_SIZE; i++)
 			migrate_timer_list(new_base, old_base->vectors + i);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6bc2f78a5ebb..6fd6c717d1e3 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4274,9 +4274,6 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err;
 	u16 vid;
 
-	if (!netlink_capable(skb, CAP_NET_ADMIN))
-		return -EPERM;
-
 	if (!del_bulk) {
 		err = nlmsg_parse_deprecated(nlh, sizeof(*ndm), tb, NDA_MAX,
 					     NULL, extack);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 90e55b9979e6..dcf9e9c52a22 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -567,20 +567,6 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
-static void ip_tunnel_adj_headroom(struct net_device *dev, unsigned int headroom)
-{
-	/* we must cap headroom to some upperlimit, else pskb_expand_head
-	 * will overflow header offsets in skb_headers_offset_update().
-	 */
-	static const unsigned int max_allowed = 512;
-
-	if (headroom > max_allowed)
-		headroom = max_allowed;
-
-	if (headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, headroom);
-}
-
 void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		       u8 proto, int tunnel_hlen)
 {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 40568365cdb3..a8d8e2f294ff 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2184,7 +2184,8 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 				 u32 max_segs)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	u32 send_win, cong_win, limit, in_flight;
+	u32 send_win, cong_win, limit, in_flight, threshold;
+	u64 srtt_in_ns, expected_ack, how_far_is_the_ack;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct sk_buff *head;
 	int win_divisor;
@@ -2246,9 +2247,19 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 	head = tcp_rtx_queue_head(sk);
 	if (!head)
 		goto send_now;
-	delta = tp->tcp_clock_cache - head->tstamp;
-	/* If next ACK is likely to come too late (half srtt), do not defer */
-	if ((s64)(delta - (u64)NSEC_PER_USEC * (tp->srtt_us >> 4)) < 0)
+
+	srtt_in_ns = (u64)(NSEC_PER_USEC >> 3) * tp->srtt_us;
+	/* When is the ACK expected ? */
+	expected_ack = head->tstamp + srtt_in_ns;
+	/* How far from now is the ACK expected ? */
+	how_far_is_the_ack = expected_ack - tp->tcp_clock_cache;
+
+	/* If next ACK is likely to come too late,
+	 * ie in more than min(1ms, half srtt), do not defer.
+	 */
+	threshold = min(srtt_in_ns >> 1, NSEC_PER_MSEC);
+
+	if ((s64)(how_far_is_the_ack - threshold) > 0)
 		goto send_now;
 
 	/* Ok, it looks like it is advisable to defer.
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 2a470c0c38ae..dfca22c6d345 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1256,8 +1256,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	 */
 	max_headroom = LL_RESERVED_SPACE(dst->dev) + sizeof(struct ipv6hdr)
 			+ dst->header_len + t->hlen;
-	if (max_headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, max_headroom);
+	ip_tunnel_adj_headroom(dev, max_headroom);
 
 	err = ip6_tnl_encap(skb, t, &proto, fl6);
 	if (err)
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
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 14d01558311d..4797f68b9ec8 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -208,12 +208,9 @@ int tls_process_cmsg(struct sock *sk, struct msghdr *msg,
 			if (msg->msg_flags & MSG_MORE)
 				return -EINVAL;
 
-			rc = tls_handle_open_record(sk, msg->msg_flags);
-			if (rc)
-				return rc;
-
 			*record_type = *(unsigned char *)CMSG_DATA(cmsg);
-			rc = 0;
+
+			rc = tls_handle_open_record(sk, msg->msg_flags);
 			break;
 		default:
 			return -EINVAL;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index fe6514e964ba..e7f151c98eb9 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1029,7 +1029,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			if (ret == -EINPROGRESS)
 				num_async++;
 			else if (ret != -EAGAIN)
-				goto send_end;
+				goto end;
 		}
 	}
 
@@ -1109,6 +1109,13 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 				} else if (ret != -EAGAIN)
 					goto send_end;
 			}
+
+			/* Transmit if any encryptions have completed */
+			if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
+				cancel_delayed_work(&ctx->tx_work.work);
+				tls_tx_records(sk, msg->msg_flags);
+			}
+
 			continue;
 rollback_iter:
 			copied -= try_to_copy;
@@ -1163,6 +1170,12 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 					goto send_end;
 				}
 			}
+
+			/* Transmit if any encryptions have completed */
+			if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
+				cancel_delayed_work(&ctx->tx_work.work);
+				tls_tx_records(sk, msg->msg_flags);
+			}
 		}
 
 		continue;
@@ -1182,9 +1195,10 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			goto alloc_encrypted;
 	}
 
+send_end:
 	if (!num_async) {
-		goto send_end;
-	} else if (num_zc) {
+		goto end;
+	} else if (num_zc || eor) {
 		int err;
 
 		/* Wait for pending encryptions to get completed */
@@ -1201,7 +1215,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		tls_tx_records(sk, msg->msg_flags);
 	}
 
-send_end:
+end:
 	ret = sk_stream_error(sk, msg->msg_flags, ret);
 
 	release_sock(sk);
@@ -1723,8 +1737,10 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 
 	if (unlikely(darg->async)) {
 		err = tls_strp_msg_hold(&ctx->strp, &ctx->async_hold);
-		if (err)
-			__skb_queue_tail(&ctx->async_hold, darg->skb);
+		if (err) {
+			err = tls_decrypt_async_wait(ctx);
+			darg->async = false;
+		}
 		return err;
 	}
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4184e8110f56..6de321a6e43c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -483,12 +483,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
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
@@ -508,20 +522,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
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
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index fdb4e11df3bd..2f5fd797955a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,8 +7,10 @@
  */
 
 #include <linux/slab.h>
+#include <linux/mm.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
 const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
+const vm_flags_t BINDINGS_VM_MERGEABLE = VM_MERGEABLE;
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 6c50ee62c56b..8cf84e899817 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -51,3 +51,4 @@ pub use bindings_raw::*;
 
 pub const GFP_KERNEL: gfp_t = BINDINGS_GFP_KERNEL;
 pub const __GFP_ZERO: gfp_t = BINDINGS___GFP_ZERO;
+pub const VM_MERGEABLE: vm_flags_t = BINDINGS_VM_MERGEABLE;
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 011d0f0c3941..dc70256ca220 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -32,7 +32,7 @@
  *	allows 5 times as large as IEC 61883-6 defines.
  * @CIP_HEADER_WITHOUT_EOH: Only for in-stream. CIP Header doesn't include
  *	valid EOH.
- * @CIP_NO_HEADERS: a lack of headers in packets
+ * @CIP_NO_HEADER: a lack of headers in packets
  * @CIP_UNALIGHED_DBC: Only for in-stream. The value of dbc is not alighed to
  *	the value of current SYT_INTERVAL; e.g. initial value is not zero.
  * @CIP_UNAWARE_SYT: For outgoing packet, the value in SYT field of CIP is 0xffff.
diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index efd92656a060..66309eede0db 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -26,7 +26,8 @@
 #include <sound/tlv.h>
 #include "nau8821.h"
 
-#define NAU8821_JD_ACTIVE_HIGH			BIT(0)
+#define NAU8821_QUIRK_JD_ACTIVE_HIGH			BIT(0)
+#define NAU8821_QUIRK_JD_DB_BYPASS			BIT(1)
 
 static int nau8821_quirk;
 static int quirk_override = -1;
@@ -902,12 +903,17 @@ static bool nau8821_is_jack_inserted(struct regmap *regmap)
 	return active_high == is_high;
 }
 
-static void nau8821_int_status_clear_all(struct regmap *regmap)
+static void nau8821_irq_status_clear(struct regmap *regmap, int active_irq)
 {
-	int active_irq, clear_irq, i;
+	int clear_irq, i;
 
-	/* Reset the intrruption status from rightmost bit if the corres-
-	 * ponding irq event occurs.
+	if (active_irq) {
+		regmap_write(regmap, NAU8821_R11_INT_CLR_KEY_STATUS, active_irq);
+		return;
+	}
+
+	/* Reset the interruption status from rightmost bit if the
+	 * corresponding irq event occurs.
 	 */
 	regmap_read(regmap, NAU8821_R10_IRQ_STATUS, &active_irq);
 	for (i = 0; i < NAU8821_REG_DATA_LEN; i++) {
@@ -934,7 +940,7 @@ static void nau8821_eject_jack(struct nau8821 *nau8821)
 	snd_soc_dapm_sync(dapm);
 
 	/* Clear all interruption status */
-	nau8821_int_status_clear_all(regmap);
+	nau8821_irq_status_clear(regmap, 0);
 
 	/* Enable the insertion interruption, disable the ejection inter-
 	 * ruption, and then bypass de-bounce circuit.
@@ -1038,9 +1044,10 @@ static void nau8821_setup_inserted_irq(struct nau8821 *nau8821)
 	regmap_update_bits(regmap, NAU8821_R1D_I2S_PCM_CTRL2,
 		NAU8821_I2S_MS_MASK, NAU8821_I2S_MS_SLAVE);
 
-	/* Not bypass de-bounce circuit */
-	regmap_update_bits(regmap, NAU8821_R0D_JACK_DET_CTRL,
-		NAU8821_JACK_DET_DB_BYPASS, 0);
+	/* Do not bypass de-bounce circuit */
+	if (!(nau8821_quirk & NAU8821_QUIRK_JD_DB_BYPASS))
+		regmap_update_bits(regmap, NAU8821_R0D_JACK_DET_CTRL,
+				   NAU8821_JACK_DET_DB_BYPASS, 0);
 
 	regmap_update_bits(regmap, NAU8821_R0F_INTERRUPT_MASK,
 		NAU8821_IRQ_EJECT_EN, 0);
@@ -1063,6 +1070,7 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 
 	if ((active_irq & NAU8821_JACK_EJECT_IRQ_MASK) ==
 		NAU8821_JACK_EJECT_DETECTED) {
+		cancel_work_sync(&nau8821->jdet_work);
 		regmap_update_bits(regmap, NAU8821_R71_ANALOG_ADC_1,
 			NAU8821_MICDET_MASK, NAU8821_MICDET_DIS);
 		nau8821_eject_jack(nau8821);
@@ -1077,11 +1085,11 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 		clear_irq = NAU8821_KEY_RELEASE_IRQ;
 	} else if ((active_irq & NAU8821_JACK_INSERT_IRQ_MASK) ==
 		NAU8821_JACK_INSERT_DETECTED) {
+		cancel_work_sync(&nau8821->jdet_work);
 		regmap_update_bits(regmap, NAU8821_R71_ANALOG_ADC_1,
 			NAU8821_MICDET_MASK, NAU8821_MICDET_EN);
 		if (nau8821_is_jack_inserted(regmap)) {
 			/* detect microphone and jack type */
-			cancel_work_sync(&nau8821->jdet_work);
 			schedule_work(&nau8821->jdet_work);
 			/* Turn off insertion interruption at manual mode */
 			regmap_update_bits(regmap,
@@ -1399,7 +1407,7 @@ static int nau8821_resume_setup(struct nau8821 *nau8821)
 	nau8821_configure_sysclk(nau8821, NAU8821_CLK_DIS, 0);
 	if (nau8821->irq) {
 		/* Clear all interruption status */
-		nau8821_int_status_clear_all(regmap);
+		nau8821_irq_status_clear(regmap, 0);
 
 		/* Enable both insertion and ejection interruptions, and then
 		 * bypass de-bounce circuit.
@@ -1712,7 +1720,23 @@ static const struct dmi_system_id nau8821_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
 			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P-V2"),
 		},
-		.driver_data = (void *)(NAU8821_JD_ACTIVE_HIGH),
+		.driver_data = (void *)(NAU8821_QUIRK_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Valve Steam Deck LCD */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
+		},
+		.driver_data = (void *)(NAU8821_QUIRK_JD_DB_BYPASS),
+	},
+	{
+		/* Valve Steam Deck OLED */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+		},
+		.driver_data = (void *)(NAU8821_QUIRK_JD_DB_BYPASS),
 	},
 	{}
 };
@@ -1754,9 +1778,12 @@ static int nau8821_i2c_probe(struct i2c_client *i2c)
 
 	nau8821_check_quirks();
 
-	if (nau8821_quirk & NAU8821_JD_ACTIVE_HIGH)
+	if (nau8821_quirk & NAU8821_QUIRK_JD_ACTIVE_HIGH)
 		nau8821->jkdet_polarity = 0;
 
+	if (nau8821_quirk & NAU8821_QUIRK_JD_DB_BYPASS)
+		dev_dbg(dev, "Force bypassing jack detection debounce circuit\n");
+
 	nau8821_print_device_properties(nau8821);
 
 	nau8821_reset_chip(nau8821->regmap);
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 5f539a1baef3..d7fe1c22a48b 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -753,10 +753,16 @@ get_alias_quirk(struct usb_device *dev, unsigned int id)
  */
 static int try_to_register_card(struct snd_usb_audio *chip, int ifnum)
 {
+	struct usb_interface *iface;
+
 	if (check_delayed_register_option(chip) == ifnum ||
-	    chip->last_iface == ifnum ||
-	    usb_interface_claimed(usb_ifnum_to_if(chip->dev, chip->last_iface)))
+	    chip->last_iface == ifnum)
+		return snd_card_register(chip->card);
+
+	iface = usb_ifnum_to_if(chip->dev, chip->last_iface);
+	if (iface && usb_interface_claimed(iface))
 		return snd_card_register(chip->card);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f8589e7c9383..d7dbbaa1f64a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3309,7 +3309,7 @@ endpoint_tests()
 	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
 	if reset "implicit EP" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -3330,7 +3330,7 @@ endpoint_tests()
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3
@@ -3457,7 +3457,7 @@ endpoint_tests()
 
 	# flush and re-add
 	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 2
 		# broadcast IP: no packet for this address will be received on ns1
diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index c65c55b7a789..312889edb84a 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -15,7 +15,6 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include "vm_util.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -71,16 +70,10 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
-	size_t hugepage_size;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;
 
-	hugepage_size = default_huge_page_size();
-	/* munmap with fail if the length is not page aligned */
-	if (hugepage_size > length)
-		length = hugepage_size;
-
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {

