Return-Path: <linux-kernel+bounces-757630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F38B1C480
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1D45600C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAFA28A3EC;
	Wed,  6 Aug 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUS8xfuV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C27261C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754477009; cv=none; b=Jaz7QT7H737uIg3YaVmcMecJU+qtXyEYKGVteVpIELm1J8c9mGuMqYcNuHACJ0aYDzQmN26WcSmsGdCnO9lgSKSRlGsbFOteL7dk/eYSdSonnV9DnKK9L3EEWUsuK4gHVE2rp7mkjwZBHn5mUCp7xQ1N4MuVwReR8dydWRMV+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754477009; c=relaxed/simple;
	bh=leYmNFud19dEBktjX/qSLYPAz8qlfnhMcr538hSMSIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0KSOY3HINu2P6vFqrnQQXhrXxBZdJXUK8Aw6I0NQLEAqhVR7lCxOxKpyKSi5xzxb75eIcTIAvO5kT6TWqHjq19168Q5Cz6oJzKpign1y3nc+AjBCYVUkmYahM6OaNwMh/4dLDfNVvupRJcz2hzJmMYc8CZjrTjJhKNy6WT0sgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUS8xfuV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754477006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vqnoi8qrtxL9pTOaS/+krX+WtLa3a5uwXy2NOCwnpqU=;
	b=bUS8xfuVRJutVgAGpTr4pHByh2llEJWoZnvMqKAYtVIxvumLx7PJp6DmccX9babh6WEXtU
	bYomQsksk910mBWp/gLt4VEUU2sDpngSnBXBp5U8bOlVBuzFIfOXZ4+aaKTFl3jGdxzVYi
	YmOATUpWubpNJpgGv3qi0ZxQSN9wM5A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-pkAsRN3EM4yZtvdgaTRLjA-1; Wed, 06 Aug 2025 06:43:24 -0400
X-MC-Unique: pkAsRN3EM4yZtvdgaTRLjA-1
X-Mimecast-MFC-AGG-ID: pkAsRN3EM4yZtvdgaTRLjA_1754477004
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-615cef7d015so3748504a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 03:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754477003; x=1755081803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vqnoi8qrtxL9pTOaS/+krX+WtLa3a5uwXy2NOCwnpqU=;
        b=oPLyKvNrwIyhsNl7V3RJwTBNnQKbfwhMEWwNfJdwcamUC5BW0r1RsRK4FGEUTom5gM
         VWnwXLmLvDPyl3+HAD6vNQeKKoT1s18G2wrU4gN2i0rMZT4trxbslkxHS+9/abF0mWeP
         RoXRD9ntWbGTe6rdIGQ9JaZBRQnnWAxOaRMANJpMRq1FxosL1weD1a3bapKT4JuyMb3q
         TrQoTwXSJR1WAU7CjtfH9+mGZBDCfQNy/aIuh6BQzhaLH5KPPH/iR6nH8sUEkmwmtuEV
         Cn2ql0XnsQfSGkGfrRnkzkg+2PvbWTRnRgzs1b+SQNVb3Kp15DYIIRWHxKJCX1Tpr1rU
         lMXA==
X-Forwarded-Encrypted: i=1; AJvYcCVmwjiNetwV3rhSjWWnWvlyieGQoRuWJlffDtf/Kiic59jS93xmOpT+Fhvc0Bn9x1KEVg6Xy/N03tOPrts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOJ4mQcsiRhngmURkU/O4ofmJygMCO+teGnlhm4yRHLygw35g
	+YacMtdvgtAmhIY6xcLvrOfM4iypPg/p6v4h3uTPgmKqPude9zvLNSH6UDAj/LK8e69ZfOOYEhp
	wFP3gPBjjCMGxEGcXnWXkh0AzzuUBF5BpUqSsFEHBoO5UP+BzIDrUKpQxbjCkZmHHdSV0V8+d2D
	1SvUuvMy30UCOp7QFEBTwCbiD3fBojJGLC44K2MqQG
X-Gm-Gg: ASbGncs1XMKtfa47+kJ2+/MLJfHRv07RQOSw7pifhvGYFp/bmrEJ3/9/AeLyRPmgM9y
	yg962P3qSu+kmoKd9dDQlVR6/sZuMAfSD8CVnAZMamsn7e14NUU3oYjyss5ZQAOCGfdPmVtp1ZQ
	18jPn+jdR/hKkKa76uh+GDaQ==
X-Received: by 2002:a17:907:6d1b:b0:af9:88a2:b7a7 with SMTP id a640c23a62f3a-af99048b9a1mr211307166b.48.1754477003478;
        Wed, 06 Aug 2025 03:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAebosUpbeq9s9Bz5urn47OJQZK+u1L1dJLsX4v+AP0ko9r4MqWrNmfNhal+LWMl/oeacHmWoudyKHAX99JPc=
