Return-Path: <linux-kernel+bounces-826327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22B4B8E336
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBAA17E084
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722181E8324;
	Sun, 21 Sep 2025 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRHbxTH5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75A137C52
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479439; cv=none; b=O4AeRRADCvGkGiK3oa24hfUuloGeinzlH/4QNXE7gk/uanf1Jw9NNECCNOxhtjzs/l3WE2riVHhE57AJI9dhB5fmayMgQLoVFGd3ds8LpwuWNnioeadZR3CHdC+AaVNiopBhprE3FUWZ0k4lyj/Y2j1k3ooYvjJrv8sb/KnmPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479439; c=relaxed/simple;
	bh=PMDUKQQmZGqLpivLY4JWsbJn9ktkVyhHNKqEF0O+HkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5eu/pTBUAutU8nYouiIJy58/SZyIm6/cOyCsirNyzzDcssQscwS87LtKnJsx8ms9hkM3j+mBfIPH3mWVA3xC06IaHZPeMpHVerBG5Romm8faD9Ox98hFkp7mvyHs2fyji6EKul+7ctDd+eIaTXqYspcheWXF5rQfQ8V5qGMhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRHbxTH5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758479436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtLN1C8BH/iw2KBS7duzlUD7pYh8eLvynIT5XvElx4c=;
	b=XRHbxTH5oqOzRz22py7XXf2jJxfvnpK/uuihhAMGksoE832ByLlPyd5lxbSc3Vf/jgv8xR
	ZxbVjOv30rFNuFeuafWb2RFqDHL1Urlo0jOPXZ1DSB0lLxRYEZpGjNyi0zPUHV3g9y6dyg
	UHhzMWppa6bTPQDCTiiK9N9YyKt0iA8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-P2FDwadsMuOJ1OcXxw7j0A-1; Sun, 21 Sep 2025 14:30:33 -0400
X-MC-Unique: P2FDwadsMuOJ1OcXxw7j0A-1
X-Mimecast-MFC-AGG-ID: P2FDwadsMuOJ1OcXxw7j0A_1758479432
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ece14b9231so1722630f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479432; x=1759084232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtLN1C8BH/iw2KBS7duzlUD7pYh8eLvynIT5XvElx4c=;
        b=VaMctkJL3STNsvQq8PMKWHDQ4yTxasQ1NnGupvVa7s1bF657j/sC2ntN8AG9DvIAbW
         QtZ6ik2FYkKMMEc3zRFeUNzSVVKVHiWPhniKfdz8y1xcdLyG91P0M1RpbEvxYtGOK7mE
         oAVrumoQuIisE4rx7NbaX5FYWFPz6n2+DVfHCBBOfQ4s0aRZYGa0t16LHuk3XY/xGauY
         KN7YylXoK0Ew2s8NjiAT+FyRdpjrTdqtokhO8eKt6bcWO0F4FJqs70xLcLB/voWY2KOs
         a+v0KR5olJtkoqR8TxGvHXtp0/ZWYQGiHXiXP5FlmWvq+SzaOL5JojNFwCqjKo0c+iqf
         3wjA==
X-Forwarded-Encrypted: i=1; AJvYcCVSrsoj0vhvE1Ern4y6dQOx17Mto8V3/6r0Bma5P+j6q6jKXxXBzpk4jRPIoEcvz9w1mKnHVzq/myTpK+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ/tvLjaquP9IkoFifJDh/6Y3Hqui1jAB+V3ywJXUuIiu1bbAF
	O9o6KR54rug89zv4XHgjVI/ep8RgonwpIsB0wctJF/kbZayKl4scwCgsxwHY+NkHwzzHVJkqlOj
	1PvO0+YmF/M+MP/HwqGzzSNMCku2CM15KBosBoQ/lyBW6ZvTnjEBaAmX1DVVGiOeiTQ==
X-Gm-Gg: ASbGncsyNYGVE46qljL8s3bGB23DBlTw0I7A1vQklRNFnkIYnjkQrsKg0OaxdXkPmNH
	rWArRN7r4r5WnNJaXBE/FwOxYica53eFazqd8KgbNujEQeurMb81coAtObLO9lQnDQJk0fXXiyp
	Ra7aadpM/F+m/pQjPuZLeeV/OMEk6CqbLT4xjbQkitauiTS7+k0VXSQWzqJxKjz89ASMtqkOKI0
	9UFLoHR5xSs49F7vDECANCDNfBFA2/gMYL5IHNgOz6ShKFkX3nCee3F7v1mWyoFRzd8ms/zK0id
	oyYI8fg0BlVOM9lavuVURFjJbLVva+JZjy8=
