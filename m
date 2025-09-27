Return-Path: <linux-kernel+bounces-834882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3847EBA5BE7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08817B275C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772782D662F;
	Sat, 27 Sep 2025 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWet3fah"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E762D6625
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758963997; cv=none; b=Y6BqcI3Yr9zrnb6AvtyEHuIfySGQXY74sjLmKcKw/XHQPrdv8cWARUKbkDUhlLNZ7DvX4PtIZMaXpGQQ7qq70yvcSEbgpKDKnqu7Z96OS7bhCoOujGQOX2L5NHEbuS6A9GYVA975p0xa8Ds0nEsxhppCDfmmgyIjwlJnQpPSlN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758963997; c=relaxed/simple;
	bh=o8u/sHbCGiIFmGRl8TRX2/l0CbB7CJw8el7xK4OcSqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGjxmnkDCpd8r3P7KIEkYIuF7u7AZss+ImCti+LOD5fggTrh+QJrnuAWpGdk2mSwtL2uuOvAx5VdasabszNIikn0inL5rWlEyS48mreSDDFbHt8ewefFlI6NUPepy6o6COmEgsXwGCAwUeAUVPbYLUB9tLcEfnqGNDrntPnrI6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TWet3fah; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso1586985e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758963993; x=1759568793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+MIeflv6TTn5FZ3EPIVQ8V67i4OTGQJGA3Tvmnh3P0=;
        b=TWet3fahbt0aB+Qhx2ZgXLLRK4zsCghReNB+mAqiUAnvAWj/z5xYyr3FDmboq38bk8
         kdfBf1r4X2VzXv5WlyWhIByAcz1wzmvY8LHUCMKk6KhnU2Q86YrwKeTl9clUtGGEDf9k
         /mL2qjJwhrxZFiRmIWw7NnH6DY3ig4GsHbnUXs3w7SrwdCg95zObfxlcYeE1fHfWnSvY
         tiZocVeXje0zGlvKWmUJLjutzlJL+7q6GVqCFZWWX0cKa3bI7uPnBkcFGeb1SRTNtpyA
         +39FEA6stOK2TQpW1liFd5tT7UEoHD/2dqfVKITh0q8WjaX2DCN8QsSe4OEZg4gT04G7
         CmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758963993; x=1759568793;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+MIeflv6TTn5FZ3EPIVQ8V67i4OTGQJGA3Tvmnh3P0=;
        b=YLgvf/dXsDOuWyp+elMCC+75AP8L7UOEqmT3s+X4f4sdIZOib7KKFA1ThEaHiagqEP
         r3yv+YrwUT8xG8I/eSaUGcwSuvpG9DitDoFU95XstK+/r3YXmZHXgUqyOED4moOypADx
         8qLKtPTBRx9VwdO3ipWdvNRJXCCLp7cXSIPJvAzFZElOxKM1q4JQZkjBT47HotCAnenm
         8HC6pye2uFagB5ZyAMNhw0eSG0NGqgWYYN6tacFGW0miC1WW4+zvhAKeZeRd4IiS0I9H
         3R8K8+wMnwpgdFVS+Sk2fKRW3kMiRRHABhTPz5oy0ySytnoDwJ3ZdvL7zYwRB+5EWzkT
         EXVw==
X-Forwarded-Encrypted: i=1; AJvYcCVkk/jwcYtxjJjaqvkswowMA/B5UJ/ONF/FKz5NVKAiMSvWzoK8vcJFmK39ql8uOvG/SiwPFvP8FUSUyMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxba5e2nUQKXUor0BdndE6Wcc3HipJWlec9cOnqvVAda0P9XNQb
	t79dbJQl0D6gJJN7xpVMYmGiGxXwiOuVYsaFEaJ7WcQp99cxnSVdYhfjSOAu0WMRC4A=
X-Gm-Gg: ASbGncuoXrqD7HUrHGV2Hnv0a1BQRktuzzOEnZv1+wKoaSDCUjQfwKh+6WPajxRuJf3
	0MhWznfOUzH8iRQAvYgs7y2sM8dSt3HVFgGIlF64S8VMhjHeaXITvxhTKP94wCJUXhhNnEezm+D
	0UHuTD5yJ6/cTL69NyvNOzvb2BuiJxww3MGPzjZes08L0O1CC+FW9jNPCOUx6MZgNZwMXzQKsd5
	sAuFIPuqph+gRYCxuvJIhM9WM5dAgVKxml3YGh5gXiA1VCpvrQAVLtA5FoTd1YnGNEAuAi28LzS
	guPitFA8HEvEhgCg/cxmhQc/Lkrhi8kmDLdaB80MqAvjcDjIM0gBrZx581oq22tN5RdTN3zSRTP
	rMBInrJ8M6h/pemAUnbXnIt0Jeqx01BqMK6hRIn4AZA93AozZKgaXhpDKfqlUzhKW7GJs4tE+ss
	9DIBCGCvqtylvc6iFyfOWL
X-Google-Smtp-Source: AGHT+IH3Xb+fDCcZorZOPmoD6Ji6lERHaHPkT5e7+FZs5aHED5mCbT+IDMueF3ssiZJPiQN8+Bs34A==
X-Received: by 2002:a05:6000:40da:b0:3ec:4fe:860 with SMTP id ffacd0b85a97d-40e4cd57776mr8411353f8f.46.1758963993037;
        Sat, 27 Sep 2025 02:06:33 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc92491efsm10414294f8f.62.2025.09.27.02.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 02:06:32 -0700 (PDT)
Message-ID: <855380e5-2141-4ed9-86c3-53bc2a096efa@linaro.org>
Date: Sat, 27 Sep 2025 10:06:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1-dell-thena: Add missing pinctrl for
 eDP HPD
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Laurentiu Tudor <laurentiu.tudor1@dell.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250927032330.21091-1-val@packett.cool>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250927032330.21091-1-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/09/2025 04:23, Val Packett wrote:
> Match the change for the XPS 13 (a41d2314) as the board is identical
> between the XPS and the Latitude/Inspiron.

Same comment on the commit identification.

Also, are the boards identical ? I don't think that statement is true, 
say the "board DP here is identical" but there are GPIOs on the PCBs 
which read back different values to differentiate.

They are not identical PCBs.

> 
> This allows us not to rely on the boot firmware to set up the pinctrl
> for the eDP HPD line of the internal display.
> 
> Fixes: e7733b42111c ("arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455")
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>   arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> index ef83e87e1b7a..0aad80a1159c 100644
> --- a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> @@ -1104,6 +1104,9 @@ &mdss_dp1_out {
>   &mdss_dp3 {
>   	/delete-property/ #sound-dai-cells;
>   
> +	pinctrl-0 = <&edp0_hpd_default>;
> +	pinctrl-names = "default";
> +
>   	status = "okay";
>   
>   	aux-bus {

Once fixed.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

