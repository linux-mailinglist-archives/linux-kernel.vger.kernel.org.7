Return-Path: <linux-kernel+bounces-830206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 446AAB990ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2B819C6372
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47A2D63F6;
	Wed, 24 Sep 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rz86vAIF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A120200BA1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705477; cv=none; b=uTH+FKT3+QX9I/2oP2jr53ULgC69vjN0m7fpq/b1PCX6wRbZjX2dFmPtzbcWaUMp3R8+AVSPLQwGPkv0rFXCISwqMlOokXbcCQ+vOFT+hxrCRnAZ9wALk7NDRROd6BhGbZGngQxiLBvw9eN/MVfqXr3KcK6Y8/BseFg98Qy+5XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705477; c=relaxed/simple;
	bh=xg7GZW/rJphiTlukpOcrakNgzK2BFUfsxpYCPWK89aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM8TwxCoq6U5p0dQyrclTV9PbmdVaWv89m8WvY7PmtzfokvDWiRr1FqzwI3WYZKmMmTaWQuxkqVLqEQpLj4NMI/fQjdAIY2dgAmtAJrPKSzpaf9K42jQDfarPXhK+jLqRt+X41wT9zOWhAU1font0XYwiJXcqU1gNiyf4n6nrz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rz86vAIF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=izBkuHLeazq1xWoDKzp63Y1vbF3xEzSp/MoEgcjLdxM=; b=Rz86vAIFq3UamqtKF/wGwG0fPs
	T0LgBhY+S7A6CbJ8nIbq7gjDGcVpaQC570mcFOuwLEkikBf5nvZyR9NalKdVs5HvAymOPYo8oOnFv
	nTpoN13h7xi4fonQcJ/F0T0czjNDQc1wk9iwwtBBNERnZhNM0KrxKB68AQxlnE5LlHXrW2rYrAtpc
	aF01WAzyQ2Bx+RDvbPWpz5Jd0zxB83ggs56BcaEZBu/geZhRGCR4zsmlOMB0K6zZW0ANSto16QVd8
	Zh17+Swb9+Pil9RKABB9wrGozOWx0i6X9Ztb9l9B1fI3Kp1JUEa4ev7xuT/2mXU36JAn867lyes6F
	b4ng+CVg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1LdI-00000008iVE-1MLD;
	Wed, 24 Sep 2025 09:17:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2CF1730033D; Wed, 24 Sep 2025 11:17:51 +0200 (CEST)
Date: Wed, 24 Sep 2025 11:17:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
Message-ID: <20250924091751.GX4068168@noisy.programming.kicks-ass.net>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924073649.GT4067720@noisy.programming.kicks-ass.net>

On Wed, Sep 24, 2025 at 09:36:49AM +0200, Peter Zijlstra wrote:

> >                       | <alternative.65c4e> alt 1/4 end
> >  65c4e: os_xsave+0x2e | <alternative.65c4e> alt 2/4 begin
> >  1c3d: .altinstr_replacement+0x1c3d | | xsaves64 0x40(%rbp) 
> >  65c53: os_xsave+0x33 | | xor %ebx,%ebx 
> >  65c55: os_xsave+0x35 | | test %ebx,%ebx - already visited
> >                       | <alternative.65c4e> alt 2/4 end
> >  65c4e: os_xsave+0x2e | <alternative.65c4e> alt 3/4 begin
> >  1c38: .altinstr_replacement+0x1c38 | | xsavec64 0x40(%rbp) 
> >  65c53: os_xsave+0x33 | | xor %ebx,%ebx - already visited
> >                       | <alternative.65c4e> alt 3/4 end
> >  65c4e: os_xsave+0x2e | <alternative.65c4e> alt 4/4 begin
> >  1c33: .altinstr_replacement+0x1c33 | | xsaveopt64 0x40(%rbp) 
> >  65c53: os_xsave+0x33 | | xor %ebx,%ebx - already visited
> >                       | <alternative.65c4e> alt 4/4 end
> >  65c4e: os_xsave+0x2e | <alternative.65c4e> alt default
> >  65c4e: os_xsave+0x2e | xsave64 0x40(%rbp) 
> >  65c53: os_xsave+0x33 | xor %ebx,%ebx - already visited
> 
> I find it *very* hard to read these alternatives. If at all possible, I
> think something like:
> 
>    65c4e: os_xsave+0x2e | xsave64	| xsaveopt64	| xsavec64	| xsaves64
>    65c53: os_xsave+0x33 | xor %ebx,%ebx
> 
> Would be *much* easier to follow

Another option is to write it source-like:

  65c4e: os_xsave+0x2e | ALTERNATIVE("xsave64",
                                     "xsaveopt64", X86_FEATURE_XSAVEOPT,
				     "xsavec64", X86_FEATURE_XSAVEC,
				     "xsaves64", X86_FEATURE_XSAVES);
  65c53: os_xsave+0x33 | xor %ebx,%ebx


We have the 'feature' bit, we'd just have to 'borrow' the feature
strings from the kernel I suppose.

