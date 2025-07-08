Return-Path: <linux-kernel+bounces-721844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D71AFCE89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5EC171F0B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2DE2DEA78;
	Tue,  8 Jul 2025 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iYfoqZlw"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93DD1A288
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987178; cv=none; b=WM8BpleplaZQqRkh7NAIc3pO3jw/BbOTfRqag7164M09JEjbkgl7nL/uO9EEPXgKaMfmU1QXjmo2IQEtewMfdSPSLiY2KiGIbQ2D+bECXbByl8rfDrw9R8cReNKQum3OhZygw+Pol48qMjcBTluIfc6y/WZwjwmnFHtvq8QtTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987178; c=relaxed/simple;
	bh=HGTpVxEEJn+4Z8F/2vfMSUr1vMJyUPWvL7WDo/xrVN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrxfOUXgeJBMWv6pSHJPFCWFBrJE1Ab5nmoBn0umvzslhag97Q+s8znCPz9LVMSA0odrU+SpT77vjUfkzhrNg+xDGVVjDqDchzy+ZiFFJjax0bC8RunR7zOTPw5356EK1rIJc2Ezv2QSqspAhL4mRRMwRRmjB2A9LDhrGCjns2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iYfoqZlw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55511c3e203so4067052e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751987175; x=1752591975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsjEc9LmeMOTlM1N3xvojXwrwvOBpBec3I1iTp5IlDk=;
        b=iYfoqZlw5nWnHnIMaRbf5FsYT1zsDYDO85OODkk7g+MecDXZW03LoPtLIHpS717JZj
         2chSnaqF5ekc0xCmrC6C1QOIiFqWdBjoDo5bmWY2Xb4r+PBJTTUo8/CwPR00VVbwUKrE
         vCxCnsxTB3mKeLJK7EKHfPdBJMnEOI14OSxoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987175; x=1752591975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsjEc9LmeMOTlM1N3xvojXwrwvOBpBec3I1iTp5IlDk=;
        b=wFOzgKpeZStRlaXXuspQiqf2Xvv3FDRorMPyaUjZCBhpbZ6fd2DRAij7qHWATyP2ly
         P6fRf4sZpQXlTgRrajPa2H34Wv1ZUUdtvxDHyQv//XGqIdcWUmtmSf9/4/RDr7eAuzjq
         xarrxXjRJQ98suJJHIfhS0H5bn7ijPmxEgU+QoKPVOxhEkiU5nIo7v2kmiYrBRNCPfzw
         XGS14MNnbHbxMKCdqcw1Iqr/QXTTymlT3AnAWndX5TD29QcJofsPhtKhJFmjuY2OgdWC
         +2o9NwiSkAnCi3LNRcU5cPW8OSBULoBQ6/hMmylmyZHkdGaVg+nxi/t6W0+2RrRO8t+v
         l+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6sL9tkIlfOmjRP2O/zOJlS6z9O2dEtfE3rQTCi+szCN8llyEjVPC7Pfg4FcQmGTWgA6EP9/OLCGG9kK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwrz9+w5ZaWQdb+o6UuczscBizAws+MQ6p6tlyEhCO72oGApt
	Y9ic7CrZzzM26BaUVUwWujzKpjoGiWTE7coSs145cCuLYsssX7wdOCEev3jDKWbotDj/mUfvWDb
	ClPbn5VXs
X-Gm-Gg: ASbGncvVjhkUE/nuNWuLb+OY+MsiSq9T1WyPnrvvb4VZchoCznrIt++l1rljrHRf0o7
	WXFwdPwlpU8uJlwJvPg+4jJLlc+f9FhV8jMhBNkFU1ukdkwvWWOLrUEr5wctHtQwNXgGCWXSZJk
	XMxTkNFRxH/Kk217Uc6p1Xuhf4zwuKnbBVxf3ZRyhV/vPHMh17LGNon/oii3jY95enb889cTply
	zfFdmSLYC6RO5yh8xv0WD8/HqatqHYb1kd+6aIAlUhhdL7CFk8V2qItXyZU2pIVdOiJMgO/CSah
	dBA3EW0IPVzhCEUtmXfuRQhbx7yjSZQfvT/ylBI8+PLAeD+2awRCdAdO9ohcdNd2RMnLbS3+X81
	JWsSp/C3J5griioeeXEZ2W9Svb1XK
X-Google-Smtp-Source: AGHT+IHHWGLNHjUCyDoVgSBDup3LviPLMbBYro5hOeeg3C2lfxLbuB9Tk0/KLnQjc14pPi45EWAcMw==
X-Received: by 2002:a05:6512:131c:b0:550:e527:886f with SMTP id 2adb3069b0e04-556de363b96mr5154324e87.51.1751987174460;
        Tue, 08 Jul 2025 08:06:14 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d8dccsm1687294e87.66.2025.07.08.08.06.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:06:14 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32f2947ab0cso20447531fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:06:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcnu5FVVIuqd/ozUNG6Or+KDNlin4I97IvvRmbNz5phQopobQW0emsO2lDoRbkWBxEBn6TU/jW/S0kw3g=@vger.kernel.org
