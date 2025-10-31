Return-Path: <linux-kernel+bounces-879297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63940C22C64
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E7844E83AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5070B190664;
	Fri, 31 Oct 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WR8lxUAx"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C871624DF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761869974; cv=none; b=IRYewB/m/Rt9W8vGZ7Sht/ImMYGnaycqKNHNr3sI7HJqenVx7DNhsmtcaVLF/2oWaBNh57BdsnOGgNQ4jZ0DISfbehrlixb8tu/5J76/VtWlKRVXIOx924eyqtFzXLk8VlLgeVDen8lLhLMvBljNtNT7bdWl3jY5ws9kHumihcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761869974; c=relaxed/simple;
	bh=8rHUYkXKPL5IW43a+4rQNutLuyHqHIoW5Z0VxJSm0u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcA8ma4C09uknR4RUlXyCBJkJsHQensrltxJMQMwD/e623KHP8blm5VkZADgxvk8ZNhOLcS8mO0r5kjv3d7L/THtemAHwjjjDWaocnGd1FW4KBfovCe4Hpsl7Dzfz7P06NWVUb3uvFFcMo2jzaySuxDpag9uyOHUwpq4PlpKa4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=WR8lxUAx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64071184811so1892506a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761869971; x=1762474771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv3Ljvf1heM/ChX+5Kbnk959i79o/ym9ON91SVXdVic=;
        b=WR8lxUAxQmD+DWLD1tgzmINQnPnyk6Vm976ZZpfc/IITPpAPs+kxbXZbaybX0nFwbv
         NP62A1PqWLovWAkXh9DGcUrXuzEEQQpxKJ3JorgCVpURG+3TKFcJ9nQy3vy+SWPmR3NS
         X8PTqprIfWt1r8qoyEIY8+qr8MTuKr8btlRjGZ2k1dZ7zM41eNj7VKyWMl1RNHRk6Zav
         0IxobgQB8mmDp07zCyQVT5Jn4zr7J1GWVIvCUjPxfK9x782d6AEE0y2XdGOLZJ5OPbNx
         xq4vRUKVwBDN8go1aAmpL3GcFErz41o/O7lOstO8c67Lob+4CzOstfEduiGJ6TAwzc5Q
         O/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761869971; x=1762474771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cv3Ljvf1heM/ChX+5Kbnk959i79o/ym9ON91SVXdVic=;
        b=NN9aBr2iFKDOXCVnhoUnnGW9SE6wOKbPpkPqa/fxDD6ZJV0+YkOZE+aEK29Z5tciPP
         ARf5N8ihMcFGOPbqeVeFHGz0Vka7MexqJYuOwjDDIf0B++Yw9PMAayocITF6vvmECA5b
         TiA5MSBSWPe9vbJXkLu3vssXDaYiHcELF05rPSWNbwb6zbilU+styrGs6U3U9Uax8TIJ
         cToBdNt+Ut3DSsvuNJal0TMzkpay6RfQ9vwkZqHGx3eFklokaBM9sp5J2Mdk/zrHbM6+
         fxlvguO6yGXrTx5jRj1zV0Vh1ow8zxDceM2i2JtGRD/SSsm5HX8/BniAJTUGWFcHkH9a
         ilnw==
X-Forwarded-Encrypted: i=1; AJvYcCXB4HJc6lPUArbM+L8Zw5jTVPyRIUBdc8686SNFSgfEu86ddpsM9R/HpPtG7wtuLFS+tRPltNNZscDs59g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+i70H9cM+aGHngOHuTE7Obqh4aqRlWNMO77uu7VcJ53eWocsO
	d/n+DUipEg9/vDhaCtZU9tGIvwbkBpN9v3VlPqanJX6KHbTa4A8I0t2auzvjkm2Jsc4cXJ0uTPb
	cPPMNu5E7i633pskRKGFLjmkR4hud+GsiHhu5RL8kZQ==
