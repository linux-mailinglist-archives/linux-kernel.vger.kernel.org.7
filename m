Return-Path: <linux-kernel+bounces-787703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC8AB379FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDFB7A46C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFC830BBA0;
	Wed, 27 Aug 2025 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hw3nvmqY"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E828E7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756273773; cv=none; b=OaWyMOm6KEEuQSejd09o6mFJ8adyAe1qch3bgQzNTlNXXuH0LRv04PinHpepR1uSjBS2yUEr2StWwzs4XAfvXqrYeEhy7wJeJ0khRuPxvw1Qst/Ku7ae2Qs05N52eJL4mwCn2UrIxgiZmOrUJj6wv9DzCNKTpkovsqbKjt4e7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756273773; c=relaxed/simple;
	bh=pUJmrIA2x5LczKe5rphw2E8dq4urzGNQhhsVJS1L7BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBUIyjrFtmOVhs3XZ7nDxyC1bbv/SeCU4udaqTYYhtCti2sIsAL/LnFH5/GSYDu43p/tqOE9IxwvkeLm728+h4NspcbuoU7oAkdtPhiweTtXWOsNB9vA5rtH3zBN3saFli8NCMAv0WNRFi3X1NPXNcHnTSNxVypGaGGaRHstobE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hw3nvmqY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-771f3f89952so514540b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1756273771; x=1756878571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcHF6RnbmpTEQbStJ3Ge4aHFj+SeTRpsf2Mr2iXfDM8=;
        b=hw3nvmqYNdUSWFIVZBT2gh0NSpOWoBTO7T1t4275kyxqIi0NlKl3HzMn+EMyGEq5X9
         OpDcz9qdbttpwNNxVLUh05F8nu9QVSOiQI6xALC344lSQjagRPrDPWJ9qjZKfdjvxKZA
         nA4EUToAfXEu3V37bqA5CusJ4oyv5idntHL6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756273771; x=1756878571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcHF6RnbmpTEQbStJ3Ge4aHFj+SeTRpsf2Mr2iXfDM8=;
        b=gFBp4BW1rX7Mv2zg+23x9Khspk7cbEzAL5F0U9Wi4QSMvAHKwUYHcpDp1TfAJafSGw
         zXQWQ2NtQmaLyGr/dUPicld2gh7OvihYwNlfU3wrxvF/sqkfmjD08WhoPJkw+SH8yBlz
         IWm7b702lsKiZ3h/F1iiAh6PcLO7GhpoV98UVlPcdFx0b/TelZoAe3z+qYntUTMId1CE
         Ro4WXdan76qN9H7Ktmxq4vuIGpQdD1uShIPx9yQ7XkWP9cWLgGbhXh3YSb2ecrJ/nPrj
         S55loHEBj99wM1W7fgQOXnpa60Ogj7OcXgLy4Z+m/QN3g2D3KBWT0KMmbdyqRvHZf+jT
         ukfA==
X-Forwarded-Encrypted: i=1; AJvYcCU1NErR7C/U73fx9bkTPMbAukW+ndTz83lUPmVCuMlgZDjNHGN7Lzyr90HAex0p3Q50+8wjZJJkZY9fGWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo7vbOfZH5x7Xrhv8jzxfrAG551n0MEb3HFjTfjueqyfMb4+Oa
	idS+JF8o3x8GtanpUNkxJZx9wn03Fzqx9Sr/OEQqIRvEIyo4JlVIGXVjPCET476m/Ys=
X-Gm-Gg: ASbGncvpF4UFCB1HJiRZkKvZjY13VizHmnw432WUA2jjkWf6j4XLNUgobjHDyiVN3p2
	Oir0s8sNhXIQaFnnVb+m4qA8sygOWuhostPaKwRstmmoq7JoSYcXzYub4u0S9gl7yEBPQKQU3Vy
	McL0WgqS+VeyNveWqw4Vsg0+qCnZ07j6iLkXnrUa4j1jzSOU5ncYgHJjA/gwUwgxzOuYFF4PU14
	B2TvBp3m40aspgjwpN4FvJMAIBuaLDJ7BHm1teDrMononGYp9uuZEZHLGtWuDR29DTWX/hZvy9R
	2ebtU8PInL21AkK75fNyuFH8bE2n6sfkVY74sHJwGJ3phpFJS/a9RRFTVCxX7oRTN3X5416Fjxs
	+A7xfTbLEAGjKpAV03NI5VBPGFlDWtZrW6atgjJfeHAdBsiRelMA+Zd1ki6dPyxBN4TDQzDr20x
	yP3cVsdrRxZjJRhQ==
