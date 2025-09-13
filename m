Return-Path: <linux-kernel+bounces-815300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB58DB5625D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80AD13B4C9A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C981FBC91;
	Sat, 13 Sep 2025 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="nUqv9wqu"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478D1D5CC6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757785124; cv=none; b=kx/foyeeLvcNmgM1krd8DA3g2itruq4uolyiyWxz9oWBVmagfqV3+B7/xgTvBEyh9eNMBLW2oXlDu43jVg5eV70hf6uGy0uu9OACFgcXVZn7LCJvhzP8KDPjYbg+4xlWDZ6zASQMfHrUkEn7Y/AueR5aaRLE589cqFcIoL1/Dh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757785124; c=relaxed/simple;
	bh=Q8Toq2djyQ92KT/7tRtP3IY2XxZeElylv3DKkezUICU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFgmH/Zk7bRHiMfYS+Xxtw/SbWntVSZR+ypKAh4iJ/jMxUgTm2Zo3KBur979Sdb4378IWRK3bG4idRMssQKGD6eTdgxUpqd5ZsMFC2KzXaVoZWGLU9UBlF2az3K8Bxq04KilqaS0QJ8PeSdKbnywsNGUNl5JYMJKVV0HukEKgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=nUqv9wqu; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:999c:0:640:51a7:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0D3ADC0160;
	Sat, 13 Sep 2025 20:38:29 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:18c::1:25] (unknown [2a02:6bf:8080:18c::1:25])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id QcR8381Gxa60-KvKXCijB;
	Sat, 13 Sep 2025 20:38:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1757785108;
	bh=fA7Y93+QrwkxY9vI/YYygrqSFpjxLSMGmbvV8jZjO80=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=nUqv9wqu13Cdl+4tFrH9dZMRMXjBzv4CSJp+5A4XZ9YPfSyZ3SzY6NUfxGqRwJ96Z
	 DOWKMPRn8x5QzCK5BqZzCt0g/6K5kf0EWMVwiXAzuaJ4fQi3noNQL5KxqOgqhSoHcy
	 605qWix8Coy+VkLORHp55Xp6KuEUvRo38dtD23pQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <20cbb02b-762f-4a3f-ba40-aae018388b3b@yandex-team.ru>
Date: Sat, 13 Sep 2025 20:38:24 +0300
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
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <84a52zy0iu.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 9:43 PM, John Ogness wrote:

> Hi Petr,
>
> Summary: printk() is not in danger but we should correct a loose bounds
> check.
>
> On 2025-09-12, Petr Mladek <pmladek@suse.com> wrote:
>> Honestly, I would really like to limit the maximal record size to
>> 1/4 of the buffer size. I do not want to make the design more
>> complicated just to be able to fill just one record, definitely.
> So I was able to track this down. Your usage of
>
> DEFINE_PRINTKRB(test_rb, 4, 4);
>
> actually made it relatively easy because there are only 16
> descriptors. All I needed to do was dump the descriptors before each
> reserve, between reserve and commit, after commit, and when reserve
> fails. This allowed me to easily see exactly how the ringbuffer is
> behaving.
>
> The problem can be reproduced with a single writer, no reader
> needed. Using
>
> #define MAX_RBDATA_TEXT_SIZE (0x256 - sizeof(struct prbtest_rbdata))
>
> provides a wild range of attempts that trigger the problem within about
> 20 write cycles.
>
> The problem comes from the function data_make_reusable(). The job of
> this function is to push the data_ring tail forward, one data block at a
> time, while setting the related descriptors to reusable.
>
> After pushing the tail forward, if it still has not pushed it far enough
> for new requested reservation, it must push it further. For this it
> _assumes the current position of the tail is a descriptor ID for the
> next data block_. But what if the tail was pushed all the way to the
> head? Then there is no next data block and it will read in garbage,
> thinking it is the next descriptor ID to set reusable. And from there it
> just goes crazy because it is reading garbage to determine how big the
> data block is so that it can continue pushing the tail (beyond the
> head!).
>
> Example: Assume the 96 byte ringbuffer has a single message of 64
> bytes. Then we try to reserve space for a 72-byte
> message. data_make_reusable() will first set the descriptor of the
> 64-byte message to reusable and push the tail forward to index 64. But
> the new message needs 72 bytes, so data_make_reusable() will keep going
> and read the descriptor ID at index 64, but there is only random garbage
> at that position. 64 is the head and there is nothing valid after it.

Good catch, although I'm not sure i understand why this produces the 
error Petr is seeing.

Why would it see garbage in a zeroed .bss buffer? Is this because of the 
previous test runs
dirtying the same data ring or something?

At least in my tests it seems like it would try to free a descriptor 
with an id of 0, which would result
in a "desc_miss", so it would basically fail to allocate anything.

Either way, I guess after your patch is accepted i'm going to resend 
mine to only strip the trailing id,
but the records must still be less than half of the data ring size so 
that data_make_reusable never
invalidates past the current head.

> This situation can never happen for printk because of your 1/4 limit
> (MAX_LOG_TAKE_PART), although it is over-conservative. It is enough to
> limit messages to 1/2 of the data ring (with Daniil's series). Otherwise
> the limit must be "1/2 - sizeof(long)" to also leave room for the
> trailing ID of a wrapping data block.
>
> I am still positive about Daniil's series. And we should fix
> data_check_size() to be provide a proper limit as well as describe the
> critical relationship between data_check_size() and
> data_make_reusable().
>
> I prefer not modify data_make_reusable() to handle this case. Currently
> data_make_reusable() does nothing with the head, so it would introduce
> new memory barriers. Also, the "push tail beyond head" scenario is a bit
> odd to handle. It is better just to document the assumption and put in
> the correct bounds checks.
>
> I will put together a patch without Daniil's series that improves the
> comments and puts a proper bound on data_check_size().
>
> John Ogness

