Return-Path: <linux-kernel+bounces-884687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EFFC30C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C75718C25E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E0A2EA15B;
	Tue,  4 Nov 2025 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+dSonTa"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A55C2C21D4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256439; cv=none; b=uNVhizk6OxQlwZAuQbPyo7smTP23SAHZ2hWMfxc+lSKarllE5iYjyeKP/qhnAng7TqMVUKLPwllNui1rgs5VHnt2ev7Veldnjb4DKuymVdRWHbE/OhIqXLNNXWbnwOOs7hzvWbPHSZer4XedOdtk8dP1v65p9aiqAe8I6RDgzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256439; c=relaxed/simple;
	bh=+oWB3A/Q6CzSkeY4soYqa5X1mb+HtRxJLp8w5G8pEck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvCP/9rtTBklerQUwIj8vA3s6bcUT/fwNLnUWUGwpgW4NrzqtV1KUw4GJLu0vgfg8TBtU/wvrE9PwjPOyHy3G4vPpdmLE+id85OKJELwoj4kTHXnz+SuJPt1M+PyirYMtjU9l+O0bLDnMZsIIBJf9P8V5Aq2nJfrbjY1mHvVFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+dSonTa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-475db4ad7e4so20999565e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762256437; x=1762861237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtEDtvTY+cIWIGM0pelvhRwZ4E8HNdVkiBIKwKLkzCw=;
        b=l+dSonTacJJFCdYpcvYCqnsSTvVMQ1qkpeWJcJoHLX+HhLJvE+s7UXxtgr968X01o3
         d6zvdb5YMp4tUNUymW+zwuri9WD4A12uTunHXOTNLowE6mVhxRsd7VSZXIahEzE8jm2F
         INkISQwNl5Kh3ANOLp1jcwDaJvTLOFkTFk3ZqpKGyAoOYKe0c74h9G1Cy39qcvajAS+D
         QJKNU5fwHev/q2AYgX67XFfXlTsGOCeLyaWKb8oRyptKY4AJJbyuR0JLYUJAlE7EPe/e
         Z0WE/2hqQasv+MZ2tnu6WnIJgbRh5c66O81Y+iEZ3GVmdu3Lqbdf65iKBtpHfnCrwarV
         IxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762256437; x=1762861237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtEDtvTY+cIWIGM0pelvhRwZ4E8HNdVkiBIKwKLkzCw=;
        b=cfwfJ2xm4xIpSrnRQF+XQnfeTUg31P7L5q34Ik5pAdzAKDNpPFlkYoZErmWvXSlQEX
         uCD5pVIydzwP+sU12zOLDaV/3AZW7HQd6VqUqp2egZkUVSb9UYHmreeKOC1JRXIDEGXp
         Zeh8H3o2jfwYzRH6qAwPVR5LIMUzXvCV+SWwfHD3xDTDdPjP1QA6hB12aKZVKbhVftJq
         fy1gkbOEbv1SIpcV8MUk7UK5W9140agYvUjocSuJCOPrzOC/LGkwzhgQ8VWzxduHe0aV
         2WesXv9LngYHzX795sT4auDcWZXHUBU6FI7swt2Io5+ciqYiKTYFKC4ld/grZ47vUfzv
         IhDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNzxiu8yK3+eSZMXvrKT1JCGsR0PRW9SvXVLz6ohtLiYzsvqTbjoslOuNvBXGmuRwnYchOBQeyA2++a3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp1KBBHX7E4oVqdO7KOCDsZ7rvu2DPIqSvTNmLpQuGwFQ5hKop
	7QPYPunDE5HFJBaNzKVU5mho4Ac1lAi/pCqoceOFkirCNPR1ykqc6nd3
X-Gm-Gg: ASbGncukQxedV7YAa4j8fwFjCedTPCRnuXEGhXTbJmZGmmSD+nbgDSqKixTAEkkenNr
	8gMUcfcoyukqB99dAfYR03Z3NJXRG55TUpLlcP/g2OkjOsec9XdaxaYY8ZYE7zihn97mkQ7wY4w
	8o60RCK/95yXFCEHjwImrX1pgjSlGji/WqzyK6tvMzN1d4rpO2QPMaKp4SGD0tbCnJlHMIpqZCH
	WB1u2uORTkgkWdTT0pBJHFdfaxmxCgn6MXERPXIqjVaG9Z3U6bk2RjAxcw1AYg0CHswLa1XyY94
	S8jZOnKEmcOFk67ji5dxmgb4aWGSyfQmlAg33mgZwqeUHFjs+GJc4iDiiHg977mdR5xjgeqh1+b
	sjLq65SnnCxSt563EpFnpS1LMKVWBeKTu2gknWUFzo4xY04hj08MpqbHSgBQgYiT3rkGggXp/ci
	FsVfXmFAW2AhirG42ywEIbNT1D2A==
X-Google-Smtp-Source: AGHT+IHLUzkgy93j93/Y457i3JDPVA/x2jz7pwHQeQNMkgQOo5iNeUyTYKEKqioqrc6ql8RXud3YDA==
X-Received: by 2002:a05:600c:3146:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-47730802c68mr141327745e9.13.1762256436466;
        Tue, 04 Nov 2025 03:40:36 -0800 (PST)
Received: from [10.24.66.43] ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755a550dfsm33200985e9.17.2025.11.04.03.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:40:36 -0800 (PST)
Message-ID: <0c3db907-7012-43c3-b7fc-36848789da52@gmail.com>
Date: Tue, 4 Nov 2025 11:40:34 +0000
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
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <aQkZtjLt6lIULffA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/11/2025 9:08 pm, Sean Christopherson wrote:
> On Tue, Oct 28, 2025, Jack Thomson wrote:
>>
>>
>> On 23/10/2025 6:16 pm, Sean Christopherson wrote:
>>> On Mon, Oct 13, 2025, Jack Thomson wrote:
>>>> From: Jack Thomson <jackabt@amazon.com>
>>>>
>>>> When creating a VM using mmap with huge pages, and the memory amount does
>>>> not align with the underlying page size. The stored mmap_size value does
>>>> not account for the fact that mmap will automatically align the length
>>>> to a multiple of the underlying page size. During the teardown of the
>>>> test, munmap is used. However, munmap requires the length to be a
>>>> multiple of the underlying page size.
>>>
>>> What happens when selftests use the wrong map_size?  E.g. is munmap() silently
>>> failing?  If so, then I should probably take this particular patch through
>>> kvm-x86/gmem, otherwise it means we'll start getting asserts due to:
>>>
>>>     3223560c93eb ("KVM: selftests: Define wrappers for common syscalls to assert success")
>>>
>>> If munmap() isn't failing, then that begs the question of what this patch is
>>> actually doing :-)
>>>
>>
>> Hi Sean, sorry I completely missed your reply.
>>
>> Yeah currently with a misaligned map_size it causes munmap() to fail, I
>> noticed when tested with different backings.
> 
> Exactly which tests fail?  I ask because I'm not sure we want to fix this by
> having vm_mem_add() paper over test issues (I vaguely recall looking at this in
> the past, but I can't find or recall the details).

The test failures happened with pre_faulting tests after adding the
option to change the backing page size [1]. If you'd prefer to
have the test handle with this I'll update there instead.

[1]
https://lore.kernel.org/all/20251013151502.6679-5-jackabt.amazon@gmail.com

-- 
Thanks,
Jack

