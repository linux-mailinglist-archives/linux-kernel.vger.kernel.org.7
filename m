Return-Path: <linux-kernel+bounces-866921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A32EC01097
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9C73A9CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B05311C35;
	Thu, 23 Oct 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="byzevInz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586DA310777
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221695; cv=none; b=k3jsLfHOY1IWW3GU2tBesJumUGtGED2K71g13WqXcNH5Pf0sd4mTU5Obp1XxwpGOEEXIwYBZYMHPC0iQQdeYjQR0p1Benf13oAXYrRX6onWfVfA8YeJUHbJIW1BVx62m73MK3k5OSU6vYclEe6RPigXrRw5Kvb0u4HyhvP0HvEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221695; c=relaxed/simple;
	bh=mKKZ+GisW4033CvpSmrHhhuLvqXiweE3YNZdMeZfmGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJn/PwBZ/1hjrd41yTQHD4e4GqFceQk7QsEYrPyP7Xc5TlNfDxFNeizJD0eHQ2/DH3Hk1TRjzInXm2DJjclfRgAWw3QbXKSAGOIVEZsBmgN8BxZnNYO9vn7HZ5HAkfedhTrzVAO65cFFY5N6PYw/BuYeRp8EQDnK9pcRI6Y1h80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=byzevInz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6iTt4026532
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5onFcSVtjASenfWYLyuXz7Ij
	aEZN0TDQOoqBl+QFROk=; b=byzevInzK3g9LUPjzm/e9hwxr+VfC64JLQt+UMkY
	xX55uPVmpIAkfnyLrD5ytJwSUlu5RgRuycTFZvu74Uf48yOs2eDSpi9BJbSMFH12
	qvnY6/dbeNVfHyU/EBWerTP3arsUgCXFSXD8ZKc2KhqBSCQWjUPlZSW7MLhTwCR+
	VE0/ozm9cGuQRGIBMaHc1r/dbD0RL7JmUdimgR0tFltGv46vWlYAO1co8tSHGBk4
	nKh2j0qAgU1QOXxdsMfzEIb/JjMCxgyY0VVq7RuMLiKNkdhwKkgo5AZKoBO0N3SR
	+f+J817Ms+IkI3IXKatVU8VG7IlEo3tATvPHOLVnuCViow==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kg53s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:14:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8a89c9750so26412501cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221682; x=1761826482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5onFcSVtjASenfWYLyuXz7IjaEZN0TDQOoqBl+QFROk=;
        b=AIR4zoAwhwOs8dpD8A9cQiVmNK23Nw3wL9/Zi7Paxxotc9oicVp3ligsGGfOJslAzg
         0Nsvie87CCPXc+tjesLk5TuZyi3R2F348js6cKOvCHwVBPmYnm1cXAVAPB+erMVvzm/U
         X1umERMoZVC9zmUSlNSyxXBOUqkG5RbEKfW+PR9cWKJYH330449MUHdFlwSiRLNqzhSw
         kE6aV7BBSqViEenPPsfN+HlQM14U9tZyDTyUjvN1lv7BZ6Mzdhj9XuczXmRAxji5qaCg
         LlR7mwCyI2yusAmkX3r8EhfZfy+o3mwCv/hkl0nKCNaFfGbeMUE7J8Rp/9pr61sUwTRo
         7GcA==
X-Forwarded-Encrypted: i=1; AJvYcCWpD1Iiu52NrLJKLLAKcNra2vecTcuOcwUh223ADhzjF6qlceBeZeNACc2jogzu5xTZYv9Cr150J1UhRhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2UZf6WuXYEoOox5i6GHDTyXWx97dwzmf+vNmZJexrr8JXqpk
	F5MAQn4zPBMUx2miPR/nKrqzjxumtyXId1C6HBb2rB3JAGNAHpmrgTtAIzSfvLgZu/pCFdjJioa
	QOvJ5d31sHQ4eo7nnzjEKFetQKVFj3fmhx8gKqaBfQyNWoNLaIqaBJlrdxd1mR2EXlSo=
