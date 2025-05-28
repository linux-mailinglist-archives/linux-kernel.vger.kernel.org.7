Return-Path: <linux-kernel+bounces-664663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD681AC5ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 03:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992F04A0F62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 01:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563B0195FE8;
	Wed, 28 May 2025 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEfzOF7K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6743A8F7
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 01:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395748; cv=none; b=thZzbKIUCO6WbpMYTXVSjQgVdOhhqXcXvXZ/vWj4894VzG5jVnEoQ0aYlyget5q7RoyLoea9GrR4dKRd/dtY/ortp/jRN+IJwgV73BkBr572hCGPuqzT/1lwCcWP7fU7Yj8TVM2SWw9xQfKLMXrt/MhlTzoOOs3fcI3faUwGCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395748; c=relaxed/simple;
	bh=oGwFaAb/2cH/uAUfWNm/mLu5py8LPF7EiDAhIsETzRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/26PXuyEorJuCtHovMGHkyQTjsYOngOqw9jsxq7lZBchVIZ4N4OI29v2LBJg1zMfmtlkrtN/i6hqTpNIUswmEcRFng8bXFj5s/ChMIfIBcnR5ov2IFFE014hNfT2di9H6/FplIH29n1YRqChtrMmxm4CycDY+OJfE8ootsPGEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEfzOF7K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748395745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdIraVhDvO04PCyDV7HzvydbUiWT3IPqefIGzxoYAzY=;
	b=XEfzOF7KFSx+vnjHEpqpU3WbDhs65JPEhzjfFBlJkKQXQcp+FcYS1Kn3rd0+NagaQt8LF4
	fdfSM+Coqsteh57uwlCXTAa8QQSijqkawlv4hnAOv8vCu2Y6YDFzjU0kZ5+tnOBx+eCEk8
	e/zyHO6M8iIRLXDke/lLV5q2tlyDVes=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-JShHqmYoN-iHtfPrtzdmcA-1; Tue, 27 May 2025 21:29:01 -0400
X-MC-Unique: JShHqmYoN-iHtfPrtzdmcA-1
X-Mimecast-MFC-AGG-ID: JShHqmYoN-iHtfPrtzdmcA_1748395738
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32a64f93c68so1798311fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 18:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748395738; x=1749000538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdIraVhDvO04PCyDV7HzvydbUiWT3IPqefIGzxoYAzY=;
        b=SIHp3ylSvzCurqdKkyXlRwOqwHYIm3Ti3JefzL8khvNBT5xdI6xA1p5DI6bfyr04pH
         UGZkNUQX5nGVhDYIoHSKJRZ2cGqi7uUaaVyTRA4qI1flT4oqVkBzeVhkRnrIK+FYNmFX
         mEUf8sXZm0ykt0Lh//N2uJ2YPiLcEeDxr4NWubrGUDjgI4I9niBJYcAys4UkBR1H12VV
         Xd7tEboxwZ2jZ2mDlWNkaWo29L9brfTnGcSHLqL9kPzo9krZL1TMp3qjoNq0q0vxZp6E
         d/KiH7U2QBlN4R07Q0m4QfgeSbTHVKxjMTkJHTEu1YgKJR3JHIRh+qfG2pzg9x3CYoHJ
         EDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMCDFYlY/VubXXswnG0nyN6OW74/7I6Oe0rSh19aWjcrDho2jDTNzH0uTLqDBazUOMMJXWVZzZk0Qm/6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxo0qF9sgCC2uByzEMteNKQFgKNlNgr1k41oNVQleGntMmF91u
	jhNwVoGAaIkwFrT/ajuvdnLLOz7Ed3NdemVf2a0ZNU0bWf/Ouxx/iGQ4uucI2SZ0EuHwdWvVz6p
	FDZdESEpJJZuOYzRbXp81JvqAk/I4DMcFXvyDiDRlBr92594oXoLaBLvLRshhoNtSjuxkvKQo/i
	9YLEkJSaAZKCt4DEHt4lcBMTf/U3xNPyr9WxCC8XKG
