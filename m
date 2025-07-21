Return-Path: <linux-kernel+bounces-738587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0728B0BAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C6817E020
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958BC1EFF93;
	Mon, 21 Jul 2025 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP2Kb3kE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68E15E5D4;
	Mon, 21 Jul 2025 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064657; cv=none; b=fjiM2c9f7mbEuQjk9uB8mz+RAafHfzTVFBn0QeSgpEq7wV/LP9X9bBeEOSdGVM9ShbR7171Dp9f1/hBYYTimjGMA1RIBvkBv1aDwMfaLLo+eWsaJfhRF5kdiN77WGgSC/4qsgOIjOcmb3Az6197ryOQFKAIu/ZtwaAPNfIKFH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064657; c=relaxed/simple;
	bh=Ey6VShtfZEI9G10TSvqYxJSr1SHPPAJkj0cWVnFBhY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PznQw6ZN/C9Vd4qrdIWLDXJ/ubGvAxfid3V+BtE94k9fnXJ97mluAAKdf7jS8cunOn727fnJ+RmsNf6BAXyDznv3W87VqgLuAgGUsIEg2zaDTTqL0s+la5oYsLPLyUem5hshOJs8hDxXrMGdnArN1ar7fxLVW30GM9f6hewIaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP2Kb3kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DF1C4CEE7;
	Mon, 21 Jul 2025 02:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064655;
	bh=Ey6VShtfZEI9G10TSvqYxJSr1SHPPAJkj0cWVnFBhY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uP2Kb3kEMoxEK+Y94nnm1CQ6pjPH0emUGltasa7oGvg0BiC3LNNn+JD2A93+C95Ve
	 nM3K7P29BMxKp2cHfpLe6DZGkW5STaxcW9V9/pLFkoac6EG1fhzNmd0HmMhI5Ru9Og
	 JOrdXtBMk6HB+6KkbtBKVhM2GDOo6HzNDmHf8D7oxMeI93E+HQeg7JmqG9t5zMpn4u
	 jCWsKnr/i8HNxHSdRUAmCXUaqx1Ao+iHC7AnWZH3BVkJ8/yvq/Kgjwpykw9voXKlPa
	 ynk0WKITPYItow0lwdTq5SQaFa0lZVypLkhwKiKszink4Sle5JLdNLPQqd+xAnCewo
	 mFyw5MvQNccvA==
Date: Mon, 21 Jul 2025 10:24:10 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: chipidea: imx: Add a missing blank line
Message-ID: <20250721022410.GA299578@nchen-desktop>
References: <cover.1752703107.git.dan.carpenter@linaro.org>
 <36d1c961-319e-4457-bdc1-69f8b6bed33e@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36d1c961-319e-4457-bdc1-69f8b6bed33e@sabinyo.mountain>

On 25-07-16 17:46:26, Dan Carpenter wrote:
> Fix a checkpatch warning:
> CHECK: Please use a blank line after function/struct/union/enum declarations
> 
> Reported-by: Xu Yang <xu.yang_2@nxp.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/chipidea/usbmisc_imx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index 0b8b980409bc..3d20c5e76c6a 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -1118,6 +1118,7 @@ static int usbmisc_imx6sx_power_lost_check(struct imx_usbmisc_data *data)
>  	else
>  		return 0;
>  }
> +
>  static int usbmisc_s32g_power_lost_check(struct imx_usbmisc_data *data)
>  {
>  	return 1;
> -- 
> 2.47.2
> 

-- 

Best regards,
Peter

