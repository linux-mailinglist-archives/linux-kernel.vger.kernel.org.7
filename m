Return-Path: <linux-kernel+bounces-827909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2347AB93670
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E66441C28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392D2F6166;
	Mon, 22 Sep 2025 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvmpTMs9"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801E287276
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577879; cv=none; b=YdeymQZ061a5Sxl2mkie72YQa0sYQre5qr59R6OZVRK9D776oQAxYhvh/XCTec7i1mgpQNGPa78daBP+W3DgT6bgtMTbVECCzTohqf+Dq6+g7BO3fvNa6X7KCknx9N69cQtDF8KZL+Hv3tw+Xh5m9gvHVzTOSvzgHEzvFG6Ga7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577879; c=relaxed/simple;
	bh=4gTCxkmFt7LbJAKduGir9q8RFZ8lBqIzBigYw0KLi0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sfvVdxEsgryygts4tLoxJzx0bBLSBNX34mKqisaQ6FNpUap/p3vSSjFGP3GRTrD3WsB3LngublgcMIg0LndysfhF6uTHmFdX407Q4G2IiiBVdS/Nmd1DmJ+y1aPg2vXlENTjKJO3r2RxrxTIjCXSwICdVVryI//k8pyQyEtBazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vvmpTMs9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c4aso4595866a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758577875; x=1759182675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ89xwcUbdPfzaNC8pLCecb224L4f7AvU3SVssm464k=;
        b=vvmpTMs9gx03PX3XjdV5g1G+VWIdNT1tjxJz8tmT1qh66vcz4MweEhuUJ+lm9tt/9d
         qdCDih+Th8mniYOoB25QwRPewyV+gGxNk7gMyvO/jOuRAMqF5eHJjnyTkeCsFU9letic
         JaPyEhHVuA7IzGtx8lYdxnT/NDeHB4kmQLFRf678i2A1P6DnDnIf4QEuXmILpjoI28yZ
         wJKsTgxtzV2lEx7mf5g8yaSUykTpWWMPmTYmSZSGs3P7b0NB71f7KyICQuDhbwhWBJNd
         AyXxt68jPzcnvbU/k67BkIcGAu+p0GJRebm/Rjls2VPStbRv2kcE9lFA40KN+klEXXAQ
         VKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577875; x=1759182675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ89xwcUbdPfzaNC8pLCecb224L4f7AvU3SVssm464k=;
        b=AXM+DQe03sRUl8CVbAZPqgZnIg3/fXU4CD4Wg3BQdChSCp78HuVnGYkwnmWZgVijhF
         pdsqNG0RzFQKjKJHDHjoYepKSk/iIEkLmPfFl25sxb1Ulmlnx18Xv1bPJOndVDIwNwhG
         x1veTrMvwPp3LpeZlRHACF2HtTJEKXDlGPnoBunB1PmeUp29sEoz9kVs6lrkqZFzp+6V
         yY8YnIBZ+BYeMCGIPjCzloJT5b7Gjaz9HTGPgbV5V2PMd1UzM0gOV33rzH2SY0arY9hA
         uKBqjCbSAredG1sZDq1NKvplsWUzSl2KUuLLGs82IdRma44WPi1NL8L4eGbBC8QfGVrF
         V9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRYyM7JunoF6+Iz+oj5cymc4w0A2sC/w3wiqBgze4YQ73icyiuA9xDKEGV+L/9ORbf+uOP6k8LDQl959c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQPNBzhv1avdU2gt7W06w9WCY3Jy+2kn0IbpyMrwlUGFFdJWN
	EfJaDvV17xswbZDxoZogSmEFULcG0Qb5bOLvimnrYg4NIc1XhZNA6EtPic17z50FVMtmcE6cnZw
	nJzfu4Q==
