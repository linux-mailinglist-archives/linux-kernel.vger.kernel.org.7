Return-Path: <linux-kernel+bounces-845450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D50BC4FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA74F3E92
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE94251795;
	Wed,  8 Oct 2025 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FYpw7sr5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12EF2264A3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927855; cv=none; b=e+ILDK13Gz5FETP4H39i8Q+ZK86cTAtsb3Nn7VavpHS2Z06KeTnPvuSEm1SM6p9FzykLMhDHN/WkKhmP1hJbigwhutT4szolWHYru3M2OZpUCQaKKdUKeUqpzQasc00D6N2SGYwGV+XdlA6RsoKDM5Le4NTFfJQ7CHtcSdhzUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927855; c=relaxed/simple;
	bh=0b2N98FdQpH0Wdd6mea5Yi+O7il5kziKC3shD0jRcLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkHQpRe1Kw+QQ8a5+Em22JVd1ZzAQ3FyRRCQrKzEAT4fLBhPk1qBBvV0lBhBJucO8ZyfiCiRfDZZKKw6FGeP8K2h+7JlXY5hFU2jkEdY7z/q4x8xiUYv/zX9LpO3ooxPF39bqqTCwjtztaAyWWZgDSaj5PaaM5ps35p97URSCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FYpw7sr5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890TAa028979
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HjXA54200/MazhziXIpKEeI9K5n9Bf0pQfwu9EvIxC4=; b=FYpw7sr5rxcDfAem
	UzAZ/lwkxo2ODXO5AvoIyUUBbP5OAwJFOM1WVVHFO6hIXDd2cJaZp2Z7x+hbOXTF
	aBF+Cj6OWwrP+fC73ZljkOYMxTwmzXa1nxTonQK4N4nxl8IQ+U6kuJOISiPAAhCP
	sVYY2rheAg30xW39mxiHfR/b+SZBLU2pEX1Ji/pnVXKL8RpAbzFcQzb+De4U4AL7
	As3sKNXCezKByJ8MaovHjo8mRCRMqDK8aRnyI77oo9t85gwrJnjimzpanMf3K+wK
	NO+dPXdbUahdeXC4ngpTg5OUpWD+OuruBY5X/xSXSGcTx0587E0ioz0hUb7UEwCP
	gZ70kQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9e2qq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:50:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e231785cc3so30504141cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927852; x=1760532652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjXA54200/MazhziXIpKEeI9K5n9Bf0pQfwu9EvIxC4=;
        b=tukd3WxE4K7XXkZ0GvKWMAy/ddlgvdIjTxyTK0KGecJ/OMWO5mSIaSxHaNk6mgZRtF
         ZeJJxjvd9GueBtJHXJ/o264KLrkOqZTlwutNq4n/GQ+Ojc52Ryjii3J8U1DORGqzc6L7
         pbIUrDyiOJJXQQk2pZyIyzsyCEvQnzm30y8tK8KM/jbgkjVDElinJv+fsWJgWoJclGfk
         gnsuyH9V28SbrG9fA/NMOJdYc4aHxLJh6WL1qtXsZUaQM247SiQnAmlUs3A4CMsZKgoJ
         jZ12Zd64bRjnzfDno3wfyIrryRzUm/HQrJA9T5Q/4+2mO7akGDe4oePNelIJJBu+8D5f
         L5aw==
X-Forwarded-Encrypted: i=1; AJvYcCVAu9TOz+B/qrx5/32zmPW99Y4gkvE1nMJrmJSuRi5jDYQLc7bjNdgycidUWnIY/EhWlw/rFCGmJOlvxLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIakFyU0fGhFU933e9a4i7fAbiZ+s3DMM0sfsuAPaBjy+3BOeU
	P+ToXWq4HF/gMYlAm3XQ8PgmqiLwXZw3yAzB1JCC8kcFR8HhEiZ9ba6pIY93kJ3quD+PalmZwtw
	SKJ7DNZKJEQuqdNq7Y0aSb6u0iizzXLeDAbRJW3OoUowzRsGkcOtwAf13zcScavGuZkk=
X-Gm-Gg: ASbGncukFRmRDLDMz/tH9cm0I0A5o57YgyJPgab4OmDYxedu/pETIfgQ24XeLrtv+NV
	nLzC0532S6b/koPdQkO4+HbTqBqFXorPe3A6KOZ6wUGSsKneBvev1ApGPksX8LgwzwB/Ffrdgws
	YPvPt1bOuo2fjMYfpCTNqIZ1zqAuBXSSXMazB22/HkKzLA0Qgtlk/G063f1h8B/bdg5gmP+VpwC
	DmyCXIWtW6hSm1dBQ5P4SMjY3NXzqfwtPn2gybHjxj50eiLx3HuWYeCQZ1dyRHIkeSe7gm00FSy
	d0GbdyGTXNbR/RsGyAO4wyrl5a4VQH8aiwkeabYKRP/4js79kQdtuobG20SMfxnBmznxwqS57Fg
	XtZ4rHaQhAwZe6aMDkiKqnK3VqCg=
