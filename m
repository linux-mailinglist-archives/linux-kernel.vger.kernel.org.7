Return-Path: <linux-kernel+bounces-798891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F0FB42459
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247A22065DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C61EFF9A;
	Wed,  3 Sep 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhue5TIl"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47A3101AA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911794; cv=none; b=f1UAi6POlaOLC34BMFnC3mFVKNSM6x/DXvgbA/qd1hWmGOVHhYgptrSUAF8eUaWZP/1/WvyNxGmCWimpl3tDsE1Ovf9kucesz86m5bTwiEylq8O0kZZ9gLhHi7dSKaENdoUG4FaM8CgJAjtGu/Ir+gdQ8j5P8yfnmj+EIRZ5Y/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911794; c=relaxed/simple;
	bh=LekdRFzFZGbphNAI7RPhmxPwnfPr7M4Uz0MSWilmzVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZlyZPuWhHP5gZcpog6a+qTmFIRiuwMDcuiHaKLZc7j9fkc6qK6/zH5QhmWEx9mTa+h5sPYbO/PNphZ9+UKfACpSHLuhHuKBXLS4iSH7Dlo8tBUbmYuhufE/OZH5kXRyx1X2ObUkdkSthOcrLlCcMD6Uv08Nzikh5GtU03hUUGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhue5TIl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b7d485173so381795e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756911791; x=1757516591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vb9H2OtYCm0pJa79dfHcS+lvaJaqfNpw4BGLzTlGfN4=;
        b=lhue5TIlbhlVCXVAscFKWU7JqRhIvfKtTRdYOjjbtrazqhTjC2JPqMdm15IpaW00g1
         T4YMxBPBtSVGGUpk1X3VY7DlUszSYzhBh+81F/Q22uMhPlcZvcldLpViGRAbyZj28b2g
         CPtZgtUIXN46sLbNcY0H9QG/b4o55GAF4Kzt5OlaQmzJAbQqCWotM+uXJ9T3rxCNjxBP
         XnOnOdkySz1p4AJw3xCiv2txjduIMmZlupun2qyBTF6wJo9m/KTCfgkA8sT5ddSQnoYe
         iL/tKQ/lkjnotpHLJeTn/Yjk3Eogenkflui5HF0dEAyPo+mpvvE4odAfw4qgQ1XYaQ0X
         89Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756911791; x=1757516591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vb9H2OtYCm0pJa79dfHcS+lvaJaqfNpw4BGLzTlGfN4=;
        b=BhbEsDb97f2DyaSDLc1fYdp5wa2Pxno2Nhh1pd5PbNTW6SZCfb7TIs6V5bwl/qy0S6
         aQB/liyyRBh5ZZYUTpEiuJivZO8kDqQMrrDzU3hfPFziClBJBXfCKk2q2wwvKyykmkl+
         h+74/+Z5/NiRNwHY376pzkT2Sos7QLNOq5lyfLKeLY0AUILuZd5xlKL3NzrGa+Y37P7w
         YcextmTIdmVlWerv15+5j2hXgosEJhOsJ9v7PsBJWSelVaVql1pIqFKZMX5HfqbBIbcy
         2hTTo3iX9/WDKLNU+7OluSPPCBNBSU6/pxfzmluiOO9DY3Tmaie0DTWgeqTw1Kdbha6a
         DmGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE+Kog3qRzyTLKOqDD9RW26TA6/Cm2WWPpU28YMpvMusIh3jY3VG+UX8oN4iwZ1ztdyJMh+sqDabV6948=@vger.kernel.org
X-Gm-Message-State: AOJu0YweSmzAufiUe5ig2p3PmbKISq+UvJbM5eHAeGxzn4mC/3z/hySF
	2qDdoxTs99t73o8U2dAtt6kVmrPWbz2NyjUyxx8LEKGexkrGwTVNFfEWBkOMeP5IiTM=
X-Gm-Gg: ASbGncvUHxlnSAiY9o1dlamV2vvgmmCYh+UIkXVhIyjzoCg2jM548P+rm8zIWKWaMIO
	Ol/dcOjLIZorte0cwdCQSc5CI4F9nyHRwX/eOe/QtA2j/xZlpu8eg18u59KhJMrueBgw4f2qDc/
	JX1bzH7o3hxCJFBJfTYT17BzIOUriiS1Nyagc3fA7YHkr9BipBTttNw43rYxXqC7507nrakB8vh
	E6U5lw+BE7ZdUwoEuJ5+yLxy7MolEHFIx1pRi+Aqgr7sqU/3ChYwOcUOJE/KCsv9Ozg6szaygui
	+q9WAr+D3iv/kmqnCOeBnAz/Zx8qWXSD/qnSUuSDrNXAXwRR8mqWi6rRBCQKfHS8jz1qTgGPTR6
	ts4RmZXP9vKzdNrQHPWnUi2L/Vs2fuYZYi0/4G1jUYxCP9UhinRg8k+u3v1RepxcBj2KWlilnWa
	MHAxSSAh3pxBaXUSpdnoTb9fOxyEJWPg==