X-Gm-Gg: ASbGncu8ojLztGdNARqhAxt0d/yqHI0pBO688+z0Jo+3FjZkaYfOD/XyAQlZvvdvlv4
	zy/Q5+qLZRtx071KoE0OEXvJ7861Dtw5WB0r8Ul7CllY4zOD8jSGNO0IaNWAHzrReXBRRw/ZKT2
	hRl5UG
X-Received: by 2002:a05:651c:4117:b0:32a:7454:4410 with SMTP id 38308e7fff4ca-32a74544480mr4511231fa.16.1748395737946;
        Tue, 27 May 2025 18:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExeeBw6K4npLsO/1jjWRJGrHsT/4tuZ3o6U790Emogbn/JQBnZ7TtIZ8gfCZepaLbbZOoi1jiutATn+opbm+Y=
X-Received: by 2002:a05:651c:4117:b0:32a:7454:4410 with SMTP id
 38308e7fff4ca-32a74544480mr4511151fa.16.1748395737458; Tue, 27 May 2025
 18:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527081407.3004055-1-yukuai1@huaweicloud.com> <190d2a22-b858-1320-cd2e-c71f057b233d@huaweicloud.com>
In-Reply-To: <190d2a22-b858-1320-cd2e-c71f057b233d@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Wed, 28 May 2025 09:28:45 +0800
X-Gm-Features: AX0GCFtmMiTAEcCq9ru1f5asds5SxyN2Ir5VDZloLq4xB71aIrR_0DWY7BrVoeg
Message-ID: <CALTww2-_QoC7OCVSXHy=XfYE3K9m_CQ05HKX7QqJ504qnN=0cA@mail.gmail.com>
Subject: Re: [PATCH v2] md/raid1,raid10: don't handle IO error for REQ_RAHEAD
 and REQ_NOWAIT
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, zdenek.kabelac@gmail.com, song@kernel.org, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, johnny.chenyi@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>, Heinz Mauelshagen <heinzm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Heinz who is a dm-raid expert. But he is on holiday this week.

