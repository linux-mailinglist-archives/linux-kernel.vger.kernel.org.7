Return-Path: <linux-kernel+bounces-890329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD3C3FD16
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302391894C20
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C87532143E;
	Fri,  7 Nov 2025 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P7aHNV3j"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4D2E0413
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516122; cv=none; b=BD9yJi5I9m5BKgOdWNyFbYE0FEzYCVVRupCzAyK4ANZ/wZF0SAE/KYXs9y8R76kGhXtq8bDMM2beoqSb7SOU+Wbk8QlkelgoNyrnbYRpgYTByXxDvcRGMKRRyKm5HGuBuN8KM67VP4dhC8OIRGE7MvkSDbkHwY/mpuTgCCyDVjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516122; c=relaxed/simple;
	bh=2RT+fnmoZ4nfvY5zlKMIbHcZWAoZa52HOltas4MhZt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCthmCDekvr5aaPE6elX9b5xzgL3xc+JJxFgEfkmeAE9DL0EVU+YhfHL3F3kgbG7YYSE1OTxQHlg4nKj9FwyXI31itER6xJkG6Le8ujkoufcZus8SdM7w4cGCYiZkqCDPsQl9uyeP9g14TQXB0t80WWGbnQ0rcQoeP2bqf4I3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P7aHNV3j; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b729f239b39so141869666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762516118; x=1763120918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0btHuhgoXf1JIAcsuz3z0Yh6Fl6KHmjrhbtAp1FpJMM=;
        b=P7aHNV3jloCek62WlFnRJC//16l643rNzJTBMrkq1gPlA0uuTXC7AbsP45doGVFfhu
         Z/N8J+9MPHUJRsbju0gzwa0ysNiaTsWeCtMey6l0kTYs0n3a9TlDrrGRWwSnDEYzy6xt
         00Yumg9eWeosEb3cErFvH1MWXqBBEFt9s6/GH97dkfTNYsNU1rqcv2w8zdDL+9dWRuYz
         7SO8UrDtP9r1/XyEUB0CEzDxHp/ps7Hlavt9TKmLVHt1ffO5Voja9tpg75wbnxqX/E1J
         8ylaWqv1+HrKj8+/nhBq+EmD9qganj8UktR6clILHy2r/qAGlNI0ryvgMkVlTfw2v6ci
         yjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762516118; x=1763120918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0btHuhgoXf1JIAcsuz3z0Yh6Fl6KHmjrhbtAp1FpJMM=;
        b=Qe13oiMrbM2FlMuKU+H8JDEYoDDspBHblSZtrDMa/PTfS20HxWKj2KbO9QjTIun4wP
         6ZYyuYsSzVF//C/Ofc35DCOxntQSUf4VgNbsPLi78nKHs+z1aox9YS3S0m6z31w3KB8d
         t+AEwNQQ/r4SWyxO7CfuJ+1JsWwhcZW75hd4LH9PM68V332Yy+S5op2LlSnOkoH0s6Eu
         VuBqExS6Qa5Qpkm3U+OMg0NDjn7AtqunUBbJr20G0p7bMAWuTObshqobZpam6z42jRQy
         z77pJfDDPhDrInvFpMdVhRWPYZ09F1WYN4cte6/FpKuBWUlJE7aT+Vy0a3Y2qnazQBkY
         PDhw==
X-Forwarded-Encrypted: i=1; AJvYcCV+g6f68nfP8iSz5GIEUqZ9uml84CCJ+cj+JemEyd3TAY6VwXvk+HUgUZeMT3SRgQnqYZekRI58oF3oNLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzldPTkShOOpWNjCxRNY/FrWCP1+WHHO/+GYsf+6+MAkLcLQlsl
	uM/HEMQzJ6yEa6mPWoEuOk9I8+GBHd5JRbbX/rqzSc3ug4n1/MU5Da6hMSZ/fopgHbc=
