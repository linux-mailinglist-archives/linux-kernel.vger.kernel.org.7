Return-Path: <linux-kernel+bounces-848751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B5BCE7ED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8363919A708B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA97255F2C;
	Fri, 10 Oct 2025 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTnDlvCH"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17D34BA59
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760128397; cv=none; b=EvmmuEki9NQGbgdR36pC2mOxrCVh/YXrWo5nZ2tuJdiF41JuntfZocXuDzneBrj+HkRZjOPh663/TKuc9595XzsYu3dAXxzsyUDII3W5h740qCICI8U77GBifmfJ2FHDGxg9EnvJlp+O371Lqmom0DPp/61pYpSi+JX3KDUt4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760128397; c=relaxed/simple;
	bh=X0w1t+jGMBVtCc8oN5Do4EjNj28nEcw8nzBfMN0pS4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gfchBvC/BvzBv5LKMhV8vIUSHZ713/hS+uycyyp4jX7C0NxxDUWG9J9D5Pl0d2Ck16YFn2ELwZhPUak5WN2JqBDaM9FsAQzo1ROI7ZnTOZR411pvhMHcd7bqG0KoXOVja+WO15M2GWYwH+ki5Si2TILsuArvtzehi6diWTEC0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTnDlvCH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27ee214108cso95853975ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760128396; x=1760733196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L4WKjl2E9WbuIFhs5JLmpEcHpxZyN+nyEAJYdJG5kGQ=;
        b=BTnDlvCHTCzZ/IjJDge92oDf7D0yMnjk5tLq8t6Yl05Yng5RjVKzeZfvyexDqJU5JI
         wuooeDGF4eGq2zUX0/Cqdbg4eCXA/iKDqGc7cvCL7SIhAtmRWtd6Flx6TGD+pFdvRiGV
         TOgeDowAO7/yPnIJ7BdGoVK+C8BmibggeAy5BC+apOeeDoDSqkeM5UId7t98OGJMWU2a
         AH1KAvT7uGp2FH3nZ2HCOczspxx51EnR46c4MznRFE7LskM6vFdwl2gxkrKfY0zp7Txo
         JXCfCtJVoRIx4SyiqYHeUBurRc9R9TWfxe+V4sxWD1af/V4vNjujp+jtayrTv0eeNz55
         Y4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760128396; x=1760733196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4WKjl2E9WbuIFhs5JLmpEcHpxZyN+nyEAJYdJG5kGQ=;
        b=W1JlKfrSsqVcuIn9KME3thds1wPMqrRwSO7AEW7fLdS1R9uB7pIGoSJoSjW9M/yBZW
         WRtoG2BmcSwQoPbeJvNYxQORXP9REC0QE99s+bOtuGYky5GqgNeYNUJOadF0tMskPhdM
         zyv2dY++H6hyuD8Oly+Yfrrb/HggFvyNKS24uOsRHpyOl6I3gnD8W1W3n5eqxdOW5leZ
         /0Yv7THvRcukGHjLMbNYrsb8bR5tMQOnSWQ6S+UczKwzku0/REzLQ20FXrvc3DcGDYXe
         a1aL6/9ZUDWBXgmOk5K5xHOsin8g+HIXRK8rqiEojQ2+YRMLomYY+IRh0P/9lLLGj/Q+
         klSg==
X-Forwarded-Encrypted: i=1; AJvYcCViHDusSOdBvONoXCWhx1VBxaQQlLJZNVnhdr1n4MJDIQw0RN5T0GJXsdIxu1VZoDADFtEbC5wvANpoetU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxgx1wdheP6LmKcpgjuidSUwTnYWhsT6xf6w3B9jfm0Gzqb5Tt
	KMTZWMi0zYs88q/1vHPPWRb7z1b8gJRzIiWh2EmsXO/by0CzxTf69iHhboDMuOabLbav0XxxvfA
	RnCNI1A==
X-Google-Smtp-Source: AGHT+IHFcGHBjt5WD8SXsC1G25bD9P3AfNkPCXsvq/nAV+y/iv/KTrwq4V0pmquBSd24rCSDN6ZBdmCxlM8=
X-Received: from plpo9.prod.google.com ([2002:a17:903:3e09:b0:27e:ed03:b5a5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3bc7:b0:269:8404:9a6b
 with SMTP id d9443c01a7336-2902741e466mr159655195ad.57.1760128395608; Fri, 10
 Oct 2025 13:33:15 -0700 (PDT)
Date: Fri, 10 Oct 2025 13:33:14 -0700
In-Reply-To: <e9bd02ba-ff0e-47a3-a12e-9a53717dde9b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007221420.344669-1-seanjc@google.com> <20251007221420.344669-6-seanjc@google.com>
 <diqzo6qfhgc9.fsf@google.com> <e9bd02ba-ff0e-47a3-a12e-9a53717dde9b@amd.com>
Message-ID: <aOltikRvKzCy1DXN@google.com>
Subject: Re: [PATCH v12 05/12] KVM: guest_memfd: Enforce NUMA mempolicy using
 shared policy
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 10, 2025, Shivank Garg wrote:
> >> @@ -112,6 +114,19 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
> >>  	return r;
> >>  }
> >>  
> >> +static struct mempolicy *kvm_gmem_get_folio_policy(struct gmem_inode *gi,
> >> +						   pgoff_t index)
> > 
> > How about kvm_gmem_get_index_policy() instead, since the policy is keyed
> > by index?

But isn't the policy tied to the folio?  I assume/hope that something will split
folios if they have different policies for their indices when a folio contains
more than one page.  In other words, how will this work when hugepage support
comes along?

So yeah, I agree that the lookup is keyed on the index, but conceptually aren't
we getting the policy for the folio?  The index is a means to an end.

> >> +{
> >> +#ifdef CONFIG_NUMA
> >> +	struct mempolicy *mpol;
> >> +
> >> +	mpol = mpol_shared_policy_lookup(&gi->policy, index);
> >> +	return mpol ? mpol : get_task_policy(current);
> > 
> > Should we be returning NULL if no shared policy was defined?
> > 
> > By returning NULL, __filemap_get_folio_mpol() can handle the case where
> > cpuset_do_page_mem_spread().
> > 
> > If we always return current's task policy, what if the user wants to use
> > cpuset_do_page_mem_spread()?
> > 
> 
> I initially followed shmem's approach here.
> I agree that returning NULL maintains consistency with the current default
> behavior of cpuset_do_page_mem_spread(), regardless of CONFIG_NUMA.
> 
> I'm curious what could be the practical implications of cpuset_do_page_mem_spread()
> v/s get_task_policy() as the fallback?

Userspace could enable page spreading on the task that triggers guest_memfd
allocation.  I can't conjure up a reason to do that, but I've been surprised
more than once by KVM setups.

> Which is more appropriate for guest_memfd when no policy is explicitly set
> via mbind()?

I don't think we need to answer that question?  Userspace _has_ set a policy,
just through cpuset, not via mbind().  So while I can't imagine there's a sane
use case for cpuset_do_page_mem_spread() with guest_memfd, I also don't see a
reason why KVM should effectively disallow it.

And unless I'm missing something, allocation will eventually fallback to
get_task_policy() (in alloc_frozen_pages_noprof()), so by explicitly getting the
task policy in guest_memfd, KVM is doing _more_ work than necessary _and_ is
unnecessarily restricting usersepace.

Add in that returning NULL would align this code with the ->get_policy hook (and
could be shared again, I assume), and my vote is definitely to return NULL and
not get in the way.

