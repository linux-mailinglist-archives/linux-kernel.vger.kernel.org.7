Return-Path: <linux-kernel+bounces-872852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B245BC122FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF10565A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03B120DD72;
	Tue, 28 Oct 2025 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgGyZuxZ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045381F4CB3
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611829; cv=none; b=FS7StRtVwI0oKbTQwZ8gWXZ3dYCo0nhhOIb2SLWkjPA+Xdf6Z0NHy6bMlDEaFmcPGiicvZre334Cn6BlBucDObYXXO+xnA7bHQhBAcXunJ6MdJi8nTLxAmmUeOwkjsblxVVtTt815h9Bwf+Vc0jUkprOyv1DwDH16eE2Vm/yu48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611829; c=relaxed/simple;
	bh=QdkEAMsGYBzU3fN0cne5qZg46IOFvPzz9xbD2HV7VAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t/3LUOjxEVrGhRtAyRd667FFNhXNHv/pd1kuPlFGJQD96/+oRt1dvSA6Q4a3rKZCa3pnUePn+HOWHl+N6Uafwp0vCKimXxqPe5dKOWJHRwNz9GnOOqGEjl0qby7pD23L9wZhRbZvWJ+MaGYti/HjAeDtRuNCKCqsaCgHUcfDzaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgGyZuxZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-339b704e2e3so4969845a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761611825; x=1762216625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3mxOKer4OGfyDxlfqvGDsZ/A3KYgtdet3LczK0ONqE=;
        b=fgGyZuxZxoFhZUStZEOkgSnMD24ZyWXS2V3OZAAoEIpZKU8UWL7ea7jebGj8oXRZvS
         ptJemZcBakmkJS9N0IfXOYbmFs227noHivg6R3O20yPkmSfN6CO3Z+ztmApH78+V4wmt
         05pOWnwPEevb+e4h2Kj2Wd6JDa9GkI1IV2nTOjdHOibYwC0gFwibdcoXY05UV62Pw4Jt
         R0EnzB+vHuohh8eubyLliqqfKvzIt796M3KNC4/Nk9AWUG+hg0xldQGNUzvRsLXI1D5d
         xlbZ9Aet7yAYgIk9a05o0KkrC2b3Kd/i7/JMRWGgCcPAqXVm8r1nF3ed8R5ApIm/AU0E
         O50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611825; x=1762216625;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J3mxOKer4OGfyDxlfqvGDsZ/A3KYgtdet3LczK0ONqE=;
        b=XXA5/5K6Sn0adJ2JImfQhntDX97OmFYIryLihBHaMGInytoa0yDp90G91knvAF1pd2
         /MFBfXjhoja5Lx5P7MaG32IaotWC2L2GpN7BlkdZny5mnBi4WAa9PhEZa44hINIIn9Xh
         K9UbgIxftP1yoR/XLZ5gmmHy92xS9FWyliJNbXdEUYB0EerBkL4qeQe9wiKdArBnxIB1
         x7SC8A+5t346SYXTvsxjAhPm6mKWkDJ4f+t7aYMxELYIvNVClbkxbbk1uGNkr2kNlEcZ
         0HmNRuYpTQs21eCKPv2U6nectszyJcwInrDys3DnLfI+Jo2pqh+a3GDTkq3G0aW6sQZQ
         Rs6g==
X-Forwarded-Encrypted: i=1; AJvYcCWa/KIkn+rv1hgegs6UgTPEpM1ZrrRi+ebKMCv018PmBV6r/0OnbOwncT7mLzyTXMDsSCMY/oA3kmP8U/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32Pp89JaF+JRtxu8mlj2xciBCYPmdqYLCKHp/KFRIvE8Oykoq
	SrhG0EoEjuRTek1YtXVKSW6BMaxYRkwrGTvj2lYy8qRWQlKRBfsPFXeAsz5as7clcs8qgGTDelx
	PnFSdVQ==
