Return-Path: <linux-kernel+bounces-593805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C128A801F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 13:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62FD3B8773
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74171266EFB;
	Tue,  8 Apr 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAjlIYxQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C0263C78
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112225; cv=none; b=sI8lwvhq15HkCT5nJxiA7hSMisgTF6MH80G3W9bJ6aOmMRVqkbdn/IAbabnu61z9oDCWY84tKg64HrWseDGV2VUnH8bzlQN3fMvL08MnSSq9X2C/UNz4jKIoMdVhODLnpuxeUFvlo2rKv+JgzVhjUKuCO5SZReHaOQuyMrSL0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112225; c=relaxed/simple;
	bh=9s3L86w3tciUYe4psZappCfNDi/qGVH4vUq7so5fIYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz+4JiDZRGoh1Sm6wM9YWH6u5UrUAQNElOSHnm92R+zYANjx9LR9omOz2KKQ4TyvvLKbtCsxbeGJxaCuf8gOpV04thCXMQ1Sc+zEG+IVnizCV27+03b8Thb5HsGe4L5kIEJzXhg9r4LhZ2xQ33f+YXZSMbJwqsBAqnOGaQDYRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAjlIYxQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744112222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cn8oAI1Xv630WkLxowzeUqJr8VFrC4TI+Nd+Uqm5SUI=;
	b=MAjlIYxQaV1UgOkFzQkCaH61c+RZ8NBQNtakBRrKPXQ9tveDjzkiKA+k19dD2FUs3akgkh
	G3A7seNjjOqHEg8pMaS+rAxAWMw1Mt/hCPDK9yqZRYn97r4B+C9Ldp9kS/FM9Sa8mNFlJz
	hDuAN2fdDMCZ4Z6VkMvqGP8H1upuR30=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-qr-nLgxzPZObhOrxFoJCgQ-1; Tue, 08 Apr 2025 07:37:00 -0400
X-MC-Unique: qr-nLgxzPZObhOrxFoJCgQ-1
X-Mimecast-MFC-AGG-ID: qr-nLgxzPZObhOrxFoJCgQ_1744112219
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso36295855e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 04:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744112219; x=1744717019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cn8oAI1Xv630WkLxowzeUqJr8VFrC4TI+Nd+Uqm5SUI=;
        b=qofBGz9pFSlRDYcae3IOwCzH3qeGhPVe6d3TS/2sQ6RWHLoC5DjhQ9nxJrhhrVirCN
         fxczE9YEpuyP2sFQup2+AQ0m884DlsXDJZjKxcxArlsLuWsARhg2+9hEOXr83cGEzUxl
         LiM9PCzWF73mbOsfzhiZiwjJnaN6k+KjaXK8lFZ9RvfgfOFUsRgAsWACGSQ7rw751Db6
         dkoeDt7s5A3PALnoJJxzWgOWYgir1f68xTm7BFFaC0MshpJUJqjzpv0mLvDg65mRPPtO
         s+EJ1wK+8keWT73BMPML8AN9qBWcO0YcG8sQdGlXx5PZDfN9fqIYQzF4mlTGySQO308P
         YM+A==
X-Forwarded-Encrypted: i=1; AJvYcCUtathTmlzZ3sG3QPFtiZpz2VlBRIulbhfljVXCtS18sTDdgY2grYKGemDl4am84xI4VgU9TbXxpE75s3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+xzlyh9VlZY7bdXdRmo2c2Y2jTMj8Zq/jrAwj+P+6aVgiuJw
	NwwNd70ea2uUJDNra/XLE6vFe8qbXIAe8OZhyaXPFT2avaa22Jxlsw8gSIbC22HJrPN8za4RBjx
	IEWFoRqYNCQhiB75j4F7OGgId6L4NOgusud+//deY8WaY/EnOqMhHYaoI/oUcl6OgMOjNXA==
