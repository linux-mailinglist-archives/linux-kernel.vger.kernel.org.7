Return-Path: <linux-kernel+bounces-721505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD709AFCA1A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA7C3AA212
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1332DAFAB;
	Tue,  8 Jul 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="izBApebl"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F072550D2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976587; cv=none; b=OdKyXoVIJlk48AZNwDm/h6DIZFK/HKJNsbsMwKb1hXnynSF5fJOs9O7eeybA8C6CczW//8lW/+zj6UHTLdsLxDIq+AkiBitnBgT3uvLE6MpWrWvNqGRgOcb3kBLqF5DcFsghnTgE/PzSJib1KQU3B0w1rhPZIxzluelGaN2xPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976587; c=relaxed/simple;
	bh=dyXUujHTnYYHwk8qxqITJQ9BmoorGjnNWrcKqYxBG+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1orl0X71i5vZZRxXnE6Fy1+uN6QNMNPdglALBkr834jyzyq3gzcVuqHUmEtkVVek7wkePdz0VGG+44GWRirTVeAX3ZJF/7A3gZDWxidgog5Q9xhKJeumZL8ftDSSHnsfqLkFwYoXwPYKya/YGvGgpiMja3fPMq/fHPIyH5BITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=izBApebl; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32f1df5b089so27667031fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751976583; x=1752581383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMrJyzq+XGe4XZwQoy4OMfTD6mqi6tUL9Fg2sLgmdig=;
        b=izBApeblB4RBepvFdR/yqPV1oV+2WUFs34UVBQxkGH4rXdyUiSkDCGmlM5EK5Df25x
         e62cxgy+a4j4a2/Bk56KV46s0fONLNlagv6JmgX2XLvHrCzrJ4onEl3L+61KQJwmSTPE
         uQ0V0wWE7kik8UvfeBufj9EjpMDJtIm15Fgzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751976583; x=1752581383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMrJyzq+XGe4XZwQoy4OMfTD6mqi6tUL9Fg2sLgmdig=;
        b=UMsyYSM8pCx/kSPrEazFGrZA3jg4tAPWgsmFk1nGlpdFdV0Lar6tkw0k4Sp0AmuMwP
         BrATxdwH/J23/fwMgBwpe+zD3t49F80nz+wXudjSisC5LGtmvyOsIXO2aea7/ziFrSBA
         RwFcittrQ+b06nE78zOYQOyZ7uv55rerwLYGRUlEHGbiMPA2QzikXPQoxqV0qvyUfyLl
         RXVfaeKX4tx+SrYv+vjbH82DNCWEgzW5RZxhj8CIuKDQ/Nrhbvoq5NpTOKob9hg61vWZ
         FGW8i0V9Mn30Fr97cNo7JwQQFFy5koRrCyoj7CWAjXh4CTJVZoRga+Jge7DRSWPnZKX/
         sieA==
X-Forwarded-Encrypted: i=1; AJvYcCVHGZExTpxNJrboRxf6hFxmvdeHozNCQoPfX9zasW5i8i1vNXxv+lG7awtvfIyqE5sQ+WisQlxiNo0pceU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQqq9VVmRApypQF1m6myZSsls9wdAbdc8Olk3MbsdJ4tRB8Avi
	TdTMdhDerFeMaU2TsYrPhuRd/4U589BMYtfwPWPXDVZXN62VCc8hBSxYKC0GCnGQe9ahnAx0KgX
	p1cLTW/7/
X-Gm-Gg: ASbGncvjWfIsOOnCau+gnSKd3YCRoXccDEr0mkfxDsonXDcFWgUQvlXrgEMHIqLKdqm
	FQtn5TD33eKLDTg0pyCtDU4fEosL5PiTtGxyn0PhNHcGXGXHSK6IYRl1/JBomFAPK+VkbkobWPa
	4Vvtp3TJAFvaWqPA+bDVVElRgINgcHPLqIelIhp7bB5Av4egwsGYY+Odm7Lg8bTV5PgskNbN6CB
	xPppq3lTHiojKH6qEwArhCYfjc9K3sS4Fqxmoujwazw37Prl6pen5bHsgtUOga7BOh32YqP+EZV
	XJukD6CiltwF68rtC0VyTvwdPG4+C0lth2GWyzUrpTHwPqr6gfJKciwVlyWO4bQlobL80ACu8JA
	vPza3/HJyi81m8kmxVfn4DvgT2NsokPzPEjXTKpQ=
