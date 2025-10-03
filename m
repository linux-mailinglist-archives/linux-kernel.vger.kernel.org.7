Return-Path: <linux-kernel+bounces-841517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F4EBB7920
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17743B38F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960562C21CB;
	Fri,  3 Oct 2025 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN/n2xkf"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263BA2C1583
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509339; cv=none; b=A1Kkq+s3rjcRWqj1FBoxg2saODK06vJy6gkU7Fe5O45CQsY82V0ncxnnV/lzOmQ6QtavojtrePM4SZbMyw+9bNgAeC5nYc0MQW2WrROk8V9KzOL4k4fJF/z7CaGDw4pLYhCxVcN7gyrrdMJZ3XASTmeFTb7j9yiJ5aWcK8hzNdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509339; c=relaxed/simple;
	bh=wY38cPr8CJMKVUZ5aHcinltVTuwl8j8UxFR895M6Hso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upVS4ycg2AzUC2HU2iMciwSoRxkVMvdxnhmQiPlB/sU7eC8nWelx8BAdfSTeasgtcGvdpBM7s8+eVhz7h7Bj1D9ZMVg0Gx2qJYoer1wqTWIVMlpKwm7/sYvkSZ8TpuyDF58Ea+uywUorp5C04+7HpuqAeNaB2ZdFDGP2Lue+wyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN/n2xkf; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-62bbc95b4dfso2632055d50.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759509337; x=1760114137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNSO+944ZR2H6x5RKg8sRR6z8l/HHp3toady+ufsnF8=;
        b=LN/n2xkf58yaH8zkc6C9Jf5NVTxTP4sembpO008MAZOGrm2uYznO+vBtbXgnS5ytoN
         1D54TQhfvApxPrCTh+Wwd0nLra8SV+Z8eAWmIrwpvCjQbXdKiBooTiU8Q5ynk2fjC2Nz
         NliHDVqo1dayMzvf9ZMoNL7ZFUVbGdF6kgN19gPtzyEZEOexhAsPo1sK19c02wy4/2/R
         zX4OMlfjg3QWLHEN7DVP5AT6WoMGFsIypENG7dhYdYNY+tjt5GoaOJKzjxNNTRpRj32G
         PMjs5mf1T/ZR6dr6ad3KHq8HtO0J9ONpcrWehhHq6TJ+x+tIMSnf+2k/i7wtsI3f60E2
         f0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759509337; x=1760114137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNSO+944ZR2H6x5RKg8sRR6z8l/HHp3toady+ufsnF8=;
        b=UVBsYLT3HC2zczCE27sTgXOUUk52pp6s8X/7ma/fjwaXtUXUnK3RdPCRmekba9/lME
         SCr7P4cxHbjYT8QSk/FNV8HVUDntSSH/Fachh4nOgcp3EmmL9HSjNT//nIZ3eCPPL9WA
         MwX9tHeRJTWAWARMqe31md4AmzLYUbmijL3XPPMI3qgnGt6AgcmFDorTEd6QwQPstSIe
         jlFnMjtldTxMnDyzP5x2h+B4NCruUaOU+bnmMUZT+R51/P0H/Ann4/MuCnR+PVq06I39
         jiCj/AqKbXqZcVgwL65Ag3dnidOilzmXk29il7k4LROLeBD19eux+K/VqDdvnh36rY4U
         M8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVDx/5tcKg88gFIlQGAntcCZctVtZLdLEVaSDFDhsgYTQGE7fbd5vqxIk9XQFGCVRJYYEQv8AUhYsLdTCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznqtmq309uw73vTrv9JHoNl1kGvmIwdiR+AXxW5/xusTwkAJxJ
	FvApQHsvrSDBbEGlVVDpkbhV4eASadjzm+CFDj5zoQ/6kte73pN7VgWS6dL7Vr2is9rwmLpTDWC
	hbIhuqn/uHJeVgJqidWo/O8/KEr5Q1Ro=
