Return-Path: <linux-kernel+bounces-840697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA1BB501F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BC719E35D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EDE28507E;
	Thu,  2 Oct 2025 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4zMbKaY"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F24258EF0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433381; cv=none; b=MKkB7ZXCqiufnsUrnYrEWn0pIdhuKx+1nyitoN2rH8G4ymG5jkFicyEVmugrt49TbvHGWp5V6Or2AZc2l3i6f2xhPsCWAfzKF0onDS8LuRVf+3VNnEJiKmPH0eLAucUE5zJVcN8LQBP66RcFuJ5IMFywPJyLpMQr59oxMuFxzPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433381; c=relaxed/simple;
	bh=L2u7PhG2hVg+yWSLzj+SP8+91k9j/TQra4RUm538Nhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiE91XoM7ZTlpdtikfu+8SjGpQwmeytEnfBd2IjrgQgG3ioOvqE1b+lGcRM3Om0WikTOHmmsCB5BD+S1ufVTMehYlc1GWjBi1jWKx//kT3z3fK6jSzIA33nlSE5wrWKTFGkA46LvedVDpFZNAZIuJBFUKHUOQ2aNUJQHVGUooOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4zMbKaY; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4df3fabe9c2so2971cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759433379; x=1760038179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2u7PhG2hVg+yWSLzj+SP8+91k9j/TQra4RUm538Nhw=;
        b=F4zMbKaYiHo/5+CZFCGmPU2kkpDMi5fjyqLMtVkfVmmG3qYW6eeHW4eDCSmF0TES1s
         IlcvxSfMiBFp5UcbgLFRocwAoenyZvHVJ4RJ+UH3OPz2Kal3/HocHhOdgOdKMn8iZJ53
         3Is9SsGyftc3a3GzC2sQ9Q0v7iCF6x+3U1Lc/atfcwXGHv+1UHmIK98CoaFafxPnFbDd
         7LDAbbQ49l42edrk8W13QRqqV36cYEFePHmDVfYFnvM/AYIXFdRixnnaXFWClVbY8V6J
         rFzaUqd9lu7DxceD3HdRMzSqEOPkgqz7FLdE5m5ZxKi2wEsfSLNlfiU+4jW9K2Pcf3gD
         YTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759433379; x=1760038179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2u7PhG2hVg+yWSLzj+SP8+91k9j/TQra4RUm538Nhw=;
        b=IExcmfEzjJizkYbqO7Rtf8ZcF8F/4ftQfXQ3nr5nmc9oQ8GcK991WnWRAokPBkT91Z
         tlC9o7XO0Hixv99GDx4H+OheMZ+oOzyc5nScwoQwbMC+G6pkn9I7Y1b+oMZsG//abHL6
         BUngDf34GASJUCp3Q0I1xMTQ+palk4fz6KdKFr8Y6mAxiakwI7Wf4tJipEHQVZ6l4XUC
         1aKmRNQ60hiwxjxhLJ0fguPjoWL07VLn6VJZ0M9BUKdA5SqeBAJCFVN5OKq6L+BfZXgQ
         sEJdt0SrOhV+ZTEX0CPONShddh0tsTlxxjb28dfO7m3p5cgZMuXdzQpMpVEpWJM3/RY3
         5VoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYxLV6irH5+rwoXxGKXVLKDYy6Et4uP691IFrjG2dTUVePlhU0rvpiD8K2DF4FZOekar9JtilcA/zT9CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYWhf58rNzxWnpIt2HkPvx4UEKfuqTopOk2+JNG/etPA3wxzG
	lstaRuRiYyrbif34e/LC3ntuCa0DRHcbANIzCOfJyulhPmYg/y8V8KYn9GNPHNCJLCFYqXacgQA
	XnrFAtHRxYQTVsKWfSlic8xEYdCTynVrN7kyXO3Zi
