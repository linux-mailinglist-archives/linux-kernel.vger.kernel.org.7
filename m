Return-Path: <linux-kernel+bounces-843101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A34BBE685
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751CF1895E39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E8B2D6605;
	Mon,  6 Oct 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rTv35cvP"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47C2D594F
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762359; cv=none; b=p1ilD9ITrdJGEAZC+l8rK5khHxImR4aafhGlk8gsfWXs7psbMtenwaaBCaLu880Myg/HEvOq4ywoPgnYmEvq7BtktRCBAyxvWTrccey7xTvAPRsOyjVHR+8u46QYQwwCNlHRHyNusIKgVIoJELyXOBGwWCGwa5p4+ByC99IVhuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762359; c=relaxed/simple;
	bh=mFLE8Eki8UEtgO9xXuNzCmZEcwPiCVe2BIsOrzsAxI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBYOOEisYtcjy1YyrZI/buLkG38T6l3Ey+gbKUDjnYL/yxFZDojPMaKup32YhPmbC/uBysqI19JGZAc8fjlA1+jwZ/+O0oGsT1+UJQ3rWQ4DaY935HFK1j6NfdmQr6AgQgJMduGICmPQxP5Al6zMN+OVOJUrLTyDvWxkC1mN89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rTv35cvP; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8ca2e53c37bso450881739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759762356; x=1760367156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlbR/hLzOsQLmDn5DZrzY4KfozQVDsskYfJwhYrKehw=;
        b=rTv35cvPOF3gl1PlI6nlFqC5rHqzVJmdTp44CYywF08ZDLvizbaBbmvarH99bAn3If
         k5+S5uzq6pJmJI8Ep9fyM5RNnvWymHhqWVXhHfkodEQopG5bLQdaA9EdJ7Bp9S4qT1fb
         +D5ftXAdAVnaD8o0bofA5jIBeqT2uW3JvJHCflRMCWcFRAEBOfuAonTfgA+PHuARSHEO
         jsXLG2LAvOm4R4lU3UPH3P59vAb4ym2V9WnNxnvkwkysPadb6MlTSmefvVjSQxWKKtcE
         XFDYD3+T4zCzAe6fbAPfldIvqNTGPKlhvgkKIQKc+BccLDMSSjCfzWWS8awmsmPgWo2M
         8HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759762356; x=1760367156;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlbR/hLzOsQLmDn5DZrzY4KfozQVDsskYfJwhYrKehw=;
        b=Rzcnbpr3SmFH4tZTRGfL9BjZs0j+PMxlOhdAPRIRyWBXDeoFxAuha+u7O/b5zxu5zt
         sxvAbpm6GIYFveybGqdSC8DsJQKyIPdTnSaG1Li7LsRlQ8zqPt21+TlmZGjNvXBo7Td4
         J1ayGDMntm71sxlCLeRCBoPly0jraWm+BUWq/f0d6Bz+v2xsSu3A0pGvmLZhG1NxKomr
         aWE6ECBEcwXfOFGyP+ngUFwWfsSmaW8GBBkB8pEkrRwga4+oEtXRUTfbMJArrXSqGSJf
         0hzBe59HKzOOz4R3lyLtFXB5jyLbmUzktqEuw+r6cJ/jCfNYNYlM0bi5/o5vDmAZ3g45
         QCnA==
X-Forwarded-Encrypted: i=1; AJvYcCXl4nEtPd8eDUABHSCDvt5etyyeMPb8Bawxhhgq44z3ztm79W4njCrT+yShrxW4VReOZHntUW/HU99R8VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjMfXXmnmVD4nTT9LJgXe45x4soT4KO2CvGBznnZliVcOePhxN
	YKDoZzsF4uaGgBTdOM6PLFIeeYUqCxCPS9KVus4xiA3oJ5iLa93ylVgte2qdet/xspo=
X-Gm-Gg: ASbGncu5+JLQVRuYsvqlpTMo2BstlePsr3CQwtHnZdVhbs0zh20TcZS3s3BE+CwlnEC
	JeUJlAF7ifk2SM4tHeKsAZxOavuoia2VtE1nMomp6t8awcoq2rQhMsWdOzUhndsFxoIP86jDQEU
	hqWKqxxLbJ9m56oxl1QIsGotEnPB9ruPK1RWUblkrbFS6v7Ekru4GIlDark/zFfXzq7+jVPlh64
	MeoYA9RJfRjl70eo6zfMV/jyUKOxGZhOOKlP6/zYCymgQiqqF89MwfhQcWwllwRliar8jF5DsKn
	fWEhYjT0uF+RSpu45z21BbM6iEn5sUrdpfSXtYo5Dgb9CZXvtq/fsdcUoDpIztAdEWhDGCVERp9
	oLVx6bMqRUAoCA2spFDbnRY1ikUt3+Fwpxx/42rIKutJ/
X-Google-Smtp-Source: AGHT+IEJN7EykLM4II7Nc1RZBJ1wPHjey+isWsfIbGWEkw9SfJz+SZYeKca+xUOdqaMCUV6s4N14AA==
X-Received: by 2002:a05:6e02:1a0d:b0:42e:729a:4b0d with SMTP id e9e14a558f8ab-42e7ad6e802mr163997875ab.20.1759762350058;
        Mon, 06 Oct 2025 07:52:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5e9eb49fsm4975250173.1.2025.10.06.07.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:52:28 -0700 (PDT)
