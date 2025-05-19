Return-Path: <linux-kernel+bounces-654197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3248ABC52A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 19:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41521B62627
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2A288537;
	Mon, 19 May 2025 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXDJch8+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A642278E42;
	Mon, 19 May 2025 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674279; cv=none; b=gxLL2QUGbxjUh2dxqVl+dmp5nao7jw5l2PiMeoPWedsV5H39P+vyiPQA/WggXbPeNxqnP3b/OJyiDK0VxmE1i/5IAkevq4AR7r7Oo1x8J7dYcmNaLZ5oluF6HYenS4u2VHlhPtl1byjRrHfJ1C2cXYnG0raMQtmVAH/w+YPHaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674279; c=relaxed/simple;
	bh=HWkGmX9ohMbCMO6qUrUKVHhYa4EPfAeTkJYjRuW53NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUBlIomKHSwAqK+Lpfu3S48pK7oGdBNrl8c9y+u04ztolP3992reI5U8FkRtTdPq87ILAqs3xAu1LaIl/OVd8iR7MzeecxXw2PwLKzB1CA0lwEGdRiYc1EKK6bWl+nJAfsM0NfDy0HOBVf7H68+cQ1zG2QNHKDStnLdi8jF8Zxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXDJch8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848ACC4CEE4;
	Mon, 19 May 2025 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747674278;
	bh=HWkGmX9ohMbCMO6qUrUKVHhYa4EPfAeTkJYjRuW53NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXDJch8+prcSr6CgtqqoWE5FzlVsN2RLtoFCuZV0b8ciHhYNY1lo59UjeKJRUAU98
	 BGlvo/zbPCt9dG1VtlRI06AtJLlM+yHyOi5UexPAUZsXDWHU0jcByDFhMkBAh/tukh
	 uR9vlBR2VUiR93eJZNCGvSOCdgJPvcqB1gjke1igQ93yTDb01r9318F1HQnv6tT8rN
	 WaUO4OMMMshndtKGyKv+o3+rQiE8IHtqbfslTCCp3gitKxQIhTaa/fONagcuGkqR82
	 Doy+RU/Xl8A5v0CVwvueE6IRl02umJHdNxl40f8RuutuP6Poif8h/8tP3P7P9UEnLf
	 mIfy0RmrWE3Bw==
Date: Mon, 19 May 2025 10:04:25 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] x86/fpu: Fix irq_fpu_usable() to return false during CPU
 onlining
Message-ID: <20250519170425.GA1243@sol>
References: <20250518193212.1822-1-ebiggers@kernel.org>
 <aCrrMEN01O7FWY6V@gmail.com>
 <aCrsiPd3u1-tEVd0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCrsiPd3u1-tEVd0@gmail.com>

On Mon, May 19, 2025 at 10:32:08AM +0200, Ingo Molnar wrote:
> 
> > void fpu__init_cpu(void)
> > {
> >        fpu__init_cpu_generic();
> >        fpu__init_cpu_xstate();
> > +
> > +       /* Start allowing kernel-mode FPU: */
> > +       this_cpu_write(kernel_fpu_allowed, true);
> > }
> 
> BTW., this is the chunk that fixes the crypto crash, right? If yes, 
> then could you please split this from the main patch, with the main 
> patch setting kernel_fpu_allowed very early, which should make the main 
> patch an identity transformation with no (expected) change in behavior.
> 
> Likewise, the cpu_disable_common change should similarly replicate the 
> current code, and should only be changed in the second patch.
> 
> Phasing it in like that should improve bisectability, for the off 
> chance of some regression.

The line in fpu__init_cpu() is needed at the same time that the boolean is
inverted (when in_kernel_fpu is replaced with kernel_fpu_allowed), since
otherwise it never gets set to true and kernel-mode FPU is never allowed.

We could include the fpu__init_cpu() change in patch 1 and leave CPU hotplug
broken, and fix it in patch 2 by updating cpu_disable_common().  I think it
makes a lot more sense to keep them together though.

Or we could use DEFINE_PER_CPU() = true in patch 1, then revert that in patch 2
and replace it with the line in fpu__init_cpu().  But again I think the split
would be more likely to create problems than solve them.

- Eric

