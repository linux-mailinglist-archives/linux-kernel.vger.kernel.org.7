Return-Path: <linux-kernel+bounces-826486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55BB8EA54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B93BDB9A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D657770824;
	Mon, 22 Sep 2025 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Na0eLgJq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8593207
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502864; cv=none; b=ClgXdMiKuWKnq1fPQ7LqUwHLukcxpabMUBJ0k62fFSDYtXWh3F/FxNWy3tGSemVBAAfbbL3BNsDcwwB7LkAI2BofS+PaCwAMP9/lKn3nfEUKUtOgX/9NiHJJmnCg5N/ukz3oOfXVgcpCioppASBYwSL9rEXfdefRwQJzVj9eXwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502864; c=relaxed/simple;
	bh=mAJwI4282ZDPMPK+aaLEUg17n0kAO3+PXNVRWl5r/aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWk+ceygdDbUqksmp1uX+oKYt3prVvKnZ4wKmeA5bRJlgWTJ6KrepmnYksPaj+vpJ9GA4jEmpZaTXdnfkLvep9QSwqPUAJ90jLeEyrZeclSzyN+b8FZPLNTzy5hGy+3i4YDPNUMtJ3JQyHBNzD3Jqj7AmW+kg1aLiFDTg+jczAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Na0eLgJq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKfB0/QKjYa5EHj4yXuFIM6ZFlGsSX0BgKB57pXFWGA=;
	b=Na0eLgJq3uxrk4jTeTGiCI2dzCm+VGtY8gzrbKXtEtJiSHGcDljvYxarBjDD16e0D8wlEC
	VbvJMnGAHxBcKZnEgPgE+1K8mQIPME77dOyUZTKzb5x7q4gxDn+u4xy0exgyFqcxHAXR2c
	mAEOMH+sTmxtlZtIznHzO4g8Cj+cTeU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-DJARooc5MQCODlGBS5Q1bw-1; Sun, 21 Sep 2025 21:00:59 -0400
X-MC-Unique: DJARooc5MQCODlGBS5Q1bw-1
X-Mimecast-MFC-AGG-ID: DJARooc5MQCODlGBS5Q1bw_1758502858
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32e8c800a79so5126505a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502858; x=1759107658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKfB0/QKjYa5EHj4yXuFIM6ZFlGsSX0BgKB57pXFWGA=;
        b=AnTPtOr9tzhfd8OVvL5QmlF+TxWs9OLglSQ5q+DTCyibe+Z9ZiKF0r8xZ+VIU49TcV
         Ti5YB4eD7XwS9/wPpNxCQ/rDZkjmbWM7/ilYucMO/m+l6mGmBs8FJhy1WRCqzBSMdlrY
         RrQdRoXEgXF24KeiNjkDIQQrwpqxvPj8V/ZSWqtqZvqe5CkGGktrOqFjeJMI8flDt6Th
         b9dxOcuoYVaQmt3wWWGR6ouXOF9m1/0IAM0wds3NFybxzGrRx1OLo7awr2eUghnFC1xi
         JQYM2gMzWbZv/nS2QoT6FiGEx+g91BV0qAnkvq4ypXwjYyPARHs1rKYOevpMTymUopXN
         Wb5g==
X-Forwarded-Encrypted: i=1; AJvYcCWKTiUxP3/1zjs4tE9qUc5zDaIqwp2u0kVJxoktcoEU8ZMaC6v7k+9CPI/EjoqJe/Z2BRnppB+uByU3Kfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQ3vvhF4L38P10kfUlnwgbQfZBrgxvcIn80pImKNgpBibA8IM
	9oT8IQ0XhbfyhZX+XbS++Vszll74w63hcIonSKlcB22qrXMnVQkCGWB4oni7Pdx4zDb+yxdvrK3
	4WPATZBRCC8iV/heOuEf4Dt3wY1IXDDBmoKKBr+KEZC6NMSuMaeoBJMcyTeeeQqP6nAj64kPePn
	/8CZYbKp4w2q41eI6hynuEfRWucKDNtpBsLzOfIRwfyel0s4BDKQY=
