Return-Path: <linux-kernel+bounces-870826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B1DC0BC53
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 04:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097E118A0802
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F721FF1C7;
	Mon, 27 Oct 2025 03:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi6A43QW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B17A78F29;
	Mon, 27 Oct 2025 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761537248; cv=none; b=hCziI2D38fs+G9w8n+kKAWt2VnrssGObh6xFY/k76PICp5ylTVmlpG7RK94jbrx20soZJkT/Ped/eUOXhAi/sX/9YfnJRXJYlhWqLgLYrq4TSHo+cD8I9VWO+pTD91kzGKZZAzUfSQYwWLR4TFgVP6MVYx17eDXKnP2lv8ESJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761537248; c=relaxed/simple;
	bh=f4zo75iPNSyYtym4iAsh6x+1Wt0bdNSnkdR3NShJB/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GocqWrK2KG/1pPKxiXaCtIpTN0q7l7vIM3GcThbN4XKE2oukt1HsGS98vFhKgpsaOdhaPBfJ6wmRiwFl+TJ6A9PYGDYH6+bePBPYRE012nfN3fY65x+MCInAOxjDMxvwgRQ+/HYZhfRCqvu2cvSP9dN6U+yzAJaxCc7d8RpAM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi6A43QW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE666C4CEFB;
	Mon, 27 Oct 2025 03:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761537245;
	bh=f4zo75iPNSyYtym4iAsh6x+1Wt0bdNSnkdR3NShJB/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gi6A43QWyQgmOvggqjbXq3qgctb/BQTva2OxpgXb+QBoHZfIJqrvhTsjcpV9eGILX
	 KpBJUCie6k8qSgwkNumLEqaaexdZ68uIo3h2epQd4NIU1SuKB5C2KcNxbo9+MZOZz7
	 fPam93UgpRvv7vQONPl/Rcy2wyslrLyn3X+zaUijqC4O7IqCSX9RcGpwe3NxGcg+8o
	 JXKcbF4z7N8euKBb2zWBz2tL1jau+MkYtmVfBZIP7HZFiC/cP3V8WiNpVCs6Oj4a8f
	 UguZsxhF81EuIJXoNJzVssy/UeCzngHfwl6RnsMx/vYdW7TMrVYYCIkmUhxSVB3DbI
	 mEIINED59ZLJw==
Date: Mon, 27 Oct 2025 03:54:02 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Brady Norander <bradynorander@gmail.com>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_lightbar: Check if ec supports
 suspend commands
Message-ID: <aP7s2ib_nUIZ3X5O@google.com>
References: <20251023234239.23882-2-bradynorander@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023234239.23882-2-bradynorander@gmail.com>

On Thu, Oct 23, 2025 at 07:42:40PM -0400, Brady Norander wrote:
> The Chromebook Pixel 2013 (Link)'s ec does not support the lightbar manual suspend commands.
> As a result, attempting to suspend the device fails and prints the following error:
> 
>     cros-ec-lightbar cros-ec-lightbar.3.auto: PM: dpm_run_callback(): platform_pm_suspend returns -22
>     cros-ec-lightbar cros-ec-lightbar.3.auto: PM: failed to suspend: error -22
>     PM: Some devices failed to suspend, or early wake event detected

Thanks for looking on this.

> @@ -550,7 +557,7 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
>  		return -ENODEV;
>  
>  	/* Take control of the lightbar from the EC. */
> -	lb_manual_suspend_ctrl(ec_dev, 1);
> +	has_manual_suspend = (lb_manual_suspend_ctrl(ec_dev, 1) >= 0);

The driver doesn't emit an error if lb_manual_suspend_ctrl() returns an
error in the first place.  However, I think `has_manual_suspend` should
only check for -22.  E.g.:

has_manual_suspend = lb_manual_suspend_ctrl(...) != -EINVAL;

