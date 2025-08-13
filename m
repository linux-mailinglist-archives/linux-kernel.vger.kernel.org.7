Return-Path: <linux-kernel+bounces-766271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38186B24483
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429CC172EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0395F2EF66C;
	Wed, 13 Aug 2025 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO5MVTDy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E82C1591
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074478; cv=none; b=oyE3DMxWtJ/m9YUGetQqxU+DFVNtcCuIeSxLwuZ2zEJ+dcNHL0hq7UkpL+X7aGyUtnB+SSJBNzX5Q3wFCBoA3d7dl9d6p5K+3KZAp0SBDbje2FPjHQDga2J+2gkzGvIsOyQgwxy8vEAl/fVzdMg224KIS+nelmiVFyvrlUelH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074478; c=relaxed/simple;
	bh=tPuksD77buzY7YWi9EBculS4rVEQBAdYHafEc74xhBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1EHP49OvYB7b9Z8kMJh4vFxdmKlf2UcRzqxhVO1aMq7gZKSBwbLtof3ZMNy/CpoTYb9NpQqFMQI4RxklLdGOVOth3bsALfnFkvywWWacGTtaLA92TefZt0C26ku8/gnvaTByE71khv9OsBlnY09amJDmfzX+720WIiRQQDHBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO5MVTDy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755074475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=76YJFkH9eIhBYjG5GaaJcP9B1ox/l/WKOLKsUlz9rUw=;
	b=CO5MVTDywykXSlKEZ2Iky8O+AqXz5iPwmq9xU15xRfjPrnelUvt1xHWBhv7aiG1qj+5ipu
	knxSrTtPpaKYgMZJ/LxhDep7LF3WHGLlUit6yChQREYDjG2Y+ePdILuyIbo0139C4ah81/
	O5FSFrdtISfTz4vC5R9RrgqsEB0ksfY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-QmDvmEOZMTSgsTH172YA4A-1; Wed, 13 Aug 2025 04:41:14 -0400
X-MC-Unique: QmDvmEOZMTSgsTH172YA4A-1
X-Mimecast-MFC-AGG-ID: QmDvmEOZMTSgsTH172YA4A_1755074473
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a09c08999so18699205e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074473; x=1755679273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76YJFkH9eIhBYjG5GaaJcP9B1ox/l/WKOLKsUlz9rUw=;
        b=MIys+hIKvajMggyW4LgAp8NsaTFw/+X3A0mHm/VOeqzrEFNSVzkQDcgOet8qrCH/Iv
         XW09WCX9xLBNOwPo2FeWMXKRqFmYgA1vwqptGVNY/xyseWvbj7/60JMlyjYq3hXNs/Om
         mo12QfEVqvlKpZD5Isl2Lp4JDPQ1ACdx64iwvYxYwaxmw/+eH4V3iVZ9zF9uQADlUbK+
         G2UGbHK3GRaxybKqHMGZAGpf7TLLS8TNnsQMCM0vKZQnpCpHMJU+YczU93d/yoLuyI/D
         R2dwcJ0XwqsEuflwmZeCUN95VHvYOWVCst0iiEmu6dXdsyaZBDKvNK1Sa4bXn2fT20Xb
         BS8A==
X-Gm-Message-State: AOJu0Yy44OoJLLGKMp9UEoUqayk04Tlmvl9iWrqkqn0dby9JE+srC1aI
	oD3k1qaPHPKu+UcbZfyeZ3pkgtWoCcCUnBJMDZS0vMLQIrBNWMk1DmMshW/P88r7oiWrKwLwR0k
	24+55MgVXwtOcuf5LpaqLnP+ubIn5oTswARSeEnngbR7Ni/6vjz8pC71OA60dQO1LCw==
X-Gm-Gg: ASbGncuBxN4UPBN66UKIlSdgP75aPa/4myijKlJ9axNbPzkPsSUW46GjKri2hZq3p1Q
	dWbudAYkxefLVSjqyxtu4feze0m8jOmRK1PYlc5NvKUF3TORji+xZmRJtg0GdI4nHDOSlXWPFl8
	bW/O0IUX23vBGbM9qlgyXJLNkVlbXuu5qBvODd9Xc4cA/DnZ7DTfN6/qt4I3mHYij1HHln0o1Qk
	4R3EKET7YEW/aE+kXrCNwc7FO5cSpJRoq7B4bXG4S6vHcDj7zGM5uf1Yme/7RMA3srvTvxdx/8V
	OrxU1AC9hrenWihk2dEax3KxqL7pPVGG
X-Received: by 2002:a05:600c:3106:b0:458:6733:fb5c with SMTP id 5b1f17b1804b1-45a1664bdb7mr15732985e9.28.1755074473353;
        Wed, 13 Aug 2025 01:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAoH7imNQ2C+/iwNJvGO5T7E2kVVUhVdyltcXD3iFW1FubZdXr/O++cAjLCc7t/dYIu5pcLQ==
X-Received: by 2002:a05:600c:3106:b0:458:6733:fb5c with SMTP id 5b1f17b1804b1-45a1664bdb7mr15732735e9.28.1755074472965;
        Wed, 13 Aug 2025 01:41:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16ddb9fbsm19841985e9.9.2025.08.13.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:41:12 -0700 (PDT)
Date: Wed, 13 Aug 2025 04:41:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for
 handling large transmit buffers
Message-ID: <20250812112226-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-10-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717090116.11987-10-will@kernel.org>

On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> transmit data. Unfortunately, these are always linear allocations and
> can therefore result in significant pressure on kmalloc() considering
> that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> allocation for each packet.
> 
> Rework the vsock SKB allocation so that, for sizes with page order
> greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> instead with the packet header in the SKB and the transmit data in the
> fragments. Note that this affects both the vhost and virtio transports.
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>



So this caused a regression, see syzbot report:

https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com


I'm inclined to revert unless we have a fix quickly.


> ---
>  net/vmw_vsock/virtio_transport_common.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index c9eb7f7ac00d..fe92e5fa95b4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -109,7 +109,8 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
>  		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
>  					       &info->msg->msg_iter, len, NULL);
>  
> -	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
> +	virtio_vsock_skb_put(skb, len);
> +	return skb_copy_datagram_from_iter(skb, 0, &info->msg->msg_iter, len);
>  }
>  
>  static void virtio_transport_init_hdr(struct sk_buff *skb,
> @@ -261,7 +262,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  	if (!zcopy)
>  		skb_len += payload_len;
>  
> -	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
> +	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>  	if (!skb)
>  		return NULL;
>  
> -- 
> 2.50.0.727.gbf7dc18ff4-goog


