Return-Path: <linux-kernel+bounces-861202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39243BF20D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088A44001AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440CC191F92;
	Mon, 20 Oct 2025 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsOIk6dh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160A354ADC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973504; cv=none; b=E2nhQ1fF0wMjUqnXUcjX2HqyJEBrIgMrcB4jJqtpFJcN2RlVb5oj7nR7N/AEtvqPk/4WQa9mWU/L1LvovS4oGsMnFuA4DQEFX4HiSoFXJI8/+9rX3b8lSOZ21FVlyTlFmfIp/TQF1JY00kzvgxD8/rv+eLHN0fvZrvCv+eRO5r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973504; c=relaxed/simple;
	bh=R8UYyT4mUt4Cb7l78TIXqfvb6Gy3loaTBotcwJd+Pp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joxKvKnJ8tBxpPOpUE/ez+LQGB3OZwxDpiPap5vOOO0QwYyAYsytKZuNjAv1R9gV5sp5PLrYjvxhl5UAwMmrsiI2c1v2GpkIZ2q2IFgxoTK77zLLondmPhdIVYipVp3hHXgeD7Ig7fg6yoCQcOJ3om4OgcdUxyiibWs+rcw9974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsOIk6dh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760973501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abiKkoYwk0LU0Chy1s73mlMtOEyiPZi25aoSUUGEVVI=;
	b=OsOIk6dhlSRdQmZCIOmN0tZGTHqMszMzz+KDTTOj+GSxBVvQl4523Or0oFpwXstpVCXykY
	kFM8GApP19L+fhUx8ZD1Onuay5gnOZUxckHL0Xr6cDc2kwRLSNhktE/of9ckDBLML72Tyh
	qnt6XyZwW+GQG3Y13j4S5eQUAUhH9Kw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-fYVNxLPnNtSOvChA-PzVaA-1; Mon, 20 Oct 2025 11:18:19 -0400
X-MC-Unique: fYVNxLPnNtSOvChA-PzVaA-1
X-Mimecast-MFC-AGG-ID: fYVNxLPnNtSOvChA-PzVaA_1760973494
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4710d174c31so48709375e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973493; x=1761578293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abiKkoYwk0LU0Chy1s73mlMtOEyiPZi25aoSUUGEVVI=;
        b=xN49zlHi1/KSkPX0WreXZQP9HVMi/FLjeMMD23qwddvgjZD4g2GNjD4mtZ+vasar2g
         7MphWQzCJqiJyx2XJ3qTZwkUiqEv6hiGgMUj5LqcS5BhuWyur/tnd4FJqVzsEyE1F/mw
         rDyRrwSJEUbUlKTPplDazDrhZBq/WBx8HE/9JfF5bLzucanonwOwbBTKHOGwFl1xVGeB
         KTL5AMTUEB98PKUIXu3NOjRcH/AJHK6Yh0T/SAqoi/cLUc+3VhrFBuHs8RWEnDJXNze0
         vLyJJe6AlMPqWA4BYtLPUzo3v2Tn/oh+4hM/eHg2M17KBUTtWa/Bt8oEccYmqU7BK4si
         8+4w==
X-Forwarded-Encrypted: i=1; AJvYcCXLvADwZQhabjz/Tzk8eKL+VaYk2nTYLz0gg94aJWsgpEp+YZjng3fhfsuHdNv55EXDpy9d2RqKOc4OSqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZPbprGtegCMd5L1nRUDiX6uy96sg/ACGpATRzbQYkjCpJAye
	jjzSytvOYKzoCT6l0r7MzGYHj7uNC2IW3vvHM8uWJWWa1Pgoalq7I4MLPJrGLIBwfDEtZMGwh3k
	3EaWK8CF2VN46Yo0Mm0RhsKWIgDN/l3JNsTylxv6EkEQUkDpkZ5ZyBpfrWY50IU29Cg==
X-Gm-Gg: ASbGncsi7Tf8DhBF2vRiO/ogJ7VoF2+N5P7OwW2vmPYnGhabZE0A005MPocfccfI/Pr
	EEeTuoEiqobpLW5camtaTaDShz1ZZWn403hTDJO2JSxkRhPdauyW27KeiOkT1OJTBMdwao5a60E
	a78wc5x43QiZkTlEcC/UVV0v4bzi4WYdcMZBjIUTolaGOty96DCKXO+TaGOThHjddLZgL6oWK8U
	6mlDfuWVBULa6HxwVCNRh1rElLzzmIaMPo6Tdv2szMBtDvaMJqoSmmnZcu5bxbKCYdX6maEqvhA
	AASZbfp2277lEQD6TNpWmN69pjqTHk8FSO6tuBQY8RAI1THeVDdfK1K95GxO4fLEuVbC
X-Received: by 2002:a05:600c:350b:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-4711791cd8fmr127221895e9.34.1760973493029;
        Mon, 20 Oct 2025 08:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwoVeE8+iKkdW6UYxdhmFrKR4TN/PEWt9sSgfJ9uAbOJbQBv4uJr+4CkF5F/sLf7VzK33szQ==
X-Received: by 2002:a05:600c:350b:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-4711791cd8fmr127221515e9.34.1760973492486;
        Mon, 20 Oct 2025 08:18:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9f9dsm15881960f8f.39.2025.10.20.08.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:18:12 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:18:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 18/19] virtio_ring: factor out split detaching logic
Message-ID: <20251020111413-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-19-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020071003.28834-19-jasowang@redhat.com>

On Mon, Oct 20, 2025 at 03:10:02PM +0800, Jason Wang wrote:
> This patch factors out the split core detaching logic that could be
> reused by in order feature into a dedicated function.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 0f07a6637acb..96d7f165ec88 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -802,8 +802,9 @@ static void detach_indirect_split(struct vring_virtqueue *vq,
>  	vq->split.desc_state[head].indir_desc = NULL;
>  }
>  
> -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> -			     void **ctx)
> +static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
> +					  unsigned int head,
> +					  void **ctx)


Well not really _inorder, right? This is a common function.
You want to call it __detach_buf_split or something maybe.

Additionally the very first line in there is:

        __virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);

and the byte swap is not needed for inorder.
you could just do __cpu_to_virtio16(true, VRING_DESC_F_NEXT)




>  {
>  	struct vring_desc_extra *extra;
>  	unsigned int i;
> @@ -824,8 +825,6 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	}
>  
>  	vring_unmap_one_split(vq, &extra[i]);
> -	vq->split.desc_extra[i].next = vq->free_head;
> -	vq->free_head = head;
>  
>  	/* Plus final descriptor */
>  	vq->vq.num_free++;
> @@ -834,6 +833,17 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  		detach_indirect_split(vq, head);
>  	else if (ctx)
>  		*ctx = vq->split.desc_state[head].indir_desc;
> +
> +	return i;
> +}
> +
> +static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> +			     void **ctx)
> +{
> +	unsigned int i = detach_buf_split_in_order(vq, head, ctx);
> +
> +	vq->split.desc_extra[i].next = vq->free_head;
> +	vq->free_head = head;
>  }
>  
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> -- 
> 2.31.1


