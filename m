Return-Path: <linux-kernel+bounces-827644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0CCB924B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F462A5C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A002EB860;
	Mon, 22 Sep 2025 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jP+SkGLC"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C21220FA9C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559681; cv=none; b=mPzK/ilVQMzTNmJOmD/QWb5l62JPd59yDgfPk/6FDfPiIRxPui2roCgXFZAOEVawWG2e8d2tvnXCuFHeVFkLyq3vaHZAaH6WIB3Ul7lgFMCm6SBCD6GZDJtigKK7u9WB/x9TV8la3K3zM5jgIYTvPEDaT4Y4CKn8A5I/wuJC9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559681; c=relaxed/simple;
	bh=oBsuLu2JKLUCe613+lzwlMJIhrh+NP73BJEi31jJDSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fXCgaa5jzmLZYGnSv43wrbnMc0hrTfJT+Rlya6VWhk3BkB+b37ru4fX2E357nXQ4DAs6o+G4fOaR9A1EQ+n6p40aUcVUoCS6/3LzTh6RWohGMqPDPB9x54g4jgoeBEcnA7FVeZYMTi5t9ikeDY8j0llx2P5Y00IjgRpVgelPNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jP+SkGLC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so4408170a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758559680; x=1759164480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZxssYmv2P9XlWR/CvEwa1BjM+msCoDFVwURRmwcEDI=;
        b=jP+SkGLC60/9s1E5ZY3XRbrOlOjUNQEvMW/UMFO9O9U3Q0he/Zu3I2jR+PmhNJJj62
         UZ40WDLFO28Kbn1qWDXZ2ihGqRZXxDz1liTYnqSebmEVTjFmzXiyLIxhZgp/obsZyO6Y
         hOKFoks79TWchvya99JfnagBAtAVBxg3gj7/8qdGvXuPOBKHWiKToIAaYgQKLWP0tvNc
         NInzhOQE3nBy221rfzCtpX9M//D25lhcELDXg+JWeaO/xnnofEqKJrLiY9OdznmF5qu7
         wbeC0fx/tEWpjPEVkbGa4vN8H1+cUakIX4NIO67H2fxN9MfXJJAHop8TA5HtPYNE7hxt
         Hv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758559680; x=1759164480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZxssYmv2P9XlWR/CvEwa1BjM+msCoDFVwURRmwcEDI=;
        b=ByIJ1fcuVWr6jYn3NAU0LlARzEavLsMUEtb8oGDUnzEnbTWrTJJsOURHdLR/+56LhC
         3U7iF4tUmi4YoMAyWPWJf8rGDXusuJpmY87HvQEZOmyZqPSGIksQsusbxy/2KW6VIzSS
         2Bhb+FDhr2zvN2FkgPJnr7VjrexDmDYb6VQ5HAwOGiODzy95aTzmy7zuTFdkN4ESEY6v
         wLGpnmq8IhiwavEiL7ux+TS+7rNVnx5hTQsBlDYl0h83rDy/NguOh+ONA7H0xXaGPIdX
         k/p+AbaN3bmJbEM0mIkGrR2CuySUBkXSaxJFpqZsvTIQ5OGk86zAKd3D++xxyin2+Xzr
         8ciw==
X-Forwarded-Encrypted: i=1; AJvYcCUogvEpGg5BAhg+9DD8TXzQVeMggO+4jbY0nGj8RNxec3691eT3ymrQxheMj+2LjHXKOyDOomlyRtPvi38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzIW1UjaXVNhuw6sjESZ2VvHRvteYphaQA3/TBz/RPOv1N9bF
	1PbbL1LkCgqEvRj0PyYujxNsTGaYmA+WUfJUeLwfhuxmr0Loz3CHyyiB5+AvBa532faevM74p2w
	MpsxJrw==
X-Google-Smtp-Source: AGHT+IGojpc09mO4sS5IQtH1pMKr5UDq6eS+hvNvRxsB51ymoZmpeQBnjx9Nm2euJcyPrtndPO4XVevFu9c=
X-Received: from pjf16.prod.google.com ([2002:a17:90b:3f10:b0:32e:c813:df48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d07:b0:32d:d5f1:fe7f
 with SMTP id 98e67ed59e1d1-3309810d081mr19272382a91.15.1758559679712; Mon, 22
 Sep 2025 09:47:59 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:47:58 -0700
In-Reply-To: <fd8ebddd-adfc-4eef-bf30-20139574d0dd@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com> <20250919223258.1604852-19-seanjc@google.com>
 <fd8ebddd-adfc-4eef-bf30-20139574d0dd@linux.intel.com>
Message-ID: <aNF9vnXrRnKjC1DD@google.com>
Subject: Re: [PATCH v16 18/51] KVM: x86: Don't emulate instructions affected
 by CET features
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 22, 2025, Binbin Wu wrote:
> > +static bool is_ibt_instruction(u64 flags)
> > +{
> > +	if (!(flags & IsBranch))
> > +		return false;
> > +
> > +	/*
> > +	 * Far transfers can affect IBT state even if the branch itself is
> > +	 * direct, e.g. when changing privilege levels and loading a conforming
> > +	 * code segment.  For simplicity, treat all far branches as affecting
> > +	 * IBT.  False positives are acceptable (emulating far branches on an
> > +	 * IBT-capable CPU won't happen in practice), while false negatives
> > +	 * could impact guest security.
> > +	 *
> > +	 * Note, this also handles SYCALL and SYSENTER.
> 
> SYCALL -> SYSCALL

Fixed.

> > +	 */
> > +	if (!(flags & NearBranch))
> > +		return true;
> > +
> > +	switch (flags & (OpMask << SrcShift)) {
> > +	case SrcReg:
> > +	case SrcMem:
> > +	case SrcMem16:
> > +	case SrcMem32:
> > +		return true;
> > +	case SrcMemFAddr:
> > +	case SrcImmFAddr:
> > +		/* Far branches should be handled above. */
> > +		WARN_ON_ONCE(1);
> > +		return true;
> > +	case SrcNone:
> > +	case SrcImm:
> > +	case SrcImmByte:
> > +	/*
> > +	 * Note, ImmU16 is used only for the stack adjustment operand on ENTER
> > +	 * and RET instructions.  ENTER isn't a branch and RET FAR is handled
> > +	 * by the NearBranch check above.  RET itself isn't an indirect branch.
> > +	 */
> > +	case SrcImmU16:
> > +		return false;
> > +	default:
> > +		WARN_ONCE(1, "Unexpected Src operand '%llx' on branch",
> > +			  (flags & (OpMask << SrcShift)));
> > +		return false;
> 
> Is it safer to reject the emulation if it has unexpected src operand?

Not really?  Maybe?  Honestly, we've failed miserably if this escapes initial
development and testing, to the point where I don't think there's a "good"
answer as to whether KVM should treat the instruction as affecting IBT.  I think
I'd prefer to let the guest limp along and hope for the best?

