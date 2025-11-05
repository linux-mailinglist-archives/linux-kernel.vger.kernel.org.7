Return-Path: <linux-kernel+bounces-887296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FA3C37C94
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C620E4E7DA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C92D660D;
	Wed,  5 Nov 2025 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUtQDV4t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5D2D3EE3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375927; cv=none; b=qPM2dzD8yD2mjCOqbQE7TAvZdHw3/Oz1iGCAusqtoq0POJRoYEusum/lPM3TmckpRuRmLduKZUrcHq6kYZHyqe0RCpA/Jo8sXrOP0+G9HII73ae4QndmQR2PFVXzIqOZT6wmQUctHuyqXJrvETD3Iz5E7ZJKASWTZ3mCEIpr3m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375927; c=relaxed/simple;
	bh=kSxAJZu2eB9oaEqsCqrYHE/x7SzvfJZjLn5/rPBuQIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrGuyei1IHq0Ewr7Ys2U0ebH+0VX+jefHJ6/ys7Si5K2wq1Cl20JPSGREAVOS2mvujJCC/LkKzC4bGy0PVXccUhUES0GWsXF0d47XXclT8sg1Wm1IaNEFfVrIdKnZvzss3bWHag7BSTfwYZo9897jpkDJTcNzTGlTrXItNKnEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUtQDV4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB95C116B1;
	Wed,  5 Nov 2025 20:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762375927;
	bh=kSxAJZu2eB9oaEqsCqrYHE/x7SzvfJZjLn5/rPBuQIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUtQDV4t9EBA4mSy9R+9exGEDhFqRXyfIzDdchOvOYjhD7uopRQKPXhrws80ap3cO
	 Vtt1inZ9s5ERAh64LGAT4DtMrZj5fSbpxmoFtYKyi8050f29I/5dE/OKI94+hEDC9o
	 jiGlT0d7UR1V4cXTIHJTGSJ8hLvO9I9+wytUQmZMn1Jd3par5DKqvmSBQ2Cm+Gszv5
	 hSjKbzF7ODm4k07D1SUPMao2jvuIwvRNumFse430bpgzMVsHB2yDq0dd4V7zfI6o9a
	 0R6IBS8D/LyVr5sK52NwGIR++JN/QEnvvGEJznaM9YYksvqMKs5J0qDphXTdpTotUE
	 9TXPo3jGzOVxg==
Date: Wed, 5 Nov 2025 12:52:04 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Alexander Graf <graf@amazon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 05/56] x86/bugs: Reset spectre_v2 mitigations
Message-ID: <4artgo3z5dysdfiplsfq2q5jbml4m44rmzghc6ghgva346tlsj@g77fwgoc5vd7>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-6-david.kaplan@amd.com>
 <20251103193130.GQaQkDEquEnEwb_cwC@fat_crate.local>
 <LV3PR12MB92655CEB1AF94875901E700C94C7A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251103202811.GMaQkQW54Gml6i1jQy@fat_crate.local>
 <j2mds5vdblnhpha6oyejqcj2fgmveylgaudzzljvfwwl3fgvnw@xgmsl4f7jzv4>
 <20251105110318.GAaQsu9vGkzSxGbzzx@fat_crate.local>
 <b7xcrqkx4ouye4ayqkkvmpoirpqydhf663uim63w7nt3xwbgyc@kytyca6dgztu>
 <20251105200447.GBaQut3w4dLilZrX-z@fat_crate.local>
 <LV3PR12MB9265DDB4E587963617DD8BA594C5A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265DDB4E587963617DD8BA594C5A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Nov 05, 2025 at 08:21:08PM +0000, Kaplan, David wrote:
> > > If "functions bad" then why not make cpu_select_mitigations() one big
> > > happy function with a ton of comments?  Just think of all the function
> > > savings ;-)
> >
> > If it makes it more readable, always. But I see your point.
> >
> 
> Josh's thinking was aligned with my original thinking.  And if the
> #ifdefs are the only problem, I think I can just make them
> __maybe_unused instead.
> 
> That said, using a single function also allows for some de-duplication
> of code.  There are several mitigations that all use the same feature
> flags or other things (like x86_return_thunk) and those only need to
> be reset once.  Having them all in a single function makes that easier
> to optimize if desired.  Here's the single function version if you
> want to check that out and see if this is better or not:

I'm thinking it's probably best to keep things separate and contained
rather than intermixing / deduplicating, otherwise we might have to
disentangle them again later on.

Someday in the distant future we might want to start phasing out some of
the mitigations due to abandoned HW.

Or we might end up deciding to have a more modular per-mitigation build.

A little bit of duplicate effort is no big deal.  Running in
stop_machine_nmi(), it's not exactly performance-sensitive code :-)

-- 
Josh

