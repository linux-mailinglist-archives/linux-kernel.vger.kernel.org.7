Return-Path: <linux-kernel+bounces-767640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA47B25710
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5C08833CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989E2FB999;
	Wed, 13 Aug 2025 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHH2wnGo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C082FB96D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125801; cv=none; b=L2X8k3bGt+I29J44zl4QY03KisksOvIyUhW4e0YktZQ87oQlSFX56gWjTjXuyNBdqAljtKYJcAY+NNtJymwqQqAvbf3y7UJlrWeYss6b7DnKSxlL3i28Of8QM94ac0t4HEFZcmPb94zgHAWNxOrmzfX4/2rrUkJTJOOvk+hoDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125801; c=relaxed/simple;
	bh=4e0l/gwaTIMLD9bL4migSckiVZwpKkWavSLci6fpGpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9K4ZT4Z9b0VHBjPhV2khsbyTIyw2k4xx1736GeBbu7xnEkFII2TEpl+FFvxJ8z0TcOrq+dFY96kwGZTBuwLzZuCyBc6O8lFYaTh78/Cx/39A7iD8ioyY6ea4UofWGCRTFOqBZQO4XDE68cKPGy8NirRmneim5n4q6wd/WQqToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHH2wnGo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755125798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLeTfhKhkO7buQ+Gq1sRAvaCeEwy+ke7zDoFKoCbE0A=;
	b=jHH2wnGoAZuROb7+2DO/RsEQDDh37ykKYu2WLqb5Z9eYybOq8etrvfFFrhETHn0BpH5mk6
	2eqioMBpfYJGA0GMj4zqWh43a0IGtn5n+wR+DhJwkx6Q7oeLAIL2Kb4KN9DkGd8ZTbtHan
	hv55rcn6faHDcc2kkjpqVN6nRuu7XnY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-pfBfif_6M1288qMlybfQew-1; Wed, 13 Aug 2025 18:56:37 -0400
X-MC-Unique: pfBfif_6M1288qMlybfQew-1
X-Mimecast-MFC-AGG-ID: pfBfif_6M1288qMlybfQew_1755125796
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e56fe7d3deso1124585ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125796; x=1755730596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLeTfhKhkO7buQ+Gq1sRAvaCeEwy+ke7zDoFKoCbE0A=;
        b=jMwnzjHTCjcqxhIO9SYgO+r0M94ISpQR/PflRepOR6sQrjeGrMTngexk/+Ker69lig
         Km/CNB9ATIS3wKeSASHIrTvwWqLJEsm3apwOIFnFQyK1iSglhMcJKPQ8dkOAZyLy5xTs
         /mWMkcjH6Oi71gQU3MpE+5a4n7fhtVzwNYpIuif28gyPF2b+DbQRdSwn5f6WoOvn3XLt
         zQZS/ha48RXOdIEGJ9vvIzw1VImZSX/Zo5T16yBJMDKRU7FPQyCZCbY25V2ygm0D4N22
         tI4NuCgtF5Kv1sRxpFeQkPNazBP8qD6rXJNaGUdCsO0G0cJSs5Rb1WrXXySXXneOehN5
         kA6g==
X-Forwarded-Encrypted: i=1; AJvYcCVEqgq/280dVQP7Eu76PDAHXW5mr95j1cVfxqrvkCFtmnXv110MS+7lSdz/0rgOyS9NrBvsQ0zLbEakHX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnst+zarPFxZXLyxpedH19P6v6zBHZnTxpsUU4gHiskS6QU4DF
	M9l9fqWxkDX23dbSChUX5knjDYfRcq3pBeyKVXaBPWmrvYrulqwU0chDKRvIbOtDbLeBlevwFyW
	mbQCu1zKHB16pwiYyFaUAxsMlX5QitrY+ASVDO+c/sb3CG4tf8A3M+PVfAMnlfDlhJQ==
