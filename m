Return-Path: <linux-kernel+bounces-848941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B5BCEDC2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A34EE3E4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9E1249EB;
	Sat, 11 Oct 2025 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T01UExVZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188D70810
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760145655; cv=none; b=ZumGybtkUGihr5isoecZzwuMaKM5owJ7g9t/zYf3WVBxCGeIredBUFYruhjDDMNbOWraY96hlJxgNbIrtwr3I1blp3k6tpuVmZPQehB9xKNcteBmz7gJ1VmrFVUGkhdTjJsSaDWHfD9DrskwGlDxsRhjCFOe89iSVDrSTAMSLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760145655; c=relaxed/simple;
	bh=y9WNkEncxs9vy/jzuB8be6UmUxCBNijCFrAxWLBKTZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTI9wk+Gh6mmZDyG5Zl6Dmh1qnQD5BMi9/VuVTmLpvXK6NFBATGzB32f9WVT02566zUpTvQ9km1f0lr7VdXGYVSaC8hKfB/XWIb8V2aBzQDZECLhXeOxq7O/gyl8LML34MhZdajk86ttdwSdr7K6qHXjAEjCO1XjwUKV3tL6sxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T01UExVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CFBC4CEF1;
	Sat, 11 Oct 2025 01:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760145654;
	bh=y9WNkEncxs9vy/jzuB8be6UmUxCBNijCFrAxWLBKTZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T01UExVZBnxlqudLuczXYZtC2DsHml4FMWEfi/RkYd1QL1jblYgFbZfOhKdC8oGjh
	 DAiLYRfQMEzirExSXrOfIeyR0h388muvS/9n8PWR6r+/EwGJoQkdrv2vlSopZ0J0Ar
	 WpNHOg9e3Nae3UeWSASjZxXeQd7ulXIMb184VhpKy8L1QXhNgz/7OC7r/MhpDS6X7r
	 pBQ6/9p85LoonCkdgVVLbJRREUfHyTIyHSnLBMFDLdnAu21UwpXFd9UXMZ9OHMaQib
	 35MgnihrbM7PpqNcSvIlfIvrZfJWCQJ0RYLaypy9nIsh8/C9jdLsJi/CZjIZltkPyy
	 po2fZknunxxjw==
Date: Fri, 10 Oct 2025 18:20:52 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Klaus Kusche <klaus.kusche@computerix.info>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <ewuawnlm44vqdxjm6iqtw4m5wvbqzcdblxkpwmozwf4ydhzzko@7rdo5ncnzjdb>
References: <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251009053336.ghcmhgsprtkgydas@desk>
 <xhxfkzrrn62xkd6moiapfueookui5f63x4lmzgkmnf3mbxilb5@kk4rylukegii>
 <jlwwd3ohjr7a6lnd4ehu4lp7ys7tm7f6rlaxyc75725thvil4k@pf3bm243ncys>
 <zrbzofjxeuioxhbruhaoacbyfbpclkbntiblg6jjirr4v2c2uu@aeyo5bdb44et>
 <LV3PR12MB9265E186460C170527D1D6B594EFA@LV3PR12MB9265.namprd12.prod.outlook.com>
 <4bjplxwz3ixsrdh3tvaz4danwrku26fbt5mr6yqhmzv5i34v5r@kyggtyietezp>
 <LV3PR12MB92652219EEB4C090230E33D794EFA@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB92652219EEB4C090230E33D794EFA@LV3PR12MB9265.namprd12.prod.outlook.com>

On Fri, Oct 10, 2025 at 09:13:56PM +0000, Kaplan, David wrote:
> > It makes it clearer *why* retpolines are enabled: to mitigate Spectre v2
> > for older hardware.  (Though, frustratingly, retpolines have made a
> > comeback thanks to ITS.)
> 
> I don't think you mean 'enabled' here, you mean why they're being
> built into the kernel?  If retpolines are being enabled at runtime,
> that is reported via sysfs.

Right, I meant compiled in.

> > If I know I won't be running my kernel on old HW, this would make it
> > easy to phase out old mitigations that are no longer needed, that
> > otherwise uglify the code and might affect performance even when they're
> > disabled at runtime.
> 
> To check if I'm understanding right, is the idea that if you have an
> ALTERNATIVE that is based on some feature flag (like
> X86_FEATURE_CLEAR_CPU_BUF) but your kernel is built without any
> support for those mitigations that need that then that macro would
> essentially get deleted at compile time so you don't have the extra
> NOPs?  That seems useful.

If we decide we care enough about removing those NOPs, then yes, that
would be a use case.  We could wrap the CLEAR_CPU_BUFFERS definition
with #ifdef CONFIG_UGLY_CLEAR_CPU_BUFFERS or whatever.

> And if you don't need any retpoline support then you remove retpolines
> from your compile options?

Right.

-- 
Josh

