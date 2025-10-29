Return-Path: <linux-kernel+bounces-877245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D7C1D8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398B53B2975
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6E22E2663;
	Wed, 29 Oct 2025 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWxji16n"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E642D3728
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761775413; cv=none; b=BOBaRgvxQtWKX6Irl5VNwuu1q2UYQgSAQM6pY/KbrxpM1z32GoBhKNLVEXc+pDn/QjMBUGqh/jZ08cKc/ZBPsPekOXY+XyQWZTAbozq+FZiReBRJTGOwvhYtqxSThT4rV3dh7ZDrsFV8RuQ99xwCewngrKn8JRao8PeOTmtFzm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761775413; c=relaxed/simple;
	bh=Rpx+i+g4UDOw+uheC336cz/8fzW0yUsW3KtUgY9A9/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXuA0+zuocCK8LyXR36DtUsvmFMTB0BFbRuePl/4CLfP49xOz2T1WpDlfe+FFDPxqPRPA61WL2Eby5QflsKAFgNu/5+5/faDo3oloLNT87JIWhmKJ6K9txF4piHL1d69Qj7zc/smpeq+gx8ML8rJf482HMF6Ab0yuEAplIhs4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWxji16n; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781997d195aso311781b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761775411; x=1762380211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Nblfgm5XoVGA2pwggUTGBEWVQZIZxWS8tzQ3rNya1k=;
        b=BWxji16nJLKjInABvrLXLKUmUE3XuS1E0BNaJ5bmjeGIyBnxSjLDc6MQoRz+9Z+YDX
         g7pZhhRL+s/VBub26bsKS4eUUb595+susT3Rj8u6paScAqqC6BTvFewfsnh6lMfnivU4
         +I3b0ql29WFTh/uwApl9Oh/nG9FLsdvHf0mlbyeGfmb9rla+c6zUXV/556oAyKQ4rqte
         FBfE1Tu1Km3MzpBXnzy4vvaaOivAChYY+/BJxHd8iAWxW0Vkt2PnLqf4pIEG0WHDIq5X
         zyuFON8aen8D+jrRm/Rxd2SZuSRDH89HRIRSY3Gxq8NvU1prHYzR0Fr7EM9Aewa/LDe+
         QieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761775411; x=1762380211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Nblfgm5XoVGA2pwggUTGBEWVQZIZxWS8tzQ3rNya1k=;
        b=L116tM9Uk6KXRfehLZT05I+N/BA5RlQCfTCs0sBBW5PzvCRCTtAkIjzmEE5QueNeuI
         7uAJf8Xqar0f0wLkSzsqdNvmOSiP7CLnIk4EZWlInM4SkerTD0gCmZJjpXqmYSh/7GiY
         sSzhVSanBGUDxwgfnVUtCuWBrHAkjNm6NHB2SYES1A6ClEnf37452DoAK9e6yXLqn9Ds
         bADyYX9khLeudHAHmKekYfXV1P9UdBpUhI8b4RbYqlGmGC0cDmm8FoLhxrXzN/ZdnsVv
         pm6DMJAXn4jUpub/QYtE8ym2cIl7XFp/1W3ooR0BMBXKMWr/dvHO/9wBPxBThJlO1OzQ
         WhxA==
X-Forwarded-Encrypted: i=1; AJvYcCWn2pBYmOctr8VXNo7iqzKb+8gExcjdR9mpKM8IvowFec3R3f8NEBHlJFKToUmwDT8DPCkPMI3n3Jr/qzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUUIlzMJpnWrhU1U6MVJv2o9paqQs/sMW2APvucGG7IPv7n3Gd
	j2UbnZOeg67viLOPQ6DTKaJcU7IMy/RfzSeL22HtGvewTxtB0b6h81LH
X-Gm-Gg: ASbGnctxP4+B8v+jlguePlaSyusXhHFpFq8XLA58s8HVQedn8Fgfhw85fmDiKRg9iZD
	UzdtykRQVbdaVBPxYPIcwqON7fSoeYEcTZPyNymM043Cr0Tr9EwIY3hP+cw1e9NnAWTs25rNCUe
	BqJjJAChdfeF/2VWDWcrHKFlaVHuXJKTDNm8X36yId2Wo3+Mtat2LyvvKTfOwmU67UgqPM+tZPB
	fjUxHNbfifU59Aeg3MvCfNbWRaDQLV0rmSVQotjAh8Tipeai2FRVTVcOt02WI3iOtc2awNXZMRO
	V57ozwrF2ftqQt1e7Bk29gfDFPsWwIr3FpBvqvOLApxH9UdpcuME2nykMpx0EVtCnCr3C7wuolF
	3EddhTRDtnouxdO6COHHbP91F4aMvnNJ393r69nrC4zhqtY3E5ePIvAF/6SSWKmX5L7IkY8cjJB
	Q4+649841zG2oz
X-Google-Smtp-Source: AGHT+IEwsj2J/ftTrnWWbeM7o5Z+AJ9IhB7ABxIMbByBawCiASkXvvXWBg+ahShIu+FUAW/13d84Zg==
X-Received: by 2002:a17:903:ad0:b0:269:96db:939 with SMTP id d9443c01a7336-294def33bffmr54489445ad.58.1761775411490;
        Wed, 29 Oct 2025 15:03:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d230basm162597355ad.46.2025.10.29.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:03:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 29 Oct 2025 15:03:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marius Cristea <marius.cristea@microchip.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: temperature: add support for EMC1812
Message-ID: <86b94f01-ff93-457e-95cc-4e87009964af@roeck-us.net>
References: <20251029-hw_mon-emc1812-v1-0-be4fd8af016a@microchip.com>
 <20251029-hw_mon-emc1812-v1-2-be4fd8af016a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-hw_mon-emc1812-v1-2-be4fd8af016a@microchip.com>

On Wed, Oct 29, 2025 at 05:50:59PM +0200, Marius Cristea wrote:
> This is the hwmon driver for Microchip EMC1812/13/14/15/33
> Multichannel Low-Voltage Remote Diode Sensor Family.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

One more ...

> +static int emc1812_parse_fw_config(struct emc1812_data *data, struct device *dev)
> +{
> +	unsigned int reg_nr = 0;
> +	int ret;
> +

I added
	if (!dev_fwnode(dev)) {
                data->num_channels = data->chip->phys_channels;
                data->active_ch_mask = BIT(data->num_channels) - 1;
                return 0;
        }

to be able to load the driver and run basic unit tests.
I expect something similar in the final driver.

Also, here is the unit test result from writing negative values
into the limit registers:

temp1_crit: Suspected underflow: [min=0, read 4294903296, written -2147483648]
temp1_min: Suspected underflow: [min=0, read 4294903296, written -2147483648]
temp1_max: Suspected underflow: [min=0, read 4294903296, written -2147483648]
temp2_crit: Suspected underflow: [min=0, read 4294903296, written -2147483648]
temp2_min: Suspected underflow: [min=0, read 4294903296, written -2147483648]
temp2_max: Suspected underflow: [min=0, read 4294903296, written -2147483648]

Thanks,
Guenter