X-Gm-Gg: ASbGncvS58rxWjUlrKzjRJPD3Ip4+4x3mxkYUL1BM2dGlqVcnQrQ7P/Mstw3a++/9Sy
	19yVOjCKq4jH1PcXYaDN3QbpSdO9Vo/STd4OYFgsZiRbp2PY5FLaw/kq7AypB2s2u04ZqkX++a8
	msmhTxdF8RNAhLAVaW6QEmekBBjqkdEuLU6ZyJfCbasHOYiJlzqJF5yV+f+V2wZqNxbrpoQcSnM
	+hbzw4wrJM8XBb5jTh3o1cTd4yh3C3nzog6KYkA3jjFptb+B8Slcx585akKg9xAGCvCB2Am18FM
	JWWfSQRt4Oy92jz4/6jyrcrcr9xULeAwztAkn8c37xVUqe0bAEnTUvW/TXBhlxGaVynFWzUkO0/
	wbAQ/sQY8pEVm0mj6czroE6m9CpbzaWrxn8EOmRyF0I9nj9874ThBjOPieZARx/mcnWA60SNu6B
	IuCxTIFlstEaHJ4CGtgFGJq2TD
X-Google-Smtp-Source: AGHT+IEokWk1ZSxMf9gnaVqeMhezk2Opyg5SPlA30ekZY/SCq/nzbaLIFzm2m4+Eq/H2tXmxOh/49A==
X-Received: by 2002:a17:907:9489:b0:b72:c103:88da with SMTP id a640c23a62f3a-b72d0adb87bmr177003966b.26.1762516117816;
        Fri, 07 Nov 2025 03:48:37 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d3baf872sm85014366b.27.2025.11.07.03.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:48:37 -0800 (PST)
Date: Fri, 7 Nov 2025 12:48:35 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	syzbot <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>,
	"amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
	brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
Message-ID: <aQ3ck9Bltoac7-0d@pathway.suse.cz>
References: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
 <69096836.a70a0220.88fb8.0006.GAE@google.com>
 <CAJnrk1Yo4dRVSaPCaAGkHc+in03KaTXJ+KxckhLoSrRxbEdDBg@mail.gmail.com>
 <aQpFLJM96uRpO4S-@pathway.suse.cz>
 <87ldkk34yj.fsf@jogness.linutronix.de>
 <aQuABK25fdBVTGZc@pathway.suse.cz>
 <87bjlgqmk5.fsf@jogness.linutronix.de>
 <87tsz7iea2.fsf@jogness.linutronix.de>
 <aQzLX_y8PvBMiZ9f@pathway.suse.cz>
 <87h5v73s5g.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5v73s5g.fsf@jogness.linutronix.de>

On Thu 2025-11-06 20:04:03, John Ogness wrote:
> On 2025-11-06, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> >> index 839f504db6d30..8499ee642c31d 100644
> >> --- a/kernel/printk/printk_ringbuffer.c
> >> +++ b/kernel/printk/printk_ringbuffer.c
> >> @@ -390,6 +390,17 @@ static unsigned int to_blk_size(unsigned int size)
> >>  	return size;
> >>  }
> >>  
> >> +/*
> >> + * Check if @lpos1 is before @lpos2. This takes ringbuffer wrapping
> >> + * into account. If @lpos1 is more than a full wrap before @lpos2,
> >> + * it is considered to be after @lpos2.
> >
> > The 2nd sentence is a brain teaser ;-)
> >
> >> + */
> >> +static bool lpos1_before_lpos2(struct prb_data_ring *data_ring,
> >> +			       unsigned long lpos1, unsigned long lpos2)
> >> +{
> >> +	return lpos2 - lpos1 - 1 < DATA_SIZE(data_ring);
> >> +}
> >
> > It would be nice to describe the semantic a more clean way. Sigh,
> > it is not easy. I tried several variants and ended up with:
> >
> >    + using "lt" instead of "before" because "lower than" is
> >      a well known mathematical therm.
> 
> I explicitly chose a word other than "less" or "lower" because I was
> concerned people might visualize values. The lpos does not necessarily
> have a lesser or lower value. "Preceeds" would also be a choice of mine.

The word "before" was fine. I proposed "lt" because it was shorter and
I wanted to add "le" variant. I wanted to keep it short also because I
wanted to add another suffix to make it obvious that there was
the twist with wrapping.


