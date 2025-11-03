Return-Path: <linux-kernel+bounces-883397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0473C2D5E4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5223AA7C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC5531C59B;
	Mon,  3 Nov 2025 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oeUPv9lO"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D3431B11F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189075; cv=none; b=mYM9ipBnw818qqn2E54Pn5XcPe7nBrHvA63xB9UmyYpYCFyG/8VALaNiQeFs+hPr940QIHhEyVkVHWfpKArg8FhWxhQ0Tvy2WKMSGDG7nuNCfioEqPKF3npcUqoyUGfLtO5c0pf1fJ0VI2aCcZS/m9G2quyc58bwfxY4hJEppMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189075; c=relaxed/simple;
	bh=8QZMELXENbunUYpr28WqprFjzAksKDqeP0VLh+0+HBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B7KmLAKerYGPrR13gKjD4vwzHf9jOwqJ//zfij4TlPTvdSugZXCKzRa7XbBPGXAPGnzIxgE++i5+WvzblfXWUoolhcZFk9W2D48xtGeKmICACLuT53hKQ4tesl27C+j2BwAmv2WSHtkcvU3YmeQvTl0e/i2orjpJhLmbOaLYxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oeUPv9lO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340e10797a8so1618226a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762189073; x=1762793873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgHCRB+iOhQXBR2DJ3UKt+ri7IzX08+hr1DQhDLbsGo=;
        b=oeUPv9lOtOFFcTCXXx73+qQHLeGQdoIKmtLtfdAco9WN6qOFn56grch2nwnNSVD9M9
         tavasGV0VNjLhrJpBaC5yTq7YVD6tv46LLzSIlFbZl2YoyvRcZTG23WioFeGFE/yibOv
         O2J0qhdeorK89aTivvkWtEzkCwGgoMYk9dPYnTfMeg7VxQTmOUx66DlfnYkWxTY1f3o3
         I+iSgAhsEim66RmAE7uSXkrFD4pfQS897HnVNBWT9gxE78QnAatBE6EaJfvEWjBje9+d
         z7WGLhbSKonl+JqWVODRjETfaZoyyNM5G8Nmz+ZKHW/ciLutNNNGOvEUVp7LKX7jbajW
         /1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189073; x=1762793873;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KgHCRB+iOhQXBR2DJ3UKt+ri7IzX08+hr1DQhDLbsGo=;
        b=lsZAhMRP/zr+kE0WDNDeYNp6L0qStLLk1d0ewDz6+CPuJEdwJ3/94EH5LhfVfBUJx3
         m58/CKqUvKhKhHwSGUo7cXVKZ/DLNquOYdNPBsxH6YZ4XpgtRD3RCyoCvP0fcxZMqF/b
         b9A1DDJ0LhLTD0qW8k/cVvb+LrmkfL8GtAMlDXihKGoqrawoOA0Rg5dC9kp4ItNXcV77
         Lb8Mx+ZZbaQUfdOLTyAju/0zs3iTF2Rt750Y/1O+4Gv8b4es+/z7JOkbzXKlHO3fbLnF
         TYDkgcjQ1KAVnUEuq98RJhuaA/bafF/Ak3pVMqcQYv3gJlJGpCcpCZQmEinr4SorCV72
         DWYw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5uqjyhjVdwumntCh77Cb1bVC5YW1ItnyhaI3JYoV/OPzy21euxgMB+W6UGknKIX91Ya7TC5yALf7d0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4L0Qonpv1grzR05SJuKTCmaC2VjhkRBdl/Gft8mtQvsZLy5L
	HSIcpqxSnxVvlI/frZXtd9xEJ6HhYGfXRYCPi5XXCAZvskBCW8kBRFdsyVKh7iQZBFQ0WH6dDLY
	vOGHPNQ==
X-Google-Smtp-Source: AGHT+IFOpWte/V7QEZNwmFK3W3HK1rZFTmmKzEm/d2Hx1LQQlueXjMmVSeG9D67BxqXsCpRIlefh72yq0PE=
X-Received: from pjpe14.prod.google.com ([2002:a17:90a:9a8e:b0:340:92f6:5531])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e8e:b0:332:3515:3049
 with SMTP id 98e67ed59e1d1-34082fc930bmr15533204a91.4.1762189072869; Mon, 03
 Nov 2025 08:57:52 -0800 (PST)
