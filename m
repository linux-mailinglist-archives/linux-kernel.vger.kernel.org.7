Return-Path: <linux-kernel+bounces-728347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B26B02728
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6675A1D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7C21E1E1E;
	Fri, 11 Jul 2025 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7+b2lko"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4AF1DD529
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274273; cv=none; b=aEX9jAdRl7tQVizd29GkWlVaOM4K/aRzEQ8VbIndj+/harbwFI5CBsDd0VAryZdbU5VWV+PpGPHVBE8IRlEvsl0MBAHpSznE566VMtkZcbrMer/IOQvgXnIv/2c5fcqgOm+Dg5Pe9ANgaQJF8o7Zixkf2Kv1DiU9TlvnTULhTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274273; c=relaxed/simple;
	bh=e2HRqwLef4kAURx8meT3jjA5yDP1bjM/Z501qkoAhEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzKHbkzGhLokmB3PImKTDUOMCpY5+c/NE2kx1TfdKzsXD/EmRL4CgkctqrsmlAsfs85IjPt0Swg0gqdh5R9UuyJTeXvVLtp62CWv+z4I72XKOsyUADQ5iZFks7SkGWTq7Yc0wN+K32WUfoM/2WSRMIIIQvpDNk0+4GXulJK+P+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7+b2lko; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752274270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUlBOZt5JepuEesoPNsvp78tEh5FR4bXJJdKcsQXWvM=;
	b=X7+b2lkoauxDUGWmTnqCyXqZeu/0AR6gawPZoUsE0mURS7F1eaVjVVSgmUkO/gqCjuMSjp
	oEzKvbJXPVHyquaMgLwxMaqR1DuLvVRhRi+awLFWY1L0Z7MBzzzzoA7B80VMcReebrklM0
	l6JF3qovIdP0DP6FnDEdfgEbT0RW/lQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-5t6K2Z9hN-uA1ZJDZzkqww-1; Fri, 11 Jul 2025 18:51:09 -0400
X-MC-Unique: 5t6K2Z9hN-uA1ZJDZzkqww-1
X-Mimecast-MFC-AGG-ID: 5t6K2Z9hN-uA1ZJDZzkqww_1752274268
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8769aa1f0c7so43267539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752274268; x=1752879068;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUlBOZt5JepuEesoPNsvp78tEh5FR4bXJJdKcsQXWvM=;
        b=OYpjtPc9ZrDOCOoTzOkKPhnk4r8NO/bb9DNsYHm6FGevdPST5rK4lQwRdZEhmUo8Dq
         C5XQdgcmJsl8jlLLCgt12o2X2skrdWwCUi1HXsQ52lpCMiDC4wJfJmK5zoLxThQi/UaI
         plYrQ1lq+IyhjoPvS91Fu7ygXA5E0/dAg3hd1sNneks8ry7b/aznxatcXW2U5NqAYphA
         ET9zXO5r4b7DdeVCQCbXyBnHLNRebXQfeQLSlBMARUvZ8CpSwUZ+hnLvAo5WcEiC13Ck
         4ZyOBJ89ZrQZCzcNfZ84qAq6+Tsh2Le9JXXHvRqQ00Y3xngVw0GtBPA+9ZeEcljppw7m
         znow==
X-Forwarded-Encrypted: i=1; AJvYcCW97oVVd65LSOwbwmn77xvZ7jJZ9XwzvnbEoqMhBpF/mrFpN7ta6mEaeJ7V2ZCJftrFfFI3YSxsGq6EBUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjvzJZwgPLUzIBep0lIqaKdo/mMFXAfM3t+FwkwsJWwdoKhSp
	hL5FTq8hgVSmC73KhocR6l0vWbdj9HY4G6SYWTxukDhEmtjSE9iIXLkLO7ODpz7I5q/9q+eMou9
	D32ZGImW8PtVUTs4nW3hYSRErnOzrVDyroZ6rqg7+VXE8/1shb1FbB43eQPn3QiEQzw==
X-Gm-Gg: ASbGncv8e13FQquP5pavkFbd/qOAeOV8KqJj9c/bDUuSNLOVxs1YDCuKW+YkyIbPnS0
	IlymZClICUkwZA9EjTpfN2kQ/1PEzL/p9TtJVZGpWs4vbK0tOiUDDZFRpZCzcUX0X9KyL00qldQ
	IZPydW+zonwYCchjJPz6R5k3kNkJQBxKeX+MAn2iZG9fnFx8zsHkV/V433bpkbiE1XY4mULBnEp
	U+YP0TG+fBTPnCuC7HoI2pXpQ2SC5FNMY6pQG+4JD4MT6+oYmrDQUCpIrOoRa1DzEvGUVFJYQXQ
	KVnHwxrxeKxHdv++vw0x5wb0rc2BzRPI/Kc9/PI7OBw=
X-Received: by 2002:a92:c248:0:b0:3df:4cf8:dd4f with SMTP id e9e14a558f8ab-3e2543e0bb3mr15415535ab.5.1752274268508;
        Fri, 11 Jul 2025 15:51:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWvIa74WArboI4td6WgV6O8vUwd+B2SMYGRpKd+kzyAGObgn0Yb70rdbxO+KtouVW2IoQ43A==
X-Received: by 2002:a92:c248:0:b0:3df:4cf8:dd4f with SMTP id e9e14a558f8ab-3e2543e0bb3mr15415475ab.5.1752274268108;
        Fri, 11 Jul 2025 15:51:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e2461344c9sm14794715ab.16.2025.07.11.15.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 15:51:06 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:51:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: <jgg@ziepe.ca>, <yishaih@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/pds: Fix missing detach_ioas op
Message-ID: <20250711165104.37fec2f6.alex.williamson@redhat.com>
In-Reply-To: <20250702163744.69767-1-brett.creeley@amd.com>
References: <20250702163744.69767-1-brett.creeley@amd.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Jul 2025 09:37:44 -0700
Brett Creeley <brett.creeley@amd.com> wrote:

> When CONFIG_IOMMUFD is enabled and a device is bound to the pds_vfio_pci
> driver, the following WARN_ON() trace is seen and probe fails:
> 
> WARNING: CPU: 0 PID: 5040 at drivers/vfio/vfio_main.c:317 __vfio_register_dev+0x130/0x140 [vfio]
> <...>
> pds_vfio_pci 0000:08:00.1: probe with driver pds_vfio_pci failed with error -22
> 
> This is because the driver's vfio_device_ops.detach_ioas isn't set.
> 
> Fix this by using the generic vfio_iommufd_physical_detach_ioas
> function.
> 
> Fixes: 38fe3975b4c2 ("vfio/pds: Initial support for pds VFIO driver")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> ---
>  drivers/vfio/pci/pds/vfio_dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vfio/pci/pds/vfio_dev.c b/drivers/vfio/pci/pds/vfio_dev.c
> index 76a80ae7087b..f6e0253a8a14 100644
> --- a/drivers/vfio/pci/pds/vfio_dev.c
> +++ b/drivers/vfio/pci/pds/vfio_dev.c
> @@ -204,6 +204,7 @@ static const struct vfio_device_ops pds_vfio_ops = {
>  	.bind_iommufd = vfio_iommufd_physical_bind,
>  	.unbind_iommufd = vfio_iommufd_physical_unbind,
>  	.attach_ioas = vfio_iommufd_physical_attach_ioas,
> +	.detach_ioas = vfio_iommufd_physical_detach_ioas,
>  };
>  
>  const struct vfio_device_ops *pds_vfio_ops_info(void)

Applied to vfio next branch for v6.17.  Thanks,

Alex


