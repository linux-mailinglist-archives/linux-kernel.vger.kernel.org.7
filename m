Return-Path: <linux-kernel+bounces-801320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C230B443AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C9AA44DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73A23D7C7;
	Thu,  4 Sep 2025 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="L5fO0ipB"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB0161302
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004762; cv=none; b=KZVMbjX+6e9X3DiUYjapiPV07usEmvwNO49G4DtV+OqObCAHcAC/1lQEnc0yK/fBBVBSWy7NPHO9ehFWLsFSVbIihjt4FYdkOXBu64O9JeVlAKneCabn1KX+6/JycySAyU3wbBqrA7mZa5+pG+sHgDB9HQLX1XtPYVEyqiSgPIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004762; c=relaxed/simple;
	bh=HfM3WDr45qjJOExyeRjuX+tshBdoxfJkyuB3RAB2xvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLjDnW6efe0m7mzODiKQp7uEvSY6qvPUvM/ssHGTKtIYKQmE3Uk1UDZfsNKxNE0tSis20I7SyjxJg48Ent3khZDTKm+fhGS8HHq7WHWMln9M9Fb8GcavScoH9YX25tWDIHVoK5wm5AJ1Qr++QkFRXw2aesaX3r3zLSgkAr7XKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=L5fO0ipB; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:999c:0:640:51a7:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 5447F8081B;
	Thu, 04 Sep 2025 19:50:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c51::1:12] (unknown [2a02:6bf:8080:c51::1:12])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Ook2jN4GxKo0-QQTtvgAN;
	Thu, 04 Sep 2025 19:50:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1757004626;
	bh=333asDOfylQvwbJ2U32qnE/+DOJxupcXNOSotOED4U0=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=L5fO0ipBudA97U1UnoMKqXl2hAdDaeAK/xwTL0X1CHMg5iitBhXtMKG7fbUUcULvD
	 U6i+yW2L4jH08gFXbSp3QQ/Qi45Bfo+Bhn+R/2/PoUO5NP1WPWMQkE3ghV9ONw6rMC
	 1PyAgmzcPygHgSHn5PJk4maMr8glAfyu0NwC4lXI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <02e9e8d3-3b82-4972-8b66-06065557a4f1@yandex-team.ru>
Date: Thu, 4 Sep 2025 19:50:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] printk_ringbuffer: don't needlessly wrap data blocks
 around
To: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250903001008.6720-1-d-tatianin@yandex-team.ru>
 <84jz2etj3t.fsf@jogness.linutronix.de> <aLm_SpmQP3UwzkqQ@pathway>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <aLm_SpmQP3UwzkqQ@pathway>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/4/25 7:33 PM, Petr Mladek wrote:
> On Thu 2025-09-04 16:04:30, John Ogness wrote:
>> On 2025-09-03, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
>>> Previously, data blocks that perfectly fit the data ring buffer would
>>> get wrapped around to the beginning for no reason since the calculated
>>> offset of the next data block would belong to the next wrap. Since this
>>> offset is not actually part of the data block, but rather the offset of
>>> where the next data block is going to start, there is no reason to
>>> include it when deciding whether the current block fits the buffer.
>> This is a nice catch!
>>
>> Although note that this patch avoids wasting a maximum of 8 bytes of
>> ringbuffer space. If you are interested in tackling the wasted-space
>> issue of the printk ringbuffer there are much larger [0] fish to catch.
>>
>> [0] https://lore.kernel.org/lkml/84y10vz7ty.fsf@jogness.linutronix.de
>>
>> My comments below...
>>
>>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>>> index d9fb053cff67..f885ba8be5e6 100644
>>> --- a/kernel/printk/printk_ringbuffer.c
>>> +++ b/kernel/printk/printk_ringbuffer.c
>>> @@ -1002,6 +1002,18 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>>>   	return true;
>>>   }
>>>   
>>> +static bool same_lpos_wraps(struct prb_data_ring *data_ring,
>>> +			     unsigned long begin_lpos, unsigned long next_lpos)
>> We need a better name here since it is not actually using the value of
>> @next_lpos to check the wrap count. Perhaps inverting the return value
>> and naming it blk_lpos_wraps(). So it would be identifying if the given
>> blk_lpos values lead to a wrapping data block. Some like this:
>>
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index d9fb053cff67d..cf0fcd9b106ae 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -1002,6 +995,17 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>>   	return true;
>>   }
>>   
>> +/* Identify if given blk_lpos values represent a wrapping data block. */
>> +static bool blk_lpos_wraps(struct prb_data_ring *data_ring,
>> +			   unsigned long begin_lpos, unsigned long next_lpos)
>> +{
>> +	/*
>> +	 * Subtract one from @next_lpos since it is not actually part of this
>> +	 * data block. This allows perfectly fitting records to not wrap.
>> +	 */
>> +	return (DATA_WRAPS(data_ring, begin_lpos) != DATA_WRAPS(data_ring, next_lpos - 1));
>> +}
> Or a combination of my and this proposal: is_blk_wrapped().
>
>> +
>>   /* Determine the end of a data block. */
>>   static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
>>   				   unsigned long lpos, unsigned int size)
>>
>>> +{
>>> +	/*
>>> +	 * Subtract one from next_lpos since it's not actually part of this data
>>> +	 * block. We do this to prevent perfectly fitting records from wrapping
>>> +	 * around for no reason.
>>> +	 */
>>> +	return DATA_WRAPS(data_ring, begin_lpos) ==
>>> +	       DATA_WRAPS(data_ring, next_lpos - 1);
>>> +}
>>> +
>>>   /* Determine the end of a data block. */
>>>   static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
>>>   				   unsigned long lpos, unsigned int size)
>> The rest looked fine to me and also passed various private
>> tests. However, we should also update data_check_size(), since now data
>> blocks are allowed to occupy the entire data ring. Something like this:
>>
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index d9fb053cff67d..e6bdfb8237a3d 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -397,21 +397,14 @@ static unsigned int to_blk_size(unsigned int size)
>>    */
>>   static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>>   {
>> -	struct prb_data_block *db = NULL;
>> -
>>   	if (size == 0)
>>   		return true;
>>   
>>   	/*
>>   	 * Ensure the alignment padded size could possibly fit in the data
>> -	 * array. The largest possible data block must still leave room for
>> -	 * at least the ID of the next block.
>> +	 * array.
>>   	 */
>> -	size = to_blk_size(size);
>> -	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
>> -		return false;
>> -
>> -	return true;
>> +	return (to_blk_size(size) <= DATA_SIZE(data_ring));
>>   }
> I hope that we would never reach this limit. A buffer for one
> message does not look practical. I originally suggested to avoid
> messages bigger than 1/4 of the buffer size ;-)
>
> That said, strictly speaking, the above change looks correct.
> I would just do it in a separate patch. The use of the full
> buffer and the limit of the maximal message are related
> but they are not the same things. Also separate patch might
> help with bisection in case of problems.

Sounds good to me.
Do you need more time for extra testing, or can I go ahead and submit a 
new series?

Since you asked, I noticed this issue when studying the code to make a 
similar lockless log ring for my hobby OS :)
I might also take a look at reducing the memory usage for the metadata 
at some point (from discussions linked in John's email).

Thanks for the quick reviews!

>
> Best Regards,
> Petr

