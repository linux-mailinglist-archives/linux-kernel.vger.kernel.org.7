Return-Path: <linux-kernel+bounces-830380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52EB99837
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE383AD9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA5A2E2DDE;
	Wed, 24 Sep 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UbNDbUyD"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB472E03E0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711504; cv=none; b=Aj33SIohIwDxY+/vTPItC8C+8x5tsYrDOFEQyFNMaAHGyoqNMNfTKQYiBDuRUc+kNQNU8Y1jJ8hNSQxpja0EiI6gpP5CRAr2vDT8VcCOMYn0srk1h0bYsTdAl3RpQaVZgWJeZ+J3sZ2UNv28EgW8TQXRrdPtD2bpVzGyBfqDdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711504; c=relaxed/simple;
	bh=QTQKsd0rJAu25JtP9BEINMY8HjthBF38FlsVhtWlBbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF+hat9/dGwcy+viXGDty3+kyQaBPPV0/vXONbSBxAzYKlzfrRKdH314R/ZUdgc3oiws6pYQk9qZxtRXdT+v1kMUc+x/KEOynwV35gEovJWDJg/eEbyh/eEkLC82ClLBFJy7m0tqH6E0FQJ+U2I6IeRlBbRVIPVtdck2odOIrjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UbNDbUyD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CopVAZ9NyzvWTDM1Dz1jnOFXdwEQjE6yBnOwr+IVlsY=; b=UbNDbUyDwTcjlHmbRiGQkf5ZCz
	z8LEADUDCyX0ppDnCG8IJvr6gXmxmFjwMITOXgS7tBK1xM7r5RbOWuO9WMJZgQPmOJaFWYJrbtTYs
	yB5Pwy0bz6OvR2DIVeZIjDDMNC731LVFqW3/J1Ldx61K3aeCVO2ANcEU/Fp/hZqDBzpmp9pc6Vu9X
	JFSv/CCiyqdOU9qBquYcVNN1yiB49iPJx0giZjc0XpyFcVFEa3C3ciG5pU333vTT2FiXSX7SvGaL8
	7nNClTbZcLmDH9iGuKe8J3Z3W1mDEA3z8m5AxxsvgPHleoENDEfKAzxjfP3FEFQmzOiEJylsXPSb4
	ZzPmsD9w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1NCR-00000008ixW-0C9p;
	Wed, 24 Sep 2025 10:58:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C65F930033D; Wed, 24 Sep 2025 12:58:13 +0200 (CEST)
Date: Wed, 24 Sep 2025 12:58:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
Message-ID: <20250924105813.GI3419281@noisy.programming.kicks-ass.net>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
 <20250924074206.GW4068168@noisy.programming.kicks-ass.net>
 <20250924100847.GY4068168@noisy.programming.kicks-ass.net>
 <20250924101038.GZ4068168@noisy.programming.kicks-ass.net>
 <90abf24a-326a-4215-8e13-2e1a2e3194ea@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90abf24a-326a-4215-8e13-2e1a2e3194ea@oracle.com>

On Wed, Sep 24, 2025 at 12:52:35PM +0200, Alexandre Chartre wrote:
> 
> On 9/24/25 12:10, Peter Zijlstra wrote:
> > On Wed, Sep 24, 2025 at 12:08:47PM +0200, Peter Zijlstra wrote:
> > > On Wed, Sep 24, 2025 at 09:42:06AM +0200, Peter Zijlstra wrote:
> > > 
> > > > > >    d051:  perf_get_x86_pmu_capability+0x51    | xchg   %ax,%ax
> > > 
> > > That libopcode is 'funny', isn't that typically spelled "nop" ?
> > 
> > Ooh, I see, it is "osp nop" and yeah binutils also seems to do that as
> > "xchg %ax,%ax".
> 
> Yes, "xchg %ax,%ax" is NOP2 (opcodes: 0x66 0x90), "nop" is NOP1 (0x90).
> 
> That's one more improvement we can do: identify NOP instructions and
> display them as NOP<n>

Right, I have just the function for that. Let me do a patch for you.

