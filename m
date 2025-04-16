Return-Path: <linux-kernel+bounces-605488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3787A8A20F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 16:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010FD441015
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD52BE0EE;
	Tue, 15 Apr 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Mvs+KGy"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6429E047
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728923; cv=none; b=QAlmE6yJ2NUHsZJr1OkkYZpMXccFAxuuLhoFb88P9dU+osicq6Rro0jZKweV4jePWxD2v5MIzHX/BfLC18B7gjwIpDj9xfCdxL+PHpI+kagIH45UT4dKZhPLKqLZesJzQcNZc5jdpW09E4SI9VC9GuXi3lcH4yS5I+Z+ToQKCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728923; c=relaxed/simple;
	bh=Z25BFswi+RwDu8PUjbMKkshugsl78jlSI7Z+pvioYuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tar71aI4Efi8PLyOjP2yq1L7cNxGa7meYj7uNbs2ok2kF0Xyq+XjA9mT3hhHtcCUc776SNq5E+0f4KmYHi29JzKkEoVBG47Shp0BOnzaiB62FZVS0cDnfpWuegvfH8ccKxgUG5w1pEIkkIAyo2qbqlHjg7JH/E1hfugc/Y6IGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Mvs+KGy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22651aca434so45952085ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744728920; x=1745333720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OuRBmgEllaRB5ZjobobNvVAEpYQN/37Jjkyiax0k//A=;
        b=1Mvs+KGySCyCiakIyxepQ/tlcwnxflO1IOuKe2sYwwNF8Mwzi4ydXykI547h7M8ZFW
         gxAnYPpT0Bc06swPzD0wmHdwuuHrSLZtHTLHq4/uzucyyGQErXX6ApWFERmfQTQGyYTG
         qoo3QfqD5niNGerIu7zB5GU7bnieu3G0cMh3/CcaO9j1t3m0XDnBFqL8u5XDc/+fJSEV
         i0EZ7Oq9ukuxCVTFqR6tmVHxFnkfVpnJ8otA44lqcd/5h5ZO5vJ8e5HHynu4SLvPejYO
         ND2GIGXLJ41Kswdp5SaDQMAkL1ST985O3J94ivNhWPjU9048cZy63C7by4fepcj1c+zS
         wVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744728920; x=1745333720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OuRBmgEllaRB5ZjobobNvVAEpYQN/37Jjkyiax0k//A=;
        b=OXm//s2OPXyq7Kl6tIIsdfIpg3vfXHHSKaaVvhEu1YbxzDDbjKTUswyuDBNlbi2/uY
         o6p2auRmLoxEpRBHJmwFtQkneANgwoIKBuhha6daQOyFODz8wpC460e0jzf/DEZEErUu
         4eD93wu6DFND2sX903nK6neCOKw3YOKYTqdnY6PP9EDJfvEdEi4+uz0V0z22Nq7KUqeu
         urG3szZzLlAFfjNhDtX1AihfCHHPX4CzQn8uRCSwCzrA2X5TP5jXBR+yBfCbx9nj129s
         8K2UmhsT+56NoaNFGu7MwCSMyWQ8wTG6NyhN1cdERubWghEMMdwSnRVPN8O37Rf4p9nu
         K2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUrfQUcpjTDHqSstTuYsQSmgkqeprm/JDmwfaG6rNUNBextyGdafykL7JhZxgJU46PyD/55EWmQV0klqis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5jx1FJZS3xd46igsHIn+Bm2vdH8hH/b7dKGmVygdO73kqav0
	DwBzR5JTqNuaD7XYs5RpN7uUAwlECIx9LYhFtm4gEuzs9WAvLStFYtVjTYRfQFY1wm3YrX7I/KR
	LBQ==
X-Google-Smtp-Source: AGHT+IHH7mC1r9KS9+glc9Ei4mef4Tc//vYXWsg5yzy8MKjIFibb6b+8ibiq0JLHt6znMV7vWbcfa+6TwQ0=
X-Received: from plev19.prod.google.com ([2002:a17:903:31d3:b0:224:efa:ef21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2345:b0:224:1af1:87ed
 with SMTP id d9443c01a7336-22bea4c71e9mr252498545ad.27.1744728920241; Tue, 15
 Apr 2025 07:55:20 -0700 (PDT)
Date: Tue, 15 Apr 2025 07:55:19 -0700
In-Reply-To: <d345b636-792f-4762-8c6c-2a7252294068@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-12-seanjc@google.com>
 <d345b636-792f-4762-8c6c-2a7252294068@amd.com>
Message-ID: <Z_5zV_59D3a4ySW0@google.com>
Subject: Re: [PATCH 11/67] KVM: SVM: Delete IRTE link from previous vCPU
 irrespective of new routing
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 15, 2025, Sairaj Kodilkar wrote:
> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> > Delete the IRTE link from the previous vCPU irrespective of the new
> > routing state.  This is a glorified nop (only the ordering changes), as
> > both the "posting" and "remapped" mode paths pre-delete the link.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/svm/avic.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index 02b6f0007436..e9ded2488a0b 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -870,6 +870,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
> >   	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
> >   		return 0;
> > +	/*
> > +	 * If the IRQ was affined to a different vCPU, remove the IRTE metadata
> > +	 * from the *previous* vCPU's list.
> > +	 */
> > +	svm_ir_list_del(irqfd);
> > +
> >   	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
> >   		 __func__, host_irq, guest_irq, set);
> > @@ -892,8 +898,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
> >   		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
> > -		svm_ir_list_del(irqfd);
> > -
> >   		/**
> >   		 * Here, we setup with legacy mode in the following cases:
> >   		 * 1. When cannot target interrupt to a specific vcpu.
> 
> Hi sean,
> Why not combine patch 10 and patch 11 ? Is there a reason to separate
> the changes ?

To provide distinct bisection points if one (or both) changes introduces a bug.

Patch 10, "Delete IRTE link from previous vCPU before setting new IRTE", is a
non-trivial change in how KVM tracks per-vCPU IRTEs.

This patch is also a somewhat non-trivial change, in that removes IRTEs from the
per-vCPU list even when the new routing isn't an MSI.

Ah, but the changelog for this patch is wrong (I wrote a number of the changelogs
several months after I wrote the code, ugh).  Either that or I've now confused
myself.  I'll stare at this a bit more and rewrite the changelog unless current
me is the one that's confused.

