Return-Path: <linux-kernel+bounces-780672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348DB307F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D23B00180
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920CE393DF1;
	Thu, 21 Aug 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+K/Ufgl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4FF393DC4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809998; cv=none; b=UjZpJp4Ngb9U57e3aAetVSUoZ71c6prqijah1UuRAIMBuz+gCTFIvxw9WCUCLF4IF3f8k6vqYPc8MDUxW/naj2lA9F651lGrtlNMoatpM++N+587o/P6AUFiIDDCvOf9m9xMwKR0pBTNXHoHwpDdo8XeLcqTFReO8gcXkagaFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809998; c=relaxed/simple;
	bh=iZGYE1Xd6jy1p5PRZ84O4xkm6GrvOQTQufb1eQO5abw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ei3OiG4ljY5tA0mcms70Yw5nUzsTc+slTnuWng5/MOHQ5tHXKHMVDLkbfQkRL+3bmunQ6B2AQHKPIWLqSHQr6NbuQXRsMkeR90F1dkyXfG9N1IMaLo2H5q5Kl+3OO6fdKWJcwFYvfqj7LFUg1ACGA6EDQfIvkF/ODLni/OOn0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+K/Ufgl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755809996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4G04SOJ0glNxufycnOsZm8GbV4T3e/3GwhGPhyQ8IQ8=;
	b=D+K/UfglLZQkcrN6RQvmE8mcdQPYiTQMxvT2OlgW6R7BJ4KAW4Y5akmKXmQ0qkYLhR2I3j
	Ufwob0u4ZzSpBtUzSKcZQZK5ts2b0keWmgHSxWz/I0U7CBMVuvA0yj+W34wdoLt6Ha49Mz
	/XWvzlKdmBde/8mEQTzVxZJsY/5RhL4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-AQRdYxetM4WzsX4hojZCAQ-1; Thu, 21 Aug 2025 16:59:54 -0400
X-MC-Unique: AQRdYxetM4WzsX4hojZCAQ-1
X-Mimecast-MFC-AGG-ID: AQRdYxetM4WzsX4hojZCAQ_1755809994
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88432d9d5d1so11833139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755809994; x=1756414794;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4G04SOJ0glNxufycnOsZm8GbV4T3e/3GwhGPhyQ8IQ8=;
        b=khKz0JGgRt/icT56NFsAQtbEMRR59WfHynDLbBSwFBKEmRjFDVLmT8tN2hbBQJCzqe
         ZsfKM11hkBGPrqzDxaOg4K0NMi0ya74kSsW1auiRHmRU9VLdI8V8GzJ68f9lWyOOwW9n
         rzqEfsv3+grUNFx5i10eHhnJ8XC3aZENF491ZE4OWz/z6mkM1aOx5EXsXODf5t6cTDhA
         SU0+NGqiz7w0pmgrPg6UpsDbyUaYyyjVQ6v+nTCdEe+C50/YPbW9kCvlSpArGeedrRNM
         U72n2wDg9GUU36q3ldLhka4XzOOM7PpZEi/eVhVQURNN/1k3+Sajs1s8Bc8UCRh+giXP
         EdMw==
X-Forwarded-Encrypted: i=1; AJvYcCXnwKWDtDpMd0hwncS80QoY5H85ZPQSwyM6mNtsG5ir5Cg5zguEu2qPuQncIpKhJl9JTzZ2bUuOGot0CI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0nYu44Va8iTGV3Z8ag9hhaphl1sguuAeGKLL3Rr/w5u9eedz
	/US770BlM99PIm/8ALFrFkPC+ea9thL9XUIlhjnqP9UNpunHMwhAxgA6r8HfXmK9itgeExF1rxf
	5G797xiK15Y8XFL4PWFyB+2EW1UWAEqnt6eFlVChNTAIYqz4PxItxF5Vzdti0aZN2cA==
X-Gm-Gg: ASbGncu5WeoXEKth2rarUAvIaRguIzTVHdbyK1S+gBpz/iPkyyHP7S1JLHawJ4h3HAi
	1Ifkr8ks6wulOjwnlkwPQxTtKSqJWxSzFlsuRwC7lmPTz4gkSZ8ELqSVP8/X4cyMOQF7hiflWh6
	bcBI974FXPQNhpmrkL0S4DV9jMGEvl6+XYEJO4x38McERjucpMAoJPYT2YxW8Zapjlrf3BQFgzs
	2rJLef4FNp1gWz/d/ne5D63Jvq/6Cq/nyzM95RqD2dDuKj8ozh6AVpGxwtc5tGd2RPrbcDR0rsX
	Sr6Pae0sjm86ggWMfPElhss6PspqKQQaqodw85Y8DDs=
X-Received: by 2002:a05:6602:2cc9:b0:881:659f:cd6c with SMTP id ca18e2360f4ac-886bd101642mr35934739f.1.1755809993795;
        Thu, 21 Aug 2025 13:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWsV1EzHTqmOI9QMn9r4+1m0MFqBhgNbF+N2ic8JnDHSvJKjdfICIF99AEr9+2AABgW89gRQ==
X-Received: by 2002:a05:6602:2cc9:b0:881:659f:cd6c with SMTP id ca18e2360f4ac-886bd101642mr35932439f.1.1755809993389;
        Thu, 21 Aug 2025 13:59:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-884702457d5sm273437639f.17.2025.08.21.13.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:59:51 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:59:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Nipun Gupta <nipun.gupta@amd.com>
Cc: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <nikhil.agarwal@amd.com>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
 <oe-kbuild-all@lists.linux.dev>, <robin.murphy@arm.com>, <krzk@kernel.org>,
 <tglx@linutronix.de>, <maz@kernel.org>, <linux@weissschuh.net>,
 <chenqiuji666@gmail.com>, <peterz@infradead.org>, <robh@kernel.org>,
 <abhijit.gangurde@amd.com>, <nathan@kernel.org>, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] vfio/cdx: update driver to build without
 CONFIG_GENERIC_MSI_IRQ
Message-ID: <20250821145949.7fa51308.alex.williamson@redhat.com>
In-Reply-To: <20250821071308.1572106-2-nipun.gupta@amd.com>
References: <20250821071308.1572106-1-nipun.gupta@amd.com>
	<20250821071308.1572106-2-nipun.gupta@amd.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 12:43:08 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> Define dummy MSI related APIs in VFIO CDX driver to build the
> driver without enabling CONFIG_GENERIC_MSI_IRQ flag.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508070308.opy5dIFX-lkp@intel.com/
> Reviewed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> ---
> Changes v1->v2:
> - fix linking intr.c file in Makefile
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
> index dc56729b3114..0482a1516439 100644
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
> +	return 0;
> +}
> +
> +static void vfio_cdx_irqs_cleanup(struct vfio_cdx_device *vdev)
> +{
> +}
> +#endif
>  
>  #endif /* VFIO_CDX_PRIVATE_H */

Why are we returning success if we don't implement the function?  This
provides the wrong return value to the user.

Also, aren't we also missing in patch 1/ that cdx_dev->num_msi is
initialized and therefore vfio_cdx_ioctl_get_info() might return that
an interrupt is supported when it is not?  Thanks,

Alex


