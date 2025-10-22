Return-Path: <linux-kernel+bounces-865831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B74BFE210
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AFE3A8CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40542F8BFC;
	Wed, 22 Oct 2025 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJtg2ADQ"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9F2F83C4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163829; cv=none; b=uQGaGa6xUicS9O5blyLX3oxniI//c0nL91zuiI2wfQJ3YA4hdnMkfUe91hLLDX4t6TKqv/NrJEim+VKJ+7GYMkcUyq+rtqKOOZIgvATcK27KL30URxyEG6zlenTSacNJ+9fW4LmTR0T3jKAaPrgirKTVTkhKCNvOfd7Yo8JQVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163829; c=relaxed/simple;
	bh=Ek3haOYmPyu4dgOa5C0zgHctdofHHVO9EUyqAYNfa2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jO7di1IsAAnGUwWbwc9xiS7z8AOUrRBaNmofIc5dYr/jGr33MGY3uDkQyZ/weDTKRuXwCIrXtJbqqVkiz2S4+D8V8ZMbN8Q4wSU9wsYD02eJXNdpRkwDXthq7ToyCF4IKhfGzYGQQ2el+MgYG4Nms3W4p641f6u9mBAV+m2iyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJtg2ADQ; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-59f64abbb61so2801992137.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761163825; x=1761768625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn5VKrdn1aznBkaeIAwzuNTcwHsl29o2bnaUn9NgWHw=;
        b=dJtg2ADQlG39P/7E15ZCN14M1JcnfeGwn8Jh5dVPvJ9O/kq75zKSJkxJfrC3sJAr4o
         +VWwO1l0Lxx9DzzAARu5Rs2c+2xXmC3SHPY7FpEypfGSNND3HOQ+03gndGGTe03K3SiQ
         IEuM8Emo6TVAaTC0GETRGviXvh76X2Hwytua6kTTf5szKjFpoHS7wYdpROBGXEBW3V2x
         ZFcNmQmSJ7v+MHIq1cchaBOekrFfXxZf3srpXHbD9XKVZp56jXAdAFDS79yeRoNrNpHi
         APpdAHD8/pxbnjx2WuladnFsEDc96LfmDnKpn1KQdZQlZe9M3/v3ytYSXzMVBW4ry7bV
         E4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163825; x=1761768625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn5VKrdn1aznBkaeIAwzuNTcwHsl29o2bnaUn9NgWHw=;
        b=mk/T3lQXhzUUI6hOiWFYFcXKAU8Wqw8jlarTJKWM9b8LWjTXvxtRhCKXkMvwIE1VbU
         zBCNErXjhRAO1ULUaRBJoVBC1Pb6s2SplNuBqLvQpMUaiNyrnk+9QWktzzl6RrkgIFzG
         3vd2JVxR23B5H1XkVr95PHqBRz6Ohp6fjehFk3s5MY10fT1ZDbOiBJ+NsoGaFr0p3BF9
         ardWlst7njTG5f9gNgORkR2PfKgvBNU3HeI0mqkf2scnXH7zRimSlghW27XJCa7kexG8
         E0DT93497wCyKNi6rKsSh1VxAM+c0gDZ65+JyXPeqd3MY+rMY2xRNDye58FBNkZtFKeQ
         S6zw==
X-Forwarded-Encrypted: i=1; AJvYcCVqth1y91Wf8aahEtpSzN4UJm85+wLQZaH+HdgmsNdozVKnVaVVKykTTimxKJjXkcxIPT7jFPsByFjeoKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7IskVnNV2Llm0s1KLkL6+nlmRsSlY2Bh739xhRSwIzFCSyfS
	Q/0MeCseTvbFFTfZ6xXQmFLZSFPv+x1JDXlr8mc+GK7Q5kCz874DLmFHr7SwS0JR5EbmBOZaLgZ
	Cds3vNPO4rQnfO95NrpsXS/YT7SPwsKWRwqkVMl50Ww==
X-Gm-Gg: ASbGncvwoD/BefNhiJ/gAT9lsNAn6U1cqbNw5BRlJTleLBdkJ5yDHNMRJbdwkT4PFX6
	EtjPW/JK+JqNuvd3pHKQfyNfjam98SbeYwwTBuDWpBmDRnXjJZ//J1kKL4iDlKviq//5ABS2ZYb
	bY+tum+ZG/i/yjwnmF9IOuDnrax3i2nFrJRUFemEoqagr/horg90OaEayPtfkDX9/QG97VEJEQ+
	KCkO6QIxjK8MsdoNvAQK4uxF6ECu5GnEKeSMCz0DExOZY8mGCzRTFVspo2Efxvj/+PK3r5/qf3t
	AYAnLiDzIrJF3g2XfPbhQbEtuw==
