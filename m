Return-Path: <linux-kernel+bounces-863459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC3BF7E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A59025071AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4413B34B661;
	Tue, 21 Oct 2025 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsGdt7Em"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD50355807
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067525; cv=none; b=nbHKyNUYjPm1/+DZBfRo8oGQcXOZgKvRs5c/4GJxSXToSeguc80Qi+FJawyvRFwkBzFf49TsSRw5S7sU3QKI4BwWqNyCHBjEdtDb/duALHXcqfw0frWTDjg1y/XuQLEYJDLqSgDP8M34RF5aCqNsLfyunVjX3hGQlukTv1kvv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067525; c=relaxed/simple;
	bh=j+uEg91Z64lRz+on1N9wDt4oXxA5V8KS5iF980bpGGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9n7DbirB6cDST7wHvEh0erRuYQDmx6p7QTBwqAb8PxCO18p4/paGtuYb5IUq7//0Jo6IUNib7IQR8NyHbaHMy8Yfw85OrJCA3PFtegNLpbsov8TYhLJXad8+hN2eYUdjxLEY6Cz0NNPLEln9I5Zp/A3kwD6CqttP6Y0RYO9rqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsGdt7Em; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63e18829aa7so60152a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067521; x=1761672321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXi6CRB3+931Kx2XZXckBgFrdC+g3QWN9I9coq5d304=;
        b=bsGdt7EmlrCu5kdIRtjBIDe5cinPhB+InG0/VKRKJ5TzewlHjV5x5GnsxpMWMsT+im
         co9oOT8klRfpcwjLJAGd3t/1n9RUEZysvpC/hRf5q/jiOcqLCj39DX0E/LkR2xegcu6N
         oJZG4ABc7foJxtH9CXXElMw39dcOrHq80d1If30ZjpuOZxCYgD7oDLksYnsM5ZHu5y4X
         8EMaZjbmU78kyzEyo1KFL9uG9Kn7ewC4FpOPWkWrVvMtdsvTSlvfqrOyR/ieLvjFj3ID
         2iPVhTpaB/71Yh8LElhpsVKY8avaQRoVr+XxxhV9wbQvk6chtsYNOTQu0ZliYnJYv7aU
         c9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067521; x=1761672321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXi6CRB3+931Kx2XZXckBgFrdC+g3QWN9I9coq5d304=;
        b=b9/h5vRCKgOzq/VCiN2xrYkZCcXMFJeVeCUZfj2FfkUebQA1UF7im2MGtqIRROv950
         9ofMLlM1tZF723OWlwVtx1fzwi0SPNVJFRU+uoY1Mp0Cq0et+pdge47Yf6RkASmt1xKN
         LohyJhLTS+tRsA3bU4IF/rhtHsf1pWBEyihwPUNzOET6xkZKt80u8N2Dct1FsfkR/HS4
         2shYOauDfVus+wiADwHhNdikvLV/MS42Wuyn4HX3qCTriRiJdSZ6oi/9D5CeFQM2ISyU
         8TdIpEHlytXvy9k1tQRPWAtKG0e4ErVIz+6Q+iPsbZL+dASKYdLLTz/3vWPu0B2hlXMO
         6Raw==
X-Forwarded-Encrypted: i=1; AJvYcCVdXhaS5lxddNMgXkcDDAbKAh0peLEgGI8C56yYKgugcamjQgI0B/4wARSb/5rx1IoHvDpb27MIP+tqYn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YziXuvRQnFofT5Vb8W8oF3PjjHgBJjvBhSIubXOe6whJNKVIATG
	z1eIJjBky2f0/D5UOf9HYjT5YmM4eomKQpAOEpxcow8pNCAdVrZKSovW2KhojqA+ZdnbwMsD8jC
	NRuZZWkYR8ZXM21SfCJw4eslib5E5T5k=
X-Gm-Gg: ASbGncurlzTjhK2dCQsNcPa387il2VFon2yBvRAbezuUVjvBaPWYTNI2C+C+mYQFdNl
	7P43B4SSlJh17YDrBqwYCm3pxX0KqyF/XOcRhtp8yXjhu+6MEIBAxvITsFFiJcpoElIUVjEB8S5
	hQSPeaIVCp7HKKNaS0RlpIdggQJf876k+nezlMGyYDVChTSYJTraBqNTvZQCQRlWb8KYlDHUnWR
	huljV+3khB7pIIJgzr2HmNo4VvzTt8+PUBVvX3CqCjZuT4LuTa7lapfxjEAt6VX0vEPtns=
X-Google-Smtp-Source: AGHT+IHFTFFLc8SGslhJN9Wcay9cG8tXSMifwIHJtttGuFS4CWix+uKRWQgP5Ud3SpMMmQW5vq10q8hPaDNaqszw2i0=
X-Received: by 2002:a05:6402:13ca:b0:637:f07d:e80f with SMTP id
 4fb4d7f45d1cf-63c1f58c0d3mr17646406a12.0.1761067520747; Tue, 21 Oct 2025
 10:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10e7ac6cebe6535c137c064d5c5a235643eebb4a.1756888965.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <10e7ac6cebe6535c137c064d5c5a235643eebb4a.1756888965.git.baolin.wang@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 22 Oct 2025 01:24:43 +0800
