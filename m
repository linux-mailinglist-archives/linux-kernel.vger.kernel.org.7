Return-Path: <linux-kernel+bounces-851416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E4BD6641
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6711D4F26CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9F2EFD95;
	Mon, 13 Oct 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzOif5oy"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402512E9ED4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391720; cv=none; b=jwDDmZQQ8lGhVQS+o+BZUQtPr0TYsGNdMe4WIuldNZ3yhwoDfGD2XC1qmiq0jySdMYczA3wutoCkDiwchHnbnbhrkQRqHwABZIVHJ2zMWS8owGuCGpKPbLlmlQizs8EnRR4hD7MmNrV4boAEdMYEsKti5ksURH2qvAoFf3gBT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391720; c=relaxed/simple;
	bh=TDs9eZA6MaUUuDc1+8bQHqQ2laN3OgoREAcfscdplpo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sHKpiIU+t2/Qk4uUJAOjUr27GAG6OxmLme4ISL6Bbm+b2g6ADS58UwE61p6F7oeQTiGWcW+oVf4vY6gQgwqkJPYuphhfDgcKeOHBh6rnSh2jzYJ6CTi7+Se51w3X76Vegp1yIjYudzeH3C1Jc0ow0mHRSr7cloB3bYTJ9OqhAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NzOif5oy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befc08so19014442a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760391718; x=1760996518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsVHXtQeXX4SM5ssgn2Mp7CjNDCTTOd3e+3GSKyAubs=;
        b=NzOif5oyyWnbTG8b4DJb3PNERXhojZG7y5PulbwpJeL5quPSOuKWToe+A0qh1fs0Wb
         bo7ESPr5jZ5n4EC0vqc4NM+UrMa5GonsMxqh4ZNTZejG9Mh4C/tXYPoXiaKvIeMkCn8n
         GSi8QDG8lt3hB970jDHQhRmjTxdlEnO5ehpCfgfRbP5m9mH3lrWnXhXlF6E0XKcRk5JA
         JJgsUbAgKFI8oomWVPLNfd/7pbLrRdlqpNhOtSUjStU4vlJoB62L7Z5glLrRaxAmyduc
         CJxZaonRHwT0rdSnrtKGVyG0zIVuLbcl0ysJXfgsTdGWBlFBldvMV8oeBauwD7904ctX
         J6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760391718; x=1760996518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsVHXtQeXX4SM5ssgn2Mp7CjNDCTTOd3e+3GSKyAubs=;
        b=Yy7dWvFhF8fLhLWrqlehyPlOHKstZF5wsGUzw7le1sXfuMC0RCEqsZ/MwaMTjvCgxw
         20HXidEQHL7KkHmbz7d06UctYrm4zG8bV0CACraOuVCOwIwHDJIHbQPsc1cs+ac74Dq3
         Z2Qx7HVYED5E/VcHLhhw8E2fgf0K3E2STMvnGogxflNGuGEVD/XLE1+mrtzAye8am2k1
         EPVnIF8ZT5MGy5Ew4THDIrLi10qElnZgCGMUw0z1Ij7elb7ic1Mf7Qx85hpqOFOu7d2N
         eZHKbpKVnTEL5zejUhaP7o7hEvXV3uRQumX3ecgD0RvAo9R18Ce3zkEize6T2ROOkFKH
         J3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXU6XHTAoMSBYutVVSuH4KrEx7UxInp5WeEVkUx6rFnL2Owz/L7s6lIdIujdqrVEbwX3dUVax8B5I3dSRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjCyyS4m0J1WmaZrh8q0vDGEJeSJXYuiEKgVzDUDgYDQe9UFu
	xBbqy8cd8BvIQvSL1zIz6+W3FuzamBnkQshVOD1QtOsS3ROjV6bLl6z5C9P3m2Ys3uZZrepozkN
	sndHyFg==
X-Google-Smtp-Source: AGHT+IH2fqDIp928vMWgxWfpIsnJ48hBAEwmrvE8ezRIGFx8FjGO7z4ubS1MD0ziJ9dEj/roPyOIK06MTjo=
X-Received: from pjvd23.prod.google.com ([2002:a17:90a:d997:b0:339:9a75:1b1e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec4:b0:32e:d16c:a8c6
 with SMTP id 98e67ed59e1d1-33b5111bd79mr33316653a91.16.1760391718415; Mon, 13
 Oct 2025 14:41:58 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:41:56 -0700
In-Reply-To: <20251001145816.1414855-9-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-9-yosry.ahmed@linux.dev>
Message-ID: <aO1yJHcKC85mo0PQ@google.com>
Subject: Re: [PATCH 08/12] KVM: selftests: Use 'leaf' instead of hugepage to
 describe EPT entries
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 01, 2025, Yosry Ahmed wrote:
> From: Yosry Ahmed <yosryahmed@google.com>
> 
> The assertions use 'hugepage' to describe a terminal EPT entry, but
> 'leaf' is more accruate as a PG_LEVEL_4K EPT entry is a leaf but not a
> hugepage.

Yes, it's more accurate, but also less precise.  I'm guessing the assert message
and comment talked about hugepages because that's the type of mappings that
caused problems at the time.

Ah, actually, I bet the code was copy+pasted from virt_create_upper_pte(), in
which case the assumptions about wanting to create a hupage are both accurate
and precise.

> The distincion will be useful in coming changes that will pass
> the value around and 'leaf' is clearer than hugepage or page_size.

What value?

> Leave the EPT bit named page_size to keep it conforming to the manual.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  tools/testing/selftests/kvm/lib/x86/vmx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
> index 04c4b97bcd1e7..673756b27e903 100644
> --- a/tools/testing/selftests/kvm/lib/x86/vmx.c
> +++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
> @@ -380,15 +380,15 @@ static void nested_create_pte(struct kvm_vm *vm,
>  			pte->address = vm_alloc_page_table(vm) >> vm->page_shift;
>  	} else {
>  		/*
> -		 * Entry already present.  Assert that the caller doesn't want
> -		 * a hugepage at this level, and that there isn't a hugepage at
> -		 * this level.
> +		 * Entry already present.  Assert that the caller doesn't want a
> +		 * leaf entry at this level, and that there isn't a leaf entry
> +		 * at this level.
>  		 */
>  		TEST_ASSERT(current_level != target_level,
> -			    "Cannot create hugepage at level: %u, nested_paddr: 0x%lx",
> +			    "Cannot create leaf entry at level: %u, nested_paddr: 0x%lx",
>  			    current_level, nested_paddr);
>  		TEST_ASSERT(!pte->page_size,
> -			    "Cannot create page table at level: %u, nested_paddr: 0x%lx",
> +			    "Leaf entry already exists at level: %u, nested_paddr: 0x%lx",

This change is flat out wrong.  The existing PRESENT PTE _might_ be a 4KiB leaf
entry, but it might also be an existing non-leaf page table.

Instead of hacking on the nested code, can we instead tweak __virt_pg_map() to
work with nested TDP?  At a glance, it's already quite close, e.g. "just" needs
to be taught about EPT RWX bits and allow the call to pass in the root pointer.

>  			    current_level, nested_paddr);
>  	}
>  }
> -- 
> 2.51.0.618.g983fd99d29-goog
> 

