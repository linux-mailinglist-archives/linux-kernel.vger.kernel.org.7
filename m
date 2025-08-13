Return-Path: <linux-kernel+bounces-766108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CCDB2425E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E1D880411
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17642D373E;
	Wed, 13 Aug 2025 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYKq1KW3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1D2BE053
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069356; cv=none; b=alDJPZPFLX0iqSkR/k8sD9aUUgMhrzAZSUkohBLXG/trC8aL6uLY6mKCTecJBbN1UK8bIhW0ijs5lDf8sdy/OS0U1575ZwUKKqO9G7YJYWDieR6dCzj7o3UUL1gLKyBvdJ04F5uzB/TQf/fhqrs7+Og9bm/nukNt9PEVr+XDk1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069356; c=relaxed/simple;
	bh=5tw3NG6slUe/9zPVFbDN/qPtARYE05vHQheAmJtyjTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSu2UB0w4rpTCoFLj9MIZ+siQJpWRgbU1WENdML+u4ak/zfnFz380MNDTjyUvdTL2UWTJdbHQ42pthSraS2V6dSP7mXiT0uHYHj0U3kqcQq2yGU815PJ0PgZK56yqUBWxD9WO5dJTvQ0arnO2hJdNWTY78Ly6za+iCJk/ARUhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYKq1KW3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755069353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iUJDUKPSUZjqYyom4L2qT6NYz7XU0fw6XAj7TVQsKM=;
	b=JYKq1KW36RHMIXz4iG86qEkyrmj5nTvrI3VYokGmWJorTM5UM6T1WYq4C9nSAktP4sCFmy
	rEf/9ynUTqRm6mM/DqgwxH791R+m9vzvyufUgdaHQniq69WNjC4YgUamyzS6HXjlkDMQ+J
	BhfE9vKjHnJePAd4Mo80dMFlxVv9DRI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-i-phI6E2MyOqaKMb4vqulw-1; Wed, 13 Aug 2025 03:15:51 -0400
X-MC-Unique: i-phI6E2MyOqaKMb4vqulw-1
X-Mimecast-MFC-AGG-ID: i-phI6E2MyOqaKMb4vqulw_1755069351
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so13252816a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069350; x=1755674150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iUJDUKPSUZjqYyom4L2qT6NYz7XU0fw6XAj7TVQsKM=;
        b=btuluXKl+jWwuo0iXJbiQlm63zaEkxA3mGPgt+wKqEjv057vWoPJYVbdbbdEskQmaq
         CzCJTDVGYap8SNNGSvOpG3wktoNeRvl1L9jLe/xDSKiXyU3b3CktTcYucKXoH+PA+0iO
         Ofht7gT0RoVjtVnZtypC8k50+XEYANyeCd883988pJhs6F8JEPfUvnFVrNj9jSOOVCAK
         W0LBhiWxOzqZ/3Kv50698YsEo/jmjEr02Rpw0B9GYVK8ga8LxZvH0pTA5VtuT8dfFFMx
         RZctfMq3josSHvTlHs9iMP0LUy/K4o2nFiCJnSvONG5uL3Wm9RIMwfP4pBFbmeekKICl
         liBg==
X-Forwarded-Encrypted: i=1; AJvYcCV8V8HYjnslIE7HUrplIaeOvw9XW3pNMIvpWFHYbhiTHsmCJ3DQn+ZIAV1baFIPAinwrdcsVh0NQtwV1EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbDXAhvHsDzPXZ/3ngHIpVrZl+X6eMP/pm4PSJ7VWM/sQBNUV
	gLe6rWy7RtKGtxuk6iNTz2XZkh5pI9QMRlReB4+H8rBMWTz6naz3wAx/6Uz5huuhIO+W+C2fmlr
	g5ZsAKNXpleTwN/w2Sfedlx4iNHh10skILXgjXK6j7ddncsHZG9WLEGVieW7CNj0h0UtjgmXjal
	1zks4KbmW3E/MkE8NnR/6TgtXBXTrro6LqEiw6Hmpu
X-Gm-Gg: ASbGncteSsBtghngDCoTpBCRZfx7VlvGI9IX96rtjEvkc0Lg8SFSzbgwiPjkZeF1T/j
	+itTCSaoD5FaYIZ47NI9xcBLJEKBhUT4WDC4hNLfPpea5JA52x7Sp0PnSqEwMH5zjaIHi0YRfFr
	EnW98UWCU0GfCoI7IXFQTFnH6K7pW0hquCA7mEDlArYcjojfHPs12Radw=
X-Received: by 2002:a17:90b:53cc:b0:321:156f:5c00 with SMTP id 98e67ed59e1d1-321d0d32df0mr2827585a91.1.1755069350401;
        Wed, 13 Aug 2025 00:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG30aL8DwBd2J+i3dLK0+cgvalccG/++ETJ0dYYPaYe0fBSo3sd+UheN8wAZQUnUNpHKqYHmUQ3LLvORgIe82c=
