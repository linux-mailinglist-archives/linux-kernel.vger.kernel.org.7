Return-Path: <linux-kernel+bounces-802565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA113B453DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E81C7BA1EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF29299928;
	Fri,  5 Sep 2025 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="db5PG2Gf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252BE1D555;
	Fri,  5 Sep 2025 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066303; cv=none; b=iSU6/oYPxGTUXgM7X7c0gIVC1kwXwdw9pbRX44AI6sALr405CrjzHFHVgVmsHjolp7YMzFTidt3o6TWt7qh9/lzeX/S7Rcc2chVbizy6nzPGtZCi/Y7dim+NMi3s5RtSSjd1GLGNjGFvI7NRZ2b0d2/KPVxDqXfnFAKoNPTL5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066303; c=relaxed/simple;
	bh=fH/fH9IlI4y4iyWIl9EmyomPqVs0ZCb7wQlHJg8l0wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo5d1GK00WnoTk8UsmTE/M5EGJb3YpRbHRC/T1Y9zjhmo3wUPQTfdXD9Ejn0Dj9NEDUAEPDcMKpksl/784YiRr9hq5pVJQhIT5HoLVDnqfDMLHGfAaAMJejp7yEXfiCIxdZLT9Fs8jxqf6FzZbig30xD7Yy+obDxqRps8X/QRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=db5PG2Gf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757066302; x=1788602302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fH/fH9IlI4y4iyWIl9EmyomPqVs0ZCb7wQlHJg8l0wE=;
  b=db5PG2GfI28nnHosiqzbBN03rtLe6M42XT5kDhu3n/FKiZrA5ZaBgY/r
   TtJMW4ERo5hCfwHMh29uArmivTgE/z5g5jdsOf5+pSVY7zeNFkQ0Oa0W/
   3cQ7f+fyAdGTTeIUF7m/ayTAG7EgQEJ+7gZCFqiqJjolGlX0fQLVZlqS+
   sNrYUSpxpEA54yWS/ytraoZyUIrQv8CeSxA78epdwrdkfo+WHcqVYWIlf
   2wGhPeAape9f2FncujvMQxPXqFseVQ0/ihSIHS5FGCpt3tP+gf74nXdJt
   SKH+k/pBOIuRYfC4k7v95p5aFePLzLtBUu3yaQuABrK3S1vx0EdJQMGtj
   g==;
X-CSE-ConnectionGUID: ewbEAwIOTEeQ6dFu4Nqwcw==
X-CSE-MsgGUID: bAn+OmcySuuw4uZO+2R0Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58450173"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="58450173"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 02:58:21 -0700
X-CSE-ConnectionGUID: z3iBlKTRSkixb0iLo9lHyw==
X-CSE-MsgGUID: cxdbLLL0T9quPQjZfy/Yfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="172012263"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa007.jf.intel.com with SMTP; 05 Sep 2025 02:58:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Sep 2025 12:58:16 +0300
Date: Fri, 5 Sep 2025 12:58:16 +0300
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
Subject: Re: [PATCH v2 2/5] platform/chrome: cros_ec_typec: Set
 alt_mode_override flag
Message-ID: <aLq0OD_7lIP6B-eJ@kuha.fi.intel.com>
References: <20250825145750.58820-1-akuchynski@chromium.org>
 <20250825145750.58820-3-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825145750.58820-3-akuchynski@chromium.org>

On Mon, Aug 25, 2025 at 02:57:47PM +0000, Andrei Kuchynski wrote:
> This flag specifies that the Embedded Controller (EC) must receive explicit
> approval from the Application Processor (AP) before initiating Type-C
> alternate modes or USB4 mode.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index b712bcff6fb2..c0806c562bb9 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -491,6 +491,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  
>  		cap->driver_data = cros_port;
>  		cap->ops = &cros_typec_usb_mode_ops;
> +		cap->no_mode_control = !typec->ap_driven_altmode;
>  
>  		cros_port->port = typec_register_port(dev, cap);
>  		if (IS_ERR(cros_port->port)) {
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
> 

-- 
heikki

