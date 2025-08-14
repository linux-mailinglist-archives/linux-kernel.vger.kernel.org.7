Return-Path: <linux-kernel+bounces-767859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F1B259E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B104680A97
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA2B17A2EC;
	Thu, 14 Aug 2025 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHCFK7EW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085272FF660
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142676; cv=none; b=bX28pz2s99F5znCOke575gOg+/xUhc/FOdRejrhbR9V1duCfThoomGNlnVhog42oXG9Ym6gwKORLgHsBh5kR4VAtVAyDstRNoubbKg0JHdlO8huVLE6PEMgOQfGT02E4HiJ+nfffBLK9FrNdCtAmFSwS0jwEc0XAlsJh1DsAToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142676; c=relaxed/simple;
	bh=ODVYxGfhnZVWRUX1W6Z3ukNvLzD/yM+NyITXKvEjiHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hv6GyPJi4Vkdl+QkPdGrqe+Xbj0dKxvRXzNtqY200Zi2AUHhIaDukfmycKgnnQ8Ri8Xe+6H81+P/pnON/5ov1kDn/uLHcu4ZsLaqsPyZK60G6PX5qORul/VxLNqUEZd7H9JTn8Y02wL8LVbRmmveorB65gcu9r0y98mf3ms6i6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHCFK7EW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755142674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71MVi3o5yr4/rX1l/x2yD3713Ae1dnEt8rt0hT91LS8=;
	b=SHCFK7EWhZAZPRwYBKuOi4CuQPoDwSpfXoppUEYTfY0jn6HBRG/Hkh8XAlBzDTfKX/opz6
	P8wg+xjwtO3QvbxWZcvgyEuoC0u3vfonR0/4igmZfP5d4pDvE/lmwC4P4HSHNFjn6Z9w+a
	5KDPurc1sQfZNcO79+tMum90aaoe83A=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-14DX6443MGiLCQTkTDuxmA-1; Wed, 13 Aug 2025 23:37:52 -0400
X-MC-Unique: 14DX6443MGiLCQTkTDuxmA-1
X-Mimecast-MFC-AGG-ID: 14DX6443MGiLCQTkTDuxmA_1755142671
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47174c8fd2so762470a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142671; x=1755747471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71MVi3o5yr4/rX1l/x2yD3713Ae1dnEt8rt0hT91LS8=;
        b=t/U7a8uqJqGmxbIC8lR/wPOMfGR8CEe2BMHjhMzy4NlvEibTuX06Z8KZtyQ/WqjVWQ
         AliAucUEB9OWy3llT6jzfRRBi5ROjXWLh+UD8xOf4qAIhSzVEx2WGw2jDPXO0Use0sRj
         WM1pC2iwKF7Uw16SVwiZhRZnC/E1N+WwDvTuCGAEuFHQ1TzDOsm+rstBJRJu/wldd8yj
         vH5YIsL3Xfr/UU/ovSNyfZ5GnpGxRnKnEKEZaY+yG2iP9+Uvu3M3NZbd5FdJLbd9ppJv
         /AiUjcEEa2pGQDErvCxG5iCE/16mAbSGeZfq3x9hpAnY0KliD38KOJyp3aT5HeDItUsV
         lxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0XYznwNK5c/saHyi7TTZ6dHRUpc77veGVHGe1kpcGMUtHF827pFHT5U5eHgB7d4cPq8bkECQHyRXePkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6P+ARY31GOmM7135/2YNCPkIZSGjsTvih4L+sZ+YgM8qj6Be
	nsrtGN/O7wet5rHXo9mt5+nKLj2CY2PgIg8W1cigoAMGJ+qv2aoJUmjNTbRjTWjFq7oK4zQbb6i
	ec0JWPsTnII3exRMtztCDqY/DWa+JGtgZPVr6/vm5IOTkuh6BdomZni4wcbtIbw+kcZRl8W55TT
	TzafqBlqqT3qOHlZIKi6TAkn7I7jWA7TSb+mniOzi9
X-Gm-Gg: ASbGncvUFXLc2rc2ZhhybURFO43lobaDVoHBNZG1xVYOg6wASZDqumbxhdXl86pxDEt
	wpB23IAFUNLFxy8u0nxo48BpiMuStxV5/J+dG/3glYiHvgVa7xXCWtDvtmS6HT1UZPgaPafwGzw
	kKv7BA9LHaAM0yxO1QhDjFqg==
X-Received: by 2002:a17:903:8cc:b0:240:79d5:8dc7 with SMTP id d9443c01a7336-244586e3c74mr23245495ad.46.1755142671519;
        Wed, 13 Aug 2025 20:37:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF203TRMVs/lgMYiSTXHuoYvkxDFILsRC72rZzKYmx/CNcAojWT22mJ6M9ytOYP/ptP7GBNCn7xeYRBHdNjeeQ=
X-Received: by 2002:a17:903:8cc:b0:240:79d5:8dc7 with SMTP id
 d9443c01a7336-244586e3c74mr23245145ad.46.1755142671092; Wed, 13 Aug 2025
 20:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-5-jasowang@redhat.com>
 <20250813045703-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250813045703-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 11:37:39 +0800
X-Gm-Features: Ac12FXya8p3BEZXXuB73dkzyerfUrbOxfG5IhoNRbKncLSzHg_MDGkUzTwIXeTM
Message-ID: <CACGkMEuyTBC-g27cSaENVFE5sZdEEb6+ydgYWyzanN0CcgPyzA@mail.gmail.com>
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Aug 13, 2025 at 01:48:26PM +0800, Jason Wang wrote:
> > Following patch will introduce the mapping operations for virtio
> > device. In order to achieve this, besides the dma device, virtio core
> > needs to support a transport or device specific mapping token as well.
> > So this patch introduces a union container of a dma device and opaque
> > mapping token. The idea is the allow the transport layer to pass
> > device specific mapping token which will be used as a parameter for
> > the virtio mapping operations. For the transport or device that is
> > using DMA, dma device is still being used.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 110 ++++++++++++++++++-----------------
> >  drivers/virtio/virtio_vdpa.c |   6 +-
> >  include/linux/virtio.h       |   7 +++
> >  include/linux/virtio_ring.h  |   7 ++-
> >  4 files changed, 72 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 482a268af851..fb1d407d5f1b 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -210,8 +210,7 @@ struct vring_virtqueue {
> >       /* DMA, allocation, and size information */
> >       bool we_own_ring;
> >
> > -     /* Device used for doing DMA */
> > -     struct device *dma_dev;
> > +     union vring_mapping_token mapping_token;
>
> For name I don't much like "token". and it's not just
> mapping right? maybe it is just union virtio_dma ?
>

It's not limited to dma, maybe virtio_map? (I'm fine with either).

Thanks


