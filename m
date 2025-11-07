Return-Path: <linux-kernel+bounces-890466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3251DC401E1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE2C1898FB0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF4B2E7BB5;
	Fri,  7 Nov 2025 13:29:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738BD2E6CB2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522186; cv=none; b=l8HeAxyvZ/rpLzKYXSoBTBuTgYV61o3oC8NN66I+zzt5Hbsw+GAhsOtPSuJQnnQpjIIgEl+qcpvR5gZEk0OPpFS9H6wJM1/MWM9UgMY2r0nh37FxXpYWUrftybWf29KBGY1CWVq4qTS8tBM3a6RdGZSLIK2Y8KgjSSXOPL4Z/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522186; c=relaxed/simple;
	bh=OGb4PhXlc+mpkFTaQ9GQ60dInigfaogOv2tb4Vfl0QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tv+B0ee3EnkAoNGhOL4yjv5KR6sVTzOqjQIfCHpg2iDgG8TLhGd3UYxIv2R5LzUnl3Nxw3Ppx2WOnF6JNoMj0Ypn45q3f6JEilReD2vaUDWUnRZgmarhZR9+6v/gpr58Med2DHtLXwzZ/7/Ruepchi7qe6HwNc6mmY5SU1kp7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10EA61515;
	Fri,  7 Nov 2025 05:29:36 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85B043F63F;
	Fri,  7 Nov 2025 05:29:42 -0800 (PST)
Message-ID: <4f5ad681-b531-48a1-8fae-a0c3b5a51a29@arm.com>
Date: Fri, 7 Nov 2025 13:29:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: tpdm: remove redundant check for drvdata
To: Jie Gan <jie.gan@oss.qualcomm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
 Tao Zhang <tao.zhang@oss.qualcomm.com>,
 Mao Jinlong <jinlong.mao@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251107-fix_tpdm_redundant_check-v1-1-b63468a2dd73@oss.qualcomm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251107-fix_tpdm_redundant_check-v1-1-b63468a2dd73@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/11/2025 06:16, Jie Gan wrote:
> Remove the redundant check for drvdata data because the drvdata here already
> has been guarranted to be non-NULL.
> 
> Fixes: 350ba15ae187 ("coresight-tpdm: Add nodes for dsb msr support")
> Fixes: 8e8804145a46 ("coresight-tpdm: Add msr register support for CMB")

This doesn't need to be backported as such, as it is a cleanup. I will 
drop the Fixes tag and merge this.

Suzuki

> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 0e3896c12f07..06e0a905a67d 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -1402,11 +1402,11 @@ static int tpdm_probe(struct device *dev, struct resource *res)
>   		if (ret)
>   			return ret;
>   
> -		if (drvdata && tpdm_has_dsb_dataset(drvdata))
> +		if (tpdm_has_dsb_dataset(drvdata))
>   			of_property_read_u32(drvdata->dev->of_node,
>   					     "qcom,dsb-msrs-num", &drvdata->dsb_msr_num);
>   
> -		if (drvdata && tpdm_has_cmb_dataset(drvdata))
> +		if (tpdm_has_cmb_dataset(drvdata))
>   			of_property_read_u32(drvdata->dev->of_node,
>   					     "qcom,cmb-msrs-num", &drvdata->cmb_msr_num);
>   	} else {
> 
> ---
> base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
> change-id: 20251107-fix_tpdm_redundant_check-a5a7bad4b7c8
> prerequisite-change-id: 20251028-add_static_tpdm_support-1f62477857e2:v4
> prerequisite-patch-id: eda8dd6884b831cb10affc22477aece39c78b408
> prerequisite-patch-id: 7beb8b17d54ff21bc57eab10b56e6ffcfa4d1963
> prerequisite-patch-id: f6f1e78dba3f1d3b1191ab827adab5a3b7b2326a
> 
> Best regards,


