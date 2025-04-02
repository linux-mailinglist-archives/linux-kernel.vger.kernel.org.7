Return-Path: <linux-kernel+bounces-585239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0F3A79127
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 16:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BE21678CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF0123A58D;
	Wed,  2 Apr 2025 14:25:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C76F30F;
	Wed,  2 Apr 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603913; cv=none; b=f64uIQDJ4hraKGsDujJ6jBFtZqgKX3kA1Vu8ct2kbKC6S80JW5IOlVgyhrTeh+iIfFz4BoZuee1o47Ai57Jp3E/QPYB8GuIQ3xpBKEleYZpXkBmh96yMuCEPAov+tZpnqEbeVMSVsaarA6k/uGCmpal53TwTKg8isOYo59p8mfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603913; c=relaxed/simple;
	bh=xEiBNLZ73CFhbw2/1zEVweIiB/owUFd2G3uCB31EpzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0W6IDaNp01ADuh8xo4Nh/PI1G0F/H9KvkhTt7fFyS9bzR/NK7KOiyG2lCntxy0VTwYMvqmQ2uSNWUm+OtUZerAK4ApcsbahIMW4X+azP7Wv+DPY5agFjrAorGcPzgcfG8IZ2iRUCT2UYxvSDk4KBEE3rhrypvIiXzNhvd3RdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC67C4CEDD;
	Wed,  2 Apr 2025 14:25:11 +0000 (UTC)
Date: Wed, 2 Apr 2025 10:26:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 1/4] tracing: Enforce the persistent ring buffer to
 be page aligned
Message-ID: <20250402102614.419cbb03@gandalf.local.home>
In-Reply-To: <Z-0BrT-OxGvaWM1H@kernel.org>
References: <20250401225811.008143218@goodmis.org>
	<20250401225842.261475465@goodmis.org>
	<Z-0BrT-OxGvaWM1H@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 12:21:49 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> > +			if (size & ~PAGE_MASK) {
> > +				pr_warn("Tracing: mapping size %lx is not page aligned\n",
> > +					(unsigned long)size);
> > +				continue;
> > +			}  
> 
> Better use %pa for printing physical address as on 32-bit systems
> phys_addr_t may be unsigned long long:
> 
> 	pr_warn("Tracing: mapping size %pa is not page aligned\n", &size);

Thanks, will update.

-- Steve

