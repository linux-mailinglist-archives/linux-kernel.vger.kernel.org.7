Return-Path: <linux-kernel+bounces-895827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED73C4F094
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77203B0AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796BD36CE08;
	Tue, 11 Nov 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qs0atqBB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87117A2FB;
	Tue, 11 Nov 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878558; cv=none; b=Om9s7kvDMAssbpzuoHn8uU2DwJMWixk2RE0IfRJ10ZpvSHmcW7uJbG7u19otkMDV+k5Q3PZhZgcUyRTbnv7hf3Ni+IYd/T4ygfCl6kTgAVNjk9X50B+d4gp7jW8YOtAZ/rQOuVaDvddgwGxnJoC65q5PKpXcrSDOf1hmb7f5enI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878558; c=relaxed/simple;
	bh=r6r/dibHt7gKsJlc15AaHj0MhZ0VxuXQRGsH4ORp1jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll0Ly2goNWk8s2kfF+F6SX5f3WkwF96N+XIHX892glddwlnvQ7xEPsVo0VJk6ou5oI2TDsAoB78vsa+YaT/2mSiHM6oHQ1BLS0Wl4DZf1BWS33daNaW4q3kcqpZu2hNoTXkMbTmH5RunUpcMVhOWyGpJdd/YJ4kwPBsGx7wl6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qs0atqBB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=45ndhzZr7OM5GxhMEX7qJet13MunAKjZDwBqrx+ASfo=; b=Qs0atqBBrm9+7ekxD2jSj1Q5lB
	VU9ueRW2n7Gd0pW6iC11HDMjIeQBesM2tsgjnu4LohOyHpu31rsOM21To6i3cjvvR/7/oGKfPxlf/
	uSGke/P+MKG/50znvfIGZUC+9ak2+DxSrBL9cump8bSfIG3mERmpZXm/O0brlP+y7rOLrdoWHqXh/
	Lr47kKLuN9lL7Y27q7Z943XTPmvC0U1Y4wopSb5FWiC52VUytDbWethq0cWORxQeW+rgyMWDDnFp2
	O3tIAI0GHekWh6MIy+JEi//oUX5t2rMzEy6c/bkolcv+zvUWhX+bth8E9Y4c+vGeesIZwvrXFVy2X
	PV+hQy4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIqNN-0000000DjeA-2Knj;
	Tue, 11 Nov 2025 15:33:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EB51D300328; Tue, 11 Nov 2025 17:29:11 +0100 (CET)
Date: Tue, 11 Nov 2025 17:29:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:sched/core 8/10] kernel/sched/deadline.c:1441:16: error:
 use of undeclared identifier 'd_se'; did you mean 'dl_se'?
Message-ID: <20251111162911.GA4156767@noisy.programming.kicks-ass.net>
References: <202511112120.vStICnyl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511112120.vStICnyl-lkp@intel.com>

On Tue, Nov 11, 2025 at 09:27:12PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> head:   46f61fb2e7678daae743d601efac3b957041ed56
> commit: b75a19b9d73e0deb5f761884228b8b15694e2858 [8/10] sched/deadline: Document dl_server
> config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20251111/202511112120.vStICnyl-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 996639d6ebb86ff15a8c99b67f1c2e2117636ae7)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511112120.vStICnyl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511112120.vStICnyl-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/sched/build_policy.c:58:
> >> kernel/sched/deadline.c:1441:16: error: use of undeclared identifier 'd_se'; did you mean 'dl_se'?
>     1441 |         if (dl_server(d_se) && dl_se->dl_throttled && !dl_se->dl_defer)
>          |                       ^~~~
>          |                       dl_se
>    kernel/sched/deadline.c:1430:70: note: 'dl_se' declared here
>     1430 | static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
>          |                                                                      ^
>    1 error generated.
> 

I'm an idiot. Last minute edit had a stray delete or something. Force
pushed.

