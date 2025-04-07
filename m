Return-Path: <linux-kernel+bounces-590508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F9A7D3A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 07:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D13F188CFC9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 05:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823CC2248A0;
	Mon,  7 Apr 2025 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBB/npdv"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5C22425B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 05:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005056; cv=none; b=o499rKw9pL3ozXQghNGkzIADSY64wJYZs9XaFLpsy7VWazqWl+t+wobOJB0GaMGthHGLzv4zFhUGCJ0zJE5Fs1xoczes0zWrNgEqjY65aeggkRc1j+5fmuWnEdCk6iaGlHapPVA1tHgvX2jVTolrUjBdN/cBY8lZgvS8PY6VbWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005056; c=relaxed/simple;
	bh=kKx4Mq6S60oDctpAHNOJ2iBB2kp8w70OG+S1g8NoT6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNF2S2/iGLmurutXF1bbvP0oPJf3zpC4S2sZ5BZSBLZaAGuEADd1quW5R6II4cuJhddQkCQYAetDdXu16jxhtY5z/zKzF14qji+Mz9ymFEIzYumrvxyTvvgDpMcw1Ppt67TxRnyW2RxpTJmMyNsQQQ5CzCUh3jRoFZmP+1kbrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBB/npdv; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-52413efd0d3so1666187e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Apr 2025 22:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744005054; x=1744609854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TncwcfsEts2FxYnhK+A5JNwLq/UeBfz60NCy/dOZhg8=;
        b=BBB/npdv6OwkKJie/NePD03I3GTt/Z4aPlinSMGWZjdRlg9ZKLX/xYm7T8QVx6yC2b
         orzMIU1884yA+YLxpFPhjhM1hpCerYXPHJu2RCyE8IKY07ClSbui68fwmvpdBzYDV7EH
         AKLqMBmUul4T/+jhnsJvlmXmYyGSwqZ7w+nndH6P+ZEmhgun3GyzPNLmgwFtoLiQb7zL
         9NwYz3oxLQ6r6HGFyGjnKn5dUUiDWzQ3DIpRXJRvzv1KDevECDAiSimTpK6b6qqgarcE
         uk7RRYFLBbwP/4uIW5EeP7cIvl/y5XhaT6nf+8XnCYmhxBtRF6JJkbvUbZukz16CueYc
         iShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744005054; x=1744609854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TncwcfsEts2FxYnhK+A5JNwLq/UeBfz60NCy/dOZhg8=;
        b=UiZrxJkT63ccRv0QW/YGQTyVQ5DjPr9NGH1fIrEG855av3NSW61cu0BhIqe3xWXIiZ
         19bxkWGSZr4J+w/rl45AKFiNioQwbSHbJcZ6jaH5HtX28tOX9X9XKPjj0ZDigpOJvrww
         vE4xjm5flVu32EJe2zg54gmeET6wy8T8Ln5raoxWNzQZmwTJcB5foulO5aYPDuPbegvG
         AGcbbGDNroiExsuckeAmfLOvolMsUxHveP/u8vZ0pyCVvxttybhV1jPGeNJ1FZm7o69u
         lOm+djS+qSxRpCZBykMtb4tIwHFHH5wT9HuiTMAmuT/tS7oiv9+8K2o9bKyybC+Pk5bJ
         323w==
X-Forwarded-Encrypted: i=1; AJvYcCXWyXDf9dOh0bNV6tm8syf3YMuJbIky37u8g0xsJiSDhXcjDteg11+zxX6OTf7T1/8hrnReoy++keZduqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi66ANa96zU6sLiNWl4BRuJKyRRxONglLbgvUGo/A9ovS85B/y
	7KiC5ysQgUfYir0WtXlm8ogt+1y8uZ14t+EJEHHX0LPDx75Y3Bri5QaVM54oKlJFAxT/Xj65HNh
	dk1v45u/LQxcNsmcYPJyLIU3PwLs=
X-Gm-Gg: ASbGncv3XXPnfVOTMhpk/ow/lTfHlbhVFYWxuQdBaliY/wk5jND3uuze47Vvs6qO/xD
	DBqYwq61AbKVxTBDZwMqpIg29D29ILHU3SAuOPOkI9d+dbnnTp0THNNctutKeuFz3wxAwpFUEcM
	9scJKm5kzEULa3E+r141AjxHEqIw==
X-Google-Smtp-Source: AGHT+IFvBUALOfbhAc7ZTDj+1qYBwV+DDke3iV0oHmxLiMrPhi01dySNUBoaRmlF207WvrrXWhLb5Q/d30UQFe8H+RU=
X-Received: by 2002:a05:6122:6585:b0:520:61ee:c7fc with SMTP id
 71dfb90a1353d-52764448721mr8144939e0c.4.1744005053724; Sun, 06 Apr 2025
 22:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212022718.1995504-1-xiaqinxin@huawei.com> <20250212022718.1995504-3-xiaqinxin@huawei.com>
In-Reply-To: <20250212022718.1995504-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 7 Apr 2025 17:50:42 +1200
X-Gm-Features: ATxdqUEwAdwB6D5DagVzMUdZgoOsw1QIQSdcNIkWQDykU7LKqNsRceUjwcC4I-M
Message-ID: <CAGsJ_4x7u00HVsa11cw_r6Mb3x0Ls-9tCg2HcUs=KvoVX=Vhvg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dma-mapping: benchmark: add support for dma_map_sg
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: chenxiang66@hisilicon.com, yangyicong@huawei.com, hch@lst.de, 
	iommu@lists.linux.dev, jonathan.cameron@huawei.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 3:27=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> Support for dma scatter-gather mapping and is intended for testing
