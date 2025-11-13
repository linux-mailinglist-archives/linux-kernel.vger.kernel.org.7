Return-Path: <linux-kernel+bounces-899258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185FC57375
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BB0B4E91E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933F233FE2E;
	Thu, 13 Nov 2025 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXmZr9PC"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7833F8D2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033645; cv=none; b=QKUnZgc3UAYSMyOzYyGXe9+IlYZfi5qf9kzFl0vXS3QOIgkeotWghTVgkAUop3WqhwKKqqmwQyXqMhpV8vcWAMdRKRVRariBHqzb/ha1NoS5TSmZckb/3sPJHNK9ayiT3P2Q/yGbUs14jW6It7JchhhATzElQ5e9Ak2msJjoOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033645; c=relaxed/simple;
	bh=szEfWU/bVV1zSB98g0M2rX9bxqlQLQNTUONjL2LW8Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcP9xQzrAnyc1oe1rf0GKpOZlbuvsjE/B5DLEvgqW/5258d27yOuOldPwIYvbyFg4wVOCNM8dz/t6Us9ks9SHFlm86xNps/XHPaJQQu/xC9Vf6b8uvMrLwKmaMnSFCVsp/j+nP++56DnPRFttHm/XXK9W/JxpwwmfSYVJHJZe2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXmZr9PC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so353247f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763033642; x=1763638442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itNJjGbKr9hOTSLlNwiZZOpbJXSs/2p7rVNvrCzyP+Y=;
        b=KXmZr9PCoa5qVa/VigcWhfxfx/iX5li6bYSwjGXHmogvrt2cWOIpg478NOtVVxdxBj
         /jXumxsJKNow4QDerDNsenR2F0LxGPCyqD5JmZBbarDqZRuMWxgMsqkD8ODXpFUIZk8A
         EzRGweoKnCNAdpp7C38a0AQRGyu25vHEw/uRMwNS6Aaoln63QtFFfpnVhelLalAOrDZ/
         wxqyDN+ggNMK98uGVsrecBi9WGZwB5XAKpI40mREtOLK8L1ntAH7Um2j7nOLfxSuDban
         rTL8hPO2dl3WhMgnM3x7xT5Ma2eaFb6AxyldwMo3Q0+yNZKb4NapWQ4SzJpbK+Ua8NSC
         LPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763033642; x=1763638442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itNJjGbKr9hOTSLlNwiZZOpbJXSs/2p7rVNvrCzyP+Y=;
        b=Tq8Jo9qBzyRwjeDRU+kNIpadjNBzrQMJKqETjFUMD0k1Yvg/HB1aAaMQIU7K6nvJM/
         H84mO1aYayBs/YofaAGUUYKX62XUIow67Q/tiCvIb11/e3lydqe7ZiZG9sMXk+/Kw2sM
         6Ww6GK85sPtmBThgxvIEJF7pkf/dUrEiMHjFYrGtwLslqX2EovHhL0ExuHxJVTsM6GMq
         NjZXryPsEiX1nFWvyAu3J1HCS+f8phWgx+UkD3NZvlDMjHm6QD/NhybJrTcLT8yBKw8k
         CHZT57FqPPLJkKGx5VlusSllZcQaYc1zfyeqJZBE6KQO17pLbsyNw8zXPRafLzHx1vqy
         Z3eA==
X-Forwarded-Encrypted: i=1; AJvYcCVH6y93HbuBt6DvX6q5yO6MtQPf0H2ijNTTbptH9Q0klyN1tikvDdFJ/QesyG5sU78PEfygsmHZ5fF/rX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6F2Yzz5ZcmXfX/u5at0eirvXkPnFas3362ivyBIKcdK20MbTb
	Vt0mt+dsmD8ih+/KhaxPauntPJUfydFlB3ZqSUbiq3heua44b9mVzN/o
X-Gm-Gg: ASbGncsjHljRf/yWnW4N4eAxmETjnuaEcWUS2KsNUe6k2B549vfO3Z0HyhvPMBi0r3q
	Ek6IGUtHMWMV6EDtNn+2fNa7iPO31LsYG3dCiSJ2Ns6LVAFUrOLprSiH+DfoESZhsUDpqLUshyk
	e+A2k48bDye/qw9nl9U+svr33MACRQLZiDo7OJBiUNWfTZFo4HnS1kvuOqA3bKkTN7mqEnWIYz3
	st2t8AGGwvTjie4SAAhNxwuVfmCZ+G3/+fUcGBJYChUCmYc1B4OjA00e6ZHWpN8AVXCd9aVV5EW
	+C1hYpYUVlqw8zYkBwTmtfWq6itiV0rxVP/YZA2Yqhg6p14yXp/qE9RxYt67T0I/doiXpTHx5i1
	7AWW5mVcvzfpTtHAtVNEE/9Ohqg+4E/0kYyFPRZOjTOlLE74R2Mnh5b5ZSZ9YMXKcmiLPdBQ4AA
	/kmv2ofUGVx9SjZ03fC+xjZEnSMo8=
