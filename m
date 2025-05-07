Return-Path: <linux-kernel+bounces-637015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0E4AAD348
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 04:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FFC4684C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 02:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE6519CD17;
	Wed,  7 May 2025 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noeTFcR1"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA70B18DF6D
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585019; cv=none; b=jVOJkXG+0msaFn5s3XQvUt+EyCneizuFexAgKuhGmbAnx9sQqWWz2dydYo7CwstIjD5EeLSzpICIAfT5NN9EaocNJS7777oj8elvXtmVcwDYxwACLOxUVFKKVIuwkgzPqsAtnYaerO1xA5Kk0MHN0YBOafsucIlxuh769CZc5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585019; c=relaxed/simple;
	bh=SznfOR6U7IN2g/iqV6jv8KKSpwQxBIwzXtZCsVeUWAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRVYjwvVYXRSi364W8bOfYfvc1I85sOLIzs6bRUc9Q3ZKBMpJ4nEo7nd8/F8v241wJQeKFFwQmpldBsdbZWZMDLfPvIEsvdl78kyRNEnMdFM0NwLZEf8QqTtet2XCQgH9EhT8QvnvnkmmACMxxUjIimByKA5XdXCSmVCbHxYWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noeTFcR1; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-877c48657f9so1288286241.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 19:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746585016; x=1747189816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4svO715lvCEPXXLLCM+oy1RnywJCznU/v/M9mAtCezc=;
        b=noeTFcR1qA49ymRhp/Jx1HA24STe4P+ghpAbpCiesZZmcjfqBoTvw4o16qqZmR4Ali
         CuhK2a534L+GhtAtFBdm8g5yeIxlYARLiLrRpRuXowyM3i7L7dlbwlZrnnERJ5XirAXP
         8vayOsomt0ICw43WkcQXW2MLbDBcKxRDGBA9bsoRqlGhkM8rFYxdysRpWZ/hd3QUeb46
         1lz41OdAdTsZ/vU/mStux/LqQAKuOOA2eAxHfUrjcHSzG6fxrO8D3GwoX2GSPYAty1Ag
         2W9L8Te3l3d0rI8Vq3fDQas0BcmZlzbDiSCF42zUd2KQ2uwlzHGYPpPsNZ05mO6nLpqq
         lFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746585016; x=1747189816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4svO715lvCEPXXLLCM+oy1RnywJCznU/v/M9mAtCezc=;
        b=QXSX9vsigo5u033NnCrMbvd5Q1yHiTc3zkEAM+s6lwIlVj+j2C6ktqTokM/39C5TX9
         geubYWAvDOUGEtAfL4ZhegVJzPXJzmF38s06svbafPR29pwvVhx59Q4e00KGpjtB/jcz
         znGqeBRJ8ekz95ED1mUdM2wLrDbB5qBXbVFhtJipL2cMS7TfDnPpG6JRyGYC4UBc8v6N
         UDMN2nZ3NPqjARVdooaDLQyVw0IpGJBoZyq/WyyKn3C9ASXgvrykq4nAjuxJnJhyPaWW
         zV3pvXPPD3ZUYtEGi2b3rDIC5CRExLeDJ7gQcGFxVGyjd9Bib0099k863cB5807L3FEW
         VSMg==
X-Forwarded-Encrypted: i=1; AJvYcCWzoqdqgI8CQEopVLVGREomOHAslLfUkB8PMnthI/+mFrU1b0AT4PtOP0lUnHFGdGZ4oXokOlX0sXPswuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxttdNGZwXNWDTVlnnTs6secVD5OGADkL56dAjVpSIqMGIcijeH
	cEQOIQ8C0Dl9H+s4Pwj0jAcClpCJ864vfKqMHvSbrYM60mTBa0iKD8H/5FZvpDnlAIJctex/PRz
	H6Yfoj9dCaHzzfZCJdhvZcSQHuSg=
X-Gm-Gg: ASbGnctWFNrCI1LPsk0AWrrLXoBuVP3b5l8VQCw5aY2TC7MoA1zFO3eeizT5JJ+WXCF
	d1INta6y0zd3U8bCWE9sVyJD7zaemtE8bOVar8htAoKCx0NoELoon5Mi1/XbSrysWQChQM+eOeb
	A+q65e84MK43/qsMU7MUVSUA==
X-Google-Smtp-Source: AGHT+IEdQ8qJRTe3nOcdVAGg66QPjgTWfepYf4RI/zrUWt73Ue904nbTHGUgW/makM6++UBpB7AgjR6Rg5Wfo7eSQ3c=
X-Received: by 2002:a05:6102:3f8f:b0:4db:154b:cb3b with SMTP id
 ada2fe7eead31-4dc73798314mr1541637137.3.1746585016544; Tue, 06 May 2025
 19:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506030100.394376-1-xiaqinxin@huawei.com> <20250506030100.394376-3-xiaqinxin@huawei.com>
