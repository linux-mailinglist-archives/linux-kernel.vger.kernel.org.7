Return-Path: <linux-kernel+bounces-851533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBFFBD6AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A77188E649
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD602FF15B;
	Mon, 13 Oct 2025 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yUq3hIxc"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E56B2571A5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396314; cv=none; b=f/qFz5r9/NhMum2JHpe7WOLynEub7swEWHDABM9D0MCTqzlfcWSnekDtH4CaJNC9ZyedoUmfHSjHani0MAsmxIXxDE8cOLXiydUHo9bV+oL4dDa4rK6nQipFGaKsa4w/vdyqLPr15XigizhSqj2FyyxiDwrIlffP+DnKL8vQfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396314; c=relaxed/simple;
	bh=OBVPRVnolJIYZ4plwt7wa568FRg7nOQAvuHQFosWrn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VGaqBA4WxvzgbG+fatDZaQ56m6rCgK2jR+WMoqpVwp3oCHpXFj9/5EP8lv57vY+/p5H+bv4UQPmWtiXGkboOK5j7Vgl/O/1iyXC2p5EJyt++7kVCYPErB5IzF0N798vX5gV0Q+uXrdWsfYiC65VR4W+nzn+RwHmRzqzJlKAf/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yUq3hIxc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-286a252bfbfso212133615ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760396312; x=1761001112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgg62F8lpJy3ysdGrDIadd5P5qmpoZpUB7Kr6b42Svo=;
        b=yUq3hIxcW0rZIS2qbIfdjGT+PEHHGTqAML104zNunFWgDW6C/6QLq0cijycuLDYaKs
         OKjkmNk3WpMCTuXKEm75/vd/FTjjnJ2a47OQnVNfQY/qTsMCLSmHQk/8L8Aj/iba4o9F
         g2CJZHHSIvCOHRWEcDXjw1wUT078zu/BuhqfQnC9MJj4mdD3726LXE0p6FyOW+eDTNP3
         ETCOHkUhCPkD99H2ej0vmrBi/twT0BlCevYJVd6b/8hHRhUFtP7DdaRu2GvnD9vd77KD
         1cy+U3AfKNB75aSBDrDf2AzoXJbwnwXtkDQ9CihQ+76ZnwCAd0MIndDc+YU+SwgliGdb
         j+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760396312; x=1761001112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgg62F8lpJy3ysdGrDIadd5P5qmpoZpUB7Kr6b42Svo=;
        b=ng7hMfwJxDxxVd62KTJtKvtLbQeamVoGKr6U3LoA34I8i/5PB52WP5s59o0JCvaYto
         L3B1RaXK+mmhFlnfma3EvToS0cXiM7U02wPBJ5SmFtBLBxk5Kws4ipOCC9/vGbGB4/5Q
         MaoTgp+EcteYWzsTA8xBT/Fe2qtO+QUOVVAkM99mmAn5eIYfzOm8vEAIlkK2/Cp4nZnZ
         kIkIg2TlRA8RgeO17k9IlCVfh781gX6Txiq3dp0Wd5wFzuedyA04jFjY0kErbWyhf1wT
         QG+KahGl/L70oL84Fp6KaE8eJrd6VSRzX6G8ali1QRYQ/1ZuMSGZ1E25ciF2722bWfF9
         KHFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRXj1J2b5dm1tNQ1xo06g5Xum8xO6TkxXC/LukWs95qx4sqAyqsbEZkIAuSzzefNgPCfvKJ6wuMlIxZUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzisjwqLl+PgSgYvmzvLkOfggD9h5cNyO7zuejFr19nulOlBPds
	0xhwtrwK3oDwasm3kIBc7tHr1zkenq6z/pTlMTnbo311lTJ0htqJn8gMJFRx9V6uU+IhIEfKqty
	cbWeR+g==
