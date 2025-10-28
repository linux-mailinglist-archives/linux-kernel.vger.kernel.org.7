Return-Path: <linux-kernel+bounces-873975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6ACC15330
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 422114EA8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE0130499B;
	Tue, 28 Oct 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4Tb7HGo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E862139CE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662511; cv=none; b=bMisYE5fIYm6QiCB8fanMIk4SN/ArCqV3kA2jLTHUnVna8IkVipAXvhDNwGFhjIU36E40jgO7iL6Q0/zZJDyRsHKsmii7107TAVb02WQPdfxkToUQczRRbxXgFPWR6QAE2uUn4jFcqiecUKAn1rjHxtV2eylIpJRj1DM0DyTT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662511; c=relaxed/simple;
	bh=zZFrWoA22wiG0tWmfXQmHOPpME9nO7zblFQfy5vvLz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA1GCO3GY7dKQY0/G/YDQFNbhwUMo4OQMdbtCaCKnIs09LQ8v4jjP/IImq1SkFkZ9CsEJw5ENgMLZxe+qjyj1lszuDf2zAwuRl9i+eivJ4fe7poRZ97Sjdfx22Q7Po07pRxD0hJgEQKHnWXlgo05MS7VHICEfMB6LVktlacM170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4Tb7HGo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761662509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7eWGU4/sCZhBc+k/OXAlSXf1w6wQiO+JEvcP2rSPOPA=;
	b=e4Tb7HGoby3b9QS36rqPu/tSsCpnD0gpfmYpcj9yLllNqavEgJWAER175OS5/S4flybpuN
	xnK+eXNZIuuyNR25EA+2WTrCoi6206VZ0X1x3xNObkHipyZhTqjSTfN0eo9+abxRxyVjqF
	EmIbXP/HbP8eKj/eGeiqrX2/XJE0ppI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449--CphB8pkNneL9SE7iXvJvg-1; Tue, 28 Oct 2025 10:41:48 -0400
X-MC-Unique: -CphB8pkNneL9SE7iXvJvg-1
X-Mimecast-MFC-AGG-ID: -CphB8pkNneL9SE7iXvJvg_1761662507
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-63c299835ebso9237553a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761662506; x=1762267306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eWGU4/sCZhBc+k/OXAlSXf1w6wQiO+JEvcP2rSPOPA=;
        b=labk7zKgeLTXSFQbSFF3quKcdA4NPeeM01rUZUVlX6jssUWsv9bz0UmQbGcjfrzs7U
         Wqo0vbKXs3dHTvtSgXUyOWjw2GLHdLyrOlwKcN7EwWrEUVie0uQBICkQ4w6/laJW7fPA
         U7jb5t/4h/oKUHeZRbAhXurb/xduilowXzmD/MVAcFDbBkfdxLREzcZom3xG19rUrbYA
         aZBkriFidehOTetFNEXMYQYWONJXeLG/zJZ3ZKZecAB3R+3CYh7Curb9D3xANdtEBSHx
         Xr5EQc500Ytj5FDQSaWXeR6eKtIV5dN2eWhjv/7sqDRpfZjq0+TqDNwGhAJcu7j//7IC
         zrmg==
X-Forwarded-Encrypted: i=1; AJvYcCVge/1VCTIO61BkcKa8+ztiF2qqRVGVJsJ0lq5fGxWBPqHPW80lmNXuGh0Aw6e7tVoLHTvEbQZz4mY8mic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgO7QF7qm48Jqvf5PLYY0nbTlWGPq/qSi/y5MHwvEi5c1UjlM
	YjXWz2s3oHnEbeAQCYFUPcPYQVeNmG9jjePMnuvOI7SFiPN4ZUcAHyAGjkbib8jLQ/uM6+UoY7e
	H52PRu4ZNsbvffT2Ir/gk4TBrXwWjuG3QlosM1vaupXv4ipGwS6Ey3SRDYo5DHSNibnVysFbjVA
	==
