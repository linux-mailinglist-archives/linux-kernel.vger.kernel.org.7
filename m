Return-Path: <linux-kernel+bounces-747823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE11FB138CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8299C7A6C86
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899382571C3;
	Mon, 28 Jul 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aulm8M/e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03B256C61
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697874; cv=none; b=RaeZj8IudBLAYwns02HR1Khrl5be7weStShhxJh+IgAbygQoMohoh0T/KCZP7HZJKbO/cqktNdgLSXDcN1QeemwoZk7ykKif2/oDmXxP0Hk0fM4tCd36BeYHH1Rc1rRG6OkRAPMuXi1b1NoV9u/GUmt+buGrUUHccEddHtdCUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697874; c=relaxed/simple;
	bh=QaZIUNMr6QnrJmwjJy1t9FTW66kKqVG2z248gDQeB38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGyAfUP7Onz1pCGJInYyaC39T8ZOia6tbShTozsDh2Xjgbf1lqerMguJeKHa/VcT2mdMG6ArA++llUu+8ojeu0rJj4rVdDfuSPsDKxfFlty8WxUPq46rjckGS0ph216tsVt0Pol2lUpg96/Ak54Gf51OPGKuG5oSv6+JgSmP+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aulm8M/e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753697870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLumxm7SJModMsb2ONwBWX1XY0bPumaaFmE6qUfDbVk=;
	b=aulm8M/eKbcukiICaS/ZAr02xak/3fMf73GAarKhpS5kEY9xmV96yvh9RZgN8XvmsGG/Cw
	1uqcrtNSntHGOyL4/hy/fx8LWj3GbkZr30paxvuypk1PKSokgPpgQjzRTdvB7pUxE8McdV
	DGGSnisyqOiWoZD8HF7HVT0ZTNEFyb4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-tS5EByaUPrObmfoW90od7g-1; Mon, 28 Jul 2025 06:17:49 -0400
X-MC-Unique: tS5EByaUPrObmfoW90od7g-1
X-Mimecast-MFC-AGG-ID: tS5EByaUPrObmfoW90od7g_1753697868
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7892c42b7so601907f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 03:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753697867; x=1754302667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLumxm7SJModMsb2ONwBWX1XY0bPumaaFmE6qUfDbVk=;
        b=oURsRgU4KWEKWFWciSt55QomhTlkDKsjp/NFo2P7wupJV0YDGOTR7pq0sdR09cMAC3
         nJzwlYHNvPaEyssIKHZmGvxta4N0ZJbIsPMClP98E8N9YV4kQ+0dN4muxqaAAgOODdJg
         CFn0Wmxc9rVnYiJEfd77/gKy2I5Du/IaU5LOQKLUWx9+B5DPS/DZIiliipvClV0+b464
         s53G5rmr3tJi7C0f0kUfyWXJZuZZPN1OOBxE+9WXc1Fnq8CJYQqDcDu/D/VmHvtZwW0W
         Ksjro9uonvt14acWZSx31q8Z50mNvk4Xkm7n/gvmbTTXZBtleb5SJQdj2Wwfd4Jp3vXV
         xaUA==
X-Forwarded-Encrypted: i=1; AJvYcCU334Wo6IbJnIPRH0+4gE1vkl9Oc4R0PaTRjS3M0Jl8SFWAuKKsxLwcVtq7bETI+LlUsD3xnQ7qswKXojQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxic8wuZJSEikCirkrJ+Nu742FQkH6IyYqY4Qf4KOxZGL6xeZ
	0z7mLumJttN+PECjps+FJ/FJ2GsenmyYqnghVc0ktt7BE7P0CiHgb0K3urEPxxb1OFPNM5+v2xh
	ikqItdqAhZ3zujHPIf+3+fdbGNHVeXd8b1u/EUgrCcCcEkdJVq0ffR+xXAT4eHFbGMU6no7ZlIg
	==