Message-ID: <24f8b266-f17c-4909-b43d-8ab05721c5d8@kernel.dk>
Date: Mon, 6 Oct 2025 08:52:27 -0600
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
 <d23fa119-c1df-4861-99e2-c35c1214baa1@kernel.dk>
 <576197870bdf21ea97559a1d84869fdcb9535156.camel@physik.fu-berlin.de>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <576197870bdf21ea97559a1d84869fdcb9535156.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 8:48 AM, John Paul Adrian Glaubitz wrote:
> On Mon, 2025-10-06 at 08:27 -0600, Jens Axboe wrote:
>>>> But that's fine, it's not uncommon for drivers to miss things like that,
>>>> and then we fix them up when noticed. It was probably written by someone
>>>> not super familiar with the IO stack.
>>>
>>> FWIW, Oracle engineers actually made some significant changes to the
>>> driver that they never upstreamed, see:
>>>
>>> https://github.com/oracle/linux-uek/commits/uek4/qu7/drivers/block/sunvdc.c
>>>
>>> In particular, they added support for out-of-order execution:
>>>
>>> https://github.com/oracle/linux-uek/commit/68f7c9c17fb80d29cbc1e5110f6c021f8da8d610
>>>
>>> and they also changed the driver to use the BIO-based interface for
>>> VDC I/O requests:
>>>
>>> https://github.com/oracle/linux-uek/commit/4b725eb64cc10a4877f2af75ff3a776586f68eb7
>>>
>>> Could you review these two changes and tell me whether these would
>>> actually implement the changes you would want to see? I think the BIO
>>> layer is a generic interface of the block layer in the kernel, isn't
>>> it?
>>
>> Moving lower down the stack to use a bio directly is not a good idea,
>> it's in fact going the opposite direction of what we'd like to see in
>> the storage stack. And it would then mean you'd need to implement your
>> own internal requeueing and retrying.
> 
> I looked at the virtio_blk driver and that seems to confirm it. There is no
> use of the bio interface either, so I guess we should not pick up this
> patch.

I'd be very hesitant to pick anything up that hasn't been posted and
included upstream...

> What do you think about the out-of-order execution? Would that make sense
> to upstream it? Does it look reasonable?

I have no opinion on that, there's not even a description of why that
change makes any sense. Sorry but I'm not going to waste my time
reviewing out-of-tree code, it's just not a very useful thing to do. If
the changes get submitted upstream for review in a suitable fashion,
then they will get reviewed.

>> These are the kind of changes that happen when development is done and
>> changes aren't submitted upstream. It's unfortunate drift...
> 
> Well, the problem here is that Oracle stopped working on Linux for SPARC
> abruptly, so many of their improvements were never sent upstream and did
> not see any reviews which would have caught this.

And to be frank, the changes you referenced also look pretty incomplete
and would not pass upstream review. I guess they are dead in the water
at this point, unless someone else picks them up and polishes them into
something that can be sent upstream for review.

>>>>>>> For now, I would propose to pick up my patch to revert the previous
>>>>>>> change. I can then pick up your proposed change and deploy it for
>>>>>>> extensive testing and see if it has any side effects.
>>>>>>
>>>>>> Why not just test this one and see if it works? As far as I can tell,
>>>>>> it's been 6.5 years since this change went in, I can't imagine there's a
>>>>>> huge sense of urgency to fix it up that can't wait for testing a more
>>>>>> proper patch rather than a work-around?
>>>>>
>>>>> Well, the thing is that a lot of people have been running older kernels
>>>>> on SPARC because of issues like these and I have started working on trying
>>>>> to track down all of these issues now [2] for users to be able to run a
>>>>> current kernel. So, the 6.5 years existence of this change shouldn't
>>>>> be an argument I think.
>>>>
>>>> While I agree that the bug is unfortunate, it's also a chance to
>>>> properly fix it rather than just go back to busy looping. How difficult
>>>> is it to test an iteration of the patch? It'd be annoying to queue a
>>>> bandaid only to have to revert that again for a real fix. If this was a
>>>> regression from the last release or two then that'd be a different
>>>> story, but the fact that this has persisted for 6.5 years and is only
>>>> bubbling back up to mainstream now would seem to indicate that we should
>>>> spend a bit of extra time to just get it right the first time.
>>>
>>> We could do that for sure. But I would like to hear your opinion on
>>> the changes contributed by Oracle engineers first. Maybe their
>>> improvements are much better so that it might make sense to try to
>>> upstream them.
>>
>> Won't help this case, and it's actively going the wrong direction
>> imho...
> 
> OK, so your opinion is then to add the patch that you proposed on top
> of what's currently there in Linus' tree, meaning adding some code
> that will requeue requests once the retry limit has been reached?

Right, the patch I sent is against the normal upstream tree.

> Can you maybe post a proper patch then which I (and others) could test
> and then hopefully add their "Tested-by"?

Sure.

-- 
Jens Axboe

