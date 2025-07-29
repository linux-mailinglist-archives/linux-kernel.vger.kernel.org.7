Return-Path: <linux-kernel+bounces-749096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47DAB14A09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B32318A314A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2B128150F;
	Tue, 29 Jul 2025 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="beRGaaBD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB65727FB32
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777406; cv=none; b=OEku0GDVTIv0Xsa18HPPVKCVv8Z/uuCAiq4InzJLr4yzVcWjbhTWSxtFQES3sqfaAAWjoGEvtwy1QgktudeG0WpAz/YU7AoFVLiUHVhFsgg5jPX3/cecT0tuwsEpJut7VSAlLQshQ43ZAzUWPbuzzMMuXIp+8Lt+SsaNeswW35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777406; c=relaxed/simple;
	bh=2wXN7cq02T3bH10Sqn0i6sPundJHGnzfwCRzUt0HFh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyU35gVlXx7jOaipEQxnyPDwQNaBCcp04FuzuJ3g/Uzbyl1XgNRy8xHmZPjL8RdzxZw0IUqfB8jUs3XRt3UFSgmR4DYDf5FR0AAwM//vVpAa0JlOIPrb5JbNN+uBURWeAPvI20j5gc2efGcZgn1WcYw4umu6tPS6UUi2El1Tmsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=beRGaaBD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SLmCsg028312
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7DJ4RaeJMoLupHxD1y+u8eH3MOycZ0I9zFremeBae8Y=; b=beRGaaBDsbR0BDiH
	i/u6yPH+lUSlsbEDtWj7xF+LBUCg5ZiDo9Xl1H2/VATq9IYkGmQssRF2btAK2fQt
	rB9noXkLa8IFXeXigqUwrEP3kz3mfhxrHReNOOONYtMDdu3IvLDrYCat6C7y2dAe
	106si8uM4C+6MAdkHiIA74yszPyOqc71aIw8eIaPffQJDAChxnwZfmZCCCkvaF0N
	e+2aFh4wI12EqRwjCsSg0MDfrapa3SdYo4pOnZxECC3PoG5pq7W7bjZd+B3wAW+J
	wEfO0bRXkJbX02Fb6BWksrju0OVd6Y76/wSaDzNuwpnTDjMVsS7eRrFvL0aRFPz0
	czgREg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2f99s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:23:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab716c33cdso24802401cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753777402; x=1754382202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DJ4RaeJMoLupHxD1y+u8eH3MOycZ0I9zFremeBae8Y=;
        b=MuicSaFaZAXoWnHzJzHjjXj58mSSK1hUp9YRdiXBGvJqtNuR6ndwEizEL1inAYqHXU
         bkq1OKsoBHRNBOCHk4vBWMLQSLIVPXmD7awBrmv/nRYeev6Mfd2JHN3Yp0dWipT9VTQm
         tJ5p07rs2P4Qy3HxrPkqv8aLAXjPjQncBgWSrOMtvR7ycp4eK0EYysrH6sqVzJew2ujP
         0JL9vN4yzsh1nITusrl5baloKbns3a5AAbr5YaxJKeZB3FQ1Tva7IWLWp7NulC+4Wm6F
         8X30s92eu49EXmokys0uml+AXYsbBEiRl8ZNDr/1oIcJqdzjpuN2niKapf0GfMZ9Qh5Q
         5mBw==
X-Forwarded-Encrypted: i=1; AJvYcCV1sbrGQLgj4wTmt7PqT2nPl5H8Npbba6QbcgJMerAGnWZZL9bmWxOAYFGw1BG/vfenKbbNzfXfrqkNW4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpxHYtAozlEyPAYpACg6PObcmZWtOEEtQvafXQjVEDTkutMT3t
	975fsbTxDlCqzVgBB1UZTVHlS7AAMW2eb7U1oIWmSFk3bOvP+qxA8jgfTyaUEt9skxZntR9gbv9
	hMdZf4xNOzyEcRlr6PDYY5GlW89AUPMCS/piRkXan8WZ4Qn/D1XNFNjowoFTmnBmncck=
X-Gm-Gg: ASbGncvp17+iIhVIjZlkvSrWa/Zw3e+wPfZmzqjxeXGx1s+FDOe04nvAgg08OnnPKrD
	s288E9BmkIzea+oG/v2thoCDLYtPVQ6fyxChJECgLXR3M1mS4La/Z3hOKqk+61EOKkt29ixtiAY
	o08U6q9DmbpXUmxMqyDe8qh2WvB3AjVVjyDczBO77Gx5ONWXiKeZdbhybl+wj0AshHeZnrGqJKq
	wC6A/03JPvR0I5m4Cjs/K2Ag6vAJ7H8fg+RvwJRzVuxQa03pHgJPFWWB1H9RvfcO7fVoabtpfVw
	vOToSu2Oq9Zs1wj2JA8CIJVW2hNDJP3CoLRPS6IyQynWtlX4Mxcaetg36QR86PrYLL46QBFT0b+
	JmhLlmVsD2/PIfHsezw==
X-Received: by 2002:ac8:5f51:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4ae98dff702mr76086221cf.2.1753777401744;
        Tue, 29 Jul 2025 01:23:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDpC4Bj15W8z8Hn1ZB09u8n7fVHVo8g7aURbaiorGpbmz59AM5D7ns33AzQ2bV0V/RJUM1/w==
X-Received: by 2002:ac8:5f51:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4ae98dff702mr76085871cf.2.1753777401111;
        Tue, 29 Jul 2025 01:23:21 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500491d12sm4326817a12.11.2025.07.29.01.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 01:23:18 -0700 (PDT)
Message-ID: <6b903628-9abf-4b9e-971e-e9338308d693@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 10:23:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 24/24] arm64: dts: qcom: x1e80100: Describe GPU_CC
 power plumbing requirements
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold
 <johan+linaro@kernel.org>,
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
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Luca Weiss
 <luca.weiss@fairphone.com>,
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
 <50868cd8-68a9-4bad-99f3-8cf542886fb6@oss.qualcomm.com>
 <aIhrav7GKpsbVpto@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aIhrav7GKpsbVpto@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WnqVKCwP0QSR-1dlsdIyy6RkMWbC99hD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA2MyBTYWx0ZWRfX0F6Wv1wuaHmI
 0oxn7jLqXzy6A8gDC7fALdfDI1vJOfImwr8DuyyJDWpOAZbk1QV3JiUwXGgRnDm9TYHAMw24M/n
 hmFoNoB988/MUk6zTharK2eNy2tkKvdGumlNpd0u/Gp/WEPnJoQFtjzelEtrBnsYGPbd7l70ad3
 RNAQ2PO+6cQDkklDQd2jTSYt1ACwwfupRo9+MMckmMuqruLSse6JV9IrInTj0/6AcyrHcgnOPlw
 T2kkyuHRkAxn15Xs0rVrlS+mMPHK8p8qxmXuCrHgGushIcYcFXRqMGuw/zfLu2cy2RDONTIO/7C
 g2LeodE/SNTanJcMWPD+VQ44KPuGrbg+oUAUfeuPM8rhFjUh+Ser4/rlPC84e1qvqDPuY79rkzi
 7daxTcmKkaooph/Lsdo1RO71grGeT0cIawoM8Oijq7CiUncUfs3qwJildzRuVHzqhzypCWD9
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688884fa cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=npIohlpTwfGSXeC_WVoA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: WnqVKCwP0QSR-1dlsdIyy6RkMWbC99hD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290063

On 7/29/25 8:34 AM, Stephan Gerhold wrote:
> On Mon, Jul 28, 2025 at 11:31:10PM +0200, Konrad Dybcio wrote:
>> On 7/28/25 7:10 PM, Stephan Gerhold wrote:
>>> On Mon, Jul 28, 2025 at 06:16:24PM +0200, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> A number of power rails must be powered on in order for GPU_CC to
>>>> function. Ensure that's conveyed to the OS.
>>>>
>>>> Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>>> index 5e9a8fa3cf96468b12775f91192cbd779d5ce946..6620517fbb0f3ed715c4901ec53dcbc6235be88f 100644
>>>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>>> @@ -3928,6 +3928,12 @@ gpucc: clock-controller@3d90000 {
>>>>  			clocks = <&bi_tcxo_div2>,
>>>>  				 <&gcc GCC_GPU_GPLL0_CPH_CLK_SRC>,
>>>>  				 <&gcc GCC_GPU_GPLL0_DIV_CPH_CLK_SRC>;
>>>> +
>>>> +			power-domains = <&rpmhpd RPMHPD_CX>,
>>>> +					<&rpmhpd RPMHPD_MX>,
>>>> +					<&rpmhpd RPMHPD_GFX>,
>>>> +					<&rpmhpd RPMHPD_GMXC>;
>>>> +
>>>>  			#clock-cells = <1>;
>>>>  			#reset-cells = <1>;
>>>>  			#power-domain-cells = <1>;
>>>>
>>>
>>> To repeat your own message from a couple of months back [1]:
>>>
>>>> You shouldn't be messing with VDD_GFX on platforms with a GMU.
>>>>
>>>> Parts of the clock controller are backed by one of the MX rails,
>>>> with some logic depending on CX/GFX, but handling of the latter is
>>>> fully deferred to the GMU firmware.
>>>>
>>>> Konrad
>>>
>>> Please describe somewhere in the cover letter or the individual patches
>>> how this relates to the responsibilities of the GMU. I searched for
>>> "GMU" in the patch series and couldn't find any note about this.
>>>
>>> Also: How much is a plain "power on" votes (without a corresponding
>>> "required-opps") really worth nowadays? An arbitrary low voltage level
>>> on those rails won't be sufficient to make the GPU_CC actually
>>> "function". Do you need "required-opps" here? In the videocc/camcc case
>>> we have those.
>>
>> Right, I failed to capture this.
>>
>> The GFX rail should be powered on before unclamping the GX_GDSC (as
>> per the programming guide). The clock controller HPG however doesn't
>> seem to have a concept of RPMh, so it says something that amounts to
>> "tell the PMIC to supply power on this rail". In Linux, since Commit
>> e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the
>> domain") we don't really need a defined level for this (perhaps it's
>> more ""portable"" across potential fuse-bins if we don't hardcode the
>> lowest level anyway?).
> 
> Thanks, I forgot that we have this commit.
> 
>>
>> However after that happens, the level scaling is done by the GMU
>> firmware. This holds for allOf CX/MX/GFX. I'm not super sure if
>> both MX and (G)MXC need to both be captured together - downstream
>> seems to describe MXC as a child of MX (in socname-regulators.dtsi),
>> but I'm not really sure this is true in hardware.
>>
>> The GPU driver currently first enables the GX_GDSC and only then
>> does it kickstart the GMU firmware. Downstream seems to do that as
>> well. So on a second thought, since we've not seen any errors so
>> far, it calls into question what role the GFX rail plays in the
>> GX_GDSC's powering up..
>>
> 
> It might play a role, but we wouldn't know since AFAICT we don't support
> enabling the GX_GDSC. Look at the beautiful gdsc_gx_do_nothing_enable()
> function, it basically just defers the entire task to the GMU. The GDSC
> just exists in Linux so we can turn it *off* during GMU crashes. :D

OHHHHH snap! I, on the other hand, forgot we have *that* commit..

> I think we should identify precisely which votes we are missing, instead
> of making blanket votes for all the power rails somehow related to the
> GPU. In this case this means: Which rails do we need to vote for to make
> the GMU turn on? If there are no votes necessary after the GMU is on,
> it's better to have none IMO.

The GMU pokes at RPMh directly (see a6xx_hfi.c), so we indeed just
need to make sure that it can turn on.. Which in short means the
*C*X_GDSC must be able to power up, which doesn't have any special
requirements. The only question that's left is basically whether
MX_C must be on. I'll try testing that in practice.

Konrad

