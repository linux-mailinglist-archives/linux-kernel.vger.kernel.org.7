Return-Path: <linux-kernel+bounces-759993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C493B1E562
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0A4188D60B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666F25A353;
	Fri,  8 Aug 2025 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJg83/Zu"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E8C1E008B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644294; cv=none; b=p82nVvCo4bswWUDIL0y6+j2zM5x/x8ezWaWHPIbVdt1L3HmrFRAKcM9kVwbl94OiZY3gXNzdOGSuho5Sx9Os0x8mKOpA2nZs1s9gJ8r6zyj0En+K3qLlwiPYFivXunT7I3kmCNrlg3JI8Q5Z8zQVnRamHn3OR5YxQkvBB8h04Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644294; c=relaxed/simple;
	bh=yO5R5g4RRRQ9fylhV15S4TlG43LV0nzy1cjPY86UEqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFqVa6XasPLQoJPjDHHliiWqhU7csD6BMvIDK/AJSp3HdTlG0RUmMZfwznE/YjCOYKiZcxnSW7MW9d+q+xIpFkS2wwCiQ5xfuL1z0RqDAomJSnh54Go5d0MlleVbH/prrUJ/NuKQ1UdSVe+T8zoRvN8e0VY8bRV+J8UXy2nccn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JJg83/Zu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b783ea502eso1459871f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754644291; x=1755249091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQHZz2yokMkgkwlKNquoPo8xw5GL1brCMiREVSCGCgU=;
        b=JJg83/Zu1uZJYskpUVR9qjcGv6WphJLWnmEyrMtPPOUSHWJ0wv9N4tWLV8uCWx4quX
         RgK9bA8oaHhfj89/HDePBmCzFG8OeG131mBhtT/0i6FutIZKvN+RvZNp7dCCG8dOxo0e
         JPHP4ebN/+JgBKt4m6hTLgDmAJry+n+ft+DZ0Zup6TV/Q4V5QtZmLjblG9MixK9nFTS4
         5PoXsyTkZZ3fv+FtqEKkvQ5mw/iCWoyqDM86qGDlQeFqXW/evSyUz2epNRfmVFJKdhWX
         bpC1HiH924dmKpsFgHTJc60GRepFOCSAw3r12EYJnjVG9hbFxWTnqCaEupb58l+XXD4b
         CIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754644291; x=1755249091;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQHZz2yokMkgkwlKNquoPo8xw5GL1brCMiREVSCGCgU=;
        b=NLpP21nk7KLRKg7pSRd44YReHpn47Edat0Tc4wbpI3QwUM3g1xbz8fFK4Xd8fzWhbq
         koZSaILWhS3R8R/2USnDlETF6LHdrIMOoFwz5S2qoJza02Gi3BM8UgmEFgaGferEDEYs
         FBDdiGWeOZziCH8nLKnLBXh2jW40HXKDm5fx+LabtgVdNxwwrCdBbSLa12FgVdlYfrVN
         EyJKQ4X4UX1fSTJmK4YPIAZqYvL3MWm3fVbCMKT85wZ1XnelgoTi6Ng3VAjpWMQRr8V+
         l8KaAFQsFBt5JRrvsryiI1WJV8XHyo7dXmggmRTGfJVjvc87FXEzxwnZUGMWUh+rBUn1
         nNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFLMzFJHWz+7FLPj9J5yWb6amOmNkfUOm8Ycvxqlu36ne63Qcsj8OCZwkwO87heJmThyrlN4zqRPeSSF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGI9E5019LC95cDeKtW5ahceuWbdSusk0HueTOXU/57rBjYfO
	BcpWxKARnQVz4jhmX+xdLdxhMruftoMWnGKiyIFHNyjUR3wnxU5Fg6fk9uU4vpk6r1I=
X-Gm-Gg: ASbGnctsSSsNfBYgIhqcK8OtjQ+Cr1ZhhkAX/xIzZh8mo1tqm27yA0VfrijoJm0BRTV
	LIUv+xOo3QJ42yc4PMMKz4mqkygxdA3ZmWpSbMXpottrT51t3w/r6AtyQVfDzijob0gmDWWhw0o
	ghQQR+EL5tD9bOS8RrOi9kaSL4TNb/fZo7JRzf3Cg+JuvVLyCMi9rtKu1diqKtQdzYX0lhLcREI
	fMM5kh1wGSNVdOk13tA9pksUYynKIKwFSIrq5TyfyyishVs8RTG6QCs7Kog2zR6yUlswrvZQodv
	KBcoltDZR24vIwR+a+dkgqTHiBOHzp9YNPZmo0jMotbJ6Dk7t30jE4w6fp0ccGJKAZxYzZ+HBTu
	j0yJQpKhD2OmI6bbCz8x5NbIKVb8lDwbRwGCjGfnKD3BpFZsYSe/VXDPAcuoxqnY=
X-Google-Smtp-Source: AGHT+IHDbCe6jjj6r9hyHFmBI+bqB412fjCUIPMbbqAd89xsBc/7FSoiXU2imCpUAZvEXTUCmX66eA==
X-Received: by 2002:a05:6000:40e1:b0:3b7:8842:89f5 with SMTP id ffacd0b85a97d-3b8f97bbfa9mr5683297f8f.1.1754644291208;
        Fri, 08 Aug 2025 02:11:31 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b501f22dsm165801695e9.0.2025.08.08.02.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:11:30 -0700 (PDT)
Message-ID: <343c1606-75c5-4b2a-9d45-160a6a8fe255@linaro.org>
Date: Fri, 8 Aug 2025 10:11:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/8] media: venus: core: Sort dt_match alphabetically.
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com, krzk+dt@kernel.org,
 konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 mchehab@kernel.org, robh@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
 <20250808085300.1403570-6-jorge.ramirez@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250808085300.1403570-6-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/08/2025 09:52, Jorge Ramirez-Ortiz wrote:
> From: Jorge Ramirez-Ortiz <jorge@foundries.io>
> 
> Correctly sort the array of venus_dt_match entries.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>   drivers/media/platform/qcom/venus/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index adc38fbc9d79..9604a7eed49d 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -1074,11 +1074,11 @@ static const struct of_device_id venus_dt_match[] = {
>   	{ .compatible = "qcom,msm8916-venus", .data = &msm8916_res, },
>   	{ .compatible = "qcom,msm8996-venus", .data = &msm8996_res, },
>   	{ .compatible = "qcom,msm8998-venus", .data = &msm8998_res, },
> +	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
> +	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
>   	{ .compatible = "qcom,sdm660-venus", .data = &sdm660_res, },
>   	{ .compatible = "qcom,sdm845-venus", .data = &sdm845_res, },
>   	{ .compatible = "qcom,sdm845-venus-v2", .data = &sdm845_res_v2, },
> -	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
> -	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
>   	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res, },
>   	{ }
>   };
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

