Return-Path: <linux-kernel+bounces-826061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B6B8D6FC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45183BF4A6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E732D1920;
	Sun, 21 Sep 2025 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8kEMl0O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F9192598
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441276; cv=none; b=cf4l8YBXGXBrqoYFoelAgf0iU2hVdOH7gRWbTq8XByC7WsCm+ZbwePdv9KvvUnIhlCK5n9b1RnKTa8G0Utiq5TlMAhRQUAbD5D3wYupctjqFWaxJPtEmm+keO1gL0wLE/W+TonnplK0tohZ3ywwthkYJraklejen50miK6SPpvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441276; c=relaxed/simple;
	bh=OM++W2tvoWr4xpIh7C03sZKKcfCBrCu3CfjnU7GC6Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSAk/jGtIL+47gPJkU/v9sROwSkBXNPwEWxgso3p1DgWpza1vVeQOnVtNt8UdE9l9eBy0jOpRWYpOemjL17PobEF/mIINrRVBPtqK3rsnrZ/4WECSp8buXc2wHqtYCUgrlyVIfFSlVHE0k4koexgyWx3R+mfv0178B6IHB4FI28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8kEMl0O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758441273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6R9T58pVe+Vn0xdle5P0g+ub08sP83iIsEw1F+TkNJo=;
	b=B8kEMl0OoAXPZ72mc8eaYYNRCt+M6v7oYiNuf7/onovuumJ9RTvOlWQcd+I0+FNciOAZ6P
	gavUtoidNptkpn49dYmRGR4I69nCpEfmm+G07sPKgZHUWCsgL/IMZeC0iE+ZFvqtA62JI9
	b6I9sErbSbemRu6UWL+QfAjjXdW8z+k=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-LylQ_jW8NfaZlDrvzayUoA-1; Sun, 21 Sep 2025 03:54:31 -0400
X-MC-Unique: LylQ_jW8NfaZlDrvzayUoA-1
X-Mimecast-MFC-AGG-ID: LylQ_jW8NfaZlDrvzayUoA_1758441270
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-57b35e176afso660262e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758441269; x=1759046069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R9T58pVe+Vn0xdle5P0g+ub08sP83iIsEw1F+TkNJo=;
        b=VV5XtUHXckK3oQRmpS6jh1kHhdg30SOMBR3Ue4bgqkfpKggoWllmW2CPxslh95g8pi
         C1MUmL03Cd3//LeD6JyNHAAB+QFZkExXeJUt7Li0bRiF1EfqF7bchGiv/SstLYz8xBtG
         YSM1n5bG3SbhpZerzUASJdUe3cQXC0p5+Vn9xVRItitDbBNKfnnVsuq4JewXhX99RSOr
         Jlc8Agv37jW63oKYtEK1aWBwIDL4COZiNsOhnxS84kTmaqle9bsF2TEJ+tufRQK3Tve7
         aSzl19a7aIZBVZSAjjWuL0hqhCl81vY6MtGQrVAP6mMHLo28H+VfjmwmtjRsHtNJyBqI
         tO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/2czNhsTxO6E2L8LZApVZGAfRlwv6OD7EneHz6B1i7BQ05wLaePh8iyX2rWsPmNmFZ2j3e3NmKi21Uw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVH9f6Vy7BHJ+i/fLwWREJTpG7WB8CDbcWWa92/q9YNFc4yb1y
	KDnqYKG1jw4QAEXDqvQ8alFN7exb122/7JbLXY5LbL8rVH0Nch9Ip5qsXngeubT/NPtTCaiL+b7
	H4HmTAQg+b3mHHIZtoq0UWDQzUd8KprcNNqBcrOFtRqG2yopym2YwDgcVvda5x5Urv+3T3sJoMs
	rvPLotsWM8NTFlnj+3FF82BV36gujfd9cb9XS1jt4K7+304sozrc8=
X-Gm-Gg: ASbGnct4LDtdls611vAdM52iDXVY0x3rbrMrz0XNpqxbOQBYdeco+js4QsCLzPJw9mD
	UpKQ0HZ2GLIx32Usm3d+Ovid6E45IzYW0rWMQk8vPRr2z6hiFb+jfmE0hAFYCKhT4VwMKuifvS6
	MEx3z3xK7hDbaXS0U+aAmRSA==
X-Received: by 2002:a05:6512:15a4:b0:57c:578e:c84e with SMTP id 2adb3069b0e04-57c578eca1bmr724017e87.21.1758441268905;
        Sun, 21 Sep 2025 00:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVlm2Sz5lVeaBGU8Yz6r8reme2P8kIxzwwu60k5b+nm8Nvvn7cfcC9dBOUDJOTKsKkHzPwJikG9EhmW17sOOw=
X-Received: by 2002:a05:6512:15a4:b0:57c:578e:c84e with SMTP id
 2adb3069b0e04-57c578eca1bmr724006e87.21.1758441268364; Sun, 21 Sep 2025
 00:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915034210.8533-1-k@mgml.me> <20250915034210.8533-2-k@mgml.me>