X-Google-Smtp-Source: AGHT+IGoxyiEdJHjsguM4HhfYAa3a3WGl9IwGzua+OMwKu3+3dxnKcX9NeqRP2yYPcwFhiCcHGTefjSDvqI=
X-Received: from pjcc13.prod.google.com ([2002:a17:90b:574d:b0:33d:813f:6829])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5241:b0:329:cb75:fef2
 with SMTP id 98e67ed59e1d1-340279e5c84mr1590788a91.3.1761611825209; Mon, 27
 Oct 2025 17:37:05 -0700 (PDT)
Date: Mon, 27 Oct 2025 17:37:03 -0700
In-Reply-To: <55461c549803e08db97528127c29e092c597adc5.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251017003244.186495-1-seanjc@google.com> <20251017003244.186495-25-seanjc@google.com>
 <55461c549803e08db97528127c29e092c597adc5.camel@intel.com>
Message-ID: <aQAQLzxyGFooGtNV@google.com>
Subject: Re: [PATCH v3 24/25] KVM: TDX: Guard VM state transitions with "all"
 the locks
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "chenhuacai@kernel.org" <chenhuacai@kernel.org>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>, 
	"maz@kernel.org" <maz@kernel.org>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"kas@kernel.org" <kas@kernel.org>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "maddy@linux.ibm.com" <maddy@linux.ibm.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>, 
	"zhaotianrui@loongson.cn" <zhaotianrui@loongson.cn>, "anup@brainfault.org" <anup@brainfault.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>, Vishal Annapurve <vannapurve@google.com>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025, Kai Huang wrote:
> On Thu, 2025-10-16 at 17:32 -0700, Sean Christopherson wrote:
> > @@ -2781,8 +2827,6 @@ int tdx_vm_ioctl(struct kvm *kvm, void __user *ar=
gp)
> > =C2=A0	if (r)
> > =C2=A0		return r;
> > =C2=A0
> > -	guard(mutex)(&kvm->lock);
> > -
> > =C2=A0	switch (tdx_cmd.id) {
> > =C2=A0	case KVM_TDX_CAPABILITIES:
> > =C2=A0		r =3D tdx_get_capabilities(&tdx_cmd);
>=20
> IIRC, this patch removes grabbing the kvm->lock in tdx_vm_ioctl() but onl=
y
> adds the "big hammer" to tdx_td_init() and tdx_td_finalize(), so the
> tdx_get_capabilities() lost holding the kvm->lock.

Ooh, yeah, nice catch, that is indeed silly and unnecessary churn.

> As replied earlier, I think we can just hold the "big hammer" in
> tdx_vm_ioctl()?

Actually, I think we can have our cake and eat it too.  With this slotted i=
n as
a prep patch, the big hammer can land directly in tdx_vm_ioctl(), without a=
ny
change in functionality for KVM_TDX_CAPABILITIES.

--
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Oct 2025 17:32:34 -0700
Subject: [PATCH] KVM: TDX: Don't copy "cmd" back to userspace for
 KVM_TDX_CAPABILITIES

Don't copy the kvm_tdx_cmd structure back to userspace when handling
KVM_TDX_CAPABILITIES, as tdx_get_capabilities() doesn't modify hw_error or
any other fields.

Opportunistically hoist the call to tdx_get_capabilities() outside of the
kvm->lock critical section, as getting the capabilities doesn't touch the
VM in any way, e.g. doesn't even take @kvm.

Suggested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1642da9c1fa9..43c0c3f6a8c0 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2807,12 +2807,12 @@ int tdx_vm_ioctl(struct kvm *kvm, void __user *argp=
)
 	if (r)
 		return r;
=20
+	if (tdx_cmd.id =3D=3D KVM_TDX_CAPABILITIES)
+		return tdx_get_capabilities(&tdx_cmd);
+
 	guard(mutex)(&kvm->lock);
=20
 	switch (tdx_cmd.id) {
-	case KVM_TDX_CAPABILITIES:
-		r =3D tdx_get_capabilities(&tdx_cmd);
-		break;
 	case KVM_TDX_INIT_VM:
 		r =3D tdx_td_init(kvm, &tdx_cmd);
 		break;

base-commit: 672537233b8da2c29dca7154bf3a3211af7f6128
--

