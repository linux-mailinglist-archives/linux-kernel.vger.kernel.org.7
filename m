Return-Path: <linux-kernel+bounces-748225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA68B13E27
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516307A3BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19A2727F6;
	Mon, 28 Jul 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VaCNnd8B"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD741A254E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716006; cv=none; b=XgHK4whqmGS9zGUK/eT30sYHYEbhKPZs3yRmvQvWPg/o3GJ3X1sjA/afBaCBwFx0TWWrqL/BvRKW1pwRfffUOQiVRkyUzp8Jz8HkXyaXjHfszlvBp8aTEzk6eRf+wQnGz7AfziMbJU465zE61ioyce+anmXVbMmt+N8sOziE0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716006; c=relaxed/simple;
	bh=LNQzmDVPXFAc/zMEWuShx2jfF/wSMyxK4QbpQtkKNT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKIaO64iZSQRddq925cPMaPRnPyUq+qTZyUIR1a/cKeWSwJMI/co6BAivbiEOG2gJSi6ws113v5wfzCStU/ZVmwdDgF5BZHScjs5p+S+Jj8cOeyX3ZzIeeFBJO/wr5kal3+uSzQTssfyvQEZWiarkxY4QX3/WdOCYi1dAL67//Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VaCNnd8B; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so150229f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753716002; x=1754320802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3M6HADrcbiuvKh0/Kz/xLBlEH+H9X+k3yVRG8+8/+Q=;
        b=VaCNnd8B13QkdvW4H1B7XUKe7Y+5foeI89AyRUEBoGCNA1XvZrQX5hUN+CQ1S+oipw
         MAUVC6a8fwMRTk//OUP2+o0K1ZmgiWCERe+kkQA7HzhVXpy2Vgxt1NJW1l46Zkw9+vGz
         n7rtycULtrZuD8m8DjIvrEHuX3Y1wjZzmTDS8//AxanVbiAzB6YyhuDVWxYQtS6acU58
         6LIoE131Y5rsnbXohQyRRNGghQfUxjECyvEQ6sFENwUnzqY//ZA/s0TxN2/1I9KsCfiy
         sOTm5YHtkijGf3M/KCV3MCXGyea7fab3fNvpA7+zQ6ZKZJTWvUxZ+BCsQXqDOKhd4FRD
         ttAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753716002; x=1754320802;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3M6HADrcbiuvKh0/Kz/xLBlEH+H9X+k3yVRG8+8/+Q=;
        b=TDFLT5gAteJrbPxfEGEz1+FxaVstG856+JLlM91Okh54Bybf5Xoj7lRp+Cijugq1WO
         CR2D/UE+gGQIFYoFC+n0DhGM4RiHM9VwjugEo+F+jjDo3ZnprDy2vXAZWrzOT2p8Ct1m
         jah/gf2sQaHq5fuErxYEq3n+CFqW7LZKisjGkDBT5sURYWfVeH0wHv5Umv26fOH7Ekj/
         HP42OU0eqibUQkHKjqrqdbagNIPeItPTJ+ziE/GGagVTp7yJ5f6tE23zUDHlKZccro+v
         Sm+IVySlsUmldGIv1Z2ola8IOTKEtK+Rtabqo2e/iC5WTCQkLKhbfXzc3jqdIsblbn+h
         uymw==
X-Forwarded-Encrypted: i=1; AJvYcCWdjpGvyeK9ZTpmp+2IqntpEsXmct/4Jckyg1OMryKDZ9t1ol1rsIeQvFno2gqz4i9CGUsBVF5VaCT/gN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/8Coy715hPYpE/htLCoUPPgwrayOoHTQI6ER16KFogNgNX1T
	0MYM55PbmQ/S/xRkOWnQAqwjzDafX0y++LaIYT+QFN9YdFGreWI4yqapnbRMpVQUG9Q=
X-Gm-Gg: ASbGncsgqDK48WwSsSo2KPRv+6S40j5KNgurcHkgTF30FRxIy4Z/6Mpzf9BxXmokalG
	GXAo2iCZxFcka09Uan4bb8Z05FeqesWs7QHGwd7AD9JUHg/qP3hTms9YTTP168fybGyOPmuTV1Y
	SYH38IIuWc89HPU+PzH8zHyJ/5EQwaYf908+qU1SaiU67KKluoCQkOIRswkvGqOC40A4sPZegPH
	jEK16J5QyKM+3fcOSgZ0bNj8M+0z99swz9CH8bQYhdYRkuL0t/AtX7qRxlRvWyeGzcdTV6ITm66
	PiOGuWznsES/EF8A5aQk+niELSNpTbqaWSANA7CCyY9qRtwsQb4fV9iOmUdR2NaW1nw1M/gqLCp
	fguRT/GvshPz/95N4dk2mp4ZMK92dSKerZg71K0oMmEB2tPbAjUtlVwmcqJFLd64=
