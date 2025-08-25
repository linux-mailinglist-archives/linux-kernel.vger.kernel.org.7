Return-Path: <linux-kernel+bounces-784991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC0B3447B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E06162754
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16F2EE619;
	Mon, 25 Aug 2025 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYab47A3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B14279918
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132924; cv=none; b=UEFhxxAe0mN3uLkfzoEMHRxOGGvhhdX2A5jYH+WqRFxTnmtYClVGwmY0WuItWWPfmD9eYWBgP0OHawvPCQ3xyFH6MkBwg8O8VpOO96RqrC8yfxOm+tGjTw4iCHp1Tijai8C0ihgTlLKFi9wD9AeRz+LddcDO7YDPSfBq2BMYAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132924; c=relaxed/simple;
	bh=dY2BC24LcOwPmwCFWjqjdFx0LB0w2liGu7oqHI05kJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMykKjuXwkizdsE2gSSm8whbno+ElpRbi7RysyDeqmM11MkbEaqXqjrL1uD5VrADWncftJQxKmI1FXFWxyzjBRpB214XRQlfBYZyEhvbUKIP13KTjApmyMDRBXXv8VnGBmkkCAYbroS+c5bP+WjJWKik7IGrycSVvr+B/ZCYOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYab47A3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756132921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLqi3ZQ4Qq7GjJJBZEDnBdmpcriLiuWuU+N614GqayQ=;
	b=MYab47A3TUePDS5cKDHuueOOpoCdfpZO7VUkEgaHpv90fm2FlVIeZJkxsEUsRE9GIHAXeK
	Kh6DU/dVtOiTmuw1EA4JnrIKheZekFhk6k84+IXNeTgXk76CrlOomuAVSJFvBh8jb3sltT
	FE1crvZ8GVRvyvZuWQmu4VUQIVZH5QY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-30KAuqcPMw6N9giJJvR9Hg-1; Mon, 25 Aug 2025 10:42:00 -0400
X-MC-Unique: 30KAuqcPMw6N9giJJvR9Hg-1
X-Mimecast-MFC-AGG-ID: 30KAuqcPMw6N9giJJvR9Hg_1756132920
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ec9adc1255so2517205ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132920; x=1756737720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLqi3ZQ4Qq7GjJJBZEDnBdmpcriLiuWuU+N614GqayQ=;
        b=hFoJkel6Wqn9FBy5uJRrIVkmiGs6kXyg1UnU4nccMvIfSLjAr76g8vUCAzobQdfXQd
         M8AhYc4sFBhZ2KXBkRHUn+BuZO8Uc1DUFIZxcp0kxCRjDOl6ndz7REZISwRqEVl9uddi
         ZJZtq112n+WOinEj59em/OLblnJvnEtI9v3BGLZBzSsbPGVVooGCZC2bMTYlZ6gXWbyo
         axcFst1w1IENyqS/lIdfF5fgZ/hNySAhxt9Td5oVeEZVScBVYy9MX1zWzIirDCeDdpWj
         Ue1dmp5eX3/rRzFLR3DVMZ8IjfXRQD4cAJB1D0HkMch4f23R9yVtlbccJoKJev+73Taw
         wnGg==
X-Forwarded-Encrypted: i=1; AJvYcCWK2e5OkTv6E63Y7VNV7ywW1XTkOQDLD4yVnq1YKdj936+12eVJ4PsTHBHjVbfz1IHIPOuUaM+zLDcTeTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+8eKhRxW8D15OwlUwymqX7Cv4PAlE99lWFs9r2NCaFyl08mH
	4yoyyCwo/aTiJi2TUYfrR6nvakbKs9UNUBBhDv1hnnrEtgcmpc4TU9rsQ7fQ05SJw8EAGR84wzF
	8J10W6oL9wMPMJUT6I/3Gnt0hg2eDFwP+ooww9MJk3Juum2BY6TF+xgfu8hf1w/ofAQ==
X-Gm-Gg: ASbGncsGSA9Mc8LmAaiKytylWV0cLZLCSPJ3M6vEDiBnXYTIEucc6Cy9AtS3ZonDmCW
	LHzVgIKFpYJ1OKe9SDnWxljS9GWiRzkRaJFRPlAJWkeIWeoqmpJ90Tjn5lfavqNza26lxhUv4gd
	sa5Xo21DaN8lnYBuppDSw0cw7ct3QQqqHgDoN9pkYgeXUIE22MPzV0l1fLsWVS7iag344krs5ja
	xDDBCRc8Edi9Tvrc3iMljdf6AFs87VqPVDZ6Ns3yPYBzmc4uMnXaIdsTfCBLYxHuLgUzp2RbDV7
	nG4NuqEYxRTV1W7R7i8vMj5uLep2QRjRWhA1V6zhfUM=
