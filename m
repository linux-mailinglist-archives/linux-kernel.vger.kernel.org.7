Return-Path: <linux-kernel+bounces-748049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EEFB13BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B605317B5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB0126AABD;
	Mon, 28 Jul 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhdH6p9S"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25614262FF0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710577; cv=none; b=Q8Hu5MTYnygyJfAgoGbkNTushBnBFeP4iANdO7UsAVFR0J7IC6/yuXduFi+YKrk6IHN/AWeEye+jbIBrPgr6BL/Ndehp4bOY+3ekjt3IOAn5E3wgRP2LJPN8e7mBRzcWasGfA8wnsGyfcsDi74lkIAeD691/scRRwlYcG/2sC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710577; c=relaxed/simple;
	bh=gD9Nrukl5V8j4gMQt+Gi7qKFR1sefM1ZFzTUiaCrRd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awnGdwtmb1K6Rcy9ODBCHEzdRMj+yw/0CQomvQCk+Nw3pWUyYoi49ULI9FaTEMzuL9XurNUoUrl4GJo7K0+w3bxK87HEDgQPmzo1KnHxn5pBTCSvaHfKgEA8ArJqVZi25kN9zTK4vkLloiiH6fWAabwZI9ecWNk9Es6MK79i4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BhdH6p9S; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b780bdda21so2124416f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753710574; x=1754315374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n36b9ILb11wJVdUKrW9GQVceZTen+jKpbT7ykNbDKSU=;
        b=BhdH6p9SHPjBBvUhmjf5Ncd2ptSrTuceqnlkrsJcJi4MlVqYMn9v1YbPCnxgEiFdsE
         KPRZGeX4WkDJV/90prs9UOylpjDvdhSU4lMKCC9SJyry14f+V13O2Xh3HkpjajVqYGIO
         zLekLaXXa/+iRYllMbMryt3bq4bLfenlCCcTwejQbqAqpbjpGXnO9g8keC8mY6GgYPmo
         UY7Q2jyIGo5Z1apD6KERe9qgyKMTtPhS2zgmOmFKIFMMdy1EkeesHcqyLG4+OnG9T6aW
         97w/9N8FjG9ZcyShe7IqNvVPu3U+gtDLmINIU+zm6T7ypgWEzI0lqGlOqArxupd5n/68
         7gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753710574; x=1754315374;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n36b9ILb11wJVdUKrW9GQVceZTen+jKpbT7ykNbDKSU=;
        b=wGNvXhfzApqMQ3IuYguSRoit79TYh0QzLtXxxrMyASnjNaNP+8POu2tlZEa3dVOrTI
         taM+pTe6ROC6T2iECMHVMvqbPVUu8wrN1URdHQjIWlfMsDbrDTcqDva8soahXyVV6sM2
         gHFBgcJ5wutxt7+/mvUo2QKs1GcNzQwivcIY1EazFeCkfDE6tGWWXa6jxtHzU5s3X+cT
         yBDXeS/ul5IQCjv+umprKLs9lcCnd296zBPP7ue3gLPVZbkn/zuSuMh1nIA9tmBhTIQy
         UMOzEdOovY2m/rvZ2Ip0MEEyV1ORRLtyTmzw0JRgW0lY04dQ1qL9XDOpZ++uDdufbuQn
         5vXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOihanwc149hXwGcwIHoGp3xpqAPnclHDJSA03iM/EEtnswvU+JLr8RlIlgnIBdTlL1AqFma9/xA2lfK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8S5wCF3akdiqK7WkZ2nAdgZ0d2Uu59QTBVX5abKtzB8/SIrE
	6N/cFIo24F6dauju6FRQ3dZdlEgg8EDdAf3KD5VF+JN/c0lM2GgeFXGy1JxECN7I4DA=
X-Gm-Gg: ASbGnctM8NSb0zGKolUXEldCvlF1dpzqjjZaI5Omun54kaB6eP1xUC0ni4Br6VHGHBx
	C5Pq2eyylu2zoWR8QAHFbm/JkYrPLd1Q63z6l4XWswPrNDdaqS1od4WjQmcm4qO1mrhqUdKVGuP
	VEfavB35PoV+SZsdbf1+l+8NnBHOJdE0TqvD2eCeOMkZ8O7GA6kCSYssYYexuvYnbTQHv0Bwmob
	7BsfSJd7c3KzcgX5yk08O2095JJR7/D4Ze9UEMFVuaPX4YzjKcH35ZFEFjHbRMLDFciG3cWFaqw
	7q69RaIxd9q4wt3gEKm6iDc3VbeoXIPDKdCge+JL5F6+n8/Mk59N1gXDLDDS1FT0Ewtc0fDXc6g
	W6yuqmvEuaEcLdFqLjjNc07kLSU3ouaZWK4pY0MRamI/IiOe5adt8H+QRj0U1S7w=
