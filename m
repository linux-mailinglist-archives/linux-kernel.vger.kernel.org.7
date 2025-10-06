Return-Path: <linux-kernel+bounces-842991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7DCBBE259
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2170F3BE0C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB0E29AB02;
	Mon,  6 Oct 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zh3n3IrO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C6287268
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756322; cv=none; b=piy8tuvrSpuqjy0fDGTTgjTNpAl55fIB61aT0aOYkVolHgDKJ/1SvEHWVwElrt+kL/LV8ee5vFhaWEqvHnH9TBYfpWs6VaSOa3aGuRDq7GeaAhOMv9fKbScD9OmB1CMSU/7SlE9HiP/giQBtbeMKuQxXoFE8TTaFqYMb0EOx4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756322; c=relaxed/simple;
	bh=RCfHcCS49H0jPfTadDqu3/+iKK/RCfM1Fd8FXNY6sN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH9rExqF+Hh62KueKW8CHpQJHuoY3/SnhtxuVyRKlmkUg0VAThr8p1r4zQbeaa1n30KXY/fMDfZuyzNHpqfy0VTt34/AsFlZvkMsbNmCIfaqo6NiJA1sM4Po5Hub0bmSN48TbKWrHeo8bvVtzxYiZ756HZtxe7jiz9XDh6LsMuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Zh3n3IrO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 26BC040E01CD;
	Mon,  6 Oct 2025 13:11:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HcjTYQawyWJL; Mon,  6 Oct 2025 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1759756312; bh=RuIz4e5yT2pXQBySS44ukbvJqhVAgwcMztPMxCNYMEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zh3n3IrOF7h/3v6jyb/c/vnhNSb6w6RYcrIMi0X6g2wsPah1JnZXs53yFSGjMYQQr
	 f27LfgFVs8oay8wAgPoI+z3jo7Pj/rXRIXzB22UPmzFX9xrXRDINUrZTzO/k8JvPTb
	 ThzDiqAPvhv1IacoFY3RHzXezGEUx3JxmKZSaeaonxk48L0WJYYw1KfWF/ZAbfvDxY
	 4R2wh1J/3+epflKNcYjQmuqLZWzXVAUfD6Ncw/1noVooX1aBhVmy9LdylJ/2l6hQBz
	 wcZ9XFTEMXNvYvT3mNAVUrSOI7+JgLawLezv3T1TLuHpNcCa/GkopFg4AS+EGEtByH
	 5Lb/viacDfdQSkSLfUI79yx7A852ayod3z+TpclaAl9b4PZU+dSrGfBWATpcScI1Un
	 BolF8TIforGEfCRacOZCInTej0TwI7padLQyYhkCbsSbym826g6y7e/qn4ncwluzm7
	 oKh5ZQlaU4RbssLm07KRD/BqkdpXrP7lYg0pRGf4iRnXmpSjdbZJh3s+7KB0jYNLDo
	 J+iV169WoDpqLYmcXKgQEBZh1r3SYwYikRKST3hLxxH7KwQ6tb3hL26UndcreZ3UHX
	 gS63awTcu8AAC/sT/cp8J3Ijmh6AUU10E/NWxSNGBDqkyZrNjLu+psAj/nRRQp8nnV
	 xijFId9qGN+HDwnBmlzG5t6Y=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8D07340E00DE;
	Mon,  6 Oct 2025 13:11:41 +0000 (UTC)
Date: Mon, 6 Oct 2025 15:11:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
References: <20251003171936.155391-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251003171936.155391-1-david.kaplan@amd.com>

On Fri, Oct 03, 2025 at 12:19:36PM -0500, David Kaplan wrote:
> When retbleed mitigation is disabled, the kernel already prints an info
> message that the system is vulnerable.  Recent code restructuring also
> inadvertently led to RETBLEED_INTEL_MSG being printed as an error, which is
> unnecessary as retbleed mitigation was already explicitly disabled (by
> config option, cmdline, etc.).
> 
> Qualify this print statement so the warning is not printed unless an actual
> retbleed mitigation was selected and is being disabled due to
> incompatibility with spectre_v2.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220624
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 6a526ae1fe99..e08de5b0d20b 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1463,7 +1463,9 @@ static void __init retbleed_update_mitigation(void)
>  			break;
>  		default:
>  			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF) {
> -				pr_err(RETBLEED_INTEL_MSG);
> +				if (retbleed_mitigation != RETBLEED_MITIGATION_NONE)
> +					pr_err(RETBLEED_INTEL_MSG);
> +
>  				retbleed_mitigation = RETBLEED_MITIGATION_NONE;
>  			}
>  		}

I guess we can do that for now...

But even with it, my random guest says:

[    0.420377] mitigations: Enabled attack vectors: SMT mitigations: off
[    0.421355] Speculative Store Bypass: Vulnerable
[    0.422234] Spectre V2 : Vulnerable
[    0.422845] Speculative Return Stack Overflow: Vulnerable
[    0.423759] Spectre V1 : Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers

during boot with

# CONFIG_CPU_MITIGATIONS is not set

in its config. 

The "Enabled attack vectors" doesn't mean a whole lot if we've disabled
mitigations. It probably is even a bit misleading.

The others are perhaps *technically* correct but then we're reporting only
a subset of the mitigations and not all for which the machine is affected.

But it ain't the right fix long term, AFAICT.

Because we probably should do this instead:

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 2f8a58ef690e..c789286a480b 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -22,7 +22,7 @@ obj-y                 += topology_common.o topology_ext.o topology_amd.o
 obj-y                  += common.o
 obj-y                  += rdrand.o
 obj-y                  += match.o
-obj-y                  += bugs.o
+obj-$(CONFIG_CPU_MITIGATIONS)          += bugs.o
 obj-y                  += aperfmperf.o
 obj-y                  += cpuid-deps.o cpuid_0x2_table.o
 obj-y                  += umwait.o

because off means off and there should be nothing in the boot log about any
mitigations and no code should be built in. Which is done now - just the code
is inactive which is not what we do with disabled code in the kernel.

But that then causes at least this:

ERROR: modpost: "cpu_buf_vm_clear" [arch/x86/kvm/kvm.ko] undefined!
ERROR: modpost: "switch_vcpu_ibpb" [arch/x86/kvm/kvm.ko] undefined!
ERROR: modpost: "gds_ucode_mitigated" [arch/x86/kvm/kvm.ko] undefined!
ERROR: modpost: "l1tf_vmx_mitigation" [arch/x86/kvm/kvm.ko] undefined!
ERROR: modpost: "x86_ibpb_exit_to_user" [arch/x86/kvm/kvm.ko] undefined!
ERROR: modpost: "itlb_multihit_kvm_mitigation" [arch/x86/kvm/kvm.ko] undefined!
ERROR: modpost: "x86_spec_ctrl_current" [arch/x86/kvm/kvm-amd.ko] undefined!
ERROR: modpost: "x86_virt_spec_ctrl" [arch/x86/kvm/kvm-amd.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [/mnt/k/kernel/r/11/linux/Makefile:1960: modpost] Error 2

which means untangling from kvm... which means ugly ifdeffery...

Sounds like a longer project...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

