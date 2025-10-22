Return-Path: <linux-kernel+bounces-865497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E6BFD644
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB123B97C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1FD2C15B8;
	Wed, 22 Oct 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOujWUAf"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AE238D52
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150118; cv=none; b=NqN3rOlEU2lZoQeOQzog5eMMGz21MMyHQmoFK98b4QBKeicGvkYwDpPoelFAfpJTKKqJktCrQxtdY6jW9g6srNgLUJxLpvJ/asegJYVbggAd7P95TMIPx8DQ2wpBXSPH7zBfcaizUH/EASVyypU2vVNnUuJddtxyjosr1lXVB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150118; c=relaxed/simple;
	bh=dSd0eofZC3/Gkt8gKUfgpf0S2itiPDG3Tf4+Ys4dvXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlDIAZofqi8wBnI6OS3T7HLBZ2hdHqL/uLuAaoy0PDfeooDBtYnbDMvBkGizIJ9E1Hh5wfL0K8ok/Qze62i0dzLBK6DaOjwRgRHAH2LrGVp6wA/ts7wb7Gi3ZNNQp43frYnt9+Y4ogu7uT5+nucgNajOJTTpKyRQMX4zowU4NVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tOujWUAf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b463f986f80so1374371466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761150115; x=1761754915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjUmK2ozECz3lbsSt7T2t2Gcp1s3ZfK8yhq5qFhNE+w=;
        b=tOujWUAftPmFCw7qcVsMKHt68AtzSB2LIu1Su+CiaLFq/1hoVGJAwOpU5XZe8Lwe85
         JcskquNycN9Yvu2OY2Xjdv/IUKXGQAZ3OopXqvgLZeVfvypEL7szoCIWYpXwvZwm4g+E
         uMu9VxXW+4ByoTuv8Ibi5eDXRDIVgtDBXqqeqziBVB2KFAvVFMaifhlQ79deSTpyATCg
         arzxJgCIuZzuqHyEflXgq9O4E1sB3qTKlfMO7WUy7b1Y/pWvT5ZGm1p6qtsY3NM2ZVFg
         fwJsh/xnKC374v5uui4aQf+1Jke4z/Y3g7pxDTGHhP+bztNHEWfINEOlFP9J6w23vcr4
         t8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150115; x=1761754915;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjUmK2ozECz3lbsSt7T2t2Gcp1s3ZfK8yhq5qFhNE+w=;
        b=EriEtnB10opBZnjS0UZ4tnZA+BFVcOk0nqeuQYjL1UzDZDH/s+/bmogL1hTjC4l128
         Cx7IhOYhJhGf64KOHo93r3y6hNfhQr1BtYdPFY7NTn9zSvx2Wom6y70aaTVHp+EGpNxM
         NpXm9Z/e300ExW59JtcFpduYWJF4ESH5MX+PfOVjQLiG9hoIvwDjA317h6B0qGxAmTzK
         jrhlaXHPyvm/CmmB5QVuB9hYSLsvB8ujQdUhAmooJlaJGK1dTQ0pC9KrpCyetGQz7B3b
         IcwxHPUdTnwYbvGzMbISC/Tb7cTKrr9W2Z/jG4CLEHMSEOqYIsE2UWsCBC1hZnj1Bvjr
         bWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmhAiZE9g09RBa0M346DdjwsqyeMT4UF7swPsgCfGf6ksPjx6bW/30j2QB8WUHTfemhBtyITfjt+uh7Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlTPWwAkGeURoyWJhTWiyQaGesJiuVpxoCzwe3+K9wAiAiG5bp
	Pum9+5QBSrPimQMgfr5ALyzri9FPpdei9DnZg3r9FZgJayWmp4UvSTgGGTfng6a5+sg=
