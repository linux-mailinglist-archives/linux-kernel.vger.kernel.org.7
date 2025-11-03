Return-Path: <linux-kernel+bounces-882227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0954CC29ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE61188ECC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5C28750A;
	Mon,  3 Nov 2025 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7MXoDz5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPwfzjZ1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B5934D3BE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139528; cv=none; b=SQh+bJqKFwGiApOLqhINGZd2gewbZw7VB+9EU6/BYsRhy6eoBBz2tfMRtzyYbm6BWjrmeprL2yqkwjgY5Ki3aidC+Deox7X6Exl7Wi1pj8f3dRJ7CNVkoClRyIyGoS7Wi0Fqj8dRuh/pJAngMRzhVNCR+nbG3GCxrREa6byKZ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139528; c=relaxed/simple;
	bh=1otINNRv810w1D+0fow2novvAGWKARRkpnbVQCDa9Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpmpcKzVWgNAWRBl8r0oj0wxbtI6+KzEYhbtc8zn0BE4C0tAhlmSohron4F9sDRZ9/rEkUcIna6zVxMF+ZhLJOi1rSZcvfNG0J3E0EIScu5O+fu2DfbO0TPfUh2ozF6hSwH2znB3VGk+6FRVFZkwbWlv1YaOn12u2Nn8MIIi064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7MXoDz5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPwfzjZ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762139524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9q9NB7J33f7YfQtT3FCN3sb4VVb8oeAZXiK7o1NqPH8=;
	b=H7MXoDz5XPNoBeI+lKCe9c1TLa1+iqEBxGrzR8jy0YbHXtOIN3HJUkNrHOFusUxaWDKqLH
	d60SJBfJdIHQkAF6rXmVtoMwWoM80a8kkCY4+OYT3aE1eKQ9hPS0wiC4t+F0OVUDk9wBHi
	FhJAtfiiFsgHFUtUTCC2ngdE8flvR1s=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-F1dLjL3SO9Sflug-dPAo_w-1; Sun, 02 Nov 2025 22:12:02 -0500
X-MC-Unique: F1dLjL3SO9Sflug-dPAo_w-1
X-Mimecast-MFC-AGG-ID: F1dLjL3SO9Sflug-dPAo_w_1762139521
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-585b3594d16so2187117e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 19:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762139521; x=1762744321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q9NB7J33f7YfQtT3FCN3sb4VVb8oeAZXiK7o1NqPH8=;
        b=VPwfzjZ1+eHKr0iqRp/ZP9Ke6dhNY2BBZnQOlVXTHn5+9h26IaQGeviX8aTm34ViCW
         vEnln7sNZvg6uceWYzDM/2PWwEyVxKyE8P7yUbJN8I+2yGZDpoVLm8um2ER1JFCpEY0m
         L+d3LFmNBR+Wep49RpxvQPhHrf+4+NSpQyV6wVFBgetb+pBMkF7NXdlLr81mjOUcIrnE
         J8hqj757Uwec9n9Ho79pMMKJC/9YIpLY18fTpH0kOaf3+jKFiHkEEuKxVLiD4LFn5wUa
         b8iHUxtkv0pyi1stOQ1rXUYM7dWecOp2eF7gs4gK20sDt0MDuYkrtWO/StlBKCz2YHls
         cmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139521; x=1762744321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9q9NB7J33f7YfQtT3FCN3sb4VVb8oeAZXiK7o1NqPH8=;
        b=l549Uf1yV8SBQ0bKyvd3aGwkcHBthCQOTxx68OXRMiW5X6RCFw3tk4WGrrDrrUeice
         f/yXH6ksHBar7iVtcdvZN4kmS9tbimSnWgNI8oXYuQoVx54/3dl9Aa3OuP1z04ccthD9
         u6Ok1gfA1UPoJrWJwh+1k40oBIsMcp0WWpMS2L6PkG0bv7W63Ikd1fSFyLaNBgIot6rD
         /wc98dwSV+lkF1FOTtkXw0YYQfkf3Rt5s2JpL7FsdPy6Bwu3g+UE99dFQ+9jjVLsvhRW
         2i8V3yiTKgfBE/6CL4GB3QnoDrg+bGVKldzC+/Jj6NqXYe+sXoNnfdswfQ8MLy6FwHKm
         tfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbiwEtwWLXv0BiOlYRzvWqjPbyIbB2+dR2kBk2hb3US6OHP/rzBvjEVLPBjse80K1spMkFQ2GRCafm2i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEPFcLUO9MHMW+y5GrxxZrNuWLp4+k6VHLRQbX+zpA2esOfcT
	WizGIdoKvYINiGcAYX021NMt8mLF1QHt4UAT8VaNIyRG+UMy8a9/rMUmi+jThJn4HfERpk7dNam
	3GdUYLmbR+DQ906EHrljVz3zLSGQ72nrMysU+UBsoL1yz0Vs85pGXqTkDv6wDIgmEISTK0y/ib+
	jhFXrWOSObEgOMLz6BjLSYPM9NZ0UFdfWWyYfk2c71
