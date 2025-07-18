Return-Path: <linux-kernel+bounces-737283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61AEB0AA45
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF7F16DFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F521C5D53;
	Fri, 18 Jul 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SP/chH1a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7512E7F06
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864032; cv=none; b=t9rF1KeiPcZ+us8UaeTRsxjWlTvpLgFGIL1q6iAEI3Q2yToJ/NeW5S7sb5LcmRRtXdTXMWxvy5zrVo6Q94A00JOPbDJkar3d5krh+e+S5z9KAkTZOqoGlF9PyDNHELOdXQvfE3UChMMGFhDwQ59uv9EkhgYwCMgsBLhirWAcgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864032; c=relaxed/simple;
	bh=u74v2ZPWbKf07KJ1IltzXzIxmN3s5/LwyFkkuh1Mykw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1Kx+5NVFf4QcArpKa8kwfs0vIUbjCWxZWwkR0Us8kz/024qAc3d5mocFd48qV+B53r0Muuxbm7pIfxdVFKGX3Y/xh+Q5ujxNLL/l9XQry2SjKwfVRp/cav05h8vsSqyZ17jxmuFDYjjTslpAzk3wDQS+27FQnqzYwNdu8GBK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SP/chH1a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHFfYJ007301
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fl/6M6Rq/6jNajcCYuhAK92SmJY6l5itfv/1kSpS1jc=; b=SP/chH1akjGFRZXh
	O7YrljpvyrsMFhX/GlscO5L8O70wnWRHydWh1oDUiojOMts7ynMitK2/20PzwLuV
	8icRuhNEYFEWv/YofICS5KQTpxgNdiODfgCEtRIKpNW3/nw0KOgaF+X+cKxbyZgZ
	z2huyAUWYZppO//7qO8F12Ri1drER/ERWbTzZdQ0ZwKbML7AyBSU+8XGi2HXKkGR
	R5jQ8RKYEu3aql6C3snRTfWj4RF6N53moqCZsaWOk52i1JUTV48YIP9FyhQ68AIt
	ekfgqR/TjfJR129IT/2kc0G57Wpg19F2/O1IQYa+PgYoP7/v3SbHAeorc/hdRO1D
	oDm7QQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfcads3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:40:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab878dfc1aso43099911cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752864029; x=1753468829;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fl/6M6Rq/6jNajcCYuhAK92SmJY6l5itfv/1kSpS1jc=;
        b=OMs2V+sLzpvqLNpTE07o0S2IXUyGlIsIzj+Cda5aW14w1KBkfZN3HwyoNq9KMz8gvN
         T8GweMkJ9q7pbTQaiCOEpjdP/LXdFdwFugEqnqtQsKUmef91VByfpMaoUvIklqgDxS3L
         5KhilQp+W9MvGaOxMrB8JH6L1ZNV2ZzW1+Kz/TI5S8Qaoe0ixB/nv19vsdhHTOFsiVu5
         ALeU4xGX9yI2q78d/9njJJSr/ZnxgvqMOXPR+uGHw5AsfuTO1F8pZECB3aaVQ7GlmyPV
         GIq5Hf1+kENbNr0+fUrpJpWEtWCPRTVr9r5YabNme3/EAcDltWAgfoKfDZeAkPDc8joh
         xKVA==
X-Forwarded-Encrypted: i=1; AJvYcCVqsjSwalGEYVxm9Io9GrEW6WjYpaZvbnb8aMN5D7EWBKebs4A6N1u19zuxzq4wCr0b+hx8XotQOB7P0BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm1H9inXC/gQZ8nVSyJ1BAH7Ajt64yaLyc1iZdsrnLL7Uh5PfV
	NeChpMpeD3PG21iGHhapP1puMkt9vjZyqJCLw/fftnBKEgtKGFfOQe1JGM75H1+gqJ4IgZDTi4K
	UET4I5x+8+FRxjRVHOneFxoUdZy8gIv8G+dxLY2fx5gk3pc8yaPWpFM7je/Nj2shZpf5Okpun7F
	Y=
X-Gm-Gg: ASbGncuZ8Dc5V0TfMZ8FSX/4u/Wv7ySpMgCrn9OaY8wUzInP4GOuTcI2jmhp1Ci3Aur
	QbqcPMngVJo8iczb2UdeCDF+B/41ax82Ualhy71fOSIqGkxW213oRBdYjDqcNB0axMXo06laemL
	Z67Ia9qv+5IV3bff8d3fwRnSu91bjXsQ5i9PUxoVj/ijwV5tSzPBAS5tMD9NTlS2zBfKs2KoPWk
	x95re9/c/tlnzN8GT1YHx3Esq9wRzZdCiI29LcRU10OYTymyaNbwH1uBXne4/Ml5bWtymo47yb4
	n/Du1eunmGVr0WD8XIDvXIdQQqAOdX3WVUXeoBq8gtErx3dQCNzgjDCsf28pMhG4ltg+qMOuN+E
	p3uUpavNuR249y0XlNAwKvZW5oi8XIby6AvjXKkiIHJS5rDaE8uMq
