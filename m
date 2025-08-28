Return-Path: <linux-kernel+bounces-790807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB1CB3AD4A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9650916A981
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEEE2BF019;
	Thu, 28 Aug 2025 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LdMcs4FD"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68421196C7C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419076; cv=none; b=dXIXrS4Hj0VCqBHaFPyRRLKcwUXazDx/VaJrhtg3UICFvSAipVaMxqv/fqFwE+Vq0TypzJZXtzOzNyRX/GXr798iU8Lhcm1zCEKiFNUmorXjJYAyI7k9g+HM3QozG5SCqvFkaaz/VncEphZjqZ23K17cl/I/cwSfEPiXd0VbtzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419076; c=relaxed/simple;
	bh=9WEGzCFhZV6sH6YxOCr5ztz6wxhV90gkoN+WpO2tJ3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSj8a9dS965z+C+j7I3SIMOJMiB3jE/lhgKillHWOxA6b3GFCiWLuP13YvI4ioSIx6d4q1r7i3iSOCftwFTvt3lD7QyXSQB4WvCGU3iRMrYeR9BA4xRtNo7rHeG0/GhG7DLIekXP9KlxYC67CvfXik9/bfg3PuyVsnIuJM9ef70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LdMcs4FD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afe9f6caf9eso215490066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756419072; x=1757023872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PvdilKb/k6sbi3O/WOYoC5wLcLE1gCyu//e95KE+Wa0=;
        b=LdMcs4FDZs3Fc+tW3G5aind3UJ1BYGG19x40EAC0vOu4Q49jUoDAPH4HbFME30b+bk
         fLUX2Z+QTKD051jO3TNKwa1hKudYCA6BYfR/XNF8ac6Nb9YPzUrTfdWsdfUOeg1phlvP
         aCvEOk/qICUl0TzRHlQgxZFOAEPYu4lo4YwDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756419072; x=1757023872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvdilKb/k6sbi3O/WOYoC5wLcLE1gCyu//e95KE+Wa0=;
        b=ah5ipVJ9bRb6PfMs+2x1qNnliSN2Uk4SaSE4KlLwoiTs1DquHHH039wdp98qxYQ78H
         KD6QlIgFqzwsSMZf9Y02YBEyj2YRLbJXlqvd24lRa131pcbggvPc2Cu5jpeBN4ZCuZwC
         Fdf5pwZdd4cOXBM2UyvsIK0fsdoJisHETJbWqRIrXKQKu39adu2MLw6mvkTePGJvbBtT
         zm6Cubb2EAI2ejef22W0I6/FM54CjDICePwUrxwuIPvO3QSXQOQGaELYX2oPIN5Dwzj8
         9cSHoYbkobAPkV7UItTCVXD3MOBDa8Hukgdouo7O4973I+dETmlT5PftM0PNN5ofXnfj
         Z3oA==
X-Forwarded-Encrypted: i=1; AJvYcCUmUJE3qIX6OF2oWqVddMMhGkJfLRVjb7m46gELTTDpryf74tV/CVCRI5vNTTQUb3sLT5bzMmyBdDX84jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI06CB7SxyDNCaRH4O8A9Yt3FAozHpJkPq5K2l4x7Cwe9u7DvV
	cZp4+MKXooTKOuTQfAznCmHwzkV/NRnlogodt1DBbT69Gx3rSkxmrgOsiqC/WFVjpvNf4IdiPvI
	8nNWtrhqFVA==
X-Gm-Gg: ASbGncuvdk7PyW+6RyJWNf7I1R2wxezVcM6avhtjFUlSieWhzPAryy1pR7GFDMlL2Lr
	nUgrluwYjxpDDeiswoEb4lcmHj/QnnL/F1YLokBV7V/5YseXCIitz3C27UxnWg3gVrK7nQe8XQC
	UNMaWUqs3slX4W1cGVIzMPcsTIT0IC/P+u0kZiTtyulQCvDz9rV67+5Sz0zq/Qgzcrwjjh3W/9R
	BTxwDtOrMDzjrAqAf2DI14izDIohCm01yMKYmUKWMMS73raJfZOsPy4B7EzQf4AgNGeanehGth+
	GuCvqKfgyTE2Zw3OwuaZpEO5xquXuTTmIBXBsNXR9NzbORc703tEOdQVf3oMCsVVQ8kXOcfMShi
	D23gSKtsiDcMtJprbnAg9TPMoyFP5uAzBCEYUJZ8f+qT5zRPReV8yqWQLetgqPNY3wFDKqzu/vA
	+lJJzBufX+v8areiuU2Q==
X-Google-Smtp-Source: AGHT+IF5Nv70uO+o6ORBTr+ve3hypDGDB0tBa1cdEZv7hlRsy5ox99ZFWCWjcTNmFFSZF0Q9V6ndLQ==
X-Received: by 2002:a17:907:80b:b0:afd:d994:7d1a with SMTP id a640c23a62f3a-afe2970a133mr2496663866b.63.1756419072440;
        Thu, 28 Aug 2025 15:11:12 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7edb7csm51769466b.2.2025.08.28.15.11.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 15:11:10 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso2115855a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:11:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRTkIi2T4gaKA+DsO11iMyV4jyzbe00Ye8jFC2JcKDqTwkvW174SzlJL2/EYRHYZG8c6uZiGSk0NnsqJI=@vger.kernel.org
X-Received: by 2002:a17:907:60cf:b0:af9:3116:e0f6 with SMTP id
 a640c23a62f3a-afe296e6412mr2315793666b.53.1756419069671; Thu, 28 Aug 2025
 15:11:09 -0700 (PDT)
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
 <20250828171748.07681a63@batman.local.home>
In-Reply-To: <20250828171748.07681a63@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 15:10:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
X-Gm-Features: Ac12FXx5hAxpj7R5TefcskUP8HKtgWPbH5S6RidfTf_IcaWQCyRoB2repH8EaWs
Message-ID: <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org, 
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

On Thu, 28 Aug 2025 at 14:17, Steven Rostedt <rostedt@kernel.org> wrote:
>
> But that's unique per task, right? What I liked about the f_inode
> pointer, is that it appears to be shared between tasks.

I actually think the local meaning of the file pointer is an advantage.

It not only means that you see the difference in mappings of the same
file created with different open calls, it also means that when
different processes mmap the same executable, they don't see the same
hash.

And because the file pointer doesn't have any long-term meaning, it
also means that you also can't make the mistake of thinking the hash
has a long lifetime. With an inode pointer hash, you could easily have
software bugs that end up not realizing that it's a temporary hash,
and that the same inode *will* get two different hashes if the inode
has been flushed from memory and then loaded anew due to memory
pressure.

> I only want to add a new hash and print the path for a new file. If
> several tasks are using the same file (which they are with the
> libraries), then having the hash be the same between tasks would be
> more efficient.

Why? See above why I think it's a mistake to think those hashes have
lifetimes. They don't. Two different inodes can have the same hash due
to lifetime issues, and the same inode can get two different hashes at
different times for the same reason.

So you *need* to tie these things to the only lifetime that matters:
the open/close pair (and the mmap - and the stack traces - will be
part of that lifetime).

I literally think that you are not thinking about this right if you
think you can re-use the hash.

             Linus

