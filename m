Return-Path: <linux-kernel+bounces-863601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 833B8BF8463
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3146F356ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C8271441;
	Tue, 21 Oct 2025 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34gvDIYm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D7ERKdmk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B026F477
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075256; cv=none; b=Q1ntuVWfQGZpvqfwRs1VRq3jALq4u8PujznvjMlMnNmpW+wD5rCBpYJHRSV6YcVpOsqZfx+B3Apjv7ZmSI892FwvR5FTk8eyH0LcR1WHYNSAasVtov776fnWEe3rcymuBH0bGpigRjfirzb4EfWPkqcW81dqExXypPhuHihvv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075256; c=relaxed/simple;
	bh=WMkVzCHb/pcFbkhVA6vjN1ycycnndL0cxlAL9SzTFy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OVwCJyOInqN/5x5TD3lTQHMYR40wiXXslLOaxrkLJWyW0jqGJ2UsDX6IKDdLbWghzt69ql9IsUsXpUiB49LpOZFBtDIq3k9dcJqH4vBcsFV84715lHm9r0UhfGVYGD6BoihTZQJ/AjasiMycEprioJ/Wt+BY/craJjFO7KoFmIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34gvDIYm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D7ERKdmk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761075251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCVeSrJNNtYjD79kUZsMuEgap1A7KQye/Hxn2Fcry1s=;
	b=34gvDIYm/MQITbz7+4egNKkE4eVdMukAqRWKx1KO9Jw202J1ov+FoCZKH/GQeUN86Mvc1Q
	D9wMDqu6oxqYpVNFMyLmvo8z/YataxJeRyRU3uNOxzA5BBpElIS6lzoxBdTGQqi38qv19S
	y07R6jLZE+C9qoY8JdgjKz/ZqNSnHgLbWy4kOC6vaorh2dkn1iTvKrDArleN5MPMaGbhiX
	96PrOqTHNKY2HDTWQjR+WPcFlwUoY0UgopSh2ZPqqj+kO1bFK1HT7ZSrDJqgFM7RMwnx6+
	GOOafTBDq1q8P1DKq9qhRjSRUuti+EUw2dDL8Rx+Ngx2oP60cb/E57ZVshLWyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761075251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCVeSrJNNtYjD79kUZsMuEgap1A7KQye/Hxn2Fcry1s=;
	b=D7ERKdmkLc9fVQG1wvFKGcbSQJYvjB5DGsc0RcDDlLdU5L7839lB8PwuG74KvBueNpKnWS
	tA1d13YA9WgARECQ==
To: Yury Norov <yury.norov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Gabriele Monaco <gmonaco@redhat.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 07/19] cpumask: Introduce cpumask_or_weight()
In-Reply-To: <aO_c3lTmvJyzsOdE@yury>
References: <20251015164952.694882104@linutronix.de>
 <20251015172834.757776587@linutronix.de> <aO_c3lTmvJyzsOdE@yury>
Date: Tue, 21 Oct 2025 21:34:09 +0200
Message-ID: <87plagxd5a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yury!

On Wed, Oct 15 2025 at 13:41, Yury Norov wrote:
> On Wed, Oct 15, 2025 at 07:29:36PM +0200, Thomas Gleixner wrote:
>> +unsigned int __bitmap_or_weight(unsigned long *dst, const unsigned long *bitmap1,
>> +				const unsigned long *bitmap2, unsigned int bits)
>> +{
>> +	unsigned int k, w = 0;
>> +
>> +	for (k = 0; k < bits / BITS_PER_LONG; k++) {
>> +		dst[k] = bitmap1[k] | bitmap2[k];
>> +		w += hweight_long(dst[k]);
>> +	}
>> +
>> +	if (bits % BITS_PER_LONG) {
>> +		dst[k] = bitmap1[k] | bitmap2[k];
>> +		w += hweight_long(dst[k] & BITMAP_LAST_WORD_MASK(bits));
>> +	}
>> +	return w;
>> +}
>
> We've got bitmap_weight_and() and bitmap_weight_andnot() already. Can
> you align naming with the existing scheme: bitmap_weight_or().

That's not the same thing. bitmap_weight_and/not() calculate the weight
of the AND resp. ANDNOT of the two bitmaps w/o modifying them:

   for (...)
       w += hweight(map1[k] & map2[k]);

While the above does:

   for (...) {
       dst[k] = map1[k] | map2[k];
       w += hweight(dst[k]);
   }

The whole point of this as explained in the change log is to avoid
walking the resulting bitmap after doing the OR operation. The compiler
is clever enough to do the or operation in a register, write it to dst
and then do the hweight calculation with it.

> Also, for outline implementation, can you employ the BITMAP_WEIGHT()
> macro?

If you insist on this ugly:

  return BITMAP_WEIGHT(({dst[idx] = bitmap1[idx] | bitmap2[idx]; dst[idx]; }), bits);

Sure.

Thanks,

        tglx

