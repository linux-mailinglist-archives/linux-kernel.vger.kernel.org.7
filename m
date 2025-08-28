Return-Path: <linux-kernel+bounces-790776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16380B3ACDD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D67D1B26C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36852C327D;
	Thu, 28 Aug 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vd6zOPx/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775222BE7AC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417470; cv=none; b=A/hFiRaeR1PusFUDt7RFG0L0L5/zTFr7yXM6hnGOx0FwJ0jLizhyIQzmkuvQ/zKOExzh7v1I7shG3WRtjGV5WUelYz+X3rbj3pitOggAw7tpDD6XvtFWR5C48rLyRcTj9XLFRt1qbYyxlWMOIITIlItMylHbUMFO2Jdtc/M7JmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417470; c=relaxed/simple;
	bh=GqvJqfvJWhpmyKfjufJhWpQg+eSKv4bD/PdpwBPkw4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHZb6PWh0JlZVowq1Ed/zNEpKOUMJrzvoKWcXLEX31l/N8wMKxHESItLGYqopV9tyGmQOJwhPWIRC/6Jxl5MkkJBcyQtZkER1GdJ14lRwvgQonC+jaYuFZ9zuNTwiH/cnf9mPneeKI08HLZgCTeEEA7v5IyTgNV6LPMb86cXcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vd6zOPx/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756417466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RACveh/So+FTKv8PaqNTUy1Q8R/Mr9cJX1WRHPYTfo=;
	b=Vd6zOPx/rlwE3GSy0+GLCj0hR+m3qy7ReZuQcxDjWykPQEvW+HJ7YIgMIeAJhbUd6wt0Vi
	mkyheYrYfRWOLbb3Dz3fQuAJeRgDXLNXXVUwYWMVHKjI886BemeyIaqL5ERr1F8KG3QN3C
	xLYt6BG0eLVNpWrGsa/w6rUYc5gMc5M=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-FbzPeY8BPh6nPdaFXOG-Tw-1; Thu, 28 Aug 2025 17:44:24 -0400
X-MC-Unique: FbzPeY8BPh6nPdaFXOG-Tw-1
X-Mimecast-MFC-AGG-ID: FbzPeY8BPh6nPdaFXOG-Tw_1756417464
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ebd3ca6902so3763705ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756417464; x=1757022264;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RACveh/So+FTKv8PaqNTUy1Q8R/Mr9cJX1WRHPYTfo=;
        b=qQ7dGBJZlsmsfjKxmChzUXhi+rJnnPM/1bpcAWi9B2EhTKhIaelF8JKRD3BcGxSxmO
         QyX2Zha+dnvxiMB2BqnPRnECxfSBzS7ekGOs4J2JK2tlUXamV1pC3OmGrRGmtRBD+r6G
         rm6XwZ6x8Ra+bs1ayjmcBsoWfGNnlR/XzDdcbLdm3JaA9vsaPvcGfQEJ+XPS6Xcmhz80
         OqXOE4xNfe6tpyZvk1T8/NGvIfGLfaQiYMbf94rMMlDInUg9bkFc0jsE/ZS3e3K3UdrF
         62s7L2dBuJ6G70UepXpferDBTs1mR3VeZSNx9zlqvLxHDan8QObpxYIpYWac7ybblaJn
         jt/A==
X-Gm-Message-State: AOJu0YzzezRgO67XGZ5P46jyJf2RibDdwz2OxXLbIa3c0UqLxRcECp/Y
	sBTjq2/DCq7L5KurUwBB4YpS6W+5L7ZxDXkTDWG2fp6LyJLnaxe023KNIT3CPwlPOjOWDf6hd1s
	dgD1OPCYE4nnOX39xVlsuJS95ssWCvbHhlGW5fwMk9FNqpnvTjKKkIJpwThLwE480ag==
X-Gm-Gg: ASbGncticlOixVP8ZUKuWBkzwEDrTBs7QZKWVEDl2k6aOcN/RVOn6QqgZAeKgGHS493
	RMEEuPHckaeoaNQ2DwA8nuN6hBbvi4mRRmrlYy5Aec2LeLQdpX0zIeBDzlW0OtthZQBcfSgOOOo
	35LxB8r96H057VTlglXuEMduu9oCV+I2/YZWb15wKcBgd57EgMK05EtEnt6T/a3n3vTIaCiCTUk
	Grd5hicGwkPmDstLWcew1dcVkZ3lWSVjuvPVKvHzFMDpX08QwcTOCT7nqxOufFRag8dL/UsjBua
	RPHFTaO42f8stIOhtt2/V8uIAm7Y88TE5gGEC1dOcMM=
