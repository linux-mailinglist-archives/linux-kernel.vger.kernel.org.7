Return-Path: <linux-kernel+bounces-823205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE51B85C96
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC56A561F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2972C30F958;
	Thu, 18 Sep 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I/tb+1YN"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB230DECA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210607; cv=none; b=gHEzEmRwLd690jyOVbVT/NBdjqPkQA+LemUWOgllhA+1Nqs/8KuMzH44ch1DRxCzUItIxeo+cv9sGaQci3zXlj04VDW+sPCDCOIYeodFwNxgYpHLaOU56VaLako7tFGZmluT7NYdpKI06kc7CGYt5Z3JQHK8DeMza9bWH8qFVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210607; c=relaxed/simple;
	bh=XhR1h2E8azi9+Iqslf03I/SakVc5s2CaBmw/N8HkwwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiqIMvQZGTP+F21ZgBGaRgonXPw0DLuddm8PT8opSrT0FIX7UunIdIfjjdl96DcQzRKz1O/oqys6WS8uZHWaVjfSWP3CLtTTGJ8f/UFqsirXHV6oXRv0gxrHMjp2xzgqgWhmUyjEzCxqrWvSXHSNACcrJNKetn5mKt8AhK0E4kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I/tb+1YN; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso4275373a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758210603; x=1758815403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hpKO6CsQCuex3g+QZ22KGPC+ZgcKRmVKS1THDCqCkXc=;
        b=I/tb+1YNmJdGigww3E55wx/YJj7WCCcHO4P8XK04VfTym/nDbaK2/fCXQMFzqg76Ox
         xCiBkE7h8uQ9Y/rq/xO0dFJhzUf10uuTh8NllkhWGV35gualMnC2HdF0WCmvAvS9etGj
         a60E/sCJD1MRwUK/1qEKsDB2/cwHQLMajG5qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210603; x=1758815403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpKO6CsQCuex3g+QZ22KGPC+ZgcKRmVKS1THDCqCkXc=;
        b=lWVYAttMAEWCHv/sqG6MKJoA9LnhQCU541nB3OiMU+UJv0xusO/a7CbytLHNiXMWw3
         SwJouIBsvPGvQlwadGj7ZbQwpsSo5wh6tfEFQisVyLTpOM3PLhjeCPneIbYI1gC2bdwd
         buikYArzSeMQarBvC1jvvC8PNEkQcWGskOCY9a3JfGAmAT9LKlxsQQNURSu6hJze20+8
         khHXuOK2aOkpx5KRgT5tgSI1O1U2gxUwZeyMr7dDmIpkWDOTYviPaVrm/9nKC3kMypP+
         jGxK7ce+tSlwu6GdUHoQ96WDubeyj0DhBUYI6legOZuyoM7FSvhkdtW+8pwyU9W8VaPB
         NhZw==
X-Forwarded-Encrypted: i=1; AJvYcCUCpZHPX0Y1naIFU9bhExe84S5rSg43pKbPnBavx+Yw6Q6rOVFevbh4Koy1hfzpRRxEJncwOe8QWt05rvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyukOgpWXqJ66DGr4szusZinnQGzuGjHG5n7GFJPpEyo4T6QFjH
	K96luIH3uOpTiQrhU4p+J6dxUxZaffzQMV4pe6e7Or69rAMT+zIWdFY+jMms0rZAmiqTqaXaxiX
	0er9pyt0=
X-Gm-Gg: ASbGncs41XAZ7Ix61q7Zjt98AnLBz07d7rsxT6r2coWTzGOcm6rjsduBcUte602CA53
	UTjB10pOTXBnK6k0Pnq7x9DYzGAd3MrvoaT0QPJPRim3XIF6Wy3nOjR+/1C2pK5J2P9AU81rK2K
	VJn2X2q7cYM0njs0qfdc8hf3z/hHi4PzI62+v1+/BnpijaW6x8cAzXwdhAHoEzXBbEHZ6j8shvw
	yBVeqbxHXUGqWrhV/eTJimiI+yfSWL3SqPGm1D0vJrwrt2/hcMX7/pIWZV7BMQjjaCds9+LM4uK
	6gH6w0M3ws8gznnVLRTjfIS6X8kuO5/6Eba3HVjlOScHU2hL/p6O9y6y/gr+JvmopTthlvesABy
	Ou5Z/f+3C8XSuSNQZhrp9rc0BLlK0sPGPjjdcXPTSKCMSYU7ERpZdWFuKSdl4rYLaXZ0W5eO6A/
	Lq/uww4kbw/x5gGfg=
