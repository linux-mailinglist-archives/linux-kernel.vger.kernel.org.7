Return-Path: <linux-kernel+bounces-728346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127C5B02726
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A914E3F10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E091F6667;
	Fri, 11 Jul 2025 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrThjmvd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3746BFCE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274242; cv=none; b=BytKFGZCKMSq6xY3m3pCYbPHEGhrXCYWsnaDWv8qf+J3X43dts9K5qSzh18otqFGhcQl0rCyHs1BtTWeK29Hfp5pLZ2agbKhZUqMvIFWuoQNF1GcnbVm8RnQr+ZP4PrQ54X1pAl3lcn+b/jR1micHxrtWFU4upTPZAlmmhEWu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274242; c=relaxed/simple;
	bh=qYP/iGjLnpgD3InKq+jEENsxYWOj3Hd8bC9doHLoCuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+oD9Ud8PSMaLrlkvL0waxYGu0JaBzHVdm2SfEoBVMwcG6vCBGcBH+cBzmJtzUJh14lM7yXyfOFsNX8u3fDcTjNuASw9ojywMdhuUjWTd0JPtLqyF7uiU3yrd6Aa0ZCbUgC3d9aNKp7MBLwVJXJMNjLGwsDKwsHsTA7gSDabXMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrThjmvd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752274238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiYBwdTFr6UYn+pTQMaNURbPHGMcyuBfNo7zVfzGq+M=;
	b=FrThjmvdvUlE1yitDs3QRy7pcbG4d5TQuB+M9z2HNgZVkbG53jauNUh1ja0utsU4IgxqwG
	2FgT1mhq2mXH4EBWDQzqv/Cqdhb+BkeAgDupyIqcmEXqxoTqFC8YmMwxi+S5c/rswePrGd
	Me9zGvCKFTDGyC6ZCXOaaRIUN6cXC18=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-3Tr0kJlfMXqGwvcHssZDUQ-1; Fri, 11 Jul 2025 18:50:37 -0400
X-MC-Unique: 3Tr0kJlfMXqGwvcHssZDUQ-1
X-Mimecast-MFC-AGG-ID: 3Tr0kJlfMXqGwvcHssZDUQ_1752274237
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df359a108bso4935615ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752274237; x=1752879037;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiYBwdTFr6UYn+pTQMaNURbPHGMcyuBfNo7zVfzGq+M=;
        b=X+Wy7eYVb8dukJXd1QnGdexNgTjLLB9Iu34Ww/eSJLZZlD08Y+I55paBYYCFw/e52K
         SNhhGPE9qbbiha5B4YqMBhwVsvfNTiVRDdn77vWTfmkHMRGmFUBztVjyzZXY5IUDzFuv
         K3KQnlOIGz7VE9U5oOI2wSwq+vJI20dNhNC6bMcPHMIbgIyumimvD7gGON9kkdCZOSui
         XUuLvt3LpcF2u5De1o7fHi3/+07ClDC8PPvCiHJvgf6vAvjC7tuytIn1IsoS4YQXvaGf
         pZx08/yhZ5Q+W3jVs9vXYb0Bje+SqZf4SeTZ7tfAdxL5TQOCFAh4mpViNgHWiSNahL/W
         zNiQ==
X-Gm-Message-State: AOJu0Yyi0AwJqJXzDU0dvZE9dSW4CCrGsIQcIXUIcIhv+w1C1uzThHRZ
	93CQRPBACcPoncC4xLQtd1iULJ5hrY069i099dAnyBHlZ4Wlbj2vrtghH/BEkFemR0+bRtUP0BD
	r+/MApAjgeKyHb5WwhCmepLVRxn8oj6GwJ6U4rmLYWVXyOvz8XHZ7KmRtrxt17lsT1w==
X-Gm-Gg: ASbGncswkpANiPvty8hCgGYJUWsF6AtteOcRlpdXWjqTqprmV0JCG0m0MTHoyzKATg8
	kMt34KBq1OFss32tl76gfDiN8GMx2QmO9jnjNs6cnI7p9XbCTmK0pZsyp/MDiT3bzJTFGpDhuzh
	iWtt4SaTjPjgbDxK23IOv/ibVVkXEL5Jx0DHys+OLEoOHfisq48cP6idTnd//Wx/xFSqfsSQovt
	ALOnXWhRHggNtkDnvepqA4Li8t64j7AxTL+gbD9hhGOjp7r345f+6P34rfvSmHOylLQNLKiyIuE
	yO98evKLvmNz10s5azl50DetHznMNGCetmLeFYzE1OI=
