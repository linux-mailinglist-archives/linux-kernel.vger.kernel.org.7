Return-Path: <linux-kernel+bounces-889229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0B2C3D062
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DEC428120
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6A5334367;
	Thu,  6 Nov 2025 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fF0wkthW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bbbAs4Ep"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E072C326C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452383; cv=none; b=TCGjXd292U0zyO0bcBul0LARP45Hugn+sy54ohxYIRh0zGCNY/iWl2ztvJdVvHVs/yfUM9E33XaIzn7eie12SvHXXs2aDUYcelETncM8cJpzWH3Zx/CG/qZt7V/yUyB+VAfrP2LTzGkQBCzPCQABQNczeRGBLKUecpOT4kZbBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452383; c=relaxed/simple;
	bh=kiOrXMG21Qs89x0SAx/LxXtzvyx38Jr26Uvnc5GzD40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQpdEFFTgJxip1fFkXEIqUB+p8k9bCV0OZk3ynVjkBqtUWGp/VVW1Rgb2tiCtFcj82hs3MRHhNe2xMGcJ/Y0tgcA/bvBcMy0XwwhZks6FhY4lQym7iDDTn7yanVIMGva6WVHIfOJW9Bdoh8DRRmB3jI92SMrgQdHjTflxTXBnYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fF0wkthW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bbbAs4Ep; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Nov 2025 19:06:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762452377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ML0+z+r8KGHrMtoQS6Ahe+a9kNBfqTdC80LLfI4Aaj4=;
	b=fF0wkthWKhwXJI8stWnYhLkQISqyw/ufNk/Nl3LOgGPSmR2Fvf1XMqs3hcOKAJR/mN/kEK
	MBfyP4DSxj1aGi2eW5ZAATkrF03jtKLxhOtf5F42bNSF6c1QwwE+Ee4cyljqNL2dMLHen5
	3Hh+1/xbFKvRfmdL7ydXGKCsWOIlpp5Eut4wAZJQAsDLwi41l0gerUyRrBKXa4ZR4QpRRQ
	+H3L4N5CK6muQouX9uyYO3rj/D9O/j+/7QipHQaD4jcr4124stOr98uifDJrbFt3DVik90
	RIoDCsgBIMYvR+9b3RyzbXhDcW3stLMu9pSp3EXCIYwxAuAmbse907arKIziFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762452377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ML0+z+r8KGHrMtoQS6Ahe+a9kNBfqTdC80LLfI4Aaj4=;
	b=bbbAs4Ep3aSxTtb92m+DX1nx/2lqdacgqbro6kIcYOO8Ds/g+nmCNul42baP3C69dVl/E0
	MflRHWGnfpt3nuAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org,
	Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH cgroup/for-6.19] cgroup: Fix sleeping from invalid
 context warning on PREEMPT_RT
Message-ID: <20251106180616.tqGlAVGX@linutronix.de>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <aQpUY7fEp6_ZqGel@slm.duckdns.org>
 <aQtqXfMfy8SWjS67@mozart.vkv.me>
 <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20251106150717.cZuPZnF5@linutronix.de>
 <aQzczJZFiGPOocKb@slm.duckdns.org>
 <20251106174614.2yy65_wM@linutronix.de>
 <aQzg9kcnCsdRQiB4@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQzg9kcnCsdRQiB4@slm.duckdns.org>

On 2025-11-06 07:55:02 [-1000], Tejun Heo wrote:
> Hello,
Hi,

> On Thu, Nov 06, 2025 at 06:46:14PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-11-06 07:37:16 [-1000], Tejun Heo wrote:
> > > Will switch to IRQ_WORK_LAZY_INIT.
> > 
> > Quick question: Since it is not important at all, would it work to have
> > it in task's RCU callback, __put_task_struct()?
> 
> It doesn't have to run right away but it better run in some definite time
> frame because at this point the task is not visible from userspace otherwise
> (it doesn't have a pid) but are still pinning the cgroup, so we're in this
> limbo state where reading cgroup.procs should return empty (there may be a
> bug here right now. I think the code will try to deref NULL pid pointer) but
> the cgroup is not empty. This window is not really broken in itself because
> cgroup empty state is tracked and notified separately. However, task_struct
> can be pinned and can linger for indefinite amount of time after being dead,
> and that would become an actual problem.
> 
> So, to add a bit of qualitifier, while it's okay to run it with some amount
> of delay that's not very significant to human perception, we definitely
> don't want to allow delaying it indefinitely.

Okay. This is some arguing that would justify the additional extension
of task_struct :)
Understood.

> Thanks.

Sebastian

