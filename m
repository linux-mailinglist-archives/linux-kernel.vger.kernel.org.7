Return-Path: <linux-kernel+bounces-860517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D8BF04E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594FF189B8BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD42ECE95;
	Mon, 20 Oct 2025 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KORLSnZG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0C239E79;
	Mon, 20 Oct 2025 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953774; cv=none; b=oxG6kg/JXktLee5tiAghqA55e8cUDMY6akR3Wc5cnQjks38N52VyQtzLEP0savNS4yfmyAWZTdIE6f0WmX8BILKiJm6PVEpzSrWuyTt6DPDHqN+4oHVRgBY7w2tZDOrjKihb9D7iSj0qVH0QwxuMWKLlqF/nZRpN0C7RHOrk4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953774; c=relaxed/simple;
	bh=IFMa8J4BmSP1xDkcLMdkDieSTWmOeb/WK7h22yGsHts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOOiva6SpTVTLFed5tTajOkZFTbZP/u+4FYAVPUXpwvnV9VZhk3yrJN22c34DNQ2PVUD9WVw+s6r1KUSha2VFJnPmFr1LekDRey/RxAF+Rs0X+vJTsdnehaXJl9QLnApooFNQXPkXEH4oS0gPXGR8X/QgnvFNbaqQBNC/ZeZoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KORLSnZG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760953772; x=1792489772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IFMa8J4BmSP1xDkcLMdkDieSTWmOeb/WK7h22yGsHts=;
  b=KORLSnZGIHs/aUjBMUVjZI6mMYdQ6MqnT2i/JYRF8gfRqITtpYCYztp4
   h4MoN8BU/TMMRMU7GfoMa3Y9JNwF62tAPN9BlxxGAW0ynDvzhyjn/HdQv
   +8ErzMTxXfhL9zWi6y7FXjupaT8E03NOFYC+yMQ0kv6E0oib/UKyTF+/H
   BfSR0FcEy9hb3O8mGkVJCPVphU6PalH9LNydkvLiKMj5qhAAX4ZTe9mfQ
   fshDiqlUCmN9wOgxqpEu24g/tUxH2fpRgXZV9uE2hlKlwfGBnnnCoBGDS
   CTPwChY0cYjjqOXVqp2aqI15za5n/0CvCp3uPmYmzmy4Pu+YQO5iASPgt
   g==;
X-CSE-ConnectionGUID: Vr6vVxNnTF2CMIZGdrvjHg==
X-CSE-MsgGUID: oCb6J91jQKuiWrAJHYWGQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="80506113"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="80506113"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 02:49:32 -0700
X-CSE-ConnectionGUID: EWWHbbtLR2+5nMBBpCh4PQ==
X-CSE-MsgGUID: UML7sHo4Qk2dcuXbG7eECQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="188581319"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.112])
  by fmviesa004.fm.intel.com with SMTP; 20 Oct 2025 02:49:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Oct 2025 12:49:27 +0300
Date: Mon, 20 Oct 2025 12:49:27 +0300
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
Subject: Re: [PATCH 2/3] usb: typec: ps883x: Rework ps883x_set()
Message-ID: <aPYFpzD6sklAvywa@kuha.fi.intel.com>
References: <20251014-topic-ps883x_usb4-v1-0-e6adb1a4296e@oss.qualcomm.com>
 <20251014-topic-ps883x_usb4-v1-2-e6adb1a4296e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-topic-ps883x_usb4-v1-2-e6adb1a4296e@oss.qualcomm.com>

On Tue, Oct 14, 2025 at 06:06:46PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> In preparation to extend it with new alt/USB modes, rework the code a
> bit by changing the flow into a pair of switch statements.
> 
> Reviewed-by: Jack Pham <jack.pham@oss.qualcomm.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/ps883x.c | 71 ++++++++++++++++++++++--------------------
>  1 file changed, 37 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index 68f172df7be3..72f1e737ca4b 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -99,44 +99,47 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
>  	int cfg1 = 0x00;
>  	int cfg2 = 0x00;
>  
> -	if (retimer->orientation == TYPEC_ORIENTATION_NONE ||
> -	    state->mode == TYPEC_STATE_SAFE) {
> -		return ps883x_configure(retimer, cfg0, cfg1, cfg2);
> -	}
> -
> -	if (state->alt && state->alt->svid != USB_TYPEC_DP_SID)
> -		return -EINVAL;
> -
>  	if (retimer->orientation == TYPEC_ORIENTATION_REVERSE)
>  		cfg0 |= CONN_STATUS_0_ORIENTATION_REVERSED;
>  
> -	switch (state->mode) {
> -	case TYPEC_STATE_USB:
> -		cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
> -		break;
> +	if (state->alt) {
> +		switch (state->alt->svid) {
> +		case USB_TYPEC_DP_SID:
> +			cfg1 |= CONN_STATUS_1_DP_CONNECTED |
> +				CONN_STATUS_1_DP_HPD_LEVEL;
>  
> -	case TYPEC_DP_STATE_C:
> -		cfg1 = CONN_STATUS_1_DP_CONNECTED |
> -		       CONN_STATUS_1_DP_SINK_REQUESTED |
> -		       CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D |
> -		       CONN_STATUS_1_DP_HPD_LEVEL;
> -		break;
> -
> -	case TYPEC_DP_STATE_D:
> -		cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
> -		cfg1 = CONN_STATUS_1_DP_CONNECTED |
> -		       CONN_STATUS_1_DP_SINK_REQUESTED |
> -		       CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D |
> -		       CONN_STATUS_1_DP_HPD_LEVEL;
> -		break;
> -
> -	case TYPEC_DP_STATE_E:
> -		cfg1 = CONN_STATUS_1_DP_CONNECTED |
> -		       CONN_STATUS_1_DP_HPD_LEVEL;
> -		break;
> -
> -	default:
> -		return -EOPNOTSUPP;
> +			switch (state->mode)  {
> +			case TYPEC_DP_STATE_C:
> +				cfg1 |= CONN_STATUS_1_DP_SINK_REQUESTED |
> +					CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D;
> +				fallthrough;
> +			case TYPEC_DP_STATE_D:
> +				cfg1 |= CONN_STATUS_0_USB_3_1_CONNECTED;
> +				break;
> +			default: /* MODE_E */
> +				break;
> +			}
> +			break;
> +		default:
> +			dev_err(&retimer->client->dev, "Got unsupported SID: 0x%x\n",
> +				state->alt->svid);
> +			return -EOPNOTSUPP;
> +		}
> +	} else {
> +		switch (state->mode) {
> +		case TYPEC_STATE_SAFE:
> +		/* USB2 pins don't even go through this chip */
> +		case TYPEC_MODE_USB2:
> +			break;
> +		case TYPEC_STATE_USB:
> +		case TYPEC_MODE_USB3:
> +			cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
> +			break;
> +		default:
> +			dev_err(&retimer->client->dev, "Got unsupported mode: %lu\n",
> +				state->mode);
> +			return -EOPNOTSUPP;
> +		}
>  	}
>  
>  	return ps883x_configure(retimer, cfg0, cfg1, cfg2);
> 
> -- 
> 2.51.0

-- 
heikki

