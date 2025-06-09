Return-Path: <linux-kernel+bounces-678171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD1AD2512
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 19:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865643B06EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DF221C189;
	Mon,  9 Jun 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e65QfGjf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616021B191
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490672; cv=none; b=PbdqPUIq2cjJBsAt8UnX7PQNcM3mgRdh6Wy/737Bk8xVVWlpt7ymp0Dapnm+p3YPy7MT+ttc5dnEjV1OYmC7MKxgFWwJ314hl4o5zKVuCYHKvKd3chRkC17eEknC2PKOmE3ttaSjH6ZSR4SuMaT+NWyVYsO/Sof+oFCkng2ngUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490672; c=relaxed/simple;
	bh=NLe94yPt4q2EEiFA0+JfFwaP7sn2Zq/pZsMRfkjjFbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iq1ePzbTByXMCwrF8l5S1P21P4t7N3vsS5Wds2xFCYUJg/b+hwP1SBtchOHf+XC/LJJUABy8NtgrqIyk543ZLyBjr/5Q6aZiL4B+OVFfqGGCtRm2ECufKK5AGQYoqIY2LVFBDUdcsKKMKWKmxASvYZOg0KWafV7n/bE6lLi/nQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e65QfGjf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599DeRW004343
	for <linux-kernel@vger.kernel.org>; Mon, 9 Jun 2025 17:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0mD1/0CoskR/YlijKuKFXQSB2LX4lWU/ihQ9C+M2R1A=; b=e65QfGjfmnEbu4p3
	UihaUlZiORk3Gozu9dLSaMSP9mF34+aiX4WazCx72GGLHI/OpvsWfbzMTiyI8CJ7
	mLLawg5hHG4k6Y9ElBnt/LhzrUX3PFK6kg0ClvFNa2HHuhvKvyZdKST+ve7kkN5C
	t5fxlPVuJXdK3KSDbmG2Agn7iX++l5ruXwifbVXyKLSFpyHuvOhjHdqTUSuYTTRb
	0Vd5vWEbDBJHOr9XFJxjsL1END05UxhmjxlBVCA+w5wE6Wb5C6RRhAni4d15POmL
	wnqBFAOEkKtRCz23tHkxlX7dA320UncHJ7y//sisuXdb/j/lF4azs/8Ky3nkMHkv
	VhFB8A==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474eqcem0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 09 Jun 2025 17:37:48 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-610e04456ceso113344eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jun 2025 10:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749490666; x=1750095466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mD1/0CoskR/YlijKuKFXQSB2LX4lWU/ihQ9C+M2R1A=;
        b=HUyduUvgcM+Je4UQPOxv6zwNuhyo6CpebYjmsKoVZv5wpAAZY06W8BTJMyJ9GvOgf9
         yVA246ZwLkJ8yLlfKFP5F1kaYsXTVPCKCvF+KWFAbwzc5wJdGvBIvqtnKIi3/Ix7FCtF
         VN3kclGG4bP8KfiigZMneF/Q76/8pixGigehidxjIQQhtdSzIsmexjkOQ6IwUjiGRUkt
         cTLPMPoNIly2J874GNazo0XofGq9ddCH09NFpgQDMrMh2BQV8rbjCdHCsqWt3epJqH81
         ujk52pq7p5uL8w7rpwzeNsNcjA+cFPYnuVdZAfvavQW3aads8ZpMiYplZwK403C/Ysiz
         AczA==
X-Forwarded-Encrypted: i=1; AJvYcCVjl0YuXC4RBPjD03gw3u7yUrbb7cI0alg0A4o7llH2EQgsPJ6XIgZXOWFtOzM7oFo69HyvkTBTmFjZKfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTca9abbqThvWMhEX+jPAIU4Z3K3t3+sdjfed9xQOa1CwwQZj
	8uza2PP0aAmNa3Cf7PQBFGqVNrMRHGxpVT3vYv8PSjBZSGZSlt2uFfAeRy3wm0DxtMVpMZ81Af+
	dwtcq3GCjnwwnl9JTnVNnYzG7jaA0PDlJvGUq48tXroD36f4dnE7Zh2nsFajw1nyIXjRAmQvTIi
	g=
X-Gm-Gg: ASbGnctdMDJVZeJAOIc+G+W3MhJ/a2GTgU4QHCjVauc8FMqSLGaxBGPvSxAS9jF4LBv
	8kd3nWgW/NU+keBJDNcyf0tgMY5vtRQnnidDASPy/Qq+mPSG62HvDuL2oqR3ZGRY8W1DVdJF83+
	wvhJ+HzAKmptEHLzXtX/0cIPqgm1SogNccN173TDrM1YoPEmOtBfNEodMe6hBpfKm+AZtdH3Vfq
	rwI18+WxKYkmAZWzy2JFbGzLAkYzryOogwSUPpY3+WmOkF4EWNd8nSjApiTKSyWL8zvXg24YnRB
	JHCyxRt0r5mwlCACUM3KmECL1WNEGdgbfqO8syPnUY6PEMd6LkQZLXHmAk9Nca4F++ga0Qk32/m
	SVqtS+s/OjTqt7gY0WdHtJMdA
X-Received: by 2002:a05:6871:5521:b0:2d8:957a:5166 with SMTP id 586e51a60fabf-2ea768aa3c9mr283282fac.4.1749490666422;
        Mon, 09 Jun 2025 10:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDybc/cT1a1uzm8usYYLOngzIkeYWJ3oezh6aMZj11iyv41ICeZDa+085dK1+g2POh2T0oFw==
