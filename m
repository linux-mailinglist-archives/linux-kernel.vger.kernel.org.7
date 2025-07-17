Return-Path: <linux-kernel+bounces-734664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13317B08481
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6411A65F76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA73C2036F3;
	Thu, 17 Jul 2025 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXSP8YNo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3628E7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732280; cv=none; b=DEag3a8jE62DNpQApTfZoK7rKmvSm3v2Q/k9j+uIX6GVw71FWmybKiMzQtQtF8SSY3QbUQgkIm/MNl8VeOdiEnbHPJUQ/MNB/zrBhvGN/25mKXdWfQOXgvvl0RiCj8A6pxM1B+Jn5RY593iuWobcJJaH1xuShxEAAy8Wh8M1UPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732280; c=relaxed/simple;
	bh=P3S2zvRoo7lQJ0ChcHfU5Ea5iDRhwpVODl4UsA4zdsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVfgcebTkTymgVH3HtbV5U87pBSsM42xIGUymGtOUUlqvcJHlYde6jkQVcI2/h37IQBp/A2sO/2uMQTJmAfz45NfBDr+lxupYr7Z+rvQ6W6M4+8x6C+9CoIbMEEYp4LL3lBxZ++eM2SwY8yPBtygRapUzXeRty4CA3Io+BYg0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXSP8YNo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752732277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tUkb4nCGAHcNyByaHU5iCpVWleaJyNw90ZAtHNo4HkE=;
	b=JXSP8YNo+m+8ITdVBAnBAa6UYBcS6tBAsn1hFa5PjIq2PsdPVmS3FuPRzCYinuj+biQ2P7
	O7N2WxA8y6SBRa23a95nCwz5q465KEzGNRDKr/GwV5BYDYeqmgnm9/1HMdarGF2dUoSgPX
	hd/EKrpK6NuYmXVMlsUG4sfowDS7sTM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-uH4f_Nq8NvCskeVoS4Rk5w-1; Thu, 17 Jul 2025 02:04:36 -0400
X-MC-Unique: uH4f_Nq8NvCskeVoS4Rk5w-1
X-Mimecast-MFC-AGG-ID: uH4f_Nq8NvCskeVoS4Rk5w_1752732275
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so5254035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752732275; x=1753337075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUkb4nCGAHcNyByaHU5iCpVWleaJyNw90ZAtHNo4HkE=;
        b=rf1zTlLJhA/5ntintMhuBC+tAbkqyJzPQS7wwtLcB2/e3WOxaK5QcCIXownB4Puk/w
         ezvnW2DGTKoDBJUo/3UyK9dF916ekbxwToAVuzqu/uIAKWh32Y1hARB4iJ79uLJfUMtF
         HYsW/KCzTqD6DCXR4O/Ylh8Y11y0GtSNBGeeQ6YjJxzHKvGoR2ugREbrl/u+IF4UchHE
         /kf3ewjimOrcfoblNYWz9WT20jS3dFoo7O+gzj5Cv3nJoXI0Jb8nFRPcAI/ACK93tBBg
         y/238nIpjLVE9qjJv5RXZ1E6NJUPAnNRRQxIiatXXTKsPXauVZXL/XGfc0AycTMIn0m1
         1REg==
X-Forwarded-Encrypted: i=1; AJvYcCUng4rRD9klqlz2NsKTN6lZP6iZFlv7Iskrr/w2seht3Sc6l1d/7MMQqIYQHCvlWWnkGSQkEme1GqqybXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjNfRJGn7+ngqs+fNktX1Dg6vnCvlTRTqGcjwv3H8d723dsw7
	2y9gTgBaLQpxfLNjKucwaosqtL8y9K0k25eiIs1EJzhHmUn/RrSW5UaN3wKd78dYwzWzAkgZXTr
	bS4fvUEhmkCWyl9KlvkKPbb9gTx8ESHeV3JRmScykvUlRM9g0fv8lCtew0rUfzQu6AA==
