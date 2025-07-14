Return-Path: <linux-kernel+bounces-730481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E4B0453F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1724A01EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3B026058D;
	Mon, 14 Jul 2025 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D1eWxC3S"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4625DB13
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509839; cv=none; b=DnFcp3Ry/VS/GVHf8Q3sbrsB4XbqCBzklFCBD5UroR1QDfbaiL0nci9fvAIFtPCuWapuXQkbtPRRSI7fFdh0d2Q6hOFU6TcPUuO6FHDzxu84D7B5N45kWwQMM472eaom5PxduV/qwkA8CSzsk6kWX9BF+GIHx8J5OJla2/LSoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509839; c=relaxed/simple;
	bh=i/R26POJP4dDcBivK5gMdeMHp+1pQls5mGnd176yHgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAP+vCdxdb4M7GaWkq8rDoNGSrfglLQhuXtspDaQpGsZwFo2bIqa66IQFyw0fC8NmqhOmBq92yErzL9H2K6u0dWU3Cp9uAvKqhXXc+HqbOJd1Zc1T/YlBcc6r9d93dp6MahLNOWdB16OEDGUKwOW61y3FOWc62JKgSVZQEVYBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D1eWxC3S; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so894520766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752509835; x=1753114635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEQq66OWWE9JtkTfXjKqpWkex8XQYQ6HwopNDNvjlsc=;
        b=D1eWxC3SuUctDTeonZF/eu1/bEecxFV+y31RuafrNjs1eJQVNdZGzucUTsLMdsUVPB
         ZA117tJLiRLNO+jvSNbMmFr+6QeN7rE871l811kSev5MezYneIF4aBK+bnQw/JoFKbqd
         XGLAz3rhaCEPm4GlZyTUkAqxELHMF0rsERPvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509835; x=1753114635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEQq66OWWE9JtkTfXjKqpWkex8XQYQ6HwopNDNvjlsc=;
        b=eZwZ8GC/XwMR6Hh6lmbgCXJHKBlAbiY3rIKXoKxnyXZc5Jl5vxOnwPIqd7zAEFMtLM
         xjAd07eM9+n+5zNNFlPZe85ZNejx3dWtAiUh/uFD8gcOdE0/gJz0u9JxlFA/1kbSgBQZ
         YjOta785xBFKfc6BhZHXPf27fZL+/BEMe1CvWVuME6MRLBWe144QQmVOGEoX9oJtLQyA
         he7Pm/Uqo4BXDMpLU8BgTdzl7xGXpR7exGzIUpJwTTKoZrTMsTvpgGf2iF9LpJ5e64lf
         xZnV4Xv6n7Qq1xvRRJJVqeF+0uovhjJQ5FTMQ1dPP3BtUZLuigLpz/w8DRlAxztI1o8y
         e1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXTt1eBnzXWt7Pgy/gc+T26pGug616TQ2aMq1qmC0IUEh0sG0lVnx3OFjGXSGCm3X7sDetir4ciMeTtcoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzofV/90BD5qYnNPuAaGwp+Ph8BGKjCjgjKxB2yetR7HWd16muA
	c1w54aD5oK7T67LSBYodnvOEQ7UBRhdb6sOxhbD9MQFTQg/70znveqJbMWAuQgUbGviG/tnkZ+d
	Y70KctOg=
X-Gm-Gg: ASbGncs5ljzRyd9UrGWx1loI7k6zhs6Nr/tCojygNd210MqZVbDgbocqHrhsUbFoQZ3
	wicYn/ElZEmtgL9QyeYm39FSmuKE/LhL0QfYaVF2F8S1jce4kkORhQNVSLMzMJcmdmchaWq+Nxh
	XI8tlSjCLdrzsNGm0tEna+o5geNAWGUrTsWZMrgS385+/cJOWrCxz2iA/onC1cJaeVgFx9oiIWP
	YPRiYtop1O8XcMH6Vw8R7emJQrFnHfVZi1NyzhyUzdq5oZvRwmoiOOrF3mAzPU3xPAo4WcRrq3Q
	UUgreE0aPewjKmts3zrJ655SJMyM15c3xcsHn1GD4zRWsI5qCw4GXsgQu7rDT457sEN17aD4WXr
	XGjisfOumnr7QA8VXk5QJQEh26hNlbJwRJR/b+zMzh7McgluTX7DmqF1vbs+3fDSEAKc543Ty