X-Google-Smtp-Source: AGHT+IGdopSjDKcZsfNDj50WFrJg2rJWrnZhwNBuCTBSaYL3A3I/G6d2OYwxOSpsfHYEqI44/nAYpQ==
X-Received: by 2002:a05:6000:40dc:b0:429:d3c9:b8af with SMTP id ffacd0b85a97d-42b5282384cmr2499048f8f.25.1763033642106;
        Thu, 13 Nov 2025 03:34:02 -0800 (PST)
Received: from [10.24.67.124] ([15.248.2.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm3172575f8f.35.2025.11.13.03.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 03:34:01 -0800 (PST)
Message-ID: <25469f8f-27ea-4d9f-af70-86e320224ec4@gmail.com>
Date: Thu, 13 Nov 2025 11:34:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] KVM: selftests: Fix unaligned mmap allocations
To: Sean Christopherson <seanjc@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 isaku.yamahata@intel.com, roypat@amazon.co.uk, kalyazin@amazon.co.uk,
 jackabt@amazon.com
References: <20251013151502.6679-1-jackabt.amazon@gmail.com>
 <20251013151502.6679-3-jackabt.amazon@gmail.com>
 <aPpi1c-8EpWuo87B@google.com>
 <c52db7bf-494f-49a8-9829-3805db6dda7c@gmail.com>
 <aQkZtjLt6lIULffA@google.com>
 <0c3db907-7012-43c3-b7fc-36848789da52@gmail.com>
 <aQpfviS-oAmanqpq@google.com>
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <aQpfviS-oAmanqpq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/11/2025 8:19 pm, Sean Christopherson wrote:
> On Tue, Nov 04, 2025, Jack Thomson wrote:
>> On 03/11/2025 9:08 pm, Sean Christopherson wrote:
>>> On Tue, Oct 28, 2025, Jack Thomson wrote:
>>>>
>>>>
>>>> On 23/10/2025 6:16 pm, Sean Christopherson wrote:
>>>>> On Mon, Oct 13, 2025, Jack Thomson wrote:
>>>>>> From: Jack Thomson <jackabt@amazon.com>
>>>>>>
>>>>>> When creating a VM using mmap with huge pages, and the memory amount does
>>>>>> not align with the underlying page size. The stored mmap_size value does
>>>>>> not account for the fact that mmap will automatically align the length
>>>>>> to a multiple of the underlying page size. During the teardown of the
>>>>>> test, munmap is used. However, munmap requires the length to be a
>>>>>> multiple of the underlying page size.
>>>>>
>>>>> What happens when selftests use the wrong map_size?  E.g. is munmap() silently
>>>>> failing?  If so, then I should probably take this particular patch through
>>>>> kvm-x86/gmem, otherwise it means we'll start getting asserts due to:
>>>>>
>>>>>      3223560c93eb ("KVM: selftests: Define wrappers for common syscalls to assert success")
>>>>>
>>>>> If munmap() isn't failing, then that begs the question of what this patch is
>>>>> actually doing :-)
>>>>>
>>>>
>>>> Hi Sean, sorry I completely missed your reply.
>>>>
>>>> Yeah currently with a misaligned map_size it causes munmap() to fail, I
>>>> noticed when tested with different backings.
>>>
>>> Exactly which tests fail?  I ask because I'm not sure we want to fix this by
>>> having vm_mem_add() paper over test issues (I vaguely recall looking at this in
>>> the past, but I can't find or recall the details).
>>
>> The test failures happened with pre_faulting tests after adding the
>> option to change the backing page size [1]. If you'd prefer to
>> have the test handle with this I'll update there instead.
> 
> Ah, yeah, that's a test bug introduced by your patch.  I can't find the thread,
> but the issue of hugepage aligntment in vm_mem_add() has come up in the past,
> and IIRC the conclusion was that tests need to handle the size+alignment, because
> having the library force the alignment risking papering over test bugs/flaws.
> And I think there may have even been cases where it introduced failures, as some
> tests deliberately wanted to do weird things?
> 
> E.g. not updating the pre-faulting test to use the "correct" size+alignment means
> the test is missing easy coverage for hugepages, since KVM won't create huge
> mappings in stage-2 due to the memslot not being sized+aligned.

Got you, that makes sense I'll update this series to resolve this then.
Thanks for taking a look.

-- 
Thanks,
Jack

