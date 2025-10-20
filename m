Return-Path: <linux-kernel+bounces-860951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF27ABF16D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38DAF4F5EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E792F6906;
	Mon, 20 Oct 2025 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecawvBXZ"
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70736245019
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965385; cv=none; b=p4M43P/TKT9F9dS4tJ4u5epRgNFAtSHUNXZ7uWlRSn2GvBRLx4VhWRtoQ92K08gWDwomuRWgilRmt+T4KkgtJV9eJNHMwyj6P/+nOKOvPchbzUojNJ4noRjBqr2YwkCRJ8GdM2MNqr1ZtSOv9wqXTf+xdTv+hT6Invif3MBJheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965385; c=relaxed/simple;
	bh=arJAKr/SK39xaCcVSfKhVwWPNXJ1iZVUEoDaCay7IWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQcIOvSypG9sFTVo/2gemmgNlC91CHgobrakOTFzvfLm0R8Y0h2GOALueq/aBIbdnwJBRY3D8ctjWsbhVY5fr1WIeKe+3adEvmn5m6NtuSGWqgAvqp9r7lK6TdYbyPo4q7gPjbfQ2HcOTL+klFT0D04zvCt5EJFJSeIY4x3F0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecawvBXZ; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-36d77de259bso32745381fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760965382; x=1761570182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uuEa1GizUQ74028zo19sko0RSacd2iUgNo//+4ytRk=;
        b=ecawvBXZSGR/OtjAilQ5YAGyyRzKd9OeIpY7Fa2NfTN920e7TZfagaAXbT5urJ4ovP
         9sD6rOgC/eIUHqLJPkKsdVNeC1AX9E1ak/p75Ti8X4/6vv82qV65w7MEh5hz9dzbxMNJ
         wvmk9yud1MzCLX9jMg0MoQSZr7jh33u6pOOgxI2dnyVZXUT7udQ+Y9WGy9MFnFDw8+Po
         0Ui6Jpua+2aqyNQHwKJ/bz+OU5gZUhYlrxMLprk7NkCO3P0JLYkkXNAFlDFc++tZW2wT
         xnHVlbp1HLi63rQlWHnDTroy1hlAj62IzudsHW4wHt6xzB+z90oLhdc6QV7rA0cd2rcw
         /0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760965382; x=1761570182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uuEa1GizUQ74028zo19sko0RSacd2iUgNo//+4ytRk=;
        b=VrQQg86O+keMIaY6j1/HnAo8WbpXMibGrOEeOQl9SLQ17YajajquJstU24f6D/Altw
         cuSUAuUwAbvv+fobyPbRAl+HF/DcMMpe9GhF0Z+giX+HNqvP0+VWvovss/KEqs34pvvv
         GHl2KK1yClH2+SughZSgF0yOVzmKUlNgqIsi1qKyfHwYkDzEqsUZANdjrHY0HzmX7HAn
         kO/KmZBifCgveztmbzYPs73d6Z+9pvGlDP96V3FfzE3pq93WwvgHXTg0hP2GDB7hS8zH
         /B7uHm/nM8oYYdbkyoHvzh2WPi1KJZqforbEOKCKo0+erxlzfk1NTwXYvhNOhFarn8P9
         QBQw==
X-Forwarded-Encrypted: i=1; AJvYcCXNy9112CltbCJBZzon6bF1dzPKAuxuUssXaFRmoZBKJWOW/kk2BoUT0Ri1UVLgEH3Lw73QEd6swVLk0Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI+KzLVDV0DCXr+E1TdnaIn6n6Fv3FBEczWwEX8BrNYm/yEp3d
	UmAhdJV3JYXOp9ct1obf4sSnxgkVRQrHqhMhzFRIMDS2Ab/0eLSvTUB7xJOcO0viFdQ/7gxpBmA
	bvB4usH+XKG2laMNnjsRNmsdZrj9io1w=
X-Gm-Gg: ASbGnctGwJl98STzy/hYGmRiAhVQCscB2dKQ4ZfWktLHWCeJbeu4Wa/bWwmuXA/gJ9m
	7aT2DlxbBvzaR+hbNzF8IVfRhmjijstgig9L0NkVJ9LaMJjtwXes3NrorRPSw24NdZN+eCM6jLJ
	YFrncw/fb7/K23vcTHd0K6hU5psLO6Q3xA43SU2ibSPyqWTmpU00GJ5WXs/Eo/M5yGte+qhl99I
	vqTt6qZXT/BT/pBxDMqcAmEYtKsY1TKT31w5JPjVu6Cl+oaa5OiazRTz5nxEiSaXdhTfgg=
