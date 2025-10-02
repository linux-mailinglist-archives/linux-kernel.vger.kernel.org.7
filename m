Return-Path: <linux-kernel+bounces-840527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98CBB49D6
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D9E322029
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59915259C94;
	Thu,  2 Oct 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWbWh2IS"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F311419A9
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424601; cv=none; b=g9/y0BaBwh2v3/N+GK2sOjZm/CxvGEF8dvP85lsTbMhDHCqQWyUQ0vuAVp/z3O3Ra+zVAKhPuhyujsJ14V9FqDDDR9MOBAydF8M0TOLikz5mR8c/phcM45wuDgjep0YIa+hWcHIPyCsg1bNlgsMqD70UpMwsCFdaB3wwKNFGGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424601; c=relaxed/simple;
	bh=fydY7mK4i/0lbTC8CRhN+yWYi1t05KnZoS/Ga1Eg7s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewr3hxOI3069h7LjuraCy6Q5giKg11EXhOzv8/bDff24Zml3HeMUxobiKYomOixbppb2J2ije/Fk/gpmU5c+JXKLB9je/2lkkbTndnP7wXdPOKe3m0G8bXRi+vbGm8gQJeqOH4NzlJXkltpAdcNAKmXpzEKIybiA/Cx5akecOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWbWh2IS; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4de60f19a57so29181cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759424598; x=1760029398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fydY7mK4i/0lbTC8CRhN+yWYi1t05KnZoS/Ga1Eg7s4=;
        b=YWbWh2ISJRRpUDVnCsHLFSn0pDX6Foo9MD4BeICTQcNLsVzwZWyxNhhUYNjO1QywBV
         IYeW2wBeTSz9Tf/ckGnp1vDtcn+P+yo9IX4d2cKXuij/1fXvyMCwu81DKrh2LZJbO5oL
         Sf/Y7+4a3IrpCuVFLe/rIKIk5DljsY14xT8Uy5rfF0SZ8E+qU3yafMTwjLxPr8M69Rkk
         DtW8NdQ2gCUaQ4HM/k7BSEOP5u1resHIIcZm52cF/zGkMj7Z5VfcWExnH0jTVIeIMoMV
         sgpeK9wzlbOVWkc9bpqZClK7cmcPreRjxVsiSUcG4CMSTNUapsK13HryhSo3AgDbyVNG
         Hk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759424598; x=1760029398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fydY7mK4i/0lbTC8CRhN+yWYi1t05KnZoS/Ga1Eg7s4=;
        b=T0DZM/K618nK/IeR+LyBgLfXuoBzXxvHLPu3HGljFtYQCKSNdUcENO3BLk2W/TYn8f
         KQEQE/gic4U9DtIq7rSSIQXHzByzS52rREu+52Hh4LTP+FgNnA0saoXjcW8ZvNGaNgu9
         P48R4siHLY/PJeerUwqTPPfEnJUO77lYUwWOwazSQufPvuxkZz+yi9tiupvwHRjh1GJ+
         O2Dn0TK87X9HLwhilIIRnMJmK9lvXN8+DS5935ymi4UxPwO0geFt76r4w9Do+tr/yeRr
         JXYHoJBnf1zuBpwcD1k+MYrvhLS6O8+xlKB4mKtFmmqQINyQewzH8NfHq2bGpHXT5vnu
         zHDg==
X-Forwarded-Encrypted: i=1; AJvYcCVn9UfbfXK+SWm2kwjMTMKycgO1s6dm6CA+NuW29ZQeZ4AoT45Jc2Sp50nnVfHEmCeJNKCpiPKghl5IzpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmlvPVlwckSvg2APMJkNlajYFdWDbJT5+l45iTjSMhKVsMeUqq
	cMSWRgYXnVwKeN7O0uL4DrHEpZ592Kpnm71q/0eGz9c2vWWNYnRgo0B+EnQONTZmn16hhLaQU1z
	7mE86058UL8iPKzy26fpOjjWVQLQ+MPUtlTDdEMJK
X-Gm-Gg: ASbGncs8/zvgOWoYKWti62vyrItl8n4l1Un4nemixYhCbFcCNQRBfSjk4SQIXXIkwBp
	LBTyLmkizp4XO5Xvhko2/ZHfFER97rIwb5NIfFsWO+qPs3z0jGIy3J3wlKfga8JtJMM3mwRMO9r
	/lhtE8wQmVfeUhG8yQFLG5KcA85C308QwwwMlP+iT9f0RLlFwCZFhTzsFvYSh/MJcq3DlHMThKY
	NE1cs1EiK94/cffgQmqwk6vRr/2zErf49NjwpVUtUjwx/x2eiyRh/1uH/b5pjbCKHQeJb7zJyF3
	oroXtA==