X-Gm-Gg: ASbGnctHmzMISr0AFXu7l6Gq4dpi8ZmF8C4K94s5ce+vjR27uYN0Yq7A/gJurlCpysL
	LCCjwdC73aKUJNYwu5VqEM2vJun5YJtaPNUL1cVBX/3fgqCQV4wswOuLPi8rp3vwFZUbGVTXkZ+
	M9ElfQI2whY2p/fo2+vwa3weczhzcLCACeWEizyl7H5j8k1MlNRGHqGPpG3wpT0kcHcaIfHg/2R
	MpkujVbNQaxKmqufBIE5wmiBteHykRlZXjps1bx/j1wFCPC1uFpQyG3fzeIW3mKkA7YRxnS+m0J
	gDOmMPUjEqOMAqbuznA218OGybGt5H/C
X-Received: by 2002:a5d:5f8e:0:b0:3a4:e480:b5df with SMTP id ffacd0b85a97d-3b7766808a4mr8473938f8f.44.1753697867241;
        Mon, 28 Jul 2025 03:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhh7phFe0D11JH3DsWxFbfzKWp5SovRp3+9FddJ/sqQmyWH6zLIpyGML7fzPxQTBqw+SZKIQ==
X-Received: by 2002:a5d:5f8e:0:b0:3a4:e480:b5df with SMTP id ffacd0b85a97d-3b7766808a4mr8473900f8f.44.1753697866460;
        Mon, 28 Jul 2025 03:17:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78ae720f5sm1294026f8f.81.2025.07.28.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 03:17:45 -0700 (PDT)
Date: Mon, 28 Jul 2025 06:17:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] virtio_ring: add in order support
Message-ID: <20250728060823-mutt-send-email-mst@kernel.org>
References: <20250728064129.32382-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728064129.32382-1-jasowang@redhat.com>

On Mon, Jul 28, 2025 at 02:41:29PM +0800, Jason Wang wrote:
> This patch implements in order support for both split virtqueue and
> packed virtqueue. Perfomance could be gained for the device where the
> memory access could be expensive (e.g vhost-net or a real PCI device):
> 
> Benchmark with KVM guest:
> 
> Vhost-net on the host: (pktgen + XDP_DROP):
> 
>          in_order=off | in_order=on | +%
>     TX:  5.20Mpps     | 6.20Mpps    | +19%
>     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> 
> Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> 
> For split virtqueue:
> 
>          in_order=off | in_order=on | +%
>     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
>     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> 
> For packed virtqueue:
> 
>          in_order=off | in_order=on | +%
>     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
>     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> 
> Benchmark also shows no performance impact for in_order=off for queue
> size with 256 and 1024.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since V4:
> - Fix build error when DEBUG is enabled
> - Fix function duplications
> - Remove unnecessary new lines
> ---
> drivers/virtio/virtio_ring.c | 421 +++++++++++++++++++++++++++++++++--
>  1 file changed, 401 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index e675d8305dbf..c6558e271f97 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -70,11 +70,14 @@
>  enum vq_layout {
>  	SPLIT = 0,
>  	PACKED,
> +	SPLIT_IN_ORDER,
> +	PACKED_IN_ORDER,
>  	VQ_TYPE_MAX,
>  };


how about specifying the #s here?
  	SPLIT = 0,
  	PACKED = 1,
 	IN_ORDER = 2,
 	SPLIT_IN_ORDER = 2,
 	PACKED_IN_ORDER = 3,
  	VQ_TYPE_MAX,

and then

  static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq)
  {
 	return vq->layout & PACKED;
 }

 static inline bool virtqueue_is_in_order(const struct vring_virtqueue *vq)
 {
 	return vq->layout & IN_ORDER;
  }

which is a tiny bit less code. 

worth doing?

>  
>  struct vring_desc_state_split {
>  	void *data;			/* Data for callback. */
> +	u32 total_len;			/* Buffer Length */
>  
>  	/* Indirect desc table and extra table, if any. These two will be
>  	 * allocated together. So we won't stress more to the memory allocator.


this is only used for in_order, and it increases the struct size
by half due to padding. why not a separate struct?
Or if you like, reuse vring_desc_state_packed - it is same
size with this addition.


> @@ -84,6 +87,7 @@ struct vring_desc_state_split {
>  
>  struct vring_desc_state_packed {
>  	void *data;			/* Data for callback. */
> +	u32 total_len;			/* Buffer Length */
>  
>  	/* Indirect desc table and extra table, if any. These two will be
>  	 * allocated together. So we won't stress more to the memory allocator.

there's empty space at the end of this struct.
struct vring_desc_state_packed {
        void *data;                     /* Data for callback. */
        u32 total_len;                  /* Buffer Length */

        /* Indirect desc table and extra table, if any. These two will be
         * allocated together. So we won't stress more to the memory allocator.
         */
        struct vring_packed_desc *indir_desc;
        u16 num;                        /* Descriptor list length. */
        u16 last;                       /* The last desc state in a list. */
};

