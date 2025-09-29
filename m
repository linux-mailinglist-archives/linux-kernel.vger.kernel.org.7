Return-Path: <linux-kernel+bounces-835935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DE6BA8623
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D45217C06C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709CB26D4C1;
	Mon, 29 Sep 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fofh76Us"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118B2116F6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134223; cv=none; b=nNktLT0Zq2wo3G51q3u0iZOK7R65egzZvFeSPiOgZdo6vi8iFxRAL56ot6QkGD5XGCMTSuhaBmNhyKYEHXe5v0uvJFsppyaWo+83lgIZMhfe0abPZJdnj0wz9K1rlyjd3wj6Lc+Gx8oCkFAmmd6b4C145P5NxKZ9TyMb1mVG5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134223; c=relaxed/simple;
	bh=7YSWCLVFuy1aop71fRCaFWaa37QT4z/Rpn+xkLUC0Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un869BFYwN2KvxCDuhyEltNSD/zZ9IGQzpHp5KWb0QqSZetjsL3zVbhdr/5U/29FsI9WKf8nFhLVmvYHAbuRYNgNnVUAZUX+yzTZRpQ8tse1W4FN+iI2oQSDzOTykoNh5gPuW67rmVqmonULgrx0Z77gPYWMUCnMdbgXPxUzo/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fofh76Us; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759134220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghS+5WNOvB1G94REnxx+I7rRFvw3ycLI6hkd+BUyMC0=;
	b=Fofh76UsoYrxIV1KD1yz8tonJ0dSkOiygRkZ8UvgDHWvFKPFElc3RJgwhO8s2ROGft2rz/
	InhuSWG/fUcTNj002i1aqxirjcYaVCU+f8dZLPTq/Aq3H6G0EQzUWENQm7uweju2k215F8
	LgoiSFymG1y4a2n03o66fB/3p2hBAkY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-y0tAbhg5N1qcgGktOVNd8A-1; Mon, 29 Sep 2025 04:23:38 -0400
X-MC-Unique: y0tAbhg5N1qcgGktOVNd8A-1
X-Mimecast-MFC-AGG-ID: y0tAbhg5N1qcgGktOVNd8A_1759134217
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee10a24246so2486376f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759134217; x=1759739017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghS+5WNOvB1G94REnxx+I7rRFvw3ycLI6hkd+BUyMC0=;
        b=XaLH94sWm/q+WHxosmzgGi5Iz05G2ZMwZ1IfO2dWEd3BYeRNgl3s9rSb6P4BHlPFO3
         GOR4e0ZKJwu8hpsFwnREjZdLg91vZ7zCEL/fmQrovgo/NzHPtRJch5lnLtQyAfF1eUgz
         d9ulMRWK00hikFVz9vqoiNs9vIjM0uGYnJT8kwArQmKSf5qzqXInj+qhn8LDUd9hm/RG
         RVfIbS/bCphL9twWa+26Z+OvV8lQNk61LflLeppXJl31m/Dd5OhNAhnkBa3WQ/orgzrQ
         +SyegkhMRvVdFnoYrQnvIUNjNguxEMCwmsN2VCnDoGZQYfNklQQ7ZYfmq4PcLDpbsUOC
         5vcg==
X-Forwarded-Encrypted: i=1; AJvYcCW+uRiu3jg44QZr8Ku7TCgHlxYqlkGoVZBpOB8FG7Ivx1g0xm08rg3F9k+nDfEpTsuqZteZvQX6UzKCdaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9j9HXn3cptLWtkxB54AzlS7tyTkLJbzRu5bVUbVbd6HzIXMW
	FwvqXDQsic6LclNZHlrHxPnKOfGMdm1d+9KAyib1D5NGnzM5DfC3W76ew3Q0eMiILzqXV44cJhl
	nhaV0DYVkr6qsV10KOoBnyVDhMWsihbXLjCpO/m4to/cxerGT5ajjXcJdjQXTH6wq82h6HkJuIg
	==
