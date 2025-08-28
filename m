Return-Path: <linux-kernel+bounces-790606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA20B3AABE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CB81C86ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456CD265CA8;
	Thu, 28 Aug 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QCEMsivX"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88528265CCB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408741; cv=none; b=IYKmhg7fWmFjuqFtN5igJZuMEylwPzud0kiVU+pXSygb1I9t6OBSoDjaC6vfF6sSN2EDfyf9En0fcCcMx0lxDSzNe45EAxt6YtVCkuVkzo4I28Xskat1ibOry0W8+yBj/tDO7vs/Sfq14LnmttTZJ70s0t2+3qdCpbuDrRdUOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408741; c=relaxed/simple;
	bh=2IF4LwSznkIAWKigu6MO3g12tp2YjOkonuilJ4MG6gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okdDfSY4qeCm6Pq4e8z98hS9I9cIItjQxpAedEUM93gbNd3gTjzWnSNDlnZh4BK8FetKjj/4j63FfQ7k1fe5FxYnBRf+jZiURotSY584ZF+igz9fA4ucxjrAYeZYRYc+8NMDC2uL4UzAjUcJ4WGbe50A0Ms6oyVk/UtlVbyQUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QCEMsivX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61cf0901a72so915384a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756408738; x=1757013538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a9FvOgSym4EqR03gYaZF038ABDYjvh3jMsW76/lQsV0=;
        b=QCEMsivX08FYVJY37gXUZhfHoWMozF3ajby9QSoIozm3dQaYyek7wRz9eUtX1645Ve
         lIOzdZmD0mrhGbkYZhOgjIo0pI6N2Xu2ofBa4LfrHksPh0R56h1jFP2Atr/Hu+J1W5IK
         wSN9hp+gbSQeGZocmdv344N5+LJ2Vcjb5M3Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756408738; x=1757013538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9FvOgSym4EqR03gYaZF038ABDYjvh3jMsW76/lQsV0=;
        b=ovESHMI5qaZptmDLJ85C3fcHEmfPGYzBThxP2k3RJnSOwJNGgCBzdkC4eosTeLFtiz
         rVP5dyKoQMuahK1QTP2KBpD2WGcIv6k5K9xIbBZf6bgs/Fnn9dlmrWW1pKUZskIX0O/P
         S/pDgZh2tkKE09kQxcOn8O5PByt0eF+8FA0PflpyXYNdTcTbbI3EHS6DIaixaWC8nz1/
         NdMBXHJSRYHzjEfk5NHP9EGJYnH9OAUwTNHCQs5dncm/EUylh+ItYbHay8QVRw4CNPC8
         lRcSPUD659R3CipPEYigV46dpIFYEvtmyEvHyrvWX/pEkPAqobwI3D5izEPyZJ/QjtRh
         41Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUMd3ua35HxyN8b2ftcgyqVsM0EfhKzMIqeb6at/OuDL5I7N7Hl2GSHxcYQswvl9QBnUncohzJj1+bHHx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztZ8ue+DG/PN2Rbf1zA3EjmwWSkIc3HrtxV3gdUW2RHxXFWllf
	qbBrmbKPwIvzwUyCyAO3bDPpxGt6VtjNdBFeTYIxCsJowJnZjOUFDtjFc5k3DQ74i7mDp9RVyvl
	MDc5hIGM=
X-Gm-Gg: ASbGncvNU71Sln6KQLp1rtzM5ozK8BkyX26b60uqAdPbILyr8fB+sr8yINLsk0ajd+q
	/HG3VAAApsgDX+h3oeJ0FOYRN1jgfx5yF75/VTpydzGQC32gf2sMhxlNqgETer9xOM9zQ86i+5P
	1TNDCCHJF9FhpTZG5saxAJgPdA6Y5EWRTqGKndOBGXFNkO2TqkNfrDRrSTtIb+WWqSFexfZSYFo
	UbmN2hiU8chC93SBgLpZQks/HoZEOjLibaYvpbvLJBOCPbpzJt45lkEI6O1FTAmSAgvzzIMYCDE
	NUgqkKQPU9Gi4o2LSbiByF29nIkOjM+3B3fQ7EbUuZZWU8/CsfpWefLOToiDOVaOYsXENCROUZ3
	Bf9cfmPizE7w7aJ+PzGnMBbPLsfLHbpdB7IgGxgjN4C2TDR/x4KdckHxUhxbi4BRWBdjDjysRfv
	ZKPbPt5XFag6XX+MQgBg==
X-Google-Smtp-Source: AGHT+IEa0sN6yM37hPX/NN2mbCTQDXpG8v5ZR0udCtHqy7Xwh7slzasAYbpNhOCDVQDidvd+/T7B4Q==
X-Received: by 2002:a05:6402:35cd:b0:61c:90ff:d509 with SMTP id 4fb4d7f45d1cf-61c90ffd5f5mr9271158a12.5.1756408737522;
        Thu, 28 Aug 2025 12:18:57 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4e1a47sm219090a12.35.2025.08.28.12.18.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 12:18:55 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7ace3baso228367066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:18:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/qKFORHpC4iw0FfArgPXGHdxFCMYGk4tlz3zz41LohVZg53hlkq66kdl6BGnQg64xsnHNF/193cKiNMI=@vger.kernel.org
X-Received: by 2002:a17:907:7242:b0:afe:9f26:5819 with SMTP id
 a640c23a62f3a-afe9f265912mr1037393266b.28.1756408735434; Thu, 28 Aug 2025
 12:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com> <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
In-Reply-To: <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 12:18:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
X-Gm-Features: Ac12FXyRk9o0Zpd1fgIo8tAfxDzyblfn9y2Gh_4SDmM8oOmqSsm_2faftGdE2CA
Message-ID: <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 11:58, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> >
> >Give the damn thing an actual filename or something *useful*, not a
> >number that user space can't even necessarily match up to anything.
>
> A build ID?

I think that's a better thing than the disgusting inode number, yes.

That said, I think they are problematic too, in that I don't think
they are universally available, so if you want to trace some
executable without build ids - and there are good reasons to do that -
you might hate being limited that way.

So I think you'd be much better off with just actual pathnames.

Are there no trace events for "mmap this path"? Create a good u64 hash
from the contents of a 'struct path' (which is just two pointers: the
dentry and the mnt) when mmap'ing the file, and then you can just
associate the stack trace entry with that hash.

That should be simple and straightforward, and hashing two pointers
should be simple and straightforward.

And then matching that hash against the mmap event where the actual
path was saved off gives you an actual *pathname*. Which is *so* much
better than those horrific inode numbers.

And yes, yes, obviously filenames can go away and aren't some kind of
long-term stable thing. But inode numbers can be re-used too, so
that's no different.

With the "create a hash of 'struct path' contents" you basically have
an ID that can be associated with whatever the file name was at the
time it was mmap'ed into the thing you are tracing, which is I think
what you really want anyway.

Now, what would be even simpler is to not create a hash at all, but
simply just create the whole pathname when the stack trace entry is
created. But it would probably waste too much space, since you'd
probably want to have at least 32 bytes (as opposed to just 64 bits)
for a (truncated) pathname.

And it would be more expensive than just hashing the dentry/mnt
pointers, although '%pD' isn't actually *that* expensive. But probably
expensive enough to not really be acceptable. I'm just throwing it out
as a stupid idea that at least generates much more usable output than
the inode numbers do.

          Linus

