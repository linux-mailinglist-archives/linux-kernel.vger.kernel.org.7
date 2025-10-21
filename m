Return-Path: <linux-kernel+bounces-862593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FAABF5B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E254621D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA232ABC3;
	Tue, 21 Oct 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzCdiHNq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5101E5B71;
	Tue, 21 Oct 2025 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041348; cv=none; b=U79PiEEGeLSL6yJ5ZSkaTk14ONp6xy5v9PWVSjqKzhNs8vmS2Q6vMWn7uD1ako10Xnt89J5InHTZk69hu+AHZzAEIZ2VVjKPbEDu+pRK5LEy7XYagBUrkkMOtDzBRPySDm2GXXIIh3WDaGps53/zfRRPLuThkokTJchXaz1cO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041348; c=relaxed/simple;
	bh=3IkoSazez8ElCAf7vNq4LiZ5Hk3FfC92/I68aQg1P+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liYOhVGcj8QTcBJSv94wwZEQzYp3xy7OLqjTFd8NsPkuGLAwzmDLal+o2Yz9+0mntKe4pu/UlJHWKimhjILFbFAMOA546E15TGOKgCrI0CaxsOzaSEpvlA64t/h0cA2wURnB4l+TUpyc4AlS96HN7S9dpRiYyp3vPuQrP3CvxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzCdiHNq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761041346; x=1792577346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3IkoSazez8ElCAf7vNq4LiZ5Hk3FfC92/I68aQg1P+s=;
  b=MzCdiHNqUCQ6OY3gn1i0H25TZE0nhvmJqSmbS7Y+iSx63/utoQkK1RiW
   51+6g2l6aRyXQwS9jHXkmxRYK45mosybStgW9qPc8N8PL5/vZj9H4IGA6
   q4wUVg+5UTQo4qnXRyjsdaLAlHoHMRE/0tHWUHeBWDEELGYg8WNCDXD//
   Yg6gdVVXHW8vBU3TwShXmPTbXasNv0rbfASedeC2oAf8V1o3AvT4urq2n
   2NVup0c5k9bU/6aq1+BAHfYOuuMLNUk5lfx9iiKaZ5uM6RtgbaoPCJzWM
   qKniWOZaUFWuMQXst+wPjkcVP1q5msTUUNbb1thCLTdPXVOrSjKVjXG5z
   w==;
X-CSE-ConnectionGUID: AaMn8ZHpS8SP2OHvDP7b6g==
X-CSE-MsgGUID: C/n+QPuiRfKqllPX8yRx8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63204112"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="63204112"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 03:09:05 -0700
X-CSE-ConnectionGUID: +kRsYGyUSpyirDU+nfxltw==
X-CSE-MsgGUID: mlr9IvkQR8S/DIFYFMbZmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="214187185"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.224])
  by orviesa002.jf.intel.com with SMTP; 21 Oct 2025 03:09:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Oct 2025 13:09:00 +0300
Date: Tue, 21 Oct 2025 13:09:00 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-usb@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] usb: typec-mux: ptn36502: Omit a variable reassignment
 in ptn36502_probe()
Message-ID: <aPdbvC6Fz4kZ9x8q@kuha.fi.intel.com>
References: <b33ac7ab-e66f-4407-ba3e-ec4c70636fcf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b33ac7ab-e66f-4407-ba3e-ec4c70636fcf@web.de>

On Mon, Oct 20, 2025 at 06:00:06PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 20 Oct 2025 17:50:12 +0200
> 
> An error code was assigned to a variable and checked accordingly.
> This value was passed to a dev_err_probe() call in an if branch.
> This function is documented in the way that the same value is returned.
> Thus delete a redundant variable reassignment.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/ptn36502.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux/ptn36502.c b/drivers/usb/typec/mux/ptn36502.c
> index 129d9d24b932..b1a2977b974c 100644
> --- a/drivers/usb/typec/mux/ptn36502.c
> +++ b/drivers/usb/typec/mux/ptn36502.c
> @@ -339,7 +339,7 @@ static int ptn36502_probe(struct i2c_client *client)
>  
>  	ret = regulator_enable(ptn->vdd18_supply);
>  	if (ret) {
> -		ret = dev_err_probe(dev, ret, "Failed to enable vdd18\n");
> +		dev_err_probe(dev, ret, "Failed to enable vdd18\n");
>  		goto err_mux_put;
>  	}
>  
> -- 
> 2.51.1

-- 
heikki

