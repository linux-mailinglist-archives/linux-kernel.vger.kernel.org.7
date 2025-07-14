Return-Path: <linux-kernel+bounces-729546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4152EB0383E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954D03A5653
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DCF2367C1;
	Mon, 14 Jul 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gSoq8zui"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C004227586
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479068; cv=none; b=r8HuAJ+hAG9Q6/z/BZMGHSAX3baFqGYyEKRAWKez9BRZCaIqfPBDKOnoRvrhEQ/7tcwC2bg9l3PH9wwWPq0rCA7r7C+GnheEJIJaDNfzMaYWWP1Oh7mipKDjG8XGw+GeA+j19NUmYmjvqj/+7O4QKT9OLm/EmszUCbEmBQ0bY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479068; c=relaxed/simple;
	bh=meIXVFuhwo0U7DlXFwTqTWPNohJSUxEpilpiwQSBqfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FikNYlsHiDYcTLgFnnUzwYBBRzQPMOUg6CWI+aJA4cDUeg1X8MQhKNVTY8uTB/FE0IwS6XH61tNABPIF0VyklkKr5X8QyoKybGj6R7bMqUcSmQ/n8VfXt/6jb68uEZc8y4QjxShdZXkq/cvUjknfkiyFcKWx+Nv7ar9uVpLnrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gSoq8zui; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55511c3e203so3820097e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752479064; x=1753083864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fiHcBWKp9YgqBe1/PxkbmZBsucMVnC9XKVlBV7M2C8g=;
        b=gSoq8zui7HFYbg02XxhBoNYcuDG5RP0r+UnHnLdpQRIktoDhkovWXlggtdnCtWrFEp
         YY5AW365dzJW5rHXQ6i1Tjd1nKk2+j5Krtn/vLLmFpuEkpttWGA2Kdow/1IIGfQhsZ5E
         k4g6VI9/2Cu/IoaJHVdDNVlxyzGQwGPe6LLaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752479064; x=1753083864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiHcBWKp9YgqBe1/PxkbmZBsucMVnC9XKVlBV7M2C8g=;
        b=ezbi29DASmll+la27rD84xmR4/fjKaEFI+wcb/bgLSt8IDiZY5XuX8px+6ZEeZvd87
         11sJfx7Fiuy0hpLMgORnjThNXO2iSZ9c9JXlZQy0ydbJE2/FJcc79IerxNrmK8dA+9Uk
         +y57XAVKNAHlYSQvLDBTcQQVhTQrTCA6l8+oPwTioQG9lFaDV0Ry57aazdOvSmaZRVoE
         VL+zHgfoUKU+TNhJ96XvwEN5TXKdB/SS7A+UCIo3Sax4dmhCr+A+94k4cpYHzMCZfVRh
         yYDEslDOb6MH9pekBI3mWExHyZYUNJ/Gy6wr6owcNIRM4DtS3FAlNP0HGWB2QgIK2F6s
         Bh0w==
X-Forwarded-Encrypted: i=1; AJvYcCU4Z2C8sEyFgQc5fiLhxe599JvRUXnTDEvKrcPc23y9aady1Ua9No7xbW5EbRPjQk1N+yEIJngBY8SL168=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqitiDOM+awl6cmORpC2ZwC2IbLWivfi2k1NmRMCh3TSgLF6CX
	Tz9lA/l1XweOt3lCOIgk32AR8S/reUvFD0mZ82w3N34gj3pukgZmGwH7SWbcBQpba5BnHFmjXJh
	xKvo=
X-Gm-Gg: ASbGncsXf1OYVN++jltEA/kivYkS/6QL8Mk5XIVhbU81B/vuYYn8ScG/FkJCOEsQk1w
	Wf0lwoL1Lqe29Em0IiLRNxFulWeOBtZ+dAj/JsfTykLpw1MAPtk5vmWrgTNrHufWWxc5oxH+E+l
	17DKmAdEkI/4SAEvaXL1nPJtT4H8k9YgDIHrGojuGPte/V7j/jMEr2O83cQ5RCEAmXgYWN31P5C
	ysL4XIWeELSTDFbvOzLUwEioQXPq+p8sdOesomhdWtAY9VLzuZOn50D1flhf2nBHtjlmf8HSZzU
	gRnat/q5nVULLup5EFvNANUMtlgy8s2sFbAcxdGtzDB26tHB8511xanqwueFliWU17Ar7bc3Hhl
	z+N7vshP8ZzumdSdkjHqgejdQuLVR2PO3ZmeQbWLL4d0vNIM4AjOPHjn9Y4HXqZIR8zGqGY2sqZ
	Y=
