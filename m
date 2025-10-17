Return-Path: <linux-kernel+bounces-858052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA18DBE8AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFB5E4F5DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C422331A40;
	Fri, 17 Oct 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNRGiHYq"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DE33033D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706010; cv=none; b=OPwRC5mC6nfGnMqIm8btF7MbymCYRMsCxxpoRPvNXE4jcVjAz/oddkhV8WOtxQDb0RtarRZevU9fVyfmaqKwwbOObQ5f6OjLrPTppR0kapjwiys3W8GH8hdby0MA5fifSxc8lR28aZzhEFpZt/zYhDDjKK+K0De2Wj5+qf65buo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706010; c=relaxed/simple;
	bh=TrjEM6d5YGsT/vS/4b6HKA867y/TiowVc5HcG6zK26k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lzjgot3zk7x4CnApQgRmWayHOTtYxKhq5EMd1ymECOg6ZnunLOD1356aMNPRrGrqLVEsqAbCNPMR42F4zmOCrEbHsG7bpmtwtH03BvNEDuta/OygbebmxSrejVeZU4enfYNOiU7NpCdoyyzkLEDmKRiZAkLecjuM+NSrDsZaFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNRGiHYq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso1339019a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760706008; x=1761310808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUZCvZegcXj7XnjfJMwDIAYl6hSvlcsfXFHMYRfMfEE=;
        b=iNRGiHYq2u0LF32kUHh0syK1DRh6+GntdVwbBnkQRVtQEpZ66sKxxYxRk7xGJb8eM0
         5R6ZaYEGhH74JPtfJWF3feWzCDG2fuv+HCEtIHRYaFggAP84uwT0xjC+jCVFUAYJbD4N
         xNzxqPyK6nWV3qLbNSeDVm8eVuaFttOFHBC8JWEw1ModNOO04sI8B4Sm7s1XB1k2tCMo
         6X8XTk3pW4fr+ZNqdqZ12xmUVqzjgWYflZtBnjSwZv3VZ607/1nz3vwaaONB0wQ8u4o3
         gdxie06dKVDJUf4aLL2wiUeuFRwSkZg93lTo2uUoh+PHmslG0a/22vdNNeeBbuKfKBjC
         SJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706008; x=1761310808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUZCvZegcXj7XnjfJMwDIAYl6hSvlcsfXFHMYRfMfEE=;
        b=GSr2UDJuBfroNZ5x/gTZStz1NXKvsVXuPHKMI30VrSFP4rwv8PhuBpEzLZ97nyYby3
         JYAUvxUl1NrPB0ShrFuQhOtA6SumLQnZCjeivxZrMhdC+EGfztaYgRJs9zYJJOyUAMOC
         ZtoKfaRpcwytMb21VGhxsV6wRUYJVisooUfkC6u2pVaFbuvxYhEHSzaIHgVa9MFOlv+j
         LETMJbiwaA0MjReAp/wzlN9NXigVjRLAWZ7/z2Sx2mmXk2sHYiVJx7dcEnYYoCWKxvkI
         S1p9HS9i58DOX+pK+bTKvXPalJiaWu+e6EeDSRmV0YMiXMUjobU0JrfgbHUZ8bOV94kn
         Mj9A==
X-Forwarded-Encrypted: i=1; AJvYcCVM4aCaK4cDLh2ImjrN32r1gYs1Nuqif6wQ/YgfzRmpCnkeSWgTlGCFfXgeUEYgK9vsvoDw4P9TQeX/siw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeImZivbPrRg1jWv/+7aqEl4XY80ynITEOw7XuWSMJOP7C5w7H
	KAg6GtYKoAFI5G3WHniAOXXzkjiUCjx47b/Ax6i0IyfYK5u7rvfnmNprsGv8FrOR4+0XGSBYO6D
	XSn4qrQ==
X-Google-Smtp-Source: AGHT+IGLI5QmCG55PPTkQ5mJ2PfNQXM41NATOrypdPmoCpqJirgnCyNoTTGdML7+fvfGa0KmmZ+U+lr/W+E=
X-Received: from pjbmr8.prod.google.com ([2002:a17:90b:2388:b0:330:49f5:c0a7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:394b:b0:2ea:41f1:d53a
 with SMTP id adf61e73a8af0-334a8620170mr5065867637.41.1760706008492; Fri, 17
 Oct 2025 06:00:08 -0700 (PDT)
Date: Fri, 17 Oct 2025 06:00:06 -0700
In-Reply-To: <2d00cefad4a5316357e76db7292e8d7ac2793eb1.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016182148.69085-1-seanjc@google.com> <20251016182148.69085-2-seanjc@google.com>
 <2d00cefad4a5316357e76db7292e8d7ac2793eb1.camel@intel.com>
Message-ID: <aPI91kOhPAK_Bkla@google.com>
Subject: Re: [PATCH v2 1/2] KVM: VMX: Inject #UD if guest tries to execute
 SEAMCALL or TDCALL
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Dan J Williams <dan.j.williams@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 17, 2025, Kai Huang wrote:
> 
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -6728,6 +6728,14 @@ static bool nested_vmx_l1_wants_exit(struct kvm_vcpu *vcpu,
> >  	case EXIT_REASON_NOTIFY:
> >  		/* Notify VM exit is not exposed to L1 */
> >  		return false;
> > +	case EXIT_REASON_SEAMCALL:
> > +	case EXIT_REASON_TDCALL:
> > +		/*
> > +		 * SEAMCALL and TDCALL unconditionally VM-Exit, but aren't
> > +		 * virtualized by KVM for L1 hypervisors, i.e. L1 should
> > +		 * never want or expect such an exit.
> > +		 */
> > +		return false;
> 
> Sorry for commenting late.
> 
> I think from emulating hardware behaviour's perspective, if L1 doesn't
> support TDX (obviously true), SEAMCALL/TDCALL in L2 should cause VMEXIT to
> L1.  In other words, L1 is expecting a VMEXIT in such case.

No, because from L1's perspective, the opcodes map to undefined instructions and
thus should #UD in L2.  There's no super explicit enumeration, but IMO it's fair
to say that for L1 to think the instructions exists, it would need to observe
IA32_SEAMRR_PHYS_{BASE,MASK} for SEAMCALL, and MSR_IA32_MKTME_KEYID_PARTITIONING
as well for TDCALL.  KVM doesn't emulate any of those instructions, and so L1
should never expect SEAMCALL or TDCALL to do anything other than #UD.

> Whether L1 can handle such VMEXIT is another story -- it may inject a #UD to
> L2 or may not (similar to the current upstream KVM), but it is L1's
> responsibility.
> 
> So I think while this patch certainly honors the correct behaviour for L2,
> it doesn't honor for L1.  But I think ultimately L1 should be the one who
> is responsible for emulating hardware behaviour for L2.
> 
> E.g., assuming we have a KVM selftest in L1 to test SEAMCALL/TDCALL in
> normal VMX L2.  L1 should be able to catch it's own bug when such VMEXIT
> isn't handled correctly.  But with this patch, L1 will never be able to
> catch this IIUC.