X-Gm-Gg: ASbGnctlADkOGVQVz3uZJ3sIUKwDhqjL+l7si7ieAk5gQPeOZpbwC39elWU855TqLrq
	wejBd9RXJj5kL9xNOvR0TdTeoaQFWxDUi1CFGKqZIC2Zsivg7iYZtH30SclcjkEmD0QsEeYfqLg
	BJup8jINKYkSAEsfh6a22l2k3PbcpkNlhGymZ3+oTOeGJjzSyKgO2bMOIS3ohIBIIAyUGkF26Vh
	tk1zX4WLOOyVs8xJaFBoz8cwXcd0JGmN+v2QyvSxlSpxI7qPFaFytGgsISDd2eBc8y/84arNkfK
	9j2ZRFuU3YS8nRJaeybOHzbGVA7UezK6fg==
X-Received: by 2002:a05:6000:1884:b0:402:a740:1edd with SMTP id ffacd0b85a97d-40e4ba3a51dmr14845143f8f.39.1759134216928;
        Mon, 29 Sep 2025 01:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9l1LLm3Rgn3VzcjgMC6odzc7H+TFJ0XAA8WOjX/s9r0eWPTBNzXN7NznhHIAgggH7MxfS1A==
X-Received: by 2002:a05:6000:1884:b0:402:a740:1edd with SMTP id ffacd0b85a97d-40e4ba3a51dmr14845114f8f.39.1759134216336;
        Mon, 29 Sep 2025 01:23:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb264sm17552639f8f.20.2025.09.29.01.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:23:35 -0700 (PDT)
Date: Mon, 29 Sep 2025 04:23:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 13/19] virtio_ring: introduce virtqueue ops
Message-ID: <20250929042244-mutt-send-email-mst@kernel.org>
References: <20250925103708.44589-1-jasowang@redhat.com>
 <20250925103708.44589-14-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925103708.44589-14-jasowang@redhat.com>

On Thu, Sep 25, 2025 at 06:37:02PM +0800, Jason Wang wrote:
> This patch introduces virtqueue ops which is a set of the callbacks
> that will be called for different queue layout or features. This would
> help to avoid branches for split/packed and will ease the future
> implementation like in order.
> 
> Note that in order to eliminate the indirect calls this patch uses
> global array of const ops to allow compiler to avoid indirect
> branches.
> 
> Tested with CONFIG_MITIGATION_RETPOLINE, no performance differences
> were noticed.
> 
> Acked-by: Eugenio P�rez <eperezma@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 173 ++++++++++++++++++++++++++---------
>  1 file changed, 130 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4679a027dc53..e61867268c75 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -67,6 +67,12 @@
>  #define LAST_ADD_TIME_INVALID(vq)
>  #endif
>  
> +enum vq_layout {
> +	SPLIT = 0,
> +	PACKED,
> +	VQ_TYPE_MAX,
> +};
> +
>  struct vring_desc_state_split {
>  	void *data;			/* Data for callback. */
>  
> @@ -159,12 +165,28 @@ struct vring_virtqueue_packed {
>  	size_t event_size_in_bytes;
>  };
>  
> +struct vring_virtqueue;
> +
> +struct virtqueue_ops {
> +	int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[],
> +		   unsigned int total_sg, unsigned int out_sgs,
> +		   unsigned int in_sgs,	void *data,
> +		   void *ctx, bool premapped, gfp_t gfp);
> +	void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void **ctx);
> +	bool (*kick_prepare)(struct vring_virtqueue *vq);
> +	void (*disable_cb)(struct vring_virtqueue *vq);
> +	bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> +	unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
> +	bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx);

poll should accept unsigned int to be consistent with enable_cb_prepare.

You can fix with a patch on top though.

And yes, the cast in there is not needed.


