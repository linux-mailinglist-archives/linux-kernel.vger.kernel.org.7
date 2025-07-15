Return-Path: <linux-kernel+bounces-731680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D49B0582A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A0B1C2289E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F882D6401;
	Tue, 15 Jul 2025 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NJLk4v5Q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A932E370F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576651; cv=none; b=QAPH3wRmZM5NPHyR19l+wVIAH/7BFrH7IY6wlaDF3yU85d4AruDQjASNhH9ghEeupiyL2sGShD2lfxUAL5upnyQZSFaEicNdsX8JygbMRL82InZ7f3GLwmTl9gLHWy+yOdfXNYDVzZkJ0t2lF3Ln1Fub9dw+nUSXpZ7pPbyy0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576651; c=relaxed/simple;
	bh=zO0eVT6bY/HaDWcD10xtv9wGIJ8Et313GZFZC4fkQfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tpkb/PEn2d4gYuiAJj8uqAaS67n4GKvWRzOyjf5Zh3QUfnOo8NCSU8W3hknkPzXDT9qONZIdqnJnPsM4qKmHGhPKdqmW5AyNljNXyo8BttzutrB4+NBKFhFnSyBw0DBBikMsPsCMPfjUlM8SCA5mRy0vVj9qV6WuxXM/xDl2AUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NJLk4v5Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7sBMx015241
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ir9keSX1LMez33Upmie3bS45n+OlybH6S/naM0ST3/w=; b=NJLk4v5QXZqJpg9A
	WyTZ0BP4zBwdehPY9BrRrvm7GMu9TAEPR1KcHVPB8TyzfgOHeqqWx0EIVBu0bGY1
	eRGGUpkLXj+klDomOlu4RicL6KqNelcEe+gMsDA8fe0WbTtG81AVwY1WmsCZHaHX
	Hx4JRUsQ2e1d8kLn/SIUxBHhxbOqZ5Dole17xyuWRU+ThLARQj+OGqFcz8/9a5PF
	m030ROwbXF6EuNgo3IlvStpmdmr42wX00h0Hfm8IuC7gywoGf6CWDa50RLMSyx6L
	G7xQumzyZmhRsG/aPS2TdYvcfstZrgaiyJGURCg3ARSKK4skUd5iurN1i+6v8XqI
	YFNXQQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu87u87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:50:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab5e4f4600so3069161cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752576648; x=1753181448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ir9keSX1LMez33Upmie3bS45n+OlybH6S/naM0ST3/w=;
        b=HaFShj6xmE4Fst81rh25SDcv4fp/o/jpHJPMocYHgEvWl425UlinFjCKzy2n1CRR/w
         +9jOzQ9WRQjzym0mgKsyIR8N8E4aT/3FoHNhZ5XYyF6OQhEvFynlZ+jAKAWy9jV2se5j
         H/qYNpRafhoqz+IDpnIyRclCZBAAh2a00A2+ChDGnSuwVZxtuhEaK3AWPC59reNHmmbI
         JlcA4vCN40eJJ/Ex5ye34aV/gCU+ddH1cLIeNCxWFDTFjCjqrjbf4ejOI06/VR0dlefF
         mKAu3OpowZtfl+9Q+B70ZDGZ5KGO5swT3I9T2W1pDKc8dmEVuyvLS8ChVRcE8a/NNsiY
         6loQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCBxSDWSKy49Yxlb+XfB9FuFU1p6sTbQo3CKUyo7TwZsq2qmXCw1b2Hq4N3rcJxZpUQhMTq4O8lbNKYAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0JMud3j0tVp8WJFe2ZTu2TGwL5fA+X86ne9l0LkaOKHW7+XZ
	82hQQwk9x9kgm64flxJPCwZ9rn2wlr6gpjueSVYMA/PX6hqqv+e8FIGLnQIDt0KL7ouYH2jlpxP
	xsK86krgQhKwscvOhIQQNwMFK5ozrBqw0VNJ3Ze/HmCufMGNS0F8SsbNEb3asvY0xmiY=
X-Gm-Gg: ASbGnct5pCB1WsnJrpZK98JxqjeopDSyJQgMoA6Xo3YLoPzeg8leho4S95D0ZFwFmmP
	ILSghUNHcuI3cf0niTbnfPqoIZwof5rjnPASjaeOFnoEKrsLAzfhoHPY4RjME531gngUbhUH2lh
	ElD4htDOND6aBPnizn0ce6nMaJtqP8SjZYAIRczJT+ZgcR4CF3Thif1U1gwG41ye79Y/8Ll5WIt
	nA0rl6INAWtVMhw6961nTSEJFQ4jVBBpqaTKDuHghfNTd3SBuXUSlCIDOnvB3ZYmaMfyhzsgJNS
	HwXtzIGKeb694a4i+3Oi4M5rwYiD1Rw72LuxlP2IKRSi4Q4KBpyPlkSJCIAaBwWHNaYoz4S0fLn
	kA62RhMHT3Tzya+ezS7ui
