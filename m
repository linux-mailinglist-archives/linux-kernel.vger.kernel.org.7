Return-Path: <linux-kernel+bounces-748628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7FB143E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0753B6EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C51274B5E;
	Mon, 28 Jul 2025 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KXs2qKgH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74532E370B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753738280; cv=none; b=B3iL/z2BugoGh+Mhl89KCt8zE9eTws9uFSdP8fS9CKx23WZgBI/zdkhDvr4+XCus7jXUIsllf0bpkPEKLVfIqL7CI3RLmsuiqrh6aCemeXQ5tLCIdcCmgZJrJg1NYlxYFV9yj72ocpECZiEcXnnyikqFs6CDabPsv76s27bWeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753738280; c=relaxed/simple;
	bh=xOpGSwD+i3k4RvsiTCXNKOCRdZ4nxyhgb6f9qWDfH6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFyMx38a+/hwxmFS0rRIQXlmrRPSZ5wdkxoVpBICajmZyNDDmm/Ioo/2ASpet+rShR06aQmr/j+aZz9wcGQOXsUSxt1E87imdMiMaL0Xyu9UaBX24ls1YAMEjCetRrP+T8FKBXcH2VzAKy8x5iu/UEuf1PuensZoDtPMNCYuJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KXs2qKgH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SLEOdu028180
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zQzEir7iRMo8Nll1ylqLs9Ikgmf6SuRckbH505+LxRU=; b=KXs2qKgHxKrmw8ge
	Q3tHP5EFqL8B3eauTeWPiQLecxuWuigdn5mxjtHAZJ3jhLrNYdt/13EDEIXEzca9
	bkIaopwTnsUpqhYazUPZuqedoPRtgl9CUqxSjsuRb1Ncgu6ztS+SzYg2ZIrDZbmS
	2HuUZE1NdG15tuv8hi+0DUMt7SL3ENWYeoSTZZ9GyKrMITXat9W+9tahQs/mS9hw
	MhFoF+k0gIxv8nHIL1ADiJsdWxWnbuyk0DuMwNKbShlIXBsoxmOC0Sv8fKasqccd
	d72XBXrAZJnCNM6LOBbgnvs/2Ili01uykCK8aCsp/6U8oGxXmXSGAnoArhO3hbTG
	Rev3ng==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2duvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:31:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7deca3ef277so99926485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753738277; x=1754343077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQzEir7iRMo8Nll1ylqLs9Ikgmf6SuRckbH505+LxRU=;
        b=TSP4TEDbi4AVLhCB8u2+//x7t1BxrednLSDGcCzGvf44syNuPeo6rHpnAfWyuPuWbt
         9/ls/ljkE6/P+af7hwhBw4zXK3yrdXcGTZJPV/sx4fRAEwHnD0RqMsVHpdx93qtngx0F
         4G5KmZUhtbe5813mBGGdwRq2i0wIno782BXWZo33ViFvQ/XyCTHePz/dxjNHxoFvLY+3
         pZhhbYXInAu0s9ziiZ75hGQWzUzvw0Z4HHaamPrf2SZBHJA3qLrSfWSIinM+eAE7/jt4
         NNrioxt7HdhalEtRjn5H3Y7sUwEVkJS/OVSDFDyfwb93pD7nX5nh4y0gkuNc68UY7rVr
         +VfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1lUKhVyOOzlI3/kfkrWzg1EvPQM/dO4Ja0vixSo8IO8LmNwcRsMsztxqOdwgW9/wH14Ky9sO+mte0lPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3iuaQH0ge8QLRC07xOghA81CTBh2muDSWPwJHNInQP6eyQOlT
	OBHQPb3Re8Q8rYU8kPa8hn+sF/zbu0TOB2Fs5Pt8/cqi10WCMdyeSqhbqu6B4/i3q7yyURdrg4V
	obpExnvwAYsJTVkSjzTXBcBTCl2zOFbQaf2lWj3EcwJzLOaWNX7fvsduMlA/aEJfHf78LuRhDvC
	w=
X-Gm-Gg: ASbGncv5dO5a+88plR7h+MXT5yopYPR971Andf/jY4utdjx054NxzemWVI9tt0gMjff
	4DNbptdjHNRoXGIyBIjffPmbn8CXwdRhTSiGJDJN7N+iDdzptFsH3+36KhYrJ2g/AAka6ZJUdp7
	/3zLAGn8zsHwVt/9RWUOZmAjudqD7czZ3Vs0kdPTHCeH+4zYFFeoKvFqWmDiuBY07xupBc1dIc3
	kcS8LqRJWPmeU3hruvyIzL9wbL92y1+RlPO4yKv3NqjBSjjLSDvqPCBHL/9p7r0kw+2Saua6CMQ
	ElTjODSCmZMl/B0Zmri5VBkI1b2kqLR6Z1AyagDNDx9qPLZ+IfwJSMzUkxY07mY03Dw5DuN/+VX
	mP48yYsAUvDN4nVGOCA==
X-Received: by 2002:a05:620a:2586:b0:7e3:3029:44c with SMTP id af79cd13be357-7e63bf6fa83mr809619085a.7.1753738276344;
        Mon, 28 Jul 2025 14:31:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+4JUeHIe/vdgr99ACJt7Fa75bNvYRVKL98OaFFoBsSdhAU1ioagzUl9HgqrphdrjT4yMMgw==
X-Received: by 2002:a05:620a:2586:b0:7e3:3029:44c with SMTP id af79cd13be357-7e63bf6fa83mr809614785a.7.1753738275560;
        Mon, 28 Jul 2025 14:31:15 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a62b14sm472695066b.77.2025.07.28.14.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 14:31:14 -0700 (PDT)
