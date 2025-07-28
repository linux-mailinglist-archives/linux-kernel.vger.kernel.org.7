Return-Path: <linux-kernel+bounces-748425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19459B14113
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B3E18925E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0B91E5B60;
	Mon, 28 Jul 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXEIuMUF"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946D79D2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722925; cv=none; b=YCuvPbnxU7ha7DiQv4fQwnKdN8i/L4O06/ymAYciKFYWFwSUDS7FyUU8LRly66w19rjumg7zUSBaqIWEM25aIUnpgeQJkLaOS0CkJ/zzFfKjIqmarm7v7T70mNH8stldilShsm1dQVOVwA0SHdKIo+v2ydzNhAcglUrU2LuDVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722925; c=relaxed/simple;
	bh=uN0alRtmBjWLAu0RIhWuPk7KA5ea2hhogSFcexI90XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBTiYRWQFx12D2j4XS0O3mK4Bq6KVXGAqcuP0MIaqyDWvYYGqoj+zeFx0VNyfnj2fsOAsqjFCgppaR+oRT3q3iqDqU6oqXg8O5Umttc2/GS4fE/iFXU9AUYUsLbo4T0a2/iswutgKAAlFbT9VOiYvNusIC/bOUtbPXspxL9q3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXEIuMUF; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e9c8a2026bso1137260137.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753722922; x=1754327722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTGKD6oRdle3dCegGleyS8Dn8yFdf/mVbo6/PiRr7Jk=;
        b=PXEIuMUFnwBNJbnIS1NBp4ohmQC0Ubpb5FMDnOmqqAC8yGoYEBqlSc6JyMIItaO3jX
         bJibschD88m1Tz3uIq+tzxfPdlT/Bm3hOjwCB1nqlPVeuzUGPAEnBY3c+E/zoJpi2qiC
         oCWJqNFtPtzn9g+DLASV7EaouZKqt2sjZymDxDxqFpJg9MxMVYd1CT1InADscU71JmS1
         y0gmsRBIvRRKinZftcdt+qymDBWP4p6pybRt51i+HqYu33/FVlgqXNDVQIcqrntctVeC
         IR/agsyKHqQ9q4Nvg6jFoF6yi+3FkaK7qxeGDL8XcNpb342f63TzDdQOe5kUmT/UFTv3
         B+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753722922; x=1754327722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTGKD6oRdle3dCegGleyS8Dn8yFdf/mVbo6/PiRr7Jk=;
        b=v1i7ScoeojICJnopRtjxpBYOVarChBNW0bCsXmi/YhC2FmYVDVOB6jxWq5Bt6JHy8c
         NN2AMikVlucyK/gti3bR4Tok+fWzpZi+jaT0eQQLnHkDsrVMTWBju03IO8TVAO+U+CAA
         RpSMvG3zsZ17LRuaot+HMk67q476LF810aMblZwIowRZmIuAeNq6sjWzbSFaFiB2V2k7
         NnZ/Ur1jCXB1JcZAguzhGXJa2aFboIzIUrOKgG0e5vXHf4uC0sl7yvfbtmrMGzTTq6qU
         Ei+XJE1plkYlOdcG3qCzTDDq0XO/AIOvevHzhK+lpzywz7GXplkG5cJODgRqQqbA55It
         sRfA==
X-Gm-Message-State: AOJu0YwHvgJTBJK/oyJns3egkaG9xVAmAwi8way7RIJc3C9arMnhefmt
	ffK6WYlUR+ifssKoYqjYHCZia0BwUOGaO4PHuLAlF5Wcd3qHJ0DkLJLaXxOHzOOd+htp85Tcmrz
	wxs59a/RXy0pVeY8ebctm6dmoCPpVnQo=
X-Gm-Gg: ASbGncvdnmBSnoC0vqlRduB7blpYqbuxc/AXg/YL6Ll8aW+0u2Y0dCiU1lSKbiU/8m1
	aiy4mv+QrBFNbrozy5JdR/F4J3tIrwd7JuU+g9LeVO9ECDx0h47WLZV4gXwVKzPfjfUHvA9Gco7
	J9SZGQDvaeLI0yi9qS2+KiHXtAX1PS5Da4YVA+v+81vCaxAsyzTp8Uk9yBtO7ObDC6RbfKXMg2E
	rOUP0knIBWhttJ8Tb02Pcx8V44+4g9eG5g3lchL
X-Google-Smtp-Source: AGHT+IFkgX9qtsaANYaIy6eAwZiNaf47ITgsQx/tyC+DkleSdSH+Y/Iu5SVMrSi3gJPK7vC6ZZT24V09AuzFI+UDklg=
X-Received: by 2002:a05:6102:41a1:b0:4e7:db33:5725 with SMTP id
 ada2fe7eead31-4fa3fc459fcmr4798539137.3.1753722922465; Mon, 28 Jul 2025
 10:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728163628.1043162-1-daeho43@gmail.com> <aIeo-kTFqsUs7L0v@google.com>
