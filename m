Return-Path: <linux-kernel+bounces-882359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF8CC2A418
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6972D3420CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA38299A9E;
	Mon,  3 Nov 2025 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fcFSGK+Z"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E719298CA2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762153997; cv=none; b=m7b0eYY4yxhfrr6dx5gtaND9KszlJUz8qC6kSoGu0MIj/9PT7vxNpvhDka35DBxJYpd0s32JAKtFgEK1F6tozdRwbWVGaGXNzA9KTuwPMbicbKYYyG2zx+GVIw46JGbmgp3Lhr2QW4BVcVhlDnmpzikAACToZpozgJWGP1zzujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762153997; c=relaxed/simple;
	bh=evbjhUsyPEtlXMWP7fJNY7yQ2DKYSAvfprUo+XQmWKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Efs14Vfjkhf5WSPqYt4KD3TLr00yhT7GU1kszozkB7CmZl5wgo4cexAZ9OFRAGoCoxT++iuLCLnIYYqzz7wsu3thi9pMz71TLf2qicQ6OvLb8g0eDRBsopm+O2FretYLnDDeMyFYBqsH/3AMaxGlwJFIJ/ayo/tYrKJri1ueGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fcFSGK+Z; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso3982965a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762153994; x=1762758794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+arHJcPoueo1Yi6g0ODC3rA/HeIdq0Ft6URIehR7l9M=;
        b=fcFSGK+ZombircRfd3nW2LJEgna4uhkVJRQVMII1k6zdGJ/PYn9aohW5TU3AfkqQJ+
         dnq6yxJgNlcKx9HEJNWojSMx8lfMbmnhds2ShTfhjSxaly2NVTLHdApD6lnzqXJgglDu
         FUWh7KaJPL68HdQ0rCEWxsIatrVYuDgr6aBeRmvxk5umFhtW2kp/VMo9E7WPy2Kf0KTA
         3C0xL0345HvVNFwBmHs6aAyiUYeoAdHJRFARoh+oGBhBRcFYQGQescCERESHUAKNJeMc
         t1e8bvUHgddVaSgjLySNhz5E5jnIAX1iqvbhe/OYg3+C7k0NU9UioCfmLcelIrValalj
         plAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762153994; x=1762758794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+arHJcPoueo1Yi6g0ODC3rA/HeIdq0Ft6URIehR7l9M=;
        b=ZrnCVr4Zlt4cHANbqbOT1Da6zOFaGUj6ZNZwv+o0MxRglBrSrOahICkm1DfLugRaMI
         pjLNfmtKI6vPtCdSXk09KTjcoISSJhVp7uuKOer+/IlpaoAnLPFNTZrq0KtxPp+CiYK9
         1N1rsnIylCTb8UN4QJISG0kGga61Is/sl9fCW5tmKfck6+FNO3/k1oQuac9aPkbSF1Ed
         TdZ7tl7/CsUGnF6D9OYWgI5GirENMBsMvMnZRDVE9767nS72mAdUVNB/40gbdtBLCnO8
         JxjDpZ+CAT7ZM366/wBf8XNbUH4y9nCFY4z7Ks6TPKY80agXAQV0eZ2VHiSiozjPMRH8
         duJw==
X-Forwarded-Encrypted: i=1; AJvYcCUBMQW877H/lXtYVZwGGPNeY6Jfg3XiKPWDEO7kTv5FBWhTqhvU8ac5AdS15QRDmJWAPKnglwJBHfrVYMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+fc1+kTrNQEPfJ1YUJyGlFCUclgWwrNogxa8OZnab3E12iBC
	o/ffql5dhf42hnIhyogZu3cYjqp12OIjeogisIo82SlgNO4XT4BXVM0HD0F4vBCngnTZJZM5mSE
	4YWeShShaqOS7i1rXvrxT2Y4lXMVbtrxFJyepqLR9
X-Gm-Gg: ASbGncuNlVzIL7p+2Rwb7S8oX0741DDgurBf9Skq5XusBh5Cy/2e8rMK7Y5YLOhbCYN
	FlO25RIkaAI80K9YcHgSCtIQeSyLPtI2XJWj2f3fvAHy+bd1GbmS89Efv7fpko6So8jkjmCYQkL
	wLLAlRyjO7EOdLfCpRm50wH++iJGEEWIV7h0SQ1BNLB2k72qwIROl+9jPcsHq+ghLTY3gN5XY8y
	92ArU7uuUyIFhSlRJ315QcPSYtFU5TEQXcAhj9QoIP0dYAJgxCW4+5wxZ9KQbu3EatzYLC6OJ89
	/GCIqt5pjiWtmlrGGI1AUQdeS9as
