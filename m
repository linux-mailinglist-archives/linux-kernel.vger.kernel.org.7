Return-Path: <linux-kernel+bounces-856086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCDEBE30B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB895863CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483E53164B0;
	Thu, 16 Oct 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+j1Wu31"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76887263B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613827; cv=none; b=F0AA7aUX2dw+drnYNR3z51DH4U+APgN2TUYPUznOIj8N5GW5h0MoX5TjgO9PdqnBkV+x5NPY51H20GD+ETlAd3FmlxdH/uD5wi7yOqbN33wxSBy2rKPXINCsj8qZHIiHP/v1M7YItxr1iB9/xuuz/n/q+arkVLZi0GfMxSNenYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613827; c=relaxed/simple;
	bh=2QNDr6BJ4iK2s/4Apca2Q4H52oQZE9xEwuSWhaOl4SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyP8j37PX/qSy88desxZj/aX+rFrijAU1H42we8SJr+tdhIN6pt4CQ3gsO42XFA940FAuKqLG2Yb47TP4YYWCRFcS7WE47YEABK9qwYtpNd58Qvl2bUc+J7uMg8NfGq20RPpAq+Q8zcUb4b4RlQv4yLUfoe+P6lk12le1u+PIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T+j1Wu31; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kzvos0GfmE1bLYBsytWgHBjCtrXqHcUYEkroBXgRp40=; b=T+j1Wu31HkhSWC+QLQtkAIc6Gf
	4x7Q2rqdjzqoIB2lFtXHb5bBRht4qsqiN7EATkm6YPtZB98Rgn12z6s+Sfy9xidre2EM/nqjEPG4V
	OLzZBf/zx8Ju9HytqWVLRJROQM9CMzYdsjRN+Qkwj4tm0ViixHY+ipbjBwqrXifh9vRqxD7RQ/OvN
	WSf/xKdiBM2iyMg97MH6LRGR2yt3bFDDU8tbivlvryiZncVAbi15gM25OR1oeyzaJF2w6agwGg463
	soypikux43N0F43ENktCilQFZI2TbpcQmgCiu7Cy8o/4rmpIyQgbnEteMo1gkopNyFepx/Zvq6KlC
	X6eyQSJA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9M4s-000000025e4-3MMs;
	Thu, 16 Oct 2025 11:23:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0FCCB30023C; Thu, 16 Oct 2025 13:23:27 +0200 (CEST)
Date: Thu, 16 Oct 2025 13:23:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
Message-ID: <20251016112327.GQ1386988@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-32-david.kaplan@amd.com>
 <20251016110717.GE3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016110717.GE3289052@noisy.programming.kicks-ass.net>

On Thu, Oct 16, 2025 at 01:07:17PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 13, 2025 at 09:34:19AM -0500, David Kaplan wrote:
> > When patching retpolines, nops may be required for padding such as when
> > turning a 5-byte direct call into a 2-byte indirect call.  Previously,
> > these were appended at the end so the code becomes "call *reg;nop;nop;nop"
> > for example.  This was fine because it's always going from a larger
> > instruction to a smaller one.
> > 
> > But this is a problem if the sequence is transformed from a 2-byte indirect
> > to the 5-byte direct call version at runtime because when the called
> > function returns, it will be in the middle of the 5-byte call instruction.
> > 
> > To fix this, prepend the nops instead of appending them.  Consequently, the
> > return site of the called function is always the same.
> > 
> 
> So this results in:
> 
> NOP3; call *%r11
> 
> And you're saying a task can be on the other side of that call and then
> return lines up. But what if the task is preempted right after that
> NOP3?
> 
> Same for all the alternative patching; what ensures no task is currently
> having a register state that is in the middle of things?

Ah, I found it, you freeze everything, which puts it at safe points.