On Tue, May 27, 2025 at 4:24=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi, Zdenek Kabelac
>
> =E5=9C=A8 2025/05/27 16:14, Yu Kuai =E5=86=99=E9=81=93:
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > IO with REQ_RAHEAD or REQ_NOWAIT can fail early, even if the storage me=
dium
> > is fine, hence record badblocks or remove the disk from array does not
> > make sense.
> >
> > This problem if found by lvm2 test lvcreate-large-raid, where dm-zero
> > will fail read ahead IO directly.
> >
> > Reported-and-tested-by: Mikulas Patocka <mpatocka@redhat.com>
> > Closes: https://lore.kernel.org/all/34fa755d-62c8-4588-8ee1-33cb1249bdf=
2@redhat.com/
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> > Changes in v2:
> >   - handle REQ_NOWAIT as well.
> >
> >   drivers/md/raid1-10.c | 10 ++++++++++
> >   drivers/md/raid1.c    | 19 ++++++++++---------
> >   drivers/md/raid10.c   | 11 ++++++-----
> >   3 files changed, 26 insertions(+), 14 deletions(-)
> >
>
> Just to let you know that while testing lvcreate-large-raid, the test
> can fail sometime:
>
> [ 0:12.021] ## DEBUG0: 08:11:43.596775 lvcreate[8576]
> device_mapper/ioctl/libdm-iface.c:2118  device-mapper: create ioctl on
> LVMTEST8371vg1-LV1_rmeta_0
> LVM-iqJjW9HItbME2d4DC2S7D58zd2omecjf0yQN83foinyxHaPoZqGEnX4rRUN7i0kH
> failed: Device or resource busy
>
> And add debug info in kernel:
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 4165fef4c170..04b66b804365 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -263,6 +263,7 @@ static int dm_hash_insert(const char *name, const
> char *uuid, struct mapped_devi
>   {
>          struct hash_cell *cell, *hc;
>
> +       printk("%s: %s %s\n", __func__, name, uuid);
>          /*
>           * Allocate the new cells.
>           */
> @@ -310,6 +311,7 @@ static struct dm_table *__hash_remove(struct
> hash_cell *hc)
>          struct dm_table *table;
>          int srcu_idx;
>
> +       printk("%s: %s %s\n", __func__, hc->name, hc->uuid);
>          lockdep_assert_held(&_hash_lock);
>
>          /* remove from the dev trees */
> @@ -882,18 +884,23 @@ static int dev_create(struct file *filp, struct
> dm_ioctl *param, size_t param_si
>          struct mapped_device *md;
>
>          r =3D check_name(param->name);
> -       if (r)
> +       if (r) {
> +               printk("%s: check_name failed %d\n", __func__, r);
>                  return r;
> +       }
>
>          if (param->flags & DM_PERSISTENT_DEV_FLAG)
>                  m =3D MINOR(huge_decode_dev(param->dev));
>
>          r =3D dm_create(m, &md);
> -       if (r)
> +       if (r) {
> +               printk("%s: dm_create failed %d\n", __func__, r);
>                  return r;
> +       }
>
>          r =3D dm_hash_insert(param->name, *param->uuid ? param->uuid :
> NULL, md);
>          if (r) {
> +               printk("%s: dm_hash_insert failed %d\n", __func__, r);
>                  dm_put(md);
>                  dm_destroy(md);
>                  return r;
>
> I got:
> [ 2265.277214] dm_hash_insert: LVMTEST8371vg1-LV1_rmeta_0
> LVM-iqJjW9HItbME2d4DC2S7D58zd2omecjf0yQN83foinyxHaPoZqGEnX4rRUN7i0kH^M
> [ 2265.279666] dm_hash_insert: LVMTEST8371vg1-LV1_rmeta_0
> LVM-iqJjW9HItbME2d4DC2S7D58zd2omecjf0yQN83foinyxHaPoZqGEnX4rRUN7i0kH^M
> [ 2265.281043] dev_create: dm_hash_insert failed -16
>
> Looks like the test somehow insert the same target twice? Is this a
> known issue?
>
> Thanks,
> Kuai
>
> > diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> > index c7efd8aab675..b8b3a9069701 100644
> > --- a/drivers/md/raid1-10.c
> > +++ b/drivers/md/raid1-10.c
> > @@ -293,3 +293,13 @@ static inline bool raid1_should_read_first(struct =
mddev *mddev,
> >
> >       return false;
> >   }
> > +
> > +/*
> > + * bio with REQ_RAHEAD or REQ_NOWAIT can fail at anytime, before such =
IO is
> > + * submitted to the underlying disks, hence don't record badblocks or =
retry
> > + * in this case.
> > + */
> > +static inline bool raid1_should_handle_error(struct bio *bio)
> > +{
> > +     return !(bio->bi_opf & (REQ_RAHEAD | REQ_NOWAIT));
> > +}
> > diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > index 657d481525be..19c5a0ce5a40 100644
> > --- a/drivers/md/raid1.c
> > +++ b/drivers/md/raid1.c
> > @@ -373,14 +373,16 @@ static void raid1_end_read_request(struct bio *bi=
o)
> >        */
> >       update_head_pos(r1_bio->read_disk, r1_bio);
> >
> > -     if (uptodate)
> > +     if (uptodate) {
> >               set_bit(R1BIO_Uptodate, &r1_bio->state);
> > -     else if (test_bit(FailFast, &rdev->flags) &&
> > -              test_bit(R1BIO_FailFast, &r1_bio->state))
> > +     } else if (test_bit(FailFast, &rdev->flags) &&
> > +              test_bit(R1BIO_FailFast, &r1_bio->state)) {
> >               /* This was a fail-fast read so we definitely
> >                * want to retry */
> >               ;
> > -     else {
> > +     } else if (!raid1_should_handle_error(bio)) {
> > +             uptodate =3D 1;
> > +     } else {
> >               /* If all other devices have failed, we want to return
> >                * the error upwards rather than fail the last device.
> >                * Here we redefine "uptodate" to mean "Don't want to ret=
ry"
> > @@ -451,16 +453,15 @@ static void raid1_end_write_request(struct bio *b=
io)
> >       struct bio *to_put =3D NULL;
> >       int mirror =3D find_bio_disk(r1_bio, bio);
> >       struct md_rdev *rdev =3D conf->mirrors[mirror].rdev;
> > -     bool discard_error;
> >       sector_t lo =3D r1_bio->sector;
> >       sector_t hi =3D r1_bio->sector + r1_bio->sectors;
> > -
> > -     discard_error =3D bio->bi_status && bio_op(bio) =3D=3D REQ_OP_DIS=
CARD;
> > +     bool ignore_error =3D !raid1_should_handle_error(bio) ||
> > +             (bio->bi_status && bio_op(bio) =3D=3D REQ_OP_DISCARD);
> >
> >       /*
> >        * 'one mirror IO has finished' event handler:
> >        */
> > -     if (bio->bi_status && !discard_error) {
> > +     if (bio->bi_status && !ignore_error) {
> >               set_bit(WriteErrorSeen, &rdev->flags);
> >               if (!test_and_set_bit(WantReplacement, &rdev->flags))
> >                       set_bit(MD_RECOVERY_NEEDED, &
> > @@ -511,7 +512,7 @@ static void raid1_end_write_request(struct bio *bio=
)
> >
> >               /* Maybe we can clear some bad blocks. */
> >               if (rdev_has_badblock(rdev, r1_bio->sector, r1_bio->secto=
rs) &&
> > -                 !discard_error) {
> > +                 !ignore_error) {
> >                       r1_bio->bios[mirror] =3D IO_MADE_GOOD;
> >                       set_bit(R1BIO_MadeGood, &r1_bio->state);
> >               }
> > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > index dce06bf65016..b74780af4c22 100644
> > --- a/drivers/md/raid10.c
> > +++ b/drivers/md/raid10.c
> > @@ -399,6 +399,8 @@ static void raid10_end_read_request(struct bio *bio=
)
> >                * wait for the 'master' bio.
> >                */
> >               set_bit(R10BIO_Uptodate, &r10_bio->state);
> > +     } else if (!raid1_should_handle_error(bio)) {
> > +             uptodate =3D 1;
> >       } else {
> >               /* If all other devices that store this block have
> >                * failed, we want to return the error upwards rather
> > @@ -456,9 +458,8 @@ static void raid10_end_write_request(struct bio *bi=
o)
> >       int slot, repl;
> >       struct md_rdev *rdev =3D NULL;
> >       struct bio *to_put =3D NULL;
> > -     bool discard_error;
> > -
> > -     discard_error =3D bio->bi_status && bio_op(bio) =3D=3D REQ_OP_DIS=
CARD;
> > +     bool ignore_error =3D !raid1_should_handle_error(bio) ||
> > +             (bio->bi_status && bio_op(bio) =3D=3D REQ_OP_DISCARD);
> >
> >       dev =3D find_bio_disk(conf, r10_bio, bio, &slot, &repl);
> >
> > @@ -472,7 +473,7 @@ static void raid10_end_write_request(struct bio *bi=
o)
> >       /*
> >        * this branch is our 'one mirror IO has finished' event handler:
> >        */
> > -     if (bio->bi_status && !discard_error) {
> > +     if (bio->bi_status && !ignore_error) {
> >               if (repl)
> >                       /* Never record new bad blocks to replacement,
> >                        * just fail it.
> > @@ -527,7 +528,7 @@ static void raid10_end_write_request(struct bio *bi=
o)
> >               /* Maybe we can clear some bad blocks. */
> >               if (rdev_has_badblock(rdev, r10_bio->devs[slot].addr,
> >                                     r10_bio->sectors) &&
> > -                 !discard_error) {
> > +                 !ignore_error) {
> >                       bio_put(bio);
> >                       if (repl)
> >                               r10_bio->devs[slot].repl_bio =3D IO_MADE_=
GOOD;
> >
>
>