X-Gm-Gg: ASbGncsmRuXDlgfU+NMtZBQB5BKhh+B7ovDdp8KkVm2TDJK6Wq1SBsP+BkZ9bLRHJcm
	JI3ak/9DoRKUuoMCXZlsR8zCr39Cmn4pYcJcIIe1kqG9L4ZBAFrmJAMHSKQYlg4H5ehQbyqXxA+
	OT6kG40QT+DyJzZ6NV7zFUfeeoKskFg9Uz9QlcFItoALJjEinEr7t9xEquJ57pmXywea3hVK4ib
	8zYc0RJfQdWcc0zKbMRf3cU51uQD9jG72J5o5kXVIcyLQ98CPbQVb8d2WqoDkJ6kB3R0epTqx9r
	Q9VRwKqhu0PQTYu4mtk/wX0R5T2yrGmn
X-Google-Smtp-Source: AGHT+IHv72FMSXkyo1Fp7W5d+5WY2maMzjTcyLcOZbJPZT49yNwAD+A8OjRUQe+ZgQqP+MgTmfVLfnAqYIUnbWaYqqc=
X-Received: by 2002:a53:8605:0:b0:639:41a5:cdc3 with SMTP id
 956f58d0204a3-63b9a107debmr2834822d50.34.1759509336837; Fri, 03 Oct 2025
 09:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916210823.4033529-1-olvaffe@gmail.com> <20250916210823.4033529-6-olvaffe@gmail.com>
 <ca22f80c-c233-4030-81d1-f425b8c1fb83@arm.com> <CAPaKu7RKDwpSqJ6u8mjcc4G0Z-T7G1LxFw2rXQtxgSW=1_-jkw@mail.gmail.com>
 <25333c43-ccd0-440d-885c-19c5f54d315a@arm.com>
