Return-Path: <linux-kernel+bounces-734982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63044B08910
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459A77A5530
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3B288535;
	Thu, 17 Jul 2025 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bZW29Qwf"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771A2857F1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743694; cv=none; b=krbzUuSepFSUgdtj6imuT6Q/o8oXPIPLBIcvb7BQN2aqinITrVD+BY04YyTT7cthGn4WvjC1IhNVgAA+G950gcDmKsNvijA2ozgJivkUF0utcCZPreBWL+nqhI3AAluhC1VC2R4p7D2Y7HoyOtDZl3GT8rF2cZMibWk1+MtGbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743694; c=relaxed/simple;
	bh=5FUJ1ODXykL1dBKSpMRvaSvysoeEX1Nqlm3DE0Otw8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTZ5b8RarK7vKhw4ESIy2RgMJRXaX+ELZrXvld3VhGmWqJUZ1pneW/oYpO3zRjiAM1kTFViaEKHQsdEfJeF/3NxZOBURPNAOVE+xfslEBTCo49M00ybdOBU2QQSVDW4JYkfQt462CQc3BwIcDviDJPh4ZzO5pZx7VoG3IIaANA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bZW29Qwf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so131778366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752743690; x=1753348490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvF3zOb5xSpb1Uxmw4UNSSWpqvIymBAoaxDK8LkmqYY=;
        b=bZW29Qwfn1HYSAuZOhBeqi+N9oj/dVBKrir4eHT+yUg6wT6L5YmOXuz461AKd6+a7/
         lajShHBLvv2p0bcstJQ+bX/+PjxuGnK4sDo5sjcnmG3U/fCqXJmuXHyyVXXJf6jGr/2x
         oAXwifZX0dHEqDW+Y5+hj/zWSjLCnwmrGZZXzYkwqMk71LM9S+r7kIw8W0JJPP437Mdy
         ukybpxS3+RyUXpwvnbA0SBf2gV7/8ZVqcvjxsoxxlVPap3VE7mV3vGnm8Ni6Al0EmpYd
         dgyDkdIjr2Gqd5DjI+MG9x6xSyBEFVQFtEBJIsqssxPf7veepX0MVn1Jeea1sopYNXIx
         0MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752743690; x=1753348490;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvF3zOb5xSpb1Uxmw4UNSSWpqvIymBAoaxDK8LkmqYY=;
        b=ZrIRdvKuNmS/myfC5AfrVLXiMcJ5d4cLP8XkO2Y9cu7VfLHEQ5fYWy8FMCLp7PoIuU
         bkBN745SvNf+zk96yGqZ8NsfZXTgOIMnO6/OFipU+nI1XpGa7/c6Stpy+sZ43vHITLkD
         ob+pFxDa/8w2qPfh4Uxkz0FZhdc/oXBBdjr+iWpCHFnQBAt5HjPwLgh1Qzh7LatQhakn
         YNd2/qtcswwQLMZxqasdzm19GhkCf6dul/F51NWvHAB5FwKXuT0Kw90TWZylahqeL3aQ
         SEldl/7hjhoVuzvvIIKCWVJhWsjWhB09TAXIFkDAn/ZYodtI6tzBqTpwD1/+VYUfzPg8
         Dy+w==
X-Forwarded-Encrypted: i=1; AJvYcCXhI3N/HNz/NdfzModiLzNvHdMXu89xDTQqJSrwB9ToJIqKyaJR0saUhCb9vhwWYwZKcIj34JOfEkG77Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2ogvWNfAdF/nh481+BVNinh/7Bvmi/dbEWLk7J/kuhW2+Z7C
	F7abHIyLMF3dlqWlmKmKFqXzHcO0ZFagWsFptjZmkCalSVnOUH4YkUBZVzX4niqo5ns=
X-Gm-Gg: ASbGncuxwnTDCmploUHse4BYXq6YnX8jEv8rCu6qbjYrcsGzc73f4AGNIp8yzv20U1t
	UYc1jtO4MzA7oZ66fqui/IC0tgzZX8e0lIIexDwwibqpQ3EUg9SdXTwfwIGAEZbwGKSBjVFxEw3
	MTH6FvmfD17YIbSyP9V3V0kTJo5cXZz882D3uUkrH8LAf68nnkSH2lmsMjrf9l7Ht9CpTHkOIra
	kgB5YRmw16tBCTEoRGMZS5JHmJTid20MEzUubZYNQYAOhxSk5RLSxgQ229HIQk5ReC4RNGKI1xH
	0/HfFeFKmbYonB3/+50WHsloUybf2uI9R4593i0tP1EhC+0kVHyBGf34w8gsMVpdNXD4lQhj7N3
	inc1w5LFXaOJVy8StMbatVkUG2iwdhNblik1/
X-Google-Smtp-Source: AGHT+IEnD/7R/2gqsCpLAcNMPV3t2q2FnJZCaxlABMRQi65QpmoSs4DiQ6mxeDbvEffx+/eNFV0Nbg==
X-Received: by 2002:a17:906:f049:b0:ae0:cc3d:7929 with SMTP id a640c23a62f3a-ae9cdd861c1mr523581866b.1.1752743689884;
        Thu, 17 Jul 2025 02:14:49 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.209.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82964a9sm1336344566b.141.2025.07.17.02.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:14:49 -0700 (PDT)
