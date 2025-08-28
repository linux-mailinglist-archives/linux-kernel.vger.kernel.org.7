Return-Path: <linux-kernel+bounces-789649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039D2B398A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91209987392
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B132E2295;
	Thu, 28 Aug 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgeicMyP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D8277C85;
	Thu, 28 Aug 2025 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374242; cv=none; b=mzMkOm+uKb74DZqMogzwdIUrPQ2a/ywuqr15WsP1/4iB42jeCXRjo8EKV6DjDK56D8wzvOby+VrAE5vTaGmwT7/ALEGaPg7sVfuQyTa2Wid3MO5t9RKS+zuuusiMNCap7mwR6Ji0vr0Pe7fJw0K7BVt7ujHoZkCu5pAxVXPMJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374242; c=relaxed/simple;
	bh=HffZ3rnLNcupsAjrlSDPYdJVw5yH4MPfwql68TJ5bCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euUegjnoEpSUi+IHbwnxhEmOTMcZFj4g52KVf65vFqLxuhVjmZu4WwjEEDXdUgzprEkZl70crfwY8ARzavNcZ7IH2tbTNh1Ro3Ksf9+XP0OasX+YS+R40j/dOYB481IwlDYGmfhIMdYvx+OdA8xecdtrO9FsokPO/y7lg8Ks6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgeicMyP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756374241; x=1787910241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HffZ3rnLNcupsAjrlSDPYdJVw5yH4MPfwql68TJ5bCo=;
  b=JgeicMyPTksyA5tI3JkLvjHa9i3YQeNFtC58500Kd6ApeAp7+7TmyWpB
   OPhsHkveNcg/xEPexFuoOBn6bbRYndVKp7l8txxcPS3gcdBcBGsSND/qd
   wnGG1pTP6ZQClyD9+D+lyetnqye9Lc5bNdPV8BRgL31sBCpgm8pk3Fh9C
   qEcEnfN7TkREiKh6qiXm6mp/V8NpDF+nYsfcW2iJLze8tauU65/vQCKGG
   JRxMoLIKisMIReUKcePxTvDAr5bAApMQj+WfNQwzIrCf18/ymdpd14uj4
   KLf8o+07XRIVr2EqQ+IO/abk4nfc9eyu8jv174Zyfh78p9968EeQA5jRN
   g==;
X-CSE-ConnectionGUID: bt3cHTdyQuuaKzUEv+ksiQ==
X-CSE-MsgGUID: UFAI9aWvRhOP3JBzSlgBnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70079996"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70079996"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 02:44:00 -0700
X-CSE-ConnectionGUID: B45B30emQTqoA5e2CL/7Zg==
X-CSE-MsgGUID: 3UpS4AUIQoS7nsbnrvHrtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207213589"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa001.jf.intel.com with SMTP; 28 Aug 2025 02:43:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 28 Aug 2025 12:43:56 +0300
Date: Thu, 28 Aug 2025 12:43:56 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: gregkh@linuxfoundation.org, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] usb: typec: class: add typec_get_data_role symbol
Message-ID: <aLAk3MJuso1w4Kkl@kuha.fi.intel.com>
References: <20250821203838.1721581-4-rdbabiera@google.com>
 <20250821203838.1721581-5-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821203838.1721581-5-rdbabiera@google.com>

On Thu, Aug 21, 2025 at 08:38:34PM +0000, RD Babiera wrote:
> Alt Mode drivers are responsible for sending Enter Mode through the TCPM,
> but only a DFP is allowed to send Enter Mode. typec_get_data_role gets
> the port's data role, which can then be used in altmode drivers via
> typec_altmode_get_data_role to know if Enter Mode should be sent.

The functions are okay by me, but is the above statement correct?
Are you mixing power role and data role?

> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
>  drivers/usb/typec/class.c         | 13 +++++++++++++
>  include/linux/usb/typec.h         |  1 +
>  include/linux/usb/typec_altmode.h | 12 ++++++++++++
>  3 files changed, 26 insertions(+)
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
> index b3c0866ea70f..559cd6865ba1 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -172,6 +172,18 @@ typec_altmode_get_svdm_version(struct typec_altmode *altmode)
>  	return typec_get_negotiated_svdm_version(typec_altmode2port(altmode));
>  }
>  
> +/**
> + * typec_altmode_get_data_role - Get port data role. Alt Mode drivers should only
> + * issue Enter Mode through the port if they are the DFP.

The second sentence should go below. But I'm not sure it's correct.

> + * @altmode Handle to the alternate mode
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
> 2.51.0.261.g7ce5a0a67e-goog

-- 
heikki

