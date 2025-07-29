Return-Path: <linux-kernel+bounces-748820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6917CB1464A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D35541D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2BA20D4F9;
	Tue, 29 Jul 2025 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiNgWKar"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309179EA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756536; cv=none; b=TbQcfjnNh4Eq4tk/+XSeVu6z+R5l+ocNRlV5gppCuukWL2hTsftnezWLKPOQQv1YCRViHsSsjBiY3TVJSJ+2Wr/TZbrx4jZg5hYH48sCP6oAlNvdGOJVAnhd8WVvm/TOAZo3H6lfybRxieVYQjf2T75mgrbeVgfFw1XtTgJS1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756536; c=relaxed/simple;
	bh=/HRnCcZbRcb+9UnZQVgZArGPTp9yESFm13pZNntIREc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDOo76Ub6TGhqn1IAdxHjHCPms80IHZqr2vcUiOIXnSdjOgwiKolyImVDnrrgb+E6RB6GYB6XMl5QsGs+AzyoaOxCjvaZsRSWQZlTyN/M1NB807xeVt7iYa8wTY11emNXcoWUn1JlpKbAsIV5eBkZUwsjZUbIp47TYIW0k2CfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiNgWKar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753756533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIZbtQ2slqhS5EM/uMEEbTpOOGP49cWRXzWaMjTHz98=;
	b=FiNgWKar3bd8jW+n4iYroNNbnXdIQZnPtMroHi4NQKq6qqXehKQclYFqP41ImcguXIEBvW
	MySdVj3dXhpfpv+sMbnbhM1Nf8G5cAmLMnwvQ0gFX1TlkiODc4HVHnh0LAH42qtQNS7gDo
	Mh1r/KbWzHij5KAJ28rsJ/HgaLwTe7g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-AMXu4T_AOCCNIkvC0jcrTQ-1; Mon, 28 Jul 2025 22:35:32 -0400
X-MC-Unique: AMXu4T_AOCCNIkvC0jcrTQ-1
X-Mimecast-MFC-AGG-ID: AMXu4T_AOCCNIkvC0jcrTQ_1753756531
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so8061734a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756531; x=1754361331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIZbtQ2slqhS5EM/uMEEbTpOOGP49cWRXzWaMjTHz98=;
        b=JOv/RZWeNbdU9hWd3bRwUBzxHYg8EHMutL+k7C8QpNcK4tYCNQRA+sA4fOWCf7rHQ7
         HsnPIgObH4AHpyeRPxVaD9p9+N4FPXJHdsmyIRxmoSwR5t6jsc9NVDmmgVnwW/5oIP8S
         FxU7dM/T8COabfimYgJ9dDmQQbM8FpN28YKD7jAs0m2ZtvuW9cYBAXjYmupMVEklYvBL
         1t4a3afH9lbZtbh+gN+N7+tgn82Z+wieO/Y1XTC+TGs/mBnrA6/9H2qoM3bvkNQhkMt0
         C6/qdAOEDNAM7IlR8wUcwBK0D9paeimvY4LAZwaoiAuM+VcgG4xaXpiXys0KTyevb1H6
         RMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbFGMVqUAVj1KKbrXk9h75ij5L1dbZYfkQn0+suuAOG0E5MUMCKTnnXumtPN/K112OrcZyDsDCd+BomPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze22RRVIyAmPjgRP+J2c0aj4X5jDJiYd00V669mt0whKaNZky1
	Mh8XUrFe3KHOjmgXnN1G88ssoiSBdxMrQvb9w7dp7HjK5ptxRFe6Wx3Ba/Uce2j3sNatYi6MwET
	tFgr1Adx+hTR4DX3SPu0TYbCuLbEpixoandQsBvWCSry1RIGes2w7Goqhom8X+IbKjnbKSwMZuD
	n9yxI8/KnLJF1zZlTGoib1qMWMItjz3jLIjCxs+92u
