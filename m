Return-Path: <linux-kernel+bounces-875569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D37C19572
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFD77507121
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57874311978;
	Wed, 29 Oct 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N+6URK2Y"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AA2EBB88
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728845; cv=none; b=GZ77CW9zf2zlh+uGvRL1Lo+pPz+sgSJWo8GvqdX9WZSMkuCA+4FI2MpzrHL3wbxBa2JZl2Hwb2bxcS8S2pb+7SFfZqpAIFtGQg8LAZC9eeqavfYyWdDBTs4AxdAZsiaYeoBioZ7+ZtpusvOo04DvfiALPJNN8pOFA0j8nJPYNws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728845; c=relaxed/simple;
	bh=85DCkG0iYuvCqnl8djYri+TmCjmvgPRIKKwvkOJSLGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmlAN2fV0+dX9jD/T80WvDabN7KaLoES7ViJYI4nQSr4ElGYWop/UM6jGbkzghfGejPcegzuY5X3DTDa72gboSbRR7eZYyxjQdtvj2VHT8JtJSWD09RYg81ObErabTp23lh4FmD3CrrW5rwxuElWUI+zRiBNszqAQxd1+GL/oWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N+6URK2Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8+C8Wrqujbj6m8Z3Zzw+OZlTUtlMo1jmakSDdlVaQ44=; b=N+6URK2Yo+7aO0bAseULE5bYRx
	crt2f9OTdD65gkdVXfDGdGv1zp+o2NEeqYFU1dzvsZK82VCBR7i/8Ht0oTbElOAaY0QlmlXQYqO+G
	IBm3VJtHYz2ZU6KuXwzIxe9PbDwMuzZoUNicRYU9ajPnuwQWCzaXTbL66uwOKxBeGjUAVmR0GuTq5
	cch/66v6wv/6yJAdeSU13LUoTshCJIX8C544oy1LhK757W1vSxLK8igKbODHMMaogXMB58i8BpW3+
	Lygu8A5KJf/kRbV4YMHv6QwptVcPH+w+QecU5JcU68geJzbuofOaoxeJqTJOOF1XI6FoWCdtKgtA8
	fhWc+uvw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE29D-00000005b6z-14Sj;
	Wed, 29 Oct 2025 09:07:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4F6AE300343; Wed, 29 Oct 2025 10:07:15 +0100 (CET)
Date: Wed, 29 Oct 2025 10:07:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] perf/x86: Add cond_resched() when allocate/release DS
 buffers
Message-ID: <20251029090715.GD988547@noisy.programming.kicks-ass.net>
References: <20251027212724.1759322-1-namhyung@kernel.org>
 <20251028141518.GA4067720@noisy.programming.kicks-ass.net>
 <20251028152747.GR4068168@noisy.programming.kicks-ass.net>
 <aQETYiqpEo5IcTXN@google.com>
 <20251028190422.GE3419281@noisy.programming.kicks-ass.net>
 <20251028201354.d25lZRRa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028201354.d25lZRRa@linutronix.de>

On Tue, Oct 28, 2025 at 09:13:54PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-10-28 20:04:22 [+0100], Peter Zijlstra wrote:
> > Well, we've been trying to get people to test things... But
> > realistically people will only test once you force them. So we'll see.
> 
> | grep CONFIG_PREEMPT_LAZY /boot/config-6.16.12+deb14+1-amd64
> | CONFIG_PREEMPT_LAZY=y
> 
> Debian has it enabled by default in current testing/ unstable distro.
> \o/

Yes, I noticed, thanks!

