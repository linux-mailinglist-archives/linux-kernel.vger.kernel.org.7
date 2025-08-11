Return-Path: <linux-kernel+bounces-762383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B3FB205D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5ECB7A235B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3892E2E3706;
	Mon, 11 Aug 2025 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c+aF4Lu9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C8722A80D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908751; cv=none; b=fSFIYAjwzSBkHRay+Bd56K35jowEkShOtd4P4gjYT78xB6785GD8zSyg7gqVXmcd6P6+wIhqF4C0FAJbRUbEP8SFLi8x220zmeCqZGIJ6krRRAyVmwjCwGA8a8wISKcYKfvaOweMyY+14qCFkTut7Zrl8mdkOLxoMmryzT9QI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908751; c=relaxed/simple;
	bh=kdFYH1VYiSyu0VHOBK+SFNLLMYFqZVqZCDcvjsyo/Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5dzjXoxC8PEsBnUUqiOJQmoBTlJWhRwTslOLa7TRLLXb8kJwc3CDxz+zH9JB00vBTum0G6TknN8/GT19r41Ams/j9uEtgWKWWhPlUKciXNFOdSIhqmUUb4q9ZXgSLZbtu3pSQarL7ajK7Ljxt03GuqGNBNS4L3T69LgwCAD4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c+aF4Lu9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dVOC022882
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8nAbwc3oA2Tcir9RuGi1mn2w
	n6rS+EOUE2odnraMql8=; b=c+aF4Lu9YR9hMl3bkVI8kdO0Ijf+TeNdiLOXcK82
	r6dwXmNds8EySKqC+OQ5+iTPrW7FioT63t1e6dq3DcJEsc0o83EdErJhDjE50WoS
	bKdl2P/S4IdhgAZokd7fZeMfUzkkYrgf49wdfPN6r7dvOnwZPV8oSOmpOpX8nyZ7
	aBpvT1hfYblJYzoRS2AigbHLtKYa2jJ2W05ze6cJS9NS0FfyXbqixk6wD01jLE1H
	pxwASbeP4pu4kcRBH4snHFrhykcNfIItJZtAsODFyltKDQJvP7dtiee/GFq2nPHr
	WxbkgW/M/V22qOO2B5999AV8mWb/1Cp18sa3wNZz8+0O0A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj441yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:39:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b08d73cc8cso119812681cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908746; x=1755513546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nAbwc3oA2Tcir9RuGi1mn2wn6rS+EOUE2odnraMql8=;
        b=a1waoH3dZljDcW+OqMiMIX0P/M02Ok80Ke9Ms4Hi1sDUDwxwkAQF1lUp5JaxisrNeL
         lCIvnPYXap+whL4jNWFYraCH2CrxJHXhzmEAclVBYNp24buP0H/UAp8cYMlv0ladZUhx
         jzpWZKPcAjulRPdsnzu0m3sKfB1rpE0+JYsrQgFX7xKed/pHh1QNsISAA9yBXMmVjoyi
         ZdmcA0c/SdJ9bF660yaZzyQU5ft/y05lmowe1Nk+UQDey9m9qLVNXkuY75fOcxTscSK3
         ol5e495sRpsGnPuW1XTxzsVOXefGeszyQCj7fxl6gWY1matq5x87ot3Yr+8DJByqKf2y
         quUA==
X-Forwarded-Encrypted: i=1; AJvYcCXRSRAwm+0jyy8rGlRtGCnQt2oqqKjw8+sQn2xsLhlMeSdgIJVRkiPv8h/Adr+cei8CvDHPdTHLtTshxaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgCDaMggRdsS3YF5f/X/wGTLdOvBP6EU1xTMvkCeKb12PKbmYe
	oGDroyXemN/T64guiSMe8e+uwknCaoZZa4ZTQ6euaiiR5W9MeOpV6sCLDC+74OXDisK85ho1uTR
	nHO1HfmvKC+JtNLGrLpwYvLrrZCLdsoGbVUM9lZ2gyUMYGiVGTCGt6x+W5bYRFapy7Tk=
X-Gm-Gg: ASbGncvULcN7NwKacElDK5dV4X3QXRCwEq4fd7wgMCM5js0vj7allVpzE4sYd1PYg49
	CM1xdySkh7lQMFL88ZA3dfch2B1gA8Mb1ycmGnX7NV2YGNfjXvHzBoxBdFP6QITTVmr37UQCJQu
	xtsOXHM+9I6lQVoIEDOmHR1Im5C6iFh6LmTx2dg4UhR2zqdUJ5hIpKFGtHD9N9y45cRqAPsnVov
	2eTJl6R/8uQVUugeim+nkbjXqcJy/+UwmwTrlsuKZG/J43YRuZEHrSrVYLNPQoHLyjdGRgyq4W+
	xd0e7uONMTJMWWXLdtXH7m4AFFrJBA52SNmMkzneskbh01vBrWKKdbCDNZpt9mpjKsr4N/8gkGB
	+cJ3G8pkKBQRVS3FIslR033PtIKpOY3vPn/OlbmtMyAY5IocZoqfv
