Return-Path: <linux-kernel+bounces-779973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D69B2FBCC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DA9AA65D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805082EC574;
	Thu, 21 Aug 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DomIJUUh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475646B5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784799; cv=none; b=eK73hZrHCLtN15Vp8R06cNJm4tvouuldVLFTfuP9Z2stabhZX+qjq0r8hqJSdtyZYNTTXZf91USZ44lUt5tnheUuHWIECDHmzNYfqXxiutfm02M1XgriXJUbvNE3r1h8urnHsjqe8XQZT4yCP+prDv6+v4DxTwR5p9IURdGSmS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784799; c=relaxed/simple;
	bh=Lu2bYgG5dOuLdip1WI1gX3Gl0kPuIjNwVUw97npG0zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZDaak6MXehcu8splYjfq+Ec4a+xxnjG9BUYpESGqs2o9ji00eCfSxSDVKnHHtbbOT7WO6Z2m7Zqua79V20+Gsk5ZSvVTvP3HPOYHt/BN1bmHQebi4apoTw2tP0RRu4tZyIUL8CCwQoH+wYIenM/rKA7gW8BB3pyL6WzEn46nDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DomIJUUh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=K0ldq7vnLW7qoAr345+DDDIwBqqpyaF5tEeLb/FgKHg=; b=DomIJUUhiGMbybJXjF9ITOPRWh
	/kMXXM3LvWPzmdLUd/8xhanFhs/NqSiK0Chh2/NbJyqQCZGpAYm1exlWJvYQTx8P/d1ZEO3FZPZ+y
	qSIRaEx2xA8bouxzMDAoYM9t8NaqVHu7jjnQNv6Ah3ZisY3bjcfh5vMzfhukyZmmicZRHO79Nb2U5
	GngBh3eMAg7ISYiacnfFC2pQIR3AO8nEks6QqaJPnb7F4MdLtD9iP+At5RYf8uI0RYAFnzvnmE+ch
	D0jAvwOzXA7ahCcLBLDG36H4vSNBsexaetN5iKylVr+5iny0IbfIK+bQbrdp3WfG1Ojdp2HkWWIW4
	eBUz8lvg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up5pU-00000000aIs-1rlX;
	Thu, 21 Aug 2025 13:59:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 056483002ED; Thu, 21 Aug 2025 15:59:48 +0200 (CEST)
Date: Thu, 21 Aug 2025 15:59:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Oleg Nesterov <oleg@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
Message-ID: <20250821135947.GR4067720@noisy.programming.kicks-ass.net>
References: <20250820013452.495481-1-marcos@orca.pet>
 <20250821124804.GP3289052@noisy.programming.kicks-ass.net>
 <666f534d-b974-4f39-9356-3e2f1ab178f0@orca.pet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <666f534d-b974-4f39-9356-3e2f1ab178f0@orca.pet>

On Thu, Aug 21, 2025 at 03:45:29PM +0200, Marcos Del Sol Vives wrote:
> El 21/08/2025 a las 14:48, Peter Zijlstra escribió:
> > On Wed, Aug 20, 2025 at 03:34:46AM +0200, Marcos Del Sol Vives wrote:
> >> +	/* Hintable NOPs cover 0F 18 to 0F 1F */
> >> +	if (insn.opcode.bytes[0] != 0x0F ||
> >> +		insn.opcode.bytes[1] < 0x18 || insn.opcode.bytes[1] > 0x1F)
> >> +		return false;
> > 
> > FWIW, you need to check for insn.opcode.nbytes == 2.
> > 
> 
> I can add it no problem for clarity, but would it be really necessary?
> 
> All opcodes in that range will have that length by the Intel SDM, so it seems
> somewhat redundant, and if the opcode couldn't be read in full the decode
> would've failed earlier.
> 
> insn_decode_mmio for example which I used as an example of software parsing
> of instructions does not check any length if the prefix was 0x0f.

Yeah, I suppose you're right.

