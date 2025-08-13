Return-Path: <linux-kernel+bounces-767457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B57DB2548D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2272B8828CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA32E8898;
	Wed, 13 Aug 2025 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgFf+LRn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2482BE7A5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117042; cv=none; b=gABpHUuiua+m9HdVkvIDv0XVeUApXR/GNofI7jGvzxO5QILrTBh03rz6eafah7h4+oWR0CMeNeYaAKWtHJXNdU5Qvih3/VnJlMRLdItGr51Ykk1mv8qCWcc2ZJcMjU4ucJw7bBlWNZ9Ih4p7tduS2GwvSMkTgf66+tFZeHoXRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117042; c=relaxed/simple;
	bh=mcdXn545T9iczKIurqQ/FlGNxvpjg61xSkqMywCy0lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klkmtx+S81krc2yjpW/yjWiaGrav/Eeq64TbnObJXZ0GaMrLRdPcFIf+XbjCBHlKuaE2TVXqPJb0ByVF4KSk9IAv5fzzameuL4sXFv17A9YlGW+0ow2+HQHgev20QFCnyM2h8KcB+sO9uvpiobBE+TX56nJJi50IHmCpCc94AQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgFf+LRn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755117039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BI+9iAXPQA3xNCjPJYTJgadfit0AjGO1DF6bqEY2VU=;
	b=FgFf+LRnIDUnu3MB/gIuYQBK2/aLy/JReLTkgQLUq9HKnzkWZdNbdizt8Dlo0p4kj9svNS
	UAeYtETCYmvr1YioWcRnHylCICXOZ+oBpGlAPDjj+iaAfs07qcumJ6g98w/8ePVVwadQ0a
	kMonOroUYo72L+0fvPYMUxANKVSOG84=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-az3cy3vaO6Ol135tghnc7g-1; Wed, 13 Aug 2025 16:30:37 -0400
X-MC-Unique: az3cy3vaO6Ol135tghnc7g-1
X-Mimecast-MFC-AGG-ID: az3cy3vaO6Ol135tghnc7g_1755117037
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e570044506so440065ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755117037; x=1755721837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BI+9iAXPQA3xNCjPJYTJgadfit0AjGO1DF6bqEY2VU=;
        b=TIkWRRVYCPWPKZ06K7hV4p/obM+aAjOmMBGtxsIfYUrjqQyFzKn0/j04Y7SHirXa7a
         QmSBZ6iWdFYS5lDFHPvRS5TUvEskltBMYA4cxsSXE7ai5K5KdW9bzcLu+8Ysadj1/Pp8
         KvpR20hZPH9C6oKZ68Lo+f6vVibPIP+J3979iPCJDmD29CEUgeRlbDigaIAzdtiqTakQ
         hEoJEpytTLT/3bJfVi26aIlrrLRits384qSYtUBm/mteWsL291udAo24myiW9es1Sf1K
         /A1hyAC/wNFsSL5wljzAFT/w+6q0ZSDIxzoQHQmSeZQ5zTMc8mxQDi3yCBPXTRRJLZjD
         XOlA==
X-Forwarded-Encrypted: i=1; AJvYcCXq1vuZAR/EIidQLdjQ5T8lI6T+aDIeySSbTf45VOhhwgde/ks51Wf2hiNsICVCTwDqJ5CqtWJ4FCyOmcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1HRGVchzjAm9WaXUDjk4kCZbPltzlm12pga65Epd6f546RU+
	4MQSGuH+sAC6seIXDuR04F3r0/nom5KWMLew7X70GsZjSTenV3rz6adZerM0NYvmaC0N+LJQILd
	9b4KamnqLLoUSTjT25c8+rQT7MneEqRJEb4vfokWl38fL1gE8B4Rwj2z0v7ZtXr1xNA==
X-Gm-Gg: ASbGncsSbhRDujmTa/raWJYE7xRm2KtcXLRTTW68kaCALZn4LeDl0ODB9FNaYAM+lJC
	DdSDLSoJABYPDtpacfSMoLy7MVfT+Hh3Sv02skZL4EQ/5XR3al6qziRaerVVgGKNkMAGZJ0RSI5
	b71Cu/jI8K6J64f3n/rpYmNkuvcu9YJa/8dgJx1BkVTvwAtY/Jjplw/lJFdEfcMaBAaBoDArtUb
	Fpm1jQ+kO2e4gkAuXUwFDwrdgUdB6Xk4sw1OwLEg9tZGOowglOenMFhCch3brZwr3qYYq+QPMbl
	XQmRqUFVgieuqwpBFNiaNe8yQw9kUZE7lgO34JkWrL4=
