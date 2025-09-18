Return-Path: <linux-kernel+bounces-822129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44767B83148
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16FA1896E14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D27E29E109;
	Thu, 18 Sep 2025 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3HRC/fC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431726A0C6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175470; cv=none; b=IIYw24D3yHPu9CkZbLQRD2OWIrQkkwHSaYAQF7Et73gCHU4bjyCFr6ZInOtWNAe4QGwP117k/VFMqPY9gKttFpTtve6NSDgUtDhADWUOMzPntUaDr+lCesu5xZ1jIYGCDYUVbDw35T6b8s+UfiR6eG+rNla3bFJsJueAZZ2Wns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175470; c=relaxed/simple;
	bh=Jywi48PU4d2DZTBGf6Cnjih4mf6Z3UgV12fYwEc0Nso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dukGrLiD3+N0aNQO/QrBPmxj+B8n4Zgb4Fb4elC8paxdzGoMLhsoLJmd3lVDNbhmesqdYl8An0hna/FhTZUFzQSPJ3To06d/bLmjDoqEzdgOe2P0uUVJ0eCP9GQ7GsO7/SVfwwoW/COlMGxF/booG8oYMRa9IeTAwWQg7U3A7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3HRC/fC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758175467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/QgS8HOi26kvO1Lv87IGYaGcFOWHc7Jaoo1F8SVjP4=;
	b=X3HRC/fCDHjXm/0Nc+fKlAplKUNAwXU3TjXu2BsQp+4TManOFNShQxZFCJLNULwZSTXbQb
	rR7ayA8yqIg7t8SigIn4lNKc5KXFq2ncXQxfuWF0Q8BtD3az4c5chQxzRm32TfqCjPpKbg
	lLGdJttHMOVwhnHZ2JnVWQC7WggQ9Dg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-MVsuN_MENVKSrStDMyRKuw-1; Thu, 18 Sep 2025 02:04:25 -0400
X-MC-Unique: MVsuN_MENVKSrStDMyRKuw-1
X-Mimecast-MFC-AGG-ID: MVsuN_MENVKSrStDMyRKuw_1758175465
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so561662a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758175465; x=1758780265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/QgS8HOi26kvO1Lv87IGYaGcFOWHc7Jaoo1F8SVjP4=;
        b=RBMlX4Fx0GIyHnEMhAaXoM0u9jFWk47ehn7hOEl7ea8SHdTukGLDknnbtiZBlQz3Q1
         wiIuk3IHH8CBUN/skrGla3gsTwRJWkF4dCSy4OX0wVEQ+k8hpnYPX0hxK5EYOvEyFKHn
         KICA5VMjfSJtn756RTS3FIKmxQdjYcBKzMvidiZ6nQJiTxLo977z8X5duu8D3+muFk8o
         Gg6v2VyzU/NTEw9cThnX83061jntrVVem5hGoGUmS1BaYDgDx2Db9JB9wQmzPqHnNijj
         alXsDn7O92ZR6/ZbY8cBHL+2FjOw0rarxo/O4nwcA9YETCm3iYsoSUIpFx1Lk77FSG1i
         z/3g==
X-Forwarded-Encrypted: i=1; AJvYcCWv0knRz2qwLSLkP95RpIX8FhFOAFU2F+uwGkVZJ4G4m5TDLvOK+AvyzBBMQnAPdn53DWPExg5Jh+sfbjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI9dByCL3uu6LpOebk+y/gtiokoYigUFv1p/jiI2yQ2pMmPQhs
	ZKLwTtrKO4Di2y7BpxGRdtxF4wXkrsTQrj8Owqy9ZqXuMa53bTsFvyutCSePuCX/plVv8mlguw2
	HOCG1gGVlSvtOj0W2T7tZN9lcAYEyOBkAz9iBQPkswiFnFqfr8b0NktmttVRk7gwJTrbz6nnc5k
	/0Z50OvoXbe8pyp1peZgRdnKkx2G1mKEI+gvrhhP7l
X-Gm-Gg: ASbGnctlsPubzfmg5gUyZUYJDBf2TlhEj0blpS5AXwyisHHxNcN/A57QYI0YS/gOODf
	Ik5dvtH7ukApmkL/eCrJ/eJlBIhmrT/LMttMNXRMp8EdYFEmPwMoOlpe3x42wKrwUVHwMz+Fjg2
	vRFneqxSTGgbGPS+eCftz9nw==
