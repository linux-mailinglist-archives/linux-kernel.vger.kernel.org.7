Return-Path: <linux-kernel+bounces-813715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A1B549DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC14AA7BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDDB2EA499;
	Fri, 12 Sep 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ez1cDXbS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C537A41
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673078; cv=none; b=NfoB5lvJj1M6793L2s2LTU5gmreLp2cK8bkt4RNw5ya6BsAau0i3KO+tpIR/1gEmXnnkSjJBmkz7KKWhv10TR9x7s10oC6fL1vO7/SfT/sUbizikSc9y7oreewjpQ+oG8vHZYt5cDI/4/DmSsXPDN4lI9zA9qmKUomkb6NI+8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673078; c=relaxed/simple;
	bh=ru1yGOyd5Y3Fq7JTiCyy2tLRgTdN7eeDCsE0W0qKNIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koX2umM+0CmM4Lu3ubCHykO2L7dGSzw8GMfxRduX+RRWaJFvutVrX8xse8aSA5QliKDA5Dj0r7LcKwzkLW5StspkNVZbWQwQ32/mdJ66ei1qbD8BeTF0KWWz1V0wzoL7WTsZBo5oSXQ/9sgYsiTn+JS+LaAAPkp0sk+mo7VNaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ez1cDXbS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fKrK014033
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QYQVjSVGI7fSyP5NPLcxC0Gn
	NWMprT3G/Z6o5y804gQ=; b=Ez1cDXbSvnGemg8472pZ8bhDQSW/4Ft8Q83R/893
	2LMiB8BhNhqVTzcLqTFOdPPzOGEBduIjUcmertrhXjUEwFazZ8uDN72wdBV17WVQ
	N1IP3xd4EzB6oLWkiiA0uY9D3WlGRnKQhXnOmECOHgeQFIT9qcKZ5aoBLm3xiFcK
	D+d1nyaUn8T/SNIOoVZO6Dv7YJUi2wuXu+p8yn5Ui7LmKx7tNTArTDBp0+OfU3kj
	emw5YhBiJ+Oo3Kqik7N5C5FR1Nvb/HHQFGiG2jJRmnOVbC5aTQJNh/VPpp7fJ2K5
	3WK/a16Y6uK50vMN5E1UFSsc/z6PliVOMaryGGIDqb4UDA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphvwfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:31:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5fbf0388eso25100221cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673075; x=1758277875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYQVjSVGI7fSyP5NPLcxC0GnNWMprT3G/Z6o5y804gQ=;
        b=kc8bZf2Wu7XZ1JeubKVMp1I5vf1s4+2rzrxDPNVBOhm+whutuOJTAQJCSPZo4n96Oh
         165g5HBMHqPBG6BLFdr+Ym4MgHXT6cH4vTJhoyKgcJIyr+UGayoSnC7jFCGgASf0bfnW
         xuOe1JOvwhdm1IqreN0foQ4k1f8OGInxuR0hrI6CnNRL4jiLIxkhRS/Sr8PULQpcCe7N
         uG7kUOx0D/OiCn093YpHYFGeenX3GVt59csCQZ6Ie2UPDydsiFpJClxL+YWWigHn5osd
         fB0dIpZx/6M05p2hQe/hbXsnoswJatAOS+FvDZw9VRpNID2kpgD7NKPh2BDb4NazDKdF
         cjiA==
X-Forwarded-Encrypted: i=1; AJvYcCUYcS9xLKT1LW36bOXzxPFql+PoTT9Cjgpd3SAsTLgizDdc73mBUkW5DdXmvdQ5gIMnrHBgwxBWCOpVf/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9NOYAR4GO3lG8nuHSQa8Xrg6yw28n87zBp7uZruL6t4zdHvs
	1p6WeyF+hR1z7RQ3ykwo8IMLLXRO6YLlMfd041700jqDbc/q5xpyiZzPCw0GW4jAavUKrxUqgt7
	8NmzJNFFfedhtnichpET3gbHMYy9iW2ImuUOgMrv7YBCZYxvuZNG/6a2vTjmnzMB19DQ=
X-Gm-Gg: ASbGncuTg+PkNeVHmXfCCYCWzoDKIrFT/qopa25uSmSVG5yzD525eFVyek963yz8w5C
	rehRMmy7YyfXNdUuld5J9tqqSFDlYRsWw2qGgKWu07GWMSlm0Z8UCpMwTptjtIwaqv2RWgldikc
	C0EVSOYTbek/jFZO0Thc+n+V6GSDTprUS1ONDJexTmzx2aZeIiDBgrZay2+NY/jYBfB8fuXV+kd
	pvKYiwn9P9GGJgmRNyygmKgudTi6pCVZt8FO5lT0a2ukBY7ursieFnV2SQu3AKrC1Tae5Y3aArL
	0UCmgSk/NhE/o1gOhGXJ4Dc9LtVRo8PlhdmYva32zovd6LivfYF8DVfzvjvVMa8w6CEZXSpk13A
	qLNzUfyzSzZj1tW2Uguuj/6E7eqigDy/SGc+X7nzXLc5YC9EUAiZL
