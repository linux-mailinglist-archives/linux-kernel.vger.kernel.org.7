Return-Path: <linux-kernel+bounces-815498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3667B5675E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EF917A744
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367DC237713;
	Sun, 14 Sep 2025 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+INlNgK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RcDwmHkK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AC1D554
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757841833; cv=none; b=TTITWRCzQWgasFhE38iezPBkajtCF4poXU7GiAPwgq9FagiPu87Ifi2TU2eFD6fFR/UTevqjXnUakTeqPYlbWzuk8SulR6JrkZPOausB0iLInVxyyCmVv5Bbry8Ndrwx6TJUyc6VfzBoc5odVMWoKmNdT69LvWjUQ2qPlRKX0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757841833; c=relaxed/simple;
	bh=GXRX7LHYfbcoSNDFBxV9Vpg0Im36TCsj96j3SOvixuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yqc98ECs7A0X9yfM8AAX0Wg86oWTBefTeyJpV4HpKH2OTosIGk1EVqLD63PQ/QDMEsZfgKCJ305efLSY3djvdZKChE2wHKqgbwRe0RL1zbPLlo38veGh28XwEdtWXlWV6xQFUweJR6feCr7yte1BqDj+KTpYgSfLfsOWVn5OBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F+INlNgK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RcDwmHkK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757841829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8yh3+f19sVxKDCB6M1To0MGsF1AfRAID24Z12rxfKk=;
	b=F+INlNgKLgvDL4fFV5mSzHN4KTsfE+m1KMsbVj2XUHQ63F45UakNrWCYobNb1Dx2wjhTgd
	LG7C3VLsoSySQHpw4xvSkWvLIX+pt/MgFBcrWhRZBajGX0y1l5pZNCGTQg169Io//SRZA6
	3hFm+QPN2SzcKHx1O7/6ELwTfN+u0Vd4jFI7ktXoiqGX3CP4hKWfnPJya0QK5wXuSpVWmH
	BctOdyVsKcTRZ1W6LlgBbujSlWuOLQQZHrV7m3EPcVQZbSISaH49zV1gTxvUVZUq4SHNqn
	f9032YVkDhof735sLdUH8meWtpaKYciMvzHxcHwjcOF/4oEkwKr8GDnUkudJdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757841829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8yh3+f19sVxKDCB6M1To0MGsF1AfRAID24Z12rxfKk=;
	b=RcDwmHkKAmkuWG4+VOANHrVY/5G7UFuZF0kTJCa3+2Haj+kulpJbWCIANe4BldgiBJX5xu
	lomhNm+pWwTQLNCw==
To: Daniil Tatianin <d-tatianin@yandex-team.ru>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
In-Reply-To: <20cbb02b-762f-4a3f-ba40-aae018388b3b@yandex-team.ru>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz> <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de> <aMPm8ter0KYBpyoW@pathway.suse.cz>
 <aMPt8y-8Wazh6ZmO@pathway.suse.cz> <aMQzD9CLP1F01Rry@pathway.suse.cz>
 <84a52zy0iu.fsf@jogness.linutronix.de>
 <20cbb02b-762f-4a3f-ba40-aae018388b3b@yandex-team.ru>
Date: Sun, 14 Sep 2025 11:29:48 +0206
Message-ID: <84348pqtej.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-13, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
>> The problem comes from the function data_make_reusable(). The job of
>> this function is to push the data_ring tail forward, one data block at a
>> time, while setting the related descriptors to reusable.
>>
>> After pushing the tail forward, if it still has not pushed it far enough
>> for new requested reservation, it must push it further. For this it
>> _assumes the current position of the tail is a descriptor ID for the
>> next data block_. But what if the tail was pushed all the way to the
>> head? Then there is no next data block and it will read in garbage,
>> thinking it is the next descriptor ID to set reusable. And from there it
>> just goes crazy because it is reading garbage to determine how big the
>> data block is so that it can continue pushing the tail (beyond the
>> head!).
>>
>> Example: Assume the 96 byte ringbuffer has a single message of 64
>> bytes. Then we try to reserve space for a 72-byte
>> message. data_make_reusable() will first set the descriptor of the
>> 64-byte message to reusable and push the tail forward to index 64. But
>> the new message needs 72 bytes, so data_make_reusable() will keep going
>> and read the descriptor ID at index 64, but there is only random garbage
>> at that position. 64 is the head and there is nothing valid after it.
>
> Good catch, although I'm not sure i understand why this produces the 
> error Petr is seeing.
>
> Why would it see garbage in a zeroed .bss buffer? Is this because of
> the previous test runs dirtying the same data ring or something?

Correct. The explosions don't start happening until after about 5-6
wraps. So the data ring is full of somewhat random data that will then
be randomly interpretted once it attempts to push the tail beyond the
head.

> Either way, I guess after your patch is accepted i'm going to resend
> mine to only strip the trailing id, but the records must still be less
> than half of the data ring size so that data_make_reusable never
> invalidates past the current head.

After applying your patch, can you provide an example where a maximum
size of exactly half causes the tail to be pushed beyond the head? Keep
in mind that data_check_size() accounts for the meta-data. It only
doesn't account for the extra ID on wrapping data blocks.

John