In-Reply-To: <aIeo-kTFqsUs7L0v@google.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 28 Jul 2025 10:15:11 -0700
X-Gm-Features: Ac12FXw-dpASSJsVJddB5j4Bjd1GWMs2Vqw35ntGZK1ivt99qkvKIf7zgLdYdvM
Message-ID: <CACOAw_zBpmVR4fKQuRcf3L+kJrJ1Rx8EzXDc6MDSVQdAOKmTvw@mail.gmail.com>
Subject: Re: [PATCH v3] f2fs: add gc_boost_gc_multiple sysfs node
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry.

The below line should belong to "f2fs: add gc_boost_gc_multiple sysfs
node", too.
+ boosted. the range should be from 1 to the segment count in a section.

On Mon, Jul 28, 2025 at 9:44=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> Please check
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=
=3Ddev-test
>
> On 07/28, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Add a sysfs knob to set a multiplier for the background GC migration
> > window when F2FS Garbage Collection is boosted.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v3: fix the range check condition
> > v2: limit the available value range
> > ---
> >  Documentation/ABI/testing/sysfs-fs-f2fs | 8 ++++++++
> >  fs/f2fs/gc.c                            | 3 ++-
> >  fs/f2fs/gc.h                            | 1 +
> >  fs/f2fs/sysfs.c                         | 9 +++++++++
> >  4 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/AB=
I/testing/sysfs-fs-f2fs
> > index bf03263b9f46..931c1f63aa2e 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -861,3 +861,11 @@ Description:     This is a read-only entry to show=
 the value of sb.s_encoding_flags,
> >               SB_ENC_STRICT_MODE_FL            0x00000001
> >               SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
> >               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +What:                /sys/fs/f2fs/<disk>/gc_boost_gc_multiple
> > +Date:                June 2025
> > +Contact:     "Daeho Jeong" <daehojeong@google.com>
> > +Description: Set a multiplier for the background GC migration window w=
hen F2FS GC is
> > +             boosted.
> > +             Default: 5
> > +
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 3cb5242f4ddf..de7e59bc0906 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -197,6 +197,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
> >
> >       gc_th->urgent_sleep_time =3D DEF_GC_THREAD_URGENT_SLEEP_TIME;
> >       gc_th->valid_thresh_ratio =3D DEF_GC_THREAD_VALID_THRESH_RATIO;
> > +     gc_th->boost_gc_multiple =3D BOOST_GC_MULTIPLE;
> >
> >       if (f2fs_sb_has_blkzoned(sbi)) {
> >               gc_th->min_sleep_time =3D DEF_GC_THREAD_MIN_SLEEP_TIME_ZO=
NED;
> > @@ -1749,7 +1750,7 @@ static int do_garbage_collect(struct f2fs_sb_info=
 *sbi,
> >                                       !has_enough_free_blocks(sbi,
> >                                       sbi->gc_thread->boost_zoned_gc_pe=
rcent))
> >                               window_granularity *=3D
> > -                                     BOOST_GC_MULTIPLE;
> > +                                     sbi->gc_thread->boost_gc_multiple=
;
> >
> >                       end_segno =3D start_segno + window_granularity;
> >               }
> > diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> > index 5c1eaf55e127..efa1968810a0 100644
> > --- a/fs/f2fs/gc.h
> > +++ b/fs/f2fs/gc.h
> > @@ -68,6 +68,7 @@ struct f2fs_gc_kthread {
> >       unsigned int no_zoned_gc_percent;
> >       unsigned int boost_zoned_gc_percent;
> >       unsigned int valid_thresh_ratio;
> > +     unsigned int boost_gc_multiple;
> >  };
> >
> >  struct gc_inode_list {
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 75134d69a0bd..b417b655d4e8 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -824,6 +824,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> >               return count;
> >       }
> >
> > +     if (!strcmp(a->attr.name, "gc_boost_gc_multiple")) {
> > +             if (t < 1 || t > SEGS_PER_SEC(sbi))
> > +                     return -EINVAL;
> > +             sbi->gc_thread->boost_gc_multiple =3D (unsigned int)t;
> > +             return count;
> > +     }
> > +
> >       *ui =3D (unsigned int)t;
> >
> >       return count;
> > @@ -1050,6 +1057,7 @@ GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_slee=
p_time);
> >  GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
> >  GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
> >  GC_THREAD_RW_ATTR(gc_valid_thresh_ratio, valid_thresh_ratio);
> > +GC_THREAD_RW_ATTR(gc_boost_gc_multiple, boost_gc_multiple);
> >
> >  /* SM_INFO ATTR */
> >  SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
> > @@ -1220,6 +1228,7 @@ static struct attribute *f2fs_attrs[] =3D {
> >       ATTR_LIST(gc_no_zoned_gc_percent),
> >       ATTR_LIST(gc_boost_zoned_gc_percent),
> >       ATTR_LIST(gc_valid_thresh_ratio),
> > +     ATTR_LIST(gc_boost_gc_multiple),
> >       ATTR_LIST(gc_idle),
> >       ATTR_LIST(gc_urgent),
> >       ATTR_LIST(reclaim_segments),
> > --
> > 2.50.1.470.g6ba607880d-goog
> >

