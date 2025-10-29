Return-Path: <linux-kernel+bounces-875798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D42ABC19CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58A67357BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ECF328622;
	Wed, 29 Oct 2025 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FyDoxIoZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jB5Omj4k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEF8253F39
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734211; cv=none; b=G1Qq5c653XnhPybSWhXl0hwDttyogortNwUA1n6/Te7fgJP1t0W2pBCDumcOy5vRDBQH0ZM6POrsngBdF+EUvSYbNhdrBhM52UNN31ZVGvc2Crkld/1dDyq6xZPHDC/0iE5yK2mCPwsXpAi296dMY52/PueRgVHCt/QRXiTAhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734211; c=relaxed/simple;
	bh=1q/1phPagPUCQxAzcCDU7tAH37qhNCsUMCP0nmK5qpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p806psSDMLBDMWd2AWR4cpJ/mumSTH2//B0w8e37PCYmXRWrmcZIKAbIIpxBaPFK0Xka4aYebhy5TR3v6CzluzrtvVsS33xBpk9E9RxeXl29QlgtR35Th6DXpnk6W2M2X5+cKMcInX04EaKKaks8HfqPG98fyNfvOQNithg+Cw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FyDoxIoZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jB5Omj4k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v0x23664616
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	toxdlYRW6wbbji6ZyP5mSx2SHaUDU1C2FPUNRmJL/Mg=; b=FyDoxIoZYiP8iBzh
	113JaYIAIvwzPXjywvyKwUE54nnpEOkhvKI7SysO6iLU4FI/90v+DKXvmsluHx6h
	x/MBn0IorHQkUqzh6iPwPpND02sxN3DpXAqfICtXr54MzA7hp8niyeTZFKZuUf8O
	Al2UWsuT8dO4h8pj/Kt69aopTavp2B3XU4qlOvZkSQpSujN3nKlhUoTMsW1Etom3
	F1Rp9LfUqz+aasSxYTslwP/ay9qhvF2M/6CjpDsOjjkamNT9Ra142pvMD0Rd0xaG
	xRa3t44JraPWBeCfNVLOWkw8CEgjcEbLmtKp9Ovb8TNIvVf3sElCRhu6wOfviKUf
	OPymUQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a3t6wt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:36:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8a1c15daa69so1118488485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761734207; x=1762339007; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=toxdlYRW6wbbji6ZyP5mSx2SHaUDU1C2FPUNRmJL/Mg=;
        b=jB5Omj4kROpuL4KhAkaxjFlYbhlBnMlliNI4oZvaJwDvdqojWoa+RhWlRlBR5+hE4l
         C4jWW+XGbZf4Fp0fBSUx66NwHzMSPsYuApheDNmH8gLmSvYlYlkbl6DDk7wZPgt0oodC
         mCbha9Ggb1SsCi4V9OriCd5Bf8gkI4zPHLvpyF+s/QggyWnGe67YvZtd9J+Fnb1yhFYr
         elUX1odrbJpGKUvu52kLMbe3ZWxc/PUChBEzoHaFCDF2qv0CeQOXEx/ybOYNRAyV3wSl
         l9ByrAX1iuO/eOSoxAJzRAtxi28fqJXp0rYE/ip3rYkSkhkYsZCNahbfLwrDreVWpUuC
         /7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761734207; x=1762339007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toxdlYRW6wbbji6ZyP5mSx2SHaUDU1C2FPUNRmJL/Mg=;
        b=tauYhJZ1c/ZcZcmnBmsGABRmkc8dLYSOzHM3mdVs6lLBAtrs8iZ9Xo97WlSnj5m8Ut
         4+d01q/DtRLsTiAhG231rgnl4NTvbf3b6EvKL6RS30gowFbIeGbw8DtX3qTMNQpOUQ86
         8tcr17BnAwN9vsvtcKvNuuussihB03z9bUdrvxjLufUy6CtR1IG2z48qzYMbQJbqoMzc
         loMI8nrN9TPGm/Mmq2UwmZ+bHE9A2wAiccd+kBkOFhwSPZMRR35Piit8nbIasKjD2SHH
         2rLZoa1PA3JqKLbISxnFcwizWqxayxpRlgFtx7td1slVwAd5l+ImGPMsHEPmjK1lLlwx
         Iktg==
X-Forwarded-Encrypted: i=1; AJvYcCV7TtktrZUFzlWQaO4f7iJ4h53EkQGR6fnnuGmVVZZnsiTiAgMRd28tvUrYSesC0rdOgU4xPFu3l3ACaDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4QDRE9WIG9UdS0kmndQIJZXSq9H3gDoAWMj91BogTMJ+TALDe
	dE7qNGCB5JVyOACEXREVOeNUK01dhfL5MdDHvf41eoUJF3XF5X9E8M/ubqqpOioR4kAPI6xG2Pe
	rqoTtQEoahSK4kfrwbu2D6/wGxmqv5vMOh9p+JVMEOdPheYaK74rCGnfEhDdC9DaMX0Q=
