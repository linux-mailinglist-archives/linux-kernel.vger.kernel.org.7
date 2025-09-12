Return-Path: <linux-kernel+bounces-814618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B9B55685
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C04BA0B28
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C94D3314AC;
	Fri, 12 Sep 2025 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WxHKhmQf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uiDFXvs6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E741CAA4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702622; cv=none; b=e+JnIVgFpoIr0IjGX7h2kAL/ecifnF1DCrb9RGONtove8igLKNjwPmA4umoS7K2pJL209o0zZVg5/zZGKwjH2lkstCGVePXrVOYo5fDb2bdElXwOV0aUZbxE5iO/8gbx7Xv19CzYxRT1S2zvI8viJV+hWPK7vyKzs309Fg7g1tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702622; c=relaxed/simple;
	bh=rV7M/lGDOKSdyyhOHWm6CNoeXtGMBwsOvrzFtaayK3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rwW7mOdc3yWpJLF9fKHM6nYvuZn02OqHlCwebyfGvh6SQux6s/19dU/zG3iZgg/3O8V+vcwAwgjnBgq602T4eyTMHLMiZuJyk655eWJOjj4/UNXxtG9cQmjuGiDOjN/fxg95FSqerN6VDf2fygjkpsMw2UX69OkKyKdMIZVz1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WxHKhmQf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uiDFXvs6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757702618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rV7M/lGDOKSdyyhOHWm6CNoeXtGMBwsOvrzFtaayK3A=;
	b=WxHKhmQf5IHA/2/oi6B+DHlxuTuhCzu45o+skNSAxbQLJ8tZt9zVQgF3hPOA27oqISIwfk
	gMP62N73g7m5v0P1jWCOjSpCwy2LgcRJyvT/EGuEXuZ+48G5r3UHqwWCuX5GqSz0Cb7tcG
	y6BP44k7mGwUrTI4Wrf1HW6nTpBjZ2e/w0G+Ulr3Ixn3nvjJ5YKaqc+/ZLPuCMaLzK9CKL
	bmV7n5foLFRKRjDMtlBrY3APs5kvj5Fl1OY03lMMUuM3+idPwp8dPlX8hmo/owBdciD5oT
	rVdkBVxmCkxoJe9fC2moVWknb1ijpLUPH7Ej/n/+gjEWwf0O7yqHR8tAoJNW/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757702618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rV7M/lGDOKSdyyhOHWm6CNoeXtGMBwsOvrzFtaayK3A=;
	b=uiDFXvs6UBRFsnkBwIqrEpdwgIHAlc1N4T9eTJOjJy0Hz2ibzVSgkJPjgylVVCDAjSwZCq
	PBHd0opKtUg5EKBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
In-Reply-To: <aMQzD9CLP1F01Rry@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz> <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de> <aMPm8ter0KYBpyoW@pathway.suse.cz>
 <aMPt8y-8Wazh6ZmO@pathway.suse.cz> <aMQzD9CLP1F01Rry@pathway.suse.cz>
Date: Fri, 12 Sep 2025 20:49:37 +0206
Message-ID: <84a52zy0iu.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Petr,

Summary: printk() is not in danger but we should correct a loose bounds
check.

On 2025-09-12, Petr Mladek <pmladek@suse.com> wrote:
> Honestly, I would really like to limit the maximal record size to
> 1/4 of the buffer size. I do not want to make the design more
> complicated just to be able to fill just one record, definitely.

So I was able to track this down. Your usage of

DEFINE_PRINTKRB(test_rb, 4, 4);

actually made it relatively easy because there are only 16
descriptors. All I needed to do was dump the descriptors before each
reserve, between reserve and commit, after commit, and when reserve
fails. This allowed me to easily see exactly how the ringbuffer is
behaving.

The problem can be reproduced with a single writer, no reader
needed. Using

#define MAX_RBDATA_TEXT_SIZE (0x256 - sizeof(struct prbtest_rbdata))

provides a wild range of attempts that trigger the problem within about
20 write cycles.

The problem comes from the function data_make_reusable(). The job of
this function is to push the data_ring tail forward, one data block at a
time, while setting the related descriptors to reusable.

After pushing the tail forward, if it still has not pushed it far enough
for new requested reservation, it must push it further. For this it
_assumes the current position of the tail is a descriptor ID for the
next data block_. But what if the tail was pushed all the way to the
head? Then there is no next data block and it will read in garbage,
thinking it is the next descriptor ID to set reusable. And from there it
just goes crazy because it is reading garbage to determine how big the
data block is so that it can continue pushing the tail (beyond the
head!).

Example: Assume the 96 byte ringbuffer has a single message of 64
bytes. Then we try to reserve space for a 72-byte
message. data_make_reusable() will first set the descriptor of the
64-byte message to reusable and push the tail forward to index 64. But
the new message needs 72 bytes, so data_make_reusable() will keep going
and read the descriptor ID at index 64, but there is only random garbage
at that position. 64 is the head and there is nothing valid after it.

This situation can never happen for printk because of your 1/4 limit
(MAX_LOG_TAKE_PART), although it is over-conservative. It is enough to
limit messages to 1/2 of the data ring (with Daniil's series). Otherwise
the limit must be "1/2 - sizeof(long)" to also leave room for the
trailing ID of a wrapping data block.

I am still positive about Daniil's series. And we should fix
data_check_size() to be provide a proper limit as well as describe the
critical relationship between data_check_size() and
data_make_reusable().

I prefer not modify data_make_reusable() to handle this case. Currently
data_make_reusable() does nothing with the head, so it would introduce
new memory barriers. Also, the "push tail beyond head" scenario is a bit
odd to handle. It is better just to document the assumption and put in
the correct bounds checks.

I will put together a patch without Daniil's series that improves the
comments and puts a proper bound on data_check_size().

John Ogness

