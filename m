Return-Path: <linux-kernel+bounces-884580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77288C30826
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6748D4E69E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A17316192;
	Tue,  4 Nov 2025 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3G1cM2r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8C315D53;
	Tue,  4 Nov 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252156; cv=none; b=pYIfMXafP6QGSYf4Ip6nlzl8zmWNXQUWk16n9kjHcuYf94DaVf41gaF7UDbg6gXwF6FKTdXxSd1VPCne8p7mBIVmXarLrVvihrECMamtb6WqPea83ifEOVr716Xloo+VadhxZyDGRjlrj6Wni9RUg1bOSYL2QUQZMPToEPu69H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252156; c=relaxed/simple;
	bh=ZvgrGlX+pY1sb/eE7IG6GO3T1HRtlfCFy+ccRd/1UpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDdVSR09k/FqQpD4jEhQDfJcd8BeZyDSsUzFhat10OMwKu6pTPxDLH+N94jCdHNWvrdbyTkTBE94CY+qWEyU/SaMVjkpi/eCMonwufUqZX2GcaWIyJ6ly2hRdqWNlCsy0noXnkEnCvZxG6oHbKjfph/HsiGOb6Son64ELmZvx5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3G1cM2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0361C116B1;
	Tue,  4 Nov 2025 10:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762252154;
	bh=ZvgrGlX+pY1sb/eE7IG6GO3T1HRtlfCFy+ccRd/1UpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U3G1cM2r1KT8NVg0CVB/YWTIbPDqI2nJA/N4IOEgZmbgwBJL6b17+J1lxY9OREUQN
	 pMiMKBSNOIfE9wceaB8ZkTG1qWdD6bEKSBLhVCrsaXnAuRrcZiXGs4k6Pa5f0sGC0U
	 Y2b6EsMo08ZbjC3nCXtaqpskSZqkkyrag+Wi7FcS8ouU15XC6N+KqFG5z/SL+CzMur
	 ccU1g/8KnqSez/+V4HTydjmp1zeiksFeYt5rYpwe43S8RihkFl3hLdJlgODCR+cGOW
	 URzKFSDSkMB++ywmnnTXlmvafUMIg/d6kP6zvTEiCJJx3bnq/vnmmyCl9RACJmBCzv
	 JYjcCGyDQrtIA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vGEHt-000000006XV-3EyI;
	Tue, 04 Nov 2025 11:29:17 +0100
Date: Tue, 4 Nov 2025 11:29:17 +0100
From: Johan Hovold <johan@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: arche-platform: fix pm_notifier leak
 in probe error path
Message-ID: <aQnVfdHKk7TD0JwM@hovoldconsulting.com>
References: <20251104090825.224-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104090825.224-1-vulab@iscas.ac.cn>

On Tue, Nov 04, 2025 at 05:08:25PM +0800, Haotian Zhang wrote:
> In arche_platform_probe(), if arche_platform_coldboot_seq() fails after
> register_pm_notifier() succeeds, the function returns without unregistering
> the pm_notifier, leading to a resource leak.
> 
> Add unregister_pm_notifier() call in the err_coldboot error path to
> properly clean up the registered notifier on failure.
> 
> Fixes: d29b67d44a7c ("greybus: arche-platform: Add support for init-off feature")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/staging/greybus/arche-platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index d48464390f58..9c5bb5dae187 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -545,6 +545,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_coldboot:
> +	unregister_pm_notifier(&arche_pdata->pm_notifier);
>  	mutex_unlock(&arche_pdata->platform_state_mutex);

This looks mostly correct, but please make sure to release the lock
before deregistering the notifier so that things are unwound in reverse
order.

It would be even better to move the mutex unlock to where the driver
jumps to err_coldboot since it is only held in that conditional since
the offending commit.

>  err_device_remove:
>  	device_remove_file(&pdev->dev, &dev_attr_state);

Johan

