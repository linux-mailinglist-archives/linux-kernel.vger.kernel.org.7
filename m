Return-Path: <linux-kernel+bounces-826475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB03B8EA09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A1E3BD57B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5A757EA;
	Mon, 22 Sep 2025 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFL/L3HO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0CD3C33
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758501819; cv=none; b=vARLWX0Zv3LlWUrrVBqnz4YUq03JQKyjDJt0ExttODGbITex8NENCwa/+wcwgIvoFOgaG/gSRV0Qrq3C+b4Bk1Eh/SgYwHKZB7Tizg0iyJ3/cr7NmSmZFfJ9QeeaXg+ictF/udj5cUrCgtivxcR/Ep2sq+4HMM6QmLHMjKkLvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758501819; c=relaxed/simple;
	bh=/iqUk/Yni83GIGQ6/+76kON6nOiHnM71jWp/JTRkbYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTS8ZEfHOEHZ1KDpSNxwYaytFv2Jgb2fJm85+WieZkRmOYbVY3g5oUGA2Qw2pQo+YdXhTz5f+T0GFt7CtY6knnu0ahWGoO9sTmT4Yahc3qbCAfNNydCQEG0Bp1rDM5KjG2NCWhrlzr8C5fYC7foRBiq9isgqfTRHs+HOSkkJlkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFL/L3HO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758501815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rbTpvybu/7oZbTC6DelSAe+gwtnRBI4nmgRx5ZUUXI=;
	b=PFL/L3HOBRt2KaVIygQO3UTx9Bh2O00hSm0TBmgrd3bNAgE8LDaTn2YssaWDV4Q/+c69gf
	e5lzGlNktgEtoxAUihwXZqwxDjbyREUAeMjaa8xLtpRMbuZ2F13VEIA51hRz5hMQfoy05X
	49wPN2WSOpdPtuAViZx99OftzXTf3WU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-vGrJOIaYNkaa8FvOqJAUGw-1; Sun, 21 Sep 2025 20:43:34 -0400
X-MC-Unique: vGrJOIaYNkaa8FvOqJAUGw-1
X-Mimecast-MFC-AGG-ID: vGrJOIaYNkaa8FvOqJAUGw_1758501813
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24458345f5dso53772425ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758501812; x=1759106612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rbTpvybu/7oZbTC6DelSAe+gwtnRBI4nmgRx5ZUUXI=;
        b=GAi6wqXB30fLFswhFP58tzLMNOJFfi+qleHZZoTGz+JNxrKplHT8zb9X+ue3dugiOE
         tiCJc/C2FS7fjZdEyMmDgmb0Bbf+cjEnVHoIfGzAR4tsQm2u8CSQ4H+RFVcWS3Bze4QH
         4oe1/SrhIXzPtI4iiu/wMwZpRhSD53+3WFurd6KFEBZ6mSX8v2boLpGTcVxEGQkrJDGK
         lWCMQRui9IirN7sZ4Juz6BBf5W7GhdZqNiYsVVkEKJ5MUlVBIdknsMep+FPCewosi4/h
         gGSnWtuIT0NK0+0qBAg5exVRqInGGlhZIkjdF3SDjqL7v6YKmU0phZfnfe9o8SJyUo7J
         xSuw==
X-Forwarded-Encrypted: i=1; AJvYcCV8z1Spv0zl5sfzwgaQf7OPCMMkvSp+r8Cef08xmQD/IsL5RqrxJRRIigChQF21JsgrHKwgH76C0W83gZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZS4E/NuFHazm57gKnGf0VbJX2YnYv+At1YYDaI3sZcgYh3N2W
	HpjB2paZjbQzF68JofeGJq8p6im6MRjX0l6EMsMjWdrtzTJVF5cB21asH91PuCmd5GyGk2sPkl4
	oVLdWeyHNANnfRgX71TAe51y/BmsLjEj08Hg3xSWFUeU2es1p0sOBv5YuSXIHzP4hIuUgX+qMGW
	VEvPaeukWIOi3srSZlTA0T4tu8wUhDS/7Mmwydt/jXkaqJH9f4Rwc=
X-Gm-Gg: ASbGnctf7BkgWpRi48xp/yONjSRHbZNj7tKXEHsP0pdKswWEjICzgDWdhTP37HaRR7t
	iL1arHjq1jvmbemUcqbJ6U6fM6sqzUHZcjLAWNIk6SpeFpX9fOychsDxqXk/OdA0vbppcVhtnR+
	OyGWUnpenqnZnzXp2qLtmLyA==
X-Received: by 2002:a05:6a20:3d05:b0:2be:81e3:112a with SMTP id adf61e73a8af0-2be81e32d30mr1212641637.8.1758501812087;
        Sun, 21 Sep 2025 17:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr4Gy9pYVutqBgPi6Vst+/mxw909Gm8FoWlUOsUlm2i5pk+6QL6S5oxjjyijCx5KRWqp3glkHzqJxfZ02cZyg=
X-Received: by 2002:a05:6a20:3d05:b0:2be:81e3:112a with SMTP id
 adf61e73a8af0-2be81e32d30mr1212617637.8.1758501811547; Sun, 21 Sep 2025
 17:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-20-jasowang@redhat.com>
 <20250921133711-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921133711-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:43:20 +0800
X-Gm-Features: AS18NWB-Fk2mTEyB3SU-enpeVRG0VZa3aetxvHMM9zHfsRVeyPhYRgIWDd919EY
Message-ID: <CACGkMEv5M7ud359wvOTCFJdHw_zrOBnwf5i6GqDh7ZR3QE==Dw@mail.gmail.com>
Subject: Re: [PATCH V6 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:40=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:54PM +0800, Jason Wang wrote:
> > This patch implements in order support for both split virtqueue and
> > packed virtqueue. Perfomance could be gained for the device where the
> > memory access could be expensive (e.g vhost-net or a real PCI device):
> >
> > Benchmark with KVM guest:
> >
> > Vhost-net on the host: (pktgen + XDP_DROP):
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.20Mpps     | 6.20Mpps    | +19%
> >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> >
> > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> >
> > For split virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> >
> > For packed virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> >
> > Benchmark also shows no performance impact for in_order=3Doff for queue
> > size with 256 and 1024.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 421 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 401 insertions(+), 20 deletions(-)
>
>
>
> Thanks for the patch! Yet something to improve:
>
>
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index b700aa3e56c3..c00b5e57f2fc 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -70,6 +70,8 @@
> >  enum vq_layout {
> >       SPLIT =3D 0,
> >       PACKED,
> > +     SPLIT_IN_ORDER,
> > +     PACKED_IN_ORDER,
> >       VQ_TYPE_MAX,
> >  };
> >
> > @@ -80,6 +82,7 @@ struct vring_desc_state_split {
> >        * allocated together. So we won't stress more to the memory allo=
cator.
> >        */
> >       struct vring_desc *indir_desc;
> > +     u32 total_len;                  /* Buffer Length */
> >  };
> >
> >  struct vring_desc_state_packed {
> > @@ -91,6 +94,7 @@ struct vring_desc_state_packed {
> >       struct vring_packed_desc *indir_desc;
> >       u16 num;                        /* Descriptor list length. */
> >       u16 last;                       /* The last desc state in a list.=
 */
> > +     u32 total_len;                  /* Buffer Length */
> >  };
> >
> >  struct vring_desc_extra {
> > @@ -206,6 +210,17 @@ struct vring_virtqueue {
> >
> >       /* Head of free buffer list. */
> >       unsigned int free_head;
> > +
> > +     /*
> > +      * With IN_ORDER, devices write a single used ring entry with
> > +      * the id corresponding to the head entry of the descriptor chain
> > +      * describing the last buffer in the batch
> > +      */
> > +     struct used_entry {
> > +             u32 id;
> > +             u32 len;
> > +     } batch_last;
> > +
> >       /* Number we've added since last sync. */
> >       unsigned int num_added;
> >
> > @@ -258,7 +273,12 @@ static void vring_free(struct virtqueue *_vq);
> >
> >  static inline bool virtqueue_is_packed(const struct vring_virtqueue *v=
q)
> >  {
> > -     return vq->layout =3D=3D PACKED;
> > +     return vq->layout =3D=3D PACKED || vq->layout =3D=3D PACKED_IN_OR=
DER;
> > +}
> > +
> > +static inline bool virtqueue_is_in_order(const struct vring_virtqueue =
*vq)
> > +{
> > +     return vq->layout =3D=3D SPLIT_IN_ORDER || vq->layout =3D=3D PACK=
ED_IN_ORDER;
> >  }
> >
> >  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> > @@ -575,6 +595,8 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> >       unsigned int i, n, avail, descs_used, err_idx, c =3D 0;
> > +     /* Total length for in-order */
> > +     unsigned int total_len =3D 0;
> >       int head;
> >       bool indirect;
> >
> > @@ -646,6 +668,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >                                                    ++c =3D=3D total_sg =
?
> >                                                    0 : VRING_DESC_F_NEX=
T,
> >                                                    premapped);
> > +                     total_len +=3D len;
> >               }
> >       }
> >       for (; n < (out_sgs + in_sgs); n++) {
> > @@ -663,6 +686,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >                               i, addr, len,
> >                               (++c =3D=3D total_sg ? 0 : VRING_DESC_F_N=
EXT) |
> >                               VRING_DESC_F_WRITE, premapped);
> > +                     total_len +=3D len;
> >               }
> >       }
> >
> > @@ -685,7 +709,12 @@ static inline int virtqueue_add_split(struct vring=
_virtqueue *vq,
> >       vq->vq.num_free -=3D descs_used;
> >
> >       /* Update free pointer */
> > -     if (indirect)
> > +     if (virtqueue_is_in_order(vq)) {
> > +             vq->free_head +=3D descs_used;
> > +             if (vq->free_head >=3D vq->split.vring.num)
> > +                     vq->free_head -=3D vq->split.vring.num;
> > +             vq->split.desc_state[head].total_len =3D total_len;;
>
> what is going on here?

I'm not sure I get the question. But total_len is needed for the
driver to get the used buffer length when the device is doing batched
used idx updating.

Or you may wonder why we have a check for in_order? It is because the
function is used in both in_order and !in_order since the difference
is minimal. When we come more optimizations for in_order in the future
we can consider to use a separate function for in_order add.


>
> > +     } else if (indirect)
> >               vq->free_head =3D vq->split.desc_extra[head].next;
> >       else
> >               vq->free_head =3D i;
> > @@ -858,6 +887,14 @@ static bool more_used_split(const struct vring_vir=
tqueue *vq)
> >       return virtqueue_poll_split(vq, vq->last_used_idx);
> >  }
> >
> > +static bool more_used_split_in_order(const struct vring_virtqueue *vq)
> > +{
> > +     if (vq->batch_last.id !=3D vq->packed.vring.num)
> > +             return true;
> > +
> > +     return virtqueue_poll_split(vq, vq->last_used_idx);
> > +}
> > +
> >  static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
> >                                        unsigned int *len,
> >                                        void **ctx)
> > @@ -915,6 +952,73 @@ static void *virtqueue_get_buf_ctx_split(struct vr=
ing_virtqueue *vq,
> >       return ret;
> >  }
> >
> > +static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtque=
ue *vq,
> > +                                               unsigned int *len,
> > +                                               void **ctx)
> > +{
> > +     void *ret;
> > +     unsigned int num =3D vq->split.vring.num;
> > +     u16 last_used;
> > +
> > +     START_USE(vq);
> > +
> > +     if (unlikely(vq->broken)) {
> > +             END_USE(vq);
> > +             return NULL;
> > +     }
> > +
> > +     last_used =3D (vq->last_used_idx & (vq->split.vring.num - 1));
> > +
> > +     if (vq->batch_last.id =3D=3D num) {
> > +             if (!more_used_split(vq)) {
> > +                     pr_debug("No more buffers in queue\n");
> > +                     END_USE(vq);
> > +                     return NULL;
> > +             }
> > +
> > +             /* Only get used array entries after they have been
> > +              * exposed by host. */
> > +             virtio_rmb(vq->weak_barriers);
> > +             vq->batch_last.id =3D virtio32_to_cpu(vq->vq.vdev,
> > +                                 vq->split.vring.used->ring[last_used]=
.id);
> > +             vq->batch_last.len =3D virtio32_to_cpu(vq->vq.vdev,
> > +                                  vq->split.vring.used->ring[last_used=
].len);
> > +     }
> > +
> > +     if (vq->batch_last.id =3D=3D last_used) {
> > +             vq->batch_last.id =3D num;
> > +             *len =3D vq->batch_last.len;
> > +     } else
> > +             *len =3D vq->split.desc_state[last_used].total_len;
> > +
> > +     if (unlikely(last_used >=3D num)) {
> > +             BAD_RING(vq, "id %u out of range\n", last_used);
> > +             return NULL;
> > +     }
> > +     if (unlikely(!vq->split.desc_state[last_used].data)) {
> > +             BAD_RING(vq, "id %u is not a head!\n", last_used);
> > +             return NULL;
> > +     }
> > +
> > +     /* detach_buf_split clears data, so grab it now. */
> > +     ret =3D vq->split.desc_state[last_used].data;
> > +     detach_buf_split_in_order(vq, last_used, ctx);
> > +
> > +     vq->last_used_idx++;
> > +     /* If we expect an interrupt for the next entry, tell host
> > +      * by writing event index and flush out the write before
> > +      * the read in the next get_buf call. */
> > +     if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> > +             virtio_store_mb(vq->weak_barriers,
> > +                             &vring_used_event(&vq->split.vring),
> > +                             cpu_to_virtio16(vq->vq.vdev, vq->last_use=
d_idx));
> > +
> > +     LAST_ADD_TIME_INVALID(vq);
> > +
> > +     END_USE(vq);
> > +     return ret;
> > +}
> > +
> >  static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
> >  {
> >       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))=
 {
> > @@ -1008,7 +1112,10 @@ static void *virtqueue_detach_unused_buf_split(s=
truct vring_virtqueue *vq)
> >                       continue;
> >               /* detach_buf_split clears data, so grab it now. */
> >               buf =3D vq->split.desc_state[i].data;
> > -             detach_buf_split(vq, i, NULL);
> > +             if (virtqueue_is_in_order(vq))
> > +                     detach_buf_split_in_order(vq, i, NULL);
> > +             else
> > +                     detach_buf_split(vq, i, NULL);
> >               vq->split.avail_idx_shadow--;
> >               vq->split.vring.avail->idx =3D cpu_to_virtio16(vq->vq.vde=
v,
> >                               vq->split.avail_idx_shadow);
> > @@ -1071,6 +1178,7 @@ static void virtqueue_vring_attach_split(struct v=
ring_virtqueue *vq,
> >
> >       /* Put everything in free lists. */
> >       vq->free_head =3D 0;
> > +     vq->batch_last.id =3D vq->split.vring.num;
> >  }
> >
> >  static int vring_alloc_state_extra_split(struct vring_virtqueue_split =
*vring_split)
> > @@ -1182,7 +1290,6 @@ static struct virtqueue *__vring_new_virtqueue_sp=
lit(unsigned int index,
> >       if (!vq)
> >               return NULL;
> >
> > -     vq->layout =3D SPLIT;
> >       vq->vq.callback =3D callback;
> >       vq->vq.vdev =3D vdev;
> >       vq->vq.name =3D name;
> > @@ -1202,6 +1309,8 @@ static struct virtqueue *__vring_new_virtqueue_sp=
lit(unsigned int index,
> >       vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
> >               !context;
> >       vq->event =3D virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> > +     vq->layout =3D virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
> > +                  SPLIT_IN_ORDER : SPLIT;
> >
> >       if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> >               vq->weak_barriers =3D false;
> > @@ -1359,13 +1468,14 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> >                                        unsigned int in_sgs,
> >                                        void *data,
> >                                        bool premapped,
> > -                                      gfp_t gfp)
> > +                                      gfp_t gfp,
> > +                                      u16 id)
> >  {
> >       struct vring_desc_extra *extra;
> >       struct vring_packed_desc *desc;
> >       struct scatterlist *sg;
> > -     unsigned int i, n, err_idx, len;
> > -     u16 head, id;
> > +     unsigned int i, n, err_idx, len, total_len =3D 0;
> > +     u16 head;
> >       dma_addr_t addr;
> >
> >       head =3D vq->packed.next_avail_idx;
> > @@ -1383,8 +1493,6 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >       }
> >
> >       i =3D 0;
> > -     id =3D vq->free_head;
> > -     BUG_ON(id =3D=3D vq->packed.vring.num);
> >
> >       for (n =3D 0; n < out_sgs + in_sgs; n++) {
> >               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > @@ -1404,6 +1512,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >                               extra[i].flags =3D n < out_sgs ?  0 : VRI=
NG_DESC_F_WRITE;
> >                       }
> >
> > +                     total_len +=3D len;
> >                       i++;
> >               }
> >       }
> > @@ -1457,6 +1566,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >       vq->packed.desc_state[id].data =3D data;
> >       vq->packed.desc_state[id].indir_desc =3D desc;
> >       vq->packed.desc_state[id].last =3D id;
> > +     vq->packed.desc_state[id].total_len =3D total_len;
> >
> >       vq->num_added +=3D 1;
> >
> > @@ -1509,8 +1619,11 @@ static inline int virtqueue_add_packed(struct vr=
ing_virtqueue *vq,
> >       BUG_ON(total_sg =3D=3D 0);
> >
> >       if (virtqueue_use_indirect(vq, total_sg)) {
> > +             id =3D vq->free_head;
> > +             BUG_ON(id =3D=3D vq->packed.vring.num);
> >               err =3D virtqueue_add_indirect_packed(vq, sgs, total_sg, =
out_sgs,
> > -                                                 in_sgs, data, premapp=
ed, gfp);
> > +                                                 in_sgs, data, premapp=
ed,
> > +                                                 gfp, id);
> >               if (err !=3D -ENOMEM) {
> >                       END_USE(vq);
> >                       return err;
> > @@ -1631,6 +1744,152 @@ static inline int virtqueue_add_packed(struct v=
ring_virtqueue *vq,
> >       return -EIO;
> >  }
> >
> > +static inline int virtqueue_add_packed_in_order(struct vring_virtqueue=
 *vq,
> > +                                             struct scatterlist *sgs[]=
,
> > +                                             unsigned int total_sg,
> > +                                             unsigned int out_sgs,
> > +                                             unsigned int in_sgs,
> > +                                             void *data,
> > +                                             void *ctx,
> > +                                             bool premapped,
> > +                                             gfp_t gfp)
> > +{
> > +     struct vring_packed_desc *desc;
> > +     struct scatterlist *sg;
> > +     unsigned int i, n, c, err_idx, total_len =3D 0;
> > +     __le16 head_flags, flags;
> > +     u16 head, avail_used_flags;
> > +     int err;
> > +
> > +     START_USE(vq);
> > +
> > +     BUG_ON(data =3D=3D NULL);
> > +     BUG_ON(ctx && vq->indirect);
> > +
> > +     if (unlikely(vq->broken)) {
> > +             END_USE(vq);
> > +             return -EIO;
> > +     }
> > +
> > +     LAST_ADD_TIME_UPDATE(vq);
> > +
> > +     BUG_ON(total_sg =3D=3D 0);
> > +
> > +     if (virtqueue_use_indirect(vq, total_sg)) {
> > +             err =3D virtqueue_add_indirect_packed(vq, sgs, total_sg, =
out_sgs,
> > +                                                 in_sgs, data, premapp=
ed, gfp,
> > +                                                 vq->packed.next_avail=
_idx);
> > +             if (err !=3D -ENOMEM) {
> > +                     END_USE(vq);
> > +                     return err;
> > +             }
> > +
> > +             /* fall back on direct */
> > +     }
> > +
> > +     head =3D vq->packed.next_avail_idx;
> > +     avail_used_flags =3D vq->packed.avail_used_flags;
> > +
> > +     WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
> > +
> > +     desc =3D vq->packed.vring.desc;
> > +     i =3D head;
> > +
> > +     if (unlikely(vq->vq.num_free < total_sg)) {
> > +             pr_debug("Can't add buf len %i - avail =3D %i\n",
> > +                      total_sg, vq->vq.num_free);
> > +             END_USE(vq);
> > +             return -ENOSPC;
> > +     }
> > +
> > +     c =3D 0;
> > +     for (n =3D 0; n < out_sgs + in_sgs; n++) {
> > +             for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> > +                     dma_addr_t addr;
> > +                     u32 len;
> > +
> > +                     if (vring_map_one_sg(vq, sg, n < out_sgs ?
> > +                                          DMA_TO_DEVICE : DMA_FROM_DEV=
ICE,
> > +                                          &addr, &len, premapped))
> > +                             goto unmap_release;
> > +
> > +                     flags =3D cpu_to_le16(vq->packed.avail_used_flags=
 |
> > +                                 (++c =3D=3D total_sg ? 0 : VRING_DESC=
_F_NEXT) |
> > +                                 (n < out_sgs ? 0 : VRING_DESC_F_WRITE=
));
> > +                     if (i =3D=3D head)
> > +                             head_flags =3D flags;
> > +                     else
> > +                             desc[i].flags =3D flags;
> > +
> > +
> > +                     desc[i].addr =3D cpu_to_le64(addr);
> > +                     desc[i].len =3D cpu_to_le32(len);
> > +                     desc[i].id =3D cpu_to_le16(head);
> > +
> > +                     if (unlikely(vq->use_map_api)) {
> > +                             vq->packed.desc_extra[i].addr =3D premapp=
ed ?
> > +                                   DMA_MAPPING_ERROR: addr;
> > +                             vq->packed.desc_extra[i].len =3D len;
> > +                             vq->packed.desc_extra[i].flags =3D
> > +                                     le16_to_cpu(flags);
> > +                     }
> > +
> > +                     if ((unlikely(++i >=3D vq->packed.vring.num))) {
> > +                             i =3D 0;
> > +                             vq->packed.avail_used_flags ^=3D
> > +                                     1 << VRING_PACKED_DESC_F_AVAIL |
> > +                                     1 << VRING_PACKED_DESC_F_USED;
> > +                             vq->packed.avail_wrap_counter ^=3D 1;
> > +                     }
> > +
> > +                     total_len +=3D len;
> > +             }
> > +     }
> > +
> > +     /* We're using some buffers from the free list. */
> > +     vq->vq.num_free -=3D total_sg;
> > +
> > +     /* Update free pointer */
> > +     vq->packed.next_avail_idx =3D i;
> > +
> > +     /* Store token. */
> > +     vq->packed.desc_state[head].num =3D total_sg;
> > +     vq->packed.desc_state[head].data =3D data;
> > +     vq->packed.desc_state[head].indir_desc =3D ctx;
> > +     vq->packed.desc_state[head].total_len =3D total_len;
> > +
> > +     /*
> > +      * A driver MUST NOT make the first descriptor in the list
> > +      * available before all subsequent descriptors comprising
> > +      * the list are made available.
> > +      */
> > +     virtio_wmb(vq->weak_barriers);
> > +     vq->packed.vring.desc[head].flags =3D head_flags;
> > +     vq->num_added +=3D total_sg;
> > +
> > +     pr_debug("Added buffer head %i to %p\n", head, vq);
> > +     END_USE(vq);
> > +
> > +     return 0;
> > +
> > +unmap_release:
> > +     err_idx =3D i;
> > +     i =3D head;
> > +     vq->packed.avail_used_flags =3D avail_used_flags;
> > +
> > +     for (n =3D 0; n < total_sg; n++) {
> > +             if (i =3D=3D err_idx)
> > +                     break;
> > +             vring_unmap_extra_packed(vq, &vq->packed.desc_extra[i]);
> > +             i++;
> > +             if (i >=3D vq->packed.vring.num)
> > +                     i =3D 0;
> > +     }
> > +
> > +     END_USE(vq);
> > +     return -EIO;
> > +}
> > +
> >  static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
> >  {
> >       u16 new, old, off_wrap, flags, wrap_counter, event_idx;
> > @@ -1791,10 +2050,81 @@ static void update_last_used_idx_packed(struct =
vring_virtqueue *vq,
> >                               cpu_to_le16(vq->last_used_idx));
> >  }
> >
> > +static bool more_used_packed_in_order(const struct vring_virtqueue *vq=
)
> > +{
> > +     if (vq->batch_last.id !=3D vq->packed.vring.num)
> > +             return true;
> > +
> > +     return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
> > +}
> > +
> > +static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqu=
eue *vq,
> > +                                                unsigned int *len,
> > +                                                void **ctx)
> > +{
> > +     unsigned int num =3D vq->packed.vring.num;
> > +     u16 last_used, last_used_idx;
> > +     bool used_wrap_counter;
> > +     void *ret;
> > +
> > +     START_USE(vq);
> > +
> > +     if (unlikely(vq->broken)) {
> > +             END_USE(vq);
> > +             return NULL;
> > +     }
> > +
> > +     last_used_idx =3D vq->last_used_idx;
> > +     used_wrap_counter =3D packed_used_wrap_counter(last_used_idx);
> > +     last_used =3D packed_last_used(last_used_idx);
> > +
> > +     if (vq->batch_last.id =3D=3D num) {
> > +             if (!more_used_packed(vq)) {
> > +                     pr_debug("No more buffers in queue\n");
> > +                     END_USE(vq);
> > +                     return NULL;
> > +             }
> > +             /* Only get used elements after they have been exposed by=
 host. */
> > +             virtio_rmb(vq->weak_barriers);
> > +             vq->batch_last.id =3D
> > +                     le16_to_cpu(vq->packed.vring.desc[last_used].id);
> > +             vq->batch_last.len =3D
> > +                     le32_to_cpu(vq->packed.vring.desc[last_used].len)=
;
> > +     }
> > +
> > +     if (vq->batch_last.id =3D=3D last_used) {
> > +             vq->batch_last.id =3D num;
> > +             *len =3D vq->batch_last.len;
> > +     } else
> > +             *len =3D vq->packed.desc_state[last_used].total_len;
> > +
> > +     if (unlikely(last_used >=3D num)) {
> > +             BAD_RING(vq, "id %u out of range\n", last_used);
> > +             return NULL;
> > +     }
> > +     if (unlikely(!vq->packed.desc_state[last_used].data)) {
> > +             BAD_RING(vq, "id %u is not a head!\n", last_used);
> > +             return NULL;
> > +     }
> > +
> > +     /* detach_buf_packed clears data, so grab it now. */
> > +     ret =3D vq->packed.desc_state[last_used].data;
> > +     detach_buf_packed_in_order(vq, last_used, ctx);
> > +
> > +     update_last_used_idx_packed(vq, last_used, last_used,
> > +                                 used_wrap_counter);
> > +
> > +     LAST_ADD_TIME_INVALID(vq);
> > +
> > +     END_USE(vq);
> > +     return ret;
> > +}
> > +
> >  static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
> >                                         unsigned int *len,
> >                                         void **ctx)
> >  {
> > +     unsigned int num =3D vq->packed.vring.num;
> >       u16 last_used, id, last_used_idx;
> >       bool used_wrap_counter;
> >       void *ret;
> > @@ -1821,7 +2151,7 @@ static void *virtqueue_get_buf_ctx_packed(struct =
vring_virtqueue *vq,
> >       id =3D le16_to_cpu(vq->packed.vring.desc[last_used].id);
> >       *len =3D le32_to_cpu(vq->packed.vring.desc[last_used].len);
> >
> > -     if (unlikely(id >=3D vq->packed.vring.num)) {
> > +     if (unlikely(id >=3D num)) {
> >               BAD_RING(vq, "id %u out of range\n", id);
> >               return NULL;
> >       }
> > @@ -1962,7 +2292,7 @@ static void *virtqueue_detach_unused_buf_packed(s=
truct vring_virtqueue *vq)
> >                       continue;
> >               /* detach_buf clears data, so grab it now. */
> >               buf =3D vq->packed.desc_state[i].data;
> > -             detach_buf_packed(vq, i, NULL);
> > +             detach_buf_packed_in_order(vq, i, NULL);
>
> Wait why is this in order unconditionally?

This is a bug, let me fix it.

Thanks


