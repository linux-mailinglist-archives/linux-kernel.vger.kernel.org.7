Return-Path: <linux-kernel+bounces-882954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBAEC2C016
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6951884223
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D030E0D0;
	Mon,  3 Nov 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+eUb7u6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="osnc5Bnf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8E30CDBA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175456; cv=none; b=U7IoNzXJpGU+9GXNotX0I/yfVwWIItKm2fJjMf0mu9LJAG+6zNJMZKp9GCnkfE/Bhtrxaa9R2zCFI5RNHOWY/zQUDczxnm1qgGKlYqy1NOi0hN0Vx7Gh1qnrNxdyVrMNBH80wlU69FZ20aLXc/1kZ4n4KE9N2Ks6eaGfHO552Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175456; c=relaxed/simple;
	bh=bv4gAPr0TXjwGKaPIWzMrPjwB2rvz2sYPRKE56eH6gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVlQOnFUgXucqZ2a3ZUzRSYzuGvh8DUbC1wkvAwsdc4DUi+2GSmB7+BvIIPjrOjpDDUs5+ZJPv2IOSTlEaXjw38JtxlslfncqCvIc+pLh+Jt24zRZFtxnwEelqPW8r+riL6ST9Tc5CRkhnsQt0cSIOtbkhOTa+esxnKwlgxAxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+eUb7u6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=osnc5Bnf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Nov 2025 14:10:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762175453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=keJYij85FmpHS+dRr9WXgII7FSzLb0l6XUmYsofOW24=;
	b=f+eUb7u6xCAbPncm6jAx5i5Ffdju84oPHLYk3f9T5yOWEev6XiNCBPAtoPxGcOsYiwep+u
	v64W9dV1Nu+JKWFmKQltaJxz+W1oGhz9BArY+qcdf0Snk/mlk2iFz/X6L4Pa3YKPgKFM+H
	nPgEPC+SDcOewqPwnbe5kI/S8qmo0s/HZm37lRc3BBdd8o4KnJZ4p7NV3YVdMglX2oGawj
	hG1OZBn+C1vt++U9wUIzuzDU/rfp/LTF3TsG5gGla5J26449hUq8/kS1CxHacM00XWvi0s
	GBiEWzwQxFZeDB1vZZcur7AkxglNXcwSo2RJU656So8tRAQhZxZC9AyIkvh/MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762175453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=keJYij85FmpHS+dRr9WXgII7FSzLb0l6XUmYsofOW24=;
	b=osnc5BnfoxAA++sjI+RLLKtbK1z2eBhU7Ta4Ee83h2CV+JNU7tLyUeSrJmAVDL/FUurZ2t
	RoI2zCpIIuC4nxAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] cpu: Make atomic callbacks run on UP with disabled
 interrupts
Message-ID: <20251103131051._qx__Noh@linutronix.de>
References: <20251103120354.HU-oB1_z@linutronix.de>
 <20251103124254.GA3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103124254.GA3245006@noisy.programming.kicks-ass.net>

On 2025-11-03 13:42:54 [+0100], Peter Zijlstra wrote:
> How about:
> 
> 	if (cpuhp_is_atomic_state(state)) {
> 		guard(irqsave)();
> 		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
> 		/*
> 		 * STARTING/DYING must not fail!
> 		 */
> 		WARN_ON_ONCE(ret);
> 	} else {
> 		ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
> 	}
> 
> which is a little more like cpuhp_thread_fun()

very nice indeed. What about WARN_ON_ONCE(ret && bringup) given the
BUG_ON(ret && !bringup) below?

> 

Sebastian

