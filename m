Return-Path: <linux-kernel+bounces-808289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0911FB4FD91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D241889D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1A834166D;
	Tue,  9 Sep 2025 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+8otUxe"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C321FF24
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425034; cv=none; b=t2zIlpI6vb0/IrHxTSku6Qbs0bAVea+s1qAruTKTZ3JPCyFJaAy+Zq6EfXzFK25Bo7/pIHd+EDmHFS/F3VEMhjP2zwjC+05NrntFltOCaqh10R8zRiu93U+NFkDJaOssqqN7V6Ls0hjF9LqoAElqNBQ/FtuEYWu334VLn3kFNjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425034; c=relaxed/simple;
	bh=1blQW6ZI4tDED7PddKag/weDoI9defs5eCmMBD39vCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWrybXzQXxts5oex68/yOLFE86GtYre8/RaLkFeOGcRAe7UyRNEyxH6iAC0hfuraDFfrqHbNxOvchR4vANjUjemcPLo6H3ysPVLq/0PWwQ2dlNpTmq3jsK61syxd7QVS714vgfB5qgsO5Y2x4vFXc8RFogGG4dIaFBjFvVWWV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+8otUxe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24b14d062acso11031365ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757425032; x=1758029832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tObwF+Z08H79MDMKWC6zGt+hFazMP8SQpHHt/ZJ99zc=;
        b=f+8otUxewBsC/pfPKDmc/j5jEofFX3UQndLtLA6Rm7ZBemTfzCxqqytWHxwXm0MajN
         D+nS2FIFpVBPs43PT1pymh0+onxNRAfEACmkc0dSMKb0EW8WLPkCgisFmrv1/AqysUue
         1GpwhedsZtvD310I5DP0UzGe73nweKnwqDgrOYRtbg8Rj4oYSy1V5U28r14iZ2ZD138k
         b5EB3E/y3APAGw6dG7nMQWqv7LGhmY4r5oAqFAb/NxtNdFh3N4tu8P5uslXpFE5e2dnH
         4DLOZvkLAj4Wa9JhcmZJ5mng+RkVl26Y0T+tvjN3AJtmLpjyWWmKu1iBv+YpKzyrnTOV
         Vylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425032; x=1758029832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tObwF+Z08H79MDMKWC6zGt+hFazMP8SQpHHt/ZJ99zc=;
        b=EyD7nQhRGZcOgtAGqPuLl8P5GYepy7YNflvR8q+ww0WFOBu7HvWbe0+6KfqWmf7OWj
         ZQwlrKj7GtUpjlft3oHv2je7HRBQ8YooN2q0KlQI1lzih0IWnmki9PHSxvtJ8JEEGg2a
         wunXn4qdum5Hlt9vSZnVMn6+7shyKav3y4dcasdOVzwkG6O6momz6dh386t0oR6Xxkj8
         rv3nZzbp91PdVgKZhdXSksSRJMlwu0ywxjottecWNZtrTnTxEjyTEpi9WwQt0RCuEV6l
         ncm0Di5Ae7t+/Kx8M1fI76WedHV6Jix4JiP+RhE0jI/h28LHHA739W3HS/pJBPVhbiiG
         F8fA==
X-Forwarded-Encrypted: i=1; AJvYcCVloNJB21cLLEw8BzWd4qx1lJ/P1lQOnEmzXw+fQR3dixey/qzcy52t+IXfet8au3OF0/BjvePHUXb72EU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlq+TjTnIO1588ddbzf/rV3lrvmj+g2TKBgHq7YtnnRmCDOx1G
	PDp2MmD3tR9RWJRPwbh2lNeRGM4ZbUCO4NRqGrOMRFVqTBMNHtRK0MvtgEr/zdFu6mVRrf2LvjZ
	zeiP7wSV54/Swjq5fIrGGCrkf/IlSGN8UNQ==
X-Gm-Gg: ASbGncvy5QuuPRM6POSJaAjkgv5TYSs4Z7pO5nsgA+cCsZ5aLOgwMdA3dO0PJChbST7
	ARK8dfzs0eucJepF4L3YHemcejoNyK526b9QaVjI8I7rcdNCKC1zPC2l3f1EN0wFpMUtigT+GOq
	9DLp3gc8uJSAG4CkiImZ0+3unn0PWf4nMDL3XiTV2+qXAtXMyuEsebBDcL4IlzmvlIoQQ9sW5rE
	PE7ncbfysDRiJU6mg==