X-Received: by 2002:a05:6e02:1567:b0:3ec:9c32:6471 with SMTP id e9e14a558f8ab-3ec9c32673bmr18816445ab.2.1756132919647;
        Mon, 25 Aug 2025 07:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW4Lgvz6FbySIAPwtm0U1Tae7UuaIE2esfeq7WZJykcdIyv6UETbtw/iCgysaF9obPTYn/Gg==
X-Received: by 2002:a05:6e02:1567:b0:3ec:9c32:6471 with SMTP id e9e14a558f8ab-3ec9c32673bmr18816275ab.2.1756132919255;
        Mon, 25 Aug 2025 07:41:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ec67d6ffdasm22921535ab.25.2025.08.25.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:41:58 -0700 (PDT)
Date: Mon, 25 Aug 2025 08:41:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Nipun Gupta <nipun.gupta@amd.com>
Cc: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <nikhil.agarwal@amd.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
 <robin.murphy@arm.com>, <krzk@kernel.org>, <tglx@linutronix.de>,
 <maz@kernel.org>, <linux@weissschuh.net>, <chenqiuji666@gmail.com>,
 <peterz@infradead.org>, <robh@kernel.org>, <abhijit.gangurde@amd.com>,
 <nathan@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/2] vfio/cdx: update driver to build without
 CONFIG_GENERIC_MSI_IRQ
Message-ID: <20250825084155.10088e2a.alex.williamson@redhat.com>
In-Reply-To: <20250825043122.2126859-2-nipun.gupta@amd.com>
References: <20250825043122.2126859-1-nipun.gupta@amd.com>
	<20250825043122.2126859-2-nipun.gupta@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 10:01:22 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> Define dummy MSI related APIs in VFIO CDX driver to build the
> driver without enabling CONFIG_GENERIC_MSI_IRQ flag.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508070308.opy5dIFX-lkp@intel.com/
> Reviewed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> ---
> 
> Changes v1->v2:
> - fix linking intr.c file in Makefile
> Changes v2->v3:
> - return error from vfio_cdx_set_irqs_ioctl() when CONFIG_GENERIC_MSI_IRQ
>   is disabled
> 
>  drivers/vfio/cdx/Makefile  |  6 +++++-
>  drivers/vfio/cdx/private.h | 14 ++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/cdx/Makefile b/drivers/vfio/cdx/Makefile
> index df92b320122a..dadbef2419ea 100644
> --- a/drivers/vfio/cdx/Makefile
> +++ b/drivers/vfio/cdx/Makefile
> @@ -5,4 +5,8 @@
>  
>  obj-$(CONFIG_VFIO_CDX) += vfio-cdx.o
>  
> -vfio-cdx-objs := main.o intr.o
> +vfio-cdx-objs := main.o
> +
> +ifdef CONFIG_GENERIC_MSI_IRQ
> +vfio-cdx-objs += intr.o
> +endif
> diff --git a/drivers/vfio/cdx/private.h b/drivers/vfio/cdx/private.h
> index dc56729b3114..5343eb61bec4 100644
> --- a/drivers/vfio/cdx/private.h
> +++ b/drivers/vfio/cdx/private.h
> @@ -38,11 +38,25 @@ struct vfio_cdx_device {
>  	u8			config_msi;
>  };
>  
> +#ifdef CONFIG_GENERIC_MSI_IRQ
>  int vfio_cdx_set_irqs_ioctl(struct vfio_cdx_device *vdev,
>  			    u32 flags, unsigned int index,
>  			    unsigned int start, unsigned int count,
>  			    void *data);
>  
>  void vfio_cdx_irqs_cleanup(struct vfio_cdx_device *vdev);
> +#else
> +static int vfio_cdx_set_irqs_ioctl(struct vfio_cdx_device *vdev,
> +				   u32 flags, unsigned int index,
> +				   unsigned int start, unsigned int count,
> +				   void *data)
> +{
> +	return -ENODEV;

With the fix to patch 1/, the device info ioctl should be returning
that there are no irqs available, so this should use the same errno as
any other case of the user trying to set an out-of-bounds irq, -EINVAL.

With that change

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

> +}
> +
> +static void vfio_cdx_irqs_cleanup(struct vfio_cdx_device *vdev)
> +{
> +}
> +#endif
>  
>  #endif /* VFIO_CDX_PRIVATE_H */


