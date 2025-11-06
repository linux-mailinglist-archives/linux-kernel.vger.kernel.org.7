Return-Path: <linux-kernel+bounces-889209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD52BC3CF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 650584E25B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3152D061E;
	Thu,  6 Nov 2025 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iayiIE5b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D83343D71
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451707; cv=none; b=CLedxBkKPqyRVKuHwvNJOpDovk+G4BtPmz0xL1cp7z3OCBGh+kxuj8tLrKqnAw2afK/tR+GpSQJhTeDAf+kIpiwMXbP258nfHIuq+PvDjM03+EguJfR714yp25FJuWNvxSp1A9mHk+zY3dQPXbvYYEqxEo0XRxQlQESN+j0l92g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451707; c=relaxed/simple;
	bh=PhIGpK/jHneVvnPo6STSaPmgJcep3TIfXiPVGahcqB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgFbcaJdgy62rs3w/cLpTvl11fkMbPI7oUkcmFCzXDpYnMeL0xFgHGU9UiwoimvCdO84HnilhfX8MLp2IFwFm9Cb9BCcBCmY4UYpi42zS3BAqWgWbZByJl221RDNq28qiQp50ET2BF2h2/nYhxxVt7WP9vEnnrloO372zbEWRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iayiIE5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1318C116B1;
	Thu,  6 Nov 2025 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762451704;
	bh=PhIGpK/jHneVvnPo6STSaPmgJcep3TIfXiPVGahcqB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iayiIE5bo7RA3gPzuQNjdGZiwXt+7T+vexiFW1VT/eACu8cfXkDZWBxBV4fVcX0vr
	 CZBpTfd+/ObL7qEelhLTxWNrt2ky9g0nvpppTQx3LYC2hcFauAqTglI6VnnX7pKeZc
	 a6bmCrBybjToHfMyBaOJaED6jrzGPDHTVmkHvan7IUAka29vDn2xcZYB7RLiXhif9T
	 CpGqFl011Yz8erenKmrUk5WUb+igzqY39NUH90nLLWMsoN1w9O5P2V/N5wAnlmrqGj
	 G5yAZi7fuw23mfAx7weA0gE86Qc4K51/V0bBC/0SMR7KSv9Av9KzuOuax1C2xi0DU7
	 umlBabGWfRgcw==
Date: Thu, 6 Nov 2025 07:55:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org,
	Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH cgroup/for-6.19] cgroup: Fix sleeping from invalid
 context warning on PREEMPT_RT
Message-ID: <aQzg9kcnCsdRQiB4@slm.duckdns.org>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <aQpUY7fEp6_ZqGel@slm.duckdns.org>
 <aQtqXfMfy8SWjS67@mozart.vkv.me>
 <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20251106150717.cZuPZnF5@linutronix.de>
 <aQzczJZFiGPOocKb@slm.duckdns.org>
 <20251106174614.2yy65_wM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106174614.2yy65_wM@linutronix.de>

Hello,

On Thu, Nov 06, 2025 at 06:46:14PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-06 07:37:16 [-1000], Tejun Heo wrote:
> > Will switch to IRQ_WORK_LAZY_INIT.
> 
> Quick question: Since it is not important at all, would it work to have
> it in task's RCU callback, __put_task_struct()?

It doesn't have to run right away but it better run in some definite time
frame because at this point the task is not visible from userspace otherwise
(it doesn't have a pid) but are still pinning the cgroup, so we're in this
limbo state where reading cgroup.procs should return empty (there may be a
bug here right now. I think the code will try to deref NULL pid pointer) but
the cgroup is not empty. This window is not really broken in itself because
cgroup empty state is tracked and notified separately. However, task_struct
can be pinned and can linger for indefinite amount of time after being dead,
and that would become an actual problem.

So, to add a bit of qualitifier, while it's okay to run it with some amount
of delay that's not very significant to human perception, we definitely
don't want to allow delaying it indefinitely.

Thanks.

-- 
tejun

