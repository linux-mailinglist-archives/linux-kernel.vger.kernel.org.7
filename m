Return-Path: <linux-kernel+bounces-744974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B7B1132D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47ED1CC82A5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD03923ABB6;
	Thu, 24 Jul 2025 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0nz3SDx"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9A23AB8B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392766; cv=none; b=gKag37bhMOzb8Uj1FoFayyNvsOotorB34B//8vIkIz2vvBxtKxfgeiyUfEm3+GsePxZ5sJjTsgskht7ikQL5xEehSyfG868ZqcWRFhdcJ0KYMfCMeDoP4+I2jz+e1Widq6K/iXyT9VurnV7x/53k2lAFfhk4sR/xoosw2ZLleUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392766; c=relaxed/simple;
	bh=iTA3fYqQ4emz1zx8tzsB+YpeoXqNPn/gMJ9GAQza/z0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yulkg9w5XKzsDZpMLCWn6qefu6f03uwrR+TKQh39QK0mWiOtVQEtoXwXSr9YVRBp2IlmO6OZ+uMz1uxukMUX3b/KDN8ybVFR0FZnQCfzQ/AuGCJ/4s115mVRuV4Rqy/NiOcTsWKVIFByjnoyKE4Z5LzqP1ZkrcpMePEkfTj3KwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0nz3SDx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so1438087a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753392763; x=1753997563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NvSjYH70GaCjL6u46m/BG5Q88RqNK9QtwmXnyyczbEM=;
        b=g0nz3SDx7yaG+iLrUGzY8TC93grJQPCFUMjfT9/hR2sQf9xrwQ26Wojr67gBI6HeYv
         alEl4i6voxvlA33sKvGmuLM/KGVh3MqaU//NK6NcwkRYvlQWvhVm9TBloeUgIm3RGs44
         OQSYlgarOnjHgQaYzVZm3K0XuHIv2bXZyZ1ilOoolQuAUOYhT/gtGja5119NJyOBj0lt
         U506eqUQGGKK/8b8MYjl55696JLo2eUiWLTr9OflAYLHTeE3RF1rhdmbI9Zk/EAa3OJ3
         ReW51PdkrGpjUc4Xg33TsIO3YiOOkBkyE6U7EBURAZLQbG1wVNZ8HezkxyFK41Ay9NcG
         Y8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753392763; x=1753997563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvSjYH70GaCjL6u46m/BG5Q88RqNK9QtwmXnyyczbEM=;
        b=sfEYlNRz8CWgzem+D2wp8igkewtHK0aH+drYXH8E5ZdCJiYX29wLeOzKQrUzPmtAIp
         pYE2spF2u0P8pRwbtxmNXGyxyAmCtCOOzzMIh3OyhXQiFhXw5oULTxnBf3a09y4z51nY
         Jl2sOSywjJPpSUNN90KqUDp3KNrj3jEvK0XLumNphyzFq15xG6UgW6L9wIe++3Bl8JBh
         vGhWyF/mv/aukE+BdZgezFaThwJFbrDZv3SBC1Sv2flbH2RP112V/sqD2dKbOXUw1eiG
         NRx9WN2KhTYQAWh7MhSqc20ZqIn+vwcXsg+x/z0N0JN19ndyAeavsQoi/k3eKKL3cacH
         /Vxw==
X-Forwarded-Encrypted: i=1; AJvYcCWy9EkTI8JtkKHy2Xtii2AAJFBYh/Er8wYbb3tO/yTsqcYK24x422tTzCvJYyncWv+39h9GVY0vSrVq++c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEOTycY/3CL7G1RBrxMCMdTZk0AVEgooSBf/yN61tjOFPIcAdP
	S2sz0+PI6O0minQ0Mjj+9lTgSvTgst7mL3Atv+7DfhInILkWml3+ln6psTG62mNlIgjw2F5AE8A
	0DXw1TA==
X-Google-Smtp-Source: AGHT+IGd5zJlVgGMj67wifl9Rtgk5UsqczFyGEvXcZTPXC/otKhxMg0VOQF6IjGRxzrGojiZezAj4FCHURo=
X-Received: from pjee15.prod.google.com ([2002:a17:90b:578f:b0:311:ff0f:6962])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc44:b0:311:ad7f:3299
 with SMTP id 98e67ed59e1d1-31e507dae6emr11516236a91.25.1753392762999; Thu, 24
 Jul 2025 14:32:42 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:32:41 -0700