X-Gm-Features: AS18NWD0g9OMCk8OjX7Ue4MmhAY_mpmnguPj7-qsu-gFqHtjguKPTiKDRTKElcI
Message-ID: <CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: fix the strategy for the tmpfs 'huge=' options
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:59=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"=
),
> we have extended tmpfs to allow any sized large folios, rather than just
> PMD-sized large folios.
>
> The strategy discussed previously was:
> "
> Considering that tmpfs already has the 'huge=3D' option to control the
> PMD-sized large folios allocation, we can extend the 'huge=3D' option to
> allow any sized large folios.  The semantics of the 'huge=3D' mount optio=
n
> are:
>
>     huge=3Dnever: no any sized large folios
>     huge=3Dalways: any sized large folios
>     huge=3Dwithin_size: like 'always' but respect the i_size
>     huge=3Dadvise: like 'always' if requested with madvise()
>
> Note: for tmpfs mmap() faults, due to the lack of a write size hint, stil=
l
> allocate the PMD-sized huge folios if huge=3Dalways/within_size/advise is
> set.
>
> Moreover, the 'deny' and 'force' testing options controlled by
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the sam=
e
> semantics.  The 'deny' can disable any sized large folios for tmpfs, whil=
e
> the 'force' can enable PMD sized large folios for tmpfs.
> "
>
> This means that when tmpfs is mounted with 'huge=3Dalways' or 'huge=3Dwit=
hin_size',
> tmpfs will allow getting a highest order hint based on the size of write(=
) and
> fallocate() paths. It will then try each allowable large order, rather th=
an
> continually attempting to allocate PMD-sized large folios as before.
>
> However, this might break some user scenarios for those who want to use
> PMD-sized large folios, such as the i915 driver which did not supply a wr=
ite
> size hint when allocating shmem [1].
>
> Moreover, Hugh also complained that this will cause a regression in users=
pace
> with 'huge=3Dalways' or 'huge=3Dwithin_size'.
>
> So, let's revisit the strategy for tmpfs large page allocation. A simple =
fix
> would be to always try PMD-sized large folios first, and if that fails, f=
all
> back to smaller large folios. This approach differs from the strategy for
> large folio allocation used by other file systems, however, tmpfs is some=
what
> different from other file systems, as quoted from David's opinion:
> "
> There were opinions in the past that tmpfs should just behave like any ot=
her fs,
> and I think that's what we tried to satisfy here: use the write size as a=
n
> indication.
>
> I assume there will be workloads where either approach will be beneficial=
. I also
> assume that workloads that use ordinary fs'es could benefit from the same=
 strategy
> (start with PMD), while others will clearly not.
> "
>
> [1] https://lore.kernel.org/lkml/0d734549d5ed073c80b11601da3abdd5223e1889=
.1753689802.git.baolin.wang@linux.alibaba.com/
> Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Changes from RFC:
>  - Update the commit message.

Hi Baolin

I'm seeing userspace errors after this commit. I'm using
"transparent_hugepage_tmpfs=3Dwithin_size/always" and build kernel test
on top of tmpfs with swap on ZRAM, both within_size / always
results in same failure:

The error I'm seeing is when build the kernel gcc always fail with:
ld: kernel/workqueue.o:(.data..read_mostly+0x28): multiple definition
of `no symbol'; kernel/workqueue.o:(.data..read_mostly+0x30): first
defined here
ld: kernel/workqueue.o:(.data..read_mostly+0x20): multiple definition
of `no symbol'; kernel/workqueue.o:(.data..read_mostly+0x30): first
defined here
ld: kernel/workqueue.o:(.data..read_mostly+0x18): multiple definition
of `no symbol'; kernel/workqueue.o:(.data..read_mostly+0x30): first
defined here
ld: kernel/workqueue.o:(.data..read_mostly+0x10): multiple definition
of `no symbol'; kernel/workqueue.o:(.data..read_mostly+0x30): first
defined here
ld: kernel/workqueue.o:(.data..read_mostly+0x8): multiple definition
of `no symbol'; kernel/workqueue.o:(.data..read_mostly+0x30): first
defined here
ld: kernel/workqueue.o:(.data..read_mostly+0x0): multiple definition
of `no symbol'; kernel/workqueue.o:(.data..read_mostly+0x30): first
defined here
ld: kernel/workqueue.o: in function `no symbol':
:(.text+0x3760): multiple definition of `no symbol';
kernel/workqueue.o:(.data..read_mostly+0x30): first defined here
ld: kernel/workqueue.o: in function `no symbol':
:(.text+0x38c0): multiple definition of `no symbol';
kernel/workqueue.o:(.data..read_mostly+0x30): first defined here
ld: kernel/workqueue.o: in function `no symbol':

... <hundreds of lines of error like this on different files>...

After reverting this commit, the error is gone. I have a very stable
reproduce rate locally with different cgroup / memory pressure with
this patch applied, error logs are basically the same.

I'm still not sure what is causing this, a kernel bug or some
userspace bug is triggered by this. Changing the compiler to clang
then the problem is also gone. Still investigating.