X-Google-Smtp-Source: AGHT+IGJrw3q48WCws5tAboLKA5HMrjEMWxK5exJRzbYZ4564Qe9iW/p3tDgnBsJrrTFDzBQhennpwUHlSTKJlLdqME=
X-Received: by 2002:a17:90b:1844:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-3410134ab67mr4207631a91.28.1762153994360; Sun, 02 Nov 2025
 23:13:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-6-eperezma@redhat.com>
 <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com>
 <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com>
 <CACycT3v4zp_uDRA6ELwcZB287TYLsJfx34EepAhSRJ+w6B0hvw@mail.gmail.com>
 <CAJaqyWe31w=Z--Sh6ufwvhaBsBaKypUjHzLy9qm6NyDJM-NgDQ@mail.gmail.com>
 <CACycT3sKofWfottqAzRWscCWNaodnqXiFtvuhSv7Pqz1F0+90A@mail.gmail.com> <CAJaqyWdzeOsTG2YT3wJCuoFMffDmGXAsPp4GwL+Jq1h-O8h9SQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdzeOsTG2YT3wJCuoFMffDmGXAsPp4GwL+Jq1h-O8h9SQ@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 3 Nov 2025 15:13:03 +0800
X-Gm-Features: AWmQ_bnykAMm-QJbaW-_COhdsSaaNbVE6YqgjS_EX3fUVMKS6M_CbkcsHb9IiIA
Message-ID: <CACycT3u4AS3=8sQuDhLWoyg5ExTPyfDf8GTB23pAepGZizMBhQ@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 2:41=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Nov 3, 2025 at 3:55=E2=80=AFAM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
> >
> > On Fri, Oct 31, 2025 at 10:09=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Fri, Oct 31, 2025 at 8:01=E2=80=AFAM Yongji Xie <xieyongji@bytedan=
ce.com> wrote:
> > > >
> > > > On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyongji@by=
tedance.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <epe=
rezma@redhat.com> wrote:
> > > > > > >
> > > > > > > Add support for assigning Address Space Identifiers (ASIDs) t=
o each VQ
> > > > > > > group.  This enables mapping each group into a distinct memor=
y space.
> > > > > > >
> > > > > > > Now that the driver can change ASID in the middle of operatio=
n, the
> > > > > > > domain that each vq address point is also protected by domain=
_lock.
> > > > > > >
> > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > ---
> > > > > > > v8:
> > > > > > > * Revert the mutex to rwlock change, it needs proper profilin=
g to
> > > > > > >   justify it.
> > > > > > >
> > > > > > > v7:
> > > > > > > * Take write lock in the error path (Jason).
> > > > > > >
> > > > > > > v6:
> > > > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VE=
RSION_1) ?/
> > > > > > >   (MST).
> > > > > > > * Fix struct name not matching in the doc.
> > > > > > >
> > > > > > > v5:
> > > > > > > * Properly return errno if copy_to_user returns >0 in VDUSE_I=
OTLB_GET_FD
> > > > > > >   ioctl (Jason).
> > > > > > > * Properly set domain bounce size to divide equally between n=
as (Jason).
> > > > > > > * Exclude "padding" member from the only >V1 members in
> > > > > > >   vduse_dev_request.
> > > > > > >
> > > > > > > v4:
> > > > > > > * Divide each domain bounce size between the device bounce si=
ze (Jason).
> > > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > > * Change if (x && (y || z)) return to if (x) { if (y) return;=
 if (z)
> > > > > > >   return; } (Jason)
> > > > > > > * Change a bad multiline comment, using @ caracter instead of=
 * (Jason).
> > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > > >
> > > > > > > v3:
> > > > > > > * Get the vduse domain through the vduse_as in the map functi=
ons
> > > > > > >   (Jason).
> > > > > > > * Squash with the patch creating the vduse_as struct (Jason).
> > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic=
 number