X-Google-Smtp-Source: AGHT+IFxv0rOsE7tY3G/Pmd8uG2iDi7lgoDGhVn14n3zGO2XFjrpO2gVxk2mGue5C/BRw+a1aj2GeQ==
X-Received: by 2002:a05:6512:ea4:b0:553:cc61:1724 with SMTP id 2adb3069b0e04-55a044c4d6dmr3864279e87.24.1752479064252;
        Mon, 14 Jul 2025 00:44:24 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7f3479sm1860354e87.82.2025.07.14.00.44.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 00:44:23 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32ce252c3acso18539501fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:44:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSW9cp5SBVlgm0LJUaUnS3xvVC3aJLmHtH9hM4ohkbvkTfDsn2tfyRKcxMci4ia0exvc8w4wj/h9+jeBk=@vger.kernel.org
X-Received: by 2002:a2e:be9e:0:b0:32b:95ca:8103 with SMTP id
 38308e7fff4ca-330532d1539mr34334811fa.14.1752479062312; Mon, 14 Jul 2025
 00:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-uvc-meta-v8-0-ed17f8b1218b@chromium.org>
 <20250707-uvc-meta-v8-4-ed17f8b1218b@chromium.org> <20250711201308.GI27674@pendragon.ideasonboard.com>
In-Reply-To: <20250711201308.GI27674@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Jul 2025 09:44:09 +0200
X-Gmail-Original-Message-ID: <CANiDSCsfMaOTb90yJ6gbN6NOPqMAZSiLVcfq6YnpVkdabrW6xw@mail.gmail.com>
X-Gm-Features: Ac12FXyBJ3g138qqv6DvaCM4IcR-em_Kp08H9lGf8-r7VoyYMA1D6l_p7Q8nePY
Message-ID: <CANiDSCsfMaOTb90yJ6gbN6NOPqMAZSiLVcfq6YnpVkdabrW6xw@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] media: uvcvideo: Introduce V4L2_META_FMT_UVC_MSXU_1_5
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hansg@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Fri, 11 Jul 2025 at 22:13, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Jul 07, 2025 at 06:34:04PM +0000, Ricardo Ribalda wrote:
> > The UVC driver provides two metadata types V4L2_META_FMT_UVC, and
> > V4L2_META_FMT_D4XX. The only difference between the two of them is that
> > V4L2_META_FMT_UVC only copies PTS, SCR, size and flags, and
> > V4L2_META_FMT_D4XX copies the whole metadata section.
> >
> > Now we only enable V4L2_META_FMT_D4XX for the Intel D4xx family of
> > devices, but it is useful to have the whole metadata payload for any
> > device where vendors include other metadata, such as the one described by
> > Microsoft:
> > https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/mf-capture-metadata
> >
> > This patch introduces a new format V4L2_META_FMT_UVC_MSXU_1_5, that is
> > identical to V4L2_META_FMT_D4XX.
> >
> > Let the user enable this format with a quirk for now. This way they can
> > test if their devices provide useful metadata without rebuilding the
> > kernel. They can later contribute patches to auto-quirk their devices.
> > We will also work in methods to auto-detect devices compatible with this
> > new metadata format.
> >
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Hans de Goede <hansg@kernel.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  .../userspace-api/media/v4l/meta-formats.rst       |  1 +
> >  .../media/v4l/metafmt-uvc-msxu-1-5.rst             | 23 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  drivers/media/usb/uvc/uvc_metadata.c               |  4 ++++
> >  drivers/media/usb/uvc/uvcvideo.h                   |  1 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
> >  include/uapi/linux/videodev2.h                     |  1 +
> >  7 files changed, 32 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
> > index bb6876cfc271e1a0543eee4209d6251e1a6a73cc..0de80328c36bf148051a19abe9e5241234ddfe5c 100644
> > --- a/Documentation/userspace-api/media/v4l/meta-formats.rst
> > +++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
> > @@ -20,6 +20,7 @@ These formats are used for the :ref:`metadata` interface only.
> >      metafmt-pisp-fe
> >      metafmt-rkisp1
> >      metafmt-uvc
> > +    metafmt-uvc-msxu-1-5
> >      metafmt-vivid
> >      metafmt-vsp1-hgo
> >      metafmt-vsp1-hgt
> > diff --git a/Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst b/Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..dd1c3076df243d770a13e7f6d07c3296a269e16a
> > --- /dev/null
> > +++ b/Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
> > @@ -0,0 +1,23 @@
> > +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> > +
> > +.. _v4l2-meta-fmt-uvc-msxu-1-5:
> > +
> > +***********************************
> > +V4L2_META_FMT_UVC_MSXU_1_5 ('UVCM')
> > +***********************************
> > +
> > +Microsoft(R)'s UVC Payload Metadata.
> > +
> > +
> > +Description
> > +===========
> > +
> > +V4L2_META_FMT_UVC_MSXU_1_5 buffers follow the metadata buffer layout of
> > +V4L2_META_FMT_UVC with the only difference that it includes all the UVC
> > +metadata in the `buffer[]` field, not just the first 2-12 bytes.
> > +
> > +The metadata format follows the specification from Microsoft(R) [1].
> > +
> > +.. _1:
> > +
> > +[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/stream/uvc-extensions-1-5
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 658543062bba3b7e600699d7271ffc89250ba7e5..fdde1d37ed2ef9058e3ea3417bec25afe454dfc0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -25827,6 +25827,7 @@ S:    Maintained
> >  W:   http://www.ideasonboard.org/uvc/
> >  T:   git git://linuxtv.org/media.git
> >  F:   Documentation/userspace-api/media/drivers/uvcvideo.rst
> > +F:   Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
> >  F:   Documentation/userspace-api/media/v4l/metafmt-uvc.rst
> >  F:   drivers/media/common/uvc.c
> >  F:   drivers/media/usb/uvc/
> > diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
> > index 4bcbc22f47e67c52baf6e133f240131ff3d32a03..77e03273d3cf6b00cac6ebb9b29b941f1cbfd9f7 100644
> > --- a/drivers/media/usb/uvc/uvc_metadata.c
> > +++ b/drivers/media/usb/uvc/uvc_metadata.c
> > @@ -195,6 +195,10 @@ void uvc_meta_init(struct uvc_device *dev)
> >           !WARN_ON(dev->info->meta_format == V4L2_META_FMT_UVC))
> >               dev->meta_formats[i++] = dev->info->meta_format;
> >
> > +     if (dev->quirks & UVC_QUIRK_MSXU_META &&
> > +         !WARN_ON(dev->info->meta_format == V4L2_META_FMT_UVC_MSXU_1_5))
> > +             dev->meta_formats[i++] = V4L2_META_FMT_UVC_MSXU_1_5;
>
> Just to clarify, does this mean that your goal is to set
> dev->info->meta_format to V4L2_META_FMT_UVC_MSXU_1_5 as devices are
> reported to support the format ?

