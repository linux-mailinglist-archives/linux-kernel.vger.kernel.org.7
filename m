Return-Path: <linux-kernel+bounces-874831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC46C172EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BA81AA1DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4217C2E11A6;
	Tue, 28 Oct 2025 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HrlHnl8w"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1F12DE6E3
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690193; cv=none; b=Atq2EFTDlBHVOyEO33dQqlTNAeAhC1TEMnc+qRjDKzoYJfW2HZ+LUlSnmcQvCLu69RKFn9YtR31RTfRYbQ1xi2Mv3DLmnaXVc2Fud3k89178rGb4y7vYE3L46p+lnfaTt7/n1ThKiLdO9xx87ib2wdRPM2DFEHLEWPjrHygz5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690193; c=relaxed/simple;
	bh=L7K9HnqH2KFb1xTVC1XCnk3NZKxonWlqyMM1iA1YmCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BANlDZBd8pQ6FBw9FVk0YCa5wNf1LnBsN2Cu1l+GLxbjfkxTKCEAhV2ryQ7vnou7WvtF8S0UPkADtk4h8h22Z3bwSTpasbpUfY8WKWNk8ahmIbPJvkibSoXTlQcTPQ2PG3VvErZT0wKtUH7vy4vqYCSHWieTR68Gy3F0PIz3v/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HrlHnl8w; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Oct 2025 22:23:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761690189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8qPfg69aH85hJK/2NIrynP1wda3Qv85XlTue8Hsfnw=;
	b=HrlHnl8wcOt30G4U6CIKp2eObmki4ed/Ly9TLL1vLd0cXjurfQy0W/nPlEekzldFR8nCSh
	t3Yxc8JeYfc4T2cmVOjZSAY4WoyZcCmFkGzCNhXh3UmYeDWhzAEYG1aWeRg8Tv0y8lCjCm
	Q5kL2bUAuLWPOKbkmyehr6PVf17K8Kg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Mathias Krause <minipli@grsecurity.net>, John Allen <john.allen@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Subject: Re: [PATCH v16 36/51] KVM: nSVM: Save/load CET Shadow Stack state
 to/from vmcb12/vmcb02
Message-ID: <ngbxelfw4lvipsvnoykqo4sonuyjqhuyoh5yogvc6btqj4w6cr@y2jpmnyjphmc>
References: <20250919223258.1604852-1-seanjc@google.com>
 <20250919223258.1604852-37-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919223258.1604852-37-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 19, 2025 at 03:32:43PM -0700, Sean Christopherson wrote:
> Transfer the three CET Shadow Stack VMCB fields (S_CET, ISST_ADDR, and
> SSP) on VMRUN, #VMEXIT, and loading nested state (saving nested state
> simply copies the entire save area).  SVM doesn't provide a way to
> disallow L1 from enabling Shadow Stacks for L2, i.e. KVM *must* provide
> nested support before advertising SHSTK to userspace.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 826473f2d7c7..a6443feab252 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -636,6 +636,14 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
>  		vmcb_mark_dirty(vmcb02, VMCB_DT);
>  	}
>  
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
> +	    (unlikely(new_vmcb12 || vmcb_is_dirty(vmcb12, VMCB_CET)))) {
> +		vmcb02->save.s_cet  = vmcb12->save.s_cet;
> +		vmcb02->save.isst_addr = vmcb12->save.isst_addr;
> +		vmcb02->save.ssp = vmcb12->save.ssp;
> +		vmcb_mark_dirty(vmcb02, VMCB_CET);
> +	}
> +

According to the APM, there are some consistency checks that should be
done on CET related fields in the VMCB12. Specifically from
"Canonicalization and Consistency Checks. " in 15.5.1 in the APM Volume
2 (24593—Rev. 3.42—March 2024):

• Any reserved bit is set in S_CET
• CR4.CET=1 when CR0.WP=0
• CR4.CET=1 and U_CET.SS=1 when EFLAGS.VM=1
• Any reserved bit set in U_CET (SEV-ES only):
  - VMRUN results in VMEXIT(INVALID)
  - VMEXIT forces reserved bits to 0

Most consistency checks are done in __nested_vmcb_check_save(), but it
only operates on the cached save area, which does not have everything
you need. You'll probably need to add the needed fields to the cached
save area, or move the consistency checks elsewhere.

Related to this, I am working on patches to copy everything we use from
vmcb12->save to the cache area to minimize directly accessing vmcb12
from the guest memory as much as possible. So I already intend to add
other fields to the cached save area.

There's also a couple of other missing consistency checks that I will
send patches for, which also need fields currently not in the cached
save area.

>  	kvm_set_rflags(vcpu, vmcb12->save.rflags | X86_EFLAGS_FIXED);
>  
>  	svm_set_efer(vcpu, svm->nested.save.efer);
> @@ -1044,6 +1052,12 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
>  	to_save->rsp = from_save->rsp;
>  	to_save->rip = from_save->rip;
>  	to_save->cpl = 0;
> +
> +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> +		to_save->s_cet  = from_save->s_cet;
> +		to_save->isst_addr = from_save->isst_addr;
> +		to_save->ssp = from_save->ssp;
> +	}
>  }
>  
>  void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
> @@ -1111,6 +1125,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>  	vmcb12->save.dr6    = svm->vcpu.arch.dr6;
>  	vmcb12->save.cpl    = vmcb02->save.cpl;
>  
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
> +		vmcb12->save.s_cet	= vmcb02->save.s_cet;
> +		vmcb12->save.isst_addr	= vmcb02->save.isst_addr;
> +		vmcb12->save.ssp	= vmcb02->save.ssp;
> +	}
> +
>  	vmcb12->control.int_state         = vmcb02->control.int_state;
>  	vmcb12->control.exit_code         = vmcb02->control.exit_code;
>  	vmcb12->control.exit_code_hi      = vmcb02->control.exit_code_hi;
> -- 
> 2.51.0.470.ga7dc726c21-goog
> 

