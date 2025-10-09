Return-Path: <linux-kernel+bounces-847553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72EBCB2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFAD34E1826
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7542877D0;
	Thu,  9 Oct 2025 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bcFYRCoN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41401287275
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760051708; cv=none; b=RnXE+a8YdR+k1ZOTplPxhlN3HSFnTnxelKE04t/dk0SatmSHzZW9fO8w8LsQbFlvpJli79sFgkIMQ7wkQT45J2SE7n69dSq3KW2cUnv0OGdS1b7K/hImCixxewrjC21Ekr7suuYhsDE6wCb/JSahc41kYhSbglwMpJx99N04lC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760051708; c=relaxed/simple;
	bh=O4GkWeDA6jXJJ/4qe6YAV2wmxQDFzbIxhW+YSRThhDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgM03I2eONdW+Jd9k8j+56hZ+oZVjJUSh+8BmCbKmuO5dEafQyhPakx2af672dIR6HWCBGcqG6UNLnNYcnbhHeodHUqVESBqlltto5BHF7U5jApE91v1g9LPP3ehGa9pm8kJxJMkyEth5NIbqSjgCgc7/J+31s28C5fxC2nhKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bcFYRCoN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6DCE740E01F9;
	Thu,  9 Oct 2025 23:15:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9IWYHPdwfSM0; Thu,  9 Oct 2025 23:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760051696; bh=K7jNNWNpgVKkaBMdIcfJinMtR+AxTBG72pekvlYU1kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcFYRCoNwX+mRjYWDFkSjLNU1hRbJ55UXOR/MvPqNrvkfYWxF4G1WF8tbd8/mPzOK
	 4q9JyembOmAPqEzMdw4LPoyVCOXOKUtrwnR+yj3ETVJq0d80t0YbjuS24SYitrRhNH
	 g7heSBAaZpaGP15zhS75d9NGT1qKW+hfwW/dQiX3Z0x+P0n/FSEuEni2CsY6FjM5OS
	 62WJ3yd/e9V34m0S9gI/68oknEv0BPJKL5MWJtCXgdFhUOuKPFc6qa8P1ijHAZYZ/P
	 jMcUhw4s/4nie5mSIkFfXKw3JTXfYj0awsImIDVOmJrhIKNyMKppnrfk/CGviAgaea
	 BQvT5RBfVCUu8G+Sc5spdUuIOWTKgGErfNQhDAkzn5vBhFoq+9AnbUKqWo7BfsMIZt
	 xtDY2K04ckpAbOIgg1BCeR1ZvewnL2+iBm9H3KQLUSdHk9rmEiXZRHVtjPU8R5jWPY
	 S5yMrvEltZVgwa7Tek2PdBJ9FkhoQ+jIA84eh6OHeZ27QLlwuj85uwcocO8HJLuW1i
	 dg1ftPkEG9tFDgg5udmX6lIg7qcs4Yerusr198+TVoRD7iSQ/RkGqNDljMfDKRGQYA
	 9acF/qqQ+vWWTuWED5ih5X/FsNAyrTC9xBHa4lqB0bd2asRaEH+MSRWfQiFqPGeDA/
	 oSC6hja01OxE66tcCxmlO6ec=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id BA39140E00DE;
	Thu,  9 Oct 2025 23:14:44 +0000 (UTC)
Date: Fri, 10 Oct 2025 01:14:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <20251009231437.GCaOhB3aeJlTCu_OkQ@fat_crate.local>
References: <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>
 <pnobm2r4icma6xzxvzklxoyoy3a4yhhxuxdoq2srmz6rpnegms@qneijnfu6fmz>
 <20251009101557.GAaOeLXYDjOnyFTWdg@fat_crate.local>
 <20251009171331.vplg2zcfystojcxo@desk>
 <LV3PR12MB9265301AEA5D0EDB672DC7A594EEA@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265301AEA5D0EDB672DC7A594EEA@LV3PR12MB9265.namprd12.prod.outlook.com>

On Thu, Oct 09, 2025 at 06:13:20PM +0000, Kaplan, David wrote:
> If we really want to optimize a CONFIG_CPU_MITIGATIONS=n kernel, why not
> also look at alternatives that will never be enabled?
> 
> All the extra NOPs I think can affect performance in various ways and if
> there was a way at compile time to know that the alternative would never be
> enabled (because the feature is completely dependent on a cpu mitigation)
> you could eliminate the NOPs...

I don't see why not. That mitigations gunk should be just like any other
CONFIG_-controllable item and not simply "leak" into the build because, oh
well, we've done it this way from the very beginning and no one should touch
it.

So yeah, eventually we should try this. I've been experimenting with
untangling bugs.c today, will check how much it actually saves us when
I finish beating the stinking pile into submission.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

