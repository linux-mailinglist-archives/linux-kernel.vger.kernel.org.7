Return-Path: <linux-kernel+bounces-817278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8615B58026
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A6D1AA7A53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856D334572E;
	Mon, 15 Sep 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C2WcLQgx"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5533EB1C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948893; cv=none; b=gIdz4EdDlw+q4Msl8AF0wYNOzbs6MDZrskv+rAY7C6ktnkwtev/l/LHvntUGEsE9GRK0ZOV6edW7U+zrwSDTIi9N1bYPO5aGExSK1SQ181uB7+ahTBnUtGkH5th45DlMLmRZ5CKqTYdKZAB8Bk1RioilUds1TADwfKM9DXQJVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948893; c=relaxed/simple;
	bh=dA6pA5Ne4a6f37qqveRmHhYYQ0u7mGdhS2lyQ8l6iYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkEaxgmnRtwTigCHYi6Q7spc57oYrt0ESoiNFJjEu9UQPqjwMZOREqF6GeLFx0tghT1/re30D8bd0zlCJQD2lpYpeJz4/irl65s1+Ib7JzkZc6MzDBgQ0Xr0BmwyhNpqO1rpkHgKJHs/WviMtq0ZSy+uGbfJyPNPcN1qgd4fGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C2WcLQgx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62f261a128cso2600767a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757948889; x=1758553689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=du4+Nj+caAcVXvPJNgMrcC6ifVmP95m7J9IIXq2HKA0=;
        b=C2WcLQgxqVs/afNY2WAaQx+itp9Fwmhf8dcLGDaVUIt/bB0SSr2aUdcVnkF+PQr+qz
         Gsd+wIwwVEHYPPyDdwa539oF6NrfR+0qLKE/GrzpuyIw1UXB9Yhlth4WzIwayph/brBy
         96IXpqW5iPCmxhMJwOFTuJNEDLPYa8P0QK7U0mvBygPzdhDyU8GKCeH6EHhTqbrjUN9s
         1QImby0WPC/FTIxEd5ToZBvrtsQrDQVCdlmv+5EeVPibnqkTI9MNGb6YiKmQyA0V7BbU
         mdzbo7meLtMihOLVJnQZN2KIQDyOVy/szDJzeuGw3L2lWLfR/hp3scERGX3onw7RolZd
         t1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948889; x=1758553689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du4+Nj+caAcVXvPJNgMrcC6ifVmP95m7J9IIXq2HKA0=;
        b=qGYeFLP7kILBd0n49nx1rPrqSk+38MwrVNu8G2RcA8PwSvjpHzH22Ykx2ZTzyk9SZ3
         /a17sauI1ypmqf9MBknbEawslrFFtioJSAsUYek1yf2SA6qHmSFvQJAOHC3C+JOGuUyT
         46VYmZhi5W+4boLtVKLpBjxoxnATwRdJqs/VvrTxbToiRuca/tzLc2oOVc5RfkLGXaL2
         bMVCQNUZIOfLqj27m36ixO5IygEl0ZMRfAqFcnq9kTliib7r0wIQdmCIy6FYmj/Rtaxd
         gpn2IK/ODaS7WgiwD3Ws4t2MnaF72j8GxAqrLGKakryzQB5OpJzRoOYDGavS+xKIULKY
         FXug==
X-Forwarded-Encrypted: i=1; AJvYcCWqzhxHEurOtMOJG9LWkcdWDEy9UicVNMFXtN7/ksFoxAU70o1I2+U6loKPOQM2DR9Lr7/Mwl4+aP//QGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSfMyhvs/MZI1AENRrVarbaZxr58vhScIZIWHNu+IzOCtnCcEq
	+cHtHTWfNcbX0AgGVE/Cd4cHiR83QPJx/XZWNI2/KCSjBPj892iRU6Mi/mpYKRkOavE=
X-Gm-Gg: ASbGncskFQHEuwYEAjvdZTOpgeq7ytOGvQbGd/BkEP7kRiyjtA8h+yYac7bDY89niqM
	ZEXkO4Fp75YKEXmnt78Pr0FruJHjHftHPGD+qfFUSZrNuAKa9khh+abkdlTCwTykcXj3/NuMTMR
	v+48AGjEYQcVjjQWLDB5wdZAoufZ+dWIjrQxmIFSdMaoZnk4cRfQ/g18AHqmbm2IpKOOgPntcwu
	YyoaoianveS6G8uB9kj/+DBxko8a8U8SW13jQnG5LEwHCVeJ3xVx9BNPrsdRwT5eHr1eLsMjFbw
	iCkQzI1asLB4GZzVVUi4N902isVLf2xWOdYQSfqLsAs7/Wk1ynjh4okEG+ZxSZxOnyyhmggIOA7
	rVHtCMCK2txqjzezJlSfMLRewUQ==