X-Received: by 2002:a05:622a:4ac4:b0:4ab:887a:66fd with SMTP id d75a77b69052e-4aba3c8dfccmr129184721cf.15.1752864028753;
        Fri, 18 Jul 2025 11:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2cRSkLcZStyjZjNMEN+wUSX0qjErIvadVGsd64otX6kO10enQxXworlq7oMTTVOWMN7HNzA==
X-Received: by 2002:a05:622a:4ac4:b0:4ab:887a:66fd with SMTP id d75a77b69052e-4aba3c8dfccmr129183731cf.15.1752864027979;
        Fri, 18 Jul 2025 11:40:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a90d4ebdsm2876781fa.8.2025.07.18.11.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 11:40:27 -0700 (PDT)
Date: Fri, 18 Jul 2025 21:40:25 +0300
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
Subject: Re: [PATCH v11 2/8] power: reset: reboot-mode: Add support for 64
 bit magic
Message-ID: <6vlm3ybjpy2jq3cr2pzj4vcmqwoissdml2xmhfzlulfbrpzakt@xrepu6c5zykb>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
 <20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE0OCBTYWx0ZWRfX2ShxlMmDIbS/
 /wPOPFJqUG+kr5xsVQ5U6ne98/erhNvuvBO6cAPMN4t71OIdVrOTPoMh9c46QdrSg112+zDcmM9
 NsmHThNydr/1BqbNPp+WQ521lQhK4i7zOikrQ3UZIgdTTJdIolzgXVTwaEw7UP6tuVg0LROfhQO
 lDpocXAAIhIfcCvwIINS759HLPBdRMc4QlchPrjaUpY1eYOmJ/tifMxDmEQCEZNPdS4VEfKKMuu
 t13JRixvbMpjU5tNGJyNGH7MKRfoH/eelbXRIdn+9Z2LvB9YO4ovj+It+NjWmneLqQsSO44PgSf
 TodESwGAKkKahDaTvK5fwC3VSbUkJUDTEjwBJYY6cwIUy/G95a/YUR7xtIhw2/07Y1o/PVQHqJl
 vF6FfVkYPII0Jtov/d6voWi4hoXOQsYbmQPszmskKYHfCUUv29Mov9usHmhn63x/p9IbGCXp
X-Proofpoint-GUID: 55h03zUZLo3hM8d1JYqLfrnAx0aHg9TV
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=687a951e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=fKl0S-9-5daLM7QqcyEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 55h03zUZLo3hM8d1JYqLfrnAx0aHg9TV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180148

On Thu, Jul 17, 2025 at 06:16:48PM +0530, Shivendra Pratap wrote:
> Current reboot-mode supports a single 32-bit argument for any
> supported mode. Some reboot-mode based drivers may require
> passing two independent 32-bit arguments during a reboot
> sequence, for uses-cases, where a mode requires an additional
> argument. Such drivers may not be able to use the reboot-mode
> driver. For example, ARM PSCI vendor-specific resets, need two
> arguments for its operation – reset_type and cookie, to complete
> the reset operation. If a driver wants to implement this
> firmware-based reset, it cannot use reboot-mode framework.
> 
> Introduce 64-bit magic values in reboot-mode driver to
> accommodate dual 32-bit arguments when specified via device tree.
> In cases, where no second argument is passed from device tree,
> keep the upper 32-bit of magic un-changed(0) to maintain backward
> compatibility.
> 
> Update the current drivers using reboot-mode for a 64-bit magic
> value.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/nvmem-reboot-mode.c  |  5 ++---
>  drivers/power/reset/qcom-pon.c           |  5 ++---
>  drivers/power/reset/reboot-mode.c        | 27 +++++++++++++++------------
>  drivers/power/reset/syscon-reboot-mode.c |  5 ++---
>  include/linux/reboot-mode.h              |  4 +++-
>  5 files changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
> index 41530b70cfc48c2a83fbbd96f523d5816960a0d1..e3eed943fdefa271b22e1f1891abef5c9095b9a5 100644
> --- a/drivers/power/reset/nvmem-reboot-mode.c
> +++ b/drivers/power/reset/nvmem-reboot-mode.c
> @@ -16,15 +16,14 @@ struct nvmem_reboot_mode {
>  	struct nvmem_cell *cell;
>  };
>  
> -static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
> -				    unsigned int magic)
> +static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>  {
>  	int ret;
>  	struct nvmem_reboot_mode *nvmem_rbm;
>  
>  	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
>  
> -	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
> +	ret = nvmem_cell_write(nvmem_rbm->cell, (u32 *)&magic, sizeof(u32));

This will work differently on BE and LE systems. Assign a temp var and
use it.

>  	if (ret < 0)
>  		dev_err(reboot->dev, "update reboot mode bits failed\n");
>  
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 7e108982a582e8243c5c806bd4a793646b87189f..93daf93c097f970afbaf43d36b1e4f725ca7a81f 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -27,8 +27,7 @@ struct qcom_pon {
>  	long reason_shift;
>  };
>  
> -static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
> -				    unsigned int magic)
> +static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>  {
>  	struct qcom_pon *pon = container_of
>  			(reboot, struct qcom_pon, reboot_mode);
> @@ -37,7 +36,7 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
>  	ret = regmap_update_bits(pon->regmap,
>  				 pon->baseaddr + PON_SOFT_RB_SPARE,
>  				 GENMASK(7, pon->reason_shift),
> -				 magic << pon->reason_shift);
> +				 ((u32)magic) << pon->reason_shift);
>  	if (ret < 0)
>  		dev_err(pon->dev, "update reboot mode bits failed\n");
>  
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index 0269ec55106472cf2f2b12bd65704dd0114bf4a3..1196627fbf98d87eec57a3d4ee544e403e6eb946 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -19,12 +19,11 @@
>  
>  struct mode_info {
>  	const char *mode;
> -	u32 magic;
> +	u64 magic;
>  	struct list_head list;
>  };
>  
> -static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
> -					  const char *cmd)
> +static struct mode_info *get_reboot_mode_info(struct reboot_mode_driver *reboot, const char *cmd)

