Return-Path: <linux-kernel+bounces-895875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C3C4F27F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4D2189D915
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6D734250D;
	Tue, 11 Nov 2025 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elplknBI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlYiNgXk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B524359FBC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880372; cv=none; b=bNPIfZuAMPMcXq2MkTCKojbwAflXwr/dqtVJ6j6aBuXqIJuhYOAaZ9YtUIH1sGFTlvV2hr2O+vCUM4xB5olFNONB1ukialCMAfbijtfwhgTwTS4mjenmqWn6o2xJkLZ+OyMpOVwiG7nE8CBfRXDqU2EdlqFJ57hbBDVgE3RuMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880372; c=relaxed/simple;
	bh=Qo7Exj/APE0HnRn2oxlqExyR6R1HSPpbWInRXXGeD64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMDHlBX3geiqrjpVm57UZrcUq77Yxqi9KTPfeePQ0wg9u9bdHr811QQiLuSysmlZ0D7Y4NDnASrYFsFbZWaLjqUwoEBSWFGUvib7pWXeDpj6/sloAv+tWEnXslOlOuT8PkXg4ryprEgyeGDyT2lpm14LIJZrFL8GTP0RhVMCIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elplknBI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlYiNgXk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762880369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0yjyFEdJw3Z/9UU9NvRSds9W8+PuhWjUlM+UriXTdoU=;
	b=elplknBI+iRbCpwOiOuxXTRx1UEVGuNxvlwaIy45MHEjTcztrJBhMDXH4G5ySBcxkiuzfH
	I+SFNgotuhD9Z6Ut/RkCLEGGBJnTJb4GvK5oeYpOZXpH7r7veYIhxoXHeRW/x5vGAs64iM
	xPEFg+YhtrmNf56FzCa3y+myMGDrOiI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-NsLbdnMtP1y3HAGHXup2RQ-1; Tue, 11 Nov 2025 11:59:27 -0500
X-MC-Unique: NsLbdnMtP1y3HAGHXup2RQ-1
X-Mimecast-MFC-AGG-ID: NsLbdnMtP1y3HAGHXup2RQ_1762880367
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b4961ec4eso208560f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762880366; x=1763485166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0yjyFEdJw3Z/9UU9NvRSds9W8+PuhWjUlM+UriXTdoU=;
        b=XlYiNgXkQ1I7q75ptMReg/SuNx2up8fMU2BRh3gywfIExtOZ1rKLE7Urh2yravjOud
         3d4BBN6g1EoQmIaxoxuRLLcwGWJRNV7DIAJH/0CpgCUZQZ4y0n2lYn656oSMQJtMX8R7
         fZVdwQPxzCLorAueiXQnMEzkZ8FlrIjwVqbIDYWNNGWYa825IismzCiwYYaDZPzW+rJX
         Vy8lfLQC2YRll9aleyB7iwox5g3XD+L/E6Ror8h/sH4e0kNaLuO5qVRBRwR2rnM9VUwa
         tDbqbUqLTYrYi6p+1/GYF++n1PjzqL70getfgNYI1+hKJMwuOtRq66ss2f+/XtU/GtX5
         BBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762880366; x=1763485166;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yjyFEdJw3Z/9UU9NvRSds9W8+PuhWjUlM+UriXTdoU=;
        b=kU5MlQO8LlbDpe+o5GVLEaJQCfGqdfKZJa6W0qYuX/iOPEt1EJW5T8SEJx1BOUzZ0P
         9hcGls3H2B3r/I4HPvvTKkhOvdRJ46MIIBw7IjRlEQJUJRiJ/zmHaGsfMp/WLVlwCQ3t
         HvGP1QVv1tmY+CIbsHUTQoWha+Yqlf2An9fQwWhpXZf8oDVyCC1wlg2lH//+NEPNAqZk
         2f3DBjOw1WOQF/RvjSJTBpLjMff/7ycEmOTvmyR7/IpW6jHo/ZnDhDhc1ps/1liYx165
         qnHlOp5+ZI3E26Aw7JxLg6XWQ7CZNUDVQ0+f6VF9f321HgQ6c/UKZ7h2E1zOpkFx7hGH
         cpmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzoCggVVn+uJixSAgIE0TCTGmqxoO4gW89i2gMw5z8V0qvqfVALoEccMjcN9Ct6MABrPz/lB0CgDPVB/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx951AQXWH9+oIVO91OF1SWF/nlsiuJD6awg4jT39vroz/+kKdr
	YoUgByPRfqZdnE44uYVvpAljfKcsEvclZvVe7xd29TFSk2agC2CnsCUmq+tQU4c88rIRFxmFsZc
	cUi6fKn5WblYHXQTyxvNxQLHTwfncA6emis9IPfYy9gZu54K9V9MOTS/9JD/IM3htvw==
