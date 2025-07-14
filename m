Return-Path: <linux-kernel+bounces-730470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E1CB044FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DE2172F51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F317125F7A5;
	Mon, 14 Jul 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GfLm4AqL"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2812561D1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509108; cv=none; b=rqyK8bpckfOR/xjxTvFD+k7oKdvGYbCGzBZPKXcctgr6O5q57eu4zgtw7HDX8oyUcVbVNTQXOsSA0CPIHWT/XMeqT25ckdspUt1QnAw5IACCaN50mNL2A5QO2JNxuCQdAeWyUukWKOVhd2Kr5nNfYmvcONDDpzuoFS1dRrhLI/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509108; c=relaxed/simple;
	bh=JxBVcWXOzrC+pQuiz7DoBffwFHlGca0wC939BUa4mlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YofmCkfB7+XjXjcftO+VzI4diwmVNhbrmGmCEN8NoEsxcC8KR+PiqcrflFjBrmTnNqmfQjdlTOEXdj6XvRYuPN0j4E02/16Y0hx5wp66kf2oIuzrSgImSi+1+Z8omWfLCl2AecR1lc51TPZ02gxxVWX7nIpA9DjGoazmziWJ7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GfLm4AqL; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-558f7472d64so4344845e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752509104; x=1753113904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDahj8/rNyyq5vqGI+SiuXe8oo3E19xokCP/r0ki8Vk=;
        b=GfLm4AqLdAYMmIdsZmkS3MDXEffjkrDEMVR6tZs3khBTyJrnQZFOnMFkHRU4TMgO8j
         icyFMoP5wWkmp3DwfyvHad2DsNtWv1uvOX44ruTe57bvqIbKE6zl4XhNXoZhJdUe+nzX
         ffCabjgfgaVrbomI80mnayTzEZrPsZnvhkAqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509104; x=1753113904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDahj8/rNyyq5vqGI+SiuXe8oo3E19xokCP/r0ki8Vk=;
        b=A74rQDVFXQPOjlpFcOxXuY8vub23yIy6Nrk8xMf8CxSxP3LMy2WcoC3GPgaCytRiJI
         ULv5KVPEqv1SfqT39IM07/fSXBEV27eQv5swxHjCZGIzCj5WlwiY9wUGEJ1dRbnHmaZ7
         WiHihLHj3vesCsteaSPF5EHBhMXJMOGuSLfKVy3J2l20SGxQrfRuHLvmc7UbCfgf/gMR
         m9JH8xDEuCoBbvvHWwB4yRMs6fKatoxJOevjZHH11B2hbDEujL5/zIQUZFZ9qJfGYgI+
         Fle+KpDtNj0o/IN2Vdfadyu+qYNvnPfEBcLG0wD552xcVTzT4q3Hav1HHty42KTdxqdU
         xsSA==
X-Forwarded-Encrypted: i=1; AJvYcCVe/HHAPItvV90pMqOlpKWWaJNW6jDN3ngI/PDdjGYM1v/HvRaXczeFT76Br4vR2KSX3wM0Ha4lCSia/NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26cK68jvWaR7Il4WFaU1J/zN7B5MEY6kb8zpnQDr8IY5cvnY4
	YluBmePcKhoojjX64fRPxXPp8oLseHi0kAUZwu99QvNGOQ8JHaTVa1p9QO5LFNhA3ShrzykWekc
	EyQVzhg==
X-Gm-Gg: ASbGncvb8GZMMb2xMZwuGJX3qHPwEdaCrn82UTUmus94nouDifsdCFrCeLMViDFYCFC
	q2ixwBU38/tn0UffhNP3g+ZTecfqdNxZa9Btr7az0NboGIdJpskduSRNtuWrXj84kH3pNoe312g
	jjWBxSa4FCd+d7VeLZB2GOaHIb6YvzBRtCgZyb64XYlPF5enP+2S3DQDR1vTj8Cu0rMhnmQoQs3
	tAafmThF607X0c9+K2OLiyW1OJYOEG4x9+z52kNinzQgzp0jbiD1wqwKEmgp11S1LdP11oxyhPV
	CU4ExWDLZG6VPCgz3K59PINJALCQRm6ZTcRuJoXS0R5x1zkp94deEUUV335NQwoV0ftuf0wbr7t
	Ue22vIRb5wf3B4GBaQHXLcwBbWk5iPfCGfgqGEfStgP3VIgOY/sm+oHt54B6G
X-Google-Smtp-Source: AGHT+IESV3hKxuoBIbtso7TpcBMx9zFTRjX2/cWsBnokhIpgY953AgGheXzfjA2A1eMNh4OBf37L+A==
X-Received: by 2002:a05:6512:23f0:b0:553:2411:b4fc with SMTP id 2adb3069b0e04-55a1c45621amr44776e87.10.1752509104057;
        Mon, 14 Jul 2025 09:05:04 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbd1esm1991336e87.42.2025.07.14.09.05.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 09:05:03 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-558f7472d64so4344813e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:05:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrjyxfDERvbw060I91etBdPsaS6DSS9HiMZxR4TLb3DnIdNT76r1Xjm6/pYsnenw88L8S6c1t1OU55ejk=@vger.kernel.org
