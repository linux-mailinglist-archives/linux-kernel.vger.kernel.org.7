Return-Path: <linux-kernel+bounces-743097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B100B0FA84
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9F2581003
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA78225762;
	Wed, 23 Jul 2025 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BC4zVDUT"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5DD1F12FB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296957; cv=none; b=tEjWoyUKK4trS1Enwt3qYcSKXIt/4FWt9MS1Mn+pGpuldgLHP3yJsRj5xGu0EHb2GrxpDI3xeRFymN+WXA8E6BxdMsLo22hXLWN+o1A8XoytYzGJ3UAhyiNfemS1TPaynODlvBVrjd02wQhY7uz9/TNXQ7se67eXXqJ8Kne86uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296957; c=relaxed/simple;
	bh=Vh2bpELVG2CxMoGWIIyObo3qKcF89FKVkUbdh7gGHCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oa/rVb8MDi3Eyy+Jm1ynvbAwGErFRTuFcsffdWnb2o58J5D1ofDLMlmPUCRAQdJpiAeGVYWEql1M0CXl1OZe+6WMOpyDpfyAj2BMlyJrLHno9qPMqnHVj64ta3ETVSTn1ZQnk4QCHsRYAGxw+Dmj/fDlgm4SD1hRZeCeGmj1+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BC4zVDUT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748e1e474f8so331273b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753296955; x=1753901755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEql4lCCTW1Ifr0adVTaMkUoVb1pJx1jzjwjCrergC8=;
        b=BC4zVDUTiXYfuFiTY2dkVUXd630VdRJyvL8VuM78dJU/RjyWi8w7fJRFVqs3RG+dNc
         ueY02WUNw0ivfbJ1pz7yECAlZhX+w5sbXMhu4Ku9f/UniFuQopxckWMklDcwd7ggHKrE
         IYYOyE/0rA49C94zcbrOO9FMG+/27WWp/xGNmcGpZ/6WhM/91eZG34glofVrrVpLvgwy
         Bczo06U7sM/1Gglwv9q/t2Rc36x3/gl2hagIIrIc4slv6Ydvhs+PnOTWg318yVm8afuX
         xBomyrP7nZeG8TydDFnvXsISodVslhyfhrA2frLHXWc+Ebn0/2xnk7lsxn2WHyLbLLHs
         Qlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296955; x=1753901755;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rEql4lCCTW1Ifr0adVTaMkUoVb1pJx1jzjwjCrergC8=;
        b=cUhdl4ohpM9Z2OvkyPXao/rqX0tEf33jP2MZwespfVaW0TdTX+3bWHSJztAaxq9pj4
         W8b82lCrITNdzvMXu1Wk3ma71/QOYZlJUg3H0WcTzD0nwqfs4HCOm8YLgKJdNDGP8Voz
         OT9p7mp43NnGqURt7XOToX4mOlmkhpIV9/dr88x1nLZrKRamYjqm4bagHK1UnwvPVpJR
         g/P3ps2rwACPXuzN13HO5i3PZvu2Z1U/9Xnr0Zo6Fn5DBzFe++K2NLGjElEIrbX2F28h
         juxUHkStG7SeK0JcFOlJ++Xm1beyH+sMY14rCE7qxxun6LBE0ahj4wrkb4+YIXCF7lZJ
         6wgA==
X-Gm-Message-State: AOJu0YwGj+QkYyfSsXeosjjbK2+P5PZ6/pCSX21hc/9VxJZytOTuQjDC
	WOMDl3jy+k4H981Qz7D5TbGQOpetleSZV0BxRabMRMPpsrEHOlBaTPaA40IehJKj9440atrmPhG
	HG1LHYA==
