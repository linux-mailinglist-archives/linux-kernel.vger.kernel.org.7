Return-Path: <linux-kernel+bounces-699223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A52AE569C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 00:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66C74A1C13
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 22:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C6E225785;
	Mon, 23 Jun 2025 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4WIGQdy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA721FF2B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717121; cv=none; b=ScR9G/hjg5QMzFfDvLm1eRVQEnbGrmKYXHVovzLTudPFqNs2PP2X/n6hucAuDGfJRyrRmzniY59HdQxRLIWirs/Xw2HxR9W7dpLGONFOTKc87FTpbkSm5ejniaO6ZLz91y/f630tcxXZUgy4wiMA6ycUrDjSdzJEtoyvu6qRQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717121; c=relaxed/simple;
	bh=vLZeWyGsVz/hEFzZKqzZVDtXhwlwigooy2q+g03afdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICaw1XOT/mnQCRL/BFdJONJ8dAeCUamrR0fOwit8i430A86wdvakhxSIr+KFLr/NcBK3SMxfz5tJ14OS4eH3ArGxZ5JAL+3Sh901m1Z/mjg+9thv0zer36WFlNs/5nbaDqTDBWeRbAK8CR8xQnkI+TVsxiUVTdnmC7A9+5Ut370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4WIGQdy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750717118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ySo8M91y1IL4iHjljRN+5mZHzSeTf/eQft1NGOyKa0=;
	b=h4WIGQdy/VWjwaMEez+FJIbRKtBfXHvL7iTyHXHCya8ISAmwTOLxpyWHFG8hfQf2F+9YVz
	cVIRM96j9WC4j19Rcr9rhlbAy3C627YZuA2eZoIojvYu9bCsGGLJI1zE2KeaAHrycgk/xR
	iRWJnHhdSue717d9VFiGffsdaNcxDZc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-8sjpRuwJNuWypFN8ialDBg-1; Mon, 23 Jun 2025 18:18:36 -0400
X-MC-Unique: 8sjpRuwJNuWypFN8ialDBg-1
X-Mimecast-MFC-AGG-ID: 8sjpRuwJNuWypFN8ialDBg_1750717116
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-73a69b45a46so228472a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 15:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717116; x=1751321916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ySo8M91y1IL4iHjljRN+5mZHzSeTf/eQft1NGOyKa0=;
        b=rvQfVRFY3MMA9tKZ4Q1uQr9Q5tOVg9Xmav7KUqNkh+r/0wvFfnJyUtoWNn7jaKJUv4
         ALWlAjfSh/H7z6ADWi9vHCHQc/zh/Yk4ACKdtHSGofk0wDIeXRXpj/5gGuuyIvxpOjhC
         iNPLjfd5qnMI2GXQgNaWZYL4+2aGxpY/awRoCGqzRvye5rH++PFJtCfCdTsqnSAcrLKX
         PiMh3QdIy/hBL0tBRvVF2y48B/d1ff8ZA4+HV2fj7h7rPrrxb49jk7BN27AMRCALzm7y
         gF2D9pivWtRh5u4GWzJ6zsXXQ83He7T9IECM58g5GmWHPQ8Mo5p0HnVFPE681teATLe+
         r+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVzJ6vRDXCe36jEbBzuN9Tiypdu2UNnyk7MVvdZ5cJWQdzGlF9m7GBmvymr/TeDeeC1QBcQt7i9NcfFPBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVtUr5c4dEFC/VFACPOtQQvjYRxGMZco91W+ACLozuMtrxVwz
	7Wg42r+mZSGmRJOIqCJxxPmPg7s1umbDf29S3nAlM8V+PuNqfen+Cy4ler+gXZxXH1dG3iZjTlL
	TQt1fcpM/D4QBC81bKDcI0yBJ0WYdtf4/wwzKc1eXAQdV+IC07TGjm1Z0msXrSOCOhQ==
