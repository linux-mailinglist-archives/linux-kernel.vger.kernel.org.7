Return-Path: <linux-kernel+bounces-766162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF679B24317
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9849117FED8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E62E2DC0;
	Wed, 13 Aug 2025 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuRANYR2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA72D836A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071289; cv=none; b=ropMM17PVaEwoGhvct7ukDX7K0O4rISSrV5R7TB1MhrLhgaH6SECzD+qUui7IWmigIon9sQxgd+HAfomOBC3RMpuiN4uapQ6oyUL6H/5x7kswYBwGO+prF+11zngEaZaJf86OM2imYSkKEZSyn8af6Zi6VSn/L/UX/qLDs62OZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071289; c=relaxed/simple;
	bh=Li0m0nEg3h+OWe/ICX5PDsk/tGlVW8FeOSB9YpitZNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLyEkhmezTJh3uPSVAlPQDIq7fAIgFFjeSqttoK3wPnewH0QLz/LghybqwUM4vy5xlrRX5khocmXCqlj18iiKqb0Xpg8zA177xvvhkXVb/ba+TOQpJeO2AJGA19SySIdz7RT6XwH3I14CgOnYMlYc12MdlStqLmQgsAjYKHRVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuRANYR2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755071286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kl1oltQNBdcY7bflfmWCksbU9W3EJNDDKAdZkMv+0SM=;
	b=YuRANYR2GC0mYwFNmm7GDyQQ8c1yZ4GlzugpwcbT2ZyskYHMnCo8nk6e63jK3aH0cco21O
	TROmiRrcpWPJfuBTVXGiB8Q6c4Oebvguw5k8J0/lk7mltAvVFN1S943CNgkUAj+dUtN95/
	4a6u+Nfy9N4oxPbJG0qCeHcUVBQuUD8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Rxq-hJZIPBi5Ql1ign6Apg-1; Wed, 13 Aug 2025 03:48:04 -0400
X-MC-Unique: Rxq-hJZIPBi5Ql1ign6Apg-1
X-Mimecast-MFC-AGG-ID: Rxq-hJZIPBi5Ql1ign6Apg_1755071283
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31ecb3a3d0aso6081415a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071283; x=1755676083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kl1oltQNBdcY7bflfmWCksbU9W3EJNDDKAdZkMv+0SM=;
        b=vLqLTjW4pBA+3Zln2t4HaPPikZH86zcXh4YRwFAZcsgZIEOakLIU56XKfAYzDi77fC
         MrwybY/jRFohFNC6WoIai2oDW68kKDtwTgskJcv6TETUP9VZDFL2RhPv24DYlbFDrZVh
         VibePdDgfUvekPct7NfeVAq1bHE48c5ZHPBXcJJB7XSyYyH3K13jAXN6aVWQMxwZDTsQ
         6OA9MayfJt7oqwZBpTu3/XxcoIsBQRL/yykHizRrG1T/8p+bjoDQpxoz5RhqRFvDNFDm
         5NUDjFgAmuqVfyE57Oqtt0riR0aIlCEB1sJoPfYveiFBQLCX3euiPIRZTB6CdzqeBoAz
         sKlw==
X-Forwarded-Encrypted: i=1; AJvYcCUioNXen/VtuG+WL4sf6XUxaMu57dBuGBw38Mv3yF8+IzbyUj0N4/eoZyHWnXvd7Jbx9jE6vjLHgQWYjrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxc9+J/iLvZy9VTFmiohlUH3hHDmDgNX11t0BG6ILqb3aQMGz6
	uVWd9vy/8imp5jY7Q9cWWcPYvsFiIRG9m6I8d9awoeqgFBK44KMXKmnwHzYg1jhulfx/2ap5QOt
	/hOunvtx/YBkuC416KPGVKwCSMtlkDmwBWMMH4r8wUcevQP0gkBv0l7ZvD8UhBs4f0UV5zOc3fr
	nZ0vUZtGT3lAIjp13HMRPQLpPtp5ZjqgTx7bA64sMf