X-Google-Smtp-Source: AGHT+IFcfdsLo3nl95pglK0oIiBcavSwsf32aKpQ2y2wm7BVnvTy3LNj+ZhguDZmbmWXKhCmFuaDsyjuhCPmvrLVttY=
X-Received: by 2002:a05:622a:1807:b0:4ca:c49a:549d with SMTP id
 d75a77b69052e-4e56c83ecb2mr5629671cf.9.1759424597142; Thu, 02 Oct 2025
 10:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
 <20251002134112.GD3195829@ziepe.ca>
In-Reply-To: <20251002134112.GD3195829@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 2 Oct 2025 10:03:05 -0700
X-Gm-Features: AS18NWAi0bfqRXKx0xb0v3E2MBmqsrGh5NbhfEqpQd8Ru5iozeldkFaXuLV7kyo
Message-ID: <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 6:41=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Wed, Oct 01, 2025 at 06:00:58PM -0700, Samiullah Khawaja wrote:
> > > No, finish should never do anything on the restore path, IMHO. User
> > > should directly attach the newly created HWPT when it is ready.
> >
> > Makes sense. But if the user never replaces the restored iommu_domain
> > with a new HWPT, we will have to discard the old (restored) domain on
> > finish since it doesn't have any associated HWPT. I see you already
> > hinted at this below. This needs to be handled carefully considering
> > the vfio cdev FD state also. Discussed further below.
>
> I think the simplest thing is the domain exists forever until
> userspace attaches an iommufd, takes ownership of it and frees it.
> Nothing to do with finish.

Hmm.. I think this is tricky. There needs to be a way to clean up and
discard the old state if the userspace doesn't need it. And I think
the LUO (session) FINISH event is that trigger. Basically if the LUO
session manager (VMM or LUOD) decides that the finish needs to happen
and the iommufd (or the underlying HWPTs) are not restored, it means
that LUOD has decided that the VM is not going to come up and the
preserved state and resources (domain, device, memory) need to be
freed/released. If we don't do this in "FINISH" then the system will
be in a stuck state and the VM scheduler cannot schedule another VM
using the same device and resources.
>
> While the domain is attached iommu_device_use_default_domain() will
> fail.

Yes this makes sense.
>
> > This is the part that I was concerned about since I was looking into
> > the auto_domain. Users that attach to ioas directly and use
> > auto_domain would not be able to restore the mappings before attaching
> > to the device.
>
> IMHO luo users need to be sophisticated enough to avoid auto_domain.

Agreed.
>
> > That's a good point. But it might be tricky since the ownership of the
> > device is with the vfio cdev FD. So if vfio cdev FD is never
> > restored/reclaimed the device can be FLR'd. iommufd will follow along
> > and discard the domain.
>
> Honestly, I keep wanting things to be kept as simple as possible with
> as few exception flows as necessary.
>
> If we make it so that iommu_device_claim_dma_owner() is aware of luo
> and the only way vfio can get ownership is if it is also restoring the
> luo session then that sounds perfect.
>
> Attaching a non-luo VFIO would be blocked by the kernel so we never
> get these inconsistencies.
>
> > The more interesting case might be where cdev is restored and bound to
> > iommufd but the user never recreates and hotswaps a new HWPT. In this
> > case we can discard the restored iommu_domain and replace it with the
> > blocking domain as it should have been if the device was not
> > preserved.
>
> Maybe the HWPT has to be auto-created inside the iommufd as soon as it
> is attached. The "restore" ioctl would just return back the ID of this
> already created HWPT.

Once we return the ID, do we make this HWPT mutable? Or is this
re-created HWPT just a handle to keep the domain ownership?

I think if we make it mutable, this will really complicate the design
and we will get into the sanity checking about attach/detach and
map/unmap calls on this HWPT. I think keeping the restored domain
attached to the preserved device until it is hotswapped with a new
HWPT is cleaner and simpler as you desire it to be.

I think if we consider FINISH a point where everything is supposed to
be reclaimed or discarded then this problem is solved. This should
also allow LUOD to cleanup the resources and create new VMs using the
same device and resources. I see you suggested in the other thread
with Pasha that we can make FINISH fail if things are not reclaimed, I
think that also means that the system would be stuck in this state
indefinitely. Maybe this is correct since the domain is owned by VFIO
and needs to be released by it.

>
> Again, this seems to avoid special cases as once we exit the special
> luo mode of iommu_device_claim_dma_owner() iommufd is always
> responsible for the iommu_domain.
>
> Jason

