Return-Path: <linux-kernel+bounces-853722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E86BDC6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928674079DA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB1E2E7F39;
	Wed, 15 Oct 2025 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZBia38u"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC462DE1E4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501450; cv=none; b=TJueY3xxusQ+6SQBnSSb7GZBsbLrHabW0K95nc+jLSS4slLDORBVCv8FdPeJNrjnYi+tnxeqn8DtYFQSG6bh/tskbE+amdfYgeM5h4kFor6618y9wwx66RbeDP2KsF4/Jra0VHLdw1ltndX5Rq5MW43GYnbdnSjtQqs+5ZAkJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501450; c=relaxed/simple;
	bh=Ya9QA+JBz6N2RcWqw6o5lhrmnXrqJ7VOm9hlMDCxI14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Np3cT2zmeVhDyhnO1rh8tw6Fr+b2q38AA43c4Ckc9L3OrD0f9lKqiOTtsb/ElfFLYvWcpEOERlHN++aoIkURuSc5w/JECwgFcI789l2x9Hrk6yLQDknGK3S61ODWCYlIxjwIax7W/devmqQVmZLTu9cNwHdhx4Sst7dMT+qmKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZBia38u; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-938760d9917so17148439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760501447; x=1761106247; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJx0WPu3FkOZhrKusO0W5EooZvLJi5ZlI1bBbjyz+V8=;
        b=EZBia38uBl1ePzR3dJlPBbltLuYovl3YowXdkx71phOAznydj63oKgIGtlaqf0Yl/V
         +Rry9Lxe0rKYQo2GnZkv8lxhlnBXIfJXHnaUl8cvQ2cGxSGOr7OaGkgpSxOXYieVpVLt
         UdvTYG+QpuA6OKz8QtiGw7LwpHLs9Ocm1m2/0ui8BSG9NApjlMPwLzJrQ/GXwgtYQEes
         rsQcrdQEvjFeIgZqY8OFR45kGti14CtsTh5VZg5zwsv83wtFY/EiGX3LO7xBqBINvR0h
         ipSnisEqw7inxmhSh+jrIRIPYo3pz8F94HIUvkstV4eJpHKcxIYxk88TPYMwKhJWk4jx
         HCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501447; x=1761106247;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJx0WPu3FkOZhrKusO0W5EooZvLJi5ZlI1bBbjyz+V8=;
        b=C3v6xAJoctur7VXFVcCOoaI1+GjoNhFt/OzfZ6jtqoZfo8ftvif2b5aAg8wY2UZZy3
         Y5j0BsDAJJwPf28qQ0l3S3aM9L4Hp1YYHTRLONQuck+PJR5yb2+Sjci1s21b09hNvgs5
         KG3EhPxFZb3QO1KriDl9nbNYBGK1LGFyfME9NmSQnNPkH+QSWL8520Ur/XrWttU7QQhs
         kihZgboNaTRPYZWTR5UIj9KDNY8vW9UNHlmd9j/i0gH1Z+qNaro9q9XUVPenpfrTmeQe
         KMhZqOv+5gI/OQwS2S87OBzpsgumUKuQucRi48pTee49WEZrin3AT8brk4ZOgDE3vJjn
         diDw==
X-Forwarded-Encrypted: i=1; AJvYcCWQvKepl4np146FPCMeFhZZXIdc/keCniqM+szNQ5A0XDakBUmJyp0+Nqpmc+vMb8LXcOWuGYH+cR7rgag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRcxTchjIlhuY1si0UPPLNfdHuHaypUiikAx89QG/efEZH3kz
	Mr8unY+wXrW+E5gP4DdDRuEojhdhL3XNIOdKPVCbT3mXqhZTNv8IUNBG