> When I see "lt" I immediately think "less than" and "<". But I will not
> fight it. I can handle "lt".
> 
> >    + adding "_safe" suffix to make it clear that it is not
> >      a simple mathematical comparsion. It takes the wrap
> >      into account.
> 
> I find "_safe" confusing. Especially when you look at the implementation
> you wonder, "what is safe about this?". Especially when comparing it to
> all the complexity of the rest of the code. But I can handle "_safe" if
> it is important for you.

OK, forget "_safe". The helper function should make the code more
clear. And it won't work when even you or me are confused.

I though about "_wrap" but it was confusing as well. The code uses
the word "wrap" many times and it is always about wrapping over
the end of the data ring, for example, DATA_WRAPS() computes how
many times the data array was filled [*].

But in this case, data_make_reusable(), and data_push_tail(),
the edge for wrapping is a moving target. It is defined by
data_ring->head_lpos and data_ring->tail_lpos.

[*] It is not the exact number because it is computed from lpos
    which is not initialized to zero and might overflow.

> > Something like:
> >
> > /*
> >  * Returns true when @lpos1 is lower than @lpos2 and both values
> >  * are comparable.
> >  *
> >  * It is safe when the compared values are read a lock less way.
> >  * One of them must be already overwritten when the difference
> >  * is bigger then the data ring buffer size.
> 
> This makes quite a bit of assumptions about the context and intention of
> the call. I preferred my brain teaser version. But to me it is not worth
> bike-shedding. If this explanation helps you, I am fine with it.

My problem with the "brain teaser" version is the sentence"

  "If @lpos1 is more than a full wrap before @lpos2,
   it is considered to be after @lpos2."

It says what it does but it does not explain why. And the "why"
is very important here.

I actually think that the sentence is misleading. If @lpos1 is more
than a full wrap before @lpos2 it is still _before_ @lpos2!

Why we want to return "false" in this case? My understanding is
that it is because we want to break the "while" cycle where
the function is used because we are clearly working with
outdated lpos values.

What about?

/*
 * Return true when @lpos1 is lower than @lpos2 and both values
 * look sane.
 *
 * They are considered insane when the difference is bigger than
 * the data buffer size. It happens when the values are read
 * without locking and another CPU already moved the ring buffer
 * head and/or tail.
 *
 * The caller must behave carefully. The changes based on this
 * check must be done using cmpxchg() to confirm that the check
 * worked with valid values.
 */
static bool lpos1_before_lpos2_sane(struct prb_data_ring *data_ring,
				    unsined long lpos1, unsigned long lpos2)
{
	return lpos2 - lpos1 - 1 < DATA_SIZE(data_ring);
}

Feel free to come up with any other function name or description.
Whatever you think that is more clear. but I have a favor to ask you to:

  + explain why the function returns false when the difference is
    bigger that the data buffer size.

  + ideally avoid the word "wrap" because it has another meaning
    in the printk ring buffer code as explained earlier.


