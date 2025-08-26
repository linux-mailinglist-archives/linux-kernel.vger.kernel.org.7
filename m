Return-Path: <linux-kernel+bounces-787188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4BDB372BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9391BA0254
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66A371EA4;
	Tue, 26 Aug 2025 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLt3UXcx"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA892882B6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234693; cv=none; b=suMJLRsz3usf547fNWw5ntBhj4Mgi18uO8HzLQ65W6FaHZBWFivLBG2N6Dp2yJkvkRZIoueohjgz49D7EdAVwwXfROIBRENLla/68MOfX9zaf5cFh0DXjKX7wdc9Ulmh8ntOasZcmJXCnwMh9y1jh1hCK06dqh0+16mqLHw28UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234693; c=relaxed/simple;
	bh=kDpcIIxD2JVz4pEHGDWpKjEw9aLoXw9c1amAhm9tDMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tr607J5Kz2Royhq1oziYo9k9cqzdR2vCLU10jd+MIMNPgQn+myDtuHw2C1GCJWjI0hlknwfRvwZ7bJbYZojs9zYjkLPe0r36SV6fi2pNGoXOMoig080Vys0GwvPd0ciPBt0JBR2PgJoadtEPvphqeN1msdi2mMOHe2/uGboWQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLt3UXcx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327594fd627so545567a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756234692; x=1756839492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsY3QiK0IbnEstf82hU96UYsRAXIuVACCLqPo2mVzDA=;
        b=dLt3UXcxCH+vnSCv7wa9SgcrDymRLdsDkMoJdZB50DvMN/l81vmBy1RRIS8G05YFe6
         mH6VQuojARAghc7Z7WrDUIXhPPeMiihXs622J+qMbZCT147YIG99TYzxcu4E/oubw08i
         jK7c67z1MHZJIL/NRxCzMcAWQB1pgxevvZQur0Ya0Qr3TAGrzWWOKs6PmuEcABT519xS
         IXfcc+SjJqNcuxrbMktJHO7UswgKE+kq4iFQL8iD9Uo5QjmwDlLCYbEOwqR5ckKEJ6fY
         k8sslpfikM1nGwPqhZrQS7Nbom+briDx5Kp60XV1mlYFtHBVBWrTMUQP+YhiW+i1VpW9
         ZQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756234692; x=1756839492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsY3QiK0IbnEstf82hU96UYsRAXIuVACCLqPo2mVzDA=;
        b=eG1cwpeutQHBeGkKYXMf3k81onBSe71+gtgcdm+0ZtHp6kF122D7JCz81M08+Q+QUo
         e6bgisHw+H4NKAs/hFGVOQnm+4jsORjuvPPj6L5fs7QF30nqBHdmFppvnQheT/XCOoKR
         u4249pWyufgIT9VAkkY2Lkpm9UEyF8IUsaTYHPPdK4HV7BmesoZX06kGKqzfGLGN6Kup
         CNU+K9LX+YD23sB4bRu3StIrAlRcQpqiiHbdXpHdGbp/HG8VV8NlKehwPeKJfU/1exuE
         3lx+5JxTPcULMuDojUoQQlLLrE8FfTCQxcB/FV+qeUywmwU7Y4blPA0PNEIJGX9hvtEh
         OunQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPfSIECdlPw126HYHxKEVkx+IS1Lnk9w64zTMU7yzmUpwhlzwCU7qilaHT4VLLma0CduVSPuIgAGT8z0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YytZx2lDVwULFPpygjH5g9UGMorU4DB1DBNupHHbBb1suU4D3a4
	x+e+6Pn1H1PKXRfOKkDJlJJ4m0cBac8wEwa58TS05aTM0IMe/lnoMjPMgQ1birwPZGKhJnV/GTV
	kPNs25g==
X-Google-Smtp-Source: AGHT+IEbYMyz1OK/7DxpodLpUWaOFW3JDTS/P5ttB89uVykFsbXSvA935+WSo4TPCjtqlt5OUT9tb2npKgM=
X-Received: from pjbst5.prod.google.com ([2002:a17:90b:1fc5:b0:325:b894:3c5d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d06:b0:321:87fa:e1f1
 with SMTP id 98e67ed59e1d1-32515ea158cmr20429199a91.22.1756234691802; Tue, 26
 Aug 2025 11:58:11 -0700 (PDT)
Date: Tue, 26 Aug 2025 11:58:10 -0700
In-Reply-To: <aKeeRynpwFTSONfm@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com> <20250821210042.3451147-6-seanjc@google.com>
 <aKeeRynpwFTSONfm@linux.dev>
Message-ID: <aK4DwtuQtzYvRei-@google.com>
Subject: Re: [RFC PATCH 05/16] KVM: arm64: Introduce "struct kvm_page_fault"
 for tracking abort state
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 21, 2025, Oliver Upton wrote:
> Hey Sean,
> 
> On Thu, Aug 21, 2025 at 02:00:31PM -0700, Sean Christopherson wrote:
> > Add and use a kvm_page_fault structure to track state when handling a
> > guest abort.  Collecting everything in a single structure will enable a
> > variety of cleanups (reduce the number of params passed to helpers), and
> > will pave the way toward using "struct kvm_page_fault" in arch-neutral KVM
> > code, e.g. to consolidate logic for KVM_EXIT_MEMORY_FAULT.
> > 
> > No functional change intended.
> > 
> > Cc: James Houghton <jthoughton@google.com>
> > Link: https://lore.kernel.org/all/20250618042424.330664-1-jthoughton@google.com
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h |  18 ++++
> >  arch/arm64/kvm/mmu.c              | 143 ++++++++++++++----------------
> >  2 files changed, 87 insertions(+), 74 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 2f2394cce24e..4623cbc1edf4 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -413,6 +413,24 @@ struct kvm_vcpu_fault_info {
> >  	u64 disr_el1;		/* Deferred [SError] Status Register */
> >  };
> >  
> > +struct kvm_page_fault {
> > +	const u64 esr;
> > +	const bool exec;
> > +	const bool write;
> > +	const bool is_perm;
> 
> Hmm... these might be better represented as predicates that take a
> pointer to this struct and we just compute it based on ESR. That'd have
> the benefit in the arch-neutral code where 'struct kvm_page_fault' is an
> opaque type and we don't need to align field names/types.

We'd need to align function names/types though, so to some extent it's six of one,
half dozen of the other.  My slight preference would be to require kvm_page_fault
to have certain fields, but I'm ok with making kvm_page_fault opaque to generic
code and instead adding arch APIs.  Having a handful of wrappers in x86 isn't the
end of the world, and it would be more familiar for pretty much everyone.

> > +	phys_addr_t fault_ipa; /* The address we faulted on */
> > +	phys_addr_t ipa; /* Always the IPA in the L1 guest phys space */
> 
> NYC, but this also seems like a good opportunity to rename + retype
> these guys. Specifically:
> 
> 	fault_ipa => ipa
> 	ipa => canonical_ipa
> 
> would clarify these and align with the verbiage we currently use to talk
> about nested.

Heh, I'm so screwed.  x86's use of "canonical" is wildly different.  I can add
a patch to do those renames (I think doing an "opportunistic" rename would be a
bit much).

