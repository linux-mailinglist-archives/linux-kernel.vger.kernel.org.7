Return-Path: <linux-kernel+bounces-821760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC21B822D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4643C48096C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11E930FC27;
	Wed, 17 Sep 2025 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xScshUvX"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D630E83C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148822; cv=none; b=Ji6ouMG/8un/H2MHdsHh5+FOvC+B2E58D1s2snfxq30RGsQpFvA0GhynYlNjOZ4UKUoQBQHVpSsYvBVJsP9Ztv53abZQQ06yxWq/X8Y2E3qwJtpipBtra8O1DrBBoOjfWYk5KIlggri0lb3fy57Lcb2ADaUt3uwiNEsQNOjoqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148822; c=relaxed/simple;
	bh=WSfFooN5Bw7kAHcBSRwXJG4k3j5I4pDgZn1B6oXDRa0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MKAj5hMcleF89/jfPwkGcG03ATP0Q6b0yN6Mn7LUhgWKrT2hQT4sCvbsICvmEgfR/7cSO70VicA9sLpSz9t365UxkYENZcG+y6TmAbapXwQoYL1gNLVrA2IYzB4+rboEoWAcc08clN/UT5N6LPu6wfbcdcq7694/+sT5ovV6U2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xScshUvX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77621c54731so432397b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758148820; x=1758753620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2gITbjAhZLVDTe91+pv60FMHVz/PyRihO/dG6TrQ1g=;
        b=xScshUvXozX1uxER7qZsO8p7Ucy0JMRPftF2Qc4iW+jUzt2v+z7shzzTO01oxCZEkq
         051hR+Gj4XdNfQu3CBsi2wZ/EH6w9tdtqjod+Kc1XRG0O89bnsuI7loyoUxiUnZGJjMe
         RCcV2iaR48KpLhO0wVK0FVGOFqVC0u6SHuSflHNj9mda6XvYExKSVhsTN67EiEq1Idi5
         0xmZ5a+QInviQ7LhmASPABrbGQyWowkK6Dj7GE/ISc3Z7Thrvt6udxsJEK7A9GUwwmqc
         SYYllHDx/tEr61hZr1eAqBMi0W5M25jIPqfsNYUNmR3C0R2D5r1NtYnjirXfnjWeOKcx
         cHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148820; x=1758753620;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m2gITbjAhZLVDTe91+pv60FMHVz/PyRihO/dG6TrQ1g=;
        b=L/+ugbyKMSzd/w+KFNUQyenr077M4OPQGXIB0HmYZ/ekyYdNOKUBkm74B1ky1D1RQP
         BMt9ag9UNZdc/IAexKdr56RAYpFf2dM4gGBXKYBX5Jkv/CUItMoWbJFwOrXnwdNkpKjY
         6P1Rnqyb4clV4ORq2eeh8YaxdW4Cz28POf4D9YzMJ3K/0E6Evv6tZSKdXU3ElrmPHmco
         7iS7hb8LoZ73sRn0uAoRcsb5Ucqu78f7lu+rMeUoQ/7AoMtbhITPfCv2Sr8L5hlMGXYW
         W0aP0OGPfTlwb1DjHvSL4neOliY/X3Kwgq7WSpMVqGZ02n4nZAq6gt/kMUlwpqa/CY25
         sZWA==
X-Forwarded-Encrypted: i=1; AJvYcCULbgLxQ6s2Uf9DfmDenqbywF57msLf8snKUx8xc233GhWOqvpI8h8rZaGZ29IXTqzQNnQomSSQWVJSDPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsvTTXOQicNqjhLtORzAXjxz1rjM+fYmZm33azzHr3wW0OhZaO
	P/fxmI7bOF1bVJ5NI6GJ/KkMU4C0uSyY3Ltb+IQAGvjp+vSrU2p9HjsWQ0XIlJPJc4QI7eA0urZ
	1MTJWQQ==
X-Google-Smtp-Source: AGHT+IFI0s+9qm/ZBuqtuCHVVai9MRluhJYduJgd1o773c0GWF5zKPkcHTokW+JlTa7DRlVZN5DukGxMcIA=
X-Received: from pjzz6.prod.google.com ([2002:a17:90b:58e6:b0:327:e172:e96])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e082:b0:262:8bce:33bd
 with SMTP id adf61e73a8af0-27aa12ef6ffmr5224302637.28.1758148820303; Wed, 17
 Sep 2025 15:40:20 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:40:18 -0700
In-Reply-To: <f533d3a4-183e-4b3d-9b3a-95defb1876e0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909182828.1542362-1-xin@zytor.com> <aMLakCwFW1YEWFG4@google.com>
 <0387b08a-a8b0-4632-abfc-6b8189ded6b4@linux.intel.com> <aMmkZlWl4TiS2qm8@google.com>
 <f533d3a4-183e-4b3d-9b3a-95defb1876e0@zytor.com>
Message-ID: <aMs40gVA4DAHex6A@google.com>
Subject: Re: [RFC PATCH v1 0/5] x86/boot, KVM: Move VMXON/VMXOFF handling from
 KVM to CPU lifecycle
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-pm@vger.kernel.org, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	pavel@kernel.org, brgerst@gmail.com, david.kaplan@amd.com, 
	peterz@infradead.org, andrew.cooper3@citrix.com, kprateek.nayak@amd.com, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, dan.j.williams@intel.com, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025, Xin Li wrote:
> On 9/16/2025 10:54 AM, Sean Christopherson wrote:
> > On Thu, Sep 11, 2025, Arjan van de Ven wrote:
> > > Hi,
> > > > I also want to keep the code as a module, both to avoid doing VMXON=
 unconditionally,
> > >=20
> > > can you expand on what the problem is with having VMXON unconditional=
ly enabled?
> >=20
> > Unlike say EFER.SVME, VMXON fundamentally changes CPU behavior.  E.g. b=
locks INIT,
> > activates VMCS caches (which aren't cleared by VMXOFF on pre-SPR CPUs, =
and AFAIK
> > Intel hasn't even publicly committed to that behavior for SPR+), restri=
cts allowed
> > CR0 and CR4 values, raises questions about ucode patch updates, trigger=
s unique
> > flows in SMI/RSM, prevents Intel PT from tracing on certain CPUs, and p=
robably a
> > few other things I'm forgetting.
>=20
> Regarding Intel PT, if VMXON/VMXOFF are moved to CPU startup/shutdown, as
> Intel PT is initialized during arch_initcall() stage, entering and leavin=
g
> VMX operation no longer happen while Intel PT is _active_, thus
> intel_pt_handle_vmx() no longer needs to "handles" VMX state transitions.

The issue isn't handling transitions, it's that some CPUs don't support Int=
el PT
post-VMXON:

  If bit 14 is read as 1, Intel=C2=AE Processor Trace (Intel PT) can be use=
d in VMX
  operation. If the processor supports Intel PT but does not allow it to be=
 used
  in VMX operation, execution of VMXON clears IA32_RTIT_CTL.TraceEn (see
  =E2=80=9CVMXON=E2=80=94Enter VMX Operation=E2=80=9D in Chapter 32); any a=
ttempt to write IA32_RTIT_CTL
  while in VMX operation (including VMX root operation) causes a general-pr=
otection
  exception.

And again, unconditionally doing VMXON is a minor objection in all of this.

