Return-Path: <linux-kernel+bounces-862139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A01BBF4838
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D00034F3F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC9A20B80D;
	Tue, 21 Oct 2025 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBB2MbBN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F51448E0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017790; cv=none; b=LfvYNaiTKKm6rbeQyV8iZuwMDNM8vyfVnL7hYcEga0jiGq5FtzmxeRqM0U42NEaE/OGKN3Svakevwwv1oMfxqm5XVQX3HXu9HqpcZNW+cGU0BCa4S/G+0zXOpyt6hLikHZziETSt7T4KSOB3qyy0455K3TKPtu698FKH5zlbfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017790; c=relaxed/simple;
	bh=KARzJmw0IGuWzPo8hIPKqlcttmgHPmhddQ93IyM/uN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tl24f28YFqoH0lSfceWGVEo5IM8FeGgFePIxrGm6KrYOyaRTnW7GhQsvglA6dGwb1ivZPK8HU5oLSK8LPF1zxDFmX4Xqd+Worby4ge4NaxGAjrrbP66Iq1YWY6Yy9FsLZejFjg5km9+woA1vsmGWVR+a6I6F+l5OhnLBtytGWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBB2MbBN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761017787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYcSSFbr7f+P4ic+LlVnNjiunvRAoAHvjqnEje36UNU=;
	b=JBB2MbBNneRxVRImBZPsrdPWsAGiZ1M2gbHkjuv5My9cRyBguzVpWYoMIk/0imOxDlYWau
	AqAKwO/jInRAumbsMryB5ZyQ0o5cvE4ZrBID+5luSQR+hDP0FypFBMhcPB/RpBcbLIb5Ge
	Su/pn20j2ThVIh6PNqDBNflse1p1sPE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-9UuShY9YPrqtFdmeyTW0JA-1; Mon, 20 Oct 2025 23:36:25 -0400
X-MC-Unique: 9UuShY9YPrqtFdmeyTW0JA-1
X-Mimecast-MFC-AGG-ID: 9UuShY9YPrqtFdmeyTW0JA_1761017785
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6fbaso66647585ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761017784; x=1761622584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYcSSFbr7f+P4ic+LlVnNjiunvRAoAHvjqnEje36UNU=;
        b=Km/KnBjM9njSGL9fkuc70keAmTsEZnUK/vd4so2kV1SrhtoKpOJ2S7XW9FsVNhNs23
         xnaJ5vccQh4l1mHHMGFI0Dqv5H4qeQfLcJCovO9T3IkV8BQvJljtaRh9W1XDu1cBJaSV
         cueNM5QlzVyZfPoogTzLM8J6CWJeui0/SqCYYlSTavWIzpWbPkkAuNtoahREB9lHFkjp
         KqCkDM0+vzyXsc+WcHYLdOYlowtctRURpYxmEYSHBKf4KtOESymufN3QIZ+CvBwOpkWe
         jVOjTxxIQQ7nAmvt+kbyABlSAkrpx40MFEHrXjglJdBrGy7SQS70yChzNMV4A0ga5bD0
         D6cg==
X-Forwarded-Encrypted: i=1; AJvYcCUmqBMXXvkEBZauy1OyULKDStfEBx+PtY5/VS6z75suyq9OvlV19j/jgXtoCogC8VWsGPMHRpXmdrBU0dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQfQBB8XYL6sA0ERRdBnpR8VEwy2TU415aHaaYWbWte8Tcwbi
	0f7fTTgew6eT61mvvUjORNYvMACHSQh2AjMyh6/Qqu8DLLTlKVZWnHYUKN/y/1mCOStg/unqBv9
	3yEMLekHzaeWKJA5j3+WDTJ6paAq+N9t5piUXPhsYhaCMxNCbOzoaHUge3RqAVl0CnYEDyYsLuV
	uugauapFFan93G563SJYqPgIkkSPE0+9c3qC+RZt69
X-Gm-Gg: ASbGncsldB49p0cF7AH3M9NK8ItdfnQOe8bEbXwygJnPMxOT/R26FrLOV48B8k2TbN9
	4PRz5shB9hJznJcVT6oCWBEmicMiXzsfuqUMTi0WP/Fa1IboUerKvTQn9ZlG2jyoAxZBwT8sgQF
	hdKU8J9nOdcBz/8pkNV3GdanlTxMgoiFvXj5jdAVIs5x9TKfhm8GEiNpn/
X-Received: by 2002:a17:903:230a:b0:27e:f018:d2fb with SMTP id d9443c01a7336-290c9cf37d3mr180562565ad.6.1761017784669;
        Mon, 20 Oct 2025 20:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnIECeEdtsIf+Sgiji3j5dUiEtg4R2S0qf/lDOwtGAJI45rkS3iRSDJoNiLAbeEZ0BroefnaRrHaukACvEvm0=
X-Received: by 2002:a17:903:230a:b0:27e:f018:d2fb with SMTP id
 d9443c01a7336-290c9cf37d3mr180562315ad.6.1761017784259; Mon, 20 Oct 2025
 20:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-19-jasowang@redhat.com>
 <20251020111413-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020111413-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:36:12 +0800
X-Gm-Features: AS18NWCvWFEXQm4CJsrSie7GqZjQ5OFo_ZDtZeYcavpQ1UuuKcolFSbgF2tcggk
Message-ID: <CACGkMEsRmkaBiU2WCQTepayhrhR18M1+bDQJXxTVxOUDG4sZyg@mail.gmail.com>
Subject: Re: [PATCH V8 18/19] virtio_ring: factor out split detaching logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Oct 20, 2025 at 03:10:02PM +0800, Jason Wang wrote:
> > This patch factors out the split core detaching logic that could be
> > reused by in order feature into a dedicated function.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 0f07a6637acb..96d7f165ec88 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -802,8 +802,9 @@ static void detach_indirect_split(struct vring_virt=
queue *vq,
> >       vq->split.desc_state[head].indir_desc =3D NULL;
> >  }
> >
> > -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int =
head,
> > -                          void **ctx)
> > +static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
> > +                                       unsigned int head,
> > +                                       void **ctx)
>
>
> Well not really _inorder, right? This is a common function.

Yes, but inorder is a subset for ooo so I use this name.

> You want to call it __detach_buf_split or something maybe.
>
> Additionally the very first line in there is:
>
>         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F=
_NEXT);
>
> and the byte swap is not needed for inorder.

I don't see why?

> you could just do __cpu_to_virtio16(true, VRING_DESC_F_NEXT)

Probably you mean a leftover for hardening? E.g should we check
desc_extra.flag instead of desc.flag here?

while (vq->split.vring.desc[i].flags & nextflag) {
                vring_unmap_one_split(vq, &extra[i]);
        i =3D vq->split.desc_extra[i].next;
                vq->vq.num_free++;
        }

Thanks


