Return-Path: <linux-kernel+bounces-861079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 157B7BF1BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CA764F6EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C454F7261A;
	Mon, 20 Oct 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjJcvvYy"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280A320CBA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969225; cv=none; b=DSWMIUcIO5FiXY70n8vCKBFu/2zbh0EtJKFpBhYjahAk4se9mfQxxIk/cDWNlcP3395zOQ3iKKgZKhO55p0g7eTV8rUAZYq9VkN1cw4hHIQOUaEWvjmSDQHXZp0o2MWoebGeyxrcUd2xOomohMhzCw7JwnHEP2jo2jBTS3ccFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969225; c=relaxed/simple;
	bh=iYFkl/nxfDRLe0SeNUr0Hl4oXg6cy9/Dzz20ODXL4b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BM49ddnezVGre7JcOhV4Av1FRmtGmsu2w+awRd9JoFy5vm84aJNJ99ScQovYqoXh1Z2LKf1d1naV2Hg2KnUnj55940+p/OfSFoe/MHa//hTk0tT2rwju9l6M4jWw++S34roV6JnQP78ey4N1BZpnl49h94/Op1N3s9WI0i4x2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjJcvvYy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso8096091a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760969220; x=1761574020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kZeqZ1f1Kjlwt5WlxnlLU6u8FvqUbW9sH2W37ltY2w=;
        b=XjJcvvYypyH+tcgmKr0o2Ya57xrhU835l/L5zyANYw2ME1fCN24Y7A/PNJAC8oY8eV
         grdexpf2M7AqR4vz4IMcG3a4LTgUQZYrXrxqDC5CToo62XcnWTXViyUiMR4lcN+ZrmDu
         hLCt0/AHvLSbwhUEkMfMTjELF+YQ0DixY/TLthM9TVS+eW4biGmIDVQRtIYzjGiTvDc5
         /4tepfmvZQhMakxnbrKEdmO8Dc1jWG4bU1xJkWaKTnlOQZ/B0fZrNvnLQz6dkLGgOzHb
         pVwNKVfDA755tCVEWAx/ENPlJFmUhnkrXaQkl5zNsYHfVsqdh0oTiT737OcV+cy11qKw
         6aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969220; x=1761574020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kZeqZ1f1Kjlwt5WlxnlLU6u8FvqUbW9sH2W37ltY2w=;
        b=fh3plaYpflLOEjZi1E1+FSrY2OGaNSJC7r2dmyeEyAHhq4L5YXuJl9fsBxt+8/k/sL
         ocCuZyiMzGQs82YhpRMocCM85S7ieA7paEudUWJIvuYK1RHWD6ECPxrTcQp8gJ74hw1s
         o3YcVsy67KEVxcHSakjNHrbQRie8iVtBFJlsw6nZaTN0hvlGXH9ihfC82ItzDxo+0qMV
         5Wz7QTan5tsqAcS+6cdQRZnSQXc34I0Ze5X1Z+65v3cI+tfM6cwBe58Q4A1yeESNGFwB
         paam2rXnEZ9b8nRAEG2Ey+nW4CDXQUA/wGq6Pppd1iHCK+DusgF7kBnJ0j9kEGjnVA6+
         lt2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVB/c4/znZLGbO5C/9lOAc+R+qKwu4Fm396mCVcBfbNKMahch+2olPO5o3tUhFxCyTEGdS6hozwEZtJBrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXVJQPC96MhcNa3GdkF5BCE/PeLr2THxS/JuaecVmG/SpX35U
	IdR6xu5T3Ito0txUUGUZ30MQb1XDjNP4zqb1Q99Zw08mdKfeZm7INELe
X-Gm-Gg: ASbGnctBswvY4HUuIC5D/J1DYDpDfHs77mNHhGlLutws3J5hIwEPu+VhJT7NyeBHEex
	I3IU26N91u5LGuPn4bc1PCeb5IL81ya7aL09HYp4WU/Ru6uwghOsEJbX0KX+7a4M5CkU7+9PGnB
	fxUlJfyDAQpCDUV3VdsaZSs/1dLphdalYzKQsXecSIpKrPEDDDBVMyeNpNrFuK+W7YP/3yTqWxe
	k3Bkm1U9+dUwcPB3HwARotGipv8h/CeX4PSEwd5ect7AbCod2hvmhUVqlX7JAPh7hvdo/yvlGC2
	jZ+sy934Yatces38giRAI/3mmkfBrsL3D5NPzysKo9QK5skBwPk9z9OLyZpNp1dhfMQYEsu2s/O
	f+/OEyy1LUVmNzQgoWEVjrNOnrQPpbXzAoZgPcGrnpG1/DyNTvheHdlWzLPBDJ5JfJGR/14/nub
	DkKfafL1DwkU+9LnMi89+VHUtXAl7VRwcUCbjpZU1ZAyMo09VC8z0TPQ==
