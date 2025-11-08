Return-Path: <linux-kernel+bounces-891281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FEAC4253D
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24B842017A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B542C15A0;
	Sat,  8 Nov 2025 02:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="s3+Z7s5t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y1zcNt0N"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE3548EE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570464; cv=none; b=LtRaJP2OMuq/nvwoMvQptAcLtfZXnaqkN3KJiw3LwDQNxOh5NeYwpJpm9FS6DMfwnAsMu38Hvu/U0bXdeLbAb1xVi4fm4hm1JQsz/alJa2yjv6bzvNFcOMeP1vTRi9QEwmg5JEmy1op5ghfjuhyBCtR8RSMUAe/4ML/tYtJdGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570464; c=relaxed/simple;
	bh=NnRElAUm7Ulo9yC1Tt1Q1/ZdghaWhnm7cVPMPa03i7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMyXVqsCzzK3ThAHR4Y1trxtFP1bKzxz76i6FaHmJkMun5HMLMwW0lS3r86BZ+a++i2Sw/amYdwJh4Fn9w2hKLD5xEIzbaxfG922U81Jer6oT6qWdY8+qz7lTlJCnPS3YJyer/dumcHLBDWhDyJ6und50mVwibYCsiZybSZJ6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=s3+Z7s5t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y1zcNt0N; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 957791D00068;
	Fri,  7 Nov 2025 21:54:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 07 Nov 2025 21:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1762570460; x=1762656860; bh=it6IS4AVUD/C1V9mOfQ7TVjD4bPmANhK
	j8iHZiSOb20=; b=s3+Z7s5tgQ5RsDIeAftZvT5QdqAIhFtaqOafjyzVY02WpDN4
	xmCGt+UUdujsuMuMpVC7C1pgDV1KniPwpqMYNGxQlNQIaTd+MVkjqesdGvZH+uNz
	0qrUPEfzP3bBhkR3DIgWb+A4wz6btiJ+kQqf+Rl6Vl+qvFKHPZ2pA6n8uz0vipBC
	YtwO+i0t++0k46otA8sxanJuRprLBQP4PzSwDMytpLkd//i2RIPKKDCerEA2EN1w
	kEE/RZJhABirQggG+eYQ2T83l51Jx0UvoG9xudC687YO+wtVLh1dyYAHqpjdOQJA
	DNv6kkJSKqncUiIoz468YHVYFVhiDoulsyEK2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762570460; x=
	1762656860; bh=it6IS4AVUD/C1V9mOfQ7TVjD4bPmANhKj8iHZiSOb20=; b=y
	1zcNt0N9jM4/xx8DTsdNdJcKuyD4ZKl9XJFFmkT4fUAg3FnZZNWiqWjMd0pO5YuG
	Pzt+5//4NkHMO4ueoqVhJOUCpNCPFSXN1EFnzhsVWrNnhOSWFKWb7qQBlfMWwdCv
	FTqRpuZzxgsh2JleSalOYv6P5Cuth5wcBH3HU13KVtlJUaNg/7bU8LPXiTFWjLNa
	LXrxAlJJ4gFiGeBZaQZHeUhdKiV70QvhoQ4+0O8LiJ/JF+eeh4aFZVAvVq0O+lN/
	Axqb4RIn6JoaG5VJLYRby4gD9XzbEy8ms47QK3w0SGqmkHPb0W9CAm54oW0qsmMv
	Slx43I2O+3mqPi58VdWQA==
X-ME-Sender: <xms:27AOaQBvc4Mqxe1g72WYYWAtppSTxx4fMU3i4V9JaM0Cf3yLRC95FQ>
    <xme:27AOachgyXbhw1Kmd7Ta6PuPdUQKTz70WUnNx5BeByILohu0i2O3Ki2GeMR_aR9Jj
    aT-moVXZP5AIE4691vA46ew-dKclN9x9ubPePY-urYTk-oCEGswbvcS>
X-ME-Received: <xmr:27AOaaNzUFGAzBlBkPSmGwgtSqT6UhNywpyaslPTj4Kk1YdlTikdnBvRxnaEb_nr6c4s3mlgTfjmpkACQjQ2hU58yDa-le-U7jY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeehieffffeffedtjedtjefhvdevveegtdeuleettedt
    ueelffeugfehfffhkeejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtghord
    gtrhhivhgvlhhlrghrihesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidufe
    elgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphht
    thhopehtjheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirghnghhshhgrnhhlrg
    hisehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtg
    hpthhtohepmhhhohgtkhhosehsuhhsvgdrtghomh
X-ME-Proxy: <xmx:27AOaU-sIbyJhBG7f_KM3kecbg7UTLLQhu508ocQQ5FTJlU-pxqkUQ>
    <xmx:3LAOaTeovDgyOXkZHt93q_kQnZO1QKRlMAseiXPwKn-Cbpd1K-LEMw>
    <xmx:3LAOabzp3J6ea3sfXzsrYePsgwOQbZ-3rgcsPFiyUebiRBFEUizuew>
    <xmx:3LAOaQJCfCYKOqn5Xc-qtoKew80JCKB1TaEEibI3xOwcjJUvB0A9Ng>
    <xmx:3LAOaV9QtlZ9kStwoGqpiXRXx1GdUDOs4B7dCMDP_JWA-xtgseJVAGyB>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 21:54:18 -0500 (EST)
Date: Sat, 8 Nov 2025 11:54:16 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] firewire: core: add WQ_PERCPU to alloc_workqueue users
Message-ID: <20251108025416.GA73420@workstation.local>
Mail-Followup-To: Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
References: <20251107112620.146996-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107112620.146996-1-marco.crivellari@suse.com>

Hi,

Thanks for the patch.

On Fri, Nov 07, 2025 at 12:26:19PM +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> This change adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
> to be per-cpu when WQ_UNBOUND has not been specified.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/firewire/core-transaction.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
> index c65f491c54d0..c15dbe882cbe 100644
> --- a/drivers/firewire/core-transaction.c
> +++ b/drivers/firewire/core-transaction.c
> @@ -1437,7 +1437,8 @@ static int __init fw_core_init(void)
>  {
>  	int ret;
>  
> -	fw_workqueue = alloc_workqueue("firewire", WQ_MEM_RECLAIM, 0);
> +	fw_workqueue = alloc_workqueue("firewire", WQ_MEM_RECLAIM | WQ_PERCPU,
> +				       0);
>  	if (!fw_workqueue)
>  		return -ENOMEM;

As far as I know, there is no specific reason to use per-cpu workqueue
for this purpose in this subsystem. I believe that using unbound workqueue
would be more beneficial, since the workqueue users just operate chained
1394 OHCI DMA descriptor over system memory for asynchronous
communication.

Would it be acceptable for you to add WQ_UNBOUND flag to the workqueue?
If so, I can prepare a patch for the next merge window.


Thanks

Takashi Sakamoto

