Return-Path: <linux-kernel+bounces-875614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF6EC19748
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 654485815F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B41C32C320;
	Wed, 29 Oct 2025 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JuUO42lI"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55F328B66
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730649; cv=none; b=QLo2irnEEQL3vOpopWP7znXU1P6K4pSXQ0OF8HvZKGQWhKfap66U049vhekKkuKxpmLZuPZIUTwPl6iTKT5P/z9L2Stfinbonn5Pnf25VzlWoOGqsu3KOrq3/G1r5qsLx71JWUB3jdkJe8rKdNpPF2eddtIagU43YizWS8sZ12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730649; c=relaxed/simple;
	bh=V3lzm9+UIlm/1FQYkWSARxO2puCijn/Xsg+ubzPsCNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nImZqOz+yrrq1ezvw/pA1nbY3dfDVek0vQyQ9mgTyIpT8B/0dAqGw020d8oiny/THLvChptzgR28jBE9rIUjlJYFEqM/KDUetwX/BblpQVNPgFcZAtm/Sga/fKJCIqfAMBg8up+2cd26WrvBQCdYZU07xOs5vsdQBkVqjRxvMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JuUO42lI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7042e50899so100019866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761730645; x=1762335445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E0TqGfvMESadklEaCWA+NgzRrU/er/I4Gi5yc6/AdPc=;
        b=JuUO42lIK2a23YlDAPCAQPRTNeX5NR1GzUvY+kAuQyl6lYwhcTh6rpxRNencI/KuOn
         NXhxW1Pkpjc7Yx+IDn76/AmnmhhgaPlfrAoDE0kJHlTePXNaJ5mWbE70O23pE7Uie6p1
         I/qMS3uBGimnbrYwEZ/DTqlR1L3xX77Jjo/VoC2kCNQK2MHqXcclYJXGP0862zX1yv4q
         aYMWfm3bIQ7d5OAMG1My6P48uHx1mpnL+0mxgKRzFW2Vm+/HF7bc/uu7P4yk5fPAscvw
         wut6CPwm1OHML1Z9J3Pf+9a27XE1DoTRXCp3NugD5K4GJsE7BCLO+XzIhv00gWTTE33l
         a0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730645; x=1762335445;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0TqGfvMESadklEaCWA+NgzRrU/er/I4Gi5yc6/AdPc=;
        b=VlmerPJ5qSnXFRaJSi566j2gyjqnUgIEpSOK+00w+91PYh1bYJwNeT1so+tI37gwIl
         ofh5fGy6jiD59iJmSLKvEC4Zv+D5O5sqQvfwGuvaUMxlh08PcbKTyQ7QJj/Kqe18/WRQ
         8En2SbWxns2AqLUvWWlvuK5nRl4pQ+uNS3wotZ1ibhNU6L2lR3hsIca0/7jEJcZqTItK
         Mks04GyEVw5DsSAmqlPrCLXMdiyfkDYoMn/Ba4Adf2Tfjser+y2spJCnpaOxX+8Zb2za
         TvQEKH+M0YhrcHcOkQzOMm641a+LDOTJS1gQYPSyTkLSQUJaEOAOWPMP0qOc/W+0U7+Y
         domg==
X-Forwarded-Encrypted: i=1; AJvYcCUblazC7moUBWL4QzW+Hy+tYnkDohnKIBLp+GJws6SAEnFlJ/ZF+ISJtEA9RsHuynNBvUPCxEFn7JKEif4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+kYdy3nOM98Nqm7WhEBf6y4QXuiumtjoFgQFA33YaZt9tuDN
	NwiB49WTQMuP33m0t2fUZVvHT2skY/UOFFQl3zU2H5SN7wLflpKYn3EK17OF4GRHGZg=
X-Gm-Gg: ASbGnct3Mo6Ekqlsy3NzeNGxsUMvVHEs6k5M3jNMPY88dFy3TStBQnJlgoHxNVZqWLN
	6il4scZSGRfaUFItenugqSU+jouunxHyUSIQaFYLNlZ+Y7cMHy26FG4ED5APH/Fmg5k026qHhYm
	gJJgU+OS+15XyG4GPTvhk1PfkuZp9mJ+6XXfdbIx4zEPZn0B0ZDv4NeFvA3eOmYDO/1ilnmmg3c
	W8nOQZWfJfQ2CN+5G58FFgMXSAawwX2/Si3ctvRAsqFx9lquFOaY5E2cxfHnmyeT3GDCXvFoIHL
	eTlakfqD4gvGGaQwDPsyuAUWLAf+f12XbNaLdKvAqFx+Mzf7swrTcX/rRJDiSv/ZsTlgEiD0U6H
	Tq7c5d1ROuFwU5mt+bEP/uhb1s9zm7pxJQkQpmIK5UyHuwPDjfMdba/sInl+9d1S6rS72CwSQ3r
	JDMZg=