In-Reply-To: <25333c43-ccd0-440d-885c-19c5f54d315a@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 3 Oct 2025 09:35:26 -0700
X-Gm-Features: AS18NWA2kPrwB1YCHLvLxzk2yW_P1b_E5W8thcxJvwpGrAwH92eaWiAlkEjvvII
Message-ID: <CAPaKu7QMwry6dLGignDZg+C38DGV=iGv1Y3Dv5nNagNwp7OHEQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/panthor: rename and document mmu_hw_do_operation_locked
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 7:13=E2=80=AFAM Steven Price <steven.price@arm.com> =
wrote:
>
> On 03/10/2025 01:31, Chia-I Wu wrote:
> > On Thu, Oct 2, 2025 at 3:41=E2=80=AFAM Steven Price <steven.price@arm.c=
om> wrote:
> >>
> >> On 16/09/2025 22:08, Chia-I Wu wrote:
> >>> Rename mmu_hw_do_operation_locked to mmu_hw_flush_caches.
> >>
> >> This is confusing, you've renamed the _locked variant and left the
> >> wrapper mmu_hw_do_operation() with the old name.
> > The commit message says "rename and document", and I try to stay true
> > to it. I could certainly squash some of the commits to make this
> > series less confusing.
>
> The idea is to have commits where the code change makes sense. The
> subject and commit message then explain the reason for making the change.
>
> Squashing the commits isn't the answer, but you need to explain the
> "why" in the commit message. I believe the reasoning here is that you
> are going to get rid of the wrapper in a later commit ("simplify
> mmu_hw_flush_caches") but there's nothing here to say that. I had to dig
> through the later commits to find the relevant one.
>
> >>
> >> I agree "do operation" isn't a great name, although "flush caches"
> >> sounds to me like it's a function which does the whole cache flush dan=
ce
> >> in one go, but it's still the same "one part of a cache flush operatio=
n"
> >> code.
> > It gets the name from being a wrapper for panthor_gpu_flush_caches.
> > Which part of "cache flush operation" is missing?
>
> Well "operation" is missing... My point is that a function called
> mmu_hw_cmd_flush_caches sounds like it handles the whole procedure. It's
> less obvious that it is only doing one part of the operation, note that
> the description you gave is:
>
> >   * Issue LOCK/GPU_FLUSH_CACHES/UNLOCK commands in order to flush and
> >   * invalidate L2/MMU/LSC caches for a region.
>
> Which again is misleading. It issues *a* LOCK/... *command*. Just one.
> So you use it as part of a procedure to perform the flush/invalidate danc=
e.
>
> Sorry, I don't mean to be awkward about this, but renaming various
> things means I've got to remember the new name as well as the old name
> (when looking at older commits/backports). So if we're going to change a
> name we a good justification otherwise it's just code churn. Note also
> that we have very similar code in panfrost (panfrost_mmu.c) which
> currently has the same names as panthor. I'm not exactly happy with the
> duplication, but at least if they have the same names it's easy enough
> to reason about.
That's very fair. I was hoping the new names are objectively better,
but they clearly aren't. Let's drop the series.

>
> Thanks,
> Steve
>
> >>
> >> Thanks,
> >> Steve
> >>
> >>>
> >>> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> >>> ---
> >>>  drivers/gpu/drm/panthor/panthor_mmu.c | 22 +++++++++++++++++-----
> >>>  1 file changed, 17 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/=
panthor/panthor_mmu.c
> >>> index 727339d80d37e..7d1645a24129d 100644
> >>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> >>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> >>> @@ -622,8 +622,20 @@ static void mmu_hw_cmd_unlock(struct panthor_dev=
ice *ptdev, u32 as_nr)
> >>>       write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
> >>>  }
> >>>
> >>> -static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, =
int as_nr,
> >>> -                                   u64 iova, u64 size, u32 op)
> >>> +/**
> >>> + * mmu_hw_cmd_flush_caches() - Flush and invalidate L2/MMU/LSC cache=
s
> >>> + * @ptdev: Device.
> >>> + * @as_nr: AS to issue command to.
> >>> + * @iova: Start of the region.
> >>> + * @size: Size of the region.
> >>> + * @op: AS_COMMAND_FLUSH_*
> >>> + *
> >>> + * Issue LOCK/GPU_FLUSH_CACHES/UNLOCK commands in order to flush and
> >>> + * invalidate L2/MMU/LSC caches for a region.
> >>> + *
> >>> + * Return: 0 on success, a negative error code otherwise.
> >>> + */
> >>> +static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_=
nr, u64 iova, u64 size, u32 op)
> >>>  {
> >>>       const u32 l2_flush_op =3D CACHE_CLEAN | CACHE_INV;
> >>>       u32 lsc_flush_op;
> >>> @@ -680,7 +692,7 @@ static int mmu_hw_do_operation(struct panthor_vm =
*vm,
> >>>       int ret;
> >>>
> >>>       mutex_lock(&ptdev->mmu->as.slots_lock);
> >>> -     ret =3D mmu_hw_do_operation_locked(ptdev, vm->as.id, iova, size=
, op);
> >>> +     ret =3D mmu_hw_flush_caches(ptdev, vm->as.id, iova, size, op);
> >>>       mutex_unlock(&ptdev->mmu->as.slots_lock);
> >>>
> >>>       return ret;
> >>> @@ -691,7 +703,7 @@ static int panthor_mmu_as_enable(struct panthor_d=
evice *ptdev, u32 as_nr,
> >>>  {
> >>>       int ret;
> >>>
> >>> -     ret =3D mmu_hw_do_operation_locked(ptdev, as_nr, 0, ~0ULL, AS_C=
OMMAND_FLUSH_MEM);
> >>> +     ret =3D mmu_hw_flush_caches(ptdev, as_nr, 0, ~0ULL, AS_COMMAND_=
FLUSH_MEM);
> >>>       if (ret)
> >>>               return ret;
> >>>
> >>> @@ -702,7 +714,7 @@ static int panthor_mmu_as_disable(struct panthor_=
device *ptdev, u32 as_nr)
> >>>  {
> >>>       int ret;
> >>>
> >>> -     ret =3D mmu_hw_do_operation_locked(ptdev, as_nr, 0, ~0ULL, AS_C=
OMMAND_FLUSH_MEM);
> >>> +     ret =3D mmu_hw_flush_caches(ptdev, as_nr, 0, ~0ULL, AS_COMMAND_=
FLUSH_MEM);
> >>>       if (ret)
> >>>               return ret;
> >>>
> >>
>

