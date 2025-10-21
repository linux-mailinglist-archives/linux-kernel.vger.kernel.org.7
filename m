Return-Path: <linux-kernel+bounces-862005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43926BF43A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36DC18A63A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46BF221D9E;
	Tue, 21 Oct 2025 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aN4tkXaX"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25791219E0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009273; cv=none; b=O5lWhKC/COkR6ZQbdYOTUd5iBeBlRr+7iM3lTOASU836Bw9atXTNcvvCYwzTvzWVHcWA1TllPDAJvQUnnefz1r1AzlCb7enqTbQaEJcZr1ODWUVXzr/h6eUzYNdsKEE0ziBP4rftyOx4jsRhrr9ymkPyU03pMxdL1D/Zmvvwddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009273; c=relaxed/simple;
	bh=ve03aCWXr1QzXG8Xq8fbriqiWKoRGyDKqZT+FrLPAOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD9qx2PVglBRDJsLsOyr1t0xPg+cRcHDtubZnDGry2FFoOfY789VaZQZf3+0RPUTblWwLqm1fsjZQV0TJgI1xdJhZjp6D1c1VcmbTRs/xY753F/xujGRslhQ3/6TkprAwXemRLphEU0P69OVrJBhCUIDlDP8hbImpstACzvh06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aN4tkXaX; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 21 Oct 2025 09:14:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761009269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNqPFAFWjOS8rFTBULhpUJlwsnHqnNO3gS5VK6HeogQ=;
	b=aN4tkXaXqI/EoT3MGjlUvVhfrN1KQDzuJZRYn4OwWcklpziN+f3Qz6bl7ui9E0kghQNgTc
	VjK7/0Erq2hakeKEBU1yDyAFrTniDIf4eQQh0rAVL6gwxEVRyD8bmwIeOiHWE/7hBR5Jt1
	xISKq+nLInnGbTKGBul1shtfi5z/H44=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] irqchip/sifive-plic: use hartid as context_id in OF to
 fix AMP conflicts
Message-ID: <aPbeb1SEZr7CG2eN@kernel.org>
References: <20251020-fix-plic-amp-v1-1-defe2a99ab80@linux.dev>
 <87bjm1zcvc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjm1zcvc.ffs@tglx>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 20, 2025 at 07:44:55PM +0200, Thomas Gleixner wrote:
> On Mon, Oct 20 2025 at 11:49, Troy Mitchell wrote:
> > In asymmetric multi-processing (AMP) scenarios, the original PLIC
> > driver used the context loop index 'i' as context_id for OF (device
> 
> Which original driver and when did it stop to use the context loop index?
> 
> > tree) platforms. This caused multiple contexts from different harts
> > (e.g., core0 and core4) to share the same enable_base, leading to
> > conflicts when initializing the PLIC.
> 
> When did it stop to cause the issues? And if the issues have been
> already resolved, what is this patch about?
The issue still exists in the current driver.
The PLIC driver for OF-based platforms assigns context_id = i inside
the context loop, which assumes that all harts are numbered contiguously
starting from 0.

In AMP systems (e.g., when Linux boots from hart4 while hart0 runs another OS),
this assumption breaks — multiple contexts from different clusters share the same
enable_base(e.g., core4's enable_base = core0's enable_base), causing conflicts.

This patch fixes the problem by assigning context_id based on the actual hartid,
ensuring that each hart context maps to a unique enable region,
while preserving behavior on SMP and UP systems.

Does it make sense? I'll update my commit message in the next version.
> 
> > This patch resolves enable_base conflicts on AMP platforms while
> 
> # git grep 'This patch' Documentation/process/
> 
> > maintaining SMP/UP behavior.
> 
> There is zero explanation what this patch does to resolve the issue.
> 
> See also:
> 
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
Thanks for your link!
> 
> >  
> >  		if (is_of_node(fwnode)) {
> > -			context_id = i;
> > +			context_id = hartid * 2 + i % 2;
> 
> This is incomprehensible and will cause head scratching 6 weeks down the
> road. This needs a proper comment with an explanation what this is
> about and why it is correct under all circumstances.
I will add comments here. Thanks!

                        - Troy
> 
> Thanks,
> 
>         tglx

