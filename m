Return-Path: <linux-kernel+bounces-805694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD6B48C64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111761895C8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A306220F3F;
	Mon,  8 Sep 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bnVhBCf3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDB2E5B11
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331620; cv=none; b=DDbraLGNyAcqLauuw3I1YeUqWIJEG2+/lfMr3rtk2+ZNgUiABU0FFTPDpoObECFB2SfwPlG7NOwCWtQp+CAWWNAyS7CND2LtAlilr1j5rVJ/fjZyrGVcRhAorPBnpJT78k1kBJ9fI34kfEKIzgZ6jmzrRxT4Twcc9IFRLLj8P+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331620; c=relaxed/simple;
	bh=mkZ6cmKwkvA3JrlNWuoEOfbkg9E/yY2SgCd/wPVk0Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/4uAisK4j8NWErnB9y9+PRMvlpKnsi2ePlSFm4dKhbVv/sLnS46qjyyRb44D0AIfkUCDMfSdA6D3+gcakGcfzerpPDPdpXFhJSJbKINU6tqu//gyDBpFqaZ4Tv0XbX7++1WeQb5HlDgl0HNkI8J3LvgAfpY5IGEC5bi3yMs/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bnVhBCf3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889LY8W003963
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 11:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NnEbO7ArMxQ89jgAEQwVkzyZoAUuZFaKn25X0Rq6OME=; b=bnVhBCf3W5YshFsc
	JTPN2wRztoaTNpoO2lYqtUE5Q/kBi8X8bL4Jfi1y5JNY84n93nx/6hOUiF6tHvEg
	eEdmDS/A5DKloz5qnPXVgew7SCHnTdpEFshGM3ctH0aJ8RGz1vmvgoWyM6660R47
	+O2/mGJYtmnzNFroX7p9WXwG3P3jVQIxfZgi2qvn/GiihOWvSztZvyI9tv0bUlOU
	/8pKuNGJLnhszzG3Z0D6MD2x2S2YlIOpFq1RHPxEr2rIdBn7Ma63/zftjyxESLs/
	1ngsUbu8nMb98pPZOfmGonsKZzWxQfirL/nUD904xBg2mi+zt/way+9ct9ZoiTd2
	ZBvVWA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfvb7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:40:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-812c3483afaso89990385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757331610; x=1757936410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnEbO7ArMxQ89jgAEQwVkzyZoAUuZFaKn25X0Rq6OME=;
        b=q+PADDwZD7j94wcau9Vp4ATRJ6XFb/hrmBvHSeHzOJGxvz2V0nIWEVJw++edzc+t7U
         RSX84xfzh4QXyNQxno8HtkvD94xKRp4AV0mWnA2eNJkRbBHOElNFg2aZ5eiS3XFnEMcV
         lfLT7txXpENWwJ6s7RVjROFl2hbVQ5hMSLEH7Tkf1kdHVhFTzuqL6DIP0GY0/fPu1MW0
         JfLfO24K8RW6mM+HVtbNW6GHP2qIy07YZcP1dNVblu8Ans8iyf25ALx9pm4jghpS4JaX
         TgjOi5q096fdD+lFUprw3AQUVP/+yi9UIv0x7DsXSn9B/BSWORB3XBGHv8cI1ovkfOOx
         FKYw==
X-Forwarded-Encrypted: i=1; AJvYcCVO6oZlP7vTXbxJ5wyp3Qncrztvm3IxJX4XLyg52Cc0P0srSKLlvzsI9E0s9c/HW7bARE5HVhbuDsT68WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbtxrrSy/4mImDr8Yzk7rEVkXS6TW6Z7ep8d7gGYlvcX+17mJm
	j2Gmjgs75hXl4rfRp413off0OM/qBJ8r5NzAG/IIUnIFL/lb+3sJl6MipHFHjHQiBcXw+bINmm+
	HOzl+AsZ0N3Mpc2vdBg5gtwj3x67W3xxwGAcrYV00zGar1Cfny7Nt3dhoacW7jMb3F50=
X-Gm-Gg: ASbGncvRWi0zdNPfMxlgApzuZz7f6OinFKiAAld8JtHsyiVG0+5IqjIBXpnYaEmHNXr
	RcxOfiGkarnl+6w45cWjBxIc5x2ZpbhURbwcyPPEogIEFB0YiBf+avK2TlWyiV5sI9UViHU7tq7
	0eN48orrvRGyOaRJ/VhK9LDw68dwpoKqxyEAzS/Pu1RhvCytACETI5P6Mpxe5LAJOIYxJVyrYxC
	NnV2PpUCUr++rHZCICI5QfiEirlHHXhFK6a/DC402RzE/+4T899wW2X0+/FwOE9kUwdHPsc/rrW
	m5cp6uT9Nwn+r0SxT/LqXJFSMEs3pVFwXUtFHyPZKrnWgf2xPDmWa3ZvbnlCsiPuyCtrfcrp4Da
	tq6T+Kd+LJr1LdzAaeDGa8w==
