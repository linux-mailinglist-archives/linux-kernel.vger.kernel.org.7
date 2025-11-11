Return-Path: <linux-kernel+bounces-895935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B515AC4F4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A941C189E542
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4125F3A1CFA;
	Tue, 11 Nov 2025 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVaBdOvH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mAWjL/J2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856F36CDF9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883345; cv=none; b=l+lCcnQmRWJAhAEGiG9ZHZ4QkpmQXz2qcD+JCDgyqGaSk0hTapj0uetvD+TRG5wKapJWhTgUFXG0xf/arkFnVIC8H0gpMBumMQeQsdtIS7pTCbwqppc5++YB3mNhJaxpMWGtGv5nt2KiwRXzODHjsUuzwbNnVv5Q/q+m9umKk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883345; c=relaxed/simple;
	bh=LgfSEHm5E8c0ifvyByIniNQ1/eAtlEy8YYfec15ztiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1OjFZyhNGrTFwvzs0H6cCCOE+mhc7XV/GEANfuyDl9Y4rZ6HqapRUvRyfrN31199ZlUNMm2557hwZgSEWhYj6jsZHBZQwXjoTh56ySpl4OeTLpRllZGljXmf7VtWu7z4ruZtmHTQts7VNdi8oW6Y8T7SvBq31qw4rF/QG9GsYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVaBdOvH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mAWjL/J2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762883342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Ir3GNyu8K7+Ql/2pFj7EGPETpq94G110GW5lctbTuc=;
	b=QVaBdOvHJyTvu/4Br4IvhVyiwIA20TVKqQdWbIvRZEmv3J0SCEDAjXaPHEPUNbdZbrCpvT
	vCKl5yyUrVkOIDzyjmekiSLNECBdj5rX9RKy00A6rGgK5ESd96eAwRe+/DMSTjDsBJmgIr
	vpuFVgR9+M9w3vm+i2SVxZ2vjVIDRuk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-gUa1hUY7OLiy1vxHbR6lrw-1; Tue, 11 Nov 2025 12:48:59 -0500
X-MC-Unique: gUa1hUY7OLiy1vxHbR6lrw-1
X-Mimecast-MFC-AGG-ID: gUa1hUY7OLiy1vxHbR6lrw_1762883338
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2ad2a58cso1833466f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762883338; x=1763488138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ir3GNyu8K7+Ql/2pFj7EGPETpq94G110GW5lctbTuc=;
        b=mAWjL/J2LtwppM4QiVON2K4nmdtQzx+VTRA0Faig5fG/mwshCzr4khlQqTSGtPc+Ie
         Qy3WWYnYK1U1BfoHb/e0iN6c1S0o7MChc+CaClWECzUckg5XVXOH9KkDLK/S6I2VfdTR
         Gzw5j/rv9LhN6EO2Z3LTEy3P6/2ck82TA08crFZ3DY/c8BbTqpnQvKs+YidkUe0pmogd
         +JUVHiG0w+bj0tyq6c+lx8oMuryRUwvTpZWRSHOPPt1PNvrt/1jsMEkcUD+2eMW7KoxP
         iU9TAMeGgyB2biFcvWIzQGk2dw6QB+UApj31iNv8Tjg9wBOxwCCl/Nbc2QZWqLEpm57O
         VSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762883338; x=1763488138;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ir3GNyu8K7+Ql/2pFj7EGPETpq94G110GW5lctbTuc=;
        b=dyjwWVgP+8DyIM5HgyhNlU/6kbTyrcCU+woVh1VI66JBYhn/I9AfAfACVCpIi/r6rD
         vFIvEW1L5fyD6u8NR/h++VdIomp61FbU4Wkc4OV3IkTXNPA1BotlZIGh5Fzz0HyNrHPr
         P32vGS7uLgZC/GNmFOzvYbCjHMOfkHvSzvld1QZ43pyxegdRwXz4P6gKh+3Ccy/5KK+9
         IktA3wTVulgUV2XDBGOhFf6/M8F0RTruLaGVLZ5iG5x1w0aMkrQUTjUmnEDkPLIw/C5N
         W3f9kuhY7E9SQSrzUtygtoTWXl3+wvVqikprzybfOO42hP66/Au0Cc/+taDI4uUHhvJm
         WuiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWONWZ/XFftZ4Fs8kBiSEgqc261lmg7CJt5G6/gZPdYegmItpoI3Y2H9BulT9pRmf0RfJ4iWFkuWwu1AXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+F25Gg2kPQFYSP1lfG7f2Cu08FzECp4oqcyERc/dtlBY6xAB
	rlBDcZWdmdpkI4doyUU+ziFfP6qnU+eEQs2IKcv0tTSGQhO39ebAKaqHryG+J54ZO2U/yfP97oa
	NpmMcDBbV1rjNmkTTHyLyumWWOj/xw6beuNGrqXStTo8L9pKtvSKwdMRVP0PO8+lK/A==