X-Gm-Gg: ASbGncvsX4T3fQ/ZRtjkt0vizvAEj4s/UIGLL4USspoXUyt6OiKpc9HXSFJXmtQy3XH
	SkiLoTJBsHqhqvdTV3MaUCDUCkBrbt68YsZDKzl+/Bdck75kMOR6d6BHCc9oGqgzFZLT/b2IO/F
	ADZEJAKJRakcYVjhfXs4cZU0Vi6k1uUBrzHAHfmp3Y7UiHR/QkwgQb0dQ=
X-Received: by 2002:a05:6512:3d92:b0:594:2f72:2f73 with SMTP id 2adb3069b0e04-5942f7234ebmr77686e87.25.1762139520550;
        Sun, 02 Nov 2025 19:12:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHafufFEhaRmrw9x1BEeN9R/m6MPrZ2EUX7gwO4XJcCY4vxclzIKjX/1k7ptgmMQoSbFUEfiiMdyGoqhNKUOHI=
X-Received: by 2002:a05:6512:3d92:b0:594:2f72:2f73 with SMTP id
 2adb3069b0e04-5942f7234ebmr77674e87.25.1762139520032; Sun, 02 Nov 2025
 19:12:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030062807.1515356-1-linan666@huaweicloud.com> <20251030062807.1515356-5-linan666@huaweicloud.com>
In-Reply-To: <20251030062807.1515356-5-linan666@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 3 Nov 2025 11:11:48 +0800
X-Gm-Features: AWmQ_blr6RzGPDBcLwF-uexl5T5cZT9NDedag9UWdBROfAjkGk49JSN6biUbmKk
Message-ID: <CALTww28r_bicJ_4jcxQ7MB2hLVX5nAZkY3tuM7q7HY_D2beHFA@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] md: allow configuring logical block size
To: linan666@huaweicloud.com
Cc: corbet@lwn.net, song@kernel.org, yukuai@fnnas.com, linan122@huawei.com, 
	hare@suse.de, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 2:36=E2=80=AFPM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> Previously, raid array used the maximum logical block size (LBS)
