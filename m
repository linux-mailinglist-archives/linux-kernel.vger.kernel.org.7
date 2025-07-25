Return-Path: <linux-kernel+bounces-745813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C4DB11F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F791CE3AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B62A2ED171;
	Fri, 25 Jul 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a3livB/I"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D48C139D0A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448490; cv=none; b=aZxasIKL8e5eo96GxPZcrUmbAc3AA7dswiqV41fVKft6sa4pGckyZH6uHE8gyV4yRoDF39qbcYLxSbsLpWTsr5+ARVp3gcNoAvYbVdWrdXMmX9Sta+GgBtk5lbIML88lNP+YHuiNtRClBnDXH25NAVIIz/keCl0vp+vth4tlAzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448490; c=relaxed/simple;
	bh=jZfI/jZo/CFIe92zR3Hl3kPSV3ETk+fIXrCk/bLV0s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/Yw/6Pl5GQy7+1FXGa5nRTiwLuDWXZ3KmEKYPtQOWHs3wLRqWyIvX4T8MPQ3aHc4M6O1UWJI7ZA4ioxt3zhJjG2V8yovVDRbNOqTtC2jDcEyI/SWjgKXuYOAx/HFMRC3PxkXhgigQxtU1p5AB1d/MuXnLbnkFA5Ad3jmVlchdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a3livB/I; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55a4e55d3a9so2342917e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753448487; x=1754053287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I2P4xcgVB0EtFaxRQaZIR9o/BHYp+7Qg3ScZYe53eyg=;
        b=a3livB/IpTtLTosP4U4YdaCcNWQP/vCd8P7rTz1eaq3+AM4JdyB7GvHtdYsYLTpX4h
         MMjFyx/3djpR8ORf029dY8lAV3HnxHl1mIVjVqiffvcGM8sN3mKglriCJUbtjtC9K4JI
         PntTa5k9gV82iz9vRpQ9dsEDVIT7sCoz23FPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753448487; x=1754053287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2P4xcgVB0EtFaxRQaZIR9o/BHYp+7Qg3ScZYe53eyg=;
        b=XFSkvxONJ5wgnvBKRNxUEszPKWVckYRci9BiLp8qoC0/QCmlHfcy+DwFPhsAIgPUGu
         pVoGTQtFZiqPuF8FWhYng4JrupwLJiocO3vxjRC/OP3sq2JynuaspR3FZiX3bupvaz9G
         qsB1ioPrWJe+212TlSu97Oxkh5tx4Q9MIWArmcLjR6FhJ84cGOSI4+5/DkkuyVlwlFsR
         gU5X8n/ALMVitHsyGxDwYnAbgsvj81QAdMPoM9N3JuhUR/45IV4y1G4oL+PrqOdTJL/N
         vLry8k45vN/xXC82XliKtRmjDCXvj0GdvaNLxrw1JC9ALZXetLpjN9BNQC3//b45/Bdg
         LZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUSNnh8xN+3abldRch8a6axfCFSQwWiRue9/WPd2elMkBcs01T43N623hl7qUvzWOW7jgnTkDk9oSslVXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnCIqNUbYlOpYv/uTbBWmJQOcZgadGmX82UE/lwEwYFPbT/0no
	rjG5VgcNgGU5PDAyagBZmeyYk4wuLc3tU8QAjl6LhMbob3acZAnpJdcPJITimyRkRL0z+cVsMBh
	t7Vc=
X-Gm-Gg: ASbGncuLLvcS1ZtRiB1IvcbEhrfB8gJWXv9IMdQ0/wcvtiS18qTLOS85LtsWN7smrUT
	KtunS15WN69V+BPvew8C8h3JEbHU3RCEmijsZfmj964nhgDWGzmEs7Yb8XA8YYNaDjOWqMSatKv
	EZtnmpBCOFH0FvYsutG+F6ICe4PloRTQKr7AhudSARaTQOEXzDL4CGG//w04nM374fsEFJ4lRa3
	Ji8Ir9nQo8MiVs7yXT7O8mai+D32ZlQH4W7paq4TR78Sl/wIjvG3Ekbx0P4C/oHrYqMTeNgGeFx
	CTAheD2RrGUJnTB5mC3P8zc931GpVXTBPcO2An6bi2Zk97226PaTn+xnKhl5nGqECKKyb98ZBlJ
	8UdcZuY7hBXsrxst9z2TbGp2X5oTGr0TYSbBKCJkseCv2SsWbMW5NmIQOGDOXM91XYozmpQQOQ2
	Y=
X-Google-Smtp-Source: AGHT+IGFcA18VYduqfijuySLd/bcyS4aJGOZ2qxq82Q3IZIEThDC/YD1mdccIJ9vu9oq+NfachTP9A==
X-Received: by 2002:a05:6512:b81:b0:55a:2735:fe6a with SMTP id 2adb3069b0e04-55b5f300e7amr535805e87.0.1753448486581;
        Fri, 25 Jul 2025 06:01:26 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331e09303adsm7177141fa.94.2025.07.25.06.01.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 06:01:25 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b43846e8cso17274421fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:01:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHUE65/FCTMkxI8rmSkGXer/o29VmunzJgP2oOHBHbk8QQL9vAkws4WmO7flFM54Xe/JdRAKr2pOqTBhA=@vger.kernel.org
X-Received: by 2002:a05:651c:4096:b0:32a:8855:f214 with SMTP id
 38308e7fff4ca-331ee825fe7mr3660911fa.27.1753448484875; Fri, 25 Jul 2025
 06:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-uvc-nousbdev-v1-0-28f5a1fdf544@chromium.org>
 <20250725-uvc-nousbdev-v1-2-28f5a1fdf544@chromium.org> <20250725112659.GC11202@pendragon.ideasonboard.com>
In-Reply-To: <20250725112659.GC11202@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 25 Jul 2025 15:01:12 +0200
X-Gmail-Original-Message-ID: <CANiDSCvJwbhxBbc=Wkbj9MG44sWnJ8pZi4vKYK4Akvm4iQH4TQ@mail.gmail.com>
X-Gm-Features: Ac12FXy-sx-xZRO0nUXAykeQ5qxinWl9sJcG-93KqvB8TDIZ-39fWSG3McaeDBo
Message-ID: <CANiDSCvJwbhxBbc=Wkbj9MG44sWnJ8pZi4vKYK4Akvm4iQH4TQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: uvcvideo: Do not re-reference dev->udev
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Fri, 25 Jul 2025 at 13:27, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Jul 25, 2025 at 11:01:30AM +0000, Ricardo Ribalda wrote:
> > dev->udev is already referenced by the variable udev. Let's use it.
>
> The variable is used in a single location. I would probably have dropped
> it instead, but I don't have a strong preference. If you prefer it this
> way,
>

I believe that it is used twice.

Anything works for me. Feel free to change it the way you prefer
when/if you merge it, or land it as is.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Please let me know if you will send a patch to drop the variable
> instead, or if I should merge this one.
>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index d09d1286da0f61d5953125df23ed92555585e8f2..209cedeff59e8be2e96ce79c3d395a5a85a336c6 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -882,7 +882,7 @@ static int uvc_parse_vendor_control(struct uvc_device *dev,
> >       unsigned int n, p;
> >       int handled = 0;
> >
> > -     switch (le16_to_cpu(dev->udev->descriptor.idVendor)) {
> > +     switch (le16_to_cpu(udev->descriptor.idVendor)) {
> >       case 0x046d:            /* Logitech */
> >               if (buffer[1] != 0x41 || buffer[2] != 0x01)
> >                       break;
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

