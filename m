Return-Path: <linux-kernel+bounces-766176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E112B24345
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7FD727F64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28312BE020;
	Wed, 13 Aug 2025 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn3s1VqG"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF42E3703
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071582; cv=none; b=T/sMrW9mTWe+6JlE7E3W0IwerI9xpY3VceFHMzgUEf2cXz2AMmb8yM2cVZ/MUud2OxKGpvg2pyURLk7nyHSR0ME17E9JM4RjBybCvzvJ9GJtUUCQ6WJqMNv06owk8MEYR8zrDRuj8XK6NVMgXFk5a+w61eaaJl6JHkHRHNwP5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071582; c=relaxed/simple;
	bh=f+S3gOFqwImEsJEICH99lenwE5M99OUKlgRH1xjj/Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osFybTqVyX3USfIGHu6qYz3Z9UG/CXjkhjvVc/sW863rvLz0FbimWZUcqvYknaezrJIVnJy8fQtZ79hVgYF5tnv+yJc+97GeS8IMnt7UcMHawVMA+/1Ejm+A0H0DkzHMmkEX/vMJV24LXeW9/O3xfPk0MK8hUpP06wuJKCMhxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn3s1VqG; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3322a34e84fso53990791fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755071578; x=1755676378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuNYhnn6aytC/r+EF2G2jA7FOCcxkDKpQ1Ff1dFxDJo=;
        b=nn3s1VqG0m2LPHVuGLCiM3dEvoeTR6UTZCmVqZ66EhnHtaaIhjrYEPsgc49lE3/XB5
         Bxctl5X9BzzhL5CPJOhes2gSlRe3Llnu1HnKUdPVJPiYoBJcxSY8Ox5u5XU7B5vcjXZs
         hg22JL08XS34RT8ZMMAOdnAls/X/1Hb53ls2pMEfKWfpStHtY4QkMEdJB3A9h3h/zQpx
         tIDFQzaesfIKO8v2STyali03Eiqxzu7FIjJErYVL/PHiMMMiYJm4tdbim3MnDQcsO+qp
         usg7hYCPNfpZ1nrz+7Jhy2tUFMYsAa3uRHxDYqP4fAb/ZsYi+mxiIdNYLqYJ1uHR0axm
         7mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071578; x=1755676378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuNYhnn6aytC/r+EF2G2jA7FOCcxkDKpQ1Ff1dFxDJo=;
        b=EUx8Zv+w5rhwKIbHV+zxo2l/ck8OfT3ziw6/qVMf4OC2oHfmS5zf75KJdqGZlJ1hvm
         MIJ/IGCiaAQKKeDwdyq5ls3xiqfPsEiymc4NkpQuqsZCT9yVo+2npqf8qx/TcMXFj+TM
         i2kqHmZ9FmuvQAQYccRz7sJI0+WbeWCDdMZlIHhyBZAxc9vCJDljBuRd7yk5PktsBxlI
         mOyfq8I9Y7By8FrhEftL+kRk4FP784y2Cq4ny3+CnbTbH9S1X3hTfCaB6L3/Dlo9Bqbq
         xgDg12DGd5cHiHY8YVhv0HBKdqqRu8sn7nvC1lQIFslv9UN0ldMLHQR7GsKf18qhxmiH
         YcAw==
X-Forwarded-Encrypted: i=1; AJvYcCU5UdSfMGmMEJMy6WKjDRysApw78g13uzWTI8IkuYW7A0w7uulyUiuqx9mP5oDpz1VrCtfOMnMiz1D7uGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvZBL6gJxhT7cCo73bX4PulFHUynxUeN1TdLfWmQ+9mJTefnf
	5SvH7BeCdoXtKJNBVrkT/nuYlhFndNvjGkYlshZ9chY9QnpjyvIcdU4NDSx1atrvvqcYEI7/mED
	20l/nf2UtMwqQv17YyHLiD3YqfJTOVMU=
