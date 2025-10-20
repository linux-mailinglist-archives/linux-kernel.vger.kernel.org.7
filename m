Return-Path: <linux-kernel+bounces-860926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56FBF1573
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2341889B53
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298A630BBA6;
	Mon, 20 Oct 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8rkt97q"
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AE73FFD
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964730; cv=none; b=MOkXzKm2AmsakliYmuIDNxu2p+oc1VdzbQy4HrsAyBqEQOLRFeOsyxjKloUEkOCtd+rdGyl2+3wYpwYvZuqjMcSeDeJLq2chp9JaaAEzMxfSY2k83jYetmr7ZKPf/C/KhIBvH4j/EeLILtRBOO1tuGCxXnc9RVWAPjG1arSTJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964730; c=relaxed/simple;
	bh=NoKN/VklOZ0PsX6E7d/ZEOoFp7KZ+BZQhEK8O2S1oJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dx1zuy75+qf4Ym9Wc05uh+s6DBYnDRgkyC00CfDqV+D703lWas4MYBKccRxUml8hHmNQM4GdO6/5gsFmmDTAHeCrh0JSs+Swkme+b+Ymcx5DPhd9evkSSDY5nyJRmA75T1Ee0onH/V0kD+xoxDy+f9IVkerBN4vABVXuJ9YBLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8rkt97q; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-36d77ae9de5so40728751fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760964725; x=1761569525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJLLkJALqNt2BGM9vipmlGBox7Ra/Q013j8h0mIEzZI=;
        b=g8rkt97qs3QC4rL3qsh3PR+Pqzj2V8iWAAr5az8X1vOd+jbjaRLAzQJHnxU+OZttfz
         db9tNHw/8Nu6fs7LubjPtWC1yGuSOM1AlDMLnEA5ozugUD9dmQxziwhD/8FdnaNzVVZI
         ig8YFQJxIowlcHyAZxjrTwgsuRbAf6a36KjFchc64oEv/Tsexvl6mNGf1Ttf/NGTKUT4
         puL0856gWwIAN5MxfGcXu0DsblcCj34Sva61thcFons+e2Y0N7VixAGfhHb1vLijH83y
         tzE7p03RmpYUKFFf47eCOYfPaPLWfELrNYS7beqH0ARziajpP+PLitetJi2+e7UcwV8L
         xKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760964725; x=1761569525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJLLkJALqNt2BGM9vipmlGBox7Ra/Q013j8h0mIEzZI=;
        b=rqu8/oaWaa5f95/oqRSWJd+x2758tGPeDTeosz1kvIApGl1Nlgm2HK7htwitwWcFTk
         qfQNcnNO0edbAVTSQlzn0Z/q5u0sLvGliE1BNU3mA915WPCYLq5ke+s1aYe0xotgQJ34
         gb5JthEx4SwkNCRNp5RrrJNo6T47ZKVs/abNQkUIoaqk83M48GX3svQOkkKLREClCIuM
         0ARZx1gAZ/59GbA9McsBsyWn5iMSPSUmfhFzdj3nfeeiwaGZmZxxYQC8ojXZZsXXHZw0
         koyXkgmmAtkT7PEE5rY79tRgva8/wMfHIEFp6A8UuLL9aJuo4x5eg5wcAyNZ7JpgYCyh
         hFRw==
X-Forwarded-Encrypted: i=1; AJvYcCXxKBeWgRc8dUh8G41aSWTDYbNhUPSOktySILSjPth38PsQQeTyGFH2skDwVpJHG3CjXxH9Jd+0gSHAb1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvcLWbK+CI3y+QIFMIrnwkC4JbK1FMaKSZsDU6PDpgo5d5zx6F
	4ge0FC/TyCVDrd7KwArlDD6FeDniidYhRqXcRvdH+mwziK9guq21uSLEaJiEDpqx5gwUJSVIn+y
	oNoHH8l6KiCJS58k0gIQqRG40rRedscNR5E8nu5k=
X-Gm-Gg: ASbGncs/SDYGHolaR6qdtuybNWAGLp6hGrSiiztIuiwdnLTrzxNIj7KqrkwvFMdDiDN
	5ECxE5B6WuGj/pD1DnUR0431AF5/4rN7Qi/3XnUsB9cocmlvDThzLseP8UvDAjROM4GLXstwNMn
	hIApRCXFkO/GR0vIn+2z/heeLfmGndh7xQdHWaJwJdBNzrZA/ZAKH9uyaM983i44Oy5JbBUYa0n
	FtbjuFBhDee2l55T7zTFsQvbAMPCmuIQQkEg1A2iclX8wxl6i0kAKXiD3o5