X-Gm-Gg: ASbGncvzRenKLWWqa6+r1GsEhCMT3npl5oU5Lf7bYQTr3dNI5+aXMx9nH2/HM4vP+vw
	oT7Q17RUbma6giTR2kz5cE/p24JpBeW5W9jBGGaJj5xQhhi7WHQQkZ2huPFiUqCDgZZZlfncWpT
	9kN1PsniNvzN1F+nbAzNKwjeTg93TdWie/8JdRWfFLOBo6T0hIN+4KzoEva525/DTuKXa31JO4X
	k4WgPK6kAwDiyqt2ZGtKC1uyPexVMdtoo+JJ+avMcwKJbN9aDbELfFU4Sd/Dr9P98OxJ+W08aqT
	73HmFohHiNF26MEIP/8kStizNbysn9NCBIPNomj1108=
X-Received: by 2002:a05:6e02:216a:b0:3e5:151e:6652 with SMTP id e9e14a558f8ab-3e57077bac5mr4982725ab.2.1755125796302;
        Wed, 13 Aug 2025 15:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGktdX8bRcKWgKmUrfDsEuQvcB5qH6b2PxIASOhiJyxcRZsecjKLRc1k18NJ79Q05dhZSHjaQ==
X-Received: by 2002:a05:6e02:216a:b0:3e5:151e:6652 with SMTP id e9e14a558f8ab-3e57077bac5mr4982635ab.2.1755125795883;
        Wed, 13 Aug 2025 15:56:35 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e533cc1bb3sm60160555ab.32.2025.08.13.15.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:56:34 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:56:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v1 5/6] vfio-pci/zdev: Perform platform specific
 function reset for zPCI
Message-ID: <20250813165631.7c22ef0f.alex.williamson@redhat.com>
In-Reply-To: <7059025f-f337-493d-a50c-ccce8fb4beee@linux.ibm.com>
References: <20250813170821.1115-1-alifm@linux.ibm.com>
	<20250813170821.1115-6-alifm@linux.ibm.com>
	<20250813143034.36f8c3a4.alex.williamson@redhat.com>
	<7059025f-f337-493d-a50c-ccce8fb4beee@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 14:52:24 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 8/13/2025 1:30 PM, Alex Williamson wrote:
> > On Wed, 13 Aug 2025 10:08:19 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >  
> >> For zPCI devices we should drive a platform specific function reset
> >> as part of VFIO_DEVICE_RESET. This reset is needed recover a zPCI device
> >> in error state.
> >>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   arch/s390/pci/pci.c              |  1 +
> >>   drivers/vfio/pci/vfio_pci_core.c |  4 ++++
> >>   drivers/vfio/pci/vfio_pci_priv.h |  5 ++++
> >>   drivers/vfio/pci/vfio_pci_zdev.c | 39 ++++++++++++++++++++++++++++++++
> >>   4 files changed, 49 insertions(+)
> >>
> >> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> >> index f795e05b5001..860a64993b58 100644
> >> --- a/arch/s390/pci/pci.c
> >> +++ b/arch/s390/pci/pci.c
> >> @@ -788,6 +788,7 @@ int zpci_hot_reset_device(struct zpci_dev *zdev)
> >>   
> >>   	return rc;
> >>   }
> >> +EXPORT_SYMBOL_GPL(zpci_hot_reset_device);
> >>   
> >>   /**
> >>    * zpci_create_device() - Create a new zpci_dev and add it to the zbus
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >> index 7dcf5439dedc..7220a22135a9 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -1227,6 +1227,10 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
> >>   	 */
> >>   	vfio_pci_set_power_state(vdev, PCI_D0);
> >>   
> >> +	ret = vfio_pci_zdev_reset(vdev);
> >> +	if (ret && ret != -ENODEV)
> >> +		return ret;
> >> +
> >>   	ret = pci_try_reset_function(vdev->pdev);
> >>   	up_write(&vdev->memory_lock);  
> > You're going to be very unhappy if this lock isn't released.
> >  
> Ah yes, thanks for catching that. Will fix this.
> 
> >  
> >>   
> >> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> >> index a9972eacb293..5288577b3170 100644
> >> --- a/drivers/vfio/pci/vfio_pci_priv.h
> >> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> >> @@ -86,6 +86,7 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >>   				struct vfio_info_cap *caps);
> >>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
> >>   void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
> >> +int vfio_pci_zdev_reset(struct vfio_pci_core_device *vdev);
> >>   #else
> >>   static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >>   					      struct vfio_info_cap *caps)
> >> @@ -100,6 +101,10 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> >>   
> >>   static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
> >>   {}
> >> +int vfio_pci_zdev_reset(struct vfio_pci_core_device *vdev)
> >> +{
> >> +	return -ENODEV;
> >> +}
> >>   #endif
> >>   
> >>   static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> >> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> >> index 818235b28caa..dd1919ccb3be 100644
> >> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> >> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> >> @@ -212,6 +212,45 @@ static int vfio_pci_zdev_setup_err_region(struct vfio_pci_core_device *vdev)
> >>   	return ret;
> >>   }
> >>   
> >> +int vfio_pci_zdev_reset(struct vfio_pci_core_device *vdev)
> >> +{
> >> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> >> +	int rc = -EIO;
> >> +
> >> +	if (!zdev)
> >> +		return -ENODEV;
> >> +
> >> +	/*
> >> +	 * If we can't get the zdev->state_lock the device state is
> >> +	 * currently undergoing a transition and we bail out - just
> >> +	 * the same as if the device's state is not configured at all.
> >> +	 */
> >> +	if (!mutex_trylock(&zdev->state_lock))
> >> +		return rc;
> >> +
> >> +	/* We can reset only if the function is configured */
> >> +	if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
> >> +		goto out;
> >> +
> >> +	rc = zpci_hot_reset_device(zdev);
> >> +	if (rc != 0)
> >> +		goto out;
> >> +
> >> +	if (!vdev->pci_saved_state) {
> >> +		pci_err(vdev->pdev, "No saved available for the device");
> >> +		rc = -EIO;
> >> +		goto out;
> >> +	}
> >> +
> >> +	pci_dev_lock(vdev->pdev);
> >> +	pci_load_saved_state(vdev->pdev, vdev->pci_saved_state);
> >> +	pci_restore_state(vdev->pdev);
> >> +	pci_dev_unlock(vdev->pdev);
> >> +out:
> >> +	mutex_unlock(&zdev->state_lock);
> >> +	return rc;
> >> +}  
> > This looks like it should be a device or arch specific reset
> > implemented in drivers/pci, not vfio.  Thanks,
> >
> > Alex  
> 
> Are you suggesting to move this to an arch specific function? One thing 
> we need to do after the zpci_hot_reset_device, is to correctly restore 
> the config space of the device. And for vfio-pci bound devices we want 
> to restore the state of the device to when it was initially opened.

We generally rely on the abstraction of pci_reset_function() to select
the correct type of reset for a function scope reset.  We've gone to
quite a bit of effort to implement all device specific resets and
quirks in the PCI core to be re-used across the kernel.

Calling zpci_hot_reset_device() directly seems contradictory to those
efforts.  Should pci_reset_function() call this universally on s390x
rather than providing access to FLR/PM/SBR reset?  Why is it
universally correct here given the ioctl previously made use of
standard reset mechanisms?

The DEVICE_RESET ioctl is simply an in-place reset of the device,
without restoring the original device state.  So we're also subtly
changing that behavior here, presumably because we're targeting the
specific error recovery case.  Have you considered how this might
break non-error-recovery use cases?

I wonder if we want a different reset mechanism for this use case
rather than these subtle semantic changes.  Thanks,

Alex


