Return-Path: <linux-kernel+bounces-855723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20253BE21C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0118351620
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA9301030;
	Thu, 16 Oct 2025 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XOUK4p5P"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083767E792;
	Thu, 16 Oct 2025 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602572; cv=none; b=XvMqgB1T80RLHWcWrBqdxqgfzu+FbB5M6zDpuFSh19F8hFT6bDXb8ExGvLEwHDv6kfxcqA7XwCI/NPpBTCwUrCDCrdjwNoMmPudip18vuqLHrM9+3eARjO0eubeyP/csxTKJOT1YEwZQN96A0b+DMy8WgpK//eiFyOLScqpIIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602572; c=relaxed/simple;
	bh=NS2bZgSCEjrsZCth2PmZak4yHidoIg5OCGTOdfjJmO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkK0AmZx3avv8QW3NBhcCok/2MFiMjn/oAo8LfXKhZkkfzAX1M7D2RCdEzL427B+mIOeOdNhjTHZq5c5jOQ0avtA6YlHnGaN2n07qfLgFoCRAh4TPC3gXkbdoK6ZTK82C/HnLImu3Qux7FRyohhISkRNJQYtwZkXQ1J24YmaVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XOUK4p5P; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7cAjm8Tz3LGb9mcUksWZLTLAnhVHMasRUPL8gTvLYQ8=; b=XOUK4p5PHmU8K8JqIcXQdSBtXH
	5AKvRswG5FW5x7jmQElrXCdawlbq/iRcWEb6skhP3c+k58gC934RrqEKxIqjTj2uL1sRT0EqVIjiU
	NoluWI0ugBHXMTdXHU7xg8iwrxs+M1s7dBCVvlw44OoXWiHZxkYV/Lo2ieYoo5itJTiFds3RqbElI
	6cNYFyBZMctvkWx+eZMp3AwRv75lGM4CVAtcS830VIPA27i8s1OW8XjUKy+lvQXiwOUxp+ePnSsuZ
	S2DiGF4n1IWMqOLkyCqjpeieGtQf4GcF0SzXFGM6ZVw0Y+/wg0x/5JWygYYNr5YIjkFoF6p5TEZoo
	0zB31JNA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9J8k-00000006am8-28IV;
	Thu, 16 Oct 2025 08:15:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6534E30023C; Thu, 16 Oct 2025 10:15:13 +0200 (CEST)
Date: Thu, 16 Oct 2025 10:15:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v13 05/17] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <20251016081513.GB3289052@noisy.programming.kicks-ass.net>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-6-lyude@redhat.com>
 <7a98eb42-bc54-4f22-bc85-0f6d41f39fc7@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a98eb42-bc54-4f22-bc85-0f6d41f39fc7@acm.org>

On Wed, Oct 15, 2025 at 01:54:05PM -0700, Bart Van Assche wrote:

> > This also makes the wrapper of interrupt-disabling locks on Rust easier
> > to design.
> 
> Is a new counter really required to fix the issues that exist in the
> above examples? Has it been considered to remove the spin_lock_irqsave()
> and spin_lock_irqrestore() definitions, to introduce a macro that saves
> the interrupt state in a local variable and restores the interrupt state
> from the same local variable? With this new macro, the first two examples
> above would be changed into the following (this code has not been tested
> in any way):

So the thing is that actually frobbing the hardware interrupt state is
relatively expensive. On x86 things like PUSHF/POPF/CLI/STI are
definitely on the 'nice to avoid' side of things.

Various people have written patches to avoid them on x86, and while none
of them have made it, they did show benefit (notably PowerPC already
does something tricky because for them it is *really* expensive).

So in that regard, keeping this counter allows us to strictly reduce the
places where we have to touch IF. The interface is nicer too, so a win
all-round.

My main objection to all this has been that they add to the interface
instead of replace the interface. Ideally this would implement
spin_lock_irq() and spin_lock_irqsave() in terms of the new
spin_lock_irq_disable() and then we go do tree wide cleanups over a few
cycles.

The problem is that that requires non-trivial per architecture work and
they've so far tried to avoid this...

