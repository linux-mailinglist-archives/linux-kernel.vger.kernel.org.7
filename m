Return-Path: <linux-kernel+bounces-806914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D8CB49D79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6041BC4318
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC6F2FC024;
	Mon,  8 Sep 2025 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D8sSQ7TF"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BCF2F7AD6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757374034; cv=none; b=YmoY7e4SMtoCrc3T7xWbkcYCwZnzV4LLGArJvoX/FHNPbSkxecLtHXTK2fOQgzV3xAzyUVWfIykIZnIt3Cqx0fltJRTSGUDc9DRr29LbKh4nih7RxofyGNc2x0rSLWkwUY984lrnQDpUdWBhuanWWZRr62nGcowt4OpP853YePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757374034; c=relaxed/simple;
	bh=9j1F9Hlgq0izFEcvkNVfyEGzv++lE2ro3SvVkZ0AdfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEilcauVulo4/77HtV82yTEhYRVhxJ0JoWYwG5XG3w5OjLrKatMG3m6ZenvCaMm+Av1TIgNzEfexIGSiQadRnjFzFVsWcPXNLmmbmG5yoEELC8AbiEEXSv9aIS7KXtVptcenDngXn9n/zydm2tPbIr0C2fJXqRDhxdviG2LoKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D8sSQ7TF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-623720201fdso5206094a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757374031; x=1757978831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bsrp6f7rC2KY8hXQre2m5AM/+TH/nwxi0ROAfuOjXMY=;
        b=D8sSQ7TFnB2qNqWmCFmYLYTeL5vQ927tRl9+2NIgbSQx/y3eC2QaZTLbn+k0wyZSBa
         KN9gL75CvuySwxvkD7aBQ2y5vOOnxx4X1XZzkxOJ5fdFkv8ZSNpJKO+irjMFjgIQplvU
         EB5MSILsWUNZfen1554hk4Zv9XSoDSzQTElfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757374031; x=1757978831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bsrp6f7rC2KY8hXQre2m5AM/+TH/nwxi0ROAfuOjXMY=;
        b=fleEChl1ApvrrV8NEZNmyoo5TMuBBgKHcpDaFA1JEGOmz3Lf8IMPnm+RGpMnqitq5L
         wwRyb3StfMlr/33L3LzuFg/YTN6xKjedWYIcw+S+l1UCC6gEObQgZD5liR9xncr2qiKx
         HMNdPD+0xbZPiBydAaXybMRNw4Lcxjys6uSptBgJBJouKxC6TQqzUgxJRJ6gtp0vom+Y
         PyvBuOD3r6lqCNtgVpQKmwTNK62thaEjClFA3UXhaNwgK0Lr8hWlE1043rDZeHEvcglt
         xrcvycd2vBc/7hj59kKx/apjjQl/ul7Hl5UMI+QWJGzKQF/dDOt222DdBQFVFWuxHP5t
         6aCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB8S9JKzX8TnIERB1hHa0gy//cSofzgx4v4zRUeEx+PxqQY1eUBwYSgZ/mfRINy2Tf1qkBRV1Acjqbi+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTG8GHuEmKbnS13OZbHCVLoSngbeQokKCGymR/aMSzpjiE25A
	nlLlZDBtQIuGQYDuG0VKIrYDtLFGQ6DrmY/mDCopAT6C6uSyLkx7s9jl8hFgctj3cCqozdUvM3t
	9ngJzHmc=
X-Gm-Gg: ASbGncsJ1h1r+qqNv28LQV/aAX1IDI80//kvVeKWjLFayohi2wck0xGUUlPzNgK0UUm
	qXnKAGEnhzyKjeNjaCv/1s/4I8lmv0/bBF+Lb4xbU4IBjFjeZDK8kdCrzfuHaYS106S1zTrWiMX
	HxrtKVewbdgF67X5B5N6Nt38Q1QyMSbV5YtoV519xYEsqvl+g1qI/4rdK+I8Xd3RbEUTjfWBoA9
	mNAQeab2HcUY0TZ+2RMdF8LSpecvgy8/W6oPcJW0KaY6SRT6GcthmLlNg16Xm1ARQDpTkrX9xNS
	K4i+eZIj/ehrAv1hY+fNp2nnFetmgeX+DZ8iqd5OIfBYwXlFuTKUqhjuknEp+en1B5a6COBmngz
	itOE8ZwxFmmKdTxDo8CwVK1KaYAl2n9/9R9jdZ5f/JS1q6/bkxTAXL4YH0bVVJ+H/JcjsZlyqN+
	nYd3Sq734=
