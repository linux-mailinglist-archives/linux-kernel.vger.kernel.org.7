Return-Path: <linux-kernel+bounces-760732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90259B1EF5E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40181C27A61
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E522343C7;
	Fri,  8 Aug 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ftvagsDA"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B621CC58
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684438; cv=none; b=goO04NQ5B3/72DnewC95FVPE/uFUC2avFZz4cfnXIzw2anpk1582ERR4H1AolfmC/GNmIIbiCqQMkqq5jyNXwzLBltcXOYvWHFCa1VTVCU1MXHEO/h8f9ZyomOLq++flhu8XlFsf7DMuXPpJ1H6+Gfcy9uVAab5DgfTbHSpQ6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684438; c=relaxed/simple;
	bh=xCzcDEPseUj6dwEakDSVeahmG75Mdil8GGbmQtbGq1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMpFgU2D61y4C5lim4WQxkLeEf3e7fji9XwLkBbB8jfa+rcp+clLS34ooVXShUFFmV6eUoAWEp17H5sKS048/CIPMJWmHjKFPyrGwP/y6IEhq4l58EdkFlm+Mx+fkRF0RtmsOI/CeVUHo0279w/8wehaOEMho4Tb95w9B4G2Fvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ftvagsDA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b06d6cb45fso31336301cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754684435; x=1755289235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQYa91kkeSfQG6Jm1FdT+mkrUk8mk+nsXZw2Gvf2uBM=;
        b=ftvagsDAfbPb8S4pSEKEvhXWuW0NCQzJne+7o3Np+qkVGAM4u5YEUlabGgmTKSgXzM
         NjG8uJYs4fgWiWJZQiil0in/jrqe1dvQdgati1dJClHgDTpvvq7Gn3AWj13VqXxpiary
         DlILjO4h5Rj85t7wiL0h5FR75Bgq/+oHKDqqXXdIMLIazCZkGkhoC1mfFZs3hgSjtitL
         vVDZz26fcXwRyxHCluLIte/0z1yKizDQld3ORVyn0iaEEPQdNDw4UKgk86MI77YlpvOR
         KN9W23+bj/CLEKwsqf8pNOMKsUc0O2rmpWv17bfmsrFSGmhpSITmC/DV2FBAelRYzQcg
         ELhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684435; x=1755289235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQYa91kkeSfQG6Jm1FdT+mkrUk8mk+nsXZw2Gvf2uBM=;
        b=xS5zVOeRqde+4XMxRCFQPH5ehb2J6IYQf535IqcbabL6V27yfYOim5Ndt4Dya6uxYK
         O4p2Fp+AKkGJcsroDMCfdxbqQU7GVp0cSEzcu/T88QBXBj+xZg7qQ2Ra67b2dKoazM6y
         yvpkRYm0RdPCPIig1hxoBX3V+DhxOH6MvxXp4fKtoHh1tdUtEcQnbUX9pPXQ41BrATkv
         3WIKfPgUjAh7OwQro5hbcghg9ASRRwLKGwqEM4sHx2/0CqNY0Yq7BSpqiKSFrjtVIpWr
         czniRcxTXRYMFat7k5YNI6BpKjj6Z3J6rYpik6VZUGDAhce3OjVe4xYfBWBIYHawntH4
         59GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCPAHlrubU19I86ux4KSo1CiKjdsimaEvuuzdZJUVOz/a6h92BVnXzlvAq1c6BTHT30iOSceUOtZNxntA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwNaa12KDhU7yTF4VsX1z/oKeZgQaZ9EaED6OBmHO57pRFIeAN
	WaqX9H14UCFqcw5IXdMiw6uBuuliwWEYXC9PdlSg6wjzFk7FZHYM3EoTaXKGEF3t24x89T2NMlh
	+GyUx6ZUqWI4eGOZULuiP0RdkKXbMXtQcm/rama1IzQ==
X-Gm-Gg: ASbGncvqZOZWxlL9bg0s2Tq8y1LHFXyH9S/pglLZ7hBQ6cQVgEqd4bPwp0tciEs/1SH
	vjcB708WqGn190qOdQwlCZgGuUNqg7V8/NC7Aikr0tyaKCNwu4JAjgXjlXN2yvX/Xv1KdDqXw0h
	Wg9n/WpiVo7vav5qECOKt6H6Xld4IRlNvcET/IJqKfnfEThiRYnnRklSBMDjbkAtvp2RPgQNHsf
	uOX
X-Google-Smtp-Source: AGHT+IEo3U6rdysgoF2C0xCMhrgpG0Agqof6n2ba9uwRUTWht+9WRzi5tte7RjhfTHV9iSsZvxQedOnK/ZZyoy8est4=
X-Received: by 2002:a05:622a:1a0a:b0:4b0:6cef:19d2 with SMTP id
 d75a77b69052e-4b0aed031fcmr51001501cf.8.1754684435323; Fri, 08 Aug 2025
 13:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-2-pasha.tatashin@soleen.com> <mafs0o6sqavkx.fsf@kernel.org>
 <mafs0bjoqav4j.fsf@kernel.org> <CA+CK2bBoMNEfyFKgvKR0JvECpZrGKP1mEbC_fo8SqystEBAQUA@mail.gmail.com>
 <20250808120616.40842e9a9fdc056c9eb74123@linux-foundation.org> <CA+CK2bCVziiUZzdGaEabmPSB4Dq41QZe7gVxtgwy4pWmpo=D_w@mail.gmail.com>
In-Reply-To: <CA+CK2bCVziiUZzdGaEabmPSB4Dq41QZe7gVxtgwy4pWmpo=D_w@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 8 Aug 2025 20:19:58 +0000
X-Gm-Features: Ac12FXymO_RsH5GAn7D-2QfHaIXjJtVjSwQOC9gpco0na8ETzrHiY720l5D8Qt8
Message-ID: <CA+CK2bBjpZLiqK_63L-o+vxotz5fTUMpO4NgUaJ=sEV72qGyqg@mail.gmail.com>
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 7:51=E2=80=AFPM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> > > Thanks Pratyush, I will make this simplification change if Andrew doe=
s
> > > not take this patch in before the next revision.
> > >
> >
> > Yes please on the simplification - the original has an irritating
> > amount of kinda duplication of things from other places.  Perhaps a bit
> > of a redo of these functions would clean things up.  But later.
> >
> > Can we please have this as a standalone hotfix patch with a cc:stable?

Done:
https://lore.kernel.org/all/20250808201804.772010-1-pasha.tatashin@soleen.c=
om

