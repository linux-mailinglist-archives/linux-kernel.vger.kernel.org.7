Return-Path: <linux-kernel+bounces-864176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5C7BFA19F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AED400C86
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0342ECD0F;
	Wed, 22 Oct 2025 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OY4d43Ge"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301FE20D4E9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111944; cv=none; b=M6/1OUfh5jFTBE0bAB0YQBxXExwATRr1p11GvKS1k0HFGwO5SPc/vKozcGhbZVrLquz1Vix/kLQfK28aX6Hnvh1tPr7R5kNGxTVpmNALK09wU9kjIEleNnUSqAnDcTEAn/dPzvL7pDiLQfHq3IyombfaF/YJsBgdywPJB2Tq8Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111944; c=relaxed/simple;
	bh=OOEDwYf/WoldymVHE1bARmPBao5IcHvki7sxdMEqYj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snaCcgepi7p4RayMqqxMxhjKcSj8gjjnBO4QK9g8x4xC+0t9k9z+DSLk/s6QKBv+yqtYveXXdyZ3AwOjlBeI+Xzpeiq90zfyC3zE11mK0tBfw6nGSNqtoxPGsclO45YBfkTNbgtXTU3g/CSsgOtyj9eibM2I4WdknvtusGYcbSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OY4d43Ge; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761111941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gdOCtyqfpPDKTOSjwLO+fIICNulbuVoEvWA7TNWh1Q=;
	b=OY4d43GeZy8RoHxJ98+KEGoz+NMxMwsdR92GCbAJVByzmDCfeiLyviRx/XZCGk6hQDaIKY
	vPyTcSEA3u1T6cgkHoKKNZfCMEsVQyfimzXVtfk15B+mwMLN3pMuqZYFHTEHGTl5GJRUJM
	2oGnjSqL6K2vZFOrpAz6j5Mt6+eGM88=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-X_IDuKiSPxyQ5EPKpj1sWg-1; Wed, 22 Oct 2025 01:45:40 -0400
X-MC-Unique: X_IDuKiSPxyQ5EPKpj1sWg-1
X-Mimecast-MFC-AGG-ID: X_IDuKiSPxyQ5EPKpj1sWg_1761111939
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471168953bdso4114295e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111939; x=1761716739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gdOCtyqfpPDKTOSjwLO+fIICNulbuVoEvWA7TNWh1Q=;
        b=OuqHt1hULNIK7tKgEqtyKUP8IyJUxsmqvoi28suLb7fDehgi/wcxb/pwdbqnyCe0Wo
         sG79uuwRPHHrgOwi2BMVdDwDV62gLestkPnQ4IINdfnrbpD1THquDileTErAzkVrfVVk
         xlBeKCGG/Ndm7PVPSioH6+0kfnYWx51HTee9LKB+FsCJ8xdNtxAUe2988PnxczqDrK17
         5vO5yFYZ8KFMWbQ07LbBb21y3xcd8nupytX5vy83JXxkLr+3a1sGEWSplrVjS7WO7hDY
         yV/ooe3rBW1SdP+aIuuXqvSY0a7z1t9cxaKJHXEqePdN47AB+z0JjxoIYdBxSsUf9R9m
         6EoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp0wfolkOTn6qXsgB+bR4O3Udy7fxH3OFc4MhkTl07wA1mwxDSilM5DuqZACsDhOZaIP0e/lAUhZk5Cos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/vXgPX0H71rBRbb6H7F85IqrbeuNdkun4NVUT2qOK9oinyGE
	1QRoKWaTk+XLLSAdV1nCV4YewE+4XeBFJ0tIfWEB2T+pg2rnAoHr8K+zjrUHwIoD8UIAMN7TIJZ
	IXgKlDMpYeU06USS4eI7og3n8ZA4NX0O9Hr3mNvOff0pjiiN+UaIUJdXsefkv/f1Z1w==
