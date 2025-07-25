Return-Path: <linux-kernel+bounces-745249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D3B11733
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00546AE35B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF8A23A997;
	Fri, 25 Jul 2025 03:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsulU1AP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F8236431
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753414986; cv=none; b=lhfsILvtXweaOfO7R5OTZp7Y6FssFggZ3aya8gPcfzA7h5+UkxFHy4mku9gDdj7Qsz1NzEFst1L1EpInYGu0VwfaLX7F2oPkI8lMZPiizRS4Qxe2Rm4fWqxzwa++iTIlUxyNpbX6QlDCUtyz6Y6ZkCz+1P4xWVXVqWi37ZTiQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753414986; c=relaxed/simple;
	bh=EYW/y1fwu5T+yqts+Bpy6dphKw7A/rXhOamx61AqAGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myn/p1n+SpbS6yRRJlwjizX7AudT60Ly/an6io80OuW037uWHLymgLVt1lwVED4YrG3qluae3/Z97tmo8n88XN2i6cEtpjMe2AUMzkwhaYrVPgQ5ZDEu0+BCOBGPL8Jo1FnFRmQvvSKOMdjUc6VTTnVSBEoqkgRA0pCMucnInic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsulU1AP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753414983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmT/ORzg0P1lBg635/k0jST+Uw1Ny6cPps1AZuQQysQ=;
	b=hsulU1APBbSsa0Oc85dGnbOIewo4Sgd/AWHzZq+ppcIJeDDLX6X7qHQjyGquRrHsxU5uWB
	SbQobmt/CZefiGxgKmwzB/mAs/pdfxjQ8mJLRG3PEXN+R3K9TBPsBiWoIrluNiq4lS6Y57
	hN+QidY2Pqfzc7IPrngcifZLTRq33ZU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-gX-uO6WDNN2uqe8jdDAixw-1; Thu, 24 Jul 2025 23:43:00 -0400
X-MC-Unique: gX-uO6WDNN2uqe8jdDAixw-1
X-Mimecast-MFC-AGG-ID: gX-uO6WDNN2uqe8jdDAixw_1753414979
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-32b32ce581bso6891641fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753414979; x=1754019779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmT/ORzg0P1lBg635/k0jST+Uw1Ny6cPps1AZuQQysQ=;
        b=KZ7I9ImtYO9LLscnwQ2ny10F9bNAWcr1FbQwAI3gjdzr2eTUx9OjfwhQCQDnS/hbYF
         xgcWvi2eo2voMUW6AX0lN3Jlnto7ryDqM8WnFb+OeZo9X1oYlbT8Ck6+VFmfsRKLyyrC
         kIFY3KS1bcmiTUEgdu53RxFzz2064VD3NzixEafhY70E/72qy5zGb38O84WOGE8rJZV7
         ZFyMWCahw2nEYpnpz3TnfA/NCSCOTWCrS6lcXaF/UQekuSAc609VCCtDbJliH0A4lULC
         +/Lljss5fLKWrtc7k5PGPILNGC5ASOS+Zs2rT/bOMD31xWytGFeGOKuk6FxcmmTBJgFV
         jWbg==
X-Forwarded-Encrypted: i=1; AJvYcCWX184H+69vwdeBZ/1cAkw/7ft+wZsGJyPmnilWXnHtrHja2gDFPVZ50N/JtY4z5GuVflXVVyyeST+Sosw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN2m9T5AAcFukN/J374BPObsEPlQwR3MfnYIApVp7e1TRbgBKy
	62bglqUCBqLifUL0uA/RnHo8+0ioRvsL5Bt23/UDmOjgsju5i76GbwXhhOzJB6Ts/4j9Px4zZx+
	GysNBZRGv1kJp+7V4aRhvHSd2ixnZPdl/pmLdcrWz4ZwyKO7yASQuu5OdeMdJI2614Aov4WVcYD
	XnyHzREw6KDgUIgnOLs+A7MeMueOfl5OcSRP2IwHKV
X-Gm-Gg: ASbGncv8LAIdToq6U9tO/hmXPQibOM1TSH+zr2sOaRMTrsmmJiEn2UdtORRo+nYfV4h
	trIhOvPEO1eb+E+oF6hpPXi2G9Q/eTvi4s86Axr4pFyL1cE5RgW1yGBOJ+w5PdmGKjpW0/WOl85
	ij5jtt2Fm9evft5cMDQWM1kQ==
