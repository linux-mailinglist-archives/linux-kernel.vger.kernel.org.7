Return-Path: <linux-kernel+bounces-792204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C300B3C16C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D93017345A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85433A007;
	Fri, 29 Aug 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d6Lu2aVn"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173EE338F28
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486783; cv=none; b=Wd2oKl5WLlFAPXlhw6vPOu8Easiq1gICJm5VeUDDaHpCSPaoXCX5tneqSheZJRmteFrB5vJK7QNG5tkbCvp3QOcsZnAk5ZU/YVgbZslD4qHkKNUCsnuCYqgauB6DlC3X5nCahsKF7/HxFAG6vYxduIBqQ2/zR3m77iS9JYeGlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486783; c=relaxed/simple;
	bh=SoJHOnBFCfoGCBXTsMVg+w/WiCD13CEgrKBCjixr8RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8pZvFfK1jaTmf5HM8QPbJXVnz7HkUZWx+AxIK+i8ZIJJr5YzEToFRBOMSGIRRJvUfzuxGP5WmHnsqpZqvxsqfElAx9PucReS2EpA2kelMwitprvybj7rF9EDcJVGwAA1AviSz8MNZLW6Vc3LNv5fDfn6Af+1EAQCqN0r/BAiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d6Lu2aVn; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61d143aa4acso614760a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756486780; x=1757091580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mkhd78GreWWyO+3GVa0xKo1UMaxxdaoGBAEK0+06R70=;
        b=d6Lu2aVnaIYWD83xnVtj4aY/D1Ba0va4p1AVAA/FgD8gu858TIyuPeOC4iLLlo9w8D
         TP5S4ZNn9W1adm9XLguQ47/X0MX58vlG2k0ic4+abFgSc6qtld3NY0kUzmk4HZ141Irb
         +26M0h//WKMsWVRG/10D6FNawOH8f0ZWyl41Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756486780; x=1757091580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mkhd78GreWWyO+3GVa0xKo1UMaxxdaoGBAEK0+06R70=;
        b=t8tJ9EiP4V7Qtgo/6oqHse2EfZxWuf47/fWoim6VRbztLm5SoGXhSYYepd04wsYaWG
         xWCiTWp7X6QZefqF7E3uF4+GVdbcgJuYshgmKqD/hCuidcGEeFnhLb8tbl3r1koOKPXR
         dibOaino+bqBG7hrbIlsMonqTvswQ9eByfizgHSHpLqS9pWjOfi1/stDIb56dhDN/OtB
         UyhvqDuZtTpgMuL1LsUmr6q8dNaGj4EdFjBZ64LQ3m56BBJXV2NiNRLYCKrqEiAeINON
         k7Us3Ww6hZi3OnQM23WXjDOPaOLFzAO9Ywg826c484F9Zla644jJ28A13Ks+JnDgEQy1
         deuw==
X-Forwarded-Encrypted: i=1; AJvYcCV9W74eft8kByfiPt/ul4QustbxVKEjv325OV6sgtFDuJt9nScYshRQDqMRfwVrJ6OCorhAnmLpgyDqGPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaZBI/M/qGb6G280QvAVgNp4DL+UFHkWrhwslWwf5+yetbsMv1
	F7+H2FGHYrvL2GtSDCbph7Xi8oKQBS8FIPoR2eQ4jlOPel1p3kx8QoopDTtMdmTufYENZjUm253
	XsxybPFAjUQ==
X-Gm-Gg: ASbGncs5ZoC98LrrUoJJ3q1yPU0dx4rp3gmTcILLCDfWhcVpWNSIpT2fa1eQXhCTICB
	Ots9zVaN6uCGENCL7VYdHSmvGmKYlDsHXVLv/hpLP/MvQP3Kw/LYP00sGTHFBWQm7Xt1Ch0CKSx
	9xIlgoOrE/YtM0XQp56I/aY5a8y/JfA+UJwITdn/ncpJAY1N6GldLGE6CdI5rlLWuDJeOVopmbF
	SR6wOMijixlg36uaRWdfrsiJAv1ouQY8IhsQCLQaWSQKSJkkohteEaxeswc0QlyxBqdDlWduxWz
	Quu75blgXQHpk8R+AnsjZ4oBKFFTEd4Dt5o3wFstvAsRv6QMgCwp3S+xrRGpCcz0u6La4X1a/c6
	VzHv0/qyS1346+3+XFhpGggIPc3K65kxBhwsGnvYuDPzfc6LKXiR0RqzhlvcUSsDcOlX1292oTT
	maIVWc1tQ=
X-Google-Smtp-Source: AGHT+IHSo+WZS752OrG3LHO+dyF80IW2kRpRMxvzGAKxn7ruEpAFSM/hIIh3tvzWlVR6b+HU1vbbYA==
X-Received: by 2002:a05:6402:270f:b0:61c:ed3b:5c94 with SMTP id 4fb4d7f45d1cf-61ced3b656fmr4346494a12.34.1756486780197;
        Fri, 29 Aug 2025 09:59:40 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4e1a47sm2039790a12.35.2025.08.29.09.59.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:59:38 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7322da8so429635466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:59:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUULDVSQJ8fzEWMDrAoalOJRFXUETuh+MF27Llso96kwjxb4wybfGAvI6J9B35+jGrNxXi5Bspuam46J4=@vger.kernel.org
X-Received: by 2002:a17:906:7306:b0:afe:f418:2294 with SMTP id
 a640c23a62f3a-afef4183758mr490846066b.49.1756486778196; Fri, 29 Aug 2025
 09:59:38 -0700 (PDT)
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
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home>
In-Reply-To: <20250829124922.6826cfe6@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:59:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
X-Gm-Features: Ac12FXzoWvnofwTTj2JxozA4t3wVRQGACFrkZ3mDbu-fxUdeCzXWr6mKd0oudcA
Message-ID: <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 09:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> What do I use to make the hash?

Literally just '(unsigned long)(vma->vm_file)'.

Nothing else.

> One thing this is trying to do is not have to look up the path name for
> every line of a stack trace.

That's the *opposite* of what I've been suggesting. I've literally
been talking about just saving off the hash of the file pointer.

(And I just suggested that what you actually save off isn't even the
hash - just the value - and that you can hash it later at a less
critical point in time)

Don't do *any* work at all at trace collection time. All you need is
to literally access three fields in the 'vma':

 - 'vm_start' and 'vm_pgoff' are needed to calculate the offset in the
file using the user space address

 - save off the value of 'vm_file' for later hashing

and I really think you're done.

Then, for the actual trace, you need two things:

 - you need the mmap trace event that has the 'file' value, and you
create a mmap event with that value hashed, and at that point you also
output the pathname and/or things like the build ID

 - for the stack trace events, you output the offset in the file, and
you hash and output the file value

now, in user space, you have all you need. All you do is match the
hashes. They are random numbers, and user space cannot know what they
are. They are just cookies as a mapping ID.

And look, now you have the pathname and the build ID - or whatever you
saved off in that mmap event. And at stack trace time, you needed to
do *nothing*.

And mmap is rare enough - and heavy enough - that doing that pathname
and build ID at *that* point is a non-issue.

See what I'm trying to say?

               Linus

