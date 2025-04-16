Return-Path: <linux-kernel+bounces-607786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFD7A90AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 20:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37663AA155
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 18:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D4219A75;
	Wed, 16 Apr 2025 18:04:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1E217F35;
	Wed, 16 Apr 2025 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826676; cv=none; b=qL3m0xjGv/C8ia8ELQEKcSGwIgfv5wyguuH1/iMu9URdkWHSIcXBu36GjnZmXpK2N3SDQ/sKWYXsgDHG6Ea/3Ix1Yk0cUuaG/SWsS1/YmME3d3SBwUmR83AIfKLfPbvXnkD3KpA49vwlpN53/3FGMzvPwCn6AKTQne90DA1J0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826676; c=relaxed/simple;
	bh=++H/SPj2hlgAsEXEILale8u7bquKXSSXOGs5qLQm0yM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBE1FBuVylMHMJ94N87NeDEI2bgEn8XOVFf3xqtD1diKMdFJ/RTfFehh4cwtLJIHrLF9Y0XI5RrqjczLJDeFElW6l5Jlp3Y3fCUwf7bPq9Z4X+LP/t6NZI5BwWr7s7PxDsi9dQ2sPHeQwDbsLCtg7Z0dB7dBCtiqyvf/f+A4uGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6E9C4CEE2;
	Wed, 16 Apr 2025 18:04:34 +0000 (UTC)
Date: Wed, 16 Apr 2025 14:06:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Junxuan Liao <ljx@cs.wisc.edu>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
Message-ID: <20250416140611.17a87271@gandalf.local.home>
In-Reply-To: <20250416140115.5b836b33@gandalf.local.home>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
	<20250414205441.GGZ_12Eew18bGcPTG0@fat_crate.local>
	<20250414182050.213480aa@gandalf.local.home>
	<20250416174714.GGZ__tIi3yNzNKoKFE@fat_crate.local>
	<20250416140115.5b836b33@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 14:01:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Ok, so AFAIU, this gives you how long user page faults take and apparently for
> > someone this is important info.  
> 
> This was just a simple example. I rather see where in the kernel it happens.
                                                      ^^^^^^^^^^^^
                                                     user space

> I can still use the synthetic events and user stack trace to find where the
> big faults occur.

