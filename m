Return-Path: <linux-kernel+bounces-809580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9DFB50F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE2C561763
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC54730ACEA;
	Wed, 10 Sep 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gs9NVCu6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58E305957
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489434; cv=none; b=oPjcnT32RzT27S3uNG7DHSWAIqDqwWu3BKO+jjNGd5EwYP5h6xsKhTu0cRCjWo2z1UJ4S0mz3a2hzC73vDXqsIeVyzCKLrCxv0OO+5bX3wh+AZA46AfQ4pwSUrLLzbxYQAA8YEkX9pVBLYk8I+yxHevg6003HLEwbdO+kKaBgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489434; c=relaxed/simple;
	bh=V4GRnptJj2qaYSvuxiQX1AqgJtScMUMPtA6IMx7BN50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMBJ1z7jPQCChcwN0gCQr/BE/wykBi4O8G3sKLhyPC6+TmZi+92cmQ3eujQgsM3jpMEQag5pG4dzjqIZqwIRUk08g+udIKTVlNwYbz9qP7nrgKTQHvTPbBzGAGrwSjHtml5VGgz2rouDZTKnOI5RT/42r2gNit9f92+FyJv0TRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gs9NVCu6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757489430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSv3IIId7unI8UfEY8bPGg1xGNeJdhNHxN9/10PYUSY=;
	b=Gs9NVCu69m5r0LTZPuDSY5kXuZlmJdmzg9I8iTRe99eIYFiI68O7jmHUfgOmv5F4vmkezL
	R0wFkuIvMdpGgzuwdyTW4Zd4DWuifbbG6jxxooB196ApNqNhr3X+z2rpKNfPnyvBrTKpSa
	bW9XLsaP1igDR/Xoma9FmHh/0qniDg0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-q71_wvGqO-ig0RPtBq4Ctw-1; Wed, 10 Sep 2025 03:30:28 -0400
X-MC-Unique: q71_wvGqO-ig0RPtBq4Ctw-1
X-Mimecast-MFC-AGG-ID: q71_wvGqO-ig0RPtBq4Ctw_1757489427
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3df07c967e9so3927952f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489427; x=1758094227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSv3IIId7unI8UfEY8bPGg1xGNeJdhNHxN9/10PYUSY=;
        b=rVJM7o1+ZhL6KvNQIQITO1AfogLNX/DvCjxGjCoxvA+Z/rqeSgplnpmBSu0zM5fHF/
         n0lGgrmTAEPalSvG537HjDDGxN2CrjqyxhecwEEdujSPYj32HPP9I9bUum6NQc7lTplZ
         oUjlimwjQO6wIdFM670bRf2o5QD60FvauWdmj4M2nNFHa0UZLa5M+rDxyIOmCQfFtOZh
         rsKrz+E7oM1ArR+hYuLJuQAZThBzNVq1xAEft6vfIfYfWfimRibTqaAYpV91cws4L7e9
         2hlhUtpJpkp9Az9f8t9ulAz6xNJ00L9YkuQDR7Smie1UiKt7M7ju2eED58IOSpiGt8JS
         EAhA==
X-Forwarded-Encrypted: i=1; AJvYcCVibZXeIZ9eHeqVIsTtOPYf3jh4J2iDDDzl+bEl4t7r9d4IwItnOStE5ar0m41Are1NvOq8oTPPeY/zODE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3oSP0AKCJZmXqXyT38DqHW0EsUppCzW+2TDgpdN+IH4wfZfG9
	WaVxOvMsXZXN5CB6EdU000o9ZbaoRYAh8axiIJ9sAbxsAmggkUGY/SagX48mYfIxZD0BAdaiQ3s
	H5IVaNoojSr4R3bgin3PZ2eowUnezM8bOc+/FUtiiUKZO3D4gdKvqTCN0tjvzzUL2Tew+fT1BVE
	wEgF8lu+r4fiNJRv9l5sHHL/H+hXMtck5kZnIa9MXE
X-Gm-Gg: ASbGncsG2LSYnUxoHcDLBqiEK7IrmBlAKAE3E13g+ECgCO4DBK+SqEJu+sTkleEb75c
	T76DVYNKM3gEjP672G0GlgSfLRxpAV7VK2qUuvAoAbXW2oR/32dfK6G6hI+3+KmgmBztK6cnNzo
	kO7vnWnSI8vLVP+OTrP20CLtna6tSaiy9LvSLXjydbzGvS+5rY5oLgNMtBgWwI5PRVeshaR8oX0
	EyUk/rIJ3lsvfBE5yMRmxc=
