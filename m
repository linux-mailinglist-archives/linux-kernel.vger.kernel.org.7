Return-Path: <linux-kernel+bounces-889056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5274FC3C96D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33D974ED2BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93662D6629;
	Thu,  6 Nov 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aeiauzw7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE034D3AE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447761; cv=none; b=MjpXhGgt9BI8RZZwmn6ZxxXxXbdkHSgY6RP/11+E9E3+4m54+KaePHUPgeFYl3foGg8LVt8HmmI9lxQqJ3NZJH5orFEPp+O8m/sX91/BAVCelj6XWpsNE8fSXO9bH4LLlNIt0TCs4jhk4Gu/2VPst8TbnE/PaqHuNYHuyyrSYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447761; c=relaxed/simple;
	bh=5BPkPQQte4G28kUKXP7jNkgzYLVqSvlQdB/LoF8pVGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzWOg/HL6kuDDMbZt9UcPd4szN5IX/wHiDIWBZjzMChOOh7gT7FRDY/7SlxfiWycO3d7RWAASGJ+axrHRNmSx9ka3DRuCKNzCVk5QvuUz94fWiAuYdHamtKPZPogq9tgp4QjqNLjHQh7gHhtBWpkmwQPjrKnytXeRQhRAHtnRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aeiauzw7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a432101882so74868b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762447759; x=1763052559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SczTyzt+6IIPWQ1HMqgPPEu+3NB4N6lu6tfW61vk03Y=;
        b=aeiauzw7Ug4EGYy6Wr5KrgJgsqybQLwHS0xrDh947qe9CKVH/h5PdQDhan8pji0uh8
         2R2b7WuzFauK7/T0JQVBryJZ289j2nG69Dc1GYX//46sAuotDAcsiKlzQjopykygno3j
         WlNd+atCMwGyHk2n0Fxgn5pEjvkBC9/oWx/vd29O+HkbtAVhHIMhsebW/TgMom1qjp/K
         0Kv1FADjeFiZWxtRtGfSBILcyZkL7EkA9v3uX3JYlqpc+IJ33+7wdZ98WkdUipYXdbdy
         vT9FyK1vPcljmGuRPxs+ET7p4BV8V8Bej6ybKLs9XuGJw/71wrJuxJcqFNy1rzRrrd3b
         7+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447759; x=1763052559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SczTyzt+6IIPWQ1HMqgPPEu+3NB4N6lu6tfW61vk03Y=;
        b=utub+LLbYF/Oo0kmeluMn39hWtM8DjWTxuu81hSPSuUUPDXVCKkI5UN5Qj6UIYIFk7
         E4D3toMAQAjUWVsN6o4NCtFyxxML+lUscUtD2eGwWxHSfTzxEThMOOsyAxhLuMGqDpFi
         JodCGJmMsDFQwvRhV2kObAZZjr1vtasQ5MBUREOyqSLwPArwRn+3IHm+F2JVW/Ny/cPJ
         7jh82AoWeXhLz2r2WVgV0xdL81ip6rq57SVviZgye37CxWPt3p3Dt6IfJaS8Pclih6H2
         Z2Z7R+zV6+D+TwGSKmZKPv8lnm0xY/zP8FyI8lruK5adaSTa823KB9FJmoq2To1cgSEy
         opwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFOs8uQoKt79Xp8EwoPBOXe39+1qrwYCWVMkeMZvrvisXn3WLf3jt7tI6lULZFp4S0pwribJkzGgi6DT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye53LE4xkZTkMeoJL/svFXvnJfBCM1m0jStth4+1aKU90hv2eq
	X4QGeNcy0EbHJdFYEaMwSbpAyrtdiZcXVtLcJIAy1KdHfKv7POQvqc04ip3XH0S0EIZ/wsIkauq
	n/GhtnFzcljbUkC5F7xcDyS1kR5x21+wixwNaB27EZw==
X-Gm-Gg: ASbGncsJK0gS1IleomTOiSMcZL/xU/wAhTbYEjrg806TJeOshjsKGlr1Q6tPhZBOr3o
	a8Y6QnSM+2PmASBq6ouZK6mUjzHKvz8S0YCLy3rR3Bed2LcUh/xngcqLYApK9qyQXD655ClysMp
	f/BcB60gpxHmARXIx0dQuBZLqlgrf/ByK2InIMXou/Z+DQBrdUz71hgfxkHlevUad3V7ywIEQ4R
	Zv53MhO7z9/ByCBhp1ETff4FVkeIgYmR1g/Frv2LSB0iR8QGSqmHVHH4vcoTYNNhzURt7qMCaSx
	G33Yp0tU7GlBSUL3w6M=