X-Google-Smtp-Source: AGHT+IHOvEUNBPtasBBqDVGrC3boG1QFPoLsPBUKZG/vU4sKHUOzXJ8cpzdtz7sFr+UjNvP3nBS1m8FRoIPx0JfHBlk=
X-Received: by 2002:a17:902:f682:b0:24c:b6b6:e54c with SMTP id
 d9443c01a7336-2516e4b07f1mr82434165ad.3.1757425032140; Tue, 09 Sep 2025
 06:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908211559.519892-1-thorsten.blum@linux.dev> <4005498b-d866-4e41-a8a4-d8228b2062e7@ursulin.net>
In-Reply-To: <4005498b-d866-4e41-a8a4-d8228b2062e7@ursulin.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 09:36:59 -0400
X-Gm-Features: Ac12FXw7muqg4kVuUdM_LumdYu1y5udy9p_-qPeA0dWyuOGO6hI58DbsamVKYbk
Message-ID: <CADnq5_NDrq_S7rcpr6_MY-USfVGr8-QcJ2hqnai7VEm5D_OyxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace kzalloc + copy_from_user with memdup_user
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 4:17=E2=80=AFAM Tvrtko Ursulin <tursulin@ursulin.net=
> wrote:
>
>
> On 08/09/2025 22:15, Thorsten Blum wrote:
> > Replace kzalloc() followed by copy_from_user() with memdup_user() to
> > improve and simplify ta_if_load_debugfs_write() and
> > ta_if_invoke_debugfs_write().
> >
> > No functional changes intended.
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 20 ++++++--------------
> >   1 file changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_psp_ta.c
> > index 38face981c3e..6e8aad91bcd3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> > @@ -171,13 +171,9 @@ static ssize_t ta_if_load_debugfs_write(struct fil=
e *fp, const char *buf, size_t
> >
> >       copy_pos +=3D sizeof(uint32_t);
> >
> > -     ta_bin =3D kzalloc(ta_bin_len, GFP_KERNEL);
> > -     if (!ta_bin)
> > -             return -ENOMEM;
> > -     if (copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len)) {
> > -             ret =3D -EFAULT;
> > -             goto err_free_bin;
> > -     }
> > +     ta_bin =3D memdup_user(&buf[copy_pos], ta_bin_len);
> > +     if (IS_ERR(ta_bin))
> > +             return PTR_ERR(ta_bin);
> >
> >       /* Set TA context and functions */
> >       set_ta_context_funcs(psp, ta_type, &context);
> > @@ -327,13 +323,9 @@ static ssize_t ta_if_invoke_debugfs_write(struct f=
ile *fp, const char *buf, size
> >               return -EFAULT;
> >       copy_pos +=3D sizeof(uint32_t);
> >
> > -     shared_buf =3D kzalloc(shared_buf_len, GFP_KERNEL);
> > -     if (!shared_buf)
> > -             return -ENOMEM;
> > -     if (copy_from_user((void *)shared_buf, &buf[copy_pos], shared_buf=
_len)) {
> > -             ret =3D -EFAULT;
> > -             goto err_free_shared_buf;
> > -     }
> > +     shared_buf =3D memdup_user(&buf[copy_pos], shared_buf_len);
> > +     if (IS_ERR(shared_buf))
> > +             return PTR_ERR(shared_buf);
> >
> >       set_ta_context_funcs(psp, ta_type, &context);
> >
>
> More complete than the one I sent in June^1.

I never received this series.  I didn't see it in patchwork either.
Seems it never made it to amd-gfx.  Sorry I missed it. I've applied
the applicable patches now.

>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Applied.  Thanks!

Alex

>
> I had some other in that series, not sure if you caught those.
>
> Regards,
>
> Tvrtko
>
> 1)
> https://lore.kernel.org/amd-gfx/20250612104430.41169-1-tvrtko.ursulin@iga=
lia.com/
>

