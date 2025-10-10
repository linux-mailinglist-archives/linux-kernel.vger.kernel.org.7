Return-Path: <linux-kernel+bounces-848066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 481ABBCC65C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EB3B4FD218
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1C62D0C7D;
	Fri, 10 Oct 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8b8ePCk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2927B34A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089314; cv=none; b=IEEwySXV1TMIPXevX4uBFYYAV1HC1BM3oP7ou5oefa9KnxSfeYsrNTeBFrdyCKoKJT+CvGI4AAN4GNwMAYCh9Ast2DV8AhlQxoacwLLwEglCmOegOLxr7W2CPLWERqc28/tKTfdNuy4b+0G8jpNSVkwcGbevPvnWBTooJEaA8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089314; c=relaxed/simple;
	bh=TCxe8AKQudXrjI6Ezcpx/IM4UKhmFZ9JhyxcqMdvoqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzZcazXuBxElrAJ1T4huApqYEmoK/X3qQOWd/SqeW88Fxfc2cZ1hrCpvcnZZeaG7CbWqgZIswe6GWWDLK9LvfGFzCFM8XR/61lnOV/D7ZsfuQGRopXOk6oqo+R4LsKa5LLxB1HqtZ/hszLOLzApnyff1XxQmaaw/731xUvrmudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8b8ePCk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760089304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRU9De0ZG84MmWJ0E/AfuolzoTzmUWqKv+6ReOBq7PQ=;
	b=H8b8ePCkmRn3O59KXWpVmnNXrya1pscFG0bFMutIKIlcA+WO8rPCXLWnGMSOXBuQG9ch85
	VqhETGOTpR73jFw+xL90y5ogcPigzUIA48ZLAhC8G2cAqAnPWCTIhwgMoEvgLlsNfIeUjJ
	8DEeiBLAOFDp+Q+oT5wDKtaGxie6eu4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-zwDpzHXdPQiuuUW-ZLhPjA-1; Fri, 10 Oct 2025 05:41:42 -0400
X-MC-Unique: zwDpzHXdPQiuuUW-ZLhPjA-1
X-Mimecast-MFC-AGG-ID: zwDpzHXdPQiuuUW-ZLhPjA_1760089302
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-780d2956a2fso43450777b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089302; x=1760694102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRU9De0ZG84MmWJ0E/AfuolzoTzmUWqKv+6ReOBq7PQ=;
        b=u/gKD+M+0wWxZqVPbR3ciO33rA14QehWpgwbk9nlWrze9od6yG9vlKjeRWAqELGITA
         GwrNR2rlolTf7/REsOm4zMctvjNmenHle7Wxxe9byyy6zBZfvfAiZeo6oFecVkHU4ZXm
         AQ7XyD4D+49k7MFfiB/kQHKrxSHNDLutHpPQ0eEgsteJou6/wfgALkGP5or2vKhjpDf6
         e0Qtumt7Opc3IsRAj1eeCvktW9Za4sAcSnvqkleoprK3HAqmC0yvtYKwfWRnLxwBN2L1
         Q25tpe1l4qTbPSZ0nrqC+yGPkti64+rNBelYURW4vDll76MHaNq38n/e6q56xHwe4I5g
         m2uA==
X-Forwarded-Encrypted: i=1; AJvYcCUUYLR3b+274CTWEgpAo82QEXsFxMh/UL8DVaq+/W89CFr7WB7/1Og2UYMD8wHbqnYix+nDBWZibc5HkoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAAcDgqxJIDj8S8va+qv0x6fzxyl+GzWA1mVyRdrc3vJ6WWxv
	vOmLXJxOAKqL8GJ3Wv9Ss74NTtma90lflnXVd1eI55o3W+IHXr/s95im3UbyCfW/JIcf5ydAuIM
	I7nfrSL8fpEawbmdwwYA/OlTug9EgW0MWEhZN7clvZcSlFdmeYZkhvkjEfRPUFq9wHgHpwP1vhW
	aiNEAvNE53u0aMMHGEU0aCulzQtQav6HwVmiH0qtLi
X-Gm-Gg: ASbGncvbm0dQ9PvVqR8hCr2g5/hAP2MXM53sTV3fwfY++sALRoKnYoohNQgYSgleKxk
	xzA5x9AYPV1ZE/6UyEOJw2zetQxq3eDi3glMsUcatWQ6DqABRWguaPruZi7U511BmJB4qM5+jFW
	7oWLU5xSHbAlwbgNiRy7FDVCXc07DfHT4FLh9+PyruUv86Ud3GjUpVFIyOzm7fKLJ563iybglmY
	8RMigaa
