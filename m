Return-Path: <linux-kernel+bounces-846106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5C5BC70CA
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 083454EBC0A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252B513AD1C;
	Thu,  9 Oct 2025 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvK1pySi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816EC1397
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972027; cv=none; b=bhf606ft0lMoDbTlLQrEpbuhbMhxkg7Att+BuFb1vMLwC+Vjf6bGlrBbdS9yUD4WqcXVoEy8mo7yAKzS2EJMJ8NEwgef7sCrU1aaJb0uA6e8hVbT8J5Q8XUlXVvaDeaK1mToeSj31v4g/9mcHedlU9kqBaz/8ktFMDe1LItUsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972027; c=relaxed/simple;
	bh=rblMiMlU1EbB0grEHe60IMt/4g2p9GtMObuC1hl622E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHMgZEzYHAM62molyJWYVlEVO4CBKlrgXVliiWXfDG+F+4wxruuoS1Y+o5vjeevkkZy4EV9CqvgbLyfIDenyGol1Zg702PwyhG6xlSGiAE2BltRVWd7U737q1F5ussZiWCOWPLS5hmxYME88PJsQ/LLo8AerEam9DHXjhHodegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvK1pySi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6A8C4CEE7;
	Thu,  9 Oct 2025 01:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759972024;
	bh=rblMiMlU1EbB0grEHe60IMt/4g2p9GtMObuC1hl622E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvK1pySi9wMuAIMvzZtPxUCPEU/fai7TxHj/BCT5JcX4gnHFskGc/eXEEfG2NDJRz
	 7VmT3tF4dpho6h/oS8ecK42iBbzzGL5rYvEqL5sHrkWWhgzv+h3Q+4D/MiI61nrFDH
	 zD6Z6/tOEugRvQ2k7sTy/QfPO2AVz/ZVBIrYrrjSsrAoavqPD0ZzjyOgzTvav3vIeJ
	 FKC20BngwwZ6ugZE3T0S/EwPhZKfA19pb8GAwdYV6/G8fOwnXeXVNwBhk+yOlLMjaS
	 5mQpAk/1zbCsHmmOxc9OsUqcO0n4ddi4CfFkBd6e+fxCIUnR6qRc+CxBtBfyNXn8+6
	 JtJt2XBdVdA1g==
Date: Wed, 8 Oct 2025 18:07:02 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Kaplan, David" <David.Kaplan@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Klaus Kusche <klaus.kusche@computerix.info>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <mnokj2q3ytnar4x2zhcazfaqrnxz353dsdczjgr7hxirlsf6pm@bn4ed3eou44p>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>

On Wed, Oct 08, 2025 at 12:21:36PM +0200, Borislav Petkov wrote:
> On Tue, Oct 07, 2025 at 05:14:29PM -0700, Josh Poimboeuf wrote:
> > Isn't that what CONFIG_CPU_MITIGATIONS=n already does today?
> 
> I'd like =n to mean, code is not compiled in.
> 
> We do have some savings:
> 
>    text	   data	    bss	    dec	    hex	filename
> 136442490	9737118		36764336	182943944	ae780c8	vmlinux 	# CONFIG_CPU_MITIGATIONS is not set
> 138493310	10692818	37741668	186927796	b244ab4	vmlinux		# CONFIG_CPU_MITIGATIONS=y
> 
> but look at bugs.o:
> 
> # CONFIG_CPU_MITIGATIONS is not set	599K arch/x86/kernel/cpu/bugs.o
> # CONFIG_CPU_MITIGATIONS=y		625K arch/x86/kernel/cpu/bugs.o

The good news is that CONFIG_CPU_MITIGATIONS=n already seems to remove
all the "ugly", but yeah, stripping out bugs.o would be a nice bonus.

> > Then one only needs to grep their .config file for UGLY to understand
> > why their disassembly is so inscrutable ;-)
> 
> Not sure about UGLY but if you can come up with a name that says "has impact
> on the resulting code and when you have them enabled, you have weird asm
> constructs all over the place", sure, why not.

I think almost anything which removes the "MITIGATION" from the name
would be an improvement.  The build enablements really are a different
kind of thing compared to the runtime defaults and it's confusing to
intermingle them together.

The "UGLY" was tongue in cheek, but it does have a nice ring to it.

Maybe CONFIG_BUILD_INDIRECT_THUNKS or so.

-- 
Josh

