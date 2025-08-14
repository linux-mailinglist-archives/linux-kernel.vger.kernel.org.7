Return-Path: <linux-kernel+bounces-768714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A0B26473
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57916888032
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818722F39C5;
	Thu, 14 Aug 2025 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RSNb5au0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D815A8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171547; cv=none; b=IhC0m5kSZJG9zEQ1a5+mKRkEW+cfkirPZz2r/Blf+0ZOwhBRUpViTnQgP1iOiMrW0I88a3Blx34C56WpMuUUR32c++ukMIHeItoMsvBNZWCxabCFe6LsFTjk9hGep990NS8Cqec28QJfGHDR5iX+h53R0U/838FiWWw4rvh6tvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171547; c=relaxed/simple;
	bh=+fPcT9hKJxHhqGh56ibnQ12erPjW1tZJjXXP9J+cHjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF8hifzJRK+mP908u3Xd2ccOrXO7ZH4l5xkO4P6eaX35DjZXuKlx1ZAgavjcfwexd6d83fRphwiZSW8wOdmJxoV8OvVKG/D85CO+Hbs1EQv/ghTq5lwV8O/eGqoTystn39eP3GQUZLkwPgZgSYm09rgJgMCHxzKMHVBbM57h7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RSNb5au0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0720C4CEED;
	Thu, 14 Aug 2025 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755171546;
	bh=+fPcT9hKJxHhqGh56ibnQ12erPjW1tZJjXXP9J+cHjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSNb5au0vHsIbn3gH4Z1hrQa4/LytYnAgAk8suiaxYJYV1eg6HXw4geZWLXR6vzkt
	 0zJsehVcvkZzF8IAjUgrLp19bLwmgo1xgW9UqiNmgPHY7t/4IWPkeKXB+GWyiyaPOg
	 7aWIepeQvMgB+98F+i4wAK0zV+X+h5BCBUvgxiuY=
Date: Thu, 14 Aug 2025 13:39:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Wensheng <wangwensheng4@huawei.com>
Cc: rafael@kernel.org, dakr@kernel.org, tglx@linutronix.de,
	saravanak@google.com, robh@kernel.org, broonie@kernel.org,
	linux-kernel@vger.kernel.org, chenjun102@huawei.com
Subject: Re: [PATCH 2/3] driver core: Introduce fw_devlink_relax_consumers
 helper
Message-ID: <2025081429-lair-esophagus-eb8b@gregkh>
References: <20250814111023.2693-1-wangwensheng4@huawei.com>
 <20250814111023.2693-3-wangwensheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814111023.2693-3-wangwensheng4@huawei.com>

On Thu, Aug 14, 2025 at 07:10:22PM +0800, Wang Wensheng wrote:
> Some devices are added during its parent's probe and will never get
> bound to a driver. In this case, with fw_devlink set to "rpm",
> which is the default value, its consumers will be deferred probe
> until deferred_probe_timeout when fw_devlink_drivers_done() would
> relax the devlinks to the suplier.
> 
> Use this function to relax the consumer devlinks, just like what we
> do for the unmatched devices in fw_devlink_drivers_done(), so that
> the consumer devices would be probed not that later.
> 
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>  drivers/base/core.c    | 22 ++++++++++++++++++++++
>  include/linux/device.h |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d22d6b23e758..2f7101ad9d11 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1754,6 +1754,28 @@ static void fw_devlink_relax_link(struct device_link *link)
>  		dev_name(link->supplier));
>  }
>  
> +/**
> + * fw_devlink_relax_consumers - Relax the devlinks with all its consumers
> + * @dev: Device whose consumer devlinks will be relaxed
> + *
> + * Some devices are added during its parent's probe and will never get bound
> + * to a driver. In this case its consumers will be deferred probe until
> + * deferred_probe_timeout.
> + *
> + * Use this function to relax the consumer devlinks so that the consumers
> + * device would be probed not that later.
> + */
> +void fw_devlink_relax_consumers(struct device *dev)
> +{
> +	struct device_link *link;
> +
> +	device_links_write_lock();
> +	list_for_each_entry(link, &dev->links.consumers, s_node)
> +		fw_devlink_relax_link(link);
> +	device_links_write_unlock();
> +}
> +EXPORT_SYMBOL_GPL(fw_devlink_relax_consumers);

We currently do not export any "fw_" functions from the driver core, why
do that now?  This feels wrong as this should all be "internal" to the
driver core, no driver should be calling this.

thanks,

greg k-h

