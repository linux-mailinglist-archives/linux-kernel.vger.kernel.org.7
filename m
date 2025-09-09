Return-Path: <linux-kernel+bounces-808288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B15EB4FD90
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FFA188C40B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7147635083D;
	Tue,  9 Sep 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i57x5a7t"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545B346A16
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425007; cv=none; b=HPr+RvLXRxx3ji4PK0FS5rkoTjCLvd6zKE9enO2GA6yqTxA31CQpj3xYzCZQOSaLK7TOZLov212KcSJvl1ihB8x7KTG3yumSdcr+/c7UaN9SlvrmyWXOSLCY/3c8vP2JHEm5wZnW0wk8vJi7LRI84ohk+xSY+ZhBTwcJuQqBhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425007; c=relaxed/simple;
	bh=s+LTaxCdkbtafjfpxFbMtUJbb49yFD25c+tR5bvUCJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BNvvMibPBUszPPkRlsJ5m3G4+DFDplens6SbMQ0amVKz5/APiHFh6Io0O3cWZAPuPO6RFWXnazhjzlfOxSHEs730YMIeTZ9r1p13Xjx1N6XJ/m/pTpfVTviSPkdn8QEIK/wd3r92gRaKdC7FZfaRVHKf1P7Wk8TOJrTHEHcB5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i57x5a7t; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3dbf3054ac4so3356677f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757425003; x=1758029803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=owMpJomD9HktZXrYn67PIBgyXHZh+dj149j6UZF5idE=;
        b=i57x5a7tRH8EwS40r1o4mnh/vyIZmffNkDQzkdFAnDod76OCKotGOfK0fft/bv/it9
         VPhGkGGJlzGGMUjAO/aqrpzMDp12J4QFQa8aSHgTI5QfIArMBDrgwdu1qrmjVIHpzdLh
         w6uIK5IPdh3uuk6mxoTiVjhtPP95iHHabZ8qQgAT+Zct3XFK2vY23fQmTFv1mYeQf2PZ
         kStjb6aUg7CvYkWyLKkWcGvwDjTiYevtZOJSOfx40j27ruXAk2Aws1/8FzXtOUhNydWS
         fVI0an9dNbw6VMzrCFpGOtA1b2J2zfPKsVyKMFDKY7ObG7EhJeEeGmzsQMZIpbuzxvyn
         eQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425003; x=1758029803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owMpJomD9HktZXrYn67PIBgyXHZh+dj149j6UZF5idE=;
        b=Tqa1kNFhfWAJCbj+qA3B9txv2s481aX4HSYYmyaIxq1U4mlH+FDmSDcG/lJEU6rww6
         QKYaMkDKxWK+Lb8m8mv4ucz5d0mw58NN1paYehc22fxpQ8zEZM4h6pgqkRVW7UrXhb15
         nQzgcCcAURbhfwU/4d7Oas+CsAQuerrqf65gpwN5BBQ7axCAjROEXLO+oezfznr6sm7u
         2Y7CbRzJdwkzEzX7vFsFgCcwNxYO3qZlraRpisMCvDMIY3/+4BNv9HyF2Xf/LxYoGZ4U
         EhkxRs59mGl6h2G46YM8Dn4V8L1pMQFD97UyI+dG8tV7pYA5PyYRubL9x5AotbhOGNGO
         xrEA==
X-Forwarded-Encrypted: i=1; AJvYcCWYh0ixqxp4NGUdwX7IhmGUoi22OwGTleDAabfl/VbPS5JLHUgV8N/NMDdHm0V5ch5bVkxcezixSPWFFHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwGgSEzYq58qIwo8tKV9iqpYOELdG9N3pjtYS2U3MP8UbomqQF
	86tgdb/6NZUS4WB0f4DnsHX/EJUxdaI0YnAdWFlICfqUihvwfhaWiImJH6LRnNVtjE8mhQJtK8L
	A9HcfKKMnb7GIfg==
X-Google-Smtp-Source: AGHT+IFb5uZ+yXEAm2ul5d4u0zb6FcIArGntIYWXEsNgKuqjWpTpJjl0OgQdZTnmi211wUNW182dBv2tNknMLA==
X-Received: from wrbfq12.prod.google.com ([2002:a05:6000:2a0c:b0:3db:2c3c:8268])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64c9:0:b0:3c9:b8b7:ea4e with SMTP id ffacd0b85a97d-3e637370e00mr9580515f8f.19.1757425003090;
 Tue, 09 Sep 2025 06:36:43 -0700 (PDT)
Date: Tue,  9 Sep 2025 13:36:31 +0000
In-Reply-To: <20250909133631.3844423-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909133631.3844423-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909133631.3844423-3-smostafa@google.com>
Subject: [PATCH v2 2/2] KVM: arm64: Map hyp text as RO and dump instr on panic
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, perret@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Map the hyp text section as RO, there are no secrets there
and that allows the kernel extract info for debugging.

As in case of panic we can now dump the faulting instructions
similar to the kernel.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/handle_exit.c    |  4 +---
 arch/arm64/kvm/hyp/nvhe/setup.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 99a8205fc104..d449e15680e4 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -560,9 +560,7 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 	kvm_nvhe_dump_backtrace(hyp_offset);
 
 	/* Dump the faulting instruction */
-	if (!is_protected_kvm_enabled() ||
-	    IS_ENABLED(CONFIG_NVHE_EL2_DEBUG))
-		dump_kernel_instr(panic_addr + kaslr_offset());
+	dump_kernel_instr(panic_addr + kaslr_offset());
 
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
2.51.0.384.g4c02a37b29-goog