X-Received: by 2002:a17:90b:53cc:b0:321:156f:5c00 with SMTP id
 98e67ed59e1d1-321d0d32df0mr2827554a91.1.1755069349963; Wed, 13 Aug 2025
 00:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-3-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-3-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 09:15:13 +0200
X-Gm-Features: Ac12FXwMYGAaWjAbPLrY3wGijOWbSZQBPgptXx-FzxARpLuCLXJ6Nod1sl-Fl6s
Message-ID: <CAJaqyWeMAVDD+vSNdtCb34Oeh8inAfzYDC4qqT4daqVttcowGw@mail.gmail.com>
Subject: Re: [PATCH V5 2/9] virtio_ring: switch to use dma_{map|unmap}_page()
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:48=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This patch switches to use dma_{map|unmap}_page() to reduce the
> coverage of DMA operations. This would help for the following rework
> on the virtio map operations.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 55 +++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 103bad8cffff..75e5f6336c8d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -405,8 +405,8 @@ static dma_addr_t vring_map_single(const struct vring=
_virtqueue *vq,
>         if (!vq->use_dma_api)
>                 return (dma_addr_t)virt_to_phys(cpu_addr);
>
> -       return dma_map_single(vring_dma_dev(vq),
> -                             cpu_addr, size, direction);
> +       return virtqueue_dma_map_single_attrs(&vq->vq, cpu_addr,
> +                                             size, direction, 0);
>  }
>
>  static int vring_mapping_error(const struct vring_virtqueue *vq,
> @@ -451,22 +451,14 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
>         if (flags & VRING_DESC_F_INDIRECT) {
>                 if (!vq->use_dma_api)
>                         goto out;
> +       } else if (!vring_need_unmap_buffer(vq, extra))
> +               goto out;
>
> -               dma_unmap_single(vring_dma_dev(vq),
> -                                extra->addr,
> -                                extra->len,
> -                                (flags & VRING_DESC_F_WRITE) ?
> -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       } else {
> -               if (!vring_need_unmap_buffer(vq, extra))
> -                       goto out;
> -
> -               dma_unmap_page(vring_dma_dev(vq),
> -                              extra->addr,
> -                              extra->len,
> -                              (flags & VRING_DESC_F_WRITE) ?
> -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       }
> +       dma_unmap_page(vring_dma_dev(vq),
> +                      extra->addr,
> +                      extra->len,
> +                      (flags & VRING_DESC_F_WRITE) ?
> +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
>
>  out:
>         return extra->next;
> @@ -1276,20 +1268,13 @@ static void vring_unmap_extra_packed(const struct=
 vring_virtqueue *vq,
>         if (flags & VRING_DESC_F_INDIRECT) {
>                 if (!vq->use_dma_api)
>                         return;
> +       } else if (!vring_need_unmap_buffer(vq, extra))
> +               return;
>
> -               dma_unmap_single(vring_dma_dev(vq),
> -                                extra->addr, extra->len,
> -                                (flags & VRING_DESC_F_WRITE) ?
> -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       } else {
> -               if (!vring_need_unmap_buffer(vq, extra))
> -                       return;
> -
> -               dma_unmap_page(vring_dma_dev(vq),
> -                              extra->addr, extra->len,
> -                              (flags & VRING_DESC_F_WRITE) ?
> -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       }
> +       dma_unmap_page(vring_dma_dev(vq),
> +                      extra->addr, extra->len,
> +                      (flags & VRING_DESC_F_WRITE) ?
> +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
>  static struct vring_packed_desc *alloc_indirect_packed(unsigned int tota=
l_sg,
> @@ -3161,7 +3146,13 @@ dma_addr_t virtqueue_dma_map_single_attrs(const st=
ruct virtqueue *_vq, void *ptr
>                 return (dma_addr_t)virt_to_phys(ptr);
>         }
>
> -       return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, at=
trs);
> +       /* DMA must never operate on areas that might be remapped. */
> +       if (dev_WARN_ONCE(&_vq->vdev->dev, is_vmalloc_addr(ptr),
> +                         "rejecting DMA map of vmalloc memory\n"))
> +               return DMA_MAPPING_ERROR;
> +
> +       return dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(ptr),
> +                                 offset_in_page(ptr), size, dir, attrs);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
>
> @@ -3186,7 +3177,7 @@ void virtqueue_dma_unmap_single_attrs(const struct =
virtqueue *_vq,
>         if (!vq->use_dma_api)
>                 return;
>
> -       dma_unmap_single_attrs(vring_dma_dev(vq), addr, size, dir, attrs)=
;
> +       dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
>
> --
> 2.31.1
>


