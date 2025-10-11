Return-Path: <linux-kernel+bounces-849231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CEABCFA5B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 19:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC2B404E72
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3033B27FB30;
	Sat, 11 Oct 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzeIkQXt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D21DF75C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760204619; cv=none; b=s6AZfLT4OxKXMuYFYEtuPm+7YTsuTzIW5If/Yc6aiBTfwvRKGHfqyK2wesudG/iWRKRsulziVU8jDg5yVhMVWtGtNJlofxAAxdS7KDzjPhOnWw8r84j0kkIlvxPnslrdOxosfHuDzSGbdxVq7LYKfV3ZYJ9esyxn1lqKb6f8ta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760204619; c=relaxed/simple;
	bh=nB3sLVCXrOCw04TzEfTsxkqbCHpOtObgLy1e3/sGvtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKy0dUDbfqmRmpw229V5A+ASYWTOJHjb+zVD/e5rHH9c+5bbhYZmVZT3Z5t5gYrCukHJY89DOkqT8KnIAmD0SLq8qeqq+Kri1biSklmryAwhrTigUK9D+WysuThUZp2XcoEMbrt6v3nfrWCmsFwNjVsv7QiYE2WJAuYZYc82530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzeIkQXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC69FC4CEF4;
	Sat, 11 Oct 2025 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760204618;
	bh=nB3sLVCXrOCw04TzEfTsxkqbCHpOtObgLy1e3/sGvtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QzeIkQXtaLbcs/3uQt1oAfSgV1mT0ayBrp125kOoEVZM3Lh3X/XVBNvs9BfhHA9Ho
	 htYR8GGTI/RgfMpKvaQfYBZRUH7T4zOVcmh3nVO4xfJqtW6lvj8O4nuIO7NGHn+NDU
	 Oohd+zDYtjfaejZA1MsGwqWvVMGlSbbezCRbo4WWfQBZX2LzxzSFSCMo0X9BbcvkN1
	 8jXcr+v9RJadGJGUJgc4mxErOtgMCtsqNxi2joN/Mmg65GX5WLY2Hv2ONgA7k0WFW9
	 DPfHZIhqZz1bkVXzgrulF4YrvwQLZz02hpIDSY8kduUl2KgTufouX2V42mNf6++7sh
	 a6nWi89aeCfKA==
Date: Sat, 11 Oct 2025 10:43:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [GIT PULL] x86/core for v6.18-rc1
Message-ID: <20251011174334.GA2929946@ax162>
References: <20251011134629.GAaOpftWmLdD6L7bJn@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011134629.GAaOpftWmLdD6L7bJn@fat_crate.local>

On Sat, Oct 11, 2025 at 03:46:29PM +0200, Borislav Petkov wrote:
> please pull one more belated x86/core lineup for v6.18-rc1.
> 
> The pile conflicts with your tree but not too badly. I've added a merge
> conflict resolution I've done locally, at the end of this mail to compare
> notes.
...
> Kees Cook (6):
>       compiler_types.h: Move __nocfi out of compiler-specific header

Please do not forget about this semantic conflict during the merge.

https://lore.kernel.org/20251003221030.GA1162775@ax162/

Cheers,
Nathan

