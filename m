Return-Path: <linux-kernel+bounces-822833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE07B84C35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021151C06914
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA327F171;
	Thu, 18 Sep 2025 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jMukja3X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="keCR8TzQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB353090E0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201365; cv=none; b=UUSDygSO+GhdhZWFuf6Xqu2qqLuT7mXQ81PdMGUOwDZTu3InEKJ52uWl9QgRcZPbwuD+TfHTjHqw0uC941P7BdzuQ/LfNuW/G1M0TtWVrqtFe0XShcaZxGmwJYWEC5R0DxlawKCFPiJfxSDoUJmyMtARIZiXwZy3BvOIb/l+Nmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201365; c=relaxed/simple;
	bh=o31y49SfOz1zzDeXlwC3LGsLmhzXDfMciiKmJfbYODI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7jDPD7HlZfWb/jfj7uHtACYM5pSG4LS25O4PnR77dVF+o4xtY8IuzvLm30fVPmZTpOa91/dyE9MLVwgFZZAJwV7P96jt4we3n2YBakEd4JRrDOmRTzS0r3U39lao5H+q7qBDQA+WfSJCKrLVpuYEPU+lraFKuUMkwo00D8v+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jMukja3X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=keCR8TzQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Sep 2025 15:15:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758201361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25kJklno+agO++8IqSq2aLV4AxGk+lui9rOAwcO0s+Y=;
	b=jMukja3XOJ3dATz9P6EGzMCQW/u6WOV8vIV+LGIrfQYxGTrkhCjzIKfauhHfjt5/5sm9Dm
	RIBUHsCoTGYR1Z2ZbCFsiZaAAKMHNPDwOmJtakSZpkTvW4lb1ATMOGUa2hUWDakZ2f82ev
	70oPyZUe9KCLv9kEarEXfqD6G0xS9CeIPTWoa/fXJW5buNm/oew5AeS/wC3qnxdhAzNQy0
	oaGI9hm2O0QOXPZnPwOIhy7BkVrKeKhCdXTNUP+QkYqgM6ueeWntFH1EtwjEIYI+MyI0FB
	XBBE8AUbzDpfAf1o8JC2QtHN7yEyWDsOMz//n46ew0VADrII7FHKK89zxR92RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758201361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25kJklno+agO++8IqSq2aLV4AxGk+lui9rOAwcO0s+Y=;
	b=keCR8TzQs4Io7DMmXcCvlVQP04DhsSY+KOy3F8fF9vwMVsbj/Zf1CUsmbKV8nVjBkIbe46
	nPXduyGjYpBr2dBQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/35] x86/cpuid: Introduce a centralized CPUID parser
Message-ID: <aMwGDk4nLq_RZ134@lx-t490>
References: <20250905121515.192792-1-darwi@linutronix.de>
 <20250905121515.192792-9-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905121515.192792-9-darwi@linutronix.de>

On Fri, 05 Sep 2025, Ahmed S. Darwish wrote:
>
>  /**
> - * cpuid_leaf_regs() - Access parsed CPUID data in raw format
> + * cpuid_leaf_raw() - Access parsed CPUID data in raw format
...
> -#define cpuid_leaf_regs(_cpuinfo, _leaf)					\
> +#define cpuid_leaf_raw(_cpuinfo, _leaf)					\
>  	((const struct cpuid_regs *)(cpuid_leaf(_cpuinfo, _leaf)))
...
>  /**
> - * cpuid_subleaf_n_regs() - Access parsed CPUID data for leaf with dynamic subleaf range
> + * cpuid_subleaf_n_raw() - Access parsed CPUID data for leaf with dynamic subleaf range
...
> -#define cpuid_subleaf_n_regs(_cpuinfo, _leaf, _subleaf)				\
> +#define cpuid_subleaf_n_raw(_cpuinfo, _leaf, _subleaf)				\
>  	((const struct cpuid_regs *)cpuid_subleaf_n(_cpuinfo, _leaf, _subleaf))
>

That snippet should've been folded into the previous patch.

Rest of the PQ stays as-is.

I'll not spam the list with a v6 just for this, since the next iteration
should include the X86_FEATURE adaptation mentioned in the cover.

Thanks,
Ahmed

