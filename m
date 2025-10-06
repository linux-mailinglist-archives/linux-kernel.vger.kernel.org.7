Return-Path: <linux-kernel+bounces-843062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E85ABBE55C
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49D364EE5A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E232D5941;
	Mon,  6 Oct 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HQ+UF+gs"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8113244661
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760881; cv=none; b=kfCbIh78Bto3mrWVsBj86JTATDDX/Jr7rYOgmpJ0HLvdrBTaLQC/w/Fb+vYyyclKfvmZxzBgT62yP2nmSQFnqeA5cunGD0BOBKKRphvZMOX76cPwStOpYURuzoKcYe9L8G11vTGYWL9RlpGjI0VAkZV8n7baSIb4q0e/tbbj0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760881; c=relaxed/simple;
	bh=EHxWT32YymNsXpB9p3S6BjTZeoLPvi+pHdnXIyHTHFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZrlBFxLyLR4QM0XtbRS4EOIcPuB8PAszzHq2rSE+EIbLLsLcFc6qI4p51IsTTDiNRtbukt97LYoB6wNZ6Vu92f8GBtAiczdaUqVeRxNJrq6f1UerWiLRpLV70So22IoS1qbaPI1dxojcAMYIIYmLlIwaRzPnGKIUQ5mSByhZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HQ+UF+gs; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-91f6ccdbfc8so275581739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759760878; x=1760365678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qej3wWBL+FUIrH9L2ourIRG5geQ59K2a1PUZ1/C7pZs=;
        b=HQ+UF+gs8ssJgQSNT2G7uL6VhAJhZv+vgtUW0DyO7jyEoez9NS7t6U/W/CGIOs1aC9
         6MnfJJl62si5Czg4LDW/Mf6P/RpvW6dHCMnnxdZXhnfOdP+0SvHdkJoT+sCgWghUtUbE
         WsdJj8EKYRmLEDC5fdbfFXYwufUXR+OB1KZhPA2HraaOt/cDl55v5oa+cFwdu8zqAAwP
         V0PTiuYismL5lmiYz703Tmyui4Fj0UYapwDAIQYVHoK/IQUgQn8Xhcp+v5HZ2SJlIBfu
         /fv9V6Mhk4rotU/gKz8u4zLxmfOJz6AI6R5+NjVfm3mT02o/ts8UVHWpgE8tZ526YRxa
         Ns3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760878; x=1760365678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qej3wWBL+FUIrH9L2ourIRG5geQ59K2a1PUZ1/C7pZs=;
        b=biurrj/C9F9YswD2im/jxzUDC9vQEu/naPaVhJsOri3Ts+xBdM5JZXbPn2M5DWSuJg
         SieEGiFcvPkcs/QbdyqUwJohtMk4cJq5XW0OMkYP7+XKikXjU8OvhSLoeO9pwtF8nKcX
         HGe0g04LVL2IP/q4XJYsUewMShjce2MDxdCF+5MG/sCdhUeaoTu2iYGVXJ78QrSfeokG
         NPSEjoH0rI/nTN7m6Xs1iEu2UwRxu1slFs5Wi96Ewj7rDHD2SSvWQdBprZuNeaVoDfW1
         9CVHHCJJBsHqc4LZIhHuiI7d1EAy0utuG6F+z8J4rQ7fU95r1qkU7whqv/uOYHKgCt9d
         hRSw==
X-Forwarded-Encrypted: i=1; AJvYcCXpECYQmhX/z9qtfTeVJhTWhf/vP0CnatgNkvjAtbXzzN0nQRYJ6ufjzxZQ7UHcx2bSoC2KnvAfEf9ApDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjM826aX/maVy9+819liWLA3lhRUcqX1i9T7EXViw88pV4bbRB
	ySagPt+3R7RlPLW/cm2x7/J0apmWY+Dxdonpf+7rMPC8qgdRDKpC786c+/OwnHXGOq0=
X-Gm-Gg: ASbGnctOJ5B0Ue2pc/fDO7y3C8XD3O401QpYvr3CRclelfU1ftmctVk1FwmH6pxEqjo
	+SpbRBDHeQLGABAZPu9CimZz9LbJ9pDEFgVtWzBfUqYL1x+c7DICGjppP/Y3ExP1RINt8IJG4MS
	q0qmCBL/Bs9JVsV1oBqIHjbL+mcbA2foCv4KAWaXZ1LKmJjbwkK/cumwAZ0tzYx/1gmtpbCHJID
	OQjMql95TyvETaDISoaS8O8BKprayaUqRDyQogqE9Gb3l5hgDseVE1QCSRW6PstmRWqsEw3gquR
	+R1BCn/SYiGr+atJFh9K129X++oa9WwvfouXaBfLcZR9x9OnWsT7ohQPJV3r74afLDCb6XPFTbt
	oLNcQoT+R9Z6QOa99Qb446IcuPG9jopP/ATlThyAqlD4I
