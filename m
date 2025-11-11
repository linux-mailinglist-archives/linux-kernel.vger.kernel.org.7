Return-Path: <linux-kernel+bounces-896112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58277C4FAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AB7E4E2272
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF463A9BE0;
	Tue, 11 Nov 2025 20:14:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F622A80D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892044; cv=none; b=j6gs4fsRaUHstxNAk2KasGB+J4tHpyotSYCP0lXt4nJegjAN4QWhfBsSV2jZsSlBSUOTwRGL8XbJrQ5FH1DVAzJP+0NbsXHx7evbrovpK1cSxXdukkxPKetsx5D8yr9KFXc2NKMRBLb0kcHMdIfvcigZgD9VqAQL9m8q7np7YiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892044; c=relaxed/simple;
	bh=0yUTJ8X0/sx2fs9GwkYIht3MiIdLIMA82zUm1wpXss0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFdTkuxRNsZrk9VzchK//Fl4nJiu/GFNMQmJnrsqOvPm+eKZb4OrwpowuTakaAZ9CocM3yHwl2NQz6/X9X+beFhFb8kMn/gf2wcH52/O42HfcVCIgQsQpMFvvFK+jj+8c59ik3Exx8jWEqDYOBqj4mKE19kICss8fZzHCz7j+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7308EC113D0;
	Tue, 11 Nov 2025 20:14:02 +0000 (UTC)
Date: Tue, 11 Nov 2025 20:13:59 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH] arch/arm64/mm/fault: Implement exceptions tracepoints
Message-ID: <aROZB_ri49OexJqX@arm.com>
References: <20251013035532.1793181-1-balbirs@nvidia.com>
 <aQjlzbkdzzYL2xJR@arm.com>
 <8f0722c5-203f-4f2b-8654-e77811aee7d3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f0722c5-203f-4f2b-8654-e77811aee7d3@nvidia.com>

On Wed, Nov 05, 2025 at 11:27:18AM +1100, Balbir Singh wrote:
> On 11/4/25 04:26, Catalin Marinas wrote:
> > On Mon, Oct 13, 2025 at 02:55:32PM +1100, Balbir Singh wrote:
> >> x86 and riscv provide trace points for page-faults (user and kernel
> >> tracepoints). Some scripts [1],[2] rely on these trace points. The
> >> tracepoint is useful for tracking faults and their reasons.
> >>
> >> Adding the tracepoints is simple and straight-forward. For arm64
> >> use esr as error code and untagged memory address as addr.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Paul Walmsley <pjw@kernel.org>
> >> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >> Cc: Albert Ou <aou@eecs.berkeley.edu>
> >> Cc: Alexandre Ghiti <alex@ghiti.fr>
> >>
> >> [1] https://www.brendangregg.com/FlameGraphs/memoryflamegraphs.html
> >> [2] https://taras.glek.net/posts/ebpf-mmap-page-fault-tracing/
> >> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> >> ---
> >>
> >> Tested at my end with a kernel-compile and running a user space
> >> program to check that the trace points are indeed reported.
> >>
> >>  arch/arm64/mm/fault.c | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> >> index d816ff44faff..9d7b86e92434 100644
> >> --- a/arch/arm64/mm/fault.c
> >> +++ b/arch/arm64/mm/fault.c
> >> @@ -44,6 +44,9 @@
> >>  #include <asm/tlbflush.h>
> >>  #include <asm/traps.h>
> >>  
> >> +#define CREATE_TRACE_POINTS
> >> +#include <trace/events/exceptions.h>
> >> +
> >>  struct fault_info {
> >>  	int	(*fn)(unsigned long far, unsigned long esr,
> >>  		      struct pt_regs *regs);
> >> @@ -572,8 +575,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
> >>  	if (faulthandler_disabled() || !mm)
> >>  		goto no_context;
> >>  
> >> -	if (user_mode(regs))
> >> +	if (user_mode(regs)) {
> >>  		mm_flags |= FAULT_FLAG_USER;
> >> +		trace_page_fault_user(addr, regs, esr);
> >> +	} else {
> >> +		trace_page_fault_kernel(addr, regs, esr);
> >> +	}
> > 
> > This has come up before and rejected:
> > 
> > https://lore.kernel.org/all/aG0aIKzxApp9j7X0@willie-the-truck/
> 
> Thanks for the pointer, since it's been five to six months since the
> discussion, I don't see the kprobe handler being merged with the trace
> point.

I was hinting that whoever needs these tracepoints can do the work ;).

> The real issue is that while we fix the issue some scripts are broken
> by default on arm64, see [1] and [2] above and a simple search for
> exceptions:page_fault will show up many more. It's just hard to be
> have all of those break and fix them as and when needed.

Does Steve's proposal in the earlier discussion help with fixing these
scripts:

https://lore.kernel.org/all/20250519120837.794f6738@batman.local.home/

-- 
Catalin

