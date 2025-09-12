Return-Path: <linux-kernel+bounces-813476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D978B545FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C13E7AF0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87326F293;
	Fri, 12 Sep 2025 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HevlWepv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C39017BA1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667078; cv=none; b=PD9SSsAvZVkO+Lkwg+9cXX727REUVpQ9P0u7EU0XjbL0v9F6hpP+pGhBuF2hET6FsbK/R3JZfj38TRWSVfz6t7uFlTz/DBGAKkiLBIJUNFiI/mcv3kA+r6F+T7S1NnWykcuyJa3uuRHrRmKaYmMbvbbilu7wAyFwqEHgQ8ShfS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667078; c=relaxed/simple;
	bh=47vQnPYhJDC8oGXmWGPzVRbfS0hchpXRA0GG7BlSkd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spquS7DPe4Vo22S10clZhvq2FjGfPICMUGjY7wigwJHZ8fQFu8LEtZN3bTq8prKrbr5VoHTl1BJBYfR5E2+rxeJ3j3o4DboRLooX2eTlIa7y7PnuFYyPPgkIvQ5IJH8sT12HWEOxwjGEat/Bew7rOhMcCfmO7W3fO+eSMFoCFO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HevlWepv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kMSCxiL40HDEAJ/S1kTvsHr28EdmEyCSrCl/4d+5lY=;
	b=HevlWepvgxJ88W9Ts9BuIqyl6X6wjaMuG53WrjpKj1/I3Qc/UEXkHIuwyKVj6Qj+uUIvTW
	W2JXDz/emA+hfvPRz/F0bAx+byGaNXUP7u/GRaPo0Z2W7sE084ti+4PJu8pogAKWVPdaXC
	8TxulreLS5JfcTQPkglxc4WkFDLble0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-I52ONs5APuSz3Ofoew4rKQ-1; Fri, 12 Sep 2025 04:51:13 -0400
X-MC-Unique: I52ONs5APuSz3Ofoew4rKQ-1
X-Mimecast-MFC-AGG-ID: I52ONs5APuSz3Ofoew4rKQ_1757667073
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e75fcdddbdso774775f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667072; x=1758271872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kMSCxiL40HDEAJ/S1kTvsHr28EdmEyCSrCl/4d+5lY=;
        b=F36UsHzsOjU1jrI+jkm4zxnBTSrZU/YkBvV/vvmiqbLzKtUTM8ug39fN8XVoMubsOJ
         qIY2HU7BcydrwmFCrh6euxDi22wBNRBY9RduyTCYcYhOfluiIwIgjD6m/7r0Bh58n0n/
         cAttRHKpNIzN3NIwKqp/gwwpibKRVbL5+sKt5XiJWzTJ8OoBn9cPMs0HAauHlYUKY5k4
         u2rv1Uu7UNyOqSpDM32d2/AcXUKVbETtQVK4Rw3IFMfK5mEa/mDps88DmHUmHdiqeM9a
         2411vdUVPIwnF0VRnICmTCREasDBWqVBdsXmRA0AtWZAn+vHYuMz432QFCi7u1v+P424
         fb1A==
X-Forwarded-Encrypted: i=1; AJvYcCX7F6tEKIhe4SebjjFIVyEkQkpinoeCfmIvUhsnYRXRW2VfCv6vJqsnnVrFrdiQ2AEDDzvDf+MBZyqlnNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwFId2f5oylhGVfYlQ+Hb6rubNy140V/hekLT70xyd5yxegqS
	qgvF42XnojjUAYkahy1tBwFYdO86CsMpEBwKX7XThAmZXOfln4ygxk2mMvdfU2zBD0wscBroCpx
	54+TViUdTbui+nXUS05MdoEf0eDgL+ZBFfe+QCrvPG0OkHYSgBCtYlKrBMxypUXHi5A==
X-Gm-Gg: ASbGncuCIbPs66MAtw5JpBy1eCI/fz7LQe7C9bnNj8etSwOxGHvLvxK9Lrta5VLPi1t
	TCvBNtjbyuwUDzMUzC/QhVbueFqqlgU9OBZ8gPPxDHM5Vs0D8QkaZvQmTInciCB0rywG21LheRv
	nBa7x2X25AJt4j8JcLtrGk0MlGaPxSdNuX02OBK1M7fv0AAs6Trbl9CfWTVfw5wy0eEbRTFT9gy
	yhCoUT4q9KrcC64Esl5oMc81znxw7hV8bQzSlXGMWyk54mmpBj5XzPbblpg7/LetRPRTiHTtGPt
	1Vp5lWGZTKiSG3jt6PPgWUVW+2hr6ItY
X-Received: by 2002:a05:6000:2407:b0:3e3:24c3:6d71 with SMTP id ffacd0b85a97d-3e76559415fmr1647254f8f.1.1757667072458;
        Fri, 12 Sep 2025 01:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ2GT21YnVBh75Wd3k+yoprEvCJQn5G2Y8wrMGySDHgCshlINWqkn9hIrIH8egTbTA2leqKQ==
X-Received: by 2002:a05:6000:2407:b0:3e3:24c3:6d71 with SMTP id ffacd0b85a97d-3e76559415fmr1647225f8f.1.1757667072042;
        Fri, 12 Sep 2025 01:51:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e41b6dbdbsm40474885e9.22.2025.09.12.01.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:51:11 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:51:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] vhost-net: unbreak busy polling
Message-ID: <20250912045102-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912082658.2262-1-jasowang@redhat.com>

On Fri, Sep 12, 2025 at 04:26:57PM +0800, Jason Wang wrote:
> Commit 67a873df0c41 ("vhost: basic in order support") pass the number
> of used elem to vhost_net_rx_peek_head_len() to make sure it can
> signal the used correctly before trying to do busy polling. But it
> forgets to clear the count, this would cause the count run out of sync
> with handle_rx() and break the busy polling.
> 
> Fixing this by passing the pointer of the count and clearing it after
> the signaling the used.
> 
> Cc: stable@vger.kernel.org
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c6508fe0d5c8..16e39f3ab956 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
>  }
>  
>  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
> -				      bool *busyloop_intr, unsigned int count)
> +				      bool *busyloop_intr, unsigned int *count)
>  {
>  	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
>  	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
> @@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
>  
>  	if (!len && rvq->busyloop_timeout) {
>  		/* Flush batched heads first */
> -		vhost_net_signal_used(rnvq, count);
> +		vhost_net_signal_used(rnvq, *count);
> +		*count = 0;
>  		/* Both tx vq and rx socket were polled here */
>  		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
>  
> @@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
>  
>  	do {
>  		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> -						      &busyloop_intr, count);
> +						      &busyloop_intr, &count);
>  		if (!sock_len)
>  			break;
>  		sock_len += sock_hlen;
> -- 
> 2.34.1


