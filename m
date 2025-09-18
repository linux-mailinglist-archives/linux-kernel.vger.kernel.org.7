Return-Path: <linux-kernel+bounces-823039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99AEB855F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FAE1C84100
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9630CD83;
	Thu, 18 Sep 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aG5BEIEQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945730C637
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207153; cv=none; b=lCh4odzhDMezbuZZNAg/QKL5FE8e0Hh3jzYBXXZCWIFcZl236xaOnI2vUI4BEP02WmfZSeqI2tPV4xyNGYy4ABdLSXF2zx5ByYVSGnUJmQblpdfvYXM02sK35s9njvH+E1Og0yi8S4N5tMqzLIp6wXHkUb4NJD4yAW9R7sCePd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207153; c=relaxed/simple;
	bh=877fy4JwCj6Yt7dwkYYuI8E/1ziIUPjIl8VIeeaY+04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV9ILYsZT7DCLPqqlkce5na2UTS4iuWV1yGRVZi5oP7gyvA9e0Zc3ldKs5cK4nH+b9k0GEz7vOZt4i5zu50m9poI0n3kfQWHufvVAMySGaZzJ6xdtSvpGDWdcnsJBQt+bbGR3AMd3trJC9LBoqlkQ4a8joApsciBa9LBn9uPlhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aG5BEIEQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758207151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4xuHLo8yzB0A9DafNx4LR5vIcuDhtQe+LRGJvMc0Qw=;
	b=aG5BEIEQROVfBVBkRun5Np22UmXKjkOb7semsa5Lp25vGmHzc93sMaI8HA25VIdVyyvjVu
	VdB8X/QM1bT+bzZ1iKfOiTCLu5v5WJRrFDZ9w2kPnS3wH5JRGHzpCd9/VpcY/OVMnkwgk1
	sJW1LVn2/X5qKxBACNcA6UpPXimQRwI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-UnUbATGHN2mrL46dZjM-ow-1; Thu, 18 Sep 2025 10:52:28 -0400
X-MC-Unique: UnUbATGHN2mrL46dZjM-ow-1
X-Mimecast-MFC-AGG-ID: UnUbATGHN2mrL46dZjM-ow_1758207147
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso9795115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207147; x=1758811947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4xuHLo8yzB0A9DafNx4LR5vIcuDhtQe+LRGJvMc0Qw=;
        b=sbkzxAf9tx2JJ2MBHgV8XliIJb1Eqyuje/FDfDARWVII0qdRcf1eETRE1PX/BoFAOd
         10a/deHgteZFkztRg/8cuumikWOrrJLmlpbPVFt92whu0xd5I8NGKiEA4pqvewc5XQK2
         SZi2I3fEQkZwqqJdsxOSqVFuEldsrufk/C0GnFA5QuGSf9PXnTcx+TdB0SpQHFksSiB0
         cYtrpKZOQ6m6q/LaMR0ZBePzoCA6AF60hvcs3Oy9xdxoh57uO9KdpRE/khHeANFfqnTP
         H9jBBYkKzr6ptPSDRhnIkQuRvs+SltdDqRGuGyyNctXASG3y5wTrGviRq4r5SiLbuKJs
         VeOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQyPW1iGeKMdegsuUNvKLaThkZ55EmI96NFjkIswd/zeR7tp0YQ+CSigVvr3KAD6zNx6JTf+ti4dQBqjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJ/Twvo70GcJw+rwJToMgUHEd1aBB7bsZmvlsS7+Yjjufnz1f
	oLsbMYlS4cEc7gQndECxTygxqzT1+KICIXfYkLhgJoxnn3KgQ3jDZ4Jm95P2x1RCPu50G4GITVy
	V4t+Oe2oYfNTppuPeQ6wgx3z5MhbAHF5qvqmbR4GBnl8/GlnCAXn33vlOQa1qfIC7Ug==
X-Gm-Gg: ASbGnctL+NUtN0pu0XrZSmpXo2k8PWBc4ZWUy7QtxX7dSf+K6ALXjnckxbIXbuVrN4e
	YAX9UysKjIv8vx32Ag7fKBln+9LJQTQc4ObzmnH3/aOjdNaA40H4YQJPwi05gU58/oxwUuC4Ttf
	pF1QRtznaRdBzJf6lhgJmbAn68VQU3/pwOkTydPZ2/H0a7b5JDOlMoxiErCls7ty40jtMocuvEy
	UrYZuwlpNAskvupYZm08gn3JHriQDcJBIbUjvUsE7xf1d10Mcu0j/HlISD3RlsrG4GDJfTOOZod
	3Cy3uEB3E47mknEkfIVKPcf1WyPq+/O+gww=
X-Received: by 2002:a05:6000:430c:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-3ecdf9bbb14mr6283929f8f.22.1758207146770;
        Thu, 18 Sep 2025 07:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqwMRBHuFFqMWYMrzOGs/Y1LvHSUdwEyMMdSeQZSTNEKri6ViSDAyQsaqS+nlL7xHwrs2MhA==
X-Received: by 2002:a05:6000:430c:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-3ecdf9bbb14mr6283908f8f.22.1758207146339;
        Thu, 18 Sep 2025 07:52:26 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32083729sm61479685e9.0.2025.09.18.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:52:25 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:52:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH vhost 1/3] vhost-net: unbreak busy polling
Message-ID: <20250918105037-mutt-send-email-mst@kernel.org>
References: <20250917063045.2042-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917063045.2042-1-jasowang@redhat.com>

On Wed, Sep 17, 2025 at 02:30:43PM +0800, Jason Wang wrote:
> Commit 67a873df0c41 ("vhost: basic in order support") pass the number
> of used elem to vhost_net_rx_peek_head_len() to make sure it can
> signal the used correctly before trying to do busy polling. But it
> forgets to clear the count, this would cause the count run out of sync
> with handle_rx() and break the busy polling.
> 
> Fixing this by passing the pointer of the count and clearing it after
> the signaling the used.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I queued this but no promises this gets into this release - depending
on whether there is another rc or no. I had the console revert which
I wanted in this release and don't want it to be held up.

for the future, I expect either a cover letter explaining
what unites the patchset, or just separate patches.

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


