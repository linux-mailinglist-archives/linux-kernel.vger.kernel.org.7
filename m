Return-Path: <linux-kernel+bounces-894089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854B6C49419
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F133B231A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318E62F1FF5;
	Mon, 10 Nov 2025 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xri2h24q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CiGlFDqc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12962DE6EF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806707; cv=none; b=qInyp0amGcubL5WvkMaS0jHy/fUNRrEswaMg0GKOfSTPgfBws0dxyvQaMjpspjn/P9cbo8mRRGULpJYCSyKZ/1X00kjryq3MCjV7m1uXNPRnkf2llNCfJrmSVdXap1Gw6ES3jyRFgNB/sOe+Isfk7aGfGzg1hfPBo889CBl32Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806707; c=relaxed/simple;
	bh=YE6PuNDtpQDapq03SWpJdSQuLlfFhMnJC90bI0n3BiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLHSlPEn4eJG4IFYs9ZGjtj9DxV5OKAMgFI1asL+4Hs/JMSfZMw08Nx2JjuUHTqfYYXoMZE2yzeQ9Ui8gBfYF/trlOU6YBEPaas2Jxu7jwKcv9uOWRMTky/YvtSTgOiVRmCJjh5UjQjvZgfPXq6sOF6n4KRKQwlOfV79wOYOLqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xri2h24q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CiGlFDqc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFhRHg3984882
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bIdT5At54DZoymEfDUiwR7h4
	Ocq8orpRWmJMZbcs1fE=; b=Xri2h24q+2MyT9XbcNYp5uUoakuMlmxSRkINmbfl
	wP1Rah4R74hwrw2N5lXsA+ZYK03HZOYndVsaq996VRMCUsO7ftiT5dsdrVz5RVHq
	vmdFljS0ZbsUN7ZZDLoV2vhQ/Iw6BTXJMziUjn8ylic9tQcVwlPSAk+6mEjIzOme
	BuhvgXW8xBpp6iKkNi0YaQXMmQ3yaRrpMpaZ6drxKF0GuQWTb4QFvIv+8VWTp6JB
	ZsGKdQMAu/PFInWyQbWZFvJJFIP0bT0B6hXtH7oZWEtB/FwSWvCvYzj/7VYLi+TW
	CGe+MayQiKVNueU/Mqs1YBqk9Xkm4F1bEBalqhVufohLww==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abjxqgv9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:31:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed846ac283so4687781cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762806699; x=1763411499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bIdT5At54DZoymEfDUiwR7h4Ocq8orpRWmJMZbcs1fE=;
        b=CiGlFDqcpyzvywIflRzieMSfSAYI5rq3xJp8Bg+QXLCvrDtFEQF+fWNVFjnFrHWR7v
         lzsW7EBfwD0pkcnVqNHoMdKpdTznshYf3MuKZEvXJ/bo7yMs518slyU7MoOMUV6nG4HT
         iBy/E/AmfBMEazZGV4a7uXoro5cILHale+KBWuVt09VNroGQtJMH0ogpMUFqfKkAeA0f
         O5gzlNDz9si4TNaXuaFP4AZ3YoymNHE5O30LR9Be/1x5FIbui6qfWupTuHII4tPRjs1R
         91x4WzZNX8SAvOw1NdeUfUxJIM++3hSVBPS2x7vXY4GCQMMBPfo9lLRp13WGu8YzozVV
         7p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806699; x=1763411499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIdT5At54DZoymEfDUiwR7h4Ocq8orpRWmJMZbcs1fE=;
        b=mkzXyQkQMf6G4QWUhjZqqkOc0+M+J9vTOmVxbavR/125eX6MKmxv4SfS4sS+WqXBbl
         TjZ1WfO1JHIKpwwNR9gBO30BKyoIsMggHYu9chfu0nfuPmQioSKNmHf+PJSDNFEZYZ60
         7gLDwT2YYzRuOKYoPWXckxU/lUbaMkosanwFL31V0Hkq7agZjn8+ERe9bywlTEdEdvz/
         r7LPPV/RgVm6PHSNJSloLcLAVLk6Oz+NrEjJuqzourfv3V3ZeHUAcQDa1aWwr9baQymb
         yLt6S3zjxGwJOMyLcAi9W90CSzfLdMP8ZNNNSVMUPlZVZfDYZi/Vh/KBKOJdouBn7FYW
         dNjg==
X-Forwarded-Encrypted: i=1; AJvYcCWlKAAYBpiieB+pVbB8s4P7vj7nxPOJ5FH17F7u0TPs4dHm8SVdswpvEOPGe15p1qPkt1Xmj6AlyHJxUF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7hIbpTbnFoUCfSMmMr0T4T+ADRKl8GrEMCGHWe3glud1Kffz
	ZO28kJIpPRQsORNX40x29hG15CVDtE2rKNXGbTILywh6M7Q1NgFmVCD7Zl5LW46pM0uR0U4dPJs
	LbgAA13TeqESwU9pGKgkSY2cVQIHyW/5r8pB1f3GOl8+Uy0aJb24fVCC2aXqVLAejMLQ=
