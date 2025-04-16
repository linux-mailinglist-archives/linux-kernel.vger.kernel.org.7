Return-Path: <linux-kernel+bounces-607546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CD8A907B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 17:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEBA4479D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41D7211A10;
	Wed, 16 Apr 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGm+rdDG"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EB211489
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817225; cv=none; b=kMrQf5ZAIGvTbdvjhRSKiHn65ox93vYKD5YmWbgDH9kn7woC5VxSNaUkjU8lNViAnnUmm32kEeLLi+wk4uj/4pHb9y8jjDDTDcqRCfdcgIf2ubB4fh29w+7qqte9TT0VUUXbT1sjauxI6w8ZF2cF2b+ZZ2vrzp9UqbvDqsRCe6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817225; c=relaxed/simple;
	bh=ybG6Mz+ruCzz/7s7l63e7fUUrL5yxQEllagsjQ9Cf3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pq11VKTAys2uAJWUOQ7AlnybnQcfSaeceqAUETuvLINMODMhhrs9EVCX8IFY0dh2t5u5soDZxvlC2xAOYaePGClBEi50uYvf6orxyJm8sW6yzCsRysbLqDKXG5YMU43LDEN6V/CM/6sAwpKyliOL+NCw6hUv19CyncEZNwhaenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGm+rdDG; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5e636b06d34so7140294a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744817222; x=1745422022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+H4roSy0ETO2xvleEvsVdzxRkBxmddA29rKMSpiaoY8=;
        b=JGm+rdDGJDLnquYOsY01Qj7TrbLmuKnTrZnvSHWQnGaFZZTbvMh9zNDioK9vIrbPS3
         4AtMwrih0PEoAkwIIsGclGBvd1XpRHYLWl70YMZLoDGIv9BaLm6ssraqdvQzcdXe54hS
         60U8UN5XHLBr9bRqn/SqK6r326u8S4iVZJOSTnZVyzBgMcVoTNl8XkM6iDGMhzsqrzVx
         1X3WH47pdbj9tLNJ47AvlwxjwRfyhbHxtdsy7y7PW29Aj4ATqx+DRrWegfwmMZ8Men07
         b/EZEgwLpA2HXetkNDAgGJQNNPDQlbvDPVmgD9zHSWVV492SgJd4TAHOKi/ykd41tlWi
         3jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744817222; x=1745422022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+H4roSy0ETO2xvleEvsVdzxRkBxmddA29rKMSpiaoY8=;
        b=EB7tYVUcrUR5g7nNJoupqWXWurTiczdTY3zpaqce7EolQ36f/nNiz2JMaSXvyGX4Wn
         YzAgTlSIVbdz/27rh2V1YcZc9v+eHuItmCMo0WsGHtWbs1dQZkT1kdjAs46sPpYJWrKT
         UnfJQweiBxCBl+uBkpBtyUxLMhfDvO995rvvjP2ZDJSTdHv86SIMTelawngX4Q/za3RT
         bMu3ZfojCayGpqtLaJpaIjsOmv8AXjzL62CRQbNWKuk2how4mf0x5HHKlZJSqZSoWIzJ
         8Wt8DfYcbYRHEdOgg+6yJAtA/r5eNe+8bLSrls0uI1wv+v8H596A6BG8jfkZYUV377lZ
         pH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVt3gLk+ffHV+vxQLQvWs5EOP2NUquJLQb/9ydE/lqiUuRPFY/RLnkwVci22PV+OrV8YsrsK9xtRYjCFCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4iEDfPFNEGjb5zCx/wmYo+8PtYw0lCnhYE1XmI+Gpw925tSeN
	z+7oFDUNOdZYO6G72xeKpQYb8TwF7RovEX34+cDtIHoxFKHtxch0Mtk9fnQK7dClLJpIdqHdKqZ
	vv1fRbA==
X-Google-Smtp-Source: AGHT+IE3AJ5+KNd/wrKE6Yh8WQPTsdymaFnGvYhcC6y9WjjslUVSUYFVwO0K57lR6F2n9q3uVegAXV72ChYn
X-Received: from ediq14.prod.google.com ([2002:a50:cc8e:0:b0:5e5:cbc8:77b7])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3486:b0:5e8:c092:7a6
 with SMTP id 4fb4d7f45d1cf-5f4b75d848cmr2056666a12.21.1744817222246; Wed, 16
 Apr 2025 08:27:02 -0700 (PDT)
Date: Wed, 16 Apr 2025 15:26:45 +0000
In-Reply-To: <20250416152648.2982950-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416152648.2982950-1-qperret@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250416152648.2982950-6-qperret@google.com>
Subject: [PATCH v2 5/7] KVM: arm64: Move hyp state to hyp_vmemmap
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Fuad Tabba <tabba@google.com>, 
	Quentin Perret <qperret@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tracking the hypervisor's ownership state into struct hyp_page has