X-Gm-Gg: ASbGnctR0dTf4dMUq8QtTQR3q3g/pWcFq2I6qlTC39ou0fxbt08Tj/KZAmhOZdIn+CV
	bGhxlVyK/D/3T3ORnuay0+Jhjh24QKN6zgminimuoIeL1VX0FC4Tqia4almOjh/dTtkiHHpcfOF
	4uOeEZ35LVLoYSxoi2Mvo=
X-Received: by 2002:a17:90b:35cb:b0:312:639:a064 with SMTP id 98e67ed59e1d1-31e77afec2fmr20280651a91.28.1753756530820;
        Mon, 28 Jul 2025 19:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkVhn9W+WFyYhtsUNtXSblsyo22sgv8VehvQUpBc0h593QkX1IjQB6CHvJZiJD5dWDQF9Je+oR19Df3Sb6E8U=
X-Received: by 2002:a17:90b:35cb:b0:312:639:a064 with SMTP id
 98e67ed59e1d1-31e77afec2fmr20280619a91.28.1753756530435; Mon, 28 Jul 2025
 19:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724064017.26058-1-jasowang@redhat.com> <CAJaqyWddTABhmjGjvY5F91g1x5pN4MxCtPnsWt-3H=SqEKO4RQ@mail.gmail.com>
In-Reply-To: <CAJaqyWddTABhmjGjvY5F91g1x5pN4MxCtPnsWt-3H=SqEKO4RQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:35:18 +0800
X-Gm-Features: Ac12FXzp_K3lxtN6U2Qhjv41YpDpTlmP8AfplG3zvRlUK09iDW2x38sfF0CaVmE
Message-ID: <CACGkMEugov98y857bGK2CmbPVK3AiB5_USxm9LOPeVj7UpfpHg@mail.gmail.com>
Subject: Re: [PATCH V4 00/19] virtio_ring in order support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 9:42=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Jul 24, 2025 at 8:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > Hello all:
> >
> > This sereis tries to implement the VIRTIO_F_IN_ORDER to
> > virtio_ring. This is done by introducing virtqueue ops so we can
> > implement separate helpers for different virtqueue layout/features
> > then the in-order were implemented on top.
> >
> > Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
> > vhost-net/testpmd on the host.
> >
> > Changes since V3:
> >
> > - Re-benchmark with the recent vhost-net in order support
> > - Rename the batched used id and length
> > - Other minor tweaks
> >
> > Changes since V2:
> >
> > - Fix build warning when DEBUG is enabled
> >
> > Changes since V1:
> >
> > - use const global array of function pointers to avoid indirect
> >   branches to eliminate retpoline when mitigation is enabled
> > - fix used length calculation when processing used ids in a batch
> > - fix sparse warnings
> >
> > Please review.
> >
> > Thanks
> >
> > Jason Wang (19):
> >   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
> >   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
> >   virtio_ring: unify logic of virtqueue_poll() and more_used()
> >   virtio_ring: switch to use vring_virtqueue for virtqueue resize
> >     variants
> >   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
> >     variants
> >   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
> >   virtio: switch to use vring_virtqueue for virtqueue_add variants
> >   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
> >     variants
> >   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
> >   virtio_ring: switch to use vring_virtqueue for disable_cb variants
> >   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
> >     variants
> >   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
> >   virtio_ring: introduce virtqueue ops
> >   virtio_ring: determine descriptor flags at one time
> >   virtio_ring: factor out core logic of buffer detaching
> >   virtio_ring: factor out core logic for updating last_used_idx
> >   virtio_ring: factor out split indirect detaching logic
> >   virtio_ring: factor out split detaching logic
> >   virtio_ring: add in order support
> >
> >  drivers/virtio/virtio_ring.c | 902 +++++++++++++++++++++++++++--------
> >  1 file changed, 690 insertions(+), 212 deletions(-)
> >
>
> I'm happy with this series and it solves the abuse of the DMA API as
> far as I know. As a suggestion, maybe we can get rid of the
> vring_use_map_api function and move it to the vdev? It's actually part
> of the TODO of the function, and this seems ideal.

Right, but I tend to make it on top.

>
> This can be done on top of course, so
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>

Thanks


