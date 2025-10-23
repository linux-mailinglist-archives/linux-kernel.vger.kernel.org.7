Return-Path: <linux-kernel+bounces-866610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A81C003A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270873A3622
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23113302179;
	Thu, 23 Oct 2025 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jZaNKcMK"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2EA3019A7
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211340; cv=none; b=LhwrYZQStyH0Ei0EKP7+95zPwy5fC/UMTc+FAUKJ3gwqdw10UrinI3VX+L0JDm3UXKbQehUWbP2XNAzBYS/6fQrHJXtjYi/mIU5OIGhMSJr+sQCTdAPLQTzIrV0pmEtV/bm6CSyamjpuECycvs/PW5K5DA1IgxS5VvDmDSemmOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211340; c=relaxed/simple;
	bh=/PqIsC/c5B9vhQoN4qtfXF1blhnnWCA3Ilm0fblSIOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSy1vCluqyiRaZuAB4hbVenXXNhk+sL3gTIfs3ek9MAgoCDp2Not6GudH0dKVUXDCSc0K77ebeX2FLeSwTMYHSMyW4iyq7/F8ohyWuOkz+edIx9+fwgChRLdbD+KGlc7GkeKWGPC5Qv2ywcweIAqbANVJJFTZ1sp8NrjEQUq4Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jZaNKcMK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bS0VBEcTp53oFhUsRsDJWewLed7rPiRVUhQ9jkmG8jY=; b=jZaNKcMKMdY1QA9tMmTpCG24eZ
	SZIHOBgaTyhdK9RhDmKBksdIEwzHdRrBjCgHzu6I53V4kDD8DaCwpHexqxd29m5tYve/djxPP9nhj
	HgRHoe4BlM7fiw4Qx2cK0OgU2683VtIXfrZEwxV6GTa9TnGIM02sWh4HqXr2q3BG2hFiqpz/Zk5En
	EOjgRHokqG8i4m2c72i9B/YlYDE87jmKyoIYrilee2AHpYKl4Q3rQlofsYaLtL0TLfirBLZGBGTtd
	nPjl4F9cIfvQc4xDz+HYDkg3En7EsxZLCAeUgML8fpFshxt6LnUuWPW/Vnjf7Uwy0x4+1o5XKXaPx
	d5nrCNfw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBqei-00000001DVF-0GhH;
	Thu, 23 Oct 2025 08:26:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 34E7C300208; Thu, 23 Oct 2025 11:22:10 +0200 (CEST)
Date: Thu, 23 Oct 2025 11:22:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V5 00/31] rseq: Optimize exit to user space
Message-ID: <20251023092210.GY3245006@noisy.programming.kicks-ass.net>
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022121836.019469732@linutronix.de>

On Wed, Oct 22, 2025 at 02:52:00PM +0200, Thomas Gleixner wrote:

> Thomas Gleixner (31):
>       rseq: Avoid pointless evaluation in __rseq_notify_resume()
>       rseq: Condense the inline stubs
>       rseq: Move algorithm comment to top
>       rseq: Remove the ksig argument from rseq_handle_notify_resume()
>       rseq: Simplify registration
>       rseq: Simplify the event notification
>       rseq, virt: Retrigger RSEQ after vcpu_run()
>       rseq: Avoid CPU/MM CID updates when no event pending
>       rseq: Introduce struct rseq_data
>       entry: Cleanup header
>       entry: Remove syscall_enter_from_user_mode_prepare()
>       entry: Inline irqentry_enter/exit_from/to_user_mode()
>       sched: Move MM CID related functions to sched.h
>       rseq: Cache CPU ID and MM CID values
>       rseq: Record interrupt from user space
>       rseq: Provide tracepoint wrappers for inline code
>       rseq: Expose lightweight statistics in debugfs
>       rseq: Provide static branch for runtime debugging
>       rseq: Provide and use rseq_update_user_cs()
>       rseq: Replace the original debug implementation
>       rseq: Make exit debugging static branch based
>       rseq: Use static branch for syscall exit debug when GENERIC_IRQ_ENTRY=y
>       rseq: Provide and use rseq_set_ids()
>       rseq: Separate the signal delivery path
>       rseq: Rework the TIF_NOTIFY handler
>       rseq: Optimize event setting
>       rseq: Implement fast path for exit to user
>       rseq: Switch to fast path processing on exit to user
>       entry: Split up exit_to_user_mode_prepare()
>       rseq: Split up rseq_exit_to_user_mode()
>       rseq: Switch to TIF_RSEQ if supported

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I'm in favour of getting the scoped_user_MODE_access() and this series
merged this cycle.

I'll look at the next series later.

