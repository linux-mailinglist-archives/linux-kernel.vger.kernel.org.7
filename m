Return-Path: <linux-kernel+bounces-829553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BC1B97542
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA5644189F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B914304968;
	Tue, 23 Sep 2025 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRuk6BEA"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E8257437
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655438; cv=none; b=hu0xHRfwfYRZmYyTlMtOrr2gEZw0oS/q4rraVwIXexBXazLD+aEa4VT8GPnwHmKO5CJIDvf8VfB5yosqA897UdquUnGluGubtKAaVWkLU1+caOgjzCtDhPXIWE/csGM22WYZpG6jk3d8ApHkSsfeAuGziYMZdNjIyREAU5GXwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655438; c=relaxed/simple;
	bh=LRBey+Wso4WI7nXLbVLoJP/j9B8XR/yd5YE842494Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZEO7C355bO52kdexgV9apXrRHfHDF2NpJzcMllKXfu1pTzVtCW2o8M1Js9U9Yz/K85QUcn3si+hZSo3U0l5ON71ghcHFy7sgN8eQIXMdDCs/7C6hebSo52ZB/O3+PchsInZK15slF+TcB2nvt316OpiLrZsbeoNbKQUILK5CNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRuk6BEA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso37899635e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655435; x=1759260235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRBey+Wso4WI7nXLbVLoJP/j9B8XR/yd5YE842494Og=;
        b=WRuk6BEAyG5qd/meHhAM7eAqaL4r5/fTvTQySSK8FWKMWz/phX3T8Bmp5q/Eq0P/Hy
         BY01guXAPPgv8Ar/955Q2cy0dFp0spY0ubCvaE9qllh5ppuue09ewDd7vBAK9mEz9g/m
         uZ+EFqLTh2Xh67Fcfj7u4QKfuDTUrpam5XWflOds4o9hSPM6vOsq2k3qyZjA0fIt0tF9
         7AELidGe1q03KzEBdwXFv4J8PcdVHeYgXNc3Jr05WkF+L5uc8OUUb+MnCqyVgP9329BP
         +2nJQ1cP+bM72QQOzpVnJ1v01Bp6QVcUiK4DvXykNtzaq2554VYieYn2d+d2rVPBis2S
         6MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655435; x=1759260235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRBey+Wso4WI7nXLbVLoJP/j9B8XR/yd5YE842494Og=;
        b=WQgFmXJL0uueThmHPuqqVu1Cyn48D9gIsON+Wbxu21CAIzLRmfhBv7nMW3m3MhwXSA
         vBxIGMtwyDHCckoSwEi+ro3HSh2SB9Ymb6ZuQqFjNqHBJjfbZ2foBZ5E9zwWGOUBMCT2
         QZIS8uIksmcAdtR5sFRPjdHIrClkTk3XFPMsH+YFQ/71eqxRhAjtOiiq1DR+sAICnko1
         3/4cngkNOT52wMaHsg+wHFDPVkICrmKtpjrAAziEAFmGiQ3WWf2fUzhL7QMLwQJmHJyj
         Gzr5jmyprkD07j2wVjiu7x2foUan3VidnYw/ceqtU6YNNuM70KeS/+Sg20NPUuBVEHL9
         KlUA==
X-Forwarded-Encrypted: i=1; AJvYcCXukMetR4tYFIPduWh1e/4Ek51oKecBrY77FxgExHLWuUOmIjtyKvBOMBqdhp25kt8qw4VIFkSZGvUryPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfjU7FTuwoNeJ0HDyS3ei6Wi7Kprwwyj8NScXJBMxJFNi0a/+r
	ofqPencx5KmQ2QDRvIJNJNBuGVL5LICvZoMS2xTxyxZX8MMVJ6waRkMl5TOHKpVvTJn0HQFfbYI
	WJnoY+R4dzZLpNcQzacWm5R7mzJwjigg=
X-Gm-Gg: ASbGncvnGdoSGgHJ0qy1QAT+etJyy95ThmnrY0RlmlAaUfqM6GnolIorz4aFHESuXo8
	X42WyEH8hhySYTa6j//+uqUrL+4Tuyt81ZfOM6IkiuUHxqo4I9Sb+jWm75pTDgPSH08e+sBWqt5
	sL8SlkdFiZpC/zSGeKh6jIoZ1OpWGHKqXZQ7aZuSlTe4zbV+jTITleCjxTqKJJK6HeSWFpT5JYM
	qZLAb4=
X-Google-Smtp-Source: AGHT+IEROyvN89zXwrTLvHEBfh+lTjpX1gLN5zjZ4UthmYExEG2GOLLm8ftHboFI82Own50+u3ZOPpnUc08RGvIFLxs=
X-Received: by 2002:a05:6000:2f84:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-405cb7bb76bmr3258549f8f.43.1758655435354; Tue, 23 Sep 2025
 12:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922095705.252519-1-dongml2@chinatelecom.cn>
 <CAPhsuW7THs9G+QV5_g+tMvXTAqVJ7jha-m70f675e9phK1Pryg@mail.gmail.com> <CADxym3b=hU4DuuhA_DAs6VYNUTp7spTsTWamMaxDGSxjoiuwbg@mail.gmail.com>
In-Reply-To: <CADxym3b=hU4DuuhA_DAs6VYNUTp7spTsTWamMaxDGSxjoiuwbg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Sep 2025 12:23:44 -0700
X-Gm-Features: AS18NWASmv7blurpmrNo9VunWCEk5u9gzididl1CMRVq8cti29RRJ98n7ZkNCbQ
Message-ID: <CAADnVQLZMwNUF0PwoCyLUC6tWVuyx80qJF692VgnGoJVm_M=eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: remove is_return in struct bpf_session_run_ctx
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:11=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Mon, Sep 22, 2025 at 10:08=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> >
> > On Mon, Sep 22, 2025 at 11:57=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > >
> > > The "data" in struct bpf_session_run_ctx is always 8-bytes aligned.
> > > Therefore, we can store the "is_return" to the last bit of the "data"=
,
> > > which can make bpf_session_run_ctx 8-bytes aligned and save memory.
> >
> > Does this really save anything? AFAICT, bpf_session_run_ctx is
> > only allocated on the stack. Therefore, we don't save any memory
> > unless there is potential risk of stack overflow.
>
> Hi, Song. My original intention is to save the usage of the
> stack to prevent potential stack overflow,

8 bytes won't matter, but wasting 8 bytes for 1 bit is indeed annoying.

> especially when we
> trace all the kernel functions with kprobe-multi.

What do you mean? kprobe-multi won't recurse,
so tracing all or a few functions is the same concern
from stack overflow pov, no ?

> The most thing for me is that the unaligned field in the struct
> looks very awkward, and it consumes 8-bytes only for a bit.

let's keep it as-is. If stack overflow is indeed an issue we need
a generic way to detect it and prevent it.
We've been thinking whether vmap stack guard pages
can become JIT's extable-like things, so when stack overflow
happens we unwind stack and stop bpf prog instead of panicing.

