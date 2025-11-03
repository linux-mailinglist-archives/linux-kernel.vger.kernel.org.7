Return-Path: <linux-kernel+bounces-882170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49DEC29CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD373AF492
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E3A22A1C5;
	Mon,  3 Nov 2025 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBuBF0Nf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3eUvJrw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED01898E9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134466; cv=none; b=pVmSx6uC6I91pyE5FO/Zf5igtY1YyO5i431dqh2WNuOP2B0Oq+acjYnL/IcrMagkn4DZtAdCJZIX7iysd2+vcSHxebp9mJOUbe4huhMwRHpVWMg0NjelmAo9ZRd70iJrplj8FjAmCnpWv3fTrICfxF5llazr0poPleC1udXbrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134466; c=relaxed/simple;
	bh=DZ/KiMq7wWJ8uPyNXpIdNz0w5pQFBc9zI5smcnaaiB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0qHSD0RtzOt0e9fmJSblAsg00z0mLmhJ7QrbSwQpzAysoNjWJpxdCminsl1yHhT4Pkk+JKjTqrn+75ngJfitcfoUzmQrVaKcOTPlizLNu+DrvMZ8X5ATjBQEKLhJ5CektlX2cjHkCvyPHiOq2vZMzsj+7b4IJS6ePVtKnJZx0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBuBF0Nf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3eUvJrw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762134464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DS23ySq+vPb5Ayo6+abelT4SHGq2SoMsLQTkVaSuuRo=;
	b=SBuBF0NfmiEAmskiJ6BG8F9JDWbtoOxdrNWriscf7/qEKzt7DPvjwjmLiJg0e6SK+hcPZi
	DsWQv9RKinnlZp9eraxIfdlm60faE5wExtJnCmU7inYs8jWTsIcURM1TIOpw3VpEU5IcTq
	6+oTAZkCkGOsa13Z432l4/1lfsp44Ms=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-8dSC1xdPOju43TTZ0oSLog-1; Sun, 02 Nov 2025 20:47:42 -0500
X-MC-Unique: 8dSC1xdPOju43TTZ0oSLog-1
X-Mimecast-MFC-AGG-ID: 8dSC1xdPOju43TTZ0oSLog_1762134461
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-59427500731so260571e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 17:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762134461; x=1762739261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DS23ySq+vPb5Ayo6+abelT4SHGq2SoMsLQTkVaSuuRo=;
        b=h3eUvJrw/IrXM943TWCMfLZSG2xXhrrG5N/qweL10nJoVfb0zjbFI20+DHAy6EFOrb
         Ffl1ym7Ef03Lp5+S0N2CV8Fzma2gr3mIeyvnu7tDkL8Z76z4Sluk22vLRAzUfZb95Zjg
         /K2cCyo4wGen2yf5cbg1m+PN/P/RNyp5qV02pywmYVFAzF/abLeHstalao/9Yq8sMgyw
         cn8nNug7tAumBFnP0aoq7x2wstwrbd0e7EqUG94jSOaLPasaeHCTJ3ezZ8UQFlsSGhNc
         m/NLFRVynESjetZZuiiY6rexzLwK0AUOhsd/a0ZrY5qqeUzHBsFigOzb5sb3aLqNdslE
         4ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134461; x=1762739261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DS23ySq+vPb5Ayo6+abelT4SHGq2SoMsLQTkVaSuuRo=;
        b=RIWb54cW8SBEf+pjPPBmzTtzy95WXaHGEFgkznPZek5UdGMLkh+1UvP580RtwDaqq0
         jWs9xm4I0Lz7+4GGrb2gBktIgpsvIIQylj3F7zR6PmMAnHyg7u91sD/nqa9ZWraYUQjm
         Sp16c7ZX1TahbOibUrFP0IPfnSIWNb6KpzK2295yU3OubHbtP1Knr8PKu2XgtIKCrY2p
         oFnFNAER3C0z1WbQGwLdJdUPjiSGAaY4V3R8BicgrOEvmZxZHu5GavcnbsWjFcSExufh
         Dz/6RYh7VtF8QW6pHpdlUOFiBdyfXDxzSxFyXER8iykqf2e6HLMdRShcYgryodHBZOLl
         GBjg==
X-Forwarded-Encrypted: i=1; AJvYcCVYeRd3YLir2A8ZhmyP8TayE9ZovvNANhGVhrJ0K46w7g7TXaKfqRSy78j0/G/mlUiZTjycSP1eXrZzehE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqyKAMRQE+hSrEPTnYMiSfnbEAW/yUl5RxjjAg4W7LWyeEFZLk
	2/Wqub8h0XX6S7rMk6TIYItOGCvUGOinyLsR9vYDz07LyA6m5BewwdijyrW9rj+YAnW8cXLlMhD
	8TYJQDYe3639SeAdvsgfWy2kvurvFOIr0rBfFtS5C4uMMSp2SAp+msQ7g8AIL4fSRTank5wD9ql
	BQJd97Z7/WMoYk9kIxeFFOJT2V2XVstEmB9jaPCQmo
