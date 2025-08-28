Return-Path: <linux-kernel+bounces-790763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFD9B3ACB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D97756823E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3E285CA4;
	Thu, 28 Aug 2025 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsLuvJRI"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8628153A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416156; cv=none; b=RB4yZ83jFFUmKhCLfQ6uHPtCCGiHvRchWfp3I6OE7luTjUouqv89xhrhCNefmo20AajTKX9FNuzhvRZwxQxGoIJER7vJpOxLgSKftfGHlf5sIIPlkLXkr7G9HJqzzAn/gOCxNNMwq8s7V4QwKmfj4+Gx0RJmlZzfMA8kB+kSwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416156; c=relaxed/simple;
	bh=J/o+rOnM/GfWiPCUvCCKKwBefcLg4bko4txBVmQbpcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0VyBM4ubupfCZDZ15bWB/DVy7DX2Ys2c6lHnoyGy7pbOYZXzICxMymsKD2ST46hxzWPpLsKufPEPqy3sexkHDV4X10p2cOTPiun/M5QYawdWWd04XvAJ1pjsawMSDHPEuqx/9c4AfU9ZL6Q5rv2YSbOraK1oONnCrC7SAHeGo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsLuvJRI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7f7edf7621dso131021785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756416153; x=1757020953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V4/qW9PcWfYhu15fgUHY3aGyxvYry4xo77SEixLObk=;
        b=HsLuvJRImXcjRsfNpI3MYP4NzGAGwV9YQ6D7b4X1xrDbZn/iGjiQgRLqwCyBxuKZYQ
         YkpjSFCA8pgfsdI4JtQ87p+Wozbi44Xtgru15BSSJuFIdqzXagub190ajuDGC2ehaFk+
         t/Tk16MQhZUxYIF9X/W/FK+Gq1ZDccb5TiHjWxdXRtYTCOpCv6dUTA5kIUWuU8A+BGbo
         MAJTdUlsu/KsvzKnF7/18toP2Qvl2YQsljKD7Wd7pvZs4gxASPo5CVcA7n6OxvCqL3ic
         frcIgL+diaJCiH4JfW+y4u6rljRFCa9HnUYT6iJ8j37fPy2uVYo8k3sAyGBGEy7PsFlb
         DeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756416153; x=1757020953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2V4/qW9PcWfYhu15fgUHY3aGyxvYry4xo77SEixLObk=;
        b=dLkMVwFBb850t+QulaO4MbLcWe4MyC1M7M5jNbQEhiJeRlXAuRyDHplDJHYA4e2roP
         rC6U7w242vtsAIr0DD2nvOPZm5hWe3Y7evlWXD8/Y/kULppz3rhzPGi+I1nJ5fiy1QbV
         fk0BI492j26k3evhMRaU3eFsNN8YHHd/QtoHZC84T1ABh+iWi4ni3HuvG9AajbOJFol+
         v24ij0Ur+TCu2JZGVp051k9eOrUqPPaOK2A201fAUYh49NSmRnKgekBQjlrr9wjo1fS1
         OqXWuEmLwJ1uUJDcRqbvAqLhcDwP0gKzjxuIfmrwZrf13ZFIFrOBUENHK0nGzYYCyo4g
         JUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSJoVWsD0oB+gMPH9eRHI8ZTbNgzPhBR6AX9JgtFTvz29MFFLlnoUv/YC32LymEU4Sc8qv1eVCTxHIYus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlwQKnVLuzU3g2eEhMWE7emURCox+/Oi+ZrHBUTL9CnA6RhzZN
	gatsgeotCjj3qHqyAablpMZFtuCwu4+bR29z7sbLPXjElbIJSJUb7nyqHRR415SE34h9gDIAl2H
	9SidiTylKJPZBLREsf1VWsXb/Ei3gRXE=
X-Gm-Gg: ASbGncsi0BEgASHz3YhwErhU2tCZLXGCX+VG3gLR8LCV9B8JbFiFZ+r35D6hIXfpN7w
	aK27Fa+Dsl3eGpNveEocwCF1I15RLWQScFJrxN25cfYvHFi3kKod8a93NOsIEAsxtk/HRs6gjKY
	ohC6t+gti78DvJHScrwkYqesPkrW+D+x1c13r2SPB+dl7E83EkN4SdUVdlGorriiY1hcPUe0UdJ
	0GvSfxn8qIPzS0ZtQ==
X-Google-Smtp-Source: AGHT+IFn4ZDbGyrKk2t1E8r2HAFHfV9PVxIMJrcwNa+oEsdok0v6ABoYp1FvGd1zU3GdYkuH+RLr8GonAF7MmBUMzsM=
X-Received: by 2002:a05:620a:a104:b0:7e9:f1c3:6850 with SMTP id
 af79cd13be357-7ea1108f6a5mr2750984785a.70.1756416153271; Thu, 28 Aug 2025
 14:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814133527.2679261-1-xiaqinxin@huawei.com>
 <20250814133527.2679261-2-xiaqinxin@huawei.com> <CAGsJ_4wbgqGavjQNXtbFVeMw8j8oSCEVSdL4BrBVWEuNHzomPg@mail.gmail.com>
 <8db50f47-9295-4c7c-8bbc-dbbbd3fb5f79@huawei.com> <CAGsJ_4xXt2uEtAohcq+3XF_cKdsZiWsRaRh+ZK4nj0-Zw-yWYw@mail.gmail.com>
 <ca162322-b97e-4ec1-828e-dad7b09f4735@huawei.com> <CAGsJ_4yTOPoO98TTh3oQ4t6rag==yqeYP8HQ1wKvYdvg4e1RTQ@mail.gmail.com>
 <e0584468-ca8e-4a3e-944d-c0bff8569a83@huawei.com>
