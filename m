Return-Path: <linux-kernel+bounces-879055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD8C222C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E00401534
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F61380858;
	Thu, 30 Oct 2025 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ge1T9AB7"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988137FC59
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855018; cv=none; b=Yr2uPLqLFyErt+7EoW9sbj7J93MMIc5boNfsiXDZegGid8x7MYsTViUgGMPyjmMqXRqzdPHLvCUXi9YzN0QZ52JZmKAI7U68gtckLX10glaJeEnFGKVuZPZFa61GOPT1AZYXl+3tLxe1Se3ft1AapZmKlyb5Kej8bEPUf2jUw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855018; c=relaxed/simple;
	bh=e3/F56xOZTqFFfm6ytjXqIzmHI1q3N3bM68KHJZJdHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=akcqLQAXmSln6lXAwtUCNjs8d1kYR7Mkfg+i7pNvA5FK06Sw57jAFHFC+WTpL1PL+3aa1TVbz4Js+K1+5ufB0UYHnWGu8//h+B0kXxj9u+QdqgTcAPWCfxJieP2ySZpQPW9jqdevpetaPZgIZzb3VJj44ikQEc7JXA9s8CryjJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ge1T9AB7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-294f59039d6so12297765ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761855016; x=1762459816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JLmVjM6Rep3/JgP/0z+P5jqrWiynYk4juTN/f68hSuo=;
        b=ge1T9AB7xA3SQDdm/6wLAolvNdiTwy7ib17w/sEC2oIr3W2lS++MAAU6ZG29Or/H3j
         zPAuYszQcGT3tWe9fOGESCwdFAxpyGMucqgv3WM7olE9IV7NQvAUqtVElC4iAaxw31HM
         Mf9DpChuKpuTXOB5k2DHJRrYz8ah4wXD+cCf6lAKBs3PsLhULOmAfaZ7rgqQ30dsH0uD
         JPEOOhqxF+Evmd7FDbx7aOucnpi1ZobunvZv/wS7FtEaEnMAbTQ0GTVs2IFtjWpLwHA1
         vasSRtA+Cszxhl356hVE88pbgqSIzEZtFoRkuYxiGuzJx0vLmjcKc3Iy9WQ+TKTk4nnz
         3Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855016; x=1762459816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLmVjM6Rep3/JgP/0z+P5jqrWiynYk4juTN/f68hSuo=;
        b=IDGG4FvetRVZS5Pnz7fkd06WF1s5CbkzHNontFnk+MhFI96VOAWTolGDRTdDaD0SE0
         HRUp+pvgPu3QQhVfyOJ+sDzwdrrJR0sQCiRXFTRQK+1MR1Pjqu94DdqaotfwkzJW0Nda
         zH96d44oJyWMY7tr1rfuinNFQZrMXIYn5XgKyOSIQ8hIo19royM3Xm5FataGMn0Lp+uy
         qSLJfkcZrzz5nzoZW+yn2w9kZgro26+Du0j5RmMqM69w2PZ0N3bVrm5/d3jvQEbeDHYE
         o6SnNCnAxcatiU5cazb7+n5SC4BefyUZOsH7m82ODQm6qCQZoJAL+jBFuWJReRIFC6Lh
         AnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpcgc0NWI0R1VWSDefQvY8SfDGQGBrX7MBD+OX+kY8efWd7qcOsWXuyzi7VQB6pt3Y5tE1bCj+hN4P+C8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6ZIH2nEF+urxiYL993TQqrcV/3ONwomX6rlGa+C9HqCCoeTb
	gv4ez+dumwpoACqu740wqZEK2orLq5Jt5BKJH/oPPm4ybUgzFP83H8tqiA17Fj2JorGc5TBZMYe
	1kPZc9w==
X-Google-Smtp-Source: AGHT+IH1/xZVzpdLpqTCV5R9sgqM94QaK+KvWTLge6Sarj+nuvNBhb5+D5DYqWRmVcfvrQhQkF7/dm0shPg=
X-Received: from plnx8.prod.google.com ([2002:a17:902:8208:b0:290:bd15:24ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88e:b0:28e:7fd3:57f2
 with SMTP id d9443c01a7336-2951a491f2dmr14399305ad.49.1761855016072; Thu, 30
 Oct 2025 13:10:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 13:09:30 -0700
In-Reply-To: <20251030200951.3402865-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030200951.3402865-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030200951.3402865-8-seanjc@google.com>
Subject: [PATCH v4 07/28] KVM: x86/mmu: Rename kvm_tdp_map_page() to kvm_tdp_page_prefault()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename kvm_tdp_map_page() to kvm_tdp_page_prefault() now that it's used
only by kvm_arch_vcpu_pre_fault_memory().

No functional change intended.

Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3a5104e4127a..10e579f8fa8e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4924,8 +4924,8 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	return direct_page_fault(vcpu, fault);
 }
 
-static int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code,
-			    u8 *level)
+static int kvm_tdp_page_prefault(struct kvm_vcpu *vcpu, gpa_t gpa,
+				 u64 error_code, u8 *level)
 {
 	int r;
 
@@ -5002,7 +5002,7 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 	 * Shadow paging uses GVA for kvm page fault, so restrict to
 	 * two-dimensional paging.
 	 */
-	r = kvm_tdp_map_page(vcpu, range->gpa | direct_bits, error_code, &level);
+	r = kvm_tdp_page_prefault(vcpu, range->gpa | direct_bits, error_code, &level);
 	if (r < 0)
 		return r;
 
-- 
2.51.1.930.gacf6e81ea2-goog


