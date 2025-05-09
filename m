Return-Path: <linux-kernel+bounces-641709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E26F4AB14F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 15:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E770188CAE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E34B296146;
	Fri,  9 May 2025 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfoW4GBR"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E245295DAA
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796654; cv=none; b=BSxhAFPRNsCfJabMIFlBTrg4w/0WLIAhVZ1Kcg/Qeg2IEIacyl8JUtD5MfF9N3Cw8C0ZDy2fkAkGpzNUAsLxwHHVxsRgAf/a963iRlBob2IoPL38bqi6jJEupSaccDhS5/yxUHt1mUR4PR9K/QRyZ7vixOR2B3fOXU4KH8w1a8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796654; c=relaxed/simple;
	bh=l/bL8Cdy19zVzYeeeRC3Bhazuunjmk5hRum5pM/tfQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C9cAdMJQcs//L2JYy5v07WGeC45Fu/zrb/XYiqrOnfM0wOhTY6LvzMxxJkjfwifHDOgZRyNp/pWD/inNJEpt+lbyzx/Gbhxoc/9V3l3zY4jBtp+I50EclYPwkVnADjhtGy0Lb8kQOjx4hQFbAWw1Svw8/atxgIN1yfR0cjbnNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XfoW4GBR; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so14052055e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746796650; x=1747401450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Nkys3MADPIj5Es68fiIJTGNjZ/cE1BlJNsvbA6coAk=;
        b=XfoW4GBRv8s6+2SmJoxHLE24o+/GCCRXVIBJW1W2v1QBbJ/fVtsfSR9q1j6jG7Nt0j
         eqGAA3e/59wszQSnnAXgZ02K3wa01B9wKyo6mKfQiotd+0J/nveJbldu1Zg+e64j/Ge3
         x+BiTN36lyKp53IFkRPXq8Y+e4CUB0S1+lzG9NWN0hlvcrqzT366llG8YJJW1kJfdGAj
         95Mg4pjbMAZzVDRavVdIyV79H13Kvk7fR1zwpwhQx29Obesrpqpfj25FWsyEH3vT6J1a
         0HCwp68VF9/rbh2bpqZ7//q3Vf4kKe6pDslsPRxodalKR65uytXPIvpnUVT8GOeT+u2O
         2v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746796650; x=1747401450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Nkys3MADPIj5Es68fiIJTGNjZ/cE1BlJNsvbA6coAk=;
        b=djiEwEBHpQqGtgnXJFK9CgNm5vcfVr4Sy1+7Qh1PgeVSve0AGrmSuXWWzig8PxpoeE
         BZl+SFfkAZ3c6LdxZDphrr4DpCixSBN974DNaPvlpcvkovqPtXnQk2tY0EwBr8P0bHWz
         bQmlUMDC87PngqV3eMbMkeliYXqb0FLC7tWFinNHBCrGkM14Ob0gxs5uaFZh7cg0FH9U
         Y61Qr8Cbv76U5MuqMqwPWWm1PrkCHrn8M0YJwM+cOEID7el57RkRzntFHVOCwhIF0WLo
         EuDG+OgOzu/u00w61loV8Lg7FNfeNiCSeCWdQ6xDI/eGxQBBxiOfr9RPEvnCgc1kLqd/
         OVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgVBIqrcNO9VfU0NCNsq4ovS0D6y5UPgdm8yzcDdipwtnky5qogh77myIEmPGqFhdh/WYKR8EWw+S3cvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwFzyc1Ku4aJ/WrocExWiKF6E/MkiNjtJnYIfLy98xCCzFy19
	7ni/AseA62n+mMXC2ww/du+T/UaFGsAaKS28ZBTo5qFRYEszsCC8crKsq69VhfUip7MC6GqmJB+
	wdTHZWmldQVzHwKeB3g==
