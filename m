Return-Path: <linux-kernel+bounces-811636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4719B52BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947683B0F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8F12E2852;
	Thu, 11 Sep 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="P3pP/gZq"
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5F22E2DDE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579803; cv=none; b=g1ffgVEFrV74j0+XMRHdquxTA3YqvGDUV0mjhFCRDjc3P/1yhwPs7FMevwgM+K3sBOMQRJUCL2lAr/ammvW/aoWk1Xnk6koJ+qUvAAX69CAVbRp7c97OjKwTA/Adgz7BOy60zQ+JoCk51BS3vr9wUn09oDL14w4p1S/9S8gMXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579803; c=relaxed/simple;
	bh=grX3KY4ya//hyp8tH6de0uVHqplm9WNkCwNifLngM8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K565DB9VpAo/g+pYd3pth9y7sJf27ufu355Ql3krbaigyS7Te6hk5qCmAQdohRbamaJpGSYfY9OmF/oN+gK6D1Hyah/I+nB/PiLMCQYU7LhU3tEg5FfYzKsih1cawNED+FMSV85sO5lmOhdZdbW/g+1nmJpWcykWqg4PKLFjHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=P3pP/gZq; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4136C808C6;
	Thu, 11 Sep 2025 11:34:56 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b59::1:18] (unknown [2a02:6bf:8080:b59::1:18])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id sYGp7G0Fk0U0-7pENpNK6;
	Thu, 11 Sep 2025 11:34:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1757579695;
	bh=2mSbqt7bF/dpUzLzF0O4X7STtkQQLozpoQa5g0Qmirg=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=P3pP/gZqeoOnTSzoTfYbaj8pMTR/21AYnSgT3rl4IBJIyZoNZ6O6HYc6Kxm3ncIqC
	 HCA8xaDRJqTDsuOgN0F3Az+HanzX2aIzQlDA7ZCPcGv4ocknuS0eY/76prX7Y9ICis
	 2IImOrTKAxXCmDpEnDqS//xigaF40hi7NvyRZrP8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <d4d676a4-643d-47fb-974e-fa08009ce23b@yandex-team.ru>
Date: Thu, 11 Sep 2025 11:34:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <20250905144152.9137-2-d-tatianin@yandex-team.ru>
 <84tt1gex89.fsf@jogness.linutronix.de>
 <ea3b4933-49d0-4940-9f05-d8e2189606c8@yandex-team.ru>
 <84ikhwev7o.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <84ikhwev7o.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/5/25 7:10 PM, John Ogness wrote:
> On 2025-09-05, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
>> On 9/5/25 6:27 PM, John Ogness wrote:
>>> On 2025-09-05, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
>>>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>>>> index d9fb053cff67..99989a9ce4b4 100644
>>>> --- a/kernel/printk/printk_ringbuffer.c
>>>> +++ b/kernel/printk/printk_ringbuffer.c
>>>> @@ -1234,14 +1245,14 @@ static const char *get_data(struct prb_data_ring *data_ring,
>>>>    	}
>>>>    
>>>>    	/* Regular data block: @begin less than @next and in same wrap. */
>>>> -	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
>>>> +	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
>>>>    	    blk_lpos->begin < blk_lpos->next) {
>>>>    		db = to_block(data_ring, blk_lpos->begin);
>>>>    		*data_size = blk_lpos->next - blk_lpos->begin;
>>>>    
>>>>    	/* Wrapping data block: @begin is one wrap behind @next. */
>>>> -	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
>>>> -		   DATA_WRAPS(data_ring, blk_lpos->next)) {
>>>> +	} else if (!is_blk_wrapped(data_ring,
>>>> +		   blk_lpos->begin + DATA_SIZE(data_ring), blk_lpos->next)) {
>>> It would look nicer if the arguments of the function were indented to
>>> the function parenthesis:
>>>
>>> 	} else if (!is_blk_wrapped(data_ring, blk_lpos->begin +
>>> 				   DATA_SIZE(data_ring), blk_lpos->next)) {
>> Would you like me to resend with this addressed?
> Knowing Petr, I would say "yes". :-)
>
> But wait for Petr's response before sending anything.

Friendly ping for Petr :)

>
> John

