Return-Path: <linux-kernel+bounces-878913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA7FC21BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD094057D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33790355809;
	Thu, 30 Oct 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8koGIKD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739902F60DA;
	Thu, 30 Oct 2025 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848505; cv=none; b=ARVoXkHG5Us17wIC/NM1+X3gX2lQV8n9oGYyWAZW8kfFigxIWwsvcfNx7dWWWTmWi1EghcActzyuyCYc4N+uhb+5nh0XNqRsiez2MjA0Dvvg/w21TmDB3IqfH/YH06WCkZNYO+CsDi9bbAKog1ZE3+hFRFkhpzFJ1lfQ4QeZRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848505; c=relaxed/simple;
	bh=RosfrqCKiQqp7UdTzbvEclGc3HGPz0C49g8iWkjlsms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfkWDY0aIg84cSUGPWUOQ92BQFnYLs6KMUPrulucDRumnddIyi1NNpHhCR3SOL5l+uWngA02ZT8nrq08DcgcdJQmFneQN8l9/QtldOgIyRyTyAM5FgB/xsN9DwwsSRs96hZfHARhQ3DaurfvMdLdZR8ak1dxImxrlb8wsutw/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8koGIKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5BAC4CEF1;
	Thu, 30 Oct 2025 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761848505;
	bh=RosfrqCKiQqp7UdTzbvEclGc3HGPz0C49g8iWkjlsms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8koGIKDRZ4CRbwawcHi772IxPA3cSVtcGly52GqwCJtpsa+plMR5MgJ0ltxVXALu
	 bPIz+9ACwamMMsvcuORe59ekYZJvfMy2QPJgyH56MR5lbaHCMCBBueq4uG+Vm3OCVd
	 KnS/WxHVMDFEHlXNTlp3CH+AmpB8/24QXF+Siu4DCF5x71/S9Jb3tK/eR1eihANQjG
	 r9LV8kACrHwQQnAd9xsJFxxkmQu4RrLH8GYZh4m/FBcKhbHL5Y7hj7wvgRrlbDEt8D
	 RzmqckCkJ4FdnvR1MUShjaZ6lBsnForrstFCMleUP4XzuaPvTz1FBApJrTlnms9Kd+
	 mHs9OxGD62UjQ==
Date: Thu, 30 Oct 2025 13:21:38 -0500
From: Rob Herring <robh@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH 0/2] mfd: syscon: introduce no-auto-mmio DT property
Message-ID: <20251030182138.GB130921-robh@kernel.org>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <3fd4beba-0d0b-4a20-b6ed-4e00df109b66@app.fastmail.com>
 <aQMUu08phVPqfgEB@stanley.mountain>
 <dbd5558a-90d9-404c-ae98-a8c04cdad08a@app.fastmail.com>
 <aQNccP-lHqgygmsu@stanley.mountain>
 <CAGb2v664ybgMVCFWcDK-5cJZegC1HJmCg4-qJdgZ=7GAL4jOTw@mail.gmail.com>
 <aQNjoM3fgAW6kxUz@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQNjoM3fgAW6kxUz@stanley.mountain>

On Thu, Oct 30, 2025 at 04:09:52PM +0300, Dan Carpenter wrote:
> Yeah.  Let me send this tommorrow if no one objects.  Pretty simple
> solution in retrospect.
> 
> [PATCH] mfd: syscon: Return -EPROBE_DEFER in device_node_get_regmap()
> 
> These days we can register syscons with of_syscon_register_regmap() so
> if we can't find the syscon that probably means it hasn't been registered
> yet.  Return -EPROBE_DEFER so the driver will try probing again.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index ae71a2710bed..e5d5def594f6 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -183,7 +183,7 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
>  		if (create_regmap)
>  			syscon = of_syscon_register(np, check_res);
>  		else
> -			syscon = ERR_PTR(-EINVAL);
> +			syscon = ERR_PTR(-EPROBE_DEFER);
>  	}
>  	mutex_unlock(&syscon_list_lock);
>  
> -- 
> 2.51.0
> 

