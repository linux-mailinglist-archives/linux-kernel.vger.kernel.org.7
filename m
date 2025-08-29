Return-Path: <linux-kernel+bounces-792091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2BFB3C011
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC2D3B452C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9533439E;
	Fri, 29 Aug 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FeK6EWT4"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E23314AC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482857; cv=none; b=KM9RaowuZSW3BBrsSwKCyHGR+/SMKbyM+2NzXpLMT9KvGxevuKzHR0PTOHQQDEXOAyw6mhLvAsSKlIJw11wrMLZzw7Cb9pOAepBBGnAvUqyKU0T2gzPXmawMTrXA8p4MfUR43YyE7eFv0SVFLv3dKhGbZ4umWjMVAucIdOT8Br0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482857; c=relaxed/simple;
	bh=IvNOoAxgGRDV/pz/+Da0UiB1N1KkrY/4Hn+qpOfi20Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/JT4/AZC/KL2cEbixLFxbV+zS7+u9s/JXAESDYhM/jddFtp5ogpk6dcGWD70mM1KvqwvhHl5ZxMmmpYMZ6U86sin2LucCNopA3D++flbWSAvBhqukE2w7fUU1YAZ+cKnkKFzoqRkmCTUrH439HFgrvRnzZAS5+X81vc9VvsGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FeK6EWT4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso3845012a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756482852; x=1757087652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qQUhdimbGwdD8GQxXTeeb1UkXF/zoKTQKbXke/E9VAE=;
        b=FeK6EWT4im0iKZ/0eotDaTeAzSBLXua1RK410L3EKuv8xC6tVJrEhbElG2FFPHZify
         clHTdIWogLuHMzjPwDMIaNaJMBBao78nKQQoDlCHKD/yHMYdMP5YNz8l7d8yNzwcC+kh
         2ftAyPzEMqgIAlTgQhVdU0GQdiJ+XOWTkdLZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756482852; x=1757087652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQUhdimbGwdD8GQxXTeeb1UkXF/zoKTQKbXke/E9VAE=;
        b=C7luCaphugu80ul3gRzVQExcc6dGr205AvqBo5WJs6K8NrSFJjo97iu/xT2D6ELT1N
         SjbYPAIC7qbTOhB/g94/MZ95twK4TFU9QQuzbpu1CwL4jrhMa8OEMlfC2iP7D+FxDUjY
         zvlmq+3Cs5QENSn8CMeNsqe3rgnjZ1crHemzluUJSC9zEgGLYVchj7oHWOMFPIxb5vnE
         HsbIwtAD/QxDSQiKaIcNYA2Bwuw3kgQVw1nzx3hd/gRziBhVBdDyEkqW9mYbQ4oVHVGH
         nErQFCblnlOBWuxl7WXP+q0Cp2D3R6FT/23s8zGBUFCNFVg0We3LRh59gT2OQh8cGwTx
         JF9w==
X-Forwarded-Encrypted: i=1; AJvYcCUQaKunPzzlgIhKa3ndXKXODSVlKmJ6M2d7JGP6Aqek0BGaQGzAuJD9cpNNMNquj8d9dtpoBZ8iaBP2lDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzloXMTeWjnjgOfv8fZKCgaczJQiWVHfnnzQvyQHUQq/Dr7OKU+
	Y+M97qtpfEvpUp7kKWUftxrW3ABEXczrUi19TSizZgVCmdzeRpxIodtVJlROUZJXd2iJ6DSB5iR
	S32g+huyQNA==
X-Gm-Gg: ASbGncvMPJ6f5VKnUIpiAiPom5IA1MqHC/0AOdq1JgtU3K8cBM7khKXn0Dnj/xlh/P5
	9gGr4EyXO/jQ6h5C2PUKRp8hP94Q+Yxl7NLITpyiwaApOal9ZUj4U9umSERRu2TdBcWirMS0WCE
	t1K9YQIrWtVA6zBudxeMJjajQlWOrOPqUxJmGjEDJzrpAg/KoLK6hMfseIQ7/5WRoJyk1dYjaZH
	Pqr7Z9jJVWVsiqKifcj4EYzYnyp49E53QKgrIiWVdrUAkGuW68m9oQghbY2T71XHtjK9pXll3Gt
	Db71XZHH/+3D4+aJaSBwC1+9rSQ1t+rcXPybZy16WWzpfRFzkkACsjaHAl8c6Q9b2g45XFuAO1Z
	gd7v6FG+nNT/vF8mM0BxUg2X6X4S92ETN4T76bQ9tQW5qkyM97/3R7Gd/krZy+5ZWO31SexhJnX
	fSEBYbBmnkuv1nvl7n2w==
