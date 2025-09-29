Return-Path: <linux-kernel+bounces-836608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D88BAA245
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3314E4E1F51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063DD30C10B;
	Mon, 29 Sep 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpT8HVEe"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F58215F4A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166515; cv=none; b=V7zidZrtkCkahrWbnbYtQgAcNapRS34lbTUfGTcdiY+CTUNMHK768JBTAPZSk/7Skj6AmUUWxkS/rFkkER7nNYYr8fVTHCzuZWockcQv+tv5pIqTXtpx64eUwg4FWxsuq+4tfDYLCVcYCh4n2bx8QhMuX9XzuzdIUWG00ZIr/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166515; c=relaxed/simple;
	bh=muqLx+ZkQE73ymU6ZJlhOW6yJMNLyerOcTjnN0fXCfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU8+WcgKOwbQrRy9cHb/LRUbOVkYjLT4oaysglspT5g6WMwCSxTuKpEX5ISdJheePUs5AeXQEdaFzi4drsHJg7DBvatucdKddmz2YxTP2YkkhIimTw21jpwYL/RCIAKzaiZfab0RCyg9BncQdyD+JirrovbqWLd/dasx7hsTagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpT8HVEe; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4de66881569so35251cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759166513; x=1759771313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVa+tDyppWrdzqK7fB53mlf91vynfNxyCklwvd1eLkI=;
        b=qpT8HVEeZcRSK5AWSCVdADBYvA5VH7XetNWnxCRUn6VX2f1XNWBRdO+qegl/+S/GqD
         Z8sLuhacR2YtOSEvmdMP8vand6wqBpwCLT9h/367dSssZdSbcEF2yvKk+EsYaBsnRI1p
         XfAbkbvFmepeWEqz0dFbvJHtSyOmZuTPb9REj1zUnfMhjF9AZEbMvdpjo0F+Jmdzax4f
         n3qidhfsWXzLFXGxQv6lVZ4B+kz8vvPv3aa2xPeJaZChq4OzAKAkDaEKTnWjb+sSNJto
         eo7oEZVD9/kkVZ0+9eMZDHPVM5vdpkN4gr45/ZXjZxLrh/paZTSHx/U2gOatJNib6P6I
         WgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759166513; x=1759771313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVa+tDyppWrdzqK7fB53mlf91vynfNxyCklwvd1eLkI=;
        b=Z3cA4Sp76ipNPWef3TwGtg/X6xW8dr5/6+96sjFb628es8zj2LluSrEqN0spsJp//H
         +0au3D7dnUWwdtOwXJWT1LjO/E5hEt/5YNQwEG+WrANkv6GMQ9XITr/S2Xzp2UlhfSN2
         Q7fZv4r01n1+jRd84LMhlufmDSTa5PTs94P0tzC9uje7/6iNRen5Zf3pZr+Kq+MIhSWK
         rn0zB3TKOEAq6fuLwMmL4kHPC9261c7NcKH7VyGCg9XJiK627WrEuQrVXoCP1EjOwaND
         t1HzfdLsv2au5sxbvVHUpdPvl991llMadYHbpXlKpG+SoyDnkulqM65BNTL0uhQsBJ3S
         +yVw==
X-Forwarded-Encrypted: i=1; AJvYcCWFhptyl5O0AjZHPRkRHi1GyAvtYbzRjKaO9eKEmCt5WBeLzg2Ggh8rwQ96GdJi9mdZm0W5BbzXUsVhhZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+bL5Z8z3cM7tChQwxrg/l6h8w3p46y0iRXudhLDeU7uMm1St8
	N/oWP4iQ0KXjrQPN2BHIvQ13iKrS6kKkEYikVYViUH+P1KkWVcy6bwoe4stOFHSp5iXW6XGF1k/
	od1gWrhHipdDFgcVo8iIk+5T3sGDx5SiKS+2XQG3n
X-Gm-Gg: ASbGnctKtoS1o2JV4VtSMoCMiiT2r+90Xt5Wn/cSnaFlo33fZas9whxykBRAXN4Xnbu
	pO6PGAgGVjfA+1++m9WavCzmq9TzgrSlNBBc5gQ1RdpTQahdmyc5eRwisKgvm/YR9/yzcJwyt52
	Ac6HU7QSOFfxS/OPAfR4IZ3pNlzHaf677fwEyWsa16rQ+NKEtwy6If8Mc3zvIs5jW8d0XFCeGX2
	l9Kk0fJq3sO86kaPsDiVdM0QxnUVflzXwgb+ck4f7iy2T8af1ff+a5gOhlxXIQ20g==
X-Google-Smtp-Source: AGHT+IEjdFHycw2DxP3B7hAIpxlRtDVL8V3otAzvB1xjUNsgkfac7OeJzDzf67jwLTAOE6fUWugAWyCiIRZjKDwHBxQ=
X-Received: by 2002:a05:622a:1aa1:b0:4b6:2d44:13c4 with SMTP id
 d75a77b69052e-4e2d014282bmr482371cf.10.1759166511654; Mon, 29 Sep 2025
 10:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-4-skhawaja@google.com>
 <20250929155123.GC2695987@ziepe.ca>
In-Reply-To: <20250929155123.GC2695987@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 29 Sep 2025 10:21:39 -0700
X-Gm-Features: AS18NWDlYoSUXVy2eQshj89NVOvmF60-kHeNYJ-dUJk0Eds8zwKuAzVWnth5PVc
Message-ID: <CAAywjhRy=BHiQgErfkdt+KWcP_ovEF2cAjMT3euHKiJX7Qfp4g@mail.gmail.com>
Subject: Re: [RFC PATCH 03/15] iommu/vt-d: Prevent hotplugs when live update
 state is not normal
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:51=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Sun, Sep 28, 2025 at 07:06:11PM +0000, Samiullah Khawaja wrote:
> > Hotplugs should not be allowed when the live update state is not normal=
.
> > This means either we have preserved the state of IOMMU hardware units o=
r
> > restoring the preserved state.
> >
> > The live update semaphore read lock should be taken before checking the
> > live update state.
> >
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > ---
> >  drivers/iommu/intel/dmar.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> > index ec975c73cfe6..248bc7e9b035 100644
> > --- a/drivers/iommu/intel/dmar.c
> > +++ b/drivers/iommu/intel/dmar.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/dmi.h>
> >  #include <linux/slab.h>
> >  #include <linux/iommu.h>
> > +#include <linux/liveupdate.h>
> >  #include <linux/numa.h>
> >  #include <linux/limits.h>
> >  #include <asm/irq_remapping.h>
> > @@ -2357,6 +2358,10 @@ static int dmar_device_hotplug(acpi_handle handl=
e, bool insert)
> >       if (tmp =3D=3D NULL)
> >               return 0;
> >
> > +     guard_liveupdate_state_read();
> > +     if (!liveupdate_state_normal())
> > +             return -EBUSY;
>
> Pasha, this is madness!
>
> Exactly why I said we should not have these crazy globals, people are
> just going to sprinkle them randomly everywhere with no possible way
> of ever understanding why or what they even are supposed to protect!
>
> There is no reason to block hotplug. Do the locking and state tracking
> properly so you only manage the instances that need to participate in
> luo because they are linked to already plugged devices that are also
> participating in luo.
Agreed.

I'll rework this and do proper state tracking once I rebase on top of
LUOv4 for next revision.
>
> Jason

