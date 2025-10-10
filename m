Return-Path: <linux-kernel+bounces-847634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B16BCB516
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5FCA351549
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA95213E89;
	Fri, 10 Oct 2025 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LysD7Y/d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E269DDC5
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760058645; cv=none; b=MQ6rT+nN9Cxd+QocYEmwQCG3CsTlvIdYuTj9QFoVAmAgxvOPB5OD9YsL5c1+OPziKtkLEcWReDjLp6mrPf05VKckYDeP78j5N+R4BSsbI4kja8+nrPmsVEzFkhE+ebwr2GUEIsyZMUIwJNqern0nHb+tZ+pxJWtyy0ZA37IIwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760058645; c=relaxed/simple;
	bh=5U6FCv7NgoRxqbeKp0lPvYqDabYpEssMfFjx3MwgN/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nehxy2I8bizYM3hegOBoqzAvgrLNjPRhkLx2TXSTNe7ERh4wKbVkWAeKGGIGScqolNzTrvS+gn2IjDx2OiqpK7Bwc5Y48pWoOBhkmfEzKJmRJPS4kQYIMVNhki5VDSVB1OjnyYfgxOXDAqfyrUiJ4rHdj4ZKYxK02IyLh1osIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LysD7Y/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D254C4CEE7;
	Fri, 10 Oct 2025 01:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760058645;
	bh=5U6FCv7NgoRxqbeKp0lPvYqDabYpEssMfFjx3MwgN/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LysD7Y/dHexnb+CYtqzBBX0jzAt+di2AvPgfcND/BCTZ5bWMKLDvXicZAd0DH42SA
	 CGWEBIKDZGmvVx3ATSsozv4BespdpOJzhKna/iGoHGjvp35Bjtq6W+fKwhuD8RNNd8
	 GG9aGnutYbSP5IkCQvmC+d/K1KnTsqxgHtkoqiQ4paSG6AvhbNdnzCLxkF0gsNyXw9
	 CyCfBgE650HKZAxdVghKT46JM/ydgjpsVS83qUdv+wB8CuH40XzJAxnbHWlrVUAeEI
	 ScTuDQcZC+Cn9Tl0LN93Tlr6jrxDRRWr2qhJm1xcsQ7vQH1EQIAHGO/hTR55MWBH8E
	 Swrs0KlSEjikw==
Date: Thu, 9 Oct 2025 18:10:42 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "Kaplan, David" <David.Kaplan@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Klaus Kusche <klaus.kusche@computerix.info>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <xhxfkzrrn62xkd6moiapfueookui5f63x4lmzgkmnf3mbxilb5@kk4rylukegii>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251009053336.ghcmhgsprtkgydas@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251009053336.ghcmhgsprtkgydas@desk>

On Wed, Oct 08, 2025 at 10:33:36PM -0700, Pawan Gupta wrote:
> On Tue, Oct 07, 2025 at 05:14:29PM -0700, Josh Poimboeuf wrote:
> > On Tue, Oct 07, 2025 at 04:08:21PM -0700, Pawan Gupta wrote:
> >   MITIGATION_RETPOLINE -> X86_UGLY_INDIRECT_THUNKS
> >   MITIGATION_RETHUNK   -> X86_UGLY_RETURN_THUNKS
> > 
> >   etc...
> > 
> > Then one only needs to grep their .config file for UGLY to understand
> > why their disassembly is so inscrutable ;-)
> 
> :-) Agree, this is ugly. One way to handle this could be two levels of
> Kconfig options like below:
> 
> * CONFIG_MITIGATION_FOO			- Compiles out the mitigation

Maybe, though compiling out individual features would be complicated by
the fact that we have dependencies between several of the mitigations,
as evidenced by *_update_mitigation().

>   * CONFIG_MITIGATION_FOO_DEFAULT	- Sets the bootup default

I'm wondering if we can just get rid of the compiled-in defaults.  Do
people really need that anymore, now that we have the attack vector
controls?  We could instead have

  CONFIG_CPU_MITIGATIONS_OFF
  CONFIG_CPU_MITIGATIONS_AUTO
  CONFIG_CPU_MITIGATIONS_AUTO_NOSMT

  CONFIG_CPU_MITIGATIONS_USER_USER
  CONFIG_CPU_MITIGATIONS_USER_KERNEL
  CONFIG_CPU_MITIGATIONS_GUEST_HOST
  CONFIG_CPU_MITIGATIONS_GUEST_GUEST

... which should cover the main cases.  And of course there's always
CONFIG_CMDLINE for more customization.

>   select X86_UGLY_INDIRECT_THUNKS

Unfortunately it's not always straightforward enough to say "mitigation
FOO always needs X ugly feature".

For example, newer CPUs mitigate Spectre v2 with enhanced IBRS, so they
don't necessarily need all the retpoline and legacy IBRS stuff.  So
CONFIG_MITIGATION_SPECTRE_V2 shouldn't enable those unconditionally.

Instead, CONFIG_MITIGATION_SPECTRE_V2 could enable a submenu which then
allows the user to enable retpoline, IBRS on entry, etc, with each
having help text describing what generations of CPUs it would be the
default for, to help guide the user to choose sane defaults depending on
their CPU:

  * CONFIG_MITIGATION_SPECTRE_V2
    * CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE
      select CONFIG_BUILD_INDIRECT_THUNKS
    * CONFIG_MITIGATION_SPECTRE_V2_IBRS
      select CONFIG_BUILD_IBRS_ENTRY

-- 
Josh

