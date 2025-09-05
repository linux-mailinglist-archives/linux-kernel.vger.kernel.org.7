Return-Path: <linux-kernel+bounces-803249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2734B45C9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9630D17AA98
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B1C2F7AD7;
	Fri,  5 Sep 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zK2I5oax";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+flpPcK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6EC1C5D55
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086238; cv=none; b=mcCv9utQj8d7vupLWrbGPilDflrjIZdadbJwX/ntlxB/DeLp4vWVNjft3T/7FDkNYSc2p0/z+yuiPW9kQ2A95AsfrF1iekEsQVr5uL4YOsa7l4Gd/7iJrZFkEWlnCe4I84D+iC0I0/bcxD83NNRREKcaTrzlk4ieZ/o3Wlsex60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086238; c=relaxed/simple;
	bh=RjyXAzgAkNRIfNAVJVNC2HQttyOoKi9O0xGyi6CzAxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YYt6ijEZM0obffwWp+jVM+NHetlcuW6frXRFI5wgbqe5ng0r+2y6moT7v1/49ZzxwcSutfHkJaObfrI1td/WrUkqGrMvj+HDY3A0ELBeBSjsujDd7cf3ZGHplO+fbZ5CnVqIJex3dxEl72ZXI9IffHfh4gLTuUabUGFXlIw3u/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zK2I5oax; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L+flpPcK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757086235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t06Q3cOtAiQD3UrhwjtXE2phuFRjnr5DF3aqSiDjskw=;
	b=zK2I5oaxN1KF3XGzL5lg68KFeD4Ntzm6TeHHtcIBq8gY6K74FeDzwxtiTYuCDw5wQNCgf1
	z/liVMe75/l15MT9LoCI3Q5jvvKYV/VVlIhoXEgtkMpjB67VCQrgK00I1P3Z3cq/PSDddi
	XkSD8mG/l4M9Xs2FmEUd9ckGORLUlGQ/u6EB6xWJQAcbYrymHGy16O0ZDA2apGs/VGZV7H
	zadOON9l6y8VyDBuw6L0JeP0DENoT6KfTP8dXUptt82oTEnZ9ryjeUbmuY2NhWTD+C7Zcr
	JPad9PtzLFc8Z1d/d7UF2wJC3fQY6Xm8YldPALoeZd2Gv0M067e/kcRO3Ywmag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757086235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t06Q3cOtAiQD3UrhwjtXE2phuFRjnr5DF3aqSiDjskw=;
	b=L+flpPcKJRrDFL/WfxgeV048n3fdNSCwSyd6ZTQrslSftrAj13AsrHlgiMMQeyFDJtMe40
	TgR0Vo+ZdKRsf+Bg==
To: Daniil Tatianin <d-tatianin@yandex-team.ru>, Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 1/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
In-Reply-To: <84tt1gex89.fsf@jogness.linutronix.de>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <20250905144152.9137-2-d-tatianin@yandex-team.ru>
 <84tt1gex89.fsf@jogness.linutronix.de>
Date: Fri, 05 Sep 2025 17:36:34 +0206
Message-ID: <84o6roex2d.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-05, John Ogness <john.ogness@linutronix.de> wrote:
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index d9fb053cff67..99989a9ce4b4 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -1234,14 +1245,14 @@ static const char *get_data(struct prb_data_ring *data_ring,
>>  	}
>>  
>>  	/* Regular data block: @begin less than @next and in same wrap. */
>> -	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
>> +	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
>>  	    blk_lpos->begin < blk_lpos->next) {
>>  		db = to_block(data_ring, blk_lpos->begin);
>>  		*data_size = blk_lpos->next - blk_lpos->begin;
>>  
>>  	/* Wrapping data block: @begin is one wrap behind @next. */
>> -	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
>> -		   DATA_WRAPS(data_ring, blk_lpos->next)) {
>> +	} else if (!is_blk_wrapped(data_ring,
>> +		   blk_lpos->begin + DATA_SIZE(data_ring), blk_lpos->next)) {
>
> It would look nicer if the arguments of the function were indented to
> the function parenthesis:
>
> 	} else if (!is_blk_wrapped(data_ring, blk_lpos->begin +
> 				   DATA_SIZE(data_ring), blk_lpos->next)) {

Ugh, my mail client messed that up. I meant to write:

	} else if (!is_blk_wrapped(data_ring,
				   blk_lpos->begin + DATA_SIZE(data_ring),
				   blk_lpos->next)) {

> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> Tested-by: John Ogness <john.ogness@linutronix.de>