X-Gm-Gg: ASbGncvc1ZG83z8avcyiBFS2v5LROmDWsHqGXBPhw+01Rnhum6tzCNqQ+NfJNPM4ZFR
	JxkQwHK6mld6SuL8GziYliwTOBvlqLKC7XK10jcaYsOfn+NHqkuWP2Vzs2whmur2F10nyhAJBbh
	zub7+MJHDg9R13y2+y/iYopA7UlOt81ONnMvXJJ+L48u+KTeFPrYhSNZxzV6hqhdlEs48W0ln/M
	Y5XGSXE+igyN973WvVaLNcUX0HGrQqtQAvxRM9rhYJnZVE4RcYCtovp7Vy9amx94xOQB7wS3Giv
	Ba4akCjDlXv09kYI6Z2b0EHlcoK9scjg9ofqkdL3cpRPRX0PZHh6EEFqbHf2rRY8vtB2qmG/7qN
	uDrXoM6ZG6Zy8d17Hz478itxzA+42keNjgqfH4e/UbMXEWYOqEvC1cMsKtgeHHzpN/R27LY5OBQ
	EX8sCuhP5nZoN2tJVm8Gqop0bS5eevXDXJ0gfgstsJcA==
X-Google-Smtp-Source: AGHT+IGYChwhuUEGPVHCLuRk88XLXPKT4H0pjkSRx8SDm4X53gF3hPcQE6y1DcQp5mZdYfFKZ8VvaQ==
X-Received: by 2002:a17:906:ef07:b0:b45:33bb:24f3 with SMTP id a640c23a62f3a-b6474f182f1mr2501488866b.44.1761150114810;
        Wed, 22 Oct 2025 09:21:54 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da1ba1sm1377700166b.14.2025.10.22.09.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:21:54 -0700 (PDT)
Message-ID: <5ff5bda1-246e-406e-a07f-6ae7e8f468c3@linaro.org>
Date: Wed, 22 Oct 2025 17:21:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] media: imx-mipi-csis: Support active data lanes
 differing from maximum
To: Isaac Scott <isaac.scott@ideasonboard.com>, mchehab@kernel.org
Cc: rmfrfs@gmail.com, laurent.pinchart@ideasonboard.com, martink@posteo.de,
 kernel@puri.sm, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, sakari.ailus@linux.intel.com,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Frank.Li@nxp.com
References: <20251022102228.275627-1-isaac.scott@ideasonboard.com>
 <0k5cPW5X5XBAPEI-utRwsf6huR-TBzPWKNIFiDo0w8R8qHEtZDcBbkrDaG-ZSl7Hts8VXGVOY_F21eKS0lIcQA==@protonmail.internalid>
 <20251022102228.275627-5-isaac.scott@ideasonboard.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251022102228.275627-5-isaac.scott@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2025 11:22, Isaac Scott wrote:
> Call on v4l2_get_active_data_lanes() to check if the driver reports that
> the number of lanes actively used by the MIPI CSI transmitter differs to
> the maximum defined in device tree.
> 
> If the number of active data lanes reported by the driver is invalid, or
> the operation is not supported, fall back to the number of allowed data
> lanes.
> 
> Signed-off-by: Isaac Scott <isaac.scott@ideasonboard.com>
> ---
>   drivers/media/platform/nxp/imx-mipi-csis.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> index 838a1ad123b5..637ef6e614fa 100644
> --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> @@ -1034,6 +1034,10 @@ static int mipi_csis_s_stream(struct v4l2_subdev *sd, int enable)
>   	format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
>   	csis_fmt = find_csis_format(format->code);
> 
> +	ret = v4l2_get_active_data_lanes(csis->source.pad,
> +					 csis->bus.num_data_lanes);
> +	csis->num_data_lanes = ret < 0 ? csis->bus.num_data_lanes : ret;

The function you've added can return -EINVAL;

Isn't that a fundamental error at this point ? It would make sense to 
trap -EINVAL and refuse to go further.

> +
>   	ret = mipi_csis_calculate_params(csis, csis_fmt);
>   	if (ret < 0)
>   		goto err_unlock;
> --
> 2.43.0
> 
> 


