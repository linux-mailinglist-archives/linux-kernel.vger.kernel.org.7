Return-Path: <linux-kernel+bounces-881864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD997C2918C
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91597347511
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B2F2264B1;
	Sun,  2 Nov 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTK+r+PP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B7A1F936;
	Sun,  2 Nov 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762099731; cv=none; b=eKU6ursDpbJf+Khl7NGbBmEjz9R91pfjg3V8KwLvZww05hTXniwlljND794zARjt2v7ZnlAcDEFzFBmoGSi7B+JrWgkVVowFRywFvLnro5PnhGM/0tb1/uAlChsPCs/owKLj3ckNF6gAGKHEJpCJv3yf5GG8V1z+2zxstjvZ4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762099731; c=relaxed/simple;
	bh=R+eQUJqY93nsA0j/rgsWshRJvg4Yt8gRY5QAT1HTwxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vERunvf5Q88Y4U9Y/Dv/UUOq4ncoRW1nyUbWMt3RWWpoOOR3wp2/eZm3RyiOscmeMMMwwyYTGuf8cKCej0CV5R/YIMX/Jbed6cwJFy00DHkJGEGJUknODxrb11onwdMbfeuux/R+zSfra7VEuZWDsKqs9YygvxAknHsNObn1pMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTK+r+PP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58792C4CEF7;
	Sun,  2 Nov 2025 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762099730;
	bh=R+eQUJqY93nsA0j/rgsWshRJvg4Yt8gRY5QAT1HTwxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dTK+r+PPtpJ2OivgDQTeE0Om5Loa0FEbqXbx46BzzdjD8Gev69t5NMmO0aZWzN3AG
	 yG6jRaxH+z9lkiOzd24I3tS02L10KpiHX2frBzb+EyznE4zsLfx35bjOlpi1yb/29l
	 1MKBeA1rumfN7P29p2erk5baqKFo4yvxCmfZBkTRp8XyDIm4D9S0073UkFZCNTU8d7
	 pLwFHiQEjQWqa540Z6NagKXqEfiwuLD8ViSGaSSO9c2XqMxQn1tmjhBWLkVrbOZNnl
	 1tXqGcuKR9VUN4tlwNoBGDjte8dlPhpyoUOgs4JqfQLjBCGwcoEdQ3hMHvj6sm89/E
	 Zx+2pN5SHNL3A==
Message-ID: <eb51b5d5-7f38-41f3-882c-eb87eb2b9f44@kernel.org>
Date: Sun, 2 Nov 2025 17:08:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nova-core: Simplify `transmute` and
 `transmute_mut` in fwsec.rs
To: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20251023205146.196042-1-delcastillodelarosadaniel@gmail.com>
 <DDXC17HXPXFZ.3TIX7FHUJHAI7@nvidia.com>
 <70210168-ee28-4996-89f0-83f8590cb716@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <70210168-ee28-4996-89f0-83f8590cb716@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/25 4:09 PM, Daniel del Castillo wrote:
> About this, I was basing myself on nova-next [1]. I will rebase on top
> of drm-rust-next for the next version.
> 
> 
> Link: https://gitlab.freedesktop.org/drm/nova [1]
> Link: https://gitlab.freedesktop.org/drm/rust/kernel/-/tree/drm-rust-next [2]

Yes, the nova tree is the one I started the project with. Meanwhile we have
moved to use a common tree for DRM Rust infrastructure and drivers [3].

For the time being, the "original" nova tree is not in use anymore.

- Danilo

[3] https://lore.kernel.org/r/20250901202850.208116-1-dakr@kernel.org

