Return-Path: <linux-kernel+bounces-883939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0FC2EDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 02:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDDB18868B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 01:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1210521D3F3;
	Tue,  4 Nov 2025 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJNilXRR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="trspT5Zl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E6238D22
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220885; cv=none; b=E+sJrWDfU44jkLniIBoZlo633SxwfqamPI3YvKChJuO+doyKcyy5U4FkrFKsHBVELFOwgaukYos6wDoHYb0qnC5hNxCxhC7K90luIrO9ENd8ci5i3QD/HS+75YOzonRStIY521V9fQqjxtnOCVOvCfTxSyTNhGs4adpWWg0F0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220885; c=relaxed/simple;
	bh=fSdA0L8Nm0YCwS16VUPzW3Aq3gD381+XRBN41NLXEX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6ABKWrmOjgTh4ezno8EdBjG3FV+L6sJX5Qda/2UjB86pnk2Wrd5rzw8yie8m5lYA1COvxSN3Ws5v8S/hGklVX2LI3prAeTa0zzgqS9gYBfOPRFreqq+LvhvgoZi6ED9NR3bws3LWjO0JkZXOlTj4dTXDj1kGdKXAAFhiT0RY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJNilXRR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=trspT5Zl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762220882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsXwYGK1x1byPj06v8OW9bm66Zb85lZTaaKe7v0rKBA=;
	b=PJNilXRRu/OcGYvHBNK+mnozrHCoSBihH+ZQcKxYwexIg6m36ouDjzuyPOUOhDdX52SrmT
	F5ARkhudsX/Chs8w0lDPrUHNrwNqJYNcFu5laFBwb6a7J+awv8Z5WlLtpQoBiHS+pkMnlm
	Vu6XY8DD1E7dCG3S3xq4zv04IkQVt2o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-5j5Zl5cmMp6rbYuE661Sfg-1; Mon, 03 Nov 2025 20:47:59 -0500
X-MC-Unique: 5j5Zl5cmMp6rbYuE661Sfg-1
X-Mimecast-MFC-AGG-ID: 5j5Zl5cmMp6rbYuE661Sfg_1762220878
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-594285c6850so1131348e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 17:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762220877; x=1762825677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsXwYGK1x1byPj06v8OW9bm66Zb85lZTaaKe7v0rKBA=;
        b=trspT5ZlNBdAIQC/2orO/aYr8asqK8FPRoQ1G5hJ8lu8hy94oy9bbBdJXfuAe1FLzO
         uEMr4WB9btdusS+3L8OG1NzauT6vJrJ1vcPKV9tNUePNp4ZmT1lp/RuqFv3K2qTfn/6O
         rilcB4j7vlWXiBcMxIPRzAE4l1khfnT3go3nmktoVGh9rl7g94D6gToAci4OrDz9/EcE
         HSIclXG84Z6p+dYcjGJKu588YVPloRD7fd4O/noPfdPScLw97NhGkgft1hsmj7JDS6tj
         Dl2vBK/SUy2KA4Hn9Lirvgqbe8vQV6KXO0Qrkbg79o/JFEdCseQPLdno7HEa4qaUOcU9
         3tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762220877; x=1762825677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsXwYGK1x1byPj06v8OW9bm66Zb85lZTaaKe7v0rKBA=;
        b=nSA2lVWroLA+ynJu1v7IJsKabAlpwcrFzq02BGkcv4BydgFvMDpb1EcEqvPtRByZjh
         itMhDerW6scTm2nhuDi62guFZOaXrOvUGksEu5+qQkYiViz8yDg9qIqub1olQTXG656i
         zZkIFzlL6WA1bH3FdKtLscvcQ8ReuUrpvVILfUnbZx/8mzsR20YZpXiUjtxOqV1ZuynW
         IuVjanXHSH130vHPkClbhukJhZ2GfgpyRcivPWJzgviGEvvEZ7RfUOvO15NH1iNKpGjW
         Tl/EAuzHK3FKxptCvtL2gtuQ2LG8tqQSSz+cSgx+kw/f8xTi/CeKqv46EV/cAyEL80Wp
         u/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWxEM0JZd99FmeZMuQ2QUUmB2ln9S24dhCMPZT63pOVZD8g37BV8obe+AqFOgoImKEwYN3KEk+Fr88LGP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCfKe/tL7JU7ZZWtgsYOBEOPPgR2+GKyX3HzXGegtcVkQMkoLc
	MIE8zQAlsxhmcFwGWvL96KGcAgeoUg6B7RrUaawwFUe7mU3RX/MiAdeXSMgLkv+lHSRt7jjkqZz
	PkCJ1K8VCxbauqahImjeCS4JA8xiApovSr/xxgKxn//Fn4TiKLEZfxDEcF4NADj3iIB2GwmD2u0
	uxmJLEggZkYb9psOq3bDgju3+SXvN6FLeAvDr3H3uB
