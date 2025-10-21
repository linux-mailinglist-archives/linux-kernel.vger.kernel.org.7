Return-Path: <linux-kernel+bounces-862217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D02BF4B36
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D1318C3E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149D25D540;
	Tue, 21 Oct 2025 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jwhu+A4v"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFE825B31B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027834; cv=none; b=Th4RuhERln9ELv6q0hMb7NwSixeO/knaN8zO/2puCGT7S1ZKUKzQr6mH9ZCW+7dKrsD3Pf89W/S9uVtQpxm2umff3oKrgaMlgSCduHErVeHZl4MgSTAmjgI7t8FQ8JWP4Pza5KTcPoU7FrW8WiAWwT9ycxdyfooREY69aBROtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027834; c=relaxed/simple;
	bh=7IH4Ryd6nfRF/cdkd9Cj41f8zlBCsdWwuDdjxbxkkqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odLnU3DU7pFSrn/JuSk6KeyetnGiQWeBGJgBYZa42Cqvseep9CN4AghazDT4DdXvX98qz8d8oxu2ECq44NSl0wya/bT6xJyAtgUYCO4JHhPDoQ0tvcihwPNzal2YAiZFU5CJqhZBdGI4xD7/JcP7B3jcxfXTFQstXyzTVv9K1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jwhu+A4v; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-88f27b67744so733668085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761027832; x=1761632632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLjXkk9G7S5NJjjLjfl1k4f4v5rB5l07o4uqGq0JEHw=;
        b=Jwhu+A4v/pKeiAn7XZZYml+d2FIc1OSnGHojCaSb93otZHBidajjFPrRHsM6cEFvUY
         LJw/+DiPB4RAC9etOV5E8SZpjfyPg7QzZmITU8EXCRy9RrqN76E1nwYufrtH3HVEbN67
         MIjk0uFQy2iRIW6g1FAmGjpleJCtF/sV9RvNVo8TErK1zDuy5WQ2Q8lzEgUvwFU05KeM
         Cpu+xr04QQARKvDOxnuw5EI9AWtCoumh7aPE+2rHeCxj3En58O9mpngF1aAszeXTbkn9
         wMOHXe2zTy279j8Y7u3SZBlQKmwexguDQHPn4Wpx2ACrwWdlhN76rRo+CMo3smEKBIGl
         zmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761027832; x=1761632632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLjXkk9G7S5NJjjLjfl1k4f4v5rB5l07o4uqGq0JEHw=;
        b=I0fd2zW0mBSU7p5iYpaCdUVA0jWK1huAJeND8K+7ESzH7mk0ftdd6xrueV8zrCwCzC
         A9UB1QXo8yQx/vgjy6I/bQbkwylracTT7r00JJb8LKE1eCTPnDtyZ7/LNtkE/S+Hwdbm
         3RS7+7x/ar6YF9Ln8zrY+pTF7zmYJUX7RheWzim9NXFc1jHq3/rzx+wCIEmunzY8F31X
         1Iik1STEz8V/dHaq+wC9FtEQGB1hX10KJuOEtpDNWdwVvqmTOT6UoiauIBl3lAvSbefj
         ux2/VzGwKO5r5Ves8ciEcmDZz2t3PsIa2C2e66hhFLAN75ZyJWcALqdR3O0h26043aBu
         mnzw==
X-Forwarded-Encrypted: i=1; AJvYcCVDPscaq7VDlEF6pAHi64eWcEz8iTMot+r6nyH/RvKGo/BKruISl0duHKWu8lQGA/FAx3VVXsC41OpwItw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvMN7+uPY87e2050/YCc4g771fC6IS8HWDdsEjDyjCfUm0isy
	GdPKA9Lrav9FOV97iHvHfFuN8XnHKa6m8Fb2onD1JJPLu9wPQaod7GCnrCObRRE6E2OQ89EB3r9
	xiIWo427rF3X1OK99HtL3vfaxArj+gcU=
X-Gm-Gg: ASbGncuSCPOjdKpOsjmv63WrdGHIoUTLn89dir6McK+aH7mhMkQT0US5WVzWC7HSBs0
	9wc7mInhmJxQ8iPs/mYHgoMKusKcySWXISM6pcuyJNGezAo2pOroaxWvFobq1nwILseeZGKERZQ
	xx40yR7K/pmdXc33J4rpVp3fDFrSo+RQQeKX0OwoNY2FP4qybLRHg80muPbwNG8WzKO89JZ0fDI
	b2WCYBAT8ujUiDAjVD4RXcAlTamFZlp0R3Y23v4x7a1RDN3BokQtNDvmGyQUWDG2wJg6J2AQCUs
	i4V9X9Z32FokH9Td5EYxRdIWXbU=
