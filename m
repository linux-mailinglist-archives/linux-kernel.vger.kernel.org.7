Return-Path: <linux-kernel+bounces-803324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5ACB45D85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731EE1C27C60
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB26306B27;
	Fri,  5 Sep 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ENN5PFHX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tomJRM0+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96066302147
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088639; cv=none; b=r9FvlZCxV3ALLb9PB77ZcOvysUWtXB1KpB6XmNGhXznIvc7nibIzu49+bvLzcmgEmLrKuV/hJtucTZmsrwcNCDOIPafeo/kCYrcoNDkBEsPGf3lnSMfAL20XVGjD3lpqK97l3JkOexOykzwMQ8RaKtHldvdnfqMWYrIc6iPYc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088639; c=relaxed/simple;
	bh=o4KU4qnN8ZD+OG71r7G2NTAK3c7Eu8SkghPngcMDO5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VHKitJxCZuHzKvhW0FG/6IlyISTOokCd0ob6pynibeZNnKswj/5UVTQuDGMQH94jBa9783Sl5f2O2Jsom/R8HKnnykEAo5C7pVLnau/Vq9L1gM5BEAC/NYGrNSQLm9h9MD9GJZ/aX9E1mQaZTzc++2tT9uPxn1jpvEluoInSh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ENN5PFHX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tomJRM0+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757088635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UWsW6zFHjqZALPgNsdGej+3s+ZafV7hRrJTxmp2W6U=;
	b=ENN5PFHXB0iedBL4vezcx22CVEaTZo8bxM4yYxabQaqkZABONLnkhEAk04Dj+joy7GxrTc
	FGjPmK3HFU0AMiskSpN/k/fIzuA9uPBye7aYNupHGRaNsuOI8N4faNJ0BncBeQMh9xjufn
	IltGz/E6XUE/kcVDvzVVKRtq0P6MYCmJ6uHpVXslxgjHz3Bijm6SJFmvqjuJ3TK8Z4sSze
	XllTx8gpf8Mp8y8UpEHJuTfP3ycc144Rjec0dgK0Ilfcu9JIvDkPOFEjal/nPRZwXZacQQ
	F7zY2zwLph7isAl/D1WK6sY2+3NVxKBl1b/R2zci+14/uK84UupeHggiEQhBEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757088635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UWsW6zFHjqZALPgNsdGej+3s+ZafV7hRrJTxmp2W6U=;
	b=tomJRM0+MAkc4lYsHr6tIXpIqWofGgaV41jV9Zpv9auWv05kaDPRd9r3pnMF5fvGlbvYr5
	lzY40xEQVc3/Z2Cg==
To: Daniil Tatianin <d-tatianin@yandex-team.ru>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 1/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
In-Reply-To: <ea3b4933-49d0-4940-9f05-d8e2189606c8@yandex-team.ru>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <20250905144152.9137-2-d-tatianin@yandex-team.ru>
 <84tt1gex89.fsf@jogness.linutronix.de>
 <ea3b4933-49d0-4940-9f05-d8e2189606c8@yandex-team.ru>
Date: Fri, 05 Sep 2025 18:16:35 +0206
Message-ID: <84ikhwev7o.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-05, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> On 9/5/25 6:27 PM, John Ogness wrote:
>> On 2025-09-05, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
>>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>>> index d9fb053cff67..99989a9ce4b4 100644
>>> --- a/kernel/printk/printk_ringbuffer.c
>>> +++ b/kernel/printk/printk_ringbuffer.c
>>> @@ -1234,14 +1245,14 @@ static const char *get_data(struct prb_data_ring *data_ring,
>>>   	}
>>>   
>>>   	/* Regular data block: @begin less than @next and in same wrap. */
>>> -	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
>>> +	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
>>>   	    blk_lpos->begin < blk_lpos->next) {
>>>   		db = to_block(data_ring, blk_lpos->begin);
>>>   		*data_size = blk_lpos->next - blk_lpos->begin;
>>>   
>>>   	/* Wrapping data block: @begin is one wrap behind @next. */
>>> -	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
>>> -		   DATA_WRAPS(data_ring, blk_lpos->next)) {
>>> +	} else if (!is_blk_wrapped(data_ring,
>>> +		   blk_lpos->begin + DATA_SIZE(data_ring), blk_lpos->next)) {
>> It would look nicer if the arguments of the function were indented to
>> the function parenthesis:
>>
>> 	} else if (!is_blk_wrapped(data_ring, blk_lpos->begin +
>> 				   DATA_SIZE(data_ring), blk_lpos->next)) {
>
> Would you like me to resend with this addressed?

Knowing Petr, I would say "yes". :-)

But wait for Petr's response before sending anything.

John

