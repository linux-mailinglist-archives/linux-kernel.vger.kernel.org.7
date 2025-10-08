Return-Path: <linux-kernel+bounces-845292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A37BC44B1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BD83ADAB9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870D02F549C;
	Wed,  8 Oct 2025 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W0TVEo1B"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB92F5A01
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918924; cv=none; b=XDXca75qHI2ObHF9kGCCC9PLpseuBIcQ82XX7RfF5EgPCIwmQlyA4K71p2pQR5/5Pq4LJak8lCCNNNpWlnuyMwswI2baZr3cg7OxENlymPDnc86f61O1sqzAS4kUTfnwjs1xeujphNbygT+ofooR0ktkGSLhTwyvu8Mx47XnLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918924; c=relaxed/simple;
	bh=qfqHbBIpB2XPm4SOcuA/T+YYxmxec8qw/7rZh96Rgtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp1mtJq62lt3ED9nhD5qGfMO5GnxS7jVz82aXcl/OCz+H3iF2Mcf57yA+eV7dTOW/8zqLb811iSHocJNl5A8Lu97jOuR6gdfXy58n+yG/T2mAtBN+FTt6AzfyOxJ9cwamqukxowhFmvPP4dwgyCx9fZdTlCXVO5VHv1u4MxAb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W0TVEo1B; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 599A340E01C9;
	Wed,  8 Oct 2025 10:21:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SLIGt5VvdLZq; Wed,  8 Oct 2025 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1759918913; bh=VAYvJAtRKA4WGZeh8ZtxhVkwCGgv4wzgcWujPkrV7WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0TVEo1Bbuh44ZPsDZ0tdeXkutIMYZic2naHA9b3NYmBM0IDrm/NzesQ8JLjRGce/
	 S7s8CZ3Bbpv2/uMpoihxA0wKtmx/9EB/XHldO/y7WIv9w+VtkJtuhom9xTKVATHM+j
	 XOXmaRogEP7aOWwuuYYcDQHOPBKZ7uMFVx8+G6+LId8aJI7Wa4sBrR9AUG2ntSmJQs
	 Avspc/LgY3uRcmZR52F0fMxxLbNKure3lCRlXyt48WQld3+k+SXumsZEVrBbMrnmv4
	 ChCnFHwHtDN4wjBiqHaT7F7eSDnoqxTQoU2O2MVZ3kj/dEAsTLBl15ObA2xD8j79oe
	 1pCSi8Q+xUP6Pj7SbH4qORBTN9eno2PmVKLbXtlwmKOonvGfXUumpVn5fAXCbLLYI8
	 b53qdWXcxTiL68rH0KA8NkXxv/E1vhddcj2ZcYg3My38U6h2WCRdBp/HmZuwWP+LHS
	 n7ds5qFFAfGcT/ntk02h0Ia5BDbWqL3fQHUiMRrSe3kFeBG7NX8NJUNN7wR/nf5TiI
	 mhhqquerxJlY81JW33bI7/yUrbPUZ3CcyDtP63j4WiHnbeZq/IkpuauXDS+wtYUe4n
	 i1j9UtamNDkMVbm/hiSs2si6Y4/QBF2jmOiqr0iF80a5dCBZ38dPEXZckUm22uycTt
	 9ZG9MJI8OIozmBo8Pimu7OrI=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8722440E01AB;
	Wed,  8 Oct 2025 10:21:42 +0000 (UTC)
Date: Wed, 8 Oct 2025 12:21:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>

On Tue, Oct 07, 2025 at 05:14:29PM -0700, Josh Poimboeuf wrote:
> Isn't that what CONFIG_CPU_MITIGATIONS=n already does today?

I'd like =n to mean, code is not compiled in.

We do have some savings:

   text	   data	    bss	    dec	    hex	filename
136442490	9737118		36764336	182943944	ae780c8	vmlinux 	# CONFIG_CPU_MITIGATIONS is not set
138493310	10692818	37741668	186927796	b244ab4	vmlinux		# CONFIG_CPU_MITIGATIONS=y

but look at bugs.o:

# CONFIG_CPU_MITIGATIONS is not set	599K arch/x86/kernel/cpu/bugs.o
# CONFIG_CPU_MITIGATIONS=y		625K arch/x86/kernel/cpu/bugs.o

and those unused 600K still go into vmlinux:

