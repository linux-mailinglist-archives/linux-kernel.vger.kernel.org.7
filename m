Return-Path: <linux-kernel+bounces-766105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF43BB24260
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321BA188E581
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551122C21C8;
	Wed, 13 Aug 2025 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtXVXtoQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7F2BD01A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069320; cv=none; b=SIZ5O/ABnG27D/kmDr9Rway7qKlxEcg6jpoZgpvsLHid08uWfTy/PoN6GmaNXbMWDBNEdbZwQfIjvCBjJNHi3vBm95wCS+ZRgAIQKqRKfEH6JX+9tsk276Y1Dgh2WOFtc5plar7sLJ+JjM5Ya1cvrw4H4W5KDVdKKDp0GW+k5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069320; c=relaxed/simple;
	bh=y26v0V7s3iGAuBSrKXUAstUvcTB+s5bChxCunkbC0r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m43Z6ID4Rgs6KtxjXUpACkaNosYaqzdvXQ5AS4fkUMIPXRyPtT4TYYVYEcXKM1bjahGBtMhY9C2xNWyNI+gw9l3boPnYAgy5GXemDhSqmb+zMn+WlyqvFho7QX/lq8NGPVZ/emuWC4uCj4NGFJmtSsaK8UnikwqR1itsz2cN/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtXVXtoQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755069315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j22/vlxbgZewQq+2BkVTztlbPB3/Pt1Gm8og/omOcJs=;
	b=NtXVXtoQakYeQqqzJ6mkG4BgrODL6zsqzvXO6z7/GknIyblguiqyWlVqUdbc8EMGjgQq9y
	Jujid25A2O/8ce7GdNlynLNLP7X1rcIHqIxvjTjh+46EG99DiJeG/a+eXAlkYEVwcd5bK9
	xUi08lMgxKywyTdxX+nsf3j5vja3p4I=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-UxOhbivZOVOw3g3efgM78Q-1; Wed, 13 Aug 2025 03:15:14 -0400
X-MC-Unique: UxOhbivZOVOw3g3efgM78Q-1
X-Mimecast-MFC-AGG-ID: UxOhbivZOVOw3g3efgM78Q_1755069313
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2403e4c82dbso51686315ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069313; x=1755674113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j22/vlxbgZewQq+2BkVTztlbPB3/Pt1Gm8og/omOcJs=;
        b=K93qNK6gl8kpiIIQnXdo+m/wwfIutx6P8NC2V55LcTNj7gSOfqE/LSc1xNzsioueL7
         dgKNYN5lhl7TNRvQs10rBJcKLmbiOhFkBA7ZH1MT4bWQ33QTRUQoieMhXSIWl6yGwtwR
         4+tRfIzl2KKpmw2oR1adDjt2AkMdj5a+RVitPI0n76jrJGlkSVCfz22aU+jmAO+akAHs
         ZOwf6Tmwc+0oNY3zYyf4k0+Dm5qOskpIST2v+4SXDDYqgRFPgWKauhAj+rln5u2CW/ts
         BA/Nq/lYshw8a7UrcNyRWy69xSHXSMq60w7df/r91vZormWWyTqr+ggUGJ7AH189vQie
         GN8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVydPHDWfzps5BDWh6eBQMkXAI7m3u2oENlmbfmYrqHgsHQWpfzpuO7XUtS4w0yPOKnlfGENP8iAY3OciI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2DXYAurv42VvVj4Oheq0uUL4IZJvfxjgaObejIKNyRQWDTglC
	PbyO6ytPenAFyyqQkGF13YQvvgAIAD3/9MqtNpEiA9UVegRxu6Via6EcrP9e/6ahq7b+tWS091Y
	CwuX/XCmbS83CR1sYKPTAcu8+Pk0DkHw6tNFBPdOO/uwH09tsrRn55sb6SWqGTqwxHVLqqcCQsM
	8dBogF+Pg0v4W7uOsdcCx5tuxrOEuyPWU/fpTEpx6hNYLp4byL5aJ2jQ==
X-Gm-Gg: ASbGncuFO+X7thVD+kRK5R/PZQa1UgPTTHb0KUkhBZWiCjoc7Oi4v8FgUQIBxZ8+CwA
	3wKNOpPGzMQ0ziZutaxL9doqQhjtu4tMoPgdWsbHqEfl1sykYKsXfjrji0/zAvcHkJMYKvc2VCC
	d7heO5aEH8VqJY2M5Qg1UF6du3qfUfw+rShfMnoEKwS6HopxARLNcO/1U=
