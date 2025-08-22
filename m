Return-Path: <linux-kernel+bounces-782797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468F1B3257B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E1760848E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D742D7DE5;
	Fri, 22 Aug 2025 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQv9ySPd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6371E5B70
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755906942; cv=none; b=Zy6PF2mPFpo7k2AdznkVwoeIX1Sto7aSZIcZmXcCz7yQNCQ9TbKXUXZOYYOk+gNM5EOZ1cqVlxAdeWNaqAYT7FytSz5aL3W+QEXUQtAq+2ySDYqutMZJ5EeFHhzjVJFRlo41PTnQoFtKBXUzzl2BxG95a/zKpK6FNgZsQXd0I9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755906942; c=relaxed/simple;
	bh=GZLgaXTIdmb6Uoyi3QhMHZrFqVeDc5J4X7FjVZRhmnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogLpoJV0pc8vtIqWXDZfCI8M1oQZ7QhPJ/JEmvMgkInnBfA2tVqsZSBLSLs0XbNMY3VCcty9fGGedwq2XBfv4EeYChQngBIjLr6WeQoetNPZv7W8MCednce8hcwKPIdTBZCKuI/uezsjXaPUq431b4gh1O0f0DUzAJvgni8gqvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQv9ySPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D53C4CEED;
	Fri, 22 Aug 2025 23:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755906941;
	bh=GZLgaXTIdmb6Uoyi3QhMHZrFqVeDc5J4X7FjVZRhmnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQv9ySPdYfkcEIMvAk0NukMND+zNiJH7+GzpUiKAVOn+BwJT886ExmnKAUxwPaAAT
	 209yNFdVtWpv8SCL1PsCdQETNWIkZ64CQKpG7hYsYZrbAKgz9mwRDGNhq4pU3G7YG8
	 Lzo65d5zMikJtPUXPcg6R5wNT/ULOQdih+Iam0TfoSnGuegV3GsH0mWggk1Lx2NUFW
	 PuGA9pKBE6lCmdDL4vW1lO5O4B/49G4UcSVDStEBr1EFSmIs6O4vYKnjT+WUBAtKzE
	 +Td5+p28hjNLRIrlc3aqXuWKU78H+WkL8zhGD9L6U92gkLq3aqJ6+3L9MLmCLF0LeD
	 djePOwwrSJHtQ==
Date: Fri, 22 Aug 2025 16:55:36 -0700
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
Message-ID: <20250822235536.GA1367428@ax162>
References: <20250822124933.74965607@gandalf.local.home>
 <20250822192437.GA458494@ax162>
 <20250822170808.5ce49cc3@gandalf.local.home>
 <20250822171637.7ee1cf7e@gandalf.local.home>
 <20250822212311.GA1629566@ax162>
 <20250822173959.72e636c4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822173959.72e636c4@gandalf.local.home>

On Fri, Aug 22, 2025 at 05:39:59PM -0400, Steven Rostedt wrote:
> On Fri, 22 Aug 2025 14:23:11 -0700
> Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > > Actually, can you see if this fixes the bug you are seeing?  
> > 
> > Yes, it does.
> > 
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> Ah, that patch isn't good, as iter->hash must be non NULL going forward,
> otherwise it thinks it failed to allocated.
> 
> Could you test this one instead?

Yes, this one works as well for that test.

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f992a5eb878e..a69067367c29 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4662,7 +4662,10 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
>  			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
>  		}
>  	} else {
> -		iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
> +		if (hash)
> +			iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
> +		else
> +			iter->hash = EMPTY_HASH;
>  	}
>  
>  	if (!iter->hash) {
> 
> 
> Thanks,
> 
> -- Steve