X-Received: by 2002:a05:622a:1355:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4b5f85310efmr55841171cf.9.1757331610323;
        Mon, 08 Sep 2025 04:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxfpBCfjkE1QhZrW+7/NQDQGsgDEMhq3BgEaMgwoV6K03PfppLuh0RrNhfqqjSD1n65xJK2Q==
X-Received: by 2002:a05:622a:1355:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4b5f85310efmr55840761cf.9.1757331609503;
        Mon, 08 Sep 2025 04:40:09 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046f888b95sm1229367066b.34.2025.09.08.04.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 04:40:08 -0700 (PDT)
Message-ID: <365b984c-a5e0-4fa3-a011-b897107e2b92@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 13:40:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 add HDMI nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250821-topic-x1e80100-hdmi-v1-0-f14ad9430e88@linaro.org>
 <20250821-topic-x1e80100-hdmi-v1-3-f14ad9430e88@linaro.org>
 <a38df652-54c0-4216-9aa5-c8d32599c8f7@oldschoolsolutions.biz>
 <c66fe361-74c9-4471-b371-353ca582bb3b@oss.qualcomm.com>
 <xzw26v6aqutgau3zwm3njblf2qw2em53n45ju2yhhfh7uhyxbz@6kqvink2chld>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <xzw26v6aqutgau3zwm3njblf2qw2em53n45ju2yhhfh7uhyxbz@6kqvink2chld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BSOrehBaU-Ix3iZPPGH0ScIJl5cJ_tMB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXwtXN4b8vG9cw
 2khReL5YH2TRoXpI3PnHWuMXy4CuRYR329eLzpZlON4Us30FFB/lpHsImmfuyowUsXq2Q654/UM
 PBdghXbqjVvt31ZElkMDTJmDGJqbsu1M5abMN8zbG2YxIX5wqRwgn5XWZVRFwGfQO1sh4FIeh4l
 KCVX2kuzEGE21J98I6rql0V2wDm0ZWXNBVPC4kUlmRh1nU3/7UD5edA5WEq/zjcpsWxkXkWYeys
 Kv4rjggikHuXgaDB+8wwUzBD9bS+scT5ThO7MCP9t63knu13f9o1i1bblFbO+HMpwcEZTxHzyo3
 fnqw4tscecfFWrtUrofxxVPlwK3Z+bLoJ3MRE9YBYlIZh2DBzFYqqXeEbQm4tg82LLTXNkLjgYj
 XiCCX81w
X-Proofpoint-GUID: BSOrehBaU-Ix3iZPPGH0ScIJl5cJ_tMB
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68bec0a2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=0cVmaDdcn-jcdQdzUFEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/8/25 11:39 AM, Dmitry Baryshkov wrote:
> On Mon, Sep 08, 2025 at 09:16:29AM +0200, Konrad Dybcio wrote:
>> On 9/6/25 10:41 AM, Jens Glathe wrote:
>>> On 21.08.25 15:53, Neil Armstrong wrote:
>>>> The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
>>>> connected to the third QMP Combo PHY 4 lanes.
>>>>
>>> [...]
>>>>   .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 44 ++++++++++++++++++++++
>>>>   1 file changed, 44 insertions(+)
>>> [...]
>>>> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>>>> index 4cf61c2a34e31233b1adc93332bcabef22de3f86..5b62b8c3123633360f249e3ecdc8ea23f44e8e09 100644
>>>> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>>> [...]
>>>> +&mdss_dp2 {
>>>> +    status = "okay";
>>>> +};
>>>> +
>>>> +&mdss_dp2_out {
>>>> +    data-lanes = <0 1 2 3>;
>>>> +};
>>>> +
>>>
>>> Hi Neil,
>>>
>>> shouldn't mdss_dp2_out also have the link-frequencies property?
>>>
>>> +    link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>>>
>>> Or is it something the bridge already negotiates?
>>
>> No, it seems like our driver falls back to HBR2 (54xx) ever since the
>> driver has been made aware of this property:
>>
>> commit 381518a1677c49742a85f51e8f0e89f4b9b7d297
>> Author: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> Date:   Tue Dec 27 09:45:02 2022 -0800
>>
>>     drm/msm/dp: Add capability to parser and retrieve max DP link supported rate from link-frequencies property of dp_out endpoint
>>
>> Dmitry, is there any reason not to allow HBR3 by default? Is our dp
>> controller/driver not smart enough not to advertise rates it can't
>> support, during negotiation?
> 
> I don't remember the exact details. If I remmber correctly, there were
> cases where using HBR3 resulted in a less stable signal than falling
> back to HBR2.

A very early revision of that series has a commit message that reads:

"""
Since it is not every platform supports HBR3 link rate, this patch
limit the DP link rate at max link rate if it is specified at DTS file.
Otherwise, the max dp link rate will be limited at HBR2 as before.
"""

Konrad