X-Google-Smtp-Source: AGHT+IG+VJgBurUuRaoHFeElA3ww13b2pdW9jZ1rmXSb4lXIbFB/JQJjQwhVJGoxQwk4v6RgB2FCuAc+oh0P0sQeJgk=
X-Received: by 2002:a17:903:183:b0:290:ad79:c617 with SMTP id
 d9443c01a7336-297c038e94dmr1135875ad.1.1762447758581; Thu, 06 Nov 2025
 08:49:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105202823.2198194-1-csander@purestorage.com>
 <20251105202823.2198194-3-csander@purestorage.com> <aQwjvu-bFZRT-8Ol@fedora>
In-Reply-To: <aQwjvu-bFZRT-8Ol@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 6 Nov 2025 08:49:05 -0800
X-Gm-Features: AWmQ_bkhP150tPSs9ogACQ31l-vCnwULMm8lXvcaEuHxWviVQoTkfsJ7PTWALcY
Message-ID: <CADUfDZq-CPJdDdtJMH7imu2rMUffJYdyFZHFyePni_Rf-AdBtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ublk: use rq_for_each_bvec() for user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:27=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Wed, Nov 05, 2025 at 01:28:23PM -0700, Caleb Sander Mateos wrote:
> > ublk_advance_io_iter() and ublk_copy_io_pages() currently open-code the
> > iteration over request's bvecs. Switch to the rq_for_each_bvec() macro
> > provided by blk-mq to avoid reaching into the bio internals and simplif=
y
> > the code. Unlike bio_iter_iovec(), rq_for_each_bvec() can return
> > multi-page bvecs. So switch from copy_{to,from}_iter() to
> > copy_page_{to,from}_iter() to map and copy each page in the bvec.
> >
> > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 78 ++++++++++++----------------------------
> >  1 file changed, 23 insertions(+), 55 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 40eee3e15a4c..929d40fe0250 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -911,81 +911,49 @@ static const struct block_device_operations ub_fo=
ps =3D {
> >       .open =3D         ublk_open,
> >       .free_disk =3D    ublk_free_disk,
> >       .report_zones =3D ublk_report_zones,
> >  };
> >
> > -struct ublk_io_iter {
> > -     struct bio *bio;
> > -     struct bvec_iter iter;
> > -};
> > -
> > -/* return how many bytes are copied */
> > -static size_t ublk_copy_io_pages(struct ublk_io_iter *data,
> > -             struct iov_iter *uiter, int dir)
> > +/*
> > + * Copy data between request pages and io_iter, and 'offset'
> > + * is the start point of linear offset of request.
> > + */
> > +static size_t ublk_copy_user_pages(const struct request *req,
> > +             unsigned offset, struct iov_iter *uiter, int dir)
> >  {
> > +     struct req_iterator iter;
> > +     struct bio_vec bv;
> >       size_t done =3D 0;
> >
> > -     for (;;) {
> > -             struct bio_vec bv =3D bio_iter_iovec(data->bio, data->ite=
r);
> > -             void *bv_buf =3D bvec_kmap_local(&bv);
> > +     rq_for_each_bvec(bv, req, iter) {
> >               size_t copied;
> >
> > +             if (offset >=3D bv.bv_len) {
> > +                     offset -=3D bv.bv_len;
> > +                     continue;
> > +             }
> > +
> > +             bv.bv_offset +=3D offset;
> > +             bv.bv_len -=3D offset;
> > +             bv.bv_page +=3D bv.bv_offset / PAGE_SIZE;
> > +             bv.bv_offset %=3D PAGE_SIZE;
>
> The above two lines are not needed because copy_page_*_iter() handles
> it already.

Yes, I realized that, but was trying to avoid the error in
page_copy_sane(). Though it sounds like updating the starting page
isn't sufficient, as the bvec may still span multiple pages.

>
> >               if (dir =3D=3D ITER_DEST)
> > -                     copied =3D copy_to_iter(bv_buf, bv.bv_len, uiter)=
;
> > +                     copied =3D copy_page_to_iter(
> > +                             bv.bv_page, bv.bv_offset, bv.bv_len, uite=
r);
>
> WARN in page_copy_sane() is triggered because copy_page_*_iter() requires
> all pages belong to one same compound page.
>
> One quick fix is to replace rq_for_each_bvec() with rq_for_each_segment()=
.

Sure, I can switch to rq_for_each_segment(). But then there's not much
point in using copy_page_{to,from}_iter(), right? It allows skipping
the bvec_kmap_local()/kunmap_local(), but incurs additional overhead
to support copying multiple base pages within a single compound page,
which rq_for_each_segment() will never produce.

Best,
Caleb

