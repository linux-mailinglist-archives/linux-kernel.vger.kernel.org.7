Return-Path: <linux-kernel+bounces-769865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55C9B2749B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8B33B91A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A913218C008;
	Fri, 15 Aug 2025 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lylBoupg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E25342A96;
	Fri, 15 Aug 2025 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220168; cv=none; b=VxOsGn2Z80KSQ24sPVjjbt0EdiQbltspwLhScK5VzYpqGsHSgRcunjw5gsAOKMZBDsORaeXdoDFLfpqv1QyyAIq6U1qR/HzEoYYH9Vn1UE7Q2F1nOqbBiFXyqyWtamFlUkcxNeI1MOHovnSUPkWNfeLqKiDWCyiKh2JyvEFjYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220168; c=relaxed/simple;
	bh=ORVkFLtFAa+LSmtgfWihr0EYr+tO8C6KqaakTOQGN9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh7WohRaUkocvSUzdB3Vj+LETw6qzzgXwo+CFVzPLQxdSIeb4I69GFCudwdVG7ke/MVUdS6HEsMPgnJ73eKUh1QuMSvWulC5jQEDs4S/twUvvgbM22jAYw+B8ieFJ2zFED+J4dEMuLpqt5KR1j+waWIch0enydvzKufx/GjhAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lylBoupg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708D0C4CEED;
	Fri, 15 Aug 2025 01:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755220167;
	bh=ORVkFLtFAa+LSmtgfWihr0EYr+tO8C6KqaakTOQGN9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lylBoupgx8rXGcaalBZ2ieQkawlDq2dWC45srK02hnXDrm2dnKF5NeUEon13y794z
	 Za/CKBuelevdnaMXtz8U0wm/3X2CTCCH/dQkwReIGEfpuGQjd4r3sqfwmEW39zbLtS
	 WB0M/2btd6vdj3inLcdO9W/AjAfFj/NlPVZBum3yqLA3E30mteyunp/GrdF9w8wJNA
	 IoOhv2hfiBO0E5B9MmSGpGtO0Whn15UkypknO2ecRNPouKGyThXjugVR0QaRw4WXTR
	 t9G+vFKpeUrS3bKLEoJm1I6TTHKyYyRGQnAJgvzmUZ2O+q1ZR6koQI9xpTmaal8HNI
	 P/brl9BbmUdEQ==
Date: Thu, 14 Aug 2025 18:08:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/crypto: ensure generated *.S files are removed on
 make clean
Message-ID: <20250815010823.GA1302@sol>
References: <20250814-crypto_clean-v2-1-659a2dc86302@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-crypto_clean-v2-1-659a2dc86302@columbia.edu>

On Thu, Aug 14, 2025 at 02:51:57AM -0400, Tal Zussman wrote:
> make clean does not check the kernel config when removing files. As
> such, additions to clean-files under CONFIG_ARM or CONFIG_ARM64 are not
> evaluated. For example, when building on arm64, this means that
> lib/crypto/arm64/sha{256,512}-core.S are left over after make clean.
> 
> Set clean-files unconditionally to ensure that make clean removes these
> files.
> 
> Fixes: e96cb9507f2d ("lib/crypto: sha256: Consolidate into single module")
> Fixes: 24c91b62ac50 ("lib/crypto: arm/sha512: Migrate optimized SHA-512 code to library")
> Fixes: 60e3f1e9b7a5 ("lib/crypto: arm64/sha512: Migrate optimized SHA-512 code to library")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

Thanks!

- Eric

