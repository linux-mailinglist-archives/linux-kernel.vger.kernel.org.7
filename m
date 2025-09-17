Return-Path: <linux-kernel+bounces-820253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79EB7CEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1E71C05D20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3978F309F11;
	Wed, 17 Sep 2025 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTjQZtL/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A3E30BB9F;
	Wed, 17 Sep 2025 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098209; cv=none; b=fAR9UhhLxW9PnMUGLEcYi1mlBduzEP54invBKoJ8sDF9VIGiu2a+ks9TUkSljmYdZoiIsuigCpIwyj41xcQlq+d5NrI8bd6a6IANQ45nAwJu5UnY2auVN4PTjXeE3yACIkYBJ5zpZYL+4tJ0W7rOUQQlTUVQHoDJpTBxfuy1mjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098209; c=relaxed/simple;
	bh=xCk75016s/xV87dqzHsaV690nHCial5+zfsMPgtss0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDvzPWe5hsgkIzSkYxS09byzNbwn06j9TFmzmtVzi+XjicOluXQD9aTnKY0LqAKoh2Y/rh4/9g/5KTx9GAdH0/4oIXjOp+yve7utC77fwlwMvFIAMYQ4cigg/wQ+2gXUe2098+w1uEKopndzkNAf2PLtjYl34UCxb5Jahco4FKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTjQZtL/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758098208; x=1789634208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xCk75016s/xV87dqzHsaV690nHCial5+zfsMPgtss0A=;
  b=jTjQZtL/4b4KFI/VaZGR/0KYeu5RtTe3uUd+dk+MUzJAt1jvg083wHT7
   63kQyALC4PzE1nxsKnux0HEfAUuXJFHgnAAbkX3aJ45WFwGnDU6oU99l3
   LhWj9ROj0bn5twOjKkrHtO4xqOma/p14U7LKh4pXBS+GvjgD8lG7TJuJV
   ePTK7IU7hGLfalJYGMI/k6GS0M5UxwfKi7CsV3TRs19KEtxqdEZMEmVR5
   7qfucfICwHxIJDTLUk1ZSGYoRf3KlhPojoKltMlopAziqemUCVwjQ7wjJ
   Wvezw3Zm9LyNhXtzFDze02OEQYraeVZd1a0x6ky8gmQMyeQFVHeeQ+arJ
   w==;
X-CSE-ConnectionGUID: HRKEs9q7Q5ye8218Eurysw==
X-CSE-MsgGUID: YxfGXiBSSjeTlDN0X72WfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60344911"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60344911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:36:47 -0700
X-CSE-ConnectionGUID: 0PZyLSU+Qx2E6WLl8IRVLA==
X-CSE-MsgGUID: l+HS+OhJRruwPr6aoPaVoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="180324623"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 17 Sep 2025 01:36:44 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0204E95; Wed, 17 Sep 2025 10:36:43 +0200 (CEST)
Date: Wed, 17 Sep 2025 10:36:43 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jiayi Li <lijiayi@kylinos.cn>
Cc: westeri@kernel.org, andreas.noever@gmail.com, michael.jamet@intel.com,
	YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jiayi_dec@163.com
Subject: Re: [PATCH RFC] thunderbolt: Re-add DP resources on resume
Message-ID: <20250917083643.GG2912318@black.igk.intel.com>
References: <20250917082456.1790252-1-lijiayi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917082456.1790252-1-lijiayi@kylinos.cn>

Hi,

On Wed, Sep 17, 2025 at 04:24:56PM +0800, Jiayi Li wrote:
> During suspend, DP resources are released through tb_disconnect_and_release_dp()
> but were not being re-added during resume, preventing DP tunnels from being
> re-established.
> 
> This caused DP displays connected via Thunderbolt docks (such as Targus docks)
> to not display after S3 resume. The issue was visible in logs:
> 
> [246.397437] tb_cfg_ack_plug:819: thunderbolt 0000:2c:00.0: acking hot plug event on 3:10

It should add the resource back when it gets hotplug event like above.

You should see hotplug happening to the DP IN adapters when the host
router comes out of sleep. Can you share the full dmesg with
thunderbolt.dyndbg=+p in the command line?

> [246.398282] tb_dp_resource_available:2019: thunderbolt 0000:2c:00.0: 3:10: DP OUT resource available
> [246.398291] tb_tunnel_dp:1875: thunderbolt 0000:2c:00.0: looking for DP IN <-> DP OUT pairs:
> [246.398294] tb_tunnel_dp:1899: thunderbolt 0000:2c:00.0: no suitable DP IN adapter available, not tunneling
> 
> Add call to tb_add_dp_resources() in tb_resume_noirq() to ensure DP resources
> are properly re-added during resume, allowing DP tunnels to be re-established.
> 
> Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
> ---
>  drivers/thunderbolt/tb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index c14ab1fbeeaf..cb652df3fc9f 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -3119,6 +3119,7 @@ static int tb_resume_noirq(struct tb *tb)
>  		tb_switch_reset(tb->root_switch);
>  
>  	tb_switch_resume(tb->root_switch, false);
> +	tb_add_dp_resources(tb->root_switch);
>  	tb_free_invalid_tunnels(tb);
>  	tb_free_unplugged_children(tb->root_switch);
>  	tb_restore_children(tb->root_switch);
> -- 
> 2.47.1

