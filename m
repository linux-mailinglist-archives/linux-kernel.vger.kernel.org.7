Return-Path: <linux-kernel+bounces-791889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B82BB3BD5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBA75679EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B8F31E119;
	Fri, 29 Aug 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ymp+EyqE"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8F31E108
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477158; cv=none; b=Xto4TJzCxGf/00/ySTQz18xkjlcwdH7M1aPbdcJR00zHLT+oVJvevh95TnGjDHZiIU5LMqXpHjqGdqfBYKRexEfvxCFRwXqk9mbJnQFPLneuoOae4go0lNfNRZKZVH6FZGVfR+xYpGavbDHX3r94aaSxbnidIdmhFUbyze3S/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477158; c=relaxed/simple;
	bh=1Pf4kWGF8Nl6Fz5LD6iSs09KK9VBlttvZCY110akIYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Af26sPnTXObUJ5A/AopJ1JDZabPsQb3teFU2q653s4T6UZJGOBgTOldsl7DOI7VlP0rKDATt2Qum6sYW1fxlZV8ZtZiYXgnI4XBEItE5dsbaAmspYL0SktvUvE0+JkXVrcqmxfZli54tpv9p8yK6gZXZ4cB+j4fgiGnMmVfhOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ymp+EyqE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327706e0642so3628149a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756477156; x=1757081956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j21crHF1Yk5JFqIlz5UrZbt7K7r61xcnF+akUnmAGnM=;
        b=ymp+EyqEmHqIcF7YhOUpYc2IfY207nJEUMzRRyLarixg7mWwWJDQW/2rD2fMkIkIhO
         6dlw8KUhHCW2kMBYeXeJgTnyA7wn2ioE3XdLy9i1dGhpy+13N1N7+JdZtfkyV+VcDR1u
         2ooZOiRUtK2lmyQW/CH4+w6mINng1mQS/sR09bPBFTx4dVTxP69k+cyKYOpoqxtw53l0
         n2Skomv0mfDY24bTA6xI1Vwpnm2G9uvWtymQni/oUbQiu887+xoJJ6Ln+PuUqHoYNqMX
         lZB6yEGWuvb4KxXPqWeycnojnWSe4ydPltB+askrntsH/QQ2t8VKuHVOksyZTpbf25Ne
         6Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756477156; x=1757081956;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j21crHF1Yk5JFqIlz5UrZbt7K7r61xcnF+akUnmAGnM=;
        b=tGXHagT9so7xUEOeSxIjn7IWcWAmZBHEkB5bNbcClkHRhayGGfMSLrjwXPWyjmnGxQ
         8lQQutZM9Bhba8yFnKZgPQYhvYj9KuFAPU8Uz7UNR47d9Pfc8iThgqfDR38q4MwU+8xI
         I514jz5QcAqShyyZ08NYVJluhuvTt0SXvxCyzRekwgSLjYuB60Gkjr/954fwUC+LCDJh
         GciFajfQaHYPALbFtP5HfJC1og3El0cbO9MOBhHoeTRcXwJ7RVgnd+SE9k1uiHWIXsiM
         NK1XkSfFpd0ePjm4Jhmb7Pq6dTHiUErim4g6iREWNeC0C7qroUdWtxRd6Mf3oPvhfTMm
         99lA==
X-Forwarded-Encrypted: i=1; AJvYcCXorI1KGapP6COgBHmURQob+H/j6oYBWoh7Jr06/nDkOf8nPgo4I9oXqvc0VfGUY064JXXXwVsyBO+ELtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY9+FlxjuZdIfudp0XVFwSIIDGteEIVfQTtFxmXSabhD222l5l
	XqQOi+yToy8UMoYLQAT7C48kTfHUgajB3tlZPXxToBu6lCuEc7RcwuFXFN0hl97BvGJLpp3Rduh
	cjcAajQ==
