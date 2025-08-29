Return-Path: <linux-kernel+bounces-792116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F172B3C056
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A861C80FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847C5321425;
	Fri, 29 Aug 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dnq6wVGL"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C371FFC45
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483701; cv=none; b=uV27/I5ME4TcmV2E/JoJBm7D9vrof1k8k+LR48vjPYWDvNWnJJaMihS5VrbFbO5OVZzBTMnFd6HjcplEYoeTlki4D404eZkmlqicD2e9eG6iy6XzY2o9WXV14/tCBxe44oH2iNdrD1OWeHPsQzGXwkYW7QwCPPeTyEIemt2qE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483701; c=relaxed/simple;
	bh=GGju3T7I+qI0JvmY68eODhYLvUvdUW9PaGUnZEXvJUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjC6b3JM/BYfvWM1Hpz69HJtl47FkUF3fDpE4Tn3Ee7UnbXodl+z2zU87eSjK66LrSaVuEh6dZN2u+WZixBalTOX8/N1fzAJHVNGwr96v2Yr9S48oyiD1G16j5fGlUB1U4QYGCgOwfgnUnV3ThIObFxBNM5+W/N/XpBy2iDh+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dnq6wVGL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so2928599a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756483698; x=1757088498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TadHi9XEzabupVoGJRB+7wCRy98sUdfJOAZ174vFHr4=;
        b=Dnq6wVGLqqRmVLD1mQhjaJrQYUjuevlS4x8pkKqH6wFKDp52vJ7P0OZNwdO5MXQVXl
         IA1O9oq8i/xL5uXRurzXfxCkQJZNAhf3dgugJ9ZWnHIsrSAGOaFs+RaFKq1hHEhxikt/
         izim+Gnfs6UhBOhQTTDj1/EWFWKC4zvrYjmmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756483698; x=1757088498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TadHi9XEzabupVoGJRB+7wCRy98sUdfJOAZ174vFHr4=;
        b=sk57VLOljVAqn7e8P69d/MKfS4qW2yEY+jl4K1K2WpkuVPqidwcs7LyfM4j14vaoGw
         C3Zseo0p+okrtLf35PdSe0kjq9ifPOCEQ5ZtiVtwqauBVeygtTMVQyjWxMbnm4An62oF
         wKArNFdScUSP2uRAmBHAn6fd2178DryimHb5jIbzSaskogINa89PbeZHbEER+V8ysVcl
         v5yYVU0azGGCmXGqqF+OJ4e+UOLnvfvO4u3CXkuf7ufUonRAzFc4+yU9GMlJ/1CigJjm
         QkApoAxQeZyNbCnAIy0QgM5CX9xZ90eu6sywHSlpDeaBrNNIl5UYGwNXwQxnd1j3BY5n
         Y2jA==
X-Forwarded-Encrypted: i=1; AJvYcCVrtE0sp/mFCg6PuHoW20bz1QaBEvswnmjnTDwrO8OrhGTMZ+MNzmmx4uK4yBxuN0AsVzDupihqMIE8e9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4clwt28K3izKefbT/mCcH2XO5sICMBjWGNDCp+6t/7hNhtTQx
	EKBdqmjLMMRhLbMBgPJ+zNAcqq2LitHWDwvnxxISpwiwzXBTx+CT2EfjoBMwC72MLSFk2u7j20w
	8UsW1w9hDxA==
X-Gm-Gg: ASbGncvvjUwD4a8OGFQrWkbZ02a3Irk2qfhRq9S+iPDg/iILjW9sgxXAPykFsbMiCwd
	QActPrgmEaf9aI3TO1Tz+wEPOK0RmMYS3+tRW09Qw9Sl425ebSDViAWSxg/nf99XgaBqs/6eVQu
	S+3+R22+U6u3td7wfM9EyvsBb5J9yNRFdfffpv0sbnCPd8UJGyo5P4XsB993OaDssf+ilywKgm5
	AAJEuXSszFz1nakJq3D/Y0g+BuP75q2Eet4NHJNH19NOeY5jaRllZLkVKvRaAmSqxW1kCs0qrcw
	lb3zdJ50e3sEjI0jOh96vs/a9D2us214ZvRHxspMALF0cqn1n4GFLEtU6r1T8ke713waK3rbLFv
	pBaSulzXqiDCI8n0e5jZQJ9mJ512RMJpzApP7qQcLknuV6ijvVXM/RBTuBX6AbxgGfmrxNldS
X-Google-Smtp-Source: AGHT+IGnpJpQxddnYWKThUp2iX2gIkZwRKRaONca+Nw8FaYmA73fUII972HAhCGlo/BRUeT+MDeH0Q==
X-Received: by 2002:a05:6402:52cb:b0:61c:fa7d:a4d6 with SMTP id 4fb4d7f45d1cf-61cfa7da95bmr3917322a12.24.1756483697998;
        Fri, 29 Aug 2025 09:08:17 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ae40sm1933166a12.44.2025.08.29.09.08.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:08:17 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso3876685a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:08:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJp+SDmLRvnrDaf4vX5TaazRgJUbtZwOsP6MEUdQ4mS2x8a95sfxKrRdqLbN7xKBGk0U2Ec/F7BBrglp4=@vger.kernel.org
X-Received: by 2002:a17:907:dac:b0:af9:8064:21df with SMTP id
 a640c23a62f3a-afe29622961mr2710655466b.53.1756483694425; Fri, 29 Aug 2025
 09:08:14 -0700 (PDT)
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
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
In-Reply-To: <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:07:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
X-Gm-Features: Ac12FXxmFqdib0IcSRzLnio3atIA7a6LSMhw2mK1t4gBHn8rvbJ5NNQPj8I4ad4
Message-ID: <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 08:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, the way to fix this is to not care about lifetimes at all:
> just treat the hash as the random number it is, and just accept the
> fact that the number gets actively reused and has no meaning.

Side note: the actual re-use of various pointers and/or inode numbers
is going to be very very random.

Classic old filesystems that live by inode numbers will use
'iget5_locked()' and will basically have the same 'struct inode *'
pointer too when they re-use an inode number.

And they likely also have a very simplistic inode allocation model and
a unlink followed by a file creation probably *will* re-use that same
inode number. So you can probably see 'struct inode *' get reused
quite quickly and reliably for entirely unrelated files just based on
file deletion/creation patterns.

The dentry pointer will typically stick around rather aggressively,
and will likely remain the same when you delete a file and create
another one with the same name, and the mnt pointer will stick around
too, so the contents of 'struct path' will be the exact same for two
completely different files across a delete/create event.

So hashing the path is very likely to stay the same as long as the
actual path stays the same, but would be fairly insensitive to the
underlying data changing. People might not care, particularly with
executables and libraries that simply don't get switched around much.

And, 'struct file *' will get reused randomly just based on memory
allocation issues, but I wouldn't be surprised if a close/open
sequence would get the same 'struct file *' pointer.

So these will all have various different 'value stays the same, but
the underlying data changed' patterns. I really think that you should
just treat the hash as a very random number, not assign it *any*
meaning at trace collection time, and the more random the better.

And then do all the "figure it out" work in user space when *looking*
at the traces. It might be a bit more work, and involve a bit more
data, but I _think_ it should be very straightforward to just do a
"what was the last mmap that had this hash"

               Linus

