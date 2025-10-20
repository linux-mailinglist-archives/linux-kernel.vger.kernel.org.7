Return-Path: <linux-kernel+bounces-861205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3774FBF20ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D85204E7F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5C22147FB;
	Mon, 20 Oct 2025 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9NLs1FM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7707A7260B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973562; cv=none; b=RfyHudmaVOvAy5IDtRISnFSqg8DiSh95KhOqw/OXC4aGm9oS+b3LDwokHm/XpWaNoXunh+B65z/gNsjbJLj1HboysBTOAEqb8cprQM6BackbEFJvNCYpGly+kKup4SekZvXP7fLFQONsBiA4VDCWVMIIyd0VEQC6dFbAguU3FkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973562; c=relaxed/simple;
	bh=UES3fuoTB2ke08i+4mK7KHAjMOlzq2Bu3GI/IW3cul4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPvYMaZ7OMl8O5xuTGtMFt59FYGWX/fYG4cDjLuZNBMDKmaKHLBkoCZcncosUF3RUDyXm+v32EW/4dUcyq5ct9OnFNF4GyoojpjJjTb8uaip9RVXubvtL0MSOddhcdOPpnXDpMPBFUo0gEvCOopaA4p61WnlLFhFNtp9vd+1CwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9NLs1FM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760973559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VzCuiv48XnVTj0yJ2CgCK8h1WFJ+MXvGeTMMKT28eU=;
	b=a9NLs1FM2uCR/UucS9DKj0do3F02+wWNjNUT1R74RLTfl32tmZLy2uJpA3nZPj36TocLP5
	RoNc51AYL1twTfGLEe221yy17uRlJFju4BErHXeu1fYxXkQsiG/RIGArAe/ZV5V0S4cxjx
	obNWdDdaTHegmP6Rz4ZSEs9QoFkOavs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-pGAKO1uIOZmusrn2q07-KA-1; Mon, 20 Oct 2025 11:19:18 -0400
X-MC-Unique: pGAKO1uIOZmusrn2q07-KA-1
X-Mimecast-MFC-AGG-ID: pGAKO1uIOZmusrn2q07-KA_1760973557
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-472ce95ed1dso10140565e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973557; x=1761578357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VzCuiv48XnVTj0yJ2CgCK8h1WFJ+MXvGeTMMKT28eU=;
        b=JCx3ZIMSFDxtnlZ1kxak9tho9AnKlKOi5NIC7LBaS5Y0ft6C46ugCKr76CATvNxr9U
         3OZ+dRo6GiOMQ1L+S06DRuqIQxWBoC4uAcp3J4dSwTTRn0iJPzmaucqQd0H65QwO9lJm
         K9FMSEEeYuQwZcwGseMIhuV0LV8DP5iOE3oC6+FdddJ1Gs8maoeVc9SCVpfiIvW1NLkc
         2C+G6h81m6mD5LZ6krA6MuIwl0yg+u9aoPKcRnUz5mem5QKElwiYa/CveSZl1Mb07LgC
         sSu/CuYT+4eiueddXZVyGOH6ovALLvMbdSqRK3x7VTST0WVI1bXOQ78vI7OmEOdMhCSp
         tm+w==
X-Forwarded-Encrypted: i=1; AJvYcCUs3W8BSXr7tfZmntyuREtpZDNeSrluU+N5PpPHmDdAxb7DFBNa17++V7oOVofk6UIYY7mnZOxr8h+syOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/C84c326T655RyZqC+MoiMaH+roroqDmuCdBG9ga33VmyyJj
	0/tteaGPrG4sBcbSnyTzy9080oFwa1Gi9X1wbq3EMlZ4RNEzMAofAC5Jk6XWRmV+3dTebKmpa2P
	Iw0A/Zzcx/9teNZL3L4Kipixdq9/CAPvCFZJHvPQRIahg1zHYqhvJfZ+/3lC9nNtHTg==
X-Gm-Gg: ASbGnct6vA/Vk1Uxbz/UJbA+hb0Up4BPk829BNQiDx41YuhnAUkSOm7HmQAQe0LJ+Ms
	JfwyYhgWGOELq05U1xFiAeKeHggJIUDdEAucqXqR4MlHfTuLu1FFnSyBpwSePiHJq2qfwkla1nv
	P4EhqRPXlpog1ZkAWPUpG+q3CabcnyJ0XlRtqpOcmbpVUKyDx1ksUCqrZjOGR0Z/+ORiP+rhyx3
	UWsBBYYF+9Rrnn8vRUrkLJofJwfuQcxNcF6wb84iogtmicIGiVuzQbpSCoFTjSh6EA34hqatKc3
	P0kfG7/adt1u4rhVajjeUae5WR+YzYKNmwm9QreZRW9AtMx2nlnQ1q/I54hcivlP5w5V
X-Received: by 2002:a05:600c:4e8e:b0:471:a98:99a6 with SMTP id 5b1f17b1804b1-4711789b11emr92630435e9.11.1760973556714;
        Mon, 20 Oct 2025 08:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI1dWATaMCNt1gTcEgwdzlqSdzz40gvI3CnKScfnNKuceA65mZfM4HYKBIw5XIwuXHTBVfNA==
X-Received: by 2002:a05:600c:4e8e:b0:471:a98:99a6 with SMTP id 5b1f17b1804b1-4711789b11emr92630175e9.11.1760973556196;
        Mon, 20 Oct 2025 08:19:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce08asm15711045f8f.44.2025.10.20.08.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:19:15 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:19:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 00/19] virtio_ring in order support
Message-ID: <20251020111824-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020071003.28834-1-jasowang@redhat.com>

On Mon, Oct 20, 2025 at 03:09:44PM +0800, Jason Wang wrote:
> Hello all:
> 
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implemented on top.
> 
> Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
> vhost-net/testpmd on the host.

This is much improved thank you!
There are some coding style comments worth addressing but
I think we are almost there.

> Changes since v7:
> 
> - Rebase on vhost.git linux-next branch
> - Tweak the comment to explain the usage of free_head
> 
> Changes since V6:
> 
> - Rebase on vhost.git linux-next branch
> - Fix poking packed virtqueue in more_used_split_in_order()
> - Fix calling detach_buf_packed_in_order() unconditonally in
>   virtqueue_detach_unused_buf_packed()
> - Typo and indentation fixes
> - Fix wrong changelog of patch 7
> 
> Changes since V5:
> 
> - rebase on vhost.git linux-next branch
> - reorder the total_len to reduce memory comsuming
> 
> Changes since V4:
> 
> - Fix build error when DEBUG is enabled
> - Fix function duplications
> - Remove unnecessary new lines
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
> Jason Wang (19):
>   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
>   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
>   virtio_ring: unify logic of virtqueue_poll() and more_used()
>   virtio_ring: switch to use vring_virtqueue for virtqueue resize
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
>   virtio: switch to use vring_virtqueue for virtqueue_get variants
>   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
>     variants
>   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
>   virtio_ring: switch to use vring_virtqueue for disable_cb variants
>   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
>     variants
>   virtio_ring: switch to use unsigned int for virtqueue_poll_packed()
>   virtio_ring: introduce virtqueue ops
>   virtio_ring: determine descriptor flags at one time
>   virtio_ring: factor out core logic of buffer detaching
>   virtio_ring: factor out core logic for updating last_used_idx
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: factor out split detaching logic
>   virtio_ring: add in order support
> 
>  drivers/virtio/virtio_ring.c | 905 ++++++++++++++++++++++++++---------
>  1 file changed, 692 insertions(+), 213 deletions(-)
> 
> -- 
> 2.31.1


