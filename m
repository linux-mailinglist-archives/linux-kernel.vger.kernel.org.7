Return-Path: <linux-kernel+bounces-845880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9024BBC664C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D51C19E42B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449652C11FD;
	Wed,  8 Oct 2025 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPKn5zfy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF822C11EC
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949964; cv=none; b=gfuZz5fWmwAvcd0W49BSueJ5xEHkHYYLyt1PPafCuy9VzvncTdCTEJPNeLUSlvT4FKGMbAarsKFPSupBcW3qaelGrpLnfC8ttYfP6aJ3+FsBsBPMk5aP/4ScsjzPgN7n/fpCdmdHGJcHZD/4KsjuI1fldtbJJyFvsSCuNDGoW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949964; c=relaxed/simple;
	bh=pkKqRsIwDhc+RUJiMdhK9GH1Pl3ZLZDY4dZbArFqFqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQiUlnxdxas3PWyFFMIgE/l/BOpENW3IeqqJmzxBAyaLPhzdwFIYf6MeS2cUTbFL1ApeJPSxtM8uW+u4IdtviKA9b0+IcZbPVAlDGEyXI6QegLJZWG6wbiNwd+O63Gdu3fVPZ63B7rB4RdtvM8iec9jSsTGRwGb4nJw+b3tfUKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aPKn5zfy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5xCd002709
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 18:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0UdkETRPI6ZWbVUbfsUgaXMe
	BnN/d50E+m0AcvlG3Bk=; b=aPKn5zfyCDXgHyxBiNSZBLkmEvt47oUi2RWDinGN
	uQyvvHaFX7LMl4N+6Xg7E0U3ZeVF21BWfHPP8/CZu+uu5h34dEKRoIbzQB8J0TiE
	DvOiVboPksV3SiAiPr6QtYJTignIEKkUErz5spHye4nfnnfOqKUBBAQoGQyTMiD3
	ZI4+mGUQUxc6mOcJVvXDWreZvdia3EDeMCn4p3gz5nnLqZMjoF+PwYiZKnDaCdDW
	hHwXINXjJlzCADrcoRbbyK468HCH703v1rkrq2SgJvhihFsk28r0YhAFs2+8Iok1
	tSkAzrPEffpnZnS+t63g3pd0//gAPGz7VU8cmZOD8FpGTA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kraj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:59:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-879e66b788bso13668676d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759949961; x=1760554761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UdkETRPI6ZWbVUbfsUgaXMeBnN/d50E+m0AcvlG3Bk=;
        b=ERuhfZxtQGPHMXV6+hE9hDq5pyv34BCtJ2/5nYR0o6XyE57pfgeqDM0F5eQV8QSwcm
         aM+Cx1fgfIrvrtys3BF9WyGa5eRiUdhW3yiuVWe2seUSOF2euecVx6/KdyPR6gAJJiSQ
         p3zxOhYV2cjOYyRrnIZDFzEj8M2v62AdnqxBhjKxBI0ZYvCLI3MUB783XGBHxdF3t0gU
         rtL9IZ4kWNo2uwtxLpx7zPVAlXKvPW9qedqlDdfvdDxLrqPCOzjjh2p7iKf+GfESMbDF
         L/7p7PmHvK4Fy3U+SH75IwGvRkxwK+H0zn+vSJYPw+V4k+dRTivCDIK3AaBweOnJBX7V
         08Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUUwm/NpGvB2H1kV7ojJ8YaK+k4B9+58YnutkgfHI7ftHyYzF8VHKpGYGfBx+93RH8tyhKXlCY1MGuNKj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvUroI8AGsSrVHuSZCDOScQxT9xKpM/iUefxZ47LcLqUttswQ
	nb79CUJIGj6L7lM00AuWPtRh8Z6qKX1ZOUAcTIoE2CUgy2mid2f5o+thWfWlL7i7FfyRKym73me
	qthToFaf7T5Vsh8SeEZdTtHphEKFnkXd1fA5qY869OGxrpylR4+J+ErRKIc9PKhEzvCM=
X-Gm-Gg: ASbGnct4/UxVY+uLVkhtpMXqt/hTC0jMjwN1pIzArl5+l2sBAWOigCTLBaoAPvLQwaE
	j03g2ORdhPbTFr0wES/AhoBFHR73tHJ05YK3Md8i20GDg4+wmunaOijWIpd/bT9HwSJaX6ARWpC
	AjMy3bWyc81ltCj6IjbfltG4kEactT00lDlAGAzHCk6cZOFtkYSfyq6JJdE6TLqPSUzc59nfzFK
	NRpH+RJ4ymLRavPuWsZl8U5FPcWcH/W91X5LPliKyocSbgNLDXaJu29OQmX5aVbdx7zSE1X8Gh7
	Ka2shmB3hwSFSDccwaw00lghHMUrltxcNajAMneTD5NWxxv/nnUKCfkD8bIe1EWqOyoMfqDfpT9
	nxJJw0k7qZ2k6LYDX4bpiUpBgl5vtZ6BTmsD0cnB4ODWebMit5UUlwgaN2A==
