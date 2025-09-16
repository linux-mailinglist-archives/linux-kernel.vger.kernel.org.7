Return-Path: <linux-kernel+bounces-818478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D1B59243
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5701B268C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD3829AB15;
	Tue, 16 Sep 2025 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7JV+FYr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD5288C89
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015093; cv=none; b=QqZJ1iNWUQTvtPYAM4/wJE8uudZ+AyTGhcC/jeZ0ADRUHy3pQVDTFcaGkpKZKp6WJWnhJbK59EquTG5RNiF3NdjDCt069kT+QIP+zY1Dlu132+g+tABPjopuymxq4aHrA4w6GydjxJIfWaQyyLfQIsFEW+/O0jzNpnzAaWbCxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015093; c=relaxed/simple;
	bh=hs4DU9bmjMgMN4EJLnSEmFWC7qoZT1F8YHGBKhnSsp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6WtiL0JajI3VdRxwZN0fK0uJDBIwQtkhrf2rup8p+PfzJnWpDqNCisfcxhwYtZo/TUEUonqqyriEs8BSsY9Dfx/CWmd6u7eKSRFZZRK+z4wq6wKDGFq1v09LCi0UFBut0bIeJw0ZsWs1pqPCk3LCtmFiR52HSyMYnLyA/tMtfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7JV+FYr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758015089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ib4Tkdqhm4azNwwchCLarf6pLs2hvhojrtVUk6fGM8s=;
	b=G7JV+FYrtWzW8cC7Cec26cir/ORNR69RE2FQF0Eg1umDt/WimADzJ4RQ1pu7XzPXtD/qj9
	DJGCpYAR3XKVwJralgu88MMOmS4enp4uLvPSWTsFNHul8imVdGPJHhJHDpt8f/oO/zM/YO
	Ov4H5DIc4Uw1ohkKSVdKljiD6XXK85Q=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-RcoboODbPB2f-lU2c6IneQ-1; Tue, 16 Sep 2025 05:31:28 -0400
X-MC-Unique: RcoboODbPB2f-lU2c6IneQ-1
X-Mimecast-MFC-AGG-ID: RcoboODbPB2f-lU2c6IneQ_1758015088
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-60f47bb49f1so4564386d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015088; x=1758619888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ib4Tkdqhm4azNwwchCLarf6pLs2hvhojrtVUk6fGM8s=;
        b=abmwCJd/99FNlpwdYd7EuRK+TIusTqsgpVB1rWQG1nuUj4zrJhErJGN9Z33ds75lwW
         HEka7JgFWmaiGswRK7fZFgqK7GowXCTY9xXukpLZlix/wB5MB9caLDg9C11266YuuTPn
         Gbf9JW/TxeO29wQgkha7Y21KkeWnjxCSIxLDLsYXlna/ERiXFGY7xn96zX1v+3Opezvs
         ysImb5f6aMzP9rvSquI1aO6QtNeuCvddMOYXcWhaUNqcDGWK4DHH5vsMt6sF4rAzToTH
         h294kKbyiLTwu27W1NowfF9C+gmdPpFN5zUOFKlvIQhm15nbVSz3Z4ETdLD+3uloyIe1
         jQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCU0vjaLjEWBCLGDRv6g+kS3DEo4Q3GPM3I055tOFXo+CI6fHMxQa/hn7z8w2moNq9u0Jr3qtMey6g6uaZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMsKjWbFJF9XG+7j29roimUrsNsvrBMDb3bTYKItBa9w6Ep25
	SuSo8m/x89qBHld9Z7/Br5ztCzPBUu3Fn51JBVztULII301a47JmbXahapx073ROii9/Qcd6YzW
	oKrQ6ekeF0WPNu18SGtZyvEdBwvD3/AuSP3qgLmhoXoQC9JH0sf3aYU5ZsobNcf9K0VMSZQWrdU
	hP7xmgpYyrDJaNC+4CGh7uhGNxXRHXUJaqGjkM9rxN