X-Google-Smtp-Source: AGHT+IEPRjnzRJoy3RI7aBDNF9oE7mN9+D8p1oqa7z508XWwunVdVtcVLS9rgz2/V4+0jMlyan7bKA==
X-Received: by 2002:a05:6a20:7490:b0:243:7e4e:3cdd with SMTP id adf61e73a8af0-2438fad29d0mr5907065637.16.1756273771075;
        Tue, 26 Aug 2025 22:49:31 -0700 (PDT)
Received: from ?IPV6:2405:201:c017:f074:2f08:3cb7:de48:e39a? ([2405:201:c017:f074:2f08:3cb7:de48:e39a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fbca8d4sm976356a91.28.2025.08.26.22.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 22:49:30 -0700 (PDT)
Message-ID: <b8dbb85b-124b-4d25-b734-069809240e81@linuxfoundation.org>
Date: Tue, 26 Aug 2025 23:49:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kunit-next tree
To: David Gow <davidgow@google.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Marie Zhussupova <marievic@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250818120846.347d64b1@canb.auug.org.au>
 <1befd7ab-f343-450f-9484-0cef21fe2da8@linuxfoundation.org>
 <CABVgOSm2_FGfjQpUBttuUH5ZrMEqnaGkYVkN6N96wX7Qs8EE2Q@mail.gmail.com>
 <4d5bad8a-6afa-4284-8f78-b52e2cfedbf0@linuxfoundation.org>
 <CABVgOS=groSq6Dcdbb_PxFwikQTDodhA7gCAJBvv3jWzk8jrZQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOS=groSq6Dcdbb_PxFwikQTDodhA7gCAJBvv3jWzk8jrZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 03:24, David Gow wrote:
> On Tue, 26 Aug 2025 at 10:15, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 8/19/25 01:44, David Gow wrote:
>>> On Tue, 19 Aug 2025 at 00:32, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> On 8/17/25 20:08, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> After merging the kunit-next tree, today's linux-next build (x86_64
>>>>> allmodconfig) failed like this:
>>>>
>>>> Thank you Stephen. I did a allmodconfig build on 6.17-rc1 base - didn't
>>>> see the error.
>>>>
>>>> Marie, David, can you take a look this. Looks like conflict with drm
>>>> in next?
>>>>
>>>
>>> Thanks, Shuah. I've managed to reproduce this with:
>>> ./tools/testing/kunit/kunit.py run --arch x86_64 --kunitconfig
>>> drivers/gpu/drm/xe
>>>
>>> These patches fix it (and a corresponding drm/xe test failure):
>>> https://lore.kernel.org/linux-next/20250819073434.1411114-1-davidgow@google.com/T/#t
>>>
>>> Ideally, they'll be squashed into the corresponding patches, as
>>> otherwise there'd be some temporary breakage during bisections. I can
>>> squash these into the original series and re-send it out if that works
>>> best for you.
>>>
>>
>> David,
>>
>> Please squash them and resend - also I see a kernel test robot
>> error in patch 1/2.
>>
>> I was going to squash them, but I saw the kernel test robot error patch.
>>
> 
> Thanks, Shuah.
> 
> A v2 of the fix series, with the kernel test robot error fixed, is
> here: https://lore.kernel.org/linux-kselftest/20250821135447.1618942-1-davidgow@google.com/
> 
> I've also squashed the fixes into a v4 of the original series here:
> https://lore.kernel.org/linux-kselftest/20250826091341.1427123-1-davidgow@google.com/
> 

I applied these to kunit next and ran test:

./tools/testing/kunit/kunit.py run --arch x86_64 --kunitconfig drivers/gpu/drm/xe

Looks good. Hopefully next is happy now.

thanks,
-- Shuah



