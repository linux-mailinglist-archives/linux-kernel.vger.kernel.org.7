Return-Path: <linux-kernel+bounces-817375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DF9B5816D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A8A1AA15DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDE915746F;
	Mon, 15 Sep 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MXunCQu2"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832CDEAD7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952054; cv=none; b=TfUCHda/NPs+qvAIu/tfcxzg0ld7IHFRcAnJ83vXDFai7DV4Uh6o+ygZD6zmhU7uwKkT8k70s8X5aRDzN8xaLaKB+/cUxHPJVJwQaPwVVx5d/vow76lE4sZqbYLif8VdMGxZuLFxFw30f3igdJnf5pYZit+9UltPPmGWwJoaqGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952054; c=relaxed/simple;
	bh=Bbg6CNM7Bw/CS33vcYruBZ7ya2Cshrz1DLgdLEadAko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ5+oD1GUrUVypsYTHMINKkIDYaCyWwF+7+bOZHGfVqRHhv9kVaY5ZGUbujuJvKf+1QyORYdBCEB7BlTrmFy8CRZfhFOrYqTzZlVsrNYcuJC8Ka9ayesaxX/A9tFJl2QO02EwhMqDm41s+Qb44d/CNeWqsDcd2fspv7AVFm2km0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MXunCQu2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62f1987d493so3780207a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757952051; x=1758556851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPYt5tu70fOZxFIZ/y40Vmiiirj+RoECgdrHrGYHWTE=;
        b=MXunCQu2uQT9G3jFc0o1nUuVIN3u6Ub61qTgUH931Ka85h9LjTiLl0N3nNPksY1iEn
         z8VnGuT6hGDmHHl3cvKnzqAWaIrlOJljV3Av28PCwXgcqCvcI55fUjNAaWNkYZ7qfSRA
         gpuN8z2kWtr7J3UJwqLFuvlgcUwimu9eGuWg5JpGN+ttGjUfbJAkfUHGvJCHj2SQ4VQi
         aTF7buMgMLs2hatswBTgbESV60D057nZFowePSh31TVEyTmbo/xNdkyKyT9YPpVrqw8q
         SSOanweaNmlOVnjl6BTg1s75oUCbojkBQI0TSHgMEyAypIUDi51RoivX0KWU0iq8GzYk
         Gwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952051; x=1758556851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPYt5tu70fOZxFIZ/y40Vmiiirj+RoECgdrHrGYHWTE=;
        b=a2BADrN5j3t9FFYZprMDV/mgusZQpvagVA2cWQYbaQ63YlQDDW5Sky5ayMVVm18Kuv
         gWItNRDYJg+9nefvVfkh5upWRL1+q3V5wmZsJblReEPvYsQlj7xfG6nAStfTmCpZV8b0
         Cx6pywpGKuNVDjHAzDEjwTpFx0pGjhprJ38orsNqkRAxpSrVAYzXiYZ15/YkqkfXkS9b
         KnR+23zg4FXURBUJaVUS6IQ0hJp7oinS9H/jmgH/M4K+L82+VR++iWecE9NQ+1+cUE62
         G4FUrXOV8xVI9hjrpbDeixx4J0kMRU/XxtP0hajqCwjkMIAUxxJjUIkP3UTo+2R6y+UK
         798A==
X-Forwarded-Encrypted: i=1; AJvYcCVNAxzjyIm/WJnwQcHo0VnQ3q7PQJY4Hz5FJ0qe3N3aCpWknuytHyBHe5lOZo9kGPBSBPKAggdTSlRLGPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMqBKUmmUerLsZF57x8uVWgslY3UumBFJpZSOLmNqk4Rxun8A
	Gptb8H/pOVNjJBe/zlaoAndF5DooexE+xFcrLPoFlyWAaI92Gna/hrHDzKCresjPimU=
X-Gm-Gg: ASbGncuQ6Cw3+0jCbX08PQC89Nx6BwDcWtOiZJF/TcItkpmscG44E9LtvTnAWWChacS
	j7T8nIMfvEm8TNFv8dWeKtGxGRNyzHQHgWylYWLF5RZt3hwmiRWqiUQGG8RztjtG/d573hjeJSq
	/iA6tr1JhptmvX+O2vNeY1MjIEGv1t9l0u7QrETskdEvux+Xyy69Av+CJlNdhvEn6gOBUhJjpwV
	9me3rCyYM1cjYQZTf/wNkEiaSfNNQcX8rxQKL5IXDKF9LtcgN7ZuxcXH41DyolHzFcS1a68iwnE
	FyluUNxjlsTAMvOoQdjJaejFslj7MH9eI6RNkWMgl/PPogq/64m+q4BraObUyJoRixYCFvfTs4K
	L9evVd7NHD+jfT4GIR580aig2kA==