X-Received: by 2002:a2e:b8d2:0:b0:32b:78ce:be8e with SMTP id 38308e7fff4ca-331ee7ff19cmr1287061fa.32.1753414978995;
        Thu, 24 Jul 2025 20:42:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4YEQa+EOQb1BXl05be8PP0uoJ9yTAnU5IBjXbn4Pml9bhqsvSe6/FSlvFTpOWnC363qchUy3SyM0LBktBwFM=
X-Received: by 2002:a2e:b8d2:0:b0:32b:78ce:be8e with SMTP id
 38308e7fff4ca-331ee7ff19cmr1286981fa.32.1753414978556; Thu, 24 Jul 2025
 20:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707012711.376844-1-yukuai1@huaweicloud.com> <20250707012711.376844-5-yukuai1@huaweicloud.com>
In-Reply-To: <20250707012711.376844-5-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Fri, 25 Jul 2025 11:42:47 +0800
X-Gm-Features: Ac12FXyOOKyHA7wp5OFT5LnhP7iR9jh1hN7dKn8UFtQrbCgR_dwXzkwUJs2-acg
Message-ID: <CALTww2-71P6Z0zxOeWJhu3bJ5AkKNqP0K+6M1djmBG=mZg38_w@mail.gmail.com>
Subject: Re: [PATCH v5 04/15] md/md-bitmap: merge md_bitmap_group into bitmap_operations
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, 
	yukuai3@huawei.com, dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:35=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Now that all bitmap implementations are internal, it doesn't make sense
> to export md_bitmap_group anymore.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md-bitmap.c | 5 ++++-
>  drivers/md/md-bitmap.h | 2 ++
>  drivers/md/md.c        | 6 +++++-
>  drivers/md/md.h        | 1 -
>  4 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index fc7282304b00..0ba1da35aa84 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -2990,7 +2990,8 @@ static struct attribute *md_bitmap_attrs[] =3D {
>         &max_backlog_used.attr,
>         NULL
>  };
> -const struct attribute_group md_bitmap_group =3D {
> +
> +static struct attribute_group md_bitmap_group =3D {
>         .name =3D "bitmap",
>         .attrs =3D md_bitmap_attrs,
>  };
> @@ -3026,6 +3027,8 @@ static struct bitmap_operations bitmap_ops =3D {
>         .copy_from_slot         =3D bitmap_copy_from_slot,
>         .set_pages              =3D bitmap_set_pages,
>         .free                   =3D md_bitmap_free,
> +
> +       .group                  =3D &md_bitmap_group,
>  };
>
>  void mddev_set_bitmap_ops(struct mddev *mddev)
> diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
> index 28c1f1c1cc83..0ceb9e97d21f 100644
> --- a/drivers/md/md-bitmap.h
> +++ b/drivers/md/md-bitmap.h
> @@ -100,6 +100,8 @@ struct bitmap_operations {
>                               sector_t *hi, bool clear_bits);
>         void (*set_pages)(void *data, unsigned long pages);
>         void (*free)(void *data);
> +
> +       struct attribute_group *group;
>  };
>
>  /* the bitmap API */
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index bda3ef814d97..7ed95e5e43fc 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -5749,7 +5749,6 @@ static const struct attribute_group md_redundancy_g=
roup =3D {
>
>  static const struct attribute_group *md_attr_groups[] =3D {
>         &md_default_group,
> -       &md_bitmap_group,
>         NULL,
>  };
>
> @@ -5996,6 +5995,11 @@ struct mddev *md_alloc(dev_t dev, char *name)
>                 return ERR_PTR(error);
>         }
>
> +       if (mddev->bitmap_ops && mddev->bitmap_ops->group)
> +               if (sysfs_create_group(&mddev->kobj, mddev->bitmap_ops->g=
roup))
> +                       pr_warn("md: cannot register extra bitmap attribu=
tes for %s\n",
> +                               mdname(mddev));
> +
>         kobject_uevent(&mddev->kobj, KOBJ_ADD);
>         mddev->sysfs_state =3D sysfs_get_dirent_safe(mddev->kobj.sd, "arr=
ay_state");
>         mddev->sysfs_level =3D sysfs_get_dirent_safe(mddev->kobj.sd, "lev=
el");
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 67b365621507..d6fba4240f97 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -796,7 +796,6 @@ struct md_sysfs_entry {
>         ssize_t (*show)(struct mddev *, char *);
>         ssize_t (*store)(struct mddev *, const char *, size_t);
>  };
> -extern const struct attribute_group md_bitmap_group;
>
>  static inline struct kernfs_node *sysfs_get_dirent_safe(struct kernfs_no=
de *sd, char *name)
>  {
> --
> 2.39.2
>
>

Looks good to me.
Reviewed-by: Xiao Ni <xni@redhat.com>


