Return-Path: <linux-kernel+bounces-875903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C81C1A13B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF7318900CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8391DF271;
	Wed, 29 Oct 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orre+9VH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41D32E13F;
	Wed, 29 Oct 2025 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737786; cv=none; b=jNxga+skiSIoDTVXSSkV4y9bW+gp+Hbsvw9BgGSWtAVzHS8UrQh9IlGN1SE+NCxF51NCljx2pFV8RrYSCqguJYvaZcYQtUOw1Cm4f8FENEhgfd78s/IbB53HzPzBt84fYHoiMB3hVCYBouNwWrEEmacKOQ0nEOFro0oXih+/BXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737786; c=relaxed/simple;
	bh=2jx+TIh8gvU1T7h86kUnIS1+C65cSUbjzUvdLnx9Bdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/FyMWatgtLRFD+0jkRohV3xJrbsOnpq8Z5/7RSPy8RIWBnZ2ciliwQLZel7pqJBZ6JgqKeFKVKX+D/cDxjCZYsW1iWYQXuArIAQopyQ0PSFXY9PForHlIPlPDZRIPN8SIC0CUaZwO7QqzH09Vkb13znac6MiUxkfWr7ODpNCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orre+9VH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687B7C4CEF7;
	Wed, 29 Oct 2025 11:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761737786;
	bh=2jx+TIh8gvU1T7h86kUnIS1+C65cSUbjzUvdLnx9Bdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orre+9VHQMaNwuV2EKOVk1igoUDc8lFLeD/uZYx+n0pjYWut69ePF7C7DQjMb6DcR
	 Mfh275K5DGCIgRsCy4y4v/A2doF6BNe5HZSB5Lr3KsvUE16JVVNDdYR8k5ZvdbXMkj
	 FIm7XvTU//CO1F06z+mqWtaKHA4RSq2nas3C+6rNCA+mkQbRRNJvnK+txIBaaVwKNm
	 rIKlqu5oLacq35wfK11wYfxd5tN/i592pBjGwYdvLoSkqjxaYnTE2TPYeCF39ZQDyT
	 1lDIyfKvDeJ3JGPhFVlhJYAFXgBOy8/FHDQ7O8eBfUPjpm4IRDTvVz7U6ec0pFiI94
	 FK+vaTUKdJCKQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
Date: Wed, 29 Oct 2025 12:36:15 +0100
Message-ID: <20251029113615.697924-1-ojeda@kernel.org>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
References: <20251027183453.919157109@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 Oct 2025 19:35:26 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

