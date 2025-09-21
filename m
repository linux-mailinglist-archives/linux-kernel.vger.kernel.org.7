Return-Path: <linux-kernel+bounces-826329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3526B8E348
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E72F3BB8DD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D21A2392;
	Sun, 21 Sep 2025 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZM7FfNYV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AAE14A62B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479605; cv=none; b=JH6zk80Vc4o950d0PVe0Orc7qC1oFcxeaQVuNIwkv3bdDyvYdt5XUCNu9Srm8r4MKuEq/JSNJs/WoPNlnciEdKCXPe7+VtGwN1qrlQQRN4olEw1CmqRukTs9NQDteoJBy9Fp+DX3+qhGFL7HwPwfBb/1ogEQu75GaxHOSQ9LFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479605; c=relaxed/simple;
	bh=CcbWrkWZJPydQU0ECeHhBe3+Ro4d21oehqcJ2BvvVj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMdsWJ+FSbYCZRvRSM6cGVLgSwRzfKZ9uf8N9V24n5tYVrEniZ3xUpJLgV6DSrLQjSptyzUGvt1aTsLudIVdKqeUkKj5pWyjNLtGPwTzEdif89PDQxUTNbR1RUdR1vGvNDpZE0tzWy/Q/V5pN3qbjThBJnhgjR7YSMnXipZ0gCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZM7FfNYV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758479602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFvofduckXZ7BgBKb8vVbo4xmKDJRP59C1iz9KAtlSw=;
	b=ZM7FfNYVUaUQLObJmlRr3BEYAn7JgY4uBfX9Zgwrug1H/kaivSzdcF75yPdU5qYED8k8aY
	eVAp9ym8C+RXlEMkIJ/M5TOP+2EF2+g6cU2PSwcIwvN/Pjz7VVZPhLhOWMxUJLVF3C9l4A
	Cv5xyazUpXcr9cFIIwtFfm+QBqMfFTQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-duGKQB8wNwiKmCpqo4Evlw-1; Sun, 21 Sep 2025 14:33:14 -0400
X-MC-Unique: duGKQB8wNwiKmCpqo4Evlw-1
X-Mimecast-MFC-AGG-ID: duGKQB8wNwiKmCpqo4Evlw_1758479593
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46d8ef3526dso55995e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479593; x=1759084393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFvofduckXZ7BgBKb8vVbo4xmKDJRP59C1iz9KAtlSw=;
        b=OlHbs6doyjoOH8n6ZZ9ONLRLdn0QsmzVs1iwAwu7zbGLFdZw3h3hcXgBcU1RVgmnOR
         yZHYCgzicObwDI5WlkO4wqpaldIVj4soG5/zyrgvr9sa+jAIYaQjGm1vEvmcl5RDXawJ
         nyC3YVifi2T0l1CLJo1+SQM/ruj7Moih67Ee+4LcNAP57ZDjJYxw4pMzco/bLYTskina
         OjYpU0V/Sz8b+gbJ/Yq1m05jEZfR6SqH95rKvW/MY9ieS7Vywz9UPiSPoOarSB+M4tyz
         SnL92+3w83tWnO9lC9mBi13eENxlvWm2lgdbgiCh6YGMfEjh3uxS+ty0K1CMt7j9IVwN
         MYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8eVIzLJ88ofg2nlJEHvL365pL6ZGJoZdWX+2O/1VElpjjzbY2/UmlV89gnMaWVndnxQmI7tlGhL+GsHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPfJQWAIxhDj5Ks+gtV9Wk0vL1ef/zcpfUmEjdiZNBiah5c3Z
	6QlECVPPMVtP8WaZRLtsky662j2kB2MV+fBy2gmpMpL5OifjgWCVSifN6kousOu2oIHOF0EnrRO
	IPQq0s1Iq0n0NbGeebknBdDGpjkpb8ZTWe8eFz7zkZ/yq8cyBrJwdV65tou2vSu8dWw==
X-Gm-Gg: ASbGnct6aGzLuT6+vcw2OJ/GULUiRgJvN0SC7A90O0shyZZPsvc9q1Zb+Ke4/x0LRSD
	ccJ1Cs3/qT6btqOxe5lDWNsQ18kJITQmtp2XoD3BOPSPrrOYq6UGknhFkP5uRZM0TB8GzP0f0G5
	0mFVRKnv5PnUWFEWkw+ox2+9nFMbGRcKLvOlC60UDicrMKvHlbx585pMOhWVLAe4Gg3W7y9MD69
	oDkPr0YQ7ftEEBLdcp2yzNjHgxl71gLlHdJnhtjWspbhySJTK3vsAotVr704M3AXt5rV1yt26MB
	USf8a5eQ8mzhtYDCLcHUMuetwykxjdrnKQg=
X-Received: by 2002:a05:600c:190c:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-467e6b64cd3mr107778825e9.4.1758479593256;
        Sun, 21 Sep 2025 11:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk6toIU2up35UKm69e04e9hy5rrEwL2PnOlvBdRfPXsRFtCMF7H/BBJ5jnrmK8xqdVe/wUVg==
X-Received: by 2002:a05:600c:190c:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-467e6b64cd3mr107778665e9.4.1758479592785;
        Sun, 21 Sep 2025 11:33:12 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f4f3csm16046371f8f.2.2025.09.21.11.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:33:12 -0700 (PDT)
Date: Sun, 21 Sep 2025 14:33:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 13/19] virtio_ring: introduce virtqueue ops
Message-ID: <20250921143217-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-14-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919073154.49278-14-jasowang@redhat.com>