X-Received: by 2002:a05:622a:52:b0:4af:3b7:7011 with SMTP id d75a77b69052e-4b0aedce1f4mr140012521cf.35.1754908745910;
        Mon, 11 Aug 2025 03:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiBFLWSXP9zPRYzgdj7IXxfYgyXaalDNulEs8SfPCYgfuywaH3NXBNE/AI22m/3gcN9RIVqQ==
X-Received: by 2002:a05:622a:52:b0:4af:3b7:7011 with SMTP id d75a77b69052e-4b0aedce1f4mr140012231cf.35.1754908745375;
        Mon, 11 Aug 2025 03:39:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272944sm38386241fa.13.2025.08.11.03.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:39:04 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:39:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wenmeng Liu <quic_wenmliu@quicinc.com>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: qcom: camss: Add support for regulator
 init_load_uA in CSIPHY
Message-ID: <d32cbtfzhwpzsvxpb7esvndpqxooergkzhlx2jp4ikuc3bsaop@gyxnlusuptg3>
References: <20250729-camss_csiphy_current-v2-1-da3c72a2055c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-camss_csiphy_current-v2-1-da3c72a2055c@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX1IBL2x5faKe6
 H4XNypMNHA+y6Dxu4FwaoizLHhs80KWkOBmNlotKDtWMOsttq1nwZuu3q1Kxxt+/kBmqxdJUc+g
 e22CitRqHvNd2bLSwJjMy2D8k5mSLR9SJlzBI49/vqbyb5EwUb5y/1uUtZ/ZWcBSYU6U5aaVlIg
 JxKSp09AIloAqWUHThFznxnQ25fdhWRkcVCV0AlEPcxuKRn8ZUhouikcrdsgdqRB6q+Rj0dNrNM
 h7XUS1g/afYu91VucsWTYs6WKl932a6LxcNikcKW1Sab1MXASUygTnHtpac99IUDIqpLwys+/Zi
 7OUqPVllSDmae28UHd/lWaRE6P8I9F2Sb5t0XSwDbcR+J6YxBIvd4VYPwvQ8+6iao/GqbTvlGv0
 USlf+xAL
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=6899c84b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=wkYRGT_rTjh0G9-bfQYA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: yxUHzuHaKCtuUxVtMW3H8JrxKIkESOLY
X-Proofpoint-GUID: yxUHzuHaKCtuUxVtMW3H8JrxKIkESOLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

On Tue, Jul 29, 2025 at 03:24:55PM +0800, Wenmeng Liu wrote:
> Some Qualcomm regulators are configured with initial mode as
> HPM (High Power Mode), which may lead to higher power consumption.
> To reduce power usage, it's preferable to set the initial mode
> to LPM (Low Power Mode).
> 
> To ensure the regulator can switch from LPM to HPM when needed,
> this patch adds current load configuration for CAMSS CSIPHY.
> This allows the regulator framework to scale the mode dynamically
> based on the load requirement.
> 
> The current default value for current is uninitialized or random.
> To address this, initial current values are added for the
> following platforms:
> SDM670, SM8250, SC7280, SM8550, and X1E80100.
> 
> For SDM670, the value is set to -1, indicating that no default
> current value is configured, the other values are derived
> from the power grid.
> 
> ---
> Changes in v2:
> - Change the source of the current value from DTS to CAMSS resource
> - Link to v1: https://lore.kernel.org/all/20250620040736.3032667-1-quic_wenmliu@quicinc.com/
> ---
> 
> Signed-off-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
> ---
>  drivers/media/platform/qcom/camss/camss-csiphy.c |  4 +++-
>  drivers/media/platform/qcom/camss/camss.c        | 26 ++++++++++++++++++++++++
>  drivers/media/platform/qcom/camss/camss.h        |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> index 2de97f58f9ae4f91e8bba39dcadf92bea8cf6f73..7a2d80a03dbd0884b614451b55cd27dce94af637 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -707,8 +707,10 @@ int msm_csiphy_subdev_init(struct camss *camss,
>  			return -ENOMEM;
>  	}
>  
> -	for (i = 0; i < csiphy->num_supplies; i++)
> +	for (i = 0; i < csiphy->num_supplies; i++) {
>  		csiphy->supplies[i].supply = res->regulators[i];
> +		csiphy->supplies[i].init_load_uA = res->regulators_current[i];

Could you possibly refactor to use devm_regulator_bulk_get_const()? It
would save you from this data moving.

> +	}
>  
>  	ret = devm_regulator_bulk_get(camss->dev, csiphy->num_supplies,
>  				      csiphy->supplies);
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index e08e70b93824baa5714b3a736bc1d05405253aaa..daf21c944c2b4818b1656efc255e817551788658 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -750,6 +750,7 @@ static const struct camss_subdev_resources csiphy_res_670[] = {
>  	/* CSIPHY0 */
>  	{
>  		.regulators = { "vdda-phy", "vdda-pll" },
> +		.regulators_current = { -1, -1 },

If it's unset, it should be 0, not -1.

>  		.clock = { "soc_ahb", "cpas_ahb",
>  			   "csiphy0", "csiphy0_timer" },
>  		.clock_rate = { { 0 },

-- 
With best wishes
Dmitry

