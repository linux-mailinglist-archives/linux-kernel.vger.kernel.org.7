Return-Path: <linux-kernel+bounces-879257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67134C22A88
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A69134C2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8D733BBBB;
	Thu, 30 Oct 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veMub3IL"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7932ED2F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865810; cv=none; b=i8SoZMHRV5Rmi12ClxjROUziFNNUOj3/04y/7CV+51Rx+Jl8qu5nCHbNiEDY7hSNb+ld75U8KQ5yhesSBJrZB6+y9gvaqlRxwNpSOtvoC1jMyTTGpiBqIr4ktAgTsv91yYeO4CvkZje9cJ0Eebmcn7e3M6fB9iYpS1P+h5Y94A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865810; c=relaxed/simple;
	bh=3c8fubCSOMv120xOPHfvgzA84Hedn11zJ/B3Ut3CdEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzRZq5hRpk4HKSej5dwWkUJqqAeO0Qvc/7NfIRzfiIueaNlpCtkly+FfwPR5mi41++BxO8b7wJWZmiARXPBc+mb9YkhCLCy4XaFo7AqkR5kWCP7csjf46+Na8utlOZh1Gou9evHgRuN2dI5SnSdp/ls2FTJTNtCuUfLxgN3HhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veMub3IL; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso1371651a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761865808; x=1762470608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVrBZIo4jViBqFI34xTRu6DdRHmaa8XjkF8JPCjoQvA=;
        b=veMub3IL6/IzVwVBTVxovKgfQ48ftr9Zb1gFb2xlhnmYqV7gs5wTh/Qkpgd1/MAJqp
         CinbTODC4ksv2ffWtVGxWpWRYjXJhKlaQuXYSa+VgYzFVcJMV3KSISioCzjfHjbQt6p3
         nUcb2R3dQfSMN+FzOlPIzs6w1bBknLxmJPlgp4FZhVvhe2ezsYk5fXwNZikM5Nsdkj/9
         Hss/oy10N/xNwt+RPSKw5XZ6s+JyWVuCfktuU84bx5PJBY6+scLUo7V5XqGy7s7OXZlh
         CC5xj5s96JqHbCRc4aiHVVQm4jbMXEazmypQrf8CIq9XAFZahwQKpE45ENATZYcBgHL3
         d+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761865808; x=1762470608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVrBZIo4jViBqFI34xTRu6DdRHmaa8XjkF8JPCjoQvA=;
        b=N7h/6RCv7BgXuM4LLcqqoxaXXUddVPLcTEYrmxQeP1jbH0rNYqibjEI/w2jiDgB9iq
         Gccgo9l+xpjP7RlS23JwNBtHgPw5XDM6ilI4MwiQfT6YFr6GJlg07qtmgW+VH790R1lt
         bu2ver/7y0nG+oUNQ+O1YuUw649YG2tVGP9zal+S+pfiQapTOrvYljsHIPJ3xU88aeQs
         v0FX/DWTNOX9Y+fg7DudFyE0OH/spb/OPsNqpmxezhVvIjbqz6pMkCNhSxKBkaZkfSUB
         fqrLPF36Iz+8TAp+/CLmb+6S/7CdDzORTd2dgDvfhE3ovr6EWIQWeTeJObMtHbpZGxj3
         cetg==
X-Forwarded-Encrypted: i=1; AJvYcCVN/LWwqQ4t3/2+T3xs+sKNHrSUy98O8r4IYfFT5wHmZnk38D3T2MsjPZFE4d4TlYUtAepg7N2War7ICSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzclh92/8r9sJJ8+GGEUMCU0rlOy8p0pnAhAWQ3ObwyxTEkMqW5
	pJBFAGDScNRVCaCudP+vTZTxcjOJHKXxSYODtrPk2wR+FwneKZxAKAGsxyYbcFYGfg==
