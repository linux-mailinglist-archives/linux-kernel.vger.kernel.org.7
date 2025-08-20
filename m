Return-Path: <linux-kernel+bounces-777473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1FBB2D9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E6618905EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B912B281369;
	Wed, 20 Aug 2025 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DrGkWONN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JLF5aZp1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A02E40E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684718; cv=none; b=Njlbwf828oP32quKt9qYzj0EYONeWq/jZlFC4hoOEGugo1dPW9xJNIR3QA/ViNwdBtJpdi4yrgMjphuCkRSH8k++AyQyG0Fi3xeTr1yLi+A6ZWU9mJfDE9vRYEWOL+0w9JoefuKkpywPxLXzXOG72NNOSDq1FicL4gP2OMOjGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684718; c=relaxed/simple;
	bh=i/996S0nRmN2vIPp+Dd7JNYsfLMsofJNfMkhQ74HIis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO/fmIg1/1GEYhClUgj0vFXKpf5Q/rF/eTNOkH13hd13hYSpWc9ggUegp2XVVXCB4e3ONcmDm4Sy3Wmr/lUcc6QQZ5MmK4OwMB2KJklid2v98GurK20XcpQS5VGl1u41ueh/3mL65SubpFy/QXk+9nPMl0K7neWR+eHwO8VB6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DrGkWONN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JLF5aZp1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 12:11:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755684708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VO/J2/Gr0OM3zaYFGDDJgauRRPzk+++gnvVjrF1KdnE=;
	b=DrGkWONNkRik2WVABvzoHYir8aPHD9rwObzadiFOspRnitm/lgHmJVoI3LTPWr6/PjIqve
	RkKFVtxVYV0QzrNx7d/E8IS3z0fZnBg9WJuzbjZfZqNZ35/5rN0r7Ec63TLhF0R5GM8egU
	XuTvFkv8QDW4nAnlsikKHUnbS2ZWusxd5LaOUvPbE1cJuv2SQBeXh4Y0z1K+6ly8UDJip+
	xNZHwHOGpmuzYWeVYUjIfeoh9dLCelWbqwTLl6uvv/OC4kdOlUyoRi5avZzvKT28vW0+++
	KoHhdr8yekIHkv93pHEus+1q+6ODMBGKSDGb1PbnjWSIONFsWQJw7+h2iEO8YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755684708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VO/J2/Gr0OM3zaYFGDDJgauRRPzk+++gnvVjrF1KdnE=;
	b=JLF5aZp1DHZgQIt/SnosYTBH6lRmLz2yZV6TEQX8QSt34DdfFUOwQnOVvENy4Nh0j8GciZ
	vE/wktApSOK+1lBw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	David Kaplan <david.kaplan@amd.com>, Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Oleg Nesterov <oleg@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
Message-ID: <aKWfYo8lKmcHE14a@lx-t490>
References: <20250820013452.495481-1-marcos@orca.pet>
 <aKWR8e6VUEZEgbkw@lx-t490>
 <2cd7b099-095d-405c-a7d9-b0f1f72184c2@orca.pet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd7b099-095d-405c-a7d9-b0f1f72184c2@orca.pet>

On Wed, 20 Aug 2025, Marcos Del Sol Vives wrote:
>
> But I think the kernel should let the user know the binaries they're
> running are having some performance penalty due to this emulation, in case
> they want to recompile without the offending flags.
>
> Without the logging, they'd be in the dark and might get confused on why
> their programs are running slower than on other machines.
>

Not convinced; especially all the extra 'thread_struct' noise.

>
> I originally did that, but then realized it was not possible due to
> "handle_hnop" depending on the conditionally-available "hnop_warn" flag.
>

Please do:

    #ifdef CONFIG_X86_HNOP_EMU
    static bool handle_hnop(struct pt_regs *regs)
    {
	// Reference 'hnop_warn' as much as you like
    }
    #else
    static bool handle_hnop(struct pt_regs *regs)
    {
	return false;
    }
    # endif

Then this ugliness:

    static inline void handle_invalid_op(struct pt_regs *regs)
    {
    #ifdef CONFIG_X86_HNOP_EMU
     	if (user_mode(regs) && handle_hnop(regs))
     		return;
    #endif
	...
    }

can become normal code:

    static inline void handle_invalid_op(struct pt_regs *regs)
    {
     	if (user_mode(regs) && handle_hnop(regs))
     		return;
	...
    }

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH

