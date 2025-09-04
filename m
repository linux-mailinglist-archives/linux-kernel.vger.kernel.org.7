Return-Path: <linux-kernel+bounces-799580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63819B42DE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25EDB5805E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE9AB661;
	Thu,  4 Sep 2025 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBT6Dn2b"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B5FAD2C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944424; cv=none; b=TV/KJLWxZTrUI34JkqrALGl9LV+wB/6FvGj7hiLCMOT73Sr3jx2WKxGJ0JLwKUn0u7VFhrXKMLig2G6CXTCiiNuepDMlfkaBoN8AH9s2Vpqc9vHj9l3CscNheHsuFQRDAa1xzrtrh6ZFTalBkA5z9qbbKCXDULPyfH8V87wbwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944424; c=relaxed/simple;
	bh=FUxoXrttyZlaf3Re6Hn7g2Jwjqejh2h3jwSdvSn7XOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcFMOvpHkhNfHX4fiwqDwPmE0VhR+soFlPjlR0frs1uUgK90EEl89HXqjJEqQbb+rKKzwIkDy7t2xtbxl+TigjdsH5+f0S8aBZlVdzZDd9yaSmxa1sdnlG2+zy3Ml7ZKz7rT+ivBAUAhFTmfzx5wvvH+oMUzXJlFXKM4BOdZgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBT6Dn2b; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f76277413so486054e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756944421; x=1757549221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoZmhLyKn/nkdQ8DJ5UpZG4Aw6d8utBCwrwUaI83R7I=;
        b=iBT6Dn2bEltFuhKk1bo9IuQE25lIGzGUtpuGgejK+FeFzrSRYc0b+n2gKzo6vUREqN
         a/+PTi52MBiInYqqYTAu7fW9mW1vfy2Q7yGxY8gx+WORboVCN4CdvJt/G0YhOJ+Om9XQ
         UFYM+dh6zahbWkJ4nsCGIa7myIUmmyeEPh/XfLY0FM5Ie3n1+g2+/Xhs0Je3i440TdHh
         aR4PaW8uKFsQbOFZSGsa/o3GXs1l4PiKuWFUGRcN+pW96Fp0v778IDouDVf1qYeQXAvt
         jNO9mUHy2BG655rb+47Nk5bbjOPYu0zRNGszR+0GPoMFRAbhE5LWJ/YRhe/k4BLR8zQq
         9MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756944421; x=1757549221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoZmhLyKn/nkdQ8DJ5UpZG4Aw6d8utBCwrwUaI83R7I=;
        b=pUaL8ca3GH8TN2T9IQa2chOnWLabp+GoyEtkPXhXZnqIhEuecLHqvFU0QLd2ZnHvgZ
         0jJ1wJ/f1RKnGdc4cExKuFOY3+R6UykCFe9YY4IPjhwd3tgIIH8+k16KEnSjAMBiVb2l
         jg1WeoYh8JJofezqxzCXfrgdrPTBf0uv3AI06+jca0A4WQg1xjc+nRYzMdwU9ueqBn/1
         UF3pCzk21V+lTqtLGhcDbua1j0JAt0MhXIPk3rWl/J+9mk8+eNXPDjTY2DQp4vDqHd/R
         3mbVAlAW4nmCzWT3v+oadbxFpWDW38ncZZcitpyOsGq41kkb2dwt7RqwqjJqTetgA07H
         5vxg==
X-Forwarded-Encrypted: i=1; AJvYcCW1TNGqOWqBjlTar0Ee0FmupwA4ODruBJidvE7BL075yvc6CGpcpZksAnqXNj4W5tLxboN8j7bOiePOSZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjcbGsulnOyjcpo/8h9lb2UhmBOorfSRs8Thh5iljs3GUINHvy
	K4kD1XN5lJ28W261pXHHsak2EnDc9KqVhOb+jp0XmByGlyBb4MuWc+958A276/hC0pxqSu9mSCN
	NKzHYam/nVEdkbKm4Rc+rpVT1FnvsORiMUS2qiEvKx4E6RIHh9NQH
