Return-Path: <linux-kernel+bounces-799334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96AB42A25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602421C20045
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECE02D8768;
	Wed,  3 Sep 2025 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+52NANB"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E52D5934
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928817; cv=none; b=kyoHliZlR6qEo2NQbdReK6rqiyTouqoQOaBD8c2QOl5U472GvF3W4eK8l7tQ1ddwu4TYWNd2UZtpP5NOKXlyv+DvJj24PJmoS/4WK2wGqa0BwTmjk/eUUxEPdOkL7XsUncRzxFDWN62lxtbrYEfz/jgrkzFC1kkuZH0Zn3KsiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928817; c=relaxed/simple;
	bh=tFTzpjJdBkLef5B/TfWDsoEETyiTmj5etTuFyawPORc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBeVywYZzVURLDk5RIuFuyxbyXxCiJbiCJFAnxjS6qtiBkDS349JiGkQC2bDTJ+ZWH1fh0kGfNwrH6S/i4aRrZX8xyv/8Z9RIgXrJoZKbJTrurq3ZfH8sNA51usnp5o8zzDlfUYRBMh0AuzA/kqBEPMtMziERHOIpXNpDMDGg1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+52NANB; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-723bc91d7bbso4061077b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756928813; x=1757533613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5od74mLFZlQQf0hFrtRdWyouIXaQ5M3HxcPQ0ujElI=;
        b=R+52NANBahVElEnjLBnF50elbs1cZonV3orSfLyUmRbWU64jQlgGjD+9nsrEov8R4X
         3J3wQ/38HWDThn49AQnAxPKMrdHxENTQHgNewfLFR2esbRHDiyyxEJkRVbDZ5ivK8VE/
         tENg/lSIRgaxLS3b2PJzHY5MndYIIMB5m8Q2I7resbiAwL30gNW78Njr0tdKkbzQdUuP
         Fb8/tmEogNpHS+o35QTdyEqLWD8lTUo1iBT49SZDUyfJWjW8db+ABOT2ODn/RVByanIU
         n7I1iyzTK7FaNwhZLfnZhJOg7NKIePgsroPQKIdL8Jv4Zq+aaI3BG7jIKCwQizgCA+Rq
         jUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756928813; x=1757533613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5od74mLFZlQQf0hFrtRdWyouIXaQ5M3HxcPQ0ujElI=;
        b=V/HjG3O0FEQG+gV77k+27P4IuF3JzAU4Hl71xCNpC9dRUGt1Rfzrw2mqi9X2LZiKrt
         BcUtpWOLhW1sb6mJe9FWhpw1Gw8pSyq1VpRc7d8Vw+9/x1k9yyBpgTVGs+8KJ7VXtDpP
         JMwzHv87/ZxoJ4VAWhHUetHUPmrzPvOue9comuyQNA0LvpF+hHCTy1hNqVAy48Za+KoK
         yo3e+s2ZdAYLaodITWqVhJZdoozS3SpJwUUS2k263HSfh2TTfvCvp96vZxKoFcmA0Bwv
         5/rSsB+LRfUTP3srOUec16RYIATaW7OBbxhCDz6VFBV4qegZnLDg4YQkW7vNlb+5mHDS
         BzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrNQ+waZlV5SsSAJ5VLrKQwGPT+7aZQ7ZpeT4ymaV3srSu2KJsIMPNpwFiwEE0whSWB9EVFWax23Pd8Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31oYWTScT+ugczBeMtdIgP5voFmFzDHmv8YgjfyL2sO+O17ZE
	HOnuEMAnoYmS3/WYzkNLwWiP1iy3pQgze7raQWQzvvqlzU4O5yZkqegoCJ1Mg4bxc8nGDqdYPED
	hsRBMydRPooF6kWnLh9I542LyjD2smu1NJiyW2R8=
X-Gm-Gg: ASbGncuE3FUOaDRZENtRu/NTlg2R+ISAjxe43Hq0Q3GkR33IP4XQdINXXOR0Atns27w
	Xa6YIu4ZHLtz0SCv5Q81wKGHdh+YibGOOkwtgfYnOfHm7FbN4eDbnTeF/FY278fvb2NNmCOZY39
	/7uK8L4bDaaBtufemOz+OSJhW+R+341MW9LOuegQp6yv6Tyucb4VAWZKg+xWeqX6cYHBCdOlst9
	teVZFCaO1DmpSP8TvEogspEJzuMx5ElU7XZheEtV1b/CGKUIjJFLPv1MP5ZLBKSV3IRnN9tCoDy
	Vbaiqz8=
X-Google-Smtp-Source: AGHT+IHW/zzUlUw7jVKGPf5C0aeJ3GH+vA7Bnv7W8RJK4G9Zh/iWqclj0Mq4xg+/rSEnU15kMtnjVt9kU4oXenhl2pI=
X-Received: by 2002:a05:690c:6089:b0:71e:7d37:9ab6 with SMTP id
 00721157ae682-7227635ccafmr177468437b3.5.1756928813410; Wed, 03 Sep 2025
 12:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828200116.3532255-1-olvaffe@gmail.com> <20250903184642.62183125@fedora>
In-Reply-To: <20250903184642.62183125@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 3 Sep 2025 12:46:42 -0700
X-Gm-Features: Ac12FXyAGfht-Rm7pLSHobH_nH7S-PexPoJxgWfFenJTwLUYifftYfrNrqSozIM
Message-ID: <CAPaKu7ROxE-7bSp3q1Nf0rz-gVUGL7v-QPXWEhB4EQhjqvP1WQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: check bo offset alignment in vm bind
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 9:46=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Thu, 28 Aug 2025 13:01:16 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > Fail early from panthor_vm_bind_prepare_op_ctx instead of late from
> > ops->map_pages.
> >
> > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pa=
nthor/panthor_mmu.c
> > index bad720f23eb70..6dec4354e3789 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -1222,7 +1222,7 @@ static int panthor_vm_prepare_map_op_ctx(struct p=
anthor_vm_op_ctx *op_ctx,
> >           (flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) !=3D DRM_PANTHOR_V=
M_BIND_OP_TYPE_MAP)
> >               return -EINVAL;
> >
> > -     /* Make sure the VA and size are aligned and in-bounds. */
> > +     /* Make sure the VA and size are in-bounds. */
> >       if (size > bo->base.base.size || offset > bo->base.base.size - si=
ze)
> >               return -EINVAL;
> >
> > @@ -2447,7 +2447,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *f=
ile,
> >       int ret;
> >
> >       /* Aligned on page size. */
> > -     if (!IS_ALIGNED(op->va | op->size, vm_pgsz))
> > +     if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
> >               return -EINVAL;
>
> Now that I look at this, I think we'd be better moving this alignment
> check to panthor_vm_prepare_[un]map_op_ctx() to cover the in-kernel
> users.
Yeah, it would be nice for this to validate for both, but it looks
like the patch has been pushed.

panthor_vm_alloc_va already validates for kernel space so the
suggested change is not urgent. Besides, I feel there might be other
missing validations. Perhaps we can wait for igt tests[1], expand
them, and improve our validation story more systematically.

[1] https://lists.freedesktop.org/archives/dri-devel/2025-August/521887.htm=
l


>
> >
> >       switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
>

