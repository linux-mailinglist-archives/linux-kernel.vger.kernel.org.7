Return-Path: <linux-kernel+bounces-688744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D75ADB686
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 18:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088CB16CAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A135E28689D;
	Mon, 16 Jun 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K8F29TXY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D92868BE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090856; cv=none; b=awmiLuQmNKwE8Mw9W/3czOwjtolTfY92ayTD8Jj40B1iPsKx/r15+C6Kd9qtVg/2Z8x6zbI80rh/CtkCBzpB0SIz8oVBHOTkiFH+UELvtIWQJ2TSjPxQmRpAjNOY5UfAravLlBFezp/dp82rptA+o49CuESZxyRdgQqGWxPEuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090856; c=relaxed/simple;
	bh=NDEkmxPGrGCG8ArtMUMwszjzAXpcPJOg3oxz2zuKJt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBy2H9zHm2ZXtA878ilbWk5O84G4wSMn90b6BgXRJkXg+npzdSkobCXtFvncOI1IfN0kir+fnNYubdLnY/WWO0aTaLveddXqXX6nuX0LAFhzHFY7Y3lteHiQBiNiuebC2hRgt5MbLpZsZh6PWFn9SY7NcH7DF4exk9KYa4o1YVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K8F29TXY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8TctE021517
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 16:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mu+psP+X+UUrmMw1teQblkErLFop9Y7rtZWa3PcMk9o=; b=K8F29TXYiy/ZZ9zu
	3y1vn87x7SCZcDXLwM/nsiTixg/PcGr2OEd5nTv0yjevUZi7DVAF1dy5jCE9ouLs
	EsMCWMFWPByBLg2sWIqB+rf75HvfJUSoOA4abKrSHn8udoNU8keMAWTEsIJOKsop
	plcW4jHkdyftDZurJb/gbRlr8xD7dihLS1SdFu9YfAkZ80AQfVjgp04jRk8OW815
	OLfrHShVyuhXoFSU4vCi7EZx17TYk8H9jVwH2wokhHpCBUpMkQD8MuNE7YMLeS/2
	t3CLt17W6WTOYmo9ue8SBFl4JstcizeWy1ycwyzIB87Pg7X9wCiUUxvi246Hw6BO
	35pX7Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791end6ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 16:20:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a5aeebad31so10517041cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 09:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090851; x=1750695651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu+psP+X+UUrmMw1teQblkErLFop9Y7rtZWa3PcMk9o=;
        b=VjMcScM2/icMVCReBRsKO6HaiTYeMIBfvSFkympTaCL7qL9ZeYTXrDgRMuEgE586fD
         G9H50KGZ9y75BRAoU+HkDljMcRgbmmeyYFQmU0nyEo5aTFfX0uDa2ZMRErAhpa4liiJt
         /v1g7gNXsX6IJJA8RGezEJdunS5g9DUfJngqklZHouP9eU0zI75DJNJSfsRICLkKlWVw
         pNtqgQ4Mdlrea5xsyZ/py3ljCdtplGRJBA+MJYkZhcSQiOcoam6kw2dCa3DGuC7F+l0H
         nmUYDk7BGb6RBNf5R+hlSE/NEnizM9HnysZkZlZA71qEObl/6XcN0/C8vrTnq3isJ3no
         AjGA==
X-Forwarded-Encrypted: i=1; AJvYcCWFpUpenr84oz9wysKC49gnnG2Aqi7aPM8UvC1VoCyd1xyKQNFTKzcUXbOS50YJ/hmTSdpP99gChiE87Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2J1v5BhYtLxHTFafIELPO4dqLhmsuyk7jmxrBlQoD67oTlX2
	A49UG+3keXs4LPQ+dSD+GaZIfJYd8cDxZb9vggCHAcrcGSn+fVclb7rXKIW/O4v+J9od/BA98Rh
	qKTq2knDhAW3yCVqBGxPILa0QHI0cKS/+ggEykCGyrvpD1TB/oeW8HNwvtd7qenNo6IQ=