Message-ID: <60d4e55c-2a4f-44b4-9c93-fab97938a19c@suse.com>
Date: Thu, 17 Jul 2025 12:14:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/1] KVM: TDX: Decrease TDX VM shutdown time
To: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: pbonzini@redhat.com, Adrian Hunter <adrian.hunter@intel.com>,
 kvm@vger.kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, kai.huang@intel.com,
 reinette.chatre@intel.com, tony.lindgren@linux.intel.com,
 binbin.wu@linux.intel.com, isaku.yamahata@intel.com,
 linux-kernel@vger.kernel.org, yan.y.zhao@intel.com, chao.gao@intel.com
References: <20250611095158.19398-1-adrian.hunter@intel.com>
 <175088949072.720373.4112758062004721516.b4-ty@google.com>
 <aF1uNonhK1rQ8ViZ@google.com>
 <7103b312-b02d-440e-9fa6-ba219a510c2d@intel.com>
 <aHEMBuVieGioMVaT@google.com>
 <3989f123-6888-459b-bb65-4571f5cad8ce@intel.com>
 <aHEdg0jQp7xkOJp5@google.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <aHEdg0jQp7xkOJp5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.07.25 г. 17:19 ч., Sean Christopherson wrote:
> On Fri, Jul 11, 2025, Xiaoyao Li wrote:
>> On 7/11/2025 9:05 PM, Sean Christopherson wrote:
>>> On Fri, Jul 11, 2025, Xiaoyao Li wrote:
>>>> On 6/26/2025 11:58 PM, Sean Christopherson wrote:
>>>>> On Wed, Jun 25, 2025, Sean Christopherson wrote:
>>>>>> On Wed, 11 Jun 2025 12:51:57 +0300, Adrian Hunter wrote:
>>>>>>> Changes in V4:
>>>>>>>
>>>>>>> 	Drop TDX_FLUSHVP_NOT_DONE change.  It will be done separately.
>>>>>>> 	Use KVM_BUG_ON() instead of WARN_ON().
>>>>>>> 	Correct kvm_trylock_all_vcpus() return value.
>>>>>>>
>>>>>>> Changes in V3:
>>>>>>> 	Refer:
>>>>>>>                https://lore.kernel.org/r/aAL4dT1pWG5dDDeo@google.com
>>>>>>>
>>>>>>> [...]
>>>>>>
>>>>>> Applied to kvm-x86 vmx, thanks!
>>>>>>
>>>>>> [1/1] KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM
>>>>>>          https://github.com/kvm-x86/linux/commit/111a7311a016
>>>>>
>>>>> Fixed up to address a docs goof[*], new hash:
>>>>>
>>>>>          https://github.com/kvm-x86/linux/commit/e4775f57ad51
>>>>>
>>>>> [*] https://lore.kernel.org/all/20250626171004.7a1a024b@canb.auug.org.au
>>>>
>>>> Hi Sean,
>>>>
>>>> I think it's targeted for v6.17, right?
>>>>
>>>> If so, do we need the enumeration for the new TDX ioctl? Yes, the userspace
>>>> could always try and ignore the failure. But since the ship has not sailed,
>>>> I would like to report it and hear your opinion.
>>>
>>> Bugger, you're right.  It's sitting at the top of 'kvm-x86 vmx', so it should be
>>> easy enough to tack on a capability.
>>>
>>> This?
>>
>> I'm wondering if we need a TDX centralized enumeration interface, e.g., new
>> field in struct kvm_tdx_capabilities. I believe there will be more and more
>> TDX new features, and assigning each a KVM_CAP seems wasteful.
> 
> Oh, yeah, that's a much better idea.  In addition to not polluting KVM_CAP,
> 
> LOL, and we certainly have the capacity in the structure:
> 
> 	__u64 reserved[250];
> 
> Sans documentation, something like so?
> 
> --
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 13da87c05098..70ffe6e8d216 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -963,6 +963,8 @@ struct kvm_tdx_cmd {
>          __u64 hw_error;
>   };
>   
> +#define KVM_TDX_CAP_TERMINATE_VM       _BITULL(0) > +
>   struct kvm_tdx_capabilities {
>          __u64 supported_attrs;
>          __u64 supported_xfam;
> @@ -972,7 +974,9 @@ struct kvm_tdx_capabilities {
>          __u64 kernel_tdvmcallinfo_1_r12;
>          __u64 user_tdvmcallinfo_1_r12;
>   
> -       __u64 reserved[250];
> +       __u64 supported_caps;
> +
> +       __u64 reserved[249];
>   
>          /* Configurable CPUID bits for userspace */
>          struct kvm_cpuid2 cpuid;
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index f4d4fd5cc6e8..783b1046f6c1 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -189,6 +189,8 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
>          if (!caps->supported_xfam)
>                  return -EIO;
>   
> +       caps->supported_caps = KVM_TDX_CAP_TERMINATE_VM;

nit: For the sake of consistency make that a |= so that all subsequent 
additions to it will be uniform with the first.
> +
>          caps->cpuid.nent = td_conf->num_cpuid_config;
>   
>          caps->user_tdvmcallinfo_1_r11 =
> --
> 
> 
> Aha!  And if we squeeze in a patch for 6.16. to zero out the reserved array, we
> can even avoid adding a capability to enumerate the TDX capability functionality.
> 
> --
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index f4d4fd5cc6e8..9c2997665762 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -181,6 +181,8 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
>   {
>          int i;
>   
> +       memset(caps->reserved, 0, sizeof(caps->reserved));
> +
>          caps->supported_attrs = tdx_get_supported_attrs(td_conf);
>          if (!caps->supported_attrs)
>                  return -EIO;
> --
> 