In-Reply-To: <20250915034210.8533-2-k@mgml.me>
From: Xiao Ni <xni@redhat.com>
Date: Sun, 21 Sep 2025 15:54:16 +0800
X-Gm-Features: AS18NWDLPb-587uhjm6P_WeoLi_luX-BsxF_I_HdUVMPOUBUCRMIQPzYJK9dQJs
Message-ID: <CALTww2_XBBBP3NHRjxrxsJ3eqjJ_bB8SmCeHFocun1hQiUedkA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] md/raid1,raid10: Set the LastDev flag when the
 configuration changes
To: Kenta Akagi <k@mgml.me>
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>, 
	Mariusz Tkaczyk <mtkaczyk@kernel.org>, Shaohua Li <shli@fb.com>, Guoqing Jiang <jgq516@gmail.com>, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kenta

On Mon, Sep 15, 2025 at 11:44=E2=80=AFAM Kenta Akagi <k@mgml.me> wrote:
>
> Currently, the LastDev flag is set on an rdev that failed a failfast
> metadata write and called md_error, but did not become Faulty. It is
> cleared when the metadata write retry succeeds. This has problems for
> the following reasons:
>
> * Despite its name, the flag is only set during a metadata write window.
> * Unlike when LastDev and Failfast was introduced, md_error on the last
>   rdev of a RAID1/10 array now sets MD_BROKEN. Thus when LastDev is set,
>   the array is already unwritable.
>
> A following commit will prevent failfast bios from breaking the array,
> which requires knowing from outside the personality whether an rdev is
> the last one. For that purpose, LastDev should be set on rdevs that must
> not be lost.
>
> This commit ensures that LastDev is set on the indispensable rdev in a
> degraded RAID1/10 array.
>
> Signed-off-by: Kenta Akagi <k@mgml.me>
> ---
>  drivers/md/md.c     |  4 +---
>  drivers/md/md.h     |  6 +++---
>  drivers/md/raid1.c  | 34 +++++++++++++++++++++++++++++++++-
>  drivers/md/raid10.c | 34 +++++++++++++++++++++++++++++++++-
>  4 files changed, 70 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 4e033c26fdd4..268410b66b83 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1007,10 +1007,8 @@ static void super_written(struct bio *bio)
>                 if (!test_bit(Faulty, &rdev->flags)
>                     && (bio->bi_opf & MD_FAILFAST)) {
>                         set_bit(MD_SB_NEED_REWRITE, &mddev->sb_flags);
> -                       set_bit(LastDev, &rdev->flags);
>                 }
> -       } else
> -               clear_bit(LastDev, &rdev->flags);
> +       }
>
>         bio_put(bio);
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 51af29a03079..ec598f9a8381 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -281,9 +281,9 @@ enum flag_bits {
>                                  * It is expects that no bad block log
>                                  * is present.
>                                  */
> -       LastDev,                /* Seems to be the last working dev as
> -                                * it didn't fail, so don't use FailFast
> -                                * any more for metadata
> +       LastDev,                /* This is the last working rdev.
> +                                * so don't use FailFast any more for
> +                                * metadata.
>                                  */
>         CollisionCheck,         /*
>                                  * check if there is collision between ra=
id1
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index bf44878ec640..32ad6b102ff7 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1733,6 +1733,33 @@ static void raid1_status(struct seq_file *seq, str=
uct mddev *mddev)
>         seq_printf(seq, "]");
>  }
>
> +/**
> + * update_lastdev - Set or clear LastDev flag for all rdevs in array
> + * @conf: pointer to r1conf
> + *
> + * Sets LastDev if the device is In_sync and cannot be lost for the arra=
y.
> + * Otherwise, clear it.
> + *
> + * Caller must hold ->device_lock.
> + */
> +static void update_lastdev(struct r1conf *conf)
> +{
> +       int i;
> +       int alive_disks =3D conf->raid_disks - conf->mddev->degraded;
> +
> +       for (i =3D 0; i < conf->raid_disks; i++) {
> +               struct md_rdev *rdev =3D conf->mirrors[i].rdev;
> +
> +               if (rdev) {
> +                       if (test_bit(In_sync, &rdev->flags) &&
> +                           alive_disks =3D=3D 1)
> +                               set_bit(LastDev, &rdev->flags);
> +                       else
> +                               clear_bit(LastDev, &rdev->flags);
> +               }
> +       }
> +}
> +
>  /**
>   * raid1_error() - RAID1 error handler.
>   * @mddev: affected md device.
> @@ -1767,8 +1794,10 @@ static void raid1_error(struct mddev *mddev, struc=
t md_rdev *rdev)
>                 }
>         }
>         set_bit(Blocked, &rdev->flags);
> -       if (test_and_clear_bit(In_sync, &rdev->flags))
> +       if (test_and_clear_bit(In_sync, &rdev->flags)) {
>                 mddev->degraded++;
> +               update_lastdev(conf);
> +       }
>         set_bit(Faulty, &rdev->flags);
>         spin_unlock_irqrestore(&conf->device_lock, flags);
>         /*
> @@ -1864,6 +1893,7 @@ static int raid1_spare_active(struct mddev *mddev)
>                 }
>         }
>         mddev->degraded -=3D count;
> +       update_lastdev(conf);

update_lastdev is called in raid1_spare_active, raid1_run and
raid1_reshape. Could you explain the reason why it needs to call this
function? Is it the reason you want to clear LastDev flag? If so, is
it a right place to do it? As your commit message says, it will be
cleared after retry metadata successfully. In raid1, is it the right
place that fixes read/write successfully?

Best Regards
Xiao

>         spin_unlock_irqrestore(&conf->device_lock, flags);
>
>         print_conf(conf);
> @@ -3290,6 +3320,7 @@ static int raid1_run(struct mddev *mddev)
>         rcu_assign_pointer(conf->thread, NULL);
>         mddev->private =3D conf;
>         set_bit(MD_FAILFAST_SUPPORTED, &mddev->flags);
> +       update_lastdev(conf);
>
>         md_set_array_sectors(mddev, raid1_size(mddev, 0, 0));
>
> @@ -3427,6 +3458,7 @@ static int raid1_reshape(struct mddev *mddev)
>
>         spin_lock_irqsave(&conf->device_lock, flags);
>         mddev->degraded +=3D (raid_disks - conf->raid_disks);
> +       update_lastdev(conf);
>         spin_unlock_irqrestore(&conf->device_lock, flags);
>         conf->raid_disks =3D mddev->raid_disks =3D raid_disks;
>         mddev->delta_disks =3D 0;
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index b60c30bfb6c7..dc4edd4689f8 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1983,6 +1983,33 @@ static int enough(struct r10conf *conf, int ignore=
)
>                 _enough(conf, 1, ignore);
>  }
>
> +/**
> + * update_lastdev - Set or clear LastDev flag for all rdevs in array
> + * @conf: pointer to r10conf
> + *
> + * Sets LastDev if the device is In_sync and cannot be lost for the arra=
y.
> + * Otherwise, clear it.
> + *
> + * Caller must hold ->reconfig_mutex or ->device_lock.
> + */
> +static void update_lastdev(struct r10conf *conf)
> +{
> +       int i;
> +       int raid_disks =3D max(conf->geo.raid_disks, conf->prev.raid_disk=
s);
> +
> +       for (i =3D 0; i < raid_disks; i++) {
> +               struct md_rdev *rdev =3D conf->mirrors[i].rdev;
> +
> +               if (rdev) {
> +                       if (test_bit(In_sync, &rdev->flags) &&
> +                           !enough(conf, i))
> +                               set_bit(LastDev, &rdev->flags);
> +                       else
> +                               clear_bit(LastDev, &rdev->flags);
> +               }
> +       }
> +}
> +
>  /**
>   * raid10_error() - RAID10 error handler.
>   * @mddev: affected md device.
> @@ -2013,8 +2040,10 @@ static void raid10_error(struct mddev *mddev, stru=
ct md_rdev *rdev)
>                         return;
>                 }
>         }
> -       if (test_and_clear_bit(In_sync, &rdev->flags))
> +       if (test_and_clear_bit(In_sync, &rdev->flags)) {
>                 mddev->degraded++;
> +               update_lastdev(conf);
> +       }
>
>         set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>         set_bit(Blocked, &rdev->flags);
> @@ -2102,6 +2131,7 @@ static int raid10_spare_active(struct mddev *mddev)
>         }
>         spin_lock_irqsave(&conf->device_lock, flags);
>         mddev->degraded -=3D count;
> +       update_lastdev(conf);
>         spin_unlock_irqrestore(&conf->device_lock, flags);
>
>         print_conf(conf);
> @@ -4159,6 +4189,7 @@ static int raid10_run(struct mddev *mddev)
>         md_set_array_sectors(mddev, size);
>         mddev->resync_max_sectors =3D size;
>         set_bit(MD_FAILFAST_SUPPORTED, &mddev->flags);
> +       update_lastdev(conf);
>
>         if (md_integrity_register(mddev))
>                 goto out_free_conf;
> @@ -4567,6 +4598,7 @@ static int raid10_start_reshape(struct mddev *mddev=
)
>          */
>         spin_lock_irq(&conf->device_lock);
>         mddev->degraded =3D calc_degraded(conf);
> +       update_lastdev(conf);
>         spin_unlock_irq(&conf->device_lock);
>         mddev->raid_disks =3D conf->geo.raid_disks;
>         mddev->reshape_position =3D conf->reshape_progress;
> --
> 2.50.1
>
>