X-Gm-Gg: ASbGnctt5/ke5jgbtEMloPlY0jUKZ4AZapFlUddPiLHrT2GcNYgVgqjF50ZnvDHyczi
	6I8rLzYYbZgXoWyZLUyf0USM+m3uDA850maid4MBuGmGclnpfdEQLx9SsRfDaZ/5rpmq8bNabB/
	nOyW0i4P7vkCMN6UpcfmeSbUBv+69G5isAu/l7BdeJmabCqssmnTSXVRdNBc6AKW1lbk/vDdJjF
	sTXqnItEhVVXlE/Aj/AcrxrIi9sR8a6rwWlkb6y7H0H2lD9JvbDlgq43hZmlxxAZ7EV
X-Google-Smtp-Source: AGHT+IHAmJ5aHdM6JoD2TOJsB7BThxEoT5eo1YrDOCS0gC6NmplAKbJLD+yZsTcgPKK2dj5Dhi5gMIE8RdzNHN72sus=
X-Received: by 2002:a05:6402:13cb:b0:640:6a18:2931 with SMTP id
 4fb4d7f45d1cf-6407702dcd1mr1160377a12.29.1761869971150; Thu, 30 Oct 2025
 17:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-7-vipinsh@google.com>
 <20251027134430.00007e46@linux.microsoft.com> <aQPwSltoH7rRsnV9@google.com>
In-Reply-To: <aQPwSltoH7rRsnV9@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 30 Oct 2025 20:18:54 -0400
X-Gm-Features: AWmQ_bmaQn5U2r87lGmHMokOwG7--caG9FTwwPKr2aHRFfrExiLwJYx42aUNdvg
Message-ID: <CA+CK2bD-E0HKsuE0SPpZqEoJyEK4=KJCBw-h1WFP7O1KEoKuNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
To: David Matlack <dmatlack@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, Vipin Sharma <vipinsh@google.com>, 
	bhelgaas@google.com, alex.williamson@redhat.com, jgg@ziepe.ca, 
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org, 
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, 
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:10=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-10-27 01:44 PM, Jacob Pan wrote:
> > On Fri, 17 Oct 2025 17:06:58 -0700 Vipin Sharma <vipinsh@google.com> wr=
ote:
> > >  static int vfio_pci_liveupdate_retrieve(struct
> > > liveupdate_file_handler *handler, u64 data, struct file **file)
> > >  {
> > > @@ -21,10 +28,17 @@ static int vfio_pci_liveupdate_retrieve(struct
> > > liveupdate_file_handler *handler, static bool
> > > vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler
> > > *handler, struct file *file) {
> > > -   return -EOPNOTSUPP;
> > > +   struct vfio_device *device =3D vfio_device_from_file(file);
> > > +
> > > +   if (!device)
> > > +           return false;
> > > +
> > > +   guard(mutex)(&device->dev_set->lock);
> > > +   return vfio_device_cdev_opened(device);
> >
> > IIUC, vfio_device_cdev_opened(device) will only return true after
> > vfio_df_ioctl_bind_iommufd(). Where it does:
> >       device->cdev_opened =3D true;
> >
> > Does this imply that devices not bound to an iommufd cannot be
> > preserved?
>
> Event if being bound to an iommufd is required, it seems wrong to check
> it in can_preserve(), as the device can just be unbound from the iommufd
> before preserve().
>
> I think can_preserve() just needs to check if this is a VFIO cdev file,
> i.e. vfio_device_from_file() returns non-NULL.

+1, can_preserve() must be fast, as it might be called on every single
FD that is being preserved, to check if type is correct.
So, simply check if "struct file" is cdev via ops check perhaps via
and thats it. It should be a very simple operation

>
> >
> > If so, I am confused about your cover letter step #15
> > > 15. It makes usual bind iommufd and attach page table calls.
> >
> > Does it mean after restoration, we have to bind iommufd again?
>
> This is still being discussed. These are the two options currently:
>
>  - When userspace retrieves the iommufd from LUO after kexec, the kernel
>    will internally restore all VFIO cdevs and bind them to the iommufd
>    in a single step.
>
>  - Userspace will retrieve the iommufd and cdevs from LUO separately,
>    and then bind each cdev to the iommufd like they were before kexec.

