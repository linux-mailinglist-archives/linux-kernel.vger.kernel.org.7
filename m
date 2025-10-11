Return-Path: <linux-kernel+bounces-848943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B849BCEDD1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 365F04ED567
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872DC7D098;
	Sat, 11 Oct 2025 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c46TLfub"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B0249EB;
	Sat, 11 Oct 2025 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760145817; cv=none; b=WjzI0WrfqSPpXRNZWf49hbnImf8raabNly93WHL3FR7WbRHJLnvGEkdqsaTDm1jl3mKlWrkP/SCsHoik64aLFBmiYNFH/u8gE6xLqYUSW44v+AH0JfXlSrrK1FLbVO4Lr0Dvgd3gkXtssvVna09fytOR5oqwOenvavbdA9yjvm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760145817; c=relaxed/simple;
	bh=SaB2KwtYsz5/VxFOp/1zSNT33ET7IgxIMwHzvwzICPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHQeifGFx6WkhsYH3mOQg6QMVZl2ySub1PLG82lO8GCxFpu+rWheo3U8Nxk6hoLlaGY3H7dVsK7bE2fHX6LlK2tInZOqMzTYvzQE8Tu4HmbOHYb8wXW8Qs/0zrGCWtAnIRxydj6AxD/9Jfk6q2i1KCfgK8zihPd5DYclKMEagBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c46TLfub; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760145804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSswTIFgeO4NEeKwFaNeakFPEwy/ELifTZQ+vFenIbE=;
	b=c46TLfubxOT4KZfepoGnVERnO9g5cSpziLUML+S0vK+h+QrSOO8CgyIwZcbedFNLwWruW7
	RlTVvr9RDbWJZy+cw8tRMwi4umyz2Fd3T4EjzuvaFLp5kgazbXG63NbDY+If/PDF6WJUJJ
	nPQDwv533Ub6ehk/OrmzkZqCKn73+zU=
From: Menglong Dong <menglong.dong@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Leon Hwang <hffilwlqm@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Subject:
 Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault to BPF
 stderr
Date: Sat, 11 Oct 2025 09:23:15 +0800
Message-ID: <6200838.lOV4Wx5bFT@7950hx>
In-Reply-To: <f9be7eda8fb72ad6a7a730023244409ee065ea60.camel@gmail.com>
References:
 <20250927061210.194502-1-menglong.dong@linux.dev> <3349652.5fSG56mABF@7950hx>
 <f9be7eda8fb72ad6a7a730023244409ee065ea60.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/11 02:55, Eduard Zingerman wrote:
> On Fri, 2025-10-10 at 20:05 +0800, Menglong Dong wrote:
> 
> [...]
> 
> > save errno to r0(Eduard)
> > -----------------------------------
> > Save the errno to r0 in the exception handler of BPF_PROBE_MEM,
> > and read r0 with a __kfun in BPF program. (Not sure if I understand
> > it correctly).
> > 
> > This sounds effective, but won't this break the usage of r0? I mean,
> > the r0 can be used by the BPF program somewhere.
> 
> What I meant is that for cases when someone wants to check for memory
> access error, there is already bpf_probe_read_kernel(). It's return
> value in r0 and is defined for both success and failure cases.
> 
> The problem with it, is that it has a function call overhead.
> But we can workaround that for 1,2,4,8 byte accesses, by replacing
> helper call by some `BPF_LDX | BPF_PROBE_MEM1 | <size>`,
> where BPF_PROBE_MEM1 is different from BPF_PROBE_MEM and tells
> jit that exception handler for this memory access needs to set
> r0 to -EFAULT if it is executed.
> 
> The inconvenient part here is that one can't do chaining,
> like a->b->c, using bpf_probe_read_kernel().
> One needs to insert bpf_probe_read_kernel() call at each step of a
> chain, which is a bit of a pain.  Maybe it can be alleviated using
> some vararg macro.

Thanks for the explication, and I see now.

Interesting idea, and I think this is something that we can do
despite this problem, which can optimize the performance of
bpf_probe_read_kernel().

Thanks!
Menglong Dong

> 
> [...]
> 
> 





