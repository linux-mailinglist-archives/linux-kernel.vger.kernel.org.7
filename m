Return-Path: <linux-kernel+bounces-862604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF1FBF5B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1E264FA8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8894A2877ED;
	Tue, 21 Oct 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cABm1VCQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B72E2F03;
	Tue, 21 Oct 2025 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041657; cv=none; b=sEiW1y0qGunPXKFkK4uI/K8CeEd4vi6vghezJDN2Fy/unL1WcWaj4x7jV9tNAbC02T4HHNfqSDUlC6CxwRZ3WeJGVn581qRZWATOqR5BrDTw84NkGqhnYzvp+JvzZ59b6Ppd/+PFVlzRvXj9xtdQsB5oX3E/lzJn+rmuc5P8qPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041657; c=relaxed/simple;
	bh=7G9wh+3pYjtmqhznpuhg/4zeG4jNF6FIdeVPDV76n9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyVASXxhA+KDEDP2+1DfOwgMXtpXOCtvY/4MY6MOfkthU2yOUnwzsPbjf6eYK/bwyXRJBDujKGv8IYqzyVSkdc2bGbFMXpiBrxEg2VAEpcXcOnvi88t+iuBJQQpjOnHZQUB4wVlMWnOxoLqcv9/wW4LIw1U5GPYijwElpkqRhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cABm1VCQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761041656; x=1792577656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7G9wh+3pYjtmqhznpuhg/4zeG4jNF6FIdeVPDV76n9A=;
  b=cABm1VCQZA1ORBJxjsSb2kUZcUFbpT5cVFTa+Mvda8DvxHfkb3GYPl/b
   d3wD+YYx3y8GfPQSKcILdD2lt8QIjv3rt+EUVwvCr3e+4wMFWOXUrgpGG
   KjBZ6r1cDl5K0gAXonI7gMRsNKefYI6EE41qkiNuk7dDSBP8+7xsgWql1
   ooXHuBOXPNIfHciFA8HkdEFUnoY6IdnQ3y2dLmR/u3e2PbAyDjoxLz3Qy
   /szirDSECuww3X3BkYZRQi2SlkeEsxEGW8fUviZoLEY1zB3+qSAkPG34I
   W5xOOX7EpYd429RGvXqVhGyt/kbVkpsS9NK8DLBAW+sp42YWnnvsCEeol
   w==;
X-CSE-ConnectionGUID: 410yUsDFSFykXVN1MiXJHA==
X-CSE-MsgGUID: ptc+hNrDSX+8S/HYekdELQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62372422"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="62372422"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 03:14:15 -0700
X-CSE-ConnectionGUID: vKdFSoyXTSCm5jBMmk1PvA==
X-CSE-MsgGUID: vCmLMOb8QVe0urxPVPyQug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="183262245"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.224])
  by fmviesa007.fm.intel.com with SMTP; 21 Oct 2025 03:14:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Oct 2025 13:14:11 +0300
Date: Tue, 21 Oct 2025 13:14:11 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] usb: typec: ucsi: Add support for orientation
Message-ID: <aPdc808hqRH73cjg@kuha.fi.intel.com>
References: <20251015-usb-typec-ucsi-orientation-v1-1-18cd109fb0b7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-usb-typec-ucsi-orientation-v1-1-18cd109fb0b7@linaro.org>

On Wed, Oct 15, 2025 at 04:50:36PM +0300, Abel Vesa wrote:
> According to UCSI 2.0 specification, the orientation is
> part of the connector status payload. So tie up the port
> orientation.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

RFC or not, this looks ok to me.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 24 ++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  3 +++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 3995483a0aa097b822046e819f994164d6183b0d..17439ec434d41d24e8e4c7a97d7e6117fd07d950 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1008,6 +1008,28 @@ static int ucsi_check_connector_capability(struct ucsi_connector *con)
>  	return ret;
>  }
>  
> +static void ucsi_orientation(struct ucsi_connector *con)
> +{
> +	if (con->ucsi->version < UCSI_VERSION_2_0)
> +		return;
> +
> +	if (!UCSI_CONSTAT(con, CONNECTED)) {
> +		typec_set_orientation(con->port, TYPEC_ORIENTATION_NONE);
> +		return;
> +	}
> +
> +	switch (UCSI_CONSTAT(con, ORIENTATION)) {
> +	case UCSI_CONSTAT_ORIENTATION_NORMAL:
> +		typec_set_orientation(con->port, TYPEC_ORIENTATION_NORMAL);
> +		break;
> +	case UCSI_CONSTAT_ORIENTATION_REVERSE:
> +		typec_set_orientation(con->port, TYPEC_ORIENTATION_REVERSE);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
>  {
>  	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
> @@ -1258,6 +1280,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  		typec_set_pwr_role(con->port, role);
>  		ucsi_port_psy_changed(con);
>  		ucsi_partner_change(con);
> +		ucsi_orientation(con);
>  
>  		if (UCSI_CONSTAT(con, CONNECTED)) {
>  			ucsi_register_partner(con);
> @@ -1690,6 +1713,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  		typec_set_pwr_role(con->port, UCSI_CONSTAT(con, PWR_DIR));
>  		ucsi_register_partner(con);
>  		ucsi_pwr_opmode_change(con);
> +		ucsi_orientation(con);
>  		ucsi_port_psy_changed(con);
>  		if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
>  			ucsi_get_partner_identity(con);
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index e301d9012936fb85eaff7f260a862ff099eb77c5..c85175cd001487fa9d66076e608e098d236f5275 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -360,6 +360,9 @@ struct ucsi_cable_property {
>  #define   UCSI_CONSTAT_BC_SLOW_CHARGING		2
>  #define   UCSI_CONSTAT_BC_TRICKLE_CHARGING	3
>  #define UCSI_CONSTAT_PD_VERSION_V1_2		UCSI_DECLARE_BITFIELD_V1_2(70, 16)
> +#define UCSI_CONSTAT_ORIENTATION		UCSI_DECLARE_BITFIELD_V2_0(86, 1)
> +#define   UCSI_CONSTAT_ORIENTATION_NORMAL	0
> +#define   UCSI_CONSTAT_ORIENTATION_REVERSE	1
>  #define UCSI_CONSTAT_PWR_READING_READY_V2_1	UCSI_DECLARE_BITFIELD_V2_1(89, 1)
>  #define UCSI_CONSTAT_CURRENT_SCALE_V2_1		UCSI_DECLARE_BITFIELD_V2_1(90, 3)
>  #define UCSI_CONSTAT_PEAK_CURRENT_V2_1		UCSI_DECLARE_BITFIELD_V2_1(93, 16)
> 
> ---
> base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
> change-id: 20251015-usb-typec-ucsi-orientation-75ed0a2c9ff3
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>

-- 
heikki

