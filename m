Return-Path: <linux-kernel+bounces-807772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D8EB4A902
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC75F3B369C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680EB2D1F68;
	Tue,  9 Sep 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkU8Kh3D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D4256C7E;
	Tue,  9 Sep 2025 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411782; cv=none; b=P/GKxJ4u/qm4AT7S7HWA/rOd0IDALuVWi/e3CAL+XCbpJAZ6I2j1nJnvyoZwghj1V0brjWzzDrchCawqm+nARKiQzDXA+GlJbe7zYelfwo13I74n0Xl3tXREFeFPjUvok2AmHTiDdlCd8pHaL8rZI1EBrOVIe6+6q89mNlaQOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411782; c=relaxed/simple;
	bh=uo5ZUhYMuByiGgJRlg8TUV2xCirGU9z4qi8EAlibyr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StAzifZ83fejtjp2N9CMVOSL7EHG1zqNVRElyElM7bhKsV5gv0ON7koTSOvZMyIkHDwiH+K/AckyRjG8MSNk16Cr/CaRDI0YhpLULeQyhLHlQPJ6HluyDtB2IE+ylDujXu6kw9/KwBpkv8kCIcJpxiAKGLpF9qG82Q3IBSpjhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkU8Kh3D; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757411781; x=1788947781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uo5ZUhYMuByiGgJRlg8TUV2xCirGU9z4qi8EAlibyr8=;
  b=VkU8Kh3DXAo47And/As3kxpv0wyHxDgnai1kTCz2f6BTeJmXj4P2E3Cf
   7r9EMazmDHP5I8lk1Uq84kjBiNAP+7i+Fn5UySa7yD/B8JAynTms5UXCZ
   coWOqAcLWNQWw2AHWZyXLLeU8ZBYNwsU++vaYwOBNj5dKox7UHm6UK0jY
   Q/7n9K/r4jAED5zP712FEAcV8c7KThIeDTHLn1x6aDRL7LTBxD7low/MZ
   VTPwFSBGMjayYWtrml+tbGf//RN4z5cxgdIa+BJUn5EWz6AL/lnPSd9sO
   UgOnFJeMxKFPEM9npmt43jpjcahQYnHyUT7iUUgZ9kPy2XwL7PuftZQ8K
   g==;
X-CSE-ConnectionGUID: oNRwR22qTrezmsxRkZ+Q+w==
X-CSE-MsgGUID: 3MXa3Dz6TySVnSUH272l6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70308685"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="70308685"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 02:56:20 -0700
X-CSE-ConnectionGUID: P1az0YAkRKGZnXA+YSHqnw==
X-CSE-MsgGUID: x+o8/7BtRJCBL8qT1k7V2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="172209638"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa006.jf.intel.com with SMTP; 09 Sep 2025 02:56:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Sep 2025 12:56:13 +0300
Date: Tue, 9 Sep 2025 12:56:13 +0300
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
	Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 13/22] usb: typec: tipd: Use read_power_status
 function in probe
Message-ID: <aL_5vZvZG4oYQACo@kuha.fi.intel.com>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-13-52c348623ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906-atcphy-6-17-v2-13-52c348623ef6@kernel.org>

On Sat, Sep 06, 2025 at 03:43:26PM +0000, Sven Peter wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> We need the initial power status to be able to reliably detect connector
> changes once we introduce de-bouncing for CD321x next. read_power_status
> takes care of this and also forwards the status to the trace subsystem
> so let's use that instead of open-coding it inside probe.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index cd427eecd8a594b7e609a20de27a9722055307d8..e6e9730ee6dacd8c1271b1d52a02da49ff248d3e 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1549,11 +1549,8 @@ static int tps6598x_probe(struct i2c_client *client)
>  		goto err_role_put;
>  
>  	if (status & TPS_STATUS_PLUG_PRESENT) {
> -		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
> -		if (ret < 0) {
> -			dev_err(tps->dev, "failed to read power status: %d\n", ret);
> +		if (!tps6598x_read_power_status(tps))
>  			goto err_unregister_port;
> -		}
>  		ret = tps6598x_connect(tps, status);
>  		if (ret)
>  			dev_err(&client->dev, "failed to register partner\n");
> 
> -- 
> 2.34.1
> 

-- 
heikki