X-Received: by 2002:a05:6214:1c8b:b0:6fa:9ca0:c67e with SMTP id 6a1803df08f44-6fb238dc2e9mr7311616d6.5.1749490654418;
        Mon, 09 Jun 2025 10:37:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00::4c9? (2001-14ba-a0c3-3a00--4c9.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::4c9])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ae1b347afsm11373071fa.34.2025.06.09.10.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 10:37:32 -0700 (PDT)
Message-ID: <951f781a-d823-4240-a1c8-b9ea85ba64e0@oss.qualcomm.com>
Date: Mon, 9 Jun 2025 20:37:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/msm/adreno: Check for recognized GPU before bind
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20250609170438.20793-1-robin.clark@oss.qualcomm.com>
 <20250609170438.20793-4-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250609170438.20793-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEzMiBTYWx0ZWRfXyJW/RiEpzOO3
 v2rE7p6MKUBhuVSn6uS5xuUeDWPHJu9O0t0XXc1qmMXWXICHtMurZWHq++gYExUoSybJUnCqvEl
 urLmqa8bBMjqt3XWzrceb8Tf4aqSgk1g8h0kDtDZDclQLcQjtzIU/OAd8JH+GCruF866GMQfAhD
 Yl4ew78WpblkINKgroXyELnjJIKwkQf+FGLKcki7TO8oJ1cjUWegFP1+wadScZM8IHaS4QbLjFg
 S6RkPXqUlyXxMiP3V1JJjwZUNJTbNBppmsSObixBJZvOjBoH3Zqr5DMbPz464JFKGV5AvhJ7M3y
 4ooxdCpl7FelMDVHiC9SDm64CA2cUjzRleZgdigkNkWwJQhmv7RcsrrbjotkI7wscwMFlmNyx+B
 0m3y4QaxRJPlEu9401XNQgMos2ooQ+OIJh2q24Px+uiaIHWXmqdMasWaN5eqWxlI6LvEZMub
X-Authority-Analysis: v=2.4 cv=Q7TS452a c=1 sm=1 tr=0 ts=68471bec cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=4MAclHcQAAAA:8 a=ciEtJq1xeetoClZ_GcsA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22 a=6vtlOZhwcO7ZS_iRoh4Z:22
X-Proofpoint-GUID: sBwGJblCCOJf0WZyQ_sL5SuZeoLnNr1h
X-Proofpoint-ORIG-GUID: sBwGJblCCOJf0WZyQ_sL5SuZeoLnNr1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_07,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090132

On 09/06/2025 20:04, Rob Clark wrote:
> If we have a newer dtb than kernel, we could end up in a situation where
> the GPU device is present in the dtb, but not in the drivers device
> table.  We don't want this to prevent the display from probing.  So
> check that we recognize the GPU before adding the GPU component.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/adreno/adreno_device.c | 29 ++++++++++++++++++----
>   drivers/gpu/drm/msm/msm_drv.c              |  2 +-
>   drivers/gpu/drm/msm/msm_gpu.h              |  1 +
>   3 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 504174dbe6d6..002aaf365322 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -178,6 +178,26 @@ static int find_chipid(struct device_node *node, uint32_t *chipid)
>   	return 0;
>   }
>   
> +bool adreno_has_gpu(struct device_node *node)
> +{
> +	const struct adreno_info *info;
> +	uint32_t chip_id;
> +	int ret;
> +
> +	ret = find_chipid(node, &chip_id);
> +	if (ret)
> +		return false;
> +
> +	info = adreno_info(chip_id);
> +	if (!info) {
> +		pr_warn("%s: Unknown GPU revision: %"ADRENO_CHIPID_FMT"\n",

Please use %pOFf instead of %s (and node instead of node->full_name).

Other than that, LGTM.

> +			node->full_name, ADRENO_CHIPID_ARGS(chip_id));
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>   static int adreno_bind(struct device *dev, struct device *master, void *data)
>   {
>   	static struct adreno_platform_config config = {};
> @@ -188,18 +208,17 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>   	int ret;
>   
>   	ret = find_chipid(dev->of_node, &config.chip_id);
> -	if (ret)
> +	/* We shouldn't have gotten this far if we can't parse the chip_id */
> +	if (WARN_ON(ret))
>   		return ret;
>   
>   	dev->platform_data = &config;
>   	priv->gpu_pdev = to_platform_device(dev);
>   
>   	info = adreno_info(config.chip_id);
> -	if (!info) {
> -		dev_warn(drm->dev, "Unknown GPU revision: %"ADRENO_CHIPID_FMT"\n",
> -			ADRENO_CHIPID_ARGS(config.chip_id));
> +	/* We shouldn't have gotten this far if we don't recognize the GPU: */
> +	if (!WARN_ON(info))
>   		return -ENXIO;
> -	}
>   
>   	config.info = info;
>   
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 87ee9839ca4a..40eb04bab35e 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -956,7 +956,7 @@ static int add_gpu_components(struct device *dev,
>   	if (!np)
>   		return 0;
>   
> -	if (of_device_is_available(np))
> +	if (of_device_is_available(np) && adreno_has_gpu(np))
>   		drm_of_component_match_add(dev, matchptr, component_compare_of, np);
>   
>   	of_node_put(np);
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 5508885d865f..56bd1a646b83 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -729,6 +729,7 @@ msm_gpu_create_private_vm(struct msm_gpu *gpu, struct task_struct *task,
>   void msm_gpu_cleanup(struct msm_gpu *gpu);
>   
>   struct msm_gpu *adreno_load_gpu(struct drm_device *dev);
> +bool adreno_has_gpu(struct device_node *node);
>   void __init adreno_register(void);
>   void __exit adreno_unregister(void);
>   


-- 
With best wishes
Dmitry

