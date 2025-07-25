Return-Path: <linux-kernel+bounces-745820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36BCB11F31
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D6D16DCE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD3B2ED15E;
	Fri, 25 Jul 2025 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/VOgu8S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009C2D46DA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449126; cv=none; b=ufqZQp/yt9Zu8GbEExbaiRiEY+aL5lJXpQgOXa/hMhLEHD30dAIHD0p0FMGZwKAFwVMnz8ICydZUeKSnZYIK/CXDzzCZgrQ8DmQ22zHDKGMC7J6YTp07P90Of1Ezi5VyAHOnAqk5AuGhczVfCfRrZmJWfLHfywe77Tn5kM0XriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449126; c=relaxed/simple;
	bh=4eae3oNI/1QzpMOYJGbwbybwLjRh7YnkKjFeCkHKrGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWQSUGEhctb4mVX3JIOwWH9h1+FceDn29eGtQZ1q/qC3lshQLGvWZ1wMNlYPadfq8TuOM/WYwvaQhT0H7Itj5V6RLMu2MguTb4bqLx+lBXq6H3lBXZEaw/ewqSgLmbwTB5yaF1MxBGiAiwla39zQ7fo/lC++9QdWSumf+p3TxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/VOgu8S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753449122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QE5pNevTgSrBNAfqe5rNVIW9hc1HtsvMNrpjAUoQRU0=;
	b=g/VOgu8SKOvhS9FLBowRssNRWF3eQy9+hnXRndKKCqPqhhUgmX4r1+h1yqrMusw/t/s9uG
	o9b8O3tsiQbxqLH/Go/E9EjvKF1E68dhoY/If8c63yYM8rhGhUZXqTbZafEDCBHMP0zkLU
	tAnjTzn/8fS9817WuYiewVFN98X75No=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-9vDTXJJTO3O4EbYUASAHsw-1; Fri, 25 Jul 2025 09:12:00 -0400
X-MC-Unique: 9vDTXJJTO3O4EbYUASAHsw-1
X-Mimecast-MFC-AGG-ID: 9vDTXJJTO3O4EbYUASAHsw_1753449120
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4563f15f226so5800535e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753449119; x=1754053919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE5pNevTgSrBNAfqe5rNVIW9hc1HtsvMNrpjAUoQRU0=;
        b=P2RQeYQ0dbxcSC7aO2Z6hWOiTWO2jvStVKNh++PHzsuSt9bVkuqwxDDe1fK8CwqlpO
         LJJJZTuvgaO48qvOYjfh3haMF5ZcdnpJUpmu/M5JR+DTSSkvG1iYKVNNTmVy9FfUA1SI
         pLvU89emXeCOX3II1hr0sNT3TmT5KDRqHo32TaThPu7dwRN//zQ25zc3OJsW1E8C0HR4
         29zXRwtB/ksMbLXxoAl1o6oqUET6NuSd7nSGtnPGVw+6mcoL6+PiBVcoIyL3ucSgxrRu
         eaogEVDx96nkZX1f4JrHT4eOjeLHLpMUJxnC/IxGZulZvqaygVdTR7q4qwOJXcvCVPeg
         8wmg==
X-Forwarded-Encrypted: i=1; AJvYcCU5QJcu7L5OzIwyWaaLsJNWJSfYpscoY8L/KF9nMRqLsBc1LGtwxHBLKFvubkSr4TeuJv09+L5HtzH18YI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4H3FWnQBA9D/5oa6psYzsMgwrecv26oifnI3TiYhAq2Xc+Tdb
	bP0mPhWkZvBhgiC2ab52jAUhCSN/3bCwaObeT3+4tqYiU8oV+HYHnEhdG0US7xAm21zd2z8qBL9
	FJXgn2L3pwnsfGmRKihQ21LewjloWCGackB91IfKNM6i7gtsib6Gh46plKjLPzxhnvg==
X-Gm-Gg: ASbGncuohYD6AvZuLqgjtXLp1efQbBQK68LJZ5HKJiJ3QcV1Uhbezy1Yz3u300ulWse
	nPI862PkXim6LuiBShZ9LhOYkmNIFLEk+RROE0Tej53k4UDbmXF4C5KDdSwoWyB+LWLEy2E9j+4
	Mwup9YvmF79AdHPKj8nXqKvc3wnczsITk85SiNuJtEQJbO7L3/HnJNas2ojRXViY3gUh1QLVGVF
	ynTsednLf+LfOr4Hvb9i4Ew/BDWvbAyvLB3PpOjlOMRFa5sgri8ff8wpiZQdb3w4gQYOTHYvcJo
	clevut6h+xEMa6FMpXo5XrfqiFp61HDlVg==
X-Received: by 2002:a05:600c:3acf:b0:456:f85:469b with SMTP id 5b1f17b1804b1-4587655600fmr18480865e9.25.1753449119515;
        Fri, 25 Jul 2025 06:11:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTr7oYcrZTiXGPdV3WbWEeF3Uca/G8/N4QJ8yjiu46Cu237Z8e7cthr/VFQgMfq45FcU7ajQ==
X-Received: by 2002:a05:600c:3acf:b0:456:f85:469b with SMTP id 5b1f17b1804b1-4587655600fmr18480595e9.25.1753449119098;
        Fri, 25 Jul 2025 06:11:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705678c1sm53152895e9.25.2025.07.25.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:11:58 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:11:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"kernelci . org bot" <bot@kernelci.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] virtio_ring: fix uninitialized used value
Message-ID: <20250725091129-mutt-send-email-mst@kernel.org>
References: <20250725083635.73355-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725083635.73355-1-jasowang@redhat.com>

On Fri, Jul 25, 2025 at 04:36:35PM +0800, Jason Wang wrote:
> Buildbot reports uninitialized used:
> 
> drivers/virtio/virtio_ring.c:2113:40: error: variable 'id' is
> uninitialized when used here [-Werror,-Wuninitialized]
>  2113 |                 BAD_RING(vq, "id %u out of range\n", id);
>       |                                                      ^~
> drivers/virtio/virtio_ring.c:2077:19: note: initialize the variable
> 'id' to silence this warning
>  2077 |         u16 last_used, id, last_used_idx;
>       |                          ^
>       |                           = 0
> 1 error generated.
> 
> Fixing this by use last_used instead and drop the complete unused
> variable id.
> 
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

I squashed but I think you should respin.
also noticed a couple of minor issues.

> ---
>  drivers/virtio/virtio_ring.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8f9413acd4e2..7b960ce9a034 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2074,7 +2074,7 @@ static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqueue *vq,
>  						   void **ctx)
>  {
>  	unsigned int num = vq->packed.vring.num;
> -	u16 last_used, id, last_used_idx;
> +	u16 last_used, last_used_idx;
>  	bool used_wrap_counter;
>  	void *ret;
>  
> @@ -2110,11 +2110,11 @@ static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqueue *vq,
>  		*len = vq->packed.desc_state[last_used].total_len;
>  
>  	if (unlikely(last_used >= num)) {
> -		BAD_RING(vq, "id %u out of range\n", id);
> +		BAD_RING(vq, "id %u out of range\n", last_used);
>  		return NULL;
>  	}
>  	if (unlikely(!vq->packed.desc_state[last_used].data)) {
> -		BAD_RING(vq, "id %u is not a head!\n", id);
> +		BAD_RING(vq, "id %u is not a head!\n", last_used);
>  		return NULL;
>  	}
>  
> -- 
> 2.39.5