X-Gm-Gg: ASbGncsu+YxTVUGvZjbnOkEX6lwG9hjhNh+4FSY5I8tLmhAOegqsE/dSem2y2N0AMRy
	c7cR2EXFyBPVIbyPkcvXTpXSPS0mecWGsGFghfXMvlugImlgX2r5s1Ss/X4e9U7WpE0ygfV0AXU
	uzmkaKbPKu5jE8NWLC12GMvhjCTS9NG47/qvnEcm8J4LIkN+kVPb1LEghPvhsUPYZuFpcrNQbjd
	GokV+kQGdSbEExNIWo8Uorc+AChmKTGJ3j3RUHNfzH1o21vFQimqRU0EVKbUUHZAp/u0soy+Oi5
	o4Vn5qZliUw0I/EssbM5oR6R4fPG2Kg5ScCXel8mDVJtrocXgOQtEmm9eknyo9dD
X-Received: by 2002:a05:6402:144a:b0:62e:ebb4:e6e0 with SMTP id 4fb4d7f45d1cf-63f4bca70a6mr2966879a12.1.1761662506575;
        Tue, 28 Oct 2025 07:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOr/YGySpncsjMyKMI6CUK3yhy881BlqAgFf5Tw9hIOxtgltg9Pn+Albol7GlK//8Ah0jD8A==
X-Received: by 2002:a05:6402:144a:b0:62e:ebb4:e6e0 with SMTP id 4fb4d7f45d1cf-63f4bca70a6mr2966848a12.1.1761662506036;
        Tue, 28 Oct 2025 07:41:46 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0e23sm9044225a12.35.2025.10.28.07.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:41:45 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:41:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v6] virtio-net: fix received length check in big
 packets
Message-ID: <20251028104041-mutt-send-email-mst@kernel.org>
References: <20251028143116.4532-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028143116.4532-1-minhquangbui99@gmail.com>

On Tue, Oct 28, 2025 at 09:31:16PM +0700, Bui Quang Minh wrote:
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> for big packets"), when guest gso is off, the allocated size for big
> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
> negotiated MTU. The number of allocated frags for big packets is stored
> in vi->big_packets_num_skbfrags.
> 
> Because the host announced buffer length can be malicious (e.g. the host
> vhost_net driver's get_rx_bufs is modified to announce incorrect
> length), we need a check in virtio_net receive path. Currently, the
> check is not adapted to the new change which can lead to NULL page
> pointer dereference in the below while loop when receiving length that
> is larger than the allocated one.
> 
> This commit fixes the received length check corresponding to the new
> change.
> 
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v6:
> - Fix the length check
> - Link to v5: https://lore.kernel.org/netdev/20251024150649.22906-1-minhquangbui99@gmail.com/
> Changes in v5:
> - Move the length check to receive_big
> - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-minhquangbui99@gmail.com/
> Changes in v4:
> - Remove unrelated changes, add more comments
> - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-minhquangbui99@gmail.com/
> Changes in v3:
> - Convert BUG_ON to WARN_ON_ONCE
> - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-minhquangbui99@gmail.com/
> Changes in v2:
> - Remove incorrect give_pages call
> - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-minhquangbui99@gmail.com/
> ---
>  drivers/net/virtio_net.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a757cbcab87f..461ad1019c37 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  		goto ok;
>  	}
>  
> -	/*
> -	 * Verify that we can indeed put this data into a skb.
> -	 * This is here to handle cases when the device erroneously
> -	 * tries to receive more than is possible. This is usually
> -	 * the case of a broken device.
> -	 */
> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> -		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
> -		dev_kfree_skb(skb);
> -		return NULL;
> -	}
>  	BUG_ON(offset >= PAGE_SIZE);
>  	while (len) {
>  		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
> @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> -	struct sk_buff *skb =
> -		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
> +	struct sk_buff *skb;
> +
> +	/* Make sure that len does not exceed the allocated size in
> +	 * add_recvbuf_big.

you mean "the size allocated in add_recvbuf_big"

> +	 */
> +	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",


allocated?

> +			 dev->name, len,
> +			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +		goto err;
> +	}
>  
> +	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>  	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>  	if (unlikely(!skb))
>  		goto err;
> -- 
> 2.43.0