X-Google-Smtp-Source: AGHT+IFVRSBXCaOg47V3LlEe/hW3xpOG/xZ18xP0dbIvEMR36+z9CDUWRAyHNBZRkitDhAucFbqnHLvEJGU=
X-Received: from pjxu8.prod.google.com ([2002:a17:90a:db48:b0:32e:b34b:92eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d60f:b0:269:ba61:222e
 with SMTP id d9443c01a7336-29027303330mr287660585ad.53.1760396311667; Mon, 13
 Oct 2025 15:58:31 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:58:30 -0700
In-Reply-To: <ivkoh7hdl7fcp5fmehmf3kv6ebqitozunbricyed5tkt7z3ngr@qvmaytpzrskw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev>
 <20251001145816.1414855-9-yosry.ahmed@linux.dev> <aO1yJHcKC85mo0PQ@google.com>
 <ivkoh7hdl7fcp5fmehmf3kv6ebqitozunbricyed5tkt7z3ngr@qvmaytpzrskw>
Message-ID: <aO2EFiOHSuvmHvq_@google.com>
Subject: Re: [PATCH 08/12] KVM: selftests: Use 'leaf' instead of hugepage to
 describe EPT entries
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 13, 2025, Yosry Ahmed wrote:
> On Mon, Oct 13, 2025 at 02:41:56PM -0700, Sean Christopherson wrote:
> > On Wed, Oct 01, 2025, Yosry Ahmed wrote:
> > > From: Yosry Ahmed <yosryahmed@google.com>
> > > 
> > > The assertions use 'hugepage' to describe a terminal EPT entry, but
> > > 'leaf' is more accruate as a PG_LEVEL_4K EPT entry is a leaf but not a
> > > hugepage.
> > 
> > Yes, it's more accurate, but also less precise.  I'm guessing the assert message
> > and comment talked about hugepages because that's the type of mappings that
> > caused problems at the time.
> 
> Given that it refers to PG_LEVEL_4K entries too, I wouldn't call it less
> precise. All callers actually create 4K mappings so it is never actually
> a hugepage in the current context :D

nested_identity_map_1g()?

> > Ah, actually, I bet the code was copy+pasted from virt_create_upper_pte(), in
> > which case the assumptions about wanting to create a hupage are both accurate
> > and precise.
> > 
> > > The distincion will be useful in coming changes that will pass
> > > the value around and 'leaf' is clearer than hugepage or page_size.
> > 
> > What value?
> 
> 'leaf'. The following changes will pass 'leaf' in as a boolean instead
> of checking 'current_level == target_level' here. So passing in
> 'hugepage' would be inaccurate, and 'page_size' is not as clear (but
> still works).
> 
> > 
> > > Leave the EPT bit named page_size to keep it conforming to the manual.
> > > 
> > > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > ---
> > >  tools/testing/selftests/kvm/lib/x86/vmx.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
> > > index 04c4b97bcd1e7..673756b27e903 100644
> > > --- a/tools/testing/selftests/kvm/lib/x86/vmx.c
> > > +++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
> > > @@ -380,15 +380,15 @@ static void nested_create_pte(struct kvm_vm *vm,
> > >  			pte->address = vm_alloc_page_table(vm) >> vm->page_shift;
> > >  	} else {
> > >  		/*
> > > -		 * Entry already present.  Assert that the caller doesn't want
> > > -		 * a hugepage at this level, and that there isn't a hugepage at
> > > -		 * this level.
> > > +		 * Entry already present.  Assert that the caller doesn't want a
> > > +		 * leaf entry at this level, and that there isn't a leaf entry
> > > +		 * at this level.
> > >  		 */
> > >  		TEST_ASSERT(current_level != target_level,
> > > -			    "Cannot create hugepage at level: %u, nested_paddr: 0x%lx",
> > > +			    "Cannot create leaf entry at level: %u, nested_paddr: 0x%lx",
> > >  			    current_level, nested_paddr);
> > >  		TEST_ASSERT(!pte->page_size,
> > > -			    "Cannot create page table at level: %u, nested_paddr: 0x%lx",
> > > +			    "Leaf entry already exists at level: %u, nested_paddr: 0x%lx",
> > 
> > This change is flat out wrong.  The existing PRESENT PTE _might_ be a 4KiB leaf
> > entry, but it might also be an existing non-leaf page table.
> 
> Hmm if pte->page_size is true then it has to be a leaf page table,
> right?

No, because bit 7 is ignored by hardware for 4KiB entries.  I.e. it can be 0 or
1 depending on the whims of software.  Ugh, this code uses bit 7 to flag leaf
entries.  That's lovely.

> If it's an existing non-leaf page table we shouldn't fail,

Ah, right, current_level can never be less than target_level because the first
assert will fail on iteration-1.

> the assertion here is when we try to override a leaf page table IIUC.
>
> > Instead of hacking on the nested code, can we instead tweak __virt_pg_map() to
> > work with nested TDP?  At a glance, it's already quite close, e.g. "just" needs
> > to be taught about EPT RWX bits and allow the call to pass in the root pointer.
> 
> That would be ideal, I'll take a look. In case I don't have time for
> that unification, can this be a follow-up change?

Part of me wants to be nice and say "yes", but most of me wants to say "no".

Struct overlays for PTEs suck.  At best, they generate poor code and obfuscate
simple logic (e.g. vm->page_size vs pte->page_size is a confusion that simply
should not be possible).  At worst, they lead to hard-to-debug issues like the
one that led to commit f18b4aebe107 ("kvm: selftests: do not use bitfields larger
than 32-bits for PTEs").

eptPageTableEntry obviously isn't your fault, but nptPageTableEntry is. :-D
And I suspect the hardest part of unificiation will be adding the globals to
deal with variable bit positions that are currently being handled by the struct
overlays.