> of all member disks. Adding a larger LBS disk at runtime could
> unexpectedly increase RAID's LBS, risking corruption of existing
> partitions. This can be reproduced by:
>
> ```
>   # LBS of sd[de] is 512 bytes, sdf is 4096 bytes.
>   mdadm -CRq /dev/md0 -l1 -n3 /dev/sd[de] missing --assume-clean
>
>   # LBS is 512
>   cat /sys/block/md0/queue/logical_block_size
>
>   # create partition md0p1
>   parted -s /dev/md0 mklabel gpt mkpart primary 1MiB 100%
>   lsblk | grep md0p1
>
>   # LBS becomes 4096 after adding sdf
>   mdadm --add -q /dev/md0 /dev/sdf
>   cat /sys/block/md0/queue/logical_block_size
>
>   # partition lost
>   partprobe /dev/md0
>   lsblk | grep md0p1
> ```
>
> Simply restricting larger-LBS disks is inflexible. In some scenarios,
> only disks with 512 bytes LBS are available currently, but later, disks
> with 4KB LBS may be added to the array.
>
> Making LBS configurable is the best way to solve this scenario.
> After this patch, the raid will:
>   - store LBS in disk metadata
>   - add a read-write sysfs 'mdX/logical_block_size'
>
> Future mdadm should support setting LBS via metadata field during RAID
> creation and the new sysfs. Though the kernel allows runtime LBS changes,
> users should avoid modifying it after creating partitions or filesystems
> to prevent compatibility issues.
>
> Only 1.x metadata supports configurable LBS. 0.90 metadata inits all
> fields to default values at auto-detect. Supporting 0.90 would require
> more extensive changes and no such use case has been observed.
>
> Note that many RAID paths rely on PAGE_SIZE alignment, including for
> metadata I/O. A larger LBS than PAGE_SIZE will result in metadata
> read/write failures. So this config should be prevented.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  Documentation/admin-guide/md.rst |  7 +++
>  drivers/md/md.h                  |  1 +
>  include/uapi/linux/raid/md_p.h   |  3 +-
>  drivers/md/md-linear.c           |  1 +
>  drivers/md/md.c                  | 77 ++++++++++++++++++++++++++++++++
>  drivers/md/raid0.c               |  1 +
>  drivers/md/raid1.c               |  1 +
>  drivers/md/raid10.c              |  1 +
>  drivers/md/raid5.c               |  1 +
>  9 files changed, 92 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide=
/md.rst
> index 1c2eacc94758..0f143acd2db7 100644
> --- a/Documentation/admin-guide/md.rst
> +++ b/Documentation/admin-guide/md.rst
> @@ -238,6 +238,13 @@ All md devices contain:
>       the number of devices in a raid4/5/6, or to support external
>       metadata formats which mandate such clipping.
>
> +  logical_block_size
> +     Configure the array's logical block size in bytes. This attribute
> +     is only supported for 1.x meta. The value should be written before
> +     starting the array. The final array LBS will use the max value
> +     between this configuration and all combined device's LBS. Note that
> +     LBS cannot exceed PAGE_SIZE before RAID supports folio.
> +
>    reshape_position
>       This is either ``none`` or a sector number within the devices of
>       the array where ``reshape`` is up to.  If this is set, the three
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 38a7c2fab150..a6b3cb69c28c 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -432,6 +432,7 @@ struct mddev {
>         sector_t                        array_sectors; /* exported array =
size */
>         int                             external_size; /* size managed
>                                                         * externally */
> +       unsigned int                    logical_block_size;
>         __u64                           events;
>         /* If the last 'event' was simply a clean->dirty transition, and
>          * we didn't write it to the spares, then it is safe and simple
> diff --git a/include/uapi/linux/raid/md_p.h b/include/uapi/linux/raid/md_=
p.h
> index ac74133a4768..310068bb2a1d 100644
> --- a/include/uapi/linux/raid/md_p.h
> +++ b/include/uapi/linux/raid/md_p.h
> @@ -291,7 +291,8 @@ struct mdp_superblock_1 {
>         __le64  resync_offset;  /* data before this offset (from data_off=
set) known to be in sync */
>         __le32  sb_csum;        /* checksum up to devs[max_dev] */
>         __le32  max_dev;        /* size of devs[] array to consider */
> -       __u8    pad3[64-32];    /* set to 0 when writing */
> +       __le32  logical_block_size;     /* same as q->limits->logical_blo=
ck_size */
> +       __u8    pad3[64-36];    /* set to 0 when writing */
>
>         /* device state information. Indexed by dev_number.
>          * 2 bytes per device
> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
> index 7033d982d377..50d4a419a16e 100644
> --- a/drivers/md/md-linear.c
> +++ b/drivers/md/md-linear.c
> @@ -72,6 +72,7 @@ static int linear_set_limits(struct mddev *mddev)
>
>         md_init_stacking_limits(&lim);
>         lim.max_hw_sectors =3D mddev->chunk_sectors;
> +       lim.logical_block_size =3D mddev->logical_block_size;
>         lim.max_write_zeroes_sectors =3D mddev->chunk_sectors;
>         lim.max_hw_wzeroes_unmap_sectors =3D mddev->chunk_sectors;
>         lim.io_min =3D mddev->chunk_sectors << 9;
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index dffc6a482181..d78e9e52c951 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1993,6 +1993,7 @@ static int super_1_validate(struct mddev *mddev, st=
ruct md_rdev *freshest, struc
>                 mddev->layout =3D le32_to_cpu(sb->layout);
>                 mddev->raid_disks =3D le32_to_cpu(sb->raid_disks);
>                 mddev->dev_sectors =3D le64_to_cpu(sb->size);
> +               mddev->logical_block_size =3D le32_to_cpu(sb->logical_blo=
ck_size);
>                 mddev->events =3D ev1;
>                 mddev->bitmap_info.offset =3D 0;
>                 mddev->bitmap_info.space =3D 0;
> @@ -2202,6 +2203,7 @@ static void super_1_sync(struct mddev *mddev, struc=
t md_rdev *rdev)
>         sb->chunksize =3D cpu_to_le32(mddev->chunk_sectors);
>         sb->level =3D cpu_to_le32(mddev->level);
>         sb->layout =3D cpu_to_le32(mddev->layout);
> +       sb->logical_block_size =3D cpu_to_le32(mddev->logical_block_size)=
;
>         if (test_bit(FailFast, &rdev->flags))
>                 sb->devflags |=3D FailFast1;
>         else
> @@ -5930,6 +5932,68 @@ static struct md_sysfs_entry md_serialize_policy =
=3D
>  __ATTR(serialize_policy, S_IRUGO | S_IWUSR, serialize_policy_show,
>         serialize_policy_store);
>
> +static int mddev_set_logical_block_size(struct mddev *mddev,
> +                               unsigned int lbs)
> +{
> +       int err =3D 0;
> +       struct queue_limits lim;
> +
> +       if (queue_logical_block_size(mddev->gendisk->queue) >=3D lbs) {
> +               pr_err("%s: Cannot set LBS smaller than mddev LBS %u\n",
> +                      mdname(mddev), lbs);
> +               return -EINVAL;
> +       }
> +
> +       lim =3D queue_limits_start_update(mddev->gendisk->queue);
> +       lim.logical_block_size =3D lbs;
> +       pr_info("%s: logical_block_size is changed, data may be lost\n",
> +               mdname(mddev));
> +       err =3D queue_limits_commit_update(mddev->gendisk->queue, &lim);
> +       if (err)
> +               return err;
> +
> +       mddev->logical_block_size =3D lbs;
> +       /* New lbs will be written to superblock after array is running *=
/
> +       set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
> +       return 0;
> +}
> +
> +static ssize_t
> +lbs_show(struct mddev *mddev, char *page)
> +{
> +       return sprintf(page, "%u\n", mddev->logical_block_size);
> +}
> +
> +static ssize_t
> +lbs_store(struct mddev *mddev, const char *buf, size_t len)
> +{
> +       unsigned int lbs;
> +       int err =3D -EBUSY;
> +
> +       /* Only 1.x meta supports configurable LBS */
> +       if (mddev->major_version =3D=3D 0)
> +               return -EINVAL;
> +
> +       if (mddev->pers)
> +               return -EBUSY;
> +
> +       err =3D kstrtouint(buf, 10, &lbs);
> +       if (err < 0)
> +               return -EINVAL;
> +
> +       err =3D mddev_lock(mddev);
> +       if (err)
> +               goto unlock;
> +
> +       err =3D mddev_set_logical_block_size(mddev, lbs);
> +
> +unlock:
> +       mddev_unlock(mddev);
> +       return err ?: len;
> +}
> +
> +static struct md_sysfs_entry md_logical_block_size =3D
> +__ATTR(logical_block_size, 0644, lbs_show, lbs_store);
>
>  static struct attribute *md_default_attrs[] =3D {
>         &md_level.attr,
> @@ -5952,6 +6016,7 @@ static struct attribute *md_default_attrs[] =3D {
>         &md_consistency_policy.attr,
>         &md_fail_last_dev.attr,
>         &md_serialize_policy.attr,
> +       &md_logical_block_size.attr,
>         NULL,
>  };
>
> @@ -6082,6 +6147,17 @@ int mddev_stack_rdev_limits(struct mddev *mddev, s=
truct queue_limits *lim,
>                         return -EINVAL;
>         }
>
> +       /*
> +        * Before RAID adding folio support, the logical_block_size
> +        * should be smaller than the page size.
> +        */
> +       if (lim->logical_block_size > PAGE_SIZE) {
> +               pr_err("%s: logical_block_size must not larger than PAGE_=
SIZE\n",
> +                       mdname(mddev));
> +               return -EINVAL;
> +       }
> +       mddev->logical_block_size =3D lim->logical_block_size;
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(mddev_stack_rdev_limits);
> @@ -6693,6 +6769,7 @@ static void md_clean(struct mddev *mddev)
>         mddev->chunk_sectors =3D 0;
>         mddev->ctime =3D mddev->utime =3D 0;
>         mddev->layout =3D 0;
> +       mddev->logical_block_size =3D 0;
>         mddev->max_disks =3D 0;
>         mddev->events =3D 0;
>         mddev->can_decrease_events =3D 0;
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index fbf763401521..47aee1b1d4d1 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -380,6 +380,7 @@ static int raid0_set_limits(struct mddev *mddev)
>         lim.max_hw_sectors =3D mddev->chunk_sectors;
>         lim.max_write_zeroes_sectors =3D mddev->chunk_sectors;
>         lim.max_hw_wzeroes_unmap_sectors =3D mddev->chunk_sectors;
> +       lim.logical_block_size =3D mddev->logical_block_size;
>         lim.io_min =3D mddev->chunk_sectors << 9;
>         lim.io_opt =3D lim.io_min * mddev->raid_disks;
>         lim.chunk_sectors =3D mddev->chunk_sectors;
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 64bfe8ca5b38..167768edaec1 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -3212,6 +3212,7 @@ static int raid1_set_limits(struct mddev *mddev)
>         md_init_stacking_limits(&lim);
>         lim.max_write_zeroes_sectors =3D 0;
>         lim.max_hw_wzeroes_unmap_sectors =3D 0;
> +       lim.logical_block_size =3D mddev->logical_block_size;
>         lim.features |=3D BLK_FEAT_ATOMIC_WRITES;
>         err =3D mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRIT=
Y);
>         if (err)
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 6b2d4b7057ae..71bfed3b798d 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4000,6 +4000,7 @@ static int raid10_set_queue_limits(struct mddev *md=
dev)
>         md_init_stacking_limits(&lim);
>         lim.max_write_zeroes_sectors =3D 0;
>         lim.max_hw_wzeroes_unmap_sectors =3D 0;
> +       lim.logical_block_size =3D mddev->logical_block_size;
>         lim.io_min =3D mddev->chunk_sectors << 9;
>         lim.chunk_sectors =3D mddev->chunk_sectors;
>         lim.io_opt =3D lim.io_min * raid10_nr_stripes(conf);
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index aa404abf5d17..92473850f381 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7747,6 +7747,7 @@ static int raid5_set_limits(struct mddev *mddev)
>         stripe =3D roundup_pow_of_two(data_disks * (mddev->chunk_sectors =
<< 9));
>
>         md_init_stacking_limits(&lim);
> +       lim.logical_block_size =3D mddev->logical_block_size;
>         lim.io_min =3D mddev->chunk_sectors << 9;
>         lim.io_opt =3D lim.io_min * (conf->raid_disks - conf->max_degrade=
d);
>         lim.features |=3D BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE;
> --
> 2.39.2
>

Hi Li Nan

The problem can't be fixed if there is no user space (mdadm) patch, right?

The patch Looks good to me.
Reviewed-by: Xiao Ni <xni@redhat.com>