several benefits, including allowing far more efficient lookups (no
page-table walk needed) and de-corelating the state from the presence
of a mapping. This will later allow to map pages into EL2 stage-1 less
proactively which is generally a good thing for security. And in the
future this will help with tracking the state of pages mapped into the
hypervisor's private range without requiring an alias into the 'linear
map' range.

Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h | 29 +++++++++++---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 51 ++++++++++++------------
 arch/arm64/kvm/hyp/nvhe/setup.c          |  6 ++-
 3 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index a1754aecf8f8..eb0c2ebd1743 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -16,8 +16,7 @@
  *       accessible by another component;
  *   10: The page is accessible but not owned by the component;
  * The storage of this state depends on the component: either in the
- * hyp_vmemmap for the host state or in PTE software bits for the hypervisor
- * and guests.
+ * hyp_vmemmap for the host and hyp states or in PTE software bits for guests.
  */
 enum pkvm_page_state {
 	PKVM_PAGE_OWNED			= 0ULL,
@@ -25,13 +24,14 @@ enum pkvm_page_state {
 	PKVM_PAGE_SHARED_BORROWED	= BIT(1),
 
 	/*
-	 * 'Meta-states' are not stored directly in PTE SW bits for hyp and
-	 * guest states, but inferred from the context (e.g. invalid PTE
-	 * entries). For the host, meta-states are stored directly in the
+	 * 'Meta-states' are not stored directly in PTE SW bits for guest
+	 * states, but inferred from the context (e.g. invalid PTE entries).
+	 * For the host and hyp, meta-states are stored directly in the
 	 * struct hyp_page.
 	 */
 	PKVM_NOPAGE			= BIT(0) | BIT(1),
 };
+#define PKVM_PAGE_STATE_MASK		(BIT(0) | BIT(1))
 
 #define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
 static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
@@ -52,7 +52,14 @@ struct hyp_page {
 	u8 order;
 
 	/* Host state. Guarded by the host stage-2 lock. */
-	unsigned __host_state : 8;
+	unsigned __host_state : 4;
+
+	/*
+	 * Complement of the hyp state. Guarded by the hyp stage-1 lock. We use
+	 * the complement so that the initial 0 in __hyp_state_comp (due to the
+	 * entire vmemmap starting off zeroed) encodes PKVM_NOPAGE.
+	 */
+	unsigned __hyp_state_comp : 4;
 
 	u32 host_share_guest_count;
 };
@@ -99,6 +106,16 @@ static inline void set_host_state(phys_addr_t phys, enum pkvm_page_state state)
 	hyp_phys_to_page(phys)->__host_state = state;
 }
 
