Return-Path: <linux-kernel+bounces-701041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC44AE6FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 21:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7043E17BD79
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624232EA73E;
	Tue, 24 Jun 2025 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkDny5T1"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B72EA49F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794096; cv=none; b=Dz/bpqStFZVuMuJB+JNerusMADQj/H4kIO4G5FiyATDGljj7Nc05tfvqVlqkyCgGISEeRjyzstrPDR8eORTUO9Oos4DRv9Cr13xdc4iAcWW4i2b//ZLIp4wpJVwTmHtzmZ8inTX4VXUuW5tGpCJGJS+IUF8y+3U8owVkN8mEqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794096; c=relaxed/simple;
	bh=W9p5RNOwWK4ssw+w9Icf1zfU8LG1axNqXqJIcyLf8rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uVA/Ovg0kAKTeRe2RbTBV1PVMRfQ0Dk0ydSmrCJznWk+P2ZwTylqja6mZeWnB13TPaVHOchVw8WPF+ptJdE5IUy2eRuxehmSnqNXHKz6EI+xejioy0j4cuwloNNXm/12nK8iIe3cCiK1Ia+5+WtQGaHCf21fKsbYOb/nq8gc+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkDny5T1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b00e4358a34so3583987a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750794093; x=1751398893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aaVL2fuBIJO5Ef+1Bh7kERwUg+3qZZc0hFGc7zd55Fo=;
        b=qkDny5T1vLt1/bIQW8/jSrHOuL/V8OSDDXfoTKlHq77hrCMX2aMR1U/RJLHT15jWpq
         RXHjM4wGLNlRPHPNgkear2i3DGlULA1qO2BPyd2Vgt4mTvKq4d8iLftviXukePTJYtTw
         Ig2vgxHCQMyVe0fZ0xcJJvHuepkUmzX6uODNYcsFIp34eBBxI8bnatB47WSP+CNY7kCm
         3FQdplRHCcFPT8Q7esjPm5hZllrts4RnsGmssiVh46P665BhYDgLshIofiuQvGcxT8YG
         101tchpnHcQINKArIZ7RDtmm+aqsmyw51wuS2I/B29fmWL0LAszM8Ubl8U+4L19wAJ0v
         tWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794093; x=1751398893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aaVL2fuBIJO5Ef+1Bh7kERwUg+3qZZc0hFGc7zd55Fo=;
        b=pUnICUS3GTg5HC+UW1nA2ZQtcXaiYN52RDsek8Rml4V7V6U64crhku42PzRrh8rtj5
         1wxh9C1u0GsT+0Dbuhn4mV6IAWHNfFaj8ardL0zU+kSJ8Fc16ZwX2ORUySvzIYhSeO6C
         iSiRO9gCoqsykMZVrx4FfU1BhFCUjNZ37s4IkbBo8+IavXA/DG9QnL/pCjmnmy/lXufm
         UMFD6nXso8F0XLPdkzOEzBRR7+6uv6jQN1BPpGhbQ5pWY9nT600NaMt0CWJGHq3vH4Ak
         jr5dnMJgsZbHJcx71WQUfh6CPfRu5ANUGMYom5fSHPhxP9s4PgASLxuInbeS+KjU4nCc
         wQEw==
X-Forwarded-Encrypted: i=1; AJvYcCWyQ7s77oygz6O8V1clYpdr8cAEQgpm6YAsJLSi+pkT6EzFZxmVGvXUpZTpX4EwtEGzyI0lI2GM8uPza4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo04uaOuYXm9CHmy1+aH/v9MjIfOdW4VhbQ0fgyT2/NtMVunXr
	coWgbGzlCWHIdMly7kn0v7KWGigR/SftD4pULbOG6+rpZHUK42eHA2vCGhyqIkDCBK+UkuRHUh0
	L18hF7Q==