X-Google-Smtp-Source: AGHT+IHzo3eQQ7ebSIExjQkPWTLAZCmjT5J88tcvcdtMWPVuT5DqQOZI415tBute195V5RH/MmN7ow==
X-Received: by 2002:a17:907:3e9f:b0:ae0:a1c2:262e with SMTP id a640c23a62f3a-ae6fbf9b027mr1199987866b.50.1752509834966;
        Mon, 14 Jul 2025 09:17:14 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dedc0sm839892766b.160.2025.07.14.09.17.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 09:17:13 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso8822566a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:17:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvC5qzLwScbmBPfPf9kPDD8TL5VaO0ofBAf45eF/JNHVcltpsfQ6XFc1oNPUsZW30xiyb7LnMAeDZfeFQ=@vger.kernel.org
X-Received: by 2002:aa7:d78f:0:b0:602:201:b46e with SMTP id
 4fb4d7f45d1cf-611e84f8dd6mr9695286a12.31.1752509833354; Mon, 14 Jul 2025
 09:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710034805.4FtG7AHC@linutronix.de> <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de> <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de> <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de> <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <20250711095008.lBxtWQh6@linutronix.de> <20250714-leumund-sinnen-44309048c53d@brauner>
In-Reply-To: <20250714-leumund-sinnen-44309048c53d@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Jul 2025 09:16:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whniDdvSeCEQD5aUzr79HnhZ=A+ftzr0p_mY+n_f0AMHg@mail.gmail.com>
X-Gm-Features: Ac12FXxWB0yp1KMBo5BvpABIxBDtYWLONaWyJRXqnq_-Wkoa7_1NLpHwfbQeSac
Message-ID: <CAHk-=whniDdvSeCEQD5aUzr79HnhZ=A+ftzr0p_mY+n_f0AMHg@mail.gmail.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
To: Christian Brauner <brauner@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, 
	Joe Damato <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 02:00, Christian Brauner <brauner@kernel.org> wrote:
>
> I was on the fence myself and I juggled the commit between vfs.fixes and
> vfs-6.17.misc because I wasn't sure whether we should consider such
> priority inversion fix something that's urgent or not.

Well, this time it actually helped that it didn't come in through the
merge window, because it made the bisection much shorter.

But in general, I do think that eventpoll should be considered to be
something that needs to die, rather than something that needs to be
improved upon. It's horrendous.

The indirections it does have been huge problems, even if they are
"powerful", because we've had lots of issues with recursion and loops,
which are all bad for reference counting - and not using reference
counting for lifetimes is just fundamentally a design bug.

For example, the vfs file close thing has a special
"eventpoll_release()" thing just because epoll can't use file
references for the references it holds (because that would just cause
recursive refs), and dammit, that's just the result of a fundamental
mis-design. And this is all after all the years of fixing outright
bugs (with hidden ones still lurking - unusually we had *another*
long-standing epoll bug fixed last week)

(Don't get me wrong: unix domain fd passing has caused all these
problems and more, so it's not like epoll is the *only* thing that
causes these kinds of horrendous issues, but unix domain fd passing
was something we did due to external reasons, not some self-inflicted
pain)

So this is just a heads-up that I will *NOT* be taking any epoll
patches AT ALL unless they are

 (a) obvious bug fixes

 (b) clearly separated into well-explained series with each individual
patch simple and obvious.

Because it was really a mistake to take that big epoll patch. That was
not a "small and obvious" fix to a big bug. That was literally a
"makes things worse" thing.

I didn't react very much to that patch because epoll has been fairly
calm for the last decade, and I had forgotten how much of a pain it
could be. So I was "whatever".

But this all re-awakened my "epoll is horrendous" memories.

Nam - please disregard performance as a primary thing in epoll. The
*only* thing that matters is "make it simpler, fix bugs".

Because long-term, epoll needs to die, or at least be seen as a legacy
interface that should be cut down, not something to be improved upon.

And yes, I hate epoll. It has caused *so* many problems over the
years. And it causes problems *outside* of epoll, ie we have that
horrendous pipe hackery:

         * Epoll nonsensically wants a wakeup whether the pipe
         * was already empty or not.

and the pipe code has that "poll_usage" flag just to deal with the
fallout of bad epoll fallout.

THAT was fun too.

Not.

              Linus

