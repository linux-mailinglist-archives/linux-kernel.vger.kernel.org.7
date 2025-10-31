Return-Path: <linux-kernel+bounces-880928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F48C26E32
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC17A3B91A2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4C8328620;
	Fri, 31 Oct 2025 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZdEJ9tJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5230B50D;
	Fri, 31 Oct 2025 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942152; cv=none; b=p3sjLfkmYrNLi+gnnIdaINnFxxiVpGAAf4POu0+LJcAc/FaZg2tINxdeOc/wkajxEwAc/ktzpzvWv9Dm8LiqX2LhzRZeB6/0cXQ95crrgi84MX9MGNIzv+X6ibn+SHEZ3wUX9TmoI0XAFhXchdLf8iZlU7Lb9pyltZ1L6xZukjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942152; c=relaxed/simple;
	bh=y1D8hn9Sl4ZYB7RrFaRiMdoHrKffc/670nzt3jGiV/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmMZLoNYtELkNid9tCWaRTPVpHpoZvstXMV1dMeCI9BnRQy6A+NXUk3YvTNhnHF5cLTyiFP0pKFF5IucLZsFHQ5C19yWEV9+SlkEhMrZtStFLPamtjkFckJJQVIRO6YGQY4kLq9GfvX+5Wfl+jhMH9gn/vuyYCiprg8SB/C7SxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZdEJ9tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9720C4CEE7;
	Fri, 31 Oct 2025 20:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761942151;
	bh=y1D8hn9Sl4ZYB7RrFaRiMdoHrKffc/670nzt3jGiV/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZdEJ9tJ/RZI6iBBX32t5YukhuFRlY6K1hb1ZW9BypwQiZBjMSo8ORRWRCiLbzNIU
	 zZqMb/XyzE19rFbTLbzkv03CkX1MO4zxEtj4Xd1FpsQDG++vh687wRd807J9P1lAQ8
	 LOYvEZ4IcZWaAGYVnVmGRqy4aBs35SaxqIBkVq8Ek7HYeW7w4s7YRZYHLe83hg7akN
	 90VO2WBhaaxyBbRxAcpHC78ykJ1ZXH/ZIbIeLzrA5Egb5NOhD4KP0IWbc4D7Hs1Zuu
	 ONYAPJfoyX8jRTQ1oQ9VlZUl9IoxOvg2dvBwatxkKpRAXA/iSpWxO40lZkNKbs0/5h
	 LHVJWjocHIKtA==
Date: Fri, 31 Oct 2025 16:22:26 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86/mm: Ensure clear_page() variants always have
 __kcfi_typeid_ symbols
Message-ID: <20251031202226.GA2486902@ax162>
References: <20251013-x86-fix-clear_page-cfi-full-lto-errors-v1-1-d69534c0be61@kernel.org>
 <20251030192819.GFaQO8U29xvWcPT_s2@fat_crate.local>
 <20251031142044.GB3022331@ax162>
 <20251031144624.GHaQTLwONX3j6aDkkP@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031144624.GHaQTLwONX3j6aDkkP@fat_crate.local>

On Fri, Oct 31, 2025 at 03:46:24PM +0100, Borislav Petkov wrote:
> On Fri, Oct 31, 2025 at 10:20:44AM -0400, Nathan Chancellor wrote:
> > These errors occur in Linus's tree so could this go before that one then
> > it could just update the instances of KCFI_ADDRESSABLE? I don't have a
> > strong opinion, I found these series of errors tangentially but this
> > feels like something that could go via x86/urgent and that series could
> > just rebase on it.
> 
> Sure, that works too.
> 
> I guess we want that in stable too, considering where the Fixes: tag commit
> landed...?

Yeah, I should have explicitly tagged this change for stable but I have
been a little lazy since AUTOSEL often picks up the slack :) If you want
a resend with that adjusted, let me know.

Cheers,
Nathan