X-Google-Smtp-Source: AGHT+IHP9vOochqphY6FRyMUtnNwry/oUJ8HZ/RRTAcAwoVKCsmUWny7XjH7CX4MaTRoKG3ozmiT8bd7+Ro=
X-Received: from pjbcz13.prod.google.com ([2002:a17:90a:d44d:b0:311:d79d:e432])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cc6:b0:311:e8cc:4255
 with SMTP id 98e67ed59e1d1-315f26a123emr109300a91.31.1750794092933; Tue, 24
 Jun 2025 12:41:32 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:38:28 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <175079326267.521591.2714927527330062591.b4-ty@google.com>
Subject: Re: [PATCH v3 00/62] KVM: iommu: Overhaul device posted IRQs support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, Jun 11, 2025, Sean Christopherson wrote:
> TL;DR: Overhaul device posted interrupts in KVM and IOMMU, and AVIC in
>        general.
> 
> This applies on the series to add CONFIG_KVM_IOAPIC (and to kill irq_comm.c):
> 
>   https://lore.kernel.org/all/20250611213557.294358-1-seanjc@google.com
> 
> [...]

Applied to kvm-x86 irqs (except for patch 1, which is already in Linus' tree),
with minor massaging (comments and changelogs) to address feedback.

Note, in the branch, the arm64 vLPI is split quite far from the rest of the
series.  This is by design so that I can provide a stable branch/tag for arm64
if a conflict or dependency crops up, without the arm64 patch inheriting all of
the dependencies and prep work for the series at large.

[01/62] KVM: arm64: Explicitly treat routing entry type changes as changes
        (already in Linus' tree)
[02/62] KVM: arm64: WARN if unmapping a vLPI fails in any path
        https://github.com/kvm-x86/linux/commit/cd4178d19420
[03/62] KVM: Pass new routing entries and irqfd when updating IRTEs
        https://github.com/kvm-x86/linux/commit/cb210737675e
[04/62] KVM: SVM: Track per-vCPU IRTEs using kvm_kernel_irqfd structure
        https://github.com/kvm-x86/linux/commit/05c5e23657e1
[05/62] KVM: SVM: Delete IRTE link from previous vCPU before setting new IRTE
        https://github.com/kvm-x86/linux/commit/0a917e9d4b70
[06/62] iommu/amd: KVM: SVM: Delete now-unused cached/previous GA tag fields
        https://github.com/kvm-x86/linux/commit/1da19c5ce053
[07/62] KVM: SVM: Delete IRTE link from previous vCPU irrespective of new routing
        https://github.com/kvm-x86/linux/commit/a0ca34bb1aad
[08/62] KVM: SVM: Drop pointless masking of default APIC base when setting V_APIC_BAR
        https://github.com/kvm-x86/linux/commit/430579577892
[09/62] KVM: SVM: Drop pointless masking of kernel page pa's with AVIC HPA masks
        https://github.com/kvm-x86/linux/commit/2e002ddc8966
[10/62] KVM: SVM: Add helper to deduplicate code for getting AVIC backing page
        https://github.com/kvm-x86/linux/commit/3338c639da15
[11/62] KVM: SVM: Drop vcpu_svm's pointless avic_backing_page field
        https://github.com/kvm-x86/linux/commit/d8527f133c0a
[12/62] KVM: SVM: Inhibit AVIC if ID is too big instead of rejecting vCPU creation
        https://github.com/kvm-x86/linux/commit/1aa6e256e46f
[13/62] KVM: SVM: Drop redundant check in AVIC code on ID during vCPU creation
        https://github.com/kvm-x86/linux/commit/c24ed209c474
[14/62] KVM: SVM: Track AVIC tables as natively sized pointers, not "struct pages"
        https://github.com/kvm-x86/linux/commit/26baab4eea4c
[15/62] KVM: SVM: Drop superfluous "cache" of AVIC Physical ID entry pointer
        https://github.com/kvm-x86/linux/commit/d29433336a7b
[16/62] KVM: VMX: Move enable_ipiv knob to common x86
        https://github.com/kvm-x86/linux/commit/bafddc70001d
[17/62] KVM: SVM: Add enable_ipiv param, never set IsRunning if disabled
        https://github.com/kvm-x86/linux/commit/d921665e01ba
[18/62] KVM: SVM: Disable (x2)AVIC IPI virtualization if CPU has erratum #1235
        https://github.com/kvm-x86/linux/commit/8de4a1c8164e
[19/62] KVM: VMX: Suppress PI notifications whenever the vCPU is put
        https://github.com/kvm-x86/linux/commit/6737557442e5
[20/62] KVM: SVM: Add a comment to explain why avic_vcpu_blocking() ignores IRQ blocking
        https://github.com/kvm-x86/linux/commit/52d826c9e54c
[21/62] iommu/amd: KVM: SVM: Use pi_desc_addr to derive ga_root_ptr
        https://github.com/kvm-x86/linux/commit/c4cdbaf9d81c
[22/62] iommu/amd: KVM: SVM: Pass NULL @vcpu_info to indicate "not guest mode"
        https://github.com/kvm-x86/linux/commit/95d50ebe6df8
[23/62] KVM: SVM: Stop walking list of routing table entries when updating IRTE
        https://github.com/kvm-x86/linux/commit/1e663ed23992
[24/62] KVM: VMX: Stop walking list of routing table entries when updating IRTE
        https://github.com/kvm-x86/linux/commit/23ca102e6fb2
[25/62] KVM: SVM: Extract SVM specific code out of get_pi_vcpu_info()
        https://github.com/kvm-x86/linux/commit/0a64c447f6f8
[26/62] KVM: x86: Move IRQ routing/delivery APIs from x86.c => irq.c
        https://github.com/kvm-x86/linux/commit/f5369619f7f8
[27/62] KVM: x86: Nullify irqfd->producer after updating IRTEs
        https://github.com/kvm-x86/linux/commit/9517aedecd0e
[28/62] KVM: x86: Dedup AVIC vs. PI code for identifying target vCPU
        https://github.com/kvm-x86/linux/commit/cf04ec393ed0
[29/62] KVM: x86: Move posted interrupt tracepoint to common code
        https://github.com/kvm-x86/linux/commit/c5af31698d71
[30/62] KVM: SVM: Clean up return handling in avic_pi_update_irte()
        https://github.com/kvm-x86/linux/commit/803928483669
[31/62] iommu: KVM: Split "struct vcpu_data" into separate AMD vs. Intel structs
        https://github.com/kvm-x86/linux/commit/53527ea1b702
[32/62] KVM: Don't WARN if updating IRQ bypass route fails
        https://github.com/kvm-x86/linux/commit/b33252b9d172
[33/62] KVM: Fold kvm_arch_irqfd_route_changed() into kvm_arch_update_irqfd_routing()
        https://github.com/kvm-x86/linux/commit/77bb184ab880
[34/62] KVM: x86: Track irq_bypass_vcpu in common x86 code
        https://github.com/kvm-x86/linux/commit/511754bc548b
[35/62] KVM: x86: Skip IOMMU IRTE updates if there's no old or new vCPU being targeted
        https://github.com/kvm-x86/linux/commit/dc6adb13046a
[36/62] KVM: x86: Don't update IRTE entries when old and new routes were !MSI
        https://github.com/kvm-x86/linux/commit/cc8b13105eac
[37/62] KVM: SVM: Revert IRTE to legacy mode if IOMMU doesn't provide IR metadata
        https://github.com/kvm-x86/linux/commit/71d6b3b8e69d
[38/62] KVM: SVM: Take and hold ir_list_lock across IRTE updates in IOMMU
        https://github.com/kvm-x86/linux/commit/c3d591c91f9c
[39/62] iommu/amd: Document which IRTE fields amd_iommu_update_ga() can modify
        https://github.com/kvm-x86/linux/commit/3be405e89f3d
[40/62] iommu/amd: KVM: SVM: Infer IsRun from validity of pCPU destination
        https://github.com/kvm-x86/linux/commit/08d9ccdd1a5c
[41/62] iommu/amd: Factor out helper for manipulating IRTE GA/CPU info
        https://github.com/kvm-x86/linux/commit/0b2b541fa3cd
[42/62] iommu/amd: KVM: SVM: Set pCPU info in IRTE when setting vCPU affinity
        https://github.com/kvm-x86/linux/commit/f965255dc503
[43/62] iommu/amd: KVM: SVM: Add IRTE metadata to affined vCPU's list if AVIC is inhibited
        https://github.com/kvm-x86/linux/commit/6df262f915ab
[44/62] KVM: SVM: Don't check for assigned device(s) when updating affinity
        https://github.com/kvm-x86/linux/commit/f5998661ff73
[45/62] KVM: SVM: Don't check for assigned device(s) when activating AVIC
        https://github.com/kvm-x86/linux/commit/fe0213923dd9
[46/62] KVM: SVM: WARN if (de)activating guest mode in IOMMU fails
        https://github.com/kvm-x86/linux/commit/16562766f171
[47/62] KVM: SVM: Process all IRTEs on affinity change even if one update fails
        https://github.com/kvm-x86/linux/commit/48f79c6c86b3
[48/62] KVM: SVM: WARN if updating IRTE GA fields in IOMMU fails
        https://github.com/kvm-x86/linux/commit/cd86240fea26
[49/62] KVM: x86: Drop superfluous "has assigned device" check in kvm_pi_update_irte()
        https://github.com/kvm-x86/linux/commit/04c4ca0ae479
[50/62] KVM: x86: WARN if IRQ bypass isn't supported in kvm_pi_update_irte()
        https://github.com/kvm-x86/linux/commit/d1bccaa1793d
[51/62] KVM: x86: WARN if IRQ bypass routing is updated without in-kernel local APIC
        https://github.com/kvm-x86/linux/commit/25ef059e8bc5
[52/62] KVM: SVM: WARN if ir_list is non-empty at vCPU free
        https://github.com/kvm-x86/linux/commit/99836eb9c5dc
[53/62] KVM: x86: Decouple device assignment from IRQ bypass
        https://github.com/kvm-x86/linux/commit/77e1b8332d1d
[54/62] KVM: VMX: WARN if VT-d Posted IRQs aren't possible when starting IRQ bypass
        https://github.com/kvm-x86/linux/commit/ce9d54f41be0
[55/62] KVM: SVM: Use vcpu_idx, not vcpu_id, for GA log tag/metadata
        https://github.com/kvm-x86/linux/commit/11a60455d4c9
[56/62] iommu/amd: WARN if KVM calls GA IRTE helpers without virtual APIC support
        https://github.com/kvm-x86/linux/commit/a23480fe21de
[57/62] KVM: SVM: Fold avic_set_pi_irte_mode() into its sole caller
        https://github.com/kvm-x86/linux/commit/f2bc961d383b
[58/62] KVM: SVM: Don't check vCPU's blocking status when toggling AVIC on/off
        https://github.com/kvm-x86/linux/commit/6eab2340f339
[59/62] KVM: SVM: Consolidate IRTE update when toggling AVIC on/off
        https://github.com/kvm-x86/linux/commit/5f3d06b1648e
[60/62] iommu/amd: KVM: SVM: Allow KVM to control need for GA log interrupts
        https://github.com/kvm-x86/linux/commit/b9e53f9ff4a8
[61/62] KVM: SVM: Generate GA log IRQs only if the associated vCPUs is blocking
        https://github.com/kvm-x86/linux/commit/b03500f03ea0
[62/62] KVM: x86: Rename kvm_set_msi_irq() => kvm_msi_to_lapic_irq()
        https://github.com/kvm-x86/linux/commit/6f343724837b

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next

