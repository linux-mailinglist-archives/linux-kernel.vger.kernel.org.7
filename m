Return-Path: <linux-kernel+bounces-844453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2563BC1F38
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E90C4F020B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDE72550CA;
	Tue,  7 Oct 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hKZR+JS0"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507D42AA3
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851535; cv=none; b=slMqMgTKyWdzikyzOzPMDrySE4oLFC8pNe6eqHgUjN/DnaOuJ2NZaGnysFObe+xfuVEpkrgL+7c0kYnM85MV7ZoY4IMnAfrEgAuRW6nOOcfT3cgKpdmcIJBXWhg7eyQ+jskQR82Lrl9Fq6WTC2EaJEtXAZU3lRyU4OtPZoVAsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851535; c=relaxed/simple;
	bh=IkglkFhprcmxSSa8IxTpfv5+R+pi6Ge8oV5Y4zYkNzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soHvO9A/lHPmyqyjIeznPtAtZSK9Id+dBRZzakoNydhND9IOSmzLQ6s1zOvB48PWb+Jm+FeHoPzyt5Hdzfk6KbEotYn1Wfeo+aavSbMB/T5r+yCvTMH2I66/mGl8uKxYSREl867d1hkpJkPzVyxfVuDrEAPTR94Vk1gUJIcMY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hKZR+JS0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63963066fb0so8293825a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759851531; x=1760456331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt9R4cob5+j/IMSNC9cMUqu/WuM5zfX0v2q372g0N1s=;
        b=hKZR+JS07pDakPDTaXFIlFHN3XFD78eaJi4BFC6hM3cFM66lG86EsuQgmmA1ECWyS7
         XQHvRmJQbD3y9Xe3dtYpgjskNJgH9kcDcqQDT222OWFqDhW+VP0PPsQW6OyLxlD74dMp
         vf5a92rdkm9CHdIIiJ3ALXJCm/PImyCJt5WvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851531; x=1760456331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kt9R4cob5+j/IMSNC9cMUqu/WuM5zfX0v2q372g0N1s=;
        b=uc0SM1eLdbjkKOTRKQWaJv1lrPLwi9HfT3/bVy8JX/+mcX57aKR/Fv+OjAsxvWB5cD
         jY/pHSrNxe0BLcyLNJJfsvVKIKU+uz0FU0kE1lR49v9bu4kM9oRPNafQuhGZG7qaWAkt
         PrS0OpAjabLrp+xvdVoG+0kPrEUkI45SP9KVwBM+w/DCZnF339UFn5NlbwrvEUknJ33S
         4eu6YSaZCXxeBfwnxN8WOqCdJjC09KtJ1SWi//LJnjhju8gfVetctFnG5nJL6z48dTf6
         xEaPxX+mhRSWvnzr7aENOOoBM84t0xi9k6d6LFb73pHukbzJdPnvtBnIMmM7yh4UT/zk
         Oi3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcwRZdITi6qHXO2fE2GyMBhZ21U+v//2D94PexDGyFAidIYgRVX9gXxAHX6FGQjjyP0NJQTcBS3v8MWBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LklB8RbYcghywc2k/4Iiji/0bVymFJygRJsO1dMNiWm0OA/Q
	Ei4uUm21lUg/O6Eh67qRevpnXKrdrCywX7tmowE6fuQ9sxVfvSwpm0tDRw3B7kslAsDY7I0oVCF
	iiMlVUI4=
