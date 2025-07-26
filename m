Return-Path: <linux-kernel+bounces-746828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA17B12BAE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 19:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A77217D912
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445A2882AF;
	Sat, 26 Jul 2025 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R1a7K+KI"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD4F1EFF9B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753552276; cv=none; b=BhpjXSRT3lTr4Kh5gSbhrs37G/laBHJMqADya5801Z7ELgFNOtCZHwdozfs4nEY7mC2k8r3VICkhsV4JEG66WB/Ckbe43b/fJ6dBcoXOx3CL78G8LL34IJ5HFr0kOUPmHBb5MfWAjf8TZZQq5XGaMqGWUVYCIbxISBj9M6S/3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753552276; c=relaxed/simple;
	bh=DooFKyvtMrhcGsvS73nOYMGBp2dUDW7K3Uj8YSGtKyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvQlqK8OK+weemfZWpEYhFkt8uZ9FZZpHpe0/zumxrDHPUtfzSCJz8LcrsK3bVVWBE5REr3CgvkqHVN/ExtBOPQhCUy6MjhraHi6eNoaLeSJxIGI2gADdAsPdVQiQOEDdEm819wUkTLLCUsUP/O18BJqKik/bk2MgEBbjBDY5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R1a7K+KI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo5632585a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753552273; x=1754157073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HSxbEUJxkP0g7ZjvYqH7NhSZ9AP/JqKw188Y1XM8KDw=;
        b=R1a7K+KItVpkTig0JKRsKxXrlOdm7y2MqXzAiKyqc1jLSiqLvkR4nA5QMD0bUWFuLS
         hKc/0hFLfFVhHjoJ1c8I64dGL5PIQ+CbUWy9HLv3SI9CzeXqDMxT+pKixz2mhV830EPP
         MC++m6Pi6ZeCp5pRJRDMhmDBZzKJm4qqLxwAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753552273; x=1754157073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSxbEUJxkP0g7ZjvYqH7NhSZ9AP/JqKw188Y1XM8KDw=;
        b=IKJjnuavM8cC/cJyq/smbAStyS+jHpKX0FTwmR2xa19XwZjE1OnENuF53C+ZevHWOh
         w2V38NzDO3Y/KdnXGGkrtfNzsTW53NkeJdZ+u/lvuU+wcMBMIaRyCtFiSFhJd5QrrOS0
         4UMDVHi7eNhaQ13L35xSWPHvAEWixiy3TF6HQecCBMUG7xA4r531igsX1e6dKnGuENmm
         +bsLQ4fELddEoP++KciB1+IuCnEQkZg/lzkJZLNTCliA7QMTgLRWDpzjGfXHExMaBftc
         NEcUPPk5jFw/5rHxVhvcFhP3JlNmqVTNteLry4ZDweGQ2yLnUMi/H8y8Fqcb+0Qad6Ak
         wUFw==
X-Forwarded-Encrypted: i=1; AJvYcCVSAdYMae4HIR8I4aonovsRzCEY5uo02cm7C5Jup/i9CFFJpvciLLRZzAR386BlwvQdquT+sXS8nb/iBVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUF8UTB/lrz5qQdyHsngMGTV6IDgRcnZSNdVu9qhp9XEr3d2Z
	lt2A/oIHXm38rVts6APRD+n5g9B6hZSDo3/icu5ENgcOz7EwkIpRhH9Uc+rZGlrPlUnKFfkuLjs
	wrg+NBdU=
X-Gm-Gg: ASbGncu5KvFYOZm9RVkza9tv2AUdT1sgoZrJF4NziA9DcD2JOucMMF5ytTsfli+epK8
	BqGAdperZTCuPtuReqrleRC//sR/JR/44tZ7ZGcZZa/oJEgzQL4rz6gRA49yCAAWO9z9a/DZu2I
	opW3LexB1qxHZq2W/P0LGhs0cJ+OlvUKlH802QTOz/Uq0Sx+HdSYVuMR643VVDTmJm7hBgTGVw1
	QAVlyl1SFWMyEMxsFhxRyXdxqKojm49Yyy1yZdi5SakI2zHWUXHrlhxb6yhqzDvXKZ233f6ituZ
	vJEUb4S0CbjCHHZOwTxvUr33+KPpegwwDNjDG6riIpxDxm1nq4ULngb1Q95lNajNw6BdD9uxVPr
	ukA0E1Nln1EkTUGzwy7v6J1dZUBE8Jb495XWiPT//EcDfgD6NECFeQcCYS9vzsIb6NPeZQbSi
