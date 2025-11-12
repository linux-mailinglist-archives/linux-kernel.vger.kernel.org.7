Return-Path: <linux-kernel+bounces-897500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733FC52F20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75D8C354A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B843C34B40F;
	Wed, 12 Nov 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux3gUjoO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B6F34D38C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959629; cv=none; b=H15pn2H4a8q3nP9XnWGbXYr1RPU3gznnt7F3SKcieTUCoRCPYeuwCVKGTc4v7hZROaVVD914Z8kt0Pm9qh47UMHsSJNyIkIKTDQyuQhWyAZ8DMoyXR8ROZL1enD78zhOcUATbxUcziVMHOuaX3rDLXKI55B0laoCON1ye3LAhG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959629; c=relaxed/simple;
	bh=Gqb+YI2S+/BJWBumgOQifCNHxmdPbzO2WCdjrw8uUuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIMSAcvrTk2buboJzo5E1kxqyLxVjJ2a8QWmsAY17pJlf315pR92V2ruHRYSCjDOaeheHbVspNCCwI/1EMbabP0lKuculjY/Bhoxcs+vtYblCfuAM6AtBEwuS/kgHEaeeeguiIDQw1AexnYM0A6/poghzfl0NIGUSHRYBuqem7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux3gUjoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF22C4CEF7;
	Wed, 12 Nov 2025 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762959628;
	bh=Gqb+YI2S+/BJWBumgOQifCNHxmdPbzO2WCdjrw8uUuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ux3gUjoOTq1LshF8CkV/eyaaiIG3TSYk1p4lslmSeJyEuKqZ1LbCWcAe4efLwxV1P
	 yWcCc80mVo0IQWNDb6ret3d8hE5jFna0suPNAoLZVt3sHjlIXc/EivqcXwOxLyo8TX
	 1xBWghKTSvdIDwpHMZxb4Vfy/kvL+GcVAc5F9TJ2grPReXcpKW/wHJaYotmhwJpTsh
	 Dlc1KXAPFece67c6ALKLg6Z0Rbayn96mGmEbY/IdRsWIZtCyqJmxoZuBSlzNcTHYKq
	 +a0N0W5+sw0XvOpfmmiqdjNYEjUE+jw5iZA5RqpbdCihIr7mIXTJM35l6kXS3XIIBY
	 NSnXttFYfZomg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vJCKi-000000005r3-0drG;
	Wed, 12 Nov 2025 16:00:28 +0100
Date: Wed, 12 Nov 2025 16:00:28 +0100
From: Johan Hovold <johan@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers/greybus: add WQ_PERCPU to alloc_workqueue users
Message-ID: <aRShDB8g0hG7JcWX@hovoldconsulting.com>
References: <20251107132149.177327-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107132149.177327-1-marco.crivellari@suse.com>

Please use just

	greybus:

as prefix.

Note that hardly any driver subsystems include "drivers/" in the commit
summary.

On Fri, Nov 07, 2025 at 02:21:49PM +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.

Apart from the naming of the WORK_CPU_UNBOUND macro I don't see the
inconsistency here. We queue on the local CPU as documented (unless the
CPU is not in the wq_unbound cpumask for unbound workqueues).

Note sure how explicitly marking percpu workqueues is going to change
this either so this paragraph doesn't seem relevant for the change at
hand.

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
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.

Fair enough, the default is about to be changed.

> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

With an updated commit message you can add my:

Reviewed-by: Johan Hovold <johan@kernel.org>

> ---
>  drivers/greybus/operation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
> index 54ccc434a1f7..7e12ffb2dd60 100644
> --- a/drivers/greybus/operation.c
> +++ b/drivers/greybus/operation.c
> @@ -1238,7 +1238,7 @@ int __init gb_operation_init(void)
>  		goto err_destroy_message_cache;
>  
>  	gb_operation_completion_wq = alloc_workqueue("greybus_completion",
> -						     0, 0);
> +						     WQ_PERCPU, 0);
>  	if (!gb_operation_completion_wq)
>  		goto err_destroy_operation_cache;

Johan

