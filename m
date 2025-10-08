Return-Path: <linux-kernel+bounces-845317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD57BC4622
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C3174EAC9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05B82F60D8;
	Wed,  8 Oct 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOhueycn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153E2571DA;
	Wed,  8 Oct 2025 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920103; cv=none; b=sTH8olySTZzFXPxgJkVd12o9g5v4OD5MAJLIg9LiAcumY8Ej2igGmj/ZonEgFupx/NwbyQ6z24cntUtqFaofSg59TFn6ypRPzmZrl6y5Ds9vSUR8w5dy+HrYsK0n4mPNuxpEs+7LaCoKBzyaZa+MaqiHtOGy8m1lYAukGlOmW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920103; c=relaxed/simple;
	bh=N7kccmBEIRyE/cBZNjVeUwqAdkOgSbKp3zdpY3l3mJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrbi736Iop0b2BLPsW7rA2uSLux10ZZLHZafUndZzk1+d7oZk720lDz6mFfu3a6Ggxswzaw0626cVRppz8GXt4wiy+TMwK1jQ2Rx2DWSn6Vgxr4w7I/cWe0pIL61c5oNIUPaRJ/pcP1Q+x418Iluq7ht+/4PIVIJ7jPiflSPZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOhueycn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759920102; x=1791456102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N7kccmBEIRyE/cBZNjVeUwqAdkOgSbKp3zdpY3l3mJE=;
  b=kOhueycnmRB7d7ATZjd+4D+XL+uPhX5pkD75A/Q8AYkEF085WFFKG3wn
   eDwgN+Vhq5B76+gGqhyGsVPUl9GDzrBbNl5xV7BxYodDDr4oRw0O1SCZB
   EsZbmQ1rcZW+FoY+e1X2gWWIbwYs6fFjw9og1T1U13Ly3LGQCpD9vHB/J
   XtvSCIisEPnb3VIptewh7bvzHjVboD/Xs1R0DEaUuMIDVPlDxxgOp4ePl
   MMTeWWCTF5A0rb/i59wuzkCDRhg8l4zNW8+3b6re3wbtBXk2Rw03psFGL
   riHoxFfPICCpwWs6iIJ/CHaW6hEvDbCU6w5GIx5yvzW79dmqg1OQ0v27z
   Q==;
X-CSE-ConnectionGUID: dfQMXXziRQCQF9fX1Ht6Wg==
X-CSE-MsgGUID: XEYfKb4zSpqMjypuHOF+0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72369483"
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="72369483"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 03:41:32 -0700
X-CSE-ConnectionGUID: X6h6d2RKRKWaq6RvYmjFbA==
X-CSE-MsgGUID: lffald/wQP+9tvvIOiENcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="180000565"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by orviesa009.jf.intel.com with SMTP; 08 Oct 2025 03:41:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 13:41:24 +0300
Date: Wed, 8 Oct 2025 13:41:24 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFC] usb: typec: thunderbolt: Fix Thunderbolt adapter
 type bitfield values
Message-ID: <aOY_1KhqJO2opqk2@kuha.fi.intel.com>
References: <20250926-topic-tbt_header_bit_fix-v1-1-122238af5c82@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-topic-tbt_header_bit_fix-v1-1-122238af5c82@oss.qualcomm.com>

On Fri, Sep 26, 2025 at 02:32:57PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The value has been amended with the release of the USB Type-C
> Specification v2.1, reportedly as an erratum.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Makes sense to me. FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> I bundled a change to the CrOS EC driver based on the assumption that
> it worked around the faulty definition. I see the Intel PMC mux driver
> also checks for this bit, but it seems like that driver assumes that
> the value is in-spec (i.e. it may be buggy as of right now).
> 
> Adding the respective maintainers to make sure everyone can see this.
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 2 +-
>  include/linux/usb/typec_tbt.h           | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index b712bcff6fb2674ec79286159090df6d79b32e9a..d80f3de1b87c362a2825bd19f826c5be077583aa 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -585,7 +585,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
>  	data.device_mode = TBT_MODE;
>  
>  	if (pd_ctrl->control_flags & USB_PD_CTRL_TBT_LEGACY_ADAPTER)
> -		data.device_mode = TBT_SET_ADAPTER(TBT_ADAPTER_TBT3);
> +		data.device_mode = TBT_SET_ADAPTER(TBT_ADAPTER_LEGACY);
>  
>  	/* Cable Discover Mode VDO */
>  	data.cable_mode = TBT_MODE;
> diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
> index 55dcea12082c80defeb6f199ad333279b58adcd7..6bf208c9dd5037f162678bc0be5be7ae1ca0deca 100644
> --- a/include/linux/usb/typec_tbt.h
> +++ b/include/linux/usb/typec_tbt.h
> @@ -27,8 +27,8 @@ struct typec_thunderbolt_data {
>  /* TBT3 Device Discover Mode VDO bits */
>  #define TBT_MODE			BIT(0)
>  #define TBT_ADAPTER(_vdo_)		FIELD_GET(BIT(16), _vdo_)
> -#define   TBT_ADAPTER_LEGACY		0
> -#define   TBT_ADAPTER_TBT3		1
> +#define   TBT_ADAPTER_TBT3		0
> +#define   TBT_ADAPTER_LEGACY		1
>  #define TBT_INTEL_SPECIFIC_B0		BIT(26)
>  #define TBT_VENDOR_SPECIFIC_B0		BIT(30)
>  #define TBT_VENDOR_SPECIFIC_B1		BIT(31)
> 
> ---
> base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> change-id: 20250926-topic-tbt_header_bit_fix-17aeb524df4a
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

-- 
heikki

