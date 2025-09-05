Return-Path: <linux-kernel+bounces-803246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26DAB45C96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6375167318
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F2D2F1FD1;
	Fri,  5 Sep 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="U5iLyCyt"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612B219EB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086192; cv=none; b=DSoc97uqff28/5TPRktG3iVTrgcrgqzLziVHIZsrNYEkSZoz3mGWpCwa2NoGktuEGs4zIyuIz48zrtqXfgAY0rr0VNXIK86F1mwYNymSUw0L1obUsGYbgpiJPhCk2re/sSf/WtBdmYVWN9lBj/nGRQjGqa9Dj3N/ozJTWpRgPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086192; c=relaxed/simple;
	bh=BxUXzbp6tW9HkuDY9YdiJ/tKeL7BUBWB6wgeuNUUUPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpsLH9ESiKiuiTL5LS3SbMaQyzftDyHYDK9BLxYyhipL3R+ZbIYttD0NB1PBjNMa4xSUcVHdEOopHYPXNnrfaaGo3fB3kTPs9MjENnkf6bCeDAltMFxDMUzUy+sHhbyfYm4g9Cb2NYhFrs7lhEAS+ZtGZpmz3T7DALJHWzQJrKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=U5iLyCyt; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B703FC1091;
	Fri, 05 Sep 2025 18:29:38 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d49::1:8] (unknown [2a02:6bf:8080:d49::1:8])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id aTkr5n3GqOs0-EHHFA89N;
	Fri, 05 Sep 2025 18:29:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1757086178;
	bh=yCEN9kUnrmHejvnk5reuG8g0xKCGYUfPqxhPWFszXpY=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=U5iLyCytt2QkzEUEvNui/S5cuOkdiYx5W5++yPBfpdyU+be7mVpsgqsPK11WSbe+0
	 9AyoLSHB6ZgHcv7dY3b5U/gN8q6RrKgqOcx5LeBTf23/T3fN2D4vjQ44m0wvz5igzp
	 JbwW9ODXSwBrMFHXEQ5rza76UFkxoT+oqOjcpi90=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <ea3b4933-49d0-4940-9f05-d8e2189606c8@yandex-team.ru>
Date: Fri, 5 Sep 2025 18:29:35 +0300
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
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <84tt1gex89.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/5/25 6:27 PM, John Ogness wrote:
> On 2025-09-05, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index d9fb053cff67..99989a9ce4b4 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -1234,14 +1245,14 @@ static const char *get_data(struct prb_data_ring *data_ring,
>>   	}
>>   
>>   	/* Regular data block: @begin less than @next and in same wrap. */
>> -	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
>> +	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
>>   	    blk_lpos->begin < blk_lpos->next) {
>>   		db = to_block(data_ring, blk_lpos->begin);
>>   		*data_size = blk_lpos->next - blk_lpos->begin;
>>   
>>   	/* Wrapping data block: @begin is one wrap behind @next. */
>> -	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
>> -		   DATA_WRAPS(data_ring, blk_lpos->next)) {
>> +	} else if (!is_blk_wrapped(data_ring,
>> +		   blk_lpos->begin + DATA_SIZE(data_ring), blk_lpos->next)) {
> It would look nicer if the arguments of the function were indented to
> the function parenthesis:
>
> 	} else if (!is_blk_wrapped(data_ring, blk_lpos->begin +
> 				   DATA_SIZE(data_ring), blk_lpos->next)) {

Would you like me to resend with this addressed?

Thanks!

> Otherwise, everything is OK for me.
>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> Tested-by: John Ogness <john.ogness@linutronix.de>

