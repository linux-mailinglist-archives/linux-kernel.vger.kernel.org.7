Return-Path: <linux-kernel+bounces-871456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0076DC0D611
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A153BFD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A8C2EF66A;
	Mon, 27 Oct 2025 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi/iZA5L"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8C366
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566027; cv=none; b=ToVL/kD2PyJkDdWCqIixwKUZ7471tTQLs6qfxRWm6nedbbzuaNbESRWzRWfHkDELnIy8vFHpUMPxGYh7xdycnny89mQdNX8211Qovs4OHcSB1xTZWlbAnFupTxbsfMv4LPDvGkfoyu8FgCFAPre3eOVwk49ZzKXxUt49YOC8uEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566027; c=relaxed/simple;
	bh=7BjcZ05zih1jpYLlSr+edVVRV3ZK4520Ony0YbCJSws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2pFSCDA2PAGbPQTujoBPoGYXTBSJgnyl32gYhAn/66umAU8z/plb/+J8xO1D6fFV83X34E0+dMXA0/5iulYYYflwmcZtARg/9OC9avo6aukUGpQT+KwAiLbJl4zW61SE7yS/O2BQiJrbBB49rIOPKpof0ef6stNQ/pFJTYPVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi/iZA5L; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-654f03136c4so1167151eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761566024; x=1762170824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+JCIx9N9UMsFHoni9806vgCcOX0IuOoBw4ayA9zElg=;
        b=Xi/iZA5LrMo02Ru7qhvyShPGjupfB7AWE1Ohmrvz6h3asuyiA/Kc0hOsM3l+X8JzEN
         scF5rxLlULrb8bToDVaKCKk5ZsJIz2dp/67Myj/6JeQT6w2Fgxt7YFlVr0q7IV4SYxr/
         k+/vA3aFuj5ipJs7W7hjlKp6qY+A8azt4udrEJzsIzRApiACBZRSR25gWqQfp/WtwDy7
         He917/CwLUKlPnzCOqHM29j2JR2kyIVIoNd9JJqTPHQ/iv6Z5Y1vwbNSkldQMsZbg2Cd
         Up1rLqFQrn7kBqRjOb5mBCOtF6MBMRmpt8I0gy9dHGuZVErJU3hEy6c793dYaB4a344Z
         r29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761566024; x=1762170824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+JCIx9N9UMsFHoni9806vgCcOX0IuOoBw4ayA9zElg=;
        b=YmgcbTnuw0eI+ROQipmLjVFyDxrPrSwE/ghd4EuJvIdCp21UQTjVFSV9Jz5kawk2TN
         IniQRjRlgeT48CCvlraySHfCcLjLtguczrpccS0ncd2X4hhAkgoCPiqLXBnuEOC7qNj0
         11Dn+hF+RRYI1VOG/pfcwXZ1UnfqQfkAFsjffQiMDLI+4yL6jfz+QZniekc13cmGYhbn
         jG/on0qMbE5CfFttzehR29enMe9tLGxIqrbIJoznY4lEMB24hMva00/Lrrl3FCoDN4ea
         UlYogmPQCNHbZpSlyq58usv8S9afYSe0YQTHgb2gKCP7Obw5uX38TRwFfl9tGwENNy5O
         b8/w==
X-Forwarded-Encrypted: i=1; AJvYcCUvmw5snk6uzz3OOr3OzwKQ91sX4mh1yMAtzyYpcsmrSy9a7odYaGU0Yw25fYdM+MeilijM2bAr5S1iUWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9l72Mi6qF/GvlgewBS/LmgHAA6XenyJVTWYQzGLLAmj9l1pI
	awye7Cd2DQJ263DU3wEJ31O5dm1tbvVhuv2blmUuzRpKgA1RXweQfQ5x/6M+BMTUtfbYRYyFl7d
	3bcbnfGna0HYTqnw16JNDVJ0ouAVk3+5CQFnYY45+bEkZ
X-Gm-Gg: ASbGncs0xfnsV1xLARdWwe9PZhYrqN1x0jAjvH9AeDcaN2uGRBZNwsFw2/pZlixlOQY
	0lz3dmbphG52vhll8a707MqI7+icOS84l18DKdEmGiU6C+UK4ieZvhfNeOykDSvEfO8lJw5LLVz
	A5xeAZJ0O90UPy6q+yb8jrD/veWBBFGD+JC/+TQGcT3jmYpNNmk9eGzkoUqoDvpCk5NBF89qbWr
	UZS2BjFTAe+J580z5rdv//JvoN0KcECnj8tQ7nOfZE/lqVx9JRafIkgDJ67wsKQwHI8rcgAPBC/
	u7w3D1U=
