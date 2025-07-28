Return-Path: <linux-kernel+bounces-748215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96403B13DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBBA189DF78
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0384270ED2;
	Mon, 28 Jul 2025 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiPCpMtS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525425D53B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715531; cv=none; b=SaWF+hcYkhD5MVhUeHZQiDmShOhDSNEFBD+YGDNqke0Yz468kFbPnMJoco0NA6IRM0RxwCBKJrgEn5lrBzvQN6CHczANEDq/lVcF1vluC+AXin4HJrtaNuzcFHdCSY5nWHSUk6lB68ZNvv+xmH0LWUKEwMMC/Yfc/E70N2BwD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715531; c=relaxed/simple;
	bh=z0XLas3n+pldVU474qS43s5jjeilAY7FSN9alhIyzFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDE0iYyGl7srKziNmLm9pu9fw/uW/cAVM0eAwLndGw4jrmNcmGQJmpaq10WG+MwIyBYq6FVRLT12Bw9sUb1Rg7GSulVLdXHGTqlmdwRNAJk5wyAfbNmuPq5sjrLD19giP5zxdDQFCAqfO1cHgO3UwURtXRiBtpeZ76ov0ubotnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiPCpMtS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753715528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHMpvShnhWh1yEjlzCXHahFQrWzaENPKZ4asjpoh/RM=;
	b=XiPCpMtSWUWj5Zdz5+8W9IOpRn3lCPdckzKeGKUwY+dEMNijrd/sQMH6gu4lAv7zRle2ob
	exTD8RcYKXhWZtegJ44iRuwSGoPoCO4Zh1TlFE6oqIICMU985wqQIX407Vn5VuwczN7gBH
	mO7gbUVVg5CqZOeh2MeR0obvQgXwAn0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-lq7i8TNLOGCfqs1wBcR9tA-1; Mon, 28 Jul 2025 11:12:06 -0400
X-MC-Unique: lq7i8TNLOGCfqs1wBcR9tA-1
X-Mimecast-MFC-AGG-ID: lq7i8TNLOGCfqs1wBcR9tA_1753715525
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b20f50da27so4429f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753715524; x=1754320324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHMpvShnhWh1yEjlzCXHahFQrWzaENPKZ4asjpoh/RM=;
        b=pZaLoCMDoRL95rBuabVJdgjy5gRS0vxJzKUMlXkeM4bE5dQ4Oggtq8Otw1siL9U5+N
         BRB5GGr5UhtrVFV/yVl7G+092DV8yx4x/THCln8nA+3p4NOuHxDRY1jkcJin6nEUcSaf
         fruzLIBLs1TZ9zKQi4XhSyK2X84VXOVWkcLrC+o+dFPcFf4aEYAY8pvPVwx4F/mqAeJt
         DFo/ZM77IJ9tIavHEUkXFotf/a/zQi8Gx3QZywAV04yZslvDKg+Q9ewvY+rIc8Bl8vlt
         cB1IGdPPknrwy0k+Ve+SN6rMKueVcUGlU6ieV4xJnfozbOioanyo9II6YhUmDQ3yEYCG
         /Llg==
X-Forwarded-Encrypted: i=1; AJvYcCXevUwIGNnLyV55NIwlf1vamn+G0q24mTmMleg1oCQvBQrlERgyK/0mvm0eUuMUw0aslPmUT6ZU629Dy7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Y7S7N1pCd1qrhV2Pa8TX2kM3K18INgiET41nnQLxsRM5jZfz
	pG+AHQLaNuhWLgRyWMrj/8EOXiDIlCqek28R+qbOpfJcMI08vcDbbOazCiI3eUKlJGeNXsgACFw
	ag1BfOGkzHUBISf7b32LM5J4+XsY4SmU9ukjRs7uV9q6ccjqwIl/bX18pFcbWWLi91+VCk0pjkS
	cd0cKhrSywo2zTeNGahA+Uus06oV9n6XurncuyjIqQRrwNwR8j
X-Gm-Gg: ASbGncvhVleJvVqsyPGi0hQs43KOxaw99Xl9fqgQn5dCKsIY49jd945eBsZbwaFKoHM
	he2IccyVAm0NMCJXwGa5+6BoXmU7O+DuzvImXjLnjxAxNC7MKVsVzb22gGwb+IMMA7NQp/uyrn/
	wiggUXgzkBClGLN1b6wk1ERA==
