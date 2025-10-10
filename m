Return-Path: <linux-kernel+bounces-847638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37651BCB528
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC19C188B2F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA7F21A95D;
	Fri, 10 Oct 2025 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vKsenpAg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C319E97B;
	Fri, 10 Oct 2025 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760058961; cv=none; b=gOq48c7yFWehQmWyNkNnvgmkWmA+cudGNcdPOaUcu+AdaVlSR/adgGzxkZF3P7HQN7xnrIk/qSUP3JyuMk79mkTIVkBi4YKFLcGJ5jA5x8dq2n+5HG+QHD5/tlHWCC9UtBgX2nVEVW4SMW+D1DICSuFI4bjOZ8TITpzqoavwIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760058961; c=relaxed/simple;
	bh=RmFN50/tFdDWu0Lu1oLgK6Ek0UwcaDtGkskQjflrkSU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VOlBiuN/TJomNaYrUgWcQ81HnY5Qb3oVHBApTTyDygpougOYETmMdqMK42XiUgGgA1875DMjbFxp5M88FyNa4wN5GO3QpqswZrDx6INv6OQ4lJBZjRJQ09Gu49Z9B0+p4o9x/shklzlCU+ry3TdZX1MTNwIDoFRej0rf071nBiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vKsenpAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF5FC4CEE7;
	Fri, 10 Oct 2025 01:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760058960;
	bh=RmFN50/tFdDWu0Lu1oLgK6Ek0UwcaDtGkskQjflrkSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vKsenpAgWw4PdXzyPEvRPTtM55CEkmIuOB06QpIL1HFkJaREveyrGwluU/V2fuGGi
	 q5TX7S4AkHAZd7NNOwoSKw4Q9atEptf5m3QREyryBOZ6qV8TyjDyjvN90WleZ6Id1/
	 W86zK2v0N2lj5WYbHcSmtpC+EsAstPuLctnj85O0=
Date: Thu, 9 Oct 2025 18:15:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Conor Dooley
 <conor@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing
 <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 00/18] riscv: Memory type control for platforms with
 physical memory aliases
Message-Id: <20251009181559.7bfa3dce6cb7265822b2d5c5@linux-foundation.org>
In-Reply-To: <20251009015839.3460231-1-samuel.holland@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Oct 2025 18:57:36 -0700 Samuel Holland <samuel.holland@sifive.com> wrote:

> On some RISC-V platforms, including StarFive JH7100 and ESWIN EIC7700,
> DRAM is mapped to multiple physical address ranges, with each alias
> having a different set of statically-determined Physical Memory
> Attributes (PMAs), such as cacheability. Software can alter the PMAs for
> a page by selecting a PFN from the corresponding physical address range.
> On these platforms, this is the only way to allocate noncached memory
> for use with noncoherent DMA.

Well that's weird.

> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -31,7 +31,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
>  			    unsigned long next, struct mm_walk *walk)
>  {
>  	struct ptdump_state *st = walk->private;
> -	pgd_t val = READ_ONCE(*pgd);
> +	pgd_t val = pgdp_get(pgd);
>  
>  #if CONFIG_PGTABLE_LEVELS > 4 && \
>  		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))

OK, but how are we to maintain this?  Will someone be running
grep/coccinelle/whatever on each kernel release?

Please give some thought to finding a way to break the build if someone
uses a plain dereference or a READ_ONCE().  Or add a checkpatch rule. 
Or something.  Let's not rely upon the whole world knowing about this.


