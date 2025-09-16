Return-Path: <linux-kernel+bounces-819107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E3B59B97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3F61BC3E95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E8A30C624;
	Tue, 16 Sep 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bhF5aPWJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834513629A0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034996; cv=none; b=DaZLY4lM8OLsTIAFGk176dYyXLJhRlIiTtJfopAI9vOJAdndHzmOOBjIT05gOHpnkL8Ro7lU5PZusLxn6VPXzMdluWRfcLjxZfXBQjk8iV8I2p15IHay1wQ9DUyDXAOwSxnbF8wDWA6/rfXhhNgmc0k7q0MiE4q2QrnCy5IZuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034996; c=relaxed/simple;
	bh=l6DkM0pOwEX3zjhBJfh9PR+c0J3tLQzthpKfI64urDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAf+p4RaZWMg7lvRMVBnluIOkUoQhBbh+bmi6haS04JUGZwv2IGg6JUMl6DqhVsCQ/DujrhdP8l5T91dyOltpoO54uhNPwmHLhioIUbEVHYr+8X1v77uf58dyzNd7vmBihNd7FiZCmQoO9ZSJwjlNyVo1zTfx4Cq1PlMLXz2DRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bhF5aPWJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GABqnQ001809
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=voj9VSoE133vX0xE3fpc2jnc
	LrpvdrOCJNA2G6rHUfc=; b=bhF5aPWJnN5LhVHC0wwplVJohISfjWlrvByhYpu+
	oAsBGDdPh2DWY6xRBJAv1LT79+4DgyQ5XLIZFtM0IwH35C3I7iy1cC0xCHeebqLr
	hZfOwneiX9tjmsRsmywnJ6qxlE2mwaezVdnttmEJ+zJ1OZjDMU5GtHGeDSeCnttu
	xIXkXIoYADM72pDmRoLdi8z6GI2fgfg0k9xtW5hYGVCcMHGMQ16q3Xmy/6T88efd
	Q0Uh4AJG82dbmcyOmRU+oKnhk6GtqLCvjGYNKyLEmUz+PHa6guZLN/laOAJq2IWw
	YPipHZ8CBOWMMuNb8p/hV9YuQweChk3oCYDT3vmJGBunZw==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqq08qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:03:12 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-621825089b4so5014182eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034991; x=1758639791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voj9VSoE133vX0xE3fpc2jncLrpvdrOCJNA2G6rHUfc=;
        b=B5Y4r8GkVGBMbEDBdawF/UWj11aQD1udiyd2XWKpdyjPWOYPg+OQ1MInfORmxQClqD
         2XKpVhdIlN8QIHucCmfg7PdL8Khclt33Odu8oh5kSQhtUanmDfn5l5+ayd9P/DDXp5q5
         74RTs2a4O4R6sA0/3TxUVX2ZM3BY/IELv2PI4Bnk9YyYGUsM8gNwR2ZM3idKwgVXFFUR
         1KgWgZR9Za7y1cWVYX7hiuzDeMHB1Yf/hqxC4LqnpNBS0VVYn8r3rR5KSPFW85UAcxC/
         pDNbvRq449JB72zpF8m6dInMaxDksftla5uKjFwokCn0t32in7PXlBkv2J5GdIGVCDK8
         agbg==
X-Forwarded-Encrypted: i=1; AJvYcCXYwK8wNmtTcQYs4CC9eqO2NnSzeeUiCeIA7VQJ96h7RmWbKrAKRZpXvXxHMkB4E0jORbaFgr1t7vxLEHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZ2lmGXAZUa1JRuZ11/idk8Yg8PFrUBpJWAHkoFGGHltlQiOt
	yjQgpzowCdCv6fUEJjYJ+sVBp5RQmLdIGJaiHQEMZSpTaTvzY0B3mwG6wX+WdgnptTpgrAfIJMS
	hwRdyajo+gbfxZ/16R5W8ZUMExIWVBf0K7az4VSx7kyAJ2yZe1atfd3XUhyBK5ZRFZAU=