X-Gm-Gg: ASbGnct19QeSe3ZB7vJstYcEX+LU+e4/92IDOKlNa3YbhLBzgZknqnfB8eFZiz0jGIR
	b+wFQZRMYPJsg2vNKbC8PahCYFbpaQOxVSlh9/7N2udcWSZOj6/Ggh9ku7tUY8Got2aM5EI40SO
	mxpX1gOPIKOMsEfxbF2A7/9tGmKSpSlw70SwiEG1a820XpNfS7QqHxsDs=
X-Received: by 2002:a17:90b:2502:b0:31e:cee1:c5e1 with SMTP id 98e67ed59e1d1-321d0eee53dmr1962322a91.30.1755071283274;
        Wed, 13 Aug 2025 00:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzZg5aAJxu8oHZbbZYEblznlj3j9+IG3S6lcFrXRSMg6BTTQS+li8YaIMOG59wemzWZuExSpHI/1K1jDrNOXk=
X-Received: by 2002:a17:90b:2502:b0:31e:cee1:c5e1 with SMTP id
 98e67ed59e1d1-321d0eee53dmr1962314a91.30.1755071282859; Wed, 13 Aug 2025
 00:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-6-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-6-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 09:47:26 +0200
X-Gm-Features: Ac12FXz6rbnL7HWYdmu-rLjYTyfD5WMOhqztTm1NI_Z6XsclKCE_ao53IAejFro
Message-ID: <CAJaqyWdu=V1AMWf1nDF8v4fZMnZGriRGeJ8ksOPLqNEOpRK5ww@mail.gmail.com>
Subject: Re: [PATCH V5 5/9] virtio_ring: rename dma_handle to map_handle
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:49=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Following patch will introduce virtio map opreations which means the
> address is not necessarily used for DMA. Let's rename the dma_handle
> to map_handle first.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fb1d407d5f1b..94b2a8f3acc2 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -305,18 +305,18 @@ size_t virtio_max_dma_size(const struct virtio_devi=
ce *vdev)
>  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
>
>  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> -                              dma_addr_t *dma_handle, gfp_t flag,
> +                              dma_addr_t *map_handle, gfp_t flag,
>                                union vring_mapping_token *mapping_token)
>  {
>         if (vring_use_map_api(vdev)) {
>                 return dma_alloc_coherent(mapping_token->dma_dev, size,
> -                                         dma_handle, flag);
> +                                         map_handle, flag);
>         } else {
>                 void *queue =3D alloc_pages_exact(PAGE_ALIGN(size), flag)=
;
>
>                 if (queue) {
>                         phys_addr_t phys_addr =3D virt_to_phys(queue);
> -                       *dma_handle =3D (dma_addr_t)phys_addr;
> +                       *map_handle =3D (dma_addr_t)phys_addr;
>
>                         /*
>                          * Sanity check: make sure we dind't truncate
> @@ -329,7 +329,7 @@ static void *vring_alloc_queue(struct virtio_device *=
vdev, size_t size,
>                          * warning and abort if we end up with an
>                          * unrepresentable address.
>                          */
> -                       if (WARN_ON_ONCE(*dma_handle !=3D phys_addr)) {
> +                       if (WARN_ON_ONCE(*map_handle !=3D phys_addr)) {
>                                 free_pages_exact(queue, PAGE_ALIGN(size))=
;
>                                 return NULL;
>                         }
> @@ -339,11 +339,11 @@ static void *vring_alloc_queue(struct virtio_device=
 *vdev, size_t size,
>  }
>
>  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> -                            void *queue, dma_addr_t dma_handle,
> +                            void *queue, dma_addr_t map_handle,
>                              union vring_mapping_token *mapping_token)
>  {
>         if (vring_use_map_api(vdev))
> -               dma_free_coherent(mapping_token->dma_dev, size, queue, dm=
a_handle);
> +               dma_free_coherent(mapping_token->dma_dev, size, queue, ma=
p_handle);
>         else
>                 free_pages_exact(queue, PAGE_ALIGN(size));
>  }
> --
> 2.31.1
>


