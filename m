Return-Path: <linux-kernel+bounces-842604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA8BBD239
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F003F4E62B4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEB92248A4;
	Mon,  6 Oct 2025 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dwaz1bIq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C761819AD89
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732440; cv=none; b=swuTnskyT0Mr+KYQYBB6F+w9g0NzoN9hhBryJfF7yS1UbZpumWPRvI/vBT7IZ2QsRkYIGR0EGnf9M15Q7WwWgvDyzHhfprx+ttHvWmUud306u3z9MNl+VZXcOc/fbMQEbs/xbCjU/5PvA9+ybjTzHoOLflQ8TJpHYyZNAf2oo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732440; c=relaxed/simple;
	bh=c3bw9/Ne4vGNMBNrsJRHN55ZAi1OhLxeR1TdqRiwynI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1gI0XrkBBPy6PC/SH8vGFACkPwR5IgOlkI22g3nE0ZReSR0o2X6tbeDzaegqsRbAkTZ1kA/xc3dr1SPoebGBRb8Rfi0ymr3DxBSYpYfWOxoPNLGclD/+hCiXlLb4S6U6lbKqf5EVPQqGUYA6IeRsuW36LfICzE++bMDtQHdi8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dwaz1bIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E53C4CEF5;
	Mon,  6 Oct 2025 06:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759732440;
	bh=c3bw9/Ne4vGNMBNrsJRHN55ZAi1OhLxeR1TdqRiwynI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwaz1bIqn8fx0SRy0vDVbZy17BX+7b3giBYodPsH59jjUhGS4Zbe+i1UL7rYjUMul
	 9WnldXln8H2ejWiGga8fxY+P7wall1z6ionC+tYzXmvKvpHwa1MdPVByuXhsIqU+6o
	 Gba9SdnJ+Y+Z77Vt4pKjCGRwypkhm9lXVwHgMZc4=
Date: Mon, 6 Oct 2025 08:33:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: rafael@kernel.org, dakr@kernel.org, riel@surriel.com,
	frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz: Expose housekeeping CPUs in sysfs
Message-ID: <2025100652-scolding-tractor-8745@gregkh>
References: <20251006005853.76335-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006005853.76335-1-atomlin@atomlin.com>

On Sun, Oct 05, 2025 at 08:58:53PM -0400, Aaron Tomlin wrote:
> Expose the current system-defined list of housekeeping CPUs in a new
> sysfs file: /sys/devices/system/cpu/housekeeping.

But you did not document that new file in Documentation/ABI so it's a
bit hard to review if this is really correct or not.

> This provides userspace performance tuning tools and resource managers
> with a canonical, reliable method to accurately identify the cores
> responsible for essential kernel maintenance workloads (RCU, timer
> callbacks, and unbound workqueues). Currently, tooling must manually
> calculate the housekeeping set by parsing complex kernel boot parameters
> (like isolcpus= and nohz_full=) and system topology, which is prone to
> error. This dedicated file simplifies the configuration of low-latency
> workloads.
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  drivers/base/cpu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index f694b4b24d6c..c6511658f6cd 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -300,6 +300,19 @@ static ssize_t print_cpus_isolated(struct device *dev,
>  }
>  static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
>  
> +static ssize_t print_cpus_hk(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	const struct cpumask *hk_mask;
> +
> +	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
> +
> +	return housekeeping_enabled(HK_TYPE_KERNEL_NOISE) ?
> +		sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(hk_mask)) :
> +		sysfs_emit(buf, "\n");

Please write out if statements, it makes it easier over time to
maintain.

> +static DEVICE_ATTR(housekeeping, 0444, print_cpus_hk, NULL);

DEVICE_ATTR_RO()?

thanks,

greg k-h