X-Gm-Gg: ASbGncv7js1/g2GqKUEu+y5zBtf98ePYE6UhMa37BW3w62kSwPxOy6d3utsuOw6AhSA
	kYyhR/4Bn2e5rblnBWD1h1fJN5MNNpdNYZNbFwtdayAonEhv0+lvbIYV2/aCEnTZ5OwDHyHM+we
	u6ZgyGvedd7iswoqoC+EbG0QQtAwwnRisRAl2fzDAtmkL4GOckMAER2sQS+nATpLaM6Qv7C34n4
	ZiCfd2F+zTujnejRv+VYkhUcLs8RC+kIhhsequouebmjk09vwsdtZgp/+hbMXRw/KjrGxA53eBA
	1eFW6r1Okh5cXsAxaTWYG12PEo9cYxr6SAxEIkcxi6RTiZILrosuVHcR+/A+wgn/s3449S9ERiv
	d/8ztOH+jodRLxoFhrubavl45g6KEzPGKR5N3C0lNu0+52PDJ1zGJOelR/zwponNFlC+QFdDtWc
	Fj1UVDrda6DE5SwXqh+tBwcsvMuX9/pb4=
X-Google-Smtp-Source: AGHT+IE/bBNxn8XZdQuniVWjz8s8Uqarp/V/gfsM7oZ4NjmmmegrbTxA+Kk56yiFXYzRV/LW3bKwsA==
X-Received: by 2002:a17:907:720b:b0:b32:b055:949a with SMTP id a640c23a62f3a-b50ac1c134cmr3869766b.33.1759851531133;
        Tue, 07 Oct 2025 08:38:51 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a83482sm1421679466b.26.2025.10.07.08.38.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 08:38:49 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63963066fb0so8293736a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:38:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqObQXqxnSaPQEbQhaj5Q+Y/3l1pcd+edr/bxMLTbkxQtI+iZsLPDNGNuBxq72p//uMd7vDCr1R9ZeGk8=@vger.kernel.org
X-Received: by 2002:a05:6402:34c6:b0:634:4b23:c9df with SMTP id
 4fb4d7f45d1cf-63939c24ec8mr17732009a12.18.1759851529408; Tue, 07 Oct 2025
 08:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928161953.GA3112@redhat.com> <20251007142043.GA17089@redhat.com>
In-Reply-To: <20251007142043.GA17089@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Oct 2025 08:38:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSSr=Ljm0rJ_zV8v__uuQOHs2Z0bwQ5HRQN3H63MLQbg@mail.gmail.com>
X-Gm-Features: AS18NWBAmn9BsRe1UBoGmDtjqWTFM-qjmP_HA3t0boJoA9CDt_sOt5mq7nFWtPM
Message-ID: <CAHk-=wgSSr=Ljm0rJ_zV8v__uuQOHs2Z0bwQ5HRQN3H63MLQbg@mail.gmail.com>
Subject: Re: [PATCH 0/4] seqlock: introduce scoped_seqlock_read() and scoped_seqlock_read_irqsave()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Boqun Feng <boqun.feng@gmail.com>, 
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Li RongQing <lirongqing@baidu.com>, Peter Zijlstra <peterz@infradead.org>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 07:22, Oleg Nesterov <oleg@redhat.com> wrote:
>
> OK, please see V2. scoped_seqlock_read_irqsave() uses the
> "for (struct {} s ..." hack to make "ulong flags" local.

Well, patches 2-4 certainly look pretty. That's clearly a *much* nicer
interface.

The macros to introduce that nicer interface may not be winning any
beauty contests, but hey, that's pretty much par for the course.

So this does look like a clear improvement to the interface.

> I can change scoped_seqlock_read() to do the same, to make
> it symmetric with _irqsave() if you think it makes sense.

I don't think it's visible to users, but maybe it would make the
macros look slightly cleaner.

And it would allow making 'lockless' an actual 'bool' - which you
admittedly didn't actually do in the irqsave version either. Not that
that would matter either - I don't think compilers would care one way
or the other.

So a matter of taste. I'd personally lean towards doing it just to
make that 'use a struct in a for-loop' pattern less of an outlier, and
perhaps make people more aware of it.

For example, one advantage of doing it that way was that you only
needed one single use of __UNIQUE_ID() in the
scoped_seqlock_read_irqsave(), because the only ID that ends up being
unique is the name of the struct, and then you can have multiple
different members. I hadn't even thought of that detail, but I thought
it was a nice bonus.

But I really don't think it *matters*, so I'm happy either way.

          Linus

