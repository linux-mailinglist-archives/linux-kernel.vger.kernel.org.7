Return-Path: <linux-kernel+bounces-869506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A265EC08080
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9271C3A6934
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3AA2F0C79;
	Fri, 24 Oct 2025 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WF7LjC75"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8AC2BEC2D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337322; cv=none; b=IyFOoChc2WELyBw06j0HmwQ64XuyXi5N/s6wlj0b1Q3pzCXaGjBfGTcievO/mHKDW1wIndDaEI+twqBdkZmgnst2rubCCQ3xyajjyj4DeXeUtQVMtHp8SGbBtTz9Sh5Dp7zLO2P15tJj95NDUjiiTO08Bv81A9ovTlk3+/GAOFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337322; c=relaxed/simple;
	bh=HY8nu1msWSv3vWsJlzaBnXdb3YfJe10Pi+fsj+Y2l9Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KutFj1SL4BPMJQ4QyqV3DFffcXjyU2gwb0ushyGbdnbjUwyDwz6qhc1D3tq430HQ+trRwYICb1G4AF+RlDWxpfIjMIdmwMindyUcAmuIodoUMMbfUzK3m0t7mGU/jSHw9sSjeOXdu1QR9ArmBE3rf7qVH+6s90C9y1d+Qv4n/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WF7LjC75; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so1930899a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761337319; x=1761942119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zHb6xopGDOUshixziaB00gh3wd9KLy6Lm4iKOPdoOQ=;
        b=WF7LjC75SoJmh4K72LWIgGjuN8o9UG3MBUiR7pPfapIAqsCHRwrDZ2itfQA2+x911m
         V0qR38M7aRYasgASja9VVew/R/E4f+wtL+mHJCWOgjGc6zTWr6XAas0b/3sFxI7cLU+o
         y8QlnHJEi1SrIMkgHuNL9mb2tHDLYooQnqVQetm3Qjk2Ujvm4Rgx9eskGckpPqJSAZOc
         BKokRErN+QVGyMfsnfhfG/uBAMBznnx118arW8KjllcgCLFaEtHruWO690bG2MhCCI50
         AXuiKw1hCYzQf9h3SaYLAKlzFK4s2/UL1zbLIILgBH3NjMAzJTFNY/UNMRU0p6HQXOw4
         U6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337319; x=1761942119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zHb6xopGDOUshixziaB00gh3wd9KLy6Lm4iKOPdoOQ=;
        b=RnMrIe04iELnXSCR87G5kgsNOuBrOWplcjQfbaKnSPsXTme0tR+zXSOG2JG4wml0Ek
         bowDRgaPYL3clFiklqimCKYmsCs6CImC6PdI/8fCQdMiF89RoB0mHa5ove5x3iRDiApw
         Chcui9ixZvyPmY5UC5ZviajUB2WtvcfWk0q4Cm10lPHkrt/M0eJjXLY9W6Yc8REOFZGu
         fP1aOtCRXu7pqL0DZ6TOdcxy+/PVikrU9o3q6OGmuAigSUl7/97S4gpI94tC27DyQWXV
         E03JEcwIYXbm8Nhxkkz2Fg1zqGpldgnRYxwnNK4UDjSzqsKFOsgvFJFT1KTfD95rAPbJ
         9tGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfOJRWTjqroTURbG0690LXtOkxuIHr1hXvm4aFlegVv+n8RVN9NZZUciCkn/RwzSr0pjKNuyfeDZUPilk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/ZNmHlumIYhigEDOE5k0TZvRuCJaIAejDo3PviVDdQ9SIHao
	MIT3s8I5HJ7DcOkbcBDkSldxeKInNdzBKBGyhK34H31bMaWyAvX4EyFjhnHuFoe+em8w5+IUCRT
	FVcn+Uw==
X-Google-Smtp-Source: AGHT+IHmB/qAZY3JsYu7ONzAV1pNq7phirOTwfp9G6z952oHz03ayW0CdVlMOUoKTMDG6oVTUHYpNDRc+9w=
X-Received: from pjbrs15.prod.google.com ([2002:a17:90b:2b8f:b0:33b:51fe:1a73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e43:b0:339:cece:a99
 with SMTP id 98e67ed59e1d1-33bcf86c699mr42532689a91.13.1761337319524; Fri, 24
 Oct 2025 13:21:59 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:21:57 -0700
In-Reply-To: <B116CE75-43FD-41C4-BB3A-9B0A52FFD06B@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918162529.640943-1-jon@nutanix.com> <aNHE0U3qxEOniXqO@google.com>
 <7F944F65-4473-440A-9A2C-235C88672E36@nutanix.com> <B116CE75-43FD-41C4-BB3A-9B0A52FFD06B@nutanix.com>
Message-ID: <aPvf5Y7qjewSVCom@google.com>
Subject: Re: [PATCH] KVM: x86: skip userspace IOAPIC EOI exit when Directed
 EOI is enabled
From: Sean Christopherson <seanjc@google.com>
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: Jon Kohler <jon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 03, 2025, Khushit Shah wrote:
> Hi Sean,
> 
> Any updates on this?

Sorry, fell into the classic pattern of "I'll do that one tomorrow...".

> I suggest adding a new KVM capability that disables advertising support for EOI
> broadcast suppression when using split-irqchip. It is similar in spirit to
> KVM_CAP_X2APIC_API for x2APIC quirks.
> 
> By default, we still assume the userspace I/O APIC implements the EOI register.
> If it does not, userspace can set a flag before vCPU creation (after selecting
> split-irqchip mode) to disable EOI broadcast suppression. This should be a
> per-VM flag, as all APICs will share the same behavior. I am sharing a
> preliminary diff for discussion. The earlier fix can sit on top of this. This just 
> allows disabling EOI broadcast suppression under split-irqchip.
> 
> What are your thoughts on this? If this seems reasonable, I can send a proper
> patch.

Make it a quirk instead of a capability.  This is definitely a KVM bug, it's just
unfortunately one that we can't fix without breaking userspace :-/

And I'm pretty sure we want to quirk the exit to userspace, not the enumeration
of and support for the feature, e.g. so that an updated userspace VMM can disable
the quirk on a live update/migration and take advantage of the fanciness without
having to wait for guests to reboot.

Can you also start with the below changelog+comment?  I massaged  in anticipation
of applying v1 before I realized it would break userespace :-)

E.g. with the quirk stubbed in (obviously not tested in any capacity):

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
 arch/x86/kvm/lapic.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 5fc437341e03..56542239cc6b 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1429,6 +1429,17 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
 
 	/* Request a KVM exit to inform the userspace IOAPIC. */
 	if (irqchip_split(apic->vcpu->kvm)) {
+		/*
+		 * Don't exit to userspace if the guest has enabled Directed
+		 * EOI, a.k.a. Suppress EOI Broadcasts, in which case the local
+		 * APIC doesn't broadcast EOIs (the the guest must EOI the
+		 * target I/O APIC(s) directly).
+		 */
+		if ((kvm_lapic_get_reg(apic, APIC_SPIV) & APIC_SPIV_DIRECTED_EOI) &&
+		    !kvm_check_has_quirk(vcpu->kvm,
+					 KVM_X86_QUIRK_IGNORE_SUPPRESS_EOI_BROADCAST))
+			return;
+
 		apic->vcpu->arch.pending_ioapic_eoi = vector;
 		kvm_make_request(KVM_REQ_IOAPIC_EOI_EXIT, apic->vcpu);
 		return;

base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
-- 