X-Received: by 2002:a05:6e02:2489:b0:3dc:87c7:a5a5 with SMTP id e9e14a558f8ab-3e2543def86mr18674525ab.5.1752274236852;
        Fri, 11 Jul 2025 15:50:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjwjYtI+ErmAwmWa/FqoT9OKqNB7tntH55hciTWbq8HIF2pSRrgP859jsyuWc6atNz+5+cJw==
X-Received: by 2002:a05:6e02:2489:b0:3dc:87c7:a5a5 with SMTP id e9e14a558f8ab-3e2543def86mr18674455ab.5.1752274236383;
        Fri, 11 Jul 2025 15:50:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e2461573a0sm14745155ab.31.2025.07.11.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 15:50:35 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:50:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, Zhang Yu <zhangyu1@microsoft.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v3 1/2] vfio: Fix unbalanced vfio_df_close call in
 no-iommu mode
Message-ID: <20250711165033.010efe96.alex.williamson@redhat.com>
In-Reply-To: <76681.125071014402700656@us-mta-395.us.mimecast.lan>
References: <20250618234618.1910456-1-jacob.pan@linux.microsoft.com>
	<76681.125071014402700656@us-mta-395.us.mimecast.lan>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 11:40:25 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Hi Alex et al,
> 
> Just wondering if there are more comments?

Seems not.  Sorry for the delay, these just fell early in the cycle and
other patches are going through various re-spins.  Applied to vfio next
branch for v6.17.  Thanks,

Alex
 
> On Wed, 18 Jun 2025 16:46:17 -0700
> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> 
> > For devices with no-iommu enabled in IOMMUFD VFIO compat mode, the
> > group open path skips vfio_df_open(), leaving open_count at 0. This
> > causes a warning in vfio_assert_device_open(device) when
> > vfio_df_close() is called during group close.
> > 
> > The correct behavior is to skip only the IOMMUFD bind in the device
> > open path for no-iommu devices. Commit 6086efe73498 omitted
> > vfio_df_open(), which was too broad. This patch restores the previous
> > behavior, ensuring the vfio_df_open is called in the group open path.
> > 
> > Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation
> > out of vfio_iommufd_bind()") Suggested-by: Alex Williamson
> > <alex.williamson@redhat.com> Suggested-by: Jason Gunthorpe
> > <jgg@nvidia.com> Signed-off-by: Jacob Pan
> > <jacob.pan@linux.microsoft.com> ---
> > v3: Apply a concise fix from Alex
> > v2: Use a fix from Jason
> > ---
> >  drivers/vfio/group.c   | 7 +++----
> >  drivers/vfio/iommufd.c | 4 ++++
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> > index c321d442f0da..c376a6279de0 100644
> > --- a/drivers/vfio/group.c
> > +++ b/drivers/vfio/group.c
> > @@ -192,11 +192,10 @@ static int vfio_df_group_open(struct
> > vfio_device_file *df)
> >  		 * implies they expected translation to exist
> >  		 */
> >  		if (!capable(CAP_SYS_RAWIO) ||
> > -		    vfio_iommufd_device_has_compat_ioas(device,
> > df->iommufd))
> > +		    vfio_iommufd_device_has_compat_ioas(device,
> > df->iommufd)) { ret = -EPERM;
> > -		else
> > -			ret = 0;
> > -		goto out_put_kvm;
> > +			goto out_put_kvm;
> > +		}
> >  	}
> >  
> >  	ret = vfio_df_open(df);
> > diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> > index c8c3a2d53f86..a38d262c6028 100644
> > --- a/drivers/vfio/iommufd.c
> > +++ b/drivers/vfio/iommufd.c
> > @@ -25,6 +25,10 @@ int vfio_df_iommufd_bind(struct vfio_device_file
> > *df) 
> >  	lockdep_assert_held(&vdev->dev_set->lock);
> >  
> > +	/* Returns 0 to permit device opening under noiommu mode */
> > +	if (vfio_device_is_noiommu(vdev))
> > +		return 0;
> > +
> >  	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
> >  }
> >    
> 


