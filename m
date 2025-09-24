Return-Path: <linux-kernel+bounces-830616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 343E8B9A1F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C780C19C7EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E71305962;
	Wed, 24 Sep 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="X7IJvaid"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A632303A1E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722162; cv=none; b=hu2zl2u6iUXhMSAxVNNmMEP7jQEBix3E3xno9Uj8ku6GPTUq+2J4SOyyaAktrRorNtDljOVAeSdEH5Rm8MpB+DebSE1u7b900Ok5VB0IvV1eZ4oUNuE0qiLrDrqvfTOUPmE/JGJYBYPfScd+kYO5hXHZ1Cmur7x4pmuzPVh/0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722162; c=relaxed/simple;
	bh=ujEzAbhMAzaWS5a8Q68eG96tR7K2Da3jAUXEFVNDAhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyIh7j0hODwn69T0mbVo+fjW/yXTWqVZA/znXsDy+vFXBWXGctX97mDhbh6h7KX4n6xdC+0bRTZFgokX5tb9SRodR4M5dPBc4Klt/A0a35zmOBzz1m9NFGacd4XSOV+zAXy+PW8F+J0tzKX5sGjEcbf0VCiaiLpgIaJIPmCjLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=X7IJvaid; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3306d93e562so6143614a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1758722159; x=1759326959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4DZQg31vv1EGe7YHwiBVuSS1/ZU1wpTEBVNkfgNEhE=;
        b=X7IJvaidIVJzNA37xf/lQKsQrDx/QbP2hbS+ce6GeBKaOkgooZYFWN4Hd2w/8s7eHR
         6BCKGbCuMfbgIV2ODm6wGipb/9YO/FDGa4xq5MM+uHAzhJy/NHtGWMYVbsuY4mcMS9p5
         oHYdqfGdWkAunGh7DqNHzNdusIAxJo1B+YNpPB+YJhGxB1EpI7oz0YyuixrK96AMfkGG
         FQvmofzA1lOAICZxHZiyqfxvA91FbNa0fmZLEL7fV/kmfSez+0ITvBsAzxzfAXt58sun
         DerlwwnMB2fD2e1moSeHVPpnsfr/5tjvGhv+PMh+bErWYLnhGyyTfesKKPNqEP81oBxM
         LwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758722159; x=1759326959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4DZQg31vv1EGe7YHwiBVuSS1/ZU1wpTEBVNkfgNEhE=;
        b=vvZ1rI0LpEYM/ADg9GqcZCj6XFZaz9R4gMbZ05d3zOf9ZjEiig3yiBw9n5/v6d4XCX
         EjMUMUMVai7l84mC77DWaTsSt0Nahib2TlUhodWYdOMMlXD5M7+2CUy2b1eaj1lpCsFu
         nVqysZid8MVs8jz1S5gx6HY6aWEuRmCSEDLQlcRwO8ht6v4XnKBv2qK2CIgnUJn7Wy6A
         FPajCZ/huptCOrkl/08twsrnB4oiONTcaVAMgSFGyFOJompEOlxeJiZCtEOjYkjP8N18
         9POV/A9QJjgz7cOKyluR789HesZcSNXyBKfQbXxcik50g8ZGbeIQ3zMqZQUQ0th1LDu5
         9NsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGfof4k0ZQI2QXrhvP1DUOiexXJHNTg9ZUVSl0CVu/gLcQiYPBDgTGRhlLbrnQ24K5kSsR5W894lzcVAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUABZvz+n5lItbDvDGabL69lRCn8Q7XM0hCXBhzpPTPUDaKPAR
	zun2dhO7L0nvvMULVqyrEXlG+965Bd6inlv4Faz1+Ai4tuVKdTgJp0Bd/jzvyJwORq9YOyWEXf2
	Lm1a5+opCQEcgn2jbWg+Ejh58OhMD8jYgnvPnb63g
X-Gm-Gg: ASbGncvkAlqD/XrZ6rmtGnsNHVm38jV1u9kFPcPftwAch1P/swsFZYUx+vNvIFrvxPm
	oWo7FH9iaCp2ocCsoQ6x3GV9GTdRvMaeOvgYHddIQOozSREPS2yKNXgXeNLhNWnvj5pNv5xUHQo
	d8ixm9IEzrdMQrELrKZBt6otC4hfUeont0Wqoe49zhfZpRAWiYwp9iUzAkSaHHFT8u71mhdnBVd
	SMGVQv90axncp+hHmw=
X-Google-Smtp-Source: AGHT+IHXbY4TxwtVWknJYQ/5Bht7+LECqN/91gP590u8montoaQ+gGtcVF5NMOWukYG+NKgo0+ZGo6Sxvl/LKJemuHI=
X-Received: by 2002:a17:90b:4c45:b0:32e:a59f:b25d with SMTP id
 98e67ed59e1d1-332a9705e25mr7813584a91.30.1758722159437; Wed, 24 Sep 2025
 06:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918150811.259596-1-thorsten.blum@linux.dev>
In-Reply-To: <20250918150811.259596-1-thorsten.blum@linux.dev>
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 24 Sep 2025 09:55:47 -0400
X-Gm-Features: AS18NWBdTWkiF1IRVXYt0unyFSpP7neFh7jhnbWQjRR_W61SWXUjoIYrMw2FMpM
Message-ID: <CAOg9mSTEV9A7s_MYK+msgJRzvUS_R6FB+dOvvkDOmeDrUH92Wg@mail.gmail.com>
Subject: Re: [PATCH] fs/orangefs: Replace kzalloc + copy_from_user with memdup_user_nul
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	linux-kernel@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, that looks better in several ways. I ran it through xfstests,
and have added it to my linux-next tree...

-Mike

On Thu, Sep 18, 2025 at 11:08=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> Replace kzalloc() followed by copy_from_user() with memdup_user_nul() to
> simplify and improve orangefs_debug_write(). Allocate only 'count' bytes
> instead of the maximum size ORANGEFS_MAX_DEBUG_STRING_LEN, and set 'buf'
> to NULL to ensure kfree(buf) still works.
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/orangefs/orangefs-debugfs.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugf=
s.c
> index 1c375fb65018..79267b3419f2 100644
> --- a/fs/orangefs/orangefs-debugfs.c
> +++ b/fs/orangefs/orangefs-debugfs.c
> @@ -440,14 +440,13 @@ static ssize_t orangefs_debug_write(struct file *fi=
le,
>                 count =3D ORANGEFS_MAX_DEBUG_STRING_LEN;
>         }
>
> -       buf =3D kzalloc(ORANGEFS_MAX_DEBUG_STRING_LEN, GFP_KERNEL);
> -       if (!buf)
> -               goto out;
> -
> -       if (copy_from_user(buf, ubuf, count - 1)) {
> +       buf =3D memdup_user_nul(ubuf, count - 1);
> +       if (IS_ERR(buf)) {
>                 gossip_debug(GOSSIP_DEBUGFS_DEBUG,
> -                            "%s: copy_from_user failed!\n",
> +                            "%s: memdup_user_nul failed!\n",
>                              __func__);
> +               rc =3D PTR_ERR(buf);
> +               buf =3D NULL;
>                 goto out;
>         }
>
> --
> 2.51.0
>

