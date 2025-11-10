Return-Path: <linux-kernel+bounces-894026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4122CC491B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91CA14EE51C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51710337BBD;
	Mon, 10 Nov 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cqKEJBIf"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF34336EF2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803669; cv=none; b=g8YzDuP0/Kn9A0iCWuN0bhkJM+7pQwCPAxNZWqSDRnUv6Ev6WihbGAPvyLd/B69aMWrOooKty7MiiFgEZx0/+qpVf0lzmhjX1xJ4j8LMgywRXPt1FYGaThFPA8zfuM6L3rlXZthxJ3aF4qXdjVDU3EUOlflHd5rUBD/oFSPUt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803669; c=relaxed/simple;
	bh=NnkJtR1oPX8Vg32hYhg8dnYxREMtPdCn9wDFrrMg9Vo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nGoHKFUq9rhR+c38f1LHvFO78VgJ5RyPF30hmLXLBeGeZ3LWJABUyNWUp7bYlz/Yp7Et8h8HHQzUPBWp6MPxvGmGNmRXV/UXvmK0Cx1WTXxopIr0l5UMOTujVUJtRxyP4SRPveorhXKkBEqzhPHMJXnyDb9NeSKVps5OUcnIYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cqKEJBIf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-298389232c4so6651865ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762803667; x=1763408467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUwPNWWmOW3pd5l2CT7ssinM/6ZdDeR72Ykm+TYUwWo=;
        b=cqKEJBIfgDaTOBcaPhTP7kwJlsQfFxM8qUbMjwp7KOpfNxWJRES59ARH7DJYjDiYiN
         jakSft2AcqmtDRVVthiylLER9YxvNaGVaKT6Syfu74AKdNHzLHXd/00zgUdF1TA7qD65
         i60JmhSAtYyKZ1V5HxYEh9atwIS7hHJp/zkFG1DzqQuNz9qpSUJpZvTQ2+jj3RDFmySl
         Y1PvcWUPrvi7SaVsa3YRh9ARsETCKk3vM98nUhW18SPQHbCy9b1/AXFBN47GjpxrzE71
         uDIWu+rUshvPq1ZmfxCGyMLfLtd83wII3jiOD7aOtrOfgwTnAMYiATQJKJDvEoZsZfEf
         XoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762803667; x=1763408467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUwPNWWmOW3pd5l2CT7ssinM/6ZdDeR72Ykm+TYUwWo=;
        b=Cwvzr2Wvb85yxJr+aC8voSGi7d+ITNxt2Er97njoiASIGQZsvT9TtVBoC+slzcEcNq
         49JP4zta1Z7aY9ToKDR96/0O9nZl0x3m3HqgYtPIrcP/lFbYPrdpVstgD3Pr3uaoKxbm
         xRNqIGUGzXBAH/F6Hwqu/vCk2IXj/FkRjA3m9VScGTYAXjGc6df1lQpO3fpqzStT9AH9
         pMCVCDrtFvRjQIBEvJpkoMz1CRagMYJfM2QL/TS8bNaOGUuXPOgk8t28I3QFwgxmKjCk
         lIV0euANesNwbomuB8JbpswDnsw3bsDRFosmzc+Ebd1oxNPlCPNAH5DhMS+SoZM0R8AI
         qumA==
X-Forwarded-Encrypted: i=1; AJvYcCV5aC/gbOTvtZEsyTdAdRmyL93icVxQNT5Jo1dUCNUDexUjIslALtcZlsdKPRHS9TVRHaIhRH7zXc0sw84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/9eoY5iqP8YZ2ixyTDsnKJZ+8nfYEAwgjB9LnZQmH8nEPl08
	y8jHLpU/loIJgrS1HOifCH3FBgAz9kGJYpz6g9KGj+r5YgInjBEkD+BranzUh5FIHyD7YxVyX9a
	U7NIakA==
X-Google-Smtp-Source: AGHT+IHTHaeqO0F5lnLpu0zRwAA/BGhqiU5wQzy/YxVtGcNDV4aiFHNbTgZVxs4VXB6ZGlzj/1a8X1wRZc8=
X-Received: from plly22.prod.google.com ([2002:a17:902:7c96:b0:298:1c6f:3c06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ec4:b0:297:ddb6:ef81
 with SMTP id d9443c01a7336-297e562ee0fmr138383975ad.16.1762803667392; Mon, 10
 Nov 2025 11:41:07 -0800 (PST)
Date: Mon, 10 Nov 2025 11:41:05 -0800
In-Reply-To: <dyfu7nopxqtdw6k6s37dmq3wedqua2risfgolsltepykffqjkp@ij3ogvhxpvrg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251108004524.1600006-1-yosry.ahmed@linux.dev>
 <20251108004524.1600006-5-yosry.ahmed@linux.dev> <be2a7126-2abc-4333-b067-75dd16634f13@redhat.com>
 <dyfu7nopxqtdw6k6s37dmq3wedqua2risfgolsltepykffqjkp@ij3ogvhxpvrg>
Message-ID: <aRI_0dBWvyu5HjTd@google.com>
Subject: Re: [PATCH 4/6] KVM: SVM: Switch svm_copy_lbrs() to a macro
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 10, 2025, Yosry Ahmed wrote:
> On Sun, Nov 09, 2025 at 08:59:18AM +0100, Paolo Bonzini wrote:
> > On 11/8/25 01:45, Yosry Ahmed wrote:
> > > In preparation for using svm_copy_lbrs() with 'struct vmcb_save_area'
> > > without a containing 'struct vmcb', and later even 'struct
> > > vmcb_save_area_cached', make it a macro. Pull the call to
> > > vmcb_mark_dirty() out to the callers.
> > 
> > The changes to use `struct vmcb_save_area_cached' are not included in this
> > series, so they are irrelevant.
> > 
> > Since I've applied patches 1-3, which fix the worst bugs, there are two ways
> > to handle the rest:
> > 
> > * keep the function instead of the macro, while making it take a struct
> > vmcb_save_area (and therefore pulling vmcb_mark_dirty() to the callers and
> > fixing the bug you mention below).
> > 
> > * you resubmit with the changes to use struct vmcb_save_area_cached, so that
> > the commit message makes more sense.
> 
> I can include patches 4-6 with the respin of the series [1] that has the
> changes to use `struct vmcb_save_area_cached`. That series origianlly
> had the patch to switch svm_copy_lbrs() to a macro, but I moved it here
> to use for the save/restore patch. I was planning to rebase [1] on top
> of this series anyway.
> 
> There is a hiccup though, I assumed everything would go through Sean's
> tree so I planned to respin [1] on top of this series. Otherwise, they
> will conflict. With the first 3 patches in your tree, I am not sure how
> that would work.
> 
> I can respin [1] on top of Sean's kvm-x86/next or kvm-x86/svm, but it
> will conflict with the patches you picked up eventually, and I already
> have them locally on top of the LBR fixes so it seems like wasted
> effort.
> 
> Sean, Paolo, how do you want to handle this?

Base your patches on kvm/master, assuming there's nothing in kvm-x86/svm that
you need.  I can create a one-off branch, e.g. kvm-x86/lbrv, based on kvm/master
or 6.18-rc6.