X-Google-Smtp-Source: AGHT+IFTXvES11v+zAjCqTSyvpFtWX1TNX81yWghE3Ft8R3P+CP2Wt7ChBh0lHwZDxtwEnw5V+LIHg==
X-Received: by 2002:a17:907:3fa1:b0:b6d:6ae2:b66 with SMTP id a640c23a62f3a-b703d2f62d4mr200115566b.20.1761730641181;
        Wed, 29 Oct 2025 02:37:21 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85398439sm1375448466b.36.2025.10.29.02.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:37:20 -0700 (PDT)
Message-ID: <5f1fa90d-5c84-43e6-a99e-ef4a215b5055@suse.com>
Date: Wed, 29 Oct 2025 11:37:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
To: "Kaplan, David" <David.Kaplan@amd.com>, Juergen Gross <jgross@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-35-david.kaplan@amd.com>
 <d897be07-ed59-4538-aceb-53c6512aeccf@suse.com>
 <LV3PR12MB9265295ABF26898CA59B86D594E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <754ee3ec-8819-47df-8251-dec2906a020b@suse.com>
 <LV3PR12MB9265E559972E1C6693AAE7E794FCA@LV3PR12MB9265.namprd12.prod.outlook.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <LV3PR12MB9265E559972E1C6693AAE7E794FCA@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/25 16:19, Kaplan, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Nikolay Borisov <nik.borisov@suse.com>
>> Sent: Monday, October 27, 2025 6:35 AM
>> To: Kaplan, David <David.Kaplan@amd.com>; Juergen Gross <jgross@suse.com>;
>> Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter
>> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Pawan
>> Gupta <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>;
>> Dave Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
>> <hpa@zytor.com>
>> Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
>> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
>> Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for alternatives
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 10/15/25 16:45, Kaplan, David wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: Juergen Gross <jgross@suse.com>
>>>> Sent: Wednesday, October 15, 2025 5:38 AM
>>>> To: Kaplan, David <David.Kaplan@amd.com>; Thomas Gleixner
>>>> <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter Zijlstra
>>>> <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Pawan
>> Gupta
>>>> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>;
>> Dave
>>>> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
>>>> <hpa@zytor.com>
>>>> Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
>>>> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
>>>> Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for alternatives
>>>>
>>>> On 13.10.25 16:34, David Kaplan wrote:
>>>>> Save the existing instruction bytes at each alternative site when patching.
>>>>> This is only done the first time, and these will be used later to help
>>>>> restore the code back to its original form.
>>>>>
>>>>> Signed-off-by: David Kaplan <david.kaplan@amd.com>
>>>>
>>>> Instead of saving the original instructions at runtime, why don't you
>>>> expand struct alt_instr to have an additional offset to a saved copy
>>>> of the original instruction, located in .altinstr_replacement?
>>>>
>>>> The new field should be guarded with #ifdef CONFIG_DYNAMIC_MITIGATIONS,
>>>> of course, like the added handling in the ALTERNATIVE() macros.
>>>>
>>>
>>> That's an interesting idea, I think that could work.  That would make the kernel
>> image on disk (slightly) larger though, as the original bytes will essentially be
>> duplicated (at the original location and in .altinstr_replacement).  I'm not sure which
>> is the better trade-off (kernel image bytes on disk vs runtime memory usage).
>> Although I think we're talking about a relatively small amount of memory regardless.
>> Most of the runtime overhead of dynamic mitigations comes from remembering the
>> call sites/returns.
>>
>> It's not just about memory usage per-se but also memory pressure from
>> allocation and the resulting fragmentation, though I'd think that
>> majority of the allocation will fit into kmalloc-32 bucket, still having
>> them as part of the kernel image eliminates the additional allocs.
> 
> I see.  Just to understand, the issue is more with the numerous small allocations right? (that is the kmalloc at each alt_site)  And less about the single large allocation of the array?

Yep, do you have some statistics how many allocs have to be done?

> 
> I'm just thinking about the retpoline_site handling too.  That one also has a large dynamically allocated array, although it does not have numerous small allocations because the size of each instruction is constrained to at most 6 bytes.


> 
> Thanks
> --David Kaplan
> 
> 


