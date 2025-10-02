Return-Path: <linux-kernel+bounces-840385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E8BB4413
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F5B3AA0E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8B187332;
	Thu,  2 Oct 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Fa5xH9P9"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D9323E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417185; cv=none; b=bFbGUoRxa94V7b2iJ4e/rEnmVdo/HW+x7CUmyhYMvQpQEuiI2FOu7y5hc0ik+8oJE4/7XvRPXtVMwW/ZfK+r0EvPE6TU+saryrHhlJRPw3xErtI0UL1PAXccpLItw7eza/8RQiO6jUTKOO6oOx4iWcaeeOOyvty7l/FBAmFOLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417185; c=relaxed/simple;
	bh=6WeaPM89+N+t6zeVK5eW6ZJd4Yp9j6uP6WJ/D1N5cM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNeE4BWzLmkMNxNBo09DPdLA12Qka2k/bUwP03+mrKMmZNbIeeDNfGDLoutiZZfUbI9zG+DDBv4a6ZNArHDySV48bpR50Y1jrLYBwJ8ileYdENBmkpviNvbmMFE7gsiAnMQ8lgV23U7aTln92Ly1q/1B8lsYUjGq1A3mR1dxR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Fa5xH9P9; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4df2911ac5aso7022971cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759417183; x=1760021983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WeaPM89+N+t6zeVK5eW6ZJd4Yp9j6uP6WJ/D1N5cM4=;
        b=Fa5xH9P9i9OLlg1royAV92X0wqabaMBMT0OSU8qNpyslZkxL010HGFQaIv9jYicwEh
         u7aKI16eAU+Ju06HH9GtKar+uYO2wHSDNppEQk6kjS8jmNboBJYMa6vzYikyZcvZ+kps
         J6elicKg3kttJd4a6eMptMmDnMjb4bLtHFhHqzQQ/hqsuUa3oXPIDcr8vBrI9TreRjU4
         p4qJj/Ew3zq3AInwx55lpIQtNEb5bvMtA13gOHES/1xLRF9C2HkiFKRL+P41RnVogXNX
         z1wnHiZAlkEOiDpoeet6HVVV21zaDhSw3Z8n3ShRbI62m1bRweZf5aDSGjY86oGxPBir
         AAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759417183; x=1760021983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WeaPM89+N+t6zeVK5eW6ZJd4Yp9j6uP6WJ/D1N5cM4=;
        b=l9Xvu/Q9Rr2tnb7o2iGD0/S5J8NrWfwKpdB0FzZkXu/lkQWnjhcDJ7Z9F+ZkAjyWSr
         h8k8+pdyQtQDXWG7RkRcBnBBfibVUsY5AerxfCe+sNp9Fa20WzSO4dUkJJ34ot9/Hph4
         msjtPeNmm3KvWpt4C3YUf3gABMgjTdP4OtVBT0f+1A2AYDxH5AjA65lE6uR1/J8Wd+4p
         2LqNlt6951RzGtC583GwqnLfifFesPzKKUSbOepinw/k81gvWC1mFNEl3yjvKUzQg+mS
         Vem6PfH4TICash8VIK09AKfgUwDE/ydAKtTjtGVIr6atz1bACyJVnxIj3IGKG3HnAilp
         KJNA==
X-Forwarded-Encrypted: i=1; AJvYcCWVv394e+8puRSJPC9F5Xtzsl7TLKs5PCMno/fHgpMHcdrDQrYUVUYB5a3wtPJ5aJ9bz1MgHD02+fU1vUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwegX6fp0seNcGm5RzODU5Qz7ewonsgGZ9WsG8ho0QmvHuErSFA
	IpD98MZxE8vyLbz5cmfUxpbS+AjD2aBQ+vrsb9YRBB1bW4oUZdebN/438UOse1US9qZBMhoFY6C
	tyff+B7yd4Mj9w8mrFiTJkaVqYLoBj7oDyQJw0179iA==
X-Gm-Gg: ASbGncsqXmRc0wZNRbFzJKawIcA0141QlUElKrkBEiwVz18HQPTX5HYaYBEeuXnBEmE
	7dEaAQ0tYPvO9aWYuD5MOsozdYJp5huh/vyJBikPg7vbPNusZyFiU8+gYwNOPADcEkmXWY3lQ2l
	1qEKt+bgDZOB/J5i3GGFcoW7lEfsozkIfMRSsDiIwVygnoAHOlGTvXLeNwKOOyy71crncQ92kyM
	ElEVMYB0TrczSocfsPJT/utK/ls
X-Google-Smtp-Source: AGHT+IEDIsfGTs5/bZKY8SdHaNpGi2ufbe9YQq/ztYQ1wGQjwGVUH9/Oqkd/Pudem5j79i0mGz4zL0iNCnq1XUSd4JA=
X-Received: by 2002:ac8:7e86:0:b0:4d9:9f2e:fede with SMTP id
 d75a77b69052e-4e41e44a6e9mr90560991cf.69.1759417183048; Thu, 02 Oct 2025
 07:59:43 -0700 (PDT)
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
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Oct 2025 10:59:05 -0400
X-Gm-Features: AS18NWAvLdllLM2EOaTpN6MfJF3yIZHaZjSWh7GNC14VBVCD_9nlyXMqeR1Swt4
Message-ID: <CA+CK2bBvY7A-PBozXC7DQwza6OqETe_x3XasuUx9VJBKWkZR-A@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
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

On Thu, Oct 2, 2025 at 9:41=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
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
>
> While the domain is attached iommu_device_use_default_domain() will
> fail.

Ah you answered my question from my previous email, let me talk to Sami.