X-Google-Smtp-Source: AGHT+IGamRLPldBcGCNTyINQ6T9zJDiT6xEn1aaKY8nTPcFl2bpamrI0VbQ+h0d3P2S96PS2ryWOeFNU1dzTbr4RLrw=
X-Received: by 2002:a05:651c:1595:b0:372:17eb:1191 with SMTP id
 38308e7fff4ca-3779793eaedmr38894401fa.18.1760964724945; Mon, 20 Oct 2025
 05:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com> <20251020101523.GE281971@e132581.arm.com>
In-Reply-To: <20251020101523.GE281971@e132581.arm.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 20 Oct 2025 20:51:52 +0800
X-Gm-Features: AS18NWBR03yV6R3tb_Tq7HsUgE_JE6nP9lFhGsbqder5VlR8vuplgzTZM726trU
Message-ID: <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
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

Hi Leo,
Thank you for your reply and for taking the time to discuss this in detail.

On Mon, Oct 20, 2025 at 6:15=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> On Mon, Oct 20, 2025 at 01:16:46PM +0900, Namhyung Kim wrote:
>
> [...]
>
> > On Mon, Oct 20, 2025 at 10:40:49AM +0800, hupu wrote:
> > > When cross-compiling perf with BPF enabled, Clang is invoked during t=
he
> > > build. Some cross-compilation environments require additional compile=
r
> > > options, such as `--sysroot` or custom include paths.
>
> [...]
>
> > Leo, are you ok with this?
>
> To be clear, now we are not talking cross build for perf program or any
> targeting a CPU arch, it is a build failure for eBPF program.
>

I=E2=80=99d like to clarify the background and scenario once more:
I=E2=80=99m building an SDK that includes a cross-compilation toolchain for
the target architecture along with a copy of the kernel source tree.
The goal is to make this SDK usable on any host system to build
software, including perf with eBPF enabled, without requiring the host
to install any additional packages. This is a common requirement in
embedded environments, where we often cannot control or modify the
host system setup.


On Wed, Oct 15, 2025 at 5:30=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> Have you installed the GCC cross packages ?
>
>  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
>  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-cr=
oss
>  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cross
>
> My understanding is arm64 cross compilation tries to find headers in the
> path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/Debian
> distros).  After install GCC cross packages, the headers should appear
> in the folder.
>

As you mentioned earlier, installing the GCC cross packages on the
host does allow perf to be cross-built successfully. This works in my
current setup (Ubuntu host kernel 6.14, SDK kernel source 6.18).

However, this approach has two key drawbacks:
a) Limited portability
If the SDK is moved to a different host, these packages must be
installed again for it to work, breaking the =E2=80=9Cplug-and-play=E2=80=
=9D goal and
increasing deployment complexity.
b) Kernel version mismatch risk
The headers from these packages are determined by the kernel version
in the host=E2=80=99s distribution repository, not the kernel version in th=
e
SDK. For example, the host apt repository might ship headers from
kernel 5.0 while the SDK contains kernel 6.18; differences in UAPI
files (e.g., linux/bpf.h) could cause eBPF programs to fail to build
due to missing APIs or structure changes. This risk is greater with
fast-evolving subsystems like eBPF, even if it does not happen in my
current environment.

This is why I don=E2=80=99t consider relying on host-installed packages as =
an
optimal solution for my case.


> This patch does not make clear why we cannot build eBPF program in
> self-contained way. E.g., after installed kernel headers, why Makefile
> misses to include installed headers when build eBPF program.
>

I may not have explained myself clearly. As noted above, installing
the headers you mentioned does allow perf to build successfully, but
this is not the approach I ideally want, and it is not the most
suitable option for my current context.

The aim of my patch is to explicitly direct the build system to use
the SDK=E2=80=99s own header files (via --sysroot or an additional -I path)=
,
ensuring that:
a) The build works without installing any host packages;
b) The headers used always match the SDK=E2=80=99s kernel version, eliminat=
ing
potential version mismatch problems.

I believe this approach meets the principle of self-contained builds
and aligns well with real-world embedded development needs.

In addition, allowing additional parameters to be passed to clang via
EXTRA_BPF_FLAGS would provide greater flexibility in the build
process.

Looking forward to further discussion.

Thanks,
hupu