X-Google-Smtp-Source: AGHT+IHQCGK1n8ucMTSWAAVaO3wbmZ1keEusOyRlTN9padDWnDkB4uZOVUdZ5WjrRzkzASPAQVQOPvuz1VQ=
X-Received: from pjbqx12.prod.google.com ([2002:a17:90b:3e4c:b0:31f:6a10:6ea6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fd0:b0:325:c92:4a89
 with SMTP id 98e67ed59e1d1-32515e3cad8mr32112898a91.5.1756477155808; Fri, 29
 Aug 2025 07:19:15 -0700 (PDT)
Date: Fri, 29 Aug 2025 07:19:13 -0700
In-Reply-To: <fcf19563-df65-4936-bd08-46f1a95359af@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com> <20250829000618.351013-16-seanjc@google.com>
 <fcf19563-df65-4936-bd08-46f1a95359af@linux.intel.com>
Message-ID: <aLG24VoWbrB5e-K4@google.com>
Subject: Re: [RFC PATCH v2 15/18] KVM: TDX: Combine KVM_BUG_ON +
 pr_tdx_error() into TDX_BUG_ON()
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025, Binbin Wu wrote:
> On 8/29/2025 8:06 AM, Sean Christopherson wrote:
> > Add TDX_BUG_ON() macros (with varying numbers of arguments) to deduplic=
ate
> > the myriad flows that do KVM_BUG_ON()/WARN_ON_ONCE() followed by a call=
 to
> > pr_tdx_error().  In addition to reducing boilerplate copy+paste code, t=
his
> > also helps ensure that KVM provides consistent handling of SEAMCALL err=
ors.
> >=20
> > Opportunistically convert a handful of bare WARN_ON_ONCE() paths to the
> > equivalent of KVM_BUG_ON(), i.e. have them terminate the VM.  If a SEAM=
CALL
> > error is fatal enough to WARN on, it's fatal enough to terminate the TD=
.
> >=20
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/vmx/tdx.c | 114 +++++++++++++++++-----------------------=
-
> >   1 file changed, 47 insertions(+), 67 deletions(-)
> >=20
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index aa6d88629dae..df9b4496cd01 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -24,20 +24,32 @@
> >   #undef pr_fmt
> >   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > -#define pr_tdx_error(__fn, __err)	\
> > -	pr_err_ratelimited("SEAMCALL %s failed: 0x%llx\n", #__fn, __err)
> > +#define __TDX_BUG_ON(__err, __f, __kvm, __fmt, __args...)			\
> > +({										\
> > +	struct kvm *_kvm =3D (__kvm);						\
> > +	bool __ret =3D !!(__err);							\
> > +										\
> > +	if (WARN_ON_ONCE(__ret && (!_kvm || !_kvm->vm_bugged))) {		\
> > +		if (_kvm)							\
> > +			kvm_vm_bugged(_kvm);					\
> > +		pr_err_ratelimited("SEAMCALL " __f " failed: 0x%llx" __fmt "\n",\
> > +				   __err,  __args);				\
> > +	}									\
> > +	unlikely(__ret);							\
> > +})
> > -#define __pr_tdx_error_N(__fn_str, __err, __fmt, ...)		\
> > -	pr_err_ratelimited("SEAMCALL " __fn_str " failed: 0x%llx, " __fmt,  _=
_err,  __VA_ARGS__)
> > +#define TDX_BUG_ON(__err, __fn, __kvm)				\
> > +	__TDX_BUG_ON(__err, #__fn, __kvm, "%s", "")
> > -#define pr_tdx_error_1(__fn, __err, __rcx)		\
> > -	__pr_tdx_error_N(#__fn, __err, "rcx 0x%llx\n", __rcx)
> > +#define TDX_BUG_ON_1(__err, __fn, __rcx, __kvm)			\
> > +	__TDX_BUG_ON(__err, #__fn, __kvm, ", rcx 0x%llx", __rcx)
> > -#define pr_tdx_error_2(__fn, __err, __rcx, __rdx)	\
> > -	__pr_tdx_error_N(#__fn, __err, "rcx 0x%llx, rdx 0x%llx\n", __rcx, __r=
dx)
> > +#define TDX_BUG_ON_2(__err, __fn, __rcx, __rdx, __kvm)		\
> > +	__TDX_BUG_ON(__err, #__fn, __kvm, ", rcx 0x%llx, rdx 0x%llx", __rcx, =
__rdx)
> > +
> > +#define TDX_BUG_ON_3(__err, __fn, __rcx, __rdx, __r8, __kvm)	\
> > +	__TDX_BUG_ON(__err, #__fn, __kvm, ", rcx 0x%llx, rdx 0x%llx, r8 0x%ll=
x", __rcx, __rdx, __r8)
> > -#define pr_tdx_error_3(__fn, __err, __rcx, __rdx, __r8)	\
> > -	__pr_tdx_error_N(#__fn, __err, "rcx 0x%llx, rdx 0x%llx, r8 0x%llx\n",=
 __rcx, __rdx, __r8)
>=20
> I thought you would use the format Rick proposed in
> https://lore.kernel.org/all/9e55a0e767317d20fc45575c4ed6dafa863e1ca0.came=
l@intel.com/
> =C2=A0 =C2=A0 #define TDX_BUG_ON_2(__err, __fn, arg1, arg2, __kvm)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 __TDX_BUG_ON(__err, #__fn, __kvm, ", " #arg1 =
" 0x%llx, " #arg2 "
> =C2=A0 =C2=A0 0x%llx", arg1, arg2)
>=20
> =C2=A0 =C2=A0 so you get: entry: 0x00 level:0xF00
>=20
> No?

Ya, see the next patch :-)

