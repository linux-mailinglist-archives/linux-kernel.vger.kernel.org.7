Return-Path: <linux-kernel+bounces-681926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F6AAD591C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B0B17D251
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0B29ACE5;
	Wed, 11 Jun 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QK/oyMPI"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3626E6EC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652945; cv=none; b=KPtOmnYkzJ2Mh/rc4fbvExwhThESTUkJLGELB08L7Hr5xJFkMe0RUN+Az1gTMdeqiATFU22ZHJdiWZzLH9N09STBDjs4Yk2DkJbckNo1MSzSJukUS2uY6I8ZwwagmEyJWQGrYqj/evfXSgPFhGGuj5L8ttQQ9MmrWT0mud0DUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652945; c=relaxed/simple;
	bh=zCEWvs/JY83t/j+RYaEA0uMvBOcPh6cmXlF6nnaCKdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RBdiCl8LKMBkkAOHykdFWvelWHJ2dyYoIi9AFQ9qgr6XSeO6CknAcpW7pqn4rmP9u2vYP7DFNsQdbKCcyx4tmAz89MeOszWsIymuEfjiX8z6K8LlL4ZRMleKzxiO3h0YuO7XWuyrbv5AepUrLFrWj6gD7jEb5/VUjCrI5o8Nv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QK/oyMPI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2355651d204so61866155ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749652943; x=1750257743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eY++0CSHsQY8qViDldqqE5thr/OR/gppfXw2etaJRMQ=;
        b=QK/oyMPI38SgJN3mtgTTto03FInT+E2hYnG6GyLbYaLtv2IMcOyL/uvzR+Jn2HxCIB
         xP5Ppcigv7dXAP4qPt5y8Y7VxBIu147jYkrVHm3lZfCjQ8NtOfoiDUNF33yYZJ8tWu9n
         cXcGDw9WMNtTlUiLtGxF0LWx4Au0b6109siBxffb08WXcRiyLofndN+QygRVtpTH9gLr
         moHSR+opH5eLhzk/8Xc9/sq3IpzxDaAVyAGd5NlOzsbS8tSpE66by63CbtaQ6NAYCxfn
         yz1ltt/ON1DSg8rI9KSMHJwSNkjCaHeTzv3y8sNy+oZSXR2lfy/mnbHvdJcp7kaLV/H0
         SnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652943; x=1750257743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eY++0CSHsQY8qViDldqqE5thr/OR/gppfXw2etaJRMQ=;
        b=vkPqDWGmIGplumdte4yGKav8ZeGY1PwSEMrrVhiJkaWzl/64k1iau1DL0RTqQ/+7R0
         X8SqFgLRqCAcHZgWUJs/OGS9XLM8+4EuDFwFwjnXq65UjC/+U8lQY5Ohb6daO/weslVI
         G2+7e7Zha5z6cnTFsjq6WbVp45jw3A6L5DXwL1Wm5VTo+tn/fPeHAvMOHNH+hyV5woTB
         iOdvr1tFvW62ZlDIKD4HYxs6sUR/nxsd6RPcZpStK0TlP9ifhrII74quGvuD+ndOW6+W
         8rkO+5SIuOCpQ2v4eJmyMQ9y8DiKV4pVYa6mFkjcRWf9JryhSzfpUOC4SE5U578BUgX9
         uyzA==
X-Forwarded-Encrypted: i=1; AJvYcCUljgRBCOSTPN+0/q7Ptnh3DBfIxxzD41N+nOftR9VVQtk2B2NtFjQgDHjKCE0ILmTBE4QlMXVdrzmALAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYA0K3wBjGoBaNGgZmQ/MWVBkbmIIbFV2c8MXWE7O7DK7NjI34
	xBuDefil4a6+Fg5vJNC/pfHLRQ0RyeHbRC83q3CAQ2/E1Nh0qq5oROZTSZLIm3rY4CP9udi3Sjy
	bnTWryg==
X-Google-Smtp-Source: AGHT+IHwCeHTqCJwSYq3SAJPO5l3QHYykxj/hvfrOos5JnENkwJ/acSlv7bACcod9zCopR+jnOJcTkZWlvQ=
X-Received: from plbjy13.prod.google.com ([2002:a17:903:42cd:b0:234:b3fc:8229])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:192:b0:235:6e1:3edf
 with SMTP id d9443c01a7336-23641b1fd31mr54499455ad.34.1749652943298; Wed, 11
 Jun 2025 07:42:23 -0700 (PDT)
