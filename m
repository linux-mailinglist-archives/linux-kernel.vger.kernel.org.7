Return-Path: <linux-kernel+bounces-792540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB9BB3C55B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8192D3B3849
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD66529E0F8;
	Fri, 29 Aug 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RbU49wJY"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2921C5F39
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507552; cv=none; b=RUxgnJpfpze2a8Fzy/e3MYwn33nROWivm0N2mbWI+NwneJx2gbSfqyDISYRauy2JEz4BKGU2dBdE678boSgYF9DhQFxAzMf6DcwKnnLIQLYYrcW4EmcJnSqFWpSuoXy/8/XRQlY8Q+yrt6qE1cmQX2PrKPwo9fAPsfuw0bk2G/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507552; c=relaxed/simple;
	bh=CtY2mpOi2NxxfnHcuhpi2dhAC8q+hcvmMeWqGSAe4aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6vACXzKw+KAuINFZrs5vdQZJ6hfqJCJAgNLBOnHmsWJ97AcwcUHadSiBZ6Sr/odmhWmsufOwhDJ+/Vr59cjTqu0XCSsN07kTv2lyBNEw/1oJwgG8x9YIiOn58iApz+zoyRaShgA80wd91aW39x4uT6wSz7uFrsTrt1VMhWBFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RbU49wJY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f4978bc0dso3018982e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756507548; x=1757112348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80fI9uxCwh0sulZ4xikoEydehsTfM/BZBcIbW551mMY=;
        b=RbU49wJYARKdnT3ux1x7mfwQSi6Baey684bfTXUIAFQMLh2tfrGQRPKipUzP6O+CL/
         NY1LYiy/3mP/3i8QCpJ+pbw1jM7C22dnnih0rLhrIP9W2tHvzioRckNr8Npdk6IV4PUf
         RsnaQz8FZLaQgB734ykomABdrKd+MPPni+dPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756507548; x=1757112348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80fI9uxCwh0sulZ4xikoEydehsTfM/BZBcIbW551mMY=;
        b=LIFwxAKqBNL18iwUyJaRst77UJoRIJES/PhQ0WJDFYZlMUe0s8UT4H2oia+xRZIGyg
         fmXa5Bq+Q13dqtfz1HLGUeZrAhl1gYR+jLGVjzxAhD6fp6WZhHPsQZ0tnf55YxrqVpLh
         2SK4KBDDj0Xu5Gk9voB359L+FjWz5lFUPgUKtG0ln+9kylxeTJwbkuuSQfpnFZoP83O9
         tO5FX4wm+3duqxL1c/vmM5rc7buKa+2Zp7TYBTsd3rHj36GZIkK8XFfEnaNkzoKKW7V8
         oO92VxPoWOpEhEq9OKo76ek2/J0VjwzgEDXQ+HbOOCsVQKhgeX8xgX18b0seoPvTDioH
         5pjg==
X-Forwarded-Encrypted: i=1; AJvYcCVDyHsdLDEKBQmuhD6LgwvJeezX/ddjUUgShwFJ0UEeH/EUN8XCvM0nGBX44DxkqyN1gYRwgAFpFnxXFMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfajStw9T3TIJZf4VVy8/SxB3Xq/ifC6Lie75fRyxBY7M+76j
	YrYuXp9HSov17D03kBVzjZRZ40DaRl86oC4Tw4MSq0r+YYKE8D8oWT4dw9fFhWM0DpH+pYsZCGy
	PG5wB3DpyFw==
X-Gm-Gg: ASbGnct/EhKY0Ei+lZzSjTN3mNPZ100MOrbPfRHcIHEIb+crezbuSKsJgBiFiRTrjPw
	MYLJNy+V19iUdb/A3Fwcn3fg9rgtav3ACSv1RgEzU9OpaJMpHxvsS+PKYnRbI5IwBeI/tuDEN5Y
	z+MT2LzXtWIszuW0XOYiSKjx2Y7Ld/lRlmLG2kmuR8IlgWl/g16JS6wJ4WUvYEi3J24Q5h4TQqp
	VKjf0PmHQ7zJY9ft5wnm93GDnJrHRPF+X7SRGT9sU8ZVVxnq5tNKxM7R3LWFFLTVwq17+0y+Bjm
	8uyOF/dQVDC0j+1KL226m6Fnk01wqltk6UmBLJF4E1psUqX6nwZB29QR/KmpY0m75zame2Bmepr
	eG8vJc4tO7VR9fop/OlYu/3on+6Ro5pK8Hqp5542334QV3TRAmorXyX7vvi7seR3+noDtN/FTMA
	rLYWR4TEgpPlg=
X-Google-Smtp-Source: AGHT+IH5t8iEeyR8dvc5Tge5vP8wwd9JwwO2XNBumFXBswoQGajJOJJWKXHXQXiMVVIuXzD3KzfEJA==
X-Received: by 2002:a05:6512:238b:b0:55f:35bf:972c with SMTP id 2adb3069b0e04-55f709b739amr47833e87.56.1756507548300;
        Fri, 29 Aug 2025 15:45:48 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f67a414d5sm950196e87.128.2025.08.29.15.45.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 15:45:47 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-336af63565dso13934001fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:45:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTcfCk207FNrY3+9bpJ4Au3CEccT6pcylTmHkEU234sWERYuz6WdtG6LzRk3tFh/xIGcjcRFX5D4+/g0c=@vger.kernel.org
X-Received: by 2002:a17:907:c27:b0:afe:63ec:6938 with SMTP id
 a640c23a62f3a-b01d8a308b8mr19318766b.7.1756507224565; Fri, 29 Aug 2025
 15:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828161718.77cb6e61@batman.local.home>
 <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home>
In-Reply-To: <20250829171855.64f2cbfc@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 15:40:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
X-Gm-Features: Ac12FXyqIi5ZrrVYAf6L3CbDdFJBIuaHmGG9fnmZTA9Sh2oSS7jS6S2QKEpzFcY
Message-ID: <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 14:18, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Just do the parsing at parse time. End of story.
>
> What does "parsing at parse time" mean?

In user space. When parsing the trace events.

Not in kernel space, when generating the events.

Arnaldo already said it was workable.

> When I get a user space stack trace, I get the virtual addresses of each of
> the user space functions. This is saved into an user stack trace event in
> the ring buffer that usually gets mapped right to a file for post
> processing.
>
> I still do the:
>
>  user_stack_trace() {
>    foreach addr each stack frame
>       vma = vma_lookup(mm, addr);
>       callchain[i++] = (addr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
>
> Are you saying that this shouldn't be done either?

I'm saying that's ALL that should be done. And then that *ONE* single thing:

     callchain_filehash[i++] = hash(vma->vm_file);

BUT NOTHING ELSE.

None of that trace_file_map() garbage.

None of that add_into_hash() garbage.

NOTHING like that. You don't look at the hash. You don't "register"
it. You don't touch it in any way. You literally just use it as a
value, and user space will figure it out later. At event parsing time.

At most, you could have some trivial optimization to avoid hashing the
same pointer twice, ie have some single-entry cache of "it's still the
same file pointer, I'll just use the same hash I calculated last
time".

And I mean *single*-level, because siphash is fast enough that doing
anything *more* than that is going to be slower than just
re-calculating the hash.

In fact, you should probably do that optimization at the whole
vma_lookup() level, and try to not look up the same vma multiple times
when a common situation is probably that you'll have multiple stack
frames all with entries pointing to the same executable (or library)
mapping. Because "vma_lookup()" is likely about as expensive as the
hashing is.

           Linus