X-Gm-Gg: ASbGncu6mfTvSzLcb/rz83TPFYgqBINtcHZPB/fObSgQZzG24lgd/o7ejzpL/Sb2Wqa
	W1YyeG2Ug53CLanDS1KymItKv6y2iMla3PNCzfjJlS51BOHj1xV2pvpGP2rIk86z10uVsVZjp9A
	KWs7JVeZh3LJJtD5O8rlUMeb1QEHRpJB4N0DnAN+ldFxcVWxU7aw+HgEff4yfhSzquUg4NDceBN
	6ARt8SK2ROPT4MD88yFT1yL7/VClyM7s3xC0Tfjg5HVuDjKx40X+WYWe45CZtEOYj2hpDkb9e+A
	P1gifjUtZQaPy2iwZDVBXAySa9HFgZG73anT6Z/iBj9gauB0CbdkWFuDvzbuA1Y51FsZx65lcA4
	OaMIeTzCeGT8nniFOLk2yyXu1XlrK53GrRe5bwk7WAUNSRMhO0T/6eSZmdwMf
X-Google-Smtp-Source: AGHT+IGIqR/8Hk4usI/epgrMfjAvBeRXNaZFHuPfg24S11auPdkvrjtv5WXDXPupN22vdsPwmJYq4Q==
X-Received: by 2002:a05:6602:1649:b0:93e:23b0:cc0f with SMTP id ca18e2360f4ac-93e23b0ccc7mr903724239f.3.1760501447266;
        Tue, 14 Oct 2025 21:10:47 -0700 (PDT)
Received: from kf-m2g5 ([2607:fb90:cf33:8caf:8d79:a64a:1cd0:8e43])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6d0431cfsm5449841173.22.2025.10.14.21.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:10:47 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:10:39 -0500
From: Aaron Rainbolt <arraybolt3@gmail.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Alexander Graf
 <graf@amazon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
Message-ID: <20251014231039.6d23008f@kf-m2g5>
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5+Ud23QwUr20gG3JKBHc9pF";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/5+Ud23QwUr20gG3JKBHc9pF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Oct 2025 09:33:48 -0500
David Kaplan <david.kaplan@amd.com> wrote:

> Dynamic mitigations enables changing the kernel CPU security
> mitigations at runtime without a reboot/kexec.
>=20
> Previously, mitigation choices had to be made on the kernel cmdline.
> With this feature an administrator can select new mitigation choices
> by writing a sysfs file, after which the kernel will re-patch itself
> based on the new mitigations.
>=20
> As the performance cost of CPU mitigations can be significant,
> selecting the right set of mitigations is important to achieve the
> correct balance of performance/security.
>=20
> Use
> ---
> As described in the supplied documentation file, new mitigations are
> selected by writing cmdline options to a new sysfs file.  Only cmdline
> options related to mitigations are recognized via this interface.  All
> previous mitigation-related cmdline options are ignored and
> selections are done based on the new options.
>=20
> Examples:
>    echo "mitigations=3Doff" > /sys/devices/system/cpu/mitigations
>    echo "spectre_v2=3Dretpoline tsa=3Doff" >
> /sys/devices/system/cpu/mitigations

If `root` is capable of setting `mitigations=3Doff` via this interface,
doesn't that somewhat defeat the purpose of denying `/proc/kcore`
access in lockdown confidentiality mode? Assuming one is running on a
CPU with some form of side-channel memory read vulnerability (which they
very likely are), they can turn off all mitigations, then read kernel
memory via one of those exploits.

There should be a one-way switch to allow denying all further writes to
this interface, so that once the system's mitigations are set properly,
any further attempts to change them until the next reboot can be
prevented.

--
Aaron