X-Gm-Gg: ASbGncvLBPNXhS57Uk6lO5jfdcNY8v7tb91uhtL54azBDIf0xGEP+1/+QOCO+PgWnJT
	FYu/Z5j/ywPVhcxe/5z4UWaTiBj7dniYlgxtkU0vUEtGQqwGLtIc6VrOpaQXLOOH5uCu89pFSTq
	2dHSmlHTdqyRh1h5GjUktelDvJv5wkUiwnzMN7jbUSo2ch7bGWm5hOB6gLKoG2TyvYrdh8xzSvC
	2tAeawpT9Jv7BqNVRsrwRcOBUeBS/pqPYdLhSjjxWrV/NamT2Y0xfVNOG1P+zLu+JO0fAARsjev
	dmnmBfh7zglZ8I1oKB/XZEpsTfcwLgim20xy8NxxBuMKaB7H3GJeqleJnUv5qur4VNhfAP6hIJ3
	fnCgleFzpXI5kTfqIIxefDkCbiYZdtrzl6AFX80sDQy82H+2HFm1xhJkWTemmmVtbmOOVEBmcmZ
	09kXQC4A==
X-Received: by 2002:a5d:64e9:0:b0:42b:3b8a:308c with SMTP id ffacd0b85a97d-42b3b8a330dmr6778694f8f.42.1762880366609;
        Tue, 11 Nov 2025 08:59:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBW6xdCq116y/1XekpG/swzz3TUrPhCCJUWZkLqBlcg3nEm6rS3ZuSaKjCs2735S7BCkgu+g==
X-Received: by 2002:a5d:64e9:0:b0:42b:3b8a:308c with SMTP id ffacd0b85a97d-42b3b8a330dmr6778671f8f.42.1762880366165;
        Tue, 11 Nov 2025 08:59:26 -0800 (PST)
Received: from [192.168.10.81] ([176.206.111.214])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac679607esm28646672f8f.43.2025.11.11.08.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 08:59:23 -0800 (PST)
Message-ID: <ab3f4937-38f5-4354-8850-bf773c159bbe@redhat.com>
Date: Tue, 11 Nov 2025 17:59:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 17/20] KVM: x86: Prepare APX state setting in XCR0
To: "Chang S. Bae" <chang.seok.bae@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: seanjc@google.com, chao.gao@intel.com, zhao1.liu@intel.com
References: <20251110180131.28264-1-chang.seok.bae@intel.com>
 <20251110180131.28264-18-chang.seok.bae@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251110180131.28264-18-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 19:01, Chang S. Bae wrote:
> Prepare the APX state enabling in XCR0 by implementing the previous
> placeholders and ensuring its readiness.
> 
> APX introduces EGPRs, tracked as XSTATE component 19. Like other
> XSAVE-managed states, EGPR availability is controlled through XCR0, and
> the registers are accessible only in 64-bit mode.
> 
> At this point, only VMX supports EGPRs. SVM will require corresponding
> extensions to handle EGPR indices.
> 
> The addition to the supported XCR0 mask should accompany guest CPUID
> exposure, which will be done separately.