> mapping performance. It achieves by introducing the dma_sg_map_param
> structure and related functions, which enable the implementation of
> scatter-gather mapping preparation, mapping, and unmapping operations.
> Additionally, the dma_map_benchmark_ops array is updated to include
> operations for scatter-gather mapping. This commit aims to provide
> a wider range of mapping performance test  to cater to different scenario=
s.
>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  include/linux/map_benchmark.h |   1 +
>  kernel/dma/map_benchmark.c    | 102 ++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.=
h
> index 054db02a03a7..a9c1a104ba4f 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -17,6 +17,7 @@
>
>  enum {
>         DMA_MAP_SINGLE_MODE,
> +       DMA_MAP_SG_MODE,
>         DMA_MAP_MODE_MAX
>  };
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index d8ec0ce058d8..b5828eeb3db7 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/timekeeping.h>
>
> @@ -111,8 +112,109 @@ static struct map_benchmark_ops dma_single_map_benc=
hmark_ops =3D {
>         .do_unmap =3D dma_single_map_benchmark_do_unmap,
>  };
>
> +struct dma_sg_map_param {
> +       struct sg_table sgt;
> +       struct device *dev;
> +       void **buf;
> +       u32 npages;
> +       u32 dma_dir;
> +};
> +
> +static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map=
)
> +{
> +       struct scatterlist *sg;
> +       int i =3D 0;
> +
> +       struct dma_sg_map_param *mparam __free(kfree) =3D kzalloc(sizeof(=
*mparam), GFP_KERNEL);
> +       if (!mparam)
> +               return NULL;
> +
> +       mparam->npages =3D map->bparam.granule;

Please add comments explaining that "granule" serves as  nents in SG
mode, and that each SG entry corresponds to a single page.
Otherwise, in single mode, the granule represents what we map and
unmap as a whole in a single operation.
I mean, make the code below clearly express what you are doing:

__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */


> +       mparam->dma_dir =3D map->bparam.dma_dir;
> +       mparam->dev =3D map->dev;
> +       mparam->buf =3D kmalloc_array(mparam->npages, sizeof(*mparam->buf=
),
> +                                   GFP_KERNEL);
> +       if (!mparam->buf)
> +               goto err1;
> +
> +       if (sg_alloc_table(&mparam->sgt, mparam->npages, GFP_KERNEL))
> +               goto err2;
> +
> +       for_each_sgtable_sg(&mparam->sgt, sg, i) {
> +               mparam->buf[i] =3D (void *)__get_free_page(GFP_KERNEL);
> +               if (!mparam->buf[i])
> +                       goto err3;
> +
> +               if (mparam->dma_dir !=3D DMA_FROM_DEVICE)
> +                       memset(mparam->buf[i], 0x66, PAGE_SIZE);
> +
> +               sg_set_buf(sg, mparam->buf[i], PAGE_SIZE);
> +       }
> +
> +       return_ptr(mparam);
> +
> +err3:
> +       while (i-- > 0)
> +               free_page((unsigned long)mparam->buf[i]);
> +
> +       pr_err("dma_map_sg failed get free page on %s\n", dev_name(mparam=
->dev));
> +       sg_free_table(&mparam->sgt);
> +err2:
> +       pr_err("dma_map_sg failed alloc sg table on %s\n", dev_name(mpara=
m->dev));
> +       kfree(mparam->buf);
> +err1:
> +       pr_err("dma_map_sg failed alloc mparam buf on %s\n", dev_name(mpa=
ram->dev));
> +       return NULL;

I assume allocation failures will already trigger their own warnings, so yo=
ur
pr_err isn't necessary. BTW, please replace err1, err2, err3 with something
meaningful.

> +}
> +
> +static void dma_sg_map_benchmark_unprepare(void *arg)
> +{
> +       struct dma_sg_map_param *mparam =3D arg;
> +       int i;
> +
> +       for (i =3D 0; i < mparam->npages; i++)
> +               free_page((unsigned long)mparam->buf[i]);
> +
> +       sg_free_table(&mparam->sgt);
> +
> +       kfree(mparam->buf);
> +       kfree(mparam);
> +}
> +
> +static int dma_sg_map_benchmark_do_map(void *arg)
> +{
> +       struct dma_sg_map_param *mparam =3D arg;
> +
> +       int sg_mapped =3D dma_map_sg(mparam->dev, mparam->sgt.sgl,
> +                                  mparam->npages, mparam->dma_dir);
> +       if (!sg_mapped) {
> +               pr_err("dma_map_sg failed on %s\n", dev_name(mparam->dev)=
);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static int dma_sg_map_benchmark_do_unmap(void *arg)

void

> +{
> +       struct dma_sg_map_param *mparam =3D arg;
> +
> +       dma_unmap_sg(mparam->dev, mparam->sgt.sgl, mparam->npages,
> +                    mparam->dma_dir);
> +
> +       return 0;

drop it.

> +}
> +
> +static struct map_benchmark_ops dma_sg_map_benchmark_ops =3D {
> +       .prepare =3D dma_sg_map_benchmark_prepare,
> +       .unprepare =3D dma_sg_map_benchmark_unprepare,
> +       .do_map =3D dma_sg_map_benchmark_do_map,
> +       .do_unmap =3D dma_sg_map_benchmark_do_unmap,
> +};
> +
>  static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE_MAX]=
 =3D {
>         [DMA_MAP_SINGLE_MODE] =3D &dma_single_map_benchmark_ops,
> +       [DMA_MAP_SG_MODE] =3D &dma_sg_map_benchmark_ops,
>  };
>
>  static int map_benchmark_thread(void *data)
> --
> 2.33.0
>

Thanks
Barry

