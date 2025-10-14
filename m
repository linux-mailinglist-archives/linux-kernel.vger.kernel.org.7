Return-Path: <linux-kernel+bounces-851663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D20BD703A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11E944E9201
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420C26B765;
	Tue, 14 Oct 2025 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1PZbMMs"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856425D1FC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406881; cv=none; b=Zc2qlYLjdvR1zMwzfGR/pohM0Cv2Xf1tB17A94Eb0spwCZwa4GoP4F09UG7sGTW4Z17eSa42wu1oRuJFbz3T1tGwjQUvP9VsDFWO7gUwtNldxAwr3t5P/G0usgF9AF7RupChlxUCKojig28sOsqF3JVTMJu9L+o1aCjBmyi/K0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406881; c=relaxed/simple;
	bh=SD0MrHq1ssWxCyKebPiwLK+lpyfYUSbLpahxboz5UU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9vPvguKAW4ebJpR6c1EcnF5m6m5X48gZsHrWnT//fTkUen6O1dlQ3QFE384ei/+xv20MCryhPNnF85S2/ld9v2RReKYmrDazMbF280TCVuCv+855MBT02eyhAFA/6EgHc9bGoUTeSyD1sF2FuX1VCw9EaQMToVLM65lJnFC1wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1PZbMMs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63b9da76e42so3461265a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760406878; x=1761011678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SD0MrHq1ssWxCyKebPiwLK+lpyfYUSbLpahxboz5UU0=;
        b=g1PZbMMs4454TNCD5zmwgDkfo8ROUwYLVatelqK4DoYSMIe3ALdvdHvHUclUxSOIIo
         fGi1elbRruEwt8ukeQBi141pMExvTTqYorYAUZbnN6YJ+y3S7lqC2Pq+N4Am8N4y6IWN
         l9aCKDKj60/zbLaxQNYztNZK8BOddFknYDLT0klUa7kXw2PLxwEHENFCnwBblIPDrMwm
         Hm7NaTeDyBR/zb/8jt+UQ+GzvVzSm1RTP5KyA7aoEUmhVrO+BXqWhIgYWuYk5qYOj7yk
         6D1+pTcByPsoETAqbwELasX4WMFzctSjmdTRskcfmrwjkDSdZWDZy0p0gq0SUZ45W1fU
         LsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760406878; x=1761011678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SD0MrHq1ssWxCyKebPiwLK+lpyfYUSbLpahxboz5UU0=;
        b=YNpMOFAUza2/egxTGCsgNb1n4dELxRoNDbKuX4sEIbNAG7eJ938EltYq+AQLd2Om/t
         a1PSJIFW2fMsYu+dyV18qU5aSQsVqou5ywSpZ7wyzC2YCLwZqNmbxaEsJGf1ZmJ8ZSZD
         hlk2rji3XFe+sehLeSrEMZT4ybsan5VIycwi7wVfc1E98vGttBZNCrd8GM7fW4i6V61r
         KNh+GSWzxG/SaAmsR0+XG8/F5EasCgop8EePBW3bOKDor0yJuXZYBSKHZ+xITDJc8Hz6
         I0Y/lQTyhBTCVfV4yo+g/oLaM2JbN9g/eC3qfeKE/4anE3rVazI+uyxm0eghCpjnMT1e
         CsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXJXpck9lXRAEpsvijts9scy1Z5x1cjU4zGYpdOd5zFbtGhn8zw+EJ+vFYLP2XACB40So/nxiaK81xayc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTMoq8JlgIUzTqIoNlXEuKo1dXM4BQolJ+5e42pw0m8peUnwLp
	o3NYxLs8x4oyHkFlFNadV2ofSBv/cqJjLW632CGT44BtNM0yIysWl9sMR6qCQqDqmwcJYkCYCbG
	YJ+QOK0qVjQsp4clO2E9JNAjv0RRg35g=
X-Gm-Gg: ASbGncvVQnYZ/lqLKZAxpQyeGxCFT3OGhj3DvV+eG+FPV+GFn8WpPcOZYY2fcDNWmOt
	m5N881fonLOGWWFcfcrfc3eTeSvNcQGbd1j5kQupsPBWuvlZrRAdJ+z8FSSf0Y/2N1oswbgfr9N
	+iOE3bt+h0CpqliLl0AJGLs2Rj5XDqRxMGCUrYQPdUPMpQZOqykXQ3bjXndepvTw4rDZk1BFbs5
	tJjpdseLmPAG9UFZ0pMeMMYEHY=
X-Google-Smtp-Source: AGHT+IFLyxaSkOEOsooMOy2EVh9b/r6FfxU6eF7+7y498s306bG3kLVif9WpacsPupFTNoocWy6y1TRJXeS5SduTWfI=
X-Received: by 2002:a05:6402:34d6:b0:639:fbc8:d38b with SMTP id
 4fb4d7f45d1cf-639fbc8d644mr15052860a12.11.1760406877642; Mon, 13 Oct 2025
 18:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com> <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
In-Reply-To: <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 14 Oct 2025 09:54:24 +0800
X-Gm-Features: AS18NWBcWVoXtEhIyQDN7IDKtMQW7Sq_qJyx9nFb6aduVYEfQL76vjSRcYH8nz8
Message-ID: <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 8:22=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 5:15=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 13, 2025 at 4:53=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > Just a few observations (if we decide to do the sorting of BTF by n=
ame
> > > > in the kernel):
> > >
> > > iirc we discussed it in the past and decided to do sorting in pahole
> > > and let the kernel verify whether it's sorted or not.
> > > Then no extra memory is needed.
> > > Or was that idea discarded for some reason?
> >
> > Don't really remember at this point, tbh. Pre-sorting should work
> > (though I'd argue that then we should only sort by name to make this
> > sorting universally useful, doing linear search over kinds is fast,
> > IMO). Pre-sorting won't work for program BTFs, don't know how
> > important that is. This indexing on demand approach would be
> > universal. =C2=AF\_(=E3=83=84)_/=C2=AF
> >
> > Overall, paying 300KB for sorted index for vmlinux BTF for cases where
> > we repeatedly need this seems ok to me, tbh.
>
> If pahole sorting works I don't see why consuming even 300k is ok.
> kallsyms are sorted during the build too.

Thanks. We did discuss pre-sorting in pahole in the threads:

https://lore.kernel.org/all/CAADnVQLMHUNE95eBXdy6=3D+gHoFHRsihmQ75GZvGy-hSu=
HoaT5A@mail.gmail.com/
https://lore.kernel.org/all/CAEf4BzaXHrjoEWmEcvK62bqKuT3de__+juvGctR3=3De8a=
vRWpMQ@mail.gmail.com/

However, since that approach depends on newer pahole features and
btf_find_by_name_kind is already being called quite frequently, I suggest
we first implement sorting within the kernel, and subsequently add pre-sort=
ing
support in pahole.

>
> In the other thread we discuss adding LOCSEC for ~6M. That thing should
> be pahole-sorted too.

