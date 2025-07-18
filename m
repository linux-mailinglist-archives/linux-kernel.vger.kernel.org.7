Return-Path: <linux-kernel+bounces-737275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E2B0AA38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913BA4E136A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0DB2E7BC4;
	Fri, 18 Jul 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8XqDrW5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C62E7BB5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863835; cv=none; b=REH81qrQ3LuVm0FUkA3VASacvschuXBw2mqRzMeWzctH2uPeYu2+frP/vqjgx9MukMyNT2Cl5lLOZdWRjO0S6m0ksOhjkyQaaFDHOkaJ1FpwDKc674Y6wLmI6uGh6F0ZnISm4pd7THiKfUtYJPo4AMjhwyGJwfE39987GYZ0n+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863835; c=relaxed/simple;
	bh=FD9HooRQCc+PXCUOKvmD24mEJXDixu8d1mCmEOHZHmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHUwioD4IOYAkwRN6esiH5SA0NPQQ4ivKS/JpgnlS3qzmKhslKSXeA9CATQ/Fda03ziTGhsQjhNlcb7UN8+v7Rz3bEkF6mFrkXwRFHmJBvpLKO9Td1s9QMU7aFGwGQszPVYiUYaKO8DZaHP68jRiAauOfzb6kH6wHANoeyFtil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8XqDrW5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IF0RMT020820
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ALPvAyKfQjtdHFgs68bECM2y
	VyHmmPwO24e9jJdHfv0=; b=P8XqDrW5iPG1Zr+qNYrNvxjbOiTer6Kt+/d6Vte1
	U/MkzM1dytcaMlu0aj78H5itvp5IMCpGjxy4Tr0j8VO6daAVabH7uLGgt70TvUit
	UjofSgTWIoF8kkxkMpum7buUxBLgxVGoko/N05tbu/R0p948qF3/4/vy6S8pkNnM
	zeR6189Rz37Cr/c2wJumOJ5j/DYZGwIxN+mp8qkBhfd3N5T+gODgkedqQW7ySpHP
	lI5pkGZdb44ABl6RHSCz4X2wfzp7fVtjK6+Hwcy+v981IgTMULCtGrMW37R8V1VF
	Y+8s2w9sWCBHf9o7RNJpZK0iQTgVJHcL3m3/rBu6N4+w1w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpqp9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:37:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e350826d99so319546485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752863832; x=1753468632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALPvAyKfQjtdHFgs68bECM2yVyHmmPwO24e9jJdHfv0=;
        b=rhnnS9zLVK1QKJy2GCnw+jb0LTm+A3azAoU/OyCcvgTsGLMrjL3vfaRWsiif66P9EW
         jb8kgmLxyl4xNvPtbxs+cLfUTrZjTFCEXBYaIDTq229mSj7gLpfvqQPVCehfQr+fUSTp
         CIxen2ibnpkC1eYJSYiPAiNT1elkoGQPcqBAP8ptg2tpbcl9QVJauJ7EPp3FEnvE9dd9
         wMRdO1D3/a3Usq5Te98+0QGUG+qDu57ly+FAwqc14WYPZyXGUU7voExQZCfXOsjb7f9Y
         mOePoLm7lYV+/oHM9wC524Hh0UIO2nOqMMRgEcShTWay2KRUdwjGyzq80pcC0eUrrPxE
         AFBw==
X-Forwarded-Encrypted: i=1; AJvYcCVl70XZfziw6QTPigxlyfehikb5tvZQob1ybgBX51+UKTh4+qPfwU/g3SNJMxcp9Xp/XbzRUuSXjfMYdgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmLbwRL6Yzkb6oede5U+mY4TuThaqWBAPbLTUEz7FKHsIku0l
	07pdV0xyrYTNwK3ery/KeJR0MRDwlmCSv/frFYR/74eTnqWz4Dv7CjgnHeV3yqa1Ev8xCKcXfF6
	Ku25SrArJFtZw/0Oo5hLEUlLBlKt7jBvdb6m4pxRSrjEO14QFTt+8n9yC6Calu+3fX5g=
