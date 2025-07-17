Return-Path: <linux-kernel+bounces-736084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD837B0989F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9008173D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899F25A353;
	Thu, 17 Jul 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQApwqHb"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABB424BBEB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796080; cv=none; b=EhR4QNJQPzP3qf9/9BpSPUXiLlcfCMo5s8yyc3NotzTb4FJkdN3qoduT+ApLLgVhbEZzLgsuQMJo0GwN4LvL9IXe80gffqs9hZfsY+ALCFkk26tYNOXnGr/BCUITX+6I7WML6nlAbTm8UFRDUfz9otdfecPbKVoBuISI0DumEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796080; c=relaxed/simple;
	bh=4Lm6rMZZKj9i8zZ/NnoVMfxriOkG8OOdGzwZV10mDmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pAJD9O5dbcXA1/+HR66FVQDGd7r5nUXSt33s9EZnHIUalJ3e/0Ye57/OZB/V5OaE4WW14kVrQmXubwg022oS9IKI8VF8eC+FMMzfgmc2xpAPcUfuI/IeV6Mv0/UrVDDwhNArWlJVzl5N8jJabiebeSfPLJsqUJmRyagVxAbjps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQApwqHb; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so996208f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752796077; x=1753400877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i36b1JU3bh8bkcjM27fcG1Vv3a5VEOWwHxSUo3VGonw=;
        b=HQApwqHb7AimiOpZoYWcuhZ6JoYNLHZXd8SC/9/756W37O3eSzavwtome/FhMNlWCD
         iCs1yQQS3RaAn3FeoYL8WWgiEJNT7ru9bbKuDxkvJVFjIMmtF7MRfdmnwF2RXJyXJIFH
         +VM87p51U8ExC+Z0U+lCaOaHNqQroTPdU156hoOBn5Aemp9hjFFqIsYE4PY/KFH4k659
         PcR5p8BNR+WQHlrcbSsMLMZFTlb5AnbcEYnVWZwMCXYICc9ANuzM7g+Gg71+O/ioanAK
         li3euIz7knSnWw0NAFMwoIGru+EeLjrUowfHNZm9vfCCQJdp/C8iqqmmfvh5jlZ+8lt5
         liDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752796077; x=1753400877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i36b1JU3bh8bkcjM27fcG1Vv3a5VEOWwHxSUo3VGonw=;
        b=UQkUneaW079z1rZHhpPH+BH4AdheQqLOb5DRo4qRXO/3WkWnKzPr6jm4Irl1RH17VP
         DBd552/pzjBzOPBk8YeNlFjMLYLiOiGi7yPzXVGu4i9g+sortIDC1HTcBKm/OmfvmTts
         7YCRAKkdZqZ0sjpmz4qu2XOANWqjwZoDFfORlYrUMz4je8n0dXiBG6Vm0GBcWPjVrY2o
         sIviRuAVJBHxaXIPMxq6A+Fbd5jzGKB9RUSTXOoIQiXMY4g3P86ToLpufG/9tQLAN+Qf
         PNbCYN8IdNAVpbL9T1o38xv92jkM5SrzNfxYI3bbqtmUE/+fLGwtZjjPOgw35WmdLNn/
         1ssg==
X-Forwarded-Encrypted: i=1; AJvYcCXWjg+HlwnLACxJz0jTrVWRu4DlTvako3kZ94Mrb73bQ6z6dajFielFx1js2lq/STioVnOLmubMu823n+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYQHbFCtRzxcZlVtg08SjuOWBQklQAWryqtVluEsTlJRzilb7
	o9oKy502qY2A315kj/vcTFBiJs704XXtA1HB+Z2vGuprQQWX3PZBc2Ca6bJBBZlwvIrrG8kYPtj
	MEyimCWM7TY6roQ==
X-Google-Smtp-Source: AGHT+IHKyMuHhag8ZOByJFmk1Ifp+SWFFmJZZLFql4fjdBJ3bTCSJXcxMK4YsTuE1B/9R5Fp15TBOEDcXOc6wQ==
X-Received: from wmbdz10.prod.google.com ([2002:a05:600c:670a:b0:450:cf3f:2a89])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d10:0:b0:3a5:5270:c38f with SMTP id ffacd0b85a97d-3b60dd0db62mr8326635f8f.0.1752796076663;
 Thu, 17 Jul 2025 16:47:56 -0700 (PDT)
Date: Thu, 17 Jul 2025 23:47:44 +0000
In-Reply-To: <20250717234744.2254371-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717234744.2254371-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717234744.2254371-3-smostafa@google.com>
Subject: [PATCH 2/2] KVM: arm64: Map hyp text as RO and dump instr on panic
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, qperret@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Map the hyp text section as RO, there are no secrets there
and that allows the kernel extract info for debugging.

As in case of panic we can now dump the faulting instructions
similar to the kernel.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/handle_exit.c    |  4 +---
 arch/arm64/kvm/hyp/nvhe/setup.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index de12b4d4bccd..d59f33c40767 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -566,9 +566,7 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 	kvm_nvhe_dump_backtrace(hyp_offset);
 
 	/* Dump the faulting instruction */
-	if (!is_protected_kvm_enabled() ||
-	    IS_ENABLED(CONFIG_NVHE_EL2_DEBUG))
-		dump_instr(panic_addr + kaslr_offset());
+	dump_instr(panic_addr + kaslr_offset());
 
 	/*
 	 * Hyp has panicked and we're going to handle that by panicking the
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index a48d3f5a5afb..90bd014e952f 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -192,6 +192,7 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	enum pkvm_page_state state;
 	struct hyp_page *page;
 	phys_addr_t phys;
+	enum kvm_pgtable_prot prot;
 
 	if (!kvm_pte_valid(ctx->old))
 		return 0;
@@ -210,11 +211,18 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	 * configured in the hypervisor stage-1, and make sure to propagate them
 	 * to the hyp_vmemmap state.
 	 */
-	state = pkvm_getstate(kvm_pgtable_hyp_pte_prot(ctx->old));
+	prot = kvm_pgtable_hyp_pte_prot(ctx->old);
+	state = pkvm_getstate(prot);
 	switch (state) {
 	case PKVM_PAGE_OWNED:
 		set_hyp_state(page, PKVM_PAGE_OWNED);
-		return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
+		/* hyp text is RO in the host stage-2 to be inspected on panic. */
+		if (prot == PAGE_HYP_EXEC) {
+			set_host_state(page, PKVM_NOPAGE);
+			return host_stage2_idmap_locked(phys, PAGE_SIZE, KVM_PGTABLE_PROT_R);
+		} else {
+			return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
+		}
 	case PKVM_PAGE_SHARED_OWNED:
 		set_hyp_state(page, PKVM_PAGE_SHARED_OWNED);
 		set_host_state(page, PKVM_PAGE_SHARED_BORROWED);
-- 
2.50.0.727.gbf7dc18ff4-goog