X-Gm-Gg: ASbGnct7eLava/Mak9J3XIT0x2lYhhH7wBolJdKnd64LL/t+iwD9OYWD9FeS94GehDx
	AGd4vMxeQEj6cM7C59r7RmuevxkTW0qBnXcbh8k9nsMHJmpB655EXpRufl2NzFryhBMPWP0Ec3r
	Id/TIO4djGhG6BlLafQEepJbgY90l6c9uBdK2aqRor0VwTx5B+26jtpeTEtZghQIps5oWyrUqfO
	cbzk28MdjvHHXRoVGXqTqNadUVTlz3n5xbDxrPNXJoZ+sbI8UWVAdVHFMc9luDCiENmFxD17lv9
	UziwsISZNkKeVUPUn8+ZcY4pvd0ystNKzlHY69vmph1JoVpMk47nFmTwTLFe4YUoiabgtoF+UbI
	vfVOulwAc6+cvKZBSWJmEeQoPXpw4AwlDcbY3IiTFRO7L4cy/doy7fUTzUpBrEifFfQMvlZ10j/
	Oyb8u+bGXEM44Y
X-Received: by 2002:ac8:5ac6:0:b0:4de:cb90:dbe4 with SMTP id d75a77b69052e-4e89d393b93mr314967101cf.66.1761221681957;
        Thu, 23 Oct 2025 05:14:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESzd2NTnn2inqqoUmN9EYSM5jAuMSd0Wq4bXLNw8lQEUOtptDq/50z8lDPp8MEtECsteYIdg==
X-Received: by 2002:ac8:5ac6:0:b0:4de:cb90:dbe4 with SMTP id d75a77b69052e-4e89d393b93mr314966411cf.66.1761221681423;
        Thu, 23 Oct 2025 05:14:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d2c32fsm702012e87.89.2025.10.23.05.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:14:40 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:14:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 07/12] drm/panel: Set sufficient voltage for panel nt37801
Message-ID: <zxofh6bwee3vjjlntlfqy7yg2iu2mipjvl7s5bcm6gbh233cjq@nuicjojawd2d>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
X-Proofpoint-GUID: te80iDddX_MTJW7f-Q_wP16XxZdYKFdQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfXzKMaZ+TW6V+z
 CIvdMwZhvNS2Jct+pPmzuv+ZLLkS933KN1M+WnRZAFcP274EBaBlvdjTXaBT+VVRPj6uxIUPKMr
 6DHJd8oTHEtNFTeKeoKpPeHsNrhH1poMoKK/vBXD3tTWuSjtzdTS1AMG0DpBdXPuLr6mNjpV2Vd
 x1Pz2ewLkuujm0YOR1PLrw91e69Qq0g/ZA94PXDdEsXM5t9tz5UefcEaqjj2ecMiOiPGd8A98ZU
 VmFhoxAY1nhVnNIM0pfd96tEve4tlUunTo9zGt+TduM+EVx/svKVyL18XlISv+SJ/d7gLUAM3+/
 GhIOsYVc2ZZtakJLJHrO0mQZyiVq1r0BqQYMncZSw467uv9cAR+RVxDDII//l2Ot+sCLX4hT1cy
 c9ci1ErLw3AE2wljDAMuCZxE2neL9A==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68fa1c33 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=-jZqwlwB3PUYXKLUuVcA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: te80iDddX_MTJW7f-Q_wP16XxZdYKFdQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

On Thu, Oct 23, 2025 at 04:06:04PM +0800, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states
> VDDI=1.65V~1.95V, so set sufficient voltage for panel nt37801.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt37801.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> index d6a37d7e0cc6..7eda16e0c1f9 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> @@ -267,6 +267,11 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = regulator_set_voltage(ctx->supplies[0].consumer,
> +				    1650000, 1950000);

This should be done in the DT. Limit the voltage per the user.

> +	if (ret < 0)
> +		return ret;
> +
>  	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(ctx->reset_gpio))
>  		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

