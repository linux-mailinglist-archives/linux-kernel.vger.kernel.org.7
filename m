Return-Path: <linux-kernel+bounces-813474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7EBB545F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A6AA6ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8A926F293;
	Fri, 12 Sep 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw7lbyV1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE017BA1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667045; cv=none; b=AhrgyK6kIJdOzPwvQqMsVBjOl9l9/7Y5ea4yKYuKyQ9jhrpMFj30Tli8SVOz+gShqeHrNCB0Qk6896UwpnNZU+Ht1+s8R+gXaKSIgBIhx6XeULVtzmLVeQTIv1k2DMpojmzfs676ebRskygLTsMnF0Uj8ioAncDllIdZ8X42PDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667045; c=relaxed/simple;
	bh=eIehRNox/dG9Q/NjSvCbhxAAOwBQCzMl/Y+73D6b6cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4I617lAAdTH7l5nw1jTZ9RMCmT/ehemdegieTEDS2x7nQRiGMns2W8utGEFjQNbDhAq8jmx8RZLeiqprGRDlD6LYHRA2YPjsRYsrIVhmSKZo/WVJbkLnYkzF12FlCtD2vqNvYbazED7h1NJvIKZvSeJV4E3UvU+tCJfGSZTypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dw7lbyV1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGhSd8CvNyRTKzq49MHrvoxg5fRG/+TgxZE8XqY/Z/Y=;
	b=dw7lbyV1uAyUvQeBntax1lqec9je/V7K4z0hn4m+rei4jme5QqeFr5bG+oLLrRnKnxsbic
	7dkcHCag5IQEPQgn1An8VEF7XuPUaK30wcATMnsUoiOTzicV9fUFbG6TiGg8aMlTB5g4j9
	Y9n49vofSTJyfeOMcJ6W5hjFAp01uu0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-YGZtnQrCNKau7mr2K7lL0w-1; Fri, 12 Sep 2025 04:50:40 -0400
X-MC-Unique: YGZtnQrCNKau7mr2K7lL0w-1
X-Mimecast-MFC-AGG-ID: YGZtnQrCNKau7mr2K7lL0w_1757667039
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e7c2273e69so37343f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667039; x=1758271839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGhSd8CvNyRTKzq49MHrvoxg5fRG/+TgxZE8XqY/Z/Y=;
        b=dZ/QyHr/GmGJaLak4BvGQsqWLMc51FS01GJQOvsZImAgZaP+vAqQ0NsF67s4jIJbAu
         8lOf5O0N1ahz3l84fzIQDQEnDZ5r0vwtAstrdzUsa9o74togV8++GZDfpL3u/lyiuWmK
         9W7RcAkGd1DZe0ejUFawEMXBmRXLqgAz/7diYa53pSQksD+t6fChC3Wk40R7zjH5FX6a
         OsepV77ByCWPiKjGVSZ3yh0FlS9wZpm10ihoL/0WrEzwejB5Q7T/8HeKNDmsscUGiT6B
         njeIIiXVKisDOlxURUHsxFR0SvRXblWi9FcdvJFE8O8aNBwa5Tjx8x+3X9m0PyKahH7l
         7vKg==
X-Forwarded-Encrypted: i=1; AJvYcCUE2JaHdm0ML/8KrvUv7V1/MMRHjff5VD4qtbK8rBNj7TGqdbOK2dJLMtKOHMFN7J9c+6+A8BFPY0w/TfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr5IlnbMw6u1G6foaEa1l+Rb9cY0mCCbc7WJTArl6qIaTfPpSu
	kTsw1ILGspOAW1U/nCivF/MdCyadjkaak/Enb80SdqUzu2vaWLzhCdR3Imbd3aITN3wzLO64nbL
	6KPYG5T23DEAAj8OrfPpGQK+3vVMIYo8ymVOXQi6zitCxdhsq1TUJA+CRbGG08FqXuQ==
