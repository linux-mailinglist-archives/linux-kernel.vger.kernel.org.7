Return-Path: <linux-kernel+bounces-827242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E8B91423
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59003B9DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5247309DB5;
	Mon, 22 Sep 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjYbQPyx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27B267AF2;
	Mon, 22 Sep 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545689; cv=none; b=sx1cxVgBuBxRn0qgKgnc4apOdEOFftwsY+UtuchvLTz/65yKj2siIioDIxzJq+2GUWMyR/2O2+hj4BzCWw4CSWU8ryuxgtlkVT6gTF4nSjgLsEz35aDvWcHn8mf/FsUfDIkxwTyfkKgOdBReCtcgho2q+hlDu4jXzuOl9eRDhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545689; c=relaxed/simple;
	bh=mo8Ww8wKPTjuOYrkH4sUb7tQu9AebzT7/14T7f8XYAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZpV3RB/nFkLZClZIbboWEQGPFgzZfdmDqnz6YDIuPoGrLfWMm9Xlie9plO7TaOH+/9olC3e9mm+tNHBBhgMT7CaYcCUuinTOv42OKM5/KX5M5qVtMUZ0VuPIpBgCtiiB0l8aGz2pujwuWdUgAgHQnPoJN/963E9aopSibXCflM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjYbQPyx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758545687; x=1790081687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mo8Ww8wKPTjuOYrkH4sUb7tQu9AebzT7/14T7f8XYAg=;
  b=AjYbQPyxX5ApznoKsyAl7tB6vYDwi8M3MFDlgaw5nhBfxBjgfGyTKN8w
   enf4xSnk20i/sOha26ibY7LfgxJgwsNz0IVLcVSobTSU7EBt1bf/1X6z6
   i4Sdf5GyYMumzE5ISaXx6a2pNg7PHEijdZNLRDwnMR8DWXFwDmVlnVYDt
   szJBmrE66q/M1UWpqNd15mbtixWgClrF4BnDImC00gwHrLUL6oIYo5itU
   gz6I5r0kL+EJnhxHPI6jpHGjSirrfn2UhIi3bH5UY4uXD1DbLEABWW2Wk
   GPnQQPOO597Nqnlrccfycua/FOMTrC/OUp4Kn9TRDoLzHBBMVc3x05R6w
   w==;
X-CSE-ConnectionGUID: Tt+lDOpWQQWtsnGNLYTHAQ==
X-CSE-MsgGUID: Cm6DYL8yQ3KOrNYMh/zRFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="60501260"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="60501260"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 05:54:46 -0700
X-CSE-ConnectionGUID: ELwCkmzLQaiE93JPOhyyeQ==
X-CSE-MsgGUID: +NY/p2tbQqq+e0J9w78zcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="180485212"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 22 Sep 2025 05:54:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id BABAD95; Mon, 22 Sep 2025 14:54:43 +0200 (CEST)
Date: Mon, 22 Sep 2025 14:54:43 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	YehezkelShB@gmail.com, westeri@kernel.org, michael.jamet@intel.com,
	andreas.noever@gmail.com
Subject: Re: [PATCH] thunderbolt: Fix use-after-free in tb_dp_dprx_work
Message-ID: <20250922125443.GX2912318@black.igk.intel.com>
References: <20250922051859.16095-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922051859.16095-1-duoming@zju.edu.cn>

Hi,

On Mon, Sep 22, 2025 at 01:18:59PM +0800, Duoming Zhou wrote:
> The original code relies on cancel_delayed_work() in tb_dp_dprx_stop(),
> which does not ensure that the delayed work item tunnel->dprx_work has
> fully completed if it was already running. This leads to use-after-free
> scenarios where tb_tunnel is deallocated by tb_tunnel_put(), while
> tunnel->dprx_work remains active and attempts to dereference tb_tunnel
> in tb_dp_dprx_work().
> 
> A typical race condition is illustrated below:
> 
> CPU 0                            | CPU 1
> tb_dp_tunnel_active()            |
>   tb_deactivate_and_free_tunnel()| tb_dp_dprx_start()
>     tb_tunnel_deactivate()       |   queue_delayed_work()
>       tb_dp_activate()           |
>         tb_dp_dprx_stop()        | tb_dp_dprx_work() //delayed worker
>           cancel_delayed_work()  |
>     tb_tunnel_put(tunnel);       |
>                                  |   tunnel = container_of(...); //UAF
>                                  |   tunnel-> //UAF
> 
> Replacing cancel_delayed_work() with cancel_delayed_work_sync() is
> not feasible as it would introduce a deadlock: both tb_dp_dprx_work()
> and the cleanup path acquire tb->lock, and cancel_delayed_work_sync()
> would wait indefinitely for the work item that cannot proceed.
> 
> Instead, implement proper reference counting:
> - If cancel_delayed_work() returns true (work is pending), we release
>   the reference in the stop function.
> - If it returns false (work is executing or already completed), the
>   reference is released in delayed work function itself.
> 
> This ensures the tb_tunnel remains valid during work item execution
> while preventing memory leaks.
> 
> This bug was found by static analysis.
> 
> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>  drivers/thunderbolt/tunnel.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
> index d52efe3f658c..89fa0c626d3e 100644
> --- a/drivers/thunderbolt/tunnel.c
> +++ b/drivers/thunderbolt/tunnel.c
> @@ -1073,6 +1073,7 @@ static void tb_dp_dprx_work(struct work_struct *work)
>  
>  	if (tunnel->callback)
>  		tunnel->callback(tunnel, tunnel->callback_data);
> +	tb_tunnel_put(tunnel);
>  }
>  
>  static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
> @@ -1097,11 +1098,14 @@ static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
>  
>  static void tb_dp_dprx_stop(struct tb_tunnel *tunnel)
>  {
> +	bool ret;
> +

Why you need variable here?

>  	if (tunnel->dprx_started) {
>  		tunnel->dprx_started = false;
>  		tunnel->dprx_canceled = true;
> -		cancel_delayed_work(&tunnel->dprx_work);
> -		tb_tunnel_put(tunnel);
> +		ret = cancel_delayed_work(&tunnel->dprx_work);
> +		if (ret)
> +			tb_tunnel_put(tunnel);

Just do:

	if (cancel_delayed_work(...))
		tb_tunnel_put(tunnel);

>  	}
>  }
>  
> -- 
> 2.34.1

