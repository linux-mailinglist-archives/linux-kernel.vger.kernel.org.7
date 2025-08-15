Return-Path: <linux-kernel+bounces-770403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F83B27A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99FD1C24DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC1D299A87;
	Fri, 15 Aug 2025 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m7vvAPFi"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1991553A3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244186; cv=none; b=afgSXemPIGa17iGkz/lSAYlH8cGCQgyZgdYzhPhLiy9CtNdSxMohrn0fgqDur6bmtoKp6bHYS0R+JA7vlpDQ38ipJJ0I23ohA4JkypjiSu9vXb9pSVuG7UNYacVBKowLE8glmXvFjXND/KSr1HIzHMGVJvcFCD6KbcDpNrrkuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244186; c=relaxed/simple;
	bh=1xKi1gkLVZmCTXUbS8F1+qjOgb76aPPKPRhO1m+NqbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjxoJ2yzN04lmmhIv+BEEm9LhEzN9A0prQbiBNZX+oSlPZLLcGm0kCC9Dizjh5LNhDKh5O5bM1NlUPnDqlVg5206iA9nvUaczPMEaBl7RgLA5i1uymRAYELV/4olYc957mksIccx02y/XTCMFHMqL2dTypVPWvFBP5GueD+uHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m7vvAPFi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Me8O43WKUcrfvWnG7HG4/nfPriw+TSMDV/5heVJ1RL0=; b=m7vvAPFildK13YCwNPmbtMbmCV
	q4LCKLa3j6nYQKlAp5M9SW+EuWhD3VLREClt9/UY8uPsTiy3QqpWoOR75ubLap2cP9tNM9zr6pRiS
	KbUF3xTf5sgMCcwCIgEZJWO5PHZ+NArIjO1MYvund6LAgv70TCiFKs8rRsc4YusViMyM1iXmdN1EW
	SJHuUtR+p/G6UpMfV3KPUwIh/N+tJ6C4LRf4PD/MwmIolqAsOQE8lhOpGJ3c6bcra4MnMlkwRwNd+
	neJI6k8BHQCm46sbxGbZMa1dIWZ+RN2SPM1OKZ5D2pG75CgtcmuKeShzfwSNLe/12T4JqiVV2yYht
	/0VuiVPw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umpBz-00000009yQT-4B1o;
	Fri, 15 Aug 2025 07:49:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 367013002ED; Fri, 15 Aug 2025 09:49:39 +0200 (CEST)
Date: Fri, 15 Aug 2025 09:49:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kees@kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, samitolvanen@google.com,
	nathan@kernel.org, alexei.starovoitov@gmail.com,
	mhiramat@kernel.org, ojeda@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250815074939.GA3419281@noisy.programming.kicks-ass.net>
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
 <2c121572-8fde-4288-80ca-ab79f2b22cce@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c121572-8fde-4288-80ca-ab79f2b22cce@zytor.com>

On Thu, Aug 14, 2025 at 06:27:44PM -0700, H. Peter Anvin wrote:
> On 2025-08-14 04:17, Peter Zijlstra wrote:
> > Hi!
> > 
> > A while ago FineIBT started using the instruction 0xEA to generate #UD.
> > All existing parts will generate #UD in 64bit mode on that instruction.
> > 
> > However; Intel/AMD have not blessed using this instruction, it is on
> > their 'reserved' list for future use.
> > 
> > Peter Anvin worked the committees and got use of 0xD6 blessed, and it
> > will be called UDB (per the next SDM or so).
> > 
> > Reworking the FineIBT code to use UDB wasn't entirely trivial, and I've
> > had to switch the hash register to EAX in order to free up some bytes.
> > 
> > Per the x86_64 ABI, EAX is used to pass the number of vector registers
> > for varargs -- something that should not happen in the kernel. More so,
> > we build with -mskip-rax-setup, which should leave EAX completely unused
> > in the calling convention.
> > 
> > The code boots and passes the LKDTM CFI_FORWARD_PROTO test for various
> > combinations (non exhaustive so far).
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Looks good to me (and using %eax will save one byte per call site as
> well), but as per our IRC discussion, *my understanding* is that the
> best possible performance (least branch predictor impact across
> implementations) is to use a forward branch with a 2E prefix (jcc,pn in
> GAS syntax) rather than a reverse branch, if space allows.

Oh right. I did see that comment on IRC and them promptly forgot about
it again :/ I'll have a poke. Scott, do you agree? You being responsible
for the backward jump and such.

