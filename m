Return-Path: <linux-kernel+bounces-880687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 391ADC2657B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2D2F344EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078FB307AD0;
	Fri, 31 Oct 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4hjv6wSb"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239852F3607
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931687; cv=none; b=JRPpBxZsSNuysivgmAti77ASMkaAwKbpieYw7f+ECBijK2ehVGMYmISso7EnSDp84zrb6fPI8KpNtV/rjIvHe3x/RZtsldRCYnkYIDFE7GZYxlUtjbwte7DRAOHs4+uBZu8igX21pHkzsotQeTd2UQyrSjgz3B+GODDhmqqbKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931687; c=relaxed/simple;
	bh=aVXM5VmJ7KRJ9XBYs6HkDlmG7/9RjEQQZI9u3MndFkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JaejUg9yRFkCFnvkVjqvnns1V6YlmmGURBUZGyeKKEa9Kg8KQ6gso2IItLMru6cjjnLqBbI69YSZ/jLUFLsGbS2TYrS4ixPBzJ6zBaZZgLMsqpD6S5f8N7TZhmMp4UV8/ogU919G2NSw2MdFTcZggKDYmm7GZ13zrA6mGsc1O5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4hjv6wSb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290c9724deeso25455705ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761931683; x=1762536483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2qAn1JAbAvTAO3XPUTs6m584JRhgVGKTKcn9QMrIKU=;
        b=4hjv6wSbgLp0mGNWQ8roeIMw/MmW45PSptQ+5mXlwq0y9kifWk3Ut7GMEF+nOgJlj3
         8pUSlppdbfvFftVGdlNRXGZjX/k/UKNau3TvMPETF91mstuXSl+Zkw7rlEiLxZVKYhhC
         aL7UCSBgTzVTuiKovysyaixEalFBWi9lFrmEIkPmpwxSI9Q1BBjkQjca6SsN/uOEI2XJ
         Xloz7M9a9zJzRJhhveAN8f8XZ/kudav65d4ZKyh3UnETeBX3TWvfRb2z7BHCTCaNh79P
         LPfXM57NVCHt9xe0sSoesu6Aj/qBk5t6KbtJLDWfzSLuoh+lNibObG8wjzf2Pe2xTBJ7
         SdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761931683; x=1762536483;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f2qAn1JAbAvTAO3XPUTs6m584JRhgVGKTKcn9QMrIKU=;
        b=tn5EbiiCsccvp536UzB6SZBdwmvlXpS2dPJNnKfBr5Xtcq5d0GTb8qvZoWVOA8qViG
         xvIel/rF+H4nVcOrAfKlRXIDPsemWOTN5tx9JWJXGp8fpLiO4pdFYJV3RIFbdkuKPBeu
         55gYMQW/0r5NxyIkVJUxIuHfkPDMJmRwWd27NgwXwfq35lAFZMUzpnhCyx/aq+iMVDex
         X9NNkPxciJERu1BGrtcVcC+7cbHmRTkk1bvPb0GBllof+65BSde8Rs6/gTU0BicmDxf4
         FNstEr23XVfWMm8RpQT+AUvy6mvQqK7grtN0XMnw0sArqXBog+YK45leOh2oy5xcYzVG
         VO1w==
X-Forwarded-Encrypted: i=1; AJvYcCVhy4M61rQW53qmXqgeEppokaRxCwzvWPvajzHDrxj9g3MUwAmIzJrOEIuPMztgN4h1xUhoB/9agZD7zAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQlYe22SlL2yOgAg0EuhiFHmnSvhz/lbuhMN4t5Ux0BjFzl2B
	fJHE7QI8A3zc4Ii50W1E4Koy8BqAeGjfxrrFp4cy3ugLvJXetqQZjPflU+NIeXayF8wYmPapUcn
	IV37Epg==
