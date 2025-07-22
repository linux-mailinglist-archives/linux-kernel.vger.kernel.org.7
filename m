Return-Path: <linux-kernel+bounces-740199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580AB0D147
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1061AA125F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDFE28851A;
	Tue, 22 Jul 2025 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mw4gxcmm"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98519DF5F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753162526; cv=none; b=I+Jx4SqNrZZ5UbiDqxAO+TBdAqIxWOj/PnvtF2bWIsifZRZdAn9NzMetiAJHCjc2qcSLMauShvfl+yRMp5aGiUcee741kkUjoeHouM5vYMECYbld2T9z8ZX/Mpjimf0s4yZpcNiCKQcphtUUBUHqTliySrO0lD+gaDwWcSuG4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753162526; c=relaxed/simple;
	bh=ruuEAcDWdE64lz7pSSWYDh5tOoV/jusMPO/T2289xX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM3Tc/ucE9EEMcr12kE1Ap0gsZ+0thy2zkEnFZ5mfipKB+mawJAy7YPHVtuVU+qDdHLVLfhKHrrC6BRD92+dlDOa0LkLkYBJs+GKGjbtYeRfH6n9se/GG2D9azIJ+5Yhm2qGStETGIi3DJ8nbbGqsTbHzrEHOP4G1ZC0Ta3RAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mw4gxcmm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=222tl/sLtZZAS2T/Yb1/Oqf8uze7Rhp5RqCT1aKB9cA=; b=Mw4gxcmmbc3SBY4qMRci3vY6X6
	18ubZYUu9OLG0Z3iF0rJQzV9FNoUGHvj0cTRNn8+c8fe2mn8j47hrIhpwpa7x7MxVb5n+IpUqcPEe
	sTgaVtzIcFAGPep9rs/G2HejgVInWqot7lAdQzmtZHC2/FscQ5w1jp0hj6410A4xOXWzybo+W8GTm
	Z9jBtzoIlTwUAB/9Y4KpAlvdyJ4H+lLTxAAT2f+qpR2avFDlu/uOk94yK1ch4kezQDGU0Beisv8fH
	bj5WuiL6rO7cSsWZDHj/Mv7H0XeCZ2BusefdpNFlLDUQ6mFzSIDE5Qn/tQ7bnTeSTZ3GJQI8uKt+T
	6mGd1z6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue5en-00000001LQz-08an;
	Tue, 22 Jul 2025 05:35:17 +0000
Date: Mon, 21 Jul 2025 22:35:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	Fushuai Wang <wangfushuai@baidu.com>, aruna.ramakrishna@oracle.com,
	aubrey.li@intel.com, bp@alien8.de, brgerst@gmail.com,
	chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
	oleg@redhat.com, peterz@infradead.org, rick.p.edgecombe@intel.com,
	seanjc@google.com, tglx@linutronix.de, vigbalas@amd.com,
	x86@kernel.org
Subject: Re: [PATCH] x86/fpu: Fix potential NULL dereference in
 avx512_status()
Message-ID: <aH8jFcoU0C82QkNS@infradead.org>
References: <89987231-37ce-4d49-a1d7-6e699e8ab0d2@intel.com>
 <20250718071250.36019-1-wangfushuai@baidu.com>
 <99baa18c-ae1c-47e1-8bbe-e411570df8f1@intel.com>
 <b3dbca94-8603-44ea-b778-97483fbbba94@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3dbca94-8603-44ea-b778-97483fbbba94@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 21, 2025 at 07:09:52AM -0700, Dave Hansen wrote:
> On 7/18/25 16:48, Sohil Mehta wrote:
> > +       /* Do not report AVX512 usage for kernel threads */
> > +       if (!(task->flags & (PF_KTHREAD | PF_USER_WORKER)))
> > +               timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
> 
> But the original reason that folks wanted this was so they can go find
> all the AVX-512 users and cluster them together. They obviously can't do
> that today if they're oopsing their kernels.
> 
> But the real question to ask here is whether kernel threads can use
> AVX-512, and whether it's important to let userspace know which threads
> are using it.
> 
> Let's fix the oops, then circle around and figure out whether tracking
> AVX-512 use in kernel threads is needed.

The RAID6 Q-stripe calculation has a AVX512 implementation which
usually is called from workqueue context.


