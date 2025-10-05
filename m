Return-Path: <linux-kernel+bounces-842353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC6BB9914
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 17:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AFD3AE3CB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B59425A642;
	Sun,  5 Oct 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c9phXeo3"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985301F5E6
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759679331; cv=none; b=jrauk5eFtyAAs6EDql3DGOLGO8jPCDGIqUSX2zl1XZH+j/ZVe2Ee1CUsKXbo55co+BgnskUCXd/81o6TT3FJwS+EHji5O+WDCND6fEJLmSJ2Mza4zYfaV+fsm9kKI8eyX/yfi2bkHhy1S4MuGwHSccfHpgn6zS41gHVN4YHhmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759679331; c=relaxed/simple;
	bh=+jXuJhALqb/AmB+cl6VyOKB9YAZG8UHNIc2PRr2KdCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wb7ZyWTdy0hzzC75tb/gMiSj+P/PIvUyCB0FwjXvRZMUyyqPlxxipvvei39rdazeoNpCHNaH8jc+X831HvEcomeiP7Es5dVyKQfvGzhp0VJ/5z/SNjCr7KN6+XRc6W7HTJ7TnUBCwl5TEdYKxXW6KRk8sY4OP0lIycFZcSFGtfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c9phXeo3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso9088504a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759679328; x=1760284128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n9fBGr6UE6Yytkt554Egsx+qAPYcXBvZPiF+SQ/v+7Y=;
        b=c9phXeo3ewnes3Ool4LjJ/VeHNYnRpPl1cZQwYN3c4I8aXa6CS37xYjvf1PXaT4NT/
         bGH4SkAXQ0NUsN1CD/KCqGixSyMQIlz70WFbKblyK1yKPD5uFqGnQuAVUO9cV795c9T3
         6l1b7tDb0qPq/bsDURWdgPQGreSkHpY3PJH90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759679328; x=1760284128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9fBGr6UE6Yytkt554Egsx+qAPYcXBvZPiF+SQ/v+7Y=;
        b=agy8a1HmL0HjPl25okzoGizBwcnBgXWCGcreuIRxuvZOSnr2ocBI6vqLTmxWuCGkOY
         bNGNWaqX885jYa3VkWa5DhelUr1AJOLfb4AIEuKIyp0MhPMq5hCOtpw6zBb3hhl+bArw
         H9FcivqhH3tlgHzI0V9u3/2C+H3IEArKfZ5OGBjcF6SqaHRXJ94+hcdht3QM8EN3LycI
         Y4fcM9bjSnWPCxhGaHtcUjCweZ1b6ZvPLYh80zPLAtigcD29F9jD5Vhpx6lvC5Q4cc3E
         Aaz5iESfZYqlQ5GW5S9SXWT3tUqB0h6Z5q34Ft8La0B4YgIAhFHAEH2xw8DTKjj9zd4t
         vAOA==
X-Forwarded-Encrypted: i=1; AJvYcCUvuWWBvxLafscXDlmJ77UlCia4VkRQynkug3tIlkwkti9iF3SBQaW1IHMBKS65KBN7IpAyP7zfx1qAsm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/OimFJ+ozrW4AZm0jHW2eJx1h/j9h5zFw6g834eI8IHHMehj
	L2LC9hv2DLNCTJtx4SFGi0Rk5dXV6sf/HlcDiUeTt3tyqdBpruyM2fwFxE87zvIvSgQpDbLORhR
	sMHyJta4=
