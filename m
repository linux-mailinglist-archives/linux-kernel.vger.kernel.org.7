Return-Path: <linux-kernel+bounces-835235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3BABA68C1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916113BA92E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC732620D5;
	Sun, 28 Sep 2025 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RuNq7OuN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAC21DC9B5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759039893; cv=none; b=XhDbVr3s3B6q0HYH3OKO9K2jvZvFufH1fZ0VpFVGvhjiKrtruAZxAgNUterptc5358noC1lzjVe+tvCziPaTfyUudbxjIdrXWKXvPIcdI12O3d5U4VpBObhh8mHDmalL0IinOnT5fl6HfFUlEWo+nPblsZZkRlK0ptAonxZbw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759039893; c=relaxed/simple;
	bh=6EeLItj9RgH/iM48wpNqwHT1GBX744iD0+SHhEj2mxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCLy/0P0TlVjHRN5hyI2kr/geyQCZee3EG3FVRuF53DOl8tqzCpq6E8HIChulTFGh1IuxVFGCkpQfgySejkhHvXLHjumrw88h5Zi7CeG/MXv7KEJG84LyUtBW9JZD1bWniSBkJ2biUZ3mvdAaUrdOsRBnkh0BC3vTxsizwJj88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RuNq7OuN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S0tHYs005434
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0y4r26rmfntPrF0VgZDFQuaSwpW4geYVgGCdzUjQpo=; b=RuNq7OuN3kDmT8W1
	aqOiKKlUwPa9Rueq+DMOSHvJRjYzZLciVeYThwt9DZCqOZgXwzWq3HhJ9h6U7ANM
	97Di47feW6nTz/PMY+Gm0KhekbJWs2JHq9hTpCE36NUBx1F13XupgV7rHozpD0U4
	6F9lDS4DFdu5tyZhGsITRUoPSH0277fdj5Z71noatcKpZFFZ6eOis4ESVTx7quoT
	66swkt6mJOj3jLqJCouXi+jt7ZMf3nwRmrbte4sProqlfo0HhO8aXvTiN6CUp2lK
	YesKRObkCWJemiba4guNX5CLWvG5luAgpaakOx2LVDSrDz8AiU9TZ3sW0h3B++Yu
	RMItHw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e78fta3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:11:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de5fe839aeso49156901cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 23:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759039884; x=1759644684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0y4r26rmfntPrF0VgZDFQuaSwpW4geYVgGCdzUjQpo=;
        b=P4L+NB5oWR4JIK7fdJQ9yPm8u/aqHbSIEZoATwWbOK853EiXQbzQ25ZIT+38KHhTmS
         CX7dZJbt4mAS7oJypoX5H+qCeftxIJSjYlo7oxy9GoPG+vR7q7EC0RzG8/OOKey4G8+d
         mBahFoB5P88ALtyO2KKliqib3qQk8gUS6dA4eiN4oNhP98qB6YyL6KNCRtjMGtgtlT3f
         koAl+mFJe1x1bFUP2TPn99C8dqd3KLaijDBHl5g9gHprLQvx1RhU5IDJywQjYz5eibYH
         1HoDAeqZlxJEG2Cgof2OTAJdmFk4OShfmuR5g/nM6PHENAkmk3niiwy3Q2gcHA1jez2H
         N5dw==
X-Forwarded-Encrypted: i=1; AJvYcCW+1IjLhzqdat4D0OeW/7lAMjF1k8kfRsrcXgzFDhe/6oTG0SIIaUmk7yGXVJA15oEgtItJ8sW1NjKwbIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvbwDOW98+WqU/mYvG5Jfai2gALkJkTT1jdtFd02gkecHr2EJ
	slyd1VC//NGGInEsFikd3YHxLQgpJznAV8cyVc/xvpPKuUi5nll6GEm6oLb6CP/HLOCtZkdd8Mr
	vYoWZ+CZBjeA/DrwJcyPT270YJpR1S4HMTeclaC/yKyzZUdSQS780TBRxUZnpMuzpWmw=
