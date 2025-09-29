Return-Path: <linux-kernel+bounces-836568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB008BAA09F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EA1189D1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016130AD05;
	Mon, 29 Sep 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BIaxuR/a"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D63081CF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164647; cv=none; b=aVvn9UATVm9TVLYNV4VT1sv6e5BrggaQ2ma+32pN52mPxukkbDY39h6+kNuiDbHwKcPHfhdXmbEUq3ME2EM3CM/6Dn/481b1ZxVBMixpHpxb+4RzdAo6+EjZs2WQH3JLFBkJseaCHawH53CgqMSw2NmEA4DA+2eudDEXDyeERGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164647; c=relaxed/simple;
	bh=58/qHynbJ4KPMwfA94nS5LugvxXvcatLKednOaZ7gxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6p0+8KYmxUUw9C4MopL355u7myml+6kSunJKA+bZeHyQJIVxc65brxygN3ZMDoWSfamT486fsVsXIJBOrTZicUCIcW38nyzujp4J3tP/4KsUp+Kg4T62pNBPXZTSSk1E3OouvwKSob0BfNnNiheSEKnYPFxlndJivlaf0Tqf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BIaxuR/a; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4de2c597965so31098511cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759164645; x=1759769445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7gI1D223HLxcIxgZm6OvXUfKzGjchEMVkrQhqdo1hY=;
        b=BIaxuR/aHK3tJbnmacwOaXn3hxrBAGfwCsh2I1K01pESxSAoGEpVGidchbW50r8ybM
         0S1BX9gTegNlifmxGDDxsG5ZTcjj4Xd7h2LWWXhbRrClzbvQHZwZR4bO9fE7K1ypGtgf
         37AZoeH8k3xn8oRFqLHejxrAaGAHTLaWqybusE8o6HdZlPlkVV8hrL7RwhlPU1NQvpSQ
         CPh9P34mcddJijflB6lLty7SgDWBx5rfyjZM5Iqumfz1bGkZEhwhM+44RzoavbnAYzLI
         s1bMvq2T+ewOuVELYEeYYGlHAJVoW/1rT0XFTSZZRZLKmWq18D4eq0XcOnwoymQUDlN4
         DrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759164645; x=1759769445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7gI1D223HLxcIxgZm6OvXUfKzGjchEMVkrQhqdo1hY=;
        b=dh94JhppOhm+PV5pSyxFzMBis3d0D2/Q96cwTPE+i/ODcqj1MRKYadqvTXIFeRTySe
         6HRVn+/1H6n/SG0ipoPBSuoKGIORMhB6UMDqDjZjsVpM4Vue0/6cOzaiGbCAMhn9elXT
         awvt1xR9Pdi7RxrQ1/r5c8qQxZ1r/+HdVjJV1ZMnATjBIAu50Ya1MRryoTQGgpfhNqTS
         MIArwrfZWxFWmzY5Fp0HPlavYAlty4Z/Pvs4Iyuz4pJV0ix4TsGDZN7mfj0pzg05RvMj
         KiXHigsV3v1+h2CTDcHuINYrKhAgQ8QoGKaehLdYXmykCvwSatXx2q59cHI2cnSH9xUM
         ts0w==
X-Forwarded-Encrypted: i=1; AJvYcCWQCPuYkl6NqdmAMIdO1ClCXihvGhMOB9AP60/AKA/1h4TXyH9248hHYgrgasKErRPXOr0iyFFOpbggZFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfCSFsL/Jj8pChbyu9qZskx+1LJVDgKMbOv9jMtIbVVJJqwEhW
	yFC25bMANtbmYNU0ctspmk5HFFKMv8FR4tz0tB4T5V3zyQG/YTTELpcaNTYeuPRRQygEwgz8sqb
	+QuxhY6Jqv03qNM00GcZdp8vYO+HreUxJOst48u9RfQ==
X-Gm-Gg: ASbGncvXFMVkn/iAO/RStFFF89ok5GNaHbsPbHZ/om3Wu8cjQfG6Mb2mDalmDVwmMtl
	Jtt+o0w0yeB2Ox+3UH1xEiyf4vpxTN90GJ/iL9Vmp1eQhwzrcXR3BPR87RxlBKSGSOW+MmCYMTx
	vgxABnMqz4cl9EiB47CLNXLMjMCllt0ibBytLuzlHoI2HDIoPsqjVlCZcUjur9CcrH6ad6XERe9
	kj22J5ShjPtQxA=
X-Google-Smtp-Source: AGHT+IHgUzM/EXrUxROfKIF2cWvTDNuiGT8lJQeSEkEeRI5k1+IecbiWt3TnKhFMPXUH2+PKuVUlPqPVEXI2ECbgRBw=
X-Received: by 2002:ac8:7dce:0:b0:4d0:ac40:faac with SMTP id
 d75a77b69052e-4da4bfc063fmr225146201cf.53.1759164644679; Mon, 29 Sep 2025
 09:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-4-skhawaja@google.com>
 <20250929155123.GC2695987@ziepe.ca>
In-Reply-To: <20250929155123.GC2695987@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 29 Sep 2025 12:50:07 -0400
X-Gm-Features: AS18NWCx5jBmL63GoATW04OdTxV3QHh9MjTQAXnbdttnUQiouCPiZpEnod1LS6U
Message-ID: <CA+CK2bA3dcc8320C481zgihW9VrcW4+saU3uCxhgfH-THt8X+w@mail.gmail.com>
Subject: Re: [RFC PATCH 03/15] iommu/vt-d: Prevent hotplugs when live update
 state is not normal
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
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

On Mon, Sep 29, 2025 at 11:51=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
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

We now have per session "state", so presumably, LUO should provide an inter=
face:
"struct file" -> session LUO state.

We should probably add interfaces like these:

liveupdate_is_preserved(struct file *) -> return true if file is preserved.
liveupdate_state(struct file *) -> returns the current state (or
LIVEUPDATE_STATE_UNDEFINED if unpreserved) for the session to which
this FD belongs (or  (in the future we could improve to per FD
granularity, if needed, but I think per-session is going to be
scalable enought).
liveupdate_state_read_enter(struct file *) -> to protect state
transition for the session to which this file belongs.

> of ever understanding why or what they even are supposed to protect!
>
> There is no reason to block hotplug. Do the locking and state tracking

This makes sense, adding a new device should be fine.

> properly so you only manage the instances that need to participate in
> luo because they are linked to already plugged devices that are also
> participating in luo.

Pasha

