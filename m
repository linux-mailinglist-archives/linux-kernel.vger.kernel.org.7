Return-Path: <linux-kernel+bounces-784384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75F8B33ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0482203706
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6E32BF009;
	Mon, 25 Aug 2025 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RWnzqxDi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445B29D270
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113850; cv=none; b=k4+NCe8vb9gumT7lK4v/umvqRDMRA76xQuBDWqqPcp3Go5EBfwxASsLOUYy1x8U4eY25mte3Q60vkIHf+yjJ8P+eVFqSn9HYbmjoWbtGmAyCMs7SrDcbZUMh2ICuKO6Lw4shOmyk4WEWlpeKHOSUpxu78c0QFdEt5fUVlBOPgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113850; c=relaxed/simple;
	bh=b2EDQMgIJW/BbvJCKvsn+1m1vJhpeJsz1lWiTiulmsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klmMBDDCCR9Z7qUWMbUIXk007ON3eIASAKRvLTEx0sUJOJjOjLCc5NXiJtJgTBZtF79EimLdfNMU3QlY0uu1/hWfYnDLcYEOioVLYDvE4rocu3pdQKJvM48xE/SJmLC9Zw7Q680i3Gx4aGn1LWbQW5fCHRA5+RNqv1DdXvicl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RWnzqxDi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8MFNm004082
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AT6FII3PRnGlX4a1qfX1+I0s
	GPeMrRjRAQ41zyHfCGM=; b=RWnzqxDiDyxxzeQAFtb+eDIoCyR8NHZ6VNb9sF8J
	jDadzd1bTuX2tLbaS4rysvu+kllLiBRG7QemuwKSVBYCEOrTkM6RtLP/seaV+qCo
	c3RnN/w9V9BkEVwUPH5GWd69n4Bl/nvjC6i01GQgqa22IvbrEhU6EHovW/kL2N5/
	A5n29nBjzZ3+nEPCTs5nqCdvffDt5nNvSCMq8UX/BN+yM/ThoJIlQ3agAAfrYiSO
	LkRaxAcGYymw6Ow9wcJrSqcnYVNQ3vvgNIGSGvYJBa3ngFbnun5DYRUDkoHD1E1A
	HT40jcUpwOUK00z4JvtB7ys53thHrefHPyMNSZZh7MSpSQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpmm8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:24:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d9eb2eb9bso55848806d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113846; x=1756718646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT6FII3PRnGlX4a1qfX1+I0sGPeMrRjRAQ41zyHfCGM=;
        b=fhbdPSwtv9Ub3EunAkC0mLoI5xsPyWHkcOk1H5NszN71r/OM7bPGkLREoEMLZyZudl
         dL8aqquqDtszycYQAYqBw+4cFH55Z4gQ7Mu7iNTBskSvdiw8W1/x8TOHvpu97fJ4gk9Z
         slrQgok2gL8/Xm3bBDS2Uai7O7FYX2DQy6fhGyu/j0laSbAY8KtIJYgC58bF6/ErIRGt
         WM4G4O9tY5pI1Jq0vLSUYfhnJWabgefRV1dZ95o4YMvMO5ttvrbdsaRamENFbq6lSIty
         +un/jKSpaVkqrC5KYjaYB4H6+PULFTJ7VUS6k/lG54zf/xcz3Abp92hMI12kXBk7lgpG
         T8MA==
X-Forwarded-Encrypted: i=1; AJvYcCX+eta8v0XxrjqFOZUoQ6Lu279s8UjMmc7Dvqlv4JwdKhOpgfrLsuc929WcS2FLjpvfkIa2vyqtRTWc1jI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxuxnc1BefnqyEuv3QCGtPEqArOn/R5qeMcDoJ6ffu/42Pyoij
	DulgqLICC2QUSzhbTjKsLeX3PWenK/EM0pvspPfIl5vFjIXOixhb9WEUdK/0HxkaVfK6uo3ssK5
	FA/aprAI5ACHtm7zfn0zLnKPLEoy5tY7l5KwRiLFz37N0r5tp0BhS5ZKgBbfRy452sH4=
X-Gm-Gg: ASbGncsRGbAqyPv4kl2wgPkcF/0CHpXfowLJExt7WiGKQYQuoBsfOKm3jQnTp6O+Rp/
	oLv6lPWDFN3/fSvsgSPToQhvG7/NJloPsuqkS5rk2baN3Q5gZRlOuXKuh3dIcKYhDoM1bMjWAYd
	PJdbcYr7rbjab6Jry82rVLSybNG2qBIAfuLa/P8ZWco/TZjD0VN91/ta9dD9ANv3VzJvRvC//kk
	nnCi7q+QEoE0H7EGeYK1//daA8DF7gvSgTPrUBXooafNhHy5nuIxwMDsrO1X2IDxwdG/i3FEWj8
	MRyaX3bB5tBqAegJ0rubkzDt2b4J4iQJRsXEyFPfBlTltS2tn2bfJ+PnapJjYqayI/S3IRtpzss
	ZFppeANjdM7dKKhelodEwu6YQDjxcAEdslsuTu470APYj6/EAHTfk
