Return-Path: <linux-kernel+bounces-847720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8985BBCB81F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6671C4E2F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C99260586;
	Fri, 10 Oct 2025 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvfiR4lG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB17200C2
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760066904; cv=none; b=Cl6JDOrUzk7X0HnYcu0RjL6fSUcGU7eF7bC1Go2kUgFkKqvtYKEB3sQu+o13kWPPjLASItsV92rkuPd2WEUmtBBFzSXCzZ+gEoYbL4tKByMHi29z6Lnk5/HQFZHeeoGKTmEjcbfCkBYry99ZoIyTF7Wm9Lzk8j8CHkySp76ntGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760066904; c=relaxed/simple;
	bh=G/99KGK2f07Kx1fKV3BGnCeC5APme/vip/f6UAL0qjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHbxS2xIhppT1PWmcQD/qYarAiWtDMwGTfg5fmkhZUObJHd9l6oG/F+tppy0eC/cVVpZcdMKTKO8MrkG/DvEYZXsHXd3BiCgJ8Ri9XbwFvrpRErs3UZbwENPItMbYKR6fpElCl2TxeSpCX3izZbhQXe9HvoSH3anHsuPw90iryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvfiR4lG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B703DC4CEE7;
	Fri, 10 Oct 2025 03:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760066904;
	bh=G/99KGK2f07Kx1fKV3BGnCeC5APme/vip/f6UAL0qjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvfiR4lGLmLZ95T5oiMcNB+6XvGT2tkd5OBuvaLxRZdM4SQpA3vDbhnqy9hgascVi
	 /aBLapOHHDflUxykPdjdofvKiCu1GSJGzFtUx89sUaeeVmw+qZlmov1qLFbBRTG778
	 7RClMZ+/7+mH5JnWX0OEsO7GPmJQiHkJl15NRBCQVPrHrJf2tykmOk8BWvP8EG4K2u
	 w6a611wK8s6jCtsuPQFt6wlkmIUTTELskr5VJyj1cVOUbPO/P3+JReYgEjx91eYJaj
	 2CQDUE+Gq6Kvyor6G5CK4my3DgDSZFYOrcHXpb57ydPMmU7gz7xJFSoESpLKhyT7dx
	 uJ+GwSFkKvjEw==
Date: Thu, 9 Oct 2025 20:28:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	riel@surriel.com, frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tick/nohz: avoid showing '(null)' if nohz_full=
 not set
Message-ID: <20251010032819.GA3743688@ax162>
References: <20251007012504.16118-1-atomlin@atomlin.com>
 <20251007012504.16118-2-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251007012504.16118-2-atomlin@atomlin.com>

Hi Aaron,

On Mon, Oct 06, 2025 at 09:25:04PM -0400, Aaron Tomlin wrote:
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
> Fixes: 6570a9a1ce3a1 ("show nohz_full cpus in sysfs")
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  drivers/base/cpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index fa0a2eef93ac..10924fb5103b 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -304,7 +304,11 @@ static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
>  static ssize_t print_cpus_nohz_full(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
> -	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
> +	if (!tick_nohz_full_mask)

This should use cpumask_available() to avoid the warning reported at
https://lore.kernel.org/202510100304.IpfE7EKh-lkp@intel.com/.

> +		return sysfs_emit(buf, "\n");
> +	else
> +		return sysfs_emit(buf, "%*pbl\n",
> +				  cpumask_pr_args(tick_nohz_full_mask));

You don't need the else since you return in the if, which will make the
diff smaller overall.

>  }
>  static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
>  #endif
> -- 
> 2.49.0
> 

