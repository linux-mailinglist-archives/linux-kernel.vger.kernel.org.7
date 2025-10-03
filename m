Return-Path: <linux-kernel+bounces-841530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DC9BB79A4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EBD24EDCA8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF302D0618;
	Fri,  3 Oct 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORS0h3yq"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01803398B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510001; cv=none; b=uw7GDEujH+2kW8fiJHSGWUTSB+J41zY1m7NdaCcdhdUUcldtuXl7o1P/YntIeLkzmlFY2jOx8mLIO+H6eGno/UI5vcY+vNOg1Kn8zQvGQ5sWRvKUzYMJpSxXFRr5UgqY6FUvJvUui5chbLl2+tbR9/WnlFvWVHAn7gxs+135ohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510001; c=relaxed/simple;
	bh=+lpvHE3UAuIjCk61dkHXsvHI5onOcrUL9NIRE9xNSfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eee0tBWZsxFJcA6qqsbxCHGAR3liq8Bpfudtbb5gLZ7HPV87eYv0UVOavC6CXFcfo1yxAz7d0OdF5NbCvQCKbXSyTO5Wa/QaUDxuq0SDHtVxOu4crNG6zPTyKeD7Rv+5VD+sz/eLjCVVBTBELd4Tk+ANlmq1rQpNkDAE2yWcWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORS0h3yq; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d5fe46572so34611337b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759509998; x=1760114798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbaO38KWIg6eoYsH/LPckOSLNAEhaqfaW0c+XUDJmuo=;
        b=ORS0h3yqX3zR9RPBTJ97ox1EGXTssJoAuN2pWhMUosh5pAfAAYTB0YCz65hkAqz62N
         54IjsDRUAE8YTx5N1FjpLPh6Bv7dP+t3s9/PxHaZXU51WI+DuBAmM14go3lMJjxBJ/av
         +ddaqCH5BVp9sQhmX7Z1B07gLbC03766VK7MERJS/vcrdnGedOc+ly8Ez9itXmOvtfvu
         r1p31Ql0G2e52VNQ7wNlxNTOUlyao7xMnL6TqbgUr55wNG5d4Y+klCec2p2IVwWImr2z
         Q2RFfXgvRBY5wueLs0v9hsvOREEj/chZJqgN0aRDF3cFKv2o4CUfHersSL0rOQpQtS5p
         NxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759509998; x=1760114798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbaO38KWIg6eoYsH/LPckOSLNAEhaqfaW0c+XUDJmuo=;
        b=LDoCnBi6N0EUFtsgi9fVtyb1RoSdrmUq+t5lnuRBocEZnQBMyMnKcAOzD6zRczqXoy
         L4/AtNd+haHOvWNDPESVWst0LCAlA24SI19rOHlqAdN00bSGsKzr7j5FBsBmN7Z7WJhV
         7FZEyt0mYOuFE4EAEKTaa5h9/cHjGgaBgDP72GYYVmUTHsoTIVjnFjyTU5M4y4WIZEgd
         GIEDT8ARBk01Bz6rCFHuUTkZKZ+7KkgIy51EUyo2I7v2Za7ix45slIvvxreX4iVigb3j
         HT1F+LBG9bzmNbM4WYuJSdWP6J7q36fhC1lb1cktqv6U39NLeNvqnmcV1gQC1l4IIg50
         1E4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV8vUsSMNQmhO7Ar5gwd880Qes5WD62LM8JPiSjiTohWsPxjO2GhVaQO/qQ3rERfoLNnFvJ3hU8eHnpfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQyQZfgw1BnK7syjNo1IHXzsW5o8yZg0Lr09Jz4/XtF/Dc0pW
	Kcq4EVoK7ZF0QDpadoMERvImv+D/RgX7yul04AVTND79yrpmAzyCaEH6bldFiEoNsGaFopDKFqT
	fhiTD+DAbksY5VUfuPzTjJxnV18n/sTU=
X-Gm-Gg: ASbGnculnVcIT6KdGg177j4ZN2lPN8W1CXva8efkm6l5wqDWrDyTfiIPTArTfjYrMnS
	5+jpeG6EKhxBB5+SY26VzqqLpNOuLNs58KUwwieEfHavGs+XO8MfwN67rvEfdr0YW/Z8xeIlzKi
	Qvin8Dlb5TtXI7dWC/audnM3YIR3fZnPdfL88/uno/cyH20b+F71bqKGdAc/WSvItXOR68wn3D1
	hn73pShXsziuB70hvBdx6fbkF20CHSqzpOnQ5dg0/4oXH7ZfN1oOo104QYIgeDiF8yYHoju4FiA
	oORzkM4DmuAVDtJY0/1tYvYlJMmVaUZE
X-Google-Smtp-Source: AGHT+IFWncG86O5r+6FwzsP59G545JzPmypkxdD50foluglEErNvNXbe4BN8ZNbnT/h3k+IRhLVHo0pO0jBsM4uckTM=
X-Received: by 2002:a53:c04b:0:20b0:636:20c2:8eb8 with SMTP id
 956f58d0204a3-63b99463d57mr3530454d50.6.1759509998437; Fri, 03 Oct 2025
 09:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916210823.4033529-1-olvaffe@gmail.com> <20250916210823.4033529-8-olvaffe@gmail.com>
 <74e2f1a8-0410-4a5e-bbf3-29d5d5d55308@arm.com> <CAPaKu7QEAbR8a_+qmyU=obyf2N-UZemfw23U_Dw2DZLqPd7tGQ@mail.gmail.com>
 <9022445f-3cf7-46a8-85ac-e1f226e0bd9b@arm.com>