X-Google-Smtp-Source: AGHT+IHgxGzSBKO2RRcMFfLj2ZBw0StjQrIND6sOj2Qk5dHscpmAOqzGzyVkeDc8krrGAjKPU2Waxw==
X-Received: by 2002:a05:600c:310b:b0:459:e3f8:92ec with SMTP id 5b1f17b1804b1-45b85532b05mr140779095e9.10.1756911789005;
        Wed, 03 Sep 2025 08:03:09 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73c52735sm306287285e9.22.2025.09.03.08.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:03:08 -0700 (PDT)
Message-ID: <0b4472cb-0c73-4eb8-a360-22b40aae44f5@linaro.org>
Date: Wed, 3 Sep 2025 16:03:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] soc: qcom: mdtloader: Add context aware
 qcom_mdt_pas_load() helper
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-3-mukesh.ojha@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250819165447.4149674-3-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2025 17:54, Mukesh Ojha wrote:
> Currently, remoteproc and non-remoteproc subsystems use different
> variants of the MDT loader helper API, primarily due to the handling of
> the metadata context. Remoteproc subsystems retain this context until
> authentication and reset, while non-remoteproc subsystems (e.g., video,
> graphics) do not require it.
> 
> Add context aware qcom_mdt_pas_load() function which uses context
> returned from qcom_scm_pas_ctx_init() and use it till subsystems
> is out of set. This will also help in unifying the API used by
> remoteproc and non-remoteproc subsystems drivers.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

I'm struggling with the logic here a little bit.

You take this function which calls qcom_mtd_load_no_init();

>   
> -		ret = qcom_mdt_pas_init(pas->dev, pas->dtb_firmware, pas->dtb_firmware_name,
> -					pas->dtb_pas_id, pas->dtb_mem_phys,
> -					&pas->dtb_pas_metadata);
> -		if (ret)
> -			goto release_dtb_firmware;
> -
> -		ret = qcom_mdt_load_no_init(pas->dev, pas->dtb_firmware, pas->dtb_firmware_name,
> -					    pas->dtb_mem_region, pas->dtb_mem_phys,
> -					    pas->dtb_mem_size, &pas->dtb_mem_reloc);
> +		ret = qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware, pas->dtb_firmware_name,
> +					pas->dtb_mem_region, &pas->dtb_mem_reloc);

and then turn it into

> +int qcom_mdt_pas_load(struct qcom_scm_pas_ctx *ctx, const struct firmware *fw,
> +		      const char *firmware, void *mem_region, phys_addr_t *reloc_base)
> +{
> +	int ret;
> +
> +	ret = __qcom_mdt_pas_init(ctx->dev, fw, firmware, ctx->peripheral,
> +				  ctx->mem_phys, ctx->metadata);
> +	if (ret)
> +		return ret;
> +
> +	return __qcom_mdt_load(ctx->dev, fw, firmware, mem_region, ctx->mem_phys,
> +			       ctx->mem_size, reloc_base);

Surely you want to qcom_mdt_load_no_init ?

On current kernel
return __qcom_mdt_load(ctx->dev, fw, firmware, mem_region, ctx,
		       mem_phys, ctx->mem_size,
		       reloc_base, true);

but that's a functional change

> +}
> +EXPORT_SYMBOL_GPL(qcom_mdt_pas_load);
the no_init version of this looks like this:

int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
                           const char *firmware, int pas_id,
                           void *mem_region, phys_addr_t mem_phys,
                           size_t mem_size, phys_addr_t *reloc_base)
{
         return __qcom_mdt_load(dev, fw, firmware, pas_id, mem_region,
			       mem_phys, mem_size, reloc_base, false);
}
EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);

So is it really the intention of this patch to change the callsites 
where qcom_mdt_pas_load() away from the init version to the no_init 
version ?

Maybe its a symptom of patch collision but hmm, having a hard time 
cherry-picking this to test.

---
bod