X-Gm-Gg: ASbGnct++5sIym8VwqoQLPKH+qgu/JjxEkSKqN4RBKaEa9F1UpApkO4XTjLPI3f5DD7
	ukXdkwo7KNDC/2nei/GscJjqfCR+of7WkAvr4+uVaq7XIM8e4I3becBb/siodYNioC0l046eiTf
	Na8CadxRN7dz/7EcMzW8z/oEwnydki7SFw/IGJDb9DvTaR8GzC+kLi0bGZ3sfADLVdIwhev+ZYv
	VSFiMIRe/jFXNehUZyiR65ZbEIGvKbzze+BwQYsQDT1nf0IfxyVOZyHy3UL9Ce+cHHycUWEVcze
	+ffA+YAMeq8Rqks5zByRmRwwiRYA/AX9YmbRApqrkty9q/MOr0uw2MIWlN+2QKW5X5zAtDsJihD
	BT+3ikoseiOknjd+IT8sFex9LpAh9hqb5qBgX+3AP4FpLsVnHMyrx
X-Received: by 2002:a05:620a:268d:b0:7e2:769a:c857 with SMTP id af79cd13be357-7e34335131amr1702166685a.1.1752863831611;
        Fri, 18 Jul 2025 11:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHElvVFF8dizfyr2Wk3GnhytPZl7LLlYnIUcaoY5rC3+dyUZxZapzDDTomhRW5XbvK70xXqrg==
X-Received: by 2002:a05:620a:268d:b0:7e2:769a:c857 with SMTP id af79cd13be357-7e34335131amr1702161085a.1.1752863831040;
        Fri, 18 Jul 2025 11:37:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91d8db4sm2741471fa.74.2025.07.18.11.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 11:37:10 -0700 (PDT)
Date: Fri, 18 Jul 2025 21:37:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v11 1/8] power: reset: reboot-mode: Add device tree
 node-based registration
Message-ID: <y7xhfbiwkduo3lytb5gbukdu3yptx6uajtbngbspqbqkyt5dzo@gy62zoxwr6ah>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
 <20250717-arm-psci-system_reset2-vendor-reboots-v11-1-df3e2b2183c3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-arm-psci-system_reset2-vendor-reboots-v11-1-df3e2b2183c3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE0NyBTYWx0ZWRfX8HJnfV9Fq5+S
 6NTzzTQM7PHM1i5Zv3msQ7Rp9kK5UGWTjBYwcKjr7gEdSlhUsHIdyELnf2dsy4gnl76uKnjJBty
 LQlWh2NtCnUgOAqV2Tr25RZZsdYXVxr6UMUOxy+XWGnmjtRyHDYlqa+HgWnHtD3z3PUKW7j9rch
 VMgrCjx+Mpw8GvGIjGkSFmWBrPS228mE+ecjf8lwTgVkuHiX6ZHLcdxgAQXPeDqtsLPua48Zmyu
 iUZ50JBp3TLD3qHOlKLlKhULb3Ad2YveynrYxkJwzx6vrmyLwAWXjjhRHAMmn8osz16FlYjgf72
 qy+5qqwpb7o3qFJWLKYRBzbOPBxflbuJsLuQaD++iQSNg6M/N6HmosDh2BfuBOmiLtpZgAYucuw
 5JeD5XXlcAbV0L3yOOdEx0W7g21M1nfw1YiOIIbRtsSH8W/FIDd57SZwZJ2e6ZzelcAqC3Gv
X-Proofpoint-GUID: Sjiib7cxt83vT0LAPW7gZQiv5i-Ek2TO
X-Proofpoint-ORIG-GUID: Sjiib7cxt83vT0LAPW7gZQiv5i-Ek2TO
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687a9459 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=vZ9_uWrtemhWx8VJ4wEA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180147

