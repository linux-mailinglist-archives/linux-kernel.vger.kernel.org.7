Return-Path: <linux-kernel+bounces-861912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CC3BF3FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B3A426011
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963B52F619A;
	Mon, 20 Oct 2025 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rp161r8S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015802D979F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001616; cv=none; b=lY7d4De8nbKAW2uzz319Mai6Br7SrZFV3g+5/6QFaT6wd/AnzfZ8sEewzMcduvNBTwf8Ut/MMCuuFpVPVgQHa6rypMcwHxcFKtv2qyemrthaQzGBO2aALsZleD1Ukc1/cu+k8XCZ+dQVZAR3/8s4CDdlnDW5t1eut8S4LhhV87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001616; c=relaxed/simple;
	bh=WOamq/8NTrRJ6lJQJ2kGQKI3k7GTITbOcQoS4hwx+3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwZ4oL1chwqbom/ijKAAhN91Bh64z981PYg3WHtLhTvUe7FRDVtNH3huqTOc8/66lXgkUE8Aa4IPhWIFDlQiIqPT5Z7A8FeHaE1S83j+pcxQ6rIcmAdoTwimHO7NikVK1EXci+lphJge4nFcY6GGRHm+j/Ni3YTAE9TcXSMhx+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rp161r8S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761001613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yadhvA4ZuoYMPNwq6F4mNtP+XLX9TmfXDYE8mlqAeoM=;
	b=Rp161r8SphdNHbB1w/9Zn0eX0KE2VvPeadoXBLDoH4B3TW4Ggc33kFx5xPX93KfgMIXfIo
	aRSD2Mv0Rz4gJUQf5cDoTwDqBMJs4o6IrHDHVWF3wNwkQaEENISL+rLCEUHR7iCvQEMZsR
	NHJIoC+/23iZg54xZ05osg03a30ZQDU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-SyJK4Pn9Ov6uoKgyLeu2pg-1; Mon, 20 Oct 2025 19:06:51 -0400
X-MC-Unique: SyJK4Pn9Ov6uoKgyLeu2pg-1
X-Mimecast-MFC-AGG-ID: SyJK4Pn9Ov6uoKgyLeu2pg_1761001610
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4721b4f3afbso10728195e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761001610; x=1761606410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yadhvA4ZuoYMPNwq6F4mNtP+XLX9TmfXDYE8mlqAeoM=;
        b=DhpqVyB9leDb9hZVfgkbPSmKQEpmnAnKPUuBc2MOBddb2n5swvnwHVAAS+1DntAXqZ
         vPLwo1tGLdEY8+j6rvJZYGyMouZA2eFENz9/LzRbg8diobla0j3KERu/KJeTFBkzeYn2
         cuWpX3BRFiuuinh2b1cKQkFbhsgFZ1Y/txwXybirLQN67UVspg8AfhsSNe1acvH/tmsP
         xY9JoeDawDJruQAEjY1aIOTOEKZoIc/FS3K51XR/TqzziFQTDh+u3WfB16OGJjeZHSl6
         j5n/MeMjx7GaBcZ37YXMQCmqvA4CeBFVtJVdADX8g/0SlnkhhYO836al+2/SmSzmZyYN
         FE0g==
X-Forwarded-Encrypted: i=1; AJvYcCXdY1X6PibPyJ9kf/eEF/YcmbawR9Y5vLHxAEuVTJmCwN8Vu3EACtYbDdTAJ/27ruc8VZcSYtZLfljzt8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6sd6et28cnjCIGrVYhz15GOYwrTmbPloCsCH7ohGO0IOT0ucM
	Krv5yj+KnmvRZxrEJZ1FrJXabwdiys9acJhNokHYba2agAipoV5kBO2UX8QCTG7pIxn/8oo2Jt1
	LuTs4clFhtZZgZ0s2GuvagW2nmD8ML/KHjZNDDc8XJ1cSy/SQHiWn4F687f/I7t9DdA==
X-Gm-Gg: ASbGncu5VLv+2bIIcxeYRcyB0UFkHHEYca5CygiyqL1zsLYfsq8TRHBaFeJNmL8Qu51
	/OyHPrFxfPS4csieRZKU5FGIgub6ZaCmSUBnanSvkazZ/PqHYN4RMNORrY5WHFSfjOiQ29BS1PK
	h3TuV13iLn48AAqp6Ogz9K94f0JwavgmTyaNkD8WQfp5G82ncGpIkFPUW91sHXyHiSQZZv2gXs2
	4gFwaS+mpmDNIZlEHfcPS7dQ6/xFlk5+nPJUlZbI5SSn/aMzGybh0GGU1rHJbURYOzg5ymD5DiC
	xsKaiMmPFl+hImNmEZxQIhRJAv5dUoEQMVBeV4sa2zKJh5nmyUJHgnG+TRaCxZXv7cyL
X-Received: by 2002:a05:600c:8b03:b0:46e:41b0:f0cb with SMTP id 5b1f17b1804b1-4711790c57amr116010325e9.25.1761001610028;
        Mon, 20 Oct 2025 16:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF22YnS0c4s1OTo1hseU2hGEMN8vRo6HAvsbGEUP5hVKEl3u1SlCcU+fRoWFkUMK+1iwOOIw==
X-Received: by 2002:a05:600c:8b03:b0:46e:41b0:f0cb with SMTP id 5b1f17b1804b1-4711790c57amr116010165e9.25.1761001609538;
        Mon, 20 Oct 2025 16:06:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442d3ddsm246071025e9.5.2025.10.20.16.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:06:48 -0700 (PDT)
Date: Mon, 20 Oct 2025 19:06:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 15/19] virtio_ring: factor out core logic of buffer
 detaching
Message-ID: <20251020190537-mutt-send-email-mst@kernel.org>
References: <20250925103708.44589-1-jasowang@redhat.com>
 <20250925103708.44589-16-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925103708.44589-16-jasowang@redhat.com>

On Thu, Sep 25, 2025 at 06:37:04PM +0800, Jason Wang wrote:
> Factor out core logic of buffer detaching and leave the id population


"id population" here really means "free list management".


> to the caller so in order can just call the core logic.


in order -> in_order


> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fc04cdb99706..4b01c26f83b9 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1661,8 +1661,8 @@ static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  	return needs_kick;
>  }
>  
> -static void detach_buf_packed(struct vring_virtqueue *vq,
> -			      unsigned int id, void **ctx)
> +static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
> +				       unsigned int id, void **ctx)
>  {
>  	struct vring_desc_state_packed *state = NULL;
>  	struct vring_packed_desc *desc;
> @@ -1673,8 +1673,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	/* Clear data ptr. */
>  	state->data = NULL;
>  
> -	vq->packed.desc_extra[state->last].next = vq->free_head;
> -	vq->free_head = id;
>  	vq->vq.num_free += state->num;
>  
>  	if (unlikely(vq->use_map_api)) {
> @@ -1711,6 +1709,17 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	}
>  }
>  
> +static void detach_buf_packed(struct vring_virtqueue *vq,
> +			      unsigned int id, void **ctx)
> +{
> +	struct vring_desc_state_packed *state = &vq->packed.desc_state[id];
> +
> +	vq->packed.desc_extra[state->last].next = vq->free_head;
> +	vq->free_head = id;
> +
> +	detach_buf_packed_in_order(vq, id, ctx);
> +}
> +
>  static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  				       u16 idx, bool used_wrap_counter)
>  {
> -- 
> 2.31.1