You should also adjust set_xcr to reject setting BNDREGS and APX 
together (QEMU should also reject MPX and APX together in CPUID, but KVM 
doesn't care enough about invalid CPUID configuration).

Paolo

> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> RFC note
> Not all callers may need to validate the XCR0 bit -- maybe a capability
> bit. However, every exit associated with EGPRs should already have that
> control bit set in the first place. Checking it explicitly does not
> charge additional cost, so I have this for consistency.
> ---
>   arch/x86/kvm/emulate.c        |  9 +++++++--
>   arch/x86/kvm/kvm_cache_regs.h |  1 +
>   arch/x86/kvm/kvm_emulate.h    |  1 +
>   arch/x86/kvm/svm/svm.c        |  7 ++++++-
>   arch/x86/kvm/vmx/vmx.h        |  9 ++++++++-
>   arch/x86/kvm/x86.c            | 11 +++++++++++
>   6 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index f9381a4055d6..ba3020e6f469 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -4787,9 +4787,14 @@ static int decode_operand(struct x86_emulate_ctxt *ctxt, struct operand *op,
>   	return rc;
>   }
>   
> -static inline bool emul_egpr_enabled(struct x86_emulate_ctxt *ctxt __maybe_unused)
> +/* EGPR availability is controlled by the APX feature bit in XCR0. */
> +static inline bool emul_egpr_enabled(struct x86_emulate_ctxt *ctxt)
>   {
> -	return false;
> +	u64 xcr0;
> +
> +	ctxt->ops->get_xcr(ctxt, XCR_XFEATURE_ENABLED_MASK, &xcr0);
> +
> +	return xcr0 & XFEATURE_MASK_APX;
>   }
>   
>   int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int emulation_type)
> diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
> index 8ddb01191d6f..acdb3751317c 100644
> --- a/arch/x86/kvm/kvm_cache_regs.h
> +++ b/arch/x86/kvm/kvm_cache_regs.h
> @@ -3,6 +3,7 @@
>   #define ASM_KVM_CACHE_REGS_H
>   
>   #include <linux/kvm_host.h>
> +#include <asm/fpu/xcr.h>
>   
>   #define KVM_POSSIBLE_CR0_GUEST_BITS	(X86_CR0_TS | X86_CR0_WP)
>   #define KVM_POSSIBLE_CR4_GUEST_BITS				  \
> diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> index cc16211d61f6..673a82532c78 100644
> --- a/arch/x86/kvm/kvm_emulate.h
> +++ b/arch/x86/kvm/kvm_emulate.h
> @@ -237,6 +237,7 @@ struct x86_emulate_ops {
>   	bool (*is_smm)(struct x86_emulate_ctxt *ctxt);
>   	int (*leave_smm)(struct x86_emulate_ctxt *ctxt);
>   	void (*triple_fault)(struct x86_emulate_ctxt *ctxt);
> +	int (*get_xcr)(struct x86_emulate_ctxt *ctxt, u32 index, u64 *xcr);
>   	int (*set_xcr)(struct x86_emulate_ctxt *ctxt, u32 index, u64 xcr);
>   
>   	gva_t (*get_untagged_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr,
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 3aa2c37754ef..e6a082686000 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5288,8 +5288,13 @@ static __init int svm_hardware_setup(void)
>   	}
>   	kvm_enable_efer_bits(EFER_NX);
>   
> +	/*
> +	 * APX introduces EGPRs, which require additional VMCB support.
> +	 * Disable APX until the necessary extensions are handled.
> +	 */
>   	kvm_caps.supported_xcr0 &= ~(XFEATURE_MASK_BNDREGS |
> -				     XFEATURE_MASK_BNDCSR);
> +				     XFEATURE_MASK_BNDCSR  |
> +				     XFEATURE_MASK_APX);
>   
>   	if (boot_cpu_has(X86_FEATURE_FXSR_OPT))
>   		kvm_enable_efer_bits(EFER_FFXSR);
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 6cf1eb739caf..784aa0504dce 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -372,7 +372,14 @@ struct vmx_insn_info {
>   	union insn_info info;
>   };
>   
> -static inline bool vmx_egpr_enabled(struct kvm_vcpu *vcpu __maybe_unused) { return false; }
> +/*
> + * EGPR availability is controlled by the APX xfeature bit in XCR0 and is
> + * only accessible in 64-bit mode.
> + */
> +static inline bool vmx_egpr_enabled(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.xcr0 & XFEATURE_MASK_APX && is_64_bit_mode(vcpu);
> +}
>   
>   static inline struct vmx_insn_info vmx_get_insn_info(struct kvm_vcpu *vcpu)
>   {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4c8c2fc3bda6..e087db0f4153 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8843,6 +8843,16 @@ static void emulator_triple_fault(struct x86_emulate_ctxt *ctxt)
>   	kvm_make_request(KVM_REQ_TRIPLE_FAULT, emul_to_vcpu(ctxt));
>   }
>   
> +static int emulator_get_xcr(struct x86_emulate_ctxt *ctxt, u32 index, u64 *xcr)
> +{
> +	/* Only support XCR_XFEATURE_ENABLED_MASK now  */
> +	if (index != XCR_XFEATURE_ENABLED_MASK)
> +		return 1;
> +
> +	*xcr = emul_to_vcpu(ctxt)->arch.xcr0;
> +	return 0;
> +}
> +
>   static int emulator_set_xcr(struct x86_emulate_ctxt *ctxt, u32 index, u64 xcr)
>   {
>   	return __kvm_set_xcr(emul_to_vcpu(ctxt), index, xcr);
> @@ -8915,6 +8925,7 @@ static const struct x86_emulate_ops emulate_ops = {
>   	.is_smm              = emulator_is_smm,
>   	.leave_smm           = emulator_leave_smm,
>   	.triple_fault        = emulator_triple_fault,
> +	.get_xcr             = emulator_get_xcr,
>   	.set_xcr             = emulator_set_xcr,
>   	.get_untagged_addr   = emulator_get_untagged_addr,
>   	.is_canonical_addr   = emulator_is_canonical_addr,