X-Google-Smtp-Source: AGHT+IHKXKNRmKCKq8i9YFRC5qxvF4LE01wbDzpQwt2CPNUz0Qg9K5a7MeBFSA0yQYYOUF6YrV9bzQ==
X-Received: by 2002:a05:6402:2352:b0:62f:4b7b:4949 with SMTP id 4fb4d7f45d1cf-62f4b7b4d60mr2922975a12.10.1757952050665;
        Mon, 15 Sep 2025 09:00:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f317bf9f0sm3155475a12.49.2025.09.15.09.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:00:50 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:00:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aMg4MJU9JZ0QPYTn@pathway.suse.cz>
References: <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de>
 <aMPm8ter0KYBpyoW@pathway.suse.cz>
 <aMPt8y-8Wazh6ZmO@pathway.suse.cz>
 <aMQzD9CLP1F01Rry@pathway.suse.cz>
 <84a52zy0iu.fsf@jogness.linutronix.de>
 <20cbb02b-762f-4a3f-ba40-aae018388b3b@yandex-team.ru>
 <84348pqtej.fsf@jogness.linutronix.de>
 <fece29ff-070e-4074-85be-4093a3000e5d@yandex-team.ru>
 <84wm5z7o14.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84wm5z7o14.fsf@jogness.linutronix.de>

On Mon 2025-09-15 17:13:03, John Ogness wrote:
> On 2025-09-14, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> >> After applying your patch, can you provide an example where a maximum
> >> size of exactly half causes the tail to be pushed beyond the head? Keep
> >> in mind that data_check_size() accounts for the meta-data. It only
> >> doesn't account for the extra ID on wrapping data blocks.
> >
> > Sorry, I think exactly half is fine, basically we can keep it half, but 
> > only remove the tailing id check with my patch.
> 
> I have been investigating this further. Even _without_ your patches, I
> cannot find (either by using my brain or through testing) a problem with
> limiting it to exactly half:
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index bc811de18316b..9d47c1b94b71f 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -398,8 +398,6 @@ static unsigned int to_blk_size(unsigned int size)
>   */
>  static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>  {
> -	struct prb_data_block *db = NULL;
> -
>  	if (size == 0)
>  		return true;
>  
> @@ -408,11 +406,7 @@ static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>  	 * array. The largest possible data block must still leave room for
>  	 * at least the ID of the next block.
>  	 */
> -	size = to_blk_size(size);
> -	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
> -		return false;
> -
> -	return true;
> +	return (to_blk_size(size) <= (DATA_SIZE(data_ring) / 2));
>  }
>  
>  /* Query the state of a descriptor. */
> 
> When invalidating a data block (pushing the tail) it only must be
> certain that the newly created space is large enough to fit the new data
> block.
> 
> With a maximum of half, a new non-wrapping data block will always
> fit. If it is a wrapping data block the worst case is if it is maximally
> sized and ends exactly at the end of the array. In the case, it is
> placed at index 0. But there it will only free up until the head
> value. (If the head value was less, the data block would not have
> wrapped.)

I could confirm this by my findings. By other words, a record which
needs half of the ring buffer will always fit into the ring buffer
even when it is wrapped and occupies also some unused space from
the previous wrap.

In the worst case, the unused space might be half of the ring buffer.
In this case, it would be the perfectly fitting record which would
be wrapped now. But it would be stored in the 2nd half of the ring
buffer with fix by the 1st patch from this patchset.

By other words, it would be enough to invalidate all existing
entries. data_alloc()/data_realloc() would never ask
data_push_tail() to push tail_lpos in front of head_lpos.

> Your series handles the "ends exactly at the end of the array" case by
> avoiding the need to wrap and thus invalidate up to half the
> ringbuffer. But your series does not affect the maximum record size.
> 
> I will submit an official patch that also improves the comments to
> clarify exactly why the limit exists.
> 
> @Petr: I am fine with you keeping our 1/4 limit in printk.c. But I would
> like the ringbuffer code to be exactly proper here.

Fair enough.

To make it complete. I wondered about the reader API. But it seems
to be safe as well.

The reader API seems to be safe as long as there is at least
one descriptor in reserved state (empty ring buffer is handled
special way).

And prb_reserve() _does reserve_ a descriptor before allocating
the data. It means that a descriptor is in a reserved state
before other descriptors are made reusable to free the space.

It means that at least one descriptor is in a reserved state
even when others are reusable. And it means that _prb_read_valid()
exits in this descriptor because prb_read() returns -EINVAL...

Best Regards,
Petr

