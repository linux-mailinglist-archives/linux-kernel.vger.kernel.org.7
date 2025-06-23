Return-Path: <linux-kernel+bounces-699131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4896AE4E30
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 22:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBF23AFEEA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 20:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282072D542B;
	Mon, 23 Jun 2025 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPEcMLlF"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1896A1F582B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750711082; cv=none; b=I/hGAs9bMCfv1M+fC1Ef7rNWyP/aaY8indb1xeVcPMVWC4qJgQYvY8MrIpCe4B33sDd7VH4f/Dy1i56PBxVSRbEPFlNVHY8widv5D5jYep/OAxIn8mq0XXzPD+QxhjgevjVETaovoYSgK5VlIKNRn9oIEL6PrCfVAxcEau5PC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750711082; c=relaxed/simple;
	bh=mWCAX680+qRZ1+4aHKuhQiGgYeG77i0nRNf740hJIP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JCznekzyq+tK1hp0Z62w9/DpjYn3w04GXnwFN71bFJvNW9ksmDT7tH/AAOgQbLImA1k5oXc4xLuboO0tD5AVPJD+ayTlLUwMQ8LNMKEg0m5KgXilV3MOWnwXZEQsU2EWz8phl/8QB4rgFCelod4XeDLxH03cctm4QAgLAQ/Tka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPEcMLlF; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso2956697a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750711080; x=1751315880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lojioo5UwNmVrjdVbpKysqClNWNwBWr9dRMAgFa7ZYU=;
        b=KPEcMLlF1lhYR3BFPGQfRJQJa/QjWwPtvap4hfrkCODYojstaQImHRnSvs9aJ7CVw5
         Y2L1cJsAzPZg7IsYzWVd/yRUipKrqD0SlG0APWbmtKD2sFfSGtsdfxKOlNs5/177QpXF
         NKLvo3wjFfZ3wqc1SdEADJR6OpNW4VganZTMzHFSdYph7yjjL669Qd4zsWunC6RFIx7V
         G7RkydBBvURQp6S3lB6ZehAbNCbVrBBnXlJ/rXEj9Exm1iBbubGoAGMR9yVKsUud5nyA
         WiNmRxWXWRFGyUqTBGJW3bnedmy+I4Y1FsKja+RfdQfHfK/9xxRu+yIf35Wuc113ZKP2
         827A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750711080; x=1751315880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lojioo5UwNmVrjdVbpKysqClNWNwBWr9dRMAgFa7ZYU=;
        b=jLAwHxA1JmH9wzgTX6SnrIpBX1TXdta05EXwOTlZoi1gNtCqGJuPpSQy1jOGoCtNhD
         7vRkhigczmCN+RAGeAn7hpPeOFE8Kdb4z1RmDM6hDRR7p/B5yS4V5Of2Md2AtJF3i2Gj
         mYpDtQNgqx76w3vfBOwpC++vf0itIAPRoQdAPu8kKXYbat639ocsPGcUaDykRfR0AJ66
         lUZfSK4tBo7vnMuw5I53LX9EOyBjc8u65aQjEje+ZIsbW1uSRvyU+hTlFhDVtz35WukI
         mORflPusOp+JHVSY6gFV2y3HkgTXLf7pkJ3oInXo4zxVoQsF+JLc48e8EAvWuG+f9niq
         qMLw==
X-Forwarded-Encrypted: i=1; AJvYcCVaXmFjexsUBY3F5G3bKf+TAqpZPk/UNGAl0gBUW0QAfEqi6E+Q5A1ydBF1Ih4nXgn1IDYJb+jy4haCarc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vW5QoZnYdKaWzRg+Sx4c9NtBMeF4L3I7FxmGSqzDpimV72dr
	nqHX64u5h9cHpmzcPf9mx5ZFeZ7v+qQqTWZXfxz1UdVjSjG/o5ws0xaoiyt18BVmsTmT+v9WjPN
	60xd8Dg==
