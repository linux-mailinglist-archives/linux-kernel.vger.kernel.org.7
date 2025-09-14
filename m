Return-Path: <linux-kernel+bounces-815503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E2B56767
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22623BFEFA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EBB238D54;
	Sun, 14 Sep 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Dl62bIHm"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EAE193077
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757843934; cv=none; b=nFERf/BIFcBqn4yUvN0wUWD21RC6jgj4yenuGDsyhATtJveBr2gVcR3srI/r8o9j5nHFh1C08qk9AjVzYh+Nb9+0JdMZLJTtg8wc/uIMxrBravQCesHJkoFX7POhX8q3vuQ5yaZ1q/dK2rLz6CCmGj/p46eznwP+Se7yO5hB5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757843934; c=relaxed/simple;
	bh=euQ0TBMjIy0YdGDzYV5M8wzEVyE3x3nmv6wDocu6xsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DR2hLj0aLFD/q73IsXrASaNDW1KqAKXLTMHkI2xpRESjdIMIL5q0j1Xa6WP4Bw0bOAqrOsXroLMEnuYY/M1R2wbSHHH8ROlB9JkogARxLzWYWWQH3bT4KLio+RFYJPtmkU3Fa0x5jOE0kHHH43/oCDl4MNBRQylb2gQWc1/0J6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=Dl62bIHm; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 26FBB80863;
	Sun, 14 Sep 2025 12:56:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d4c::1:2] (unknown [2a02:6bf:8080:d4c::1:2])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id puKaEf1GlCg0-Wupti9yF;
	Sun, 14 Sep 2025 12:56:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1757843813;
	bh=iS2UrzTIef32MN0VP2W3/OiYiyAT0+G4n00k64sgkN0=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=Dl62bIHm1y7e08cO3CG6ziT8Qqhkda7aKkCeJQrohnurDc77gqh3bkm0kmJ+0qd5X
	 sizL3JfrN9GsUGpieQ0eulxlA6LT7YWM9wxJ3t1MlhJyvOyvSpJ8jqDgmDxJN3JhqQ
	 B/A+wlD1bA6DIhQzj8g1MOxZ+cej/OCCFsNmKUGk=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <fece29ff-070e-4074-85be-4093a3000e5d@yandex-team.ru>
Date: Sun, 14 Sep 2025 12:56:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz> <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de> <aMPm8ter0KYBpyoW@pathway.suse.cz>
 <aMPt8y-8Wazh6ZmO@pathway.suse.cz> <aMQzD9CLP1F01Rry@pathway.suse.cz>
 <84a52zy0iu.fsf@jogness.linutronix.de>
 <20cbb02b-762f-4a3f-ba40-aae018388b3b@yandex-team.ru>
 <84348pqtej.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <84348pqtej.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/25 12:23 PM, John Ogness wrote:

> On 2025-09-13, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
>>> The problem comes from the function data_make_reusable(). The job of
>>> this function is to push the data_ring tail forward, one data block at a
>>> time, while setting the related descriptors to reusable.
>>>
>>> After pushing the tail forward, if it still has not pushed it far enough
>>> for new requested reservation, it must push it further. For this it
>>> _assumes the current position of the tail is a descriptor ID for the
>>> next data block_. But what if the tail was pushed all the way to the
>>> head? Then there is no next data block and it will read in garbage,
>>> thinking it is the next descriptor ID to set reusable. And from there it
>>> just goes crazy because it is reading garbage to determine how big the
>>> data block is so that it can continue pushing the tail (beyond the
>>> head!).
>>>
>>> Example: Assume the 96 byte ringbuffer has a single message of 64
>>> bytes. Then we try to reserve space for a 72-byte
>>> message. data_make_reusable() will first set the descriptor of the
>>> 64-byte message to reusable and push the tail forward to index 64. But
>>> the new message needs 72 bytes, so data_make_reusable() will keep going
>>> and read the descriptor ID at index 64, but there is only random garbage
>>> at that position. 64 is the head and there is nothing valid after it.
>> Good catch, although I'm not sure i understand why this produces the
>> error Petr is seeing.
>>
>> Why would it see garbage in a zeroed .bss buffer? Is this because of
>> the previous test runs dirtying the same data ring or something?
> Correct. The explosions don't start happening until after about 5-6
> wraps. So the data ring is full of somewhat random data that will then
> be randomly interpretted once it attempts to push the tail beyond the
> head.

Ah ok, yeah that makes sense.

>
>> Either way, I guess after your patch is accepted i'm going to resend
>> mine to only strip the trailing id, but the records must still be less
>> than half of the data ring size so that data_make_reusable never
>> invalidates past the current head.
> After applying your patch, can you provide an example where a maximum
> size of exactly half causes the tail to be pushed beyond the head? Keep
> in mind that data_check_size() accounts for the meta-data. It only
> doesn't account for the extra ID on wrapping data blocks.

Sorry, I think exactly half is fine, basically we can keep it half, but 
only remove the tailing id check with my patch.

>
> John

