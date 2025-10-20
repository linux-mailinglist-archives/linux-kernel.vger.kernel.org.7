Return-Path: <linux-kernel+bounces-860510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA3BF04CC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E617406905
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB0C2FB09E;
	Mon, 20 Oct 2025 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrcBpFLs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D82F746C;
	Mon, 20 Oct 2025 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953423; cv=none; b=QO2kL9Hw7BvPBqay4LfwMqNWN0nn/IprS4uRQk4Z3VpyZc3X0pC5nBW0A862UpoIRd4k3K5JM++HWFekiBbD/jjqsst9wU99AjrgYPkytGIrIAxC2Ua64md2gAuusMCY4SaLbkioEFDp9MPDdk0Q86cuR7+klZNCmMklfbAd7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953423; c=relaxed/simple;
	bh=1IsVPhW/sf67YgQO1rky3oKuczfRd7w9/SINK+ai9kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es7Zv6BTx48aV16JAAvLdIdrntt7cDem40RJvFl/7065tYLSb5Id3S500seDoZmFm+h5x0pnZMqgOodIehGtwmNIOiGT44OENar79XBIM/af38zLdYe5loXvNOATjRr36gV+a8p+ghZXZQGsR2+Rc4tr8tregP/O5El78bPFL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrcBpFLs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760953421; x=1792489421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1IsVPhW/sf67YgQO1rky3oKuczfRd7w9/SINK+ai9kI=;
  b=mrcBpFLsEiAH1iDL+5qRqfUm/Tk/OW9tnxmyR/FAb33qpJD/P1oJwG4u
   qn1PTSWdYMl9lFQGfWRn9YmRPIa/y/ySgyo15H7NlgXgfVWSa5QieQPti
   oXLeNab+DuCTcwlqg2KQJ8B8u5pltcO+VIkfg3qsE3p5ZLd9reSq83/KT
   PqOcq0kYRqhlpP2fSL7Kt3BLgugenbG/phiMQ2bucVnWyFmrl9dcDKH41
   dWbRqLHpkqe0haTrwODz4GjDAg4VLwPdLr/RvNE675PqC/k0cCV0b3R39
   2Q15jGnbHTGRptFoKpgS1E6/NoJlP9xOHj4oDJT+XuM9erV6VR5jPMuPG
   w==;
X-CSE-ConnectionGUID: hIrh/eHCRnirgVk633qYmA==
X-CSE-MsgGUID: Pqsm47eAR+q7F073aR44WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="73738163"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="73738163"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 02:43:40 -0700
X-CSE-ConnectionGUID: X9lbY/qSTaq4k+rQCF9Ybw==
X-CSE-MsgGUID: +xw2olryQQunXSfGcIpQaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="220437083"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.112])
  by orviesa001.jf.intel.com with SMTP; 20 Oct 2025 02:43:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Oct 2025 12:43:34 +0300
Date: Mon, 20 Oct 2025 12:43:34 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
	Jack Pham <jack.pham@oss.qualcomm.com>,
	Raghavendra Thoorpu <rthoorpu@qti.qualcomm.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] usb: typec: ps883x: Cache register settings, not
 Type-C mode
Message-ID: <aPYERtFRKx6jdh_R@kuha.fi.intel.com>
References: <20251014-topic-ps883x_usb4-v1-0-e6adb1a4296e@oss.qualcomm.com>
 <20251014-topic-ps883x_usb4-v1-1-e6adb1a4296e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-topic-ps883x_usb4-v1-1-e6adb1a4296e@oss.qualcomm.com>

