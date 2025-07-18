Return-Path: <linux-kernel+bounces-736736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB3B0A11C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE451885980
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954202BD59C;
	Fri, 18 Jul 2025 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hdFNWohI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978DC2BD022
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836046; cv=none; b=d7P2tl64KRIFe9STKMfwk3YYSY6nZojvuqRL9crTPcHvaozwDkJYT0CzuItZoR5sfaBxVY5J9g6yvsgESDbo6P8BJVoSB7sxuRa8+tIEfphfoRt4kPZhT40l1Q7QHvxCeqehiJckh6tBGGrHC8+cM9JWFdvSx+C2biYIJLJFZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836046; c=relaxed/simple;
	bh=ZtyV0pcwIGmLZgYZMuNrzpvaXbHSwQYl8wSg6lg4Hjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYdyQx3xsKQz1psHLpK62udUnjAfyewpRPlxiVdrhRPhD/Me06/Vq06MNSqzKQgTwV7rfLaKuj5RWb9nLGboKWvkHiY7V3EcqB7MmVvmsLB0NtcpQyQ/FhWbUCvZU7pLLwhP3sdYidFwA3vzhvRyMRpUZLtsqR2N9OaaarNcDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hdFNWohI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I77bXR020820
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zoFL7Jxs7RkKl/HeM9uPqTAAPaM3GkGbjjY3U9dj2iI=; b=hdFNWohIzcND3iZ3
	BkAJfQ65KpgfjHOX2Nxa49jDvvVG8k6+qZ8brK0CDvyuksdx+ot/SVyowcNOotia
	ajEJdvn9Jp5p3hn1CsJYedrfjshqSVxPN1zVUOFkB8PJqESoE3U+aw30qVjzEvnG
	2Ch1tKrOC+31cFqFOUwA5Nan8xictEbC16g0g0pcFo3KP1/+AU0XfArkpjH61MZ+
	ZtslqsXo6E7trqcixgh+KElkCHBa8OciN+hmNGACskwbpTw/HQOuVcD1NTQwdXQo
	T5umiroDG0bhAHKLDNXEer8iND5v9ENx8ESZOniM8DjwcDCFUvWYYj6M1vU6gy4q
	JVcGRA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpp9ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:54:02 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fabbaa1937so5658916d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752836041; x=1753440841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoFL7Jxs7RkKl/HeM9uPqTAAPaM3GkGbjjY3U9dj2iI=;
        b=Obj/z16c68ee0QK9nX2+xgekEbBm7tVCwL5IwHj+Zq14umFA0pR4gQH5jpvMyutD+C
         a5fLipwBDnHLPaDbJihQoButpCGpcuhWmqf4dwyzIF66W1e9VczbnoMBbb7tXDZIJP2R
         JFYqqkIFPRsNcqzJn1+GT3TntRzF+LcspThwiX60WQnImXJDsVSjGqHd4gfOH0AyOa2k
         U7seT3c04RW1URjDIcMqUhCSsDaNOqolmhBSJmoHZgDNYXin4a5ocYosg0gm3MvHh/vu
         9w984Rwp3JC5lcMdQwUfFZEmv47WYKkKaxKU/nI9n28d2exutE1CisBuHJqbHaq+J/Rb
         nGOA==
X-Forwarded-Encrypted: i=1; AJvYcCWVH5+xviWHIfpsETsWj4kUI9frVkfbgz45zDd/CkcjKi0R8cWU9D30dP9oqQbPWNMazxg+EFuCP1VIvJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2pFhy976jltmRCa2UEi4vyE+X2h3pOhnssqvmkJ0wJS6Phv3
	QedM1zs8y8hl2o8P9mG2mjURHBKQtL3mcYxxXs4bRC+mRo9MXV9erNygpyYDqmYvp94WfwZSL/m
	UXmF3VWus17cp1NJfRtiO/L9oMKZiBAKnOpRyYgSUHwoMbWTwVBEzm+L5XWCAr2dZS5s=
X-Gm-Gg: ASbGnctInDhiW8cV0KwRmq7GzE75yqpxmUBFfVCrXGGQrruHil4hKSu2JiVsA027i4y
	38R5L8ezE5ylsaJOkxxdjr1yh4NYiLlbjIkroehNLDdncdcKCuhsSwAqI8FnEnzuXlUHlgOGnjm
	043/ksSuEIsnK0jpa3e7x25NySFmRbc91Mx40hUOfWf0zZ8FFJb+PxMUicGtxvQGXGHArfPevVI
	H3iZjyBsyO7PigrlatgOQucyU3KdyQoTjP8cGtP+PtQLc2F3yOcRskLAaMMRE/TEFiZ5U/tIpbg
	kIejdswvB2Cm2iwFHHrOQ2ZcjF1yVGp0KxlWpMnOgV/0yKe1DQDMfzfiQFcF8shgc0GZje2Kl8s
	GDbfUY40nivk9lgYXX3Ds