X-Received: by 2002:a05:6e02:b2e:b0:3e2:9275:60dc with SMTP id e9e14a558f8ab-3e56750457emr19692515ab.7.1755117037093;
        Wed, 13 Aug 2025 13:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWKByLUCJANfJjFdntgzUouQryuRTSs8eTS8v1GZ/BIcQp6Rqz8qHwqV82SCnUE7c5PEq/xA==
X-Received: by 2002:a05:6e02:b2e:b0:3e2:9275:60dc with SMTP id e9e14a558f8ab-3e56750457emr19692375ab.7.1755117036671;
        Wed, 13 Aug 2025 13:30:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae997b3acsm4070617173.13.2025.08.13.13.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:30:35 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:30:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v1 5/6] vfio-pci/zdev: Perform platform specific
 function reset for zPCI
Message-ID: <20250813143034.36f8c3a4.alex.williamson@redhat.com>
In-Reply-To: <20250813170821.1115-6-alifm@linux.ibm.com>
References: <20250813170821.1115-1-alifm@linux.ibm.com>
	<20250813170821.1115-6-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 10:08:19 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> For zPCI devices we should drive a platform specific function reset
> as part of VFIO_DEVICE_RESET. This reset is needed recover a zPCI device
> in error state.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/pci/pci.c              |  1 +
>  drivers/vfio/pci/vfio_pci_core.c |  4 ++++
>  drivers/vfio/pci/vfio_pci_priv.h |  5 ++++
>  drivers/vfio/pci/vfio_pci_zdev.c | 39 ++++++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index f795e05b5001..860a64993b58 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -788,6 +788,7 @@ int zpci_hot_reset_device(struct zpci_dev *zdev)
>  
>  	return rc;
>  }
> +EXPORT_SYMBOL_GPL(zpci_hot_reset_device);
>  
>  /**
>   * zpci_create_device() - Create a new zpci_dev and add it to the zbus
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 7dcf5439dedc..7220a22135a9 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1227,6 +1227,10 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	 */
>  	vfio_pci_set_power_state(vdev, PCI_D0);
>  
> +	ret = vfio_pci_zdev_reset(vdev);
> +	if (ret && ret != -ENODEV)
> +		return ret;
> +
>  	ret = pci_try_reset_function(vdev->pdev);
>  	up_write(&vdev->memory_lock);

You're going to be very unhappy if this lock isn't released.

>  
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index a9972eacb293..5288577b3170 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -86,6 +86,7 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				struct vfio_info_cap *caps);
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
>  void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
> +int vfio_pci_zdev_reset(struct vfio_pci_core_device *vdev);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
> @@ -100,6 +101,10 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  
>  static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>  {}
> +int vfio_pci_zdev_reset(struct vfio_pci_core_device *vdev)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 818235b28caa..dd1919ccb3be 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -212,6 +212,45 @@ static int vfio_pci_zdev_setup_err_region(struct vfio_pci_core_device *vdev)
>  	return ret;
>  }
>  
> +int vfio_pci_zdev_reset(struct vfio_pci_core_device *vdev)
> +{
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +	int rc = -EIO;
> +
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	/*
> +	 * If we can't get the zdev->state_lock the device state is
> +	 * currently undergoing a transition and we bail out - just
> +	 * the same as if the device's state is not configured at all.
> +	 */
> +	if (!mutex_trylock(&zdev->state_lock))
> +		return rc;
> +
> +	/* We can reset only if the function is configured */
> +	if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
> +		goto out;
> +
> +	rc = zpci_hot_reset_device(zdev);
> +	if (rc != 0)
> +		goto out;
> +
> +	if (!vdev->pci_saved_state) {
> +		pci_err(vdev->pdev, "No saved available for the device");
> +		rc = -EIO;
> +		goto out;
> +	}
> +
> +	pci_dev_lock(vdev->pdev);
> +	pci_load_saved_state(vdev->pdev, vdev->pci_saved_state);
> +	pci_restore_state(vdev->pdev);
> +	pci_dev_unlock(vdev->pdev);
> +out:
> +	mutex_unlock(&zdev->state_lock);
> +	return rc;
> +}

This looks like it should be a device or arch specific reset
implemented in drivers/pci, not vfio.  Thanks,

Alex

> +
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(vdev->pdev);