X-Gm-Gg: ASbGncsch9K/m3LuCDov3SMAzh+HrHiAMCpF1tqlAcaHTsO0fhALfsD38twVBVo08p3
	bWO4Kcny/cZmQOc7T9y0X5QS0FtVBl4dMEpor0L0tne4d065sEFyuifFg6h0QdDTiNh0UCJBJDQ
	rqBQuhL3Ji2f9A2A/z0PE9z1od5LeKwjpw8aPNvObT7ovQ7mt8ARpSS0lsW/i0/unPOlTJtKwUE
	6NCjIBKurAWQXDvZMPj03jKCRSSKPkgagUxFx33ziifc5I60+ExO+z+1J5HvraBxBTwE7OMcOPY
	h6MhskIVQ+NSDU3wTA+DcJL3hcgbOCw4
X-Received: by 2002:a05:600c:a55:b0:456:1442:854 with SMTP id 5b1f17b1804b1-4562e28616amr46679075e9.24.1752732274621;
        Wed, 16 Jul 2025 23:04:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjrUfFCvAdm/MUeAz0hpuBCDwLEyQ3RVRuTxAsQFHlPQhXRkgs7ZoZlJruFXtXCDIWxuHA8Q==
X-Received: by 2002:a05:600c:a55:b0:456:1442:854 with SMTP id 5b1f17b1804b1-4562e28616amr46678735e9.24.1752732274082;
        Wed, 16 Jul 2025 23:04:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f5ea01sm11589685e9.14.2025.07.16.23.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:04:33 -0700 (PDT)
Date: Thu, 17 Jul 2025 02:04:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: jiang.peng9@zte.com.cn
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	sumit.semwal@linaro.org, christian.koenig@amd.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v3] virtio: Update kerneldoc in
 drivers/virtio/virtio_dma_buf.c
Message-ID: <20250717015524-mutt-send-email-mst@kernel.org>
References: <202507171041593886W7pGra5n2hPMaT1j17NV@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507171041593886W7pGra5n2hPMaT1j17NV@zte.com.cn>

On Thu, Jul 17, 2025 at 10:41:59AM +0800, jiang.peng9@zte.com.cn wrote:
> From: Peng Jiang <jiang.peng9@zte.com.cn>
> 
> Fix kernel-doc descriptions in virtio_dma_buf.c to fix W=1 warnings:
> 
> drivers/virtio/virtio_dma_buf.c:41 function parameter 'dma_buf' not described in 'virtio_dma_buf_attach'
> drivers/virtio/virtio_dma_buf.c:41 function parameter 'attach' not described in 'virtio_dma_buf_attach'
> 
> Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
> ---
>  drivers/virtio/virtio_dma_buf.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> index 3fe1d03b0645..986cc73c503f 100644
> --- a/drivers/virtio/virtio_dma_buf.c
> +++ b/drivers/virtio/virtio_dma_buf.c
> @@ -16,6 +16,8 @@
>   * This wraps dma_buf_export() to allow virtio drivers to create a dma-buf
>   * for an virtio exported object that can be queried by other virtio drivers
>   * for the object's UUID.
> + *
> + * Returns: dma-buf pointer on success, ERR_PTR on failure.

Most people write "dmabuf".


>   */
>  struct dma_buf *virtio_dma_buf_export
>         (const struct dma_buf_export_info *exp_info)
> @@ -36,6 +38,14 @@ EXPORT_SYMBOL(virtio_dma_buf_export);
> 
>  /**
>   * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
> + * @dma_buf: DMA buffer being attached to a device

And here it's different for some reason.

> + * @attach: Attachment metadata for the device-dma_buf association

and here in a third form.

> + *
> + * Allows virtio devices to perform device-specific setup when a DMA buffer
> + * is attached to a device. This is part of the DMA-BUF sharing mechanism
> + * that enables virtio devices to interoperate with other subsystems.

I'm sorry this is just empty of content.
I can not shake the feeling this is AI written.
If we wanted AI to document all APIs in this way, I'd just script it.

> + *
> + * Returns: 0 on success, negative on failure.

This one is ok.

>   */
>  int virtio_dma_buf_attach(struct dma_buf *dma_buf,
>                           struct dma_buf_attachment *attach)
> -- 
> 2.25.1