X-Google-Smtp-Source: AGHT+IH0iPJMGQvhOuM8mY0VFND0YjjgxyBg4rxvudWNKZ8wuD0Q5l+0cNUItegjBjtjC9hU+uux9lD/gtOpDc0CMps=
X-Received: by 2002:a05:6820:2918:b0:654:fd90:bdcb with SMTP id
 006d021491bc7-654fd90c601mr1447002eaf.5.1761566023690; Mon, 27 Oct 2025
 04:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026091351.36275-1-linmq006@gmail.com> <20251027101451.14551A49-hca@linux.ibm.com>
In-Reply-To: <20251027101451.14551A49-hca@linux.ibm.com>
From: =?UTF-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Date: Mon, 27 Oct 2025 19:53:25 +0800
X-Gm-Features: AWmQ_blk3uq_5rtQV412EY7V2h_deFBjeohYtVY_FLPkTWCodoGGNeoKyoGDHBc
Message-ID: <CAH-r-ZG8vP=6qH42ew26BMBL9dRB3OtLUeFmMmKXzp1tnKvkxQ@mail.gmail.com>
Subject: Re: [PATCH] s390/mm: Fix memory leak in add_marker() when kvrealloc fails
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Heiko

Thank you for the feedback.

Heiko Carstens <hca@linux.ibm.com> =E4=BA=8E2025=E5=B9=B410=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=B8=80 18:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Oct 26, 2025 at 05:13:51PM +0800, Miaoqian Lin wrote:
> > When kvrealloc() fails, the original markers memory is leaked
> > because the function directly assigns the NULL to the markers pointer,
> > losing the reference to the original memory.
> >
> > As a result, the kvfree() in pt_dump_init() ends up freeing NULL instea=
d
> > of the previously allocated memory.
> >
> > Fix this by using a temporary variable to store kvrealloc()'s return
> > value and only update the markers pointer on success.
> >
> > Found via static anlaysis and this is similar to commit 42378a9ca553
> > ("bpf, verifier: Fix memory leak in array reallocation for stack state"=
)
> >
> > Fixes: d0e7915d2ad3 ("s390/mm/ptdump: Generate address marker array dyn=
amically")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> >  arch/s390/mm/dump_pagetables.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetab=
les.c
> > index 9af2aae0a515..0f2e0c93a1e0 100644
> > --- a/arch/s390/mm/dump_pagetables.c
> > +++ b/arch/s390/mm/dump_pagetables.c
> > @@ -291,16 +291,19 @@ static int ptdump_cmp(const void *a, const void *=
b)
> >
> >  static int add_marker(unsigned long start, unsigned long end, const ch=
ar *name)
> >  {
> > +     struct addr_marker *new_markers;
> >       size_t oldsize, newsize;
> >
> >       oldsize =3D markers_cnt * sizeof(*markers);
> >       newsize =3D oldsize + 2 * sizeof(*markers);
> >       if (!oldsize)
> > -             markers =3D kvmalloc(newsize, GFP_KERNEL);
> > +             new_markers =3D kvmalloc(newsize, GFP_KERNEL);
> >       else
> > -             markers =3D kvrealloc(markers, newsize, GFP_KERNEL);
> > -     if (!markers)
> > +             new_markers =3D kvrealloc(markers, newsize, GFP_KERNEL);
> > +     if (!new_markers)
> >               goto error;
> > +
> > +     markers =3D new_markers;
>
> This is not better to the situation before. If the allocation fails,
> markers_cnt will be set to zero, but the old valid markers pointer will s=
tay,
> which means that the next call to add_marker() will allocate a new area v=
ia
> kvmalloc() instead of kvrealloc(), and thus leaking the old area too.
>
> add_marker() needs to changes to return in a manner that both marker and
> marker_cnt correlate with each other. And I guess it is also easily possi=
ble
> to get rid of the two different allocation paths.
>
> Care to send a new version?

I'm not sure if I can make it right.
Do you think this way can fix the leak correctly? Thanks.

```diff
static int add_marker(unsigned long start, unsigned long end, const char *n=
ame)
 {
-       size_t oldsize, newsize;
-
-       oldsize =3D markers_cnt * sizeof(*markers);
-       newsize =3D oldsize + 2 * sizeof(*markers);
-       if (!oldsize)
-               markers =3D kvmalloc(newsize, GFP_KERNEL);
-       else
-               markers =3D kvrealloc(markers, newsize, GFP_KERNEL);
-       if (!markers)
-               goto error;
+       struct addr_marker *new_markers;
+       size_t newsize;
+
+       newsize =3D (markers_cnt + 2) * sizeof(*markers);
+       new_markers =3D kvrealloc(markers, newsize, GFP_KERNEL);
+       if (!new_markers)
+               return -ENOMEM;
+
+       markers =3D new_markers;
        markers[markers_cnt].is_start =3D 1;
        markers[markers_cnt].start_address =3D start;
        markers[markers_cnt].size =3D end - start;
@@ -312,9 +311,6 @@ static int add_marker(unsigned long start,
unsigned long end, const char *name)
        markers[markers_cnt].name =3D name;
        markers_cnt++;
        return 0;
-error:
-       markers_cnt =3D 0;
-       return -ENOMEM;
 }