In-Reply-To: <9022445f-3cf7-46a8-85ac-e1f226e0bd9b@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 3 Oct 2025 09:46:27 -0700
X-Gm-Features: AS18NWBSZ8ttnfWhFPgsAOcecJWxL-MxEUEzojwa5u1JT9CrpBjxCoFd82w-r10
Message-ID: <CAPaKu7SK44HqvPvDsFVNeJs9+KkUFCXzH6CL+iD8tT73ws+oiw@mail.gmail.com>
Subject: Re: [PATCH 07/10] drm/panthor: remove unnecessary mmu_hw_wait_ready calls
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
> On 03/10/2025 01:23, Chia-I Wu wrote:
> > On Thu, Oct 2, 2025 at 3:41=E2=80=AFAM Steven Price <steven.price@arm.c=
om> wrote:
> >>
> >> On 16/09/2025 22:08, Chia-I Wu wrote:
> >>> No need to call mmu_hw_wait_ready after panthor_gpu_flush_caches or
> >>> before returning from mmu_hw_flush_caches.
> >>
> >> Why is there no need? If we attempt to send a command when the hardwar=
e
> >> is busy then the command will be dropped (so the cache flush won't
> >> happen), and if we don't wait for the unlock command to complete then
> >> then we don't know that the flush is complete.
> > We have this sequence of calls
> >
> >   mmu_hw_wait_ready
> >   panthor_gpu_flush_caches
> >   mmu_hw_wait_ready
> >   mmu_hw_cmd_unlock
> >   mmu_hw_wait_ready
> >
> > I could be utterly wrong, but my assumption was that
> > panthor_gpu_flush_caches does not cause AS_STATUS_AS_ACTIVE, at least
> > by the time it returns. That's why I removed the second wait.
>
> Hmm, so this was a recent change, moving away from FLUSH_MEM/FLUSH_PT. I
> have to admit the spec implies that it a FLUSH_CACHES command wouldn't
> set the AS_ACTIVE bit.
>
> Indeed we now actually split the active bit between AS_ACTIVE_EXT and
> AS_ACTIVE_INT - where _INT is from an "internal source" and therefore
> doesn't prevent writing to the COMMAND register.
>
> We do, however, need the LOCK command to have completed before we flush
> the caches. So the operations should be:
>
>  * wait_ready()
>  * LOCK
>  * wait_ready() // To check that the LOCK has completed
>  * FLUSH_CACHES
>  * UNLOCK
>  * wait_ready() // Optional
>
> The final wait_ready() is optional in some cases (because the LOCK
> ensures that we can't have any translations using the old TLB entries -
> note that I believe older Midgard GPUs couldn't rely on this). However
> in the case where we want to disable a MMU we're going to have to wait.
The end result of this patch is exactly the operation you gave above.
It is without the optional wait at the end, because whoever issues the
next command will call wait_ready.

>
> > We also always wait before issuing a cmd. Removing the last wait here
> > avoids double waits for panthor_mmu_as_{enable,disable}. It does leave
> > the cmd in flight when panthor_vm_flush_range returns, but whoever
> > issues a new cmd will wait on the flush.
>
> Note that wait_ready() is really cheap - it's a single GPU register read
> if there's nothing active. So the "double wait" isn't really a problem.
> I'd much rather have the occasional double wait (i.e. one extra register
> read) than the situation where we miss a wait_ready() and end up with an
> MMU command being dropped by the hardware.
Yeah, the elimination of double wait is really minor. Avoiding the
wait at the end of panthor_vm_flush_range is probably bigger, but it
is hard to tell.

Let's be on the safe side and drop the series.

>
> Thanks,
> Steve
>
> >
> >
> >>
> >> Thanks,
> >> Steve
> >>
> >>> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> >>> ---
> >>>  drivers/gpu/drm/panthor/panthor_mmu.c | 7 ++-----
> >>>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/=
panthor/panthor_mmu.c
> >>> index 373871aeea9f4..c223e3fadf92e 100644
> >>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> >>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> >>> @@ -669,12 +669,9 @@ static int mmu_hw_flush_caches(struct panthor_de=
vice *ptdev, int as_nr, u64 iova
> >>>        * at the end of the GPU_CONTROL cache flush command, unlike
> >>>        * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
> >>>        */
> >>> -     ret =3D mmu_hw_wait_ready(ptdev, as_nr);
> >>> -     if (!ret)
> >>> -             mmu_hw_cmd_unlock(ptdev, as_nr);
> >>> +     mmu_hw_cmd_unlock(ptdev, as_nr);
> >>>
> >>> -     /* Wait for the unlock command to complete */
> >>> -     return mmu_hw_wait_ready(ptdev, as_nr);
> >>> +     return 0;
> >>>  }
> >>>
> >>>  static int mmu_hw_do_operation(struct panthor_vm *vm,
> >>
>

