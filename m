Return-Path: <linux-kernel+bounces-826477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84859B8EA18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDCA1715C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6E25776;
	Mon, 22 Sep 2025 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq7rwbjO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC879CD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502032; cv=none; b=IA613qiCyyNX6ZNzlb+SopyA9nOIfTeXxE/AN0bLaBqUApBndKm09o7jqi/HQn9X0dl6JbzOxzmVZHAZjb0hqgByfpC6ABeQ1Z7H+0tclO2CofSG5sxogb0F5qFpAgxpqT631+SCdqdYkvoG6C/qlJrB7SgwLVaNrCC09FC49Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502032; c=relaxed/simple;
	bh=9Ki4boBBFSTOm6bTDAVCg7R7ZncOaE6Xsh/zpAUfEjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/a9wfITpBqnJCwWpt+aN8kN5Xrn4nh2zvnDaZC4N+IC6qAfBbCJ0O+oA+oGrLU+qmqfAyPRFw2AnEYcLIiUN3AxvcFJBh7N53si4l5SpReVEfdUvSCcxd2YNz1zSdyUkGYTiWxzxKR+P+LqTqtRXZxL2rwupCizafgRUJCUiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xq7rwbjO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KySsdtQdiuNJp3kMt+bHY2mjpu7nVhM7jiH9jFwsa8g=;
	b=Xq7rwbjOe0Hzycoavpluvgw+lK/Sg9VPNm/gtOExFNvPvBYU9GhhfUDgwgdFIzMpS49px8
	qzs692Nkwv2tDc0hUFTI1atqBk0j+zxIq4BKyLDadrIVWlYhu0Qav7GOlzZc5ffNk+UjE+
	iiFuNbbQEa3zaDrE5Pa61Pu1eEBt3tI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-hVzaUlJPM8-hhqr8Iwjg_g-1; Sun, 21 Sep 2025 20:47:07 -0400
X-MC-Unique: hVzaUlJPM8-hhqr8Iwjg_g-1
X-Mimecast-MFC-AGG-ID: hVzaUlJPM8-hhqr8Iwjg_g_1758502027
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6fbaso4019565ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502027; x=1759106827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KySsdtQdiuNJp3kMt+bHY2mjpu7nVhM7jiH9jFwsa8g=;
        b=wNsxvWX7a8x60hruCNHs58sfthaTOBtHFxNPYdm8gp68bN9lSQZRz0pq2d8+qUy8P4
         CgMxuIvbIywd+ZtBkdgGFsBLAtS+ehMm97xCYwcbqGIxzA2Hyl5483+/r4syBIrRz4PY
         hlDMLUVndsq+mplAR5FjPTBcRcj6SiIFkUZCgzHVsxDyN520FhzoFxEnFS05NH6VN8/a
         WkgyEIXzvXIcWh476OKPqOJDOaKKiRTCV0T9xPusFQOn/z8ngd7QoNspD6itbY/NzuKr
         pvuMYljHo3BtSKl1Z3A2gpatiNASPoQ8aaZApHQqpUoUlRVfByRBimqgMhy7+LV+GeF+
         W9Og==
X-Forwarded-Encrypted: i=1; AJvYcCX8OLxJCBcPX0Jy4d2YV0jnfdJ/qcsKIm3KBNQDdo9mhtTxxE1ZXKm5rvhfHlXsTiWLN4nACNCPc4xdHAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJqFq/3iGdbhllxR9v6k/R4sxdo4wdvy5ivRuvAGDIBqo2xGx
	X/nwXGQEBwoSiAcfISWGTrOLmrbOVydbEeGkKNi2kkLBW2ztsLf7eP7eDl7t+24rpWTKR6x/NHg
	1nkPbsiDlu4dPpmHhnx7gSFoN0duXdQXUL4rQQRf4pJ9towMboFVHxexXzXwmserbWldHUmSKvI
	GEkFouuC3KwuKT9U5sBLGNtqMtecSaB8kNqh+Gn3+z
X-Gm-Gg: ASbGncs0WZo1sXcG3MGK1pH+5V+Wg1uy5t8rvajE/TBrDoZ5dP2acSwRr0MJdVHWLWL
	7+vyPDTLS3gDugCQkbsdTQKg7WspK2u5MM65sYOitOLO97G6VWOSy8QbYCJlU+HXcQKf2M3w/a+
	f0HhFGDKgHTvcnoDFVu6gJqQ==
X-Received: by 2002:a17:902:e790:b0:269:b466:8d46 with SMTP id d9443c01a7336-269ba4b0d19mr142092275ad.27.1758502026775;
        Sun, 21 Sep 2025 17:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx03rywSBBNlmUq18hE46ivk2F2LHYtObQ3Pr0Au/MMmMga+vs6uREz+IlhTQ8NjggT0qss6QVDOyOA8Q6ENA=
X-Received: by 2002:a17:902:e790:b0:269:b466:8d46 with SMTP id
 d9443c01a7336-269ba4b0d19mr142092075ad.27.1758502026433; Sun, 21 Sep 2025
 17:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-16-jasowang@redhat.com>
 <20250921134159-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921134159-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:46:54 +0800
X-Gm-Features: AS18NWA8g4bWALv8lBfETe3esqYxg2UugsUhThrcHNsEaChQ7W6Vcol-vylUH1c
Message-ID: <CACGkMEsFrSH=LC4AFKcxCaxXArdtJtyaCQBko_vieT1VAscRHQ@mail.gmail.com>
Subject: Re: [PATCH V6 15/19] virtio_ring: factor out core logic of buffer detaching
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:42=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:50PM +0800, Jason Wang wrote:
> > Factor out core logic of buffer detaching and leave the id population
> > to the caller so in order can just call the core logic.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 0949675a3d12..a83d08070e8a 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1662,8 +1662,8 @@ static bool virtqueue_kick_prepare_packed(struct =
vring_virtqueue *vq)
> >       return needs_kick;
> >  }
> >
> > -static void detach_buf_packed(struct vring_virtqueue *vq,
> > -                           unsigned int id, void **ctx)
> > +static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
> > +                                    unsigned int id, void **ctx)
> >  {
> >       struct vring_desc_state_packed *state =3D NULL;
> >       struct vring_packed_desc *desc;
> > @@ -1674,8 +1674,6 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
> >       /* Clear data ptr. */
> >       state->data =3D NULL;
> >
> > -     vq->packed.desc_extra[state->last].next =3D vq->free_head;
> > -     vq->free_head =3D id;
> >       vq->vq.num_free +=3D state->num;
> >
> >       if (unlikely(vq->use_map_api)) {
> > @@ -1712,6 +1710,17 @@ static void detach_buf_packed(struct vring_virtq=
ueue *vq,
> >       }
> >  }
> >
> > +static void detach_buf_packed(struct vring_virtqueue *vq,
> > +                           unsigned int id, void **ctx)
> > +{
> > +     struct vring_desc_state_packed *state =3D &vq->packed.desc_state[=
id];
> > +
> > +     vq->packed.desc_extra[state->last].next =3D vq->free_head;
> > +     vq->free_head =3D id;
> > +
> > +     return detach_buf_packed_in_order(vq, id, ctx);
> > +}
> > +
>
> Wait what? return in a void function?
> How does this compile?

It looks like it passes the compiling since detach_buf_packed_in_order
returns void as well :(

> I'm guessing it's tweaked by a follow
> up patch?

Nope. Let me drop the return here.

Thanks

>
>
> >  static inline bool is_used_desc_packed(const struct vring_virtqueue *v=
q,
> >                                      u16 idx, bool used_wrap_counter)
> >  {
> > --
> > 2.31.1
>