X-Gm-Gg: ASbGncsEhT+1hVMAak4px7u/ommhsoTReVxcM+94fyg/fuofMAWdHpJ1wK76b6a1jCp
	moxBW9f68FaZNUk/LIeQLBlRLhHhOLsbXHiwp7P/sWWpisaK/auRxU+cauGjYi7EhDv1XheQa3k
	EkJ4oIFAwqO5/8lXXl9ed2ILJ22VRe5W2g/ciT8vLtwyolVolNraHaXifC7X2ODRHJ27xh+srMf
	MeobCEF7Cg9DOdx9omtlc6A7jmyHrjTCb80Kb9Eh9w1Qq/3trmcjLf0KVR93FVRwNc59KOsT/s9
	F54wsElC0DdVG9Lx0xDZ/KrQRA==
X-Received: by 2002:a05:6808:1796:b0:3fe:b5d3:3f23 with SMTP id 5614622812f47-40ac70710d0mr3749366b6e.5.1750717115756;
        Mon, 23 Jun 2025 15:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHILrlVnJBx+mTuTTPbKRzPKiqKsl1pZskdj3jz18VZONotRoUc+IIq6ZgB9V0iZtVqVDVm7A==
X-Received: by 2002:a05:6808:1796:b0:3fe:b5d3:3f23 with SMTP id 5614622812f47-40ac70710d0mr3749359b6e.5.1750717115389;
        Mon, 23 Jun 2025 15:18:35 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6d11be3sm1589959b6e.37.2025.06.23.15.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:18:34 -0700 (PDT)
Date: Mon, 23 Jun 2025 16:18:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alex Mastro <amastro@fb.com>
Cc: <peterx@redhat.com>, <kbusch@kernel.org>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] vfio/pci: print vfio-device name to fdinfo
Message-ID: <20250623161831.12109402.alex.williamson@redhat.com>
In-Reply-To: <20250623-vfio-fdinfo-v1-1-c9cec65a2922@fb.com>
References: <20250623-vfio-fdinfo-v1-1-c9cec65a2922@fb.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 14:02:38 -0700
Alex Mastro <amastro@fb.com> wrote:

> Print the PCI device name to a vfio device's fdinfo. This enables tools
> to query which device is associated with a given vfio device fd. It's
> inspired by eventfd's printing of "eventfd-id" (fs/eventfd.c), which
> lsof uses to format the NAME column (e.g. "[eventfd:7278]").
> 
> This results in output like below:
> 
> $ cat /proc/"$process_using_vfio"/fdinfo/"$vfio_device_fd" | grep vfio
> vfio-device-name: 0000:c6:00.0
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
> Hello, this is my first patch submission to vfio, and linux. We would
> like our tools to be able to query the PCI device name for a given
> vfio-device fd by inspecting a process's open file descriptors. It is
> inspired by eventfd's id printing, which is nicely formatted by lsof in
> the NAME column.
> 
> I am not sure to what extent this should be generalized, so I opted
> to put as little policy as possible into vfio_main.c, and have each
> vfio_device_fops implement what it means to show_fdinfo. The only
> implementer is vfio_pci_ops in this change.
> 
> Alternatively, if we wanted to normalize show_fdinfo formatting, this
> could instead hoist the print formatting up into vfio_main.c, and call
> an optional vfio_device_ops->instance_name() to get the name. I opted
> not to do this here due to unfamiliarity with other vfio drivers, but am
> open to changing it.

TBH, I don't think we need a callback, just use dev_name() in
vfio_main.  The group interface always requires the name, in some cases
it can require further information, but we seem to have forgotten that
in the cdev interface anyway :-\

> I noticed that other vfio_device_fops are guarded by checks on
> vfio_device_file.access_granted. From what I can tell, that shouldn't
> be required here, since a vfio pci device is guaranteed to be
> able to print its name (due to existence of vfio_device.pdev) after
> vfio_device_ops.init() construction.

Yep, we shouldn't need any extra locking.
 