X-Gm-Gg: ASbGncvFxnAy/9216+9DtvGE1OKbzkIDFDX7n8gCJUKEWjt89n4LpooXkac/Y15AqL7
	xCaMOcVOkl0Tk9zBMJY/2hkSMD+TO8ibm9VKS0IllFy0sSpHGqmvh5YtcN999lQLryWzbj5r+mk
	AImLIyFYCeZ3U35FamNGm4ePjWJafJ0XS1cqVpnvtcLWr2gOvmb1s2yfIqcu3xurocPXXWWoiSX
	UAxNGSQJIAKXN/XM1QKg/JCXi8a0ulc8BorNBtHFh2t5sHUVpbmNy2ksuRBsz2aUuQ34W4=
X-Google-Smtp-Source: AGHT+IG1VtoYtqefc+SKzvRAMV/hvnzBHVa3U0eqUwJo+ikfv5tW8uurQLIa4ePuZX9TNIvh3Ut/XEDLHo5Y7YPwcVU=
X-Received: by 2002:a05:622a:2b06:b0:4b3:7533:c1dd with SMTP id
 d75a77b69052e-4e576b9436emr898881cf.1.1759433378465; Thu, 02 Oct 2025
 12:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca> <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca>
In-Reply-To: <20251002151012.GF3195829@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 2 Oct 2025 12:29:25 -0700
X-Gm-Features: AS18NWCLvUocYb1YrfwQdo0SU6N_bDWtnj2kplIrYTjYsks3r_IoDR6SzwlPV88
Message-ID: <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
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

On Thu, Oct 2, 2025 at 8:10=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 10:43:45AM -0400, Pasha Tatashin wrote:
> > > Finish on resume shouldn't indicate anything specific beyond the luo
> > > should be empty and everything should have been restored. It isn't
> > > like finish on pre-kexec.
> > >
> > > Userspace decides how it sequences things and what steps it takes
> > > before ending blackout and resuming the VM.
> >
> > This is a fair statement: userspace knows when vCPUs are resumed and
> > can decide when to do the HWPT swap. Following that logic, what if we
> > provide a specific ioctl() to perform the swap?
>
> Yeah, that is what I've been talking about. The ioctl already exists
> in iommufd..

Yes, I agree. We can use the existing ioctl and the hotswap happens
when userspace attaches the new HWPT to the device. That has been my
understanding as well.

Userspace should indeed have full autonomy to perform the hotswap
whenever the VMM (and HWPT) is ready.
>
> > What do we do if the user reclaimed iommufd but did not swap HWPT or
> > did not perform some other ioctl() before finish(), simply print a
> > kernel warnings and let it be, or force swapping during finish before
> > going into normal mode?
>
> The problem we haven't discussed how to solve is the linkage between
> the iommu_domain and the memfd.
>
> Since the preserved iommu_domain is referring to memory owned by the
> memfd and the pins don't get restored until the iommufd starts and
> generates new pins. Thus we need to keep the memfd in a frozen state.

Yes, there are dependencies between preserved FDs, and we need to
consider them during LUO PREPARE (preservation). We can use an LUO
helper in the can_preserve callback to check if a dependency is also
going to be preserved. I discuss the restore part below.
>
> Maybe that is the real use case for finish - things like memfd remain
> frozen until finish concludes.

Yes, for memfd LUO file_handler, maybe that is the purpose of FINISH.

But that gets us into the discussion of whether a dependency is
ready/allowed to mutate and FINISH. How would LUO file_handler of a
dependency know that it is safe to mutate/finish? Maybe LUO calls the
iommufd FINISH first and if it fails the dependencies don't get a
FINISH call.

I had a quick discussion with Pasha to see how LUO can help with FD
dependencies and FINISH order. Perhaps we need a new LUO API that
iommufd can call before live update, explicitly telling LUO that it
depends on an FD that is going to be preserved.

>
> However, keeping with the keep it simple theme, finish can just not
> succeed if there are stray objects that userspace has not cleaned up
> floating around. Eg a simple refcount and iommu_domain decrs it when
> it is destroyed.
>
> Jason

