Return-Path: <linux-kernel+bounces-861716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB77CBF3763
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F46018851C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52CF221F2F;
	Mon, 20 Oct 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TzYHm46C"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD44B2D73A7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992581; cv=none; b=B2flMfy1EKkfE5gQ1qAWf12aRqe4Hd0C8Y25OCuUs63XFrXQQgPoRBAoxvuMT0AlpXSi7fZ4LEJDGGcclecygPEAkDWwopiqSulhOMZBqnRgCYQp0jGsjNJR2trmVU7IdrSX+AUNUeBO7gYpbjeVo1L7dxZ3B49p0nB0GEzehZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992581; c=relaxed/simple;
	bh=OHgpkAvmZ6yf/JhTQlBlLu0y0FUMUEE6N7YIxKfEsNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPCGyA2fkc2xf0M06f2HafIPFthX+eMXbmPUYBbuK6xWlWBxzi+2Qj8k9EfrolEagb9wgSgEkLUO8xO7+rnqbCqy5FGKRXakQmmPhMk5JCZuWoQ+DtzwaJoSjWNJ5lc/j1CX+7XTz4sxT23gVRAt5/PlvxDK3IizRO0ADBY7q1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TzYHm46C; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-9379a062ca8so203702339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760992579; x=1761597379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crKMvRfwVH1JxtBHbx57zrx+BGBjZHigVkm8MVwMmQs=;
        b=TzYHm46CQ3t5lyTY+PLMcv55YWHufvB5eAolJbkgarU6I2qlYQDoabS32t2JPVhyWY
         Fpuxv2n6DJZllzM81jFCYI7s3PR3PlCe19M3rsBc/u3g3Af7znrik79SKpgwHq23pgvI
         7dgfvv2FOZBf/3O1JuRcBLKHp/oSZYv1Ovjn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760992579; x=1761597379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crKMvRfwVH1JxtBHbx57zrx+BGBjZHigVkm8MVwMmQs=;
        b=O3Xwk5G8TOxQPVwODiUrjCTaRHRZyfsE3uISn8GXQ/Dkqf3hhx/bGUCquo6teLTGWb
         CgIVK94JHC36bBvJGakRcp8RfN/Bl7XIiIoFotuUn3t32lY/i2dqJIHm4FLdkE4m7R+f
         jBUYjIQ/NQvVczdguliyIkQiJ/nRga1v0r8fHhPZs7BwD7SdpCFCF1PZfCVjCkZDNjwv
         yMc7wxogES2703wHV7rYWdj9aKkUNVlKINQa/80tRupLZntFgWDDOd9JXAAtNCrAOhrB
         fsVCfJTfKJCDK1JlYEFdqzEansDk81PWYBQz7vBHlDLYmGUx6s0Zrqg69wRExPHPAY2t
         AJBA==
X-Gm-Message-State: AOJu0Yz4VMjlsPSnPQn/K6xcGOt/Tk+vP9I5fSCZVIMPMebVC2BSOVLf
	AHyJKrOgm8wTcTzRpX4lr2LcUIJhhL+x04QishEwAkxIfICPI+LRJP75JnVAS5k6fDM=
X-Gm-Gg: ASbGncsEf1jIcrtevX2IHTcdCj38ckSHZdn3GMZLcpz9TN214yumiW9mc4ea8/IVEgB
	ZJ8rJfv4FqEE1m9dMNbxq8ZZOktH9u0Ac1zIHYU5W4Wmhq3KGL4efjtuAmkBhWtaB20mIwsO4wt
	Kj3383FWlS4vE4Gi9+g7l4qUBptmGbeZ/yDI2i76TxKq4HrC/TytW7Nb1A9AYE36zBZqmXHq/Qc
	lxc+3yFOw69rPW1uLy1n/d2ruWZCj6IYifKXLEj4bcodv4PdvN63wVKimX9+JhPbwzeGquxKlmE
	/CQS72Q053eiOgWowHXuc5M2w+fb6jWnUyApybIsgv7K2V8rUKFcrgwq3Ja7aqse3H0u1aIxHqe
	HcfK3H+tZDavQDupqG3ybRAg2mh8CczM0qfyz8ipF1c6P8gV1SRhzYBlrmBjdZYLxD55T483XFy
	IXEmVoPAfznbAQRWuDJA/gAsE=
