Return-Path: <linux-kernel+bounces-877110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51241C1D367
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 456CC4E171D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98BC31280B;
	Wed, 29 Oct 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eqK8PpQV"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E4311969
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770042; cv=none; b=sGm6e8BtzGsqyc5/ZMWqGrZMnONs9+QUrQYcsJskCa+D3P72JHk0rGwNnF9I/BOv1wsQlEjigH1aHCsuLZeuuqiFQFxWv0Svojr0geAjNaxAnjCvhLcKjvPx3v6d8gD5w1RJC8f+/KF9I9GMINBepav7MfzVaxcUlPGDDHHg/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770042; c=relaxed/simple;
	bh=f4BgwcQbfSKq6anpK4XuvXsMkFdycBzStXXczZDDPlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLnAUH2Enopx6dsI+SSMt1GdHuHzM04H5+gVoWV8x4ACP5vs2GP831p4lXL88HsgVvPbyzjaN1SpGw0A4Ra5WN5p9lgWtYXcZhF+Cko/0hr5jtolcWodXc7yFlVVZ4nKnxVx8fMMYFkFG7JypDQRh04qzi+3pEgzexUKl4Wm+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eqK8PpQV; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03fa25f0-b7f5-4b3e-8a93-0637d0222719@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761770038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2k0g02pMCf4/8FiMhdYemYEY3w1Y1j1mpeO8X6WI3F8=;
	b=eqK8PpQVhB45TQ+e9goYGAPAg0O2Dp06e6a1Qy0SoalbGt2/CB4bHuWi9DNZmYphHq5OsB
	CRFgUrQja5ezsp4/USWxeyJSdcFXjFc/PnpUdXp7sr/7dZJ+a5JgQ5iQ3UFdcn1W1qf3MP
	7KHJ40xm9nGAtKsecbRfiSgdOH592uw=
Date: Wed, 29 Oct 2025 20:33:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ptp: Allow exposing cycles only for clocks with
 free-running counter
To: Carolina Jubran <cjubran@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20251029083813.2276997-1-cjubran@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251029083813.2276997-1-cjubran@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/10/2025 08:38, Carolina Jubran wrote:
> The PTP core falls back to gettimex64 and getcrosststamp when
> getcycles64 or getcyclesx64 are not implemented. This causes the CYCLES
> ioctls to retrieve PHC real time instead of free-running cycles.
> 
> Reject PTP_SYS_OFFSET_{PRECISE,EXTENDED}_CYCLES for clocks without
> free-running counter support since the result would represent PHC real
> time and system time rather than cycles and system time.
> 
> Fixes: faf23f54d366 ("ptp: Add ioctl commands to expose raw cycle counter values")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/ptp/ptp_chardev.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 8106eb617c8c..c61cf9edac48 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -561,10 +561,14 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   		return ptp_mask_en_single(pccontext->private_clkdata, argptr);
>   
>   	case PTP_SYS_OFFSET_PRECISE_CYCLES:
> +		if (!ptp->has_cycles)
> +			return -EOPNOTSUPP;
>   		return ptp_sys_offset_precise(ptp, argptr,
>   					      ptp->info->getcrosscycles);
>   
>   	case PTP_SYS_OFFSET_EXTENDED_CYCLES:
> +		if (!ptp->has_cycles)
> +			return -EOPNOTSUPP;
>   		return ptp_sys_offset_extended(ptp, argptr,
>   					       ptp->info->getcyclesx64);
>   	default:

Fair point.
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

