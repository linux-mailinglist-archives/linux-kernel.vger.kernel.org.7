Return-Path: <linux-kernel+bounces-843016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26711BBE368
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C17E1892853
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2642D29AC;
	Mon,  6 Oct 2025 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TVe7Z3Od"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CA223339
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758388; cv=none; b=t5xi662rZDSL0dRmGDbX4QnoGzM7h7/JBI0UeL6GNRZ8NEVMEW8UJPZyejm74wVTDBIsSYi07WLPE6vC/zYcRCZzixo5FCB6Qos/CwYIve1fLstz0FAWhFs6zh2GsGXUuDlXc5Iv5SM9GY6bADHFe89qtR3YZenMWjrpTgCBpTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758388; c=relaxed/simple;
	bh=k8OGcIl6xM111ga3scVq8EniMirQnZBx7DtYgJnq1zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQIGuNu8r2E3fKjMOeKhfddgEAfpZDInvK/yH/LdYqgUeYc/03ORrcPeerZv2XN6i1jTGZgv47MMi2gDBRXbetoczuMJlUsx2oVgx06uv8cIrLd0fPya1xiTgg/qnUd/j5kViTx6UB2mxR5U0+EWzOSemFvxaEL+lNXK706IRPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TVe7Z3Od; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-93b9022d037so187486739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759758384; x=1760363184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vl94wiObNp5v9aBc4+5g0hzUE6kvt1gCT0TmryQiUaI=;
        b=TVe7Z3OdL59Pmms6Z1wP/zYRVsbszuwlzBO1SU687VfZWA2cnmJrkMth7P3w5LJVXE
         AEQ4p1zTqVCCMNkP1CF523BnTLqNZMQhXfK5okjF4jhRQ6VMjAI19C5/kVLamvx4F7e9
         Kxte5jdQa4FrUz7MoXviwkGyJb4a2suqJSipw6Mvz/RYaSHTjyNP8FUfizy2sFZTdwmX
         KpO5HrlkEnqRNJk4s2DBFBvzBQzUS65UZRqE03L1FSOVlvLHq2WZYihsmR7VjsRPcLig
         enrcXs9oZKISWA1uXn+LEmifHUHN21j5pKoKt/WKXyNLF+PeN59yizuwEN2E3yJL8F1/
         8WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759758384; x=1760363184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vl94wiObNp5v9aBc4+5g0hzUE6kvt1gCT0TmryQiUaI=;
        b=QHJ7F0PHJoO/e6/VPK7+eYzOZpRlonEQK/tMhne07ImFSD65XI0inIYzxeE7Vm/7L+
         hf2p+h/A67K+o5scszkJeF30pfjQ2cgbvya0I4CZ3PblzqcYpo8Fy88P50A1G8yfHuNn
         5wT/jdr/jUXUkghfUgzCwW9EfGwrCz3v8DxXK2Ae2pXSHtFWIq8nB1EaduBlg2/A9Y1t
         sfE+mQDJL9wJJ5RP7Pf9MaVAVJoP6OWC05oX4BC+WucQ3kzeWijGEJVnhuSIA/WMWHRe
         8vIHuiev7eK4FTA/rUNKgenuJxWx19FAMZFmu7osI1A02L1IaB4uCwzHApJUKawwkkM0
         cq9w==
X-Forwarded-Encrypted: i=1; AJvYcCXfqrJvtXhb4abqngOPSSfiiglNC8OthiMP7NQEj9dhglx0J29zQYAf2IUYoNApitSsuogpDTKSxKX8JW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx73me+qUqRmjPOnDhIdod4PQRgWN4WGQicbEsDlxWjAtV8ARmW
	hFu1LSVImqAyWHgchxF8XQpTOpdbXUAqjPH0WaVfgPlZ/yCP2D/BtQBVYkVn6NaPA+A=
X-Gm-Gg: ASbGncvENMwwebgGG/IvhCQ7X/8fgMy9wazX60Y+fycBa0UM8RXljkmj6A4yw6wx7yj
	Me2rPxwSMYeXuwMciD4vZYmJ24+gFN1Ku7WR3BeuoxBYcFbJ/WLBH79n0fPw3ropnF3nRcfBwh0
	wyUUUJapySLSqVs5GO/XnMaOlBlbWdBSynqLmfm3RgwVJpCmfBl9jtrXFnMZAlr2y1KvRjx6tdC
	BnRsCKrQgwnhJoefhEPrD6gP2ee+Q2/bbPklnOzn5/YhBgv0wnxwqiQSbgJShIspq5Sj+gYRQOA
	auvojjYrV/KoSp4sh6WGDpbmyiq2IIVCGs1uJCFlpbVcVsofOUtmPc8LqsrGlJhNELhcFJXZlnf
	OqnJEQciHDi40+HfcOPJnivL+ji44q4EalTshbNah9cjCRnfzaRSWalA=
X-Google-Smtp-Source: AGHT+IHH8sxyQOMlbr4/OFDa1GITi3nK1zCJw09BsdehtgJxGsIR1A9r+x+AWjZd6uum6Rns+ryWnw==
X-Received: by 2002:a05:6602:3c3:b0:922:6c20:45ef with SMTP id ca18e2360f4ac-93b96977bdcmr1954185739f.7.1759758384148;
        Mon, 06 Oct 2025 06:46:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a88960692sm505123739f.20.2025.10.06.06.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 06:46:22 -0700 (PDT)