Why? This doesn't seem relevant to u32 -> u64 conversion.

>  {
>  	const char *normal = "normal";
>  	struct mode_info *info;
> @@ -35,11 +34,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>  
>  	list_for_each_entry(info, &reboot->head, list)
>  		if (!strcmp(info->mode, cmd))
> -			return info->magic;
> +			return info;
>  
>  	/* try to match again, replacing characters impossible in DT */
>  	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
> -		return 0;
> +		return NULL;
>  
>  	strreplace(cmd_, ' ', '-');
>  	strreplace(cmd_, ',', '-');
> @@ -47,21 +46,21 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>  
>  	list_for_each_entry(info, &reboot->head, list)
>  		if (!strcmp(info->mode, cmd_))
> -			return info->magic;
> +			return info;
>  
> -	return 0;
> +	return NULL;
>  }
>  
>  static int reboot_mode_notify(struct notifier_block *this,
>  			      unsigned long mode, void *cmd)
>  {
>  	struct reboot_mode_driver *reboot;
> -	unsigned int magic;
> +	struct mode_info *info;
>  
>  	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
> -	magic = get_reboot_mode_magic(reboot, cmd);
> -	if (magic)
> -		reboot->write(reboot, magic);
> +	info = get_reboot_mode_info(reboot, cmd);
> +	if (info)
> +		reboot->write(reboot, info->magic);
>  
>  	return NOTIFY_DONE;
>  }
> @@ -78,6 +77,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
>  	struct mode_info *info;
>  	struct property *prop;
>  	size_t len = strlen(PREFIX);
> +	u32 magic_64;
>  	int ret;
>  
>  	if (!np)
> @@ -95,12 +95,15 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
>  			goto error;
>  		}
>  
> -		if (of_property_read_u32(np, prop->name, &info->magic)) {
> +		if (of_property_read_u32(np, prop->name, (u32 *)&info->magic)) {

Again, somebody didn't think about endianness.

>  			pr_err("reboot mode %s without magic number\n", info->mode);
>  			kfree(info);
>  			continue;
>  		}
>  
> +		if (!of_property_read_u32_index(np, prop->name, 1, &magic_64))
> +			info->magic |= (u64)magic_64 << 32;
> +
>  		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>  		if (!info->mode) {
>  			ret =  -ENOMEM;
> diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
> index e0772c9f70f7a19cd8ec8a0b7fdbbaa7ba44afd0..6783d05e80fbc2c812b45ffe69755478af90d30a 100644
> --- a/drivers/power/reset/syscon-reboot-mode.c
> +++ b/drivers/power/reset/syscon-reboot-mode.c
> @@ -20,8 +20,7 @@ struct syscon_reboot_mode {
>  	u32 mask;
>  };
>  
> -static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
> -				    unsigned int magic)
> +static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>  {
>  	struct syscon_reboot_mode *syscon_rbm;
>  	int ret;
> @@ -29,7 +28,7 @@ static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
>  	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
>  
>  	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
> -				 syscon_rbm->mask, magic);
> +				 syscon_rbm->mask, (u32)magic);
>  	if (ret < 0)
>  		dev_err(reboot->dev, "update reboot mode bits failed\n");
>  
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 36f071f4b82e1fc255d8dd679a18e537655c3179..d9d9165a8635e5d55d92197a69c7fae179ac2045 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -2,10 +2,12 @@
>  #ifndef __REBOOT_MODE_H__
>  #define __REBOOT_MODE_H__
>  
> +#include <linux/types.h>
> +
>  struct reboot_mode_driver {
>  	struct device *dev;
>  	struct list_head head;
> -	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
> +	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
>  	struct notifier_block reboot_notifier;
>  };
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