In-Reply-To: <20250506030100.394376-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 May 2025 14:30:05 +1200
X-Gm-Features: ATxdqUFNaSx8vLRgaXQvYHswVMU1YW8ewJcP9JYFNqr9iEGTSzlrviy0h9P2_qY
Message-ID: <CAGsJ_4wgxgXs6pyYUTNFmNmqHSWtPbKSUnMCzf8=rvOdhgJ04Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dma mapping benchmark: modify the framework to
 adapt to more map modes
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 3:01=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> wr=
ote:
>
> In this patch map_benchmark abstract in four interface: prepare, unprepar=
e,
> do_map, do_unmap. When there's a new mode to add, need four steps:
> 1) Add the mode in map_benchmark.h
> 2) Defines the mode param, like struct dma_xxx_map_param, and this object
>    will be return in prepare and as input parameter in other ops;
> 3) Defines the ops functions:prepare, unprepare, do_map, do_unmap.
> 4) Add the new mode in dma_map_benchmark_ops.

There are too many irrelevant details.

We're more interested in the reasoning behind this change than just the cha=
nge
itself. There should be some explanation of the purpose.

>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  include/linux/map_benchmark.h |   8 ++-
>  kernel/dma/map_benchmark.c    | 120 +++++++++++++++++++++++++++-------
>  2 files changed, 104 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.=
h
> index 2ac2fe52f248..5294dfd1870f 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -15,6 +15,11 @@
>  #define DMA_MAP_TO_DEVICE       1
>  #define DMA_MAP_FROM_DEVICE     2
>
> +enum {
> +       DMA_MAP_SINGLE_MODE,
> +       DMA_MAP_MODE_MAX
> +};
> +
>  struct map_benchmark {
>         __u64 avg_map_100ns; /* average map latency in 100ns */
>         __u64 map_stddev; /* standard deviation of map latency */
> @@ -27,6 +32,7 @@ struct map_benchmark {
>         __u32 dma_dir; /* DMA data direction */
>         __u32 dma_trans_ns; /* time for DMA transmission in ns */
>         __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a ti=
me */
> -       __u8 expansion[76];     /* For future use */
> +       __u8  map_mode; /* the mode of dma map */
> +       __u8 expansion[75];     /* For future use */
>  };
>  #endif /* _KERNEL_DMA_BENCHMARK_H */
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index cc19a3efea89..f04973eba1d8 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -5,6 +5,7 @@
>
>  #define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
>
> +#include <linux/cleanup.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -31,17 +32,97 @@ struct map_benchmark_data {
>         atomic64_t loops;
>  };
>
> +struct map_benchmark_ops {
> +       void *(*prepare)(struct map_benchmark_data *map);
> +       void (*unprepare)(void *arg);
> +       int (*do_map)(void *arg);
> +       void (*do_unmap)(void *arg);
> +};
> +
> +struct dma_single_map_param {
> +       struct device *dev;
> +       dma_addr_t addr;
> +       void *xbuf;
> +       u32 npages;
> +       u32 dma_dir;
> +};
> +
> +static void *dma_single_map_benchmark_prepare(struct map_benchmark_data =
*map)
> +{
> +       struct dma_single_map_param *mparam __free(kfree) =3D kzalloc(siz=
eof(*mparam),
> +                                                                   GFP_K=
ERNEL);
> +       if (!mparam)
> +               return NULL;
> +
> +       mparam->npages =3D map->bparam.granule;
> +       mparam->dma_dir =3D map->bparam.dma_dir;
> +       mparam->dev =3D map->dev;
> +       mparam->xbuf =3D alloc_pages_exact(mparam->npages * PAGE_SIZE, GF=
P_KERNEL);
> +       if (!mparam->xbuf)
> +               return NULL;
> +
> +       /*
> +        * for a non-coherent device, if we don't stain them in the
> +        * cache, this will give an underestimate of the real-world
> +        * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
> +        * 66 means evertything goes well! 66 is lucky.
> +        */
> +       if (mparam->dma_dir !=3D DMA_FROM_DEVICE)
> +               memset(mparam->xbuf, 0x66, mparam->npages * PAGE_SIZE);
> +
> +       return_ptr(mparam);
> +}
> +
> +static void dma_single_map_benchmark_unprepare(void *arg)
> +{
> +       struct dma_single_map_param *mparam =3D arg;
> +
> +       free_pages_exact(mparam->xbuf, mparam->npages * PAGE_SIZE);
> +       kfree(mparam);
> +}
> +
> +static int dma_single_map_benchmark_do_map(void *arg)
> +{
> +       struct dma_single_map_param *mparam =3D arg;
> +
> +       mparam->addr =3D dma_map_single(mparam->dev, mparam->xbuf,
> +                                     mparam->npages * PAGE_SIZE, mparam-=
>dma_dir);
> +       if (unlikely(dma_mapping_error(mparam->dev, mparam->addr))) {
> +               pr_err("dma_map_single failed on %s\n", dev_name(mparam->=
dev));
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void dma_single_map_benchmark_do_unmap(void *arg)
> +{
> +       struct dma_single_map_param *mparam =3D arg;
> +
> +       dma_unmap_single(mparam->dev, mparam->addr,
> +                        mparam->npages * PAGE_SIZE, mparam->dma_dir);
> +}
> +
> +static struct map_benchmark_ops dma_single_map_benchmark_ops =3D {
> +       .prepare =3D dma_single_map_benchmark_prepare,
> +       .unprepare =3D dma_single_map_benchmark_unprepare,
> +       .do_map =3D dma_single_map_benchmark_do_map,
> +       .do_unmap =3D dma_single_map_benchmark_do_unmap,
> +};
> +
> +static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE_MAX]=
 =3D {
> +       [DMA_MAP_SINGLE_MODE] =3D &dma_single_map_benchmark_ops,
> +};
> +
>  static int map_benchmark_thread(void *data)
>  {
> -       void *buf;
> -       dma_addr_t dma_addr;
>         struct map_benchmark_data *map =3D data;
> -       int npages =3D map->bparam.granule;
> -       u64 size =3D npages * PAGE_SIZE;
> +       __u8 map_mode =3D map->bparam.map_mode;
>         int ret =3D 0;
>
> -       buf =3D alloc_pages_exact(size, GFP_KERNEL);
> -       if (!buf)
> +       void *arg =3D dma_map_benchmark_ops[map_mode]->prepare(map);

It's a bit awkward. Let's try something like this instead:

struct map_benchmark_ops *mb_ops =3D &dma_map_benchmark_ops[map_mode];

then
mb_ops->prepare()/map/unmap/unprepare etc.

And can you find a better name than "arg" which is meaningless, mparam?

> +
> +       if (!arg)
>                 return -ENOMEM;
>
>         while (!kthread_should_stop())  {
> @@ -49,23 +130,10 @@ static int map_benchmark_thread(void *data)
>                 ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
>                 ktime_t map_delta, unmap_delta;
>
> -               /*
> -                * for a non-coherent device, if we don't stain them in t=
he
> -                * cache, this will give an underestimate of the real-wor=
ld
> -                * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
> -                * 66 means evertything goes well! 66 is lucky.
> -                */
> -               if (map->dir !=3D DMA_FROM_DEVICE)
> -                       memset(buf, 0x66, size);
> -
>                 map_stime =3D ktime_get();
> -               dma_addr =3D dma_map_single(map->dev, buf, size, map->dir=
);
> -               if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
> -                       pr_err("dma_map_single failed on %s\n",
> -                               dev_name(map->dev));
> -                       ret =3D -ENOMEM;
> +               ret =3D dma_map_benchmark_ops[map_mode]->do_map(arg);
> +               if (ret)
>                         goto out;
> -               }
>                 map_etime =3D ktime_get();
>                 map_delta =3D ktime_sub(map_etime, map_stime);
>
> @@ -73,7 +141,8 @@ static int map_benchmark_thread(void *data)
>                 ndelay(map->bparam.dma_trans_ns);
>
>                 unmap_stime =3D ktime_get();
> -               dma_unmap_single(map->dev, dma_addr, size, map->dir);
> +               dma_map_benchmark_ops[map_mode]->do_unmap(arg);
> +
>                 unmap_etime =3D ktime_get();
>                 unmap_delta =3D ktime_sub(unmap_etime, unmap_stime);
>
> @@ -108,7 +177,7 @@ static int map_benchmark_thread(void *data)
>         }
>
>  out:
> -       free_pages_exact(buf, size);
> +       dma_map_benchmark_ops[map_mode]->unprepare(arg);
>         return ret;
>  }
>
> @@ -209,6 +278,11 @@ static long map_benchmark_ioctl(struct file *file, u=
nsigned int cmd,
>
>         switch (cmd) {
>         case DMA_MAP_BENCHMARK:
> +               if (map->bparam.map_mode >=3D DMA_MAP_MODE_MAX) {
> +                       pr_err("invalid map mode\n");
> +                       return -EINVAL;
> +               }
> +
>                 if (map->bparam.threads =3D=3D 0 ||
>                     map->bparam.threads > DMA_MAP_MAX_THREADS) {
>                         pr_err("invalid thread number\n");
> --
> 2.33.0
>

Thanks
Barry

