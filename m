Return-Path: <linux-kernel+bounces-879309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B91C22CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22A374F0056
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8611A0BD6;
	Fri, 31 Oct 2025 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftCtbTX2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7AC16CD33
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761870770; cv=none; b=bPRK+icjRGCe0MplDKh+z9Ik7A136oMqrCElhVoQDH3O8N6hZOJk3xTSA1JOq61dEBBEXkhCTpil7c6ycnA/17C2KlO/84kYQkCvzZhD1KNZEyzCiCt2b5KPWJ39tHhyAuwuVztPF0nkni1QvaxzP+CvF6eb7wK0rOy7Ti+EOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761870770; c=relaxed/simple;
	bh=h1TLH+nEjFU2KXBp2iIuzuSAxG5eFA8Sa6aoePIEORk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIodrl/rTzeU3hbkzQKHVihOq6b6YGslE3jV4kR179Qded3aRS8EKTN2V5xiU/UHDKJ6hdFYD8gwtytgCnOM5xLkNwbcI6ZFGNlKfNwYgzUzLrmtgR/F5O95TW2NNDIfVFuo34aS30j6+a0TULV/nN+SSH/TwqRYig+mKXh+gBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ftCtbTX2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47710acf715so8712905e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761870767; x=1762475567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4WS+57LRAe2z3W3iH5ZoI+GUsCAS2zPS5JkdO3F1cjY=;
        b=ftCtbTX2hjWDOlZjUkKp/iQfqDg0UJ+QC5uAjzU6PCOwbjXRiYYxENCmDA6akQ1QW6
         /oCL1U4hIZJRmHmuyRIIuCy/1WhV/tKzPLHrvrJQyRAGeVhhwsyIldQHcH6HmMToh2Mk
         fZ4yHJV6GAnSgvGWJjYxUeQJJbc04nuMqmfDOthgHP2AmjnltSE7leBh/l6d5DwaRCYA
         Me8l22AmNyaMOk6tsAeiVmDJiYglFmC4RTerIALbUFsF5S7oiw6fOYeRz54jKjyPxCqh
         LpfvGxPq6K/u0AawEscsxbVohKlcdKiHvzcO3KH8bN2wUZZjiBploUJm8uYrfUqR5DW2
         mUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761870767; x=1762475567;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WS+57LRAe2z3W3iH5ZoI+GUsCAS2zPS5JkdO3F1cjY=;
        b=wEuGFbnOnH9tTYg1olJUUAynlj/hELp5v/fZDX2c9Gbl5S1LaqaN1CR4zbEIUXEbwH
         IAFmLrjZfNF9QxtCZ0TaC3gaa16aJCZY5cSV6rgVxmBfJXm1NvUCBxAlzJQ39zi4TTml
         sWhtvqXYlJHmdxSn5eDeKfIjdDi2oKPJAZO6lFwypr6mYHX7PeDc15o8X32JDRZbVU2e
         LK1BY9MvRlk4M1ZvL5iOjc8sDR1J7GY21iVtDiJSkixPiafeIbdG16VFqNBSQb03KTGY
         JOdVc1eh6dURKpefMzGGskH0y8kcB1NOJjv6WF3P9zhq+hPSUYhFnQPvMJseXTSw0bwP
         3+NA==
X-Forwarded-Encrypted: i=1; AJvYcCXuQ4+nAOJ05PasYBcbbbuPuykNBmU4pKRr19YRIHBkyVq9++C+Q94j1hyR8FNbEqHXJ25t1AH/KdyJPuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJNx+kfXj05Zty216vlqmVgNg6bVg27btP0OO76bAVY+StXw4s
	B03gVbVCLVoJ08ORqvH52TqZlAtmbBoDpJA4uugAwwsJ+T7SJy/wKens3Dz1KcUZ+pQ=
X-Gm-Gg: ASbGnctw4Q1vUyrq0rpetB/zB6BEbx4tjF3LM0UV+/jqDw3Sq39Xw9A2MYME/bxqI/2
	p9Jp0ICxxavJo7hAA4ZkOCREqaqNn0xEP02udUBhhuAmiBGYV/qJ28avj9rudnqMQOpVz4T/KER
	zXWk9m3MviFYxXjQKTTer+KExD8wWvAqZNU5jfwJlAoymipc+5hWqQWwWq9qliwMqtHG+S5lnZa
	65+5W959MB/Qh63oaSeq/m7B6gCtbp/Fx6nRdTeXXBj7Sh5HL1gvxEkNzwwy5aRWTF5Ums72gww
	mycRcmqoKr+nG0t7xU2NsEftcFhL6SuxTFOa3EGPuF7yhl6YAMOgSbhLdRa9YYljSDNJaAw82kX
	LVNQ/4rASwLcXQ0m7P+615n5vslwT5BIgdjyWdZ/7M4Y+aR/kBOHsi2z8kNSz2cWYuJ66JncVvp
	9NsruKXYOehssglL/UvDFXRpy1kJ8f5o/cWJo4PLtYQ0cYcxqCreud
X-Google-Smtp-Source: AGHT+IH6S0BGPSLesVEJyyjn1HKh+/PSEyTQZTdOC1ozQ38rp8QkhnHJnaRNW4UulaFZCitT1zs0IA==
X-Received: by 2002:a05:600c:1d9b:b0:46d:996b:826a with SMTP id 5b1f17b1804b1-477308c8b64mr14997905e9.36.1761870766940;
        Thu, 30 Oct 2025 17:32:46 -0700 (PDT)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728ab375asm65700185e9.17.2025.10.30.17.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 17:32:45 -0700 (PDT)
Message-ID: <536dd549-739d-4c79-a46a-e373b233aa4c@linaro.org>
Date: Fri, 31 Oct 2025 00:32:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] media: v4l2: Add description for V4L2_PIX_FMT_AV1
 in v4l_fill_fmtdesc()
To: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251030-av1d_stateful_v3-v3-0-a1184de52fc4@oss.qualcomm.com>
 <2RL0oNzhGU62slpUlEImZNc7UKB19dBLEtchBiwHw8taKSKcKabsuC9iZIV3dWKfXF4UyIdNmspnQ3YpX4pk8g==@protonmail.internalid>
 <20251030-av1d_stateful_v3-v3-2-a1184de52fc4@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251030-av1d_stateful_v3-v3-2-a1184de52fc4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2025 07:00, Deepa Guthyappa Madivalara wrote:
> Add a descriptive string for the AV1 pixel format to v4l_fill_fmtdesc(),
> enabling proper reporting of AV1 support via VIDIOC_ENUM_FMT.
> 
> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
> ---
>   drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 01cf52c3ea33e1a01e1b306036ba4e57ef5c95d0..bdfdf45c5de2f2ce885f219007718a54b5c86251 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1542,6 +1542,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>   		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
>   		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
>   		case V4L2_PIX_FMT_AV1_FRAME:	descr = "AV1 Frame"; break;
> +		case V4L2_PIX_FMT_AV1:		descr = "AV1 OBU stream"; break;
>   		case V4L2_PIX_FMT_MT2110T:	descr = "Mediatek 10bit Tile Mode"; break;
>   		case V4L2_PIX_FMT_MT2110R:	descr = "Mediatek 10bit Raster Mode"; break;
>   		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;
> 
> --
> 2.34.1
> 

You've missed accumulating Nicholas' RB btw.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

