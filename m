Return-Path: <linux-kernel+bounces-856076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEECBE3039
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76A3C4E4FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B353307491;
	Thu, 16 Oct 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lqFMMEpD"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69352307487
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613057; cv=none; b=f5OEE0zD9Km/QT4ei4EVWguC4uteOmNZy68v2GcTawygxom8j2S+w7nPx38cZjUiSCrrJExmfyLL1AFEEhLUd75AYbw9PM5BdB/lZoGFh7jhhbrcpnp6QANR0G5zz/pA9ijjdWFrtuguPepjjoKC8HrjBzZm1xPg+QkNyYDG2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613057; c=relaxed/simple;
	bh=MUEntCr2Dyf3s21UeE6RAqOb6Ge0RHsUvZzXKmFSj24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOrXQfl31ZOmNvN3J9x706CIsb/aXpHQWw+JcU4iPyxoZcnUGegolq88KwTHl8Zz5e+Tpm1z/nwyaZ5emv/J8zkrVlV1gD2q200uelQRdFpLbp+y3PNjPknuTVsARpLR+N8i1Kz4e5EGr3XTQ+f1/UwxgsKwWKOhgHd7KCGjUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lqFMMEpD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mbcRg+C7qz18C4vqHks8odgTF0Z26ChkfEwT8Scgj+Y=; b=lqFMMEpD5Ak/0rf+7l9eid7CPA
	rJScu13GynWeWQdQVXyw3yT5jmqrpUs21lsp8PlQ2c94gDnIH3ZvojkmOf3bXynpI/kNqfwhI9kL0
	h/S4h2b2QDwsqz4/dE9XRwBbCvG9TS8+5KuK0N0byFEyDjOmktS6fYLJHN1iXihyCnGb6M8JlzE/G
	oXRao3et6ZSQaf731mgUiuwDV4eswsF1WAfIPQKzrDXjgtj35vTR5pK4KwD1ZXCWA9Q5ZyRWTr8Ka
	nDsI/OwRWCTpiwhumM4r6kgq7XB33+QoQVxtUiQJA0QltqhL8M9msGTG6xRi9Df4MenHg31wmxio1
	MoucdyyA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9LsX-00000006hNn-3L8B;
	Thu, 16 Oct 2025 11:10:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60EE230023C; Thu, 16 Oct 2025 13:10:41 +0200 (CEST)
Date: Thu, 16 Oct 2025 13:10:41 +0200
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
Message-ID: <20251016111041.GP1386988@noisy.programming.kicks-ass.net>
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

Also possible:

  lfence; call *r11

(which is why we needed 6 bytes for reg>8)

> And you're saying a task can be on the other side of that call and then
> return lines up. But what if the task is preempted right after that
> NOP3?
> 
> Same for all the alternative patching; what ensures no task is currently
> having a register state that is in the middle of things?



