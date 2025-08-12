Return-Path: <linux-kernel+bounces-764602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 174A4B224F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4DF1885665
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8812EBDDD;
	Tue, 12 Aug 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SaCptQg8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840B2E92CD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995889; cv=none; b=r3Na7jePvr+oLrylnkzdDtm7aePVh/GyNEmiew3mtoCCVwoq3bWiyVOjF/G0Nd3SeSgkqUoxNw6Mb+fb5okFGqobmH3nq8iqq+TmZwrkSqyIljY7PIklft3AAL0Vwir99W6XjzUiFNIClSdOYbgqdtxRHcTqaAoSlUVTsegXU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995889; c=relaxed/simple;
	bh=KgnjkLOYLkDSwC0GXwfOBN4C4F4nJHESxIsZ3ha4nMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDkttjxoorj94sUw31qBXZKjensssC0n0jN91LAwFPaT4JO8UzDmlItDD4tM4Fx+CDUyuWWIuW0jqOmO+AJVYYlRokRRmC2tmfn+chBA7/hQ63zJC+6UCfv74fu/LG6cwrdG6ZpFs3Nc3pgRYNzPU6kGNb84umQnFVzKAZwO5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SaCptQg8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAl7sI004687
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bhG7bDwD3mvvB+arfoW2xQRe
	XiSpPUNHdkakI97zRUg=; b=SaCptQg8OXr1fB+vzrIxE0gIdTuUI0OSlqiSVAo6
	hv4hYpHddXMK4iTZYGmZ8+1Lako3QGbjomeNsCXme4kAX/1sjY+F1/N1OF4jrRiP
	zOvg9fWQv92SawDa3fmv6U47AtfmwoItcptGQlG/kvI2rzkY09rivUwjxBNCqRzp
	kCs4TW6w4MrIveaRol49orOXOPs72DmRCL9wjyU8w/TlR+Unlv1UFybeROkf1bde
	uAjOehhWjcWN2le9Z11GKckLtSi9sY3tmD7JRlA2V5taolCJhDrdSW0w5/1oBDzO
	HvGs/J94Zqsp6Ceta8DBr8qUSRi324lFr8xQGgi0/CDetQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbaxtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:51:26 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7075a0b5580so105355906d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754995885; x=1755600685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhG7bDwD3mvvB+arfoW2xQReXiSpPUNHdkakI97zRUg=;
        b=wpw+GKssUf9vO7GAjJXXzCaCAvXOP/hkmxd9r2dBHo3jk3jYzPXAQhUpVd80fqXAF/
         y67CznosBJymjk/LWT4YQiam+RNPmCwo9WZczKbFJTsXyUFqIbh2JsQIdh0eceJktGX3
         Ld/fY6BI52FB5xlwIDg81Q4+JHiZb6K6pQgjj6j1/vG50hFZQCD4EClL6uUEZ9PFGCMN
         zCmdePtvLPnqUU4RPIHS4z/GxlAgn8Gs6O2Y/yknW9Jo5plGJq/Nt8dEF41sIlDLbF4h
         /i+5Ib7kaxRAYnJ4ccGaNBO2lnuQY4Tj4US9XIlXZxzAd9i47s1fXmAO8qHWuoT9fADf
         jYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq9j9iWKL/WXdFXEoxVAdc+EdoxSM0ZxltVxQ01wPY8cylui7O8iSV1j4NU7ELZNIHtrd4JCQ1AjxvcRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/o24N9hbXKkoAJEXqyoJyKNvkvoD/bqYkj3mxoKFYb39032Cj
	TohhbLh8IgUVErK0KmA0BRn2WUXqqmQDvJhF+Zj6E6J8a+Us0wmqUXY3WrAIvjNrviIa1wHbIlp
	yTW+GkwY3NyMG7UgzLIn7jzpYRhQVkJCfw/S0xH2Bh3FsrdgD2v2kk14Ek9KQ34VjHlY=
