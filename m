Return-Path: <linux-kernel+bounces-860522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 344EABF050E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC61834ADE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34042D593D;
	Mon, 20 Oct 2025 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqQ7G6Cv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A623D29A;
	Mon, 20 Oct 2025 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953884; cv=none; b=t6U94kitmkrcnxcoJpRH7q52Dw7iWAvsnP33Wy4A0rmXGcsYqiuXEFczMC77gzsGRUj+nTSE4zQjydYbV/fucOSBnddVsxPYkEMmdYyU2x/MgY8LZlP00tU0iKEcR3lDfEoSmFZyU9Gb6ADck/gcNlOGHytM1Rv+EP3+aME4GaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953884; c=relaxed/simple;
	bh=fXHOT9Qt7BLc0k0x5i94Cl6ngLWjCwQDKoli5qGtDJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLcZtXZTfB5m0m0dxGibXfXtR23KjgYPM+H3Gs3XDxHXZM6c0m965+4TQJS92voOdRtGCep7A4MREzvgd/DXSMnzbUPiCW66kU6wRPoosD800i7BL9s6katRdlCzKB6wamtNDaS5aCgewPx3Se21wKvtzwVYgnuwKMpwtz1nb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqQ7G6Cv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760953883; x=1792489883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fXHOT9Qt7BLc0k0x5i94Cl6ngLWjCwQDKoli5qGtDJQ=;
  b=JqQ7G6Cvu622MYK+0iKh+W3BTb18l7s6Fd0sjN66WTZfwZ6fHzc9gNRt
   lgq7I9NRirgF5Sv8fozgUxDgt8gsNxDydhi9EWPyTiKpZ+kQhsqxS2/ca
   eXybC1mcs1BkLR7yyC2kWPFpAP3M/cDDtd7Iyn+QlAifZuqd3fect3r7J
   9ACSx+OBlWV29t98x3tW6C3r/p/dNz2wcP4dzPdNYSmxyQ7WoshuyA6sB
   iwxVn0HA55SlmXX+bQ1VqUQi+JAE2QPxFkzxBNasxwDE95tRPXdPLV1cx
   igZt1TbU82YaRw+HMPnB2xmBL3A5Cewmvmb/WaLqaPsxx4x+pLUYwZ2/j
   Q==;
X-CSE-ConnectionGUID: c9K8qyGnRpCvDGM0V+LhqA==
X-CSE-MsgGUID: xn+PVhh9QSiJcpJSMJDOOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="66705344"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="66705344"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 02:51:22 -0700
X-CSE-ConnectionGUID: jTqJl2MHQ8KcRplnFPGg0A==
X-CSE-MsgGUID: Z029Y5DVQ9+uYF2+x43+/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183306858"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.112])
  by orviesa008.jf.intel.com with SMTP; 20 Oct 2025 02:51:18 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Oct 2025 12:51:17 +0300
Date: Mon, 20 Oct 2025 12:51:17 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: gregkh@linuxfoundation.org, amitsd@google.com, kyletso@google.com,
	rdbabiera@google.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tcpm: Parse and log AVS APDO
Message-ID: <aPYGFdrnJ0OHaEjp@kuha.fi.intel.com>
References: <20251015043017.3382908-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015043017.3382908-1-badhri@google.com>