X-Google-Smtp-Source: AGHT+IHp7bre9yTzOjiuwtKXuWQuLVV8hu55jTM4h8oB41ShjrWoQvO8peRk3KA18ea9HgC70X3Rqg==
X-Received: by 2002:a05:6402:35cc:b0:62f:259f:af43 with SMTP id 4fb4d7f45d1cf-62f259fb180mr6223874a12.17.1757948889043;
        Mon, 15 Sep 2025 08:08:09 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f1a24d2ebsm4657344a12.10.2025.09.15.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:08:08 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:08:01 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aMgr0dId_UfBptzW@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz>
 <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de>
 <aMPm8ter0KYBpyoW@pathway.suse.cz>
 <aMPt8y-8Wazh6ZmO@pathway.suse.cz>
 <aMQzD9CLP1F01Rry@pathway.suse.cz>
 <84a52zy0iu.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84a52zy0iu.fsf@jogness.linutronix.de>

On Fri 2025-09-12 20:49:37, John Ogness wrote:
> Hi Petr,
> 
> Summary: printk() is not in danger but we should correct a loose bounds
> check.
> 
> On 2025-09-12, Petr Mladek <pmladek@suse.com> wrote:
> > Honestly, I would really like to limit the maximal record size to
> > 1/4 of the buffer size. I do not want to make the design more
> > complicated just to be able to fill just one record, definitely.
> 
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
> data block is so that it can continue pushing the tail (beyond the head!).
>
> Example: Assume the 96 byte ringbuffer has a single message of 64
> bytes. Then we try to reserve space for a 72-byte
> message. data_make_reusable() will first set the descriptor of the
> 64-byte message to reusable and push the tail forward to index 64. But
> the new message needs 72 bytes, so data_make_reusable() will keep going
> and read the descriptor ID at index 64, but there is only random garbage
> at that position. 64 is the head and there is nothing valid after it.

Great catch and example!

I wondered why data_make_reusable() needed to push the tail that far.
The buffer was empty after making the 64 bytes long message free.

My understanding is that it is combination of the following effects:

  1. The message is wrapped.

  2. The ring buffer does not support proper wrapping. Instead,
     the non-sufficient space at the end of the buffer stays
     unused (last wrap). And the messages will be written
     from the beginning of the buffer (next wrap).

      => the message will occupy more space than expected

	  unused space from last wrap + full message size in new wrap

In our case:

    + size of the buffer: 96
    + unused space in old wrap: 96 - 64 = 32
    + occupied space in new wrap: 72

    => total occupied space: = 32 + 72 = 104 > 96

    => lpos passed to data_push_tail() is from a never used space

    => This is why data_push_tail() tries to read
       descriptor from a never used space and reads a garbage

> This situation can never happen for printk because of your 1/4 limit
> (MAX_LOG_TAKE_PART), although it is over-conservative.

I would say that it is conservative. It would survive mistakes from the
off-by-one family, ... ;-)

And it is still far from practical limits. Because having this
powerful ring buffer for 1, 2, or 4 messages looks line an overkill.

> It is enough to limit messages to 1/2 of the data ring
> (with Daniil's series). Otherwise the limit must be
> "1/2 - sizeof(long)" to also leave room for the
> trailing ID of a wrapping data block.

I am not sure why it is important to push it to the limits.
That said, I could live with it. Especially how, when we
understood what happened.


> I am still positive about Daniil's series.

Yes, the patch which prevents wrapping for perfectly fitting messages
looks good to me.

> And we should fix
> data_check_size() to be provide a proper limit as well as describe the
> critical relationship between data_check_size() and
> data_make_reusable().

Yup.

> I prefer not modify data_make_reusable() to handle this case. Currently
> data_make_reusable() does nothing with the head, so it would introduce
> new memory barriers. Also, the "push tail beyond head" scenario is a bit
> odd to handle. It is better just to document the assumption and put in
> the correct bounds checks.

It might be possible to catch this in either in data_alloc().
or in get_next_lpos(). They could ignore/yell about when
the really occupied space would be bigger than DATA_SIZE(data_ring).

Something like:

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 17b741b2eccd..d7ba4c0d8c3b 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1056,8 +1056,16 @@ static char *data_alloc(struct printk_ringbuffer *rb, unsigned int size,
 	do {
 		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
 
-		if (!data_push_tail(rb, next_lpos - DATA_SIZE(data_ring))) {
-			/* Failed to allocate, specify a data-less block. */
+		/*
+		 * Double check that the really used space won't be bigger than
+		 * the ring buffer. Wrapped messages need to reserve more space,
+		 * see get_next_lpos.
+		 *
+		 * Specify a data-less block when the check or the allocation
+		 * fails.
+		 */
+		if (WARN_ON_ONCE(next_lpos - begin_lpos > DATA_SIZE(data_ring)) ||
+		    !data_push_tail(rb, next_lpos - DATA_SIZE(data_ring))) {
 			blk_lpos->begin = FAILED_LPOS;
 			blk_lpos->next = FAILED_LPOS;
 			return NULL;


Similar check would need to be done also in data_realloc().

I am not sure if it is worth it. Maybe, we could rule this out
when we limit the allocated size to 1/2 or 1/4 of the ring buffer size.

Best Regards,
Petr

