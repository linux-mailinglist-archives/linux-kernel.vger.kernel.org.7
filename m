Return-Path: <linux-kernel+bounces-652898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6C4ABB1C3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 23:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1783B1EB0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 21:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8980620A5F5;
	Sun, 18 May 2025 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZr1rOfb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4F1C5D59
	for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747604313; cv=none; b=UP5Dq5BHu9eIzNGYnoc3uFvqYiMcOJZArY3h4zQr4cvP8noZnUjhIoAvG7eAYicu3PNTp8FmsekXlLIKx6ToXqJosE24lwAw32fGenr1EPgyQuhv407ih4KmbssoWKH3o98R54UFcYYPP/Z4cvgSQtAT0ZdjFHt6OnJlsi4aSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747604313; c=relaxed/simple;
	bh=IY5YxUgfeivoNaGKuPIC9nYUq6Yn5iTNzaXtAmgFxWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP0zkn6+9ZXG2NOXvEFbQiYW3SrWVmyxrXgpx61hGVzsnJeKBkdSbY3JiMEL3Xwgr8La/5lzVlrN2fqUhKJy7BBoGD+njExhRjiWPi+kw23ZLJG7BmPR4e5R55FRmcwe+tQdUx/OFEs4s61KXmSrtIXMk64iEEo2fD06YtVirPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZr1rOfb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747604310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2DxfFVVppWL2QDoeVADckrWoeG/v7XssiZgeHgdT/vk=;
	b=UZr1rOfboB5AypuAyhh5MGYPeKBw3dKb1JLCbgJ1lA4sqMyrK72mKUngXF3K3to380hlfl
	jEkE54ecCs3MvSVBMdbk3m8BSdbNln/8nXISQ+zaVT4W9uF825e3BGy44ePaLyq0hyJZl5
	Qcgq8EQszsXSpHlzRcPN14cgGfp6PJ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-OuBDW38fO2yVwUHWs48W7w-1; Sun, 18 May 2025 17:38:28 -0400
X-MC-Unique: OuBDW38fO2yVwUHWs48W7w-1
X-Mimecast-MFC-AGG-ID: OuBDW38fO2yVwUHWs48W7w_1747604308
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442dc6f0138so21146335e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 14:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747604307; x=1748209107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DxfFVVppWL2QDoeVADckrWoeG/v7XssiZgeHgdT/vk=;
        b=cF9WV5NiVQaQkJQhBMbt1gy/C1U6WUgjOydll/Uhzx02sxX2l1NgFNi2d7IbkeqXb8
         /vsWrFZnr6k5irsEuvWP0MsvMAR54KoYMKOEZmobvpxLpqD5tW5e/8r0HfORylgJ09Ib
         gSF7h6ki3OxZSb3Bc1wwOnZOAEWOBFpvsKa6pEwogVeC7dik68qUO46H9fvdgPd9aen4
         1on8TPXzWonvd1PZRmNJv6sFuTN683PqpD0UrJWDunqm3pd6PYnOj3wd0zrQkrBkHqSo
         f3YQSaEa+cNGTrDSj+ToiGt4bxAqDnCa5L6J/u5uob/YRCwjlxuQN5nXW7MkcF71Uqbv
         a2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWW8QCmDU0yhfp4OOyDADuSnnnLVJgsMQTs9VeNPEwh8eJUtjOYQwe2JECJYZUGKBYpc9RZRhR/r9pCS6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhf6//hdYTFM31OYprDn05Y6t5nP0uAvtPA/1GDUTEnJyuA6Uh
	cYq1oSPNgz8h9GWBObonnYjarxNXmYG8FZ47/dt7kIXRr87nrwOfc+b97FSydm9wGJtRaU+kF2r
	TqqzuWq/Or4RgvMvzF3sWp6HuHDyid3lnFRKAKKTI63GzOFHjLiPZGcamLWv1aBjz+Q==
X-Gm-Gg: ASbGncuzKKR5D5DnX0YXt/e+gKjeNIk4pHNUGx+KPxeKGNTOtcfn6dvFuKF1gIuFZWy
	G368Oytowr9+B03U81WgQ6R11ZTacLtXQ9HTww/QUVCnNcjR9qPITwCzLisN7DxQBfHs2qb0IWp
	j0/QH6QJXKTwtoSc7D0/YFUYxeJGIpOkxugCskv97KLg3MpWk+HWYRu6OHf5eaiDfmZ7zMroJiS
	OhtmRGdfE0S0ntkdJRZNi28AmbhQdqEmWpoDHN73XV0XiI8z5WpCu0an4JsIjuu7Y14k/bNTyCp
	UWyJqg==
X-Received: by 2002:a05:6000:2a4:b0:3a0:b5ec:f05f with SMTP id ffacd0b85a97d-3a35c84bd9emr9695879f8f.39.1747604307626;
        Sun, 18 May 2025 14:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPvcQqiUdzhpUsTAuhZDZDZTf1fjEgpPyr6jPbRPZ5J04iBfqTi3ZNActvJ+NaYfNQu9hbkw==
