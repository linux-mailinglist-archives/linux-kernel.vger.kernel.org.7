Return-Path: <linux-kernel+bounces-838038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B987BAE489
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FE116567A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C004E30CD88;
	Tue, 30 Sep 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gN2FaSFY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC21E0DFE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255996; cv=none; b=guHNRPDOe2FvWsgnRMQ2e9duKSW6zAbzXlg3a3wL8lUyO9ajjLsitvqwY9JNy3LZztLSZvxf1I57VoDT7CujB6hbD2Qosfth8VYpEnPRKZhqgSsm1enHNFF8MPayi0sY7bsZTawfuehy2fibK8QtfL44sGdDvETRZkDzSAWzWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255996; c=relaxed/simple;
	bh=tLzQaY9xNs46b9TNYBN3bfsuXib5IFK4hY2r84lPSWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lez9L0CBuRUDX4l4ss3QnGuO+OXAkWnX1CSp+2bS2tInCqu5ZzmArZz2m4eM4kiGtHefsZofu1je5YhH6mfWYW19Sa6SdbYlYp+9KhMBLqkGrzr8l5bZfCcciAknFensQr6TWF6591WA/qJOmDWLENA76tKT3ID51Ftt3EsjAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gN2FaSFY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759255993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IIPDd0kT6C4FiADrZisLSF/yuhkConGOm03Id2jcBDU=;
	b=gN2FaSFYKdeswLDoNMU6Q5FKTiDPHEMyinFswmY/x337VhSit77jtb26nZAegJ2GnRGgg7
	SVvzH0PqJrsldIwOPBsmG0ZF9GMGm5n1P1kZOULFe8MbpldtTotqId4bnVm2QEho/7S0fK
	1UjhinrANtWrXNVhyP0OBxoQ6oTekY4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-od6oYE3jPo-5DwjCDGzgBA-1; Tue, 30 Sep 2025 14:13:10 -0400
X-MC-Unique: od6oYE3jPo-5DwjCDGzgBA-1
X-Mimecast-MFC-AGG-ID: od6oYE3jPo-5DwjCDGzgBA_1759255989
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b4626b2d07bso60968366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759255989; x=1759860789;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIPDd0kT6C4FiADrZisLSF/yuhkConGOm03Id2jcBDU=;
        b=WJ54oH+15p+ZtP8w/klLysSWX1mIjX8pEJcyglDiFyRmQQKX36CJgeaLW4x51mspsx
         aEhhLGraBMsBnrlPlGqdoBWpJ2deikqtwqPOSC3NDM0M1lRMwxXcwb7JSwn7guZmHlVl
         0QDiWYtiXcRLE1GjlUTk5uV28JCN8jcabA1B49E+FK7y+UsNbxH1eox2DByy1Lb7gVdg
         yejkQ+b3Cxqm5Tk4bJkeiG2F0p1H2pOKtcci/J803LtZO2JghRixNTfGyNFf1RSySnAk
         3Zmd5p2AQ5S/BgC33yq+MlX0czysd8q/odIGtStZY4pqd4vaN96Jr5LOey8k3Ij464KR
         fFxw==
X-Gm-Message-State: AOJu0YwiLeVbJhZ+uwt0IPWVqf12LTB2BmWusYSSDyI8EtiFWpYPJa8I
	eACSotsqDgEr0C/Y0oYqmvNysNVF824hscn3KuwH1x7Jcx/E4zs9hsiNFCbgq1XT0rwTraV3/Se
	3khMlSYLPxIqRyYmTjOb69OjEgYq5dLS7EtYc5Ju8+Z0x4uwEP7gjL243EfIQUtDSQg==
X-Gm-Gg: ASbGncsnqg32DyFhcmr7DZhZfvcFEyJX4iSnOhkSqcB7/CthiPWI7BJoZCib1/Kt0DP
	UVAdIK+lTBNbzPbkXkiXPwpHzv6DboFOKEhBGyULmIkXlqgBQ2Txk7epFIP3Ew5FpL40/bohKFe
	8dgmij6H5sf8cUCzqCBzsl8qCtodrfKYWZr8RWVv0FbT+nN7HIxx7X5TL28Q50smFfpSh3eh768
	XQlKdXRlw9fJy7Nm9Sye1bQ4st79ZpIztWmC0cFXQdj/8/Yh0omBZ+LrJ0KjBV02wtPmp2Aup2b
	TDgJ8Qa0sTEijqCiKS8o+4rXRR4Ex96OxQ1iAv+m++v4VvzYrTdTejUP+7QvMAvZPCDWwXcnXO0
	iMxbqCCTBWHOEd9ol5HAu7HDFTlXp8dVZQk+G2Z4Oz0Z1oNN8h4o=
X-Received: by 2002:a17:907:9447:b0:b46:9a2d:9ef with SMTP id a640c23a62f3a-b46e6a08184mr59776566b.63.1759255988706;
        Tue, 30 Sep 2025 11:13:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7pZ97wuHTXTTcZBhQGrP/6pyws1EiYlgdha7WtbgyDLfQO1zxTuzhS0LBdBiQxzqfXIUGlw==
