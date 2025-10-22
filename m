Return-Path: <linux-kernel+bounces-864291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4FCBFA6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D143F505FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD462F49E0;
	Wed, 22 Oct 2025 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJ7Up6Xv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FB2F39CF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116478; cv=none; b=OuWy0VVGEZgp2n418R8bMggMB+G6W+qcebR4E7IH12jhTuMI6an449XtHCKidd2wApAQXDUx7VSg4OYqk0Ys1vXJxtggxJvZI4KV08YOAsDOesxWpsN02CFwPTuNlsOISQUZ/+I63ARoPeOSacfYEZeIi7CiTJOgEP3xFl91YWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116478; c=relaxed/simple;
	bh=HxC//6c/pxtCaIYc6byaWXcJI1kJg6+v7VVvcpx2G0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyHgUvfUv5sNE55SyXYtMnqn3xrb+nnKSPfb9rGj1iwebvA5+wrI/ycuRTxbi0pS4ZMz5x9OUa9X5NiTQssi4bFiOLEJQ2wzDt2CjhUs9aN7HfyVM117AV3LjWpkaqf52ApRZk3FE9cc6CeYoeiYdcLRdMzGzsgnqWN5y5DuMxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJ7Up6Xv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761116474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/wzttfZZIcdwp5kIjVhv23r7cyBB6dYXyfUT8ERUaw=;
	b=XJ7Up6Xv0TRJJoRz0xUOMcQXCyG5bIkzoPCA+elWLAwLWagKxc4CtENdhC111+ziFnZi26
	xrlmeC5I0CdW/VkyxLc57VOPyOwEl3lEOtqH0Ntz0ZjfzUsUPMtd7WlrMB2WcjIbijXg8a
	VjMDFu9wRrqYdmBviIaL8WzbhwhEphw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-6VaTVKLoNFq5KaGFh5nhsQ-1; Wed, 22 Oct 2025 03:01:10 -0400
X-MC-Unique: 6VaTVKLoNFq5KaGFh5nhsQ-1
X-Mimecast-MFC-AGG-ID: 6VaTVKLoNFq5KaGFh5nhsQ_1761116469
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-428567f67c5so58221f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761116469; x=1761721269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/wzttfZZIcdwp5kIjVhv23r7cyBB6dYXyfUT8ERUaw=;
        b=CTs2TsZBfzUsvsI/mdafYEUJJeh17ZxhabiLV1f5ZHF6ZJnR9KDv9CJ5BN18YVoIwG
         rhFyT8+brThhoeuCuWZP7J+e8pDkDmEcbCtrVbSeuWVDDxgQudIjU6aUwOtns8GjBN7n
         5NlVxn19YWOcxOFZLx45UVX4i4iwDi5Mhy3sDIE+yblGMmUiwH2/OK82Q6/yzjGazeVB
         lu2My3osnv5H2eaYUORzqbeVcBe0xxEnV0uA4Pi5oaSd2Nq5gzRYfuwJSR7VWXOTWAHz
         uKl22Uexwv0Tjd7RCUyqBB+DGlwVLYNDcNzZjWre3h9aSgDKb3kMYeMLaaNxhUqOESBV
         WTsA==
X-Forwarded-Encrypted: i=1; AJvYcCX6KazANwQIj/F7i/xM0hsGDd9GlIivjobeIDZfmUbP+E6u9NVydVpl7YdwtxjqZA4L6pqh0qUED+Vp+6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/Q3nvz2CjBQeZAg5E/TiL8tTED9KWp5oparwsQV9jyhujbKM
	IVlx8X5EmITdLOxHr+orwOL5zciCy2DrPgcnWkd3JKbMmMtpVluVzoiPd+TtT10dtKdLFbRU4pM
	CcV0Q7S/4y0CYTJoHEzHLn+ONuJVmJYvEBJ5P9CASYrwgg+WklDHJAyK/0CAoN6jvbA==
