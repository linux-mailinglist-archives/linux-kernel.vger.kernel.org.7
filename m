Return-Path: <linux-kernel+bounces-729331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5185FB0350C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7BE7AA990
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4810E1DE2BD;
	Mon, 14 Jul 2025 03:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DtJAHR7q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17B1519B4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752464906; cv=none; b=CFUZpIrr9kwe7qGrh4+MTJ3bbq6h7EJt5MOhP82Nuzf6OAyjFoA4OMqKE4+wUPu9mE1x99CcRAUZhI7iZk2UIbkms+VsvnO0QE69ZYMJYJ+sDPWobJy32A7UmYmG0MTwwga7J6SdstcvfskgaLMOe4tuYMYDlXAstHWAwotJ3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752464906; c=relaxed/simple;
	bh=gGfCqv7LeYSi2hrPFljddGhKaweiqkmzsdiTgmng0UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+qfP6PQ9sRgXgy5YSRJB2bC6foFYjsrmkuwzRejcke8xV5FKsLFCi/gwDLper2T8GGmXwvMpicPWnZZr3rz0QPQjoBfA6OH5rDqSLqAKUVcukrQUaZN7dv4bw6BbFnTwc8n3E13haU5B+cBfYtWUdaGQ3XQEdQkSjMiShdYXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DtJAHR7q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNRfFN006695
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4tCgmSZzhThqfTTY2ybikWriOTvAUcyKXDdYsfC585M=; b=DtJAHR7qFgpBNJKj
	55Z4Ek6koZZYYUdfkouPDBjY7lnSYlpkOOcWfd7Q0R4LnV6FqAJGpcjsbgZV6/1A
	0TOB2PUkCigRWSpsG5Wgrvb/Taa0Oh30bT3SNM9QojXn9HOhAMdi1Xv45y4Mv816
	PSkyVnELZRjBrdpwF0FIOFcP/l2RG0JEsQkCZoagagIyED9eDYv6IEPmy28EZMS6
	aWxMNd7UujZ/YIBQWrvn+OIOSEcTt9TEJJH2PI2mB3mvvcCPiFQM3xOCqp+m0yDc
	2zJd9vDRUr5ZPgcYhmImh5KoCLWO+y2ia++onNPobwM9gpwgkMZGTaQGYfYvUbbl
	I6Y4jw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8334y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:48:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3121cffd7e8so2921215a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 20:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752464902; x=1753069702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tCgmSZzhThqfTTY2ybikWriOTvAUcyKXDdYsfC585M=;
        b=DaKLFqaT3mumVEgJi8GGv9isgpwQoJ83sh8MzisDlE56ot8RWWSYoKdAl9l8suJ5q3
         DIDuBMR0keFSdWk1ZHbg3dyk9rIeyo9X31Ub5WIuIBtH59lSPX0TRPl+u6slUZaKvVCu
         c2/oGU5VKMGYD4sNsvXPRywXE3btvROYo0ihpVktOLQ/3J+jqzAgzJJVU4dV2CPSARqx
         v2fdEM2Vqc5FPlHH94jHi7yjvof1RkkvzRgEI/qK65hdhd87j/1r6WzTe6xIeEO248uN
         VyrkeQFB5VOB/RLc7MnyNH7L0TVVkzqYpJ8jnGUAkVhDpYztp01Xl8V2dfIJ5/Y47ESi
         Z2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUs9Eze/edjUtrz7Yj+4KObpju9jeft1eN1nYohtuAhaRaz/hU9ymJVoT2Uc1w9rClmUNp3hkiVkV6qw9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwllSYBLgrt0fMfYn/NCqFpOQyhaMUXIaII25rdgWTZC9phMhml
	Lujd/wywacrnBopHYFY64StF4kyR8XAGLD8Ox8QJXy3EVjw5cv+XTUKNFIzGqaJZnXkxknPAZnJ
	4NclS57zE8H01p3S9okxqhQtWhkSGV2rFLEmaeuXwT/zeZOUywJzfejawxw/9BXTdEXA=
X-Gm-Gg: ASbGncvHTkCTatTDBfCtBP609hDMS4RmYSwuNHNWA/xkvNOo+xoP2sJwyrEq3qL9L/r
	LReEmteWnmLgFYxlxTKLRHdF4j3z11QiG2+Koa2E7UCsTFbKXM/Qn0NccNLAIrlmz4ZweWlO4uI
	XXfBsq/8gpwiflmtJILKgnIknTeT33XkXtv0sABo+gKZuxmVt/UrSljVhT9r+77HAZeUk3nEPEP
	VyinD5lsgI0TyzjIJNqNXAYdaCf5lUasxN0GkyhDjjkgtQ15WG7OpqFe0yLj8wyG9GmDEMUtj0I
	7QnXxxwa8lYUzr0NDeGf6rJeGp3UDK6eZE40RxWpjMWquL7SiZal2AtScPAKUg==
X-Received: by 2002:a17:90b:5830:b0:311:df4b:4b7a with SMTP id 98e67ed59e1d1-31c4f563387mr13686430a91.29.1752464902075;
        Sun, 13 Jul 2025 20:48:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+ICcsq4xx5+Xy33tp1bP5bxNybUTBCZjbAYqsf5uVLmJ9j0Lqv5Xd9R8LbMkUF7FyaqR16Q==