X-Gm-Gg: ASbGncvFz+mjnDqK5Z8dk6MORhlpCbUgj6kMVUxxUpNQxpppX1kLhY15ESvzbGPLY8R
	FnN9VpGsa1vs9LmZFCLqdr0PuhIgGPYRTigKk2hWTQewVz3PykHSu5KBF3Hvgvjj+Q6jCpeFnhO
	+muukpuhqpqVZ5zQ33orDEeVxniSXstuZPY/kix4V8Ikp4GDtl+0B8KmQ=
X-Received: by 2002:a05:6512:3e10:b0:594:2c58:978b with SMTP id 2adb3069b0e04-5942c589ad9mr620626e87.51.1762134461225;
        Sun, 02 Nov 2025 17:47:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHDOR/3/dEMSprdbAr+vGPJpG0WiUEecPksq7/JieZgEHWe+BMjD1gOgOvmjXIa+VsxvCQ+Uz9nvUL4YhsU+c=
X-Received: by 2002:a05:6512:3e10:b0:594:2c58:978b with SMTP id
 2adb3069b0e04-5942c589ad9mr620618e87.51.1762134460782; Sun, 02 Nov 2025
 17:47:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030062807.1515356-1-linan666@huaweicloud.com> <20251030062807.1515356-4-linan666@huaweicloud.com>
In-Reply-To: <20251030062807.1515356-4-linan666@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 3 Nov 2025 09:47:28 +0800
X-Gm-Features: AWmQ_bl8wDMCqnoMJ36yUqoXBMkz_wvMmqiObsyO1YtquNOV0cAL5Eti1U9XmlA
Message-ID: <CALTww286rYcR1hFk5GtxuwFqtUo3fwNyixd5N-_MwBX3P6UUBA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] md/raid0: Move queue limit setup before r0conf initialization
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
> Prepare for making logical blocksize configurable. This change has no
> impact until logical block size becomes configurable.
>
> Move raid0_set_limits() before create_strip_zones(). It is safe as fields
> modified in create_strip_zones() do not involve mddev configuration, and
> rdev modifications there are not used in raid0_set_limits().
>
> 'blksize' in create_strip_zones() fetches mddev's logical block size,
> which is already the maximum aross all rdevs, so the later max() can be
> removed.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/raid0.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index e443e478645a..fbf763401521 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -68,7 +68,7 @@ static int create_strip_zones(struct mddev *mddev, stru=
ct r0conf **private_conf)
>         struct strip_zone *zone;
>         int cnt;
>         struct r0conf *conf =3D kzalloc(sizeof(*conf), GFP_KERNEL);
> -       unsigned blksize =3D 512;
> +       unsigned int blksize =3D queue_logical_block_size(mddev->gendisk-=
>queue);
>
>         *private_conf =3D ERR_PTR(-ENOMEM);
>         if (!conf)
> @@ -84,9 +84,6 @@ static int create_strip_zones(struct mddev *mddev, stru=
ct r0conf **private_conf)
>                 sector_div(sectors, mddev->chunk_sectors);
>                 rdev1->sectors =3D sectors * mddev->chunk_sectors;
>
> -               blksize =3D max(blksize, queue_logical_block_size(
> -                                     rdev1->bdev->bd_disk->queue));
> -
>                 rdev_for_each(rdev2, mddev) {
>                         pr_debug("md/raid0:%s:   comparing %pg(%llu)"
>                                  " with %pg(%llu)\n",
> @@ -405,6 +402,12 @@ static int raid0_run(struct mddev *mddev)
>         if (md_check_no_bitmap(mddev))
>                 return -EINVAL;
>
> +       if (!mddev_is_dm(mddev)) {
> +               ret =3D raid0_set_limits(mddev);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         /* if private is not null, we are here after takeover */
>         if (mddev->private =3D=3D NULL) {
>                 ret =3D create_strip_zones(mddev, &conf);
> @@ -413,11 +416,6 @@ static int raid0_run(struct mddev *mddev)
>                 mddev->private =3D conf;
>         }
>         conf =3D mddev->private;
> -       if (!mddev_is_dm(mddev)) {
> -               ret =3D raid0_set_limits(mddev);
> -               if (ret)
> -                       return ret;
> -       }
>
>         /* calculate array device size */
>         md_set_array_sectors(mddev, raid0_size(mddev, 0, 0));
> --
> 2.39.2
>

Looks good to me.
Reviewed-by: Xiao Ni <xni@redhat.com>