X-Google-Smtp-Source: AGHT+IHXuWGHbnbAoxL6ihnO8QjgLe6ktA9GhBOI7EB0Q/YzQ14Cb655eT8bkJC+EW7owJU5PXSxGQ==
X-Received: by 2002:a2e:a606:0:b0:32b:7cdb:aa4d with SMTP id 38308e7fff4ca-32f39b4ce21mr6797001fa.31.1751976583434;
        Tue, 08 Jul 2025 05:09:43 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1afc389asm14265751fa.37.2025.07.08.05.09.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 05:09:41 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b43846e8cso34841251fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:09:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAjSRz0i1pmCtnqF0uZldXwaAIH8LZ61Di3Hz13yVJfyGUnET/6nnY4Wlw8s6+0/jt6W+/I1lsvL54Go8=@vger.kernel.org
X-Received: by 2002:a2e:8e3c:0:b0:32f:1c0f:fb74 with SMTP id
 38308e7fff4ca-32f39b2409amr8468421fa.22.1751976580861; Tue, 08 Jul 2025
 05:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-5-5710f9d030aa@chromium.org> <aGw_1T_Edm8--gXW@kekkonen.localdomain>
 <CANiDSCup2iRx+0RcaijSmbn04nBY4Ui9=esCPFsQzOKe=up9Gg@mail.gmail.com> <aGzjTRSco39mKJcf@kekkonen.localdomain>
In-Reply-To: <aGzjTRSco39mKJcf@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 8 Jul 2025 14:09:28 +0200
X-Gmail-Original-Message-ID: <CANiDSCsqEHTnbvzLMoe_yxi8JRzp+2PQe3ksXhD=Y3+AqC_9hw@mail.gmail.com>
X-Gm-Features: Ac12FXyPY8jp6OO5y2rUkBGCgm071L0BZh3437cx12a8IP9Dnshn9sW-VSnuQ7c
Message-ID: <CANiDSCsqEHTnbvzLMoe_yxi8JRzp+2PQe3ksXhD=Y3+AqC_9hw@mail.gmail.com>
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

On Tue, 8 Jul 2025 at 11:22, Sakari Ailus <sakari.ailus@linux.intel.com> wr=
ote:
>
> Hi Ricardo,
>
> On Tue, Jul 08, 2025 at 11:16:25AM +0200, Ricardo Ribalda wrote:
> > Hi Sakari
> >
> > Thanks for your review
> >
> > On Mon, 7 Jul 2025 at 23:45, Sakari Ailus <sakari.ailus@linux.intel.com=
> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > On Thu, Jun 05, 2025 at 05:52:58PM +0000, Ricardo Ribalda wrote:
> > > > The v4l2_fwnode_device_properties contains information about the
> > > > rotation. Use it if the ssdb data is inconclusive.
> > >
> > > As SSDB and _PLD provide the same information, are they always aligne=
d? Do
> > > you have any experience on how is this actually in firmware?
> >
> > Not really, in ChromeOS we are pretty lucky to control the firmware.
> >
> > @HdG Do you have some experience/opinion here?
> >
> > >
> > > _PLD is standardised so it would seem reasonable to stick to that -- =
if it
> > > exists. Another approach could be to pick the one that doesn't transl=
ate to
> > > a sane default (0=C2=B0).
> >
> > I'd rather stick to the current prioritization unless there is a
> > strong argument against it. Otherwise there is a chance that we will
> > have regressions (outside CrOS)
>
> My point was rather there are no such rules currently for rotation: only
> SSDB was being used by the IPU bridge to obtain the rotation value,
> similarly only _PLD is consulted when it comes to orientation.

So something like this:?

static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
                                     struct ipu_sensor_ssdb *ssdb,
                                     struct
v4l2_fwnode_device_properties *props)
{
        if (props->rotation !=3D V4L2_FWNODE_PROPERTY_UNSET)
                return props->rotation;

        switch (ssdb->degree) {
        case IPU_SENSOR_ROTATION_NORMAL:
                return 0;
        case IPU_SENSOR_ROTATION_INVERTED:
                return 180;
        }

        dev_warn(ADEV_DEV(adev),
                 "Unknown rotation %d. Assume 0 degree rotation\n",
                 ssdb->degree);
        return 0;
}




>
> --
> Regards,
>
> Sakari Ailus



--=20
Ricardo Ribalda

