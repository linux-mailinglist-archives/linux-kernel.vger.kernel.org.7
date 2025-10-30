Return-Path: <linux-kernel+bounces-879050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC9C2223C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD651888B47
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0687E37DBD9;
	Thu, 30 Oct 2025 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5UwO06f"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D661375744
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855009; cv=none; b=kkxHdYS5M3sA2Xkt2z76XJ6lQawHbVUtN7rMQBRfml0yot/vqVnL6kwsr4PzvJ8rN3Aj6RRHWDcUJmJWLU/QDTjLyazMTH89xqT6ubacfoXVgvCxft0v9JeK6zPD/Af0RD0lsUfXoDQnS9msYBlx7GeZZCdseDYNjMg4+zXwtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855009; c=relaxed/simple;
	bh=MUDH20eIOuOTsz0KS9uuqL90AQHBBTqkmMlPBeDR0dg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T//l0+40z6HovReWtdOH5YU2w1NekZU6V7l25VdocAAvpMMZV3S/Eb/Av8lP+ICdMHCndY8hPzuRPzHMGcq4TXC/3q4yrZ9SvzUWpI+GxYTRfc0QaAFKYHCg9LcxcIIG3vFlLBNHUAHBAX3n39zxP2bGmsXNMONPlm4mID/SL/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5UwO06f; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b63038a6350so1675643a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761855007; x=1762459807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TnV5Uo4WEDSyHqNRydChmPWwv04NNnacTlgMSv81cvQ=;
        b=T5UwO06f5YYUjTOoIBnQeZqZF3MXwA1xsiU1nObbLP4/tgmhojQYA0acKw+ROJdLk9
         /nhe7veeJ9PR6/EvlxZ/mL4TOA/L5gZn2S0eczabNl9X2qMRy0wrgO17HvSvr3Cnmvoe
         Ebc3mpQ1/R4HhJ6Zhp2PBi/Bd3WEzUf1WjQ3zT3PF0qlQ6BlaQNN4B85rknkW0/4a65U
         TTQwXCjGC76CGEUdnqoTejpjoQ9+G3P1mTGkf9++df2k+gUwVdj4UiZX9JuhsIO7wCRo
         czlCTLXHHsmRVXv6UnoyWtnqqCcU8z0eJERJy4epx5L577EKtT42wHUbSYvVKx0YiY6Z
         NSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855007; x=1762459807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnV5Uo4WEDSyHqNRydChmPWwv04NNnacTlgMSv81cvQ=;
        b=ubj0WVzUNeFvJ3353Qxjn/YoZsihylAhyPu0Y3nuHfHo3AllkOWBPWnugtvajwfnqW
         WdxT2AK1DlOscI1x+OC6bVzmjaNqJSRGfo3uIre8FJrJT2I3j/7pg1+MqpWo1tPK2vFi
         YHPBB4K9vNa2biTc6spA9oTynjdVUpQ5iTBMS/d1Hburfb2bAQnWOtSA7kUYPK90HibV
         hQ43kE4hfu/bef7rOl3vHAt+KWodbu2MOgg9AauIS6QlZB9XFsda6EYFQQ1EntWg8fOF
         06lSni+FWBc/pfw/0MlM6AYAB+MMGeAL3B2j7MS95+mVPJvzy2EMJ0SeOLsrw9hVtuoC
         3qwg==
X-Forwarded-Encrypted: i=1; AJvYcCXgIA0i0H7MkibF0ox7pPuxWAUKTA4ELkhidy6oqmHQW6XORgfssBKMhDn+obY3gFGJKAR+sZb6ZpBs6bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAOg+FbCuRd5m80fORxXdgNAcMN+ksk7gBiyyq6nvBiCw3m5o1
	oSofbZ5g4GDg+Kpa3EvLbHsWOvQNGXtftMj4tl1Rt0WgK1E3plfvnO3y5BRoFKFwVcqUyLOoBl8
	GpD3P9w==
X-Google-Smtp-Source: AGHT+IFGhHo2Di0bU/Eld4A49PARSXoqPeeyu/ySpV1D9gJIOdjNn1G+WqeVqdSQrN5R+YSZ+ehbNpIGVJQ=
X-Received: from plow8.prod.google.com ([2002:a17:903:1b08:b0:267:cd3d:3446])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54c:b0:295:134:9ae5
 with SMTP id d9443c01a7336-29519b9f27cmr11657375ad.24.1761855006488; Thu, 30
 Oct 2025 13:10:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 13:09:26 -0700
In-Reply-To: <20251030200951.3402865-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030200951.3402865-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030200951.3402865-4-seanjc@google.com>
Subject: [PATCH v4 03/28] KVM: TDX: Drop PROVE_MMU=y sanity check on
 to-be-populated mappings
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

Drop TDX's sanity check that a mirror EPT mapping isn't zapped between
creating said mapping and doing TDH.MEM.PAGE.ADD, as the check is
simultaneously superfluous and incomplete.  Per commit 2608f1057601
("KVM: x86/tdp_mmu: Add a helper function to walk down the TDP MMU"), the
justification for introducing kvm_tdp_mmu_gpa_is_mapped() was to check
that the target gfn was pre-populated, with a link that points to this
snippet:

 : > One small question:
 : >
 : > What if the memory region passed to KVM_TDX_INIT_MEM_REGION hasn't been pre-
 : > populated?  If we want to make KVM_TDX_INIT_MEM_REGION work with these regions,
 : > then we still need to do the real map.  Or we can make KVM_TDX_INIT_MEM_REGION
 : > return error when it finds the region hasn't been pre-populated?
 :
 : Return an error.  I don't love the idea of bleeding so many TDX details into
 : userspace, but I'm pretty sure that ship sailed a long, long time ago.

But that justification makes little sense for the final code, as the check
on nr_premapped after TDH.MEM.PAGE.ADD will detect and return an error if
KVM attempted to zap a S-EPT entry (tdx_sept_zap_private_spte() will fail
on TDH.MEM.RANGE.BLOCK due lack of a valid S-EPT entry).  And as evidenced
by the "is mapped?" code being guarded with CONFIG_KVM_PROVE_MMU=y, KVM is
NOT relying on the check for general correctness.

The sanity check is also incomplete in the sense that mmu_lock is dropped
between the check and TDH.MEM.PAGE.ADD, i.e. will only detect KVM bugs that
zap SPTEs in a very specific window (note, this also applies to the check
on nr_premapped).

Removing the sanity check will allow removing kvm_tdp_mmu_gpa_is_mapped(),
which has no business being exposed to vendor code, and more importantly
will pave the way for eliminating the "pre-map" approach entirely in favor
of doing TDH.MEM.PAGE.ADD under mmu_lock.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 326db9b9c567..4c3014befe9f 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3181,20 +3181,6 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	if (ret < 0)
 		goto out;
 
-	/*
-	 * The private mem cannot be zapped after kvm_tdp_map_page()
-	 * because all paths are covered by slots_lock and the
-	 * filemap invalidate lock.  Check that they are indeed enough.
-	 */
-	if (IS_ENABLED(CONFIG_KVM_PROVE_MMU)) {
-		scoped_guard(read_lock, &kvm->mmu_lock) {
-			if (KVM_BUG_ON(!kvm_tdp_mmu_gpa_is_mapped(vcpu, gpa), kvm)) {
-				ret = -EIO;
-				goto out;
-			}
-		}
-	}
-
 	ret = 0;
 	err = tdh_mem_page_add(&kvm_tdx->td, gpa, pfn_to_page(pfn),
 			       src_page, &entry, &level_state);
-- 
2.51.1.930.gacf6e81ea2-goog


