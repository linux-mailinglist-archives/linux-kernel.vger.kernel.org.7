Return-Path: <linux-kernel+bounces-802761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E04B456A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EC0A41A54
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1714734A307;
	Fri,  5 Sep 2025 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBnNCUSt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF2343218;
	Fri,  5 Sep 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072409; cv=none; b=TGQMi5UKmOjXWzkzK+C7wyGDtJeyfSyKn7g7dn2wI2CZpadxDzVy/W+OSibYlSDhxpO0dqm+2EqyoZDA1eqnZQ0Fm2OLavPkgkDG2lLjuVt1RfPk/uzefseLFZCo64wA860L2aZbwjNzc78uMCQxDG7eOHhZZQxjpss/rTZfcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072409; c=relaxed/simple;
	bh=sx2wz53gv4OIUWMCEXeNS8i0YplTPAB4OZ9qODA9qog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq1ExSVckm+9XO1wGnhh8YtSCU0RE6YXwxsLOmgEVJUTFRt9Wv6js9XKqbWlmIglWwIGZiFJFainXr5PHbCiXMoTgTARiBnIcwsyeur0tEZ1cQWUKibk2E1E4ToI6lmQOkFwq7beu2YW6vo+ds60Lrp1wCH+VR9iF/oMVAi7osA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBnNCUSt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757072408; x=1788608408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sx2wz53gv4OIUWMCEXeNS8i0YplTPAB4OZ9qODA9qog=;
  b=SBnNCUStDUL8/JU+555300KEYJqMKh87/udKHLgCPI8aYRdDCjWyf+HH
   J/XeWcr05hfN7fZ99VbPcOW7GMdjSiv8urOg2/PuOWC7ls+yYT0rS1+Hp
   8qMda3aFHc81hPO8FfSU2yG5bJ86J424+lzCFWpCixOJc+e8KwAkNTALv
   cZ3T162/4IXaz39sq4e11W3VQgHh3h7zssBKWhItn/bPzx7JiWTzkBOQH
   YPsIff6m5zRlHu+rdkAyY3HJDh1Oo6G1H6inNmssLXFF1LqzGIWe9C2U1
   zlJ3qGyKfAy+tc1kWS/cf+5Yrn5wCmjSG4GStGxJiQeFGFuLWBicJWISE
   Q==;
X-CSE-ConnectionGUID: ctwFtdUfRUKCae+fE+b6gA==
X-CSE-MsgGUID: ZlCcPbIKRliMa9oxkWWuFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="63064752"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="63064752"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 04:40:07 -0700
X-CSE-ConnectionGUID: 7ivWf5SiTburyJTsZYw9/Q==
X-CSE-MsgGUID: Mm1LtjFKRfexLBEV4Qw4+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="171710329"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa007.fm.intel.com with SMTP; 05 Sep 2025 04:40:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Sep 2025 14:40:00 +0300
Date: Fri, 5 Sep 2025 14:40:00 +0300
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
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH RFC 15/22] usb: typec: tipd: Update partner identity when
 power status was updated
Message-ID: <aLrMEL_St_0JlZYG@kuha.fi.intel.com>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-15-172beda182b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-atcphy-6-17-v1-15-172beda182b8@kernel.org>

Hi,

On Thu, Aug 21, 2025 at 03:39:07PM +0000, Sven Peter wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> Whenever the power status is changed make sure to also update the
> partner identity to be able to detect changes once de-bouncing and mode
> changes arre added for CD321x.

s/arre/are/

> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  drivers/usb/typec/tipd/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index e369897bfa017ca96e559a8bd70da11207d4513a..b0fdd4dddd3a490dbc2a8ced21ea0803658f36a7 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -636,9 +636,16 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  	if (!tps6598x_read_status(tps, &status))
>  		goto err_unlock;
>  
> -	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE)
> +	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE) {
>  		if (!tps6598x_read_power_status(tps))
>  			goto err_unlock;
> +		if (TPS_POWER_STATUS_PWROPMODE(tps->pwr_status) == TYPEC_PWR_MODE_PD) {
> +			if (tps6598x_read_partner_identity(tps)) {
> +				dev_err(tps->dev, "%s: failed to partner identity\n", __func__);

				dev_err(tps->dev, "failed to read partner identity\n");

> +				tps->partner_identity = (struct usb_pd_identity) {0};
> +			}
> +		}
> +	}
>  
>  	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
>  		if (!tps->data->read_data_status(tps))

thanks,

-- 
heikki

