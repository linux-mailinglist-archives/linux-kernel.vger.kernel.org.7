Return-Path: <linux-kernel+bounces-782724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74083B32422
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B8A5C2DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5443218AE;
	Fri, 22 Aug 2025 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO4h0b4Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6C393DCB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897800; cv=none; b=KmV+1S6OsjEdf+wbaWRZKsSGev4G5ELIKMD5/AJeTbFuGSRJKtY3HUcSGjfw4OgATz1pd4tBv4V5GM7BOgjuAFHEUKp0MzKD5LqE3TyY0sJrw2rA/1lM0HKwbU6Xrpr7L2MTS/YQpP1ctt5YB2pyqmbLSOyqA7zm3xy31CHs8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897800; c=relaxed/simple;
	bh=emFrIjJagr5Xd2l/R7El5VsK0CbVYWgGJZgN1yLrwMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc59Ms5WtQAJ62LsWacwNfOckdt5p4nLBjK8KDY0aLbs5K6jGWnpimxSRHv33+YcIr6DqYUghSIXL3J1LzVmDdQQfbes0ldYuiqlJeJHzKxrhNQZ0obi/ehR68rFbgCQuniIBvA5yh9A4oMrGFpAORSrAQ1Jk0U3NhmP7q1bQuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO4h0b4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F00C4CEED;
	Fri, 22 Aug 2025 21:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755897798;
	bh=emFrIjJagr5Xd2l/R7El5VsK0CbVYWgGJZgN1yLrwMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZO4h0b4Zx8jlvENNbMXDpztTypI2iIzCtE/EhqaeIbmTL6x0FJrFTCWCt/+1sVd5M
	 uxrqsH8+5AwoJwlPu6BiAnQwpZOzBtI2jPiJMIf0WVsUTFAiDBacRzebq97MU0eEcP
	 Ta7+3lZda+NGw0foBeC9Qn0Atzkgewu3TVjeFZSCfI3sglp94zfGP6ciS8151n5CNQ
	 044DueALDBicIqx+aGGkX9cGHQ82wP7ginIfSrk6O+lYh3Od64tpg9/bmfNyLr53Jt
	 GsjwN35SUnohKgOysN8gmNZQejwjr/RMKsOIywjzWeiItWc2K/9Lxl6eDkU15cXmNS
	 Ft30LtBiJqXOQ==
Date: Fri, 22 Aug 2025 14:23:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Pu Lehui <pulehui@huawei.com>, Tao Chen <chen.dylane@linux.dev>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Ye Weihua <yeweihua4@huawei.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
Message-ID: <20250822212311.GA1629566@ax162>
References: <20250822124933.74965607@gandalf.local.home>
 <20250822192437.GA458494@ax162>
 <20250822170808.5ce49cc3@gandalf.local.home>
 <20250822171637.7ee1cf7e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822171637.7ee1cf7e@gandalf.local.home>

On Fri, Aug 22, 2025 at 05:16:37PM -0400, Steven Rostedt wrote:
> On Fri, 22 Aug 2025 17:08:08 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > 
> > > If there is any other information I can provide or patches I can test, I
> > > am happy to do so.  
> > 
> > Can you send me your .config file?
> 
> Actually, can you see if this fixes the bug you are seeing?

Yes, it does.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f992a5eb878e..2b570e057ba3 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4662,7 +4662,8 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
>  			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
>  		}
>  	} else {
> -		iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
> +		if (hash)
> +			iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
>  	}
>  
>  	if (!iter->hash) {
> 
> 
> -- Steve

