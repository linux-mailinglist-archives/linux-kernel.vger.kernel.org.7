Return-Path: <linux-kernel+bounces-795521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1360BB3F3D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66181633CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915B725394A;
	Tue,  2 Sep 2025 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akhQRcxv"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF1B72618
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788340; cv=none; b=Xl4NqdXyH5+MkJdCSsm3rOSl1F7WNslZ53hsw07m7azaA2r8ysPG26CJrmDEuGADAgLM2QOYsfZ74hq1+Slry2jlEgg+sRAiGqIOpzNBS6ftLY6eOZzldEIMdrzx/DxgflHLOgUhtIkaUetfktekNjJXMAIIBWM4ES1pHay141E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788340; c=relaxed/simple;
	bh=/OogJwtAjxwiLwi3I6AQ9o4DEBQ8vK1okBLRmMLSjuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtLeZVjULwPg1115S3Tx7I7IzYMJIFGV1tzOl1y1eb7kDya7+CROcbF4edO9gocISHMOT00aRB8QtS/umtZarKE1dARCeqDDwImlRPCat2soehDXixlpZQqlCeyqAxZk8Vs/2PGI7mJeplhoGu4jbkrEeeTMSqaYAZFN1upQ9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akhQRcxv; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-893c2b58374so924418241.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756788338; x=1757393138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2czLyRPqV1NqQm/ya0rQGCoiUl7QzZi3DhinlOw81cc=;
        b=akhQRcxvjp9wuubncxqB/IIPFRLz5al4qUKhbutXC7niy0RwHNx1PW25aZqQk/t5Q7
         CwHAgd2WcbeNRTDoDvG83vhyD0kp2FpuzBE4XzGkqcBQLoUNT1GYpkPcwjnq9XPEoADP
         291JKNS6vOslHsRDZHRbZjazkDW7X/fnbR3Qbb6JiX7zmasD44KLUDMBdOFWvfold+69
         tCDPVch9D1iabDSX87SYLxKpRHq45BPUPC2rl0RN15HMClGY+d1JpKJdZ6fwm5lyugr6
         3+Nn4K12lusbivmcyUfSF+iBKqJ+N5ZvzhXsXHS3sU+TQ8WYRB/5qJ/5s+bm9zSq1nmO
         DXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788338; x=1757393138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2czLyRPqV1NqQm/ya0rQGCoiUl7QzZi3DhinlOw81cc=;
        b=H2D69RbHmQNJnOwreekmg5gHsLpvZI3NH2+IqFn0wO1addKOpPtX9h7beT2CoTI5pR
         lEYdMVtdHNFLoMWLWjJwWT8pDqnrMHJ4bVVViL2svRxYTNERZPx+C2tMHivTrEF4pYFH
         heIoiNEGQvEIw6cLH1hCJ6WSxB+FEqxi2Hof6q1RtUMWfupGaZw0e6lqMr+xYCBl6osH
         Hu31Pexu7azE1EHHoUpv/zxdWGcryvkbfMIB5LDj1AuKWUCO7UEryvO8n8vJWLq35SeO
         /ad3AmxfTPxFzIOhoDaT1rOWWHp9B3hrRRUdWR5iy/vgq1SqXarNKfTLMTcnRFhH0FWg
         ZW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWg0oTzpCo0Z2smKWNKhKzjsBm52V2We8u7WgUmGunXiwk7D7Rd+x5AkkrAr1kC8H8NI/BD6Sq4HaLtP8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ey05EqIC2+S/cUXmvx7AWHgDU9RDtORET0C41p6xv2l/gNkF
	M4ATLNu91CJ39ERk76UWi+XWZeTQtgKY4GS7ZdDn3zB/wTTyL5X73JUCDWfk5JQYsVo5W92yJ+A
	ty9FUvPqGh3I8MNwp+r67QIfTmzeMQAI=
X-Gm-Gg: ASbGncs187g+9WezvqNA+M5myDleJSxs8zUNNBbt6R4T1JfoXld7tOrSu+V6Sl0L7m/
	ohMC06P969wzh8Pcg4qFSBdkoOZtPkBmeBmk7a2CbVOX7J9jqCAMKsToAyvDxjhbLgd1wiFeffr
	Vc+S/QKhR/09RTZOaKKzzoUsaejyjqK6nYBg5tJ1VKFuF07OES21zH/ldCshgCS9eBBUq4DBa8v
	WzE+iBVtYvb58GFaw==