Date: Wed, 11 Jun 2025 07:42:21 -0700
In-Reply-To: <119e40ecb68a55bdf210377d98021683b7bda8e3.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424030033.32635-1-yan.y.zhao@intel.com> <20250424030618.352-1-yan.y.zhao@intel.com>
 <dc20a7338f615d34966757321a27de10ddcbeae6.camel@intel.com>
 <c19b4f450d8d079131088a045c0821eeb6fcae52.camel@intel.com>
 <aCcIrjw9B2h0YjuV@yzhao56-desk.sh.intel.com> <c98cbbd0d2a164df162a3637154cf754130b3a3d.camel@intel.com>
 <aCrsi1k4y8mGdfv7@yzhao56-desk.sh.intel.com> <f9a2354f8265efb9ed99beb871e471f92adf133f.camel@intel.com>
 <aCxMtjuvYHk2oWbc@yzhao56-desk.sh.intel.com> <119e40ecb68a55bdf210377d98021683b7bda8e3.camel@intel.com>
Message-ID: <aEmVa0YjUIRKvyNy@google.com>
Subject: Re: [RFC PATCH 09/21] KVM: TDX: Enable 2MB mapping size after TD is RUNNABLE
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Kirill Shutemov <kirill.shutemov@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Fan Du <fan.du@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	"david@redhat.com" <david@redhat.com>, Zhiquan Li <zhiquan1.li@intel.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>, 
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, Chao P Peng <chao.p.peng@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	"jroedel@suse.de" <jroedel@suse.de>, Jun Miao <jun.miao@intel.com>, 
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 20, 2025, Kai Huang wrote:
> On Tue, 2025-05-20 at 17:34 +0800, Zhao, Yan Y wrote:
> > On Tue, May 20, 2025 at 12:53:33AM +0800, Edgecombe, Rick P wrote:
> > > On Mon, 2025-05-19 at 16:32 +0800, Yan Zhao wrote:
> > > > > On the opposite, if other non-Linux TDs don't follow 1G->2M->4K
> > > > > accept order, e.g., they always accept 4K, there could be *endless
> > > > > EPT violation* if I understand your words correctly.
> > > > > 
> > > > > Isn't this yet-another reason we should choose to return PG_LEVEL_4K
> > > > > instead of 2M if no accept level is provided in the fault?
> > > > As I said, returning PG_LEVEL_4K would disallow huge pages for non-Linux TDs.
> > > > TD's accept operations at size > 4KB will get TDACCEPT_SIZE_MISMATCH.
> > > 
> > > TDX_PAGE_SIZE_MISMATCH is a valid error code that the guest should handle. The
> > > docs say the VMM needs to demote *if* the mapping is large and the accept size
> > > is small.

No thanks, fix the spec and the TDX Module.  Punting an error to the VMM is
inconsistent, convoluted, and inefficient.

Per "Table 8.2: TDG.MEM.PAGE.ACCEPT SEPT Walk Cases":

  S-EPT state         ACCEPT vs. Mapping Size         Behavior
  Leaf SEPT_PRESENT   Smaller                         TDACCEPT_SIZE_MISMATCH
  Leaf !SEPT_PRESENT  Smaller                         EPT Violation <=========================|
  Leaf DONT_CARE      Same                            Success                                 | => THESE TWO SHOULD MATCH!!!
  !Leaf SEPT_FREE     Larger                          EPT Violation, BECAUSE THERE'S NO PAGE  |
  !Leaf SEPT_FREE     Larger                          TDACCEPT_SIZE_MISMATCH <================|


If ACCEPT is "too small", an EPT violation occurs.  But if ACCEPT is "too big",
a TDACCEPT_SIZE_MISMATCH error occurs.  That's asinine.

The only reason that comes to mind for punting the "too small" case to the VMM
is to try and keep the guest alive if the VMM is mapping more memory than has
been enumerated to the guest.  E.g. if the guest suspects the VMM is malicious
or buggy.  IMO, that's a terrible reason to push this much complexity into the
host.  It also risks godawful boot times, e.g. if the guest kernel is buggy and
accepts everything at 4KiB granularity.

The TDX Module should return TDACCEPT_SIZE_MISMATCH and force the guest to take
action, not force the hypervisor to limp along in a degraded state.  If the guest
doesn't want to ACCEPT at a larger granularity, e.g. because it doesn't think the
entire 2MiB/1GiB region is available, then the guest can either log a warning and
"poison" the page(s), or terminate and refuse to boot.

If for some reason the guest _can't_ ACCEPT at larger granularity, i.e. if the
guest _knows_ that 2MiB or 1GiB is available/usable but refuses to ACCEPT at the
appropriate granularity, then IMO that's firmly a guest bug.

If there's a *legitimate* use case where the guest wants to ACCEPT a subset of
memory, then there should be an explicit TDCALL to request that the unwanted
regions of memory be unmapped.  Smushing everything into implicit behavior has
obvioulsy created a giant mess.