Message-ID: <cef07e8f-a919-4aa1-9904-84b16dfa8fe6@kernel.dk>
Date: Mon, 6 Oct 2025 07:46:21 -0600
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e6a7e68ff9e23aee448003ee1a279a4ab13192c0.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 7:34 AM, John Paul Adrian Glaubitz wrote:
> Hi Jens,
> 
> On Mon, 2025-10-06 at 07:19 -0600, Jens Axboe wrote:
>>> The problem is that giving up can lead to filesystem corruption which
>>> is problem that was never observed before the change from what I know.
>>
>> Yes, I get that.
>>
>>> We have deployed a kernel with the change reverted on several LDOMs that
>>> are seeing heavy use such as cfarm202.cfarm.net and we have seen any system
>>> lock ups or similar.
>>
>> I believe you. I'm just wondering how long you generally need to spin,
>> as per the question above: how many times does it generally spin where
>> it would've failed before?
> 
> I don't have any data on that, unfortunately. All I can say that we
> have seen filesystem corruption when installing Linux inside an LDOM
> and this particular issue was eventually tracked down to this commit.

Right, I would imagine that would need to be collected separately. But
if we can get away from the busy looping, then I don't think it's too
interesting.

>>>> Not that it's _really_ that important as this is a pretty niche driver,
>>>> but still pretty ugly... Does it work reliably with a limit of 100
>>>> spins? If things get truly stuck, spinning forever in that loop is not
>>>> going to help. In any case, your patch should have
>>>
>>> Isn't it possible that the call to vio_ldc_send() will eventually succeed
>>> which is why there is no need to abort in __vdc_tx_trigger()?
>>
>> Of course. Is it also possible that some conditions will lead it to
>> never succeed?
> 
> I would assume that this would require for the virtual disk server to
> not respond which should never happen since it's a virtualized
> environment.

Most likely, yes.

> If hardware issues would cause vio_ldc_send() to never succeed, these
> would have to be handled by the virtualization environment, I guess.

Yep, it'd be a bug somewhere else.

>> The nicer approach would be to have sunvdc punt retries back up to the
>> block stack, which would at least avoid a busy spin for the condition.
>> Rather than return BLK_STS_IOERR which terminates the request and
>> bubbles back the -EIO as per your log. IOW, if we've already spent
>> 10.5ms in that busy loop as per the above rough calculation, perhaps
>> we'd be better off restarting the queue and hence this operation after a
>> small sleeping delay instead. That would seem a lot saner than hammering
>> on it.
> 
> I generally agree with this remark. I just wonder whether this
> behavior should apply for a logical domain as well. I guess if a
> request doesn't succeed immediately, it's an urgent problem if the
> logical domain locks up, is it?

It's just bad behavior. Honestly most of this just looks like either a
bad implementation of the protocol as it's all based on busy looping, or
a badly designed protocol. And then the sunvdc usage of it just
proliferates that problem, rather than utilizing the tools that exist in
the block stack to take a breather rather than repeatedly hammering on
the hardware for conditions like this.

>>> And unlike the change in adddc32d6fde ("sunvnet: Do not spin in an infinite
>>> loop when vio_ldc_send() returns EAGAIN"), we can't just drop data as this
>>> driver concerns a block device while the other driver concerns a network
>>> device. Dropping network packages is expected, dropping bytes from a block
>>> device driver is not.
>>
>> Right, but we can sanely retry it rather than sit in a tight loop.
>> Something like the entirely untested below diff.
>>
>> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
>> index db1fe9772a4d..aa49dffb1b53 100644
>> --- a/drivers/block/sunvdc.c
>> +++ b/drivers/block/sunvdc.c
>> @@ -539,6 +539,7 @@ static blk_status_t vdc_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  	struct vdc_port *port = hctx->queue->queuedata;
>>  	struct vio_dring_state *dr;
>>  	unsigned long flags;
>> +	int ret;
>>  
>>  	dr = &port->vio.drings[VIO_DRIVER_TX_RING];
>>  
>> @@ -560,7 +561,13 @@ static blk_status_t vdc_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  		return BLK_STS_DEV_RESOURCE;
>>  	}
>>  
>> -	if (__send_request(bd->rq) < 0) {
>> +	ret = __send_request(bd->rq);
>> +	if (ret == -EAGAIN) {
>> +		spin_unlock_irqrestore(&port->vio.lock, flags);
>> +		/* already spun for 10msec, defer 10msec and retry */
>> +		blk_mq_delay_kick_requeue_list(hctx->queue, 10);
>> +		return BLK_STS_DEV_RESOURCE;
>> +	} else if (ret < 0) {
>>  		spin_unlock_irqrestore(&port->vio.lock, flags);
>>  		return BLK_STS_IOERR;
>>  	}
> 
> We could add this particular change on top of mine after we have
> extensively tested it.

It doesn't really make sense on top of yours, as that removes the
limited looping that sunvdc would do...

> For now, I would propose to pick up my patch to revert the previous
> change. I can then pick up your proposed change and deploy it for
> extensive testing and see if it has any side effects.

Why not just test this one and see if it works? As far as I can tell,
it's been 6.5 years since this change went in, I can't imagine there's a
huge sense of urgency to fix it up that can't wait for testing a more
proper patch rather than a work-around?

-- 
Jens Axboe

