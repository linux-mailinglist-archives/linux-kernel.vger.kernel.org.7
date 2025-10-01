Return-Path: <linux-kernel+bounces-838795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6338BB02A6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CC32A1D07
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516FE2C3272;
	Wed,  1 Oct 2025 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6RCiEaC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE52C21C1
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318269; cv=none; b=IhR/DYugGQBRNuyfAc2kOYWzwl9IFhsOdlsWA4JwGq46nkfaI/HjwOZ2J9BtyZkKWVexo3cN2F/KOVMPhynvyjKLL14WYHGSj4gzlKseslZddrtQ+6JzlYppMLK1mgvpaVXFCdLQgecE0ut6VxWe/iO6dGScqlWLFqlCtlvZ7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318269; c=relaxed/simple;
	bh=+ntO8IhcLjUfgG3Tl85pJSQjIsj7vcYuQlV24Iuh4lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX2udxRjQrjP2e86SL3HIut/fO7aXunP929gJlt3bIlloWPIOwr0bbvOEzz14GTagk7Mx4ph/ra8Tfk8vWkvZBEGzevLXZdR+GSPQv5Y1HrY24WvKHBUlOP0g4QJp19rvebb/DZSu3HiHnrRZiwrsnsx1+i/IVJlJ9LJOjktbEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6RCiEaC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759318267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjn0YAp/S91LPcD+yCLO1GaiQme1ryl9SDDHJbufKoc=;
	b=V6RCiEaCBq4Od7BraAtXsJ+XeykoKVASFYa7APbrSeYbXEu2Tojm6VF0iqRKPlP4MsWir5
	IzaBzQ1gtMqdhwcG3g48WH/l/swALBYYFJqCOMY+ZPutwNvjIjFohlINIaBimzSRybrid9
	5FZJ2k1WrxQmrSuGPaGu65yQjDR2BH4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-1B0Th-37NoCq8mg-t63IAg-1; Wed, 01 Oct 2025 07:31:05 -0400
X-MC-Unique: 1B0Th-37NoCq8mg-t63IAg-1
X-Mimecast-MFC-AGG-ID: 1B0Th-37NoCq8mg-t63IAg_1759318264
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e3d43bbc7so28985185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759318263; x=1759923063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjn0YAp/S91LPcD+yCLO1GaiQme1ryl9SDDHJbufKoc=;
        b=tyacVVi5p2eRZ4KpIu/jUTsAgOQwzNOt/X2LXbBQDYE0jA9U/ELNIuYeEobA68LOmu
         lWjv9+m9H8ybemrrXbJVSPNTx9Mm7Unpb6FZhRhPVNJaEzUJUgT/1GbqgvTg0j8aSGUD
         snzXRhSSR8Y63lbIazj4+sOQzqdMCjaNuDNFDaVWKVWT30WNxE+rAH9zYokCKj1y3qoC
         B6qp4j1x7Pc+Pw9w9Q3BJVoBAINMxjhXl991ROu03v9HP3eCnbShh3KASReJpCvwKhry
         Zp1C+d9bEq1vS05gSyG6XfTQbvyW+/ZJ6YZmoDAeVPuLz7Ve4FJd5JYEAeFK/N/zhfJQ
         BuLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnsGzyhHYhn45+TGgIUWm9BYv5R8+aHLMntvgnc/03SroJsWyZoT6AGhui5vni2098PFxRV9l5Ar1Jp3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3721Us1bEpBIPy8+Uck7WE6B9tIsRZ7AhdBpXFEiU46JDBIw5
	NSRV+Eh3e1U4R3vYmwXpAVyuxJLxEUPCjdYMhMsA9t5rBBugoojCyEDyOyzd3T2mzl0Ys7oRCx7
	MEJI92pwBsVpXa1/aysLaaGsUpd1xMS3gSD8idtp4zv/RsQVMrAXDpvIs0JEqFrSQlA==
X-Gm-Gg: ASbGncvbUmqLueh26Bt25RijEVeB0quvxDrYcfkFk8UlMH9xHxu0R6zF/jCwdbnUg45
	snJIp/ZT6kkTFoFPvfiRnn/5MyUUAb5DZ3QbOy0XQot9/MUnOrV4Thiuuf4517VHxxTfYnTjwyu
	Etcyk98qZHZwtLcnoXHTsFh6Lny20NE75r2YIBDXyLz0n7fsJiK9S+Gl/aAy22X4LHypjlg3pcN
	pCAdTS/gqUlCzMfpsTwSITm/GJ9lzDAzCDEu2Fd2pcSLOVCAt0ZEQTA1/7O8GzBE3t3xi//g9t7
	oaAsQvnMfnLVWCzaZwzHtP5jNjqnjuUXwNpSGIg=
X-Received: by 2002:a05:6000:24c6:b0:3e9:978e:48fd with SMTP id ffacd0b85a97d-425577f056dmr2450936f8f.23.1759318262726;
        Wed, 01 Oct 2025 04:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5q08sJLCfUBTyxM3ZcMrLPFKvZgNXOAzaBU2ckt9yIh/nxyqNXUMtFwGdm94iF2nTmKPT4Q==
X-Received: by 2002:a05:6000:24c6:b0:3e9:978e:48fd with SMTP id ffacd0b85a97d-425577f056dmr2450911f8f.23.1759318262213;
        Wed, 01 Oct 2025 04:31:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619ad9c6sm38124855e9.16.2025.10.01.04.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:31:01 -0700 (PDT)
Date: Wed, 1 Oct 2025 07:30:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 00/19] virtio_ring in order support
Message-ID: <20251001073020-mutt-send-email-mst@kernel.org>
References: <20250925103708.44589-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925103708.44589-1-jasowang@redhat.com>

On Thu, Sep 25, 2025 at 06:36:49PM +0800, Jason Wang wrote:
> Hello all:
> 
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implemented on top.
> 
> Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
> vhost-net/testpmd on the host.

Jason can you pls spin v8 without patch 12? I think I agree
it is questionable.

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
>   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
>   virtio_ring: introduce virtqueue ops
>   virtio_ring: determine descriptor flags at one time
>   virtio_ring: factor out core logic of buffer detaching
>   virtio_ring: factor out core logic for updating last_used_idx
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: factor out split detaching logic
>   virtio_ring: add in order support
> 
>  drivers/virtio/virtio_ring.c | 892 ++++++++++++++++++++++++++---------
>  1 file changed, 681 insertions(+), 211 deletions(-)
> 
> -- 
> 2.31.1