X-Gm-Gg: ASbGnctmb8VfNmKnY01q4SbPOI/YXhCGmp/6rUQY4FN3+JMmpokrsrn3bfM5eJW7OIr
	TnqCOzFgmT+R7Sfx40FjH8GUBZgu3n/4HCRxM5h7IhLuJ5LFhZFfsfZkQouTQT4eYTNTVrnR9NG
	KeF9nxIu19pbw/WQHVRsRG/pFEz5p2pN9EBIgwp7+K3ZiFEwVQ++5y5DUtcAKtikEXssTM0c6W3
	b582V0npPSqfdTZ7xWybDrHJfF4pg891Ih4yTBQSEbHENgO/3yTX2Hg+F+KiWkIrbAQ1IlzANTe
	nSaGlYakoCFGRww155R7vHJTzq9et7bfAQio3bl1zgShECEZTDIVYrAq1GuDz2D5OE5byh4MV4f
	d4y+KPqYNuDx3s6BQoCa7zDjjiu+HIXVePdB7W4o6FBbFP5bQiQcsMNi/uud409hE06aldJXBnQ
	MVXcQZABL1ZBXQ
X-Received: by 2002:a05:620a:17a4:b0:863:696d:e37a with SMTP id af79cd13be357-8a8e4e006e4mr321291385a.44.1761734206720;
        Wed, 29 Oct 2025 03:36:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDn6C0Q5aW30mE0+ypBSnHz9+A4C1AANd7lKkjPrOnIt7fuqfOc3mHR+srflmr9P7wSnz0aA==
X-Received: by 2002:a05:620a:17a4:b0:863:696d:e37a with SMTP id af79cd13be357-8a8e4e006e4mr321288785a.44.1761734206193;
        Wed, 29 Oct 2025 03:36:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f60dfasm3791480e87.61.2025.10.29.03.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:36:45 -0700 (PDT)
Date: Wed, 29 Oct 2025 12:36:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/24] arm64: dts: qcom: Introduce Glymur base dtsi and
 CRD dts
Message-ID: <gg7srymb2dspk4jeycc5su5gjl434ymgzapqqyqw7yq2marzue@ql27qx2ptuo6>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-3-24b601bbecc0@oss.qualcomm.com>
 <2960a6fc-106b-4280-b4d4-9c1a3a449454@oss.qualcomm.com>
 <0a47016c-1d7e-4026-92bb-a13ac2ce169b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a47016c-1d7e-4026-92bb-a13ac2ce169b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: cE9S2w2zaUU2Nr-g8wsAvgQYSHloedfh
X-Authority-Analysis: v=2.4 cv=HM3O14tv c=1 sm=1 tr=0 ts=6901ee3f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=TvNQ-Dz4i63DqaZ9HxoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3OSBTYWx0ZWRfXyATxA3p2cQQy
 thhM4Uiouk8U1n6ljYgdM8QGR0n3f6D5Pl+O166P0BFR6G/QoBBSDtqArryvF5ks+DIQ1ekVQjj
 JvfUFE2hqxl8zw21YWks7zqmB2EbtvcgUaR3+PBMLvl2PEfGp+tlhimemCsXmyZBqlMjutycoSI
 5us07hVCUfyTzeg/l25/fYcv8v7dUfGAWX6eFg0qDMLRxMtJta8gpUozGBbiVo5ZfK5QxFSGNC3
 2X++96UFuNfb7WSe3NVaNtd8gMi7UbkNsIJEjkbcJzeb/k8ab9CMPGCKJS0xk5B3Lii5mS5bOZ4
 X9Rllxaee9xXDKFBJzkKOjfvrWw3llseSmd+sXSCWx+Iv7nLThZrmnIiosPrqadAhXBgXlT1QbR
 jyIMYK2i8t6BS6TVol0iZNjGg3BG7A==
X-Proofpoint-GUID: cE9S2w2zaUU2Nr-g8wsAvgQYSHloedfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290079

On Wed, Oct 29, 2025 at 03:30:54PM +0530, Taniya Das wrote:
> 
> 
> On 9/25/2025 3:46 PM, Konrad Dybcio wrote:
> >> +		tcsrcc: clock-controller@1fd5044 {
> >> +			compatible = "qcom,glymur-tcsr";
> >> +			reg = <0x0 0x1fd5044 0x0 0x48>;
> > We can map 0x1fd5000 - 0x1fd5094 inclusive, as that seems like a
> > logical subblock (this would require adjusting the driver)
> > 
> 
> Konrad, we encountered issues when trying to map regions beyond just the
> clock reference registers. Normally, we map the entire address range of
> a clock controller (CC) module in the device tree. However, for TCSRCC
> where CLKREF_EN registers are located within shared modules like TCSR or
> TLMM—we don't own the whole address space, and mapping the full range
> can overlap with other devices.
> To avoid this, we propose defining the base address as the first
> register actually used, and the size to only include up to the last
> register we use. This ensures we only map the relevant subblock,
> preventing conflicts with other device nodes.

Then you need to behave slightly differently: map the full range at the
basic device (TLMM, TCSR, etc.) and then create TCSRCC as a child device
to that node (and use paren't regmap to access the registers).

> 
> So want to keep the mapping same from the start of clockref clocks.
> 
> > There's also a laaaarge pool of various TCSR_ registers between
> > the previous node and this one.. but we can leave that in case we
> > need to describe it in a specific way some day
> >> +			#clock-cells = <1>;
> >> +			#reset-cells = <1>;
> >> +		};
> >> +
> 
> -- 
> Thanks,
> Taniya Das
> 

-- 
With best wishes
Dmitry