X-Google-Smtp-Source: AGHT+IE2FDgOyVizKussiv9apbfYwyb4t37C4e5rp1PAwAxC2/otxegTxGHRbStc7wugU2FIFqJPBA==
X-Received: by 2002:a05:6402:42c5:b0:61c:29e:db04 with SMTP id 4fb4d7f45d1cf-623725eda00mr10119783a12.6.1757374030977;
        Mon, 08 Sep 2025 16:27:10 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f65c8sm45835a12.39.2025.09.08.16.27.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 16:27:07 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7ace3baso867211866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:27:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGJLwAjvpMkwUiVUq1i7AECTPBKW7dz1PUTkaWJ3MUaVMQbM0+t3+h/Vt16s8hyLkikMjk0YnNWec9yQ0=@vger.kernel.org
X-Received: by 2002:a17:906:f597:b0:b04:ad1c:59e4 with SMTP id
 a640c23a62f3a-b04b13cfa09mr966785466b.12.1757374027292; Mon, 08 Sep 2025
 16:27:07 -0700 (PDT)
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
 <20250908174235.29a57e62@gandalf.local.home> <CAHk-=wiEL-5f96NbRtm4JJVi6u=3Edto9-ZABgpOc6WAj=gX=w@mail.gmail.com>
In-Reply-To: <CAHk-=wiEL-5f96NbRtm4JJVi6u=3Edto9-ZABgpOc6WAj=gX=w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Sep 2025 16:26:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyry=1=gabJ0iw_HbqrHkg84gCvKQXi5Qg5u6pq=vwzg@mail.gmail.com>
X-Gm-Features: Ac12FXw_TEqw3uAfoUb6rds-8PBZlK9wEtfwraJcwLFCTgjp6oxAH2_abLFrQqY
Message-ID: <CAHk-=wgyry=1=gabJ0iw_HbqrHkg84gCvKQXi5Qg5u6pq=vwzg@mail.gmail.com>
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

On Mon, 8 Sept 2025 at 16:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Make the "give me the expensive output" be a dynamic flag, so that you
> don't do it by default, but if you have some model where you are
> scripting things with shell-script rather than doing 'perf record', at
> least you get good output.

Side note: you could make that dynamic flag be basically "per-target",
by having the *tracer* open the files that it wants to match against,
and guaranteeing that the dentry stays around by virtue of having
opened the files.

Then - I'm handwaving a bit here - you could have some "hash the
dentry pointer" model.

In that model,  you couldn't use the 'struct file' hash, because now
you're matching against different 'open()' cases: the tracer that uses
sysfs would open the executable and the libraries it knows it is going
to trace, and keep them open for the duration of the trace in order to
have stable hashes for those files.

All the tracer would need is some simple interface to "give me the
hash for the file I just opened", and then it could easily match that
against any hashes it sees in sysfs stack traces.

The advantage of this model is that now the tracer not only has the
hash, and controls the lifetime, it means that the tracer also can
decide to look up build IDs etc if it wants to.

The disadvantage is obvious, though: this requires that the tracer
know what the files in question are. Of course, that's usually not
that hard. You might literally just know it a-priori (ie just from
what you are tracing along with having run 'ldd' etc), but for the
'I'm tracing a running process' you can use that /proc/<pid>/maps file
to start populating your hash information.

I'm *not* claiming this is a wonderful interface, but it's at least a
*fairly* straightforward way to give some kind of cheap hash ID for
the user space traces, and it puts the burden of "hash lifetime"
clearly on user space, not on the kernel having to try to maintain
some kind of hash map.

In other words: if user space wants to get good information, maybe
user space needs to work at it a bit.  The kernel side shouldn't be
made complicated or be expected to bend over backwards.

          Linus

