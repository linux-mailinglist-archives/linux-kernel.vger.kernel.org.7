Return-Path: <linux-kernel+bounces-752469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8DCB175E6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8747116C1AF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43520CCE3;
	Thu, 31 Jul 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMvVtBcj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2A1D799D;
	Thu, 31 Jul 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984797; cv=none; b=ZWYYDWCfULONhgUJow41iW/bVBhDOkimRx1uPoV9bzrdXS06X2BGwIuiyzJ7hO+l7TuihIDKA6IsjmYWjnDL0i/ObjxbgqLduf7O0Xzdo81MjPF7yEXy7JffNloZ037/4NqYXILdMi7KRXZ1ulNZzsMFI+m5qWLWC8UjM3F3RQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984797; c=relaxed/simple;
	bh=Ptk/Q7/Iyhy4Rqdh5Z4v7N2Hcd2mosBQp4bFkdIZlhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8p1o1a8endP1ISxF+TaM0WYlLJmBn3SXhs73fdXzhM6jtg/mv6PgAqh2YbYCw5E1dhweZxdYQDoPQfqhKK5nyYWXmScpXUvwQGCopLunTRvmiPiFCgw71v3GFXo8FaFPY/sFMu5DQIwBm40Ix/4inqLjfL5Uv8v7wDt9YoNF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMvVtBcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E7CC4CEEF;
	Thu, 31 Jul 2025 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984795;
	bh=Ptk/Q7/Iyhy4Rqdh5Z4v7N2Hcd2mosBQp4bFkdIZlhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMvVtBcjORhi0/3Neov3/9uYvF7aOCn8wqZKqMOgKQgL9752YznmEBY+Vz51/ICWT
	 qSUnUuqekI8zLSyLQx4oi9NWbfAnlRw+S72Wpuvia1T5DQ6hDL4UmUTr2Lk0Nly5S0
	 76Ku0J9k09tfubeOt+8n2jLI4POCu6TnAy0V9JpVXi0JxUzEThYwF/3euqa0b8sHsf
	 GL3UJ6yf7qGJAieb4+HFdS6cNae4cXHIn7GEshY+IOdsVMWiC7RPLXk3wIrYX8J1oZ
	 3+H72zfmevb2Cll+qF4BKjeL+H6fLWIq3ZpJovU3EjziTtJNxSgwRxl0xX0omIoxDN
	 QaeupKV+sEFJQ==
Date: Thu, 31 Jul 2025 10:59:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: lkp@intel.com, akpm@linux-foundation.org, zi.li@linux.dev,
	llvm@lists.linux.dev, mhiramat@kernel.org,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hung_task: fix objtool sibling call warning in
 watchdog()
Message-ID: <20250731175951.GC1455142@ax162>
References: <20250731023934.48840-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731023934.48840-1-lance.yang@linux.dev>

On Thu, Jul 31, 2025 at 10:39:34AM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> The kernel test robot reported an objtool warning on the loongarch
> architecture with clang:
> 
>         vmlinux.o: warning: objtool: watchdog+0x418: sibling call from
> callable instruction with modified stack frame
> 
> To resolve this, explicitly prevent the compiler from inlining or
> performing a tail call on check_hung_uninterruptible_tasks() by marking
> it with the noinline attribute. This ensures a standard function call
> with a proper stack frame, satisfying objtool's validation requirements.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507301256.cZlxQ10s-lkp@intel.com/
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

While this may solve that particular instance of the warning, the fact
there are many, many more with that configuration indicates that there
will need to be a more generalized fix. I have started a separate thread
with some LoongArch folks around this issue:

https://lore.kernel.org/20250731175655.GA1455142@ax162/

Cheers,
Nathan

> ---
>  kernel/hung_task.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 8708a1205f82..a5b5a0a2c262 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -283,7 +283,7 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
>   * a really long time (120 seconds). If that happens, print out
>   * a warning.
>   */
> -static void check_hung_uninterruptible_tasks(unsigned long timeout)
> +static noinline void check_hung_uninterruptible_tasks(unsigned long timeout)
>  {
>  	int max_count = sysctl_hung_task_check_count;
>  	unsigned long last_break = jiffies;
> -- 
> 2.49.0
> 
> 