why not put it there?




> @@ -206,6 +210,17 @@ struct vring_virtqueue {
>  
>  	/* Head of free buffer list. */
>  	unsigned int free_head;
> +
> +	/*
> +	 * With IN_ORDER, devices write a single used ring entry with
> +	 * the id corresponding to the head entry of the descriptor chain
> +	 * describing the last buffer in the batch
> +	 */
> +	struct used_entry {
> +		u32 id;
> +		u32 len;
> +	} batch_last;
> +
>  	/* Number we've added since last sync. */
>  	unsigned int num_added;
>  
> @@ -259,7 +274,12 @@ static void vring_free(struct virtqueue *_vq);
>  
>  static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq)
>  {
> -	return vq->layout == PACKED;
> +	return vq->layout == PACKED || vq->layout == PACKED_IN_ORDER;
> +}
> +
> +static inline bool virtqueue_is_in_order(const struct vring_virtqueue *vq)
> +{
> +	return vq->layout == SPLIT_IN_ORDER || vq->layout == PACKED_IN_ORDER;
>  }
>  
>  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> @@ -571,6 +591,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
>  	unsigned int i, n, avail, descs_used, err_idx, c = 0;
> +	/* Total length for in-order */
> +	unsigned int total_len = 0;
>  	int head;
>  	bool indirect;
>  
> @@ -642,6 +664,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  						     ++c == total_sg ?
>  						     0 : VRING_DESC_F_NEXT,
>  						     premapped);
> +			total_len += len;
>  		}
>  	}
>  	for (; n < (out_sgs + in_sgs); n++) {
> @@ -659,6 +682,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  				i, addr, len,
>  				(++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>  				VRING_DESC_F_WRITE, premapped);
> +			total_len += len;
>  		}
>  	}
>  
> @@ -681,7 +705,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	vq->vq.num_free -= descs_used;
>  
>  	/* Update free pointer */
> -	if (indirect)
> +	if (virtqueue_is_in_order(vq)) {
> +		vq->free_head += descs_used;
> +		if (vq->free_head >= vq->split.vring.num)
> +			vq->free_head -= vq->split.vring.num;
> +		vq->split.desc_state[head].total_len = total_len;;
> +	} else if (indirect)
>  		vq->free_head = vq->split.desc_extra[head].next;
>  	else
>  		vq->free_head = i;
> @@ -854,6 +883,14 @@ static bool more_used_split(const struct vring_virtqueue *vq)
>  	return virtqueue_poll_split(vq, vq->last_used_idx);
>  }
>  
> +static bool more_used_split_in_order(const struct vring_virtqueue *vq)
> +{
> +	if (vq->batch_last.id != vq->packed.vring.num)
> +		return true;
> +
> +	return virtqueue_poll_split(vq, vq->last_used_idx);
> +}
> +
>  static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  					 unsigned int *len,
>  					 void **ctx)
> @@ -911,6 +948,73 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  	return ret;
>  }
>  
> +static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
> +						  unsigned int *len,
> +						  void **ctx)
> +{
> +	void *ret;
> +	unsigned int num = vq->split.vring.num;
> +	u16 last_used;
> +
> +	START_USE(vq);
> +
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return NULL;
> +	}
> +
> +	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> +
> +	if (vq->batch_last.id == num) {
> +		if (!more_used_split(vq)) {
> +			pr_debug("No more buffers in queue\n");
> +			END_USE(vq);
> +			return NULL;
> +		}
> +
> +		/* Only get used array entries after they have been
> +		 * exposed by host. */
> +		virtio_rmb(vq->weak_barriers);
> +		vq->batch_last.id = virtio32_to_cpu(vq->vq.vdev,
> +				    vq->split.vring.used->ring[last_used].id);
> +		vq->batch_last.len = virtio32_to_cpu(vq->vq.vdev,
> +				     vq->split.vring.used->ring[last_used].len);
> +	}
> +
> +	if (vq->batch_last.id == last_used) {
> +		vq->batch_last.id = num;
> +		*len = vq->batch_last.len;
> +	} else
> +		*len = vq->split.desc_state[last_used].total_len;
> +
> +	if (unlikely(last_used >= num)) {
> +		BAD_RING(vq, "id %u out of range\n", last_used);
> +		return NULL;
> +	}
> +	if (unlikely(!vq->split.desc_state[last_used].data)) {
> +		BAD_RING(vq, "id %u is not a head!\n", last_used);
> +		return NULL;
> +	}
> +
> +	/* detach_buf_split clears data, so grab it now. */
> +	ret = vq->split.desc_state[last_used].data;
> +	detach_buf_split_in_order(vq, last_used, ctx);
> +
> +	vq->last_used_idx++;
> +	/* If we expect an interrupt for the next entry, tell host
> +	 * by writing event index and flush out the write before
> +	 * the read in the next get_buf call. */
> +	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +		virtio_store_mb(vq->weak_barriers,
> +				&vring_used_event(&vq->split.vring),
> +				cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx));
> +
> +	LAST_ADD_TIME_INVALID(vq);
> +
> +	END_USE(vq);
> +	return ret;
> +}
> +
>  static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
>  {
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
> @@ -1004,7 +1108,10 @@ static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
>  			continue;
>  		/* detach_buf_split clears data, so grab it now. */
>  		buf = vq->split.desc_state[i].data;
> -		detach_buf_split(vq, i, NULL);
> +		if (virtqueue_is_in_order(vq))
> +			detach_buf_split_in_order(vq, i, NULL);
> +		else
> +			detach_buf_split(vq, i, NULL);
>  		vq->split.avail_idx_shadow--;
>  		vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
>  				vq->split.avail_idx_shadow);
> @@ -1067,6 +1174,7 @@ static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
>  
>  	/* Put everything in free lists. */
>  	vq->free_head = 0;
> +	vq->batch_last.id = vq->split.vring.num;
>  }
>  
>  static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_split)
> @@ -1177,7 +1285,6 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  	if (!vq)
>  		return NULL;
>  
> -	vq->layout = SPLIT;
>  	vq->vq.callback = callback;
>  	vq->vq.vdev = vdev;
>  	vq->vq.name = name;
> @@ -1197,6 +1304,8 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>  		!context;
>  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> +	vq->layout = virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
> +		     SPLIT_IN_ORDER : SPLIT;
>  
>  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>  		vq->weak_barriers = false;
> @@ -1360,13 +1469,14 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  					 unsigned int in_sgs,
>  					 void *data,
>  					 bool premapped,
> -					 gfp_t gfp)
> +					 gfp_t gfp,
> +					 u16 id)
>  {
>  	struct vring_desc_extra *extra;
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
> -	unsigned int i, n, err_idx, len;
> -	u16 head, id;
> +	unsigned int i, n, err_idx, len, total_len = 0;
> +	u16 head;
>  	dma_addr_t addr;
>  
>  	head = vq->packed.next_avail_idx;
> @@ -1384,8 +1494,6 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	}
>  
>  	i = 0;
> -	id = vq->free_head;
> -	BUG_ON(id == vq->packed.vring.num);
>  
>  	for (n = 0; n < out_sgs + in_sgs; n++) {
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> @@ -1405,6 +1513,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  				extra[i].flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
>  			}
>  
> +			total_len += len;
>  			i++;
>  		}
>  	}
> @@ -1458,6 +1567,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = desc;
>  	vq->packed.desc_state[id].last = id;
> +	vq->packed.desc_state[id].total_len = total_len;
>  
>  	vq->num_added += 1;
>  
> @@ -1510,8 +1620,11 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>  	BUG_ON(total_sg == 0);
>  
>  	if (virtqueue_use_indirect(vq, total_sg)) {
> +		id = vq->free_head;
> +		BUG_ON(id == vq->packed.vring.num);
>  		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> -						    in_sgs, data, premapped, gfp);
> +						    in_sgs, data, premapped,
> +						    gfp, id);
>  		if (err != -ENOMEM) {
>  			END_USE(vq);
>  			return err;
> @@ -1632,6 +1745,152 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>  	return -EIO;
>  }
>  
> +static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
> +						struct scatterlist *sgs[],
> +						unsigned int total_sg,
> +						unsigned int out_sgs,
> +						unsigned int in_sgs,
> +						void *data,
> +						void *ctx,
> +						bool premapped,
> +						gfp_t gfp)
> +{
> +	struct vring_packed_desc *desc;
> +	struct scatterlist *sg;
> +	unsigned int i, n, c, err_idx, total_len = 0;
> +	__le16 head_flags, flags;
> +	u16 head, avail_used_flags;
> +	int err;
> +
> +	START_USE(vq);
> +
> +	BUG_ON(data == NULL);
> +	BUG_ON(ctx && vq->indirect);
> +
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return -EIO;
> +	}
> +
> +	LAST_ADD_TIME_UPDATE(vq);
> +
> +	BUG_ON(total_sg == 0);
> +
> +	if (virtqueue_use_indirect(vq, total_sg)) {
> +		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> +						    in_sgs, data, premapped, gfp,
> +						    vq->packed.next_avail_idx);
> +		if (err != -ENOMEM) {
> +			END_USE(vq);
> +			return err;
> +		}
> +
> +		/* fall back on direct */
> +	}
> +
> +	head = vq->packed.next_avail_idx;
> +	avail_used_flags = vq->packed.avail_used_flags;
> +
> +	WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
> +
> +	desc = vq->packed.vring.desc;
> +	i = head;
> +
> +	if (unlikely(vq->vq.num_free < total_sg)) {
> +		pr_debug("Can't add buf len %i - avail = %i\n",
> +			 total_sg, vq->vq.num_free);
> +		END_USE(vq);
> +		return -ENOSPC;
> +	}
> +
> +	c = 0;
> +	for (n = 0; n < out_sgs + in_sgs; n++) {
> +		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> +			dma_addr_t addr;
> +			u32 len;
> +
> +			if (vring_map_one_sg(vq, sg, n < out_sgs ?
> +					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
> +					     &addr, &len, premapped))
> +				goto unmap_release;
> +
> +			flags = cpu_to_le16(vq->packed.avail_used_flags |
> +				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
> +				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> +			if (i == head)
> +				head_flags = flags;
> +			else
> +				desc[i].flags = flags;
> +
> +
> +			desc[i].addr = cpu_to_le64(addr);
> +			desc[i].len = cpu_to_le32(len);
> +			desc[i].id = cpu_to_le16(head);
> +
> +			if (unlikely(vq->use_dma_api)) {
> +				vq->packed.desc_extra[i].addr = premapped ?
> +				      DMA_MAPPING_ERROR: addr;
> +				vq->packed.desc_extra[i].len = len;
> +				vq->packed.desc_extra[i].flags =
> +					le16_to_cpu(flags);
> +			}
> +
> +			if ((unlikely(++i >= vq->packed.vring.num))) {
> +				i = 0;
> +				vq->packed.avail_used_flags ^=
> +					1 << VRING_PACKED_DESC_F_AVAIL |
> +					1 << VRING_PACKED_DESC_F_USED;
> +				vq->packed.avail_wrap_counter ^= 1;
> +			}
> +
> +			total_len += len;
> +		}
> +	}
> +
> +	/* We're using some buffers from the free list. */
> +	vq->vq.num_free -= total_sg;
> +
> +	/* Update free pointer */
> +	vq->packed.next_avail_idx = i;
> +
> +	/* Store token. */
> +	vq->packed.desc_state[head].num = total_sg;
> +	vq->packed.desc_state[head].data = data;
> +	vq->packed.desc_state[head].indir_desc = ctx;
> +	vq->packed.desc_state[head].total_len = total_len;
> +
> +	/*
> +	 * A driver MUST NOT make the first descriptor in the list
> +	 * available before all subsequent descriptors comprising
> +	 * the list are made available.
> +	 */
> +	virtio_wmb(vq->weak_barriers);
> +	vq->packed.vring.desc[head].flags = head_flags;
> +	vq->num_added += total_sg;
> +
> +	pr_debug("Added buffer head %i to %p\n", head, vq);
> +	END_USE(vq);
> +
> +	return 0;
> +
> +unmap_release:
> +	err_idx = i;
> +	i = head;
> +	vq->packed.avail_used_flags = avail_used_flags;
> +
> +	for (n = 0; n < total_sg; n++) {
> +		if (i == err_idx)
> +			break;
> +		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[i]);
> +		i++;
> +		if (i >= vq->packed.vring.num)
> +			i = 0;
> +	}
> +
> +	END_USE(vq);
> +	return -EIO;
> +}
> +
>  static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  {
>  	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
> @@ -1792,10 +2051,81 @@ static void update_last_used_idx_packed(struct vring_virtqueue *vq,
>  				cpu_to_le16(vq->last_used_idx));
>  }
>  
> +static bool more_used_packed_in_order(const struct vring_virtqueue *vq)
> +{
> +	if (vq->batch_last.id != vq->packed.vring.num)
> +		return true;
> +
> +	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
> +}
> +
> +static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqueue *vq,
> +						   unsigned int *len,
> +						   void **ctx)
> +{
> +	unsigned int num = vq->packed.vring.num;
> +	u16 last_used, last_used_idx;
> +	bool used_wrap_counter;
> +	void *ret;
> +
> +	START_USE(vq);
> +
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return NULL;
> +	}
> +
> +	last_used_idx = vq->last_used_idx;
> +	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
> +	last_used = packed_last_used(last_used_idx);
> +
> +	if (vq->batch_last.id == num) {
> +		if (!more_used_packed(vq)) {
> +			pr_debug("No more buffers in queue\n");
> +			END_USE(vq);
> +			return NULL;
> +		}
> +		/* Only get used elements after they have been exposed by host. */
> +		virtio_rmb(vq->weak_barriers);
> +		vq->batch_last.id =
> +			le16_to_cpu(vq->packed.vring.desc[last_used].id);
> +		vq->batch_last.len =
> +			le32_to_cpu(vq->packed.vring.desc[last_used].len);
> +	}
> +
> +	if (vq->batch_last.id == last_used) {
> +		vq->batch_last.id = num;
> +		*len = vq->batch_last.len;
> +	} else
> +		*len = vq->packed.desc_state[last_used].total_len;
> +
> +	if (unlikely(last_used >= num)) {
> +		BAD_RING(vq, "id %u out of range\n", last_used);
> +		return NULL;
> +	}
> +	if (unlikely(!vq->packed.desc_state[last_used].data)) {
> +		BAD_RING(vq, "id %u is not a head!\n", last_used);
> +		return NULL;
> +	}
> +
> +	/* detach_buf_packed clears data, so grab it now. */
> +	ret = vq->packed.desc_state[last_used].data;
> +	detach_buf_packed_in_order(vq, last_used, ctx);
> +
> +	update_last_used_idx_packed(vq, last_used, last_used,
> +				    used_wrap_counter);
> +
> +	LAST_ADD_TIME_INVALID(vq);
> +
> +	END_USE(vq);
> +	return ret;
> +}
> +
>  static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>  					  unsigned int *len,
>  					  void **ctx)
>  {
> +	unsigned int num = vq->packed.vring.num;
>  	u16 last_used, id, last_used_idx;
>  	bool used_wrap_counter;
>  	void *ret;
> @@ -1822,7 +2152,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>  	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
>  	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
>  
> -	if (unlikely(id >= vq->packed.vring.num)) {
> +	if (unlikely(id >= num)) {
>  		BAD_RING(vq, "id %u out of range\n", id);
>  		return NULL;
>  	}
> @@ -1963,7 +2293,7 @@ static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *vq)
>  			continue;
>  		/* detach_buf clears data, so grab it now. */
>  		buf = vq->packed.desc_state[i].data;
> -		detach_buf_packed(vq, i, NULL);
> +		detach_buf_packed_in_order(vq, i, NULL);
>  		END_USE(vq);
>  		return buf;
>  	}
> @@ -1989,6 +2319,8 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
>  	for (i = 0; i < num - 1; i++)
>  		desc_extra[i].next = i + 1;
>  
> +	desc_extra[num - 1].next = 0;
> +
>  	return desc_extra;
>  }
>  
> @@ -2120,8 +2452,12 @@ static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
>  {
>  	vq->packed = *vring_packed;
>  
> -	/* Put everything in free lists. */
> -	vq->free_head = 0;
> +	if (virtqueue_is_in_order(vq))
> +		vq->batch_last.id = vq->split.vring.num;
> +	else {
> +		/* Put everything in free lists. */
> +		vq->free_head = 0;
> +	}
>  }
>  
>  static void virtqueue_reset_packed(struct vring_virtqueue *vq)
> @@ -2168,13 +2504,14 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>  #else
>  	vq->broken = false;
>  #endif
> -	vq->layout = PACKED;
>  	vq->dma_dev = dma_dev;
>  	vq->use_dma_api = vring_use_dma_api(vdev);
>  
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>  		!context;
>  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> +	vq->layout = virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
> +		     PACKED_IN_ORDER : PACKED;
>  
>  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>  		vq->weak_barriers = false;
> @@ -2284,9 +2621,39 @@ static const struct virtqueue_ops packed_ops = {
>  	.reset = virtqueue_reset_packed,
>  };
>  
> +static const struct virtqueue_ops split_in_order_ops = {
> +	.add = virtqueue_add_split,
> +	.get = virtqueue_get_buf_ctx_split_in_order,
> +	.kick_prepare = virtqueue_kick_prepare_split,
> +	.disable_cb = virtqueue_disable_cb_split,
> +	.enable_cb_delayed = virtqueue_enable_cb_delayed_split,
> +	.enable_cb_prepare = virtqueue_enable_cb_prepare_split,
> +	.poll = virtqueue_poll_split,
> +	.detach_unused_buf = virtqueue_detach_unused_buf_split,
> +	.more_used = more_used_split_in_order,
> +	.resize = virtqueue_resize_split,
> +	.reset = virtqueue_reset_split,
> +};
> +
> +static const struct virtqueue_ops packed_in_order_ops = {
> +	.add = virtqueue_add_packed_in_order,
> +	.get = virtqueue_get_buf_ctx_packed_in_order,
> +	.kick_prepare = virtqueue_kick_prepare_packed,
> +	.disable_cb = virtqueue_disable_cb_packed,
> +	.enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
> +	.enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
> +	.poll = virtqueue_poll_packed,
> +	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
> +	.more_used = more_used_packed_in_order,
> +	.resize = virtqueue_resize_packed,
> +	.reset = virtqueue_reset_packed,
> +};
> +
>  static const struct virtqueue_ops *const all_ops[VQ_TYPE_MAX] = {
>  	[SPLIT] = &split_ops,
> -	[PACKED] = &packed_ops
> +	[PACKED] = &packed_ops,
> +	[SPLIT_IN_ORDER] = &split_in_order_ops,
> +	[PACKED_IN_ORDER] = &packed_in_order_ops,
>  };
>  
>  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
> @@ -2342,6 +2709,12 @@ static int virtqueue_enable_after_reset(struct virtqueue *_vq)
>  	case PACKED:							\
>  		ret = all_ops[PACKED]->op(vq, ##__VA_ARGS__);		\
>  		break;							\
> +	case SPLIT_IN_ORDER:						\
> +		ret = all_ops[SPLIT_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
> +		break;							\
> +	case PACKED_IN_ORDER:						\
> +		ret = all_ops[PACKED_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
> +		break;							\
>  	default:							\
>  		BUG();							\
>  		break;							\
> @@ -2358,10 +2731,16 @@ static int virtqueue_enable_after_reset(struct virtqueue *_vq)
>  	case PACKED:					\
>  		all_ops[PACKED]->op(vq, ##__VA_ARGS__);	\
>  		break;					\
> -	default:					\
> -		BUG();					\
> -		break;					\
> -	}						\
> +	case SPLIT_IN_ORDER:						\
> +		all_ops[SPLIT_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
> +		break;							\
> +	case PACKED_IN_ORDER:						\
> +		all_ops[PACKED_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
> +		break;							\
> +	default:							\
> +		BUG();							\
> +		break;							\
> +	}								\
>  })
>  
>  static inline int virtqueue_add(struct virtqueue *_vq,
> @@ -3076,6 +3455,8 @@ void vring_transport_features(struct virtio_device *vdev)
>  			break;
>  		case VIRTIO_F_NOTIFICATION_DATA:
>  			break;
> +		case VIRTIO_F_IN_ORDER:
> +			break;
>  		default:
>  			/* We don't understand this bit. */
>  			__virtio_clear_bit(vdev, i);
> -- 
> 2.39.5