X-Google-Smtp-Source: AGHT+IHJ6Ug2lZ+EwcnN/sajdCCAyKS2oET8piVm/uCVqDq6/j9BnOqfKPaK7OSzRMQ+TH//37e8HgXM+UiJR6KC
X-Received: from wmbji3.prod.google.com ([2002:a05:600c:a343:b0:43c:eba5:f9b3])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b0e:b0:43c:f6b0:e807 with SMTP id 5b1f17b1804b1-442d6ddea12mr29578065e9.31.1746796649880;
 Fri, 09 May 2025 06:17:29 -0700 (PDT)
Date: Fri,  9 May 2025 14:17:06 +0100
In-Reply-To: <20250509131706.2336138-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250509131706.2336138-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250509131706.2336138-11-vdonnefort@google.com>
Subject: [PATCH v4 10/10] KVM: arm64: np-guest CMOs with PMD_SIZE fixmap
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

With the introduction of stage-2 huge mappings in the pKVM hypervisor,
guest pages CMO is needed for PMD_SIZE size. Fixmap only supports
PAGE_SIZE and iterating over the huge-page is time consuming (mostly due
to TLBI on hyp_fixmap_unmap) which is a problem for EL2 latency.

Introduce a shared PMD_SIZE fixmap (hyp_fixblock_map/hyp_fixblock_unmap)
to improve guest page CMOs when stage-2 huge mappings are installed.

On a Pixel6, the iterative solution resulted in a latency of ~700us,
while the PMD_SIZE fixmap reduces it to ~100us.

Because of the horrendous private range allocation that would be
necessary, this is disabled for 64KiB pages systems.

Suggested-by: Quentin Perret <qperret@google.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 1b43bcd2a679..2888b5d03757 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -59,6 +59,11 @@ typedef u64 kvm_pte_t;
 
 #define KVM_PHYS_INVALID		(-1ULL)
 
+#define KVM_PTE_TYPE			BIT(1)
+#define KVM_PTE_TYPE_BLOCK		0
+#define KVM_PTE_TYPE_PAGE		1
+#define KVM_PTE_TYPE_TABLE		1
+
 #define KVM_PTE_LEAF_ATTR_LO		GENMASK(11, 2)
 
 #define KVM_PTE_LEAF_ATTR_LO_S1_ATTRIDX	GENMASK(4, 2)
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 230e4f2527de..b0c72bc2d5ba 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -13,9 +13,11 @@
 extern struct kvm_pgtable pkvm_pgtable;
 extern hyp_spinlock_t pkvm_pgd_lock;
 
-int hyp_create_pcpu_fixmap(void);
+int hyp_create_fixmap(void);
 void *hyp_fixmap_map(phys_addr_t phys);
 void hyp_fixmap_unmap(void);
+void *hyp_fixblock_map(phys_addr_t phys);
+void hyp_fixblock_unmap(void);
 
 int hyp_create_idmap(u32 hyp_va_bits);
 int hyp_map_vectors(void);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 97e0fea9db4e..9f3ffa4e0690 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -220,16 +220,52 @@ static void guest_s2_put_page(void *addr)
 	hyp_put_page(&current_vm->pool, addr);
 }
 
