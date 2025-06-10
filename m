Return-Path: <linux-kernel+bounces-679990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8846DAD3E91
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 18:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70AE97AB3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258BC24292E;
	Tue, 10 Jun 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VkYQlwcE"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C6A241CB2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571948; cv=none; b=R8Q8cEx2nPmvl278WN6vVb8Sn5IOoRJ+SDCAS14zVYTElj5NEV4DRsvuy8qZLIQMcO4GvzFq4ohrKOeBybOCmpDH56TviUXoNuGFPy7SgvJpiyJhNXqBvLDGRiwV8O4x4vE00ZUAc1w9deoiTEyB9K9yaiwXl53rynqmcLW80iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571948; c=relaxed/simple;
	bh=5WJNEkDIjQQz2okt4KOF8T62rDFTSGAdY4cYKkBLKAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P/PQAP9w6idSzxRdWckLGdDAS8otHkg5qgZC0NerovgCI+XPtBd4jU2FMTs8slOOjfW7BnEYMVGMyGZdajzQnmAzI752WZj6gN0K+f4eoabKxZ7dgPbU+rKJK6ogRZCEuG+qYGjL12q9A22krmciX1O4PsfUkV9O212njhLzu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VkYQlwcE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31215090074so7821202a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749571946; x=1750176746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdst2AXEI4Imm1N+8aUcHMsoZp01dEp7fOzDZf0fTqo=;
        b=VkYQlwcE6Gabdm0Q7BNy4Sel4WedZgCTG3pCAIRXdkA6O0GwFNVvtEK8iaDfIxwcXg
         a5+6PWIHy0gUmcG8ljDl95pPZ/yQ2BxPskUxxla6hNVwau2tpkYZ+vEGsbaADSHv8KR/
         h6pxSBtXFv5OdeMyYuQC1oc3z15OLzEZ+QOwC3yEtkKgOL7eFFkb3jw1vcPNRMU8+Jmt
         m8SKqFeVit/Tj9pXGQ13MuFeXaO0djRyJFU5jgDmVclghlcGA4FR51z+PU0MiRUGKZ3e
         MQ+V+u1nUaEQuQ7/CoiBUB1SlO9+UFCWmXuY4U+ciU9JHKp6soH1uxPtjZJ6Ox7AbCGG
         Nv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749571946; x=1750176746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdst2AXEI4Imm1N+8aUcHMsoZp01dEp7fOzDZf0fTqo=;
        b=T9MB0I7gD5/ezJCGvNg/BxcJpiP2J7J4Pj9FWoH4ELKWUahlYtrAv0HGMqajuXrXwj
         /2FhV5fArvky0SMmUAE85bxnTLjrqArtHIZc/0jcVqI8SUJCUGtorQt3MvyeZOYhJ2Zj
         Givas4/wcNLTpcRSxF8uhTuBs21Jo4r2jO3gYl2S9hkvSRFekrcvYVom4SqGcqlLlN9p
         J3UJl24NSg6R1y6UeKT4vHhyOaO/c2aa8bfAf2RBwwBlsZRUqJ6TWGoCZzKSXdDHJ6A/
         RANFguhY85o050Kd06FuKCJZT54YCb2VYzDVc5O1Z+PFXhuTCV/SE1HB4+JmuG7Y/buT
         2Qug==
X-Gm-Message-State: AOJu0YzhJK7FoV5p7iFYTSmzUuQ06uZXUFmjrHQFQUxj/HjkA4jsbGqc
	ClguuKJkz/+UCsqGNn2VUm/mV4Pun0yue4ui1rpwZTCHYwwTPQCPYVeXFe5c7g6odCCrbGb2mwU
	dzoeb6A==