X-Received: by 2002:a05:622a:1495:b0:4ab:8107:6c0f with SMTP id d75a77b69052e-4ab86fc5d66mr6516281cf.10.1752576647870;
        Tue, 15 Jul 2025 03:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrHzbQnSG5UsPwzEKOplY0S2bhAFx47Y1I/loi9Sna7ftnlRubhy2cMFHCBtRP+hsTx5xo7Q==
X-Received: by 2002:a05:622a:1495:b0:4ab:8107:6c0f with SMTP id d75a77b69052e-4ab86fc5d66mr6516121cf.10.1752576647271;
        Tue, 15 Jul 2025 03:50:47 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82e5309sm991511666b.173.2025.07.15.03.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:50:46 -0700 (PDT)
Message-ID: <4be1ebb7-1dc7-49e0-aa5d-621f023b3853@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 12:50:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250714-b4-sm8750-iris-dts-v1-0-93629b246d2e@linaro.org>
 <20250714-b4-sm8750-iris-dts-v1-1-93629b246d2e@linaro.org>
 <5dd36649-821c-450e-bdcc-871735d10059@linaro.org>
 <15b8b9e0-a211-4102-9b68-994c8ab50a7a@linaro.org>
 <b5a68138-4eca-4bdd-8f72-d80236b02c0a@oss.qualcomm.com>
 <ec0f64c3-bd08-4944-817e-f5f67c317b94@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ec0f64c3-bd08-4944-817e-f5f67c317b94@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5OCBTYWx0ZWRfX7IQbAEb/TU83
 6Zf8BP9aiUsLRlM+aPVfqYmLeovJCUg/OLpj96eBkyRRHc/gF1AzASeXP33vVO3dP3YpkcDbvLO
 ffqsuZUrWcqOVo+LcnmCzLdH03vdbogysThfxBOUs4z3S99FwDf2GG/R34sxHTO2+GSk+hHEocE
 njTIs64J1DE0GDvPCF4yC5p3Q5eHpRO1cVqcqQF2ruveH2AP5IYtFxsfrbHn7UCs+PFaK5VfmND
 qLr45k/Zb+BZqOmuMwZLBHlOA4xhhbEMzdgUhSNUjkzW6WVNdIFlRMJ+WtXxRyLFxgJ8LvvMDdS
 QUEIzbblCl8EephMK+s1gDmW7Uf0wQ+denloQ2JFGGPgS2h2stlvGlNLwDR/3CnOfFuIbM0x3bO
 ZXsBorrY86M+rU0PFrBgf7ddjoj8GaGUwHo35Sgc21Xpot8x2TRrd4TAdUPNrdQgvF9o5Oyc
X-Proofpoint-ORIG-GUID: vuXZHDk-860IXSAlaSS1j0mQ3sphFoVw
X-Proofpoint-GUID: vuXZHDk-860IXSAlaSS1j0mQ3sphFoVw
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68763288 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KBVr0NYvNlN9pVTpkDkA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150098

On 7/15/25 12:34 PM, Krzysztof Kozlowski wrote:
> On 15/07/2025 12:09, Konrad Dybcio wrote:
>> On 7/15/25 12:07 PM, Krzysztof Kozlowski wrote:
>>> On 15/07/2025 11:32, Krzysztof Kozlowski wrote:
>>>> On 14/07/2025 15:55, Krzysztof Kozlowski wrote:
>>>>> +
>>>>> +		videocc: clock-controller@aaf0000 {
>>>>> +			compatible = "qcom,sm8750-videocc";
>>>>> +			reg = <0x0 0x0aaf0000 0x0 0x10000>;
>>>>> +			clocks = <&bi_tcxo_div2>,
>>>>> +				 <&gcc GCC_VIDEO_AHB_CLK>;
>>>>> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
>>>>
>>>> This is incomplete, need second power domain and I did not check against
>>>> qcom,sm8750-videocc schema before sending. I will send a v2 a bit later
>>>> (maybe some reviews pop up).
>>>
>>> Heh, no. The DTS here is correct. The videocc bindings are not correct
>>> (and that's not my patch).
>>
>> Well, you want two power domains here in either case..
> Are you sure? My point was one is correct and downstream confirms that
> in their bindings (which is a poor argument, I know). Which one would be
> the second? MM? We don't have such...

Historically clock controllers used a pair of CX/MX, with CX powering
the "meat" and MX powering the PLLs (& retention logic, IIUC).
Over time, CX was split into multiple usecase-specific domains (like
GFX), and we now have MMCX (or MM_CX - multimedia CX) for multimedia
hw specifically

In the downstream tree you're looking at, sun-regulators.dtsi aliases
VDD_MMCX_LEVEL as VDD_MM_LEVEL for $reasons, which is admittedly a
little confusing

MX has similarly been split into MXA (MX-Always [on]) and MXC
(MX-Collapsible). For Venus, you want the latter, as the hardware is
not crucial to the functioning of the SoC (the connection is of course
physically determined at SoC design stage, but it's a good heuristic
to keep in mind).

Konrad

