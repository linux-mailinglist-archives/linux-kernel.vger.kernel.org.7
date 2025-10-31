Return-Path: <linux-kernel+bounces-880342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB0C25902
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E904657FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA32727FA;
	Fri, 31 Oct 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK4TwL24"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF322D7B0;
	Fri, 31 Oct 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920450; cv=none; b=dH8F2rdLVwk/6ESWyN1JKBgqjT/8nL9nRU0OzndkzhB5BEafO06HtM7ORHB+/abf10NfdXrtZa9M8bhpzaVUSSbx/LF9aFYCEqq4t4gaSft8XT7T0imTHmQeSLq1NNlEdD4l3tRNJYIRoxa+Ps1vk6b5NR0Kx1A/eCxc+asteaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920450; c=relaxed/simple;
	bh=wh6zd9fvU8ipn4MulVvw1GrofK8id7WNq3FH3NCoR7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vsk1nfPZj2g3Ih2Hce76DUz+8/moEiTLHcGKLM44G5x6R+ymifVs9lpUdN7S5o2a2Byxn1F+06sB3AMZhPIVFNarrU0SmM4mpor/ohm0aqRIOxeBSRFRgZ5Ld53RzJGUJyWqkq+ysHtS4eH4D8mE9hVuisHx/UibUwJIgRwrjuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK4TwL24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC740C4CEE7;
	Fri, 31 Oct 2025 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761920449;
	bh=wh6zd9fvU8ipn4MulVvw1GrofK8id7WNq3FH3NCoR7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fK4TwL2459essJSdTIjxuPbYw4OjS84JVq2wrngo7NM8pXyHhEOtF6BGVBMHtJcyN
	 yTU7Oajhmm4mOg8AELd7H6shDknnjSYZJ3ZIjn8u+LFq8I2cPg6cf2HNlPv7lmE0Ax
	 0ad8XIKndAPRXrqu8PxUZNx8FUb0142kTVwTHPEpsP+L4hvIXntGraT5LEKBt/yjPE
	 Auy628X4Qh39jJblssbXTPKrtc8SYTTaUWh1XWsAJuQ1if8J6yEf5YtSj8IGB5NWI+
	 cpzbLXzmFn+Y07BPPynyo0hj0kLYVcqFV5LR/hIDA/QpI45ClO6e+4Pnk8ih1LYvE1
	 7Sujizc5Ueazw==
Date: Fri, 31 Oct 2025 10:20:44 -0400
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
Message-ID: <20251031142044.GB3022331@ax162>
References: <20251013-x86-fix-clear_page-cfi-full-lto-errors-v1-1-d69534c0be61@kernel.org>
 <20251030192819.GFaQO8U29xvWcPT_s2@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030192819.GFaQO8U29xvWcPT_s2@fat_crate.local>

Hey Boris,

On Thu, Oct 30, 2025 at 08:28:19PM +0100, Borislav Petkov wrote:
> On Mon, Oct 13, 2025 at 02:27:36PM -0700, Nathan Chancellor wrote:
> > When building with CONFIG_CFI=y and CONFIG_LTO_CLANG_FULL=y, there is a
> > series of errors from the various versions of clear_page() not having
> > __kcfi_typeid_ symbols.
> 
> might wanna wait with this one - those are going away except one:
> 
> https://lore.kernel.org/r/20251027202109.678022-5-ankur.a.arora@oracle.com

These errors occur in Linus's tree so could this go before that one then
it could just update the instances of KCFI_ADDRESSABLE? I don't have a
strong opinion, I found these series of errors tangentially but this
feels like something that could go via x86/urgent and that series could
just rebase on it.

Cheers,
Nathan

