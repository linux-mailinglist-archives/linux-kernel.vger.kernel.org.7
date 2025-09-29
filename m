Return-Path: <linux-kernel+bounces-836667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB9CBAA427
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64C13A46D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE07D22A4E1;
	Mon, 29 Sep 2025 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsE95/yW"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058319F13F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169496; cv=none; b=HAyIJ5O3FBbrCSlM6CPbYTYwk+83weyzZgMtVjPNXiEUW3Wh1eSOKRCpEiScCN6lA53gsGIHDNyrOuEn9PbSI8+HqvlzktaiCvWk2DxXhQrllbdBwHz5SOa5MmtYzGTiCds02KR598JJ61HAh9Xy/NfGr1cIvO29M4Zd/ro+DCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169496; c=relaxed/simple;
	bh=oaBnKYKRtDSOkq82mNcg4j2E9t3pxhoUAjF8MG0lM7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZ9HPkfj4Z90BTY9Um+ICADVIgsJEluHTbRXlK7hs/E8SMBrEisPCA75IZavRsqJ/I22/ObNbvy7sVmIHsgE4sJbBoPFDp1ngzbaCii8+rAjJCTaJTZ14DArlaQPbKA0IKEC/5xbA70O/2IWl7yqvVsji6ucJFSENIGZjPOAgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fsE95/yW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4de60f19a57so53831cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759169493; x=1759774293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WP9Pb00ucL3q+YTHoUOjxzFDPuJDXrkNbKXJ5OVUaw=;
        b=fsE95/yWqKECwV60TflZE+8noIKBUR6tl+Za9pQE1B8xh0WvBQLpkAX3AteOchF/SX
         1YIKNFtJbDKuh7QsCkXUqE2hYcRLXOhYDlDMoOoNj6HhpmWuLqljfiDnw0u++KXH3uO4
         VSooj88AhvYx7VnRwJbkEMYfyQZ84O1p77VFLypz9uWn/9ji/CxuYESl3ZZVy4jyBcfA
         nwDiedxT63u9T9PfopR0fwfak/pNyEU+7dXExVcC7+18EYuwOReVVX3oChWOkIpMEDQS
         dD63t9rZ1+gVhv0GykHLWhf7i9DDF06SBj6jvB4R0vWMx/642LIBki+Ggj6tIaKyROfN
         mBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759169493; x=1759774293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WP9Pb00ucL3q+YTHoUOjxzFDPuJDXrkNbKXJ5OVUaw=;
        b=KpBaYogF97yUcM2CuU5MI14VkZ9+dtDsE+GWhs2P6kzS41T2YRwyVCrP7H1p+y6VQe
         Pe47fktXlYo6AaLsDJbb+B6yps7zL/asJ9xCZEJ9U9+NhLz4umvzlDH36zlPENJpaxOx
         o3pzNG4W4LGbSLZ0923veCwa/OlFVabDqDI4zGtQKH/XhjhcIeK6dSVQ5mGXdzqyGZpM
         QGTkp46tZ3e4r5BERa4eUK7y2xeNtHbS03Q0cuFVFKDupOiEcgclCbcWkulQJeI02Ziy
         j0NH1Utgl3tYHT8K2AtIh9RCMvHOON5bFmMKTyiAmzBcjXhf9I5G55TKTd0hDZJwyzzz
         OXWA==
X-Forwarded-Encrypted: i=1; AJvYcCWbk7yk5WJePSSoNrAryTm+C3kCbiEDzhbY52dHVxGqdDbsnc3DME+huxORDUuHDCBeSHFrq9/g5MQDxuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypqpczUlUqCqFYtzwrbDJ6/3xlZiNqe8ueTYbfJCb/7YxGMoqm
	BN01MrE+axrx0c/a+gihi6quAENZbd+gxuCLpq4HD3Cgw5tlbfvyhYZLOjOMOP6UB0Hgf9CVX7Q
	kZ6QQR6HhogKS0Agnrae0Uqh0+ARrM00nN1QLteeb
X-Gm-Gg: ASbGncsOR8SZ1tmRFZjIZ6mm48Jt/1jwre4IMyMWIRE9INO7wp4ZGaq/UP+CXNCbH3C
	py4ZvzIPcbjvQkNfuTb0HSyY7MlUq+D1ybIEGuHL4UyC0V3O12oToTUzJD/U3ky3SgHGjVtWpNN
	bnqshhQJoa1JYdLqnmsEL1OTwdCFzd9IjgnCoUtVNXb54z9xe0EGI92ktBVZ7jRCItqQcmgVkyI
	XJhV29g4UY5zc/BsaYliIxPmYq8D+cmKYzrZeWANooTYgRI1xwSWgE=
X-Google-Smtp-Source: AGHT+IFk9+g5RGER16T9Rf5j3thJpIbSLaw2lbdh0SFeSMJ0I/BaCi9UDExRyE6OwQZRBGlbkaoGaNCtxagEZxiCCDI=
X-Received: by 2002:ac8:5790:0:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-4e2d49c9dd3mr898521cf.7.1759169492701; Mon, 29 Sep 2025
 11:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-6-skhawaja@google.com>
 <20250929155430.GD2695987@ziepe.ca>
In-Reply-To: <20250929155430.GD2695987@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 29 Sep 2025 11:11:21 -0700
X-Gm-Features: AS18NWBVbyJFfnqTe1gc_E_0boTIQTS5TdlZZnZSyILctEmVzhw_D3pAIZAsjos
Message-ID: <CAAywjhSnmSeiJ-GjensY4x6DMsTCtG-Gxq8WtMc7BLTFfXrEmA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/15] iommu: Introduce API to preserve iommu domain
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:54=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Sun, Sep 28, 2025 at 07:06:13PM +0000, Samiullah Khawaja wrote:
> > Add an API that can be called by the iommu users to preserve iommu
> > domain. Currently it only marks the iommu_domain as preserved.
>
> Merge it with the previous path
>
> > +#ifdef CONFIG_LIVEUPDATE
> > +     atomic_set(&domain->preserved, 0);
> > +#endif
>
> The memory is kzallocated, I don't think this is needed
>
> > +int iommu_domain_preserve(struct iommu_domain *domain)
> > +{
>
> I expect this to accept some kind of luo pointer to signal what stream
> the domain is part of.
>
> Domains are linked to iommufd's which are linked to luo sessions. This
> all needs to be carefully conveyed down to all the lower levels.
>

Agreed. Currently this is based on LUOv3 and once I rebase on top of
LUOv4 I will rework all this.
> I also expect preserve to return some kind of handle that the caller
> can hide away to deserialize.
>
> > +     lockdep_assert_held(&liveupdate_state_rwsem);
> > +     if (!domain->ops->preserve)
> > +             return -EOPNOTSUPP;
> > +
> > +     ret =3D domain->ops->preserve(domain);
> > +     if (!ret)
> > +             atomic_set(&domain->preserved, 1);
>
> And if we have a caller handle then there is probably no reason to
> have this state tracking atomic.

Yes, all the domain states can be serialized and backed by the caller
handle. But we will still need to mark the backing iommus for
preservation, because the state of preserved iommus will be needed for
restoration during iommu init during boot. That is why I have a LUO
subsystem registered for IOMMU.
>
> Jason

