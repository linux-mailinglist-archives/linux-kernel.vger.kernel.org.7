Return-Path: <linux-kernel+bounces-728298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48767B02629
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33831CC21EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1408F21D018;
	Fri, 11 Jul 2025 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/hG+oqE"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B07494;
	Fri, 11 Jul 2025 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752268273; cv=none; b=poUQnABalEut9b0oRFyISRyoFhqF9BpxdPhpmCvROdgv+ArJY9A4JLtQFplM33ADILYo+Ar17HMuR8IeVGoLMASmtk1vYmW6+2Ut9lMLzmnwiai9EAqH1gH6EfQB61Zcm9ylqgFa7L/wcGc5p56o7VoxGA60Z6QJy9jdeHHQt6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752268273; c=relaxed/simple;
	bh=DRCNGoA6QS0bUBkiqJSdhXQNrcY5wxnYm5E39u7q/xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/lXynfjmeifVP6BxA5G9h8ruryp9Q02tBXRLcUfnaE2FYv9y8MzAul9mAe0q1HAQ6ujYEZg8BLoI2/9lE4wW11JT081RCF2axseKZozahU6Oly9gnxe0aymY3jTnKw8DOhwjhnH/PhP1j+YYj/KT0jbnDw1ioZ0uNCv4Hprvr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/hG+oqE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234eaea2e4eso3782645ad.0;
        Fri, 11 Jul 2025 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752268271; x=1752873071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Id33Mh0yn//Z70R8X33hXzajTyy941nJMPZubqNqXg=;
        b=K/hG+oqEZiyTaOx8rD409pnRR2RwM9by8Tn5rTnbhG00fTzu7eO7hezgQL3qCBfooe
         8xhaSNPOZxouvoYTUnpWBHZ3TLl7n04UKJ4q9F4vOWE6j83dVxBqQpP8rfbgqhvM9Adm
         yFaV86L4gUiKsPuyt/Q3AfML3amd8DlzXmWUIYxGyS2AVeUJ20THf7HeRey2fPZtEP0a
         6gGaVZ/aG7RH+kq90DiFWe+oztix1qPi5cE7FfS+WhOzqTtmrhmrL/Z2Z/j06LCYrHL3
         +7NGe14n6hSHtrUfglxfRr/KPeVpA8CbUK/YbO+2h8XXKfdRnBE+GXY66nnoUlTnlRnf
         YVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752268271; x=1752873071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Id33Mh0yn//Z70R8X33hXzajTyy941nJMPZubqNqXg=;
        b=uN4Tz+Tr7uflb+nr7OKz3vM/giET2RYZCbU02AbZDf7icqJA+YiRevSC8cGMX91om9
         ukMuOpykWCf21WzttSQgIXAY7G3Irmf+5rwqOjszl7NA5l6X7NmwJLU/8a7mhjN8LuG1
         UsaMLx+EJwRBKcg3QTdzfoGTq1Uqq8/CxwcKBSCsmCUekChV2dc6xsRSmyge5opT1RC2
         4KRwI45HmXys2iYh4EKRE4sLqiOT88Y39/gl/OCjG4ktWepL0T87kOL6wGBiVcUxhA5m
         mud0wN49C1Und2Pd5DDJ+4LrJw/64YvIMCsM+jxvFORP+VkQ942lEnY/m3ZyqNxPQ727
         dhNw==
X-Forwarded-Encrypted: i=1; AJvYcCWN4Th7UOqScgEYoAE3LgCCxW6fWAmpunIXu8bNlIknj39cqgZWTRYVd9LWn1Bl22vVhLKU4mNBby4Ci+2r@vger.kernel.org, AJvYcCWyd/Zn73yIR1Nqm/uBD6bWo4a1YRrl8Dp11/PXQBqMNlNy2qsdkwtqMOfNlzwJGHUztbruj1UV+Ldbeszx9NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVE4OQpc6m55mBU3UaGAu9xoTMeGEDSuTyeZs/DEwO3p/QDKw
	EpUsKlQ+UdcAJqbvg128hBYKloxq/k0ig+r6dANVT7Uqx3/3df2FRae/+R5xpWzhoK0LLGpJYJT
	7cbNEdwD3BVbCk3kU3mVtrjXiw4JCANJKBQ==
X-Gm-Gg: ASbGncttWmMUS3NC/sLaYQqpLjLrKep1lKpori53hm1asQX/qWVAtHkbKxvbiN4CUkn
	PBlUzeqquesARONKAOR5eNLJiDl4weZ0A3qxP/IPsbWdiAaIW/ZRNZX48x2GbA4bLWekS9ahizB
	aLzY5jV/Z5vJKZvv9Nn2aHfk8lW8hpD5wByhmz5R7heUS0Httofn31DFKW49EE7gobIIoz5HFnR
	v9Qe4bu
X-Google-Smtp-Source: AGHT+IGpJSVp1KJC67mP9tYUlD7o9SFm9SGP4FrEtk5U5U6aBHi9jNnu7oPx4ia9y9djde5+J/vRTWXyDwi9eXTEhj0=
X-Received: by 2002:a17:90a:e7d0:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-31c4cd1cd40mr2250510a91.7.1752268271234; Fri, 11 Jul 2025
 14:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <366557fa7ca8173fd78c58336986ca56953369b9.1752087753.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <366557fa7ca8173fd78c58336986ca56953369b9.1752087753.git.christophe.jaillet@wanadoo.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Jul 2025 17:10:59 -0400
X-Gm-Features: Ac12FXwGI8TSVukgGWSUQp6H1YscPS-pE-fH7frUdLlnr1VDrWuzrJq-3B0vZ2Y
Message-ID: <CADnq5_MX6jkkgKTTkZY=M9btZPdVmSSs9siEJ9E8b=tz21MCZw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix missing unlocking in an error path in amdgpu_userq_create()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sunil Khatri <sunil.khatri@amd.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:28=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If kasprintf() fails, some mutex still need to be released to avoid locki=
ng
> issue, as already done in all other error handling path.
>
> Fixes: c03ea34cbf88 ("drm/amdgpu: add support of debugfs for mqd informat=
ion")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

@Christian Koenig @Sunil Khatri can you pick this up for drm-misc?

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 513bbc543f40..bce97318965c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -520,8 +520,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>         }
>
>         queue_name =3D kasprintf(GFP_KERNEL, "queue-%d", qid);
> -       if (!queue_name)
> -               return -ENOMEM;
> +       if (!queue_name) {
> +               r =3D -ENOMEM;
> +               goto unlock;
> +       }
>
>         /* Queue dentry per client to hold MQD information   */
>         queue->debugfs_queue =3D debugfs_create_dir(queue_name, filp->deb=
ugfs_client);
> --
> 2.50.0
>

