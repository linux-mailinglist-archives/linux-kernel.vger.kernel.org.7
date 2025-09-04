Return-Path: <linux-kernel+bounces-800953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C707B43E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D67BA31F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0210130BF77;
	Thu,  4 Sep 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmx8C5ID"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C22D3A86
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994853; cv=none; b=iVLIa9HV677WmWaFDWcHjw/AN9VEMcVXuVKN3dxiDuavxQ6aJne2F8kA/tXmBUoRonHSJcJY5BOwbEHK8syqpz+IzUQkk1yYcyrvi88XmX2B8A27RO5OEBVEf7q0odF2GCztMgkpzIz0vWsbvH17t7F7CeoNr6j2ZrgDi6DIF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994853; c=relaxed/simple;
	bh=GpLrwpBjFgVZ/+5BOLTD+3omYqDGzzxW7dP1pUXDtbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipF2MYTLI9sW+1GaXHFiGaZCTCeVwmjpwwODdYiMx+9Nk2DY8/+IwB/wDV+Y1bVA+5dIDG+XyI7LYgjN+9spgRF56QZuniPoNf6vORLyqCNoFtROLCvbpD4FAgDWCKoGBK04oBoA4lRzSGmR+beklicQPazrm9mCHz5d/StPdrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmx8C5ID; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24cb267c50eso1571725ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756994851; x=1757599651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXF7lUGlzoUNaaSeGTJ59Qfx95myet4lfZdU71qhW/c=;
        b=lmx8C5IDnGP5p1QmsfSjSuMMpyFked29UfBj0ZNYjTwwHq1LFiL+i5H+ac8W8++oKt
         1v06+mgGEpZ+V1D1+hMNWaMg3O22c+TPOGE26iTH59vrYs3bTndxIObZKEhVUdfhh4P6
         /mefpVZzYTUxUPi6eoTfy3f5XMTwqXbMxVBhnj5dCjyeqrehccwpgdJwe5Dvh7OPlWU6
         yRX13SNY8KS7R43vLcxlLCDs/bq8jCxyX9uawpoB7l7QLKbYy3RDjMp6IPKA0m8N0z0P
         xL4akY10Q+kFIFqlL/6oKXzPuNDyz6CZtNLyHxk9mUnhuz1fPj3IhezcpBtVyPv9EJQB
         BFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756994851; x=1757599651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXF7lUGlzoUNaaSeGTJ59Qfx95myet4lfZdU71qhW/c=;
        b=wVbrGXIZ7WkLgWEw/326CPJsx0RN7qkxXrZH12jswlXoqTWqD50mTQP25UFARS9fLF
         J9m9SjlA4UeIowNjfqSfo9NJ57fHq6E9U2Df0dbYkVASqg7rtiyrLAEsk//xZwRiubO8
         Tyl9mb29ujSsgu+eAkF08Nilo/OcZODPDYaaYla1Pb8oGSC9G/oNwGZrW0MqDRLL07hV
         h2ed58uWQDr2ThecAn5kLQdaYeePSMbiRjtiRg73ZAL3BJJXaTO3jjhFTXmnAgMahCdU
         g7YWJ/07zpqPUWW9xLuQwO7W25aI0w7GGNuO0UfgfUdUa+Akepa1f94IlHSqS7rrXvrZ
         3QKg==
X-Forwarded-Encrypted: i=1; AJvYcCVOzDQ7Ob6tzcmUXZEnAKDYzLcKTwBEhIGqSUNC+q5poSRnw0nMRJKEikyTq27ZkdEHdA0L3sG3g/iJ5FM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi4P5c//8N15nExvzC727x3ljKoA+jb2kdsxM4ApZcoJVSSlqF
	Fz+kFjhTfMezDxJpFXC7jcx+EEd8PfRp/ZI+24c2iAsA/UuyXtDitsKipOAn7eqFI435NvjW4FT
	wrBx942EjHHbsyPAqKazWau2LEwE3FNM=
X-Gm-Gg: ASbGncsoXZHT6qF+jCNXWGXiioD77l1DGbQ+TbM96W7zqzaty1HMZnx/hHCYnTAZvMn
	dpqUr/5rWD0df3gGKu7rF6S12PTWT+dSeXZr1NIP2bYnI9Rg7fvm/OZJ6unVJJZUO2OdT0VK5Yu
	77y2wj5/jRZxpyvR6vrOXmLS4DuWquddwdmd6hLbRT0ugk4ehgcrTQJ6ljn6s+wu73uIpRwwAst
	JIGrMcuIwFmcxsvyA==
X-Google-Smtp-Source: AGHT+IH3MY/OTockoauDSyOp/l19fy2ykBd3RlTZfyNT0ABfjsmLAysxtPRcG50Q0m4OIHq4m+LRitinGGXWpfoiUgE=
X-Received: by 2002:a17:903:22d1:b0:248:8a31:bf6f with SMTP id
 d9443c01a7336-2491eadb922mr166015585ad.4.1756994851019; Thu, 04 Sep 2025
 07:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904123646.464028-1-rongqianfeng@vivo.com>
In-Reply-To: <20250904123646.464028-1-rongqianfeng@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Sep 2025 10:07:19 -0400
X-Gm-Features: Ac12FXykgD4aIBzDItZHcqzk1vdrpEvCwQuABoCP0-tmsZGt2PPBgJYPMj3ZoqA
Message-ID: <CADnq5_N=hQH9OGp2GfdPeOq7V2B_UX0VCDQ-XcTDroy-WHRmyQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix error code sign for EINVAL in svm_ioctl()
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Philip Yang <Philip.Yang@amd.com>, 
	Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Sep 4, 2025 at 8:54=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.com=
> wrote:
>
> Use negative error code -EINVAL instead of positive EINVAL in the default
> case of svm_ioctl() to conform to Linux kernel error code conventions.
>
> Fixes: 42de677f7999 ("drm/amdkfd: register svm range")
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index 521c14c7a789..68ba239b2e5d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -4261,7 +4261,7 @@ svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm=
_op op, uint64_t start,
>                 r =3D svm_range_get_attr(p, mm, start, size, nattrs, attr=
s);
>                 break;
>         default:
> -               r =3D EINVAL;
> +               r =3D -EINVAL;
>                 break;
>         }
>
> --
> 2.34.1
>