> This change rooted on the for-linus branch of linux-vfio [1].
> 
> [1] https://github.com/awilliam/linux-vfio
> ---
>  drivers/vfio/pci/vfio_pci.c | 14 ++++++++++++++
>  drivers/vfio/vfio_main.c    | 15 +++++++++++++++
>  include/linux/vfio.h        |  2 ++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 5ba39f7623bb..b682766127ab 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -21,6 +21,7 @@
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> @@ -125,6 +126,16 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PROC_FS
> +static void vfio_pci_core_show_fdinfo(struct vfio_device *core_vdev, struct seq_file *m)
> +{
> +	struct vfio_pci_core_device *vdev =
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +
> +	seq_printf(m, "vfio-device-name: %s\n", pci_name(vdev->pdev));
> +}
> +#endif
> +
>  static const struct vfio_device_ops vfio_pci_ops = {
>  	.name		= "vfio-pci",
>  	.init		= vfio_pci_core_init_dev,
> @@ -138,6 +149,9 @@ static const struct vfio_device_ops vfio_pci_ops = {
>  	.mmap		= vfio_pci_core_mmap,
>  	.request	= vfio_pci_core_request,
>  	.match		= vfio_pci_core_match,
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo	= vfio_pci_core_show_fdinfo,
> +#endif
>  	.bind_iommufd	= vfio_iommufd_physical_bind,
>  	.unbind_iommufd	= vfio_iommufd_physical_unbind,
>  	.attach_ioas	= vfio_iommufd_physical_attach_ioas,
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 1fd261efc582..e02504247da8 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -28,6 +28,7 @@
>  #include <linux/pseudo_fs.h>
>  #include <linux/rwsem.h>
>  #include <linux/sched.h>
> +#include <linux/seq_file.h>

Only where we're doing the seq_print do we need to include this.

I think you're missing an update to Documentation/filesystems/proc.rst
as well.

>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/string.h>
> @@ -1354,6 +1355,17 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
>  	return device->ops->mmap(device, vma);
>  }
>  
> +#ifdef CONFIG_PROC_FS
> +static void vfio_device_show_fdinfo(struct seq_file *m, struct file *filep)
> +{
> +	struct vfio_device_file *df = filep->private_data;
> +	struct vfio_device *device = df->device;
> +
> +	if (device->ops->show_fdinfo)
> +		device->ops->show_fdinfo(device, m);
> +}
> +#endif
> +
>  const struct file_operations vfio_device_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= vfio_device_fops_cdev_open,
> @@ -1363,6 +1375,9 @@ const struct file_operations vfio_device_fops = {
>  	.unlocked_ioctl	= vfio_device_fops_unl_ioctl,
>  	.compat_ioctl	= compat_ptr_ioctl,
>  	.mmap		= vfio_device_fops_mmap,
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo	= vfio_device_show_fdinfo,
> +#endif
>  };
>  
>  static struct vfio_device *vfio_device_from_file(struct file *file)
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 707b00772ce1..54076045a44f 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -16,6 +16,7 @@
>  #include <linux/cdev.h>
>  #include <uapi/linux/vfio.h>
>  #include <linux/iova_bitmap.h>
> +#include <linux/seq_file.h>
>  
>  struct kvm;
>  struct iommufd_ctx;
> @@ -135,6 +136,7 @@ struct vfio_device_ops {
>  	void	(*dma_unmap)(struct vfio_device *vdev, u64 iova, u64 length);
>  	int	(*device_feature)(struct vfio_device *device, u32 flags,
>  				  void __user *arg, size_t argsz);
> +	void	(*show_fdinfo)(struct vfio_device *device, struct seq_file *m);

Were we to keep this, the comment would need to be updated to describe
it.  Thanks,

Alex

>  };
>  
>  #if IS_ENABLED(CONFIG_IOMMUFD)
> 
> ---
> base-commit: c1d9dac0db168198b6f63f460665256dedad9b6e
> change-id: 20250623-vfio-fdinfo-767e75a1496a
> 
> Best regards,


