Return-Path: <linux-kernel+bounces-877832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E47C1F26E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF42D3ADBD4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C4335BAF;
	Thu, 30 Oct 2025 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPK/RhRK"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31D31E0F7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814514; cv=none; b=ghwZubnD7vKC2WnOGuhpS1oAIKn3o8pIHHxlZZPcOBdKPLDVtrEk4upcLZTmBRurLjIkcni7rxuukhEoBCnznv+MhsNPJGU7hc5z3bUrRNfl5D68+YmmLH5eUWAByh6Fv6uo0zqfxisjb4UOaSivyDiUlvSFZG7cGYHJ7IMewwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814514; c=relaxed/simple;
	bh=gCe206Sd+n4icVwxXqzoKWpmtTKswWt6dHVdlGTXLL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXKHITAHlI8nb6i8l2EconweQvF+jPN/X013FyA24qOdFg6eZV0+GJNmBwexM+SLcRc4x7kiLnA32nHZ9bw//MPG4/edz5F8HUGX5vASFzV0rvQUdkgww33t0J3Vxg2UvcdDnpRCoq+hdDKfnKTQMQf8U0FPbdXtzubyXE35+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPK/RhRK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-592f600acb3so1099243e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761814509; x=1762419309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lz2wxKaeXnztSBPHZVxZj1ui+100tXbJd+q75YbpezI=;
        b=KPK/RhRK0x83sAIcfz0EM6H0+ohjc14NdkO58r6e7PfZZLFePhIbo7kyfCsHz+cqnN
         dUVbemeR3N5Wr9Z0+knr/qBwkA3N3MaRCGuI8Q/zpc/Jms5ekavF3a4yymL/VWGUb9S4
         IsjMA7pPtIicTNBqmo7xJlFRxkgBZCaWqmHKZ0at22xXg+aLe/uj6Jj2hN3rYN1D1iOM
         2qcqSP8kGdhudH+PANjovIQ8lK7M7eDDItjjEtlDeNR80CSM8f4xTDGyacZ5ZvfOp1Rd
         DOkquk67gQtvjkIas2rSrPwM746LBUKSN8Tp9QbTowoBvNnJo3m4+fUZIrPdobPQreQr
         d1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814509; x=1762419309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lz2wxKaeXnztSBPHZVxZj1ui+100tXbJd+q75YbpezI=;
        b=tCzdtaB/QQ1RJiG3cOdtD9ndC5wJMq/97idLrCVbmubBv8TP6LYePrzH8aCj7Cvd5c
         iLb8HhHx9xTb6jP0ZwHhXojAEvrG6EVMS6bZSlBlBHKIOsMJXlhL0ARgDZC+Rn/urftO
         n3JuKMdJb3uSWuiYEU1vrpVB/CJBJWvHwRo6Uju7jSV6/FAZp4COrbFq161/j5WTbCfc
         Jp3mJyKCyeYqrf0eBmrUTiNHpseXwZB3cxhojKw4jUXusgTDXfFQc39l+S8zf2BOyNgP
         hwXYIdbKUHCWl6eYDoo1/05k3/6UFQZX7iY9yTr9rxJYCd7Xv5Huf1RT7fpGLbvrIECF
         z4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWQETPeLjDwtJ5avz12DTAe3FhLWAQfdy9fBE7B7E7j5ySaLd6IpVVsnbAkcwDeG+TMJZYKqv4z3jWNAqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuguEO+yBySO48TpcE1GoDlGUp8k6scko3WfS1/YEb2+8ydZxM
	O0yYSPabaikz9ot0Mn7EufXiImR4CskRT73S0GTYHeov/fa3vS2J4HmC
X-Gm-Gg: ASbGncuQUZ1ZNmVVdWZbu/pgvWQ3lPSJAzVqiqvyf+WxWug3rpGJWHsKPInttm+0HBb
	MyVAQ6SEpP+I5SzYG1X+UCdzzdp/g6BSzP/QYSj5rDNscflDEZEf9iKfqfU+1Czq7Hu2883Kqtk
	2jZNIJw3aPNB7b4lC0+xSjpzdPD0BI9JP03TFHSMa4Uzq40GXBggQYJOsEx5c+Sg8/GBQOnOOPZ
	ED5ge9AL/Om/lqTc2DH/iwPuEgwSJNeoVnBRlUHHh9Z0syJtfriSFCcC7d4H0ea/yO6mruPGx+B
	BE+U6YQHCCiPLLuo/VQHhvsUYOQWnrytzbu/5flN9rLI3ojgfvMsY0/Iw3O3sfrvN4hDhS21SjJ
	wV0HEBEfiShQ2w+AQGbTwl9lZVKUPDnl0EHV4iajo7BQQ2QtJGZL7z52EqxlwdkZNUee/71WZfB
	9TKI1AtZlW+301EhFkeQcljiq+OCYKrLf8c7zzzftb5BrZo9QBb1jzrgxIbg==
X-Google-Smtp-Source: AGHT+IGxefDaDMkvXf+C6MInrLdPPOS2BAZ41RZb8shvZ6Cg4IwpRXpVQvrD4g2MHSCgteFU4nxUAQ==
X-Received: by 2002:a05:6512:b8c:b0:584:2746:c6d8 with SMTP id 2adb3069b0e04-59412c424b5mr1969364e87.29.1761814509186;
        Thu, 30 Oct 2025 01:55:09 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941566452esm866246e87.8.2025.10.30.01.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 01:55:08 -0700 (PDT)
Message-ID: <8fb5a1a0-96a5-4830-a9f5-4e624ac806cc@gmail.com>
Date: Thu, 30 Oct 2025 10:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] regulator: bd718x7: Fix voltages scaled by
 resistor divider
To: maudspierings@gocontroll.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20251030-mini_iv-v3-0-ef56c4d9f219@gocontroll.com>
 <20251030-mini_iv-v3-2-ef56c4d9f219@gocontroll.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251030-mini_iv-v3-2-ef56c4d9f219@gocontroll.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2025 08:35, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> The .min_sel and .max_sel fields remained uninitialized in the new
> linear_range, causing an error further down the line. Copy the old
> values of these fields to the new one as they represent the range of
> register values, which does not change.
> 
> Fixes: d2ad981151b3a ("regulator: bd718x7: Support external connection to scale voltages")
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>   drivers/regulator/bd718x7-regulator.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
> index 022d98f3c32a2..ea9c4058ee6a5 100644
> --- a/drivers/regulator/bd718x7-regulator.c
> +++ b/drivers/regulator/bd718x7-regulator.c
> @@ -1613,6 +1613,8 @@ static int setup_feedback_loop(struct device *dev, struct device_node *np,
>   				step /= r1;
>   
>   				new[j].min = min;
> +				new[j].min_sel = desc->linear_ranges[j].min_sel;
> +				new[j].max_sel = desc->linear_ranges[j].max_sel;
>   				new[j].step = step;
>   
>   				dev_dbg(dev, "%s: old range min %d, step %d\n",
> 

Thanks a ton for fixing this! Very much appreciated :)

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

