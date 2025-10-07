Return-Path: <linux-kernel+bounces-844859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32D6BC2EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE0B189CE3D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D40E259C83;
	Tue,  7 Oct 2025 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTK8l4Kx"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89352235C01
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879555; cv=none; b=HtOw+IJjBr2NIJXVaOqeNX1zVsdh524z6Nbz0ohUcScnTrV7z99ByDMakccZep+nxca7lIgWnQfTUM29g/Jab+SxnpY6Z1smT8Rd8cK6EwjigmpJ4dvGuKhW0CWhpPZQ9zNZPUrGSdDpSJCYncYBb4QRfMLgSW4e/cmmEYkNL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879555; c=relaxed/simple;
	bh=sM3A7QvmdBlfaZ/1cFm6HDZFBo8SVeKyCVvxoFkhzqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZZqUnqG8yww2el6k7RZrrtLMQo/ZZlxV7/bc1wzvtfacJ3nSh6YB7MuQQbEbAJn47U+f52M7SjHvaJIx7bgHTTtWrE1gCOY+iIKNrJUFkZYu86CIArddEUlwFq1yKQG3thSErCu44osoDPl/+0tWJjt62sJZz0hFd1QBc1JbLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTK8l4Kx; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6014810fso75122337b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759879552; x=1760484352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znGzsSqOOr/r0H2h0VqSOL5mXrikH4XLgaNPq7VatkE=;
        b=CTK8l4KxIipDZzDoHJM4LG8w9Q4GfR+TQDUkVHXXJUUJXjhvMl5YCGr3Yf3AepE+iv
         dJYwW1u9Q3HMxr2kSBvu0IMyGxq7YSk6tCLTp6jyVFMCNTbKwYeFw1JPBRbPLnbYZUAY
         4uzxre1D8nGF+WAEwvViW3fJnJOS6NF13n7b4hfqZ8QJoiP+jjGL8t4kVbq/XvmNL4gC
         9lFCShhzvxqpGSS7ATavmPFXbkPqQCg+PREW7lHYkxv8QFyHlFAZaecGznNb4v/dG3FO
         YOT5sj6BwTQ8D6HzOm7m1tNtsKs9vk8TQ2hffjJwYaTBr3UD8FlJHTPNiF7m2lIwfCwa
         nHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759879552; x=1760484352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znGzsSqOOr/r0H2h0VqSOL5mXrikH4XLgaNPq7VatkE=;
        b=Nyb/+L9I4S1/aHW8AgAL1nUkLlk3L7VMqrqR0ox7wF7kdpslouiUtrYvGPpoCgQ2MM
         f4RBjCZqSdjTuHdm0MJ1tYFjCaOzpq8v8axV/kJJ2aZdTH59JCn9Hb1NiXtzKLjwXvip
         Bd3c8xSvhKzF2es/6s6XQo2rKWfk52ZIJDGWBtrgsXx6U9gDTe/D0dY2wpjEm2733zVG
         lf49thRVK4CLhPuWgmshvEFRzYKVqKJp97TMm34S3cNhLA3TMoiLrWJbEaVpCBw2bWoh
         Pd7OH+2yNkfsBk77mYNMAqQCgkaByldl5fG9D262QK/w/o9spg6fU34y7VJghMY4/uID
         brjg==
X-Forwarded-Encrypted: i=1; AJvYcCXZLYczciOpQ9HDMtvwY55BKQgCsvVNYnJ4EqEkcs2IJEFtd8Ig+Kwa6KtaYpO7VEaNAS49S1Guc7za0CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEBO/bdRp7NjYbjQtx21J/ztdsh3U0D4cjPydEtXCSxjPl1uxQ
	mtwQCyAFD4WQZjTUZ042cYLjVKxemOqYw9LjHyFwYv63sASIF2c+rWAy5XXITSSdWBPlePtmrNZ
	cbFSEegdhjWoFgu2KVRcNhRJ1yPSlO5aANSN+jyZG
X-Gm-Gg: ASbGncvYfd3HBi70ogGNUV5UQVOXpBhomNBzQjJ4rp+hSOpOXgqx2mtyj3D1lviKroc
	ffuny7SYysY0JCFDDtnBbcnqcXsgvio4a6s9tS9mm2vGPjKghHAIXjbgWn453OLAt921ieN7vuG
	aQmIF2o8zOrhwDhpeqyatJlcMQ+fhnBipRbEuY1KG8YkOqDRW/jGJpCdwU19mbpq5i6z8cIQ/qn
	EWHNh2Qc/q5+FAbpBGarHD4kqOWm+Mizl5icMrKytM2LSvGm6XYAMgh7QAsZYcwgAcKvEN1L6bW
	e5w=
X-Google-Smtp-Source: AGHT+IHwuI2DV/8i9wA+ftWDchHWoXcLhvoxkPYCx4wGBXD6hoJ3XwVMuh37n+yunlF2yMM+iZ57eZJG7up0SSWoOtM=
X-Received: by 2002:a53:d811:0:b0:635:4ecd:75a2 with SMTP id
 956f58d0204a3-63ccb8efe97mr1280678d50.48.1759879552427; Tue, 07 Oct 2025
 16:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007003417.3470979-2-runpinglai@google.com>
 <20251006221043.07cdb0fd@gandalf.local.home> <CABgk4RQwGsn4CdP0K+_7A0j7RVOiHNfoF1ESk17wEuzCea16pA@mail.gmail.com>
 <20251007154308.5b158d04@gandalf.local.home> <20251007163141.1034b120@gandalf.local.home>
 <20251007174208.11fd02da@gandalf.local.home>
In-Reply-To: <20251007174208.11fd02da@gandalf.local.home>
From: Runping Lai <runpinglai@google.com>
Date: Tue, 7 Oct 2025 16:25:41 -0700
X-Gm-Features: AS18NWAB9wq6H0aVv79GmfnejYGOzUl2Ly8MQJ4U2zAS6jGCp5V1hgXWT22LhFU
Message-ID: <CABgk4RSxm8mNJcRn0HdNH3+Y=VDL5gNVvyhhR26wjBme+i5X-g@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page
 fault during preempt_disable"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Wattson CI <wattson-external@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Luo Gengkun <luogengkun@huaweicloud.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:40=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 7 Oct 2025 16:31:41 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > +static void trace_user_fault_buffer_free(struct trace_user_buf_info *t=
info)
> > +{
> > +     char *buf;
> > +     int cpu;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             buf =3D per_cpu_ptr(tinfo->tbuf, cpu)->buf;
> > +             kfree(buf);
> > +     }
>
> Oops, missed:
>
>         free_percpu(tinfo->tbuf);
>
> here.

Hey Steve,

Thanks for providing the buffer-based solution. I tried it and it
fixes the problem!
However, the first experiment, adding pagefault_disable/enable()
around copy_nofault()
doesn't help. Still having the same problem. I suppose the issue is
more than pagefault?

Can you please suggest the next move? I can also do more tests if needed.

Best,
Runping

>
> -- Steve
>
> > +     kfree(tinfo);
> > +}

