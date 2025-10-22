Return-Path: <linux-kernel+bounces-864107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5262BF9ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FD6426B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613442D640A;
	Wed, 22 Oct 2025 04:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zx2D6QcS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B31FBEB0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106781; cv=none; b=h5AeVliTiRRV9wGr5U4SK21wWhnbi1mrSFMDM7oYYdforS36raHTvryUUhjVpDSWeLQs1nXDr+7i6d5bwHlOEeD1aWSkzhkxJ/BDe6YszGa28M0vhuKlLHoyWnaxQrYYeNdT33lHJkCCjsR/7w9O2drJFh4t6Mr1wZzuc8uBEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106781; c=relaxed/simple;
	bh=EgU8rnXynIPhs/BZsA64otPdBcSY9W7JNRXfkBA9twA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7fa3Sgvp30yC7f++5hKZnlFtbVtOReDZ16fTNAEGZrT4q7m8D7bXrTWC9dZEYBN5fhRxeIXOVMzd7BfkJqr8E27xKYrOtMmUuBIsZ47uDdFZHB5/jgOCdG8Xedt6sb6nrymWSJGLMDSOh0ZLgI3Wo+K+RhtlG/ExzTxw8gZ91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zx2D6QcS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761106778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEB1GkxvFRSrK09fb4q7fCqBnMrGabs898MxIlOczVU=;
	b=Zx2D6QcSU0WMx/j7rNFV1jcbdAkVb/twtxjCXJnrxVUMxMvYjbOFE5dO1nE6oP89CUlx39
	OL88agAb14g5ujgBCRXKmWPcsr3lRYIqAQ8fSwgw8T5YUIkqSen7tHQYjc8fmj2lwnp2Ty
	Zi3gtu2kwCICDyEdwSHVniXKiSQ30II=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-PlAjbzIeOYyXiGJyTD72oQ-1; Wed, 22 Oct 2025 00:19:34 -0400
X-MC-Unique: PlAjbzIeOYyXiGJyTD72oQ-1
X-Mimecast-MFC-AGG-ID: PlAjbzIeOYyXiGJyTD72oQ_1761106774
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33da21394adso3194594a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106773; x=1761711573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEB1GkxvFRSrK09fb4q7fCqBnMrGabs898MxIlOczVU=;
        b=vAjGOoaIMCsqYs2bemTQ5NM9nrDbW/h3VQ4s/3hzwA+73aJnlPMbN6WaFz5gddPOrM
         qgXsWw+8WDvuaVVNV1udhB5bvX9eBOhilWHgig9sKtkrDsYpL9yPhPRueMozJewtaOem
         KxVTV9aDYyPYax4AaxCPt2hazmgHtffX2ABfgZkPx//6w5E5VmJiSJsC08Et+E70MjbF
         JV2az2wS0sVUmq9LKpUtfzSyyXzGWIVZ7x0q+DGcLC/hr8MqLTYHwUB9qALPP/UymPJ0
         Y2tq1lrrbiMHwBNcoUw/rx/geQLW8NaNjRzx+QvQsR65y9muqIQk0hzZHQeHcpC8RP6i
         ah9w==
X-Forwarded-Encrypted: i=1; AJvYcCXgS2ahG2HMOTTwcU3zNRM0+bUgrtLpAuuKHGam1zvtr3uJ8YmpSQjuGTWj5+nsI69oT1oSjnhip5eWAjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzka62NGoxbw2ZonodO2t5TLox+/nbVI9dvdYqDBn2fjVPnUnkv
	4m7bd+YO93Jc7V6cyw9HCCvQUgP3UpjoOSSyD10VBHCFbLekcJJ7rhEZvcFSEY6PDMPbqlcybMS
	XkpSVEANVWWovdsH5lG1hDZyxvp/bzqZnXSPdo9y+s09fIt59c1yd4O+0/9HkYWM+ZJ3ikMACbx
	R6sWgqaEae2vZM+WO2mb56DyuteZr3RjJRMXgPmGZB6N13d/Tui3c=
X-Gm-Gg: ASbGncvYf0t/MKD/Ztj1ujlBbfDHndEUnJdJoYU7A70VGlKVjq1Q0xGFfmFuy4EsI4t
	qQMsMt+yppcfyt3sjysC+vVYWUCOOvjNu9HaLs7cWmsQ1wk9DJ1WjT8qicSj/bFkP69g/h0Soiz
	XI0dWswEjWbKbeaJ1vLZvg7I7FI/5zVuPrXF4I5feW4i2C0lt6GiZaUqtR
X-Received: by 2002:a17:90b:3f10:b0:32e:c6b6:956b with SMTP id 98e67ed59e1d1-33bcf85aba8mr27207003a91.4.1761106773411;
        Tue, 21 Oct 2025 21:19:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxpm190zeS/O7QhosnTZCJ+sJ0OOtUfB8EF+I18t2uJyG2ctlTvkqQPBgMA4jG+/iqib9IAmxZwYBAa++FoXg=
X-Received: by 2002:a17:90b:3f10:b0:32e:c6b6:956b with SMTP id
 98e67ed59e1d1-33bcf85aba8mr27206962a91.4.1761106772999; Tue, 21 Oct 2025
 21:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com> <20251021085030-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251021085030-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Oct 2025 12:19:19 +0800
X-Gm-Features: AS18NWCKmXJHmGDH1OnrtnkNAc2Gt2Hyx92v8bPZ5LqsjBJ7559XCA-Y6f0OWpQ
Message-ID: <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed resume
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cong Zhang <cong.zhang@oss.qualcomm.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pavan.kondeti@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> > The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> > is allocated, later freeze/remove may attempt to free vqs again.
> > Set vblk->vqs to NULL after freeing to avoid double free.
> >
> > Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> > ---
> > The patch fixes a double free issue that occurs in virtio_blk during
> > freeze/resume.
> > The issue is caused by:
> > 1. During the first freeze, vblk->vqs is freed but pointer is not set t=
o
> >    NULL.
> > 2. Virtio block device fails before vblk->vqs is allocated during resum=
e.
> > 3. During the next freeze, vblk->vqs gets freed again, causing the
> >    double free crash.
>
> this part I don't get. if restore fails, how can freeze be called
> again?

For example, could it be triggered by the user?

Thanks

>
> > ---
> >  drivers/block/virtio_blk.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0=
344d24f9fa06841eb 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
> >  out:
> >       kfree(vqs);
> >       kfree(vqs_info);
> > -     if (err)
> > +     if (err) {
> >               kfree(vblk->vqs);
> > +             /*
> > +              * Set to NULL to prevent freeing vqs again during freezi=
ng.
> > +              */
> > +             vblk->vqs =3D NULL;
> > +     }
> >       return err;
> >  }
> >
>
> > @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_dev=
ice *vdev)
> >
> >       vdev->config->del_vqs(vdev);
> >       kfree(vblk->vqs);
> > +     /*
> > +      * Set to NULL to prevent freeing vqs again after a failed vqs
> > +      * allocation during resume. Note that kfree() already handles NU=
LL
> > +      * pointers safely.
> > +      */
> > +     vblk->vqs =3D NULL;
> >
> >       return 0;
> >  }
> >
> > ---
> > base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> > change-id: 20250926-virtio_double_free-7ab880d82a17
> >
> > Best regards,
> > --
> > Cong Zhang <cong.zhang@oss.qualcomm.com>
>