X-Gm-Gg: ASbGncuWyVOoTiB4T4FI3/ILFHGb6NjesEHvVzv7lEshXzm6xGD4Msaz/B2qXos5zDa
	s5ahUvvbwc1JHtpx18DMus0ATbD1y7vxTcLFBelOhGFzR2UAULm9RyiV1cW5/GRzs+TXIck3DSF
	6MGBObYf3elL5S/Rs4Jx54VdEcgNNV64gAD/ZqmQUOE4QCX8cH8GfB81iD
X-Received: by 2002:ac2:4e06:0:b0:594:2f72:2f8e with SMTP id 2adb3069b0e04-5942f723446mr1343701e87.10.1762220877385;
        Mon, 03 Nov 2025 17:47:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa2QAcOx2jbiaR7JKF3K5bdYSVRtB/YvBQpCC8cf4XQDFWQEH7U+c+L3BD/FhyG3c+WA30SnGgfwMNQxzZnKY=
X-Received: by 2002:ac2:4e06:0:b0:594:2f72:2f8e with SMTP id
 2adb3069b0e04-5942f723446mr1343693e87.10.1762220876921; Mon, 03 Nov 2025
 17:47:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103125757.1405796-1-linan666@huaweicloud.com> <20251103125757.1405796-5-linan666@huaweicloud.com>
In-Reply-To: <20251103125757.1405796-5-linan666@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 4 Nov 2025 09:47:45 +0800
X-Gm-Features: AWmQ_bnPKBTjG4KT60HiXK62t6RM-uEzUUaIJ9bAKjC9tyeQ8C-26fjcFNkMFHU
Message-ID: <CALTww29-7U=o=RzS=pfo-zqLYY_O2o+PXw-8PLXqFRf=wdthvQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] md: add check_new_feature module parameter
To: linan666@huaweicloud.com
Cc: corbet@lwn.net, song@kernel.org, yukuai@fnnas.com, linan122@huawei.com, 
	hare@suse.de, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 9:06=E2=80=AFPM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> Raid checks if pad3 is zero when loading superblock from disk. Arrays
> created with new features may fail to assemble on old kernels as pad3
> is used.
>
> Add module parameter check_new_feature to bypass this check.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/md.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index dffc6a482181..5921fb245bfa 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -339,6 +339,7 @@ static int start_readonly;
>   */
>  static bool create_on_open =3D true;
>  static bool legacy_async_del_gendisk =3D true;
> +static bool check_new_feature =3D true;
>
>  /*
>   * We have a system wide 'event count' that is incremented
> @@ -1850,9 +1851,13 @@ static int super_1_load(struct md_rdev *rdev, stru=
ct md_rdev *refdev, int minor_
>         }
>         if (sb->pad0 ||
>             sb->pad3[0] ||
> -           memcmp(sb->pad3, sb->pad3+1, sizeof(sb->pad3) - sizeof(sb->pa=
d3[1])))
> -               /* Some padding is non-zero, might be a new feature */
> -               return -EINVAL;
> +           memcmp(sb->pad3, sb->pad3+1, sizeof(sb->pad3) - sizeof(sb->pa=
d3[1]))) {
> +               pr_warn("Some padding is non-zero on %pg, might be a new =
feature\n",
> +                       rdev->bdev);
> +               if (check_new_feature)
> +                       return -EINVAL;
> +               pr_warn("check_new_feature is disabled, data corruption p=
ossible\n");
> +       }
>
>         rdev->preferred_minor =3D 0xffff;
>         rdev->data_offset =3D le64_to_cpu(sb->data_offset);
> @@ -10704,6 +10709,7 @@ module_param(start_dirty_degraded, int, S_IRUGO|S=
_IWUSR);
>  module_param_call(new_array, add_named_array, NULL, NULL, S_IWUSR);
>  module_param(create_on_open, bool, S_IRUSR|S_IWUSR);
>  module_param(legacy_async_del_gendisk, bool, 0600);
> +module_param(check_new_feature, bool, 0600);
>
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("MD RAID framework");
> --
> 2.39.2
>

Hi

Thanks for finding this problem in time. The default of this kernel
module is true. I don't think people can check new kernel modules
after updating to a new kernel. They will find the array can't
assemble and report bugs. You already use pad3, is it good to remove
the check about pad3 directly here?

By the way, have you run the regression tests?

Regards
Xiao