X-Received: by 2002:a05:622a:60c:b0:4d9:ac87:1bdc with SMTP id d75a77b69052e-4e6ead0aba7mr29848861cf.6.1759927851731;
        Wed, 08 Oct 2025 05:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd3wvG1Ynm7djM218qT3jkj11ov7+KlyDnSw0DDL6cJyrMjJ5qDwiZKjNKdh5U87l7RnzuDg==
X-Received: by 2002:a05:622a:60c:b0:4d9:ac87:1bdc with SMTP id d75a77b69052e-4e6ead0aba7mr29848301cf.6.1759927851051;
        Wed, 08 Oct 2025 05:50:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4e49esm1648890166b.72.2025.10.08.05.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:50:50 -0700 (PDT)
Message-ID: <b14ca601-56d8-4ecc-8813-b9b642646a0c@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:50:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: lemans: add mdss1 displayPort
 device nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>,
        marijn.suijten@somainline.org, swboyd@chromium.org, mripard@kernel.org,
        abel.vesa@linaro.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        robin.clark@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        abhinav.kumar@linux.dev, sean@poorly.run, airlied@gmail.com,
        simona@ffwll.ch, alex.vinarskis@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_riteshk@quicnic.com, quic_amitsi@quicnic.com
References: <20250926085956.2346179-1-quic_mkuntuma@quicinc.com>
 <20250926085956.2346179-3-quic_mkuntuma@quicinc.com>
 <e3400ab5-c4ea-455a-b8ea-d4fba2ece85d@oss.qualcomm.com>
 <6uo2w4lscjlx5mtio2xw3xgyyu6kem6kavtdxtu7cbyix6kews@h2ou2awbppzy>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6uo2w4lscjlx5mtio2xw3xgyyu6kem6kavtdxtu7cbyix6kews@h2ou2awbppzy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e65e2d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=Nc9AMxU9nlP_Mo_kQ7EA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: tb6GkaLFHKVod4INy8h1fFTCd6ze_Oc4
X-Proofpoint-ORIG-GUID: tb6GkaLFHKVod4INy8h1fFTCd6ze_Oc4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX9CwWJPIH47Jn
 YTkLytTFzDctmkO2QAVHG0YthPjwKvOUgog+2V6+5YOHGlVc3JRSb6eneCMoa8LNN3ksAj8Wybl
 /bseUDp9qwykosM1/ZfdKccZpoHHOERngn7/47/WJkOanB0sPJ7DDo1tP2P7+G1gCpgdBkiMgIJ
 aL2MPip8oi/zDUrrofpEv2AMR5c/NSk8GYsObruc4RmH5Jxcn9/oiW+HvTmg5i8/g0aYqf+KgGx
 c8pmdc178X6IDJUU/W2+iYfgZC1vqa7eVEagQwKdeDfTmTEO8Vu95vmw8cKOuxU2FdfcnOWfvAP
 1REm3iZwvZvJ80aqpolq2vp1LAGQqCoQLG9z8px5e92U3iW+6SckqFytACG+8NoEx1I96YozJff
 Yh9O97vC6+B47Go9CwjbHFYHCpJZ4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 10/8/25 2:49 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 08, 2025 at 02:40:35PM +0200, Konrad Dybcio wrote:
>> On 9/26/25 10:59 AM, Mani Chandana Ballary Kuntumalla wrote:
>>> Add device tree nodes for the mdss1 DPTX0 and DPTX1 controllers
>>> with their corresponding PHYs.
>>>
>>> Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
>>> ---
>>
>> [...]
>>
>>> +			mdss1_dp0: displayport-controller@22154000 {
>>> +				compatible = "qcom,sa8775p-dp";
>>> +
>>> +				reg = <0x0 0x22154000 0x0 0x104>,
>>
>> sz = 0x200
> 
> Hmm, why? I think the memory map specifies these sizes.

Yeah and I went in line with the allocated region size (not last register)

[...]

>>>  		dispcc1: clock-controller@22100000 {
>>> @@ -6872,6 +7115,8 @@ dispcc1: clock-controller@22100000 {
>>>  				 <&rpmhcc RPMH_CXO_CLK>,
>>>  				 <&rpmhcc RPMH_CXO_CLK_A>,
>>>  				 <&sleep_clk>,
>>> +				 <&mdss1_dp0_phy 0>, <&mdss1_dp0_phy 1>,
>>> +				 <&mdss1_dp1_phy 0>, <&mdss1_dp1_phy 1>,
>>>  				 <0>, <0>, <0>, <0>,
>>
>> You need to remove the same amount of zeroes that you added
> 
> Nice catch. Which means that somebody was sending untested patches.

It would work.. until someone tried to add DSI to the second row of zeroes
instead of the first one

Konrad> Nice.
> 