X-Google-Smtp-Source: AGHT+IFw1THLnJLq7kXvJahTmoBARR7DHZ788vuoYVuwEu86BCjQmgI8bFvULKVG/FjqioZwQmTc0g==
X-Received: by 2002:a05:6e02:12c8:b0:430:a0f7:a5b1 with SMTP id e9e14a558f8ab-430c527eb4emr197839625ab.24.1760992578882;
        Mon, 20 Oct 2025 13:36:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3314106173.63.2025.10.20.13.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:36:18 -0700 (PDT)
Message-ID: <cabc6307-b5d1-488c-920d-0c66cedffb2e@linuxfoundation.org>
Date: Mon, 20 Oct 2025 14:36:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: cpu_rmap.c Refactor allocation size calculation in
 kzalloc()
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250930092327.27848-1-mehdi.benhadjkhelifa@gmail.com>
 <10082c41-4302-4cb3-a2bf-788e59bad0c8@linuxfoundation.org>
 <84bf5902-b3e5-4d58-a2a7-f01e15cfe143@gmail.com>
 <bd60a8e5-f4df-4743-8b56-3d6127906ff2@linuxfoundation.org>
 <1263c092-d4bc-4d8f-8ef8-2706d337f4c2@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1263c092-d4bc-4d8f-8ef8-2706d337f4c2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/25 10:52, Mehdi Ben Hadj Khelifa wrote:
> On 10/10/25 6:00 PM, Shuah Khan wrote:
>> On 10/9/25 09:16, Mehdi Ben Hadj Khelifa wrote:
>>> On 10/7/25 11:23 PM, Shuah Khan wrote:
>>>
>>>>
>>>> How did you find this problem and how did you test this change?
>>
>> Bummer - you trimmed the code entirely from the thread. Next time
>> leave it in for context for the discussion.
>>
> Ah, I saw in other LKMLs that some do delete the code so I thought it was okay. We'll do next time.>> For the first part of your question,After simply referring to
>>> deprecated documentation[1] which states the following:
>>
>> Looks you forgot to add link to the deprecated documentation[1].
>> It sounds like this is a potential problem without a reproducer.
>> These types of problems made to a critical piece of code require
>> substantial testing.
>>
> 
> Ack, This is the doc that I was referencing: https://docs.kernel.org/process/deprecated.html
> I'm not sure what is exactly demanded in substantial testing.My guess was to do normal testing as I mentionned and add some fault injection to test the change in case of failure and also compare dmesg outputs.I have run selftests for the net subsystem too since my last mail with no sign of regression.Any suggestions on what testing for this case should look like instead or on top of what I did?>> 'For other calculations, please compose the use of the size_mul(),
>>> size_add(), and size_sub() helpers'
>>> Which is about dynamic calculations made inside of kzalloc() and kmalloc(). Specifically, the quoted part is talking about calculations which can't be simply divided into two parameters referring to the number of elements and size per element and in cases where we can't use struct_size() too.After that it was a matter of finding code where that could be the problem which is the case of the changed code.
>>>
>>> For the second part, As per any patch,I make a copy of all dmesg warnings errors critical messages,then I compile install and boot the new kernel then check if there is any change or regression in dmesg.
>>
>> This is a basic boot test which isn't sufficient in this case.
>>
>>> For this particular change, since it doesn't have any selftests because it's in utility library which in my case cpu_rmap is used in the networking subsystem, I did some fault injection with a custom module to test if in case of overflow it fails safely reporting the issue in dmesg which is catched by the __alloc_frozen_pages_noprof() function in mm/page_alloc.c and also return a NULL for rmap instead of wrapping to a smaller size.

Why not a write a test for this then?

>>
>> Custom module testing doesn't test this change in a wider scope
>> which is necessary when you are making changes such as these
>> without a reproducer and a way to reproduce. How do you know
>> this change doesn't introduce regressions?
>>
> My custom module testing specifically tested the change in case of failure which is what the change is for in the first place.The change which deems to be simple in the documentation since we are just wrapping calculations instead of using operators,is just to safe guard calculations that are made inside of kzalloc() so that no unwanted behavior is produced i.e in case of overflow.As I mentionned above,I tested regressions by running selftests for net subsystem with it showing no regressions on top of fault injection mentionned.
> I would like to have more guidance as to what I could do to have more robust testing in this case.> thanks,
So as you say this is a potential overflow, can you explain what
are the cases where you would run into this?

thanks,
-- Shuah