X-Gm-Gg: ASbGnctHxm5B9HsNkADSEQ67GxltPBSlbxBwrNpYncbEjdiO7copq1wbpQtMr8EwyB/
	eTTKnXuIx6ExcHNf525cNke3VRDrtZayEUgvxCvqsKMLZRu1T9jGcToT73Fx+zJNGJQu1+DEIZV
	3zREM1W7Zvnv/4mKgRSjlp4iwxPMesf5qp1Jgl1qGrmc1HU/ydTIAMKBB8MT80qGs+OgZQYYIP0
	SNPQtwgZobs2WKnGNU9cu32vzh+ryzkNQjQs8x1OOiyunpAKY3ganQbIte86ppQ3UfQohCjMvnK
	yKDtvM1MQw==
X-Received: by 2002:a05:600c:5494:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43ecfa04a99mr114813535e9.28.1744112219036;
        Tue, 08 Apr 2025 04:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkdd9XDHZH69wpZWmKlgMrLox4ZlFp0C8zW/kcglEMyDCZY1oLA2xMCYRrwZ1w1FPWZTxnjA==
X-Received: by 2002:a05:600c:5494:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43ecfa04a99mr114813315e9.28.1744112218570;
        Tue, 08 Apr 2025 04:36:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7225sm14608667f8f.26.2025.04.08.04.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:36:57 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:36:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/19] virtio_ring: introduce virtqueue ops
Message-ID: <20250408073317-mutt-send-email-mst@kernel.org>
References: <20250324054333.1954-1-jasowang@redhat.com>
 <20250324060127.2358-1-jasowang@redhat.com>
 <20250407041729-mutt-send-email-mst@kernel.org>
 <CACGkMEv-=V0a7jpR9e-i=Oe+PE9pN_cH3yDBmyOYhwPcJXOHPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv-=V0a7jpR9e-i=Oe+PE9pN_cH3yDBmyOYhwPcJXOHPQ@mail.gmail.com>

On Tue, Apr 08, 2025 at 03:02:35PM +0800, Jason Wang wrote:
> On Mon, Apr 7, 2025 at 4:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Mar 24, 2025 at 02:01:21PM +0800, Jason Wang wrote:
> > > This patch introduces virtqueue ops which is a set of the callbacks
> > > that will be called for different queue layout or features. This would
> > > help to avoid branches for split/packed and will ease the future
> > > implementation like in order.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> >
> >
> >
> > > ---
> > >  drivers/virtio/virtio_ring.c | 96 +++++++++++++++++++++++++-----------
> > >  1 file changed, 67 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index a2884eae14d9..ce1dc90ee89d 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -159,9 +159,30 @@ struct vring_virtqueue_packed {
> > >       size_t event_size_in_bytes;
> > >  };
> > >
> > > +struct vring_virtqueue;
> > > +
> > > +struct virtqueue_ops {
> > > +     int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[],
> > > +                unsigned int total_sg, unsigned int out_sgs,
> > > +                unsigned int in_sgs, void *data,
> > > +                void *ctx, bool premapped, gfp_t gfp);
> > > +     void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void **ctx);
> > > +     bool (*kick_prepare)(struct vring_virtqueue *vq);
> > > +     void (*disable_cb)(struct vring_virtqueue *vq);
> > > +     bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> > > +     unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
> > > +     bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx);
> > > +     void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> > > +     bool (*more_used)(const struct vring_virtqueue *vq);
> > > +     int (*resize)(struct vring_virtqueue *vq, u32 num);
> > > +     void (*reset)(struct vring_virtqueue *vq);
> > > +};
> >
> > I like it that it's organized but
> > I worry about the overhead of indirect calls here.
> 
> We can switch to use INDIRECT_CALL_X() here

If you think it's cleaner.. but INDIRECT_CALL is all chained
while a switch can do a binary search.