X-Received: by 2002:a17:907:9447:b0:b46:9a2d:9ef with SMTP id a640c23a62f3a-b46e6a08184mr59773866b.63.1759255988268;
        Tue, 30 Sep 2025 11:13:08 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.127.188])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b4691b07a77sm52359666b.2.2025.09.30.11.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 11:13:07 -0700 (PDT)
Message-ID: <e8907aaf-ff55-4873-849c-91a844494cf7@redhat.com>
Date: Tue, 30 Sep 2025 20:13:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the kvm-x86 tree with the tip tree
To: Mark Brown <broonie@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <aNEb7o3xrTDQ6JP4@finisterre.sirena.org.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aNEb7o3xrTDQ6JP4@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 11:50, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm-x86 tree got a conflict in:
> 
>    arch/x86/kvm/emulate.c
> 
> between commit:
> 
>    6204aea36b74c ("KVM: x86: Introduce EM_ASM_1")
> 
> from the tip tree and commit:
> 
>    f8457615b71c6 ("KVM: x86: Don't emulate instructions affected by CET features")
> 
> from the kvm-x86 tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This will soon become a conflict between kvm and tip.

Paolo

> diff --cc arch/x86/kvm/emulate.c
> index 796d0c64f9baf,5c5fb6a6f7f92..0000000000000
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@@ -4001,11 -4153,11 +4088,11 @@@ static const struct opcode group4[] =
>    };
>    
>    static const struct opcode group5[] = {
>   -	F(DstMem | SrcNone | Lock,		em_inc),
>   -	F(DstMem | SrcNone | Lock,		em_dec),
>   +	I(DstMem | SrcNone | Lock,		em_inc),
>   +	I(DstMem | SrcNone | Lock,		em_dec),
> - 	I(SrcMem | NearBranch | IsBranch,       em_call_near_abs),
> - 	I(SrcMemFAddr | ImplicitOps | IsBranch, em_call_far),
> + 	I(SrcMem | NearBranch | IsBranch | ShadowStack, em_call_near_abs),
> + 	I(SrcMemFAddr | ImplicitOps | IsBranch | ShadowStack, em_call_far),
>   -	I(SrcMem | NearBranch | IsBranch, em_jmp_abs),
>   +	I(SrcMem | NearBranch | IsBranch,       em_jmp_abs),
>    	I(SrcMemFAddr | ImplicitOps | IsBranch, em_jmp_far),
>    	I(SrcMem | Stack | TwoMemOp,		em_push), D(Undefined),
>    };
> diff --cc arch/x86/include/asm/cpufeatures.h
> index b2a562217d3ff,8738bd783de22..0000000000000
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@@ -495,8 -496,7 +496,9 @@@
>    #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
>    #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
>    #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
>   -#define X86_FEATURE_MSR_IMM		(21*32+14) /* MSR immediate form instructions */
>   +#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
>   +#define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */
> ++#define X86_FEATURE_MSR_IMM		(21*32+16) /* MSR immediate form instructions */
>    
>    /*
>     * BUG word(s)
> diff --cc arch/x86/include/asm/msr-index.h
> index 718a55d82fe45,717baeba6db3c..0000000000000
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@@ -315,14 -315,15 +315,16 @@@
>    #define PERF_CAP_PT_IDX			16
>    
>    #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
>   -
> + #define PERF_CAP_LBR_FMT		0x3f
>    #define PERF_CAP_PEBS_TRAP		BIT_ULL(6)
>    #define PERF_CAP_ARCH_REG		BIT_ULL(7)
>    #define PERF_CAP_PEBS_FORMAT		0xf00
> + #define PERF_CAP_FW_WRITES		BIT_ULL(13)
>    #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
>   +#define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
>    #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
>   -					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE)
>   +					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
>   +					 PERF_CAP_PEBS_TIMING_INFO)
>    
>    #define MSR_IA32_RTIT_CTL		0x00000570
>    #define RTIT_CTL_TRACEEN		BIT(0)
> diff --cc arch/x86/kvm/emulate.c
> index 796d0c64f9baf,5c5fb6a6f7f92..0000000000000
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@@ -4001,11 -4153,11 +4088,11 @@@ static const struct opcode group4[] =
>    };
>    
>    static const struct opcode group5[] = {
>    	F(DstMem | SrcNone | Lock,		em_inc),
>    	F(DstMem | SrcNone | Lock,		em_dec),
> - 	I(SrcMem | NearBranch | IsBranch,       em_call_near_abs),
> - 	I(SrcMemFAddr | ImplicitOps | IsBranch, em_call_far),
> + 	I(SrcMem | NearBranch | IsBranch | ShadowStack, em_call_near_abs),
> + 	I(SrcMemFAddr | ImplicitOps | IsBranch | ShadowStack, em_call_far),
>   -	I(SrcMem | NearBranch | IsBranch, em_jmp_abs),
>   +	I(SrcMem | NearBranch | IsBranch,       em_jmp_abs),
>    	I(SrcMemFAddr | ImplicitOps | IsBranch, em_jmp_far),
>    	I(SrcMem | Stack | TwoMemOp,		em_push), D(Undefined),
>    };


