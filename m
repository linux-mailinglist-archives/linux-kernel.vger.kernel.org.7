Return-Path: <linux-kernel+bounces-847840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B732EBCBDB4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9C924ED062
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D013B246BD7;
	Fri, 10 Oct 2025 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjAtw209"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2123A9AC
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080006; cv=none; b=fHAL/QfA/oIWvnoaJk5oURfPRPqn/nW4KBhpUXQYn57Wf5++awh1U+m1poUmxy+/03uzqSj0OkbfVlcHOohVpCQtRWZfDcDpbMtQ+xRu0LqE0/aDRraRKmoCbMHM6I+5VH7T35/TwkRmwgDkhYUt/wpr43/OP51fhSN7Z67a8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080006; c=relaxed/simple;
	bh=2+xopuqcb8jYIYZ43TKLFq1BSj8EDYzIfiTpnANL+go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OENvwh6b95evWYUgTRJ9fBgNRIQFAZJ1e7ncWYzkvrgURCkdFrsvGN4OxLFx5cZfMJXaOSQln7Cafoq3a0c2hygxAQ4Pn47FIcB2sHGPsdtDXegXk2MAW5ujG81blH2Jw+K0CtdWacDUoLvIRTCZ9XA1TGg3/8sBijaSmTyRyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjAtw209; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760080002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNF4bqSfxRXQ2tMzr7IR6cFMVgrJk7iMG/ca9AYKDuQ=;
	b=LjAtw2095CocYh5YwC0vTXJuaPh8qDLlf6cs9redJoo56VJv9UnDJqV1vniSoD5YNGFn8d
	9wKEdD4oITabcoWMqUUbORn+FF+m/fT/7OR554+rPGcohZR7b7DnhK2Tfz6qOM5y85Ostu
	NQlHTN4llUyZPMk6XPMEih6gfTM+CPk=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-bGtzWDopPombyL14KqNTmQ-1; Fri, 10 Oct 2025 03:06:41 -0400
X-MC-Unique: bGtzWDopPombyL14KqNTmQ-1
X-Mimecast-MFC-AGG-ID: bGtzWDopPombyL14KqNTmQ_1760080001
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6360e9f4efaso3703944d50.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080000; x=1760684800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNF4bqSfxRXQ2tMzr7IR6cFMVgrJk7iMG/ca9AYKDuQ=;
        b=DBGM05gy1vT/iu5Ei4g0SRAxxlmSe4eSITgUepl6iXt5lXSBC2rWv3vapxGyE/e9kf
         vylGDYFo+TXHATmwtr3/65ncU1BFVKH098l1FfOVNY44fZE+P9vjp/T9qjc1EkChLIHJ
         wy8OKjbmrSnn2VKpM7E6YTdnAUyk/UweTtjngDzFq3tRhkenmrkRSp7xWhTGQL+7c6tf
         sPvlhTtB8HKNyguIH3MZddGiUPKr8AVxuk1C+JVG4tkjGchkX1YgKhpvaxe40dbl0vqB
         usT3RizaBITejkvjA6oWtGOqJ956cntGg8xAJkcf8LNJFZLMCnCdf/QHUg6L6Er1F/Xh
         C9Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWtd2KIkNkHbHigXhkzxND3ci2dxGAxdpS6P2Uf1HOV6jWhKDQ5DA40HJt3DwXEfZV1TBh8c4VQFJXM/BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0f7Qx4SDkzT5sfGQke0yWJHDF1+vIthzDbK0vI6qZfUmFYpkr
	PvaG+EM5G+5+0Y7wyoW5D/Ooko+JG2RXW5RgwMb2wtaRc+6G1/3DfwHlbpwiKzUdD9G1SDsRZTd
	YNxLqiSUkv2GJhnQRLA1uZdMWkK0MftIELJKW35R0F+E/lkN3i+cExM6Tuo7gHgA3Q24UL8cq0T
	nN0v0pKCe2X310aNlgOsumJAtGjFGgJ7Y1h6ummBkr
X-Gm-Gg: ASbGnctGrHw2L6LxeHTPFj3pjPQ8uRU/pHGuTL9lrnMHU/huZHOOC8KmuR+IC+lo3ND
	VAPzH6Vw1b/Wrj8Vp1LU0fsag7PFbRZUd0HeMqtBZeq4xzBIp0xFcrcIiyQVBmJvYT9cOeFqBC6
	G7czcn+2EIrEbA3gMYVPp5poteHugmNTZ8bJlq54s/VRNFXGHOgFLUMjWOm8n5LsYuYyYBKXZxn
	XC5QvBc
X-Received: by 2002:a05:690e:1a0f:b0:633:b9eb:85ff with SMTP id 956f58d0204a3-63ccb845174mr8758527d50.12.1760080000668;
        Fri, 10 Oct 2025 00:06:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENGoIFzOultU88GKL3yEdXx/Sa1hT+G+e2edQkctkSb896rcs+z2VWdsWIjNeAA6gUDvvKfsp0/P1YuTQGtdI=
X-Received: by 2002:a05:690e:1a0f:b0:633:b9eb:85ff with SMTP id
 956f58d0204a3-63ccb845174mr8758511d50.12.1760080000276; Fri, 10 Oct 2025
 00:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929165213.2896034-1-eperezma@redhat.com> <20250929165213.2896034-7-eperezma@redhat.com>
 <CACGkMEuRMXrt3zyQtrW8QvHJSVPqh5XGXtxBtir3UxGzjSmXOQ@mail.gmail.com>
