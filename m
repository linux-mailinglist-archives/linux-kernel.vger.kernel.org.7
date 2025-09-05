Return-Path: <linux-kernel+bounces-802496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E7B452D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCE4A45745
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAF330CDA1;
	Fri,  5 Sep 2025 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sSXmzoqt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gtNXmcxz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86AE30C638
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063593; cv=none; b=QP6YLpJbwhxR2Z8bXGqM60zvRLX9o2VbN3K2p2m5+WEdunc4A03edJjVlsl1uWCtCoQfc2/xjxLSEw2/8kB3aXJYOb/Na3rVyRS2yNTbLi3u1RrzcCCC1Cx+ewLRWmfJIpIfTGI9nlQNNap8iIfpEDPaw2rWqJQ+jTndyiGo1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063593; c=relaxed/simple;
	bh=upnPBSePU5oRzZeCcHXsf8e52RwKiQZllkXcOtak8WY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c1Uoj3I8QPfDTKj2NoA6K/9rms0mONPL2/g8ga5iP/KpPhZ5LpEDE5OJk3NSThY5Wtmtg40X3pif44OgApzOZzNiPFdNDPZN4RsiskOpgCat3igyg0Mi9nLUKaxcykGL1K9YpscFurokofbcWXBMymGgPg1u75HuU3TS8eQWTHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sSXmzoqt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gtNXmcxz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757063582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dFAgFCfcibzN9hSMLX40yFT+93rXfUiRizWSBQdGEk=;
	b=sSXmzoqtt5MBTndEgKXkm4xJrMWhPS0Vypkdo7SsQi/OEyuQGpfE5oowl220Ejz8lh9GO5
	eIYmCfubpjjPrsf8vFrzleTz+wJ48vmf+diLJAIFVG9HqnT+jJemZ9Ur/0FSt42NPDtucu
	VNEUMDExrXGePSYAN+vm15GkVWtqy3TohcEiGGHSlcKRov3vILEjkeEiRgv8bwf7UBjHgA
	x64L5nPwxU13sta4w4d1aaRhBXifhYXB3wlYW2LaGZNf2GQfMY4IueqB0H9OM3so+mX1wj
	29WQidhKQEzI1hCd+21/irY+y/xCssZALht1lJnHEUtd+SItlOOCpPT5wXOClg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757063582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dFAgFCfcibzN9hSMLX40yFT+93rXfUiRizWSBQdGEk=;
	b=gtNXmcxzHVGP+h4+m82twQRO3bk82wkZcAVjWcoqjSQQ0Yo7k3aOrEnw9zvJC+/AYBy6E7
	2TL/TTgTkrFD9uDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1] printk_ringbuffer: don't needlessly wrap data blocks
 around
In-Reply-To: <aLm_SpmQP3UwzkqQ@pathway>
References: <20250903001008.6720-1-d-tatianin@yandex-team.ru>
 <84jz2etj3t.fsf@jogness.linutronix.de> <aLm_SpmQP3UwzkqQ@pathway>
Date: Fri, 05 Sep 2025 11:19:02 +0206
Message-ID: <84ikhxfejl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-04, Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2025-09-04 16:04:30, John Ogness wrote:
>> > +static bool same_lpos_wraps(struct prb_data_ring *data_ring,
>> > +			     unsigned long begin_lpos, unsigned long next_lpos)
>> 
>> We need a better name here since it is not actually using the value of
>> @next_lpos to check the wrap count. Perhaps inverting the return value
>> and naming it blk_lpos_wraps(). So it would be identifying if the given
>> blk_lpos values lead to a wrapping data block.
>
> Or a combination of my and this proposal: is_blk_wrapped().

Sounds good to me.

>> The rest looked fine to me and also passed various private
>> tests. However, we should also update data_check_size(), since now data
>> blocks are allowed to occupy the entire data ring. Something like this:
>> 
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index d9fb053cff67d..e6bdfb8237a3d 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -397,21 +397,14 @@ static unsigned int to_blk_size(unsigned int size)
>>   */
>>  static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>>  {
>> -	struct prb_data_block *db = NULL;
>> -
>>  	if (size == 0)
>>  		return true;
>>  
>>  	/*
>>  	 * Ensure the alignment padded size could possibly fit in the data
>> -	 * array. The largest possible data block must still leave room for
>> -	 * at least the ID of the next block.
>> +	 * array.
>>  	 */
>> -	size = to_blk_size(size);
>> -	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
>> -		return false;
>> -
>> -	return true;
>> +	return (to_blk_size(size) <= DATA_SIZE(data_ring));
>>  }
>
> I hope that we would never reach this limit. A buffer for one
> message does not look practical. I originally suggested to avoid
> messages bigger than 1/4 of the buffer size ;-)
>
> That said, strictly speaking, the above change looks correct.
> I would just do it in a separate patch. The use of the full
> buffer and the limit of the maximal message are related
> but they are not the same things. Also separate patch might
> help with bisection in case of problems.

FWIW, Aside from inspecting all the related code carefully, I also
performed various size and boundary tests using small buffers (like 1KB
and 2KB). I am confortable with these changes.

John