X-Google-Smtp-Source: AGHT+IG4WheSuTjAfSc3EnUDPS2pz/ETCad4B0Sop/vJQl15RM/WsGCuUE1aZUEbgQvuzoEUmlmmvCdPedw=
X-Received: from pjbci9.prod.google.com ([2002:a17:90a:fc89:b0:32f:46d:993b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da87:b0:294:ccc6:cd30
 with SMTP id d9443c01a7336-2951a3851a6mr53377555ad.17.1761931683240; Fri, 31
 Oct 2025 10:28:03 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:28:01 -0700
In-Reply-To: <EFA9296F-14F7-4D78-9B7C-1D258FF0A97A@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918162529.640943-1-jon@nutanix.com> <aNHE0U3qxEOniXqO@google.com>
 <7F944F65-4473-440A-9A2C-235C88672E36@nutanix.com> <B116CE75-43FD-41C4-BB3A-9B0A52FFD06B@nutanix.com>
 <aPvf5Y7qjewSVCom@google.com> <EFA9296F-14F7-4D78-9B7C-1D258FF0A97A@nutanix.com>
Message-ID: <aQTxoX4lB_XtZM-w@google.com>
Subject: Re: [PATCH] KVM: x86: skip userspace IOAPIC EOI exit when Directed
 EOI is enabled
From: Sean Christopherson <seanjc@google.com>
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: Jon Kohler <jon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025, Khushit Shah wrote:
> Hi Sean,
>=20
> Thanks for the reply.
>=20
> > On 25 Oct 2025, at 1:51=E2=80=AFAM, Sean Christopherson <seanjc@google.=
com> wrote:
> >=20
> > Make it a quirk instead of a capability.  This is definitely a KVM bug,=
 it's just
> > unfortunately one that we can't fix without breaking userspace :-/
>=20
> I don=E2=80=99t think this approach fully addresses the issue.
>=20
> For example, consider the same Windows guest running with a userspace
> I/O APIC that has no EOI registers. The guest will set the Suppress EOI
> Broadcast bit because KVM advertises support for it (see=20
> kvm_apic_set_version).
>=20
> If the quirk is enabled, an interrupt storm will occur.
> If the quirk is disabled, userspace will never receive the EOI
> notification.

Uh, why not?

> For context, Windows with CG the interrupt in the following order:
>   1. Interrupt for L2 arrives.
>   2. L1 APIC EOIs the interrupt.
>   3. L1 resumes L2 and injects the interrupt.
>   4. L2 EOIs after servicing.
>   5. L1 performs the I/O APIC EOI.

And at #5, the MMIO access to the I/O APIC gets routed to userspace for emu=
lation.

> Guest is not doing anything theoretically wrong here.=20
>=20
> The root issue is that KVM advertises support for EOI broadcast
> suppression without knowing whether userspace supports it.

That's the whole point of the quirk; userspace should disable the quirk if =
and
only if it supports the I/O APIC EOI extension.

> Even my previous proposal doesn=E2=80=99t completely solve this. A potent=
ial
> way to fix it without breaking userspace would be to let userspace
> explicitly indicate whether it supports EOI broadcast suppression
> (i.e. whether it implements EOI registers). By default, KVM should
> assume userspace does *not* support EOI broadcast suppression,
> contrary to the current behavior.

But as I mentioned in my previous reply, that requires a guest reboot to ta=
ke
affect.

> This way, unmodified userspace remains unaffected,

Not entirely, no.  If you strictly scope "userspace" to mean the VMM code, =
then
yes, that statement is true.  But changing the virtual CPU model that is pr=
esented
to the guest is absolutely going to affect userspace, in the sense that a g=
uest
will see what appears to be different CPUs=20

> and updated userspace can opt in when it truly supports EOI broadcast
> suppression.
>=20
> Am I missing something?

I think so?  It's also possible I'm missing something :-)

And all of the above said, I'm not at all opposed to giving userspace contr=
ol
over whether or not Suppress EOI Broadcast is advertised to the guest.  Qui=
te
the opposite actually.  It's just that I also want to provide a fix that al=
lows
for fixing the worst of the issue without needing a guest reboot, and witho=
ut
having to change the virtual CPU model that's exposed to the guest.

So, what if we do both?  And to avoid spreading the damage all over the pla=
ce,
use KVM_CAP_X2APIC_API?  Compile tested only...

From: Khushit Shah <khushit.shah@nutanix.com>
Date: Fri, 31 Oct 2025 09:25:59 -0700
Subject: [PATCH] KVM: x86: Add x2APIC "features" to control EOI broadcast
 suppression

Add two flags for KVM_CAP_X2APIC_API to allow userspace to control support
for Suppress EOI Broadcasts, which KVM completely mishandles.  When x2APIC
support was first added, KVM incorrectly advertised and "enabled" Suppress
EOI Broadcast, without fully supporting the I/O APIC side of the equation,
i.e. without adding directed EOI to KVM's in-kernel I/O APIC.

That flaw was carried over to split IRQCHIP support, i.e. KVM advertised
support for Suppress EOI Broadcasts irrespective of whether or not the
userspace I/O APIC implementation supported directed EOIs.  Even worse,
KVM didn't actually suppress EOI broadcasts, i.e. userspace VMMs without
support for directed EOI came to rely on the "spurious" broadcasts.

KVM "fixed" the in-kernel I/O APIC implementation by completely disabling
support for Supress EOI Broadcasts in commit 0bcc3fb95b97 ("KVM: lapic:
stop advertising DIRECTED_EOI when in-kernel IOAPIC is in use"), but
didn't do anything to remedy userspace I/O APIC implementations.

KVM's bogus handling of Supress EOI Broad is problematic when the guest
relies on interrupts being masked in the I/O APIC until well after the
initial local APIC EOI.  E.g. Windows with Credential Guard enabled
handles interrupts in the following order:

 the interrupt in the following order:
  1. Interrupt for L2 arrives.
  2. L1 APIC EOIs the interrupt.
  3. L1 resumes L2 and injects the interrupt.
  4. L2 EOIs after servicing.
  5. L1 performs the I/O APIC EOI.

Because KVM EOIs the I/O APIC at step #2, the guest can get an interrupt
storm, e.g. if the IRQ line is still asserted and userspace reacts to the
EOI by re-injecting the IRQ, because the guest doesn't de-assert the line
until step #4, and doesn't expect the interrupt to be re-enabled until
step #5.

Unfortunately, simply "fixing" the bug isn't an option, as KVM has no way
of knowing if the userspace I/O APIC supports directed EOIs, i.e.
suppressing EOI broadcasts would result in interrupts being stuck masked
in the userspace I/O APIC due to step #5 being ignored by userspace.  And
fully disabling support for Suppress EOI Broadcast is also undesirable, as
picking up the fix would require a guest reboot, *and* more importantly
would change the virtual CPU model exposed to the guest without any buy-in
from userspace.

Add two flags to allow userspace to choose exactly how to solve the
immediate issue, and in the long term to allow userspace to control the
virtual CPU model that is exposed to the guest (KVM should never have
enabled supported for Supress EOI Broadcast without a userspace opt-in).

Note, Suppress EOI Broadcasts is defined only in Intel's SDM, not in AMD's
APM.  But the bit is writable on some AMD CPUs, e.g. Turin, and KVM's ABI
is to support Directed EOI (KVM's name) irrespective of guest CPU vendor.

Fixes: 7543a635aa09 ("KVM: x86: Add KVM exit for IOAPIC EOIs")
Closes: https://lore.kernel.org/kvm/7D497EF1-607D-4D37-98E7-DAF95F099342@nu=
tanix.com
Cc: stable@vger.kernel.org
Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst  | 14 ++++++++++++--
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/include/uapi/asm/kvm.h |  6 ++++--
 arch/x86/kvm/lapic.c            | 13 +++++++++++++
 arch/x86/kvm/x86.c              | 11 ++++++++---
 5 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rs=
t
index 57061fa29e6a..4bfd4ed6afa4 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7800,8 +7800,10 @@ Will return -EBUSY if a VCPU has already been create=
d.
=20
 Valid feature flags in args[0] are::
=20
-  #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
-  #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
+  #define KVM_X2APIC_API_USE_32BIT_IDS                    (1ULL << 0)
+  #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK          (1ULL << 1)
+  #define KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST_QUIRK (1ULL << 2)
+  #define KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST       (1ULL << 3)
=20
 Enabling KVM_X2APIC_API_USE_32BIT_IDS changes the behavior of
 KVM_SET_GSI_ROUTING, KVM_SIGNAL_MSI, KVM_SET_LAPIC, and KVM_GET_LAPIC,
@@ -7814,6 +7816,14 @@ as a broadcast even in x2APIC mode in order to suppo=
rt physical x2APIC
 without interrupt remapping.  This is undesirable in logical mode,
 where 0xff represents CPUs 0-7 in cluster 0.
=20
+Setting KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST_QUIRK overrides KVM's qu=
irky
+behavior of not actually suppressing EOI broadcasts for split IRQ chips wh=
en
+support for Suppress EOI Broadcasts is advertised to the guest.
+
+Setting KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST disables support for Sup=
press
+EOI Broadcasts entirely, i.e. instructs KVM to NOT advertise support to th=
e
+guest and thus disallow enabling EOI broadcast suppression in SPIV.
+
 7.8 KVM_CAP_S390_USER_INSTR0
 ----------------------------
=20
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 48598d017d6f..fdf4f99de630 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1480,6 +1480,8 @@ struct kvm_arch {
=20
 	bool x2apic_format;
 	bool x2apic_broadcast_quirk_disabled;
+	bool disable_suppress_eoi_broadcast_quirk;
+	bool x2apic_disable_suppress_eoi_broadcast;
=20
 	bool has_mapped_host_mmio;
 	bool guest_can_read_msr_platform_info;
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kv=
m.h
index d420c9c066d4..955b854b4b82 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -913,8 +913,10 @@ struct kvm_sev_snp_launch_finish {
 	__u64 pad1[4];
 };
=20
-#define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
-#define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
+#define KVM_X2APIC_API_USE_32BIT_IDS            	(1ULL << 0)
+#define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  	(1ULL << 1)
+#define KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST_QUIRK	(1ULL << 2)
+#define KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST	(1ULL << 3)
=20
 struct kvm_hyperv_eventfd {
 	__u32 conn_id;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0ae7f913d782..f83abbcf136f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -562,6 +562,7 @@ void kvm_apic_set_version(struct kvm_vcpu *vcpu)
 	 * IOAPIC.
 	 */
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_X2APIC) &&
+	    !vcpu->kvm->arch.x2apic_disable_suppress_eoi_broadcast &&
 	    !ioapic_in_kernel(vcpu->kvm))
 		v |=3D APIC_LVR_DIRECTED_EOI;
 	kvm_lapic_set_reg(apic, APIC_LVR, v);
@@ -1517,6 +1518,18 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *ap=
ic, int vector)
=20
 	/* Request a KVM exit to inform the userspace IOAPIC. */
 	if (irqchip_split(apic->vcpu->kvm)) {
+		/*
+		 * Don't exit to userspace if the guest has enabled Directed
+		 * EOI, a.k.a. Suppress EOI Broadcasts, in which case the local
+		 * APIC doesn't broadcast EOIs (the guest must EOI the target
+		 * I/O APIC(s) directly).  Ignore the suppression if userspace
+		 * has NOT disabled KVM's quirk (KVM advertised support for
+		 * Suppress EOI Broadcasts without actually suppressing EOIs).
+		 */
+		if ((kvm_lapic_get_reg(apic, APIC_SPIV) & APIC_SPIV_DIRECTED_EOI) &&
+		    apic->vcpu->kvm->arch.disable_suppress_eoi_broadcast_quirk)
+			return;
+
 		apic->vcpu->arch.pending_ioapic_eoi =3D vector;
 		kvm_make_request(KVM_REQ_IOAPIC_EOI_EXIT, apic->vcpu);
 		return;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b4b5d2d09634..b82840104c53 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -121,8 +121,10 @@ static u64 __read_mostly efer_reserved_bits =3D ~((u64=
)EFER_SCE);
=20
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
=20
-#define KVM_X2APIC_API_VALID_FLAGS (KVM_X2APIC_API_USE_32BIT_IDS | \
-                                    KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK=
)
+#define KVM_X2APIC_API_VALID_FLAGS (KVM_X2APIC_API_USE_32BIT_IDS | 			\
+                                    KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK=
 |		\
+				    KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST_QUIRK |	\
+				    KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
=20
 static void update_cr8_intercept(struct kvm_vcpu *vcpu);
 static void process_nmi(struct kvm_vcpu *vcpu);
@@ -6783,7 +6785,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			kvm->arch.x2apic_format =3D true;
 		if (cap->args[0] & KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK)
 			kvm->arch.x2apic_broadcast_quirk_disabled =3D true;
-
+		if (cap->args[0] & KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST_QUIRK)
+			kvm->arch.disable_suppress_eoi_broadcast_quirk =3D true;
+		if (cap->args[0] & KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
+			kvm->arch.x2apic_disable_suppress_eoi_broadcast =3D true;
 		r =3D 0;
 		break;
 	case KVM_CAP_X86_DISABLE_EXITS:

base-commit: 4361f5aa8bfcecbab3fc8db987482b9e08115a6a
--