X-Received: by 2002:ad4:5bc5:0:b0:70d:6de2:1b35 with SMTP id 6a1803df08f44-70d9723e568mr105994856d6.65.1756113846195;
        Mon, 25 Aug 2025 02:24:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9KdiFDmptPVEofCOhzPmh2gkvGoRl091r38GytacLaqu0DbZGgyFkNfMNserqEeK0yyOrKg==
X-Received: by 2002:ad4:5bc5:0:b0:70d:6de2:1b35 with SMTP id 6a1803df08f44-70d9723e568mr105994626d6.65.1756113845564;
        Mon, 25 Aug 2025 02:24:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c9a21fsm1548650e87.128.2025.08.25.02.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:24:04 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:24:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quill Qi <le.qi@oss.qualcomm.com>, Jie Zhang <quic_jiezh@quicinc.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>,
        Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
Message-ID: <qlyqobhy2wjwpp437qwyk3zs6gqp47sremvdud674ygjbeziag@motnuwsalpvj>
References: <20250821-hamoa_initial-v6-0-72e4e01a55d0@oss.qualcomm.com>
 <20250821-hamoa_initial-v6-3-72e4e01a55d0@oss.qualcomm.com>
 <jj3mvad27kdpfxo4p2c3jfpjq2icao6mltpx4uu3sretqgkfap@vpqgfwzl3sjs>
 <33ac5fef-f855-46f3-acd3-daa8fc34d918@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ac5fef-f855-46f3-acd3-daa8fc34d918@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68ac2bb7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=PfjXB2Kww6_2cIryhmQA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: iSZ5jw764fLQuZQ4yf70IsErpzzNGGDb
X-Proofpoint-ORIG-GUID: iSZ5jw764fLQuZQ4yf70IsErpzzNGGDb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX3eboTLgCPQdx
 z35Idb7zDy1U4Brn47cbhSwXhzEg6reuwUG6I8d1W3kYrtdD07HnTWhBr9G+zqXWodr3T5v8Dmf
 u0C1780FkzrYRqM29M0wCMSgKHUNmZzrKouHh9Rgl+8/K5jGS629BPR0rooedEOTPCS7tLXHTJr
 9y6KVtSNVpJpCyMTox56hUqDO9qZe9NceHg1gBcYg0kGhstkWhJYf9AIjwoYph8hSX+jOlwy1qu
 EgqHUAnlNERqHbzS+oz4Z0SF47wGWkF95QLOLofOT2xIfUelfGjJWotWP0aBufu+5zW6fxxwpNM
 bvMRzcQWxpM5t/G/wm2h/WtaMZFySvjh1UewjqeLLkc9Dac5qgRebM0W8MlXAADCLMznYBH47Jh
 0s3/afXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 10:47:22AM +0800, Yijie Yang wrote:
> 
> 
> On 2025-08-22 19:56, Dmitry Baryshkov wrote:
> > On Thu, Aug 21, 2025 at 04:20:24PM +0800, Yijie Yang wrote:
> > > The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> > > the Hamoa IoT SoM and a carrier board. Together, they form a complete
> > > embedded system capable of booting to UART.
> > > 
> > > This change enables the following peripherals on the carrier board:
> > > - UART
> > > - On-board regulators
> > > - USB Type-C mux
> > > - Pinctrl
> > > - Embedded USB (EUSB) repeaters
> > > - NVMe
> > > - pmic-glink
> > > - USB DisplayPorts
> > > - Bluetooth
> > > - Graphic
> > > - Audio
> > 
> > No WiFi?
> It's in patch 2/3.>

No, it's not. It has PCIe4, but not a WiFi (which makes sense since WiFI
is not present on the SoM).

> > > 
> > > Co-developed-by: Quill Qi <le.qi@oss.qualcomm.com> # Audio
> > > Signed-off-by: Quill Qi <le.qi@oss.qualcomm.com>
> > > Co-developed-by: Jie Zhang <quic_jiezh@quicinc.com> # Graphic
> > > Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> > > Co-developed-by: Shuai Zhang <quic_shuaz@quicinc.com> # Bluetooth
> > > Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> > > Co-developed-by: Yongxing Mou <quic_yongmou@quicinc.com> # USB DisplayPorts
> > > Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> > > Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/Makefile          |    1 +
> > >   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 1247 ++++++++++++++++++++++++++++
> > >   2 files changed, 1248 insertions(+)
> > > 

-- 
With best wishes
Dmitry