X-Google-Smtp-Source: AGHT+IFSL/5dFrJLz7PeQwAUIL6kzN3CGq96msr7Do6Zqx1vWxQ3Yu+HoV9pUozdU0LrcUA9PVv+DsCQ9j8=
X-Received: from pjtu14.prod.google.com ([2002:a17:90a:c88e:b0:311:a879:981f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b42:b0:311:d670:a0e9
 with SMTP id 98e67ed59e1d1-3159d8c603bmr19392847a91.21.1750711080367; Mon, 23
 Jun 2025 13:38:00 -0700 (PDT)
Date: Mon, 23 Jun 2025 13:37:58 -0700
In-Reply-To: <6f5af820-5ccf-92e6-1acd-b87aef9885e6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326193619.3714986-1-yosry.ahmed@linux.dev>
 <20250326193619.3714986-7-yosry.ahmed@linux.dev> <aFXrFKvZcJ3dN4k_@google.com>
 <6f5af820-5ccf-92e6-1acd-b87aef9885e6@amd.com>
Message-ID: <aFm7JtFe5NzrhwyW@google.com>
Subject: Re: [RFC PATCH 06/24] KVM: SEV: Track ASID->vCPU instead of ASID->VMCB
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Rik van Riel <riel@surriel.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 23, 2025, Tom Lendacky wrote:
> On 6/20/25 18:13, Sean Christopherson wrote:
> > On Wed, Mar 26, 2025, Yosry Ahmed wrote:
> > The more I think about all of this, the less it makes sense.  The *entire* point
> > of an ASID is to tag TLB entries so that a flush isn't required when running code
> > for the same address space.
> > 
> > The main problem I'm struggling with is that, as usual, the APM doesn't properly
> > document anything, and just gives "suggestions" for the VMM.  *sigh*
> > 
> > As I read it, these snippets from the APM are saying ASIDs tag only GPA=>PA entries
> > when NPT is in use.
> > 
> >   TLB entries are tagged with Address Space Identifier (ASID) bits to distinguish
> >   different guest virtual address spaces when shadow page tables are used, or
> >   different guest physical address spaces when nested page tables are used. The
> >   VMM can choose a software strategy in which it keeps multiple shadow page tables,
> >   and/or multiple nested page tables in processors that support nested paging,
> >   up-to-date; the VMM can allocate a different ASID for each shadow or nested
> >   page table. This allows switching to a new process in a guest under shadow
> >   paging (changing CR3 contents), or to a new guest under nested paging (changing
> >   nCR3 contents), without flushing the TLBs.
> > 
> >   Note that because an ASID is associated with the guest's physical address
> >   space, it is common across all of the guest's virtual address spaces within a
> >   processor. This differs from shadow page tables where ASIDs tag individual
> >   guest virtual address spaces. Note also that the same ASID may or may not be
> >   associated with the same address space across all processors in a
> >   multiprocessor system, for either nested tables or shadow tables; this depends
> >   on how the VMM manages ASID assignment.
> > 
> > But then the "15.16.1 TLB Flush" section says this, without any qualification
> > whatsoever that it applies only to shadow paging.
> > 
> >   A MOV-to-CR3, a task switch that changes CR3, or clearing or setting CR0.PG or
> >   bits PGE, PAE, PSE of CR4 affects only the TLB entries belonging to the current
> >   ASID, regardless of whether the operation occurred in host or guest mode. The
> >   current ASID is 0 when the CPU is not inside a guest context.
> > 
> > And honestly, tagging only GPA=>PA entries doesn't make any sense, because
> > GVA=>GPA needs to be tagged with *something*.  And the APM doesn't say anything
> > about caching GPA=>PA translations, only about caching VA=>PA.
> 
> VA=>PA translations are always tagged with a TLB tag value.  Outside of
> SEV-SNP, the TLB tag value is ASID.
> 
> So for those guests, VA=>PA translation are tagged with the ASID.  For
> SEV-SNP guests, see below.
> 
> > 
> > The thing that doesn't fit is that SEV+ uses ASIDs on a per-VM basis.  I suggested
> > per-VM ASIDs for all VM types based solely on that fact, but now I'm wondering if
> > it's SEV+ that crazy and broken.  Because if ASIDs also tag GVA=>GPA, then SEV has
> > a massive architectural security hole, e.g. a malicious hypervisor can coerce the
> > CPU into using a stale GVA=>GPA TLB entry by switching vCPUs and letting guest
> > process with CR3=x access memory for guest process with CR3=y.  But again, if
> > ASIDs don't tag GVA=>GPA, then what provides isolation between vCPUs!?!?!
> 
> No.
> 
> For SEV/SEV-ES guests, the HV (which remains partially trusted) must do a
> TLB flush before running a different VMCB of the same guest, in order to
> avoid this problem. This code is in pre_sev_run().
> 
> For SEV-SNP guests, this is handled automatically by hardware through the
> PCPU_ID and TLB_ID VMSA fields (documented somewhat in APM 15.36.15).

Aha!  I knew I had to be missing something.  Rule #1: don't doubt Kaplan ;-)

> In short, the TLB is tagged with {TLB_ID, ASID} and TLB_ID is managed by
> HW and guaranteed to be different for each vCPU of the guest running on a
> physical core. This ensures that the TLB tag is unique for each guest and
> for each vCPU of the guest.

Thanks Tom, very much appreciated!

