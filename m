Return-Path: <linux-kernel+bounces-898705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D2CC55CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7A624E29B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527CB265CBE;
	Thu, 13 Nov 2025 05:27:26 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CC31C6FEC;
	Thu, 13 Nov 2025 05:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763011645; cv=none; b=TjVQe6LH13vFA9tDyLhAFKBZcuJPl8L2vcIiX3Wzlq1qOvpWBKqAK2Mjr7iPYiQmjrBNxRniz7EBck5ojkltXWkaen66YIbFEcuXfjCdfZ5T5Q5KeB064rMMWxp9P0DnDyBwKBLq1078ikDxgD5KrVJ/8+9Vk4c142Ey9wiEfVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763011645; c=relaxed/simple;
	bh=rl3bxSHr3vD7QcIKxTyHs9+a7pybTH6HoyaLbyxLYRQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ohSJ7jOCg71jKkocsFqkqN7qFfyyFPKU5gjUje8FkwD4jIF/3dxmCOC+gD8UsG8jzgIYpnDD7ITt1U3ad/1o1Xmyw/xuIfv5NBCUL7bgmwiZsGnN8eN0YUjKYdyVMHwketCZSM1K97CL4hf+v+l1Ei5/jEvNTckMBqUBwe5ud/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 294F192009C; Thu, 13 Nov 2025 06:27:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2563792009B;
	Thu, 13 Nov 2025 05:27:22 +0000 (GMT)
Date: Thu, 13 Nov 2025 05:27:22 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Nick Bowler <nbowler@draconx.ca>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: mm: Prevent a TLB shutdown on initial
 uniquification
In-Reply-To: <tsok52tdbt3z5j3i6ht22iko3mdqeom2ojcvvb52pwfbjnzzyy@mcwnzfpvksee>
Message-ID: <alpine.DEB.2.21.2511130521330.25436@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2511122032400.25436@angie.orcam.me.uk> <tsok52tdbt3z5j3i6ht22iko3mdqeom2ojcvvb52pwfbjnzzyy@mcwnzfpvksee>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Nov 2025, Nick Bowler wrote:

> > This fixes (at least) R4x00 cores if TLBP hits multiple matching TLB 
> > entries (SGI IP22 PROM for examples sets up all TLBs to the same virtual 
> > address).
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> > Fixes: 35ad7e181541 ("MIPS: mm: tlb-r4k: Uniquify TLB entries on init")
> 
> I tried this one too and it also appears to work fine on my R4400SC
> Indy.  The system is booting normally again.

 Thank you for testing.

 I chose to respin the patch once again after all as I concluded it makes 
no sense to pretend we can handle wired TLB entries with the code as 
offered and neither we need to take care of them in the first place.

 Would you mind having a Tested-by: record in the kernel if you choose to 
give v3 a spin too?

  Maciej

