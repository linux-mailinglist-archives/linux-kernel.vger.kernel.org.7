Return-Path: <linux-kernel+bounces-748031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73F9B13BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1985F3AB805
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D52676DE;
	Mon, 28 Jul 2025 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3apBcto"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1F21A704B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710136; cv=none; b=hkkojBVhKx4Iy9cCHZjCaW2QXghYi1Oot2ORk7HjMOt013dony5IG23wcHfQjJUE9n4AyCxkiJ6WWXSRuBrHawe2xPRCzHMo8pI4u7GIQJfqopju36lFm9RsffCb1doHe8t6OtcNO4MJ/JCAqmkxhEknZHAuPF9RTxX2o553GS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710136; c=relaxed/simple;
	bh=Qi73DRoSdKFUDtg+GqUWUXH46IoLyNyfTl9cXuf39KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCGhSBi5tIQwG5PCikWzfMQEEsniDOcZwZe5M3+S9Etn07hmGz4KRTdV/SxxURJP53ThLAPur3mM1cuJcVx8o1Tq0H6PIJi5gAeNTohLgtBiH5V6Kbff97qNhSXI/Uc/Vch/Wpw4t03WltFPOMVvAj1iI9TGr7Dqt4FcQNiPbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3apBcto; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+z91P0F4/0V3P8rhqCpVUP3XXznNf+Eecy4UXi6zcY=;
	b=e3apBctoDmGLP9JFRSs8Ym5TdWp2J5pNXMbwkUEu79fCCEbt+9w+DjMtP9jGayuMAf52MA
	H+N/HzESGQ+ahT5M9Rt4RfXcvgSrzmwKSnc8mSNInWHY3QZN3vzjHwC3X5RxndOGdzBztx
	TGC53l4yYSVQDT/jVxSnUr1gQsEq8jQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-BYWfNwx8NyCDB1jS6pYNYA-1; Mon, 28 Jul 2025 09:42:12 -0400
X-MC-Unique: BYWfNwx8NyCDB1jS6pYNYA-1
X-Mimecast-MFC-AGG-ID: BYWfNwx8NyCDB1jS6pYNYA_1753710131
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234f1acc707so40705595ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753710131; x=1754314931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+z91P0F4/0V3P8rhqCpVUP3XXznNf+Eecy4UXi6zcY=;
        b=UbusmhgERPgkYRI5KqDBfae8NUcbS1LFs+QWzzecWrIP3Y7njlxbRfyHBFMo10d1GV
         W2Z54JcVw1AAouZLXPlQ2JhW2PXk+ayDEZylamZJHyzVs7RCSpsgkM7co0SQQ74/ysdm
         rsLldGinEs91QhTWLn0MzdFI52GD/1mOTn9hm7ui6JN+TYQ3dEIrfoTzJIMv1yGAcpFG
         SLzLa1SRKYFZoGaHnEh6gQPPCSXuqNly6BJdb+jO+4wFFb7IWWpO/2a0pZYhxqwlj9Ou
         yqjkPFQjZtPy8ZRgHeqsz2aK8EWeH96sMPs/RvDqn2AALpWUZ4fvoaE4rDbwydiEjm88
         vyiw==
X-Forwarded-Encrypted: i=1; AJvYcCVfZWt5Gs2xRDwkTn9JQLkx7oZFXaxYiz7XOnX9EGg91idVgz1MStFJmfPaqPL+qpaN+a/zVFd/L4414xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZydQADTkNrQCxCLhbzT8zelGS2Y3G9YkFi+EyOpvWh19nNYIQ
	h8M/cwqb8n3bMXaGqv0r879gNrmtVcOg0FdOuWf7n6gnW7NCvgSokoxjg829im89qe0sduRGTfY
	dGqIbh8D6LvdZq2VrWlUFeVRxniwgbrAmYkRf6KrzwhVWuyk32N8crX2aFSzduFhNtWYka4ivaa
	zf61/mx+RYqp16c5OEcOibkBR7eexChDl8fwltlh0J
X-Gm-Gg: ASbGncsR0SXJm8Y5uHnZqmOGKJBL296bieFL4mtfDztbV3x+O+E5/GWO7RtH8ApSbWI
	IMg2qGj9knbBE7xaHowdSLQAJxPIFn6huczwyfQ4C95P95dT10wuAcVvPh6Zft+SriS4stHCwzr
	y++0U6Bf/xajpyDrfQ9mQp
X-Received: by 2002:a17:903:1c2:b0:234:ef42:5d69 with SMTP id d9443c01a7336-23fb30995c3mr182209905ad.13.1753710130862;
        Mon, 28 Jul 2025 06:42:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHtpGSH0sdEHyiDtTCdyalB+5CXKfabmBBzxTMxNDt4pqkBUOeol9l7wFkRGUrlKlV1TFiSAWJviDOHFEHtNE=
X-Received: by 2002:a17:903:1c2:b0:234:ef42:5d69 with SMTP id
 d9443c01a7336-23fb30995c3mr182209645ad.13.1753710130476; Mon, 28 Jul 2025
 06:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724064017.26058-1-jasowang@redhat.com>
In-Reply-To: <20250724064017.26058-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 28 Jul 2025 15:41:34 +0200
X-Gm-Features: Ac12FXzUYMLeBVSoheOigrILsCXTJHp77xuCF_ZnD4KDihWoroctcgBEpSz1Kg0
Message-ID: <CAJaqyWddTABhmjGjvY5F91g1x5pN4MxCtPnsWt-3H=SqEKO4RQ@mail.gmail.com>
Subject: Re: [PATCH V4 00/19] virtio_ring in order support
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 8:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hello all:
>
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implemented on top.
>
> Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
> vhost-net/testpmd on the host.
>
> Changes since V3:
>
> - Re-benchmark with the recent vhost-net in order support
> - Rename the batched used id and length
> - Other minor tweaks
>
> Changes since V2:
>
> - Fix build warning when DEBUG is enabled
>
> Changes since V1:
>
> - use const global array of function pointers to avoid indirect
>   branches to eliminate retpoline when mitigation is enabled
> - fix used length calculation when processing used ids in a batch
> - fix sparse warnings
>
> Please review.
>
> Thanks
>
> Jason Wang (19):
>   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
>   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
>   virtio_ring: unify logic of virtqueue_poll() and more_used()
>   virtio_ring: switch to use vring_virtqueue for virtqueue resize
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
>   virtio: switch to use vring_virtqueue for virtqueue_add variants
>   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
>     variants
>   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
>   virtio_ring: switch to use vring_virtqueue for disable_cb variants
>   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
>     variants
>   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
>   virtio_ring: introduce virtqueue ops
>   virtio_ring: determine descriptor flags at one time
>   virtio_ring: factor out core logic of buffer detaching
>   virtio_ring: factor out core logic for updating last_used_idx
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: factor out split detaching logic
>   virtio_ring: add in order support
>
>  drivers/virtio/virtio_ring.c | 902 +++++++++++++++++++++++++++--------
>  1 file changed, 690 insertions(+), 212 deletions(-)
>

I'm happy with this series and it solves the abuse of the DMA API as
far as I know. As a suggestion, maybe we can get rid of the
vring_use_map_api function and move it to the vdev? It's actually part
of the TODO of the function, and this seems ideal.

This can be done on top of course, so

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!


