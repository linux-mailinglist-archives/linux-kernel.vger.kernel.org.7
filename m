Return-Path: <linux-kernel+bounces-848777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806E5BCE8D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972FF54597F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACABC302775;
	Fri, 10 Oct 2025 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLlW/7jz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C3279917
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129274; cv=none; b=etg2JtsdNOBaxG2Lb82dDkBbKzZzUCvF37hMfzw4yg5YO2jgmTpVwUqtkvmcQh4H9SH9R8fxY4DDf2Z746HOlRyfeo1n6M3PdWjTROt9t2gM8JUhnSlQBXTkP/FcJGEBHpxBBJp//SVr0eQvOc8g+dKjxdn5UpwNVEe4Cu1C3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129274; c=relaxed/simple;
	bh=aZZwnBIcH9CMFofcrl8LA35WVTPs3TZCbJw87kdDbHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaDtwhW1w6WTdCNMoDloorKReOBM9FMvPHR6sE7cSoRdrxIF3wSQ8p4AdlsfddczEVz0Ue3xknuSfGzDmelrl2LJsDViDbxLWjjPacS2OLNh1N4fS/PpK8KUAmMM8DZajac0Vvs86g0og7+AEKRL09zJg6t8oCT3xAdeZyy9n9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLlW/7jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848FEC4CEF1;
	Fri, 10 Oct 2025 20:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760129273;
	bh=aZZwnBIcH9CMFofcrl8LA35WVTPs3TZCbJw87kdDbHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLlW/7jz3zpFgcfvLVgEA6YZ5x0I2gHBgNHYduhppe63+3fsnxYtM8vwztuN7HLtn
	 LJK+b/ysqvd5MmaKiP6jjI+qeGG8iO04goreUlV+NML201bRBBz75tbl+wI/IBvbI9
	 BD4Q4rJngGdQE3imJpvPk9xDj+wy+ZO+X5pVYp/S5Pp80BKdb7c5s7EE3dbYA9a2WZ
	 ZKU+SHCItS58QCC+nw2BdRhSBgh634iCT9dD38GMdD6gMC+TEkaQfkOAEXUoCMWF37
	 TEZLWOX9UuyafKkfLaxL3KhWyJ+c2sI6VJv86i288PUCQf8g11FbKsVrdR5LShTgD2
	 q2lKMYZ7NekIw==
Date: Fri, 10 Oct 2025 13:47:50 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Klaus Kusche <klaus.kusche@computerix.info>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <4bjplxwz3ixsrdh3tvaz4danwrku26fbt5mr6yqhmzv5i34v5r@kyggtyietezp>
References: <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251009053336.ghcmhgsprtkgydas@desk>
 <xhxfkzrrn62xkd6moiapfueookui5f63x4lmzgkmnf3mbxilb5@kk4rylukegii>
 <jlwwd3ohjr7a6lnd4ehu4lp7ys7tm7f6rlaxyc75725thvil4k@pf3bm243ncys>
 <zrbzofjxeuioxhbruhaoacbyfbpclkbntiblg6jjirr4v2c2uu@aeyo5bdb44et>
 <LV3PR12MB9265E186460C170527D1D6B594EFA@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265E186460C170527D1D6B594EFA@LV3PR12MB9265.namprd12.prod.outlook.com>

On Fri, Oct 10, 2025 at 07:27:22PM +0000, Kaplan, David wrote:
> > On Fri, Oct 10, 2025 at 11:47:25AM -0700, Pawan Gupta wrote:
> > > > Instead, CONFIG_MITIGATION_SPECTRE_V2 could enable a submenu which
> > then
> > > > allows the user to enable retpoline, IBRS on entry, etc, with each
> > > > having help text describing what generations of CPUs it would be the
> > > > default for, to help guide the user to choose sane defaults depending on
> > > > their CPU:
> > > >
> > > >   * CONFIG_MITIGATION_SPECTRE_V2
> > > >     * CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE
> > > >       select CONFIG_BUILD_INDIRECT_THUNKS
> > > >     * CONFIG_MITIGATION_SPECTRE_V2_IBRS
> > > >       select CONFIG_BUILD_IBRS_ENTRY
> > >
> > > That would be good if a kernel is built for certain specific CPU(s). This
> > > may not be ideal for distro kernels.
> >
> > Why not?  A distro can just enable everything:
> >
> >   CONFIG_MITIGATION_SPECTRE_V2=y
> >   CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE=y
> >   CONFIG_MITIGATION_SPECTRE_V2_IBRS=y
> >
> > and then if/when some older HW ages out of being supported by the
> > distro, they can start disabling things.
> >
> 
> Is this really improving things?
> 
> There's already a lot of CONFIG options related to mitigations that
> make testing a pain, and this seems to just make it worse by now
> having even more options that may or may not make sense together.
> 
> I get the value in building a kernel with all mitigations disabled,
> although frankly I think that only makes sense if it's substantially
> better than just 'mitigations=off'.  But is the cost of only building
> support for IBRS and not retpoline really buying much?

I think this would add several improvements.

It makes it clearer *why* retpolines are enabled: to mitigate Spectre v2
for older hardware.  (Though, frustratingly, retpolines have made a
comeback thanks to ITS.)

If I know I won't be running my kernel on old HW, this would make it
easy to phase out old mitigations that are no longer needed, that
otherwise uglify the code and might affect performance even when they're
disabled at runtime.

That would be useful for me personally (I don't want that crap in my
kernel if I don't need it), but also for distros which phase out support
for older CPUs.

Yes, it does add some config options, but we can counterbalance that by
removing all the ones which set the defaults, and instead only allow
changing defaults at the granularity of attack vectors.

And these MITIGATION config options wouldn't need to be referenced by
actual code.  Their purpose would be to select
CONFIG_BUILD_INDIRECT_THUNKS and friends, as needed, which are in a
separate namespace (naming bikeshedding welcome).  So overall I think
there would be a lot less confusion about the purpose of each config
option.

(Yes, CONFIG_MITIGATION_* could also be used to compile out individual
mitigations, but I'm not quite convinced that would be worth all the
ifdeffery)

That's kind of a lot, I can work up some patches to clarify what it all
would look like.

-- 
Josh

