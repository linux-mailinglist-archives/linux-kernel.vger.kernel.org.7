Return-Path: <linux-kernel+bounces-583581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5BEA77CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED7CC7A1D37
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D112046B2;
	Tue,  1 Apr 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9H71HUm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E2204680
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515864; cv=none; b=LUdkfpKiLHFR/y7MYI5CpL9kAMlaBi8UzuSZvgxZ9UUKEXQ36NWKUoz4KpBkopwYLq1eHcQC0hOTznc35YgBrAgYRt0M/N9GZpiO6Kkwcw5wXJ82COVwdB0KF2vuVwqSyL4372zZ7cLCa+WFyse4RjTRlYy8+NVex+pWXCMLwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515864; c=relaxed/simple;
	bh=Ei4o2YiJCXeec+uFKDsiydnj+4SkZPbIQelCXI4KKNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNISS4lcr176ph3ERJu88HRVzUUeJoUsm+MVjODk3jEwMetuJTy4dFtxrbNVLbN6tUoL9QzfowJgbr0SMTMvEWuOI+6NCxbskk/ysInbojduf6/9mYz1fRObS3v6ITRAOVIl3t8ngUzRW4nG4htKGM5phAR3OfGvc8TquRyOP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9H71HUm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743515861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nK9hIRueLujXj1So3EtFD3gYBWrgxP2wNV1sCqS84Xw=;
	b=U9H71HUmQsubaekBCr66HRJwKbVXaXEB5Hj1Lu884wmJpFx1061+DxamQFqcbWGq5caPWb
	bETu8Fyo9ohwqM5Bj/+PJyoV/xgcsSLfLuLTgKcQE6ihQ+hwXDGDFQaJLdmi/LADvhlvTl
	N6l9ubkCb/2FfW71a0UY0UEl7bE4MMw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-WuLj5_PaMqqHOYY989l02A-1; Tue, 01 Apr 2025 09:57:40 -0400
X-MC-Unique: WuLj5_PaMqqHOYY989l02A-1
X-Mimecast-MFC-AGG-ID: WuLj5_PaMqqHOYY989l02A_1743515856
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912fe32b08so3203985f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 06:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515856; x=1744120656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK9hIRueLujXj1So3EtFD3gYBWrgxP2wNV1sCqS84Xw=;
        b=Bt7mNeklGgxT0TwkHq0RgOvZjAOqlor/9FGS7+FOffUQvGkhpbQr/iK4VT2lmsAdYF
         1TfdjBdxfPd5gAleO87T64Q1UYnET+5HzYDhCmwQZ0XRryI8wLXuDrQNChmhUj9biJ81
         vS6H9itUr50XQBEewI5Xr/00sq3FuD2Nrrcq8BbSZ/kMglrPdHGhA8VsQ3FWxpm/9kL1
         ynKpVRV3qVkhmBwewNE5WYGYbjOGzGLtCr/auBPveG2OCue614HX9CTPNUQTI+2+ThPd
         hRa0qJGse7cqowhLHpdxMOAmtWbPsgob+9q179K3y1lXU8M0jnu3EqSQLNtZ203+0gy2
         PXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1bWos8Sj++Qr6B4YcTrfFXU8yzDDWB83DYe0/1yQ70JytkQJUEXKm01aD5DHNxAxPkhYeSK8Jrky/h3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwd4tggsG8BvmNjN6zQwL+kWNQjTw/HNBmWxDOBSb6/I88Q/U
	K7S370hALqDiZwdNGySLC3Ba7UbKqMAsB/vuGnJvpw/iH2SqNjZ2CvJbrMsiJfaZhIsrWczLjM7
	jvkj5DKCwEnlS4FBlNwO3aF6tqQuzf6jagc5ItV0mDbuuWxZ4J5em+ovsk79Vzg==
X-Gm-Gg: ASbGncs/BRxuibhdwCP81xkiFXGtvjCxEdhazigHxkfVWtqMQtmSI8bFVgiVCIKwOdh
	rekh5Js8lxg9Q9LfA/lrjpPrGyVf4VqTTVgmCSAw7WLXhi26tRR+45xY6xyybIRzTrsq7BAfwhf
	B7pOVb65ykkrqUv5Yv7/0X8fgwsdqFMhxcxEIfampvh+4eQTHQXme/xrms6EoAL10bZ8IlAfo25
	XLrFgrShgGT3SELxgXjxgyfe/juR3Rhg0mrrda5SORclVgydT/X1NE9nwI1mFEiG5p1kXqtBKdL
	zqTJZqUO3UGQYYZl3YjypA0Sg/AXnwGYaNiiIF0wrN8J9ceJejKC46sJyUY=
X-Received: by 2002:a05:6000:2913:b0:39a:ca59:a626 with SMTP id ffacd0b85a97d-39c120e3e5cmr11015548f8f.28.1743515856236;
        Tue, 01 Apr 2025 06:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgTZzKaL62iArCAHG5W6zUwy/3RjZmmIeQYPk9NlRX20WPMdkLbAFtCRU8EaAYV78xSkqWEQ==
X-Received: by 2002:a05:6000:2913:b0:39a:ca59:a626 with SMTP id ffacd0b85a97d-39c120e3e5cmr11015519f8f.28.1743515855788;
        Tue, 01 Apr 2025 06:57:35 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8314b5e7sm201779655e9.35.2025.04.01.06.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:57:35 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:57:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 6/8] vhost: uapi to control task mode (owner vs
 kthread)
Message-ID: <pgcopzs6q6kqwlmndtbt2bdpbj3xvosjjxb7vikte3gnt643xh@5qhv5myd2cpc>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-7-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250328100359.1306072-7-lulu@redhat.com>

On Fri, Mar 28, 2025 at 06:02:50PM +0800, Cindy Lu wrote:
>Add a new UAPI to configure the vhost device to use the kthread mode

nit: missing . at the end

>The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
>to choose between owner and kthread mode if necessary

Ditto

>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function

Ditto.

>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 22 ++++++++++++++++++++--
> include/uapi/linux/vhost.h | 16 ++++++++++++++++
> 2 files changed, 36 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index be97028a8baf..ff930c2e5b78 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1134,7 +1134,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> 	int i;
>
> 	vhost_dev_cleanup(dev);
>-
>+	dev->inherit_owner = true;
> 	dev->umem = umem;
> 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
> 	 * VQs aren't running.
>@@ -2287,7 +2287,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>-

As I mentioned, I'll add the Kconfig in this patch to avoid bisection 
issues.

The rest LGTM.

Thanks,
Stefano

>+	if (ioctl == VHOST_FORK_FROM_OWNER) {
>+		u8 inherit_owner;
>+		/*inherit_owner can only be modified before owner is set*/
>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		if (inherit_owner > 1) {
>+			r = -EINVAL;
>+			goto done;
>+		}
>+		d->inherit_owner = (bool)inherit_owner;
>+		r = 0;
>+		goto done;
>+	}
> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..1ae0917bfeca 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,20 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device,
>+ * This ioctl must called before VHOST_SET_OWNER.
>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1(default value):
>+ *   - Vhost will create tasks similar to processes forked from the owner,
>+ *     inheriting all of the owner's attributes.
>+ *
>+ * When inherit_owner is set to 0:
>+ *   - Vhost will create tasks as kernel thread.
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>+
> #endif
>-- 
>2.45.0
>