X-Received: by 2002:a05:6000:2087:b0:3de:c5b3:dda3 with SMTP id ffacd0b85a97d-3e645c9d0fbmr12128050f8f.44.1757489427439;
        Wed, 10 Sep 2025 00:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzuJXYwoOG98BtNJlZ2tE3xANYEOw3wxoX+SSNAaviVD84eLYQ2LV34osvXJQI60WO2kZRIXngmquFvmIfJHk=
X-Received: by 2002:a05:6000:2087:b0:3de:c5b3:dda3 with SMTP id
 ffacd0b85a97d-3e645c9d0fbmr12128022f8f.44.1757489427039; Wed, 10 Sep 2025
 00:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e8c743dfb16c6c00fd793d7afa6eed33c49f895f.1756202009.git.jstancek@redhat.com>
 <0ab92ae3-674f-445e-883c-0e511add85d2@redhat.com>
In-Reply-To: <0ab92ae3-674f-445e-883c-0e511add85d2@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 10 Sep 2025 09:30:10 +0200
X-Gm-Features: AS18NWAr8td3LOQLP511LSO5DpHnyQa1skw1nOcY5CC6N4rA6NZKjHj2YmR1a-c
Message-ID: <CAASaF6yOskaXhQzvqz_-fZekYimgbNspi0JfT4TAWL-rB6mMhg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/tools: drop `-o pipefail` in gcc check scripts
To: Joe Lawrence <joe.lawrence@redhat.com>, mpe@ellerman.id.au, 
	christophe.leroy@csgroup.eu, maddy@linux.ibm.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 3:32=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> On 8/26/25 5:54 AM, Jan Stancek wrote:
> > We've been observing rare non-deterministic kconfig failures during
> > olddefconfig, where ARCH_USING_PATCHABLE_FUNCTION_ENTRY was getting
> > disabled and with it number of other config options that depend on it.
> >
> > The reason is that gcc-check-fpatchable-function-entry.sh can fail
> > if `grep -q` (or scripts/dummy-tools/gcc) is fast enough to exit while
> > there is still someone writing on other side of pipe. `pipefail`
> > propagates that error up to kconfig.
> >
> > This can be seen for example with:
> >   # (set -e; set -o pipefail; yes | grep -q y); echo $?
> >   141
> >
> > or by running the actual check script in loop extensively:
> >   ----------------------------- 8< -------------------------------
> >   function kconfig()
> >   {
> >     for i in `seq 1 100`; do
> >       arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh \
> >         ./scripts/dummy-tools/gcc -mlittle-endian \
> >         || { echo "Oops"; exit 1; }
> >     done
> >   }
> >
> >   for ((i=3D0; i<$(nproc); i++)); do kconfig & done
> >   wait; echo "Done"
> >   ----------------------------- >8 -------------------------------
> >
> > Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-funct=
ion-entry")
> > Fixes: b71c9ffb1405 ("powerpc: Add arch/powerpc/tools directory")
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh | 1 -
> >  arch/powerpc/tools/gcc-check-mprofile-kernel.sh           | 1 -
> >  2 files changed, 2 deletions(-)
> >
> > diff --git a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh =
b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> > index 06706903503b..baed467a016b 100755
> > --- a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> > +++ b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> > @@ -2,7 +2,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  set -e
> > -set -o pipefail
> >
> >  # To debug, uncomment the following line
> >  # set -x
> > diff --git a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh b/arch/pow=
erpc/tools/gcc-check-mprofile-kernel.sh
> > index 73e331e7660e..6193b0ed0c77 100755
> > --- a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> > +++ b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> > @@ -2,7 +2,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  set -e
> > -set -o pipefail
> >
> >  # To debug, uncomment the following line
> >  # set -x
>
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
>
> This bug manifests when automated scripts expect to run a kernel build
> after `make olddefconfig`.  I reported this to Jan when I found that

Right, maybe we can still add that too.

Reported-by: Joe Lawrence <joe.lawrence@redhat.com>

Would anyone else also care to review, please?

Thanks,
Jan

> kpatch-build [1] instances were hanging (expecting to hear from a user
> that would never answer :(
>
> [1] https://github.com/dynup/kpatch/blob/master/kpatch-build/kpatch-build
> --
> Joe
>


