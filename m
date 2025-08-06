Return-Path: <linux-kernel+bounces-758264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA220B1CD07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671027AF01F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C732DCF6E;
	Wed,  6 Aug 2025 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSXJIUU6"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EBF2DBF47
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510312; cv=none; b=nuzUZVmo3GO480JjIAmpSQAbUImnjFE3EgXXREj8u0+BcEoQ6/MTS4TjlXXLHXJ4SHHJFivk0dgbuULxH3AeKjxZ+Z2WUNvgcMpQm0X23xIAk7c+YHmd6uIzYP1X1bN1wyTtL6TMDXPU6m+xAExOKwliS5DUpg19LUFvOAAZ7Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510312; c=relaxed/simple;
	bh=bLdrcgmYm6mqxmhXKdA5ykWfWtLQ9xTXCUeboAWobh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L47k+GZ+AkYtTaL33Dgc1/Zsdc8cZFR00UcLRHUQbJ7bPyh3VQaCm/uMCo2e8MckZ2mjJ+heSMbjK7vH5bTMCpAyMk5j80aTbyldLoaEgsIFZk9SNUDjxC6l6opcyLYySkdd/mv3p5ZwSW/F/tI/BwnGcl/6qDKZUbl8M9y64C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSXJIUU6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23fe28867b7so2375515ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510309; x=1755115109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=h+R0RK6o+FBkoODCsg4/sPruy7k1VkLsFBuytBNeaEE=;
        b=iSXJIUU6wdXDWE+TME9js/BZQbuHpAdlhA44UPPJ47gUH4lbOdS6vM2+6qDFAdQybE
         rbCpHs76ChOdhN6Ppd2d/JwAoVR08Eblv1MFP/7zcCJjQnEh22ngC+act2j8dyiO+hWI
         HKnzBwDicXtq+0NjnSee5M8vOwjYBzD6J7uMdQBTZRCzWhtnnCJ8AP0T7pO18F2w90bK
         BpwTyNaxEwIBOgOfq/EekyceNG0TMKmcroIucWUVN+XJ0hwLOjKuqXfWnspVBTMcZUOm
         xGf20/CPTp7f6hW06bV3OQgaM4JtIcnvE8mXEP58YQmi/gXxp6E8NiHbyt7R5hkpXg+U
         i7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510309; x=1755115109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+R0RK6o+FBkoODCsg4/sPruy7k1VkLsFBuytBNeaEE=;
        b=ewKRAFJ6VZe2qtlF6my2cayLd9WO6OQnRSL3hp8j64zWAPjUy/fzK15n3K5O/QLZ1k
         aRcNCgdB+NzHeyPYkWrNEf0qT6encB1mWJfdt06iPbKdAEXZyNLRsfT42Xbqbl9aOtwV
         ph2r2dov1rSd9E9SFz08+xluF0qUYWGwYk5WhwCnEtR/MUbZx2dJArV0XY5HRzcsVHgt
         SWOsMgLE5jldgeP++FhQY/li2EH4eOWvbsRZ7b3uJUY4I9i3dPTyNgaUG42a0KnWBwuP
         cCgM6ncdZMLPIUEo3DnRJwSL27oBMZANkgHzr7dXFp1f/WgvZu5RPaxbzmTKH0oFqjsT
         6uPA==
X-Forwarded-Encrypted: i=1; AJvYcCX351E4PSgWpS9hf3+DcoiM62nhVjNPCdAHbVFeI0CqnW7ZM53ovno1S51MjAi98U5Ja8EbTC1JXtrgx4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8viuCR9k/LH9Jl8U8HOdWXr3Y4uA3VEi8R3EH/wVAzrzbP3a
	ZbuqMcpzD27YT3wjlxi80yvvdnU+l+kEqSoIDrTZWNyoQacvyuK8VakTR2P4kVMttB4KYcOrKnc
	SnYfuAw==
X-Google-Smtp-Source: AGHT+IEfUJQHCKm2Ka63Vh1rz9TId3URvafpVHxlHcjND/kCO75vRaPMhhxSn7fVXTy0Nxb/+lRjTxRhOaU=
X-Received: from pgbcz12.prod.google.com ([2002:a05:6a02:230c:b0:b42:1518:df18])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d510:b0:240:763d:e9a6
 with SMTP id d9443c01a7336-242a0ae9d65mr50650645ad.25.1754510308841; Wed, 06
 Aug 2025 12:58:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:55 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-34-seanjc@google.com>
Subject: [PATCH v5 33/44] KVM: x86/pmu: Bypass perf checks when emulating
 mediated PMU counter accesses
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

When emulating a PMC counter read or write for a mediated PMU, bypass the
perf checks and emulated_counter logic as the counters aren't proxied
through perf, i.e. pmc->counter always holds the guest's up-to-date value,
and thus there's no need to defer emulated overflow checks.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: split from event filtering change, write shortlog+changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 5 +++++
 arch/x86/kvm/pmu.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 817ef852bdf9..082d2905882b 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -377,6 +377,11 @@ static void pmc_update_sample_period(struct kvm_pmc *pmc)
 
 void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
 {
+	if (kvm_vcpu_has_mediated_pmu(pmc->vcpu)) {
+		pmc->counter = val & pmc_bitmask(pmc);
+		return;
+	}
+
 	/*
 	 * Drop any unconsumed accumulated counts, the WRMSR is a write, not a
 	 * read-modify-write.  Adjust the counter value so that its value is
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 51963a3a167a..1c9d26d60a60 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -111,6 +111,9 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 {
 	u64 counter, enabled, running;
 
+	if (kvm_vcpu_has_mediated_pmu(pmc->vcpu))
+		return pmc->counter & pmc_bitmask(pmc);
+
 	counter = pmc->counter + pmc->emulated_counter;
 
 	if (pmc->perf_event && !pmc->is_paused)
-- 
2.50.1.565.gc32cd1483b-goog