X-Received: by 2002:a05:622a:11:b0:4b4:9773:5866 with SMTP id d75a77b69052e-4b77d0c8726mr25974391cf.65.1757673074740;
        Fri, 12 Sep 2025 03:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlmYG3GvVCPpgbJA4niCY20ubvFQsgSIGszF/TZGTRPQ9P7ipXCexaQtPdOTizRtrNWqVY8g==
X-Received: by 2002:a05:622a:11:b0:4b4:9773:5866 with SMTP id d75a77b69052e-4b77d0c8726mr25973891cf.65.1757673074110;
        Fri, 12 Sep 2025 03:31:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65a3464bsm1032362e87.139.2025.09.12.03.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:31:13 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:31:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 10/13] phy: qcom: qmp-usbc: Add DP PHY ops for USB/DP
 switchable Type-C PHYs
Message-ID: <buob3axokndjfuwvv5j5zee4e66tf7t4ficz6fend5yadw4j6e@czus6n6zfor7>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-10-2702bdda14ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-10-2702bdda14ed@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c3f673 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tOlg4r5JIpINhLxCU78A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 8ibATIgog3g2trHu5hPhAoK_HleRRP_c
X-Proofpoint-ORIG-GUID: 8ibATIgog3g2trHu5hPhAoK_HleRRP_c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfXyysFiWq4HzLg
 MDAwLvc4HabaP5eYgGnhd8Sya9E/x12qujB2D1M7+N3unMENXF8bU9hVbaSUKDEolm/XDwQLfRi
 nBiF5w/zC6s287vL/tpTu6zzkzCcpOzSE57ZFuIgzx7okWQwL0ScYWCpOAqNnaiNQl6Dv7PhaAS
 euc7fQittoDPHl4AmWcfMVeE8tlGpgaTk/MwUr/2xUeemLiKQzU4Jj2j7I+bbEQdrBl6kL0tsI/
 +ELb/g9UYYNLfV4rZGoTkPK/NI9JXbXkRrPLbQ86GAzP607BaOZ5kEzi2ZdwErWCq6a9IHk9Lf2
 k6/PPJUkuFW/m9LGWc7sQ5mkIEufLMNA1oA0UMyRZYVXfFh6r8umTeXNsgfQdBzFDC7CxnTrlTB
 EA0eTDLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

On Thu, Sep 11, 2025 at 10:55:07PM +0800, Xiangxu Yin wrote:
> Define qmp_usbc_dp_phy_ops struct to support DP mode on USB/DP
> switchable PHYs.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 192 ++++++++++++++++++++++++++++++-
>  1 file changed, 191 insertions(+), 1 deletion(-)
> 
> @@ -1669,6 +1832,23 @@ static int qmp_usbc_parse_tcsr(struct qmp_usbc *qmp)
>  	return 0;
>  }
>  
> +static struct phy *qmp_usbc_phy_xlate(struct device *dev, const struct of_phandle_args *args)
> +{
> +	struct qmp_usbc *qmp = dev_get_drvdata(dev);
> +
> +	if (args->args_count == 0)
> +		return qmp->usb_phy;
> +
> +	switch (args->args[0]) {
> +	case QMP_USB43DP_USB3_PHY:
> +		return qmp->usb_phy;
> +	case QMP_USB43DP_DP_PHY:
> +		return qmp->dp_phy;

return qmp->dp_phy ?: ERR_PTR(-ENODEV);

We are not expected to return NULL here (and dp_phy can be NULL).

> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  static int qmp_usbc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1743,9 +1923,19 @@ static int qmp_usbc_probe(struct platform_device *pdev)
>  
>  	phy_set_drvdata(qmp->usb_phy, qmp);
>  
> +	if (qmp->dp_serdes != 0) {
> +		qmp->dp_phy = devm_phy_create(dev, np, &qmp_usbc_dp_phy_ops);
> +		if (IS_ERR(qmp->dp_phy)) {
> +			ret = PTR_ERR(qmp->dp_phy);
> +			dev_err(dev, "failed to create PHY: %d\n", ret);
> +			goto err_node_put;
> +		}
> +		phy_set_drvdata(qmp->dp_phy, qmp);
> +	}
> +
>  	of_node_put(np);
>  
> -	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	phy_provider = devm_of_phy_provider_register(dev, qmp_usbc_phy_xlate);
>  
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

