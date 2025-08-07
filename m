Return-Path: <linux-kernel+bounces-759082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6657B1D830
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A0447A82FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AC0253F3A;
	Thu,  7 Aug 2025 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcLZcYf/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBE5695
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570767; cv=none; b=gZQY1zCsIFZJY3oy8LcfGLuZhZtI/0/YawUnLwyg+ILE8dEgRbpRgCzqalkFgPVtDxSG8/oQ9lFZxK+rUX//Ybsf13zMngVpZX5H99pgervvccmNcnReVVVCddU6ox8jyyQurQMCxPYmE9xCp/02aA5G0WGU8IMu0rEa+b3H0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570767; c=relaxed/simple;
	bh=SLMjRNqfRB8WZrmm7YlXu1OtnsSA4gA3+W+rAwXSIbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RresziEcvKeNR4wj8Z3EEKN3psxoL4V2XVFveZx5CYl9m5/4uxruNCP9Zm1LdRhg1rTDEUU3cx8f/5/QurF+HUlokBx21I4GqwsQvvt+jWWzEJDIvSd4F3IIu+le/Unifuys3ThQAGzjKUyqFzKWqvsfLiSbwObu7hFI9memIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcLZcYf/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754570763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzpyvLBCuDDbTq0I4txF+uqEBSf1omkOPXzrV+o5WA8=;
	b=VcLZcYf/VY4ER8rnTbkmRBxsBw6QOIY5FljOugws1PtK1LhY8g9FnmX680IlX4OO6N/nba
	KnP+JqeFq/mVrX3HV5Ucq96GUNH//tmkvngNkEDi0z8shJ/+0r4tgcgcJ66YsPL0MYnAQn
	3jIIPzOKYRX5ZdIZhFDIJJfM/ANsnjo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-nzYuGsPKMpGRxUoj3vZFug-1; Thu, 07 Aug 2025 08:46:01 -0400
X-MC-Unique: nzYuGsPKMpGRxUoj3vZFug-1
X-Mimecast-MFC-AGG-ID: nzYuGsPKMpGRxUoj3vZFug_1754570760
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459e0f54c88so5004775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 05:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754570760; x=1755175560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzpyvLBCuDDbTq0I4txF+uqEBSf1omkOPXzrV+o5WA8=;
        b=C6UinhL0Uw8HANc2udCA/7fpZ/KEXCrA5stg5V6lkyHzzKDaXqj4GnarlfngUToQZt
         fg7ja7i8aVvhlkxG0XM0lgE0YAnxSb6sHE3qYm250Uzj21UGpQxtx+/zNHmve469izqY
         yA6FIxw8JTD663y/ePn8SI6caLp1v12zuzCIk+8XNvbE8doEEzGBjphjOjtqBqUNyDbs
         +niefdNpJwedL3DdXfsgWkZqKNU16JqsOfUsZytXiOyoKzs1/+pSwVAx9WHJDYIrlXtn
         1WytHzNp0XcnRLZlOWKHsgbi0ViyNF/Bst172FjFQ3+w87IJ8Hrb7iFJxx44ISsgbYPV
         Ey/w==
X-Forwarded-Encrypted: i=1; AJvYcCWO8VpoqKe3cGTPrEqNQvDFdr4oCjdnOLfy46mnLR/xV/ai3Jb/jQ99rUhYPHu5Y2MzCwMMGeR5sYXH3f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBb5Plj7PnH/koDQGKUq3qKMCP2281f7wYiygysYncv0kEVqr
	a1ja0d+ZRbzMlJljjblGh+UiQEeJyOj4HJQamE2SigWmzBo1jg8G9M59UpsgqC3RdxA0WEFV+lh
	a7RX5FTr2plnTwDkpeeyjRa7O2yf9eCNDFS47EzcJkt1FwwlPD9GyBPug/i54XfHaXA==
X-Gm-Gg: ASbGncvx1uMjk61BLsDCsIjQaU2/wnRHlswTEU7XP44UhONoIIl5bSU2wY5lKyGqSeF
	mW0O5h6YkR+CaSRoABL+DNo9IQS7EhgqhhhX4yrja3X1RXD8J3wvXdVqE6/RAg1d2hFQF5t3UkI
	x0lkduZTCqnmv/F5TJe8D1Q79XpVUltqwbUKTJgA4JF27jhT7WGJx6ETx6atM5evmbUBysJIJXr
	PXUAnOqwJGdNw5Pu5y8CVx1DD2cBK1OKBoE30QgcCxGrzUcbzHR5RMSzLyRMBV0dfyRcgQGluJk
	l355A2Og0bJX0sZPUuJLeQkDSvkhqYnp
X-Received: by 2002:a05:600c:1c9c:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-459ee0a960dmr34279975e9.14.1754570760119;
        Thu, 07 Aug 2025 05:46:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbbXT1nYDpa11Vm4wjS1klHPpTOY7WS4UUDzDQqgWHSoXb4hnl8yYsbxcqS9wXeD7K7Y86cw==
X-Received: by 2002:a05:600c:1c9c:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-459ee0a960dmr34279735e9.14.1754570759734;
        Thu, 07 Aug 2025 05:45:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm26009083f8f.57.2025.08.07.05.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:45:59 -0700 (PDT)
Date: Thu, 7 Aug 2025 08:45:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Torrente <igor.torrente@collabora.com>
Cc: sami.md.ko@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, jasowang@redhat.com,
	dmitry.osipenko@collabora.com
Subject: Re: [PATCH] Revert "virtio: reject shm region if length is zero"
Message-ID: <20250807084310-mutt-send-email-mst@kernel.org>
References: <20250807124145.81816-1-igor.torrente@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807124145.81816-1-igor.torrente@collabora.com>

On Thu, Aug 07, 2025 at 09:41:45AM -0300, Igor Torrente wrote:
> This reverts commit 206cc44588f72b49ad4d7e21a7472ab2a72a83df.
> 

No that's not enough. Explain the why not the what.
for example

-------


The commit 206cc44588f7 ("virtio: reject shm region if length is zero")
breaks the Virtio-gpu `host_visible` feature.

As you can see in the snippet below, host_visible_region is zero because
of the `kzalloc`.  It's using the `vm_get_shm_region`
(drivers/virtio/virtio_mmio.c:536) to read the `addr` and `len` from
qemu/crosvm.

```
drivers/gpu/drm/virtio/virtgpu_kms.c
132         vgdev = drmm_kzalloc(dev, sizeof(struct virtio_gpu_device), GFP_KERNEL);
[...]
177         if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region,
178                                   VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
```
Now it always fails.

To fix, revert the offending commit.

Fixes: 206cc44588f7 ("virtio: reject shm region if length is zero` breaks the Virtio-gpu `host_visible")

-------

> Signed-off-by: Igor Torrente <igor.torrente@collabora.com>


> ---
>  include/linux/virtio_config.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b3e1d30c765b..169c7d367fac 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -329,8 +329,6 @@ static inline
>  bool virtio_get_shm_region(struct virtio_device *vdev,
>  			   struct virtio_shm_region *region, u8 id)
>  {
> -	if (!region->len)
> -		return false;
>  	if (!vdev->config->get_shm_region)
>  		return false;
>  	return vdev->config->get_shm_region(vdev, region, id);
> -- 
> 2.49.0


