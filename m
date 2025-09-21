Return-Path: <linux-kernel+bounces-826309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D74B8E27F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC117DE88
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD5B254AFF;
	Sun, 21 Sep 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDqhmj7M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2648DF72
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476744; cv=none; b=GcbJcuFNJCrYz32tFYDSFfBmWf35pCJpRXtHEt8fgXxnuNNydJK3iExYeEF63pc2zTJOE/Z0sQmewLY8JhX58Jca1dEhPb/v2IfCoYtUnoX7IMli9rJywh/h6L1HUeyWzYF0Gh2dQZMdjpq/Mu16Kok0CziTtzCvJZVJTOb4wa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476744; c=relaxed/simple;
	bh=WwvQk40Glb4XvOASk1LFtrDjxeGKgX2muBFVQuxVnzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogGbNHs1tEtKz1vvYAiAz1LCmb7rM+4ugtetkyjeLlEnycEultx68bUKpEO/Gpe9Wp7/oxjsvR0RkwomUboR/RPX0hnZZmFMW7jI7l/NoWLGDstiszcwtYyb1g/GxSy2aB0cxO4U1vp6UhLOUhON7c4e4kU+5eIoA+OEuWR+BOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDqhmj7M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758476741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1OlVkMyWhOP7kDhR7luqdc21LW8/q1ATcp0AWEUEzQ=;
	b=XDqhmj7M9UE2NwtjzZEVfxEMtewUvI078P/ow9f4LheYMPT0KIq+yJfoDD52In9S2bC68I
	eLLAHRItFXqryZN2pbU8OjiBBaGu2re8ICr6QlLLuMyVX3KscWvry3kK/WpYi9h6EKM8EF
	F2LSca7FnqlBq2qYL0ivfy2+MFZa5EY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-hdR-hvr4N8m8IhrxZg-T0A-1; Sun, 21 Sep 2025 13:45:40 -0400
X-MC-Unique: hdR-hvr4N8m8IhrxZg-T0A-1
X-Mimecast-MFC-AGG-ID: hdR-hvr4N8m8IhrxZg-T0A_1758476739
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46b227bbf65so8546555e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758476739; x=1759081539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1OlVkMyWhOP7kDhR7luqdc21LW8/q1ATcp0AWEUEzQ=;
        b=XLcy8dyEbfilTLV0HAatWyozBkOfDToN3kMt/GpdzNXRhIboSC+UnrW6/10fOkNyQx
         I8tUAuItGJJhmnlMh7eFLU17AcxBRbhmDqapv2JQuzLxv170HRBD1vALBI4Kq7kunZRF
         kHxQKojyi+Kh9dHd564TYC06NarY0wo42Kah5ksNICe/D1n9Bam3UJSwuNOJiFKvh0N4
         ERgEnN50bgTPF4ryCOM5Vt2VzXg/YRkKlHMnuBIT09gRyTaEt2dkOUExcLcogHvRFY/O
         KNwSwk43HfbZFLz1NWYq2ypUhmSWHQY3Mr9JK9hK8xUbN1FlJj8/zTU0JRg+/QrmeN2D
         IXFg==
X-Forwarded-Encrypted: i=1; AJvYcCWPuZBPONYvyArSsrzgwlfWFkpkeWA1YXeCacKnHp62vAhlP0+zu7AAqCUuuDvChRSQ5ukMaWJ1AArcF/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDd/QpXkNGnV/33HLQjWvT63jerMzW6cZw97ToCwjiZHJIL8R
	DpGu8FKqyaC83uSR4LcSHtuPX0VKxjCT+REo84Pv7AcpDZSihiIgh4jxAZJyFuS1bNXomZicU7q
	k6xXofwnyurpOC7wqM6gfv5+qChuFEEE9yt1chCj+YaiU2ZK8rYxY0UU57+KShAAX3A==
X-Gm-Gg: ASbGncvObvIMMrpPsF8EWBcgZ+00GeYCpHwAbriD4LzEul9r1Vq3jocauA/iTmDt9Gb
	CvoFQXPHkVbJOaB7Uz7ka1EH5OnhW6AiP2SYnu2SPPCt96d9yXQa+k3wP0sTqfC3cZkUUZJiaKx
	Ao8/88/wYK6M6xrUIagtaG4tw/VEdfZ5bCns4Cm8hfgl+gckPvMtt76722Nc1ZMvURuzg4S3pGx
	l3Rvip3Lly6w0IzDLza8bC4TCGaSLC36KK34DFWQ0dfrEbNnsGNPoAn1GNfZ7qU6veIeFeGpf5c
	dh+CN/C4OKh29e7RD+IsVxLXRcz7M2BsjIA=
X-Received: by 2002:a05:600c:4714:b0:45b:615c:cd2 with SMTP id 5b1f17b1804b1-467e6b64fb2mr105330995e9.8.1758476738866;
        Sun, 21 Sep 2025 10:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGX5vkXsKpQyY2Ux5CBEzyb6byASk4h+/Il/pigqdryAM+E6y/7Hj/+4Dr77FNhLif4LWHAg==
X-Received: by 2002:a05:600c:4714:b0:45b:615c:cd2 with SMTP id 5b1f17b1804b1-467e6b64fb2mr105330815e9.8.1758476738249;
        Sun, 21 Sep 2025 10:45:38 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d5c1fc13dsm2586065e9.1.2025.09.21.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:45:37 -0700 (PDT)
Date: Sun, 21 Sep 2025 13:45:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 07/19] virtio: switch to use vring_virtqueue for
 virtqueue_add variants
Message-ID: <20250921134504-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-8-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919073154.49278-8-jasowang@redhat.com>

On Fri, Sep 19, 2025 at 03:31:42PM +0800, Jason Wang wrote:
> Those variants are used internally so let's switch to use
> vring_virtqueue as parameter to be consistent with other internal
> virtqueue helpers.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>


This one actually switches virtqueue_get_buf variants.

Previous one is for virtqueue_add



> ---
>  drivers/virtio/virtio_ring.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 93c36314b5e7..3625c7ed2fbb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -816,11 +816,10 @@ static bool more_used_split(const struct vring_virtqueue *vq)
>  	return virtqueue_poll_split(vq, vq->last_used_idx);
>  }
>  
> -static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  					 unsigned int *len,
>  					 void **ctx)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	void *ret;
>  	unsigned int i;
>  	u16 last_used;
> @@ -842,9 +841,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	virtio_rmb(vq->weak_barriers);
>  
>  	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> -	i = virtio32_to_cpu(_vq->vdev,
> +	i = virtio32_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->ring[last_used].id);
> -	*len = virtio32_to_cpu(_vq->vdev,
> +	*len = virtio32_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->ring[last_used].len);
>  
>  	if (unlikely(i >= vq->split.vring.num)) {
> @@ -866,7 +865,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
> -				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> +				cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx));
>  
>  	LAST_ADD_TIME_INVALID(vq);
>  
> @@ -1720,11 +1719,10 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
>  	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
>  }
>  
> -static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>  					  unsigned int *len,
>  					  void **ctx)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 last_used, id, last_used_idx;
>  	bool used_wrap_counter;
>  	void *ret;
> @@ -2524,8 +2522,8 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
> -				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
> +	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
> +				 virtqueue_get_buf_ctx_split(vq, len, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>  
> -- 
> 2.31.1