+static inline enum pkvm_page_state get_hyp_state(phys_addr_t phys)
+{
+	return hyp_phys_to_page(phys)->__hyp_state_comp ^ PKVM_PAGE_STATE_MASK;
+}
+
+static inline void set_hyp_state(phys_addr_t phys, enum pkvm_page_state state)
+{
+	hyp_phys_to_page(phys)->__hyp_state_comp = state ^ PKVM_PAGE_STATE_MASK;
+}
+
 /*
  * Refcounting for 'struct hyp_page'.
  * hyp_pool::lock must be held if atomic access to the refcount is required.
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index e9060e6205cb..25ff84c053c1 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -649,24 +649,24 @@ static int __host_set_page_state_range(u64 addr, u64 size,
 	return 0;
 }
 
-static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte, u64 addr)
+static void __hyp_set_page_state_range(phys_addr_t phys, u64 size, enum pkvm_page_state state)
 {
-	if (!kvm_pte_valid(pte))
-		return PKVM_NOPAGE;
+	phys_addr_t end = phys + size;
 
-	return pkvm_getstate(kvm_pgtable_hyp_pte_prot(pte));
+	for (; phys < end; phys += PAGE_SIZE)
+		set_hyp_state(phys, state);
 }
 
-static int __hyp_check_page_state_range(u64 addr, u64 size,
-					enum pkvm_page_state state)
+static int __hyp_check_page_state_range(phys_addr_t phys, u64 size, enum pkvm_page_state state)
 {
-	struct check_walk_data d = {
-		.desired	= state,
-		.get_page_state	= hyp_get_page_state,
-	};
+	phys_addr_t end = phys + size;
+
+	for (; phys < end; phys += PAGE_SIZE) {
+		if (get_hyp_state(phys) != state)
+			return -EPERM;
+	}
 
-	hyp_assert_lock_held(&pkvm_pgd_lock);
-	return check_page_state_range(&pkvm_pgtable, addr, size, &d);
+	return 0;
 }
 
 static enum pkvm_page_state guest_get_page_state(kvm_pte_t pte, u64 addr)
@@ -694,7 +694,6 @@ int __pkvm_host_share_hyp(u64 pfn)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
 	void *virt = __hyp_va(phys);
-	enum kvm_pgtable_prot prot;
 	u64 size = PAGE_SIZE;
 	int ret;
 
@@ -705,13 +704,13 @@ int __pkvm_host_share_hyp(u64 pfn)
 	if (ret)
 		goto unlock;
 	if (IS_ENABLED(CONFIG_NVHE_EL2_DEBUG)) {
-		ret = __hyp_check_page_state_range((u64)virt, size, PKVM_NOPAGE);
+		ret = __hyp_check_page_state_range(phys, size, PKVM_NOPAGE);
 		if (ret)
 			goto unlock;
 	}
 
-	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
-	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, prot));
+	__hyp_set_page_state_range(phys, size, PKVM_PAGE_SHARED_BORROWED);
+	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, PAGE_HYP));
 	WARN_ON(__host_set_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED));
 
 unlock:
@@ -734,7 +733,7 @@ int __pkvm_host_unshare_hyp(u64 pfn)
 	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED);
 	if (ret)
 		goto unlock;
-	ret = __hyp_check_page_state_range(virt, size, PKVM_PAGE_SHARED_BORROWED);
+	ret = __hyp_check_page_state_range(phys, size, PKVM_PAGE_SHARED_BORROWED);
 	if (ret)
 		goto unlock;
 	if (hyp_page_count((void *)virt)) {
@@ -742,6 +741,7 @@ int __pkvm_host_unshare_hyp(u64 pfn)
 		goto unlock;
 	}
 
+	__hyp_set_page_state_range(phys, size, PKVM_NOPAGE);
 	WARN_ON(kvm_pgtable_hyp_unmap(&pkvm_pgtable, virt, size) != size);
 	WARN_ON(__host_set_page_state_range(phys, size, PKVM_PAGE_OWNED));
 
@@ -757,7 +757,6 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 	u64 phys = hyp_pfn_to_phys(pfn);
 	u64 size = PAGE_SIZE * nr_pages;
 	void *virt = __hyp_va(phys);
-	enum kvm_pgtable_prot prot;
 	int ret;
 
 	host_lock_component();
@@ -767,13 +766,13 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 	if (ret)
 		goto unlock;
 	if (IS_ENABLED(CONFIG_NVHE_EL2_DEBUG)) {
-		ret = __hyp_check_page_state_range((u64)virt, size, PKVM_NOPAGE);
+		ret = __hyp_check_page_state_range(phys, size, PKVM_NOPAGE);
 		if (ret)
 			goto unlock;
 	}
 
-	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_OWNED);
-	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, prot));
+	__hyp_set_page_state_range(phys, size, PKVM_PAGE_OWNED);
+	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, PAGE_HYP));
 	WARN_ON(host_stage2_set_owner_locked(phys, size, PKVM_ID_HYP));
 
 unlock:
@@ -793,7 +792,7 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
 	host_lock_component();
 	hyp_lock_component();
 
-	ret = __hyp_check_page_state_range(virt, size, PKVM_PAGE_OWNED);
+	ret = __hyp_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
 	if (ret)
 		goto unlock;
 	if (IS_ENABLED(CONFIG_NVHE_EL2_DEBUG)) {
@@ -802,6 +801,7 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
 			goto unlock;
 	}
 
+	__hyp_set_page_state_range(phys, size, PKVM_NOPAGE);
 	WARN_ON(kvm_pgtable_hyp_unmap(&pkvm_pgtable, virt, size) != size);
 	WARN_ON(host_stage2_set_owner_locked(phys, size, PKVM_ID_HOST));
 
@@ -816,19 +816,18 @@ int hyp_pin_shared_mem(void *from, void *to)
 {
 	u64 cur, start = ALIGN_DOWN((u64)from, PAGE_SIZE);
 	u64 end = PAGE_ALIGN((u64)to);
+	u64 phys = __hyp_pa(start);
 	u64 size = end - start;
 	int ret;
 
 	host_lock_component();
 	hyp_lock_component();
 
-	ret = __host_check_page_state_range(__hyp_pa(start), size,
-					    PKVM_PAGE_SHARED_OWNED);
+	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED);
 	if (ret)
 		goto unlock;
 
-	ret = __hyp_check_page_state_range(start, size,
-					   PKVM_PAGE_SHARED_BORROWED);
+	ret = __hyp_check_page_state_range(phys, size, PKVM_PAGE_SHARED_BORROWED);
 	if (ret)
 		goto unlock;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 1a414288fe8c..955c431af5d0 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -194,16 +194,20 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
 
 	/*
 	 * Adjust the host stage-2 mappings to match the ownership attributes
-	 * configured in the hypervisor stage-1.
+	 * configured in the hypervisor stage-1, and make sure to propagate them
+	 * to the hyp_vmemmap state.
 	 */
 	state = pkvm_getstate(kvm_pgtable_hyp_pte_prot(ctx->old));
 	switch (state) {
 	case PKVM_PAGE_OWNED:
+		set_hyp_state(phys, PKVM_PAGE_OWNED);
 		return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
 	case PKVM_PAGE_SHARED_OWNED:
+		set_hyp_state(phys, PKVM_PAGE_SHARED_OWNED);
 		set_host_state(phys, PKVM_PAGE_SHARED_BORROWED);
 		break;
 	case PKVM_PAGE_SHARED_BORROWED:
+		set_hyp_state(phys, PKVM_PAGE_SHARED_BORROWED);
 		set_host_state(phys, PKVM_PAGE_SHARED_OWNED);
 		break;
 	default:
-- 
2.49.0.604.gff1f9ca942-goog


