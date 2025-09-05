Return-Path: <linux-kernel+bounces-803461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE844B46007
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7621A46904
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC1258CFF;
	Fri,  5 Sep 2025 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o86UWphi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491B3191DE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093125; cv=none; b=dVgagpwMFcVYuPJ8YwycS4VIzpHUQeZCtqJbMSu8PUyv82v+FjcWeQ0LOYUKxfg/E+/6moUMGf3W96g6Skcl8h2zIOPhJZ2dMbi1WwJd6Dch+4Cnvhx6KHVlB1cUNG32aG5Q/OTw3LP916J4o7GQsAvKqKOAVJZ9nVtA6C4Tk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093125; c=relaxed/simple;
	bh=LAU8apx0hsDucsURLBFwDqMFBcQ7Grcm+liKgKQbxVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlQ/w4KRwxboMJjsIDjGE68bxw9y16N+TXVbvP/0DTMy98hFVIow3LA3NE9FffiTeRaHxdffRMjiTwmhYrIXYIfJuZsq1qradkCIkJZnkK6IyRCJWJs1RFXP0GHbejCGb7Mf8/iK0MrZ2ecS1624NSSBhJk1Z4ojLoBCW/a7Di0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o86UWphi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342A9C4CEF7;
	Fri,  5 Sep 2025 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757093125;
	bh=LAU8apx0hsDucsURLBFwDqMFBcQ7Grcm+liKgKQbxVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o86UWphiW72ariivg7nnUWBkH0eOa9yLZCGu+1KbNWn+L3/aoFb1NeUZArFGLfzaF
	 IByfWBK9XgMgMEtaCmpjeufg5FrpvtKivEnbkIL4k+6XeORSv8zqWXVMWCCXZGbw1Q
	 pLtYZ+i2k3ccwHdzWGVF0+XglDwnIbsvkfKMuZakc1GL5/mu4YErDUELzU2I1yQyH9
	 pzxvlUq6zGZueLKTiWfdOe2f8xZK7k8xuB+arewqf7U9d3+KTN5gXOb/RWBJayxZSZ
	 H8SRP4w85QQkRY4Xz5/ezfS6NJDX20Uap2IikPx7sUoVvWKzbZH5JDUMsylTGFx24I
	 LVGkRVdTktC0Q==
Date: Fri, 5 Sep 2025 07:25:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 3/3] workqueue: WQ_PERCPU added to alloc_workqueue users
Message-ID: <aLsdBIY01140Vyy_@slm.duckdns.org>
References: <20250905091325.112168-1-marco.crivellari@suse.com>
 <20250905091325.112168-4-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905091325.112168-4-marco.crivellari@suse.com>

Hello,

The patch doesn't apply to wq/for-6.18 and...

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 89839eebb359..d33ca6acc5a5 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -7819,22 +7819,23 @@ void __init workqueue_init_early(void)
>  		ordered_wq_attrs[i] = attrs;
>  	}
>  
> -	system_wq = alloc_workqueue("events", 0, 0);
> -	system_percpu_wq = alloc_workqueue("events", 0, 0);
> -	system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
> -	system_long_wq = alloc_workqueue("events_long", 0, 0);
> +	system_wq = alloc_workqueue("events", WQ_PERCPU, 0);
> +	system_percpu_wq = alloc_workqueue("events", WQ_PERCPU, 0);
> +	system_highpri_wq = alloc_workqueue("events_highpri",
> +					    WQ_HIGHPRI | WQ_PERCPU, 0);
> +	system_long_wq = alloc_workqueue("events_long", WQ_PERCPU, 0);
>  	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
>  	system_dfl_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
>  	system_freezable_wq = alloc_workqueue("events_freezable",
> -					      WQ_FREEZABLE, 0);
> +					      WQ_FREEZABLE | WQ_PERCPU, 0);
>  	system_power_efficient_wq = alloc_workqueue("events_power_efficient",
>  					      WQ_POWER_EFFICIENT, 0);
>  	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_pwr_efficient",
> -					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
> -					      0);
> -	system_bh_wq = alloc_workqueue("events_bh", WQ_BH, 0);
> +					      WQ_FREEZABLE | WQ_POWER_EFFICIENT, 0);

Isn't this missing WQ_PERCPU for system_freezable_power_efficient_wq?

Thanks.

-- 
tejun

