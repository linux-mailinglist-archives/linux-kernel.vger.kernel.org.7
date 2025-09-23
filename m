Return-Path: <linux-kernel+bounces-829014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E46B960C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F89E17BA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B3D327A1E;
	Tue, 23 Sep 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzjpRXqc"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3ED3277A9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634842; cv=none; b=SkhEv8xT+cwZKs8dVWwGS2Edwixg4qysjO86OeIxNTL8mpP53w6ic9lNBzryYyHFtUTnbsyePzHmw3kNf3gr3EfbiAwmZ0G3baQxUnm2eceJ1FzMhC/dGHnOUISelpmJDJGxJdnYYbUaOXnyTiU4sedX4/mPaBLcQ82yWxIqGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634842; c=relaxed/simple;
	bh=jqiBUK9/mj3MBAI+kIAnz+rD1nKORVX6srf0Jf+a4hQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uZzQauIrQzfOZy3yN7m4PQMbMslxwOMvRVs//Bv+abeeR0v9byFJmhDtrzg8ERne3840MVP2eOywAddL1J5+/1OsH4V/O3+jc7hnEHaC/g/t2+AhLpAAGUnNKowP3Ch9SkmU9l0QlMaqOjpt5QIttSuydpV3+k2hNzsAzzyfzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OzjpRXqc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-272ed8c106eso17794965ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758634839; x=1759239639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+q1ANiVdqE4PLX6BxhbC6Ed2UomSL/7PeR7UsDBlsI=;
        b=OzjpRXqc+wPLui+uUjQxvQB/9bwrdmKQacZx4bg0CSx3kGi4sjkfejeoNg+CCUENSw
         PCSMQG1bVF9z1N0wjWWQF5bSJSjNHXtm4EkAVVwsPXcmuJt/oIygLyr52pJVoGIe7awL
         Foqr+5mTaJpipjOn0FND84xXDFnFEx2h6/hmYOVET1QXywopXUsIT4weOZJGePSDJRCH
         y32XhQJIfTnMa+YebFgU8D2mMEhlLt5+T87YMAtBvXo2nq8Gm6HAYp5bmzUxvGEgv7Tv
         IANGPZ6buFMf43hKQYuJRwHgO26BzqUhYf9Ef0RYVaUiSu3DmYia9hd0iBpWa6mseq84
         +0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634839; x=1759239639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+q1ANiVdqE4PLX6BxhbC6Ed2UomSL/7PeR7UsDBlsI=;
        b=KRG4OPn11UkNUTIlLmiJG6pVPlcilEO6bqjhhPF224Y6WF+0iON4eQ38mUv3399BWQ
         16koGJwkLvhimbKPBDAQczVlxwyV72t/pPq5LupqWIbsCUS4oTV5nPRhi8uwFwtdlxh+
         UQqerOapb5gFnYMDQBStLVmDmPaXFOKcG26QR37ePhpWQUWOMfpQK0f7O8YhQt/W+ub8
         xvgTmC+MgqowJNvMAi3bn6WQ6XmzXSSZccA3o1TrU7qYLZBstnbl1/zSxoSNNDg3tVAd
         ZNXb2cdhIovthlMFurGDiSkibFLZd5nveID31ZRWZWltju7DJMaWrCeApYNioHoHcqNT
         9eTA==
X-Forwarded-Encrypted: i=1; AJvYcCXKIREPzB34HRbnJ7MF2n9AkXOjvZoj5JmVrIs1NSbYuJeg/+DjHrbqcZc4iIAO/yY2SUb01l/j1kXw9h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrz5kTTJvGrSockau514UhAZF0sAPq6lW1qOoH05INeE5dPbyr
	2OTmgbb8ZfaCl31VxtZEe8aBGrgtS2xMxrGE3Bq80NsUQHpqreUFted+1UGbE4byRrHDwq+scSb
	ExGzSgw==
X-Google-Smtp-Source: AGHT+IH1umU0hviOHL6mfJrfC/KblA1ofkjZSfEzaisGwPHRVVBGNbnvXRYWg5KI7SU4qrTt9g98pjrjG4g=
X-Received: from pjbnd17.prod.google.com ([2002:a17:90b:4cd1:b0:32e:b34b:92eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2446:b0:275:2328:5d3e
 with SMTP id d9443c01a7336-27cc3eee458mr34116465ad.18.1758634839306; Tue, 23
 Sep 2025 06:40:39 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:40:36 -0700
In-Reply-To: <20250923012738.GA4102030@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919003303.1355064-1-seanjc@google.com> <20250919003303.1355064-3-seanjc@google.com>
 <20250923012738.GA4102030@ax162>
Message-ID: <aNKjVLpajXCKfqr_@google.com>
Subject: Re: [PATCH v2 2/5] KVM: Export KVM-internal symbols for sub-modules only
From: Sean Christopherson <seanjc@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 22, 2025, Nathan Chancellor wrote:
> Hi Sean,
> 
> On Thu, Sep 18, 2025 at 05:33:00PM -0700, Sean Christopherson wrote:
> > diff --git a/arch/powerpc/include/asm/kvm_types.h b/arch/powerpc/include/asm/kvm_types.h
> > new file mode 100644
> > index 000000000000..656b498ed3b6
> > --- /dev/null
> > +++ b/arch/powerpc/include/asm/kvm_types.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_PPC_KVM_TYPES_H
> > +#define _ASM_PPC_KVM_TYPES_H
> > +
> > +#if IS_MODULE(CONFIG_KVM_BOOK3S_64_PR) && IS_MODULE(CONFIG_KVM_BOOK3S_64_HV)
> > +#define KVM_SUB_MODULES kvm-pr,kvm-hv
> > +#elif IS_MODULE(CONFIG_KVM_BOOK3S_64_PR)
> > +#define KVM_SUB_MODULES kvm-pr
> > +#elif IS_MODULE(CONFIG_KVM_INTEL)
> 
> Typo :) which obviously breaks the ppc64_guest_defconfig build.
> Changing that to CONFIG_KVM_BOOK3S_64_HV fixes it.

Argh, so many flavors of PPC KVM (says the x86 person :-D).

> > +#define KVM_SUB_MODULES kvm-hv
> > +#else
> > +#undef KVM_SUB_MODULES
> > +#endif
> > +
> > +#endif
> 
> Also, you'll want to drop kvm_types.h from generic-y to avoid
> 
>   scripts/Makefile.asm-headers:39: redundant generic-y found in arch/powerpc/include/asm/Kbuild: kvm_types.h
> 
> diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
> index e5fdc336c9b2..2e23533b67e3 100644
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -3,7 +3,6 @@ generated-y += syscall_table_32.h
>  generated-y += syscall_table_64.h
>  generated-y += syscall_table_spu.h
>  generic-y += agp.h
> -generic-y += kvm_types.h

Thanks much!

>  generic-y += mcs_spinlock.h
>  generic-y += qrwlock.h
>  generic-y += early_ioremap.h
> --
> 
> Cheers,
> Nathan