X-Google-Smtp-Source: AGHT+IHjA+DvOGHmbLUYqaqD2+pRBxPNWpVNH3nM6UmIZDFLbjRvFDn18A+IcLjI+4v9hlXkF26DsQ==
X-Received: by 2002:a05:6402:d08:b0:617:9bff:be16 with SMTP id 4fb4d7f45d1cf-61c1b5ed4bemr23081705a12.22.1756482851703;
        Fri, 29 Aug 2025 08:54:11 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc575b94sm1908530a12.53.2025.08.29.08.54.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 08:54:10 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso3844934a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:54:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4tei45u20L+NzW4FFOMJX8mttoAb6LCxWQDwMz9SrMeMDogv3mwBBMNNKwmqwekkQkF6xzcc2+Jl0zNE=@vger.kernel.org
X-Received: by 2002:a17:907:1c84:b0:af9:4fa9:b132 with SMTP id
 a640c23a62f3a-afe29548f36mr2755239066b.33.1756482480512; Fri, 29 Aug 2025
 08:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home>
In-Reply-To: <20250829110639.1cfc5dcc@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 08:47:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
X-Gm-Features: Ac12FXwNlyz00O8OVBJK4ieQwLO8cLGOqnKUasO_BCaKG_QlAegARW0kUgVHzi8
Message-ID: <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 08:06, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The hash value can actually last longer than the file pointer. Thus, if we
> use the file pointer for the hash, then we could risk it getting freed and
> then allocated again for different file. Then we get the same hash value
> for two different paths.

No, no no.

That doesn't mean that the hash "lasts longer" than the file pointer.
Quite the reverse.

It is literally about the fact that YOU HAVE TO TAKE LIFETIMES INTO ACCOUNT.

So you are being confused, and that shows in your "solution".

And the thing is, the "you have to take lifetimes into account' is
true *regardless* of what you use as your index. It was true even with
inode numbers and major/minor numbers, in that file deletion and
creation would basically end up reusing the same "hash".

And this is my *point*: the advantage of the 'struct file *' is that
it is a local thing that gets reused potentially quite quickly, and
*forces* you to get the lifetime right.

So don't mess that up.

Except you do, and suggest this instead:

> What I'm looking at doing is using both the file pointer as well as its
> path to make the hash:

NO NO NO.

Now you are only saying "ok, I have a bogus lifetime, so I'll make a
hash where that isn't obvious any more because reuse is harder to
trigger".

IOW: YOU ARE MAKING THE BUG WORSE BY HIDING IT.

You're not fixing anything at all. You are literally making it obvious
that your design is bogus and you're not thinking things through.

So stop it. Really.

Instead, realize that *ANY* hash you use has a limited lifetime, and
the *ONLY* validity of that random number - whether it's a hash of the
file pointer, an inode number, or anything else - is DURING THE
MAPPING THAT IT USES.

As long as the mapping exists, you know the thing is stable, because
the mapping has a reference to the file (which has a reference to the
path, which has a reference to the inode - so it all stays consistent
and stable).

But *immediately* when the mapping goes away, it's now no longer valid
to think it has some meaning any more. Really. It might be a temporary
file that was already unlinked, and the 'munmap()' is the last thing
that releases the inode and it gets deleted from disk, and a new inode
is created with the exact same inode number, and maybe even the exact
same 'struct inode *' pointer.

And as long as you don't understand this, you will always get this
wrong, and you'll create bogus "workarounds" that just hide the REAL
bug. Bogus workarounds like making a random different hash that is
just less likely to show your mistake.

In other words, to get this right, you *have* to associate the hash
with the mmap creation that precedes it in the trace. You MUST NOT
reuse it, not unless you also have some kind of reference count model
that keeps track of how many mmap's that hash is associated with.

Put another way: the only valid way to reuse it is if you manually
track the lifetime of it. Anything else is WRONG.

Now, tracking the actual lifetime of the hash is probably doable, but
it's complex and error-prone. You can't do it by using the reference
count in the 'struct file' itself, because that would keep the
lifetime of the file artificially elevated, so you'd have to do some
entirely separate thing that tracks things. Don't do it.

Anyway, the way to fix this is to not care about lifetimes at all:
just treat the hash as the random number it is, and just accept the
fact that the number gets actively reused and has no meaning.

Instead, just make sure that when you *use* the hash in user space,
you always associate the hash with the previous trace event for the
mmap that used that hash.

You need to look up the event anyway to figure out what the hash means.

And this is where the whole "short lifetime" is so important. It's
what *forces* you to get this right, instead of doing the wrong thing
and thinking that hashes have lifetimes that they simply do not have.

The number in the stack trace - regardless of what that number is - is
*ONLY* valid if you associate it with the last mmap that created that
number.

You don't even have to care about the unmap event, because that unmap
- while it will potentially kill the lifetime of the hash if it was
the last use of that file - also means that now there won't be any new
stack traces with that hash any more. So you can ignore the lifetime
in that respect: all that matters is that yes, it can get re-used, but
you'll see a new mmap event with that hash if it is.

(And then you might still have the complexity with per-cpu trace
buffers etc where the ordering between an mmap event on one CPU might
not be entirely obvious wrt the stack trace even on another CPU with a
different thread that shares the same VM, but that's no different from
any of the other percpu trace buffer ordering issues).

                 Linus