X-Google-Smtp-Source: AGHT+IEejdz2oiuxm0bEp46aC7xYCSy0m6Th5nMlB8ZWlLLKrCeYcXoDqqGzkkBeDM18tdXFLdLO9S2MHY39zpFN/lc=
X-Received: by 2002:a05:620a:2907:b0:892:76c6:8356 with SMTP id
 af79cd13be357-89276c68516mr1190962985a.81.1761027831487; Mon, 20 Oct 2025
 23:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021011739.1468912-1-xiaqinxin@huawei.com>
 <CAGsJ_4zF4JOPXpkzmR+invqefLstcaB=xaGEfueHEQRSg2oLOg@mail.gmail.com> <47cc4984-a424-410d-a1b8-9947c1a42ccb@huawei.com>
In-Reply-To: <47cc4984-a424-410d-a1b8-9947c1a42ccb@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 21 Oct 2025 19:23:40 +1300
X-Gm-Features: AS18NWDG-m0bOlArM3Uv4n8n97lC2PURCatQf_aAqUx-Doqvx3jG08RzBBhZCIE
Message-ID: <CAGsJ_4zf31seJif1N93yk_mUaEYh4SzwedASK9VPnPm_JJ6t3Q@mail.gmail.com>
Subject: Re: [PATCH v3] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:16=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
>
>
> On 2025/10/21 10:59:05, Barry Song <21cnbao@gmail.com> wrote:
> >> @@ -0,0 +1,2 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only
> >> +dma_map_benchmark
> >> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
> >> new file mode 100644
> >> index 000000000000..4acbd9e00cfa
> >> --- /dev/null
> >> +++ b/tools/dma/Makefile
> >> @@ -0,0 +1,17 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +bindir ?=3D /usr/bin
> >> +
> >> +CFLAGS +=3D -idirafter../../include/uapi
> >
> > I'm a bit confused =E2=80=94 it seems you haven=E2=80=99t tried to unde=
rstand what the issue
> > was in v1 [1]. You were using -I for kernel header files (under
> > include/linux but not uapi), which caused those kernel headers to take
> > precedence over the system headers, leading to build errors. The uapi
> > headers, however, are specifically designed to be installed into the sy=
stem by
> > the toolchain.
> > So that=E2=80=99s no longer the case =E2=80=94 -idirafter is not the co=
rrect flag for uapi.
> >
> Hello Barry :
> If I delete -idirafter, like:
>
> CFLAGS +=3D -I../../include/uapi
>
> It will get warning info:
>
> [xiaqinxin@localhost dma]$ make
> cc -I../../include/uapi dma_map_benchmark.c -o dma_map_benchmark
> In file included from ../../include/uapi/linux/map_benchmark.h:9,
>                   from dma_map_benchmark.c:13:
> ../../include/uapi/linux/types.h:10:2: warning: #warning "Attempt to use
> kernel headers from user space, see https://kernelnewbies.org/
> KernelHeaders" [-Wcpp]
>     10 | #warning "Attempt to use kernel headers from user space, see
> https://kernelnewbies.org/KernelHeaders"
>
> So I keep -idirafter there.
>
> There's another way, like:
>
> CFLAGS +=3D -I../../usr/include
> (need make headers_install first)
>
> Maybe I haven=E2=80=99t thought it through.
> If you have a better way, you can give an example.:)

I see =E2=80=94 the uapi headers haven=E2=80=99t been installed yet. This i=
ssue will
automatically resolve once the toolchain is upgraded. Before that, we
can try the following:

tools/gpio/Makefile

#
# We need the following to be outside of kernel tree
#
$(OUTPUT)include/linux/gpio.h: ../../include/uapi/linux/gpio.h
        mkdir -p $(OUTPUT)include/linux 2>&1 || true
        ln -sf $(CURDIR)/../../include/uapi/linux/gpio.h $@

prepare: $(OUTPUT)include/linux/gpio.h

I guess we could copy and paste GPIO=E2=80=99s Makefile and make a few mino=
r
modifications?

>
> >> index b12f1f9babf8..5474a450863c 100644
> >> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> >> +++ b/tools/dma/dma_map_benchmark.c
> >> @@ -10,7 +10,6 @@
> >>   #include <unistd.h>
> >>   #include <sys/ioctl.h>
> >>   #include <sys/mman.h>
> >> -#include <linux/types.h>
> >
> > What=E2=80=99s the reason for this? Is it to work around a build error?
> > If so, no =E2=80=94 please keep it.
> >
> >>   #include <linux/map_benchmark.h>
> >
>
> Moved it to map_benchmark.h, otherwise some x86_64 build errors
> would occur.

Let=E2=80=99s avoid moving types.h =E2=80=94 that feels more like a workaro=
und than a
proper fix.

Thanks
Barry