>=20
> There are several use cases that will benefit from dynamic
> mitigations:
>=20
> Use Cases
> ---------
> 1. Runtime Policy
>=20
> Some workflows rely on booting a generic kernel before customizing
> the system. cloud-init is a popular example of this where a VM is
> started typically with default settings and then is customized based
> on a customer-provided configuration file.
>=20
> As flows like this rely on configuring the system after boot, they
> currently cannot customize the mitigation policy.  With dynamic
> mitigations, this configuration information can be augmented to
> include security policy information.
>=20
> For example, a cloud VM which runs only trusted workloads likely does
> not need any CPU security mitigations applied.  But as this policy
> information is not known at boot time, the kernel will be booted with
> unnecessary mitigations enabled.  With dynamic mitigations, these
> mitigations can be disabled during boot after policy information is
> retrieved, improving performance.
>=20
> 2. Mitigation Changes
>=20
> Sometimes there are needs to change the mitigation settings in light
> of new security findings.  For example, AMD-SB-1036 advised of a
> security issue with a spectre v2 mitigation and advised using a
> different one instead.
>=20
> With dynamic mitigations, such changes can be made without a
> reboot/kexec which minimizes disruption in environments which cannot
> easily tolerate such an event.
>=20
> 3. Mitigation Testing
>=20
> Being able to quickly change between different mitigation settings
> without having to restart applications is beneficial when conducting
> mitigation development and testing.
>=20
> Note that some bugs have multiple mitigation options, which may have
> varying performance impacts.  Being able to quickly switch between
> them makes evaluating such options easier.
>=20
>=20
> Implementation Details
> ----------------------
> Re-patching the kernel is expected to be a very rare operation and is
> done under very big hammers.  All tasks are put into the freezer and
> the re-patching is then done under the (new) stop_machine_nmi()
> routine.
>=20
> To re-patch the kernel, it is first reverted back to its compile-time
> state.  The original bytes from alternatives, retpolines, etc. are
> saved during boot so they can later be used to restore the original
> kernel image. After that, the kernel is patched based on the new
> feature flags.
>=20
> This simplifies the re-patch process as restoring the original kernel
> image is relatively straightforward.  In other words, instead of
> having to re-patch from mitigation A to mitigation B directly, we
> first restore the original image and then patch from that to
> mitigation B, similar to if the system had booted with mitigation B
> selected originally.
>=20
>=20
> Performance
> -----------
> Testing so far has demonstrated that re-patching takes ~50ms on an
> AMD EPYC 7713 running a typical Ubuntu kernel with around 100 modules
> loaded.
>=20
> Guide to Patch Series
> ---------------------
> As this series is rather lengthy, this may help with understanding it:
>=20
> Patches 3-18 focus on "resetting" mitigations.  Every bug that may
> set feature flags, MSRs, static branches, etc. now has matching
> "reset" functions that will undo all these changes.  This is used at
> the beginning of the re-patch flow.
>=20
> Patches 20-22 move various functions and values out of the .init
> section.  Most of the existing mitigation logic was marked as __init
> and the mitigation settings as __ro_after_init but now these can be
> changed at runtime.  The __ro_after_init marking functioned as a
> defense-in-depth measure but is arguably of limited meaningful
> security value as an attacker who can modify kernel data can do a lot
> worse than change some speculation settings.  As re-patching requires
> being able to modify these settings, it was simplest to remove them
> from that section.
>=20
> Patches 23-27 involve linker and related modifications to keep
> alternative information around at runtime instead of free'ing it
> after boot.  This does result in slightly higher runtime memory
> consumption which is one reason why this feature is behind a Kconfig
> option.  On a typical kernel, this was measured at around 2MB of
> extra kernel memory usage.
>=20
> Patches 28-30 focus on the new stop_machine_nmi() which behaves like
> stop_machine() but runs the handler in NMI context, thus ensuring
> that even NMIs cannot interrupt the handler.  As dynamic mitigations
> involves re-patching functions used by NMI entry code, this is
> required for safety.
>=20
> Patches 31-40 focus on support for restoring the kernel text at
> runtime.  This involves saving the original kernel bytes when patched
> the first time and adding support to then restore those later.
>=20
> Patches 41-44 start building support for updating code, in particular
> module code at runtime.
>=20
> Patches 45-47 focus on support for the Indirect Target Selection
> mitigation which is particularly challenging because it requires
> runtime memory allocations and permission changes which are not
> possible in NMI context.  As a result, ITS memory is pre-allocated
> before entering NMI context.
>=20
> Patch 50 adds the complete function for resetting and re-patching the
> kernel.
>=20
> Patches 51-53 build the sysfs interface for re-patching and support
> for parsing the new options provided.
>=20
> Patches 54-56 add debugfs interfaces to values which are important for
> mitigations.  These are useful for userspace test utilities to be
> able to force a CPU to appear to be vulnerable or immune to certain
> bugs as well as being able to help verify if the kernel is correctly
> mitigating various vulnerabilities.
>=20
> David Kaplan (56):
>   Documentation/admin-guide: Add documentation
>   x86/Kconfig: Add CONFIG_DYNAMIC_MITIGATIONS
>   cpu: Reset global mitigations
>   x86/bugs: Reset spectre_v1 mitigations
>   x86/bugs: Reset spectre_v2 mitigations
>   x86/bugs: Reset retbleed mitigations
>   x86/bugs: Reset spectre_v2_user mitigations
>   x86/bugs: Reset SSB mitigations
>   x86/bugs: Reset L1TF mitigations
>   x86/bugs: Reset MDS mitigations
>   x86/bugs: Reset MMIO mitigations
>   x86/bugs: Reset SRBDS mitigations
>   x86/bugs: Reset SRSO mitigations
>   x86/bugs: Reset GDS mitigations
>   x86/bugs: Reset BHI mitigations
>   x86/bugs: Reset ITS mitigation
>   x86/bugs: Reset TSA mitigations
>   x86/bugs: Reset VMSCAPE mitigations
>   x86/bugs: Define bugs_smt_disable()
>   x86/bugs: Move bugs.c logic out of .init section
>   x86/callthunks: Move logic out of .init
>   cpu: Move mitigation logic out of .init
>   x86/vmlinux.lds: Move alternative sections
>   x86/vmlinux.lds: Move altinstr_aux conditionally
>   x86/vmlinux.lds: Define __init_alt_end
>   module: Save module ELF info
>   x86/mm: Conditionally free alternative sections
>   stop_machine: Add stop_machine_nmi()
>   x86/apic: Add self-NMI support
>   x86/nmi: Add support for stop_machine_nmi()
>   x86/alternative: Prepend nops with retpolines
>   x86/alternative: Add module param
>   x86/alternative: Avoid re-patching init code
>   x86/alternative: Save old bytes for alternatives
>   x86/alternative: Save old bytes for retpolines
>   x86/alternative: Do not recompute len on re-patch
>   x86/alternative: Reset alternatives
>   x86/callthunks: Reset callthunks
>   x86/sync_core: Add sync_core_nmi_safe()
>   x86/alternative: Use sync_core_nmi_safe()
>   static_call: Add update_all_static_calls()
>   module: Make memory writeable for re-patching
>   module: Update alternatives
>   x86/module: Update alternatives
>   x86/alternative: Use boot_cpu_has in ITS code
>   x86/alternative: Add ITS re-patching support
>   x86/module: Add ITS re-patch support for modules
>   x86/bugs: Move code for updating speculation MSRs
>   x86/fpu: Qualify warning in os_xsave
>   x86/alternative: Add re-patch support
>   cpu: Parse string of mitigation options
>   x86/bugs: Support parsing mitigation options
>   drivers/cpu: Re-patch mitigations through sysfs
>   x86/debug: Create debugfs interface to x86_capabilities
>   x86/debug: Show return thunk in debugfs
>   x86/debug: Show static branch config in debugfs
>=20
>  .../ABI/testing/sysfs-devices-system-cpu      |   8 +
>  .../hw-vuln/dynamic_mitigations.rst           |  75 ++
>  Documentation/admin-guide/hw-vuln/index.rst   |   1 +
>  arch/x86/Kconfig                              |  12 +
>  arch/x86/entry/vdso/vma.c                     |   2 +-
>  arch/x86/include/asm/alternative.h            |  51 +-
>  arch/x86/include/asm/bugs.h                   |   4 +
>  arch/x86/include/asm/module.h                 |  10 +
>  arch/x86/include/asm/sync_core.h              |  14 +
>  arch/x86/kernel/alternative.c                 | 497 ++++++++++++-
>  arch/x86/kernel/apic/ipi.c                    |   7 +
>  arch/x86/kernel/callthunks.c                  |  85 ++-
>  arch/x86/kernel/cpu/bugs.c                    | 686
> +++++++++++++----- arch/x86/kernel/cpu/common.c                  |
> 65 +- arch/x86/kernel/cpu/cpu.h                     |   4 -
>  arch/x86/kernel/fpu/xstate.h                  |   2 +-
>  arch/x86/kernel/module.c                      |  96 ++-
>  arch/x86/kernel/nmi.c                         |   4 +
>  arch/x86/kernel/static_call.c                 |   3 +-
>  arch/x86/kernel/vmlinux.lds.S                 | 110 +--
>  arch/x86/mm/init.c                            |  12 +-
>  arch/x86/mm/mm_internal.h                     |   2 +
>  arch/x86/tools/relocs.c                       |   1 +
>  drivers/base/cpu.c                            | 113 +++
>  include/linux/cpu.h                           |  10 +
>  include/linux/module.h                        |  11 +
>  include/linux/static_call.h                   |   2 +
>  include/linux/stop_machine.h                  |  32 +
>  kernel/cpu.c                                  |  62 +-
>  kernel/module/main.c                          |  78 +-
>  kernel/static_call_inline.c                   |  22 +
>  kernel/stop_machine.c                         |  79 +-
>  32 files changed, 1876 insertions(+), 284 deletions(-)
>  create mode 100644
> Documentation/admin-guide/hw-vuln/dynamic_mitigations.rst
>=20
>=20
> base-commit: a5652f0f2a69fadcfb2f687a11a737a57f15b28e