In-Reply-To: <CACGkMEuRMXrt3zyQtrW8QvHJSVPqh5XGXtxBtir3UxGzjSmXOQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 10 Oct 2025 09:06:03 +0200
X-Gm-Features: AS18NWBLONCc_FbcAQRyNDKclrFzfavSvYt64l1dGovRosSfau7oYRhiOOj7tZ0
Message-ID: <CAJaqyWcSeNo-182zAQdjUxs+3LhBH+ype2NYNcFjiBEEjBeVXw@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:43=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Sep 30, 2025 at 12:52=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> >
> > Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> > group.  This enables mapping each group into a distinct memory space.
> >
> > Now that the driver can change ASID in the middle of operation, the
> > domain that each vq address point is also protected by domain_lock.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v6:
> > * Make vdpa_dev_add use gotos for error handling (MST).
> > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1) ?=
/
> >   (MST).
> > * Fix struct name not matching in the doc.
> >
> > v5:
> > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_F=
D
> >   ioctl (Jason).
> > * Properly set domain bounce size to divide equally between nas (Jason)=
.
> > * Exclude "padding" member from the only >V1 members in
> >   vduse_dev_request.
> >
> > v4:
> > * Divide each domain bounce size between the device bounce size (Jason)=
.
> > * revert unneeded addr =3D NULL assignment (Jason)
> > * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
> >   return; } (Jason)
> > * Change a bad multiline comment, using @ caracter instead of * (Jason)=
.
> > * Consider config->nas =3D=3D 0 as a fail (Jason).
> >
> > v3:
> > * Get the vduse domain through the vduse_as in the map functions
> >   (Jason).
> > * Squash with the patch creating the vduse_as struct (Jason).
> > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
> >   (Jason)
> >
> > v2:
> > * Convert the use of mutex to rwlock.
> >
> > RFC v3:
> > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
> >   value to reduce memory consumption, but vqs are already limited to
> >   that value and userspace VDUSE is able to allocate that many vqs.
> > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> >   VDUSE_IOTLB_GET_INFO.
> > * Use of array_index_nospec in VDUSE device ioctls.
> > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > * Move the umem mutex to asid struct so there is no contention between
> >   ASIDs.
> >
> > RFC v2:
> > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> >   part of the struct is the same.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 347 ++++++++++++++++++++---------
> >  include/uapi/linux/vduse.h         |  53 ++++-
> >  2 files changed, 290 insertions(+), 110 deletions(-)
> >
>
> [...]
>
> > @@ -2154,7 +2280,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
> >                         const struct vdpa_dev_set_config *config)
> >  {
> >         struct vduse_dev *dev;
> > -       int ret;
> > +       size_t domain_bounce_size;
> > +       int ret, i;
> >
> >         mutex_lock(&vduse_lock);
> >         dev =3D vduse_find_dev(name);
> > @@ -2168,29 +2295,35 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
> >                 return ret;
> >
> >         write_lock(&dev->domain_lock);
> > -       if (!dev->domain)
> > -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1=
,
> > -                                                 dev->bounce_size);
> > -       write_unlock(&dev->domain_lock);
> > -       if (!dev->domain) {
> > -               ret =3D -ENOMEM;
> > -               goto domain_err;
> > +       ret =3D 0;
> > +
> > +       domain_bounce_size =3D dev->bounce_size / dev->nas;
>
> Could dev->nas be zero here?
>
> It looks like we only have the check like this:
>
>         dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 : confi=
g->nas;
>
> When API version >=3D 1, userspace could fill zero here.
>

It's protected in the change in vduse_validate_config of this patch:

-       if (api_version >=3D VDUSE_API_VERSION_1 &&
-           (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
-               return false;
+       if (api_version >=3D VDUSE_API_VERSION_1) {
+               if (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GRO=
UPS)
+                       return false;
+
+               if (!config->nas || config->nas > VDUSE_DEV_MAX_AS)
+                       return false;
+       }

> > +       for (i =3D 0; i < dev->nas; ++i) {
> > +               dev->as[i].domain =3D vduse_domain_create(VDUSE_IOVA_SI=
ZE - 1,
> > +                                                       domain_bounce_s=
ize);
> > +               if (!dev->as[i].domain) {
> > +                       ret =3D -ENOMEM;
> > +                       goto err;
> > +               }
> >         }
> >
> > +       write_unlock(&dev->domain_lock);
> > +
> >         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
> > -       if (ret) {
> > -               goto register_err;
> > -       }
> > +       if (ret)
> > +               goto err;
>
> We don't hold domain_lock here but err tries to unlock it.
>

Ouch, good point! fixing it, thanks!

> >
> >         return 0;
> >
> > -register_err:
> > -       write_lock(&dev->domain_lock);
> > -       vduse_domain_destroy(dev->domain);
> > -       dev->domain =3D NULL;
> > +err:
> > +       for (int j =3D 0; j < i; j++) {
> > +               if (dev->as[j].domain) {
> > +                       vduse_domain_destroy(dev->as[j].domain);
> > +                       dev->as[j].domain =3D NULL;
> > +               }
> > +       }
> >         write_unlock(&dev->domain_lock);
> >
>
> Thanks
>