$ readelf -W -s vmlinux | grep cpu_show_
 38058: ffffffff81869d20    27 FUNC    LOCAL  DEFAULT    1 cpu_show_not_affected
 91642: ffffffff81284980    70 FUNC    GLOBAL DEFAULT    1 cpu_show_vmscape
 92944: ffffffff812840f0    68 FUNC    GLOBAL DEFAULT    1 cpu_show_spectre_v1
 93449: ffffffff812847e0    70 FUNC    GLOBAL DEFAULT    1 cpu_show_gds
 96967: ffffffff81869d20    27 FUNC    WEAK   DEFAULT    1 cpu_show_ghostwrite
 99329: ffffffff812843b0    70 FUNC    GLOBAL DEFAULT    1 cpu_show_spec_store_bypass
102119: ffffffff81284830    70 FUNC    GLOBAL DEFAULT    1 cpu_show_reg_file_data_sampling
102618: ffffffff812845b0    56 FUNC    GLOBAL DEFAULT    1 cpu_show_itlb_multihit
102660: ffffffff81284880    85 FUNC    GLOBAL DEFAULT    1 cpu_show_old_microcode
103154: ffffffff812848e0    70 FUNC    GLOBAL DEFAULT    1 cpu_show_indirect_target_selection
103474: ffffffff81284460   164 FUNC    GLOBAL DEFAULT    1 cpu_show_mds
103673: ffffffff81284510   153 FUNC    GLOBAL DEFAULT    1 cpu_show_tsx_async_abort
106613: ffffffff81284930    70 FUNC    GLOBAL DEFAULT    1 cpu_show_tsa
109692: ffffffff81284400    92 FUNC    GLOBAL DEFAULT    1 cpu_show_l1tf
111021: ffffffff81284640   150 FUNC    GLOBAL DEFAULT    1 cpu_show_mmio_stale_data
111165: ffffffff812845f0    70 FUNC    GLOBAL DEFAULT    1 cpu_show_srbds
112332: ffffffff81284090    83 FUNC    GLOBAL DEFAULT    1 cpu_show_meltdown
114213: ffffffff812846e0   174 FUNC    GLOBAL DEFAULT    1 cpu_show_retbleed
114312: ffffffff81284790    70 FUNC    GLOBAL DEFAULT    1 cpu_show_spec_rstack_overflow
118586: ffffffff81284140   619 FUNC    GLOBAL DEFAULT    1 cpu_show_spectre_v2

$ readelf -W -s vmlinux | grep _parse_cmdline
  2575: ffffffff897a0050    27 FUNC    LOCAL  DEFAULT   18 nospectre_v2_parse_cmdline
  2578: ffffffff897a0070    27 FUNC    LOCAL  DEFAULT   18 nossb_parse_cmdline
  2587: ffffffff897a0110    37 FUNC    LOCAL  DEFAULT   18 its_parse_cmdline
  2591: ffffffff897a01d0   138 FUNC    LOCAL  DEFAULT   18 tsx_async_abort_parse_cmdline
  2594: ffffffff897a0260   138 FUNC    LOCAL  DEFAULT   18 mmio_stale_data_parse_cmdline
  2597: ffffffff897a02f0    97 FUNC    LOCAL  DEFAULT   18 rfds_parse_cmdline
  2599: ffffffff897a0360    56 FUNC    LOCAL  DEFAULT   18 srbds_parse_cmdline
  2601: ffffffff897a03a0    38 FUNC    LOCAL  DEFAULT   18 l1d_flush_parse_cmdline
  2603: ffffffff897a03d0    96 FUNC    LOCAL  DEFAULT   18 gds_parse_cmdline
  2604: ffffffff897a0430   166 FUNC    LOCAL  DEFAULT   18 tsa_parse_cmdline
  2606: ffffffff897a04e0   268 FUNC    LOCAL  DEFAULT   18 spectre_v2_user_parse_cmdline
  2608: ffffffff897a05f0   487 FUNC    LOCAL  DEFAULT   18 spectre_v2_parse_cmdline
  2609: ffffffff897a07e0   131 FUNC    LOCAL  DEFAULT   18 spectre_bhi_parse_cmdline
  2611: ffffffff897a0870   206 FUNC    LOCAL  DEFAULT   18 ssb_parse_cmdline
  2613: ffffffff897a0a30   200 FUNC    LOCAL  DEFAULT   18 srso_parse_cmdline
  2615: ffffffff897a0b00   178 FUNC    LOCAL  DEFAULT   18 vmscape_parse_cmdline
  2617: ffffffff897a0bc0   344 FUNC    LOCAL  DEFAULT   18 retbleed_parse_cmdline

and so on...

So I'd like to try to see whether completely axing it off in the =n case
without incurring a lot of ugly ifdeffery, would work.

> Then one only needs to grep their .config file for UGLY to understand
> why their disassembly is so inscrutable ;-)

Not sure about UGLY but if you can come up with a name that says "has impact
on the resulting code and when you have them enabled, you have weird asm
constructs all over the place", sure, why not.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

