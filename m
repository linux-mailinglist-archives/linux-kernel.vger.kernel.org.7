Return-Path: <linux-kernel+bounces-806910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2521B49D6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974F34451A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFD62F7446;
	Mon,  8 Sep 2025 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dCRYermQ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C92F744C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757373501; cv=none; b=OUzvG3WDl77FewXmDtRCbjFNxVyAxrE7xQOwKxzfdeh1siSPb2QG2cX5LOydOeVCRLG4XDGxaMlBikOc+c5AHuqu2AIYdBrYW7TCpjmN0xLlRIY+GMaJ6LMbv0Uk347hwtZtQVGuxZ8+BA1qimum7B4kEGircGTunjiSOeuepAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757373501; c=relaxed/simple;
	bh=FS4nc2fJeS5Q3A/mcWeQ/ZPhjTODNmSRZ+cO8Gw2KxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HB140BcXxKq/dWkPD+M7M4J+sbB5UQU8MxnwslvhY/WNW/dh0F9x+LBWMIieqzyaGT2aSrhgwmMWLQEzlQRaoOl1l72xfV8txl/iPxB4vJk4JhoZT7EThb2reg4fhmNFp/pK2fV4QqSDYjr9+eOPHcb3eJV/QKVIZz+kYvUBi10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dCRYermQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b047f28a83dso824029766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757373497; x=1757978297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3Q44KwJ8t0CaEyMHJTLNYuOABw/iss9AUCNI8J6M2g=;
        b=dCRYermQCt/CIECM0bssFOlOJl+SM51DlYGHB3/W7cYMwJRid+QzxsZorXC+3H3uXD
         6g817SHtgxVM7Nhep17B/GV99UHeo6y1kQzx5OOiXreASto1DJ9U+RcGkcl3P3tHm3oP
         68JRoYzP+269C8htGCYjI/p8L/XK0x/x/ChFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757373497; x=1757978297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3Q44KwJ8t0CaEyMHJTLNYuOABw/iss9AUCNI8J6M2g=;
        b=brgL7DNjDu9Lgy5ygpK2T8RhoitVHGEwDfGGWHkdPpx633XKQexAVkkhO8rPSjJcMj
         gMIit4TZ3SR3sPqDZ7jqSB9PidUvx+E5Mkg+eqrC+hC23nDmDViWChPnzpclF8qRzU6v
         WJoXiRQsfKKhmpOCGhd4uTAyy6CCmfNbJckLJiUs4qthi7yzX6JfpwTHVPp0lOYatgIj
         49tmgMBdpTmpRTGeHG3/JZg9n/iTeg6rRXIaUvKfb/tH/UhznW3HtEDwGMvSMabrIir7
         so4nMozYs0m2TyyfLHrJtg7OiqXR7321cqoSrdIOlENmtAfXAeijEdRhonp0sWc68v+k
         Er/w==
X-Forwarded-Encrypted: i=1; AJvYcCUrCYBdxIyrgFJkSr3bLyCY1JsHtpMIdjnxVjBqypLO5/MvXJ2X308aUJU/mz4KG1ykb+6WVV+exCRl4Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5vGPIPGeaFKiYAW67jANQTXXSJ3lCb9XGmFIBGw8UUApNuDe
	YZljhYupyewmuyjPkmAXpMOdIZmTx2Pge+73jNfYcPjFkIy9j3Gca96lID5G8A0SEiiYcLGKBhx
	dQfeOi6w=
X-Gm-Gg: ASbGncucPdYRX+qw8kyB7FVAaFZZDHBQB/TaEmvWN4zvI5ObB9/7OrBf6BqkWW6drzI
	FJM0pl3c+FMFyiWroP/nkldhm5LMfLyU4xLf/ugG6Cd6sKl0a8StP39evi0a/lULeMOYhbk9H08
	iniRW60Cat/CMTifbFi6QqoosWlDcAoKAOQkOiTX6KgmxJjICf/sPBKT4ZDPtbloMtfnZtZY/Da
	F1RDPNf1LeKpcQYKgxVEozlUtJS8+UUvdWWCOfRsXq0i03U2CtfO73Lo175PpKOAOvVnj7a8SBP
	6XMaJJ7VDxu6Bt4+x2yXqyrg5yJcE6xOlyMG1TPm7ql7rAWPArFPRrZYulwxte+sw/iEF0pMQI3
	c/1Q7DgF7EitUnVtiCVwwcZe9PwmC0ro+JzqslSYVibHC7y8eImOBFKK82cwAOKza837Kbz1UwG
	3/o5zITWA=
X-Google-Smtp-Source: AGHT+IH4EaBhOU9FosZV5LZ1uqvZQlKjBIUk06O9ijLHub9GWZtD6m7VCMwMGxRy0MrVdBJWadYiOA==
X-Received: by 2002:a17:906:d555:b0:afe:dbfb:b10e with SMTP id a640c23a62f3a-b04b16baf46mr856779366b.47.1757373496523;
        Mon, 08 Sep 2025 16:18:16 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04189de5b5sm2114956966b.10.2025.09.08.16.18.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 16:18:16 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b04b869abb9so362204566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:18:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQ2tZznVMa+4zD6kSwwRF9QlWvvDCI1KtfD1HhKrlihoYP6mu/RPl4aKjq94EgXC3sNQDI1oiB2s8HKk4=@vger.kernel.org
X-Received: by 2002:a17:907:6d0d:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-b04b13fb3d7mr915632966b.12.1757373007881; Mon, 08 Sep 2025
 16:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250829110639.1cfc5dcc@gandalf.local.home>
 <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home> <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
 <20250829190935.7e014820@gandalf.local.home> <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
 <20250830143114.395ed246@batman.local.home> <CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
 <20250908174235.29a57e62@gandalf.local.home>