X-Received: by 2002:a05:6000:4210:b0:3e7:6197:9947 with SMTP id ffacd0b85a97d-3ee868a74bamr9345044f8f.53.1758479431890;
        Sun, 21 Sep 2025 11:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3f4teE4HzWpOGKP+JaITqWsn77PVM6zJ/ttnb3obDGEXcGZ4GaGHy94uIwfy2e7Adqzj5HQ==
X-Received: by 2002:a05:6000:4210:b0:3e7:6197:9947 with SMTP id ffacd0b85a97d-3ee868a74bamr9345017f8f.53.1758479431238;
        Sun, 21 Sep 2025 11:30:31 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm128771735e9.3.2025.09.21.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:30:30 -0700 (PDT)
Date: Sun, 21 Sep 2025 14:30:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 17/19] virtio_ring: factor out split indirect
 detaching logic
Message-ID: <20250921143014-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-18-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919073154.49278-18-jasowang@redhat.com>

On Fri, Sep 19, 2025 at 03:31:52PM +0800, Jason Wang wrote:
> Factor out the split indirect descriptor detaching logic in order to
> make it be reused by the in order support.

and I think you mean "allow it to be reused"

> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f376f717c8e4..5aa0cd785362 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -771,11 +771,42 @@ static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
>  	return needs_kick;
>  }
>  
> +static void detach_indirect_split(struct vring_virtqueue *vq,
> +				  unsigned int head)
> +{
> +	struct vring_desc_extra *extra = vq->split.desc_extra;
> +	struct vring_desc *indir_desc =
> +	       vq->split.desc_state[head].indir_desc;
> +	unsigned int j;
> +	u32 len, num;
> +
> +	/* Free the indirect table, if any, now that it's unmapped. */
> +	if (!indir_desc)
> +		return;
> +	len = vq->split.desc_extra[head].len;
> +
> +	BUG_ON(!(vq->split.desc_extra[head].flags &
> +			VRING_DESC_F_INDIRECT));
> +	BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> +
> +	num = len / sizeof(struct vring_desc);
> +
> +	extra = (struct vring_desc_extra *)&indir_desc[num];
> +
> +	if (vq->use_map_api) {
> +		for (j = 0; j < num; j++)
> +			vring_unmap_one_split(vq, &extra[j]);
> +	}
> +
> +	kfree(indir_desc);
> +	vq->split.desc_state[head].indir_desc = NULL;
> +}
> +
>  static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  			     void **ctx)
>  {
>  	struct vring_desc_extra *extra;
> -	unsigned int i, j;
> +	unsigned int i;
>  	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>  
>  	/* Clear data ptr. */
> @@ -799,34 +830,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	/* Plus final descriptor */
>  	vq->vq.num_free++;
>  
> -	if (vq->indirect) {
> -		struct vring_desc *indir_desc =
> -				vq->split.desc_state[head].indir_desc;
> -		u32 len, num;
> -
> -		/* Free the indirect table, if any, now that it's unmapped. */
> -		if (!indir_desc)
> -			return;
> -		len = vq->split.desc_extra[head].len;
> -
> -		BUG_ON(!(vq->split.desc_extra[head].flags &
> -				VRING_DESC_F_INDIRECT));
> -		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> -
> -		num = len / sizeof(struct vring_desc);
> -
> -		extra = (struct vring_desc_extra *)&indir_desc[num];
> -
> -		if (vq->use_map_api) {
> -			for (j = 0; j < num; j++)
> -				vring_unmap_one_split(vq, &extra[j]);
> -		}
> -
> -		kfree(indir_desc);
> -		vq->split.desc_state[head].indir_desc = NULL;
> -	} else if (ctx) {
> +	if (vq->indirect)
> +		detach_indirect_split(vq, head);
> +	else if (ctx)
>  		*ctx = vq->split.desc_state[head].indir_desc;
> -	}
>  }
>  
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> -- 
> 2.31.1