X-Received: by 2002:a17:902:ec85:b0:23f:ecf6:463b with SMTP id d9443c01a7336-2430d224901mr35063765ad.45.1755069312924;
        Wed, 13 Aug 2025 00:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF48cGlFDnLEX9VoOq+NnLcpHQcDjQviYJ0rwpDN3nUccZ4JSexKB+sW1cyJ9IoDV1jj64zMumFmb3K72xCJSc=
X-Received: by 2002:a17:902:ec85:b0:23f:ecf6:463b with SMTP id
 d9443c01a7336-2430d224901mr35063355ad.45.1755069312478; Wed, 13 Aug 2025
 00:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-2-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-2-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 09:14:36 +0200
X-Gm-Features: Ac12FXz2yP8POKqHq5p9pzviM2xNHLsxaW7X3Xm17rGiZUFa5EQ7EQVenYKJjm4
Message-ID: <CAJaqyWcuMVz6eTbwcCDd=F1gqyXmQOZRD=1ronWAqke5xa01Mw@mail.gmail.com>
Subject: Re: [PATCH V5 1/9] virtio_ring: constify virtqueue pointer for DMA helpers
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:48=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This patch consities virtqueue point for DMA helpers.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
>  include/linux/virtio.h       | 12 ++++++------
>  2 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f5062061c408..103bad8cffff 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3149,12 +3149,12 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>   *
>   * return DMA address. Caller should check that by virtqueue_dma_mapping=
_error().
>   */
> -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *p=
tr,
> +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, v=
oid *ptr,
>                                           size_t size,
>                                           enum dma_data_direction dir,
>                                           unsigned long attrs)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (!vq->use_dma_api) {
>                 kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), =
size, dir);
> @@ -3176,11 +3176,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs)=
;
>   * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
>   *
>   */
> -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t =
addr,
> +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
> +                                     dma_addr_t addr,
>                                       size_t size, enum dma_data_directio=
n dir,
>                                       unsigned long attrs)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (!vq->use_dma_api)
>                 return;
> @@ -3196,9 +3197,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs)=
;
>   *
>   * Returns 0 means dma valid. Other means invalid dma address.
>   */
> -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
> +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t =
addr)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (!vq->use_dma_api)
>                 return 0;
> @@ -3217,9 +3218,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
>   *
>   * return bool
>   */
> -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
> +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t add=
r)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (!vq->use_dma_api)
>                 return false;
> @@ -3240,12 +3241,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
>   * the DMA address really needs to be synchronized
>   *
>   */
> -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
> +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq=
,
>                                              dma_addr_t addr,
>                                              unsigned long offset, size_t=
 size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>         struct device *dev =3D vring_dma_dev(vq);
>
>         if (!vq->use_dma_api)
> @@ -3266,12 +3267,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range=
_for_cpu);
>   * Before calling this function, use virtqueue_dma_need_sync() to confir=
m that
>   * the DMA address really needs to be synchronized
>   */
> -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
> +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *=
_vq,
>                                                 dma_addr_t addr,
>                                                 unsigned long offset, siz=
e_t size,
>                                                 enum dma_data_direction d=
ir)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>         struct device *dev =3D vring_dma_dev(vq);
>
>         if (!vq->use_dma_api)
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 8b745ce0cf5f..cf8def717dfd 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -259,18 +259,18 @@ void unregister_virtio_driver(struct virtio_driver =
*drv);
>         module_driver(__virtio_driver, register_virtio_driver, \
>                         unregister_virtio_driver)
>
> -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *p=
tr, size_t size,
> +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, v=
oid *ptr, size_t size,
>                                           enum dma_data_direction dir, un=
signed long attrs);
> -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t =
addr,
> +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq, dma_a=
ddr_t addr,
>                                       size_t size, enum dma_data_directio=
n dir,
>                                       unsigned long attrs);
> -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
> +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t =
addr);
>
> -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
> -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_=
addr_t addr,
> +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t add=
r);
> +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq=
, dma_addr_t addr,
>                                              unsigned long offset, size_t=
 size,
>                                              enum dma_data_direction dir)=
;
> -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, d=
ma_addr_t addr,
> +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *=
_vq, dma_addr_t addr,
>                                                 unsigned long offset, siz=
e_t size,
>                                                 enum dma_data_direction d=
ir);
>
> --
> 2.31.1
>


