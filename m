Return-Path: <linux-kernel+bounces-777486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5764FB2DA07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8AF7AE0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F55E2E11B9;
	Wed, 20 Aug 2025 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1RcFYYBF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DJO7qjkW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9A2DCC03
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685849; cv=none; b=bl7kytYqUTVOUhEVxmSBItzbtcL13/t61NfMq+Gn94djAmytxEWYlh/vFif3PVL9XEFZ9cWLpU+9v6Q1owQDokWfu1rqZAs7gNGezmtVvKXTX/FZ4ONOi24y2swNckUqYRT4KPIXnmMRO4LhHzWJvh2R1+LLAMndgI58xec01ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685849; c=relaxed/simple;
	bh=UaGYbeesrpg0oek5MewzqAMP7UUuwr2FCQtbx3jbdcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUrosPmzZDo403p9sSgshIQWQ8RVeHnIwRLYX2dnRiv6czCijXvlJlZVWK1eqFSoFSh/MAJHE+OR1sfrSjF9e0M872liCDjCEYVPNRWOE6mxeO7PvmOSUgrDLI93+Ht4/NvSJ25MIrv/UAgyslBiwU9/BII8JgukYcd+fYTE31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1RcFYYBF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DJO7qjkW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 12:30:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755685846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zaVTYfobWUE+bjjymjisIJ92DUMlRrRNvqMXW0nDgVA=;
	b=1RcFYYBF2Vmr3l7B4lixY7D+VNdGCUTCTpwvOBEON+ZWOd0uLj691dUw3ebXR5WrpHhoGC
	TqeDbvt5H3bBAw8emb5Sezy/wH6TkEqW5fnHfaOL3VdeBVLbsGDRvWJfj8iIy5MRBa9Aiv
	RuAZ6mCvWzKRNzdAjdsoFvVDQiJmeSJc4twBETfF3BiUTWrTEkl0toHIMOEfvwOGNYYSR+
	4KXJMTeIYmhKAcOOpClXqSQrYmXA+/AriOkLY24dJImR2EYcmNyaa5RVgdpWBtca7tcYaO
	4KmhkQR2Z8BeIWleJhmTOZw3GCAnJG4RXBgaxnqruiePw5dC9IRhPjv8DKfwrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755685846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zaVTYfobWUE+bjjymjisIJ92DUMlRrRNvqMXW0nDgVA=;
	b=DJO7qjkWFYf1lN9NpbwANoJ+6LNLOFEl7azcDovrLpEdT/vTNji2GELeBQsGGBOoahxWrY
	xuog2d4/i1UUgkDw==
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
Message-ID: <aKWj0SI1_qmT6dW2@lx-t490>
References: <20250820013452.495481-1-marcos@orca.pet>
 <aKWR8e6VUEZEgbkw@lx-t490>
 <2cd7b099-095d-405c-a7d9-b0f1f72184c2@orca.pet>
 <aKWfYo8lKmcHE14a@lx-t490>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKWfYo8lKmcHE14a@lx-t490>

On Wed, 20 Aug 2025, Ahmed S. Darwish wrote:
>
> Please do:
>
>     #ifdef CONFIG_X86_HNOP_EMU
>     static bool handle_hnop(struct pt_regs *regs)
>     {
> 	// Reference 'hnop_warn' as much as you like
>     }
>     #else
>     static bool handle_hnop(struct pt_regs *regs)
>     {
> 	return false;
>     }
>     # endif
>

And as previously suggested: remove the ugly hnop_warn stuff from
'thread_struct', then you can even just do:

    static bool handle_hnop(struct pt_regs *regs)
    {
	if (!IS_ENABLED(CONFIG_X86_HNOP_EMU))
		return false;

	pr_warn_once("%s[%d] Emulating hintable NOP\n"
		     "This warning will not be repeated; even for other binaries\n"
		     current->comm, task_pid_nr(current));

	...
    }

And everything else will fit quietly in place.

--
Ahmed S. Darwish
Linutronix GmbH

