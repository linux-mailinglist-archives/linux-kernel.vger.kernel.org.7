Return-Path: <linux-kernel+bounces-852151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B43BD84AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F10A19218A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22312DE718;
	Tue, 14 Oct 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kTIbnxel"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA042D248E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432018; cv=none; b=MUGc33H6hS+0VytdLpmcrHtuRf7aIF35njNyI7+XdXMokXZsHwWLTtRB2rUNf8/RoJ7rGbMDt6X5zrgCldwmGMgSpd9qTUIRaMsYZ4vqO2H5PDnBPwcsTAd+FblpdS5yDQGupVUC/hndqxIicblqw/iImS1wvxILUNSwS7FESKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432018; c=relaxed/simple;
	bh=ixb/fdiw8StgSMnPp3lrzYkEhBChXbenwOwYOc+9cJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDA06nLMfB8+mUtZ3YzkSaYYrYxHPx78uybyUJe9cAC5tF8JYJopE1XFwK5m4abs9UPtsD8OPe/QDhZBCRHL1VFW/gG9Ti4vARZBjBZ/E3Ut9KLRSWQ6GBsRYjMp5bliVS9QCRNUhwhtlpwm690hWqkUsia42OQ3+YM+S4mmKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kTIbnxel; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87KfM001576
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yu6GxXvjzVdp0jD9TyFSB0cQTPVuV4yy/C3ICodMY8c=; b=kTIbnxelhGa2sVP3
	boJK3HyeqmX/0HOgmXYWMij4nlauwxuwRmcj0aAOZC4nC4JsZAFPBu3yvdYA6Gjl
	aJPSbjTRO5XYviCOe3d/StKOp4eBS4kFaxp8IpxTRPa9EkjQhRE97dB3bco2DMyy
	ExLDNvHIFyeDsenozVaaiXx8hbeOVQkVIE+06H8xn0QlAnPwUFvtvhDDXpzbJJUQ
	RES2xTPr6phcaIik9jHxJXDZ694LxbumoYb98FK4U+Y6oFD4smz72AGvwcXiFbD2
	WD+GJ8WUBOOrW0qJQc2Wn1Tv9xMjgxPvsZtyrVRg2G5DU5HoODBTW92jlmzk1aSw
	ffoEog==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa87ts7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:53:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-860fe46b4easo287819785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432014; x=1761036814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yu6GxXvjzVdp0jD9TyFSB0cQTPVuV4yy/C3ICodMY8c=;
        b=V6vyUvIyBdiGuiBHUeERkBX1DE1441IpH+GV7tUWeloPK9pRxpD0xfzOH1QxGhOz6z
         a4tkJNeE0c9wv8ZcaX0sfp/fbS0Qv0qNo4IX9hrTi/u4/5JEobUaiNPn2SacuDek6Ngj
         JqhKxLYARCKzJAZZ+JulPusM9jESSA9ZnLK1t2VMMNnQ2c/7axeo5Tj4AOxCiaEgph3s
         G+gch7n/zin+Ap64QGXdPLxSeZ65XD1vgFqicXtD9wSnMV2cMC7Jlv8u4GyAMfwINpnL
         XA6m8Gf38+hYKPStV+/5AvGBVpW+0Kdu5z4bbtf1136/V8KKVpO08uG19dFES9zev3oU
         x6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG7ciqRS1cQqx3wzP4aBMsSVnhk70zm1jaZ6j6RbeXE2A1G9WfGgyO1d1U52+pwpRwrmGqxoM/TXTbtdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyESmubY0aDqS3g2CBObx6FFx3nTReJT+l8ZT6Yi+EFTPX3MrA8
	I9qiBpM//Ns7KwpvHoKZG+3Xfos3uWNzz1MUh6W7M5kjA3H94SfYsMPah98SPuoRizr9C322BDm
	K4pER7i9WTkntq5ZsGRqjpydjWx+e6GSr2GiFu1+kF7SHZZaF/WpPJMf1lUbIO/s5kOg=
X-Gm-Gg: ASbGncteS3DrLer7Eg3apJi+pnmBpxV1rcHxsbAvBdyAcMCUYNqqP80pKdVtd1GJKGU
	VICCvMIosA11Un9vINO4VdT9FcLPjiUa9Xdb9iHAKk4eTyhWuVLEr3cro192w62UuOckT4SZ7pV
	nN8F1pRQoXGZEHbNywjUhnz4SOztIcZXgA2QttGccD7+y7NVYsW0id9Hi7WKhSStKnxdGNVrT27
	f5y/dhAHI2kaO0vgB73NlF0IFpZtlM2BUJoDwoIdXnXm5NakK8rkmWS7CW07RQYmD3X5W00vOuf
	w2A2Rgsepg9MwLZOCfjB+e9eFFGgKMa9A2Zq9HpuSf5V16KFYEJH35680jxziBQL//JOXcTfCOl
	VlV9WrGC3Vk8tFUdqHvgC+g==
X-Received: by 2002:a05:620a:372c:b0:86b:12e2:28d1 with SMTP id af79cd13be357-88352d954aemr2148349585a.7.1760432014525;
        Tue, 14 Oct 2025 01:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm4ixM4YDDyNB4X3gy92GuzgILUxOgPYXhz9lsuSEFNcMwwXiOp3PYD1SDSeDU0RrlNXPctQ==
X-Received: by 2002:a05:620a:372c:b0:86b:12e2:28d1 with SMTP id af79cd13be357-88352d954aemr2148348085a.7.1760432014042;
        Tue, 14 Oct 2025 01:53:34 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12b4csm1136163866b.56.2025.10.14.01.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:53:33 -0700 (PDT)
Message-ID: <40a9643d-01b3-434d-9163-da35c2e469b4@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 10:53:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: qcs8300: add Display Serial
 Interface device nodes
To: Ayushi Makhija <quic_amakhija@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonathan@marek.ca, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com
References: <20251006013924.1114833-1-quic_amakhija@quicinc.com>
 <20251006013924.1114833-7-quic_amakhija@quicinc.com>
 <fsqytqhe72bgmloyzm6khoprq6bysf52ufz6oi6epos7uadyho@wg4rxs6f2xyl>
 <374098ea-23f1-4d1a-8f70-313a7e384f8d@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <374098ea-23f1-4d1a-8f70-313a7e384f8d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ApfbAN1c1M3gFI-R8bCYVTUlk9mKc21D
X-Proofpoint-ORIG-GUID: ApfbAN1c1M3gFI-R8bCYVTUlk9mKc21D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX5K5T77OnxxZC
 lUcGCCTHLQ8IDUnKAVfYX51ZIEelDwk3iBQXUiTaNE7xoyqssCWxZVFvH05q8319wq5SNrXc5wu
 iX/YEd9XVgjFRWyUXANxYoDAi+gQw4m9kjivweBy25KCH1NMQQhf5SaEjTlmYvBze9QzJXC8r4S
 BVHUGs89YFOqYjsPTaIdjBHqpgdXfeIVDqvpvINcq4E95V3E+kwuvqHrGbjuEBMf4FQGLBfcN9q
 hPt0thsj7augm118fKZZAvMloinutx7EHuC8SsNGxq7ahL7Igj/7AM80lLAsnqS0TREY5hfi/I2
 V3HMo52BHSqsaCmrWLY+FFZTB+fEiL7B4yxyZ4gPYd/6LosrGCm/YOIKFofX1WaLFK0eGdmKBR2
 i2EvEHfky9nlGPpw1+jkgxNlvPq+tA==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ee0f8f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=BM6OdSh4NsqE7HirI3EA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On 10/14/25 8:24 AM, Ayushi Makhija wrote:
> On 10/6/2025 3:44 PM, Dmitry Baryshkov wrote:
>> On Mon, Oct 06, 2025 at 07:09:23AM +0530, Ayushi Makhija wrote:
>>> Add device tree nodes for the DSI0 controller with their corresponding
>>> PHY found on Qualcomm QCS8300 SoC.
>>>
>>> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 98 ++++++++++++++++++++++++++-
>>>  1 file changed, 97 insertions(+), 1 deletion(-)
>>>
>>> +
>>> +				mdss_dsi_opp_table: opp-table {
>>> +					compatible = "operating-points-v2";
>>> +
>>> +					opp-358000000 {
>>> +						opp-hz = /bits/ 64 <358000000>;
>>> +						required-opps = <&rpmhpd_opp_svs_l1>;
>>> +					};
>>
>> Does it really support only a single freq?
>>
> 
> Hi Dmitry, yes it support only single opp frequency, I got this information from ipcat sw for monaco, similar
> we have used for LeMans.

I can attest to that, even though I'm a little surprised that's
the case

Konrad

