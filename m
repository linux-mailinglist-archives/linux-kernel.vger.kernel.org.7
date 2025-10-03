Return-Path: <linux-kernel+bounces-840895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD4ABB5AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7E43BCDC2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC6D72612;
	Fri,  3 Oct 2025 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DylSLvJ0"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3597261D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759451003; cv=none; b=R+mQ7jQJGSMa56zr+bbhPiMJ2YhKNHdDhPPvKn2hbvfQbyRp5RkjbMF+xmYPKeRvFeQDAEPOW7zPayCUYg+5xJtdSIcjzNSUDHIRaygQ7bBtHcPo1jsz8GFY7ig39au5Dz1Y7W6+IEXWTKR9bXEXy6dNW4D6G+ZnaPXjBmh8u20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759451003; c=relaxed/simple;
	bh=r37B0Tr7c28GNhgMVubxeVdQbc6QoeOEoXXZOXq+bH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2jjw/sn8pbFS6veeF6FlvQR0gTJ2p/y5ttXPKesnnESHMx0WzrQmkIX9m0S2+KMgJr4KdCmUfLccqbAwHNL5DHDELRQC3Jy6ldTj6NkdsF6/T6Y4AuzUCnVyGEY3Lc+nEeGKPJZtNsiMhGCsKLtu3JVSTC4ntxN4d0GA9xQYGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DylSLvJ0; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcab6fso17990867b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759450997; x=1760055797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UogbRmh8ZZFm/yaTOGh0nQGpaUOSHHMMlYpMQ7rZnx8=;
        b=DylSLvJ0l/EK+R6/SbYWbuQPjqNrbwZus4TwCwHV4vFmOohbnyXzL37Tpw9pMJE0J9
         bzzm4kBZqb1RFt4MXgBwEIBQzYYJ0sRhJi2qPe4IvE31R5krOEu1RG4VUcsqsJGFFJfY
         9ak7i9CWcDEq4m8ilc1EX1KQafKtFqoIkwD8IFtUJUe1k/HE6ySoQGD5huRcGfLtaJwW
         F7/Wf1Nw+Zo3fQfJQA+3WkwF7WU0OvEOFjoII47+DQbmUHtznu0gPuzq4Q3/wiJCVm7o
         9+CRfZu+nG32m8XdAyCYJe4B/WPpkB4ZlMsMTkR7M4YhVuHd84lCZ015jUEorvxmZqXQ
         GnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450997; x=1760055797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UogbRmh8ZZFm/yaTOGh0nQGpaUOSHHMMlYpMQ7rZnx8=;
        b=OVKAl5EBQac5JgkKuvocl9a+qoJrubTC0L0IJUpRf2kyUczbMAxgkSxxHqCLhGKpks
         Ltye3+HTgFz8EeJoja3i7cZoQSemebDiiOoNj5/CVWuHk0iQIu4e1u7+LYggSoMyHOX2
         bC9644l8Wni98rQEsLkjWjTrFZBJeo3bFlMoxmjEQ4ZHR2unQq2+2Ou7gMwdC/k8KJqK
         +XpNfz+o3nRYK1i9e+XFq4gjmhiRfcOhBIHGBH2aRx9KKAqhSY3ygTwDOncke/BDr+b1
         o9YDik7TGc3tUbW1fLBj2uPU9y2gL/lE+9nxeW9DabcnWThh8oUz9hUZN8uFK6J0BRwz
         O+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWRcOhO667andanwqBGvLSfAPmNH2ezUF5Oqs771X0jEG2CG8HVVUMxZ3arJk/7r6/5/V+A0BfAbyDDV4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm+aFACPl9fRcERL4hVm2H+Cb/5GrViPYL4k9Qfz+KVFEi1Ygj
	gCLjXx7LlY8S2nV1N/ZsWeNKi3dWb1+92C/1f9A7GHio/tEMlkOMzp8VOVA8ww5QUfXvALnO+J9
	HEXmPJcGrRLvM1a1BFPDpOnhR8FqB2/0=
