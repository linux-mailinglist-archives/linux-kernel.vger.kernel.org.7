Return-Path: <linux-kernel+bounces-728492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21BDB028F4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 04:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DCF16C97E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E118B47C;
	Sat, 12 Jul 2025 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei3s51nM"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A5190679
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752287081; cv=none; b=ffaQKBnKW6jNIP21f6xyyqDMq4VcxZZgWhQx2H0H9osMyzZE2G41dmwmCSaaDh18Lz6SWotQHey7L7hw2XE544W+UpHExnA9eFDeUDC48IX8IKmgL4Gnge5HqgbaXrYXnAp3g4M1m8Qhh2lkYp99Uw5/iC0JJV8DfY7sP1+U3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752287081; c=relaxed/simple;
	bh=kg+ldBP8mANblU16CGIi3bTTsdJlN3R/kLzJXyyhBi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3QcyEHQi/WrMEk2LS4WACtx4uOjbq3pVJAmg7iTBbwz3kDFDH8gH33pXJ8RFBnRS0fHKUi0nIzRwgqNFbIqn9yzH3PQOI9h80nASCEaLG7fxUVvY6pknNdhktEdbaEsaruKVXb4ZMd7sepKPqvSJLo7Ue+JeEPWGIb/3XHT4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei3s51nM; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a43972dcd7so30957021cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752287079; x=1752891879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BEVuvJPWuEDX0BGPKdNrGGTkmVgHKfZXX+4b2mygZJo=;
        b=Ei3s51nMTgUX0WzGLvn0x3sYSVkydzXe9DkYZio8oQWQOpZa7aKHztWkaqM9BJfjir
         Mc/cjOJ6WCJ+zFHjP2BRL/2ax1Q7RRyKKeIbmCjPmSZQ0PzeSPUl6oEoV+xzB9fQb0x5
         /8QqnNOy5q7A/tQPdPSP63wh62XCZfta1wC2Vr7fFksFLuf+aLjuQbF4cZc2zZ9PkwTA
         oXu0IDmMmWRMBTkn/DuuJ06jqpzuS6VxmXBq5t6KpV1csIOXv8/uWCJCc9PEAVuCf5Vy
         J9hBZHoIKcq4PTuUH3Q8kmoIc7Hf8M/J3xSTXj5TOcUpOfA+u+eElXuO6vCxCzZ3cCcX
         unqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752287079; x=1752891879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEVuvJPWuEDX0BGPKdNrGGTkmVgHKfZXX+4b2mygZJo=;
        b=rRefZvCzmpyOcONWBAyBa9Yc4jcmnMdIirMpCt4QKECTdsjQI7alkVLMy/o7dN/49M
         /MykNb47zePgSC4pkelCqEqltP43KJRhg5zS0m1ZM+vJLcOqeyvecCDsIsYGB5JKZjkl
         tjv2i59afkTGiDAeEXl4tQRTnSExnRMICSu6Q/8LwOSBK33LZ8ef9sfk/rzIV03GsShD
         ooJ/5Glclp4OAA00HB7GSkVq4uZ505CqbDwfqUYBfdoEzpCEPPS9i3lIhZ82X5TLeE00
         J13Vc3qjDJrFYt9cJSVVTRhg6LrKQpU1hes7PVxv0ZsG0amojHQURZnVetoxLHPV4QoC
         YuoA==
X-Forwarded-Encrypted: i=1; AJvYcCWJWNFV420lX5kZlZY/pjWm+cukDp5C8yB1gGHm0nKUsmh0zCMf4IfS3P6TRPMly22iLAUTzLoP2fgYg7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZn2NZp+5s1RvXVq2uJBGkxUdbtVgKd2SZDxB1zJ8hjPyfbSyc
	hQASnkPEtvK6MxX2gdVa544nrxzNXXurqTfWs4sp6czsDcP94JAQLoTT