X-Gm-Gg: ASbGnctWt6XIsfW+92wTjBTPeGuZB3cPivsMbFSY6suYmOfEJ1NCcZGM3aR56lRWJvB
	oHisiwRKhwuGmJzR9dQHiPGUls6VaCuNrjSSihScQ3BlfrFSHaG/KZZhBmlNJ9Wqe7p0N5JQDO8
	2ErkGmzpnviQsKWgWfgWYYf/aguM2dVFtYNLoOqFtjxENvXTOW1FfNj7D7UF7cVydGq/ACrn7xs
	y4u+q5JCtPaIM/ViUKuVoGf2m3GYozW7JSnd9a/pHjs
X-Received: by 2002:a53:d645:0:b0:633:a1c7:ab72 with SMTP id 956f58d0204a3-633a1c7b2c1mr1153638d50.37.1758015087822;
        Tue, 16 Sep 2025 02:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAexSGu+ClNoQwUCXj+/rxG2mNjZgHnV3uExzz15hIyPbt5ZC4oCv1dZGdaL2PHef1hHIpFp3VWGN3PNfPYrQ=
X-Received: by 2002:a53:d645:0:b0:633:a1c7:ab72 with SMTP id
 956f58d0204a3-633a1c7b2c1mr1153616d50.37.1758015087273; Tue, 16 Sep 2025
 02:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-6-eperezma@redhat.com>
 <CACycT3v=_Nm6fefJGFEyoU+Xf5G=Kzi0sXhhaBHnJQZcG-4EqA@mail.gmail.com>
In-Reply-To: <CACycT3v=_Nm6fefJGFEyoU+Xf5G=Kzi0sXhhaBHnJQZcG-4EqA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Sep 2025 11:30:50 +0200
X-Gm-Features: Ac12FXyKW3pAidVDIyPsFhtkbmaLjnspz5U_JhnATocRp1FZQ9QX7hGc72YwNsM
Message-ID: <CAJaqyWeKmxM=DDLka-QBv35YwXn4eJeLJOqxJ_3HnRz_mq8K6g@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add vq group asid support
To: Yongji Xie <xieyongji@bytedance.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 2:12=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com>=
 wrote:
>
> Hi Eugenio,
>
> On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> > group.  This enables mapping each group into a distinct memory space.
> >
> > Now that the driver can change ASID in the middle of operation, the
> > domain that each vq address point is also protected by domain_lock.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v3:
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
> > v2:
> > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> >   part of the struct is the same.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 290 +++++++++++++++++++++--------
> >  include/uapi/linux/vduse.h         |  52 +++++-
> >  2 files changed, 259 insertions(+), 83 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 7d2a3ed77b1e..2fb227713972 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -92,6 +92,7 @@ struct vduse_as {
> >  };
> >
> >  struct vduse_vq_group_int {
> > +       struct vduse_iova_domain *domain;
> >         struct vduse_dev *dev;
> >  };
> >
> > @@ -99,7 +100,7 @@ struct vduse_dev {
> >         struct vduse_vdpa *vdev;
> >         struct device *dev;
> >         struct vduse_virtqueue **vqs;
> > -       struct vduse_as as;
> > +       struct vduse_as *as;
> >         char *name;
> >         struct mutex lock;
> >         spinlock_t msg_lock;
> > @@ -127,6 +128,7 @@ struct vduse_dev {
> >         u32 vq_num;
> >         u32 vq_align;
> >         u32 ngroups;
> > +       u32 nas;
> >         struct vduse_vq_group_int *groups;
> >         unsigned int bounce_size;
> >         struct mutex domain_lock;
> > @@ -317,7 +319,7 @@ static int vduse_dev_set_status(struct vduse_dev *d=
ev, u8 status)
> >         return vduse_dev_msg_sync(dev, &msg);
> >  }
> >
> > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> >                                   u64 start, u64 last)
> >  {
> >         struct vduse_dev_msg msg =3D { 0 };
> > @@ -326,8 +328,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev=
 *dev,
> >                 return -EINVAL;
> >
> >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > -       msg.req.iova.start =3D start;
> > -       msg.req.iova.last =3D last;
> > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > +               msg.req.iova.start =3D start;
> > +               msg.req.iova.last =3D last;
> > +       } else {
> > +               msg.req.iova_v2.start =3D start;
> > +               msg.req.iova_v2.last =3D last;
> > +               msg.req.iova_v2.asid =3D asid;
> > +       }
> >
> >         return vduse_dev_msg_sync(dev, &msg);
> >  }
> > @@ -439,14 +447,28 @@ static __poll_t vduse_dev_poll(struct file *file,=
 poll_table *wait)