X-Gm-Gg: ASbGncuVZ4j/sooZ1I1mCNnxyUYyQlyh9W9q9cn1wg4IwId1HIkReuKyV5MhDZuHaHy
	qIatBTDp4IA8fYvVPoIS5uXNitFF7eBu/ZMSqKJt1rQ0LBbidDvDMhFRXm7A5+ZOKUCzCgonJW3
	IHsyi66t+YApNBIV+Khw4VmhOdiTv7ybE/6V9Fh5htXI7u3Q1e1QF+FT+63biRNr54PCN45qi/B
	6+FBRsCUnVW+3pH80xmzeKwsqPFyT0+bdMtliiT9Q==
X-Google-Smtp-Source: AGHT+IGFeq7PPC0eDOedQvgcpVbMujIUP3t7+BvdzV2tK5S5ebK463DvsDG3mCmLv5tGlRuKsDUgiKS8yfPokoH4RbQ=
X-Received: by 2002:a05:6512:b2a:b0:55c:ad2a:aa85 with SMTP id
 2adb3069b0e04-55ce03ee417mr558298e87.42.1755071578069; Wed, 13 Aug 2025
 00:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805154725.22031-1-pranav.tyagi03@gmail.com> <871pppfnjy.ffs@tglx>
In-Reply-To: <871pppfnjy.ffs@tglx>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Wed, 13 Aug 2025 13:22:46 +0530
X-Gm-Features: Ac12FXzxt4da2HYC4FFx3-Q0XE9aXKct1tIAwbLc7mv9ge5_lOj4D9vnXeJrQjY
Message-ID: <CAH4c4jKEx4w3LobdSbixXBK4NaSdfa993YjNF_j_pZoqjieBOQ@mail.gmail.com>
Subject: Re: [PATCH v3] futex: don't leak robust_list pointer on exec race
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org, 
	dave@stgolabs.net, andrealmeid@igalia.com, linux-kernel@vger.kernel.org, 
	jann@thejh.net, keescook@chromium.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 3:17=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Tue, Aug 05 2025 at 21:17, Pranav Tyagi wrote:
> > +
> > +     if (IS_ENABLED(CONFIG_COMPAT) && compat)
> > +             head =3D p->compat_robust_list;
>
> This still does not compile because the dead code elimination comes
> _after_ the compiler decodes this line. I don't even need to fire up a
> compiler to predict the error emitted when CONFIG_COMPAT=3Dn:
>
>   error: =E2=80=98struct task_struct=E2=80=99 has no member named =E2=80=
=98compat_robust_list=E2=80=99
>
> No?
>
> There is a reason why I suggested you to use that helper function.
>
> You are obviously free to ignore me, but then please make sure that the
> stuff you submit compiles _AND_ works. Otherwise if you are not sure,
> why I told you, ask.
>
> Please take your time and stop rushing out half baken crap, which wastes
> everybodys time. I don't care about your time wasted, but I pretty much
> care about mine.
>
> To be clear: I don't want to see this in my inbox again before next week
> and then it better be correct.
>
> Thanks,
>
>         tglx
>
>
>

Hello Sir,

There is no question of ignoring you. It is my privilege to be
communicating with you.
Your guidance in the course of this specific patch has only enhanced
my understanding.
I always try to respect everyone's time and agree that I hurried the last o=
ne as
time of my mentorship program is closing fast. My apologies.

I have again sent the reworked patch (v4) duly corrected based on your
observations.
I have compiled and checked it with CONFIG_COMPAT=3Dn. And to the extent
my little wisdom
allowed, I have tested it using the following custom testing code on a
virtual machine:

#define _GNU_SOURCE
#include <unistd.h>
#include <sys/syscall.h>
#include <linux/futex.h>
#include <linux/unistd.h>
#include <stdio.h>

int main() {
    pid_t pid =3D 0;  // 0 =3D self
    struct robust_list_head *head;
    size_t len;
    long ret;

    ret =3D syscall(SYS_get_robust_list, pid, &head, &len);
    if (ret =3D=3D -1) {
        perror("get_robust_list");
        return 1;
    }

    printf("Robust list head: %p, length: %zu\n", head, len);
    return 0;
}

Regards
Pranav Tyagi

