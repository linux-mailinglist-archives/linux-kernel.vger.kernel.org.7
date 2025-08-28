Return-Path: <linux-kernel+bounces-790756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B7B3AC99
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D39207DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18429BD82;
	Thu, 28 Aug 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRdR8FKz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766529AAF7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415629; cv=none; b=BUraGaY8EAlcY7WkFMX85wzLHPt9hTnhDi97UdxoS0YcbE1F2JrPGUHlwvegPJTV2Qq/rBkZqah/bukWemBaiapPONYUxkJIfcmXJWk13PXhiECyTlcinXHBW0Uur7OEGbDTbYfGoBnoJ5+03/NC/kgEPPximl1UurANUMwjsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415629; c=relaxed/simple;
	bh=deTO71vPJGPyawngqwuoD5bX+7ClNc0SKbmTxPXZJAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4JIOqWE3GYwTO9dfGzqsgMnYyuEBSADc4aufrEmJlItrFSIlg0WK0YSh8DIN8z8nmdq2Lq3qozXp02tkMXyF8ThL9PvwPJLjRVJNfh6FPYyq07EXux2tIUKzDT2klUR/57JQfs46kZyDeMsXY+lKD51tKu9tfCxlcw4WuOuNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRdR8FKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09356C4CEEB;
	Thu, 28 Aug 2025 21:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756415629;
	bh=deTO71vPJGPyawngqwuoD5bX+7ClNc0SKbmTxPXZJAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aRdR8FKzNfFqdkhAIX1LJepECgAW8wux9LdMdE1El2zueNl+XoTn5jW9qybwVxiFl
	 a/kdmAvL1NJi+CQkgojj6A4K9oCmMEFnKwwEXR6CF48buaDBNGLpyc7iKqkHWgkWBu
	 cf+Q82eb5J678s1DC5UzAqQZdYorfQytFPvIj2aRtCrtzN6zmPa8IwJhsOgMXUQhy1
	 IuBivUzCLJBWRLMevjO4sF6qrmYk8DZpTpSF46OnNi65JEdzEWFw9SqVrDCVpuBCKm
	 Bpz/spEi+HIK+B4tqqlW09/l6hzVYLtQAL6YlynS/z1SXspsaB5o8mxsT5GxmLwre8
	 ZSeTB9p8D/LzQ==
Date: Thu, 28 Aug 2025 17:13:46 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [for-next][PATCH 0/3] tracing: Trigger a warning on build if a
 tracepoint is defined but unused
Message-ID: <20250828171346.21642d91@batman.local.home>
In-Reply-To: <20250829070224.503ddc8a@canb.auug.org.au>
References: <20250828182754.733989525@kernel.org>
	<20250829070224.503ddc8a@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 07:02:24 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> [Pretending to be Linus :-)]
> 
> So, have you fixed up the 178 new warnings you know about?  I cannot
> possibly do that, or even notify the offenders.  Please do that before
> adding this code to linux-next.
> 
> But, really, these known warnings can just make it so much harder to
> notice new ones.

Then this won't get in. I simply don't have the time to fix the current
ones. I did 20 or so, and that took me all day (which I did on a
holiday). And this work is something I'm already doing on my own time,
as my employer has other priorities for me to work on.

But it is something that is needed as there's currently nothing that
tells you that you have a tracepoint not used, and the are growing in
numbers and wasting more memory.

There is an option that needs to be enabled. Now this will get enabled
with allmodconfig or allyesconfig, but scripts that do tests could
disable it. Or I can make it a tri op that doesn't get set by one of
those (but randconfig may set it).

As for fixing the warnings, it really belongs to whoever added the
tracepoint (git blame will give you that). And would be a great project
for an intern (which I don't have any).

-- Steve