X-Gm-Gg: ASbGnctkqGPhm1fcoQuNB/idPgTlPOgElIbffGlZIAoDlR8u58vVnYWzmrEsRp8eRhI
	VhpFHtHbloiQokoAlDHyWteMdcMBRavU8ZZbFShAZDHjlVoucf141+2zKx1+YAPV+Jie/C8dSkY
	RanOzoCDLMJSJMCwBy7sEUr98iyGl/lKYC0jEVLYXyWdvb9BAZCSTm/qtdbukwacTAx/Mdzpl1z
	RGEcKHzb2Txigzy/IdQItoGMTg67EO8o+5IP3FnwCtJJ6x+22TZ0SiX0cewjh+2r8eq/I2lpgiO
	6NIQStTv4/JwaCuoG4/yfkyrwZroChhoMvtNuyBTg9hzSif/zvZqTeq8PZ2equq628SxEM8y5Er
	ov2e7XilKoGZdDj45Rsz/uR2JFpdpRO2aV5IoXBEWGzwAvl24YkTQ
X-Received: by 2002:a05:622a:40cc:b0:4d2:c24f:848f with SMTP id d75a77b69052e-4da422ec59amr161136481cf.0.1759039883835;
        Sat, 27 Sep 2025 23:11:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCFI031F4POmzN8xNjPo0knLdtXvaIP0iciO46OR4x2yq72HuKbRGQbQjE9f3v1Uf95N7c7A==
X-Received: by 2002:a05:622a:40cc:b0:4d2:c24f:848f with SMTP id d75a77b69052e-4da422ec59amr161136231cf.0.1759039883378;
        Sat, 27 Sep 2025 23:11:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831343113fsm3210443e87.16.2025.09.27.23.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 23:11:20 -0700 (PDT)
Date: Sun, 28 Sep 2025 09:11:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric =?utf-8?Q?Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8250-samsung-common: correct
 reserved pins
Message-ID: <oi6hdvxqcble4qikfngpqc43glf6nwl24oh2ukdqwautbt4jui@geuzqecdqgsv>
References: <20250928044533.34798-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250928044533.34798-1-ghatto404@gmail.com>
X-Authority-Analysis: v=2.4 cv=DZAaa/tW c=1 sm=1 tr=0 ts=68d8d18c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=rMa14cLU_uRGXJEyJrMA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMiBTYWx0ZWRfX+lepykIADzT5
 sPV8OY0AsY9nNDxqEtOlboDuvINr9Eh2fx7g9kEVOoVpUqlD1HEXAwLL8vltY7F/sVPSqZVOK+T
 YaJ2eNm+gel9HuEo9f+Ki5A0Z/hubFko8yvxP0psjrwunl3WeZvSRHu9FGb9v2WLE748wiKAox1
 585YYIelKGTkd89tlzJTcdET6CYThRsgfkxcpVuyoeJiTBSTiQLBNbXd0ocw01aMbFS09Mu73Of
 AXMuMxkNZ1K0tVXJBKIlvChz8JTkU/kQGzoZC2cteyHmyhtEyNM/S1TX4Ld4GalVv/bupdoBN1G
 kNhkAvz98GSzAaWdSVkk6dPLoAs9D/fWG6k/nMOdMnEYA9JL/mC5uBhq7DKOmol2U741sKcYCkE
 qGU+ZnEJX8wU1uEuEG1KdOCcW96Bag==
X-Proofpoint-GUID: V5UCL1Xt50bmBEgLk3cno-_RghLKR0Io
X-Proofpoint-ORIG-GUID: V5UCL1Xt50bmBEgLk3cno-_RghLKR0Io
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270022

On Sun, Sep 28, 2025 at 04:45:33AM +0000, Eric Gonçalves wrote:
> The S20 series has additional reserved pins for the fingerprint sensor,
> GPIO 20-23. Correct it by adding them into gpio-reserved-ranges.
> 
> Fixes: 6657fe9e9f23 ("arm64: dts: qcom: add initial support for Samsung Galaxy S20 FE")
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
> Changes in v2:
> - Fixed the formatting of the <40 4> line
> - Added Fixes tag
> ---
>  arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> index 96662bf9e527..a87e3d23e3e2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> @@ -159,7 +159,8 @@ &pon_resin {
>  };
>  
>  &tlmm {
> -	gpio-reserved-ranges = <40 4>; /* I2C (Unused) */
> +	gpio-reserved-ranges = <20 4>, /* SPI (fingerprint scanner) */
> +					       <40 4>, /* Unused */

This is still not aligned to the opening angle bracket. Could you please
recheck your setup?

>  };
>  
>  &usb_1 {
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

