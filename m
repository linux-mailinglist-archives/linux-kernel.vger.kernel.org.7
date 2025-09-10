Return-Path: <linux-kernel+bounces-810283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1358EB5183D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319BA7BBA96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F36F1FE471;
	Wed, 10 Sep 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsfnIoGa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CF1F8724
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511985; cv=none; b=ujWiKzfrV1L/jHeBgEqkHL67a1Q3Zi2yNLOqAlwkTtQRT1HjnJaUvMDjbwy5xWygcN/EWOcrJQB96Yqpew/tGGg9sny4rXH+U2SmTkNQ8p5251K269QAsbv9WpmRJ5I//6dsvFC+XLVPnh/ApP1ApeAzE/LFMsUg4ORGhEe53zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511985; c=relaxed/simple;
	bh=Z/lyEjkENGwT4E4qRYJLH9qYiypcMSYpOEd2eScZw3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPqSvXvydaa8+u8NhwkKpm/q5+OVU5tJ9BomDfVW1bgQ+Pb6DOYc7t2Xy1MdMOmHnS8M5uLyN6ThC9udO5V8pvfGhM4KI+BzxfnKzLCUlhXhDw6/2ZMRnOiYJlLKGc8IhmF2SxAxj+d9a4lEyTX6KnCP21yn7iayOli/4Me4wZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsfnIoGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B15DC4CEF0;
	Wed, 10 Sep 2025 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757511984;
	bh=Z/lyEjkENGwT4E4qRYJLH9qYiypcMSYpOEd2eScZw3g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KsfnIoGafcYvKijpvZ2STXtEl7e62sVFN+Y13CBCjAbA72Gx0Hw/vJnG3OzJxvk/b
	 fIpuSKJClLuGe+cVp0Jo9ymlSNYIb7IlGALa21ZRuxYY0dxelgONUWz2EFFejNn0P3
	 vmK3Yfmy00EoNWp3u5kr537nJ1mPw39SevEVNS9SNBeG6WGUPnDd6qqXFORRLR6fRd
	 tJGpxTgnkfhiY+nS1G5d7R5gs1/x2sFvny1Jp2I2Qru+jNo+KlULxDPdeG0ukd/2E2
	 eYVAKpi/ZzGzfLUm2R6/szd0DPyXcID0KwrmVPccLBv7Vn0WwIxk0mKE2E7CgqbaZJ
	 KvSbs9o798yvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 28310CE0B24; Wed, 10 Sep 2025 06:46:23 -0700 (PDT)
Date: Wed, 10 Sep 2025 06:46:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refperf: Remove redundant kfree() after
 torture_stop_kthread()
Message-ID: <328b2f91-acef-4ee8-9562-9ec608124d07@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250909054148.1573012-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909054148.1573012-1-kaushlendra.kumar@intel.com>

On Tue, Sep 09, 2025 at 11:11:48AM +0530, Kaushlendra Kumar wrote:
> Remove unnecessary kfree(main_task) call in ref_scale_cleanup() as
> torture_stop_kthread() already handles the memory cleanup for the
> task structure internally.

Again, thank you for your interest in Linux-kernel RCU!

And you are right that the kfree(main_task) is redundant, especially given
that the main_task pointer will be set to NULL in _torture_stop_kthread(),
so that this kfree() is just a confusing no-op.

> The torture_stop_kthread() function is designed to stop the kernel
> thread and free the associated task structure as part of its cleanup
> process. The additional kfree(main_task) call after torture_stop_kthread()
> results in a double-free condition.

But this last sentence needs adjustment.  Because _torture_stop_kthread()
NULLs the pointer, the second kfree() gets a NULL pointer, thus not doing
a duplicate free, right?

> This pattern is consistent with other torture test modules where
> torture_stop_kthread() is called without explicit kfree() of the
> task pointer, as the torture framework manages the task lifecycle
> internally.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  kernel/rcu/refscale.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index 2c2648a3ad30..2bfa987f4ba9 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -1050,7 +1050,6 @@ ref_scale_cleanup(void)
>  	kfree(reader_tasks);

For ease of debugging with kdgb, drgn, and other tools, it would also
be good to set reader_tasks to NULL.  Please feel free to do that,
either as part of this patch or as a separate patch.

							Thanx, Paul

>  	torture_stop_kthread("main_task", main_task);
> -	kfree(main_task);
>  
>  	// Do scale-type-specific cleanup operations.
>  	if (cur_ops->cleanup != NULL)
> -- 
> 2.34.1
> 