On Thu, Jul 17, 2025 at 06:16:47PM +0530, Shivendra Pratap wrote:
> The reboot-mode driver does not have a strict requirement for
> device-based registration. It primarily uses the device's of_node
> to read mode-<cmd> properties and the device pointer for logging.
> 
> Remove the dependency on struct device and introduce support for
> Device Tree (DT) node-based registration. This enables drivers
> that are not associated with a struct device to leverage the
> reboot-mode framework.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 29 +++++++++++++++++++----------
>  include/linux/reboot-mode.h       |  2 +-
>  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..0269ec55106472cf2f2b12bd65704dd0114bf4a3 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -3,13 +3,17 @@
>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>   */
>  
> +#define pr_fmt(fmt)	"reboot-mode: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/reboot.h>
>  #include <linux/reboot-mode.h>
> +#include <linux/slab.h>
>  
>  #define PREFIX "mode-"
>  
> @@ -65,33 +69,35 @@ static int reboot_mode_notify(struct notifier_block *this,
>  /**
>   * reboot_mode_register - register a reboot mode driver
>   * @reboot: reboot mode driver
> + * @np: Pointer to device tree node
>   *
>   * Returns: 0 on success or a negative error code on failure.
>   */
> -int reboot_mode_register(struct reboot_mode_driver *reboot)
> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np)
>  {
>  	struct mode_info *info;
>  	struct property *prop;
> -	struct device_node *np = reboot->dev->of_node;
>  	size_t len = strlen(PREFIX);
>  	int ret;
>  
> +	if (!np)
> +		return -EINVAL;
> +
>  	INIT_LIST_HEAD(&reboot->head);
>  
>  	for_each_property_of_node(np, prop) {
>  		if (strncmp(prop->name, PREFIX, len))
>  			continue;
>  
> -		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> +		info = kzalloc(sizeof(*info), GFP_KERNEL);
>  		if (!info) {
>  			ret = -ENOMEM;
>  			goto error;
>  		}
>  
>  		if (of_property_read_u32(np, prop->name, &info->magic)) {
> -			dev_err(reboot->dev, "reboot mode %s without magic number\n",
> -				info->mode);
> -			devm_kfree(reboot->dev, info);
> +			pr_err("reboot mode %s without magic number\n", info->mode);
> +			kfree(info);
>  			continue;
>  		}
>  
> @@ -102,8 +108,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>  		} else if (info->mode[0] == '\0') {
>  			kfree_const(info->mode);
>  			ret = -EINVAL;
> -			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
> -				prop->name);
> +			pr_err("invalid mode name(%s): too short!\n", prop->name);
>  			goto error;
>  		}
>  
> @@ -130,11 +135,15 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>  {
>  	struct mode_info *info;
> +	struct mode_info *next;
>  
>  	unregister_reboot_notifier(&reboot->reboot_notifier);
>  
> -	list_for_each_entry(info, &reboot->head, list)
> +	list_for_each_entry_safe(info, next, &reboot->head, list) {

This feels liks a missing lock.

>  		kfree_const(info->mode);
> +		list_del(&info->list);

list_del should come before kfree, otherwise it's possible to access
freed memory while traversing the list.

> +		kfree(info);
> +	}
>  
>  	return 0;
>  }
> @@ -162,7 +171,7 @@ int devm_reboot_mode_register(struct device *dev,
>  	if (!dr)
>  		return -ENOMEM;
>  
> -	rc = reboot_mode_register(reboot);
> +	rc = reboot_mode_register(reboot, reboot->dev->of_node);
>  	if (rc) {
>  		devres_free(dr);
>  		return rc;
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..36f071f4b82e1fc255d8dd679a18e537655c3179 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -9,7 +9,7 @@ struct reboot_mode_driver {
>  	struct notifier_block reboot_notifier;
>  };
>  
> -int reboot_mode_register(struct reboot_mode_driver *reboot);
> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot);
>  int devm_reboot_mode_register(struct device *dev,
>  			      struct reboot_mode_driver *reboot);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