In-Reply-To: <3cc16f7d-c650-43f2-b0ca-d99c427cd69b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
 <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local> <20250723183426.GA1158000@yaz-khff2.amd.com>
 <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de> <aIKehTDgP-Nu36ol@google.com>
 <3cc16f7d-c650-43f2-b0ca-d99c427cd69b@amd.com>
Message-ID: <aIKmeclza-9TDe4U@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
From: Sean Christopherson <seanjc@google.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>, 
	David Arcari <darcari@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 24, 2025, Mario Limonciello wrote:
> On 7/24/2025 3:58 PM, Sean Christopherson wrote:
> > On Wed, Jul 23, 2025, Borislav Petkov wrote:
> > > On July 23, 2025 9:34:26 PM GMT+03:00, Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> > > > On Tue, Jul 22, 2025 at 06:56:15PM +0200, Borislav Petkov wrote:
> > > > > On Mon, Jul 21, 2025 at 06:11:54PM +0000, Yazen Ghannam wrote:
> > > > > > The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
> > > > > > commonly used error response from hardware. This may occur due to a real
> > > > > > hardware issue or when running in a VM.
> > > > > 
> > > > > Well, which is it Libing is reporting? VM or a real hw issue?
> > > > > 
> > > > 
> > > > In this case, it was a VM.
> > > > 
> > > > > If it is a VM, is that -1 the only thing a VMM returns when reading that
> > > > > MMIO address or can it be anything?
> > > > > 
> > > > > If latter, you need to check X86_FEATURE_HYPERVISOR.
> > > > > 
> > > > > Same for a real hw issue.
> > > > > 
> > > > > IOW, is -1 the *only* invalid data we can read here or are we playing
> > > > > whack-a-mole with it?
> > > > > 
> > > > 
> > > > I see you're point, but I don't think we can know for sure all possible
> > > > cases. There are some reserved bits that shouldn't be set. But these
> > > > definitions could change in the future.
> > > > 
> > > > And it'd be a pain to try and verify combinations of bits and configs.
> > > > Like can bit A and B be set together, or can bit C be set while running
> > > > in a VM, or can bit D ever be set on Model Z?
> > > > 
> > > > The -1 (all bits set) is the only "applies to all cases" invalid data,
> > > > since this is a common hardware error response. So we can at least check
> > > > for this.
> > > > 
> > > > Thanks,
> > > > Yazen
> > > 
> > > I think you should check both: HV or -1.
> > > 
> > > HV covers the VM angle as they don't emulate this
> > 
> > You can't possibly know that.  If there exists a hardware spec of any kind, it's
> > fair game for emulation.
> > 
> > > and we simply should disable this functionality when running as a guest.
> > > 
> > > -1 covers the known-bad hw value.
> > 
> > And in a guest, -1, i.e. 0xffffffff is all but guaranteed to come from the VMM
> > providing PCI master abort semantics for reads to MMIO where no device exists.
> > That's about as "architectural" of behavior as you're going to get, so I don't
> > see any reason to assume no VMM will every emulate whatever this feature is.
> 
> I don't really understand why there would be any value in a VMM emulating
> this feature.  It's specifically about the reason the hardware saw for the
> last reboot.  Those reasons are *hardware reasons*.  IE, you're never going
> to see a thermal event as the reason a guest was rebooted.

Not necessarily.  There are a variety of use cases for doing nearly-full passthrough
of bare metal state into a VM, e.g. to deprivilege the "main" OS, interpose and/or
isolate select resources, etc.  I don't think it's too far fetched to imagine one
or more such use cases exposing this range of MMIO to the guest _and_ also setting
the HYPERVISOR bit in CPUID.

But whether or not there's a legitimate use case is beside the point.  I'm not
arguing this is at all useful for VMs.  I'm arguing _against_ splattering
X86_FEATURE_HYPERVISOR checks all over the place just because an error was first
(or only) observed while running in a VM.

If a VMM is operating out of spec, then fix the VMM.  If the behavior is legal
but unexpected, then address it in the guest.  Neither of those requires gating
code on X86_FEATURE_HYPERVISOR.

> CF9 reset or ACPI power state transition are about all I can envision for
> guest reboot reasons.  And even then do you *want* the to really have the
> VMM track the reasons for a guest reboot?