In-Reply-To: <e0584468-ca8e-4a3e-944d-c0bff8569a83@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 29 Aug 2025 09:22:21 +1200
X-Gm-Features: Ac12FXzbOGAv08AtzA1hUlGyCRB81BWq8u_Nlc_DEoAaTlRTmJ-LNqKXkdE8We8
Message-ID: <CAGsJ_4y+J9uaj=h6JfmKeq5SM5ic9ZKwgDONBP+JbUm6SJtzNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, yangyicong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 12:07=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.com> =
wrote:
>
>
>
> On 2025/8/22 09:12:07, Barry Song <21cnbao@gmail.com> wrote:
> >>
> >> Does usr/include have header files? Did you run make headers_install
> >> before make?
> >> [xiaqinxin@localhost linux]$ make headers_install
> >>     HOSTCC  scripts/basic/fixdep
> >>     HOSTCC  scripts/unifdef
> >>     WRAP    arch/arm64/include/generated/uapi/asm/socket.h
> >>     SYSHDR  arch/arm64/include/generated/uapi/asm/unistd_64.h
> >>     HDRINST usr/include/asm-generic/mman.h
> >>     HDRINST usr/include/asm-generic/stat.h
> >>     HDRINST usr/include/asm-generic/ucontext.h
> >>     HDRINST usr/include/asm-generic/int-ll64.h
> >>     HDRINST usr/include/asm-generic/unistd.h
> >>     HDRINST usr/include/asm-generic/kvm_para.h
> >>     HDRINST usr/include/asm-generic/types.h
> >>     HDRINST usr/include/asm-generic/ipcbuf.h
> >>     HDRINST usr/include/asm-generic/termbits-common.h
> >> ...
> >> [xiaqinxin@localhost linux]$ cd tools/dma/
> >> [xiaqinxin@localhost dma]$ make
> >> cc -I../../usr/include -I../../include dma_map_benchmark.c -o
> >> dma_map_benchmark
> >
> > This is really frustrating. Why do other parts not need this, but
> > dma_map_benchmark does? It is also not acceptable to hardcode the
> > path to usr/include.
> >
> > It is also not good practice to access a kernel header directly from a
> > userspace tool - such as -I../../include.
> >
> > Shouldn't map_benchmark.h be a proper UAPI header that gets installed
> > into the toolchain like the others?
> >
> Hello Barry :
>
> This include file is inherited from the original version, and there are
> similar
>
> method in other parts =EF=BC=9A
>
> pcmcia/Makefile:CFLAGS :=3D -I../../usr/include
> laptop/dslm/Makefile:CFLAGS :=3D -I../../usr/include
> accounting/Makefile:CFLAGS :=3D -I../../usr/include
>
> During compilation, the system searches for header files from
> ../../usr/include first.
>
> If no header file is found in ../../usr/include, the system attempts to
> get header files

The difference is that, for them, the build still passes even without
running `header_install` (and thus without `../../usr/include`).

tools/laptop/dslm$ make
gcc -I../../usr/include    dslm.c   -o dslm

tools/pcmcia$ make
gcc -I../../usr/include    crc32hash.c   -o crc32hash

For tools/accounting, the build fails mainly because the UAPI header
files in the toolchain may be older than those in the latest kernel. so
we need make headers_install to update.

But I don=E2=80=99t really understand why we need it. My guess is that the
"-I../../include" option overrides the system header files, which then
causes type conflicts.

cc -I../../include dma_map_benchmark.c -o dma_map_benchmark
In file included from dma_map_benchmark.c:13:
../../include/linux/types.h:20:33: error: conflicting types for
=E2=80=98fd_set=E2=80=99; have =E2=80=98__kernel_fd_set=E2=80=99
   20 | typedef __kernel_fd_set         fd_set;
      |                                 ^~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/types.h:179,
                 from /usr/include/stdlib.h:395,
                 from dma_map_benchmark.c:8:
/usr/include/x86_64-linux-gnu/sys/select.h:70:5: note: previous
declaration of =E2=80=98fd_set=E2=80=99 with type =E2=80=98fd_set=E2=80=99
   70 |   } fd_set;
      |     ^~~~~~
In file included from dma_map_benchmark.c:13:
../../include/linux/types.h:21:33: error: conflicting types for
=E2=80=98dev_t=E2=80=99; have =E2=80=98__kernel_dev_t=E2=80=99 {aka =E2=80=
=98unsigned int=E2=80=99}
   21 | typedef __kernel_dev_t          dev_t;
      |                                 ^~~~~

You should be referring to the system types.h, but the -I../../include
option makes you pick up the wrong kernel types.h. However, when you
do have "../../usr/include", you end up with the correct types.h from UAPI.

I really dislike all this *mess*. You can fix it by doing the following:

diff --git a/tools/dma/Makefile b/tools/dma/Makefile
index 841b54896288..cec09abf47cd 100644
--- a/tools/dma/Makefile
+++ b/tools/dma/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 bindir ?=3D /usr/bin

-CFLAGS +=3D -I../../include -I../../usr/include
+CFLAGS +=3D -idirafter ../../include

>
> from the system directory of the compilation environment. So maybe in
> some compilation
>
> environments, compiling these modules might have the same problem...
>
> 'struct map_benchmark' is defined in map_benchmark.h which is used by
> map_benchmark.c
>
> Do we need to define them separately in the kernel and uapi header files?=
>>

Ideally, yes=E2=80=94then the -I../../include option would no longer be nec=
essary.

Thanks
Barry