X-Received: by 2002:a05:6000:888:b0:3a4:f7dd:6fad with SMTP id ffacd0b85a97d-3b776639335mr7830691f8f.14.1753715523551;
        Mon, 28 Jul 2025 08:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVu4mVwJXobjLaxAPwIZZffuenqn6t93Fir1eLCwdOHk3I6Uaz0CGFy2KYWDFtxHA1uWxdOmWU7JE4vtaXmYU=
X-Received: by 2002:a05:6000:888:b0:3a4:f7dd:6fad with SMTP id
 ffacd0b85a97d-3b776639335mr7830663f8f.14.1753715523069; Mon, 28 Jul 2025
 08:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725220713.264711-1-seanjc@google.com> <20250725220713.264711-6-seanjc@google.com>
In-Reply-To: <20250725220713.264711-6-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Jul 2025 17:11:51 +0200
X-Gm-Features: Ac12FXxjS6zgP1Mwg9KBibeR9J_8x9y3euusxeo48NSg8v2Vlp1nuBhRHg8HLCU
Message-ID: <CABgObfZjCc=0n=SO0jf7wUzJuFxvR8bZiHQaN3YgaNnYvcx7WQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Misc changes for 6.17
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 12:07=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> The highlights are the DEBUGCTL.FREEZE_IN_SMM fix from Maxim, Jim's APERF=
/MPERF
> support that has probably made him question the meaning of life, and a bi=
g
> cleanup of the MSR interception code to ease the pain of adding support f=
or
> CET, FRED, and the mediated PMU (and any other features that deal with MS=
Rs).
>
> But the one change that I really want your eyeballs on is that last commi=
t,
> "Reject KVM_SET_TSC_KHZ VM ioctl when vCPUs have been created"; it's an A=
BI
> change that could break userspace.  AFAICT, it won't affect any (known)
> userspace, and restricting the ioctl for all VM types is much simpler tha=
n
> special casing "secure" TSC guests.  Holler if you want a new tag/pull re=
quest
> without that change; I deliberately kept it dead last specifically so it =
could
> be omitted without any fuss.

No problem there. It makes no sense to use the VM ioctl if you can't
issue it before vCPU creation, the whole point is to have a homogenous
frequency.

Paolo

