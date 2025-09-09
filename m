Return-Path: <linux-kernel+bounces-807794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A42B4A941
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA3A363C92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AA42D46C9;
	Tue,  9 Sep 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ac6XIqw3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6F2853F2;
	Tue,  9 Sep 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412135; cv=none; b=ucuW31DwKqJvYhD+XqXMJ9F+YXUccJmqG/YDoUqYyIbnwLL411UyECvf2GYQr1DIsJy+/EmLlFpPR3D3+hY4OOAdrRF/7ftcjMduOdc//Efi/QisBQ7Khnma9sRUR/mNkFy3vO1wFGG+CEO60fy+BBs5LRoP351iNvyrDhH6OcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412135; c=relaxed/simple;
	bh=tEjUpDYvYVCiLuU5pbp0rm5Pfjj/tg0TJ9N8gnYaMb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAyTgxVs/UYLT3M3PRd9QFDIZH0IMz38Lq9OLgJQ4nC0OkA+OyCdZJqzOfL5k3w9YPZwRmHBScib+BGJXjQDf/F0hSLE2RNRS4FSD7ChzsG/oh06k5i2OkgbmZQqOEJqAQKwOADMVp00PB+y/B/jbHhRntbIAoAQmmaZUSJGiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ac6XIqw3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757412134; x=1788948134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tEjUpDYvYVCiLuU5pbp0rm5Pfjj/tg0TJ9N8gnYaMb8=;
  b=ac6XIqw3h/x/eFpMHOzAmDaGZsExBmZiupjwyvTJ3SF3tDUgexDJevhC
   lLKHYhV+cwIXFjLVrQhkShh3sVlk1eGPDpV+94WJhSsEDl1+VvYTNG/Pu
   VyFH60+YtwFikNMCRfCltF7THA3qSGXy5xTMo0UZgUkWSCEZbB51O/J6N
   N36DG3A2hgu52W/N3bHofGOswREfO3Vuwzd5qsBWU3HR4mpHwzn1JSdp5
   KeMhNIt2joQMUh7U1B21IpE1YRQ1wqpWWg6iV0SwED1GYQEvepNO7gK1X
   +owaX1AJTKCLXLOpZh2nAeW+XuEyLF9MZJumAy8LufG7u0gizvpk5OVbc
   g==;
X-CSE-ConnectionGUID: vgWVE26wSYahaQubXGuBDA==
X-CSE-MsgGUID: ELk+hLv3Th6IFVFVt3POTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="59627226"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="59627226"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 03:02:13 -0700
X-CSE-ConnectionGUID: 6CAL+BkbQ0GLmY9r/PDbfQ==
X-CSE-MsgGUID: bWb6v0dzQF2Nf5Sb/J+gnA==
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa003.fm.intel.com with SMTP; 09 Sep 2025 03:02:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Sep 2025 13:02:06 +0300
Date: Tue, 9 Sep 2025 13:02:06 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 14/22] usb: typec: tipd: Read data status in probe and
 cache its value
Message-ID: <aL_7Hklraq2ff_YA@kuha.fi.intel.com>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-14-52c348623ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906-atcphy-6-17-v2-14-52c348623ef6@kernel.org>

On Sat, Sep 06, 2025 at 03:43:27PM +0000, Sven Peter wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> Just like for power status we also need to keep track of data status to
> be able to detect mode changes once we introduce de-bouncing for CD321x.
> Read it during probe and keep a cached copy of its value.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@kernel.org>

Reviewed-by: Heikki Krogerus <>

> ---
>  drivers/usb/typec/tipd/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index e6e9730ee6dacd8c1271b1d52a02da49ff248d3e..b558fc5ecbc35a9dabbf33c444f38173740af7c3 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -176,6 +176,7 @@ struct tps6598x {
>  
>  	int wakeup;
>  	u32 status; /* status reg */
> +	u32 data_status;
>  	u16 pwr_status;
>  	struct delayed_work	wq_poll;
>  
> @@ -538,6 +539,7 @@ static bool tps6598x_read_data_status(struct tps6598x *tps)
>  		dev_err(tps->dev, "failed to read data status: %d\n", ret);
>  		return false;
>  	}
> +	tps->data_status = data_status;
>  
>  	if (tps->data->trace_data_status)
>  		tps->data->trace_data_status(data_status);
> @@ -1551,6 +1553,8 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (status & TPS_STATUS_PLUG_PRESENT) {
>  		if (!tps6598x_read_power_status(tps))
>  			goto err_unregister_port;
> +		if (!tps->data->read_data_status(tps))
> +			goto err_unregister_port;
>  		ret = tps6598x_connect(tps, status);
>  		if (ret)
>  			dev_err(&client->dev, "failed to register partner\n");
> 
> -- 
> 2.34.1
> 

-- 
heikki

