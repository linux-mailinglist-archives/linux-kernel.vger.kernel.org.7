Return-Path: <linux-kernel+bounces-883042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BEEC2C5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AEA3A3F63
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2156E2D8DB8;
	Mon,  3 Nov 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VKdVfcIB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E25311588
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179017; cv=none; b=j6Anq0A3fffAd9DDDrioeb3vFXPhaFC6Xsj5cjND1bOSRsONryL5f8IvSeSMvRANzls5XEK/s7Tb6PUJITK+5k8P3vxr1ouE4lIS271zYy41ZBIW3GlRvNt6lm2y4zLO1psHFajadGL58mVmLdGtlmGGv91D6//5Ds84JBEWPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179017; c=relaxed/simple;
	bh=R7Or7plg8Rs4aKB31Gqc2IHoxMRTOyZMl3Jw87ZceEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p90DmtVv72dD4XzYAxVlfV55Ehu9kFS0WTC3ziTnI9G/JJX7CszpnxySyjb3My6qX4vX7mb0y4RgLpRZNX/aQofQjLmXV94SVJwVHvCnJSrW7ddcJnx+ucsC62OoQQqufRDtm//HyVEExSvE75NefHZZF/pmhJLpj4B/s/q+CvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VKdVfcIB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UVqaSM9HKo8NqcDWO4dG0ClcXPN/yo36Q894RscQeWM=; b=VKdVfcIBpt7wkP1r3AMnCPF2Qu
	CilL/t9rturuTgyrhNXmkL2oH3DV6SA1iMhamBfIxTjDMI+cbivOVDXSW8iy3WF8kS3hpHgh29kZI
	1PC5vkbp3er6+8WW4kE/rjJhGRtmn4qkulokEDFw2pGNpyBUSOthaY1o6JCY9h59uyB5n+Eo8VHid
	Zx7Q7KL45HqDzz/6f3BGnMrSWduHfI43IT3kzOSCGPNpu8M7iowcOtQui78jySYLmgGYVILutzO03
	lDacxISeSZn5oz1LyPxbKCPgZLAmJTFMVe4aNy+bDnIZJlmqnwQwRgTt4lFPyBzduipI3NCINDTuz
	DgdApvOA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuOR-0000000FXr2-15fe;
	Mon, 03 Nov 2025 13:14:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B7FD9300265; Mon, 03 Nov 2025 15:10:11 +0100 (CET)
Date: Mon, 3 Nov 2025 15:10:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] cpu: Make atomic callbacks run on UP with disabled
 interrupts
Message-ID: <20251103141011.GC3245006@noisy.programming.kicks-ass.net>
References: <20251103120354.HU-oB1_z@linutronix.de>
 <20251103124254.GA3245006@noisy.programming.kicks-ass.net>
 <20251103131051._qx__Noh@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103131051._qx__Noh@linutronix.de>

On Mon, Nov 03, 2025 at 02:10:51PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-03 13:42:54 [+0100], Peter Zijlstra wrote:
> > How about:
> > 
> > 	if (cpuhp_is_atomic_state(state)) {
> > 		guard(irqsave)();
> > 		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
> > 		/*
> > 		 * STARTING/DYING must not fail!
> > 		 */
> > 		WARN_ON_ONCE(ret);
> > 	} else {
> > 		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
> > 	}
> > 
> > which is a little more like cpuhp_thread_fun()
> 
> very nice indeed. What about WARN_ON_ONCE(ret && bringup) given the
> BUG_ON(ret && !bringup) below?

That would be confusing to read, the condition here is any failure. And
yes, this way you'll get a WARN and then a BUG, but meh :-)