> > > > > > >   (Jason)
> > > > > > >
> > > > > > > v2:
> > > > > > > * Convert the use of mutex to rwlock.
> > > > > > >
> > > > > > > RFC v3:
> > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set =
to a lower
> > > > > > >   value to reduce memory consumption, but vqs are already lim=
ited to
> > > > > > >   that value and userspace VDUSE is able to allocate that man=
y vqs.
> > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > > * Move the umem mutex to asid struct so there is no contentio=
n between
> > > > > > >   ASIDs.
> > > > > > >
> > > > > > > RFC v2:
> > > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so th=
e first
> > > > > > >   part of the struct is the same.
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 +++++++++++++++++++=
+---------
> > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index 97be04f73fbf..c6909d73d06d 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -41,6 +41,7 @@
> > > > > > >
> > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > @@ -86,7 +87,14 @@ struct vduse_umem {
> > > > > > >         struct mm_struct *mm;
> > > > > > >  };
> > > > > > >
> > > > > > > +struct vduse_as {
> > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > +       struct vduse_umem *umem;
> > > > > > > +       struct mutex mem_lock;
> > > > > > > +};
> > > > > > > +
> > > > > > >  struct vduse_vq_group {
> > > > > > > +       struct vduse_as *as;
> > > > > > >         struct vduse_dev *dev;
> > > > > > >  };
> > > > > > >
> > > > > > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > > > > > >         struct vduse_vdpa *vdev;
> > > > > > >         struct device *dev;
> > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > +       struct vduse_as *as;
> > > > > > >         char *name;
> > > > > > >         struct mutex lock;
> > > > > > >         spinlock_t msg_lock;
> > > > > > > @@ -122,9 +130,8 @@ struct vduse_dev {
> > > > > > >         u32 vq_num;
> > > > > > >         u32 vq_align;
> > > > > > >         u32 ngroups;
> > > > > > > -       struct vduse_umem *umem;
> > > > > > > +       u32 nas;
> > > > > > >         struct vduse_vq_group *groups;
> > > > > > > -       struct mutex mem_lock;
> > > > > > >         unsigned int bounce_size;
> > > > > > >         struct mutex domain_lock;
> > > > > > >  };
> > > > > > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct vd=
use_dev *dev, u8 status)
> > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > >  }
> > > > > > >
> > > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32=
 asid,
> > > > > > >                                   u64 start, u64 last)
> > > > > > >  {
> > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(struct=
 vduse_dev *dev,
> > > > > > >                 return -EINVAL;
> > > > > > >
> > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > +       } else {
> > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > +       }
> > > > > > >
> > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > >  }
> > > > > > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct f=
ile *file, poll_table *wait)
> > > > > > >         return mask;
> > > > > > >  }
> > > > > > >
> > > > > > > +/* Force set the asid to a vq group without a message to the=
 VDUSE device */
> > > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev=
,
> > > > > > > +                                      unsigned int group, un=
signed int asid)
> > > > > > > +{
> > > > > > > +       mutex_lock(&dev->domain_lock);
> > > > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > > > +       mutex_unlock(&dev->domain_lock);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > > >  {
> > > > > > >         int i;
> > > > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > > > >
> > > > > > >         /* The coherent mappings are handled in vduse_dev_fre=
e_coherent() */
> > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > +               struct vduse_iova_domain *domain =3D dev->as[=
i].domain;
> > > > > > > +
> > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > +                       vduse_domain_reset_bounce_map(domain)=
;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > > > >
> > > > > > >         down_write(&dev->rwsem);
> > > > > > >
> > > > > > > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_map=
(struct vdpa_device *vdpa, u16 idx)
> > > > > > >         return ret;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, un=
signed int group,
> > > > > > > +                               unsigned int asid)
> > > > > > > +{
> > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > +       int r;
> > > > > > > +
> > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > > > > > +               return -EINVAL;
> > > > > > > +
> > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > +
> > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > +       if (r < 0)
> > > > > > > +               return r;
> > > > > > > +
> > > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa,=
 u16 idx,
> > > > > > >                                 struct vdpa_vq_state *state)
> > > > > > >  {
> > > > > > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct vd=
pa_device *vdpa,
> > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > >         int ret;
> > > > > > >
> > > > > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, io=
tlb);
> > > > > > >         if (ret)
> > > > > > >                 return ret;
> > > > > > >
> > > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX)=
;
> > > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLON=
G_MAX);
> > > > > > >         if (ret) {
> > > > > > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > > > > > +               vduse_domain_clear_map(dev->as[asid].domain, =
iotlb);
> > > > > > >                 return ret;
> > > > > > >         }
> > > > > > >
> > > > > > > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops vduse=
_vdpa_config_ops =3D {
> > > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinit=
y,
> > > > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > > > >         .free                   =3D vduse_vdpa_free,
> > > > > > >  };
> > > > > > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_de=
vice(union virtio_map token,
> > > > > > >                 return;
> > > > > > >
> > > > > > >         vdev =3D token.group->dev;
> > > > > > > -       domain =3D vdev->domain;
> > > > > > > -
> > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > +       domain =3D token.group->as->domain;
> > > > > > >         vduse_domain_sync_single_for_device(domain, dma_addr,=
 size, dir);
> > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > >  }
> > > > > > >
> > > > > > >  static void vduse_dev_sync_single_for_cpu(union virtio_map t=
oken,
> > > > > > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_cp=
u(union virtio_map token,
> > > > > > >                 return;
> > > > > > >
> > > > > > >         vdev =3D token.group->dev;
> > > > > > > -       domain =3D vdev->domain;
> > > > > > > -
> > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > +       domain =3D token.group->as->domain;
> > > > > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, si=
ze, dir);
> > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > >  }
> > > > > > >
> > > > > > >  static dma_addr_t vduse_dev_map_page(union virtio_map token,=
 struct page *page,
> > > > > > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(un=
ion virtio_map token, struct page *page,
> > > > > > >  {
> > > > > > >         struct vduse_dev *vdev;
> > > > > > >         struct vduse_iova_domain *domain;
> > > > > > > +       dma_addr_t r;
> > > > > > >
> > > > > > >         if (!token.group)
> > > > > > >                 return DMA_MAPPING_ERROR;
> > > > > > >
> > > > > > >         vdev =3D token.group->dev;
> > > > > > > -       domain =3D vdev->domain;
> > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > >
> > > > > > The mutex_lock can't be used here since the dma ops might be ca=
lled in
> > > > > > atomic context. And I think we can just remove it since creatio=
n and
> > > > > > deletion operations of the iova domain are guaranteed not to ex=
ecute
> > > > > > concurrently with I/O operations.
> > > > > >
> > > > >
> > > > > That would be great indeed! Can you expand on this, what protects=
 here
> > > > > from the moment the two syscalls are issues from userland?
> > > > >
> > > >
> > > > The domain mutex lock is introduced in commit
> > > > d4438d23eeeef8bb1b3a8abe418abffd60bb544a ("vduse: Delay iova domain
> > > > creation"). It's used to prevent concurrent execution between
> > > > vdpa_dev_add() and some vduse device ioctl which needs to access th=
e
> > > > iova domain such as VDUSE_IOTLB_REG_UMEM/DEREG_UMEM. But the dma op=
s
> > > > would not be called until vdpa_dev_add() completed, so the mutex lo=
ck
> > > > is not needed.
> > > >
> > >
> > > Yes, but the usage is extended here to also protect from concurrent
> > > calls to vduse_dev_map_page and vduse_set_group_asid or similar.
> > >
> > > So I guess the best is to replace it with a spinlock or RCU.
> > >
> >
> > OK, I see, we simply aim to prevent concurrent access to the group->as
> > variable here. But I wonder if the .set_group_asid function can be
> > called during I/O.
>
> At least a malicious userland app could do it.
>
> > I think the unmap_page() would fail if we change
> > the group->as between map_page() and unmap_page().
>
> I guess a SIGSEGV or similar could be a valid outcome of that, but we
> need to protect the "as" pointer anyway.
>
> > Besides, it seems
> > that .set_group_asid is only called in the vhost-vdpa case currently,
> > but the dma ops such as map_page/unmap_page only service the
> > virtio-vdpa case, so they would not be called concurrently with
> > .set_group_asid now.
> >
>
> That's totally true but a malicious app can do it anyway. So it is
> better to protect it properly.
>

Actually there is no interface for userspace to call .set_group_asid
if the vduse device is binded to the virtio-vdpa driver.

> Preparing a new version with a spinlock or RCU, thanks!
>

If so, we'd better introduce a new RCU lock here rather than using the
domain lock.

Thanks,
Yongji