X-Google-Smtp-Source: AGHT+IHsV39PUiM8jSMXJ1TFDCv7QgcTSMXBPnSyUL+WNYqfnqN++rRnXbYTiLp3Hl+CdJgodqXHnVoKFpU=
X-Received: from pjff6.prod.google.com ([2002:a17:90b:5626:b0:329:7dfc:f4e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a42:b0:32d:d408:e86
 with SMTP id 98e67ed59e1d1-332a94f5f80mr552161a91.7.1758577875232; Mon, 22
 Sep 2025 14:51:15 -0700 (PDT)
Date: Mon, 22 Sep 2025 14:51:13 -0700
In-Reply-To: <20250918162529.640943-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918162529.640943-1-jon@nutanix.com>
Message-ID: <aNHE0U3qxEOniXqO@google.com>
Subject: Re: [PATCH] KVM: x86: skip userspace IOAPIC EOI exit when Directed
 EOI is enabled
From: Sean Christopherson <seanjc@google.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Khushit Shah <khushit.shah@nutanix.com>
Content-Type: text/plain; charset="us-ascii"

It'd be super helpful for downstream folks to mention "split IRQCHIP" somewhere
in the shortlog, e.g.

  KVM: x86: Suppress EOI broadcasts with split IRQCHIP if Directed EOI is enabled

On Thu, Sep 18, 2025, Jon Kohler wrote:
> From: Khushit Shah <khushit.shah@nutanix.com>
> 
> Problem:

Please read Documentation/process/maintainer-kvm-x86.rst.  I'll die on the hill
that leading with a problem statement results in a less efficient changelog.

And nowhere in the changelog does it state what change is actually being made.
The shortlog calls it out, but the shortlog isn't always visible, e.g. when
reviewing the initial patch email.

> We observed Windows w/ HyperV getting stuck during boot because of

No "we".  Over time, who "we" is can become unclear.

> level triggered interrupt storm. This is because KVM currently
> does not respect Directed EOI bit set by guest in split-irqchip
> mode.
>
> We observed the following ACTUAL sequence on Windows guests with

Uber nit, generally speaking, use asterisks or underscores to emphasive a word.
Using all caps suggests there is special meaning to the word, e.g. that it's an
acronym or something.  I am guilty of using ALL CAPS, but I'm pretty sure only
for "do NOT", where I think/hope the intent is clear.  For whatever reason, I
kept doing double-takes when reading this sentence.

Though to be honest, I would omit the whole "actual" part.  There's an assumption
that everyone is acting in good faith, i.e. that contributors aren't fabricating
a bug report or making things up.

> Directed EOI enabled:
>   1. Guest issues an APIC EOI.
>   2. The interrupt is injected into L2 and serviced.
>   3. Guest issues an IOAPIC EOI.
> 
> But, with the current behavior in split-irqchip mode:
>   1. Guest issues an APIC EOI.
>   2. KVM exits to userspace and QEMU's ioapic_service reasserts the
>      interrupt because the line is not yet deasserted.
>   3. Steps 1 and 2 keeps looping, and hence no progress is made.
> (logs at the bug linked below).

Eh, for the logs, there's a bug report, just use Closes.  And honestly, I would
shorten all of the above.  This is a fairly straightforward bug, providing a
super detailed play-by-play actually makes it _harder_ to understand what's

> This is because in split-irqchip mode, KVM requests a userspace IOAPIC

Please don't use QEMU's terminology when describing KVM bugs.

> EOI exit on every APIC EOI.

This is wrong.  Every *intercepted* EOI, but not all EOIs are intercepted.

> However, if the guest sets the Directed EOI bit in the APIC Spurious
> Interrupt Vector Register (SPIV, bit 12), per the x2APIC specification,

There is no singular x2APIC specification.  x2APIC is defined by both Intel's SDM
and AMD's APM.  Usually the Intel and AMD specs are compatible, key word "usually".
Case in point, I can't find anything in the APM that suggests AMD CPUs support
"Suppress EOI Broadcasts".

Of course, that could just be an APM documentation bug, since the bit appears
writable on Turin (though not on Milan).

> the APIC does not broadcast EOIs to the IOAPIC.  In this case, it is the
> guest's responsibility to explicitly EOI the IOAPIC by writing to its EOI
> register.
> 
> kernel-irqchip mode already handles this similarly in
> kvm_ioapic_update_eoi_one().

Hmm, I'm pretty sure that's dead code since commit 0bcc3fb95b97 ("KVM: lapic: stop
advertising DIRECTED_EOI when in-kernel IOAPIC is in use").

And Fudge with a capital 'F', because I'm pretty sure we're going to need at least
a new CAP, and probably a quirk too.

As per the aforementioned commit, advertising DIRECTED_EOI without an I/O APIC
that emulates the EOI register will make for a very sad guest.  So simply fixing
KVM will break existing setups, even though it's unequivocally the correct behavior.
And unfortunately, I _know_ there is at least one VMM in production that doesn't
support EOIs in the I/O APIC.

> Link: https://lore.kernel.org/kvm/7D497EF1-607D-4D37-98E7-DAF95F099342@nutanix.com/

As above, this should be Closes, not Link.

  Closes: https://lore.kernel.org/kvm/7D497EF1-607D-4D37-98E7-DAF95F099342@nutanix.com

This also needs:

  Fixes: 7543a635aa09 ("KVM: x86: Add KVM exit for IOAPIC EOIs")
  Cc: stable@vger.kernel.org

> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  arch/x86/kvm/lapic.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 0725d2cae742..a81e71ad5bda 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1473,6 +1473,10 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
>  
>  	/* Request a KVM exit to inform the userspace IOAPIC. */
>  	if (irqchip_split(apic->vcpu->kvm)) {
> +		/* EOI the ioapic only if the Directed EOI is disabled. */

Capitalize I/O APIC (ugh, the above uses IOAPIC, and further above uses ioapic).
I'd just avoid mentioning I/O APIC at this point, it should be super obvious
what's happening.

"the Directed EOI" doesn't parse.  Directed EOI is a feature, not a "thing".

"the ioapic" is also wrong in the sense that KVM has no idea how many I/O APICs
are being emulated by userspace.  Could be 1, could be 0 or 2.

Don't bother sending a v2, at least not yet.  I'll follow-up with various folks
to try and figure out the least awful way to get out of this mess, and will
probably post a v2 with a CAP and/or quirk.

In the meantime, I have the below sitting in a local branch:

--
From: Khushit Shah <khushit.shah@nutanix.com>
Date: Thu, 18 Sep 2025 09:25:28 -0700
Subject: [PATCH] KVM: x86: Suppress EOI broadcasts with split IRQCHIP if
 Directed EOI is enabled

Do not generate a KVM_EXIT_IOAPIC_EOI exit to userspace when handling EOIs
for a split IRQCHIP and the vCPU has enabled Directed EOIs in its local
APIC, i.e. if the guest has set "Suppress EOI Broadcasts" in Intel
parlance.

Incorrectly broadcasting EOIs can lead to a potentially fatal interrupt
storm if the IRQ line is still asserted and userspace reacts to the EOI by
re-injecting the IRQ.  E.g. Windows with Hyper-V enabled gets stuck during
boot when running under QEMU with a split IRQCHIP.

Note, Suppress EOI Broadcasts is defined only in Intel's SDM, not in AMD's
APM.  But the bit is writable on some AMD CPUs, e.g. Turin, and KVM's ABI
is to support Directed EOI (KVM's name) irrespective of guest CPU vendor.

Note #2, KVM doesn't support Directed EOIs for its in-kernel I/O APIC.
See commit 0bcc3fb95b97 ("KVM: lapic: stop advertising DIRECTED_EOI when
in-kernel IOAPIC is in use").

Fixes: 7543a635aa09 ("KVM: x86: Add KVM exit for IOAPIC EOIs")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/kvm/7D497EF1-607D-4D37-98E7-DAF95F099342@nutanix.com
Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
Link: https://lore.kernel.org/r/20250918162529.640943-1-jon@nutanix.com
[sean: rewrite changelog and comment]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 5fc437341e03..4d77112b887d 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1429,6 +1429,15 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
 
 	/* Request a KVM exit to inform the userspace IOAPIC. */
 	if (irqchip_split(apic->vcpu->kvm)) {
+		/*
+		 * Don't exit to userspace if the guest has enabled Directed
+		 * EOI, a.k.a. Suppress EOI Broadcasts, in which the local APIC
+		 * doesn't broadcast EOIs (the the guest must EOI the target
+		 * I/O APIC(s) directly).
+		 */
+		if (kvm_lapic_get_reg(apic, APIC_SPIV) & APIC_SPIV_DIRECTED_EOI)
+			return;
+
 		apic->vcpu->arch.pending_ioapic_eoi = vector;
 		kvm_make_request(KVM_REQ_IOAPIC_EOI_EXIT, apic->vcpu);
 		return;

base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
--

