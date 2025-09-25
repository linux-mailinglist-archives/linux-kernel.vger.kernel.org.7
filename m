Return-Path: <linux-kernel+bounces-831602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1582B9D19C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D583ACE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8852DF3D9;
	Thu, 25 Sep 2025 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gfUnTKVx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96C2E0921
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766223; cv=none; b=ljGuSvLFVbVM9bvB/KCWMaY5Stg1uihNn2p7/QH5RU+yQWs1b1l4nH9HThLhMf57phuBRowYAlZauAwzCTQ3lksdyPrAXBBa0XFBBXIL8lCtt1pt7uJ1a/YxRMy0O5p/ErQJ5+XRwCXOjKK0b7DJVtO/3GPR7rsYDaceDZMnNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766223; c=relaxed/simple;
	bh=bjee08JRPy0I62XUoi+pR4Sr5AISrB+/yfRGenhZsNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frRGszX8351epNaUn7Jv2ThcYjHS1XdHeE3QbkN5Un0rVRLKGHq4i2TBOgg3tmvi3SGIyyXIzqoeyyifGOs3axvL/L4QC3atTwGmbriydKBzLUjS5vEHWGoia/exCuod7ddC4QYDNhqFjq/3IWBQr3JyMr4hyMk+WhgP5nt9nsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gfUnTKVx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONqWoE023856
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C/7uHCKAmdWyZHNd0/dLgQZx
	NGpO7Z+I9wSgi4aQWpw=; b=gfUnTKVxKRrXAnjEvnmU379FIOSq0pBrvmZrUcpr
	i2ca7c6etOZPd92L7yYWVfmZb//GRUIONVaEeH4/kC+q3KbTI1Sal/hx2niUO7VR
	Okf3/wm3C0AD/RBZIg7zh4B/V3BTGYAwNu6Df7mv0b6ryFB/tdUPwGJzYWvuRjHV
	qyiiwqEiQ9xs84pobZjXX8ncipxxmxlNoXHV7B7bsX+BtK5IV/jFH+VE60uOzq/M
	WwO4PmPu7sXXTem20yz31z8Le07FlzGLVHy3ttdPJqQv60hW1lDR26WVSzVcHGsC
	y11+WmSP/ZZHd5QVCQZfMjlmAyR2U1Mwi4mazGxWEdwoYQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0ddrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:10:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b78fb75a97so4927111cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758766219; x=1759371019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/7uHCKAmdWyZHNd0/dLgQZxNGpO7Z+I9wSgi4aQWpw=;
        b=BZ7zT7cm1QB0bGWE/Erx/FfXBlHhcEH94a1e7StmCEDD3Ag1zoshXEm0NzImbKKd/X
         9lMTbH6uA+ZwizMD51sG16kZPAf6f7ag0SrVMDZWFxr9Vq+aF70fXH0IC2WRO3ja9v6T
         xe4SVd6boQSwNjAREMW9J0fu40N9opnL1eVVU0PzjxzImd9IKo6Itg2P4L6fKhr+plOr
         sVPe75eiEFoMVIpXg3twNdQLNSM2JAA0pXbkR9HtKOkOot3dPv+Zslp74MC/iQgAWHlC
         0vIH3q26YFeDAxMtDL2lnK/TA6fqIMHHot6XZOqIJWkpEDebBKTxdKPSVwXEklcVQDmr
         MUdw==
X-Forwarded-Encrypted: i=1; AJvYcCXO6ZrPXXzSfhmUD4jkwO+LY6G42ABsoP9VC+8Hcbt1tZTnxookBNz25vbPEszNMmdtdaRNJ5vAptf3Djs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4oxuBt9StWqk40INfp28WlZu2I9qGaZOltuCAfbXM17vE+Eh
	GjtlwMnX5knhTDRF9dwmz9oSlpApx75jSt/sWdaJ+cdgUm+9as9col8WnoVcfmyit1mVVj+Oc+g
	i/mJjgIWlB0E1XeuEtJyEjm6hIDvrmlFBzfw4ixUXw9yMB/TM+AqJr7ecGbkgYDGZLq4=