X-Gm-Gg: ASbGncvc9PW9ggteS3x0y89PfNHqgDwNJHf22ueXAi4fj+nmo9CRoqsCkeJxewV8AiJ
	QaUn9G6vbHqtGqC6Rhq0fsyPtHC9qn4zgIGFnFYA4FGDwH3ZInKTMeB6NaRXfGrUHnheajblytB
	yCYUbRK/RGGVP6SsjcTDCvowhyUAc2qxOBlBcr1vyfYvHzDSGcpsbmGu9oX+9asQ2m0NxWnuGuY
	NMnS/tHloamX7Ddd+fkqG1cDX0q84dfQtQ81kChasytKpBG1+FDDN4ahJvmamhHHU9erljFR+fL
	h98LSwGkMuLOGGZxk54pc5tG8MfTeUJo3zIOajPdFR+R+/fL3p/LN/vZvXnfBGXTHJiu8qerJPu
	WPDgCLW2Y7guG/hQN6pGCKRjTYrxxTzNMxxG/gxtzAj3sz4ZN+j4QTdj6geeqnLyIRf65NeatyH
	fvptdIjbrap+X6qOr/K8S9yQI=
X-Google-Smtp-Source: AGHT+IFcn1zuQbFRQfe6s6QgBM9C5h41AhXylXzhmA0AGrDOmiKAw51yhlwZYhXuM+UZ//2gRfSm3A==
X-Received: by 2002:a05:622a:653:b0:4a3:4d46:c2a6 with SMTP id d75a77b69052e-4aa2cc8082dmr78954831cf.7.1752287078499;
        Fri, 11 Jul 2025 19:24:38 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edc16c8esm26968451cf.11.2025.07.11.19.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 19:24:38 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 95CB6F40066;
	Fri, 11 Jul 2025 22:24:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 11 Jul 2025 22:24:37 -0400
X-ME-Sender: <xms:ZcdxaDjkeV3es56Kc4hA8muVH0z2uprtX-fPnfRFoK4KoB_jrTYN_Q>
    <xme:ZcdxaM85HddcRdQJqw0JSILMn3wGg6im_URnPZ3qUjOdcPF3p6hX-0rCG6vg9H1bW
    zYGHKdlgbrE1Z3Emg>
X-ME-Received: <xmr:ZcdxaOu0HhvCa2TkryiZv5k_QKHSFwPu8yK7-L5WVfXerF1mGkx7u14umb2LyHDNpQsox5wFz2QNyLwXk5cGU9DRpptzgTeYTv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeevueffieeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhlohhnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhorhhvrghlug
    hssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehpvghtvghr
    iiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrth
    drtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsghoqhhunhesfhhigihm
    vgdrnhgrmhgv
X-ME-Proxy: <xmx:ZcdxaIq4gN0NzFJcAtGyPyOE5qCM11yLH8LzpBSw0QyavLm3XpyO2A>
    <xmx:ZcdxaKqMiqHFrbYdF55018l4xL36izf7Hq7OhZuVwDUkI27n03xDcg>
    <xmx:ZcdxaPbw2d2dpUMCghF7R6yfqnoSSdYVxCFYrrOt3caZqgiHBMmyjQ>
    <xmx:ZcdxaA99xO2udDkfE1sGK-Smxb4Urw916kq_uC7jU5EXXx7UPHLx-g>
    <xmx:ZcdxaFmO9pfdeVogdQSEmWdvBvwQNUezvsy509d9s_DXvCAgtjqxOMAY>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 22:24:37 -0400 (EDT)
Date: Fri, 11 Jul 2025 19:24:36 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] locking/mutex: Add debug code to help catching violation
 of mutex lifetime rule
Message-ID: <aHHHZJ5sKGscTCqo@tardis.local>
References: <20250709193910.151497-1-longman@redhat.com>
 <aHGONjuRiA3KfH1q@tardis-2.local>
 <CAHk-=wj4gifTA94-11JXKj5Q5TSieu2LXgOauNDC9gbOQRcZeg@mail.gmail.com>
 <aHGeF7ko_4uXHUgl@tardis-2.local>
 <e88452ed-411b-419e-a41d-0ff98d54a59b@redhat.com>
 <00fdac3e-092d-46f0-bbe7-6067c0f22eeb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00fdac3e-092d-46f0-bbe7-6067c0f22eeb@redhat.com>

