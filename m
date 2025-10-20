Return-Path: <linux-kernel+bounces-860519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAACBF04FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E80018A02DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1250E2F291A;
	Mon, 20 Oct 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/lZFgN4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669EE2D9795;
	Mon, 20 Oct 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953804; cv=none; b=U/cH3+yHvVe7Xund8uNR4JYTXEApf1MtekrSwyOv540OkNbq4RpKSkhKuyLyTpV0K8OzQ1BO+/qFpdTdYhAjETS71YKi4K2ei8/kjCWqeuZ1SjPhtlsGAgdGwrg9tiLw2rIbcnYyMQGYdun/FMTRZ1st1Z4RaBDE9e2QLEMbUc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953804; c=relaxed/simple;
	bh=fa3VNUjm5V+YGeMPh0BJjulfz9KSAO20RwqiqeZmk50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMWNccxmze3P1FbUPOozce3naUmrG/UIdWqGdJZhkbVCMvxv6pzYs30jJWvWOR/sMo+yaaTj8WCwCUT7p5qkbQxoHOi8mJQg33Ubri1jPSrKxbQc99pPGRZdkcgJoYJTh1db2eeNI8uf0kauZ3mdvkmuVhcGQB9DiU8nFp+VCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/lZFgN4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760953802; x=1792489802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fa3VNUjm5V+YGeMPh0BJjulfz9KSAO20RwqiqeZmk50=;
  b=R/lZFgN4D4Co5gWLnJh7jqwrY5gKrzQ2Fy751g2igVjPKhaW1PZNw5Qy
   u3h9boUa94M9lGIMrgcqaS98xIEniJYjwy4C+XtgZlFwiVxxSmTsveOsm
   hnRPtUMT6bd190Cvr+OnPVYSmLAP6N6HwlkychvOH2tLf0UFFusg6lun8
   NkHc2ycjCZnxhv63NItCXs4siHX4oFYGl4A9J2lSBTwoHk2Xpkas19wog
   +eNftRPpK75I0bbGXNaZoD8lOF5EMxvgIOuXCIsYEA1IouJa9pBBLQtjU
   tKxYC9dHgu8PLLq6PY7HairSb+UpQ8Fg8hU/bnf4sI6UbziV+DIQiAhYZ
   Q==;
X-CSE-ConnectionGUID: Ofyz30ZHQLqhR0XQiuJV5g==
X-CSE-MsgGUID: JDfwpm6BQQ+FzfiQ+/46PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62985299"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62985299"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 02:50:02 -0700
X-CSE-ConnectionGUID: woi3yM4DR3Wk6cSjn9EVpA==
X-CSE-MsgGUID: WBScl/r4STW8LzMLC83pGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183239412"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.112])
  by fmviesa006.fm.intel.com with SMTP; 20 Oct 2025 02:49:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Oct 2025 12:49:57 +0300
Date: Mon, 20 Oct 2025 12:49:56 +0300
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
Subject: Re: [PATCH 3/3] usb: typec: ps883x: Add USB4 mode and TBT3 altmode
 support
Message-ID: <aPYFxF8fRhkQcv06@kuha.fi.intel.com>
References: <20251014-topic-ps883x_usb4-v1-0-e6adb1a4296e@oss.qualcomm.com>
 <20251014-topic-ps883x_usb4-v1-3-e6adb1a4296e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-topic-ps883x_usb4-v1-3-e6adb1a4296e@oss.qualcomm.com>

