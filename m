Return-Path: <linux-kernel+bounces-880269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE3AC2545A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14D5423C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F6D1A23A6;
	Fri, 31 Oct 2025 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCdRDPks"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FFEAC7;
	Fri, 31 Oct 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917563; cv=none; b=u7MYjuMbsG53MAI6oJeFlomLdABTvsSFFVKH6JLWmnIAnMW8dfyuz9nCUjXFRI0jo25I0FPf1i0KR+ps0n0NxfS5wXCmd2lVmvptpNHf5N6mMsiaKbf9Ptp5SYUizIGfo4p7C7P5K31JiNM/JaJSHuYMDUlg8sBr744w4VXDIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917563; c=relaxed/simple;
	bh=jyztiEsZ+csB4RCtRcDmpzJi7vqq2rVqeKbvXQM1D/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuSryNQH93b4ZJecVZGH4aQCBuEFqjIlv0YWrv/qkwHTWt2k2vpYk5Wp/s1H9BfvAnWCRByvJfvDwSfhAd+L8EqKCk82oKoQoHUSwG+pL49Yrra5y/EYBY3DJWPtW9z6T0xNCdYmqGEN8PjxJhg0DiPfjpalloL8Vyr5AHZiZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCdRDPks; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761917562; x=1793453562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jyztiEsZ+csB4RCtRcDmpzJi7vqq2rVqeKbvXQM1D/Y=;
  b=hCdRDPksanh1FW7KwGkMFshobIeRJpPN/brx91Gy7q4x8sQmeXBLailG
   +e5+4xGc++EFjmVE75QyNxLMbK4RApuiOEh9r5p5NcmepibFSxNwIr+pR
   gP4t0ou9y9woj0MdKa+I7Y9dBBZ8vuHYHZwOMulhqs61NmYLQUb84u3oa
   ezx60eKTg8bBnDKQULmbGYbqj0uGV8fIZsq2WCY9F/ow56mXZrIraGsMU
   OvDfQ8PBXyexBefWVciPVZGjVOKK0YHqYQVDTDoIQHc2JZFB8/TVVSwnn
   iDyuzff80uilSxcnsltY5jCYE0jugXmZGxd1nhwgq+58EEUykhoot21hK
   g==;
X-CSE-ConnectionGUID: C36ai6MYTV69X1cQjDi2EQ==
X-CSE-MsgGUID: xa+puWiYSKmCkBmglPaPbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63773863"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="63773863"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:32:42 -0700
X-CSE-ConnectionGUID: gK3hd0tBQiKP3T3IAA8EnA==
X-CSE-MsgGUID: /ewMgTYWQ8ieuppHhS4GDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186691071"
Received: from jjgreens-desk20.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.81])
  by fmviesa009.fm.intel.com with SMTP; 31 Oct 2025 06:32:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 31 Oct 2025 15:32:37 +0200
Date: Fri, 31 Oct 2025 15:32:37 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Set orientation_aware if UCSI version
 is 2.x and above
Message-ID: <aQS6dfrSxAihLC2o@kuha.fi.intel.com>
References: <20251028-b4-ucsi-set-orientation-aware-on-version-2-and-above-v1-1-d3425f5679af@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-b4-ucsi-set-orientation-aware-on-version-2-and-above-v1-1-d3425f5679af@linaro.org>

Tue, Oct 28, 2025 at 05:43:03PM +0200, Abel Vesa kirjoitti:
> For UCSI 2.0 and above, since the orientation is part of the paylad,
> set the orientation_aware by default and let the implementation specific
> update_connector op override if necessary.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index ed23edab776354f08452c539d75d27132b8c44dd..84afa9bfc65b6e6ad0a8c1856252299c16562baf 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1637,6 +1637,9 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  	cap->driver_data = con;
>  	cap->ops = &ucsi_ops;
>  
> +	if (ucsi->version >= UCSI_VERSION_2_0)
> +		con->typec_cap.orientation_aware = true;
> +
>  	if (ucsi->ops->update_connector)
>  		ucsi->ops->update_connector(con);
>  
> 

thanks,

-- 
heikki