X-Gm-Gg: ASbGncvpDU839V0AZC8ogktCwvOY3sUmzz3sRnkP69mPZv/XJghrN8OGUQO7ftbKzgC
	bpCe6m+DTKdiS6QvdgvWNHl9P4fGTUbPYqHqWOtdtw8+iYjcC66GtUaHNXDy+9cPH92dttVxzqn
	5aAYxKBB25yUjVzY1izo+/1Gk57ppJWCoQxTsrv2R9dlmSee/h1Y78nEUfa4AcZLRxTr7Ys93dO
	rj4XtRQS7Q6VrJkntylcVUYsGkK+vFBAkuIK6nk7bq93Tg04zgpawIHmOkING7BUTKsVVTLP9cv
	WdHkC4t25wPGkKKVWZ05cAbICngh5cCs/NuttpKQFvn1xmYtBBTOdzEixzNJwno3PPlM
X-Received: by 2002:a05:6000:420a:b0:3e5:5822:ec9d with SMTP id ffacd0b85a97d-42704d99f29mr12826975f8f.41.1761116469401;
        Wed, 22 Oct 2025 00:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtVUgbjjOkBKOAaeXoFsLqPC4uhTnJ7B4qxCiofbC48XDxdUtASszyIQinjVP9ESvl7Ojt0A==
X-Received: by 2002:a05:6000:420a:b0:3e5:5822:ec9d with SMTP id ffacd0b85a97d-42704d99f29mr12826933f8f.41.1761116468823;
        Wed, 22 Oct 2025 00:01:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c56sm23924067f8f.18.2025.10.22.00.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:01:08 -0700 (PDT)
Date: Wed, 22 Oct 2025 03:01:05 -0400
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
Message-ID: <20251022030050-mutt-send-email-mst@kernel.org>
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
 <20251021085030-mutt-send-email-mst@kernel.org>
 <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
 <20251022014453-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022014453-mutt-send-email-mst@kernel.org>

On Wed, Oct 22, 2025 at 01:45:38AM -0400, Michael S. Tsirkin wrote:
> On Wed, Oct 22, 2025 at 12:19:19PM +0800, Jason Wang wrote:
> > On Tue, Oct 21, 2025 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> > > > The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> > > > is allocated, later freeze/remove may attempt to free vqs again.
> > > > Set vblk->vqs to NULL after freeing to avoid double free.
> > > >
> > > > Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> > > > ---
> > > > The patch fixes a double free issue that occurs in virtio_blk during
> > > > freeze/resume.
> > > > The issue is caused by:
> > > > 1. During the first freeze, vblk->vqs is freed but pointer is not set to
> > > >    NULL.
> > > > 2. Virtio block device fails before vblk->vqs is allocated during resume.
> > > > 3. During the next freeze, vblk->vqs gets freed again, causing the
> > > >    double free crash.
> > >
> > > this part I don't get. if restore fails, how can freeze be called
> > > again?
> > 
> > For example, could it be triggered by the user?
> > 
> > Thanks
> 
> I don't know - were you able to trigger it? how?

Sorry I mean the submitter of course.

> 
> > >
> > > > ---
> > > >  drivers/block/virtio_blk.c | 13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
> > > >  out:
> > > >       kfree(vqs);
> > > >       kfree(vqs_info);
> > > > -     if (err)
> > > > +     if (err) {
> > > >               kfree(vblk->vqs);
> > > > +             /*
> > > > +              * Set to NULL to prevent freeing vqs again during freezing.
> > > > +              */
> > > > +             vblk->vqs = NULL;
> > > > +     }
> > > >       return err;
> > > >  }
> > > >
> > >
> > > > @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
> > > >
> > > >       vdev->config->del_vqs(vdev);
> > > >       kfree(vblk->vqs);
> > > > +     /*
> > > > +      * Set to NULL to prevent freeing vqs again after a failed vqs
> > > > +      * allocation during resume. Note that kfree() already handles NULL
> > > > +      * pointers safely.
> > > > +      */
> > > > +     vblk->vqs = NULL;
> > > >
> > > >       return 0;
> > > >  }
> > > >
> > > > ---
> > > > base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> > > > change-id: 20250926-virtio_double_free-7ab880d82a17
> > > >
> > > > Best regards,
> > > > --
> > > > Cong Zhang <cong.zhang@oss.qualcomm.com>
> > >