X-Google-Smtp-Source: AGHT+IFssyTApAOhxJU58SLlqBYvE/LKUb2fw7BCVg89YulGeLHStu+0w1xyRhRmP+JMx6RKwF7kjg==
X-Received: by 2002:aa7:d491:0:b0:611:ca7b:d89d with SMTP id 4fb4d7f45d1cf-614f1da6149mr4663354a12.20.1753552272869;
        Sat, 26 Jul 2025 10:51:12 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615005860f3sm1190782a12.2.2025.07.26.10.51.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 10:51:12 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso5042758a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUONhYWF0koR9Ij2QH6slBj7OMbGcCEDw1yktwykFPLTJvE2uucepuxvPy6v5lvJ+hvpFRdA3fs3j+j7vE=@vger.kernel.org
X-Received: by 2002:a05:6402:14d:b0:611:d10e:ebd7 with SMTP id
 4fb4d7f45d1cf-614f1da658amr5711204a12.19.1753552272125; Sat, 26 Jul 2025
 10:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724123612.206110-1-bhupesh@igalia.com> <20250724123612.206110-3-bhupesh@igalia.com>
 <202507241640.572BF86C70@keescook>
In-Reply-To: <202507241640.572BF86C70@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Jul 2025 10:50:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
X-Gm-Features: Ac12FXwUXdIlVLvMNocbefDF6HEUwlAESHc5g0TBeq7Fw2jKEkXsJpBWks3U_Dc
Message-ID: <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

, but

On Thu, 24 Jul 2025 at 16:49, Kees Cook <kees@kernel.org> wrote:
>
> Why not switch all of these to get_task_comm()? It will correctly handle
> the size check and NUL termination.

I'd rather aim to get rid of get_task_comm() entirely.

I don't think it has ever made much sense, except in the "guarantee
NUL termination" sense, but since we have basically agreed to always
guarantee that natively in ->comm[] itself (by *never* writing non-NUL
characters to the last byte, rather than "write something, then
overwrite it") the whole concept is broken.

The alleged other reason for get_task_comm() is to get a stable
result, but since the source can be modified by users, there's no
"stable". If you get some half-way state, that *could* have been a
user just writing odd names.

So the other reason to use get_task_comm() is pretty much pointless too.

And several of the existing users are just pointless overhead, copying
the comm[] to a local copy only to print it out, and making it much
more complex than just using "%s" with tsk->comm.

End result: all get_task_comm() does now is to verify the size of the
result buffer, and that is *BAD*. We shouldn't care. If the result
buffer is smaller than the string, we should just have truncated it.
And if the buffer is bigger, we should zero-pad or not depending on
the use case.

And guess what? We *have* that function. It's called "strscpy()". It
already does the right thing, including passing in the size of a fixed
array and just dealing with it the RightWay(tm). Add '_pad()' if that
is the behavior you want, and now you *document* the fact that the
result is padded.

So I claim that get_task_comm() is bad, and we should feel bad about
ever having introduced it.

Now, the tracing code may actually care about *performance*, and what
it probably wants is that "just copy things and NUL-terminate it", but
I don't think we should use get_task_comm() for that because of all
the horrid bad history it has.

In other words, if "strscpy()" is too expensive (because it's being
careful and returns the size), I think we should look at maybe
optimizing strscpy() further. It already does word-at-a-time stuff,
but what strscpy() does *not* do is the "inline at call site for small
constant sizes".

We could inline sized_strscpy() for small constant sizes, but the real
problem is that it returns the length, and there's no way to do
"inline for small constant sizes when nobody cares about the result"
that I can think of. You can use _Generic() on the arguments, but not
on the "people don't look at the return value".

So we do probably want something for that "just copy comm to a
constant-sized array" case if people care about performance for it
(and tracing probably does), but I still think get_task_comm() has too
much baggage (and takes a size that it shouldn't take).

"get_task_array()" might be more palatable, and is certainly simple to
implement using something like

   static __always_inline void
       __cstr_array_copy(char *dst,
            const char *src, __kernel_size_t size)
   {
        memcpy(dst, src, size);
        dst[size] = 0;
   }

   #define get_task_array(a,b) \
      __cstr_array_copy(dst, src, __must_be_array(dst))

(Entirely untested, hasn't seen a compiler, is written for email, you
get the idea..).

But I think that should be a separate thing (and it should be
documented to be data-racy in the destination and *not* be the kind of
"stable NUL at the end" that strscpy and friends are.

               Linus