X-Received: by 2002:a05:6512:ac8:b0:553:3028:75ae with SMTP id
 2adb3069b0e04-556de076273mr5727105e87.46.1751986718368; Tue, 08 Jul 2025
 07:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-5-5710f9d030aa@chromium.org> <aGw_1T_Edm8--gXW@kekkonen.localdomain>
 <CANiDSCup2iRx+0RcaijSmbn04nBY4Ui9=esCPFsQzOKe=up9Gg@mail.gmail.com>
 <aGzjTRSco39mKJcf@kekkonen.localdomain> <CANiDSCsqEHTnbvzLMoe_yxi8JRzp+2PQe3ksXhD=Y3+AqC_9hw@mail.gmail.com>
 <aG0NI2V0Tfh2HZ6O@kekkonen.localdomain>
In-Reply-To: <aG0NI2V0Tfh2HZ6O@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 8 Jul 2025 16:58:25 +0200
X-Gmail-Original-Message-ID: <CANiDSCu=wU_Oi7CLPcYTC3Xf_pGbDroaVitPAiAj7ND5pXy-6g@mail.gmail.com>
X-Gm-Features: Ac12FXx3zIz7eqEIVhgOFhdr-yyA-k97hK_sQ1bucetsK4DfnOnoX-8awEd9Sp8
Message-ID: <CANiDSCu=wU_Oi7CLPcYTC3Xf_pGbDroaVitPAiAj7ND5pXy-6g@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] media: ipu-bridge: Use v4l2_fwnode for unknown rotations
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Jul 2025 at 14:21, Sakari Ailus <sakari.ailus@linux.intel.com> wr=
ote:
>
> Hi Ricardo,
>
> On Tue, Jul 08, 2025 at 02:09:28PM +0200, Ricardo Ribalda wrote:
> > On Tue, 8 Jul 2025 at 11:22, Sakari Ailus <sakari.ailus@linux.intel.com=
> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > On Tue, Jul 08, 2025 at 11:16:25AM +0200, Ricardo Ribalda wrote:
> > > > Hi Sakari
> > > >
> > > > Thanks for your review
> > > >
> > > > On Mon, 7 Jul 2025 at 23:45, Sakari Ailus <sakari.ailus@linux.intel=
.com> wrote:
> > > > >
> > > > > Hi Ricardo,
> > > > >
> > > > > On Thu, Jun 05, 2025 at 05:52:58PM +0000, Ricardo Ribalda wrote:
> > > > > > The v4l2_fwnode_device_properties contains information about th=
e
> > > > > > rotation. Use it if the ssdb data is inconclusive.
> > > > >
> > > > > As SSDB and _PLD provide the same information, are they always al=
igned? Do
> > > > > you have any experience on how is this actually in firmware?
> > > >
> > > > Not really, in ChromeOS we are pretty lucky to control the firmware=
.
> > > >
> > > > @HdG Do you have some experience/opinion here?
> > > >
> > > > >
> > > > > _PLD is standardised so it would seem reasonable to stick to that=
 -- if it
> > > > > exists. Another approach could be to pick the one that doesn't tr=
anslate to
> > > > > a sane default (0=C2=B0).
> > > >
> > > > I'd rather stick to the current prioritization unless there is a
> > > > strong argument against it. Otherwise there is a chance that we wil=
l
> > > > have regressions (outside CrOS)
> > >
> > > My point was rather there are no such rules currently for rotation: o=
nly
> > > SSDB was being used by the IPU bridge to obtain the rotation value,
> > > similarly only _PLD is consulted when it comes to orientation.
> >
> > So something like this:?
> >
> > static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
> >                                      struct ipu_sensor_ssdb *ssdb,
> >                                      struct
> > v4l2_fwnode_device_properties *props)
> > {
> >         if (props->rotation !=3D V4L2_FWNODE_PROPERTY_UNSET)
> >                 return props->rotation;
> >
> >         switch (ssdb->degree) {
> >         case IPU_SENSOR_ROTATION_NORMAL:
> >                 return 0;
> >         case IPU_SENSOR_ROTATION_INVERTED:
> >                 return 180;
> >         }
> >
> >         dev_warn(ADEV_DEV(adev),
> >                  "Unknown rotation %d. Assume 0 degree rotation\n",
> >                  ssdb->degree);
>
> Maybe:
>
>         acpi_handle_warn(acpi_device_handle(adev), ...);
>
> ?
>
> >         return 0;
> > }
>
> Looks good to me. Maybe something similar for orientation?

Do you mean using ssdb also for orientation or using acpi_handle_warn?


I cannot find anything related to orientation for SSDB
https://github.com/coreboot/coreboot/blob/main/src/drivers/intel/mipi_camer=
a/chip.h#L150

Am I looking in the right place?

Regards!
>
> --
> Regards,
>
> Sakari Ailus



--=20
Ricardo Ribalda