X-Google-Smtp-Source: AGHT+IEWreHZclFRliJ16PSZcdV1rDGjySecvtqwp6tYvpa+GiYIMV7QH0kygTLh9fY3CyZCr8D8zQ==
X-Received: by 2002:a05:6602:14d3:b0:90a:ce21:ae1e with SMTP id ca18e2360f4ac-93b9696026fmr1773971039f.5.1759760877800;
        Mon, 06 Oct 2025 07:27:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a87cad2cesm480918539f.14.2025.10.06.07.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:27:56 -0700 (PDT)
Message-ID: <d23fa119-c1df-4861-99e2-c35c1214baa1@kernel.dk>
Date: Mon, 6 Oct 2025 08:27:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN"
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, Sam James <sam@gentoo.org>,
 "David S . Miller" <davem@davemloft.net>,
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 sparclinux@vger.kernel.org
References: <20251006100226.4246-2-glaubitz@physik.fu-berlin.de>
 <d78a1704-31dc-4eaa-8189-e3aba51d3fe2@kernel.dk>
 <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
 <a80a1c5f-da21-4437-b956-a9f659c355a4@kernel.dk>
 <e6a7e68ff9e23aee448003ee1a279a4ab13192c0.camel@physik.fu-berlin.de>
 <cef07e8f-a919-4aa1-9904-84b16dfa8fe6@kernel.dk>
 <5b3caa0e218dd473c8871c1b1f09a8dc1c356f1e.camel@physik.fu-berlin.de>
 <ecb74c6c-8de6-4774-8159-2ec118437c57@kernel.dk>
 <6ed7112cb4f338ba02d9ab67c14e7a3af4afbca0.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6ed7112cb4f338ba02d9ab67c14e7a3af4afbca0.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 8:12 AM, John Paul Adrian Glaubitz wrote:
> On Mon, 2025-10-06 at 08:03 -0600, Jens Axboe wrote:
>>> To be fair, the sunvdc driver is fairly old and I'm not sure whether these
>>> tools already existed back then. FWIW, Oracle engineers did actually work
>>> on the Linux for SPARC code for a while and it might be possible that their
>>> UEK kernel tree [1] contains some improvements in this regard.
>>
>> Requeueing and retry has always been available on the block side. It's
>> not an uncommon thing for a driver to need, in case of resource
>> starvation. And sometimes those resources can be unrelated to the IO, eg
>> iommu shortages. Or this busy condition.
> 
> I see. Makes sense.
> 
>> But that's fine, it's not uncommon for drivers to miss things like that,
>> and then we fix them up when noticed. It was probably written by someone
>> not super familiar with the IO stack.
> 
> FWIW, Oracle engineers actually made some significant changes to the
> driver that they never upstreamed, see:
> 
> https://github.com/oracle/linux-uek/commits/uek4/qu7/drivers/block/sunvdc.c
> 
> In particular, they added support for out-of-order execution:
> 
> https://github.com/oracle/linux-uek/commit/68f7c9c17fb80d29cbc1e5110f6c021f8da8d610
> 
> and they also changed the driver to use the BIO-based interface for
> VDC I/O requests:
> 
> https://github.com/oracle/linux-uek/commit/4b725eb64cc10a4877f2af75ff3a776586f68eb7
> 
> Could you review these two changes and tell me whether these would
> actually implement the changes you would want to see? I think the BIO
> layer is a generic interface of the block layer in the kernel, isn't
> it?

Moving lower down the stack to use a bio directly is not a good idea,
it's in fact going the opposite direction of what we'd like to see in
the storage stack. And it would then mean you'd need to implement your
own internal requeueing and retrying.

These are the kind of changes that happen when development is done and
changes aren't submitted upstream. It's unfortunate drift...

>>>>> For now, I would propose to pick up my patch to revert the previous
>>>>> change. I can then pick up your proposed change and deploy it for
>>>>> extensive testing and see if it has any side effects.
>>>>
>>>> Why not just test this one and see if it works? As far as I can tell,
>>>> it's been 6.5 years since this change went in, I can't imagine there's a
>>>> huge sense of urgency to fix it up that can't wait for testing a more
>>>> proper patch rather than a work-around?
>>>
>>> Well, the thing is that a lot of people have been running older kernels
>>> on SPARC because of issues like these and I have started working on trying
>>> to track down all of these issues now [2] for users to be able to run a
>>> current kernel. So, the 6.5 years existence of this change shouldn't
>>> be an argument I think.
>>
>> While I agree that the bug is unfortunate, it's also a chance to
>> properly fix it rather than just go back to busy looping. How difficult
>> is it to test an iteration of the patch? It'd be annoying to queue a
>> bandaid only to have to revert that again for a real fix. If this was a
>> regression from the last release or two then that'd be a different
>> story, but the fact that this has persisted for 6.5 years and is only
>> bubbling back up to mainstream now would seem to indicate that we should
>> spend a bit of extra time to just get it right the first time.
> 
> We could do that for sure. But I would like to hear your opinion on
> the changes contributed by Oracle engineers first. Maybe their
> improvements are much better so that it might make sense to try to
> upstream them.

Won't help this case, and it's actively going the wrong direction
imho...

-- 
Jens Axboe