X-Gm-Gg: ASbGncuT9TbhdXNrtSeOvrEewoheg6GFLdxJPq2MxxQeFDM44TFmtI4EKOpD/W3O0T7
	i6ud4Z40yx8UPYJhEuE9gf6/+Gie3r+vlXxorGwUqrJQGMu+6RAManXPVdt3UnKDlckK/c7WLWI
	mRoq9FKTJviv9RNjtJmLuF7DWKk8GjrNKpomnBYmeRgo2wR2MN6jN7+g3Ry+b5fRiQUZz3jXlfQ
	bJLaQUQdrPwc2CsI200EjvISJSOJ8LAF4TN25RpY3e5Whon5buv2QO1GxnTJ5FhXMQF6ex5QQ1x
	ceZDosar2BvjRtTUFsM17trm8IbuGs5y8hui8/Eumvh0ZqikizrE6w+u0QKmnJ8InfspO1rIKXM
	qUUQ=
X-Received: by 2002:a05:622a:451:b0:4a5:a4ad:c55b with SMTP id d75a77b69052e-4a758bbb5camr1770041cf.12.1750090851517;
        Mon, 16 Jun 2025 09:20:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN9jae6FOVYKQqSYeEw38hAiQvkYtCqfi+CbDM3+x5+zp/5SRgo/YqSvoVNOrVijkqA/tVJQ==
X-Received: by 2002:a05:622a:451:b0:4a5:a4ad:c55b with SMTP id d75a77b69052e-4a758bbb5camr1769861cf.12.1750090851050;
        Mon, 16 Jun 2025 09:20:51 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48f27e1sm6496194a12.29.2025.06.16.09.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 09:20:50 -0700 (PDT)
Message-ID: <713cd518-935f-4501-9753-d33c9ea6aef7@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 18:20:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: add debug UART pins to reserved GPIO
 ranges on RB2
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250616143341.51944-1-brgl@bgdev.pl>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250616143341.51944-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TGJy94OnmZTVZfIe0HW1MfyCOYV5xeEP
X-Authority-Analysis: v=2.4 cv=D6RHKuRj c=1 sm=1 tr=0 ts=68504464 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=Uobm0kU4YoDV-O0PfCkA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TGJy94OnmZTVZfIe0HW1MfyCOYV5xeEP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEwNyBTYWx0ZWRfX5U/KEwOZBegd
 T9E4e6+AmjTRawpidCSANCG0ZUPEWbiySteXI8tXGJa/mXnQTdRCmz+L4bvfJ3vS13+zJ6pYd4I
 +ONpYFt8gkURB+hRPfCZON8g9aICOXKaQ2jLPz3Aa0ltAjvyApJHJ03T4wRF6bChbsiOJ5yd5FR
 cwDdPvnPsjoAAX8TZiYFTg7a8g9AYARxNYjR1PDuB1MNWXkfvyhwjWfmx+7f30nF2jD1KPSuolX
 61dFXbJfYLmDC2ZZlYeDv9EXcCrUY5rgdERfdHrFQyGmpanU+ImpL9fO0iPN+3ve8wkDkPqMVnA
 Ut/VjD/nySkuH+I2N2BBcDfnncupz9FgNJWhOpYxHrw1/9VZ5Wdxr5URN1xrBBJSSf0OeVDTFsi
 c7qgdZkdReVpQy7NHg5ZD9bqyGhrEr41fD0sdTNMj1pZPD2tam9yQEB4PvAvqPx7+IiXsLGm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=835 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160107

On 6/16/25 4:33 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> GPIO12 and GPIO13 are used for the debug UART and must not be available
> to drivers or user-space. Add them to the gpio-reserved-ranges.
> 
> Fixes: 8d58a8c0d930c ("arm64: dts: qcom: Add base qrb4210-rb2 board dts")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

That also makes them unavailable to the kernel though, no?

Konrad