X-Google-Smtp-Source: AGHT+IHC3kAsWYGrx8XDReGY3zoMJ+XR82D+qFvzdMiAEztTXUYPlSU5XWnOkJjEr8vKLLt9Ftpc1g==
X-Received: by 2002:a17:907:86a9:b0:b07:6444:bce6 with SMTP id a640c23a62f3a-b24882999a7mr21232766b.7.1758210602785;
        Thu, 18 Sep 2025 08:50:02 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fcfe88e40sm221705066b.59.2025.09.18.08.50.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:50:02 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07dac96d1eso334381866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:50:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4bhZfUC91NcvrBMJhyBU7TJlr+v1lkS+69k4mwwUxPs496Fhdn3Cr4mGDXCdGOcPDHHQm7cBmcVgmTSk=@vger.kernel.org
X-Received: by 2002:a17:907:9612:b0:b10:ecc6:5d8d with SMTP id
 a640c23a62f3a-b1fac9c9b84mr417765966b.26.1758210601571; Thu, 18 Sep 2025
 08:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 08:49:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
X-Gm-Features: AS18NWBk4u9ObN57KesSGhJyt-aPlWZgKdxYhvzpAyoaxlNUF53WHe4dSKjzUBg
Message-ID: <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Compiler-Based Capability- and Locking-Analysis
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 07:05, Marco Elver <elver@google.com> wrote:
>
> Capability analysis is a C language extension, which enables statically
> checking that user-definable "capabilities" are acquired and released where
> required. An obvious application is lock-safety checking for the kernel's
> various synchronization primitives (each of which represents a "capability"),
> and checking that locking rules are not violated.
>
> Clang originally called the feature "Thread Safety Analysis" [1],

So this looks really interesting, but I absolutely *hate* the new
"capability" name.

We have existing and traditional - and very very different - meaning
of "capabilities" in the kernel, and having this thing called
"capability" is just wrong. Particularly as it then talks about
"acquiring capabilities" - which is *EXACTLY* what our lon-existing
capabilities are all about, but are something entirely and totally
different.

So please - call it something else. Even if clang then calls it
'capability analysis", within the context of a kernel, please ignore
that, and call it something that makes more sense (I don't think
"capabilities" make sense even in the context of clang, but hey,
that's _their_ choice - but we should not then take that bad choice
and run with it).

Sparse called it "context analysis", and while the "analysis" part is
debatable - sparse never did much anything clever enough to merit
calling it analysis - at least the "context" part of the name is I
think somewhat sane.

Because it's about making decisions based on the context the code runs in.

But I'm certainly not married to the "context" name either. I'd still
claim it makes more sense than "capability", but the real problem with
"capability" isn't that it doesn't make sense, it's that we already
*HAVE* that as a concept, and old and traditional use is important.

But we do use the word "context" in this context quite widely even
outside of the sparse usage, ie that's what we say when we talk about
things like locking and RCU (ie we talk about running in "process
context", or about "interrupt context" etc). That's obviously where
the sparse naming comes from - it's not like sparse made that up.

So I'm really happy to see compilers start exposing these kinds of
interfaces, and the patches look sane apart from the absolutely
horrible and unacceptable name. Really - there is no way in hell we
can call this "capability" in a kernel context.

I'd suggest just doing a search-and-replace of 's/capability/context/'
and it would already make things a ton better. But maybe there are
better names for this still?

I mean, even apart from the fact that we have an existing meaning for
"capability", just look at the documentation patch, and read the first
sentence:

  Capability analysis is a C language extension, which enables statically
  checking that user-definable "capabilities" are acquired and released where
  required.

and just from a plain English language standpoint, the word
"capability" makes zero sense. I think you even realized that, in that
you put that word in quotes, because it's _so_ nonsensical.

And if not "context", maybe some other word? But really, absolutely
*not* "capability". Because that's just crazy talk.

Please? Because other than this naming issue, I think this really is a
good idea.

           Linus