+static void *__fixmap_guest_page(void *va, size_t *size)
+{
+	if (IS_ALIGNED(*size, PMD_SIZE)) {
+		void *addr = hyp_fixblock_map(__hyp_pa(va));
+
+		if (addr)
+			return addr;
+
+		*size = PAGE_SIZE;
+	}
+
+	if (IS_ALIGNED(*size, PAGE_SIZE))
+		return hyp_fixmap_map(__hyp_pa(va));
+
+	WARN_ON(1);
+
+	return NULL;
+}
+
+static void __fixunmap_guest_page(size_t size)
+{
+	switch (size) {
+	case PAGE_SIZE:
+		hyp_fixmap_unmap();
+		break;
+	case PMD_SIZE:
+		hyp_fixblock_unmap();
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
 static void clean_dcache_guest_page(void *va, size_t size)
 {
 	WARN_ON(!PAGE_ALIGNED(size));
 
 	while (size) {
-		__clean_dcache_guest_page(hyp_fixmap_map(__hyp_pa(va)),
-					  PAGE_SIZE);
-		hyp_fixmap_unmap();
-		va += PAGE_SIZE;
-		size -= PAGE_SIZE;
+		size_t fixmap_size = size == PMD_SIZE ? size : PAGE_SIZE;
+		void *addr = __fixmap_guest_page(va, &fixmap_size);
+
+		__clean_dcache_guest_page(addr, fixmap_size);
+		__fixunmap_guest_page(fixmap_size);
+
+		size -= fixmap_size;
+		va += fixmap_size;
 	}
 }
 
@@ -238,11 +274,14 @@ static void invalidate_icache_guest_page(void *va, size_t size)
 	WARN_ON(!PAGE_ALIGNED(size));
 
 	while (size) {
-		__invalidate_icache_guest_page(hyp_fixmap_map(__hyp_pa(va)),
-					       PAGE_SIZE);
-		hyp_fixmap_unmap();
-		va += PAGE_SIZE;
-		size -= PAGE_SIZE;
+		size_t fixmap_size = size == PMD_SIZE ? size : PAGE_SIZE;
+		void *addr = __fixmap_guest_page(va, &fixmap_size);
+
+		__invalidate_icache_guest_page(addr, fixmap_size);
+		__fixunmap_guest_page(fixmap_size);
+
+		size -= fixmap_size;
+		va += fixmap_size;
 	}
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index f41c7440b34b..e3b1bece8504 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -229,9 +229,8 @@ int hyp_map_vectors(void)
 	return 0;
 }
 
-void *hyp_fixmap_map(phys_addr_t phys)
+static void *fixmap_map_slot(struct hyp_fixmap_slot *slot, phys_addr_t phys)
 {
-	struct hyp_fixmap_slot *slot = this_cpu_ptr(&fixmap_slots);
 	kvm_pte_t pte, *ptep = slot->ptep;
 
 	pte = *ptep;
@@ -243,10 +242,21 @@ void *hyp_fixmap_map(phys_addr_t phys)
 	return (void *)slot->addr;
 }
 
+void *hyp_fixmap_map(phys_addr_t phys)
+{
+	return fixmap_map_slot(this_cpu_ptr(&fixmap_slots), phys);
+}
+
 static void fixmap_clear_slot(struct hyp_fixmap_slot *slot)
 {
 	kvm_pte_t *ptep = slot->ptep;
 	u64 addr = slot->addr;
+	u32 level;
+
+	if (FIELD_GET(KVM_PTE_TYPE, *ptep) == KVM_PTE_TYPE_PAGE)
+		level = KVM_PGTABLE_LAST_LEVEL;
+	else
+		level = KVM_PGTABLE_LAST_LEVEL - 1; /* create_fixblock() guarantees PMD level */
 
 	WRITE_ONCE(*ptep, *ptep & ~KVM_PTE_VALID);
 
@@ -260,7 +270,7 @@ static void fixmap_clear_slot(struct hyp_fixmap_slot *slot)
 	 * https://lore.kernel.org/kvm/20221017115209.2099-1-will@kernel.org/T/#mf10dfbaf1eaef9274c581b81c53758918c1d0f03
 	 */
 	dsb(ishst);
-	__tlbi_level(vale2is, __TLBI_VADDR(addr, 0), KVM_PGTABLE_LAST_LEVEL);
+	__tlbi_level(vale2is, __TLBI_VADDR(addr, 0), level);
 	dsb(ish);
 	isb();
 }
@@ -273,9 +283,9 @@ void hyp_fixmap_unmap(void)
 static int __create_fixmap_slot_cb(const struct kvm_pgtable_visit_ctx *ctx,
 				   enum kvm_pgtable_walk_flags visit)
 {
-	struct hyp_fixmap_slot *slot = per_cpu_ptr(&fixmap_slots, (u64)ctx->arg);
+	struct hyp_fixmap_slot *slot = (struct hyp_fixmap_slot *)ctx->arg;
 
-	if (!kvm_pte_valid(ctx->old) || ctx->level != KVM_PGTABLE_LAST_LEVEL)
+	if (!kvm_pte_valid(ctx->old) || (ctx->end - ctx->start) != kvm_granule_size(ctx->level))
 		return -EINVAL;
 
 	slot->addr = ctx->addr;
@@ -296,13 +306,73 @@ static int create_fixmap_slot(u64 addr, u64 cpu)
 	struct kvm_pgtable_walker walker = {
 		.cb	= __create_fixmap_slot_cb,
 		.flags	= KVM_PGTABLE_WALK_LEAF,
-		.arg = (void *)cpu,
+		.arg = (void *)per_cpu_ptr(&fixmap_slots, cpu),
 	};
 
 	return kvm_pgtable_walk(&pkvm_pgtable, addr, PAGE_SIZE, &walker);
 }
 
-int hyp_create_pcpu_fixmap(void)
+#ifndef CONFIG_ARM64_64K_PAGES
+static struct hyp_fixmap_slot hyp_fixblock_slot;
+static DEFINE_HYP_SPINLOCK(hyp_fixblock_lock);
+
+void *hyp_fixblock_map(phys_addr_t phys)
+{
+	hyp_spin_lock(&hyp_fixblock_lock);
+	return fixmap_map_slot(&hyp_fixblock_slot, phys);
+}
+
+void hyp_fixblock_unmap(void)
+{
+	fixmap_clear_slot(&hyp_fixblock_slot);
+	hyp_spin_unlock(&hyp_fixblock_lock);
+}
+
+static int create_fixblock(void)
+{
+	struct kvm_pgtable_walker walker = {
+		.cb	= __create_fixmap_slot_cb,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.arg = (void *)&hyp_fixblock_slot,
+	};
+	unsigned long addr;
+	phys_addr_t phys;
+	int ret, i;
+
+	/* Find a RAM phys address, PMD aligned */
+	for (i = 0; i < hyp_memblock_nr; i++) {
+		phys = ALIGN(hyp_memory[i].base, PMD_SIZE);
+		if (phys + PMD_SIZE < (hyp_memory[i].base + hyp_memory[i].size))
+			break;
+	}
+
+	if (i >= hyp_memblock_nr)
+		return -EINVAL;
+
+	hyp_spin_lock(&pkvm_pgd_lock);
+	addr = ALIGN(__io_map_base, PMD_SIZE);
+	ret = __pkvm_alloc_private_va_range(addr, PMD_SIZE);
+	if (ret)
+		goto unlock;
+
+	ret = kvm_pgtable_hyp_map(&pkvm_pgtable, addr, PMD_SIZE, phys, PAGE_HYP);
+	if (ret)
+		goto unlock;
+
+	ret = kvm_pgtable_walk(&pkvm_pgtable, addr, PMD_SIZE, &walker);
+
+unlock:
+	hyp_spin_unlock(&pkvm_pgd_lock);
+
+	return ret;
+}
+#else
+void hyp_fixblock_unmap(void) { WARN_ON(1); }
+void *hyp_fixblock_map(phys_addr_t phys) { return NULL; }
+static int create_fixblock(void) { return 0; }
+#endif
+
+int hyp_create_fixmap(void)
 {
 	unsigned long addr, i;
 	int ret;
@@ -322,7 +392,7 @@ int hyp_create_pcpu_fixmap(void)
 			return ret;
 	}
 
-	return 0;
+	return create_fixblock();
 }
 
 int hyp_create_idmap(u32 hyp_va_bits)
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index c19860fc8183..a48d3f5a5afb 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -312,7 +312,7 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
-	ret = hyp_create_pcpu_fixmap();
+	ret = hyp_create_fixmap();
 	if (ret)
 		goto out;
 
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index df5cc74a7dd0..c351b4abd5db 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -11,12 +11,6 @@
 #include <asm/kvm_pgtable.h>
 #include <asm/stage2_pgtable.h>
 
-
-#define KVM_PTE_TYPE			BIT(1)
-#define KVM_PTE_TYPE_BLOCK		0
-#define KVM_PTE_TYPE_PAGE		1
-#define KVM_PTE_TYPE_TABLE		1
-
 struct kvm_pgtable_walk_data {
 	struct kvm_pgtable_walker	*walker;
 
-- 
2.49.0.1015.ga840276032-goog


