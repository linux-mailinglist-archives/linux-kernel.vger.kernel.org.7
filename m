Return-Path: <linux-kernel+bounces-842605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F6DBBD23C
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C223348F25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE2E24DFF4;
	Mon,  6 Oct 2025 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iPcOaQqG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F146FBF
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732471; cv=none; b=OWiRnHvW1IillT3vCgDHWhnzbU9c8+J82blXKMG/UYOkyPqyb09TweR8e7HhQPbqtm2rj9aJoNDSEFzQVF5v4aBRh4HSckF2mZnnGyY2ku0eUyTMhij+ZvEuefsnWXcnfo2EJmzXiCAYYibhPTLnQbKxVYrooiVIE/vpU8pUmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732471; c=relaxed/simple;
	bh=1L8K9EgZKgHDhP/AGV3do9GOqTXVlszDq23leu0gJns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6HrggAC68HfU3QhfD+mtamo6SY/K/FQdDGV5lYnE1bIb9eS9gQ8NJkJ4nPubPBTHq+SpMb7J1arfh1uGEcT8TE5jW/MA0kNW3utFSdG9gNhd+HpRSVfS8/Du+kooRIw3wRHAyJRY4z71HjskCk0eJGLdorPtqnvlMXuD4LMJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iPcOaQqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD0DC4CEF5;
	Mon,  6 Oct 2025 06:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759732470;
	bh=1L8K9EgZKgHDhP/AGV3do9GOqTXVlszDq23leu0gJns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPcOaQqGhyTkT36Xg2em7gB0333h43RnvY7MCN+H5ZzBtP3e5MZEAOeR7J0Y0fda6
	 SBOnsUTZHRGlYPdUjrBMq/Zk5E3HUIHIsHWjqMk3u0Bfn/RGlY6u4yG1bIHls4eAtr
	 tu/tZHt42rPCWUzsqnFDVqIUM1rDQSZIC4C9gHQw=
Date: Mon, 6 Oct 2025 08:34:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: rafael@kernel.org, dakr@kernel.org, riel@surriel.com,
	frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz: avoid showing '(null)' if nohz_full= not set
Message-ID: <2025100612-disarray-hazily-a49b@gregkh>
References: <20251006005824.76187-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251006005824.76187-1-atomlin@atomlin.com>

On Sun, Oct 05, 2025 at 08:58:24PM -0400, Aaron Tomlin wrote:
> In the context of CONFIG_NO_HZ_FULL=y, tick_nohz_full_mask (of type
> cpumask_var_t) is initialised to 0. Memory is only allocated to the cpumask
> data structure, in tick_nohz_full_setup(), when Linux kernel boot-time
> parameter "nohz_full=" is correctly specified (see housekeeping_setup()).
> If "nohz_full=" is not set and an attempt is made to read
> /sys/devices/system/cpu/nohz_full, '(null)' can be displayed:
> 
>     ❯ cat /sys/devices/system/cpu/nohz_full
>     (null)
> 
> This patch changes the output to print a newline (or 0x0A) instead of
> '(null)', making it consistent with print_cpus_isolated() behaviour.
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  drivers/base/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index fa0a2eef93ac..f694b4b24d6c 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -304,7 +304,9 @@ static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
>  static ssize_t print_cpus_nohz_full(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
> -	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
> +	return !tick_nohz_full_mask ?
> +		sysfs_emit(buf, "\n") :
> +		sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));

Please write out the if statement please.

thanks,

greg k-h