X-Gm-Gg: ASbGncsRcaz0V7XAF25TajLBF2cibe8WBVjcWIXy4n5f7yErY6sHy9thjYWa+nzsF14
	5ZW2m8+6WnJ5+ibPENvs4Fng4MwvmvCCFT3G+bC6laG9RUyPkkJKekAbXTjJPcx2QJEiIMCWTNC
	uIe62bD68VYbyBBhtILwBE+scf/af0I/+zKQW8D4UhN4OUO5E/ekafvSgF8eplhrtqqxEmd/nRj
	l+B9h7HtJ0tYzBiFqtcXtk4W++YaEyS+kh/jZB0mLmFKEA2SxMf86yqX3UcJsBupZyEe2ybh8Wm
	8KNZDkjuLPAqkMh3O25QB8hh/MzsTAwBKGvW5TMfymXnypoagRtjzrSr7SMQ82jDPHC3vnelgUA
	KvESX4i1Mo4TnUQj2ia0LBDbhmJUnnjwqt/x7qI8nOy07WYxmGiuh
X-Received: by 2002:a05:6870:3913:b0:30b:abec:23ff with SMTP id 586e51a60fabf-32e5886b3bdmr7740096fac.33.1758034989086;
        Tue, 16 Sep 2025 08:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcisuFcv2atf9H79MHkvJiSg+gdxORbtbE3n2z00jFOxZfPYG5xjPkQb5n2gWIoRN61G0dtA==
X-Received: by 2002:a05:6870:3913:b0:30b:abec:23ff with SMTP id 586e51a60fabf-32e5886b3bdmr7740037fac.33.1758034988279;
        Tue, 16 Sep 2025 08:03:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm3410574e87.46.2025.09.16.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:03:06 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:03:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: lemans: Remove unnecessary cells from
 DSI nodes
Message-ID: <kday4tlzjmycgfexiaxgwnan3a3nfxt7sgslncsktcyw5bmr7d@nmjtdm3gd2sk>
References: <20250916141931.601957-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916141931.601957-1-eugen.hristev@linaro.org>
X-Proofpoint-GUID: K3ndP_Vtd9zSHlY0i5iC8XYntiEbmBx1
X-Proofpoint-ORIG-GUID: K3ndP_Vtd9zSHlY0i5iC8XYntiEbmBx1
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c97c30 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=67COZcyXgys7xXrTGRYA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10 a=WZGXeFmKUf7gPmL3hEjn:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX5FpIurVrkDRw
 a/SNUHvPk9xIdFCOCXv3AIVujaLAp7EvVqzrtqbP0UR61gYb2JWcObOaj+goyctpRAR+YSX9M8w
 Ia252mqkwYyesaVbMH2LIa0BfUEfkAzM2U7b1p5Zc2hnvBlBvTs+enIGvnHp4F8MBrbMMhtBbcx
 FZVPY/PoIK/GzEieqiUJIEgGDBruRJ9/mCt0XjDWsjXNDcTdAc4bkzQ8O111bQYMgFWbHJzRSlF
 jiTB3gHbWaxZWkcEEr5kwWFUDX6UdkVfZt+hA8eFukJZG7xKUN8+Bx4Ld2VPDrp3J9h07LGZr5m
 U4gAg98OUlIPaOlBCLPe1q5ljj9BhgJ2qnmEM3LDq4/NfuONpTjT9WACTA5+98SVr0NeCdY5bB/
 /6qWiqcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Tue, Sep 16, 2025 at 05:19:31PM +0300, Eugen Hristev wrote:
> Fix warnings
> Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae94000:
> unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property
> 
> Fixes: 73db32b01c9f ("arm64: dts: qcom: sa8775p: add Display Serial Interface device nodes")
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
> I haven't found a pending patch for this, so here it goes, sorry if someone
> already sent.

Thanks, but no. The nodes are correct. I don't think we should be having
the -cells boilerplate each time somebody adds a panel under the DSI
node.

> 
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
> 

-- 
With best wishes
Dmitry