X-Google-Smtp-Source: AGHT+IE71Jz/QhQNRZ8OzEh0DWxt/XrMZMCp0tDfjSa8QU6g08JvolhGnuLJkEQj3Yvonq7nqSu9ReSpHFU=
X-Received: from pjbrr16.prod.google.com ([2002:a17:90b:2b50:b0:311:f699:df0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3887:b0:311:e9ac:f5ce
 with SMTP id 98e67ed59e1d1-313af23d84bmr171621a91.21.1749571946315; Tue, 10
 Jun 2025 09:12:26 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:12:24 -0700
In-Reply-To: <cc3df866-9144-42f0-a24c-fbdcedd48315@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250429061004.205839-1-Neeraj.Upadhyay@amd.com>
 <20250429061004.205839-2-Neeraj.Upadhyay@amd.com> <aBDlVF4qXeUltuju@google.com>
 <cc3df866-9144-42f0-a24c-fbdcedd48315@amd.com>
Message-ID: <aEhZaMuipi2qePHX@google.com>
Subject: Re: [PATCH v5 01/20] KVM: x86: Move find_highest_vector() to a common header
From: Sean Christopherson <seanjc@google.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, Thomas.Lendacky@amd.com, 
	nikunj@amd.com, Santosh.Shukla@amd.com, Vasant.Hegde@amd.com, 
	Suravee.Suthikulpanit@amd.com, David.Kaplan@amd.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	kirill.shutemov@linux.intel.com, huibo.wang@amd.com, naveen.rao@amd.com, 
	francescolavra.fl@gmail.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 10, 2025, Neeraj Upadhyay wrote:
> On 4/29/2025 8:12 PM, Sean Christopherson wrote:
> > Please slot the below in.  And if there is any more code in this series that is
> > duplicating existing functionality, try to figure out a clean way to share code
> > instead of open coding yet another version.
> > 
> > --
> > From: Sean Christopherson <seanjc@google.com>
> > Date: Tue, 29 Apr 2025 07:30:47 -0700
> > Subject: [PATCH] x86/apic: KVM: Deduplicate APIC vector => register+bit math
> > 
> > Consolidate KVM's {REG,VEC}_POS() macros and lapic_vector_set_in_irr()'s
> > open coded equivalent logic in anticipation of the kernel gaining more
> > usage of vector => reg+bit lookups.
> > 
> > Use lapic_vector_set_in_irr()'s math as using divides for both the bit
> > number and register offset makes it easier to connect the dots, and for at
> > least one user, fixup_irqs(), "/ 32 * 0x10" generates ever so slightly
> > better code with gcc-14 (shaves a whole 3 bytes from the code stream):
> > 
> > ((v) >> 5) << 4:
> >   c1 ef 05           shr    $0x5,%edi
> >   c1 e7 04           shl    $0x4,%edi
> >   81 c7 00 02 00 00  add    $0x200,%edi
> > 
> > (v) / 32 * 0x10:
> >   c1 ef 05           shr    $0x5,%edi
> >   83 c7 20           add    $0x20,%edi
> >   c1 e7 04           shl    $0x4,%edi
> > 
> > Keep KVM's tersely named macros as "wrappers" to avoid unnecessary churn
> > in KVM, and because the shorter names yield more readable code overall in
> > KVM.
> > 
> > No functional change intended (clang-19 and gcc-14 generate bit-for-bit
> > identical code for all of kvm.ko).
> > 
> 
> With this change, I am observing difference in generated assembly for VEC_POS
> and REG_POS, as KVM code passes vector param with type "int" to these macros.
> Type casting "v" param of APIC_VECTOR_TO_BIT_NUMBER and APIC_VECTOR_TO_REG_OFFSET
> to "unsigned int" in the macro definition restores the original assembly. Can
> you have a look at this once? Below is the updated patch for this. Can you please
> share your feedback on this?

LGTM.

Ideally, KVM would probably pass around an "unsigned int", but some higher level
APIs in KVM use -1 to indicate an invalid vector (e.g. no IRQ pending), and mixing
and matching types would get a little weird and would require a decent amount of
churn.  So casting in the macro where it matters seems like the best option, at
least for now.

Thanks much for taking care of this!