X-Gm-Gg: ASbGncs/1fLS5/RR48cm+70d9bEwzT07oMEndR3oSGdLoQPQHtXFjWGp5fdKhPvcapV
	e6VpDwMHL3K2jEFcg3EdgIq+NL6O9/KHLXeU3oYUSh0vrrPkgppmvf6aU94KR/B7nl8pYzlfUps
	4AcZMVDzEX9OLOdB+EXFtave3mAeB3Saof9HPRU/jz94uPg0DMd6CLoaL3arx7lMIzH7Iy1dUPr
	eDNAdiE9kTB9yfJ0VedOQaZANaJGr1jKk/ylPaloO6qzarzJZ7zmTRKskxCmJeaC3OurQ1AtHsN
	5fmOKq5u6bOTXBsHTy3CwEJ4KdVUYyL/
X-Received: by 2002:a05:6000:178b:b0:3e7:5f26:f1f3 with SMTP id ffacd0b85a97d-3e7658c0f20mr1991856f8f.25.1757667039440;
        Fri, 12 Sep 2025 01:50:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS2Tz/SulTKIR1f9nSWXhOdRDsMn29o7jRrHZHGh4hg8LiyfPRYgIJgThyJhmqJvpcfuVOUA==
X-Received: by 2002:a05:6000:178b:b0:3e7:5f26:f1f3 with SMTP id ffacd0b85a97d-3e7658c0f20mr1991827f8f.25.1757667038953;
        Fri, 12 Sep 2025 01:50:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7b42bdc5asm321061f8f.21.2025.09.12.01.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:50:38 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:50:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250912044523-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912082658.2262-2-jasowang@redhat.com>

On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> sendmsg") tries to defer the notification enabling by moving the logic
> out of the loop after the vhost_tx_batch() when nothing new is
> spotted. This will bring side effects as the new logic would be reused
> for several other error conditions.
> 
> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> might return -EAGAIN and exit the loop and see there's still available
> buffers, so it will queue the tx work again until userspace feed the
> IOTLB entry correctly. This will slowdown the tx processing and may
> trigger the TX watchdog in the guest.

It's not that it might.
Pls clarify that it *has been reported* to do exactly that,
and add a link to the report.


> Fixing this by stick the notificaiton enabling logic inside the loop
> when nothing new is spotted and flush the batched before.
> 
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

So this is mostly a revert, but with
                     vhost_tx_batch(net, nvq, sock, &msg);
added in to avoid regressing performance.

If you do not want to structure it like this (revert+optimization),
then pls make that clear in the message.


> ---
>  drivers/vhost/net.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 16e39f3ab956..3611b7537932 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  	int err;
>  	int sent_pkts = 0;
>  	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> -	bool busyloop_intr;
>  	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>  
>  	do {
> -		busyloop_intr = false;
> +		bool busyloop_intr = false;
> +
>  		if (nvq->done_idx == VHOST_NET_BATCH)
>  			vhost_tx_batch(net, nvq, sock, &msg);
>  
> @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> -			/* Kicks are disabled at this point, break loop and
> -			 * process any remaining batched packets. Queue will
> -			 * be re-enabled afterwards.
> +			/* Flush batched packets before enabling
> +			 * virqtueue notification to reduce
> +			 * unnecssary virtqueue kicks.

typos: virtqueue, unnecessary

>  			 */
> +			vhost_tx_batch(net, nvq, sock, &msg);
> +			if (unlikely(busyloop_intr)) {
> +				vhost_poll_queue(&vq->poll);
> +			} else if (unlikely(vhost_enable_notify(&net->dev,
> +								vq))) {
> +				vhost_disable_notify(&net->dev, vq);
> +				continue;
> +			}
>  			break;
>  		}
>  
> @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		++nvq->done_idx;
>  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  
> -	/* Kicks are still disabled, dispatch any remaining batched msgs. */
>  	vhost_tx_batch(net, nvq, sock, &msg);
> -
> -	if (unlikely(busyloop_intr))
> -		/* If interrupted while doing busy polling, requeue the
> -		 * handler to be fair handle_rx as well as other tasks
> -		 * waiting on cpu.
> -		 */
> -		vhost_poll_queue(&vq->poll);
> -	else
> -		/* All of our work has been completed; however, before
> -		 * leaving the TX handler, do one last check for work,
> -		 * and requeue handler if necessary. If there is no work,
> -		 * queue will be reenabled.
> -		 */
> -		vhost_net_busy_poll_try_queue(net, vq);
>  }
>  
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> -- 
> 2.34.1