X-Received: by 2002:a05:6512:3b9e:b0:553:2884:5fb3 with SMTP id
 2adb3069b0e04-55a1c467663mr45477e87.12.1752509103021; Mon, 14 Jul 2025
 09:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-uvc-orientation-v2-0-5710f9d030aa@chromium.org>
 <20250605-uvc-orientation-v2-12-5710f9d030aa@chromium.org>
 <20250629180534.GN24912@pendragon.ideasonboard.com> <CANiDSCvcQ9MA+WBMQTpUzSxDLNiKpvaHsb-pDHTuiUQekgXvQA@mail.gmail.com>
 <CANiDSCtq0cr1LgFCgvdBtWcE3z1MWZEjc0e1wTH_BYPETC+s4Q@mail.gmail.com> <20250714143617.GK8243@pendragon.ideasonboard.com>
In-Reply-To: <20250714143617.GK8243@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Jul 2025 18:04:50 +0200
X-Gmail-Original-Message-ID: <CANiDSCud66tcaODuVA1TreEQ3k8u4k-6ghzRQedTPFcT3j+9VQ@mail.gmail.com>
X-Gm-Features: Ac12FXxJPvBJAM528bNZN02Nhk1iZCMcKXmyshIGKqYKQPEJihw9v-tpgzFvPcg
Message-ID: <CANiDSCud66tcaODuVA1TreEQ3k8u4k-6ghzRQedTPFcT3j+9VQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] media: uvcvideo: Do not create MC entities for
 virtual entities
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 16:36, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Tue, Jul 08, 2025 at 08:28:21AM +0200, Ricardo Ribalda wrote:
> > On Tue, 1 Jul 2025 at 13:20, Ricardo Ribalda wrote:
> > > On Sun, 29 Jun 2025 at 20:06, Laurent Pinchart wrote:
> > > > Hi Ricardo,
> > > >
> > > > Thank you for the patch.
> > > >
> > > > I would use "software entities" and not "virtual entities" in the
> > > > subject line and everywhere else, as those entities are not virtual.
> > > >
> > > > On Thu, Jun 05, 2025 at 05:53:05PM +0000, Ricardo Ribalda wrote:
> > > > > Neither the GPIO nor the SWENTITY entities form part of the device
> > > > > pipeline. We just create them to hold emulated uvc controls.
> > > > >
> > > > > When the device initializes, a warning is thrown by the v4l2 core:
> > > > > uvcvideo 1-1:1.0: Entity type for entity SWENTITY was not initialized!
> > > > >
> > > > > There are no entity function that matches what we are doing here, and
> > > > > it does not make to much sense to create a function for entities that
> > > > > do not really exist.
> > > >
> > > > I don't agree with this. The purpose of reporting entities to userspace
> > > > through the MC API is to let application enumerate what entities a
> > > > device contains. Being able to enumerate software entities seems as
> > > > useful as being able to enumerate hardware entities.
> > >
> > > What function shall we use in this case? Nothing here seems to match a
> > > software entity
> > > https://www.kernel.org/doc/html/latest/userspace-api/media/mediactl/media-types.html
> > >
> > > Any suggestion for name?
> > > Shall we just live with the warning in dmesg?
> >
> >  I just realised that if/when we move to the control framework, the
> > software entity will be gone.... So to avoid introducing a uAPI change
> > that will be reverted later I think that we should keep this patch.
>
> You know my opinion about moving to the control framework, so that's not
> a very compelling argument :-)

Correct me if I am wrong, your opinion is that it will take too much
work, not that it can't be done or that it is a bad idea.

Will send a patch using MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER, but
when/if we use the control framework, please let me drop the swentity.

Thanks!


>
> We could use MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER, as that's the
> function already used by XUs, and the SWENTITY fulfills the same role as
> XUs in some devices.
>
> > > > > Do not create MC entities for them and pretend nothing happened here.
> > > > >
> > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > ---
> > > > >  drivers/media/usb/uvc/uvc_entity.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> > > > > index d1a652ef35ec34801bd39a5124b834edf838a79e..2dbeb4ab0c4c8cc763ff2dcd2d836a50f3c6a040 100644
> > > > > --- a/drivers/media/usb/uvc/uvc_entity.c
> > > > > +++ b/drivers/media/usb/uvc/uvc_entity.c
> > > > > @@ -72,6 +72,16 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
> > > > >  {
> > > > >       int ret;
> > > > >
> > > > > +     /*
> > > > > +      * Do not initialize virtual entities, they do not really exist
> > > > > +      * and are not connected to any other entities.
> > > > > +      */
> > > > > +     switch (UVC_ENTITY_TYPE(entity)) {
> > > > > +     case UVC_EXT_GPIO_UNIT:
> > > > > +     case UVC_SWENTITY_UNIT:
> > > > > +             return 0;
> > > > > +     }
> > > > > +
> > > > >       if (UVC_ENTITY_TYPE(entity) != UVC_TT_STREAMING) {
> > > > >               u32 function;
> > > > >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

