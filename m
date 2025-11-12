Return-Path: <linux-kernel+bounces-897244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 472BCC525D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC3F64F90F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E132BF20;
	Wed, 12 Nov 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="UK7fd9z3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBEfLY+w"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39431C56A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952170; cv=none; b=MsFi4ZsBnh8mz+qpvrxB71OXTySx0ugF+ejQ5aoul/Jcr4745vGMRCeLNqHbG2+YAxEuxJKIaIz34ReOvJZh6diCrXvf6zUaXkvAr/LlwvURSfLj/Uib/ziyOyRwqZ3beA9sdSDZCTLltRiCZD724QCQ9XfyMBGj3V3GbCCYZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952170; c=relaxed/simple;
	bh=I3Q2jYDOCZeaFT7QaSLqlzLaEREStpumauoP/k1fnak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TezvWN28EKCrPBLXmLpkJeuT00uAAwxZ7gg8NWOY/xZJg/dQLYKf8pm65bo5jnuquWYV/8Ya2EwrNjpwtMWcmwvmXjo6E4dCc1YCKIQyzLWo8I0l9UuMxvHY5vfkN5EaMBdi6LWhT6fTVA42SUdCfSi2f/T1XglCTNJ5cjpOaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=UK7fd9z3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBEfLY+w; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E247A7A001D;
	Wed, 12 Nov 2025 07:56:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 07:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1762952165; x=1763038565; bh=tJ22zlrlu3Vel3DOJxla0AS5oBx5Wd5Q
	85qKqPsVN/I=; b=UK7fd9z374LzG4q3ktkKx90gR0duxPhELruoGhPvt6Huz+wz
	GxIQouwxCe7IYtzwJi7D4QKlo4HHnxfvAPuqiVPAJGjkImLqFI59UZqRUPVC9lmf
	ieTlK0NJuE9ghmsdE+gY98fibiHVEFV27qb0Zw8+vNoVVRUzhkUkS3pP1yPFV3g5
	UPSt5f2PzNfWRJ5rKQ6scDyFMdkMLkFdM8ytGTX/9Dm2iGCBQ+78ekw6xScb6iBJ
	SoBRgIEqKqB+fLBLpRVwc9kyiVCNdVhFQJA+2TbandIkxwPu3kkqeBzuNnvTAXQp
	SqdZFGC9ZcfYDJ7gLEP1IQcpNk/+1Up/ta4dJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762952165; x=
	1763038565; bh=tJ22zlrlu3Vel3DOJxla0AS5oBx5Wd5Q85qKqPsVN/I=; b=f
	BEfLY+w82VzbPQlTH1tkQRrrikjnQrSY3EDbT4FmBDEjnf2IuX+pSPJAPXRti6N/
	xOiO8pKTX3oQamu2MQeXHVARidGGFWV2BuPqV7r5jugFkpp0ozK8xMhfnFaWKBZt
	JlS4gyLZZ4O+RXNQI0Yaw9/bdmAV+ILhS+eAFA2rHHyyP7giUo9PUhdajwFMcSeS
	RyNZnADfHWCKNveTgROsiOJ2Wc01tkQLlCnw9Xvi444Fkr4nECxoikV2Fr4IJNm8
	3NxbP7n19YdMAfc/AIXIbdtQdmPn1nHwjmWc01lIEeahPFYEJUrVZS8m06RVBS2R
	htvtzrr3+HD7eYluXYAcA==
X-ME-Sender: <xms:5YMUaS7KLYjKjS6zC4PXGmV5s7AOhW3pTl0IxLeuIWwlmr8TeHK9Pg>
    <xme:5YMUaV6HddoEWQLaD9N_myFHJjqSjse5svv6M3CTmsXsKbuw3LK-Bs8xrdaQe2GOx
    ApzsI-qniQJWdGlO4kR7ssI_qLJw7A9LGV4GkuERsmXFz2rVP-kOR5D>
X-ME-Received: <xmr:5YMUaYGljxIojB4wEPENMWOe5WULcQOe_J5pUTklJy4iu5sgXVpLtAndG4S9aCjoMne7GA8cs-OEVezxFLghnaU60mdcyvkw4Us>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegudefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:5YMUadVbf0cuIo0bDfwXgTlv9st7c8rk0jQTKk1og6LiRR91aAFsnQ>
    <xmx:5YMUaUXI2r6Ha9PAk-44A57tVWJeYPjaNlpFTptyRTLhUan_Mw9WYA>
    <xmx:5YMUabIjZXtQNkfEvbXEPgmrsS4leMPjpeEUWFMzCd0GmzltQUu2oA>
    <xmx:5YMUacDzVzN3g_98LIKLkszCw6NAjlgJtZOP3a0J2AwFEhosHJ5lvQ>
    <xmx:5YMUadJhfrImORzvmI3OA39mHrKOhUXtNAwxOQFu32H2wpoH0yrrt9rf>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 07:56:03 -0500 (EST)
Date: Wed, 12 Nov 2025 21:56:00 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] firewire: core: add WQ_UNBOUND to alloc_workqueue
 users
Message-ID: <20251112125600.GA325192@workstation.local>
Mail-Followup-To: Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
References: <20251112120125.124578-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112120125.124578-1-marco.crivellari@suse.com>

Hi,

On Wed, Nov 12, 2025 at 01:01:25PM +0100, Marco Crivellari wrote:
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
> This change adds the WQ_UNBOUND flag to explicitly request
> alloc_workqueue() to be unbound, because this specific workload has no
> benefit being per-cpu.
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
> Changes in v2:
> - This workload benefit from an unbound workqueue. So change WQ_PERCPU
>   with WQ_UNBOUND_WQ.
> 
> - Rebased on 6.18-rc5
> ---
>  drivers/firewire/core-transaction.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next branch.

I'm sorry not to reply to your previous post since it did not reach my
mail box... Your v2 patch is a good reminder ;)


Thanks

Takashi Sakamoto

