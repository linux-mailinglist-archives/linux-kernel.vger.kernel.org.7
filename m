Return-Path: <linux-kernel+bounces-872158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32ABC0F70D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B59466620
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326B1311583;
	Mon, 27 Oct 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyIJ2kiA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F530F7F0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583267; cv=none; b=B6elq8Jo2Ou+7OajqpK4G5+LzZunDJ535fZVJbSCwezDkdyAn2igctECseh5la0Tedz+z3TfeiqXR2dQzxWtywooLosAI9ajLkc2gSHNK+jdwRqrYu14Xn/LBJRqqaoQ/8ZpIgTLSuMSG536JB1tj1WU2mzskyIkI2Eb7sH90kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583267; c=relaxed/simple;
	bh=YvO3EjSKrMULU4MU7n6apNKpcUJ205zLnvXrEAqn5rI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nkHnmsstbLwS/amBk04Cet2IdmXdZELnilcho3RqGSSxfJfrB50rBNs5SQ+2pkzup3i/JHe9aeJWRzL/byKbCnBrLGGbI/Wx9b+6Q2zPyynEOvqkhkyhwIHrVQCfNxRVQykvpjRSfoNaCI1X4GMC+/8sRmREYNs+ak7JEwvSxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyIJ2kiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC23C4CEFD;
	Mon, 27 Oct 2025 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761583267;
	bh=YvO3EjSKrMULU4MU7n6apNKpcUJ205zLnvXrEAqn5rI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jyIJ2kiAogOLX8i/NYhD7/KSkrZa/7Dl/4JnqQCG0wbkW8JkOpJ0399YbBT+e5bgh
	 sxKqSnX0EklHI/SURIyAu3FPx8xvl4T105n94+bglWtBaudmMGFyk5QEiFOtaSF8L2
	 zcO3TRHXiPQ+XoP2PKyI4Zt9hJqaDUfKNoEfpawoV/Dzd6Wx0saA5OWNPQiJIO9elU
	 VoQZGb9THsu9D/uVQ35QVhoqk1dwlOTpmsLmhrMaU5TM3Ij3K2pBEgMPVzQegh+kpf
	 x56bRGBxJozYgYTakX2KZwaK+NvFxxxbR6RlvAwhYVkD/bSneEHRXX84pxeYakQR4S
	 6v8GAudwoNIUQ==
Date: Mon, 27 Oct 2025 10:41:01 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
cc: Icenowy Zheng <uwu@icenowy.me>, Huang Rui <ray.huang@amd.com>, 
    Matthew Auld <matthew.auld@intel.com>, 
    Matthew Brost <matthew.brost@intel.com>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Maxime Ripard <mripard@kernel.org>, 
    Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
    Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, dri-devel@lists.freedesktop.org, 
    linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
    Han Gao <rabenda.cn@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
    Inochi Amaoto <inochiama@gmail.com>, Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH v2] drm/ttm: add pgprot handling for RISC-V
In-Reply-To: <dff6216d-b4a4-4d5d-89e3-e393dc018dec@amd.com>
Message-ID: <5fed2297-4e51-6aa9-464a-6f8a2cf8fcc6@kernel.org>
References: <20251020053523.731353-1-uwu@icenowy.me> <dff6216d-b4a4-4d5d-89e3-e393dc018dec@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-798525650-1761583098=:20800"
Content-ID: <d1ca5497-3239-01f3-606c-51cfffc22eec@kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-798525650-1761583098=:20800
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <e4c53a36-2fe4-7c79-5307-a54b036b1dd4@kernel.org>

On Mon, 27 Oct 2025, Christian König wrote:

> On 10/20/25 07:35, Icenowy Zheng wrote:
> > The RISC-V Svpbmt privileged extension provides support for overriding
> > page memory coherency attributes, and, along with vendor extensions like
> > Xtheadmae, supports pgprot_{writecombine,noncached} on RISC-V.
> > 
> > Adapt the codepath that maps ttm_write_combined to pgprot_writecombine
> > and ttm_noncached to pgprot_noncached to RISC-V, to allow proper page
> > access attributes.

[ ... ]

> > diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
> > index b3fffe7b5062a..aa137ead5cc59 100644
> > --- a/drivers/gpu/drm/ttm/ttm_module.c
> > +++ b/drivers/gpu/drm/ttm/ttm_module.c
> > @@ -74,7 +74,8 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching, pgprot_t tmp)
> >  #endif /* CONFIG_UML */
> >  #endif /* __i386__ || __x86_64__ */
> >  #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
> > -	defined(__powerpc__) || defined(__mips__) || defined(__loongarch__)
> > +	defined(__powerpc__) || defined(__mips__) || defined(__loongarch__) || \
> > +	defined(__riscv)
> 
> Looks reasonable, but does that work on all RISC-V variants?

From an RISC-V architectural perspective, yes.

Of course there might be a hardware bug in some given manufacturer's 
implementation, but then again, that could happen on the other 
architectures as well.  


- Paul
--8323329-798525650-1761583098=:20800--