X-Gm-Gg: ASbGncuI6N/eJh1sdgvf1zJ2aRtnHGAkH8/mn4sjd2KnlP8XK5sOw/5oQ93kcRxqXHP
	zkGrFXJFjwhzKaAf5tulU5icWIA6kUW1JxqWHpcjiK3+V8tLMKUpc7pTnwVBe9QSQ/UzsLQwTxg
	8Shyn6AaCrJ3dcyuTBkl0UGvhoW/Kh8A6fo6rOPNe9vUqC9nyt2pTZaZTfzieWExLd5nWYslkNS
	3hz40nSv19Gc9Fi2ZLz2gyS7DuNpIdCr7oc1TUe2tnsll3zA5g9+nbCZfhM4pbjYRiHKx5ztZZ0
	rnnf2ctjP65azmpw6mYeBdR9IUUc+seVU1FT9z5hn1rTOa2pUAjAHSYJAej8ahWHjWcw9AG4n6g
	mXb4TeYGe9KP5xpaB7Udrqws3097kuWQUD/4sexrchsd/MaqWQmSdBVTJ7SZPIKLkzwLC0znvXp
	JoSKG3bA==
X-Received: by 2002:a05:6000:24c2:b0:429:c450:8fad with SMTP id ffacd0b85a97d-42b4bdb8c17mr44712f8f.53.1762883337897;
        Tue, 11 Nov 2025 09:48:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpJqHhquYMTbCx1S1xFecjmlzL5ZP61ooK/fmIld3/vUnPpo6ngWbwqeyiPh5gU0D+c1VmlQ==
X-Received: by 2002:a05:6000:24c2:b0:429:c450:8fad with SMTP id ffacd0b85a97d-42b4bdb8c17mr44688f8f.53.1762883337515;
        Tue, 11 Nov 2025 09:48:57 -0800 (PST)
Received: from [192.168.10.81] ([176.206.111.214])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm28258289f8f.35.2025.11.11.09.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 09:48:54 -0800 (PST)
Message-ID: <ebda0c03-b21e-48df-a885-8543882a3f3b@redhat.com>
Date: Tue, 11 Nov 2025 18:48:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 07/20] KVM: nVMX: Support the extended instruction
 info field
To: "Chang S. Bae" <chang.seok.bae@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: seanjc@google.com, chao.gao@intel.com, zhao1.liu@intel.com
References: <20251110180131.28264-1-chang.seok.bae@intel.com>
 <20251110180131.28264-8-chang.seok.bae@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251110180131.28264-8-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/25 19:01, Chang S. Bae wrote:
