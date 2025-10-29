Return-Path: <linux-kernel+bounces-874987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAACC17F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 239323522C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73226279DB6;
	Wed, 29 Oct 2025 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3zEMTLc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58C23EA80
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702623; cv=none; b=opOEUKFGAp4KthEBHVocwW3bZc/mNGbzYXXZjN4iXFKsFS+GC/KM4Z/DMAYDs4geJDhvpwnz5sQ+g87FMYfipb2eqPmvl6P/o7OMFRI2kSO9XFvWwbKrRbrJErOn0F8k655St/7kFF7+FgPQpH5w8paohGHakkN66InRMIUwgpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702623; c=relaxed/simple;
	bh=Gc6TRF3YI5Z9kV69Bszu6Ljoaa/1ceinuOGcIMvHDfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG4NEVCKy/1c/sFEAKPY1xW7Matuka0i2aR2dfwPWyVv+x1QFN0/wf5TpxOj83edId1/BNk3PkFwj4IaWMY15vPqm/wsPr11DnBHZXOqD8UZtIZh3Si23xD6OBfJNn68W3WHVmBk45DTwIJJ8wLlmZpRrXxcpK3geGkhBRSFNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3zEMTLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB000C4CEE7;
	Wed, 29 Oct 2025 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761702623;
	bh=Gc6TRF3YI5Z9kV69Bszu6Ljoaa/1ceinuOGcIMvHDfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3zEMTLcHqLxHzj8Zsugr60+coVne9GMpHWor4CC17dPUHDczEevNo/yZVw4ZgGNs
	 U8UZ/qxYrM7UCEKL8JIjZ1IW8Fd5ubsmmcclSdzB9R6DkXZ6rmAz1okaQ7dPgoXl4n
	 sjySRr9E+iHfO5gLmyfpP4xL5cUcaO0A8vqShcu4JcyAVUjYQ+4GAc1HJnQnNFpzap
	 i59ZC2sjsowTlfi24xM2NQeEnzyYJp77ErppCWUixZ9cBforiLZnTyb7Q1ik9jnbUf
	 9PRnPA80OWICMxbyDrTSaqv7Q0pRoawzWstlB+wUrnmC+nOeykHyy9qLQtpMC3qWtA
	 LBDEYSkMgSASQ==
Date: Tue, 28 Oct 2025 18:50:21 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: odd objtool 'unreachable instruction' warning
Message-ID: <es4awalt6i63cy5kkrbz7f22cxpt4zbmq6zsbol3yafek2375e@6b6stnc6k6h2>
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
 <ubqjeplvslhnspqw6pnqwo7c6sq2ygdtmkuqr4q3hjlxfkuwii@xn63k6qz22mz>
 <CAHk-=wgs8+xVbv5tu9kv5n=LwWFZ0FW4GPwVmXBPjLQ0goLfjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgs8+xVbv5tu9kv5n=LwWFZ0FW4GPwVmXBPjLQ0goLfjQ@mail.gmail.com>

On Tue, Oct 28, 2025 at 05:59:01PM -0700, Linus Torvalds wrote:
> On Tue, 28 Oct 2025 at 17:21, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > See the diff below, hopefully that fixes things for you?
> 
> Bingo, that patch works for me.

Thanks, let me run that through some testing and then I'll post a proper
patch.

> > On a related note, it would be nice if we could make that codegen more
> > readable...  Here were a few formats I had played with before, any
> > thoughts?
> 
> I don't think any of this is ever going to be remotely readable,
> because of the whole horrible section noise.
> 
> If I recall correctly, one of the ideas you had was to use macros to
> make things more legible, but that sadly didn't work with clang or
> something like that?

Right.  Those macros were actually pretty nice.  They worked great with
GCC but Clang wouldn't cooperate.  Maybe I can talk to some Clang people
to try to get that working.

> > Note there's also an objtool "disas" feature Alexandre is working on
> > which will show the disassembly annotated with runtime patching info
> > (alternatives, static branches, etc):
> 
> Yeah, that would be a good feature to have, although I wouldn't
> obviate the asm cleanup for me.
> 
> Depending on what I am looking for, I end up looking at either the asm
> output and the objdump output (or at both) because they each have
> their good and bad parts.
> 
> Sometimes I *want* the comments that gcc in particular adds to the
> assembler, and sometimes I prefer the "raw objdump" format.
> 
> Oh, and Alexandre: if you are working on improving objdump - are you
> perhaps also looking at making the relocation output saner?

Just to clarify, Alexandre is working on objTOOL, not objDUMP :-)

> Because I absolutely detest the odd relocation output format. I use it
> occasionally, but it's just crazy to see things like
> 
> <delayed_put_task_struct>:
>         ...
>         call   <delayed_put_task_struct+0x1a>
>                         R_X86_64_PLT32  rethook_flush_task-0x4
> 
> when any *sane* tool would just output the simple
> 
>         call   rethook_flush_task
> 
> instead.  Because as it is, the line without the relocation info is
> useless, and then the separate relocation line (with -r) is just
> crazy.

FWIW, this can be slightly improved by adding '-w' (objdump -drw) which
at least puts the function name on the same line:

     call   34d <delayed_put_task_struct+0x1d>       349: R_X86_64_PLT32     rethook_flush_task-0x4

The good news is that we will have the ability to print things however
we want with "objtool disas".

-- 
Josh

