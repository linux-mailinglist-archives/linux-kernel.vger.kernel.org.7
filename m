Return-Path: <linux-kernel+bounces-852004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391BDBD7EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F6918A4CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7D730F55D;
	Tue, 14 Oct 2025 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TE7XVk3n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711130E0EC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427054; cv=none; b=dG/nRpJnxywbhE4lZtQG1+/1FVfp0G7hXjITMACLV9+0qaDzKR0bq/GnyL9heRN+xPFlxFKv/OJ+06n72lyV0L6u83wyLaqO48mfxvXoimtwd+lgmwymf9cv1k1pbdy/8NuwpoOSybRpgZOxp28hi5O8r+4ZNAPJWm0zOOwmraQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427054; c=relaxed/simple;
	bh=Wocm0VB/Jzd8XJphp1xueqg11SgR1DOsJ91gXwSvemo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCsH405sk0/dOELkTpw9ob79DN1k/X8sJXDV+kyC9pv+dFjcU/3ccMxkY/wRaBygmYguXVkM+sVD4jtjPd86enOMxMq9YPGtMKkzBsmQV7i0/PT6Sw/WHKI5OLCU5pH936WCcszieVgm6OCORPidoIMUF6UL50awIKmmCL7A2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TE7XVk3n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjPM0Dek3XJBMiI43E2t7Sst/xVZxIkoO+1LC4iV+eI=;
	b=TE7XVk3ncACZmSMXScrVdtC4nKq9WLvw1L3WFOUiTgw1zYFkYtivoPI1s4ECnIgYD9+MPu
	bVi6AVYIrZAzcd4ZTQimZRzXb0tptQVdAgWIaFKA6QmYLNI7JjzUjABUxseXqptgOS25dw
	6AxJ2Dr9bCxH3rWCrbrBBO8Zk1yhl3g=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-uBYP67JrPcKUXtuIerv9Zg-1; Tue, 14 Oct 2025 03:30:42 -0400
X-MC-Unique: uBYP67JrPcKUXtuIerv9Zg-1
X-Mimecast-MFC-AGG-ID: uBYP67JrPcKUXtuIerv9Zg_1760427042
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7436271d14cso187775677b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427041; x=1761031841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjPM0Dek3XJBMiI43E2t7Sst/xVZxIkoO+1LC4iV+eI=;
        b=u7IVHJDunjBhElc0z+LJxhFUY2nXQkBbRn/SAswKC9WppuvqWG9qagsVih4m76JzXL
         LeTVv/jYjHsPwdmtmFWf8cfCNi1xIz5GJ2jQmrtRonEE1l5r88XUqObLPs8T0VwKIzPX
         Za01Pp860orHC7czlSkg4vRrrXcyQImgnx0yvB5XSFwhXIRU7Hx1IzDpdiYp3h6+/4wp
         mzfxS5Z3ltu0m6U/GnIKMb2fkXU9XVxq9ERwYkcgqSjgRnOziL4Z7tlVW87JHqDWG/YB
         doZbCB8thEZ1UuFzONpyD+F2U13fjf3ZTIcWI6EyeLvVwyMNRLXIRH2xie0mi+eMJUU3
         IfQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbttoBOn3Y/97Auza8fGJ12DKNDlL1SRUJH/smHylBc1G8n4AhNfjEXOgdDA4LrkHvCkg4pXBnkP1/1yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Vtan++t3rDXyjhkLDuO+hsUTJgAeoUSchbja+ukHYB2UlpPs
	LioK+eU8e6GUAOh+0c9gXK8i2VD+pHa5oiXkGZ5eM2oPIupHm2Jl/BFqGm92ED0QkhM7ddCeMQv
	NdFQpPl2iaDAnMOEDxJc2q65XApT85jkD/jsYD6F/6xHzzklKH42GLbo241fp8rkrnBK/LpFcqW
	xco0IY9norPiNZyftJZI1r2xDw7jjZphzaV+b5YFk8fR9mijiZ
X-Gm-Gg: ASbGncvKLhBC9vdM90sriOos1r2N8oYCi8HRDXiqYVYLceL5XnexMyzwLp8R3RI962F
	Hb1wLG2lwM54BtanXnuKxKbjZLu7fkRDqEDl+YclI9VRmuevA35CMoHwxx1Zn7k/57CjnfKWwNX
	gzdIDmraJbQSbC0X1QNMlnge63WZADlHBc62z8P99FJi2OzTtIjOVsiKsoJDagTqBXqkL8oBJnj
	sLtFyyW
X-Received: by 2002:a53:acc8:0:10b0:63c:f5a6:f30b with SMTP id 956f58d0204a3-63cf5a707a8mr8150388d50.34.1760427041202;
        Tue, 14 Oct 2025 00:30:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTGjvgm+q6Xi/4Sr+8n6vmI+h9vBKa+gJNc7gSb1sSY2AxAj8OLoP2ljZtRHahMX8MdJUTrHqa5gno2mIxl8U=
X-Received: by 2002:a53:acc8:0:10b0:63c:f5a6:f30b with SMTP id
 956f58d0204a3-63cf5a707a8mr8150373d50.34.1760427040882; Tue, 14 Oct 2025
 00:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <CACGkMEvJwcTFmDTXyXvMM1dP0OginF-FKZsksFO1DamRQJP1TQ@mail.gmail.com>
In-Reply-To: <CACGkMEvJwcTFmDTXyXvMM1dP0OginF-FKZsksFO1DamRQJP1TQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 14 Oct 2025 09:30:04 +0200
X-Gm-Features: AS18NWBM7CJVO_99VdUET8T7W_kxp8s61iA763QHZRqN906DJB2ICmMi_MvpUFI
Message-ID: <CAJaqyWeuMvkj2HzCrph+h-rjYdTMQJRcAvHzryKt6iUhd4sEsQ@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 9:45=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Oct 7, 2025 at 9:06=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > An userland device implemented through VDUSE could take rtnl forever if
> > the virtio-net driver is running on top of virtio_vdpa.  Let's break th=
e
> > device if it does not return the buffer in a longer-than-assumible
> > timeout.
> >
> > A less agressive path can be taken to recover the device, like only
> > resetting the control virtqueue.  However, the state of the device afte=
r
> > this action is taken races, as the vq could be reset after the device
> > writes the OK.  Leaving TODO anyway.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 31bd32bdecaf..ed68ad69a019 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct vir=
tnet_info *vi, u8 class, u8 cmd
> >  {
> >         struct scatterlist *sgs[5], hdr, stat;
> >         u32 out_num =3D 0, tmp, in_num =3D 0;
> > +       unsigned long end_time;
> >         bool ok;
> >         int ret;
> >
> > @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct v=
irtnet_info *vi, u8 class, u8 cmd
> >
> >         /* Spin for a response, the kick causes an ioport write, trappi=
ng
> >          * into the hypervisor, so the request should be handled immedi=
ately.
> > +        *
> > +        * Long timeout so a malicious device is not able to lock rtnl =
forever.
> >          */
> > +       end_time =3D jiffies + 30 * HZ;
>
> The problem that 30 * HZ is probably long enough to trigger the
> warnings like hungtask?
>

That's right. OTOH, the same behavior from the device already triggers
the hungtask.

Maybe it is better to set it to 15*HZ?


