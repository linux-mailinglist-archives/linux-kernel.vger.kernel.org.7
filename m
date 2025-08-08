Return-Path: <linux-kernel+bounces-759981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12305B1E536
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89C418A38C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5926E14D;
	Fri,  8 Aug 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlr+tHg1"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290C26560A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643691; cv=none; b=EVx7jADVGUCKrHXAZFt1SkdxDLGuaHa8zrlXe0JcbJCGK5M5LBDwNMBRs8k2wpiyZHFOs8TOojb5LUkxNXzKgjumTWkY1E/MdOeFZaGOvgz6CH49JKN+XQX8z8GtP6tFqvVeu4g5lVtRIqpv5we8Ho6xccvs30VWi8/mWnD+zsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643691; c=relaxed/simple;
	bh=+5mmSXXgQfg4o9txh+YZiXCmcXSiP1ZTVMOYqvAj0qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMJPHG+oO3sBGu8+kx4R24te1c0vK0UeeynDmsNxilwfIbNANFPcnIC2EafWZAljmLM6/4vx0Ysqb5TdLLsaIA/Oxf9yGzW3WgTg98L3atcuoz07COponUJeelyPjEE0BHhdUmDIXizZM+QmFwoS4in2G7/Oy5cD/S3iS/pUhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xlr+tHg1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so931119f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754643687; x=1755248487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PH1sc0HOWazPmGzwk0Iil9DpgiFfEiqxA8M31CQZlCk=;
        b=xlr+tHg1005RrOat2Wwb4pM+isp+i1hNprkpHOCqV/YiBYEmYz+HfzZRfbWuikWDX0
         HgWHGnl9irdoXbqzPXbjojhlrRUfpANAYEb0ThAbTf6MQKTpPqlAzx+j3lGJzKPLG7t+
         5DM5OiMGgufRQoM4AS41k9xH9mzwJYRLCfJaOQhq03UWwDF2q5ylPpjQNt8xf1/u+qOt
         iTN46ZUr9DLebsxI9O4skLnBur2ho3uzr8wmqE1wE4i4RYD+s1RyY/NU9DceJWnfAvhx
         4fOnU2J5doFo4A7/xUIoJKUiHU9nPTEzFw36oS565yjJMbaJPujzsaug4iyzDzklhJxm
         3r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643687; x=1755248487;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PH1sc0HOWazPmGzwk0Iil9DpgiFfEiqxA8M31CQZlCk=;
        b=HDh26E7sQhQlGdZV1s8n4tPkJ/X4h64JyookyR3beBPIfaSL16hbWcYe0m/icyn3xk
         cZmW2+ednZwPM+ohNgLCqfH2JU4rO/lLKQ1nPN49aCW/f3c0QLvLbMaWph5s7fQObnzI
         zxzlEXb0OkAUzkUCvJsI5Rt+AZ1b5PwXrNXGaxnYvV/xdp7iknbilVvHkP2etRACPGaz
         W8E4EiEdUsBPabif0MlSidqkcnz8Nq34ysAItZsuY8Gha11Y36eC0Q8kaOdNzcq+uXMQ
         QV/pvFImOEG7NwOA2+7nq+XS9H+ryztbdYVVDQib4s9XTIHlD9c2QPWmSgcFNOnaB98j
         gCvw==
X-Forwarded-Encrypted: i=1; AJvYcCXoQ94bxTyX5mhsXywmbHHsv6kGOQ9PWzuQpGAgFPya2tbm8ALqQNszzFWZe6s2h0FhEzDMXaZiB90ufjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/zj2OKct8T9GP78yW+0naWsVI9Q29lwBOSZyqZtmgJbetNkr
	FpAvHBwFswIPTjWnhjv46qntcJ9/ITok+JiQDeV6ACShTV7DD4Ztxe2a00MxqlbNgmE=
X-Gm-Gg: ASbGncvaTFdJ91j2nhqigo/iva0Zd84IySbp5YFnIorDelhGH1c1Ax0uZVEEgO72gFH
	iEXR09+vib/wYhiOdKQuKZMHmbQpbsYlh7BQcBQk593viExhjPLTBg0KQhiZ4IMfFx5hMR3yHAA
	ZqTQctewDj07n4zezyz873JF4sCs2UrqBvv3ONqJHux9lJpj4LbbV8NsMgn/a9YMnIev1zBHYpG
	AvEFzzD2HVWXZQn+KGKWS4ieM4MG/d6meENgnBeLZlzmD0j1rXqnhtTUSyDSt0vXBYMriG+p1fc
	dRBzultxlM9It3appFXDjxiMrio+mvW24kjDRNL8d4kczJCDK4LlKo6qNwTHSW7hRHSVriMc3ly
	OqkjIJGTg6/RMvNGIVNa94JxQNcdYzU77cP5ks8tTkeiCF/HlMMHTmA3EuIOYi1I=
X-Google-Smtp-Source: AGHT+IHQSMBQxLb0BZuEhqNGRQomUFmT/lydrrM1kku7nF06fGNwjgx661NlU4HIkiIGSw1p8Q5DVw==
X-Received: by 2002:a05:6000:2410:b0:3b8:ffd2:6745 with SMTP id ffacd0b85a97d-3b900b51264mr2127347f8f.44.1754643687141;
        Fri, 08 Aug 2025 02:01:27 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm29605740f8f.39.2025.08.08.02.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:01:26 -0700 (PDT)
Message-ID: <2c63a133-eedb-4b8c-82a7-6b183317f6f7@linaro.org>
Date: Fri, 8 Aug 2025 10:01:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/8] media: venus: Define minimum valid firmware
 version
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com, krzk+dt@kernel.org,
 konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 mchehab@kernel.org, robh@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
 <20250808085300.1403570-3-jorge.ramirez@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250808085300.1403570-3-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/08/2025 09:52, Jorge Ramirez-Ortiz wrote:
> Add support for specifying the minimum firmware version required for
> correct operation.
> 
> When set, the driver compares this value against the version reported by
> the firmware: if the firmware is older than required, driver
> initialization will fail.
> 
> The version check is performed before creating dynamic device tree
> nodes, to avoid the need for reverting nodes on failure.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/venus/core.c     | 40 +++++++++++---------
>   drivers/media/platform/qcom/venus/core.h     | 13 ++++---
>   drivers/media/platform/qcom/venus/firmware.c | 20 ++++++++++
>   drivers/media/platform/qcom/venus/firmware.h |  1 +
>   4 files changed, 51 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 4c049c694d9c..f45715c9b222 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -448,19 +448,9 @@ static int venus_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		goto err_runtime_disable;
>   
> -	if (core->res->dec_nodename || core->res->enc_nodename) {
> -		ret = venus_add_dynamic_nodes(core);
> -		if (ret)
> -			goto err_runtime_disable;
> -	}
> -
> -	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> -	if (ret)
> -		goto err_remove_dynamic_nodes;
> -
>   	ret = venus_firmware_init(core);
>   	if (ret)
> -		goto err_of_depopulate;
> +		goto err_runtime_disable;
>   
>   	ret = venus_boot(core);
>   	if (ret)
> @@ -474,34 +464,48 @@ static int venus_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_venus_shutdown;
>   
> -	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_DEC);
> +	ret = venus_firmware_check(core);
>   	if (ret)
>   		goto err_core_deinit;
>   
> +	if (core->res->dec_nodename || core->res->enc_nodename) {
> +		ret = venus_add_dynamic_nodes(core);
> +		if (ret)
> +			goto err_core_deinit;
> +	}
> +
> +	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	if (ret)
> +		goto err_remove_dynamic_nodes;
> +
> +	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_DEC);
> +	if (ret)
> +		goto err_of_depopulate;
> +
>   	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_ENC);
>   	if (ret)
> -		goto err_core_deinit;
> +		goto err_of_depopulate;
>   
>   	ret = pm_runtime_put_sync(dev);
>   	if (ret) {
>   		pm_runtime_get_noresume(dev);
> -		goto err_core_deinit;
> +		goto err_of_depopulate;
>   	}
>   
>   	venus_dbgfs_init(core);
>   
>   	return 0;
>   
> +err_of_depopulate:
> +	of_platform_depopulate(dev);
> +err_remove_dynamic_nodes:
> +	venus_remove_dynamic_nodes(core);
>   err_core_deinit:
>   	hfi_core_deinit(core, false);
>   err_venus_shutdown:
>   	venus_shutdown(core);
>   err_firmware_deinit:
>   	venus_firmware_deinit(core);
> -err_of_depopulate:
> -	of_platform_depopulate(dev);
> -err_remove_dynamic_nodes:
> -	venus_remove_dynamic_nodes(core);
>   err_runtime_disable:
>   	pm_runtime_put_noidle(dev);
>   	pm_runtime_disable(dev);
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 5b1ba1c69adb..d1f0e9979ba4 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -58,6 +58,12 @@ enum vpu_version {
>   	VPU_VERSION_IRIS2_1,
>   };
>   
> +struct firmware_version {
> +	u32 major;
> +	u32 minor;
> +	u32 rev;
> +};
> +
>   struct venus_resources {
>   	u64 dma_mask;
>   	const struct freq_tbl *freq_tbl;
> @@ -94,6 +100,7 @@ struct venus_resources {
>   	const char *fwname;
>   	const char *enc_nodename;
>   	const char *dec_nodename;
> +	const struct firmware_version *min_fw;
>   };
>   
>   enum venus_fmt {
> @@ -231,11 +238,7 @@ struct venus_core {
>   	unsigned int core0_usage_count;
>   	unsigned int core1_usage_count;
>   	struct dentry *root;
> -	struct venus_img_version {
> -		u32 major;
> -		u32 minor;
> -		u32 rev;
> -	} venus_ver;
> +	struct firmware_version venus_ver;
>   	unsigned long dump_core;
>   	struct of_changeset *ocs;
>   	bool hwmode_dev;
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 66a18830e66d..3666675ae298 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -280,6 +280,26 @@ int venus_shutdown(struct venus_core *core)
>   	return ret;
>   }
>   
> +int venus_firmware_check(struct venus_core *core)
> +{
> +	const struct firmware_version *req = core->res->min_fw;
> +	const struct firmware_version *run = &core->venus_ver;
> +
> +	if (!req)
> +		return 0;
> +
> +	if (!is_fw_rev_or_newer(core, req->major, req->minor, req->rev))
> +		goto error;
> +
> +	return 0;
> +error:
> +	dev_err(core->dev, "Firmware v%d.%d.%d < v%d.%d.%d\n",
> +		run->major, run->minor, run->rev,
> +		req->major, req->minor, req->rev);
> +
> +	return -EINVAL;
> +}
> +
>   int venus_firmware_init(struct venus_core *core)
>   {
>   	struct platform_device_info info;
> diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
> index aaccd847fa30..ead39e3797f0 100644
> --- a/drivers/media/platform/qcom/venus/firmware.h
> +++ b/drivers/media/platform/qcom/venus/firmware.h
> @@ -9,6 +9,7 @@ struct device;
>   
>   int venus_firmware_init(struct venus_core *core);
>   void venus_firmware_deinit(struct venus_core *core);
> +int venus_firmware_check(struct venus_core *core);
>   int venus_boot(struct venus_core *core);
>   int venus_shutdown(struct venus_core *core);
>   int venus_set_hw_state(struct venus_core *core, bool suspend);

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