X-Google-Smtp-Source: AGHT+IHNzJ3XEsHXRJSlfkxjznD/AZG9sa0VCqsJ/c+5smyHDA2MMKoazPIgSqVAn/23mNld9KJoxvJPzTG+I4zGvjc=
X-Received: by 2002:a2e:9a0d:0:b0:362:b98f:edec with SMTP id
 38308e7fff4ca-37797a28204mr45253401fa.23.1760965381415; Mon, 20 Oct 2025
 06:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com>
 <20251020101523.GE281971@e132581.arm.com> <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
In-Reply-To: <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 20 Oct 2025 21:02:49 +0800
X-Gm-Features: AS18NWCDclAgKEGbog6wTtTC1zhcEOa3aSTen8VqnfyTBuzuEw3Omsl0Mvc1NlQ
Message-ID: <CADHxFxTHYwjqAjURTbkZ=6-4Ti0GGc7uKsrjthL9s78rAgv5EA@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It is worth noting that this is not a special requirement unique to my
case, but rather a common need in embedded development scenarios.

Thanks,
hupu

On Mon, Oct 20, 2025 at 8:51=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
>
> Hi Leo,
> Thank you for your reply and for taking the time to discuss this in detai=
l.
>
> On Mon, Oct 20, 2025 at 6:15=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
> >
> > On Mon, Oct 20, 2025 at 01:16:46PM +0900, Namhyung Kim wrote:
> >
> > [...]
> >
> > > On Mon, Oct 20, 2025 at 10:40:49AM +0800, hupu wrote:
> > > > When cross-compiling perf with BPF enabled, Clang is invoked during=
 the
> > > > build. Some cross-compilation environments require additional compi=
ler
> > > > options, such as `--sysroot` or custom include paths.
> >
> > [...]
> >
> > > Leo, are you ok with this?
> >
> > To be clear, now we are not talking cross build for perf program or any
> > targeting a CPU arch, it is a build failure for eBPF program.
> >
>
> I=E2=80=99d like to clarify the background and scenario once more:
> I=E2=80=99m building an SDK that includes a cross-compilation toolchain f=
or
> the target architecture along with a copy of the kernel source tree.
> The goal is to make this SDK usable on any host system to build
> software, including perf with eBPF enabled, without requiring the host
> to install any additional packages. This is a common requirement in
> embedded environments, where we often cannot control or modify the
> host system setup.
>
>
> On Wed, Oct 15, 2025 at 5:30=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Have you installed the GCC cross packages ?
> >
> >  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> >  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-=
cross
> >  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cros=
s
> >
> > My understanding is arm64 cross compilation tries to find headers in th=
e
> > path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/Debian
> > distros).  After install GCC cross packages, the headers should appear
> > in the folder.
> >
>
> As you mentioned earlier, installing the GCC cross packages on the
> host does allow perf to be cross-built successfully. This works in my
> current setup (Ubuntu host kernel 6.14, SDK kernel source 6.18).
>
> However, this approach has two key drawbacks:
> a) Limited portability
> If the SDK is moved to a different host, these packages must be
> installed again for it to work, breaking the =E2=80=9Cplug-and-play=E2=80=
=9D goal and
> increasing deployment complexity.
> b) Kernel version mismatch risk
> The headers from these packages are determined by the kernel version
> in the host=E2=80=99s distribution repository, not the kernel version in =
the
> SDK. For example, the host apt repository might ship headers from
> kernel 5.0 while the SDK contains kernel 6.18; differences in UAPI
> files (e.g., linux/bpf.h) could cause eBPF programs to fail to build
> due to missing APIs or structure changes. This risk is greater with
> fast-evolving subsystems like eBPF, even if it does not happen in my
> current environment.
>
> This is why I don=E2=80=99t consider relying on host-installed packages a=
s an
> optimal solution for my case.
>
>
> > This patch does not make clear why we cannot build eBPF program in
> > self-contained way. E.g., after installed kernel headers, why Makefile
> > misses to include installed headers when build eBPF program.
> >
>
> I may not have explained myself clearly. As noted above, installing
> the headers you mentioned does allow perf to build successfully, but
> this is not the approach I ideally want, and it is not the most
> suitable option for my current context.
>
> The aim of my patch is to explicitly direct the build system to use
> the SDK=E2=80=99s own header files (via --sysroot or an additional -I pat=
h),
> ensuring that:
> a) The build works without installing any host packages;
> b) The headers used always match the SDK=E2=80=99s kernel version, elimin=
ating
> potential version mismatch problems.
>
> I believe this approach meets the principle of self-contained builds
> and aligns well with real-world embedded development needs.
>
> In addition, allowing additional parameters to be passed to clang via
> EXTRA_BPF_FLAGS would provide greater flexibility in the build
> process.
>
> Looking forward to further discussion.
>
> Thanks,
> hupu