On Fri, Jul 11, 2025 at 09:48:13PM -0400, Waiman Long wrote:
> On 7/11/25 8:42 PM, Waiman Long wrote:
> > 
> > On 7/11/25 7:28 PM, Boqun Feng wrote:
> > > On Fri, Jul 11, 2025 at 03:30:05PM -0700, Linus Torvalds wrote:
> > > > On Fri, 11 Jul 2025 at 15:20, Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > > Meta question: are we able to construct a case that shows
> > > > > this can help
> > > > > detect the issue?
> > > > Well, the thing that triggered this was hopefully fixed by
> > > > 8c2e52ebbe88 ("eventpoll: don't decrement ep refcount while still
> > > > holding the ep mutex"), but I think Jann figured that one out by code
> > > > inspection.
> > > > 
> > > > I doubt it can be triggered in real life without something like
> > > > Waiman's patch, but *with* Waiman's patch, and commit 8c2e52ebbe88
> > > > reverted (and obviously with CONFIG_KASAN and CONFIG_DEBUG_MUTEXES
> > > > enabled), doing lots of concurrent epoll closes would hopefully then
> > > > trigger the warning.
> > > > 
> > > > Of course, to then find *other* potential bugs would be the whole
> > > > point, and some of these kinds of bugs are definitely of the kind
> > > > where the race condition doesn't actually trigger in any real load,
> > > > because it's unlikely that real loads end up doing that kind of
> > > > "release all these objects concurrently".
> > > > 
> > > > But it might be interesting to try that "can you even recreate the bug
> > > > fixed by 8c2e52ebbe88" with this. Because if that one *known* bug
> > > > can't be found by this, then it's obviously unlikely to help find
> > > > others.
> > > > 
> > > Yeah, I guess I asked the question because there is no clear link from
> > > the bug scenario to an extra context switch, that is, even if the
> > > context switch didn't happen, the bug would trigger if
> > > __mutex_unlock_slowpath() took too long after giving the ownership to
> > > someone else. So my instinct was: would cond_resched() be slow enough
> > > ;-)
> > > 
> > > But I agree it's a trivel thing to do, and I think another thing we can
> > > do is adding a kasan_check_byte(lock) at the end of
> > > __mutex_unlock_slowpath(), because conceptually the mutex should be
> > > valid throughout the whole __mutex_unlock_slowpath() function, i.e.
> > > 
> > >     void __mutex_unlock_slowpath(...)
> > >     {
> > >         ...
> > >         raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags,
> > > &wake_q);
> > >         // <- conceptually "lock" should still be valid here.
> > >         // so if anyone free the memory of the mutex, it's going
> > >         // to be a problem.
> > >         kasan_check_byte(lock);
> > >     }
> > > 
> > > I think this may also give us a good chance of finding more bugs, one of
> > > the reasons is that raw_spin_unlock_irqrestore_wake() has a
> > > preempt_enable() at last, which may trigger a context switch.
> > > 
> > > Regards,
> > > Boqun
> > 
> > I think this is a good idea. We should extend that to add the check in
> > rwsem as well. Will a post a patch to do that.
> 
> Digging into it some more, I think adding kasan_check_byte() may not be
> necessary. If KASAN is enabled, it will instrument the locking code
> including __mutex_unlock_slowpath(). I checked the generated assembly code,
> it has 2 __kasan_check_read() and 4 __kasan_check_write() calls. Adding an

The point is we want to check the memory at the end of
__mutex_unlock_slowpath(), so it's an extra checking.

Also since kasan will instrument all memory accesses, what you saw may
not be the instrument on "lock" but something else, for example,
wake_q_init() in raw_spin_unlock_irqrestore_wake().

Actually, I have 3 extension to the idea:

First it occurs to me that we could just put the kasan_check_byte() at
the outermost thing, for example, mutex_unlock().

Second I wonder whether kasan has a way to tag a pointer parameter of a
function, for example for mutex_unlock():

	void mutex_unlock(struct mutex * __ref lock)
	{
		...
	}

a kasan_check_byte(lock) will auto generate whenever the function
returns.

I actually tried to use __cleanup to implement __ref, like

	#define __ref __cleanup(kasan_check_byte)

but seems the "cleanup" attritube doesn't work on function parameters ;(

Third, I went to implement a always_alive():

	#define always_alive(ptr)                                                              \
	       typeof(ptr) __UNIQUE_ID(always_alive_guard) __cleanup(kasan_check_byte) = ptr;

and you can use in mutex_unlock():

	void mutex_unlock(struct mutex *lock)
	{
		always_alive(lock);
		...
	}

This also guarantee we emit a kasan_check_byte() at the very end.

Regards,
Boqun

> extra kasan_check_byte() can be redundant.
> 
> Cheers,
> Longman
> 