X-Received: by 2002:a17:90a:d605:b0:32e:a60d:93e2 with SMTP id 98e67ed59e1d1-32ee3f0091amr5561302a91.11.1758175464826;
        Wed, 17 Sep 2025 23:04:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF74BNn62n0fCPpYrN19sazfjg3lw3RFSdYOhWEwIFAbxay07InGj0/AE3xU3ArCc/qZ6HXLFS6Jeu2ve2W34Q=
X-Received: by 2002:a17:90a:d605:b0:32e:a60d:93e2 with SMTP id
 98e67ed59e1d1-32ee3f0091amr5561274a91.11.1758175464423; Wed, 17 Sep 2025
 23:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-6-eperezma@redhat.com>
 <CACGkMEtp61-OB2EpuMY+SWd2b1yShGwfTCNuw9xtMC5YdkpQkQ@mail.gmail.com> <CAJaqyWdu9O_q7dzXk98XcUE=wT1J3gA89j_3DAEJ7y1p_V+c5w@mail.gmail.com>
In-Reply-To: <CAJaqyWdu9O_q7dzXk98XcUE=wT1J3gA89j_3DAEJ7y1p_V+c5w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Sep 2025 14:04:13 +0800
X-Gm-Features: AS18NWDBdO22KtYZ3g_3p0_7NDuMDIxSVKlBfzpM64iTVt8a4bYvOuUSrXtXEhI
Message-ID: <CACGkMEt6fdud4t5k_veh_jr+4BGmvgZzMyWUP8JA5ki3gVt5DQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] vduse: create vduse_as to make it an array
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:35=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Sep 17, 2025 at 10:46=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > This is a first step so we can make more than one different address
> > > spaces.  No change on the colde flow intended.
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Sorry, I think I found something new.
> >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 114 +++++++++++++++------------=
--
> > >  1 file changed, 59 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 9c12ae72abc2..b45b1d22784f 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -86,6 +86,12 @@ struct vduse_umem {
> > >         struct mm_struct *mm;
> > >  };
> > >
> > > +struct vduse_as {
> > > +       struct vduse_iova_domain *domain;
> > > +       struct vduse_umem *umem;
> > > +       struct mutex mem_lock;
> > > +};
> > > +
> > >  struct vduse_vq_group_int {
> > >         struct vduse_dev *dev;
> >
> > I would expect this has an indirection for as. E.g unsigned int as;
> >
>
> This is a change from the previous commit and *dev is needed for
> taking the rwlock of the vq_group -> asid relation anyway, as function
> like vduse_dev_sync_single_for_cpu could run at the same time as
> VHOST_VDPA_SET_GROUP_ASID.
>
> I'm ok with adding the "unsigned int as" indirection but it involves
> memory walking that is not needed.

I think it should be fine unless we can notice it during the
benchmark. What's more we can refactor vduse as without caring much
about the group in the future.

>
> > >  };
> > > @@ -94,7 +100,7 @@ struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > > -       struct vduse_iova_domain *domain;
> > > +       struct vduse_as as;
> >
> > This needs to be an array per title:
> >
> > "vduse: create vduse_as to make it an array"
> >
>
> I meant "to make it an array in next patches". Would it work if I just
> change the patch subject to:
>
> "create vduse_as to contain per-as members"
>
> And then specify that it will be converted to an array later in the
> patch message? Or do you prefer me just to squash the patches?

I would prefer either:

1) make it an array in this patch
or
2) squash this patch into the next one

to avoid unnecessary changes.

>
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -122,9 +128,7 @@ struct vduse_dev {
> > >         u32 vq_num;
> > >         u32 vq_align;
> > >         u32 ngroups;
> > > -       struct vduse_umem *umem;
> > >         struct vduse_vq_group_int *groups;
> > > -       struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > >         rwlock_t domain_lock;
> > >  };
> > > @@ -439,7 +443,7 @@ static __poll_t vduse_dev_poll(struct file *file,=
 poll_table *wait)
> > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > >  {
> > >         int i;
> > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > +       struct vduse_iova_domain *domain =3D dev->as.domain;
> >
> > This should be an iteration of all address spaces?
> >
>
> Yes, it will be in next patches.
>
> The rest of the comments have the same reply actually, as this patch
> just prepares the struct to make it an array in patches as small as
> possible.

Right.

Thanks


