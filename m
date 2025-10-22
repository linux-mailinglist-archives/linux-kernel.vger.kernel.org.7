Return-Path: <linux-kernel+bounces-864740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93021BFB6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5252D19A1FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE6130FC07;
	Wed, 22 Oct 2025 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rcipaVm/"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186621339A4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129661; cv=none; b=i7lAuHfWZ5rGiGrVuic8XU4rqKcJHXSWjEeYtAvlp+3vfnEMpFJZwOaNpO9peLu3lRBWJy0RvFmE83yxZ7NVjexsncoxX0zq0ysWujaws1B4exfVtehEKhAHaiL+lPrrcLf1P/bZayTNXSurhwGCThE7Syhwug/A/VxKuv2gnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129661; c=relaxed/simple;
	bh=BGZZccd53zYlywdxSswYndHzqUR4I/fMhn5/AO6DF9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqyO2epTm3nkakLptNf22XUD1cbYIp/GmlKAJyDMxA7S2+Wiuf64B3TOLfkOIp64XH4N8GPzk2FxQ0ypYWxK5DbXLUisxtoA4FSzsk1PZoYwuXDxIpK6ssFQkMiY+KGoZC3Wl5ReoZB8FnI1UxQiZ3hRsYgHiAJLef5XGHk8t5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rcipaVm/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p/bbcZcZiikIVI/uzovJhW6sSpcSlEePWaiGO/UwIEM=; b=rcipaVm/wYnFC0CxjGFmPdkFXo
	U8vLk8S2ZVXgFgcHMihmTUrPtWLzSJqwkKg4JUKDfEBfYQydCvbkp2IUs943+BrviBsNaQDVX8Uuv
	Cp6F+JrNsYrfjaGeC8r21q+YRJg2Or5r8F00JnD6P33oUkj1l/NOh60YOq8qfCmKvOvR93879vxAG
	S6RWbex6tlobAntG5iygIi7sw4/zgu2g/H1Mn5tbE965RYHvpC5dt7QUnZyW7aDY0ZPpnxByyIWNp
	IntLtdPuRWRjxWyrvBsriNnPQT3/N+/5jje58N5+DU4Mk5jxgW5VaavMdPV1ggS4yMJGlRs7tBhpv
	R+w3P2vw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBVP9-00000000TC8-3jhR;
	Wed, 22 Oct 2025 09:45:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7570430039F; Wed, 22 Oct 2025 12:40:43 +0200 (CEST)
Date: Wed, 22 Oct 2025 12:40:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
Message-ID: <20251022104043.GY3419281@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-32-david.kaplan@amd.com>
 <20251016110717.GE3289052@noisy.programming.kicks-ass.net>
 <20251016112327.GQ1386988@noisy.programming.kicks-ass.net>
 <DS0PR12MB92738D3C38021EE0B693326994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <20251022094105.7ea30194@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022094105.7ea30194@pumpkin>

On Wed, Oct 22, 2025 at 09:41:05AM +0100, David Laight wrote:

> > > Ah, I found it, you freeze everything, which puts it at safe points.  
> > 
> > Yes.  In fact, I think you were the one who pointed me in that direction :)
> 
> Does that help?
> It'll stop the cpu prefetch queue containing garbage and let you flush the I-cache,
> but I don't see how it can stop the return address after the NOP3 being on the
> stack from an earlier interrupt, or even the nmi entry itself.
> 
> I'm not sure, but if the kernel is pre-emptable could a sleeping thread have
> a stack that includes the address after the NOP3 - eg if an interrupt at
> that point is what caused the reschedule.

The thing is that freezing is only done at known safe points;
specifically schedule() calls that have TASK_FREEZABLE set.

Typically this is the return to userspace point and for kernel threads
somewhere in their main event loop.

This ensures tasks are not preempted at random points like in the middle
of an alternative.

