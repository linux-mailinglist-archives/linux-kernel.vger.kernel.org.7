Return-Path: <linux-kernel+bounces-844693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C3DBC2850
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D53434EBD3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3772DCF43;
	Tue,  7 Oct 2025 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H0gRCcGp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F0119067C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865832; cv=none; b=aBStPySb0+TQ6qJ1uAlAUA0mWEu1B7R8JVojBRsf969wg4+uvySC7n+cH/vleJnz8Intf2GcYHff7hmT3TzqhvdAzL1uvmLKVLdz8G3jZfuAqQi06g7brm3rqOVW4oT4j2js/+k30A7DZk/Vu7TP9g/vvxu1c9i4RjH9fF4H7Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865832; c=relaxed/simple;
	bh=LOfOUUfqWX+NsLrNLCw9PaTqSdVkAkPiZMHNwHycgA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PezbnE2vF0U27GsRHma+JD4wLJFxeG/h3rPjqxGwz9/rY8yZYtix5afdWlMt1zqhRrv/bW/zZ3MVhcYm4VNwvLsgxwAPkbti/GfykJvJYV3L+aHjGcqGwuMMdxtb3mrE2w7+kDuJvEdmU74l1fnW9hB7znEU6NuZjEDHeBK3tUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H0gRCcGp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597ETN0W022566
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 19:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hsVAyePWJTAhjxa705BPnLB7
	NWPeaogs03EwGPJoGcw=; b=H0gRCcGp+QypnY1ISzAvYqH8tPhRTnByblTtxnIa
	KNlRZSzilLGoxd2vH4T7U89wOSSYQnzZkouD09w++gcJrcmQw0wRoZ299n8gK14c
	RhV8CA8GzzlX/7Rv5oJkYF1YoF/u7fGGBJ+eArD0It68tRXatuCuJSRCTHhKuJuK
	lJGXu0IesYUWcJSONDeZVmruGxm2xxoisghyeNbj1pWKx3GLhXKvVM+iuJ2nMo87
	M+QmzebVJ/2FnSSwsFFIMZM4TmE383HwrRNgJPJjJiVkaY2G6Hdu9LLu18ArqLLu
	q6Ey6KgiyOeZmbwh/kicYJVPPUvC7Gzix2jINCS6nGVRLg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu8cjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 19:37:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d7f90350f3so6407201cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759865828; x=1760470628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsVAyePWJTAhjxa705BPnLB7NWPeaogs03EwGPJoGcw=;
        b=If9a1ENpX+EnJqUpHmi4T9tHPXcNg9hC+k76N8JWffCeCIDF5M1ScdShbOQwgCYdxq
         sjgNMM+iUIK/27dVKIcdGwgnY6R6bea7+pDYYYYOLG3vm0GtThqJkiAho/VY0uWKavwe
         hb+SntNXQsQwbjZM7jlaY88HKbjIY7HgzCb5EfSFFsojSmo2EubQsYV8K2x4chjepUFG
         3otVXj5ZJYt3OpHbAU9KfrBFMBNBdp2dwiQsE3c4vM3gcHGDjgjcOm4kEl1uHEB0v4+8
         yyp0LuIPrLN150zeOcPiXmHpyaG4qeSozkbphB0bvW0XkNZViu4+GccbLB/0VRdf6cg/
         gV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUg4eKEE3FSHG2B0QUqtdPqoEYBBm5yG65tiaq4ivOEOcUPmXH8OYgqGf1fp5UahZfu7VRSPFrsX0yQ5b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uR99aFvwAtf0rYPGVlhqkKquLSKC/gWymZGIjMh4pmRRE6Zh
	MUXPFB4R/ePTX2UjDs8TejLnDXNLt+ITLjyMpEhJE+CJouxyzdlI8WgVR5Cnpbbknnmxoa6yRlO
	Kn5iPLzlEI1b7SxVduc0rktAaxdBPjNYstFEt0qY6AtLw4M3l30X2xH9mFoLFa2bqRc8=
