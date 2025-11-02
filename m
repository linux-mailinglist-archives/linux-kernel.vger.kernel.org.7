Return-Path: <linux-kernel+bounces-881986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8CC29610
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 21:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC3244E15F3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 20:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227C4136658;
	Sun,  2 Nov 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rspze4WS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA3208AD
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762114298; cv=none; b=aAaB7LAOpeLhD9zSRPDgGTbr+dGe2rdftdPbzENzGp2yPkHgGznlet9zBJ6tv9ik2sl90G4TBI/w47aGEYoIGIrhOsZXtJyYWuiML5xViqJ4huECmqDN0il8FHsDsgOzYEA2BXep+VfKGYgqZIF+dWEOl7f1FtTpq+v+i9EMbxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762114298; c=relaxed/simple;
	bh=em0Ceh7fHYuSWkQG3v7mbzCxln5XJ2+qVb54oOXSnL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znk3QDAr8y4kJs2kZ/upVLPtUuemX2gLio1akNnwPZ0TtjbGyqV32y82C3YHa7zSYtrvSk7RteAVT5oGpDS5FFxVAgd3ud0MLPS7HuxBv3w3yNXjA7UxsF0Ay+qs+Yqizc/NfgznxghZGOAkMyNf0hGB+PWb2I3QnFDruENUkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Rspze4WS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2E6F640E0191;
	Sun,  2 Nov 2025 20:11:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ALa2FPn4mpKm; Sun,  2 Nov 2025 20:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762114287; bh=po6hmy7KlYwYLDLvTkqSJ42RxBeEi0Xe5+U+thi+QoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rspze4WSn37vhjth9UilgTR/TuHwqCu7/i6I8u+uOeOYt0LFNzFrzk33wCcV+WUgi
	 4rVC7s7arq/2zw4NLzn8OSRx1F1iifTMcWH/Tpln5GQYUqsP//ke8IPAfDNHb8BwXz
	 CDO6trR5VAfoVx14UyyjCG/99W0GKW1H9iX3CyN8OHW9aKHrEW/86HJUtQz1FNnTWm
	 cXHM5k0jfDQRBGvPdjbYRM0OmWjtsVPqz0Xgwl5zn0JQbBEpsiauWeJ5AY5EcnpBRY
	 AwoY1rUqqj5rMi69eT8t/B7FJaFvIBohzntaRCWo2DbYV1gfEqDekOwemeihPUAa8v
	 4JBtbw/yMX7xhkcE9df/pSWMjinmxLRw7Nd9o9Ow0NzAfsP+i5vVsETHMLQcqLvdpE
	 xcPEN0DesYjc8QkZtBnIfD6fl8YKMdMVdCI29rcUsm/2QGBqn/eMmcCLcgvmw5osVo
	 qQ8NZW8Y3tLcR5V5QZDgddpkXx4+BsoCjCtbI6Fq1y10hzXF09DUhP3gyGBG2C+JM1
	 Dn+NXRqcN/B2jy9+8Ob4PBUuDH54Ft3PZcoIFYv+iO3j3s1I6mxSsrxegf/IItE6gf
	 A+bwAXjwQyhcgp5AP6BDzoVHds6KIYalGsPaWCH4xGSNxbRfGgixd2CPnT9LQ/S4xm
	 YzaFq+qX4Oj6UZyClO6QPbss=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 06F7C40E00DA;
	Sun,  2 Nov 2025 20:11:15 +0000 (UTC)
Date: Sun, 2 Nov 2025 21:11:15 +0100
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
Message-ID: <20251102200902.GDaQe6Xo0plI8glTbE@fat_crate.local>
References: <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>
 <pnobm2r4icma6xzxvzklxoyoy3a4yhhxuxdoq2srmz6rpnegms@qneijnfu6fmz>
 <20251009101557.GAaOeLXYDjOnyFTWdg@fat_crate.local>
 <20251009171331.vplg2zcfystojcxo@desk>
 <LV3PR12MB9265301AEA5D0EDB672DC7A594EEA@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251009231437.GCaOhB3aeJlTCu_OkQ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251009231437.GCaOhB3aeJlTCu_OkQ@fat_crate.local>

On Fri, Oct 10, 2025 at 01:14:37AM +0200, Borislav Petkov wrote:
> On Thu, Oct 09, 2025 at 06:13:20PM +0000, Kaplan, David wrote:
> > If we really want to optimize a CONFIG_CPU_MITIGATIONS=n kernel, why not
> > also look at alternatives that will never be enabled?
> > 
> > All the extra NOPs I think can affect performance in various ways and if
> > there was a way at compile time to know that the alternative would never be
> > enabled (because the feature is completely dependent on a cpu mitigation)
> > you could eliminate the NOPs...
> 
> I don't see why not. That mitigations gunk should be just like any other
> CONFIG_-controllable item and not simply "leak" into the build because, oh
> well, we've done it this way from the very beginning and no one should touch
> it.
> 
> So yeah, eventually we should try this. I've been experimenting with
> untangling bugs.c today, will check how much it actually saves us when
> I finish beating the stinking pile into submission.

So I can't say that it is insignificant:

   text    data     bss     dec     hex filename
30787172        11613226        7863812 50264210        2fef892 vmlinux.with
30210273        11598338        6061260 47869871        2da6faf vmlinux.without

that's ~500K code on my tailored config, meaning I haven't even enabled all
mitigations. So I'm thinking we should do this, but slowly, piecemeal, until
we have settled on the layout.

I'll send some patches soon to gather opinions...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