In-Reply-To: <20250908174235.29a57e62@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Sep 2025 16:09:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEL-5f96NbRtm4JJVi6u=3Edto9-ZABgpOc6WAj=gX=w@mail.gmail.com>
X-Gm-Features: Ac12FXy1lCy2MUtjNn6OggSKXnFGQilTbpirSh9H6fsZa-eyGTZysLHvi-fEy38
Message-ID: <CAHk-=wiEL-5f96NbRtm4JJVi6u=3Edto9-ZABgpOc6WAj=gX=w@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt <rostedt@kernel.org>, 
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

On Mon, 8 Sept 2025 at 14:42, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I just re-read the entire thread, and I'm still not sure where to go with
> this.

So honestly, I don't know how to get where you want to get - or
whether it's even *possible* without horrible performance impact.

And no, we're not adding crap interfaces to mmap/munmap just for a
stupid sysfs tracing thing.

> Ideally, the user space stack trace should look like:
>
>    futex_requeue-1044    [002] .....   168.761423: <user stack unwind> cookie=31500000003
>  =>  <000000000009a9ee> : path=/usr/lib/x86_64-linux-gnu/libselinux.so.1 build_id={0x3ba6e0c2,0xdd815e8,0xe1821a58,0xa5940cef,0x7c7bc5ab}
>  =>  <0000000000001472> : path=/work/c/futex_requeue build_id={0xc02417ea,0x1f4e0143,0x338cf27d,0x506a7a5d,0x7884d090}
>  =>  <0000000000092b7b> : path=/usr/lib/x86_64-linux-gnu/libselinux.so.1 build_id={0x3ba6e0c2,0xdd815e8,0xe1821a58,0xa5940cef,0x7c7bc5ab}

Yes. And I think that's what you should aim to generate. Not inode
numbers, because inode numbers are the wrong thing.

> Note, the build-id isn't really necessary for my own use case, because the
> applications seldom change on a chromebook. I added it as it appears to be
> useful for others I've talked to that would like to use this.

My personal suspicion is that in reality, the pathname is sufficient.
It's certainly a lot better than inode numbers are, in that the
pathname is meaningful even after-the-fact, and even on a different
machine etc. It's not some guaranteed match with some particular
library or executable version, no. But for some random one-time quick
scripting thing that uses sysfs, it's probably "good enough".

The build id is certainly very convenient too, but it's not *always*
convenient. And 99% of the time you could just look up the build id
from the path, even though obviously that wouldn't work across
machines and wouldn't work across system updates.

> But printing a copy of the full path name and build-id at every stack trace
> is expensive. The path lookup may not be so bad, but the space on the ring
> buffer is.

So that's the thing. You can do it right, or you can do it wrong. I'd
personally tend to prefer the "expensive but right", and just make it
a trace-time option.

> To compensate this, we could replace the path and build-id with a unique
> identifier, (being an inode/device or hash, or whatever) to associate that
> file. It may even work if it is unique per task. Then whenever one of these
> identifiers were to show up representing a new file, it would be printed.

So I really hate the inode number, because it's just wrong.

You can't match it across machines, and to make things worse it's not
even *meaningful* over time or over machines - or to humans - so it's
strictly clearly objectively worse than the pathname.

But more importanly - rven on the *local* machine - and at the moment
- it's actually wrong.

Exactly because the inode number you look up is *not* the user-visible
inode number from 'stat()'.

So it's *really* wrong to use the inode number. It's basically never
right. And bever will be, even if you can make it appear useful in
some specific cases.

The *one* saving grace for the inode number is that *in*the*moment*
you can match it against /proc/<pid>/maps, because that /proc file has
that historical bug too (it wasn't buggy at the time that /proc file
was introduced, but our filesystems have become much more complex
since).

So if you do that

    inode = file_user_inode(vma->vm_file);

that I mentioned, at least the otherwise random inode numbers can be
matched to *something*.

That still doesn't fix the other issues with inode numbers, but it
means that at the time of the trace - and on the machine that the
tracing is done - you can now match that not-quite-real inode number
and device against another /proc file, and turn it into a pathname.

But it's kind of sad to do that, when you could just do the pathname
in the trace directly, and not force the stupid interface in the first
place.

And honestly, at that point it's still not really *better* than the
pathname (and arguably much much worse, because you might not be able
to do the matching if you didn't catch the /proc/<pid>/maps file).

So the inode number - together with a lookup in /proc/<pid>/maps - is
generally about the same as just giving a path, but typically much
less convenient, and anybody using that interface would have to do
extra work in user space.

And *none* of these issues would be true of somebody who uses the
'perf()' interface that can do all of this much more efficiently, and
without the downsides, and without any artificially limited sysfs
interfaces.

So that really makes me go: just don't expose this at all in sysfs
files.  You *cannot* do a good job in sysfs, because the interface is
strictly worse than just doing the proper job using perf.

Alternatively, just do the expensive thing. Expose the actual
pathname, and expose the build ID. Yes, it's expensive, but dammit,
that's the whole *point* of tracing in sysfs. sysfs was never about
being efficient, it was about convenience.

So if you trace through sysfs, you either don't get the full
information that could be there, or pay the price for the expense of
generating the full info.

Make the "give me the expensive output" be a dynamic flag, so that you
don't do it by default, but if you have some model where you are
scripting things with shell-script rather than doing 'perf record', at
least you get good output.

Hmm?

           Linus