X-Gm-Gg: ASbGnctB9WFE1+HRrFsm/CkMX26eu7W1zKXeCsafWRhNawVIliQVISzy1FF455361BJ
	1Tj0lriXmIb6mNEcM8IBthPAcdFX5rGOOQPKL0g5FdwA7Owwu5gsT1BP1+0K4f2zVxPi5sG39QS
	pHrSDSbZF8Of+OOsVvKJqqk06ONvysJrh+3FgsHbb07GZl1M+SPKrkvpveawhyBwNOo7ZkaMd6s
	9nVXAvs2fNg+8IApCJSsy4nu08psMzSPNJ8b7RV15rgOKbvCAll7oGqR9+uSkD+ZemqY+cGHLwU
	JdNXHiGjmOCRE/s7LWtD3qtf01OD2ZmnfqpfoNoqS99fXPcvQG8D9nGN5420Dvb/kaQN
X-Received: by 2002:a05:600c:6992:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-475c3fa355cmr13586805e9.6.1761111939131;
        Tue, 21 Oct 2025 22:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElHGkXoX3hCkc0GRrDbDcYpbH4YLBEG6cIW8mw2RcnC42OK12DSE/fMXDY2iXzD02ahYxuXQ==
X-Received: by 2002:a05:600c:6992:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-475c3fa355cmr13586695e9.6.1761111938746;
        Tue, 21 Oct 2025 22:45:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ab11bbsm30712795e9.1.2025.10.21.22.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:45:38 -0700 (PDT)
Date: Wed, 22 Oct 2025 01:45:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cong Zhang <cong.zhang@oss.qualcomm.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed
 resume
Message-ID: <20251022014453-mutt-send-email-mst@kernel.org>
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
 <20251021085030-mutt-send-email-mst@kernel.org>
 <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>

On Wed, Oct 22, 2025 at 12:19:19PM +0800, Jason Wang wrote:
> On Tue, Oct 21, 2025 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> > > The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> > > is allocated, later freeze/remove may attempt to free vqs again.
> > > Set vblk->vqs to NULL after freeing to avoid double free.
> > >
> > > Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> > > ---
> > > The patch fixes a double free issue that occurs in virtio_blk during
> > > freeze/resume.
> > > The issue is caused by:
> > > 1. During the first freeze, vblk->vqs is freed but pointer is not set to
> > >    NULL.
> > > 2. Virtio block device fails before vblk->vqs is allocated during resume.
> > > 3. During the next freeze, vblk->vqs gets freed again, causing the
> > >    double free crash.
> >
> > this part I don't get. if restore fails, how can freeze be called
> > again?
> 
> For example, could it be triggered by the user?
> 
> Thanks

I don't know - were you able to trigger it? how?


> >
> > > ---
> > >  drivers/block/virtio_blk.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
> > >  out:
> > >       kfree(vqs);
> > >       kfree(vqs_info);
> > > -     if (err)
> > > +     if (err) {
> > >               kfree(vblk->vqs);
> > > +             /*
> > > +              * Set to NULL to prevent freeing vqs again during freezing.
> > > +              */
> > > +             vblk->vqs = NULL;
> > > +     }
> > >       return err;
> > >  }
> > >
> >
> > > @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
> > >
> > >       vdev->config->del_vqs(vdev);
> > >       kfree(vblk->vqs);
> > > +     /*
> > > +      * Set to NULL to prevent freeing vqs again after a failed vqs
> > > +      * allocation during resume. Note that kfree() already handles NULL
> > > +      * pointers safely.
> > > +      */
> > > +     vblk->vqs = NULL;
> > >
> > >       return 0;
> > >  }
> > >
> > > ---
> > > base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> > > change-id: 20250926-virtio_double_free-7ab880d82a17
> > >
> > > Best regards,
> > > --
> > > Cong Zhang <cong.zhang@oss.qualcomm.com>
> >


