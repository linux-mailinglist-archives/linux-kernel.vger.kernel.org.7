Return-Path: <linux-kernel+bounces-778172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E176CB2E23A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DD36876DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33463326D5E;
	Wed, 20 Aug 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7t3TJml"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F454327796
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706713; cv=none; b=nREXrHnC/x3mkSz45mwS+fAMkKD8mOPGCHpy9lOxvBSv3kxvFfQxv9RviJXvDbWfEiq+KB6UBUWZ9YhWrS8fFW77kyjOG9G2WSUfCT+RHfV+tx8USCqnI3s5BLTlwGc2SbDPCM0Nuy9EL+ZSWD5LovCGToRoYVFZ7FpxgKD57t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706713; c=relaxed/simple;
	bh=aryoRv5tAqznCZnbWBlEmRqJE3caNfx+OkacUf1bQXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dZQwLLh5xIy6TH4QC35TmrqHRovdTGoE+fPPFqHbaq6MLQSVuI4lRvMHNzrOn3Gr2lRe4H7K/Ghcdukt8vf57HHKWP5gzXSRXudXl7jxqj04kRuevl6zn+ES56ZttcCcWa3M1fNW9Lu1tkZaj7d5cjxMzs+IZSOKEc3vIn6mc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7t3TJml; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326779c67so97006a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755706711; x=1756311511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbIBXkjzpro1lSKQx3DixkUfhZO5cnnCemwVjT931F8=;
        b=a7t3TJml2qZzGlZGJDqItorgUi5EnVdzKSjfSyRddahQsq67bi0tXTP/CcIlApUTME
         2qbaqRj6sxS5++0GRewdz3WdcATITz6w5slbdAub0m6eeVkz0c65wwwFvse2dBa6BcJJ
         YakpNQFFDm/NT9yyy51YI9GbO+7DzPo4/XCbjcDm/r8cvKwu4c8oxGOeaamCfHKPSRON
         fDnw1JWh+UAkgFVUAg+26VrtNnE7IicH8WKh4bJJF0FDEvoUsPrd8r3mOJrmEB6dT7Pw
         4kkw7IdFW99HhdRVXEi3NY4/pVzflOOQ/5B2KFMf4iCJIUsJCgR/MAKsdODtwV1Xtp5c
         qs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755706711; x=1756311511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbIBXkjzpro1lSKQx3DixkUfhZO5cnnCemwVjT931F8=;
        b=FdSmp8iWR1pzLKaLxIBvpX2gz0m9RGy4b7zsuHRoubXo5dIvbBJM31PDCBf6AakKVO
         /McvMiDY3ALrXUrR0VRCAjCuFbEbAMUT9xTgANH+bFZ9JyMRCLrBq7I9nF9u8abSfRQq
         MeljQJuJrPXT/EzIfolPtwyuTb7aGnMl7DrZNH1aYnqe2PisYx/bw8uQO5E9buFqUqxP
         yOuysezFKqsdiy2rvsIMISDpFiwAzpNmak7TnqGv6V01GWSrgcLSirsu7hZg0bX/9NTw
         8o2zAXfUZeN8rMN4IhMeKB4jM0IS30NvxDzutRMh1TZf4Sg/deA0Uaffhv8TjWnzntJT
         fyvg==
X-Forwarded-Encrypted: i=1; AJvYcCX5WOWD/HFLF2yZJKuCOUkiRB/bxzJWdTiu2/OQVjT/3O9xp0/T5cCd6eCyty/UEA/SrS4cdhF8Qo/kLg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DipgzDabFMUTdZkMH2ka5CaZkg6n1KOSnf8xdmUkqtCiMvCk
	TMcry8H3bQmAOwX8SoyF+7ugvUF8M+ZVVlAQF04REwts6fGo/kkpF5Rbi7LzMTc1SISojzH7//6
	ztFia5g==
X-Google-Smtp-Source: AGHT+IFf7xM6eNozrIlEIQuQlsTpvkezZkqf70mjUn0hYGfwmHZjVUeiPiaXieLgH9P/BZPxZ7N9paBfqZs=
X-Received: from pjbof13.prod.google.com ([2002:a17:90b:39cd:b0:31f:6a10:6ea6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a:b0:321:abd4:b108
 with SMTP id 98e67ed59e1d1-324e1334fe2mr5783918a91.12.1755706711464; Wed, 20
 Aug 2025 09:18:31 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:18:29 -0700
In-Reply-To: <c4adbc456e702b6e04b160efb996212fe3ee9d04.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250515152621.50648-1-amit@kernel.org> <20250515152621.50648-2-amit@kernel.org>
 <43bbb306-782b-401d-ac96-cc8ca550af7d@amd.com> <c4adbc456e702b6e04b160efb996212fe3ee9d04.camel@kernel.org>
Message-ID: <aKX1VZ90_wBxMI7l@google.com>
Subject: Re: [PATCH v5 1/1] x86: kvm: svm: set up ERAPS support for guests
From: Sean Christopherson <seanjc@google.com>
To: Amit Shah <amit@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, bp@alien8.de, 
	tglx@linutronix.de, peterz@infradead.org, jpoimboe@kernel.org, 
	pawan.kumar.gupta@linux.intel.com, corbet@lwn.net, mingo@redhat.com, 
	dave.hansen@linux.intel.com, hpa@zytor.com, pbonzini@redhat.com, 
	daniel.sneddon@linux.intel.com, kai.huang@intel.com, sandipan.das@amd.com, 
	boris.ostrovsky@oracle.com, Babu.Moger@amd.com, david.kaplan@amd.com, 
	dwmw@amazon.co.uk, andrew.cooper3@citrix.com, amit.shah@amd.com
Content-Type: text/plain; charset="us-ascii"

On Wed, May 28, 2025, Amit Shah wrote:
> On Mon, 2025-05-19 at 16:22 -0500, Tom Lendacky wrote:
> > > +static inline void vmcb_set_flush_guest_rap(struct vmcb *vmcb)
> > > +{
> > > +	vmcb->control.erap_ctl |= ERAP_CONTROL_FLUSH_RAP;
> > > +}
> > > +
> > > +static inline void vmcb_clr_flush_guest_rap(struct vmcb *vmcb)
> > > +{
> > > +	vmcb->control.erap_ctl &= ~ERAP_CONTROL_FLUSH_RAP;
> > > +}
> > > +
> > > +static inline void vmcb_enable_extended_rap(struct vmcb *vmcb)
> > 
> > s/extended/larger/ to match the bit name ?
> 
> I also prefer it with the "larger" name, but that is a confusing bit
> name -- so after the last round of review, I renamed the accessor
> functions to be "better", while leaving the bit defines match what the
> CPU has.
> 
> I don't mind switching this back - anyone else have any other opinions?

They both suck equally?  :-)

My dislike of "larger" is that it's a relative and intermediate term.  What is
the "smaller" size?  Is there an "even larger" or "largest size"?

"extended" doesn't help in any way, because that simply "solves" the problem of
size ambiguity by saying absolutely nothing about the size.

I also dislike "allow", because in virtualization context, "allow" usually refers
to what the _guest_ can do, but in this case "allow" refers to what the CPU can
do.

If we want to diverge from the APM, my vote would be for something like

  ERAP_CONTROL_FULL_SIZE_RAP