X-Gm-Gg: ASbGncuujhWvZGBvaMrgc2XeaxAdfYeSaZwMIhgwgCayKiOa2ZWVuybHgWrVf9hjqLn
	/OM50lxLsdGfNYs0YvLPWH1vLcJVqwTQsOx0cL/qL+JAxQho/l4brxppAdjR9gl8OegnuvLIYth
	E5ol06yyu8hK/33qtYry8Ue2Bi4t6wT6DYJdaXhAoWiyLWvTm5Zwk2mDxvXjoUevqx/Mb3F8Mg0
	g6STM1XQYW77zSoZOxVIyVboCBkxWry73+cd6GU2Oej9LMTxfJA
X-Google-Smtp-Source: AGHT+IEct78UJdrP8Mw1fHoqQhwiDSK6WJTCelvjHpNt0ZBbR9UBNmKHi6gPcy7tM8EHSgXZol8bWA6P0Y5bJNZG0cQ=
X-Received: by 2002:a05:6512:258a:b0:55f:6fcc:6f4c with SMTP id
 2adb3069b0e04-55f7095249bmr5080694e87.47.1756944420550; Wed, 03 Sep 2025
 17:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830235838.58067-1-21cnbao@gmail.com>
In-Reply-To: <20250830235838.58067-1-21cnbao@gmail.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 3 Sep 2025 17:06:48 -0700
X-Gm-Features: Ac12FXzqtilJ6SdZS-KX2jb500H77ogaF5l5m6ZQqtBfs2J7DgcHM6yl_AOpcwo
Message-ID: <CANDhNCqcoR3USLG0Ys2WBQmEdS0u6gdaHGCVsftMk3OC5Vhjpw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: use larger contiguous mappings
 instead of per-page mmap
To: Barry Song <21cnbao@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 4:58=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> We can allocate high-order pages, but mapping them one by
> one is inefficient. This patch changes the code to map
> as large a chunk as possible. The code looks somewhat
> complicated mainly because supporting mmap with a
> non-zero offset is a bit tricky.
>
> Using the micro-benchmark below, we see that mmap becomes
> 3.5X faster:
...

It's been awhile since I've done mm things, so take it with a pinch of
salt, but this seems reasonable to me.

Though, one thought below...

> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> index bbe7881f1360..4c782fe33fd4 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -186,20 +186,35 @@ static int system_heap_mmap(struct dma_buf *dmabuf,=
 struct vm_area_struct *vma)
>         struct system_heap_buffer *buffer =3D dmabuf->priv;
>         struct sg_table *table =3D &buffer->sg_table;
>         unsigned long addr =3D vma->vm_start;
> -       struct sg_page_iter piter;
> -       int ret;
> +       unsigned long pgoff =3D vma->vm_pgoff;
> +       struct scatterlist *sg;
> +       int i, ret;
> +
> +       for_each_sgtable_sg(table, sg, i) {
> +               unsigned long n =3D sg->length >> PAGE_SHIFT;
>
> -       for_each_sgtable_page(table, &piter, vma->vm_pgoff) {
> -               struct page *page =3D sg_page_iter_page(&piter);
> +               if (pgoff < n)
> +                       break;
> +               pgoff -=3D n;
> +       }
> +
> +       for (; sg && addr < vma->vm_end; sg =3D sg_next(sg)) {
> +               unsigned long n =3D (sg->length >> PAGE_SHIFT) - pgoff;
> +               struct page *page =3D sg_page(sg) + pgoff;
> +               unsigned long size =3D n << PAGE_SHIFT;
> +
> +               if (addr + size > vma->vm_end)
> +                       size =3D vma->vm_end - addr;
>
> -               ret =3D remap_pfn_range(vma, addr, page_to_pfn(page), PAG=
E_SIZE,
> -                                     vma->vm_page_prot);
> +               ret =3D remap_pfn_range(vma, addr, page_to_pfn(page),
> +                               size, vma->vm_page_prot);

It feels like this sort of mapping loop for higher order pages
wouldn't be a unique pattern to just this code.  Would this be better
worked into a helper so it would be more generally usable?

Otherwise,
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