X-Gm-Gg: ASbGncu3vAPJq0Rz0tzqrrZembfSf/TsLteb3g74E1FAWGJRZ/lQelSd3nVTD7cmdUV
	2sAcr19ek3NDtEjjelGQm5rXZKzl6fnQg7Rw+m+AFGd9qYfzTKhlNSAJVvVA7eAWkdbO7RXKe5q
	TChpqZ7KOlFkWcGN+yYl34gsWr1hGvywWC6iz2Bu8CESIMDHjOzEJa9wJ77fcVBLCKPt/X0wE7x
	1B6/gyzfvANpugE57EeHr0aZbZI9dMsKgEBl+99DXicGeW5AVmPBcVGT09uxVnKTQHZgSah8loP
	m/brW5f2S5J9UtFGeTHg
X-Google-Smtp-Source: AGHT+IHOLdaIHo5P2VOGhm5KkYSe5owt52O+0aQI4TZI+V6q/b0CuBZtjoShHyYCEalYDt7A3qdiiKgFGQuVvZwB5NE=
X-Received: by 2002:a05:690e:2404:b0:627:86de:ac9f with SMTP id
 956f58d0204a3-63b9a074c43mr1120484d50.12.1759450996803; Thu, 02 Oct 2025
 17:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916210823.4033529-1-olvaffe@gmail.com> <20250916210823.4033529-8-olvaffe@gmail.com>
 <74e2f1a8-0410-4a5e-bbf3-29d5d5d55308@arm.com>
In-Reply-To: <74e2f1a8-0410-4a5e-bbf3-29d5d5d55308@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 2 Oct 2025 17:23:06 -0700
X-Gm-Features: AS18NWDsN3mYbrQ17ccUwcQtLGbvJ-VcpQvebBOZyQ8AFN9Ko-OXrdSad4I9OrI
Message-ID: <CAPaKu7QEAbR8a_+qmyU=obyf2N-UZemfw23U_Dw2DZLqPd7tGQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] drm/panthor: remove unnecessary mmu_hw_wait_ready calls
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:41=E2=80=AFAM Steven Price <steven.price@arm.com> =
wrote:
>
> On 16/09/2025 22:08, Chia-I Wu wrote:
> > No need to call mmu_hw_wait_ready after panthor_gpu_flush_caches or
> > before returning from mmu_hw_flush_caches.
>
> Why is there no need? If we attempt to send a command when the hardware
> is busy then the command will be dropped (so the cache flush won't
> happen), and if we don't wait for the unlock command to complete then
> then we don't know that the flush is complete.
We have this sequence of calls

  mmu_hw_wait_ready
  panthor_gpu_flush_caches
  mmu_hw_wait_ready
  mmu_hw_cmd_unlock
  mmu_hw_wait_ready

I could be utterly wrong, but my assumption was that
panthor_gpu_flush_caches does not cause AS_STATUS_AS_ACTIVE, at least
by the time it returns. That's why I removed the second wait.

We also always wait before issuing a cmd. Removing the last wait here
avoids double waits for panthor_mmu_as_{enable,disable}. It does leave
the cmd in flight when panthor_vm_flush_range returns, but whoever
issues a new cmd will wait on the flush.



>
> Thanks,
> Steve
>
> > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pa=
nthor/panthor_mmu.c
> > index 373871aeea9f4..c223e3fadf92e 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -669,12 +669,9 @@ static int mmu_hw_flush_caches(struct panthor_devi=
ce *ptdev, int as_nr, u64 iova
> >        * at the end of the GPU_CONTROL cache flush command, unlike
> >        * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
> >        */
> > -     ret =3D mmu_hw_wait_ready(ptdev, as_nr);
> > -     if (!ret)
> > -             mmu_hw_cmd_unlock(ptdev, as_nr);
> > +     mmu_hw_cmd_unlock(ptdev, as_nr);
> >
> > -     /* Wait for the unlock command to complete */
> > -     return mmu_hw_wait_ready(ptdev, as_nr);
> > +     return 0;
> >  }
> >
> >  static int mmu_hw_do_operation(struct panthor_vm *vm,
>

