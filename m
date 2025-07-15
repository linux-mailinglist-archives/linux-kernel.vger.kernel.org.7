Return-Path: <linux-kernel+bounces-732273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CBBB06462
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E53A605E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35E1D5CEA;
	Tue, 15 Jul 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gi/NADAW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="plrfCHYY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFADC13AA2D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597101; cv=none; b=SN8TPHqewWECyEZTYLlJEIbo9eNvESLYYpuIUp8B9w9Mm8xaHQulUhdfW1iA6q55MYn8Rhrmr6rJmmjl4SJV/bEhBrnEpn0eUqEKuzslnPcRTRuqKv2Y9gRbJUWUvZz66P1L3ZEkv412hxC1hIlkn70CdIfLp6JYmscihc8/Z64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597101; c=relaxed/simple;
	bh=pWY2s8xoBA9GzuHDRbl2rBEJzmzXbVL1ZioSH4Gi4JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRFOb2FMmDttu9sG+17vHyVOhwtYl548o3Vqaf1uHswh2huW7TEq7FzOCDbjOd1tWIDzN9Wf6yl3AP6z0LIRkI7+hUIBZzO0JRC0GP3CY5EVDShapNBLAKjp4oXmpuGZOj3R/v1Z4oLws1VhUCmL8lKjvdnYMZ0se6LiSFOvZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gi/NADAW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=plrfCHYY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Jul 2025 18:31:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752597096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZRHfDmIEn/5QmfrWGRI7AsoURbTlppiIfa0I/ZcNcU=;
	b=Gi/NADAWSZRVma9PjpMs3K8z3LzjH7g7tml709NaamBGRL1t/TuVSldeIOctMb/Q41Ldps
	5floW6m4G/+6f6+KykMVyYhvq4vrx9VZALp3dz3+npgmkfZ7sRaGt0PCAJBvYVhpWrpbum
	riUFiibTN6sqanMYcc0IoxzaBFmWFy0oV9DqXYt4x6n6afrahkJsEAVP179FV7maifG7As
	SA1tV0VC0siJF4ez/6ddP9Q/4gn9cv0Hz1pvkmsghJfC8CumN/LtiEJEfTHc/5t8iF+fxf
	ZHQT8S0Q2ny409ZRO6k6lAJGpHfy+YoOwqz7Tk21+KfwQxjv4BxEdDeMJnPCng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752597096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZRHfDmIEn/5QmfrWGRI7AsoURbTlppiIfa0I/ZcNcU=;
	b=plrfCHYY0PFC7F0OPQaA0RW8KO2g69f/IYXZsf07q90IyeA7tpMKmb78BkRdRERFzsKgYN
	MIpIQultd/gXtWDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 0/6] futex: Use RCU-based per-CPU reference counting
Message-ID: <20250715163134.pM1J2XO9@linutronix.de>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
 <e0f58203-22ef-44c0-9f7b-b15c6007249b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0f58203-22ef-44c0-9f7b-b15c6007249b@linux.ibm.com>

On 2025-07-15 21:29:34 [+0530], Shrikanth Hegde wrote:
> Hi. Sorry for not stumble upon this earlier. Saw these now.
> 
> Since perf bench had shown a significant regression last time around, and
> for which immutable option was added, gave perf futex a try again.
> 
> Below are the results: Ran on 5 core LPAR(VM) on power. perf was compiled from tools/perf.
Thank you.

If you use perf-bench with -b then the buckets are applied
"immediately". It mostly works also with auto scaling. The problem is
that perf creates the threads and immediately after it starts the test.
While the RCU kicks in shortly after there is no transition happening
until after all the test completes/ the threads terminate. The reason is
that several private-hash references are in use because a some threads
are always in the futex() syscall.

It would require something like commit
    a255b78d14324 ("selftests/futex: Adapt the private hash test to RCU related changes")

to have this transition before the test starts.
Your schbench seems not affected?

If you use -b, is it better than or equal compared to the immutable
option? This isn't quite clear.

Sebastian