X-Received: by 2002:a05:620a:4490:b0:7d5:c29a:b41d with SMTP id af79cd13be357-7e342ab5490mr671467185a.6.1752836041385;
        Fri, 18 Jul 2025 03:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlcZ4cMvUifS/6K13j2DzA/MxzlKQABGHki3WuWIX0V7eMrHBQtq5xw0vfsXBYwbja7Ah8Qw==
X-Received: by 2002:a05:620a:4490:b0:7d5:c29a:b41d with SMTP id af79cd13be357-7e342ab5490mr671464785a.6.1752836040901;
        Fri, 18 Jul 2025 03:54:00 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca310ccsm99825266b.85.2025.07.18.03.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 03:54:00 -0700 (PDT)
Message-ID: <86e14d55-8e96-4a2d-a9e8-a52f0de9dffd@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 12:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
To: Johan Hovold <johan@kernel.org>,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
 <20250718081718.390790-4-ziyue.zhang@oss.qualcomm.com>
 <aHobmsHTjyJVUtFj@hovoldconsulting.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aHobmsHTjyJVUtFj@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA4NCBTYWx0ZWRfX5ME8ofPzs3VG
 RAr+gZ90jrewjATleDmIZlrHI9/VFU2KyCkia5IldptcAnCYkciLY7wNmONz2GkBLt6oFWecdEB
 D9dxDvLXHtJQkwe5+sq/875lGNqOBtAlrQSFLkvznboLELMQVBidMZUwjFeD7QOr0xBEYlHzWfl
 FFIGIUgcGMd8+6ybvphf84idSGcaYLvCuAAEWPkf2k+gmXQRhs62xxLQDqZaP1y48So5sJXTYr+
 vlDQ1xySI8lJa52AsPYI1ioj9Q9vHH/AIpCa0CFI/8faQ3+EdWmv3Oh7oG4l3vB6VgLOe9duyue
 2YvWmNtU1suchPFoIhp3glgNDVcOCXuP+bZdIdULshOZq3ob/rIyY5KvmIDp4on4LK3jEgzYoeK
 yjisGuYV6keWNcm0FtpcNECs3Hm6NPUjNwEHv1EpT7KMGaH2vWLkqi+z8o30gn4ol/aiPsny
X-Proofpoint-GUID: rlr0y7BH6dSDTcRE8y6CjvHKiewl2D-Z
X-Proofpoint-ORIG-GUID: rlr0y7BH6dSDTcRE8y6CjvHKiewl2D-Z
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687a27ca cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=JwSYIlhaqBluAGix--wA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180084

On 7/18/25 12:02 PM, Johan Hovold wrote:
> On Fri, Jul 18, 2025 at 04:17:17PM +0800, Ziyue Zhang wrote:
>> gcc_aux_clk is used in PCIe RC and it is not required in pcie phy, in
>> pcie phy it should be gcc_phy_aux_clk, so remove gcc_aux_clk and
>> replace it with gcc_phy_aux_clk.
> 
> Expanding on why this is a correct change would be good since this does
> not yet seem to have been fully resolved:
> 
> 	https://lore.kernel.org/lkml/98088092-1987-41cc-ab70-c9a5d3fdbb41@oss.qualcomm.com/

I dug out some deep memories and recalled that _PHY_AUX_CLK was
necessary on x1e for the Gen4 PHY to initialize properly. This
can be easily reproduced:

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a9a7bb676c6f..d5ef6bef2b23 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3312,7 +3312,7 @@ pcie3_phy: phy@1be0000 {
                        compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy";
                        reg = <0 0x01be0000 0 0x10000>;
 
-                       clocks = <&gcc GCC_PCIE_3_PHY_AUX_CLK>,
+                       clocks = <&gcc GCC_PCIE_3_AUX_CLK>,
                                 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
                                 <&tcsr TCSR_PCIE_8L_CLKREF_EN>,
                                 <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>,

==>
[    6.967231] qcom-qmp-pcie-phy 1be0000.phy: phy initialization timed-out
[    6.974462] phy phy-1be0000.phy.0: phy poweron failed --> -110

And the (non-PHY_)AUX_CLK is necessary for at least one of them, as
removing it causes a crash on boot

Konrad