> +	void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> +	bool (*more_used)(const struct vring_virtqueue *vq);
> +	int (*resize)(struct vring_virtqueue *vq, u32 num);
> +	void (*reset)(struct vring_virtqueue *vq);
> +};
> +
>  struct vring_virtqueue {
>  	struct virtqueue vq;
>  
> -	/* Is this a packed ring? */
> -	bool packed_ring;
> -
>  	/* Is DMA API used? */
>  	bool use_map_api;
>  
> @@ -180,6 +202,8 @@ struct vring_virtqueue {
>  	/* Host publishes avail event idx */
>  	bool event;
>  
> +	enum vq_layout layout;
> +
>  	/* Head of free buffer list. */
>  	unsigned int free_head;
>  	/* Number we've added since last sync. */
> @@ -231,6 +255,12 @@ static void vring_free(struct virtqueue *_vq);
>  
>  #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq)
>  
> +
> +static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq)
> +{
> +	return vq->layout == PACKED;
> +}
> +
>  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
>  				   unsigned int total_sg)
>  {
> @@ -433,7 +463,7 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
>  {
>  	vq->vq.num_free = num;
>  
> -	if (vq->packed_ring)
> +	if (virtqueue_is_packed(vq))
>  		vq->last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
>  	else
>  		vq->last_used_idx = 0;
> @@ -1122,6 +1152,8 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  	return 0;
>  }
>  
> +static const struct virtqueue_ops split_ops;
> +
>  static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  					       struct vring_virtqueue_split *vring_split,
>  					       struct virtio_device *vdev,
> @@ -1139,7 +1171,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  	if (!vq)
>  		return NULL;
>  
> -	vq->packed_ring = false;
> +	vq->layout = SPLIT;
>  	vq->vq.callback = callback;
>  	vq->vq.vdev = vdev;
>  	vq->vq.name = name;
> @@ -2076,6 +2108,8 @@ static void virtqueue_reset_packed(struct vring_virtqueue *vq)
>  	virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
>  }
>  
> +static const struct virtqueue_ops packed_ops;
> +
>  static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>  					       struct vring_virtqueue_packed *vring_packed,
>  					       struct virtio_device *vdev,
> @@ -2106,7 +2140,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>  #else
>  	vq->broken = false;
>  #endif
> -	vq->packed_ring = true;
> +	vq->layout = PACKED;
>  	vq->map = map;
>  	vq->use_map_api = vring_use_map_api(vdev);
>  
> @@ -2194,6 +2228,39 @@ static int virtqueue_resize_packed(struct vring_virtqueue *vq, u32 num)
>  	return -ENOMEM;
>  }
>  
> +static const struct virtqueue_ops split_ops = {
> +	.add = virtqueue_add_split,
> +	.get = virtqueue_get_buf_ctx_split,
> +	.kick_prepare = virtqueue_kick_prepare_split,
> +	.disable_cb = virtqueue_disable_cb_split,
> +	.enable_cb_delayed = virtqueue_enable_cb_delayed_split,
> +	.enable_cb_prepare = virtqueue_enable_cb_prepare_split,
> +	.poll = virtqueue_poll_split,
> +	.detach_unused_buf = virtqueue_detach_unused_buf_split,
> +	.more_used = more_used_split,
> +	.resize = virtqueue_resize_split,
> +	.reset = virtqueue_reset_split,
> +};
> +
> +static const struct virtqueue_ops packed_ops = {
> +	.add = virtqueue_add_packed,
> +	.get = virtqueue_get_buf_ctx_packed,
> +	.kick_prepare = virtqueue_kick_prepare_packed,
> +	.disable_cb = virtqueue_disable_cb_packed,
> +	.enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
> +	.enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
> +	.poll = virtqueue_poll_packed,
> +	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
> +	.more_used = more_used_packed,
> +	.resize = virtqueue_resize_packed,
> +	.reset = virtqueue_reset_packed,
> +};
> +
> +static const struct virtqueue_ops *const all_ops[VQ_TYPE_MAX] = {
> +	[SPLIT] = &split_ops,
> +	[PACKED] = &packed_ops
> +};
> +
>  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
>  					 void (*recycle)(struct virtqueue *vq, void *buf))
>  {
> @@ -2236,6 +2303,39 @@ static int virtqueue_enable_after_reset(struct virtqueue *_vq)
>   * Generic functions and exported symbols.
>   */
>  
> +#define VIRTQUEUE_CALL(vq, op, ...)					\
> +	({								\
> +	typeof(all_ops[SPLIT]->op(vq, ##__VA_ARGS__)) ret;		\
> +									\
> +	switch (vq->layout) {						\
> +	case SPLIT:							\
> +		ret = all_ops[SPLIT]->op(vq, ##__VA_ARGS__);		\
> +		break;							\
> +	case PACKED:							\
> +		ret = all_ops[PACKED]->op(vq, ##__VA_ARGS__);		\
> +		break;							\
> +	default:							\
> +		BUG();							\
> +		break;							\
> +	}								\
> +	ret;								\
> +})
> +
> +#define VOID_VIRTQUEUE_CALL(vq, op, ...)		\
> +	({						\
> +	switch ((vq)->layout) {			\
> +	case SPLIT:					\
> +		all_ops[SPLIT]->op(vq, ##__VA_ARGS__);	\
> +		break;					\
> +	case PACKED:					\
> +		all_ops[PACKED]->op(vq, ##__VA_ARGS__);	\
> +		break;					\
> +	default:					\
> +		BUG();					\
> +		break;					\
> +	}						\
> +})
> +
>  static inline int virtqueue_add(struct virtqueue *_vq,
>  				struct scatterlist *sgs[],
>  				unsigned int total_sg,
> @@ -2248,10 +2348,9 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
> -					out_sgs, in_sgs, data, ctx, premapped, gfp) :
> -				 virtqueue_add_split(vq, sgs, total_sg,
> -					out_sgs, in_sgs, data, ctx, premapped, gfp);
> +	return VIRTQUEUE_CALL(vq, add, sgs, total_sg,
> +			      out_sgs, in_sgs, data,
> +			      ctx, premapped, gfp);
>  }
>  
>  /**
> @@ -2441,8 +2540,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> -				 virtqueue_kick_prepare_split(vq);
> +	return VIRTQUEUE_CALL(vq, kick_prepare);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>  
> @@ -2512,8 +2610,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
> -				 virtqueue_get_buf_ctx_split(vq, len, ctx);
> +	return VIRTQUEUE_CALL(vq, get, len, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>  
> @@ -2535,10 +2632,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	if (vq->packed_ring)
> -		virtqueue_disable_cb_packed(vq);
> -	else
> -		virtqueue_disable_cb_split(vq);
> +	VOID_VIRTQUEUE_CALL(vq, disable_cb);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>  
> @@ -2561,8 +2655,7 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  	if (vq->event_triggered)
>  		vq->event_triggered = false;
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> -				 virtqueue_enable_cb_prepare_split(vq);
> +	return VIRTQUEUE_CALL(vq, enable_cb_prepare);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>  
> @@ -2583,8 +2676,8 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
>  		return false;
>  
>  	virtio_mb(vq->weak_barriers);
> -	return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
> -				 virtqueue_poll_split(vq, last_used_idx);
> +
> +	return VIRTQUEUE_CALL(vq, poll, last_used_idx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> @@ -2627,8 +2720,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  	if (vq->event_triggered)
>  		data_race(vq->event_triggered = false);
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> -				 virtqueue_enable_cb_delayed_split(vq);
> +	return VIRTQUEUE_CALL(vq, enable_cb_delayed);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>  
> @@ -2644,14 +2736,13 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> -				 virtqueue_detach_unused_buf_split(vq);
> +	return VIRTQUEUE_CALL(vq, detach_unused_buf);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>  
>  static inline bool more_used(const struct vring_virtqueue *vq)
>  {
> -	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
> +	return VIRTQUEUE_CALL(vq, more_used);
>  }
>  
>  /**
> @@ -2781,7 +2872,8 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	if (!num)
>  		return -EINVAL;
>  
> -	if ((vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num) == num)
> +	if ((virtqueue_is_packed(vq) ? vq->packed.vring.num :
> +			               vq->split.vring.num) == num)
>  		return 0;
>  
>  	err = virtqueue_disable_and_recycle(_vq, recycle);
> @@ -2790,10 +2882,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	if (recycle_done)
>  		recycle_done(_vq);
>  
> -	if (vq->packed_ring)
> -		err = virtqueue_resize_packed(vq, num);
> -	else
> -		err = virtqueue_resize_split(vq, num);
> +	err = VIRTQUEUE_CALL(vq, resize, num);
>  
>  	err_reset = virtqueue_enable_after_reset(_vq);
>  	if (err_reset)
> @@ -2831,10 +2920,7 @@ int virtqueue_reset(struct virtqueue *_vq,
>  	if (recycle_done)
>  		recycle_done(_vq);
>  
> -	if (vq->packed_ring)
> -		virtqueue_reset_packed(vq);
> -	else
> -		virtqueue_reset_split(vq);
> +	VOID_VIRTQUEUE_CALL(vq, reset);
>  
>  	return virtqueue_enable_after_reset(_vq);
>  }
> @@ -2877,7 +2963,7 @@ static void vring_free(struct virtqueue *_vq)
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (vq->we_own_ring) {
> -		if (vq->packed_ring) {
> +		if (virtqueue_is_packed(vq)) {
>  			vring_free_queue(vq->vq.vdev,
>  					 vq->packed.ring_size_in_bytes,
>  					 vq->packed.vring.desc,
> @@ -2906,7 +2992,7 @@ static void vring_free(struct virtqueue *_vq)
>  					 vq->map);
>  		}
>  	}
> -	if (!vq->packed_ring) {
> +	if (!virtqueue_is_packed(vq)) {
>  		kfree(vq->split.desc_state);
>  		kfree(vq->split.desc_extra);
>  	}
> @@ -2931,7 +3017,7 @@ u32 vring_notification_data(struct virtqueue *_vq)
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 next;
>  
> -	if (vq->packed_ring)
> +	if (virtqueue_is_packed(vq))
>  		next = (vq->packed.next_avail_idx &
>  				~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))) |
>  			vq->packed.avail_wrap_counter <<
> @@ -2984,7 +3070,8 @@ unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
>  
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
> +	return virtqueue_is_packed(vq) ? vq->packed.vring.num :
> +				      vq->split.vring.num;
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>  
> @@ -3067,7 +3154,7 @@ dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *_vq)
>  
>  	BUG_ON(!vq->we_own_ring);
>  
> -	if (vq->packed_ring)
> +	if (virtqueue_is_packed(vq))
>  		return vq->packed.ring_dma_addr;
>  
>  	return vq->split.queue_dma_addr;
> @@ -3080,7 +3167,7 @@ dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *_vq)
>  
>  	BUG_ON(!vq->we_own_ring);
>  
> -	if (vq->packed_ring)
> +	if (virtqueue_is_packed(vq))
>  		return vq->packed.driver_event_dma_addr;
>  
>  	return vq->split.queue_dma_addr +
> @@ -3094,7 +3181,7 @@ dma_addr_t virtqueue_get_used_addr(const struct virtqueue *_vq)
>  
>  	BUG_ON(!vq->we_own_ring);
>  
> -	if (vq->packed_ring)
> +	if (virtqueue_is_packed(vq))
>  		return vq->packed.device_event_dma_addr;
>  
>  	return vq->split.queue_dma_addr +
> -- 
> 2.31.1