X-Google-Smtp-Source: AGHT+IHuFxUfNvgAlegftl8WivsnpjLThvsD/neUVLJFPFSoDoKmpaGfm37Dy5WdZFowr4b1ZggyxQ==
X-Received: by 2002:a05:6000:4211:b0:3b7:73b5:e96d with SMTP id ffacd0b85a97d-3b776725608mr8244540f8f.15.1753716001775;
        Mon, 28 Jul 2025 08:20:01 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778ec36bcsm8929728f8f.37.2025.07.28.08.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 08:20:01 -0700 (PDT)
Message-ID: <6dc33f02-6691-4ad8-b04f-423e4e5caea8@linaro.org>
Date: Mon, 28 Jul 2025 16:20:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: venus: pm_helpers: add fallback for the
 opp-table
To: Renjiang Han <quic_renjiang@quicinc.com>, quic_qiweil@quicinc.com,
 quic_wangaow@quicinc.com, Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250724-fallback_of_opp_table-v2-1-2fc61f2407dc@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250724-fallback_of_opp_table-v2-1-2fc61f2407dc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 08:53, Renjiang Han wrote:
> Since the device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX
> do not include an opp-table and have not configured opp-pmdomain, they
> still need to use the frequencies defined in the driver's freq_tbl.
> 
> Both core_power_v1 and core_power_v4 functions require core_clks_enable
> function during POWER_ON. Therefore, in the core_clks_enable function,
> if calling dev_pm_opp_find_freq_ceil to obtain the frequency fails,
> it needs to fall back to the freq_tbl to retrieve the frequency.
> 
> Fixes: b179234b5e59 ("media: venus: pm_helpers: use opp-table for the frequency")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
> ---
> Since device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX do not
> contain an opp-table and have not configured opp-pmdomain, they still
> need to use the frequencies defined in the driver's freq_tbl.
> 
> Therefore, if calling dev_pm_opp_find_freq_ceil to obtain the frequency
> fails in the core_clks_enable, it needs to fall back to the freq_tbl to
> retrieve the frequency.
> 
> Validated this series on QCS615 and msm8916.
> ---
> Changes in v2:
> - 1. Update the returned error value as per the feedback.
> - Link to v1: https://lore.kernel.org/r/20250723-fallback_of_opp_table-v1-1-20a6277fdded@quicinc.com
> ---
>   drivers/media/platform/qcom/venus/pm_helpers.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 8dd5a9b0d060cddfeafd4da477ade0c7aeb6c390..77c12273dbb9505244e260fc8fa635e4fe045236 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -40,6 +40,8 @@ static int core_clks_get(struct venus_core *core)
>   
>   static int core_clks_enable(struct venus_core *core)
>   {
> +	const struct freq_tbl *freq_tbl = core->res->freq_tbl;
> +	unsigned int freq_tbl_size = core->res->freq_tbl_size;
>   	const struct venus_resources *res = core->res;
>   	struct device *dev = core->dev;
>   	unsigned long freq = 0;
> @@ -48,7 +50,14 @@ static int core_clks_enable(struct venus_core *core)
>   	int ret;
>   
>   	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> -	dev_pm_opp_put(opp);
> +	if (IS_ERR(opp)) {
> +		if (!freq_tbl)
> +			return -ENODEV;
> +		freq = freq_tbl[freq_tbl_size - 1].freq;
> +	} else {
> +		dev_pm_opp_put(opp);
> +	}
> +
>   
>   	for (i = 0; i < res->clks_num; i++) {
>   		if (IS_V6(core)) {
> 
> ---
> base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
> change-id: 20250721-fallback_of_opp_table-4ea39376f617
> 
> Best regards,

Note to self add a

Closes: CA+G9fYu5=3n84VY+vTbCAcfFKOq7Us5vgBZgpypY4MveM=eVwg@mail.gmail.com

---
bod

