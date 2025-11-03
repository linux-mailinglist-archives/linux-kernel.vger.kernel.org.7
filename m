Return-Path: <linux-kernel+bounces-883045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C5C2C635
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7793BA73E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F772F7AAE;
	Mon,  3 Nov 2025 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RRRjrO+q"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8526F2B3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179062; cv=none; b=lWWqWisDzuoEikZybLlzwfAve/vbPZJXSurYWd0Uui23fNy50H3e1vcKYsQBkp9ogyqvs4AcIFGTKdkPpnGZRtwJtWZ8LTerBkCVOYdFD1uOnaeMcJhf0kA4LYC6Zu43UNv/IB4jY1TnE9OIYP/6uwBo1bR/2VUdUsaHl5Ud+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179062; c=relaxed/simple;
	bh=LCg2FJVItVV2AjHuXcIQ70LEq7W7yjPE5Gz1+nGeeXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSV1/tHXQOn0dRiwb3+mHMCr69pJlKzKB3Sd5iMLaU1FaMYwT/DSY6PFl6RwWAwKZ3BtMeJsD/fSaIAjepooOT7uqqlyDJctJPHJaaiwDBzDqePS8EoTng1RDscQMy9ItVm+GgorI5l1AXZXFc1wyJpgorZuRTiNixGqquilIfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RRRjrO+q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qRo4YCRGbvtz8DuyAvDxzk2/wOn+OWsm+lfxk7gT8HI=; b=RRRjrO+qViwEcH2/ArlXcFbfdX
	aQoVspFgW+Zpr2U+bT6iWtsFgX9Df0Xhh0oLyq2TBdAd7qvWuBrY0fp3xo47+YsZqWlYIdp5MTHl2
	2YAfThAlXXSUSi5NQ9Qvv3uKkNVnBr4Az3ST9YD6d7RRTeQ7UOac3CU45JSZG2NHcQKIckgYdBCnl
	F+PNTrX0ryvH875/FIdYrW0nhxzHIB+7QDCOWoRFpOC9teEMye9JJ3b5Q0uh5DSCgDqivNp6CZJi+
	oT/9lsM7uF4vVKSRNQbmrsplv59HZ1Uy0t+ZngIoqjvuwiDwFtAb+nEguDPCtKxC3lby2/rTXHPWY
	KmMvyOcA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuPB-0000000FXxH-1J00;
	Mon, 03 Nov 2025 13:15:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A467930023C; Mon, 03 Nov 2025 15:10:58 +0100 (CET)
Date: Mon, 3 Nov 2025 15:10:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] cpu: Make atomic callbacks run on UP with disabled
 interrupts
Message-ID: <20251103141058.GD3245006@noisy.programming.kicks-ass.net>
References: <20251103120354.HU-oB1_z@linutronix.de>
 <20251103124254.GA3245006@noisy.programming.kicks-ass.net>
 <20251103132820.0llS_QPg@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103132820.0llS_QPg@linutronix.de>

On Mon, Nov 03, 2025 at 02:28:20PM +0100, Sebastian Andrzej Siewior wrote:
> On SMP callbacks in the "starting" range are invoked while the CPU is
> brought up and interrupts are still disabled. Callbacks which are added
> later ar invoked via the hotplug-thread on the target CPU and interrupts
> are explicitly disabled.
> In the UP case callbacks which are added later are invoked "directly"
> without the thread. This is okay since there is just one CPU but with
> enabled interrupts debug code, such as smp_processor_id(), will issue
> warnings.
> 
> Disable interrupts before invoking the calback on UP if the state is
> atomic and interrupts are expected to be disabled.
> The "save" part is required because this is also invoked early in the
> boot process while interrupts are disabled and must not be enabled. The
> warnings aligns the function with cpuhp_thread_fun().
> 
> Fixes: 06ddd17521bf1 ("sched/smp: Always define is_percpu_thread() and scheduler_ipi()")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Did we want me to merge this into sched/urgent or what was the
hope/intention for this patch.


