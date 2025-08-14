Return-Path: <linux-kernel+bounces-768684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A30CB26427
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4B59E6ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C2E2EAB6E;
	Thu, 14 Aug 2025 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cv2nmiHN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0D2C3254
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170617; cv=none; b=BbjgMVogfpu71PMaiv38mcYrI/Ji8E5aF4RcR81m6Lz2Empay7zAVck/7lOrzvwKd6n9BQfTOQHoQkDeysstcMIl0XIMlagttLdxGuPDzOP9ItteN3mvT2AV/dRzp46QYnYz3rifOEwKP6CY0E2uY+8wv/qCE4S6+nqOVn5dx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170617; c=relaxed/simple;
	bh=HhEhJKRgB5ddmEmTuM79qCI5EO0LMX7gbVAgUkM1HKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNUP8xXw4b/guJwIlV7Tb2O2LyDR3cyUie9QEnge1GqxGTDTlJafHgi3ep9ohumP6xxAD9V2qpIA0GBfknD5dszV4v5DX7DIrDF25fd0L5sCWKzDu11jRCU1E5xw+reIs1u1WUt9ESPdE+riZAmEmt9D9rFXSNbsjbLQ4oWqPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cv2nmiHN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FOIBf4BvqOwTh7/DswQxWmanob5JJzJTMvHkH4v9WWM=; b=Cv2nmiHN4RELTEdfyzJV1ptcwP
	86bkkeXcOAidEhfuMDgpvfnM5hehOuzsqvnhPxqMxOizu1FFcboeOO2AoHfbBue9Ktq7TGeH2yRmR
	DCN6cskNNOOQIOmx9acUPTt3DVsUVVSUy8L1JzElvRqCYYLnwuW9/B1qBN0FUO8LCf3TGTamGI8mc
	TVjRhpD+xNArpLgfYDc0AURFVqfgMuSZrLIF51e9KWoUMHOmfh3g3E/k7VagBFXmxkqoHuGo+ySSO
	dtReoNKaj4nstj14UJd1AVLzOprXnYAhyVjM3Nw4Zl3hQdG2vYpZs8lEI6a0OwbtDu0fz2F3LY9pk
	Bjtc3AbQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umW3O-0000000GN0h-0cxA;
	Thu, 14 Aug 2025 11:23:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EE4603002C5; Thu, 14 Aug 2025 13:23:28 +0200 (CEST)
Date: Thu, 14 Aug 2025 13:23:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: kees@kernel.org, alyssa.milburn@intel.com, scott.d.constable@intel.com,
	joao@overdrivepizza.com, andrew.cooper3@citrix.com,
	samitolvanen@google.com, nathan@kernel.org,
	alexei.starovoitov@gmail.com, mhiramat@kernel.org, ojeda@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250814112328.GC4068168@noisy.programming.kicks-ass.net>
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>

On Thu, Aug 14, 2025 at 01:17:33PM +0200, Peter Zijlstra wrote:
> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> index 99444409c026..59f8bf022ec5 100644
> --- a/arch/x86/kernel/cet.c
> +++ b/arch/x86/kernel/cet.c
> @@ -123,7 +123,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
>  		return;
>  	}
>  
> -	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
> +	early_printk("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
>  	if (!ibt_fatal) {
>  		printk(KERN_DEFAULT CUT_HERE);
>  		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);

Obviously this is debugging remnant and will go away.

