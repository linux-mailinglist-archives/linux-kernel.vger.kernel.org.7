Return-Path: <linux-kernel+bounces-802684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83164B4557C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 363934E0253
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FE430F541;
	Fri,  5 Sep 2025 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUI5oZU+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09E30BB9C;
	Fri,  5 Sep 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070004; cv=none; b=rT5GH+aj0rt14+rAt49roymol76q4JlDA3A0a8jXEW7VsSOaI6YS/u+wGG2SOI8lFBfvBfm5b+Wzb2pZGp+5lVPOxj8K70UzCn23kBSLVeJ2XGe2wdJj80xSUsJ+qnksRBU093lV/umurSkVErd4/VewLp2v2YS2H8hUGcIihQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070004; c=relaxed/simple;
	bh=xWFG9IcSFRaAzKyA5Lio/LJJoAzp+33hlHZFKOaExJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4k5wIUoWOSTh0ctg4N5JfRxMN1t9Skf9k7n0UTmkSkr3bbUbEKAgFOEeyNQzxIvNGCGQ7QO97ell8J8lncYTmxCywioKv+gCryk6pwonlLyaWNck9b7oY6v8WuflLdj7lns4Nu5YgzEfF+29NLqMhjQdegUeDyp/hI7LRIbYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUI5oZU+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757070002; x=1788606002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xWFG9IcSFRaAzKyA5Lio/LJJoAzp+33hlHZFKOaExJw=;
  b=PUI5oZU+WbcD5TRE5B1gzpA3ji46yxWYYV84kOnwJvwNgxtAxrR4p28b
   q50qbhe6Zl9eC69UepGrKFCU556x/KiKT8R84Z8AbBr8wpxZ0xC98pnSC
   yFhyTm7+BZpv3pcxjrfGGEVvLRfyVPg51Oege4jd+2he6TJpfVta9SQja
   JiQz7/XfVDM7AmNPBYprAMlFj1/V+swY2mQHX+xgxsCqvbOiKEZ3fsuMW
   8AXK9eNwyjzyxeXfEcRNDovFIdIh9auNKJVvINAYufKcJq5KHAjyh8wqH
   UK5bC/dj9w/7topFCYZK2SrRMpwGnWwXgt5Bk//TvLTIUK35+lfaYpmWc
   w==;
X-CSE-ConnectionGUID: p9S9SDCySq2s9KefkPIA7Q==
X-CSE-MsgGUID: Azqi8x4kS5CuwXXMYLbkFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59118962"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="59118962"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 04:00:01 -0700
X-CSE-ConnectionGUID: zgDOmaF0S/+OTUlsH0/d9g==
X-CSE-MsgGUID: 7w6td42BQWaRq1lJzsfd3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172579445"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa009.fm.intel.com with SMTP; 05 Sep 2025 03:59:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Sep 2025 13:59:57 +0300
Date: Fri, 5 Sep 2025 13:59:57 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-usb@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ucsi: stm32: Use min() to improve
 ucsi_stm32g0_fw_cb()
Message-ID: <aLrCrQOdLsqq0U37@kuha.fi.intel.com>
References: <20250830110426.10007-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830110426.10007-2-thorsten.blum@linux.dev>

On Sat, Aug 30, 2025 at 01:04:20PM +0200, Thorsten Blum wrote:
> Use min() to improve ucsi_stm32g0_fw_cb() and avoid calculating
> 'end - data' twice.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> index 57ef7d83a412..838ac0185082 100644
> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> @@ -10,6 +10,7 @@
>  #include <linux/firmware.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/unaligned.h>
> @@ -523,11 +524,7 @@ static void ucsi_stm32g0_fw_cb(const struct firmware *fw, void *context)
>  	data = fw->data;
>  	end = fw->data + fw->size;
>  	while (data < end) {
> -		if ((end - data) < STM32G0_I2C_BL_SZ)
> -			size = end - data;
> -		else
> -			size = STM32G0_I2C_BL_SZ;
> -
> +		size = min(end - data, STM32G0_I2C_BL_SZ);
>  		ret = ucsi_stm32g0_bl_write(g0->ucsi, addr, data, size);
>  		if (ret) {
>  			dev_err(g0->dev, "Write failed %d\n", ret);
> -- 
> 2.50.1

-- 
heikki