On Tue, Oct 14, 2025 at 06:06:47PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This chip can do some more than the driver currently describes. Add
> support for configuring it for various flavors of TBT3/USB4 operation.
> 
> Reviewed-by: Jack Pham <jack.pham@oss.qualcomm.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/ps883x.c | 29 +++++++++++++++++++++++++++++
>  include/linux/usb/typec_tbt.h  |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index 72f1e737ca4b..7c61629b36d6 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -14,15 +14,18 @@
>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/usb/pd.h>
>  #include <linux/usb/typec_altmode.h>
>  #include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_mux.h>
>  #include <linux/usb/typec_retimer.h>
> +#include <linux/usb/typec_tbt.h>
>  
>  #define REG_USB_PORT_CONN_STATUS_0		0x00
>  
>  #define CONN_STATUS_0_CONNECTION_PRESENT	BIT(0)
>  #define CONN_STATUS_0_ORIENTATION_REVERSED	BIT(1)
> +#define CONN_STATUS_0_ACTIVE_CABLE		BIT(2)
>  #define CONN_STATUS_0_USB_3_1_CONNECTED		BIT(5)
>  
>  #define REG_USB_PORT_CONN_STATUS_1		0x01
> @@ -34,6 +37,10 @@
>  
>  #define REG_USB_PORT_CONN_STATUS_2		0x02
>  
> +#define CONN_STATUS_2_TBT_CONNECTED		BIT(0)
> +#define CONN_STATUS_2_TBT_UNIDIR_LSRX_ACT_LT	BIT(4)
> +#define CONN_STATUS_2_USB4_CONNECTED		BIT(7)
> +
>  struct ps883x_retimer {
>  	struct i2c_client *client;
>  	struct gpio_desc *reset_gpio;
> @@ -95,6 +102,8 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
>  
>  static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state *state)
>  {
> +	struct typec_thunderbolt_data *tb_data;
> +	const struct enter_usb_data *eudo_data;
>  	int cfg0 = CONN_STATUS_0_CONNECTION_PRESENT;
>  	int cfg1 = 0x00;
>  	int cfg2 = 0x00;
> @@ -120,6 +129,18 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
>  				break;
>  			}
>  			break;
> +		case USB_TYPEC_TBT_SID:
> +			tb_data = state->data;
> +
> +			/* Unconditional */
> +			cfg2 |= CONN_STATUS_2_TBT_CONNECTED;
> +
> +			if (tb_data->cable_mode & TBT_CABLE_ACTIVE_PASSIVE)
> +				cfg0 |= CONN_STATUS_0_ACTIVE_CABLE;
> +
> +			if (tb_data->enter_vdo & TBT_ENTER_MODE_UNI_DIR_LSRX)
> +				cfg2 |= CONN_STATUS_2_TBT_UNIDIR_LSRX_ACT_LT;
> +			break;
>  		default:
>  			dev_err(&retimer->client->dev, "Got unsupported SID: 0x%x\n",
>  				state->alt->svid);
> @@ -135,6 +156,14 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
>  		case TYPEC_MODE_USB3:
>  			cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
>  			break;
> +		case TYPEC_MODE_USB4:
> +			eudo_data = state->data;
> +
> +			cfg2 |= CONN_STATUS_2_USB4_CONNECTED;
> +
> +			if (FIELD_GET(EUDO_CABLE_TYPE_MASK, eudo_data->eudo) != EUDO_CABLE_TYPE_PASSIVE)
> +				cfg0 |= CONN_STATUS_0_ACTIVE_CABLE;
> +			break;
>  		default:
>  			dev_err(&retimer->client->dev, "Got unsupported mode: %lu\n",
>  				state->mode);
> diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
> index 55dcea12082c..0b570f1b8bc8 100644
> --- a/include/linux/usb/typec_tbt.h
> +++ b/include/linux/usb/typec_tbt.h
> @@ -55,6 +55,7 @@ struct typec_thunderbolt_data {
>  
>  /* TBT3 Device Enter Mode VDO bits */
>  #define TBT_ENTER_MODE_CABLE_SPEED(s)	TBT_SET_CABLE_SPEED(s)
> +#define TBT_ENTER_MODE_UNI_DIR_LSRX	BIT(23)
>  #define TBT_ENTER_MODE_ACTIVE_CABLE	BIT(24)
>  
>  #endif /* __USB_TYPEC_TBT_H */
> 
> -- 
> 2.51.0

-- 
heikki