X-Received: by 2002:a05:622a:1b24:b0:4e3:970:661a with SMTP id d75a77b69052e-4e6ead91fe2mr67087911cf.75.1759949960535;
        Wed, 08 Oct 2025 11:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaXzhWAKXAgn1FOnUImvO0Ih0s0vnFPkEOMy8MA4cgd7lRzHdrWt6cw5JjIrgIzgwo4fpdJg==
X-Received: by 2002:a05:622a:1b24:b0:4e3:970:661a with SMTP id d75a77b69052e-4e6ead91fe2mr67087441cf.75.1759949960070;
        Wed, 08 Oct 2025 11:59:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ac00be6sm263748e87.23.2025.10.08.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:59:19 -0700 (PDT)
Date: Wed, 8 Oct 2025 21:59:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] drm/panel: Add Samsung S6E3FC2X01 DDIC with
 AMS641RW panel
Message-ID: <6yp5udhm2g42basxeyjnn3onfons2k2besxfqwemnqrafsai6q@tfr74bfz7s7t>
References: <20251008-s6e3fc2x01-v2-0-21eca1d5c289@ixit.cz>
 <20251008-s6e3fc2x01-v2-5-21eca1d5c289@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-s6e3fc2x01-v2-5-21eca1d5c289@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8hzwGPxSu6W7
 h5qRVajIDXcKKOSKm9Uz2kuyRi9+LYSnojapDnukNNiaeuOpdb9ipL+1qgT/Mv3aP0efRbWnD0U
 v4POz5ZAoqAyw77+Oz8T4sS1CWMjT7Fywq852ZJyQj/TAkpDmQDmNrXX0U/lRigmsqB8dtfXnvI
 zWL1OP+LpTS9KP5+n2nPINu9ZSmjmKWR+VUHryZoROvIvUPp79stA7vB+9OWt7/GTdKi+5Uzz+K
 Iks8aWHYFB3hIF2XP0PIUdt7eenq9kMB70zsd2ifhpNLp01OMXuH5Cl0cjjaz7fh0+aMzHKLzg8
 xgtMpOwPhDVwuS/CcFpxVcXF9WI2MlqD8birD2a70zvxOOP7jqKQunuCVMBnZUy2RNJc5uuB0jA
 bptbKKM9cSRcevM66Gzkt2Fp9rMjsg==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e6b48a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=WFa1dZBpAAAA:8 a=bBqXziUQAAAA:8 a=SYGtE8pA4Zq6nJvkfUIA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=MZguhEFr_PtxzKXayD1K:22
 a=BjKv_IHbNJvPKzgot4uq:22
X-Proofpoint-GUID: bH7G8aHdYGFoYcW_El7VBxFeh_GVMqJ_
X-Proofpoint-ORIG-GUID: bH7G8aHdYGFoYcW_El7VBxFeh_GVMqJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Wed, Oct 08, 2025 at 04:05:32PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Add panel driver used in the OnePlus 6T.
> 
> No datasheet, based mostly on EDK2 init sequence and the downstream driver.
> 
> Based on work of:
>   Casey Connolly <casey@connolly.tech>
>   Joel Selvaraj <foss@joelselvaraj.com>
>   Nia Espera <a5b6@riseup.net>
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  MAINTAINERS                                      |   1 +
>  drivers/gpu/drm/panel/Kconfig                    |  13 +
>  drivers/gpu/drm/panel/Makefile                   |   1 +
>  drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c | 402 +++++++++++++++++++++++
>  4 files changed, 417 insertions(+)
> 
> +static const struct of_device_id s6e3fc2x01_of_match[] = {
> +	{ .compatible = "samsung,s6e3fc2x01-ams641rw", .data = &ams641rw_mode },

Again, why can't we use defined compatible here?

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, s6e3fc2x01_of_match);
> +
> +static struct mipi_dsi_driver s6e3fc2x01_driver = {
> +	.probe = s6e3fc2x01_probe,
> +	.remove = s6e3fc2x01_remove,
> +	.driver = {
> +		.name = "panel-samsung-s6e3fc2x01",
> +		.of_match_table = s6e3fc2x01_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(s6e3fc2x01_driver);
> +
> +MODULE_AUTHOR("David Heidelberg <david@ixit.cz>");
> +MODULE_DESCRIPTION("DRM driver for Samsung S6E3FC2X01 DDIC");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