X-Received: by 2002:a05:6000:2a4:b0:3a0:b5ec:f05f with SMTP id ffacd0b85a97d-3a35c84bd9emr9695869f8f.39.1747604307288;
        Sun, 18 May 2025 14:38:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb85bb20sm131025615e9.0.2025.05.18.14.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 14:38:26 -0700 (PDT)
Date: Sun, 18 May 2025 17:38:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] vhost/net: Defer TX queue re-enable until
 after sendmsg
Message-ID: <20250518173756-mutt-send-email-mst@kernel.org>
References: <20250420010518.2842335-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420010518.2842335-1-jon@nutanix.com>

On Sat, Apr 19, 2025 at 06:05:18PM -0700, Jon Kohler wrote:
> In handle_tx_copy, TX batching processes packets below ~PAGE_SIZE and
> batches up to 64 messages before calling sock->sendmsg.
> 
> Currently, when there are no more messages on the ring to dequeue,
> handle_tx_copy re-enables kicks on the ring *before* firing off the
> batch sendmsg. However, sock->sendmsg incurs a non-zero delay,
> especially if it needs to wake up a thread (e.g., another vhost worker).
> 
> If the guest submits additional messages immediately after the last ring
> check and disablement, it triggers an EPT_MISCONFIG vmexit to attempt to
> kick the vhost worker. This may happen while the worker is still
> processing the sendmsg, leading to wasteful exit(s).
> 
> This is particularly problematic for single-threaded guest submission
> threads, as they must exit, wait for the exit to be processed
> (potentially involving a TTWU), and then resume.
> 
> In scenarios like a constant stream of UDP messages, this results in a
> sawtooth pattern where the submitter frequently vmexits, and the
> vhost-net worker alternates between sleeping and waking.
> 
> A common solution is to configure vhost-net busy polling via userspace
> (e.g., qemu poll-us). However, treating the sendmsg as the "busy"
> period by keeping kicks disabled during the final sendmsg and
> performing one additional ring check afterward provides a significant
> performance improvement without any excess busy poll cycles.
> 
> If messages are found in the ring after the final sendmsg, requeue the
> TX handler. This ensures fairness for the RX handler and allows
> vhost_run_work_list to cond_resched() as needed.
> 
> Test Case
>     TX VM: taskset -c 2 iperf3  -c rx-ip-here -t 60 -p 5200 -b 0 -u -i 5
>     RX VM: taskset -c 2 iperf3 -s -p 5200 -D
>     6.12.0, each worker backed by tun interface with IFF_NAPI setup.
>     Note: TCP side is largely unchanged as that was copy bound
> 
> 6.12.0 unpatched
>     EPT_MISCONFIG/second: 5411
>     Datagrams/second: ~382k
>     Interval         Transfer     Bitrate         Lost/Total Datagrams
>     0.00-30.00  sec  15.5 GBytes  4.43 Gbits/sec  0/11481630 (0%)  sender
> 
> 6.12.0 patched
>     EPT_MISCONFIG/second: 58 (~93x reduction)
>     Datagrams/second: ~650k  (~1.7x increase)
>     Interval         Transfer     Bitrate         Lost/Total Datagrams
>     0.00-30.00  sec  26.4 GBytes  7.55 Gbits/sec  0/19554720 (0%)  sender
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>


Jon what are we doing with this patch? you still looking into
some feedback?

> ---
>  drivers/vhost/net.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index b9b9e9d40951..9b04025eea66 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -769,13 +769,17 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> +			/* If interrupted while doing busy polling, requeue
> +			 * the handler to be fair handle_rx as well as other
> +			 * tasks waiting on cpu
> +			 */
>  			if (unlikely(busyloop_intr)) {
>  				vhost_poll_queue(&vq->poll);
> -			} else if (unlikely(vhost_enable_notify(&net->dev,
> -								vq))) {
> -				vhost_disable_notify(&net->dev, vq);
> -				continue;
>  			}
> +			/* Kicks are disabled at this point, break loop and
> +			 * process any remaining batched packets. Queue will
> +			 * be re-enabled afterwards.
> +			 */
>  			break;
>  		}
>  
> @@ -825,7 +829,14 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		++nvq->done_idx;
>  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  
> +	/* Kicks are still disabled, dispatch any remaining batched msgs. */
>  	vhost_tx_batch(net, nvq, sock, &msg);
> +
> +	/* All of our work has been completed; however, before leaving the
> +	 * TX handler, do one last check for work, and requeue handler if
> +	 * necessary. If there is no work, queue will be reenabled.
> +	 */
> +	vhost_net_busy_poll_try_queue(net, vq);
>  }
>  
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> -- 
> 2.43.0