X-Received: by 2002:a92:c26c:0:b0:3f1:de48:36ad with SMTP id e9e14a558f8ab-3f1de48389amr15264715ab.4.1756417463547;
        Thu, 28 Aug 2025 14:44:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg3wgzbv9HEvAwkExjx2PJxCJ2VJntEJpNjUpTyBRq2NcFk03fhpFQ0yUR1SdojwXP+MApaA==
X-Received: by 2002:a92:c26c:0:b0:3f1:de48:36ad with SMTP id e9e14a558f8ab-3f1de48389amr15264645ab.4.1756417463113;
        Thu, 28 Aug 2025 14:44:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f2a1c704ccsm763975ab.42.2025.08.28.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:44:22 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:44:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: linux-kernel@vger.kernel.org, ldv@strace.io, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio: show the name of IOMMU driver in
 /proc/$pid/fdinfo
Message-ID: <20250828154419.5f4b15ff.alex.williamson@redhat.com>
In-Reply-To: <20250828202100.3661180-1-yamato@redhat.com>
References: <20250828202100.3661180-1-yamato@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[Cc kvm@vger.kernel.org]

On Fri, 29 Aug 2025 05:21:00 +0900
Masatake YAMATO <yamato@redhat.com> wrote:

> The ops of VFIO overlap:
> 
>   (include/uapi/linux/vfio.h)
>   #define VFIO_DEVICE_GET_PCI_HOT_RESET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
>   ...
>   #define VFIO_MIG_GET_PRECOPY_INFO _IO(VFIO_TYPE, VFIO_BASE + 21)
>   ...
>   #define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
>   #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
>   #define VFIO_EEH_PE_OP			_IO(VFIO_TYPE, VFIO_BASE + 21)
>   #define VFIO_IOMMU_SPAPR_REGISTER_MEMORY	_IO(VFIO_TYPE, VFIO_BASE + 17)
>   ...
>   #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
> 
> These overlapping makes strace decoding the ops and their arguments hard.
> See also https://lists.strace.io/pipermail/strace-devel/2021-May/010561.html
> 
> This change adds "vfio-iommu-driver" field to /proc/$pid/fdinfo/$fd
> where $fd opens /dev/vfio/vfio. The value of the field helps strace
> decode the ops arguments.
> 
> The prototype version of strace based on this change works fine:
> - https://lists.strace.io/pipermail/strace-devel/2021-August/010660.html
> - https://lists.strace.io/pipermail/strace-devel/2021-August/010660.html

Duplicate links.

We really only have type1 and spapr, and they're mutually exclusive per
architecture.  POWER is spapr and everything else is type1.  We're also
moving to using IOMMUFD and consider the vfio container to be somewhat
legacy, so we're not getting any new IOMMU backends for container mode.
The spapr support is also barely hanging on by a shoestring.

Is there current interest (ie. since 2021) for these changes?  It
doesn't appear that even the RFC these changes were based on,
differentiating by file type, is in the current strace code base.
 
> Cc: Dmitry V. Levin <ldv@strace.io>
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  drivers/vfio/container.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/vfio/container.c b/drivers/vfio/container.c
> index d53d08f16973..03677fda49de 100644
> --- a/drivers/vfio/container.c
> +++ b/drivers/vfio/container.c
> @@ -11,6 +11,7 @@
>  #include <linux/iommu.h>
>  #include <linux/miscdevice.h>
>  #include <linux/vfio.h>
> +#include <linux/seq_file.h>
>  #include <uapi/linux/vfio.h>
>  
>  #include "vfio.h"
> @@ -384,12 +385,22 @@ static int vfio_fops_release(struct inode *inode, struct file *filep)
>  	return 0;
>  }

#ifdef CONFIG_PROC_FS

> +static void vfio_fops_show_fdinfo(struct seq_file *m, struct file *filep)
> +{
> +	struct vfio_container *container = filep->private_data;
> +	struct vfio_iommu_driver *driver = container->iommu_driver;
> +
> +	if (driver && driver->ops->name)
> +		seq_printf(m, "vfio-iommu-driver:\t%s\n", driver->ops->name);
> +}

#endif

> +
>  static const struct file_operations vfio_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= vfio_fops_open,
>  	.release	= vfio_fops_release,
>  	.unlocked_ioctl	= vfio_fops_unl_ioctl,
>  	.compat_ioctl	= compat_ptr_ioctl,

#ifdef CONFIG_PROC_FS

> +	.show_fdinfo    = vfio_fops_show_fdinfo,

#endif

>  };
>  
>  struct vfio_container *vfio_container_from_file(struct file *file)

proc.rst should also be updated.  See [1] for a recent addition fdinfo.
Thanks,

Alex

[1]https://lore.kernel.org/r/20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com