> Define the VMCS field offset for the extended instruction information and
> handle it for nested VMX.
> 
> When EGPRs are available, VMX provides a new 64-bit field to extend the
> legacy instruction information, allowing access to the higher register
> indices. Then, nested VMX needs to propagate this field between L1 and
> L2.
> 
> The EGPR checker will be implemented later.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> RFC note:
> During the draft, I brought up the offset definition initially for
> non-nested VMX primarily. Then, I realized the switching helper affects
> nVMX code anyway. Due to this dependency, this change is placed first
> together with the offset definition.
> ---
>   arch/x86/include/asm/vmx.h | 2 ++
>   arch/x86/kvm/vmx/nested.c  | 2 ++
>   arch/x86/kvm/vmx/vmcs12.c  | 1 +
>   arch/x86/kvm/vmx/vmcs12.h  | 3 ++-
>   arch/x86/kvm/vmx/vmx.h     | 2 ++
>   5 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index c85c50019523..ab0684948c56 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -264,6 +264,8 @@ enum vmcs_field {
>   	PID_POINTER_TABLE_HIGH		= 0x00002043,
>   	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
>   	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
> +	EXTENDED_INSTRUCTION_INFO	= 0x00002406,
> +	EXTENDED_INSTRUCTION_INFO_HIGH	= 0x00002407,
>   	VMCS_LINK_POINTER               = 0x00002800,
>   	VMCS_LINK_POINTER_HIGH          = 0x00002801,
>   	GUEST_IA32_DEBUGCTL             = 0x00002802,
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 97ec8e594155..3442610a6b70 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4798,6 +4798,8 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>   		vmcs12->vm_exit_intr_info = exit_intr_info;
>   		vmcs12->vm_exit_instruction_len = exit_insn_len;
>   		vmcs12->vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
> +		if (vmx_egpr_enabled(vcpu))
> +			vmcs12->extended_instruction_info = vmcs_read64(EXTENDED_INSTRUCTION_INFO);

 From patch 17:

+static inline bool vmx_egpr_enabled(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.xcr0 & XFEATURE_MASK_APX && is_64_bit_mode(vcpu);
+}

but here you must not check XCR0, the extended instruction information 
field is always available.  The spec says "A non-Intel® APX enabled VMM 
is free to continue using the legacy definition of the field, since lack 
of Intel® APX enabling will guarantee that regIDs are only 4-bits, 
maximum" but you can also use the extended instruction information field 
if you want.  So, I'd make this also static_cpu_has(X86_FEATURE_APX).

Paolo

>   
>   		/*
>   		 * According to spec, there's no need to store the guest's
> diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
> index 4233b5ca9461..ea2b690a419e 100644
> --- a/arch/x86/kvm/vmx/vmcs12.c
> +++ b/arch/x86/kvm/vmx/vmcs12.c
> @@ -53,6 +53,7 @@ const unsigned short vmcs12_field_offsets[] = {
>   	FIELD64(XSS_EXIT_BITMAP, xss_exit_bitmap),
>   	FIELD64(ENCLS_EXITING_BITMAP, encls_exiting_bitmap),
>   	FIELD64(GUEST_PHYSICAL_ADDRESS, guest_physical_address),
> +	FIELD64(EXTENDED_INSTRUCTION_INFO, extended_instruction_info),
>   	FIELD64(VMCS_LINK_POINTER, vmcs_link_pointer),
>   	FIELD64(GUEST_IA32_DEBUGCTL, guest_ia32_debugctl),
>   	FIELD64(GUEST_IA32_PAT, guest_ia32_pat),
> diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
> index 4ad6b16525b9..2146e45aaade 100644
> --- a/arch/x86/kvm/vmx/vmcs12.h
> +++ b/arch/x86/kvm/vmx/vmcs12.h
> @@ -71,7 +71,7 @@ struct __packed vmcs12 {
>   	u64 pml_address;
>   	u64 encls_exiting_bitmap;
>   	u64 tsc_multiplier;
> -	u64 padding64[1]; /* room for future expansion */
> +	u64 extended_instruction_info;
>   	/*
>   	 * To allow migration of L1 (complete with its L2 guests) between
>   	 * machines of different natural widths (32 or 64 bit), we cannot have
> @@ -261,6 +261,7 @@ static inline void vmx_check_vmcs12_offsets(void)
>   	CHECK_OFFSET(pml_address, 312);
>   	CHECK_OFFSET(encls_exiting_bitmap, 320);
>   	CHECK_OFFSET(tsc_multiplier, 328);
> +	CHECK_OFFSET(extended_instruction_info, 336);
>   	CHECK_OFFSET(cr0_guest_host_mask, 344);
>   	CHECK_OFFSET(cr4_guest_host_mask, 352);
>   	CHECK_OFFSET(cr0_read_shadow, 360);
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 64a0772c883c..b8da6ebc35dc 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -372,6 +372,8 @@ struct vmx_insn_info {
>   	union insn_info info;
>   };
>   
> +static inline bool vmx_egpr_enabled(struct kvm_vcpu *vcpu __maybe_unused) { return false; }
> +
>   static inline struct vmx_insn_info vmx_get_insn_info(struct kvm_vcpu *vcpu __maybe_unused)
>   {
>   	struct vmx_insn_info insn;