Message-ID: <50868cd8-68a9-4bad-99f3-8cf542886fb6@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 23:31:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 24/24] arm64: dts: qcom: x1e80100: Describe GPU_CC
 power plumbing requirements
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Andy Gross
 <andy.gross@linaro.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
 <20250728-topic-gpucc_power_plumbing-v1-24-09c2480fe3e6@oss.qualcomm.com>
 <aIevIuMDA5R8igmi@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aIevIuMDA5R8igmi@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aYnE5CSMkLL5tDqooklJ6KWM_JwsTihz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE1OCBTYWx0ZWRfX49aOJWJKsr6a
 jfQHNZnQBY5ikXBHiHj2w3IMYnkVZpqGa1YH/suopuLiJ2Jwh8B6EIF9AoZFAEYL2ok0wb5D2Vp
 j2SvvhBDae+SsS5D6nyOL5rLT2lxPW8UAtFSmTIL9kf/SDB6u/OXecw8Oc8CMne8s4Tgua1o5yJ
 rOgg3xvzYbNMPWC+1QdYOYQv/QouzPxdqXuAuNx+f/jYIWrRTDBR21AgXVft0jA3svY+cllsabx
 NIoj2v3PwXyPYRTvshSiJb+WxAf0eY0WZo6x53VI5chxl3gwgQGWUbmFCu9eyYO4Are4vm4DlmL
 0u4ELsqPP/O9dACtUFmzvA/hoBFF3eRQzVzLHRygvR/sjsn/GnvArdKWq0kk7BFa3mh3UmIt6Jb
 2CQfdlHB7iir31epjLyyphVXCrgj4O3Q3pSq6DUgsIZx5ttTmN6h8/W/8417m/5RGm69FUwJ
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=6887ec25 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Ep2Uw0KgDCB9V8QWne8A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: aYnE5CSMkLL5tDqooklJ6KWM_JwsTihz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_04,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280158

On 7/28/25 7:10 PM, Stephan Gerhold wrote:
> On Mon, Jul 28, 2025 at 06:16:24PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> A number of power rails must be powered on in order for GPU_CC to
>> function. Ensure that's conveyed to the OS.
>>
>> Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 5e9a8fa3cf96468b12775f91192cbd779d5ce946..6620517fbb0f3ed715c4901ec53dcbc6235be88f 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -3928,6 +3928,12 @@ gpucc: clock-controller@3d90000 {
>>  			clocks = <&bi_tcxo_div2>,
>>  				 <&gcc GCC_GPU_GPLL0_CPH_CLK_SRC>,
>>  				 <&gcc GCC_GPU_GPLL0_DIV_CPH_CLK_SRC>;
>> +
>> +			power-domains = <&rpmhpd RPMHPD_CX>,
>> +					<&rpmhpd RPMHPD_MX>,
>> +					<&rpmhpd RPMHPD_GFX>,
>> +					<&rpmhpd RPMHPD_GMXC>;
>> +
>>  			#clock-cells = <1>;
>>  			#reset-cells = <1>;
>>  			#power-domain-cells = <1>;
>>
> 
> To repeat your own message from a couple of months back [1]:
> 
>> You shouldn't be messing with VDD_GFX on platforms with a GMU.
>>
>> Parts of the clock controller are backed by one of the MX rails,
>> with some logic depending on CX/GFX, but handling of the latter is
>> fully deferred to the GMU firmware.
>>
>> Konrad
> 
> Please describe somewhere in the cover letter or the individual patches
> how this relates to the responsibilities of the GMU. I searched for
> "GMU" in the patch series and couldn't find any note about this.
> 
> Also: How much is a plain "power on" votes (without a corresponding
> "required-opps") really worth nowadays? An arbitrary low voltage level
> on those rails won't be sufficient to make the GPU_CC actually
> "function". Do you need "required-opps" here? In the videocc/camcc case
> we have those.

Right, I failed to capture this.

The GFX rail should be powered on before unclamping the GX_GDSC (as
per the programming guide). The clock controller HPG however doesn't
seem to have a concept of RPMh, so it says something that amounts to
"tell the PMIC to supply power on this rail". In Linux, since Commit
e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the
domain") we don't really need a defined level for this (perhaps it's
more ""portable"" across potential fuse-bins if we don't hardcode the
lowest level anyway?).

However after that happens, the level scaling is done by the GMU
firmware. This holds for allOf CX/MX/GFX. I'm not super sure if
both MX and (G)MXC need to both be captured together - downstream
seems to describe MXC as a child of MX (in socname-regulators.dtsi),
but I'm not really sure this is true in hardware.

The GPU driver currently first enables the GX_GDSC and only then
does it kickstart the GMU firmware. Downstream seems to do that as
well. So on a second thought, since we've not seen any errors so
far, it calls into question what role the GFX rail plays in the
GX_GDSC's powering up..

Furthermore, this assumes that the OS is aware when the GPU is in
use, meaning VDD_GFX would be on when GPU(_CC) would be resumed, but
with IFPC or hwsched, we have 2 corner cases:

1) GPU is on but the OS doesn't know that
   (which is fine because by the time the GPU is on, the GMU has
   taken over)

2) GPU wants to be off, but the OS holds an RPMh vote

I *think* 2 shouldn't be an issue either, as downstream does
precisely this, and if it turns out to be a problem down the line,
it'd still be something to sort out on the C side.

LMK your thoughts

Konrad

