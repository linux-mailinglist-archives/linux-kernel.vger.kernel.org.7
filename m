Return-Path: <linux-kernel+bounces-867173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60360C01C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E723B501F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09AE32AADD;
	Thu, 23 Oct 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lznF4sEs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF2314B88
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229462; cv=none; b=kqnKHv9pTS87kGcjSKkdYvg6AKT76MsmRwQuoPSTDtFsX+3WKBfjLnamx9rHlBENQc9TNEtYT9P/GOggCGmPP9Hwe9Hd5FbR4FumFXZJSyf1u+8wnucUMizAQNR+a44NrGJ85NcTECD3docFXVa7+vmsx++8FriFUxkK40AaX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229462; c=relaxed/simple;
	bh=ROt2XAbOsvOTefCTKaxDf18B8nqBMHnyExoANEuIVSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI62tnHIJs6to5/f8PU5TlVieMmsBEdwqaHiGrJEZ4nqtq03fHcwMoX8LSaeWfmlIlCOav/l6FjMw0rBMM5R12UYMyPYrhxpceKsjUs51kJPeFCTHQOdBjqF4LQWQlBAVo/4qhn7/dra1iYxmw+3BRfMKU2aG+nLdbOEd2kZbmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lznF4sEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CA0C4AF0B;
	Thu, 23 Oct 2025 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761229461;
	bh=ROt2XAbOsvOTefCTKaxDf18B8nqBMHnyExoANEuIVSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lznF4sEs2VBBaG+lhkkgH9c0TVj36wEDcHlfT59uDXRO16OEMrWCUaK9wD+/J+mWM
	 eNJBP6Xn568XTYRVkQqPbj7OnuWpsswg0RhbuljZSc8BmY8Ri95zc7R53vSJ2sVJpN
	 EY6J3o7gcN6FJBaw2BTMB5EG4Nk5MsdkO6u3LdC7DbO+pvw8tGXKoLWhGLlsnE29FD
	 kPkaO+2GYPq69G5noYYk8ZTSa000QI09sxP/eGPlUNXZZR0l1/aRlrjmLdLJIBYA0q
	 0s0FPXdkAKbBdacGVfS29KcesW1P3338FBRsApHS+drI3pqsM2yI+FS3MYsAGhbX93
	 PU5e7h0f+/W+A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 80382F4006B;
	Thu, 23 Oct 2025 10:24:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 23 Oct 2025 10:24:20 -0400
X-ME-Sender: <xms:lDr6aM4AmfEcoQm2fghe38n-0aLBMRusQVfx30OU1-alwNtdfCFDVg>
    <xme:lDr6aNIMwxWBE0Jxq8ViM4ymcUw0mUmY4JykJ_K-ypRpFrSnOxL8qhYnyBE2WGUxr
    VGxi-PB7v5zX-gjen16T7T5Ge6S-mQO8tLw93nCpojMpbCmgTvkpLw>
X-ME-Received: <xmr:lDr6aHq2ia2nJrablGtYvGdW5nnlshrR2po8CW3vwrRkjAYylGleDqMlCZxkHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeiieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghvvgdrhhgrnhhsvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhsrg
    hmrggrrhhifheigedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepugifmhifsegrmhgr
    iihonhdrtghordhukhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphes
    rghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrd
    hinhhtvghlrdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehhphgrseiihihtohhrrdgtohhm
X-ME-Proxy: <xmx:lDr6aL6G_T35ABDSJ_BcCtlXYXLParegxJHxYd2eod292g6Qm_niuw>
    <xmx:lDr6aDK_bSQ_cvd3DHZB7Yb_jrbwg0zgrtFwj-4rJTDkwgND0Ueekw>
    <xmx:lDr6aChz2NgM9ATKp_5jiTarq7TewaaTtQ-9srXP5K0fHiNU0zMtYw>
    <xmx:lDr6aFH-L9GtaQ5DrRA7MCx3hQ2HjdbKG6B36GqTAloGJOXntcYlIg>
    <xmx:lDr6aEJWA1SXAaIMwBBr_5e0OIBz7S1AGTCPML_lk6zLoF6t4pAtk-Hh>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 10:24:19 -0400 (EDT)
Date: Thu, 23 Oct 2025 15:24:17 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Usama Arif <usamaarif642@gmail.com>, dwmw@amazon.co.uk, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	ardb@kernel.org, hpa@zytor.com, x86@kernel.org, apopple@nvidia.com, 
	thuth@redhat.com, nik.borisov@suse.com, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, kernel-team@meta.com, 
	Michael van der Westhuizen <rmikey@meta.com>, Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH 3/3] x86/mm: Move _PAGE_BIT_NOPTISHADOW from bit 58 to
 bit 9
Message-ID: <yv2sjut5urpzz426z4wmufshbron35ohwtqk6jzun46elbcqtf@3z54nh33yl4m>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
 <20251022220755.1026144-4-usamaarif642@gmail.com>
 <98bc658f-2ec6-43f5-a7e1-e9424450a850@intel.com>
 <797c78f4-1a90-42da-9fed-e87682456a43@gmail.com>
 <90047889-3b90-4c6a-90ed-f155c92f7ce1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90047889-3b90-4c6a-90ed-f155c92f7ce1@intel.com>

On Thu, Oct 23, 2025 at 07:05:24AM -0700, Dave Hansen wrote:
> On 10/22/25 16:58, Usama Arif wrote:
> >> This isn't necessary once the previous 2 patches are applied, right?
> > In kexec if the target kernels have patch 1 and 2, then this patch
> > is not needed. Unfortunately, patches 1 and 2 are not livepatchable.
> > Also backporting patches 1 and 2 to all previous kernels running in
> > production in a large fleet is not very scalable.
> 
> I don't think I've ever been asked to apply a patch to make livepatching
> easier. I'm not sure that's something we want to pollute mainline with.

It is not about assisting livepatching.

Machines in our fleet may switch between kernel versions using kexec.

We recently introduced a kernel in the fleet that enables 5-level
paging.

Kexecing into an older kernel that requires switching from 5- to 4-level
paging which is broken because the target kernel doesn't expect
_PAGE_NOPTISHADOW.

The first two patches fix the problem for the target kernel. If we only
apply them upstream, we would need to backport them to all kernels we
use to address the problem.

The last patch allows us to only update the kernel that has 5-level
paging enabled, making it much easier logistically.

The fix seems trivial, and I don't see any downsides.

Ultimately, it helps with interoperability between different kernel
versions and/or configurations.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