X-Gm-Gg: ASbGncsCEDIXv3Z5IUZ8/J6mLlxigadXx4KUJlFxtAnN06r1g2k1Wx2SHw3vD0WzeoY
	1cWrt2iW00TpYA6EIOnlXOSnI1jvLj8VUZI+h55QMNosTZqXTwP3grKTdy2n6BAE7gSWr3daHoZ
	JvXycFup15H886wTQV7UYL+3aSSWVo2veDXw1mY6Sa5rqudYr2ee5dcu+Lc/78N6OyQc7sv2ztW
	9a/c0sDAPvE/xm5XGS7L3XV+T0rK+vi0ZGWsgQKg/U2ZgPHbhyjyMhVp5m5l32mMCKkK1Ikximk
	otx6I4CIhrwSNrdIJQDPPtbx/Scgxf2x2ouUjD4J9IJHijvlul9J8SL639rJibdTjzexO6EDNuc
	HPiy2RO4p1UgkYmWWqn2i7EMlOgjEeDn4B0fBC3y0jsfqhadpuMwiCVxVqeJBUavq5ib/lFSZo2
	7WRRWwAslw4aKy
X-Received: by 2002:ac8:7f89:0:b0:4ed:5f73:f82c with SMTP id d75a77b69052e-4edcaaca4ecmr10918631cf.11.1762806698754;
        Mon, 10 Nov 2025 12:31:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIZbcmmVUaYDitCUIFZPjdhrCzCbtSzSkTsWaMEcYAfRyoi2LFGBk+O42E4nfXG+YHNcdP/Q==
X-Received: by 2002:ac8:7f89:0:b0:4ed:5f73:f82c with SMTP id d75a77b69052e-4edcaaca4ecmr10918211cf.11.1762806698332;
        Mon, 10 Nov 2025 12:31:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a59c4e6sm4254424e87.102.2025.11.10.12.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:31:37 -0800 (PST)
Date: Mon, 10 Nov 2025 22:31:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Dylan Van Assche <me@dylanvanassche.be>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845-oneplus: add ath10k
 calibration variant
Message-ID: <oufiptvhpgr47xekpex45wyp3ysoz27ko2jlygoeho5u7e7n5r@maz7m7wmwkm3>
References: <20251110-sdm845-calibration-variants-v1-0-2c536ada77c2@ixit.cz>
 <20251110-sdm845-calibration-variants-v1-1-2c536ada77c2@ixit.cz>
 <wqjil4hhrbsozvhwdf355dqpwu736z4x2nwnurug2bpx23ed3g@c4shkwfyohky>
 <5fbe9d10-5d6d-404c-8f47-e4a12ebe7eeb@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fbe9d10-5d6d-404c-8f47-e4a12ebe7eeb@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3NSBTYWx0ZWRfX2t31hgV5KIKc
 0Q4cGstO64YT7VbVe0TSirXIGpqoKS9BgZGsi1u4tAJPZkj1iHLjMDJMwZOrKnvvG3JzJHkKR0X
 tg/yJwF901hXHblVY1kaKDdmaYSnXxFGd5G+IWWt2ZuI7qd1TXV3T8ikR7+9igLR7tO2/2r5ONI
 I8ux9eQVprBa9BEsnI3unCd+x10lz6wAsYCuyiV98BTxEuKYGH3RbwWmusdTYY0xAg1PwW02RQe
 gVkeihDyKYWtVV5u+tDnVB1zl3NYwebPdNqW881Xg0ducgk+W7rBjieD9VHEnOUuY5FAsk4O2/Y
 S+ny+oE9XxA/MjOW8ReOu8He9szixoxGzN0iNm/dY2tCXwhrO8sGr1hsqS0kd2xLUQ+3u48ijlu
 MwtKPvLI5LamH/K2x/mIZNAtVK51NA==
X-Authority-Analysis: v=2.4 cv=CsKys34D c=1 sm=1 tr=0 ts=69124bab cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=uFkZ6A_fq3OJCtIxTy8A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: saQtvM8LugIOsP_jI3OGSVx4WhBLf4EC
X-Proofpoint-GUID: saQtvM8LugIOsP_jI3OGSVx4WhBLf4EC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100175

On Mon, Nov 10, 2025 at 05:04:35PM +0100, David Heidelberg wrote:
> On 10/11/2025 16:58, Dmitry Baryshkov wrote:
> > On Mon, Nov 10, 2025 at 04:37:46PM +0100, David Heidelberg via B4 Relay wrote:
> > > From: Dylan Van Assche <me@dylanvanassche.be>
> > > 
> > > SDM845-based Oneplus 6 and 6T have their own calibration files
> > > for the WCN3990 WiFi/Bluetooth radio with the ath10k driver.
> > > Add the calibration variant name to the DTS to reflect this to
> > > allow using the calibration files from linux-firmware.
> > > 
> > > [David] Adjust the compatible as ath10k-calibration-variant is deprecated
> > > Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> > > index db6dd04c51bb5..a0c2f6efec59d 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> > > @@ -929,5 +929,6 @@ &wifi {
> > >   	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
> > >   	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
> > > +	qcom,calibration-variant = "oneplus_sdm845";
> > 
> > oneplus_sdm845_6? or oneplus_6_6t? SDM845 is too broad.
> 
> I verified with https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/ath10k/WCN3990/hw1.0/board-2.bin
> 
> $ strings board-2.bin | rg oneplus
> bus=snoc,qmi-board-id=ff,qmi-chip-id=30214,variant=oneplus_sdm845mmm
> 
> $ ./ath10k-bdencoder -e ~/Downloads/board-2.bin
> ...
> bus=snoc,qmi-board-id=ff,qmi-chip-id=30214,variant=oneplus_sdm845.bin
> created size: 19152
> ...
> 
> Since OP6/6T should have same WiFi.

If it's in, then we dont have other choice.

> 
> David>
> > BTW: Were those board files sent to the ath10k ML for inclusion?
> > 
> > >   	qcom,snoc-host-cap-8bit-quirk;
> > >   };
> > > 
> > > -- 
> > > 2.51.0
> > > 
> > > 
> > 
> -- 
> David Heidelberg
> 

-- 
With best wishes
Dmitry