X-Received: by 2002:a53:e02a:0:b0:63b:6340:8e64 with SMTP id 956f58d0204a3-63ccb9030ccmr7879076d50.39.1760089301983;
        Fri, 10 Oct 2025 02:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlUiPsiwWpvI3oTDKYUNUVRFCMnRJmvebTbfIc4uDv865d8wTOTnPHEKhrULJ+5FLnqrcuR9Jto3LombTI4u4=
X-Received: by 2002:a53:e02a:0:b0:63b:6340:8e64 with SMTP id
 956f58d0204a3-63ccb9030ccmr7879067d50.39.1760089301559; Fri, 10 Oct 2025
 02:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002103537.308717-1-eperezma@redhat.com> <20251002103537.308717-2-eperezma@redhat.com>
 <59eb64f1-7019-450d-96bb-a9398d2af602@oracle.com>
In-Reply-To: <59eb64f1-7019-450d-96bb-a9398d2af602@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 10 Oct 2025 11:41:05 +0200
X-Gm-Features: AS18NWCjM5wvi9XlNJHpYwkkr8FMsHSPm7e0O_6hZ2XlqsH_hMhNdnOb8X4OZb4
Message-ID: <CAJaqyWcxooE69w+P-M24FTkKi37WGthrhhdJ0BC+GBQV0xxngg@mail.gmail.com>
Subject: Re: [RFC 1/2] vduse: support feature provisioning
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: mst@redhat.com, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, Cindy Lu <lulu@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, jasowang@redhat.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Jonah Palmer <jonah.palmer@oracle.com>, virtualization@lists.linux.dev, 
	=?UTF-8?Q?Be=C3=B1at_Gartzia_Arruabarrena?= <bgartzia@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 6:40=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/2/2025 3:35 AM, Eugenio P=C3=A9rez wrote:
> > This patch implements features provisioning for vduse devices.  This
> > allows the device provisioner to clear the features exposed by the
> > userland device, so the driver never see them.  The intended use case i=
s
> > to provision more than one different device with the same feature set,
> > allowing live migration between them.
> >
> > The device addition validates the provisioned features to be a subset o=
f
> > the parent features, as the rest of the backends.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   drivers/vdpa/vdpa_user/vduse_dev.c | 17 ++++++++++++++---
> >   1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 6c74282d5721..ef8fc795cfeb 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -121,6 +121,7 @@ struct vduse_dev {
> >       bool connected;
> >       u64 api_version;
> >       u64 device_features;
> > +     u64 supported_features;
> >       u64 driver_features;
> >       u32 device_id;
> >       u32 vendor_id;
> > @@ -698,7 +699,7 @@ static u64 vduse_vdpa_get_device_features(struct vd=
pa_device *vdpa)
> >   {
> >       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >
> > -     return dev->device_features;
> > +     return dev->supported_features;
> >   }
> >
> >   static int vduse_vdpa_set_driver_features(struct vdpa_device *vdpa, u=
64 features)
> > @@ -2256,13 +2257,22 @@ struct vduse_mgmt_dev {
> >
> >   static struct vduse_mgmt_dev *vduse_mgmt;
> >
> > -static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name=
)
> > +static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name=
,
> > +                            const struct vdpa_dev_set_config *config)
> >   {
> >       struct vduse_vdpa *vdev;
> >
> >       if (dev->vdev)
> >               return -EEXIST;
> >
> > +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +             if (config->device_features & ~dev->device_features)
> > +                     return -EINVAL;
> > +             dev->supported_features =3D config->device_features;
> > +     } else {
> > +             dev->supported_features =3D dev->device_features;
> > +     }
> > +
> Why this feature filter can't be done in the client (library) of vduse
> itself, similar to other device specific features of the existing vduse
> client? I thought those vduse clients are never managed by vdpa tool,
> while the device class can't be bound until client had registered with
> vduse. What is the point to define the feature bit in one place, but the
> value of the feature (for e.g. mac, mtu) is still or has to be provided
> by the client itself? Is it the right behavior to filter features in a
> separate layer rather than contain all relevant feature bits and
> attributes in one central location?
>

Maxime can expand on this, but the user of the vdpa command should not
need to know if the backend device is VDUSE, HW, or other device: It
should just call the vdpa command the same way, and expect the same
results.

That also implies that it should handle the same way if a HW device
has its own MAC address and then you set a different one with the vdpa
command, but device_featues just came first in the pending list :).


