Return-Path: <linux-kernel+bounces-883405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87002C2D59F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF37189CAE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B7F31DDBB;
	Mon,  3 Nov 2025 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uh0coHKJ"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFDB31DDA9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189252; cv=none; b=TRHylyY9c3WcIwCQnrzX11arEVs0Jh+x5i63bVFgl1aKJvtnD+8ejmX6GXRN//0eTwq2qo8r+oGYnk8GBRRLsGEBHh9YxfVKU4XG8CR4dG1zmSz4Oe0IFuC5PY/AsyeOdBm2JG91CqLem1gr8bLK0dTT0/KZipBRhaMUAjIqcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189252; c=relaxed/simple;
	bh=epEz5JO14EzdvaM0l5sjchiiiWhS1f9DBzocBK/FLHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULdOFJ8mLgDmvQ1ajkCiEsZv/pDbVImB4LeMwOnEE4J/4CwXgTpXxk1bJth1Qr8CrNobW2cl9jyvA9gko8UgLkR1HLNHm0Dpb7zAliAOSqv/XYKZ4YhxXb1/Ro/Orf60N2FaYEDOG7rYndWYIhRm3Hm/uhynZdrBACmuk6IRhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uh0coHKJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295592eb5dbso23810105ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762189250; x=1762794050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6IRIo7fpurV9GwKBfgD4OHFoa2+Cu2Rk9LbA8Fikj3I=;
        b=Uh0coHKJorT4bPh9+27hakbFp4SE4YVDoB8nPNi2YjGoJmOHB0n4LNmFyUqRYotYCK
         0ySBYU9xkfiiKaRYBq5mRXVDZ6rZJdOMXiWPIZYmizl+V0gZrc2kG6U2lkE7VLgEzzjx
         pewFtKE15qEDrDPb9I4J22uAuJ903S8psqXznAHXhVvD+oa2u9RoJc2Pe3xzXiO7psbs
         X9EhG/+4M1XLznvAfo5N84Oh6aadJg88FfWVIgkzC0FsUzJR0rP6rs0ya5+n7AVf8qzm
         AK1VGBzWfdWao97K08AhDabmDL/cqCw5P/Onj3ePhPz95x21/lhsA2TRozMiJu1B5ThO
         T2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189250; x=1762794050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IRIo7fpurV9GwKBfgD4OHFoa2+Cu2Rk9LbA8Fikj3I=;
        b=SRTzrEz40SJsDbpihbsMZIKXbT0SwKCjFOeTrmtL9vSX+mCrYPaZlLLIQCtYs80wWG
         sliJ5iBIZnJxxriOfIod+QC2M0NROzWdDA8TLMF9DfR8RU2Wxsjgozc7x3M2AcTE86wi
         RoyNv3qd7hBqNnWsytgFbBFp+ZuJMSnb8kWJ2BFcNbPclWc1VHzVho6TjCsOVQ58ZdrJ
         TWrYNpDj8rbkrNMAEQMt3WVnYU6anRFVZAmrlnHS1iMQP6ImSwflnl2YdP6siKmqV2KA
         8I4fJMXsABhJYw9ePzM6Z4lG7x/wxr72ZtEXZEXBKAnMQ6GpgDwnQ2ephvjBvSv5lNkX
         vl0w==
X-Forwarded-Encrypted: i=1; AJvYcCWy9km31qd1wo5k89ooWpGjEPUhd3f4dyJ0muWuMXx2AYr/fZAdOZ/VjzCA31fr1/5IlAtsghMya+AqRwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0aL43CoQsJg3xQrXZ/WLmHWwg193517HrIfMXXIQ9GDol+lA2
	cpZrgVdQAKkbGdUF7tZiY9LFuiWw5EIk9HU/oesysVLg6skduhqRqFmecyNKnCo6a/kF0+fMDna
	wLSmO9Q==
X-Google-Smtp-Source: AGHT+IF4lU1MjPjgJlhY3ic7+3CyBeck4ktMoovFtnCRGs7Fp/0cEW7DY9B8zdM7xq780PsQFsocJ4vjmC4=
X-Received: from pjqt18.prod.google.com ([2002:a17:90a:ae12:b0:340:c0e9:24b6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:185:b0:290:9a31:26da
 with SMTP id d9443c01a7336-2951a37a3d6mr188846515ad.16.1762189250233; Mon, 03
 Nov 2025 09:00:50 -0800 (PST)
Date: Mon, 3 Nov 2025 09:00:48 -0800
In-Reply-To: <20251101041324.k2crtjvwqaxhkasr@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com> <20251031003040.3491385-3-seanjc@google.com>
 <20251101041324.k2crtjvwqaxhkasr@desk>
Message-ID: <aQjfwARMXlb1GGLJ@google.com>
Subject: Re: [PATCH v4 2/8] x86/bugs: Decouple ALTERNATIVE usage from VERW
 macro definition
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 31, 2025, Pawan Gupta wrote:
> On Thu, Oct 30, 2025 at 05:30:34PM -0700, Sean Christopherson wrote:
> > Decouple the use of ALTERNATIVE from the encoding of VERW to clear CPU
> > buffers so that KVM can use ALTERNATIVE_2 to handle "always clear buffers"
> > and "clear if guest can access host MMIO" in a single statement.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/nospec-branch.h | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > index 08ed5a2e46a5..923ae21cbef1 100644
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -308,24 +308,23 @@
> >   * CFLAGS.ZF.
> >   * Note: Only the memory operand variant of VERW clears the CPU buffers.
> >   */
> > -.macro __CLEAR_CPU_BUFFERS feature
> >  #ifdef CONFIG_X86_64
> > -	ALTERNATIVE "", "verw x86_verw_sel(%rip)", \feature
> > +#define CLEAR_CPU_BUFFERS_SEQ	verw x86_verw_sel(%rip)
> >  #else
> > -	/*
> > -	 * In 32bit mode, the memory operand must be a %cs reference. The data
> > -	 * segments may not be usable (vm86 mode), and the stack segment may not
> > -	 * be flat (ESPFIX32).
> > -	 */
> > -	ALTERNATIVE "", "verw %cs:x86_verw_sel", \feature
> > +/*
> > + * In 32bit mode, the memory operand must be a %cs reference. The data segments
> > + * may not be usable (vm86 mode), and the stack segment may not be flat (ESPFIX32).
> > + */
> > +#define CLEAR_CPU_BUFFERS_SEQ	verw %cs:x86_verw_sel
> >  #endif
> > -.endm
> > +
> > +#define __CLEAR_CPU_BUFFERS	__stringify(CLEAR_CPU_BUFFERS_SEQ)
> >  
> >  #define CLEAR_CPU_BUFFERS \
> > -	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF
> > +	ALTERNATIVE "", __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF
> >  
> >  #define VM_CLEAR_CPU_BUFFERS \
> > -	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF_VM
> > +	ALTERNATIVE "", __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF_VM
> 
> Sorry nitpicking, we have too many "CLEAR_CPU_BUF" in these macros, can we
> avoid adding CLEAR_CPU_BUFFERS_SEQ?

AFAICT, there's no sane way to avoid defining a macro for the raw instruction. :-/

> Or better yet, can we name the actual instruction define to VERW_SEQ, 

Works for me.

