Return-Path: <linux-kernel+bounces-649426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90832AB84AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 13:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4C41B63222
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C947296D27;
	Thu, 15 May 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvmQN4Qt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12EC2C9
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308121; cv=none; b=KkMoQkz3xgcvS3dj6NYel5b8uionX2mHVVDRl689H4grLyeV+fC0gE1j0G8rYlAxJn2ySsVXF4T67i5OcZg3T2uQIZRXKMzyXVl3FxEmcAIAKSoifAbqXNQSnDZDp7QjI5f6+gc3lI3X6biejXer5Go1w8ijZDgb2hT3m38Eql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308121; c=relaxed/simple;
	bh=ZMdjJ6TrgX+duYqwnFiUS7mJ99alQEOls7x835K3L9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4dc2o3w/28HK42C0GCqLzDIT3pgWtPrry/HKPA5PhiSxmeIj2WfUOltUiX+1Y4W/fUkYO7yo7V4rYSR1y0lDcsI9BkTGDTJVtM41e2+04jb91K97AflYEofeFD++7/JPcnOWA0B4SFOPwZd1AV/big3NTOlrmK/H7XqzmydAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvmQN4Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ED5C4CEE7;
	Thu, 15 May 2025 11:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747308121;
	bh=ZMdjJ6TrgX+duYqwnFiUS7mJ99alQEOls7x835K3L9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvmQN4Qt6/x5PBs9gXAi5WXNJQu6vHUADJ3YTdzWj9H9V0LZyZYHkJqsHlqitd3uf
	 ihj+JAbdzu5YYVfsS/wtnwLrYivaz0E2y2H8BYTla7i0fdFK5iTmVL3+QzluTnZCTU
	 kVGgvJEBHuoKUhkkmQ4enBLWX2BgwCSj+uxOswBTs6tGL7Xwl45NBFuzFSgV57adSE
	 0ml5D99eFVA8GEYd9PKWzPc5WwGT5zpLpdPeHr3rk6Ns8his/241VCu8fj2EbM+aXS
	 XtXDzNe1fBs7lHsAVSYsiXvKOA0S/JDOoBVs5Kh295cv9+C7Qnoe270d0kipSANZhO
	 vY/6vfHyGMzDg==
Date: Thu, 15 May 2025 13:21:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH 14/29] x86/boot/e820: Clean up __e820__range_add() a bit
Message-ID: <aCXOUx-a809LVxgE@gmail.com>
References: <20250421185210.3372306-1-mingo@kernel.org>
 <20250421185210.3372306-15-mingo@kernel.org>
 <aAdrJGBTiC75KPn-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAdrJGBTiC75KPn-@smile.fi.intel.com>


* Andy Shevchenko <andy@kernel.org> wrote:

> On Mon, Apr 21, 2025 at 08:51:54PM +0200, Ingo Molnar wrote:
> >  - Use 'idx' index variable instead of a weird 'x'
> >  - Make the error message E820-specific
> >  - Group the code a bit better
> 
> ...
> 
> > -	if (x >= ARRAY_SIZE(table->entries)) {
> > -		pr_err("too many entries; ignoring [mem %#010llx-%#010llx]\n",
> > -		       start, start + size - 1);
> > +	if (idx >= ARRAY_SIZE(table->entries)) {
> > +		pr_err("too many E820 table entries; ignoring [mem %#010llx-%#010llx]\n",
> > +		       start, start + size-1);
> 
> size - 1 ?

Not in this case, see:

	https://lore.kernel.org/r/aCW-qKOYJWRLYgpx@gmail.com

Thanks,

	Ingo