X-Gm-Gg: ASbGncucMgCgNH+FUg7mh0y/+UKO+DVLJnliEUeTCfIruX3midPyqw3SSTWTwbsVrF4
	HcOO8utWc/KqUmb+6sIRa7dN6OFbWgjmuouWOU2fcn7ktyEPGgI0hnmETAWa0LHCgp5EFm02C6i
	863tXkeAA2Qu1PvSQwZ2MDzHdZyyxwjqceLDQHF4WtCQweyp27IWtxKDoTEr5BOIE0VIl0n+8+B
	kb46/xCggUxtCajYPwHHYoreZ8BzZvwH7Fa5z43LQz2Z1y4AW0A2ybTxaWKtBn+2qULDb4xQEEA
	yfX3hUv75WuVW68fhVK1Jp/1b1bTRN/s2xj+ckZFA1yh0TpxAZG2KySdxUBnKAbCuFIWwV8arXt
	diP3MpBLaNebtFzojce8m970jZIPX6up+3pRZjGUwlWNHOLdMEgLt
X-Received: by 2002:ad4:5dea:0:b0:704:8db8:d3cd with SMTP id 6a1803df08f44-709d5c76484mr34564006d6.8.1754995885283;
        Tue, 12 Aug 2025 03:51:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDlfuS4Nwz3fIMIuFWUdbpX9cZH7Wuc6mH++YEeE7VTQQtOIc09mesMedO5BiAjMUO345wxg==
X-Received: by 2002:ad4:5dea:0:b0:704:8db8:d3cd with SMTP id 6a1803df08f44-709d5c76484mr34563536d6.8.1754995884789;
        Tue, 12 Aug 2025 03:51:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ac341sm4628423e87.60.2025.08.12.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:51:23 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:51:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci@protonmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v4 3/3] arm64: dts: qcom: msm8953: Add device tree
 for Billion Capture+
Message-ID: <b7qczborzhw7slea3mpmwp5lbcawurvgkdhioqener5ph3hbvg@kdvyoqqv6xy5>
References: <20250811-rimob-initial-devicetree-v4-0-b3194f14aa33@protonmail.com>
 <20250811-rimob-initial-devicetree-v4-3-b3194f14aa33@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-rimob-initial-devicetree-v4-3-b3194f14aa33@protonmail.com>
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689b1cae cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=sfOm8-O8AAAA:8 a=EUspDBNiAAAA:8 a=N6ARxV_FePN732dIbUEA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX2dah5T6RNd5k
 2OKYE8FPr+wjrjNqJzNk4RiSrHH+A9R4Mv3lcE7jtAoNCfrqtrOcgQeWxcY6RDoM3XDNYNyme8n
 gvMgMVP3PkgGvfXDdCU7xeVrksqjiysIz3JiELmx1rs7dzYuHtn9ZUQIwr14oZK3o474DdLgiiH
 l1EHTQ0zXaHgMmyQXEAxiEmlGJLKT+U6cdzLjOjFtAA+5aAFr7ie0Ps7G2fhUvrxb0x99n/VTU0
 qyHSRLV2UF6mx1B1UB0q32u0zKvLJJO3v+MSIRatFEBHDuUDtac5kts53mJ4gb+BJ8dONRsJHdF
 2NNQxtHqgIteDRrNvZRzV47/jQtACCCNR6KI3y4RCjn0Rnq/VpwwPMtRnzDzTqfNMdvqlYQ2mbd
 W0WKGkE1
X-Proofpoint-ORIG-GUID: IXJbfcJP6VPstssdAdkyhZi2VyejdypJ
X-Proofpoint-GUID: IXJbfcJP6VPstssdAdkyhZi2VyejdypJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

On Mon, Aug 11, 2025 at 11:08:11PM +0200, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> Billion Capture+ (flipkart,rimob) is a smartphone released in 2017, based
> on Snapdragon 625 (MSM8953) SoC.
> 
> Add a device tree with initial support for:
> 
> - GPIO keys
> - SDHCI (internal and external storage)
> - USB Device Mode
> - Regulators
> - Simple framebuffer
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 255 +++++++++++++++++++++
>  2 files changed, 256 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