That is correct. Compatible devices shall either be autodetected via
the special control or manually added to the quirk list.

Quirking via module parameter should be just used for development purposes.


>
> > +
> >        /* IMPORTANT: for new meta-formats update UVC_MAX_META_DATA_FORMATS. */
> >       dev->meta_formats[i++] = 0;
> >  }
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index b3c094c6591e7a71fc00e1096bcf493a83f330ad..616adc417c62a58686beccbc440a5dfac0a2d588 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -77,6 +77,7 @@
> >  #define UVC_QUIRK_DISABLE_AUTOSUSPEND        0x00008000
> >  #define UVC_QUIRK_INVALID_DEVICE_SOF 0x00010000
> >  #define UVC_QUIRK_MJPEG_NO_EOF               0x00020000
> > +#define UVC_QUIRK_MSXU_META          0x00040000
> >
> >  /* Format flags */
> >  #define UVC_FMT_FLAG_COMPRESSED              0x00000001
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> > index be94a79b976e3de4eb957f5d2584ec6d4230469e..993b36417b4655456ce545cb42a41b55b98e4d6c 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1463,6 +1463,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> >       case V4L2_META_FMT_VSP1_HGO:    descr = "R-Car VSP1 1-D Histogram"; break;
> >       case V4L2_META_FMT_VSP1_HGT:    descr = "R-Car VSP1 2-D Histogram"; break;
> >       case V4L2_META_FMT_UVC:         descr = "UVC Payload Header Metadata"; break;
> > +     case V4L2_META_FMT_UVC_MSXU_1_5:        descr = "UVC MSXU Metadata"; break;
> >       case V4L2_META_FMT_D4XX:        descr = "Intel D4xx UVC Metadata"; break;
> >       case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
> >       case V4L2_META_FMT_RK_ISP1_PARAMS:      descr = "Rockchip ISP1 3A Parameters"; break;
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index 6f7bd38dd5aa4b1b2084685512512a380d76a5e4..863bc5b7dec32303e852d7e9c3891011ce5a3d71 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -867,6 +867,7 @@ struct v4l2_pix_format {
> >  #define V4L2_META_FMT_VSP1_HGT    v4l2_fourcc('V', 'S', 'P', 'T') /* R-Car VSP1 2-D Histogram */
> >  #define V4L2_META_FMT_UVC         v4l2_fourcc('U', 'V', 'C', 'H') /* UVC Payload Header metadata */
> >  #define V4L2_META_FMT_D4XX        v4l2_fourcc('D', '4', 'X', 'X') /* D4XX Payload Header metadata */
> > +#define V4L2_META_FMT_UVC_MSXU_1_5  v4l2_fourcc('U', 'V', 'C', 'M') /* UVC MSXU metadata */
> >  #define V4L2_META_FMT_VIVID    v4l2_fourcc('V', 'I', 'V', 'D') /* Vivid Metadata */
> >
> >  /* Vendor specific - used for RK_ISP1 camera sub-system */
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