X-Received: by 2002:a17:907:6d1b:b0:af9:88a2:b7a7 with SMTP id
 a640c23a62f3a-af99048b9a1mr211304866b.48.1754477003042; Wed, 06 Aug 2025
 03:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728064129.32382-1-jasowang@redhat.com> <20250728060823-mutt-send-email-mst@kernel.org>
 <CACGkMEsX9=MAT=pg+MG-5_0PN7DYGNv8G9E2ZLgtZ1TmCLV-0g@mail.gmail.com>
In-Reply-To: <CACGkMEsX9=MAT=pg+MG-5_0PN7DYGNv8G9E2ZLgtZ1TmCLV-0g@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 6 Aug 2025 18:42:46 +0800
X-Gm-Features: Ac12FXwjsaUrwZ3HtqaXSQImiLG2up-ILmGcVP5QBC1pOAAAUnebPr4gUGDosKQ
Message-ID: <CAPpAL=yVvT4VYFMr6gykMuo3MYmfJMApWgW_naWWwTNKeTRGJA@mail.gmail.com>
Subject: Re: [PATCH V5] virtio_ring: add in order support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Jul 29, 2025 at 10:34=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jul 28, 2025 at 6:17=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Mon, Jul 28, 2025 at 02:41:29PM +0800, Jason Wang wrote:
> > > This patch implements in order support for both split virtqueue and
> > > packed virtqueue. Perfomance could be gained for the device where the
> > > memory access could be expensive (e.g vhost-net or a real PCI device)=
:
> > >
> > > Benchmark with KVM guest:
> > >
> > > Vhost-net on the host: (pktgen + XDP_DROP):
> > >
> > >          in_order=3Doff | in_order=3Don | +%
> > >     TX:  5.20Mpps     | 6.20Mpps    | +19%
> > >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> > >
> > > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> > >
> > > For split virtqueue:
> > >
> > >          in_order=3Doff | in_order=3Don | +%
> > >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> > >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> > >
> > > For packed virtqueue:
> > >
> > >          in_order=3Doff | in_order=3Don | +%
> > >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> > >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> > >
> > > Benchmark also shows no performance impact for in_order=3Doff for que=
ue
> > > size with 256 and 1024.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > > Changes since V4:
> > > - Fix build error when DEBUG is enabled
> > > - Fix function duplications
> > > - Remove unnecessary new lines
> > > ---
> > > drivers/virtio/virtio_ring.c | 421 +++++++++++++++++++++++++++++++++-=
-
> > >  1 file changed, 401 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index e675d8305dbf..c6558e271f97 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -70,11 +70,14 @@
> > >  enum vq_layout {
> > >       SPLIT =3D 0,
> > >       PACKED,
> > > +     SPLIT_IN_ORDER,
> > > +     PACKED_IN_ORDER,
> > >       VQ_TYPE_MAX,
> > >  };
> >
> >
> > how about specifying the #s here?
> >         SPLIT =3D 0,
> >         PACKED =3D 1,
> >         IN_ORDER =3D 2,
> >         SPLIT_IN_ORDER =3D 2,
> >         PACKED_IN_ORDER =3D 3,
> >         VQ_TYPE_MAX,
> >
> > and then
> >
> >   static inline bool virtqueue_is_packed(const struct vring_virtqueue *=
vq)
> >   {
> >         return vq->layout & PACKED;
> >  }
> >
> >  static inline bool virtqueue_is_in_order(const struct vring_virtqueue =
*vq)
> >  {
> >         return vq->layout & IN_ORDER;
> >   }
> >
> > which is a tiny bit less code.
> >
> > worth doing?
>
> Probably not, for example it would introduce branches. As we
> discussed, once we have sufficient optimizations, most of the branches
> could be saved.
>
> >
> > >
> > >  struct vring_desc_state_split {
> > >       void *data;                     /* Data for callback. */
> > > +     u32 total_len;                  /* Buffer Length */
> > >
> > >       /* Indirect desc table and extra table, if any. These two will =
be
> > >        * allocated together. So we won't stress more to the memory al=
locator.
> >
> >
> > this is only used for in_order, and it increases the struct size
> > by half due to padding. why not a separate struct?
> > Or if you like, reuse vring_desc_state_packed - it is same
> > size with this addition.
> >
> >
> > > @@ -84,6 +87,7 @@ struct vring_desc_state_split {
> > >
> > >  struct vring_desc_state_packed {
> > >       void *data;                     /* Data for callback. */
> > > +     u32 total_len;                  /* Buffer Length */
> > >
> > >       /* Indirect desc table and extra table, if any. These two will =
be
> > >        * allocated together. So we won't stress more to the memory al=
locator.
> >
> > there's empty space at the end of this struct.
> > struct vring_desc_state_packed {
> >         void *data;                     /* Data for callback. */
> >         u32 total_len;                  /* Buffer Length */
> >
> >         /* Indirect desc table and extra table, if any. These two will =
be
> >          * allocated together. So we won't stress more to the memory al=
locator.
> >          */
> >         struct vring_packed_desc *indir_desc;
> >         u16 num;                        /* Descriptor list length. */
> >         u16 last;                       /* The last desc state in a lis=
t. */
> > };
> >
> > why not put it there?
> >
>
> Fine.
>
> Thanks
>
>