Date: Mon, 3 Nov 2025 08:57:51 -0800
In-Reply-To: <80691865-7295-44C9-9967-5E5B744EB5D4@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918162529.640943-1-jon@nutanix.com> <aNHE0U3qxEOniXqO@google.com>
 <7F944F65-4473-440A-9A2C-235C88672E36@nutanix.com> <B116CE75-43FD-41C4-BB3A-9B0A52FFD06B@nutanix.com>
 <aPvf5Y7qjewSVCom@google.com> <EFA9296F-14F7-4D78-9B7C-1D258FF0A97A@nutanix.com>
 <aQTxoX4lB_XtZM-w@google.com> <80691865-7295-44C9-9967-5E5B744EB5D4@nutanix.com>
Message-ID: <aQjd1q5jF5uSTfmu@google.com>
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

On Mon, Nov 03, 2025, Khushit Shah wrote:
> Hi Sean,=20
>=20
> > On 31 Oct 2025, at 10:58=E2=80=AFPM, Sean Christopherson <seanjc@google=
.com> wrote:
> >=20
> >> Hi Sean,
> >>=20
> >> Thanks for the reply.
> >>=20
> >>> On 25 Oct 2025, at 1:51=E2=80=AFAM, Sean Christopherson <seanjc@googl=
e.com> wrote:
> >>>=20
> >>> Make it a quirk instead of a capability.  This is definitely a KVM bu=
g, it's just
> >>> unfortunately one that we can't fix without breaking userspace :-/
> >>=20
> >> I don=E2=80=99t think this approach fully addresses the issue.
> >>=20
> >> For example, consider the same Windows guest running with a userspace
> >> I/O APIC that has no EOI registers. The guest will set the Suppress EO=
I
> >> Broadcast bit because KVM advertises support for it (see=20
> >> kvm_apic_set_version).
> >>=20
> >> If the quirk is enabled, an interrupt storm will occur.
> >> If the quirk is disabled, userspace will never receive the EOI
> >> notification.
> >=20
> > Uh, why not?
> >=20
> >> For context, Windows with CG the interrupt in the following order:
> >>  1. Interrupt for L2 arrives.
> >>  2. L1 APIC EOIs the interrupt.
> >>  3. L1 resumes L2 and injects the interrupt.
> >>  4. L2 EOIs after servicing.
> >>  5. L1 performs the I/O APIC EOI.
> >=20
> > And at #5, the MMIO access to the I/O APIC gets routed to userspace for=
 emulation.
>=20
> Yes, but the userspace does not have I/O APIC EOI register and so it will=
 just be a
> meaningless MMIO write, resulting in the the IRQ line being kept masked.

Why on earth would userspace disable the quirk without proper support?

> > On 31 Oct 2025, at 10:58=E2=80=AFPM, Sean Christopherson <seanjc@google=
.com> wrote:
> >=20
> > That's the whole point of the quirk; userspace should disable the quirk=
 if and
> > only if it supports the I/O APIC EOI extension.
>=20
>=20
> Sadly, so if the quirk is kept enabled (no I/O APIC EOI extension) and if=
 we do
> not want a guest reboot, the original windows interrupt storm bug will pe=
rsist?

Well, yeah, if you don't fix the bug it'll keep causing problems.

> Unless we also update the userspace to handle the EOI register write none=
theless,
> as damage has been done on the time of power on.
>=20
> > On 31 Oct 2025, at 10:58=E2=80=AFPM, Sean Christopherson <seanjc@google=
.com> wrote:
> >=20
> >> and updated userspace can opt in when it truly supports EOI broadcast
> >> suppression.
> >>=20
> >> Am I missing something?
> >=20
> > I think so?  It's also possible I'm missing something :-)
>=20
> I am just thinking that the original Windows bug is not solved for all th=
e cases,
> i.e A powered on Windows guest with userspace I/O APIC that does not have
> EOI register.=20

Userspace _must_ change one way or the other.  Either that or you livepatch=
 your
kernel to carry an out-of-tree hack-a-fix to avoid updating userspace.=20

> Also, in the patch instead of a knob to disable suppress EOI broadcast, I=
 think
> we should have a knob to enable, this way at least for unmodified userspa=
ce=20
> the buggy situation is never reached.

No.  Having a bug that prevents booting certain guests is bad.  Introducing=
 a
change that potentially breaks existing setups is worse.  Yes, it's unfortu=
nate
that userspace needs to be updated to fully remedy the issue.  But unless y=
ou're
livepatching the kernel, userspace should be updated anyways on a full rebo=
ot.