On Wed, Oct 15, 2025 at 04:30:13AM +0000, Badhri Jagan Sridharan wrote:
> The USB PD specification introduced new Adjustable Voltage Supply (AVS)
> types for both Standard Power Range (SPR) and Extended Power Range (EPR)
> sources.
> 
> Add definitions to correctly parse and handle the new AVS APDO. Use
> bitfield macros to add inline helper functions to extract voltage,
> current, power, and peak current fields to parse and log the details
> of the new EPR AVS and SPR AVS APDO.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Kyle Tso <kyletso@google.com>
> Reviewed-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> * Fixed incorrrect squash.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 15 +++++++-
>  include/linux/usb/pd.h        | 69 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index b2a568a5bc9b..c65aa8104950 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -823,10 +823,23 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
>  		case PDO_TYPE_APDO:
>  			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
>  				scnprintf(msg, sizeof(msg),
> -					  "%u-%u mV, %u mA",
> +					  "PPS %u-%u mV, %u mA",
>  					  pdo_pps_apdo_min_voltage(pdo),
>  					  pdo_pps_apdo_max_voltage(pdo),
>  					  pdo_pps_apdo_max_current(pdo));
> +			else if (pdo_apdo_type(pdo) == APDO_TYPE_EPR_AVS)
> +				scnprintf(msg, sizeof(msg),
> +					  "EPR AVS %u-%u mV %u W peak_current: %u",
> +					  pdo_epr_avs_apdo_min_voltage_mv(pdo),
> +					  pdo_epr_avs_apdo_max_voltage_mv(pdo),
> +					  pdo_epr_avs_apdo_pdp_w(pdo),
> +					  pdo_epr_avs_apdo_src_peak_current(pdo));
> +			else if (pdo_apdo_type(pdo) == APDO_TYPE_SPR_AVS)
> +				scnprintf(msg, sizeof(msg),
> +					  "SPR AVS 9-15 V: %u mA 15-20 V: %u mA peak_current: %u",
> +					  pdo_spr_avs_apdo_9v_to_15v_max_current_ma(pdo),
> +					  pdo_spr_avs_apdo_15v_to_20v_max_current_ma(pdo),
> +					  pdo_spr_avs_apdo_src_peak_current(pdo));
>  			else
>  				strcpy(msg, "undefined APDO");
>  			break;
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 3068c3084eb6..6ccd1b2af993 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -6,6 +6,7 @@
>  #ifndef __LINUX_USB_PD_H
>  #define __LINUX_USB_PD_H
>  
> +#include <linux/bitfield.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/usb/typec.h>
> @@ -271,9 +272,11 @@ enum pd_pdo_type {
>  
>  enum pd_apdo_type {
>  	APDO_TYPE_PPS = 0,
> +	APDO_TYPE_EPR_AVS = 1,
> +	APDO_TYPE_SPR_AVS = 2,
>  };
>  
> -#define PDO_APDO_TYPE_SHIFT	28	/* Only valid value currently is 0x0 - PPS */
> +#define PDO_APDO_TYPE_SHIFT	28
>  #define PDO_APDO_TYPE_MASK	0x3
>  
>  #define PDO_APDO_TYPE(t)	((t) << PDO_APDO_TYPE_SHIFT)
> @@ -297,6 +300,35 @@ enum pd_apdo_type {
>  	PDO_PPS_APDO_MIN_VOLT(min_mv) | PDO_PPS_APDO_MAX_VOLT(max_mv) |	\
>  	PDO_PPS_APDO_MAX_CURR(max_ma))
>  
> +/*
> + * Applicable only to EPR AVS APDO source cap as per
> + * Table 6.15 EPR Adjustable Voltage Supply APDO – Source
> + */
> +#define PDO_EPR_AVS_APDO_PEAK_CURRENT	GENMASK(27, 26)
> +
> +/*
> + * Applicable to both EPR AVS APDO source and sink cap as per
> + * Table 6.15 EPR Adjustable Voltage Supply APDO – Source
> + * Table 6.22 EPR Adjustable Voltage Supply APDO – Sink
> + */
> +#define PDO_EPR_AVS_APDO_MAX_VOLT	GENMASK(25, 17)	/* 100mV unit */
> +#define PDO_EPR_AVS_APDO_MIN_VOLT	GENMASK(15, 8)	/* 100mV unit */
> +#define PDO_EPR_AVS_APDO_PDP		GENMASK(7, 0) /* 1W unit */
> +
> +/*
> + * Applicable only SPR AVS APDO source cap as per
> + * Table 6.14 SPR Adjustable Voltage Supply APDO – Source
> + */
> +#define PDO_SPR_AVS_APDO_PEAK_CURRENT		GENMASK(27, 26)
> +
> +/*
> + * Applicable to both SPR AVS APDO source and sink cap as per
> + * Table 6.14 SPR Adjustable Voltage Supply APDO – Source
> + * Table 6.21 SPR Adjustable Voltage Supply APDO – Sink
> + */
> +#define PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR	GENMASK(19, 10)	/* 10mA unit */
> +#define PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR	GENMASK(9, 0)	/* 10mA unit */
> +
>  static inline enum pd_pdo_type pdo_type(u32 pdo)
>  {
>  	return (pdo >> PDO_TYPE_SHIFT) & PDO_TYPE_MASK;
> @@ -350,6 +382,41 @@ static inline unsigned int pdo_pps_apdo_max_current(u32 pdo)
>  		PDO_PPS_APDO_CURR_MASK) * 50;
>  }
>  
> +static inline unsigned int pdo_epr_avs_apdo_src_peak_current(u32 pdo)
> +{
> +	return FIELD_GET(PDO_EPR_AVS_APDO_PEAK_CURRENT, pdo);
> +}
> +
> +static inline unsigned int pdo_epr_avs_apdo_min_voltage_mv(u32 pdo)
> +{
> +	return FIELD_GET(PDO_EPR_AVS_APDO_MIN_VOLT, pdo) * 100;
> +}
> +
> +static inline unsigned int pdo_epr_avs_apdo_max_voltage_mv(u32 pdo)
> +{
> +	return FIELD_GET(PDO_EPR_AVS_APDO_MIN_VOLT, pdo) * 100;
> +}
> +
> +static inline unsigned int pdo_epr_avs_apdo_pdp_w(u32 pdo)
> +{
> +	return FIELD_GET(PDO_EPR_AVS_APDO_PDP, pdo);
> +}
> +
> +static inline unsigned int pdo_spr_avs_apdo_src_peak_current(u32 pdo)
> +{
> +	return FIELD_GET(PDO_SPR_AVS_APDO_PEAK_CURRENT, pdo);
> +}
> +
> +static inline unsigned int pdo_spr_avs_apdo_9v_to_15v_max_current_ma(u32 pdo)
> +{
> +	return FIELD_GET(PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR, pdo) * 10;
> +}
> +
> +static inline unsigned int pdo_spr_avs_apdo_15v_to_20v_max_current_ma(u32 pdo)
> +{
> +	return FIELD_GET(PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR, pdo) * 10;
> +}
> +
>  /* RDO: Request Data Object */
>  #define RDO_OBJ_POS_SHIFT	28
>  #define RDO_OBJ_POS_MASK	0x7
> 
> base-commit: 877c80dfbf788e57a3338627899033b7007037ee
> -- 
> 2.51.0.858.gf9c4a03a3a-goog

-- 
heikki

