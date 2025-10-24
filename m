Return-Path: <linux-kernel+bounces-868413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 445D3C052EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECE3C58143B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6B30594A;
	Fri, 24 Oct 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX2s72mv"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077053064A1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295141; cv=none; b=tr9AigUHRPmbJ3JxlFxvkRgMjw+PnzBtyyZbme1eL0v4WwFrVz+QZ9KMYccW6Z742eXyC4uZkxCTUo1D5A7prKNLSaTizg7Bm2kgOTudRz8cvkh9v5hhyC354ggyc75a6d7gaet43umqhf95ccjxxB42SJRokjmFjFmpo4YiKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295141; c=relaxed/simple;
	bh=WXCqwiJaVzwif74IHtQzyPxXFrlHw+EGeR8pfbgmG08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hv7z6RmA1FGKLDXBTsOVXey0G40GBWm9JaIw4O8EOEozucs9Ec0BQwzSMzRNJVSufdZF4aaxJkkRIzgW6z3OQk6aEr/Gl6KCuA8slBEolOzClNoXfE4DVEoCn/p1d1EXqG/cO5XnbkpmPIsPbHenadaurMkGdGjrdsXee2HB2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX2s72mv; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b3b27b50090so335567266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761295137; x=1761899937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOoOk6fIvEaDShhUmAzlzdMKvgXXV9HjXrl++QyhiQI=;
        b=NX2s72mv9cBjMc5Fwa+10R5tk+AsdfpiTQVwN3tMWFthG3RwMzxr9zNDiPxGRXXpgA
         yDVLTyg7oKTd6tu0LrL6z0aC97r181X17EiWbDfV7forO0DkaQIR294mt2gZ0eYHqK1J
         JEWmDLnxerR0oSNlvxEQ+2V9snXLKou2wIU07eLQWIdmHGVKMiAMOYFZoq+ybN7yg1EW
         GG3wKIso9Pb2vXuwrFmuS/dZtDrFq6hsAyiSLxZOVwSM51KU645Lcmoz/85H0b47VMFF
         ZQWOIerznZh3a8JCloR5FjKu4zWwowiZYtO6ZYBtuC3E7I0d+Pt4i445kE24u6AqzKbz
         7jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295137; x=1761899937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOoOk6fIvEaDShhUmAzlzdMKvgXXV9HjXrl++QyhiQI=;
        b=ra9WUv3wKZyXuKcfifEYUniaISDHiFYa9lZ4wUTqX6Cfy+MINHNEfEwGXs9hHeggaJ
         XiGjXoMgQDDA3p0SW7yn+/g7LdVuyKxrvA2cAXHQR6UWMGYLUEuFjbJbkKJ3bi+vTslo
         Vdgb/WmqvnNDKfd9mPbdJybd0AQj+9GrDLSc0eHUfW/KPNDFEhQDERDINQViIk+fGkLH
         x4hvMxBmfuVdO3yp3oQhxG0a6s77WA2d6L/+zhoDmTVTgqeUPpk317IEbmsoIoYZJa5B
         ralq+6QPww2g/TgiTrgwK9OEMVtXXhBNdrsZai6GoVVM9h+uDg/qL/QYz4z1+bqgQc1N
         1jAA==
X-Forwarded-Encrypted: i=1; AJvYcCX+39q6ntRi7ME4/0KMOo3VdmedKHHdGm/WhTzU9eDnJAFW4cjNqdQvmBNTfHwDSH8u4l5bOKTGBP61ZKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOvmnMkk+2IVIPBfXf5OpPV7FZXE7iWMGGQdgUcVn+SPq4flc
	N6uYIH1Bbbpb+vzpp9lW4S4EjuVnoGKSWBxoX8SzqFYzc9BQN079ltdkyImoVGZretT7ZV/GqQz
	el/Lwdwp7n4SaffggEfd2cVmmbob8+S8=
X-Gm-Gg: ASbGnctgzTkVYrf2eMQ+ddxxDdvLZgthpT7RFsMDfh/OeAVI8h4E9ybrCwRlW5zTy3L
	ek48JOTl0VN12DAXg1k1lQOvIn+SF86oFwDePqOq0b/eUOg1Y3ZVVMRls3yf9ub7cdrTTU2yqom
	yc9ZOqgRBQJ61d+f/nrKSgulPBf3GXIEjGdh46MIJdLXR+xkDKdR2ki306MUODy0wGOJ8284nQ3
	l8G49Q6C3/UuF5VDOUwCJ+DTk8k/rlsP5GIhiRiR1VwxTOnYPoiOogHVGgO4WNlCX2oGAjK
X-Google-Smtp-Source: AGHT+IFix1z6tMmwfjPEG1oQQ06cd/niYVFK7A3ERyfKb9o0nkBTriHS7CNo7xGrw+fDhLGT1YJYfTTjX20y7ecwqRg=
X-Received: by 2002:a17:907:948f:b0:b57:2b82:732b with SMTP id
 a640c23a62f3a-b6475706215mr3433422466b.54.1761295136987; Fri, 24 Oct 2025
 01:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012173035.12536-1-raskar.shree97@gmail.com> <20251018160400.6921df6c@jic23-huawei>
In-Reply-To: <20251018160400.6921df6c@jic23-huawei>
From: Shrikant <raskar.shree97@gmail.com>
Date: Fri, 24 Oct 2025 14:08:44 +0530
X-Gm-Features: AS18NWBKc75onvPQ2KcRtEzbrT_rOdOOZhjS01vyTKH3-6a5Fttp43NYSt_gDrg
Message-ID: <CAHc1_P6a=6MGT4_6mmMLzBXz8WxVv1C29iwDwXrDywV+Z2k-0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] iio: health: max30100: Add DT LED pulse-width support
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 8:34=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 12 Oct 2025 23:00:33 +0530
> Shrikant Raskar <raskar.shree97@gmail.com> wrote:
>
> > Add Device Tree support for configuring the LED pulse-width of the MAX3=
0100
> > sensor, and updates the driver to read and apply this property.
> >
> > Testing:
> > - Verify DT property read successfully in probe().
> > - Verify default fallback to 1600 us when DT property is omitted.
> > - Confirm SPO2_CONFIG register programmed correctly using regmap_read()=
.
> > - Validate different DT pulse-width values (200, 400, 800, 1600 us)
> >   are applied correctly.
> > - Validate probe() failure for invalid LED pulse-width
> > - Tested-on: Raspberry Pi 3B + MAX30100 breakout board
> >
> > Changelog:
> > Changes from v2:
> > - Fix DT binding schema errors
> > - Add default value
> > - Remove changelog from commit message
> > - Add missing header file
> >
> > Shrikant Raskar (2):
> >   dt-bindings: iio: health: max30100: Add LED pulse-width property
> >   iio: health: max30100: Make LED pulse-width configurable via DT
> >
> >  .../bindings/iio/health/maxim,max30100.yaml   |  8 ++++
> >  drivers/iio/health/max30100.c                 | 38 +++++++++++++++++--
> >  2 files changed, 43 insertions(+), 3 deletions(-)
> >
> >
> > base-commit: 8bd9238e511d02831022ff0270865c54ccc482d6
>
> Applied to the togreg branch of iio.git and pushed out as testing for now
Thanks for the update. I really appreciate your time and support!

Regards,
Shrikant

