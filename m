Return-Path: <linux-kernel+bounces-844496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90020BC2125
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C199350151
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910222E7BA9;
	Tue,  7 Oct 2025 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWejzV/g"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA82E62C5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853650; cv=none; b=D8XWoWfE4hYyL0AEdYdrOJHRC/lJR9g/QciZkiGfOGvRT7MnKeJNbR7pehZoZiZcr2JCuMllMt0I+9EH+I8XsIwaEP6NrEEX9GyXHszh+sdkFnCjdrFHi2cCR0mWpNMP1TG97vz468+AwbiFNk+0+NumCtIF7J9ZZpYhrzo6iIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853650; c=relaxed/simple;
	bh=mVzsovC58EEV1QLoRn5Q6vMEItcEyrBnmeexI0Cw4F0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qdn1/nmSRa0Z1btEKxxvggYoQ34Nl7f7kB571TQEm6l+M4tcYwQvEH7ycFyfwWMe2k2jsbbbTjBoO2MTCimyas9cQyMIuEHNNHLzvSgAl1qLayIjqcbLSqjdqWL3HKPfBLaJi7z+97VgRDZwx4pEUtQTBuJipUg8TLTYt7f8Xtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWejzV/g; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befbbaso7323950a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759853648; x=1760458448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/irXsuAsamtgCtTOtUDY4BLJIyfQgPNN1bFCPmxoW+M=;
        b=SWejzV/g5ryUAiGVuVNh10ho17+MbJpKoqn6NvoGX21ghgDzwPnAAzp/z891zrP8Yo
         O+27ld91bAmJR3GlhSlKuHpTTC5ZGohT5q+OlSlpm4Q/QhQ/ltCUAj4A548SeWCpRBcN
         ne7lwm3secZnz04DBTDB8qolpEekwXi/2LkJpzXAbkMEyL4AbY69xPISG8Rnpd+ump6d
         M9jxEdKaLyVtC680E0+2mviS7C595NCSjlcCr9m+f1I8vOCd+85ba9J3246YcWv6HAMf
         x6cuqJ6W/BV546OFqyKgyp6+k6uAEgurw4gM0/LDY1zv9zQzKacDx1bOq1awvAf74uwF
         a70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853648; x=1760458448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/irXsuAsamtgCtTOtUDY4BLJIyfQgPNN1bFCPmxoW+M=;
        b=go/yXk9rDrrQS6iVL6q7Q+N9y3JBzCZ71hKon4vGlxcPDhu1gpKOadjtgBj5/FMMiU
         dr8jn2Oz61VFszHxDHIyKc25E4xmBIdNQwDOz7osMv7RkF57i1poPAaQZtM2VlYx3lNs
         xV5vgqmMHaDZd79mG6pF+WTXyu4tM5B897mH7sqtw726qBBZNrFc+ylR5VRlUKUYIuqk
         4ZUzBqHqUg/1rhspGKi8N1XmXM9Y2wgFswnEnfsBCDeV4owdHRfvaAnZNxUg2SsGoq7M
         mX/CatQxaIaC+nitRmGoiv8os2lePO0pJJesl/NVjOP9TsfQz05sBwaINgXwQSozEwiE
         GSCA==
X-Forwarded-Encrypted: i=1; AJvYcCVt8nrLOcwCWiK4Mjnkh4k1L056nHerpHFh9sAw3V4zvKfTTpj8WFjkhda1WIBfbs+bN9U5mNErP1bBCGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4qwnR/nScKKMxKP1DG/Xv/C/w7JE9rWqlkAsdergCzcMO+wk
	8Omuwo1HsM8rnU0cS6P5RAo0MIGetBf6yEf/xNvTvg2m/entluD2Sah7YBpGEKtRlecMsYgr+z8
	Rf23gf3VV7fVINm7FmthFtM0bCA==
X-Google-Smtp-Source: AGHT+IGQJ9dt+G+ZFPwTDhM1HDP1QQ7G7O/XAdM0NKpHIchJqMPg0aPlJZz4Dn0RLMvkAE7a+NuOyaT3bV2/gD20kQ==
X-Received: from pjkk8.prod.google.com ([2002:a17:90b:57e8:b0:334:1935:56cc])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d0a:b0:32e:87f6:f5a6 with SMTP id 98e67ed59e1d1-33b50f2300dmr157081a91.0.1759853648456;
 Tue, 07 Oct 2025 09:14:08 -0700 (PDT)
Date: Tue, 07 Oct 2025 09:14:07 -0700
In-Reply-To: <20251003232606.4070510-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com> <20251003232606.4070510-3-seanjc@google.com>
Message-ID: <diqzecreelkg.fsf@google.com>
Subject: Re: [PATCH v2 02/13] KVM: guest_memfd: Add INIT_SHARED flag, reject
 user page faults if not set
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Add a guest_memfd flag to allow userspace to state that the underlying
> memory should be configured to be initialized as shared, and reject user
> page faults if the guest_memfd instance's memory isn't shared.  Because
> KVM doesn't yet support in-place private<=>shared conversions, all
> guest_memfd memory effectively follows the initial state.
>
> Alternatively, KVM could deduce the initial state based on MMAP, which for
> all intents and purposes is what KVM currently does.  However, implicitly
> deriving the default state based on MMAP will result in a messy ABI when
> support for in-place conversions is added.
>
> For x86 CoCo VMs, which don't yet support MMAP, memory is currently private
> by default (otherwise the memory would be unusable).  If MMAP implies
> memory is shared by default, then the default state for CoCo VMs will vary
> based on MMAP, and from userspace's perspective, will change when in-place
> conversion support is added.  I.e. to maintain guest<=>host ABI, userspace
> would need to immediately convert all memory from shared=>private, which
> is both ugly and inefficient.  The inefficiency could be avoided by adding
> a flag to state that memory is _private_ by default, irrespective of MMAP,
> but that would lead to an equally messy and hard to document ABI.
>
> Bite the bullet and immediately add a flag to control the default state so
> that the effective behavior is explicit and straightforward.
>
> Fixes: 3d3a04fad25a ("KVM: Allow and advertise support for host mmap() on guest_memfd files")
> Cc: David Hildenbrand <david@redhat.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>

Tested-by: Ackerley Tng <ackerleytng@google.com>

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  Documentation/virt/kvm/api.rst                 |  5 +++++
>  include/uapi/linux/kvm.h                       |  3 ++-
>  tools/testing/selftests/kvm/guest_memfd_test.c | 15 ++++++++++++---
>  virt/kvm/guest_memfd.c                         |  6 +++++-
>  virt/kvm/kvm_main.c                            |  3 ++-
>  5 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 7ba92f2ced38..754b662a453c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6438,6 +6438,11 @@ specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:
>    ============================ ================================================
>    GUEST_MEMFD_FLAG_MMAP        Enable using mmap() on the guest_memfd file
>                                 descriptor.
> +  GUEST_MEMFD_FLAG_INIT_SHARED Make all memory in the file shared during
> +                               KVM_CREATE_GUEST_MEMFD (memory files created
> +                               without INIT_SHARED will be marked private).
> +                               Shared memory can be faulted into host userspace
> +                               page tables. Private memory cannot.
>    ============================ ================================================
>

Also tested make htmldocs. Interestingly even though Sphinx docs [1]
says simple tables must contain more than one row, the html output is
as-expected before and after the GUEST_MEMFD_FLAG_INIT_SHARED row.

[1] https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html

>  When the KVM MMU performs a PFN lookup to service a guest fault and the backing
> 
> [...snip...]
> 