X-Google-Smtp-Source: AGHT+IGQ2KHXqDEDGEp9BnTNFiPQGdAVT8Ouj1BVUG/QhZCfM9UZZgtqTuoNYoWMo1tQOuCn7aFqvw==
X-Received: by 2002:a05:6000:645:b0:3b7:7d57:575a with SMTP id ffacd0b85a97d-3b77d575a53mr4407496f8f.29.1753710574286;
        Mon, 28 Jul 2025 06:49:34 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b785258135sm5093611f8f.42.2025.07.28.06.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 06:49:33 -0700 (PDT)
Message-ID: <3b0e880b-b85a-442e-9ebc-377685794ef1@linaro.org>
Date: Mon, 28 Jul 2025 14:49:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] media: qcom: camss: Add sa8775p compatible
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250703171938.3606998-1-quic_vikramsa@quicinc.com>
 <20250703171938.3606998-6-quic_vikramsa@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250703171938.3606998-6-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2025 18:19, Vikram Sharma wrote:
> Add CAMSS_8775P enum, SA8775P compatible and sa8775p camss driver
> private data, the private data just include some basic information
> now, later changes will enumerate with csiphy, tpg, csid and vfe
> resources.
> 
> Co-developed-by: Suresh Vankadara <quic_svankada@quicinc.com>
> Signed-off-by: Suresh Vankadara <quic_svankada@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 23 +++++++++++++++++++++++
>   drivers/media/platform/qcom/camss/camss.h |  1 +
>   2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 310b5cd8de5f..3122a29891c2 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -2483,6 +2483,19 @@ static const struct resources_icc icc_res_sm8550[] = {
>   	},
>   };
>   
> +static const struct resources_icc icc_res_sa8775p[] = {
> +	{
> +		.name = "ahb",
> +		.icc_bw_tbl.avg = 38400,
> +		.icc_bw_tbl.peak = 76800,
> +	},
> +	{
> +		.name = "hf_0",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,
> +	},
> +};
> +
>   static const struct camss_subdev_resources csiphy_res_x1e80100[] = {
>   	/* CSIPHY0 */
>   	{
> @@ -3753,6 +3766,15 @@ static const struct camss_resources msm8996_resources = {
>   	.link_entities = camss_link_entities
>   };
>   
> +
> +static const struct camss_resources sa8775p_resources = {
> +	.version = CAMSS_8775P,
> +	.pd_name = "top",
> +	.icc_res = icc_res_sa8775p,
> +	.icc_path_num = ARRAY_SIZE(icc_res_sa8775p),
> +	.link_entities = camss_link_entities
> +};
> +
>   static const struct camss_resources sdm660_resources = {
>   	.version = CAMSS_660,
>   	.csiphy_res = csiphy_res_660,
> @@ -3865,6 +3887,7 @@ static const struct of_device_id camss_dt_match[] = {
>   	{ .compatible = "qcom,msm8916-camss", .data = &msm8916_resources },
>   	{ .compatible = "qcom,msm8953-camss", .data = &msm8953_resources },
>   	{ .compatible = "qcom,msm8996-camss", .data = &msm8996_resources },
> +	{ .compatible = "qcom,sa8775p-camss", .data = &sa8775p_resources },
>   	{ .compatible = "qcom,sc7280-camss", .data = &sc7280_resources },
>   	{ .compatible = "qcom,sc8280xp-camss", .data = &sc8280xp_resources },
>   	{ .compatible = "qcom,sdm660-camss", .data = &sdm660_resources },
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index 63c0afee154a..345479f6feba 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -86,6 +86,7 @@ enum camss_version {
>   	CAMSS_8280XP,
>   	CAMSS_845,
>   	CAMSS_8550,
> +	CAMSS_8775P,
>   	CAMSS_X1E80100,
>   };
>   
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