X-Google-Smtp-Source: AGHT+IEAmpCYQ3I3CaF01f4rD5k8jsO3VFkaaCggeAPNetgcdL42bDO5ziQu0Y8LVdLou4hTbEHf9n0KaVc/TOKWEY4=
X-Received: by 2002:a05:6102:c48:b0:5d5:f6ae:74b4 with SMTP id
 ada2fe7eead31-5d7dd62a873mr7028676137.40.1761163824525; Wed, 22 Oct 2025
 13:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022042514.2167599-1-danisjiang@gmail.com> <cf501c1e-94eb-4855-b3ad-e0b8c68d1a74@kernel.org>
In-Reply-To: <cf501c1e-94eb-4855-b3ad-e0b8c68d1a74@kernel.org>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Wed, 22 Oct 2025 15:10:12 -0500
X-Gm-Features: AWmQ_blNULWk3f3C_pQvJ7TQXzRfUECTP0SyTqgDO42bYPywBEVt3wfIIpRq2Ys
Message-ID: <CAHYQsXRpG9LL5cL9w_UPWpZpR-TiOp2QZzF5k69NiEzT8+oOFg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Fix use-after-free in acpi_video_switch_brightness()
To: Hans de Goede <hansg@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

Thanks for the feedback! I've submitted it in patch v3:
https://lore.kernel.org/all/20251022200704.2655507-1-danisjiang@gmail.com/.

Best regards,
Yuhao

On Wed, Oct 22, 2025 at 4:28=E2=80=AFAM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Hi Yuhao,
>
> On 22-Oct-25 6:25 AM, Yuhao Jiang wrote:
> > The switch_brightness_work delayed work accesses device->brightness
> > and device->backlight, which are freed by
> > acpi_video_dev_unregister_backlight() during device removal.
> >
> > If the work executes after acpi_video_bus_unregister_backlight()
> > frees these resources, it causes a use-after-free when
> > acpi_video_switch_brightness() dereferences device->brightness or
> > device->backlight.
> >
> > Fix this by calling cancel_delayed_work_sync() for each device's
> > switch_brightness_work before unregistering its backlight resources.
> > This ensures the work completes before the memory is freed.
> >
> > Fixes: 8ab58e8e7e097 ("ACPI / video: Fix backlight taking 2 steps on a =
brightness up/down keypress")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
>
> Thank you for your patch, this is a good catch.
>
> > ---
> > Changes in v2:
> > - Move cancel_delayed_work_sync() to acpi_video_bus_unregister_backligh=
t()
> >   instead of acpi_video_bus_put_devices() for better logic clarity and =
to
> >   prevent potential UAF of device->brightness
> > - Correct Fixes tag to point to 8ab58e8e7e097 which introduced the dela=
yed work
> > - Link to v1: https://lore.kernel.org/all/20251022040859.2102914-1-dani=
sjiang@gmail.com
> > ---
> >  drivers/acpi/acpi_video.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > index 103f29661576..64709658bdc4 100644
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c
> > @@ -1869,8 +1869,10 @@ static int acpi_video_bus_unregister_backlight(s=
truct acpi_video_bus *video)
> >       error =3D unregister_pm_notifier(&video->pm_nb);
> >
> >       mutex_lock(&video->device_list_lock);
> > -     list_for_each_entry(dev, &video->video_device_list, entry)
> > +     list_for_each_entry(dev, &video->video_device_list, entry) {
> > +             cancel_delayed_work_sync(&dev->switch_brightness_work);
> >               acpi_video_dev_unregister_backlight(dev);
> > +     }
> >       mutex_unlock(&video->device_list_lock);
> >
> >       video->backlight_registered =3D false;
>
> As you mention in your changelog, the cancel_delayed_work_sync() needs
> to happen before acpi_video_dev_unregister_backlight().
>
> Since this needs to happen before unregistering things I think it would b=
e
> more logical to put the cancel_delayed_work_sync(&dev->switch_brightness_=
work);
> call inside acpi_video_bus_remove_notify_handler().
>
> So do the cancel in the loop there, directly after the
> acpi_video_dev_remove_notify_handler(dev) call which removes the handler
> which queues the work.
>
> E.g. make the loop inside acpi_video_bus_remove_notify_handler() look lik=
e
> this:
>
>         mutex_lock(&video->device_list_lock);
>         list_for_each_entry(dev, &video->video_device_list, entry) {
>                 acpi_video_dev_remove_notify_handler(dev);
>                 cancel_delayed_work_sync(&dev->switch_brightness_work);
>         }
>         mutex_unlock(&video->device_list_lock);
>
> This cancels the work a bit earlier, but more importantly this feels
> like the more logical place to put the cancel call.
>
> Regards,
>
> Hans
>
>