On Tue, Oct 14, 2025 at 06:06:45PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Certain Type-C mode configurations may result in identical settings of
> the PS8830. Check if the latter have changed instead of assuming
> there's always a difference.
> 
> ps883x_set() is changed to accept a typec_retimer_state in preparation
> for more work and the ps883x_sw_set() (which only handles orientation
> switching) is changed to use regmap_assign_bits(), which itself does
> not perform any writes if the desired value is already set.
> 
> Reviewed-by: Jack Pham <jack.pham@oss.qualcomm.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/ps883x.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index ad59babf7cce..68f172df7be3 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -54,8 +54,9 @@ struct ps883x_retimer {
>  	struct mutex lock; /* protect non-concurrent retimer & switch */
>  
>  	enum typec_orientation orientation;
> -	unsigned long mode;
> -	unsigned int svid;
> +	u8 cfg0;
> +	u8 cfg1;
> +	u8 cfg2;
>  };
>  
>  static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
> @@ -64,6 +65,9 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
>  	struct device *dev = &retimer->client->dev;
>  	int ret;
>  
> +	if (retimer->cfg0 == cfg0 && retimer->cfg1 == cfg1 && retimer->cfg2 == cfg2)
> +		return 0;
> +
>  	ret = regmap_write(retimer->regmap, REG_USB_PORT_CONN_STATUS_0, cfg0);
>  	if (ret) {
>  		dev_err(dev, "failed to write conn_status_0: %d\n", ret);
> @@ -82,27 +86,31 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
>  		return ret;
>  	}
>  
> +	retimer->cfg0 = cfg0;
> +	retimer->cfg1 = cfg1;
> +	retimer->cfg2 = cfg2;
> +
>  	return 0;
>  }
>  
> -static int ps883x_set(struct ps883x_retimer *retimer)
> +static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state *state)
>  {
>  	int cfg0 = CONN_STATUS_0_CONNECTION_PRESENT;
>  	int cfg1 = 0x00;
>  	int cfg2 = 0x00;
>  
>  	if (retimer->orientation == TYPEC_ORIENTATION_NONE ||
> -	    retimer->mode == TYPEC_STATE_SAFE) {
> +	    state->mode == TYPEC_STATE_SAFE) {
>  		return ps883x_configure(retimer, cfg0, cfg1, cfg2);
>  	}
>  
> -	if (retimer->mode != TYPEC_STATE_USB && retimer->svid != USB_TYPEC_DP_SID)
> +	if (state->alt && state->alt->svid != USB_TYPEC_DP_SID)
>  		return -EINVAL;
>  
>  	if (retimer->orientation == TYPEC_ORIENTATION_REVERSE)
>  		cfg0 |= CONN_STATUS_0_ORIENTATION_REVERSED;
>  
> -	switch (retimer->mode) {
> +	switch (state->mode) {
>  	case TYPEC_STATE_USB:
>  		cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
>  		break;
> @@ -149,7 +157,13 @@ static int ps883x_sw_set(struct typec_switch_dev *sw,
>  	if (retimer->orientation != orientation) {
>  		retimer->orientation = orientation;
>  
> -		ret = ps883x_set(retimer);
> +		ret = regmap_assign_bits(retimer->regmap, REG_USB_PORT_CONN_STATUS_0,
> +					 CONN_STATUS_0_ORIENTATION_REVERSED,
> +					 orientation == TYPEC_ORIENTATION_REVERSE);
> +		if (ret) {
> +			dev_err(&retimer->client->dev, "failed to set orientation: %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	mutex_unlock(&retimer->lock);
> @@ -165,18 +179,7 @@ static int ps883x_retimer_set(struct typec_retimer *rtmr,
>  	int ret = 0;
>  
>  	mutex_lock(&retimer->lock);
> -
> -	if (state->mode != retimer->mode) {
> -		retimer->mode = state->mode;
> -
> -		if (state->alt)
> -			retimer->svid = state->alt->svid;
> -		else
> -			retimer->svid = 0;
> -
> -		ret = ps883x_set(retimer);
> -	}
> -
> +	ret = ps883x_set(retimer, state);
>  	mutex_unlock(&retimer->lock);
>  
>  	if (ret)
> 
> -- 
> 2.51.0

-- 
heikki

