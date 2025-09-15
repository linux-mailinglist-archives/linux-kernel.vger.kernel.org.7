Return-Path: <linux-kernel+bounces-817379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C12EB58175
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0432B2041C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E7423FC66;
	Mon, 15 Sep 2025 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPKAIfnB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F222A4EE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952197; cv=none; b=klOobJ3Oza47z6Y5B3vaNHnzeWYVMe04JB7CSfvlivoZiQgq6F84Uypk8Tbj/+2apQSvEhMBYnX23CC9+n8BjkqhIJpX+LWtKOsSmy9KOPtfyoC/giZMTD1InrVVOocyZuYyTwCFdn4JqvkvSrcLeDwN8iO4bz7HpgCvsr09f3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952197; c=relaxed/simple;
	bh=UgpAiUSkfqsIiMi/5vuPzG4RqiLKzyDrVtzPJiZs6b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTy66yCBCxJcKqRBIH7koUjzr82l8Y9HOQ814kdlgRpzCYfRXxKIshNovRzSFrp2bOyt16cXT1UJKtl/AgHRdc3+uIMMyFA6jplkfgcA3/d/Jb3f3o36+2sr/A9s4DW9TSPJFB1wMCMFlCTqIdBL6GbfGrH3Z9S8JKGJDmTgXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPKAIfnB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxYYDZD7WvA8pBIh8RZ+XYWpfwg8m7Jck2wpptSqpfw=;
	b=dPKAIfnBBkSOZaiOxdGP1PiuyU56PTuZZY8Swx0Ha7AJPZgB7Lj+R09u6+IA/gZE/QebLe
	UnSi05Z8/e1sES4/87i3o9m3xEkGtTn29MOoE714t9URm3KTYNvlTu8RwGkC+TtuxvulOB
	p77eMs8vuQ0p2QzAmZF7AyM/6jTBtF0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-YL5Omkd7NLSsqiuzX7ap6g-1; Mon, 15 Sep 2025 12:03:13 -0400
X-MC-Unique: YL5Omkd7NLSsqiuzX7ap6g-1
X-Mimecast-MFC-AGG-ID: YL5Omkd7NLSsqiuzX7ap6g_1757952192
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-62ae827e496so3911974a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952192; x=1758556992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxYYDZD7WvA8pBIh8RZ+XYWpfwg8m7Jck2wpptSqpfw=;
        b=brTmI8pANyQQtzdBPo3j+9YGbRFvY2g7pOwL0DJYadrXV2usPkCqwDUMY6MiDTCorZ
         q7CZXsnDwLorEkIAUK0dC0LIRL1mCWdzw5lFgsVmIysrDpXLoEgS4JEJfTPUo5kmam5m
         RLEpuZKJyKn+CQbhuPSqEAWejL3vz846XkVvELD2kciBk/n3VInV4nIlqhcmYDwi3JE4
         8i2BOcRXyqopdIxZi0NdYr/laX3ZTOuKxnC0SeJjtiCNh3ZPxti0WDnF8F64vvxJvtQb
         LtHnVJTuNtuWXY8rlyWngHp+gYYfZLIJU2YSWCAUy0mlLWRML+Q8FYlfuMtAOzvKWeYK
         tfAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv56ii8l6LNIiT9gUAOMP+Fxi3Y1DSEGwETUk+45CqwzD/q4fh1J+Gnap45kal6JwiyE+2BC+tjS6TYR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx7vjkMYWSm71OTJxu52e/XObLnZF2ekv09gW6t8knlFX0smwf
	9eTE3hOJp0YyIzMpUkTVTlxaqtRptNgjZKXqOm8ACU8w4BcxfVfWysRkzcrvAkyF4HqWYo7dlM2
	vaF/RzsThK3hUQNGj9lCsXMuPUfdbFSOILA8fvuXhdcqYoybhp6uB08vUQIeajG4KIFyFggpwgg
	==
X-Gm-Gg: ASbGncsM6lkHCNQMaA7fMCryTXI8B+IIfZnOuW3dOSbemcodWvSpScD1Fe7cbu54BQe
	MgFgj+h9r1jK0hyAPc8QgYqFbWrnwT/hqlzzEP8L8kSc0ubi4B7+hJAUVzSAvmZHnWVMV8ssQg2
	0MGMSaaqTLIZHNwT9nttyOnevKdUOUzKtjqTibRMoxGvyJo7PSBnoAnbr9Ik7aXY7wxU2j7hcdA
	18fPE91+Il8gRnt21NHtLs9EQ6LPWhHBgeOqmGB3QTIChwGsBaanugnMsY/YimiTWFs9gr3VdqC
	6/scP1IZaY4jyHUizZQBCaMUs+gy
X-Received: by 2002:a05:6402:5c9:b0:62f:5cd8:9b2e with SMTP id 4fb4d7f45d1cf-62f5cd8a072mr216481a12.29.1757952191717;
        Mon, 15 Sep 2025 09:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjGn2Z0BOy+sfljpNHO+I5IXHBbdbcb8SYTOdauYndHQ59yMvvIQnAzpSL9eW6X/im0GKszQ==
X-Received: by 2002:a05:6402:5c9:b0:62f:5cd8:9b2e with SMTP id 4fb4d7f45d1cf-62f5cd8a072mr216441a12.29.1757952191084;
        Mon, 15 Sep 2025 09:03:11 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f454f4288sm1899363a12.5.2025.09.15.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:10 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250915120210-mutt-send-email-mst@kernel.org>
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
> 
> Fixing this by stick the notificaiton enabling logic inside the loop
> when nothing new is spotted and flush the batched before.
> 
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
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
>  			 */
> +			vhost_tx_batch(net, nvq, sock, &msg);

So why don't we do this in the "else" branch"? If we are busy polling
then we are not enabling kicks, so is there a reason to flush?


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