> (but I'm not sure we
> should worry about it too much as ndo_ops or qdiscs doesn't use that).


And that's why we ended up with xdp, no? the stack's too heavy ...

> > How about a switch statement instead?
> >
> > struct vring_virtqueue {
> >         enum vring_virtqueue_ops ops;
> >
> > }
> >
> >
> > @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
> >  {
> >       struct vring_virtqueue *vq = to_vvq(_vq);
> >
> >         switch (vq->ops) {
> >          VQ_PACKED:
> >          VQ_SPLIT:
> >          VQ_IN_ORDER:
> >         }
> >
> >
> > }
> >
> >
> > What do you think?
> 
> Actually, the matrix will be 2*2:
> 
> PACKED, SPLIT, PACKED_IN_ORDER, SPLIT_IN_ORDER

Confused. Same amount of enums as ops structures in your approach, no?


> And will be doubled if a new layout is implemented.
> 
> If we open them such a switch will spread in a lot of places in the code.
> 
> Thanks
> 
> >
> >
> >
> > > +
> > >  struct vring_virtqueue {
> > >       struct virtqueue vq;
> > >
> > > +     struct virtqueue_ops *ops;
> > > +
> > >       /* Is this a packed ring? */
> > >       bool packed_ring;
> > >
> > > @@ -1116,6 +1137,8 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
> > >       return 0;
> > >  }
> > >
> > > +struct virtqueue_ops split_ops;
> > > +
> > >  static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
> > >                                              struct vring_virtqueue_split *vring_split,
> > >                                              struct virtio_device *vdev,
> > > @@ -1134,6 +1157,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
> > >               return NULL;
> > >
> > >       vq->packed_ring = false;
> > > +     vq->ops = &split_ops;
> > >       vq->vq.callback = callback;
> > >       vq->vq.vdev = vdev;
> > >       vq->vq.name = name;
> > > @@ -2076,6 +2100,8 @@ static void virtqueue_reset_packed(struct vring_virtqueue *vq)
> > >       virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
> > >  }
> > >
> > > +struct virtqueue_ops packed_ops;
> > > +
> > >  static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
> > >                                              struct vring_virtqueue_packed *vring_packed,
> > >                                              struct virtio_device *vdev,
> > > @@ -2107,6 +2133,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
> > >       vq->broken = false;
> > >  #endif
> > >       vq->packed_ring = true;
> > > +     vq->ops = &packed_ops;
> > >       vq->dma_dev = dma_dev;
> > >       vq->use_dma_api = vring_use_dma_api(vdev);
> > >
> > > @@ -2194,6 +2221,34 @@ static int virtqueue_resize_packed(struct vring_virtqueue *vq, u32 num)
> > >       return -ENOMEM;
> > >  }
> > >
> > > +struct virtqueue_ops split_ops = {
> > > +     .add = virtqueue_add_split,
> > > +     .get = virtqueue_get_buf_ctx_split,
> > > +     .kick_prepare = virtqueue_kick_prepare_split,
> > > +     .disable_cb = virtqueue_disable_cb_split,
> > > +     .enable_cb_delayed = virtqueue_enable_cb_delayed_split,
> > > +     .enable_cb_prepare = virtqueue_enable_cb_prepare_split,
> > > +     .poll = virtqueue_poll_split,
> > > +     .detach_unused_buf = virtqueue_detach_unused_buf_split,
> > > +     .more_used = more_used_split,
> > > +     .resize = virtqueue_resize_split,
> > > +     .reset = virtqueue_reset_split,
> > > +};
> > > +
> > > +struct virtqueue_ops packed_ops = {
> > > +     .add = virtqueue_add_packed,
> > > +     .get = virtqueue_get_buf_ctx_packed,
> > > +     .kick_prepare = virtqueue_kick_prepare_packed,
> > > +     .disable_cb = virtqueue_disable_cb_packed,
> > > +     .enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
> > > +     .enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
> > > +     .poll = virtqueue_poll_packed,
> > > +     .detach_unused_buf = virtqueue_detach_unused_buf_packed,
> > > +     .more_used = more_used_packed,
> > > +     .resize = virtqueue_resize_packed,
> > > +     .reset = virtqueue_reset_packed,
> > > +};
> > > +
> > >  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
> > >                                        void (*recycle)(struct virtqueue *vq, void *buf))
> > >  {
> > > @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
> > >  {
> > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -     return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
> > > -                                     out_sgs, in_sgs, data, ctx, premapped, gfp) :
> > > -                              virtqueue_add_split(vq, sgs, total_sg,
> > > -                                     out_sgs, in_sgs, data, ctx, premapped, gfp);
> > > +     return vq->ops->add(vq, sgs, total_sg,
> > > +                         out_sgs, in_sgs, data, ctx, premapped, gfp);
> > >  }
> > >
> > >  /**
> > > @@ -2437,8 +2490,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
> > >  {
> > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -     return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> > > -                              virtqueue_kick_prepare_split(vq);
> > > +     return vq->ops->kick_prepare(vq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
> > >
> > > @@ -2508,8 +2560,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
> > >  {
> > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -     return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
> > > -                              virtqueue_get_buf_ctx_split(vq, len, ctx);
> > > +     return vq->ops->get(vq, len, ctx);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> > >
> > > @@ -2531,10 +2582,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
> > >  {
> > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -     if (vq->packed_ring)
> > > -             virtqueue_disable_cb_packed(vq);
> > > -     else
> > > -             virtqueue_disable_cb_split(vq);
> > > +     return vq->ops->disable_cb(vq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> > >
> > > @@ -2557,8 +2605,7 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
> > >       if (vq->event_triggered)
> > >               vq->event_triggered = false;
> > >
> > > -     return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> > > -                              virtqueue_enable_cb_prepare_split(vq);
> > > +     return vq->ops->enable_cb_prepare(vq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> > >
> > > @@ -2579,8 +2626,7 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
> > >               return false;
> > >
> > >       virtio_mb(vq->weak_barriers);
> > > -     return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
> > > -                              virtqueue_poll_split(vq, last_used_idx);
> > > +     return vq->ops->poll(vq, last_used_idx);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_poll);
> > >
> > > @@ -2623,8 +2669,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
> > >       if (vq->event_triggered)
> > >               vq->event_triggered = false;
> > >
> > > -     return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> > > -                              virtqueue_enable_cb_delayed_split(vq);
> > > +     return vq->ops->enable_cb_delayed(vq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
> > >
> > > @@ -2640,14 +2685,13 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
> > >  {
> > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -     return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> > > -                              virtqueue_detach_unused_buf_split(vq);
> > > +     return vq->ops->detach_unused_buf(vq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> > >
> > >  static inline bool more_used(const struct vring_virtqueue *vq)
> > >  {
> > > -     return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
> > > +     return vq->ops->more_used(vq);
> > >  }
> > >
> > >  /**
> > > @@ -2785,10 +2829,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >       if (recycle_done)
> > >               recycle_done(_vq);
> > >
> > > -     if (vq->packed_ring)
> > > -             err = virtqueue_resize_packed(vq, num);
> > > -     else
> > > -             err = virtqueue_resize_split(vq, num);
> > > +     err = vq->ops->resize(vq, num);
> > >
> > >       return virtqueue_enable_after_reset(_vq);
> > >  }
> > > @@ -2822,10 +2863,7 @@ int virtqueue_reset(struct virtqueue *_vq,
> > >       if (recycle_done)
> > >               recycle_done(_vq);
> > >
> > > -     if (vq->packed_ring)
> > > -             virtqueue_reset_packed(vq);
> > > -     else
> > > -             virtqueue_reset_split(vq);
> > > +     vq->ops->reset(vq);
> > >
> > >       return virtqueue_enable_after_reset(_vq);
> > >  }
> > > --
> > > 2.42.0
> >