X-Gm-Gg: ASbGncuWQRSlPWeWvf638tE4oOh+ZHoTpgAMsgMKeQpS6UJSxigt6WeT+ACAcmfIcXu
	ygpMTwgzXO1lYHTzpZBsuBVJaOHCgaqznAkYV1MMQ5eEvotGYGxZhy3QDAAtWDOJ0IrZwwwRGmD
	NGAxK9ZV/cIPWSyNkvMzpZWnCuy+O7QTZUo4nEBt27eo3YFBw986KqheG+DCoHF67ySjARNFQL1
	174vNGEguuJ4pnnpjg3e9Rz9/sGV+cb9XeCaN5AWXVBjudLo4a0/3ypYcerNwCUYJg5YSTmxtoM
	jbt56Q1aYeZMySux4hW+a7zCpmHVyN2hw72iwJh0RqMwVRuqQbQnZaM3Ux/xzbdAC+u3QTFn5Yw
	BiHt4c153YcN2eNkSI6L9aLSai0J3tZEemipfF/uCmZ3bxgnxAJvZstm8sg==
X-Received: by 2002:a05:622a:1905:b0:4b7:acab:852b with SMTP id d75a77b69052e-4e6de86ab32mr65028421cf.26.1759865828401;
        Tue, 07 Oct 2025 12:37:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDx2ONp4L/v483WQnvQA7zF/axGkACaYdM3X2iRGt+9KfFhjQqRxTsRhKQg/568r2vy/0pow==
X-Received: by 2002:a05:622a:1905:b0:4b7:acab:852b with SMTP id d75a77b69052e-4e6de86ab32mr65028061cf.26.1759865827789;
        Tue, 07 Oct 2025 12:37:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3b63f0esm12435451fa.34.2025.10.07.12.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:37:06 -0700 (PDT)
Date: Tue, 7 Oct 2025 22:37:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: set ufs as dma coherent
Message-ID: <qxn3dkgqwusj3kf6unk2pnkcuay646unoxwqp4yyw2fv6afca4@kamtq2ahwlwb>
References: <20251007-topic-sm8650-upstream-ufs-dma-coherent-v1-1-f3cfeaee04ce@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-topic-sm8650-upstream-ufs-dma-coherent-v1-1-f3cfeaee04ce@linaro.org>
X-Proofpoint-ORIG-GUID: BcOIljdbgCx5ud-NNDt1mElEq2m_Kyf-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX4yRlEfhYw3e8
 a0w9loXULfzvBU9KNeY1VrEd+Kui3ZZW++J/kNCJOIHyf5e1ZDrJ1WTbHTKClT7N37kHXugAmEO
 jQbiQAbopP94SVbBn65puu7GbNYLdBEu3IeSUhIQcW0SISCOhSh9L93foVztchMiadCZxUuQ+4N
 FDghgR8UupE7z6GYU+6UoiPXAGVTGBQoBjMMRy1eafOc+q+JELCECY9GzNFNPuF4cuTVJHCEEaV
 LcScGdKJnp+p6rXJKY6YnBwvHBaROpWqornp9eSUf0eBayi+cbuYC5DtQG9R3MWWLsVkAcsPN0h
 /JcpOJs3ZHlfK691G7XTejfJoVtg3UC/KwKHyotmYhAp+1zemqTJPUAJeB1vnfYLiGKYuiicYaV
 eaMe9OB6lqxOOYTG6AlglaNRn0+PtA==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e56be5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ioNB40zKG52I8NeMSy0A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BcOIljdbgCx5ud-NNDt1mElEq2m_Kyf-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On Tue, Oct 07, 2025 at 08:53:44PM +0200, Neil Armstrong wrote:
> The UFS device is ovbiously dma coherent like the other IOMMU devices
> like usb, mmc, ... let's fix this by adding the flag.
> 
> To be sure an extensive test has been performed to be sure it's
> safe, as downstream uses this flag for UFS as well.
> 
> As an experiment, I checked how the dma-coherent could impact
> the UFS bandwidth, and it happens the max bandwidth on cached
> write is slighly highter (up to 10%) while using less cpu time
> since cache sync/flush is skipped.
> 
> Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