> >>  /*
> >>   * Sanity checker for reserve size. The ringbuffer code assumes that a data
> >>   * block does not exceed the maximum possible size that could fit within the
> >> @@ -577,7 +588,7 @@ static bool data_make_reusable(struct printk_ringbuffer *rb,
> >>  	unsigned long id;
> >>  
> >>  	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
> >> -	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
> >> +	while (lpos1_before_lpos2(data_ring, lpos_begin, lpos_end)) {
> >
> > lpos1_lt_lpos2_safe() fits here.
> >
> >>  		blk = to_block(data_ring, lpos_begin);
> >>  		/*
> >> @@ -668,7 +679,7 @@ static bool data_push_tail(struct printk_ringbuffer *rb, unsigned long lpos)
> >>  	 * sees the new tail lpos, any descriptor states that transitioned to
> >>  	 * the reusable state must already be visible.
> >>  	 */
> >> -	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
> >> +	while (lpos1_before_lpos2(data_ring, tail_lpos, lpos)) {
> >>  		/*
> >>  		 * Make all descriptors reusable that are associated with
> >>  		 * data blocks before @lpos.
> >
> > Same here.
> >
> >> @@ -1149,7 +1160,7 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
> >>  	next_lpos = get_next_lpos(data_ring, blk_lpos->begin, size);
> >>  
> >>  	/* If the data block does not increase, there is nothing to do. */
> >> -	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {
> >> +	if (!lpos1_before_lpos2(data_ring, head_lpos, next_lpos)) {
> >
> > I think that the original code was correct. And using the "-1" is
> > wrong here.
> 
> You have overlooked that I inverted the check. It is no longer checking:
> 
>     next_pos <= head_pos
> 
> but is instead checking:
> 
>     !(head_pos < next_pos)
> 
> IOW, if "next has not overtaken head".

I see. I missed this. Hmm, this would be correct when the comparsion was
mathemathical (lt, le). But is this correct in our case when take
into account the ring buffer wrapping?

The original check returned "false" when the difference between head_lpos
and next_lpos was bigger than the data ring size.

The new check would return "true", aka "!false", in this case.

Hmm, it seems that the buffer wrapping is not possible because
this code is called when desc_reopen_last() succeeded. And nobody
is allowed to free reopened block.

Anyway, I consider using (!lpos1_before_lpos2()) as highly confusing
in this case.

I would either keep the code as is. Maybe we could add a comment
explaining that

	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {

might fail only when the substraction is negative. It should never be
positive because head_lpos advanced more than the data buffer size
over next_lpos because the data block is reopened and nobody could
free it.

Maybe, we could even add a check for this.


> > Both data_make_reusable() and data_push_tail() had to use "-1"
> > because it was the "lower than" semantic. But in this case,
> > we do not need to do anything even when "head_lpos == next_lpos"
> >
> > By other words, both data_make_reusable() and data_push_tail()
> > needed to make a free space when the position was "lower than".
> > There was enough space when the values were "equal".
> >
> > It means that "equal" should be OK in data_realloc(). By other
> > words, data_realloc() should use "le" aka "less or equal"
> > semantic.
> >
> > The helper function might be:
> >
> > /*
> >  * Returns true when @lpos1 is lower or equal than @lpos2 and both
> >  * values are comparable.
> >  *
> >  * It is safe when the compared values are read a lock less way.
> >  * One of them must be already overwritten when the difference
> >  * is bigger then the data ring buffer size.
> >  */
> > static bool lpos1_le_lpos2_safe(struct prb_data_ring *data_ring,
> > 				unsined long lpos1, unsigned long lpos2)
> > {
> > 	return lpos2 - lpos1 < DATA_SIZE(data_ring);
> > }
> 
> If you negate lpos1_lt_lpos2_safe() and swap the parameters, there is no
> need for a second helper. That is what I did.

Sigh, lpos1_le_lpos2_safe() does not say the truth after all.
And (!lpos1_lt_lpos2_safe()) looks wrong to me.

I am going to wait what you say about my comments above.

> >> @@ -1262,7 +1273,7 @@ static const char *get_data(struct prb_data_ring *data_ring,
> >>  
> >>  	/* Regular data block: @begin less than @next and in same wrap. */
> >>  	if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
> >> -	    blk_lpos->begin < blk_lpos->next) {
> >> +	    lpos1_before_lpos2(data_ring, blk_lpos->begin, blk_lpos->next)) {
> >
> > Hmm, I think that it is more complicated here.
> >
> > The "lower than" semantic is weird here. One would expect that "equal"
> > values, aka "zero size" is perfectly fine.
> 
> No, we would _not_ expect that zero size is OK, because we are detecting
> "Regular data blocks", in which case they must _not_ be equal.

It seems that you have more or less agreed with my proposal to
use  check_data_size() in the other replay, see
https://lore.kernel.org/all/87ecqb3qd0.fsf@jogness.linutronix.de/

I think about fixing this in a separate patch and pushing this
into linux-next ASAP to fix the regression.

We could improve the other comparisons later...

How does that sound?
Should I prepare the patch for get_data() are you going to do so?

Best Regards,
Petr