X-Gm-Gg: ASbGncsY43vxhhEi/0Rsm8zrInd6GltIwzEZlpsbb/hqYAD8tRJED5/VB6LNm2GVSxv
	G6Upaua3zhQCAXJ3D2QwNBd740ekC4IbfKToLg2d8gwLH7wL1w505AqvwORWDqxyy5eGoDubK4P
	IZ7zW623YW2WxEzPnp/aPSGljjs2pax/9I8mVs5trYRk5nUEztkbLTQYPz6GeZLxlBUElb70OtH
	Vtl5A22ntiqVhLyUu4y1GCWrXTTBU0PCYnq/6HtiUzjSTjT/AiF0lTaF8r1DS26FvQQmExg5h0o
	bWvVCEMFNqDZuq8HLHbXB9tRT4kkYCOSU4Nrr1o2Ej0a8+oNYMhj9sxgyBV5rsUsV4/bZYMXrBd
	ibGAPWPZPn1Dw1fa65JB+zo7ty/uCunmxY+08JHwCggPQIL87hkJ4
X-Received: by 2002:a05:622a:8cf:b0:4d6:173a:8729 with SMTP id d75a77b69052e-4da47354eb9mr29433941cf.10.1758766219508;
        Wed, 24 Sep 2025 19:10:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvUUmMZkLOjmwfUxC0iVnkbYdMU7OcIFMO4AR+CisgKDy2LIfUOS6Qp9qM3Rb+mOQMi+xa4g==
X-Received: by 2002:a05:622a:8cf:b0:4d6:173a:8729 with SMTP id d75a77b69052e-4da47354eb9mr29433481cf.10.1758766218832;
        Wed, 24 Sep 2025 19:10:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313dd67c4sm239442e87.55.2025.09.24.19.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:10:16 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:10:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 15/20] arm64: dts: qcom: kaanapali-mtp: Enable modem
Message-ID: <iexa64nrdqmwitvunl3inmgtmhufphl3p4p2kbvhgcsb2y6l7j@5tpt23yd6jzh>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-15-3fdbc4b9e1b1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-dts-v1-15-3fdbc4b9e1b1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d4a48c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=noE4yVIB50t1Y-xfs_8A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: huK2naeXYEzROgMGmR8ZnP0ZJ8HYYqUK
X-Proofpoint-ORIG-GUID: huK2naeXYEzROgMGmR8ZnP0ZJ8HYYqUK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfXxfbpeG2SLapE
 PkH0XzBTJ9HsolBynreLFRofG4wKvZrZftlQit8EBUJt08B5ywlkg9vHwIJ1J1kECbh7EYIvG2t
 rOLvp109UHV4EBulwrqsM0EItENCZr26fiSt6Slb/3kgL9v7kJqf+a+0UM77PJQZZr8fmwBCcbH
 DnkiNb5mbXBY9Z3GRRMX9Ba9L77XizFXWHqknlzWndCj1A7WwoBq+B4NR0iE1Jt8DGyFKR4FDRn
 G6mWBjS6NhC0Vt2Uf+YZYJCUGmY3hwO6s1mIsGk4NncBSaixEZe2+kM+fzk6+I7jOFXfY+Pd+qr
 oCIthjjyi+yBZVEUmJUDvMaxNqhV9pUnsDL+mVEz7HTxPSvHV3BUZRQphpNS4WZXJRvq+yOI2fI
 ECOxn/cG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On Wed, Sep 24, 2025 at 05:17:32PM -0700, Jingyi Wang wrote:
> Enable the MODEM on Kaanapali MTP board.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
> index 2949579481a9..8d1b3278389e 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
> @@ -1263,6 +1263,14 @@ &remoteproc_cdsp {
>  	status = "okay";
>  };
>  
> +&remoteproc_mpss {
> +	firmware-name = "qcom/kaanapali/modem.mbn",
> +			"qcom/kaanapali/modem_dtb.mbn";
> +
> +	/* Modem crashes after some time for OEMPD load failure */
> +	status = "fail";

I can't call this 'enable'. Why is it crashing?

> +};
> +
>  &remoteproc_soccp {
>  	firmware-name = "qcom/kaanapali/soccp.mbn",
>  			"qcom/kaanapali/soccp_dtb.mbn";
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