X-Google-Smtp-Source: AGHT+IEI7undIZBUtGTMoVAFM+LMhz9On3SXFHelwKZQgX+SCthgAL+5iCIY2PzLdGdyEqEpZcJ7vqeNCUQ=
X-Received: from pfbhr20-n2.prod.google.com ([2002:a05:6a00:6b94:20b0:747:abae:78e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:339b:b0:232:1f25:7965
 with SMTP id adf61e73a8af0-23d48fe74c4mr5803785637.5.1753296954851; Wed, 23
 Jul 2025 11:55:54 -0700 (PDT)
Date: Wed, 23 Jul 2025 18:55:53 +0000
In-Reply-To: <CABQX2QMj=7HnTqCsKHpcypyfNsMYumYM7NH_jpUvMbgbTH=ZXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422161304.579394-1-zack.rusin@broadcom.com>
 <20250422161304.579394-2-zack.rusin@broadcom.com> <aIEgVpjXDR0BXgHq@google.com>
 <CABQX2QMj=7HnTqCsKHpcypyfNsMYumYM7NH_jpUvMbgbTH=ZXg@mail.gmail.com>
Message-ID: <aIEwOToiAkKfQA-4@google.com>
Subject: Re: [PATCH v2 1/5] KVM: x86: Centralize KVM's VMware code
From: Sean Christopherson <seanjc@google.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+lists

Please keep all replies on-list, no matter how trivial the question/comment=
.
Pretty much the only time it's ok to take something off-list is if the conv=
ersation
is something that can't/shouldn't be had in public.

On Wed, Jul 23, 2025, Zack Rusin wrote:
> On Wed, Jul 23, 2025 at 1:48=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > > index 60986f67c35a..b42988ce8043 100644
> > > --- a/arch/x86/kvm/emulate.c
> > > +++ b/arch/x86/kvm/emulate.c
> > > @@ -26,6 +26,7 @@
> > >  #include <asm/debugreg.h>
> > >  #include <asm/nospec-branch.h>
> > >  #include <asm/ibt.h>
> > > +#include "kvm_vmware.h"
> >
> > Please sort includes as best as possible.  KVM's loose rule is to organ=
ize by
> > linux =3D> asm =3D> local, and sort alphabetically within each section,=
 e.g.
> >
> > #include <linux/aaaa.h>
> > #include <linux/blah.h>
> >
> > #include <asm/aaaa.h>
> > #include <asm/blah.h>
> >
> > #include "aaaa.h"
> > #include "blah.h"
>=20
> Yea, that's what I do in my code but in this case I had no idea where
> to put it because none of the sections in that file are sorted, where
> would you like the include among:
> ```
> #include <linux/kvm_host.h>
> #include "kvm_cache_regs.h"
> #include "kvm_emulate.h"
> #include <linux/stringify.h>
> #include <asm/debugreg.h>
> #include <asm/nospec-branch.h>
> #include <asm/ibt.h>
>=20
> #include "x86.h"
> #include "tss.h"
> #include "mmu.h"
> #include "pmu.h"
> ```
> below kvm_emulate or would you like me to resort all the includes?

Nah, don't bother sorting them all (though that might happen anyways[*]).  =
Just
do your best to not make things worse.  Luckily, 'v' is quite near the end,=
 so I
think the least-awful option will be fairly obvious in all/most cases, e.g.

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 78e0064dd73e..9b7e71f4e26f 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -26,12 +26,12 @@
 #include <asm/debugreg.h>
 #include <asm/nospec-branch.h>
 #include <asm/ibt.h>
-#include "kvm_vmware.h"
=20
 #include "x86.h"
 #include "tss.h"
 #include "mmu.h"
 #include "pmu.h"
+#include "vmware.h"
=20
 /*
  * Operand types
---

[*] https://lore.kernel.org/lkml/aH-dqcMWj3cFDos2@google.com

> > > @@ -2565,8 +2563,8 @@ static bool emulator_io_port_access_allowed(str=
uct x86_emulate_ctxt *ctxt,
> > >        * VMware allows access to these ports even if denied
> > >        * by TSS I/O permission bitmap. Mimic behavior.
> > >        */
> > > -     if (enable_vmware_backdoor &&
> > > -         ((port =3D=3D VMWARE_PORT_VMPORT) || (port =3D=3D VMWARE_PO=
RT_VMRPC)))
> > > +     if (kvm_vmware_backdoor_enabled(ctxt->vcpu) &&
> >
> > Maybe kvm_is_vmware_backdoor_enabled()?  To make it super clear it's a =
predicate.
> >
> > Regarding namespacing, I think for the "is" predicates, the code reads =
better if
> > it's kvm_is_vmware_xxx versus kvm_vware_is_xxx.  E.g. is the VMware bac=
kdoor
> > enabled vs. VMware is the backdoor enabled.  Either way is fine for me =
if someone
> > has a strong preference though.
> >
> > > +         kvm_vmware_io_port_allowed(port))
> >
> > Please separate the addition of helpers from the code movement.  That w=
ay the
> > code movement patch can be acked/reviewed super easily, and then we can=
 focus on
> > the helpers (and it also makes it much easier to review the helpers cha=
nges).
>=20
> Sorry, I'm confused about this one. I find it a lot easier to review
> helpers if I know what code they're supposed to replace and that's
> harder to do if a change is just adding some code without any
> indication of where it's coming from but I'm happy to adjust this in
> whatever way is easiest for you.

All I'm saying is do the initial bulk, pure code movement in a single patch=
,
with no other changes whatsoever.  And then add and rename helpers in a sep=
arate
patch(es).  The add/renames can go before/after the code movement, what I c=
are
most about is isolating the pure code movement.

I'm guessing the cleanest approach would be to do pure code movement, then =
do
renames, and finally add helpers.  That'll require an ugly double move of t=
he
VMWARE_PORT_VMPORT and VMWARE_PORT_VMRPC #defines to vmware.h, and then aga=
in to
vmware.c.  But while annoying, that makes the individual patches super easy=
 to
review and apply.

Holler if it's still unclear, I can put together a quick comple of example =
patches.

