Return-Path: <linux-kernel+bounces-579149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2BA74029
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 22:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BBF1888EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 21:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918501D89EF;
	Thu, 27 Mar 2025 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrPxEmLF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00639189F20
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110328; cv=none; b=HonZXAUu+GtHJKbG1Ozf1FDab2/pW15DXUIfnvgrta2vaZTT2DFcWLajwIGmdSBE4JopJnB7ada47X1xToDdJiEKOwCiekpBSu5fXwrDuFOZxcgg1hWH91dm5tbKMth3kC5wEnmu/wsmk18/CkfgpnYGeO9rdAc7MHG8ctX0RlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110328; c=relaxed/simple;
	bh=N5LdbcFxo+ikxS/LEvNMnTwKP6zrz88QHIfAi+yme6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQasS0L9OppM6vNALqIbyfQlnddXWQofKpVz3c7IxtJKdFv2QBcdLQkFifeL9B39myKOepA6glWo5vV0RE+R3GXVHPJ/oh78/mKKxwmjE+21+S0ZEQW7q1xF6HPP1TkMfXy7xY0kvCCWahm5GjmCEB/IZnXtJ5sSzQbXxlhHeEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrPxEmLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD52C4CEDD;
	Thu, 27 Mar 2025 21:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743110327;
	bh=N5LdbcFxo+ikxS/LEvNMnTwKP6zrz88QHIfAi+yme6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrPxEmLF+dLQJBSFIemLC4jTD4tJn8+GLUQFi8nnPFnO6G/710w1vCWyCU2UWSCWL
	 hk6MuF/nao31K4K+rglet6QU9TlJZa01wy0nuRNFvdrDlyjU04/HjOjoXlI9XxWYUH
	 Q/jBLNZXWj+HuBp23nEZXe6s8JM9f6aeVclg1GFNibkWNyQalnvN/4RsLMh2K5kAi6
	 dcaz4Hi8O8qUDYdGQNlGe5VGJ41+n87hCdIHiAftwxivmFoSN5bOtA9H8VqqvznNmF
	 velxxGENTHb/JqZl8nb5sHFrhdl+Q5NhgX8VbzfYuzXdk6cpqmUHPN8Z3jXDXapTRt
	 P18YL/LTSHpww==
Date: Thu, 27 Mar 2025 22:18:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] bugs/x86: Augment warnings output by concatenating
 'cond_str' with the regular __FILE__ string in _BUG_FLAGS()
Message-ID: <Z-XAtDi8DCNNmrCn@gmail.com>
References: <20250326084751.2260634-1-mingo@kernel.org>
 <20250326084751.2260634-5-mingo@kernel.org>
 <20250326085343.GB25239@noisy.programming.kicks-ass.net>
 <Z-UcIJAQsNXoxMXG@gmail.com>
 <CAHk-=wiN1d6ZuzwwLOKreyGuE6Q-yHG5kCkA2xVxbWXxORoXSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiN1d6ZuzwwLOKreyGuE6Q-yHG5kCkA2xVxbWXxORoXSw@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 27 Mar 2025 at 02:36, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > BTW., any reason why we go all the trouble with the bug_entry::line u16
> > number, instead of storing it in the bug_entry::file string with a
> > :__LINE__ postfix or so?
> 
> The compiler will happily share the same storage for identical
> strings, so that was an issue: re-using the same memory for the same
> filename being repeated multiple times.

ohhh ... TIL.

> That obviously doesn't work anyway once you add the warning string to 
> it, so that makes that whole argument go away.

Yeah. Explains the +100K increase in .data as well, which was more than 
what I expected.

Thanks,

	Ingo