X-Gm-Gg: ASbGncuPjJI8Rr/HZdT5RWPgFMTZTteUsLtfVqGmucJHmh2a+Ze33m4cozchxpPHYWV
	kF7Skov9yPvWfvEnphOa6SsVPhHF9tGdVtM6F8vcbrcUrWhV9abIotIXdgwhORdD/iDbSdJPcTL
	OiGxnjqNgEveYlHZLFhUghzI3afN9rY6aDg6m9qqWwdq7rlouHjPsH1c8YnZG2xhcvC9DIHIuzf
	g0zYXs2YxqqCtZdrlBZNFTQRplJKsMSyjpKa5UGWwm7Y3rpk46Me9O847Gc9+RxzP8iLk9JDKK9
	WPna/8+jF5M1zaU3OFsdNkdzoosA37gdovmbRaPQHDw0kPdGjUTqbsmNrVwCsONvN40L4D1pIUE
	E8x2LWTRs+JDhl1ZcTdMq3TQORMLv+a9nZTRPXvX68q822YKQjxFkI9rW58j5dZZm3Vi/we/MPg
	mSx+06bTjDPso9Yl7UMS2S
X-Google-Smtp-Source: AGHT+IFulmqS8r32tzZ6j6VHCjKu9B1U8bIAtIvt5ZkbdrJySIz9UK0IpxZTrfAWQZOMH5UONXSuzQ==
X-Received: by 2002:a17:907:6090:b0:b29:1c4b:3d50 with SMTP id a640c23a62f3a-b49c4398239mr1157345266b.64.1759679327649;
        Sun, 05 Oct 2025 08:48:47 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48628a6d90sm941659666b.0.2025.10.05.08.48.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 08:48:46 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b40f11a1027so732031366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 08:48:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjqvkoFuvsrMZgsV2NaPKKCKkYF5/NC4XoXcy1bsE5KT2ejSSZ+uVwqxjTKe0kgaY38MWSywyy2CFos+c=@vger.kernel.org
X-Received: by 2002:a17:906:dc94:b0:b3b:eb5f:9f1a with SMTP id
 a640c23a62f3a-b49c3933030mr1248024866b.38.1759679325974; Sun, 05 Oct 2025
 08:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005144929.GB1188@redhat.com> <20251005145041.GA1266@redhat.com>
In-Reply-To: <20251005145041.GA1266@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Oct 2025 08:48:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYznwPjhEb-FSkRjZsgh6W6Z8+tne2EbO4qBF+hMEJtA@mail.gmail.com>
X-Gm-Features: AS18NWDQCfxyfk6BYikpHXlLvfirPrfsgfVzyHtX-BpPK9b0ttSPn61PViBCAFs
Message-ID: <CAHk-=wiYznwPjhEb-FSkRjZsgh6W6Z8+tne2EbO4qBF+hMEJtA@mail.gmail.com>
Subject: Re: [PATCH 5/5] seqlock: change __dentry_path() to use __SEQLOCK_READ_SECTION()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Boqun Feng <boqun.feng@gmail.com>, 
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Li RongQing <lirongqing@baidu.com>, Peter Zijlstra <peterz@infradead.org>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 07:52, Oleg Nesterov <oleg@redhat.com> wrote:
>
> To simplify the code and make it more readable.

Ok, so the other ones looked fine. This one I'm not convinced about.

The end result makes no sense taken alone. It does that odd
"rcu_read_unlock()" after the first loop, and it basically ends up
being very incestuous with that implementation, which means that now
you have to understand both pieces intimately to figure it out, and
they are not near each other.

It *might* be solved by just renaming 'lockless' to
'first_lockless_iteration' - not because it changes the code, but
because it makes the logic much more explicit, and then that

        if (first_lockless_iteration)
                rcu_read_unlock();

test inside that loop would at least make a lot more conceptual sense
without knowing the internal implementation of that macro.

But honestly, while I think that would turn it from "too ugly to live"
to "I don't love it but I can deal with it", I would wish for
something better.

Side note: that whole internal loop:

        while (!IS_ROOT(dentry)) {
                const struct dentry *parent = dentry->d_parent;

                prefetch(parent);
                if (!prepend_name(&b, &dentry->d_name))
                        break;
                dentry = parent;
        }

should be a helper function of its own, I think. And if you do that,
maybe you can switch the whole thing over to just making the first
non-locked iteration be an explicitly separate phase?

I dunno. I don't love that code in the existing format - but I think
you ended up hiding that subtlety even more.

             Linus

