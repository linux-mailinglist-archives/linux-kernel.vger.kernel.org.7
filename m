Return-Path: <linux-kernel+bounces-779126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB18B2EF5E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDC8A25696
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A82E8B75;
	Thu, 21 Aug 2025 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3OComlg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230222D97A9;
	Thu, 21 Aug 2025 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760823; cv=none; b=MFyor3PDKzB2I9PIPeWODdFKhz80BTgDfOeKmJL/w9sN3/ovLUp8RU88//5gcUpS17mAB8mHHxkJ1WGb3N95JAVuBxTQ2wDNFj7aJlApbRQwfTuS1GZOwTO1mBN+im/7IxIdi/XywlL3t5Wqssq4EfhegkouGgrhTgL/fMQWOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760823; c=relaxed/simple;
	bh=Xc4DeUvPlwL/X3t5tUIDgqbcUa1hfQSPHd61UdxsmOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzKWBdf36ddJCgSq2/Yp8XP5LXTJ5GcOkci0o8HmWY4G+M7piLEAa+RvelDJJteGJaKkCQSvHFhRIzF2CCuImNpvz7/TZUFgYqEsAxsgiWCkqRIDXdqNR1tyQIh0EAp20a7UgpqYu0vd8sbTUQWvV0HJsuhxakoZD8rFWm5DxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3OComlg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755760823; x=1787296823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xc4DeUvPlwL/X3t5tUIDgqbcUa1hfQSPHd61UdxsmOc=;
  b=h3OComlgEVwMA+QQKEQ6Ku7fxGsSnUsMMcrzCAvOJIyg61bVZP5sH9Ni
   a/uI48uAGZdeSPLcelR/dp+hpyhb643M+GIUOVOFSGpXIMzhhN8ml3MhP
   2py/cyHQtbwl+n/OWVBuwYk84uKs4b3vzQHVkS4BeaoN+dl9biRUIzkeC
   fwIzM1JeieaRfI8/hxfwTapWkGgxQ6HRCDeZ4174fb/HRElyMBmP8WMN8
   DJxzhto/eMM06ylKjWrvJnZi4MKXxOZrkunQyHQwz2NQKFH/5L9nPItPe
   6b/tG5LyklzIpUD/hJGoAibc3cZAYeBVPPU6icfa10USJRXCLHwWqbYyI
   A==;
X-CSE-ConnectionGUID: jNKa4L97RqKTS7fgS8unrA==
X-CSE-MsgGUID: MY0dLeYxQzmgMyo8Bhm1Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58185534"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58185534"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 00:19:06 -0700
X-CSE-ConnectionGUID: 7VGpz8mcSvGH+prbD7CmsQ==
X-CSE-MsgGUID: f5GzOVavRwGAW3sDIppezA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168697277"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa008.fm.intel.com with SMTP; 21 Aug 2025 00:19:02 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Aug 2025 10:19:01 +0300
Date: Thu, 21 Aug 2025 10:19:01 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yongbo Zhang <giraffesnn123@gmail.com>,
	Hans de Goede <hansg@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] usb: typec: fusb302: Revert incorrect threaded irq fix
Message-ID: <aKbIZSCIK5mOB3Vz@kuha.fi.intel.com>
References: <20250818-fusb302-unthreaded-irq-v1-1-3a9a11a9f56f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-fusb302-unthreaded-irq-v1-1-3a9a11a9f56f@kernel.org>

On Mon, Aug 18, 2025 at 06:50:19PM +0200, Sebastian Reichel wrote:
> The fusb302 irq handler has been carefully optimized by Hans de Goede in
> commit 207338ec5a27 ("usb: typec: fusb302: Improve suspend/resume
> handling"). A recent 'fix' undid most of that work to avoid a virtio-gpio
> driver bug.
> 
> This reverts the incorrect fix, since it is of very low quality. It
> reverts the quirks from Hans change (and thus reintroduces the problems
> fixed by Hans) while keeping the overhead from the original change.
> 
> The proper fix to support using fusb302 with an interrupt line provided
> by virtio-gpio must be implemented in the virtio driver instead, which
> should support disabling the IRQ from the fusb302 interrupt routine.
> 
> Cc: Hans de Goede <hansg@kernel.org>
> Cc: Yongbo Zhang <giraffesnn123@gmail.com>
> Fixes: 1c2d81bded19 ("usb: typec: fusb302: fix scheduling while atomic when using virtio-gpio")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Note, that the referenced patch is in 6.17-rc, but not yet in any
> released kernel. It breaks boot for Radxa ROCK 5B when fusb302 is
> enabled in its device tree (strictly speaking that's not a regression,
> since upstream DT does not yet describe fusb302).
> ---
>  drivers/usb/typec/tcpm/fusb302.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index a4ff2403ddd66fb7aaa27fd890533c7aff1dc163..870a71f953f6cd8dfc618caea56f72782e40ee1c 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1485,6 +1485,9 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
>  	struct fusb302_chip *chip = dev_id;
>  	unsigned long flags;
>  
> +	/* Disable our level triggered IRQ until our irq_work has cleared it */
> +	disable_irq_nosync(chip->gpio_int_n_irq);
> +
>  	spin_lock_irqsave(&chip->irq_lock, flags);
>  	if (chip->irq_suspended)
>  		chip->irq_while_suspended = true;
> @@ -1627,6 +1630,7 @@ static void fusb302_irq_work(struct work_struct *work)
>  	}
>  done:
>  	mutex_unlock(&chip->lock);
> +	enable_irq(chip->gpio_int_n_irq);
>  }
>  
>  static int init_gpio(struct fusb302_chip *chip)
> @@ -1751,10 +1755,9 @@ static int fusb302_probe(struct i2c_client *client)
>  		goto destroy_workqueue;
>  	}
>  
> -	ret = devm_request_threaded_irq(dev, chip->gpio_int_n_irq,
> -					NULL, fusb302_irq_intn,
> -					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> -					"fsc_interrupt_int_n", chip);
> +	ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
> +			  IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +			  "fsc_interrupt_int_n", chip);
>  	if (ret < 0) {
>  		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
>  		goto tcpm_unregister_port;
> @@ -1779,6 +1782,7 @@ static void fusb302_remove(struct i2c_client *client)
>  	struct fusb302_chip *chip = i2c_get_clientdata(client);
>  
>  	disable_irq_wake(chip->gpio_int_n_irq);
> +	free_irq(chip->gpio_int_n_irq, chip);
>  	cancel_work_sync(&chip->irq_work);
>  	cancel_delayed_work_sync(&chip->bc_lvl_handler);
>  	tcpm_unregister_port(chip->tcpm_port);

-- 
heikki