X-Google-Smtp-Source: AGHT+IH32X2dcrCeBnz40TFdhgHrUG0jWvU6TsYGviMku5+2IuEc3XdnFN6o2hSnzeQl+EMQGqpLYhQ2tzlqQmqE9cc=
X-Received: by 2002:a05:6102:688c:b0:52a:fd2e:ef91 with SMTP id
 ada2fe7eead31-52b1985a08emr2669319137.8.1756788337992; Mon, 01 Sep 2025
 21:45:37 -0700 (PDT)
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
 <e0584468-ca8e-4a3e-944d-c0bff8569a83@huawei.com> <CAGsJ_4y+J9uaj=h6JfmKeq5SM5ic9ZKwgDONBP+JbUm6SJtzNg@mail.gmail.com>
 <751409ee-86e6-4322-a14b-1387a845be79@huawei.com>
In-Reply-To: <751409ee-86e6-4322-a14b-1387a845be79@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Sep 2025 12:45:26 +0800
X-Gm-Features: Ac12FXy7ks01z8PRhSzjdgKzMUPQ_nBHMfdpLGXgW50awCE-h9UZit1hzD586j4
Message-ID: <CAGsJ_4yAoqkmsjeVLT8A9c=jQ0aggWBNmo51B4M37rHpQj2WSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, yangyicong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:08=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
>
>
> On 2025/8/29 05:22:21, Barry Song <21cnbao@gmail.com> wrote:
> > On Thu, Aug 28, 2025 at 12:07=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.c=
om> wrote:
> >>
> >>
> >>
> >> On 2025/8/22 09:12:07, Barry Song <21cnbao@gmail.com> wrote:
> >>>>
> >>>> Does usr/include have header files? Did you run make headers_install
> >>>> before make?
> >>>> [xiaqinxin@localhost linux]$ make headers_install
> >>>>      HOSTCC  scripts/basic/fixdep
> >>>>      HOSTCC  scripts/unifdef
> >>>>      WRAP    arch/arm64/include/generated/uapi/asm/socket.h
> >>>>      SYSHDR  arch/arm64/include/generated/uapi/asm/unistd_64.h
> >>>>      HDRINST usr/include/asm-generic/mman.h
> >>>>      HDRINST usr/include/asm-generic/stat.h
> >>>>      HDRINST usr/include/asm-generic/ucontext.h
> >>>>      HDRINST usr/include/asm-generic/int-ll64.h
> >>>>      HDRINST usr/include/asm-generic/unistd.h
> >>>>      HDRINST usr/include/asm-generic/kvm_para.h
> >>>>      HDRINST usr/include/asm-generic/types.h
> >>>>      HDRINST usr/include/asm-generic/ipcbuf.h
> >>>>      HDRINST usr/include/asm-generic/termbits-common.h
> >>>> ...
> >>>> [xiaqinxin@localhost linux]$ cd tools/dma/
> >>>> [xiaqinxin@localhost dma]$ make
> >>>> cc -I../../usr/include -I../../include dma_map_benchmark.c -o
> >>>> dma_map_benchmark
> >>>
> >>> This is really frustrating. Why do other parts not need this, but
> >>> dma_map_benchmark does? It is also not acceptable to hardcode the
> >>> path to usr/include.
> >>>
> >>> It is also not good practice to access a kernel header directly from =
a
> >>> userspace tool - such as -I../../include.
> >>>
> >>> Shouldn't map_benchmark.h be a proper UAPI header that gets installed
> >>> into the toolchain like the others?
> >>>
> >> Hello Barry :
> >>
> >> This include file is inherited from the original version, and there ar=
e
> >> similar
> >>
> >> method in other parts =EF=BC=9A
> >>
> >> pcmcia/Makefile:CFLAGS :=3D -I../../usr/include
> >> laptop/dslm/Makefile:CFLAGS :=3D -I../../usr/include
> >> accounting/Makefile:CFLAGS :=3D -I../../usr/include
> >>
> >> During compilation, the system searches for header files from
> >> ../../usr/include first.
> >>
> >> If no header file is found in ../../usr/include, the system attempts t=
o
> >> get header files
> >
> > The difference is that, for them, the build still passes even without
> > running `header_install` (and thus without `../../usr/include`).
> >
> > tools/laptop/dslm$ make
> > gcc -I../../usr/include    dslm.c   -o dslm
> >
> > tools/pcmcia$ make
> > gcc -I../../usr/include    crc32hash.c   -o crc32hash
> >
> > For tools/accounting, the build fails mainly because the UAPI header
> > files in the toolchain may be older than those in the latest kernel. so
> > we need make headers_install to update.
> >
> > But I don=E2=80=99t really understand why we need it. My guess is that =
the
> > "-I../../include" option overrides the system header files, which then
> > causes type conflicts.
> >
> > cc -I../../include dma_map_benchmark.c -o dma_map_benchmark
> > In file included from dma_map_benchmark.c:13:
> > ../../include/linux/types.h:20:33: error: conflicting types for
> > =E2=80=98fd_set=E2=80=99; have =E2=80=98__kernel_fd_set=E2=80=99
> >     20 | typedef __kernel_fd_set         fd_set;
> >        |                                 ^~~~~~
> > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:179,
> >                   from /usr/include/stdlib.h:395,
> >                   from dma_map_benchmark.c:8:
> > /usr/include/x86_64-linux-gnu/sys/select.h:70:5: note: previous
> > declaration of =E2=80=98fd_set=E2=80=99 with type =E2=80=98fd_set=E2=80=
=99
> >     70 |   } fd_set;
> >        |     ^~~~~~
> > In file included from dma_map_benchmark.c:13:
> > ../../include/linux/types.h:21:33: error: conflicting types for
> > =E2=80=98dev_t=E2=80=99; have =E2=80=98__kernel_dev_t=E2=80=99 {aka =E2=
=80=98unsigned int=E2=80=99}
> >     21 | typedef __kernel_dev_t          dev_t;
> >        |                                 ^~~~~
> >
> > You should be referring to the system types.h, but the -I../../include
> > option makes you pick up the wrong kernel types.h. However, when you
> > do have "../../usr/include", you end up with the correct types.h from U=
API.
> >
> > I really dislike all this *mess*. You can fix it by doing the following=
:
> >
> > diff --git a/tools/dma/Makefile b/tools/dma/Makefile
> > index 841b54896288..cec09abf47cd 100644
> > --- a/tools/dma/Makefile
> > +++ b/tools/dma/Makefile
> > @@ -1,7 +1,7 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   bindir ?=3D /usr/bin
> >
> > -CFLAGS +=3D -I../../include -I../../usr/include
> > +CFLAGS +=3D -idirafter ../../include
> >
> Hello, Barry:
>
> Let me see... 'make headers_install' installs the UAPI header files to
> the usr/include directory in the kernel source tree by default, rather
> than directly to the system's /usr/include directory.
>
> This means that when 'map_benchmark.h' is moved to uapi/include,
> compilation tool chain cannot get the header file from the system path.
> Users need to install the UAPI header file to the system directory or
> set environment variables to reference it from the environment variables.
>
> Could this get a little complex?  Should we keep ' -I ../../usr/include
> ' ?>>
> >> from the system directory of the compilation environment. So maybe in
> >> some compilation
> >>
> >> environments, compiling these modules might have the same problem...

This is also true for any Linux application if the toolchain=E2=80=99s UAPI
headers lag behind the kernel version.

> >>
> >> 'struct map_benchmark' is defined in map_benchmark.h which is used by
> >> map_benchmark.c
> >>
> >> Do we need to define them separately in the kernel and uapi header fil=
es?>>

No, just move it to UAPI. When the Linux distribution is upgraded,
GCC will include this header automatically, like any other UAPI header.

If you don't move it to UAPI, please remove  -I ../../usr/include.

> >
> > Ideally, yes=E2=80=94then the -I../../include option would no longer be=
 necessary.
> >

Thanks
Barry