X-Google-Smtp-Source: AGHT+IHVJ/TkOaDWREHUGoT4AMJTtZpCtqwsaqdgZXDvsL2iueitwKCDkh+1+uFs2HpKPMVPG6Ccmw==
X-Received: by 2002:a05:6402:848:b0:63c:1170:6572 with SMTP id 4fb4d7f45d1cf-63c1f6d94edmr11212098a12.37.1760969219915;
        Mon, 20 Oct 2025 07:06:59 -0700 (PDT)
Received: from [10.25.213.231] ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c49430272sm6767614a12.23.2025.10.20.07.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:06:59 -0700 (PDT)
Message-ID: <1bd36f10-aeb7-47d0-bc9a-e2078d5aeb86@gmail.com>
Date: Mon, 20 Oct 2025 07:06:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] reset: imx8mp-audiomix: Extend the driver usage
To: Frank Li <Frank.li@nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-7-laurentiumihalcea111@gmail.com>
 <aPJZCv+iG6cuxsj4@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <aPJZCv+iG6cuxsj4@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/17/2025 7:56 AM, Frank Li wrote:
> On Fri, Oct 17, 2025 at 04:20:23AM -0700, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Some NXP SoCs integrate one or more, per-subsystem, block control IPs,
>> which allow users to control the assertion and de-assertion of the
>> reset lines tied to some peripherals present in said subsystems. Some
>> examples of such SoCs include i.MX8MP with AUDIOMIX block control and
>> i.MX8ULP with SIM LPAV.
>>
>> Some of the aformentioned block control IPs exhibit a common pattern with
>> respect to the assertion and de-assertion of the reset lines. Namely, the
>> user is able to control the state of the reset line by toggling a bit from
>> one of the IP's registers.
>>
>> Linux can take advantage of this pattern and, instead of having one driver
>> for each block control IP, a single, more generic driver could be used.
>>
>> To allow this to happen, the previous approach, in which a single reset
>> map is used, is replaced by a per-driver approach, in which each auxiliary
>> device driver holds a reference to a certain reset map.
> Can you shorter your commit message?, basically, you just add
> imx8mp_reset_info for difference auxiliary_device_id.
>
>> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  drivers/reset/reset-imx8mp-audiomix.c | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
>> index c74ce6e04177..c370913107f5 100644
>> --- a/drivers/reset/reset-imx8mp-audiomix.c
>> +++ b/drivers/reset/reset-imx8mp-audiomix.c
>> @@ -24,7 +24,12 @@ struct imx8mp_reset_map {
>>  	bool active_low;
>>  };
>>
>> -static const struct imx8mp_reset_map reset_map[] = {
>> +struct imx8mp_reset_info {
>> +	const struct imx8mp_reset_map *map;
>> +	int num_lines;
>> +};
>> +
>> +static const struct imx8mp_reset_map imx8mp_reset_map[] = {
>>  	[IMX8MP_AUDIOMIX_EARC_RESET] = {
>>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
>>  		.mask = BIT(0),
>> @@ -45,10 +50,16 @@ static const struct imx8mp_reset_map reset_map[] = {
>>  	},
>>  };
>>
>> +static const struct imx8mp_reset_info imx8mp_reset_info = {
>> +	.map = imx8mp_reset_map,
>> +	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
>> +};
>> +
>>  struct imx8mp_audiomix_reset {
>>  	struct reset_controller_dev rcdev;
>>  	void __iomem *base;
>>  	struct regmap *regmap;
>> +	const struct imx8mp_reset_info *rinfo;
>>  };
>>
>>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
>> @@ -60,6 +71,7 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
>>  				  unsigned long id, bool assert)
>>  {
>>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
>> +	const struct imx8mp_reset_map *reset_map = priv->rinfo->map;
>>  	unsigned int mask, offset, active_low, shift, val;
>>
>>  	mask = reset_map[id].mask;
>> @@ -144,7 +156,8 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>>  		return -ENOMEM;
>>
>>  	priv->rcdev.owner     = THIS_MODULE;
>> -	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
>> +	priv->rinfo           = (const struct imx8mp_reset_info *)id->driver_data;
> needn't force convert from void*


not a void *, "id->driver_data" is kernel_ulong_t


>
> Frank
>
>> +	priv->rcdev.nr_resets = priv->rinfo->num_lines;
>>  	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
>>  	priv->rcdev.of_node   = dev->parent->of_node;
>>  	priv->rcdev.dev	      = dev;
>> @@ -168,6 +181,7 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>>  static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
>>  	{
>>  		.name = "clk_imx8mp_audiomix.reset",
>> +		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
>>  	},
>>  	{ }
>>  };
>> --
>> 2.43.0
>>

