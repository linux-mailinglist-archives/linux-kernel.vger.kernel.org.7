Return-Path: <linux-kernel+bounces-721803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7699AFCE1B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486CD1883AD3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95442E03F3;
	Tue,  8 Jul 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SP9ycgxx"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166D2DF3DA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985868; cv=none; b=t3vskCjrzmAqBiyY9jcyY5u2ApLNuA+4zwP27TENOeQmu5yipjSue6WbamZZn0MEwl7LGWcN1ZFImJ6Xeyj6pJbmCehPB7Kbic+TAjd2HDdmDv79oRql+Cx+MJ6MfhPEn0dJ3w86cmMNKOuJVedS9nKjetobm05oB0m797V6KZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985868; c=relaxed/simple;
	bh=TXEGRBsgm+n8P+t42R28we4U8CCik0hjXIM15uylAJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NJT5870Qw869fMo1llIrxB9cNDbLzGVOTFqovTpqpJMp9/lGTJISjjplvSbmkMUS8XxeBHJV4g+MYZpKqeWJ6vVrvVpQJGLkXj6GGAOpQA86YWY+Dk4vx8DgiydNQGZ/ALbc0SVQ/K6s3kYG7sC4vbR58uEIU3FvGY+L8tSJUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SP9ycgxx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748cf01de06so6949452b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751985866; x=1752590666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4Y0LHIYImOnqvxWJNSqr5NHEbLMZdgrbi8mWqVwvxE=;
        b=SP9ycgxxWe9uVDqLKT9uTgkRWv3yG8pB5WdXkOTT8grhG4s7QcHhSos1qYPoE6Z1Hd
         vb4nm45o4AHRi2Hsz0OEgup02EenohWOdAwVO3wBNGLE4H37W/fWR1rERjn69jIaK98l
         RLqcinvtVVYQ8qXJGcVYxKH709aiXBnUbn3fVQFFdagSsYfAWpK4DiJq6U1HCIGtsCHP
         8TME3OvW0X+LMpVVYIAn469JBEtjSi2UqqZN9BZEHcMDs91febIdzQetXqgJmWMCDsHp
         xtKckyXavrhDmvgtaUupof/MdHPWz+hYuaj4mE25G7idqQ/zttbeWk/DL+DOpf6oHopO
         aBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985866; x=1752590666;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M4Y0LHIYImOnqvxWJNSqr5NHEbLMZdgrbi8mWqVwvxE=;
        b=NJYJrXNIp/rc8ecjQaai0BiPUCNyAVlNGwI0SLdXaZ9EEd7ATl4Z4E2mjB26g7tk4J
         7Inb9D6S4dpl2yrVdrNBA6SXk07fpSrRWCTCYr+7UmXAYNwLo5KGQx93VOVxqT96X6zD
         lLuqaCtSLM+jh77FL/DmRH+xcAQ2P/XtbeYrvg2AiGagiOOBhGM06sNTJZc9kuvROIRU
         +h6t+svErZvgwy+9s6vgXHHk4sDldKyk/G7jSkB190zRf7JZg3JtluYDFmxJcGb1NwJc
         wzTAyb+K7S+Lv6fAIkyCs2JlW35/uEMDIrIT/IbvgQs9dW1MLsKZeh4KxKuk1dCK1DUx
         8gAg==
X-Forwarded-Encrypted: i=1; AJvYcCU8ofXCtn0B2l0bsYP0QSWnBHByepTug5F5KX2s9UNapEQYmbWDAe/+xJYutwPQizb145i12hEES4Tikuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJ9jAYxQ6z4X9AGBu9EagDykjeoOld3vrW60u9tUI84RyKlit
	9wExpfjA8QYNUdrE8m/9Ts1D2Hf1Jzf/3PilG/q4kq9XQ2de85bCxzk3UwJMgF6/bIIMsXYNniv
	oC3DEtw==
X-Google-Smtp-Source: AGHT+IEryFAJQIP1RYdnl3B5+MmSaaqt34bQLLxukJow6DGBXYKU32xvLqLVHhWhYnnjS3IC2/q6uMASVdg=
X-Received: from pfus6.prod.google.com ([2002:a05:6a00:8c6:b0:747:9faf:ed39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:80c:b0:736:5664:53f3
 with SMTP id d2e1a72fcca58-74ce6668f9cmr23430472b3a.15.1751985866098; Tue, 08
 Jul 2025 07:44:26 -0700 (PDT)
Date: Tue, 8 Jul 2025 07:44:24 -0700
In-Reply-To: <bdd84a04818a40dd1c7f94bb7d47c4a0116d5e5d.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708080314.43081-1-xiaoyao.li@intel.com> <20250708080314.43081-3-xiaoyao.li@intel.com>
 <aG0lK5MiufiTCi9x@google.com> <bdd84a04818a40dd1c7f94bb7d47c4a0116d5e5d.camel@intel.com>
Message-ID: <aG0uyLwxqfKSX72s@google.com>
Subject: Re: [PATCH 2/2] KVM: TDX: Remove redundant definitions of TDX_TD_ATTR_*
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"hpa@zytor.com" <hpa@zytor.com>, Tony Lindgren <tony.lindgren@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2025, Rick P Edgecombe wrote:
> On Tue, 2025-07-08 at 07:03 -0700, Sean Christopherson wrote:
> > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > > index c539c2e6109f..efb7d589b672 100644
> > > --- a/arch/x86/kvm/vmx/tdx.c
> > > +++ b/arch/x86/kvm/vmx/tdx.c
> > > @@ -62,7 +62,7 @@ void tdh_vp_wr_failed(struct vcpu_tdx *tdx, char *u=
class,
> > > char *op, u32 field,
> > > =C2=A0=C2=A0	pr_err("TDH_VP_WR[%s.0x%x]%s0x%llx failed: 0x%llx\n", uc=
lass,
> > > field, op, val, err);
> > > =C2=A0 }
> > > =C2=A0=20
> > > -#define KVM_SUPPORTED_TD_ATTRS (TDX_TD_ATTR_SEPT_VE_DISABLE)
> > > +#define KVM_SUPPORTED_TD_ATTRS (TDX_ATTR_SEPT_VE_DISABLE)
> >=20
> > Would it make sense to rename KVM_SUPPORTED_TD_ATTRS to
> > KVM_SUPPORTED_TDX_ATTRS?
> > The names from common code lack the TD qualifier, and I think it'd be h=
elpful
> > for
> > readers to have have TDX in the name (even though I agree "TD" is more
> > precise).
>=20
> It's useful to know that these are per-TD attributes and not per-TDX modu=
le.
> Especially for TDX_TD_ATTR_DEBUG. I kind of prefer the KVM naming scheme =
that is
> removed in this patch.

Heh, as does Xiaoyao, and me too.  I thought I was just being nitpicky :-)

Though in that case, I think I'd prefer KVM_SUPPORTED_TDX_TD_ATTRS.


