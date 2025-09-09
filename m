Return-Path: <linux-kernel+bounces-808222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923A8B4FC10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2451174259
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB581340D98;
	Tue,  9 Sep 2025 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd3zxPP6"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67333EAEB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423195; cv=none; b=I/tNLf7v4trzbQCm2MorxrAWDZwpVdw7o3ZKVSo6MD2IXDWlTyuw7tQHhAKyn8DLI0aG71VWQbwFEr4JEFDCVMwmnxA9LvE3a5oDavDmt2sYPvpRl9czLxgQe3/5xgGc3dPqzSXl4HqwmnKmaLqd0ATW3Dtvhv61hiZ6NmL3v+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423195; c=relaxed/simple;
	bh=TuyvGeybEDFvhkMzdveNDYGLiqIQ0+8InSIJvHMcT7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqHoATqPUTXsqhiHBijYbFsAghgFPwM0o03s6+ADieiKXaZrctqx9RvTFiKjeY5iK7diHJHBYh2RIjrPEEpJPD8Epym/VRuyPrXfVhZak1ehVWq/AItf5kEE+ubG5N1iPzPxQOiQZXbxPn4B04kPBCl2M9mJ0ZfE/JExDN+BrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cd3zxPP6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24b150fb800so14187625ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757423193; x=1758027993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCRhKSwPG7CAUIvZCPIlLSCZ3YprR/xiUPz/bvHEoWk=;
        b=cd3zxPP6ADkU4AnxPU5nGSUjj5ECWngRACTcdZV1HYiYB7yA2FjqgICSVjfWPotLL2
         7+967tJfjkl4TzKkXhDHErk8bGD+J4CiVVStKyBpDxrKsgJpIGRdhPY0wJ53ZLT9vS0M
         hQzh2Nkes57THV/quViOuDekFjLYtlaMS5JGSOyTXWqrJCq0BBAaPof/yFSr9arMTwHI
         L8G/tffogUoVQRm6sXR5ZqWDG4KtOmF75oU0CQo5p2SDq8s0feUgRjVMF0Ty3lgOzxVo
         e/KgIxfF65bGE3JJooukcBcglsJUjCi1B1DDT2qL2YA2AsxpvmnOnC27W/YL2Topa+yL
         JSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757423193; x=1758027993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCRhKSwPG7CAUIvZCPIlLSCZ3YprR/xiUPz/bvHEoWk=;
        b=bsjRXlFYahTJ26Pm3L4gfVNcSrkhZ5rjk2OlCFPxSgUI7olDYm5RP2PE5hqYRsLWNJ
         D/0CeCoP3GukJ4Nb2/IcgkxorOcDYWprRm2ttqde6vyuB+gwFajeYk9mYqflgrAi4ELN
         CkDOWJ3a9PmWFbw84cZqaUv4RDke22fy40/DlJ0Pv1W55XRJ0gyAxF32qEDLQf0zfPTh
         1RCkXlB07dgLOxHTl5XgNqs1JSzEuVyiIdlEUMAdejQTSnehax4QE/IDajSUM0Nwt0Zd
         B/Qpz/JnD27/XTVJPdiD5lZxm5aiPWzvVinLscLN5JmryqWnPD2+2vCtfnRSIXwxObaI
         J1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5z1dqRm0qNNsO+nBvbSLySSrSGUA3aCeh2/3zJRJOwjTPhxUdX02KVHb4Qh7l8nUp1fM54RwWEiV1Yek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Le8A6xmUmOXmMZBopfIyO1c1BfIxXuRtjBi+/OgVlZzmunY7
	oWM+fn/m9Z5rSZydbAwu3QwBdZ01JEb23CApphWrhebRDJn8ah1NiNpCal37LtEkkYGVS1dTcxo
	6bJJN6QF0cOfgy+ZIsuVS0pnSS5lWICMMbQ==
X-Gm-Gg: ASbGncvo61ZpEbs3CIqyz1j+uDwOPvwSMoHCmIo5vcUX5HiOua39ucFOD4mgGZ1xL2d
	aysU5Iuj8Xkgo3zkGUdw9sh549/+ybo2aeFQ0xTIzpuaDqgZojjPWkOrRpmymx6dJc65vpO1c9i
	jf57rQI7WJ0ZKNd1Wd/60Qu3SS/IP+QkMG7ImpPv4hFIzKqmCSs20ygQYGNpWB8htBPOMNYKQFR
	dt3d/Y=
X-Google-Smtp-Source: AGHT+IHa8baY6Pl1flgTs6pP2dTZu9WNTAlY3N3JvHJNZ3zkp6rEoHwCNUfHmb5TxMZbd3mIXJZz9XbwZBZNyfQuoI8=
X-Received: by 2002:a17:902:8ec5:b0:24d:5f38:ab67 with SMTP id
 d9443c01a7336-2517653b8f5mr64653695ad.11.1757423192955; Tue, 09 Sep 2025
 06:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908213156.565861-2-thorsten.blum@linux.dev>
In-Reply-To: <20250908213156.565861-2-thorsten.blum@linux.dev>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 09:06:21 -0400
X-Gm-Features: Ac12FXwSeHW2KQ319aeqOCaDVZwYWCXWouptpaWLQeAEdAJOVtD4BE9k9jsqKMo
Message-ID: <CADnq5_PwxJ5ErFrMzAo1ocK=rQi81G9iLMPpPM9T51_txrp3yg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Replace kzalloc + copy_from_user with memdup_user
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  thanks!

Alex

On Mon, Sep 8, 2025 at 5:49=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.d=
ev> wrote:
>
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify kfd_ioctl_set_cu_mask().
>
> Return early if an error occurs and remove the obsolete 'out' label.
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 828a9ceef1e7..5d58a7bf309a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -521,15 +521,10 @@ static int kfd_ioctl_set_cu_mask(struct file *filp,=
 struct kfd_process *p,
>                 cu_mask_size =3D sizeof(uint32_t) * (max_num_cus/32);
>         }
>
> -       minfo.cu_mask.ptr =3D kzalloc(cu_mask_size, GFP_KERNEL);
> -       if (!minfo.cu_mask.ptr)
> -               return -ENOMEM;
> -
> -       retval =3D copy_from_user(minfo.cu_mask.ptr, cu_mask_ptr, cu_mask=
_size);
> -       if (retval) {
> +       minfo.cu_mask.ptr =3D memdup_user(cu_mask_ptr, cu_mask_size);
> +       if (IS_ERR(minfo.cu_mask.ptr)) {
>                 pr_debug("Could not copy CU mask from userspace");
> -               retval =3D -EFAULT;
> -               goto out;
> +               return PTR_ERR(minfo.cu_mask.ptr);
>         }
>
>         mutex_lock(&p->mutex);
> @@ -538,7 +533,6 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, s=
truct kfd_process *p,
>
>         mutex_unlock(&p->mutex);
>
> -out:
>         kfree(minfo.cu_mask.ptr);
>         return retval;
>  }
> --
> 2.51.0
>

