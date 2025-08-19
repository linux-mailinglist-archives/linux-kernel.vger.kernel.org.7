Return-Path: <linux-kernel+bounces-775793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EDFB2C4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D54A235DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D42133A039;
	Tue, 19 Aug 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMnXIL88"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391933A038
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609029; cv=none; b=qc/41WLFXipoz1kTyytocmuDxVVNsOC/qjwk//t5+BUF2PL4MlgHGhmAToRkkzEGB/VHyJ2qBczHvAhDrXuYBNp7j8ymKtdm5fExx8t4P5AJaGPqFtd7CzEMDbtD2en4GsCYgu6kn3twRid8B0CIOvnEChe/J9SpaT3wovPZ+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609029; c=relaxed/simple;
	bh=qtmt0U2pFQHYBzs4k348sZd8pxeJZenrsuX0KnNmONY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLskhf8PaEONW9WULvhzJfSRnPDdT6oZol9pEURD52CREznzSU7Fx7QXRQbOCc0zfUSCo9dhQYt14smcrFw8zcsLHARcd6sWI/OnzMgXVszCb5NWTXo8rPtSy8WhBzWCfox8Om95U3Qs/Ss2f4xe0JV5AjklGtcGiwPbPKu17Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMnXIL88; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-244581eab34so8206105ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755609027; x=1756213827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBO0mQ7zrboFrLruEp+8+uIF4ovtiK0aQdxBxT/KyMA=;
        b=eMnXIL884OGIGfy1nYr1nIb2bY43GED/Jk/5UXg5RMPpz3vNYk7oDbb1lHWLKlrBx9
         lLICtU7FtCWiO8NBLkFQXEkw6XHeojBkNiB6ZJTdsXjUtZsHtXrcC0EMUlQH4IFmtU73
         Ue81xVb5oYpuR5XqhxaUKAcdZOp0NAiMWZtnPi+nsW5wYf9NtCDt8nB/BvdFEMSGpH0Z
         zdPPbUEFbKkH40EXxgspxwx2T6w3ojC/0tVdIyxxjyPjjS87wMnaw2ZD06C9R6QxNJtx
         MKvHpaTGjWVw3VCCcQz4iIna8d2WBqR7YieeksfNVjsgoLro8JJe6vwWrcuvvLa6CRYO
         REig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609027; x=1756213827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBO0mQ7zrboFrLruEp+8+uIF4ovtiK0aQdxBxT/KyMA=;
        b=E4qoz5gLMnAQz/DnCKSMROevgqyHNA+mBZMndH4O9urOQm5Sxr/10tlPPc8Gwld4OQ
         dQ94o2a6QCttMWUodQ+amFJcObKjddHtxntGTyNkMtT0gWAMeKof08kpGyFbS86ydwp2
         RyA4NYnKKvnK8VRopJ1vLZnKpw59HRlsqe6Xq2Ny0h8UaJp7iW3y3okHerMQHP0uO7rP
         YCxdc+wOQPMatTMO+I7VQKGfrYSlZG90fQHRId76hoaBYydPHlS6YH4tPtbLMDeYq3AS
         HTBRPVFVhy94zgUmBS26YsV4uaa7s8ptcRQPzOQV8boPTFbhiYn49WvHjQS6RgOfZZhM
         GkFg==
X-Forwarded-Encrypted: i=1; AJvYcCXhDh/pPZdezzIMIMASfOChbHS3J09P70pKdpQp3iz8Ju+DtZ4CtHZkSdHEomZok6Dm8zLmof79D63DnLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6Zji7r9W3+KyajW9gnYodRiE+56AxJJv9YkjO+wea65nT0WX
	7iuuFIaxcxB2stWuRHxbc8+z534a1LjBWc2WTl+d3cxa/z8lAY1kg/ov135oZb6CCELPQWgPgJu
	pCItMo9vC6FgqJKzFQlETTk/DRaN++F8=
X-Gm-Gg: ASbGncuVyHBAAqh4XCP7rZ3Pgzg6+PlpKYMSX/2ijj4fI4OovZWA01ZYWMxuH5pQ0TL
	H6jRr7UqNSF3+gwu9OxcA0GAhHAnBupRgpG9sQB7jI0TTm8VrPOVpvOEkZAj284W5Tp39Ind1jG
	aSihy+sMpENFP5HKxz6C8dMAvXefE5DKk/OidurfyVagYYssdQpJxjED1qyve2C3KBR8CaxMoR+
	88Es6I=
X-Google-Smtp-Source: AGHT+IHgDHQQVvQ81lJeFxwOYKVLPEWtIJSQrpi70KdAtd/aUfRobzNM5gDqlN/++cIRn61vbrInrD505a7SNJ3odjc=
X-Received: by 2002:a17:902:ea07:b0:240:33c7:fbf9 with SMTP id
 d9443c01a7336-245e0503f5emr17013235ad.11.1755609027188; Tue, 19 Aug 2025
 06:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819082524.526572-1-liaoyuanhong@vivo.com> <00e7ce33-cc0a-4249-ac18-081ab9ead243@amd.com>
In-Reply-To: <00e7ce33-cc0a-4249-ac18-081ab9ead243@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Aug 2025 09:10:15 -0400
X-Gm-Features: Ac12FXwmelZstNIBVdCAl2Tac6u3JKQmNwideXgAhYQM85MNWz4RZc0s2eVEDwE
Message-ID: <CADnq5_PA8P8V9Da8ZUrDAsYXM_tbnPPyBR4MgF4QA++59vKerA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/fence: Remove redundant 0 value initialization
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>, Alex Deucher <alexander.deucher@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Tue, Aug 19, 2025 at 4:41=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 19.08.25 10:25, Liao Yuanhong wrote:
> > The amdgpu_fence struct is already zeroed by kzalloc(). It's redundant =
to
> > initialize am_fence->context to 0.
> >
> > Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> If you want a challenge what we would really use is a scan of all the str=
uctures defined in drivers/gpu/drm/amd/amdgpu/*.[ch] for unused fields.
>
> The UAPI and BIOS/HW header files are full of padding fields, but there s=
houldn't be any in the driver core defines and we sometimes forget to remov=
e fields from structures when they are not used any more.
>
> Regards,
> Christian.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index bcb74286a78a..fd8cca241da6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -120,7 +120,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, str=
uct dma_fence **f,
> >               am_fence =3D kzalloc(sizeof(*am_fence), GFP_KERNEL);
> >               if (!am_fence)
> >                       return -ENOMEM;
> > -             am_fence->context =3D 0;
> >       } else {
> >               am_fence =3D af;
> >       }
>

