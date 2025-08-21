Return-Path: <linux-kernel+bounces-780663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB57B307B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144D2B021CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F39393DD3;
	Thu, 21 Aug 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvj99zj8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E739393DC3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809290; cv=none; b=X0TvZBhkj/Gk1/ZOPnCtiN19k6w/pnbT3E8vVyAXjs7Q2wz3rh8DPcWKEbSWzobHMMDxt+F/jzTWSdm92ag88ooEwv0Y/KXmgrLC5JfrqaZMG3RAsEcO23ULEbRl5bGkr6eaHRDfYviyXg5s4XY5GEeaWKenBJluBaZOs7cGRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809290; c=relaxed/simple;
	bh=u0qAFg0w6DmFqgeo+FGgznU5nyNw2qIKOCtpovYVDJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMNuaO/WDi35fafBNO/O87Ns/nHonkRQ6oGqqmR2RFpmeXvMhsO9SWJ5+jYY0hIu68coltD60qiIW0A2rof1vBMZVjhd5DfufFuPYfV9PXuwi/7j6jxnNRKlevKbZiaDj88OUE6/EiuM5Hev2nB7xlOgvZYXKiqVW2jCKT3PsuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvj99zj8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266a1e87so1420775a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755809288; x=1756414088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ND27ByCi8FxwH4N1fs9wDJsbh1LvmHDFCkk7m0bPpgk=;
        b=dvj99zj8vezlHLoH5NHuy2+9ETUxhDg32on5TGo70m8+ahudruXx9XoX/elTkgAdiX
         Di0y7/fFrbwaywmsz5nsalM0a8OoPfUM4u8ESQgE14VYNafB75VhpERuaYahEFnNKMxF
         nEuz5dN0IdK7Ds+b/WBmIb8vZMzSNa7hIDxwDr7P53duHPJ+fR3sRboCO9SP+JV8w4X+
         N9ew99oXj4eKXIQz63WO+y0vlQRrDazyjUmLVEXUw3qzuHLI7lCrKnn++GnZZlLrLrS1
         Hv65psQs8X+AecSCXRAblnAlW8Oxi4L8fVbLjKa01OhQqP6mAQwgCIPa24ak2qlaRqDq
         zhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755809288; x=1756414088;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ND27ByCi8FxwH4N1fs9wDJsbh1LvmHDFCkk7m0bPpgk=;
        b=Nrih4COFFRz55/rFaCGM22e5+qj1mWI5wRYsadK0HiSlda1+40LRQuIegQ5Eyf0ACn
         eHyrZKsiBv3X7OoE5t1CbOlN9f+SF0FsPNgCE1WNOxEThf4uMo57/4ijVm6ahoSrWXZn
         /zF2k181z8Vu0XNQ162Y0FEH6YKSLJIGapWXcX+Mf+T665TY8X0fMUhwXoZ80M3ZOV/D
         mVQXu8c+Hs8p3aZaS3/ovIJR5BX76sAyb3uX3FUjCN+fh+Spnr2zhfDYHHTkGprI695H
         xQaSBJiBx6P3AROWFZ54k3f8hr40i0iU5eaziN/aptmEo/M18Molcfhzs78ux3slgiIB
         2UsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV77rDAUUh+6oahPtF8hhLiTeZ2rDngSnWQsf9XgpxDq1b23N3yjbziO6r3npzNjs+EhgEU9bHQohAS9DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzioMiSrnOXSdYf40Y7+Sa0rcdfQ50LLcTdOkumDoIC+JN7ItvV
	sFd4ygq+tX+tiKhdvqG70MZV/lE7Imy9TkRXiKpuhJOKHSoavDT3BQS51ZS1zYoYKl1MgheCLXH
	LDWLhOg==
X-Google-Smtp-Source: AGHT+IGb8bllN3WweHljCycX2OTDOIuqByEGF5OmfEKIoI89t/XTtEhC0baTzcLsE02jx1iDQuQe88zLHuI=
X-Received: from pjq16.prod.google.com ([2002:a17:90b:5610:b0:312:15b:e5d1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3952:b0:321:3715:993
 with SMTP id 98e67ed59e1d1-32515e48ec5mr1174634a91.14.1755809287794; Thu, 21
 Aug 2025 13:48:07 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:48:06 -0700
In-Reply-To: <6783241f1bfadad8429f66c82a2f8810a74285a0.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250816101308.2594298-1-dwmw2@infradead.org> <aKdIvHOKCQ14JlbM@google.com>
 <933dc95ead067cf1b362f7b8c3ce9a72e31658d2.camel@infradead.org>
 <aKdzH2b8ShTVeWhx@google.com> <6783241f1bfadad8429f66c82a2f8810a74285a0.camel@infradead.org>
Message-ID: <aKeGBkv6ZjwM6V9T@google.com>
Subject: Re: [PATCH v2 0/3] Support "generic" CPUID timing leaf as KVM guest
 and host
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, graf@amazon.de, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Colin Percival <cperciva@tarsnap.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025, David Woodhouse wrote:
> On Thu, 2025-08-21 at 12:27 -0700, Sean Christopherson wrote:
> > =C2=A0
> > > The problem with that is that it's been quite unreliable. The kernel
> > > doesn't trust it even on chips as recent (hah) as Skylake. I'd be
> > > happier to trust what the hypervisor explicitly gives us. But yes, it
> > > should be *one* of the sources of information before we reverse-
> > > calculate it from the pvclock.=20
> >=20
> > Sorry, by "the VMM use" I mean have the host, e.g. QEMU, explicitly def=
ine TSC
> > frequency in CPUID.0x15 and CPU frequency in CPUID.0x16.=C2=A0 And then=
 on the
> > KVM-as-a-guest side of things, trust those leaves when they're availabl=
e.
>=20
> Those leaves are untrustworthy on hardware. Are you suggesting that the
> kernel should trust them when it detects that it's running under KVM,
> on the assumption that KVM will have corrected them? And that KVM will
> be fabricating them even on CPU models which didn't naturally have
> those leaves? And that in the presence of TSC scaling, those leaves
> will show the right values for the guest even on hypervisors running
> today?
>=20
> I'll be surprised if that works out well.
>=20
> I think I'm a lot happier with the explicit CPUID leaf exposed by the
> hypervisor.

Why?  If the hypervisor is ultimately the one defining the state, why does =
it
matter which CPUID leaf its in?