X-Gm-Gg: ASbGncvOPq0OxyZWcbX/UUYyLw/Yf0KN01I51tzZO3taaZqSBPnAKXEVzl2Kad5iGBY
	PPM+ZYeISR8barpbvqMX+eTB5fMEXfcKh+QJNQCTctLftZg/s3RWllNvLT3KebgRr4uw5AgHFxG
	bgtpPWslAetutyOt5hgvXx9nDTUA6MWTjXRGGkyVEIDABZ/RzcHSWYBYjeUISM0duhhA5ISIBm5
	CxlCxKMRMKX3GXeKsmZ2Tc7XjqutCWHqvoUA4prHfPDh38LAL1rhAWZdEX0YMSY7asiu5Cils4G
	Q62Ee8EdMq/1/HFYyZKADP37NUuu4xbM7tCIow+G/gNmv2Vu7xSvIUQ9hrFMgaXBX2VR4369G3U
	FcXEq2glVS36EFKLNeNJxNh2LKPxIRFsu5UUD2mmsvTiYOfYfVyKNfQzroY1wuQKlNC4xuOZI2+
	Ok3kHMwbTvkw25Nu1481N0uyN0LgcpV3x/6p8DrLTgU0R9WB3KDDgq
X-Google-Smtp-Source: AGHT+IEM9Vd0HVjov8boWovrq63avSdAuwijp306wSVuatfQyJg281aFDD9T6kwljFFF6SpZOGU8uQ==
X-Received: by 2002:a17:902:d505:b0:290:c0ed:de42 with SMTP id d9443c01a7336-2951a4dfc4fmr19563065ad.36.1761865807920;
        Thu, 30 Oct 2025 16:10:07 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699b791sm833815ad.75.2025.10.30.16.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 16:10:06 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:10:02 +0000
From: David Matlack <dmatlack@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Vipin Sharma <vipinsh@google.com>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com, jgg@ziepe.ca,
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com,
	parav@nvidia.com, saeedm@nvidia.com, kevin.tian@intel.com,
	jrhilke@google.com, david@redhat.com, jgowans@amazon.com,
	dwmw2@infradead.org, epetron@amazon.de, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
Message-ID: <aQPwSltoH7rRsnV9@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-7-vipinsh@google.com>
 <20251027134430.00007e46@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027134430.00007e46@linux.microsoft.com>

On 2025-10-27 01:44 PM, Jacob Pan wrote:
> On Fri, 17 Oct 2025 17:06:58 -0700 Vipin Sharma <vipinsh@google.com> wrote:
> >  static int vfio_pci_liveupdate_retrieve(struct
> > liveupdate_file_handler *handler, u64 data, struct file **file)
> >  {
> > @@ -21,10 +28,17 @@ static int vfio_pci_liveupdate_retrieve(struct
> > liveupdate_file_handler *handler, static bool
> > vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler
> > *handler, struct file *file) {
> > -	return -EOPNOTSUPP;
> > +	struct vfio_device *device = vfio_device_from_file(file);
> > +
> > +	if (!device)
> > +		return false;
> > +
> > +	guard(mutex)(&device->dev_set->lock);
> > +	return vfio_device_cdev_opened(device);
>
> IIUC, vfio_device_cdev_opened(device) will only return true after
> vfio_df_ioctl_bind_iommufd(). Where it does:
> 	device->cdev_opened = true;
> 
> Does this imply that devices not bound to an iommufd cannot be
> preserved?

Event if being bound to an iommufd is required, it seems wrong to check
it in can_preserve(), as the device can just be unbound from the iommufd
before preserve().

I think can_preserve() just needs to check if this is a VFIO cdev file,
i.e. vfio_device_from_file() returns non-NULL.

> 
> If so, I am confused about your cover letter step #15
> > 15. It makes usual bind iommufd and attach page table calls.
> 
> Does it mean after restoration, we have to bind iommufd again?

This is still being discussed. These are the two options currently:

 - When userspace retrieves the iommufd from LUO after kexec, the kernel
   will internally restore all VFIO cdevs and bind them to the iommufd
   in a single step.

 - Userspace will retrieve the iommufd and cdevs from LUO separately,
   and then bind each cdev to the iommufd like they were before kexec.