--Sig_/5+Ud23QwUr20gG3JKBHc9pF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEudh48PFXwyPDa0wGpwkWDXPHkQkFAmjvHr8ACgkQpwkWDXPH
kQlbJxAAkOHLW+rRVy7OZxXK9+diWeoNDbsQ/SdM9di+LFYpL1W7dji7SkkIlUI9
REzzzAXml6TwwxfB1aDuXF9geepEzXFGBG0+gSciT5XA6vejs8+iRX419dWxnFle
EcEwnSDqX4U1eUdJ8wKVgHJRuHBrwXRRQzEbhHo2YoFMOpynh3YHOCFOR3Ribd32
hhL0aUNppo/lUjJRTq0eVulRzJigiDHAkKAGaNwB3d6sujMAufxLqtHO4TTn7n9d
JUraEtttHaOQ2UdfjMliDBYMqiPx7MXxAyZQtS2T1PT1rByh5/5IGFy3+eQU4fJD
lhXP7FRsb0sNyznVb5wmOPlcea1jNag0Y9nbhctbkkiqWEZu0YyRe1h0fh5oGoWd
lzAgIjentIIM1zpnO8uYZ0TZY4haGFyOG6xtW5Ks0vOnJUQEwSfPsESvwCIgChKw
uO2dmOtW7b4RtwK2cO+empfviWJPo7UC/p3H6pNaumjvhcngcI63aGl/tL8ICdtX
u5Q85mGzlLwzngPyU5srClvbUnxkiT3gF0VAaZCgHAHeKme5mlvme1+DVPdJ6DLJ
GFy8yqkfvUfc3S/MmYJqmo869LhOzZ9kkqIUNfpXXD+nM0vv8r1nOiTSrzTz4mtW
Kst0brMc49xPgs1WQvmV2DXBc+4mZaIFBf3fdbo+++8FHUijOn8=
=8PWc
-----END PGP SIGNATURE-----

--Sig_/5+Ud23QwUr20gG3JKBHc9pF--