X-Received: by 2002:a17:90b:5830:b0:311:df4b:4b7a with SMTP id 98e67ed59e1d1-31c4f563387mr13686394a91.29.1752464901589;
        Sun, 13 Jul 2025 20:48:21 -0700 (PDT)
Received: from [10.64.69.180] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435f262sm82597905ad.236.2025.07.13.20.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 20:48:21 -0700 (PDT)
Message-ID: <aca4c45d-7bc2-4803-98a1-ba4af22c3c0a@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 11:47:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] pci: qcom: Add QCS615 PCIe support
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAyMCBTYWx0ZWRfX2uu3EHcN3ngq
 HKJENUaX16SWTTb9zheLXyL9XRGMUKrTwU+JFBMr/CPq2CvI+8f07Ar7xa+JhOax649psRGmmkd
 Jh5GrAErj49H7FOMrQYF2yGdsPBd3DjR+MvLI4XwNwX06udNe7TPkPLhgIJ1tlJireyK9TCHbyp
 3jdMEXqBGFPOlXeHe3euHL4IkTMXY1CbmYIJctFZQ+Q8A0k9iGKEDi/xnb/YEyav33Z7TH1JoKl
 OSlNoqUP3H8ZCe/kbiGfPH1w5L1ZAGGDtJeqgHakWZ3EKw5of9OXjDXWH9FFF8abAp+0ijFNh73
 ZXbraBHtL4dCfIm97wTTWj9QLnmoFBUeMPKc7CRpQUtiYwXu9GoDNVmd+BKxQDNNQ/dUhyGmyDD
 tG3o9V5iYGzAFITeGvlaVIwXPesSli0mXvmwLzs7QgpuRwAVb19htciktM85Cx2JNHlsXtoR
X-Proofpoint-ORIG-GUID: IbAKFpF7RqIC865u6CqEBomb_tKV-899
X-Proofpoint-GUID: IbAKFpF7RqIC865u6CqEBomb_tKV-899
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68747e07 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=0rveLjV9VWli9pvRdbwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=780 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140020


On 7/3/2025 5:56 PM, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS615.
>
> This series depend on the dt-bindings change
> https://lore.kernel.org/all/20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com/
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---
> Have following changes:
> 	- Add a new Document the QCS615 PCIe Controller
> 	- Add configurations in devicetree for PCIe, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe, platform related gpios, PMIC regulators, etc.
>
> Changes in v8:
> - Fix scripts/checkpatch.pl error (Krzystof)
> - Link to v7: https://lore.kernel.org/all/20250702103549.712039-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v7:
> - Add Fixes tag to phy bindings patch (Johan)
> - QCS615 is Gen3 controller but Gen2 phy, so limited max link speed to Gen2.
> - Remove eq-presets-8gts and oppopp-8000000 for only support Gen2.
> - Link to v6: https://lore.kernel.org/all/t6bwkld55a2dcozxz7rxnvdgpjis6oveqzkh4s7nvxgikws4rl@fn2sd7zlabhe/
>
> Changes in v6:
> - Change PCIe equalization setting to one lane
> - Add reviewed by tags
> - Link to v5: https://lore.kernel.org/all/t6bwkld55a2dcozxz7rxnvdgpjis6oveqzkh4s7nvxgikws4rl@fn2sd7zlabhe/
>
> Changes in v5:
> - Drop qcs615-pcie.yaml and use sm8150, as qcs615 is the downgraded
>    version of sm8150, which can share the same yaml.
> - Drop compatible enrty in driver and use sm8150's enrty (Krzysztof)
> - Fix the DT format problem (Konrad)
> - Link to v4: https://lore.kernel.org/all/20250507031559.4085159-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v4:
> - Fixed compile error found by kernel test robot(Krzysztof)
> - Update DT format (Konrad & Krzysztof)
> - Remove QCS8550 compatible use QCS615 compatible only (Konrad)
> - Update phy dt bindings to fix the dtb check errors.
> - Link to v3: https://lore.kernel.org/all/20250310065613.151598-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v3:
> - Update qcs615 dt-bindings to fit the qcom-soc.yaml (Krzysztof & Dmitry)
> - Removed the driver patch and using fallback method (Mani)
> - Update DT format, keep it same with the x1e801000.dtsi (Konrad)
> - Update DT commit message (Bojor)
> - Link to v2: https://lore.kernel.org/all/20241122023314.1616353-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v2:
> - Update commit message for qcs615 phy
> - Update qcs615 phy, using lowercase hex
> - Removed redundant function
> - split the soc dtsi and the platform dts into two changes
> - Link to v1: https://lore.kernel.org/all/20241118082619.177201-1-quic_ziyuzhan@quicinc.com/
>
>
> Krishna chaitanya chundru (2):
>    arm64: dts: qcom: qcs615: enable pcie
>    arm64: dts: qcom: qcs615-ride: Enable PCIe interface
>
> Ziyue Zhang (1):
>    dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
>      for QCS615
>
>   .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +-
>   arch/arm64/boot/dts/qcom/qcs615-ride.dts      |  42 ++++++
>   arch/arm64/boot/dts/qcom/qcs615.dtsi          | 138 ++++++++++++++++++
>   3 files changed, 181 insertions(+), 1 deletion(-)
>
>
> base-commit: 3f804361f3b9af33e00b90ec9cb5afcc96831e60
Hi Maintainers,

It seems the patches get reviewed tag for a long time, can you give this

series further comment or help me to merge them ?
Thanks very much.

BRs
Ziyue