> The following changes since commit 28224ef02b56fceee2c161fe2a49a0bb197e44=
f5:
>
>   KVM: TDX: Report supported optional TDVMCALLs in TDX capabilities (2025=
-06-20 14:20:20 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-6.17
>
> for you to fetch changes up to dcbe5a466c123a475bb66492749549f09b5cab00:
>
>   KVM: x86: Reject KVM_SET_TSC_KHZ VM ioctl when vCPUs have been created =
(2025-07-14 15:29:33 -0700)
>
> ----------------------------------------------------------------
> KVM x86 misc changes for 6.17
>
>  - Prevert the host's DEBUGCTL.FREEZE_IN_SMM (Intel only) when running th=
e
>    guest.  Failure to honor FREEZE_IN_SMM can bleed host state into the g=
uest.
>
>  - Explicitly check vmcs12.GUEST_DEBUGCTL on nested VM-Enter (Intel only)=
 to
>    prevent L1 from running L2 with features that KVM doesn't support, e.g=
. BTF.
>
>  - Intercept SPEC_CTRL on AMD if the MSR shouldn't exist according to the
>    vCPU's CPUID model.
>
>  - Rework the MSR interception code so that the SVM and VMX APIs are more=
 or
>    less identical.
>
>  - Recalculate all MSR intercepts from the "source" on MSR filter changes=
, and
>    drop the dedicated "shadow" bitmaps (and their awful "max" size define=
s).
>
>  - WARN and reject loading kvm-amd.ko instead of panicking the kernel if =
the
>    nested SVM MSRPM offsets tracker can't handle an MSR.
>
>  - Advertise support for LKGS (Load Kernel GS base), a new instruction th=
at's
>    loosely related to FRED, but is supported and enumerated independently=
.
>
>  - Fix a user-triggerable WARN that syzkaller found by stuffing INIT_RECE=
IVED,
>    a.k.a. WFS, and then putting the vCPU into VMX Root Mode (post-VMXON).=
  Use
>    the same approach KVM uses for dealing with "impossible" emulation whe=
n
>    running a !URG guest, and simply wait until KVM_RUN to detect that the=
 vCPU
>    has architecturally impossible state.
>
>  - Add KVM_X86_DISABLE_EXITS_APERFMPERF to allow disabling interception o=
f
>    APERF/MPERF reads, so that a "properly" configured VM can "virtualize"
>    APERF/MPERF (with many caveats).
>
>  - Reject KVM_SET_TSC_KHZ if vCPUs have been created, as changing the "de=
fault"
>    frequency is unsupported for VMs with a "secure" TSC, and there's no k=
nown
>    use case for changing the default frequency for other VM types.
>
> ----------------------------------------------------------------
> Chao Gao (2):
>       KVM: x86: Deduplicate MSR interception enabling and disabling
>       KVM: SVM: Simplify MSR interception logic for IA32_XSS MSR
>
> Jim Mattson (3):
>       KVM: x86: Replace growing set of *_in_guest bools with a u64
>       KVM: x86: Provide a capability to disable APERF/MPERF read intercep=
ts
>       KVM: selftests: Test behavior of KVM_X86_DISABLE_EXITS_APERFMPERF
>
> Kai Huang (1):
>       KVM: x86: Reject KVM_SET_TSC_KHZ VM ioctl when vCPUs have been crea=
ted
>
> Maxim Levitsky (3):
>       KVM: nVMX: Check vmcs12->guest_ia32_debugctl on nested VM-Enter
>       KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter API=
s
>       KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running t=
he guest
>
> Sean Christopherson (44):
>       KVM: TDX: Use kvm_arch_vcpu.host_debugctl to restore the host's DEB=
UGCTL
>       KVM: x86: Convert vcpu_run()'s immediate exit param into a generic =
bitmap
>       KVM: x86: Drop kvm_x86_ops.set_dr6() in favor of a new KVM_RUN flag
>       KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported
>       KVM: VMX: Extract checking of guest's DEBUGCTL into helper
>       KVM: SVM: Disable interception of SPEC_CTRL iff the MSR exists for =
the guest
>       KVM: SVM: Allocate IOPM pages after initial setup in svm_hardware_s=
etup()
>       KVM: SVM: Don't BUG if setting up the MSR intercept bitmaps fails
>       KVM: SVM: Tag MSR bitmap initialization helpers with __init
>       KVM: SVM: Use ARRAY_SIZE() to iterate over direct_access_msrs
>       KVM: SVM: Kill the VM instead of the host if MSR interception is bu=
ggy
>       KVM: x86: Use non-atomic bit ops to manipulate "shadow" MSR interce=
pts
>       KVM: SVM: Massage name and param of helper that merges vmcb01 and v=
mcb12 MSRPMs
>       KVM: SVM: Clean up macros related to architectural MSRPM definition=
s
>       KVM: nSVM: Use dedicated array of MSRPM offsets to merge L0 and L1 =
bitmaps
>       KVM: nSVM: Omit SEV-ES specific passthrough MSRs from L0+L1 bitmap =
merge
>       KVM: nSVM: Don't initialize vmcb02 MSRPM with vmcb01's "always pass=
through"
>       KVM: SVM: Add helpers for accessing MSR bitmap that don't rely on o=
ffsets
>       KVM: SVM: Implement and adopt VMX style MSR intercepts APIs
>       KVM: SVM: Pass through GHCB MSR if and only if VM is an SEV-ES gues=
t
>       KVM: SVM: Drop "always" flag from list of possible passthrough MSRs
>       KVM: x86: Move definition of X2APIC_MSR() to lapic.h
>       KVM: VMX: Manually recalc all MSR intercepts on userspace MSR filte=
r change
>       KVM: SVM: Manually recalc all MSR intercepts on userspace MSR filte=
r change
>       KVM: x86: Rename msr_filter_changed() =3D> recalc_msr_intercepts()
>       KVM: SVM: Rename init_vmcb_after_set_cpuid() to make it intercepts =
specific
>       KVM: SVM: Fold svm_vcpu_init_msrpm() into its sole caller
>       KVM: SVM: Merge "after set CPUID" intercept recalc helpers
>       KVM: SVM: Drop explicit check on MSRPM offset when emulating SEV-ES=
 accesses
>       KVM: SVM: Move svm_msrpm_offset() to nested.c
>       KVM: SVM: Store MSRPM pointer as "void *" instead of "u32 *"
>       KVM: nSVM: Access MSRPM in 4-byte chunks only for merging L0 and L1=
 bitmaps
>       KVM: SVM: Return -EINVAL instead of MSR_INVALID to signal out-of-ra=
nge MSR
>       KVM: nSVM: Merge MSRPM in 64-bit chunks on 64-bit kernels
>       KVM: SVM: Add a helper to allocate and initialize permissions bitma=
ps
>       KVM: x86: Simplify userspace filter logic when disabling MSR interc=
eption
>       KVM: selftests: Verify KVM disable interception (for userspace) on =
filter change
>       KVM: x86: Drop pending_smi vs. INIT_RECEIVED check when setting MP_=
STATE
>       KVM: x86: WARN and reject KVM_RUN if vCPU's MP_STATE is SIPI_RECEIV=
ED
>       KVM: x86: Move INIT_RECEIVED vs. INIT/SIPI blocked check to KVM_RUN
>       KVM: x86: Refactor handling of SIPI_RECEIVED when setting MP_STATE
>       KVM: VMX: Add a macro to track which DEBUGCTL bits are host-owned
>       KVM: selftests: Expand set of APIs for pinning tasks to a single CP=
U
>       KVM: selftests: Convert arch_timer tests to common helpers to pin t=
ask
>
> Xin Li (1):
>       KVM: x86: Advertise support for LKGS
>
>  Documentation/virt/kvm/api.rst                     |  25 +-
>  arch/x86/include/asm/kvm-x86-ops.h                 |   3 +-
>  arch/x86/include/asm/kvm_host.h                    |  22 +-
>  arch/x86/include/asm/msr-index.h                   |   1 +
>  arch/x86/kvm/cpuid.c                               |   1 +
>  arch/x86/kvm/lapic.h                               |   2 +
>  arch/x86/kvm/svm/nested.c                          | 128 ++++--
>  arch/x86/kvm/svm/sev.c                             |  33 +-
>  arch/x86/kvm/svm/svm.c                             | 500 +++++++--------=
------
>  arch/x86/kvm/svm/svm.h                             | 104 ++++-
>  arch/x86/kvm/vmx/common.h                          |   2 -
>  arch/x86/kvm/vmx/main.c                            |  23 +-
>  arch/x86/kvm/vmx/nested.c                          |  27 +-
>  arch/x86/kvm/vmx/pmu_intel.c                       |   8 +-
>  arch/x86/kvm/vmx/tdx.c                             |  24 +-
>  arch/x86/kvm/vmx/vmx.c                             | 284 ++++--------
>  arch/x86/kvm/vmx/vmx.h                             |  61 ++-
>  arch/x86/kvm/vmx/x86_ops.h                         |   6 +-
>  arch/x86/kvm/x86.c                                 | 106 +++--
>  arch/x86/kvm/x86.h                                 |  18 +-
>  include/uapi/linux/kvm.h                           |   1 +
>  tools/include/uapi/linux/kvm.h                     |   1 +
>  tools/testing/selftests/kvm/Makefile.kvm           |   1 +
>  tools/testing/selftests/kvm/arch_timer.c           |   7 +-
>  .../selftests/kvm/arm64/arch_timer_edge_cases.c    |  23 +-
>  tools/testing/selftests/kvm/include/kvm_util.h     |  31 +-
>  tools/testing/selftests/kvm/lib/kvm_util.c         |  15 +-
>  tools/testing/selftests/kvm/lib/memstress.c        |   2 +-
>  tools/testing/selftests/kvm/x86/aperfmperf_test.c  | 213 +++++++++
>  .../selftests/kvm/x86/userspace_msr_exit_test.c    |   8 +
>  30 files changed, 930 insertions(+), 750 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86/aperfmperf_test.c
>


