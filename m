Return-Path: <linux-kernel+bounces-807601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C277B4A6D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2871885406
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A8E283C93;
	Tue,  9 Sep 2025 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXVBGM+h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3989A28136F;
	Tue,  9 Sep 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408878; cv=none; b=XdVvpjix5eQEpcAX4bo1yQOB8HOzYf6+LZVfmwAtOkk6YpMX+ZxBU0ZVgyEem/ShvcjxsMDcEKMVLGq/aQCSHr3EAgRfVJ6enqMt9BklA444Qw5hzAH/+djqxCz+WaWA4Jfgaf+gBWtluQQnqvmg2/ahN85VS1oc7N0UlEeO1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408878; c=relaxed/simple;
	bh=WD/veY6O9nbXJ4rBWI8CJZC9zCfx1N915s17C4ExMOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRpoShA7z8Wu1JWqlQgvchDv9tppRDlTtMy4MAB4fTDy/0zw7YDc/q4baGrT+Qe2x37ZIG9adG5TrVK2okanuVqg19+N+SgO7s6ZXaCvWwPu43/fZFVT092UmUE5fd2CuBufETyaXcgO68mIsR7kSA7Hi6Ht5cMT495fOrNCGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXVBGM+h; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757408877; x=1788944877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WD/veY6O9nbXJ4rBWI8CJZC9zCfx1N915s17C4ExMOM=;
  b=DXVBGM+hIRCNm9KXtUp3tbYMIAtgXk1iF2wf1cBBelkNYs6zUx25kGt3
   oWVUvKCBat1M89+4BRyJ/QpUwDcRRxw0zmA3DQHnGqTz8Y/LYOzLj06uy
   DC9SWm3Vd97bnNPFGxoHvb5jrMUjbCRNIAlN2uw1Db1ajRjbRG8SfMhEm
   uGxG9WdSAWbyKnztzgn7wMPJwi77HQUNzMNATPMqsem7NljAmY+ez+hdN
   D8Ngyqm5NU0Yfih6MuoaQz9HmqOXpAHyTHwtqZE07EHTe0tEPXpyNjmUL
   78uDjtr34SXq9PxgMQLmCtCl/3WIHdSweyKlm1kNxhLMBGUG6XyET4CV3
   A==;
X-CSE-ConnectionGUID: TfBb8X1BQ9euHRlTgDktww==
X-CSE-MsgGUID: luZ2HQq6QzaICM4OW23hNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="85132854"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="85132854"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 02:07:56 -0700
X-CSE-ConnectionGUID: suuo11xPTgyHPNT80Zh/vQ==
X-CSE-MsgGUID: H6m7DZRTQlGVevJFCZ5OLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="172950676"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 09 Sep 2025 02:07:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Sep 2025 12:07:51 +0300
Date: Tue, 9 Sep 2025 12:07:51 +0300
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
Subject: Re: [PATCH v3 3/5] usb: typec: ucsi: Set no_mode_control flag
Message-ID: <aL_uZxBkBfC9Etrk@kuha.fi.intel.com>
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-4-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905142206.4105351-4-akuchynski@chromium.org>

On Fri, Sep 05, 2025 at 02:22:04PM +0000, Andrei Kuchynski wrote:
> This flag indicates that the PPM allows the OPM to change the currently
> negotiated alternate mode using the SET_NEW_CAM command.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 0d6b0cf5a7cd..9f754344a841 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1632,6 +1632,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  
>  	cap->driver_data = con;
>  	cap->ops = &ucsi_ops;
> +	cap->no_mode_control = !(con->ucsi->cap.features & UCSI_CAP_ALT_MODE_OVERRIDE);

The flag is now used to expose the priority file, but you can't affect
the order in which the UCSI attempts to enter the modes, or can you?

thanks,

-- 
heikki