On Fri, Sep 19, 2025 at 03:31:48PM +0800, Jason Wang wrote:
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
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 173 ++++++++++++++++++++++++++---------
>  1 file changed, 130 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b1b6af297061..1045c553ee65 100644
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

Why is it _vq here?


> +	void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void **ctx);
> +	bool (*kick_prepare)(struct vring_virtqueue *vq);
> +	void (*disable_cb)(struct vring_virtqueue *vq);
> +	bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> +	unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
> +	bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx);
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

why the extra empty line?


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
> @@ -1121,6 +1151,8 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  	return 0;
>  }
>  
> +static const struct virtqueue_ops split_ops;
> +
>  static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  					       struct vring_virtqueue_split *vring_split,
>  					       struct virtio_device *vdev,
> @@ -1138,7 +1170,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  	if (!vq)
>  		return NULL;
>  
> -	vq->packed_ring = false;
> +	vq->layout = SPLIT;
>  	vq->vq.callback = callback;
>  	vq->vq.vdev = vdev;
>  	vq->vq.name = name;
> @@ -2075,6 +2107,8 @@ static void virtqueue_reset_packed(struct vring_virtqueue *vq)
>  	virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
>  }
>  
> +static const struct virtqueue_ops packed_ops;
> +
>  static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>  					       struct vring_virtqueue_packed *vring_packed,
>  					       struct virtio_device *vdev,
> @@ -2105,7 +2139,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>  #else
>  	vq->broken = false;
>  #endif
> -	vq->packed_ring = true;
> +	vq->layout = PACKED;
>  	vq->map = map;
>  	vq->use_map_api = vring_use_map_api(vdev);
>  
> @@ -2193,6 +2227,39 @@ static int virtqueue_resize_packed(struct vring_virtqueue *vq, u32 num)
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
> @@ -2235,6 +2302,39 @@ static int virtqueue_enable_after_reset(struct virtqueue *_vq)
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
> @@ -2247,10 +2347,9 @@ static inline int virtqueue_add(struct virtqueue *_vq,
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
> @@ -2440,8 +2539,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> -				 virtqueue_kick_prepare_split(vq);
> +	return VIRTQUEUE_CALL(vq, kick_prepare);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>  
> @@ -2511,8 +2609,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
> -				 virtqueue_get_buf_ctx_split(vq, len, ctx);
> +	return VIRTQUEUE_CALL(vq, get, len, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>  
> @@ -2534,10 +2631,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
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
> @@ -2560,8 +2654,7 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  	if (vq->event_triggered)
>  		vq->event_triggered = false;
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> -				 virtqueue_enable_cb_prepare_split(vq);
> +	return VIRTQUEUE_CALL(vq, enable_cb_prepare);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>  
> @@ -2582,8 +2675,8 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
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
> @@ -2626,8 +2719,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  	if (vq->event_triggered)
>  		data_race(vq->event_triggered = false);
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> -				 virtqueue_enable_cb_delayed_split(vq);
> +	return VIRTQUEUE_CALL(vq, enable_cb_delayed);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>  
> @@ -2643,14 +2735,13 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
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
> @@ -2780,7 +2871,8 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	if (!num)
>  		return -EINVAL;
>  
> -	if ((vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num) == num)
> +	if ((virtqueue_is_packed(vq) ? vq->packed.vring.num :
> +			               vq->split.vring.num) == num)
>  		return 0;
>  
>  	err = virtqueue_disable_and_recycle(_vq, recycle);
> @@ -2789,10 +2881,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
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
> @@ -2830,10 +2919,7 @@ int virtqueue_reset(struct virtqueue *_vq,
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
> @@ -2876,7 +2962,7 @@ static void vring_free(struct virtqueue *_vq)
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (vq->we_own_ring) {
> -		if (vq->packed_ring) {
> +		if (virtqueue_is_packed(vq)) {
>  			vring_free_queue(vq->vq.vdev,
>  					 vq->packed.ring_size_in_bytes,
>  					 vq->packed.vring.desc,
> @@ -2905,7 +2991,7 @@ static void vring_free(struct virtqueue *_vq)
>  					 vq->map);
>  		}
>  	}
> -	if (!vq->packed_ring) {
> +	if (!virtqueue_is_packed(vq)) {
>  		kfree(vq->split.desc_state);
>  		kfree(vq->split.desc_extra);
>  	}
> @@ -2930,7 +3016,7 @@ u32 vring_notification_data(struct virtqueue *_vq)
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 next;
>  
> -	if (vq->packed_ring)
> +	if (virtqueue_is_packed(vq))
>  		next = (vq->packed.next_avail_idx &
>  				~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))) |
>  			vq->packed.avail_wrap_counter <<
> @@ -2983,7 +3069,8 @@ unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
>  
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
> +	return virtqueue_is_packed(vq) ? vq->packed.vring.num :
> +				      vq->split.vring.num;
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>  
> @@ -3066,7 +3153,7 @@ dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *_vq)
>  
>  	BUG_ON(!vq->we_own_ring);
>  
> -	if (vq->packed_ring)
> +	if (virtqueue_is_packed(vq))
>  		return vq->packed.ring_dma_addr;
>  
>  	return vq->split.queue_dma_addr;
> @@ -3079,7 +3166,7 @@ dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *_vq)
>  
>  	BUG_ON(!vq->we_own_ring);
>  
> -	if (vq->packed_ring)
> +	if (virtqueue_is_packed(vq))
>  		return vq->packed.driver_event_dma_addr;
>  
>  	return vq->split.queue_dma_addr +
> @@ -3093,7 +3180,7 @@ dma_addr_t virtqueue_get_used_addr(const struct virtqueue *_vq)
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


