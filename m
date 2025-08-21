Return-Path: <linux-kernel+bounces-779790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5F8B2F8CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82A78B63EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E831DDB5;
	Thu, 21 Aug 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OqLsjddJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F431DDA7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780494; cv=none; b=QBJJKwgryST/uYNWFBDQfccQa/+MwG0ZEsl17zqLyhiMchRwH2zXwLhzLEgohYWbDmL2tKUT2hX3P8T4uiOsNgs81oWHy/2Vyyu8WqVjaqYPJEWIw/2GS2CwjIMELr3olWAZvxFjj+OdNWptAMKtQXQgihFqIgN3cU11NgtqX2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780494; c=relaxed/simple;
	bh=Do0j0v5kNYzW3LiK4jyAkZwTHofjmZdzcjqQZHywvEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUJsOiG2fcCrrLlmfikxZaUMLFfl9b8Sgu4BK/egC/bMWcV22BuzRu+W2Q82vdH1d40UyHgtVF06usqVNR3SwLfINycnOXnUbhhDAp+OH1MH/xHYwRjVsiR94E0wme9jZX4KcWxF6AUeuJuwpnEBFB0YKeRKK48k/jtCm4GWjAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OqLsjddJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/KUgYQxH7a7g1wbBy1/HJEg7pdhs92wukvyptpmXFfY=; b=OqLsjddJGMaYiOFyOIWabawzt9
	grkWipNRy4T9+PT97g3+7Y8AkEXhl8I6aPg/I3bpNYnOzfd4YN36VefHXWbU+nQydva3ZDhf1DfPn
	/Oa1n/zzUcLmam2SRmU/lcs6YIhjQW4P5AwSFZcM4PbyCius+H0uCxgade6xUTsTmH5U3cduQa6rY
	Ta79Lq4K7gJNk8ioe6662Ce1LfI19dLwr56l+gaNL7xr/5hxtud0VGqg5lmYfayDUcWQ/R2lkV+RP
	b/YpQL2wZAq3bRjlYkg03D3vO2G86Y0yA0827qaX38iY1H4O/Dk3y0iu+G+pZvuqWBak19K71u9xz
	tEbDaPiQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up4i4-00000007CjP-1SHt;
	Thu, 21 Aug 2025 12:48:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8E6573002ED; Thu, 21 Aug 2025 14:48:04 +0200 (CEST)
Date: Thu, 21 Aug 2025 14:48:04 +0200
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
Message-ID: <20250821124804.GP3289052@noisy.programming.kicks-ass.net>
References: <20250820013452.495481-1-marcos@orca.pet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820013452.495481-1-marcos@orca.pet>

On Wed, Aug 20, 2025 at 03:34:46AM +0200, Marcos Del Sol Vives wrote:
> +static bool handle_hnop(struct pt_regs *regs)
> +{
> +	struct thread_struct *t = &current->thread;
> +	unsigned char buf[MAX_INSN_SIZE];
> +	unsigned long nr_copied;
> +	struct insn insn;
> +
> +	nr_copied = insn_fetch_from_user(regs, buf);
> +	if (nr_copied <= 0)
> +		return false;
> +
> +	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
> +		return false;
> +
> +	/* Hintable NOPs cover 0F 18 to 0F 1F */
> +	if (insn.opcode.bytes[0] != 0x0F ||
> +		insn.opcode.bytes[1] < 0x18 || insn.opcode.bytes[1] > 0x1F)
> +		return false;

FWIW, you need to check for insn.opcode.nbytes == 2.

> +	if (!t->hnop_warn) {
> +		pr_warn_ratelimited("%s[%d] emulating hintable NOP, ip:%lx\n",
> +		       current->comm, task_pid_nr(current), regs->ip);
> +		t->hnop_warn = 1;
> +	}
> +
> +	regs->ip += insn.length;
> +	return true;
> +}