X-Gm-Gg: ASbGncvFG/vs/A6vhQPF148iyiTscZTAsgphR61C9DWuWbUzC6R8c3FzpXgjBtv2SW0
	dsqna7hoE3K2utI0yUoxGzaAlq8hTKjYjCEGTXct5IpYl9ej1lRSpQZKywi/JZ3oQ2AmR7mcFTA
	gMsHpizBvJ4dZ1NUgfdg8jDA==
X-Received: by 2002:a17:90b:3a48:b0:32e:a650:3ed5 with SMTP id 98e67ed59e1d1-330983817aemr12058380a91.31.1758502858148;
        Sun, 21 Sep 2025 18:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLZz+Qc8bnkgDeBSLJdsDeUY71+Q67GmWu7okPrXkBs2XjlOs5L4tIZeAfED1wye0qrXWSxp6okx514jPYN/8=
X-Received: by 2002:a17:90b:3a48:b0:32e:a650:3ed5 with SMTP id
 98e67ed59e1d1-330983817aemr12058335a91.31.1758502857615; Sun, 21 Sep 2025
 18:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-14-jasowang@redhat.com>
 <20250921143217-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921143217-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 09:00:45 +0800
X-Gm-Features: AS18NWAcZG3mF30zT9ro015BT23AMPKeqQ63N5iOYfT0LpuxO_G50-YKXCOjPgA
Message-ID: <CACGkMEtfDr7v2HECZMSSrR97eZjwbT_wTuDtcX312ObqgE=Jhg@mail.gmail.com>
Subject: Re: [PATCH V6 13/19] virtio_ring: introduce virtqueue ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:48PM +0800, Jason Wang wrote:
> > This patch introduces virtqueue ops which is a set of the callbacks
> > that will be called for different queue layout or features. This would
> > help to avoid branches for split/packed and will ease the future
> > implementation like in order.
> >
> > Note that in order to eliminate the indirect calls this patch uses
> > global array of const ops to allow compiler to avoid indirect
> > branches.
> >
> > Tested with CONFIG_MITIGATION_RETPOLINE, no performance differences
> > were noticed.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 173 ++++++++++++++++++++++++++---------
> >  1 file changed, 130 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index b1b6af297061..1045c553ee65 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -67,6 +67,12 @@
> >  #define LAST_ADD_TIME_INVALID(vq)
> >  #endif
> >
> > +enum vq_layout {
> > +     SPLIT =3D 0,
> > +     PACKED,
> > +     VQ_TYPE_MAX,
> > +};
> > +
> >  struct vring_desc_state_split {
> >       void *data;                     /* Data for callback. */
> >
> > @@ -159,12 +165,28 @@ struct vring_virtqueue_packed {
> >       size_t event_size_in_bytes;
> >  };
> >
> > +struct vring_virtqueue;
> > +
> > +struct virtqueue_ops {
> > +     int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[]=
,
> > +                unsigned int total_sg, unsigned int out_sgs,
> > +                unsigned int in_sgs, void *data,
> > +                void *ctx, bool premapped, gfp_t gfp);
>
> Why is it _vq here?

Fixed.

>
>
> > +     void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void =
**ctx);
> > +     bool (*kick_prepare)(struct vring_virtqueue *vq);
> > +     void (*disable_cb)(struct vring_virtqueue *vq);
> > +     bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> > +     unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
> > +     bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx)=
;
> > +     void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> > +     bool (*more_used)(const struct vring_virtqueue *vq);
> > +     int (*resize)(struct vring_virtqueue *vq, u32 num);
> > +     void (*reset)(struct vring_virtqueue *vq);
> > +};
> > +
> >  struct vring_virtqueue {
> >       struct virtqueue vq;
> >
> > -     /* Is this a packed ring? */
> > -     bool packed_ring;
> > -
> >       /* Is DMA API used? */
> >       bool use_map_api;
> >
> > @@ -180,6 +202,8 @@ struct vring_virtqueue {
> >       /* Host publishes avail event idx */
> >       bool event;
> >
> > +     enum vq_layout layout;
> > +
> >       /* Head of free buffer list. */
> >       unsigned int free_head;
> >       /* Number we've added since last sync. */
> > @@ -231,6 +255,12 @@ static void vring_free(struct virtqueue *_vq);
> >
> >  #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq=
)
> >
> > +
>
> why the extra empty line?
>

And fix this.

Thanks


