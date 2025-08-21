Return-Path: <linux-kernel+bounces-779132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E9CB2EF85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B065E7759
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682922E8B88;
	Thu, 21 Aug 2025 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMom5Aco"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73242283FEB;
	Thu, 21 Aug 2025 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761002; cv=none; b=DumasI8N0ZJpwQsiI33wzpgTuK9FU/bceae9CsC37JbNjygmfHoSWoQO5+aZ+Jx4XurdsR3wbSnlaQwMsSZmu6cj2zeze0aimozKdFQX7Petk0MoKtjaI51aZgDfoDJxQnVunSGmb91gx4BLmurlmgS/k3qa25cYyIt/y/u9KRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761002; c=relaxed/simple;
	bh=l+Xf6Cch4otNX9tUnaUGjMlw9IQdKLXtuDE0iA7v9pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw/WdkE5pEScTpyyb/H76Nt2p6Mcg28WqbohPzD3BztirAPuFCgtvf41SrapAzILrt+pQQXwWOFL5gWRQO96dYttduH/RKOLsuJEGE0k+ljb/2Qtxg8768SeACWPLD6vfHRVnmWCjN5g7xSXWESjb6vRQJG/iFojlHd8x58vfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMom5Aco; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755761001; x=1787297001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l+Xf6Cch4otNX9tUnaUGjMlw9IQdKLXtuDE0iA7v9pQ=;
  b=dMom5AcoubJ+XKVWlqkqsYvmR4Ay1rntK0J7WP6JMz+JRzjztKK8Z2aF
   JB6aySfr+7USu0HaSXeVN/YIyT7pXv0P1NYEY48NJpsdJbU2WqFrLEoxe
   U+ZJd3cmQX8Pzq1e0rDwOW42jfmKsa0QP0y1+OGwUf41NX5UDAZEaLjLD
   D6g08dwaROu84D3liqL5izBz/28El9uPcXCJlFTuJm+gk2UU0mbC/CAG3
   T63fkGga8Ny1rgsOuZQqGoOkGb/nLlLWu1bcZbBpBvIJeVJUSxQXo8kc0
   VISl7VDQwqApZoaRMKDR2GfdRzGd+/Xm3gQdXezLLF6PPGcMlubXjGRP/
   Q==;
X-CSE-ConnectionGUID: 46Vo+Nh1Qv2HNBXtXcR6JA==
X-CSE-MsgGUID: PO7KKEdwTaKHjiEstae0KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58136719"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58136719"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 00:23:20 -0700
X-CSE-ConnectionGUID: 2bruqgrORWCFqqqUbkKbrQ==
X-CSE-MsgGUID: bcGw8VVRS2K/RI8OtffQdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199211870"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa001.fm.intel.com with SMTP; 21 Aug 2025 00:23:18 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Aug 2025 10:23:17 +0300
Date: Thu, 21 Aug 2025 10:23:17 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: romain.gantois@bootlin.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: mux: Remove the use of dev_err_probe()
Message-ID: <aKbJZa1tQMpf0QWX@kuha.fi.intel.com>
References: <20250819112451.587817-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819112451.587817-1-zhao.xichao@vivo.com>

On Tue, Aug 19, 2025 at 07:24:51PM +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/tusb1046.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux/tusb1046.c b/drivers/usb/typec/mux/tusb1046.c
> index b4f45c217b59..3c1a4551c2fb 100644
> --- a/drivers/usb/typec/mux/tusb1046.c
> +++ b/drivers/usb/typec/mux/tusb1046.c
> @@ -129,7 +129,7 @@ static int tusb1046_i2c_probe(struct i2c_client *client)
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> -		return dev_err_probe(dev, -ENOMEM, "failed to allocate driver data\n");
> +		return -ENOMEM;
>  
>  	priv->client = client;
>  
> -- 
> 2.34.1

-- 
heikki

