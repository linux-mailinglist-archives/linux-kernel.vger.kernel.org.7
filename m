Return-Path: <linux-kernel+bounces-802568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE2CB453E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192201C27DE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EE5299A87;
	Fri,  5 Sep 2025 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTKzlnep"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650D29992B;
	Fri,  5 Sep 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066355; cv=none; b=ACyixzgR/I/RWhZLIQy8T/PruhQbMoMnR7TNw2Swx7cHtzNFa3vzJKKdszpqvdsxHONjlM4A/s2HwN8hC4Eoy9bsxdCAigmwYycZiiwwtJzbtnI8SChXxY7NTxI74qa+ATtubokFLM40KSnKKZx/WriJWOiQy2NU2pqwprG/vFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066355; c=relaxed/simple;
	bh=Oc5oxzPko0VSO8pZR2WCr8boFGP/lzIgTp951BTp44A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSkVM0ckp+qqELDw2D+cyfa3N8Ay7tBt2babIzSTw+Xdzv/M4ywpwpem2iys7WnnRDwt0eTLziARHN5zm04oeAmJ7FBDzNPhGaFLSdag1GekVOCH/lJs6UP6GenUF6S4XpIwe5Dc84ZjwALR3WakW25TTTtVmSFRMfWx9gVK3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTKzlnep; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757066353; x=1788602353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oc5oxzPko0VSO8pZR2WCr8boFGP/lzIgTp951BTp44A=;
  b=QTKzlnepQ2ohWBFQIhnSkDkZ02qVJ/a5+zEVCKLfQJQmFLIkMcAvLmHg
   rTq3beDwZfHGX7p7yFoxi4c1wnXpGS00UqsjBqET07GnRpbC5KBZM5eNI
   JY62HwW8AAqg6pIodoYv/0tXcmGl2pAunl9QnKKDmxDxBy8lGAh4Jxori
   t6ciZBMb+G5vb1iArCJmoZQb7wscLUVKEkKM+HGc0izKYgAPdjmvD3jQK
   Ez3U+gShsz7Ca1CUyaXaF6d0Zi2WC1SRIhP4sym+DfKkCAf3nVl6mYwFA
   jjRkcAzgP2hPgDe+Nx+8sE0bO1836d3fgSBeFoXrAaxF/MPN07nIyNnsa
   Q==;
X-CSE-ConnectionGUID: LeKcOVZyTjCMxVyZj7kGpg==
X-CSE-MsgGUID: hJq3fttFR5CB/Sml/aK2GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59368734"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59368734"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 02:59:13 -0700
X-CSE-ConnectionGUID: tob/WFwEQ562+GvuXs11xg==
X-CSE-MsgGUID: Q0cV4h2pQJKjymxh1k3+jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="177344958"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa004.fm.intel.com with SMTP; 05 Sep 2025 02:59:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Sep 2025 12:59:07 +0300
Date: Fri, 5 Sep 2025 12:59:07 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] usb: typec: ucsi: Set alt_mode_override flag
Message-ID: <aLq0a4fPzeWKzaxk@kuha.fi.intel.com>
References: <20250825145750.58820-1-akuchynski@chromium.org>
 <20250825145750.58820-4-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825145750.58820-4-akuchynski@chromium.org>

On Mon, Aug 25, 2025 at 02:57:48PM +0000, Andrei Kuchynski wrote:
> This flag indicates that the PPM allows the OPM to change the currently
> negotiated alternate mode using the SET_NEW_CAM command.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 0d6b0cf5a7cd..85a6b7fc6d93 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1632,6 +1632,8 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  
>  	cap->driver_data = con;
>  	cap->ops = &ucsi_ops;
> +	cap->no_mode_control =
> +		!(con->ucsi->cap.features & UCSI_CAP_ALT_MODE_OVERRIDE);

Fits to one.

thanks,

-- 
heikki