> >         return mask;
> >  }
> >
> > +/* Force set the asid to a vq group without a message to the VDUSE dev=
ice */
> > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > +                                      unsigned int group, unsigned int=
 asid)
> > +{
> > +       guard(mutex)(&dev->domain_lock);
> > +       dev->groups[group].domain =3D dev->as[asid].domain;
> > +}
> > +
> >  static void vduse_dev_reset(struct vduse_dev *dev)
> >  {
> >         int i;
> > -       struct vduse_iova_domain *domain =3D dev->as.domain;
> >
> >         /* The coherent mappings are handled in vduse_dev_free_coherent=
() */
> > -       if (domain && domain->bounce_map)
> > -               vduse_domain_reset_bounce_map(domain);
> > +       for (i =3D 0; i < dev->nas; i++) {
> > +               struct vduse_iova_domain *domain =3D dev->as[i].domain;
> > +
> > +               if (domain && domain->bounce_map)
> > +                       vduse_domain_reset_bounce_map(domain);
> > +       }
> > +
> > +       for (i =3D 0; i < dev->ngroups; i++)
> > +               vduse_set_group_asid_nomsg(dev, i, 0);
> >
> >         down_write(&dev->rwsem);
> >
> > @@ -620,6 +642,29 @@ static union virtio_map vduse_get_vq_map(struct vd=
pa_device *vdpa, u16 idx)
> >         return ret;
> >  }
> >
> > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int=
 group,
> > +                               unsigned int asid)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +       struct vduse_dev_msg msg =3D { 0 };
> > +       int r;
> > +
> > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > +               return -EINVAL;
> > +
> > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > +       msg.req.vq_group_asid.group =3D group;
> > +       msg.req.vq_group_asid.asid =3D asid;
> > +
> > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > +       if (r < 0)
> > +               return r;
> > +
> > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > +       return 0;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -818,13 +863,13 @@ static int vduse_vdpa_set_map(struct vdpa_device =
*vdpa,
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >         int ret;
> >
> > -       ret =3D vduse_domain_set_map(dev->as.domain, iotlb);
> > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> >         if (ret)
> >                 return ret;
> >
> > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
> >         if (ret) {
> > -               vduse_domain_clear_map(dev->as.domain, iotlb);
> > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
> >                 return ret;
> >         }
> >
> > @@ -867,6 +912,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >         .reset                  =3D vduse_vdpa_reset,
> >         .set_map                =3D vduse_vdpa_set_map,
> > +       .set_group_asid         =3D vduse_set_group_asid,
> >         .get_vq_map             =3D vduse_get_vq_map,
> >         .free                   =3D vduse_vdpa_free,
> >  };
> > @@ -876,8 +922,10 @@ static void vduse_dev_sync_single_for_device(union=
 virtio_map token,
> >                                              enum dma_data_direction di=
r)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > +       struct vduse_iova_domain *domain;
> >
> > +       guard(mutex)(&vdev->domain_lock);
> > +       domain =3D token.group->domain;
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
> >  }
> >
> > @@ -886,8 +934,10 @@ static void vduse_dev_sync_single_for_cpu(union vi=
rtio_map token,
> >                                              enum dma_data_direction di=
r)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > +       struct vduse_iova_domain *domain;
> >
> > +       guard(mutex)(&vdev->domain_lock);
> > +       domain =3D token.group->domain;
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> >  }
> >
> > @@ -897,8 +947,10 @@ static dma_addr_t vduse_dev_map_page(union virtio_=
map token, struct page *page,
> >                                      unsigned long attrs)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > +       struct vduse_iova_domain *domain;
> >
> > +       guard(mutex)(&vdev->domain_lock);
>
> Won't this mutex lock hurt the performance? Can we use rw_lock/rcu_lock i=
nstead?
>

I think RCU is not valid as the driver expects iotlb changes to be
done when it returns, and do not allow in-flight requests to access
the old data.

Using rwlock for the next version, thanks!


