Return-Path: <linux-kernel+bounces-845307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D11FBC4538
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF92189FE23
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB11F2F5A1C;
	Wed,  8 Oct 2025 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOKCoRhJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27471D7E41;
	Wed,  8 Oct 2025 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919553; cv=none; b=WdHLxDEmp1cs9I/3o2+cBNRpJlH7+PiG/g9UeshnyI1APtHPRk6zAvyvI1YADkjem7jqNTvNNl+AuL9fESFf/zcZx+uavvKwqJvXAPIJvlEDAvnIaMGD5Uit9Qh2oT7sctbn0WtrFkzFbm/aJl666Le04eq7Y49XK838SzHIiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919553; c=relaxed/simple;
	bh=mpJCJRmqq7qLlxk4UiGEW5X5iwP6YOqYIuZ48aIO4q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCCVWJWqcV3LSCwoyzeeSICgWnpHxQYkEBCF+JITi7698Pd4AIStyBgQqWOHLDoKd5ODjL+MGhwO+/2snVolRGimE7n+nspjxZSEOcnlhLpCUComLkyLnPDZ42vbjQjlaCsSssDD0PhCx3sKl97AK65d4WnBpaT9/U8/B1OAW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOKCoRhJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759919550; x=1791455550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mpJCJRmqq7qLlxk4UiGEW5X5iwP6YOqYIuZ48aIO4q8=;
  b=gOKCoRhJHGQW735mW+blQjla0ynUKUQgVo2KOpQm34xecoMaGVeaYFFH
   VGpNK2pHveyy3lwDZTgiu+isH7NF5XRHveMeCoOJJ6zbloNk5iudVZg9q
   9M1yS/v5mvBGZkwCxrnsfTX4n9HgW2IA0/BXBZgbuHoumptm0855M2x9M
   DjxRr7dr5atGojgXMyNxbf8Xvlq6HH+Cd7wSUBT+QCB7X+sfjtweg6cB9
   0GCFrt/HshujV1PkVHIhgB3DBYzZ2Oz4NpZF/17uwwlmuachn1ATjKcrm
   /wZjO0tTGtzZ8f3kg8iMDJW1NCfuVfr12HJuMkQW+TBKV0Y2eNGJCYsuG
   w==;
X-CSE-ConnectionGUID: Wntt9tKdT8CtnLUp0v43Ug==
X-CSE-MsgGUID: GvalrHyLR3mVX2mVQrSLrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="79544713"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="79544713"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 03:32:30 -0700
X-CSE-ConnectionGUID: Cm7dSnEPQ96+ZUiAYYydhA==
X-CSE-MsgGUID: bGjmKLv0QpycyeA3pBOf1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="179652095"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by orviesa010.jf.intel.com with SMTP; 08 Oct 2025 03:32:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 13:32:26 +0300
Date: Wed, 8 Oct 2025 13:32:26 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: gregkh@linuxfoundation.org, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: typec: class: add typec_get_data_role symbol
Message-ID: <aOY9uk3waQH8wJKr@kuha.fi.intel.com>
References: <20250923181606.1583584-4-rdbabiera@google.com>
 <20250923181606.1583584-5-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923181606.1583584-5-rdbabiera@google.com>

On Tue, Sep 23, 2025 at 06:16:07PM +0000, RD Babiera wrote:
> Alt Mode drivers are responsible for sending Enter Mode through the TCPM,
> but only a DFP is allowed to send Enter Mode. typec_get_data_role gets
> the port's data role, which can then be used in altmode drivers via
> typec_altmode_get_data_role to know if Enter Mode should be sent.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes from v1:
> * changed typec_altmode_get_data_role documentation format
> ---
>  drivers/usb/typec/class.c         | 13 +++++++++++++
>  include/linux/usb/typec.h         |  1 +
>  include/linux/usb/typec_altmode.h | 13 +++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 67a533e35150..9b2647cb199b 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -2120,6 +2120,19 @@ void typec_set_data_role(struct typec_port *port, enum typec_data_role role)
>  }
>  EXPORT_SYMBOL_GPL(typec_set_data_role);
>  
> +/**
> + * typec_get_data_role - Get port data role
> + * @port: The USB Type-C Port to query
> + *
> + * This routine is used by the altmode drivers to determine if the port is the
> + * DFP before issuing Enter Mode
> + */
> +enum typec_data_role typec_get_data_role(struct typec_port *port)
> +{
> +	return port->data_role;
> +}
> +EXPORT_SYMBOL_GPL(typec_get_data_role);
> +
>  /**
>   * typec_set_pwr_role - Report power role change
>   * @port: The USB Type-C Port where the role was changed
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 252af3f77039..309251572e2e 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -337,6 +337,7 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
>  void typec_unregister_plug(struct typec_plug *plug);
>  
>  void typec_set_data_role(struct typec_port *port, enum typec_data_role role);
> +enum typec_data_role typec_get_data_role(struct typec_port *port);
>  void typec_set_pwr_role(struct typec_port *port, enum typec_role role);
>  void typec_set_vconn_role(struct typec_port *port, enum typec_role role);
>  void typec_set_pwr_opmode(struct typec_port *port, enum typec_pwr_opmode mode);
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index b3c0866ea70f..f7db3bd4c90e 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -172,6 +172,19 @@ typec_altmode_get_svdm_version(struct typec_altmode *altmode)
>  	return typec_get_negotiated_svdm_version(typec_altmode2port(altmode));
>  }
>  
> +/**
> + * typec_altmode_get_data_role - Get port data role
> + * @altmode: Handle to the alternate mode
> + *
> + * Alt Mode drivers should only issue Enter Mode through the port if they are
> + * the DFP.
> + */
> +static inline enum typec_data_role
> +typec_altmode_get_data_role(struct typec_altmode *altmode)
> +{
> +	return typec_get_data_role(typec_altmode2port(altmode));
> +}
> +
>  /**
>   * struct typec_altmode_driver - USB Type-C alternate mode device driver
>   * @id_table: Null terminated array of SVIDs
> -- 
> 2.51.0.534.gc79095c0ca-goog

-- 
heikki

