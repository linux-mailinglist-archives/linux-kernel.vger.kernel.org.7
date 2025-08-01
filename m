Return-Path: <linux-kernel+bounces-753306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 724B1B18155
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0777AE8D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA73221546;
	Fri,  1 Aug 2025 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jp/hcV3q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A231E5711
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049272; cv=none; b=U5f/feVCS+M/6AizDokc02Ssph5FTaRNb54MJMrmAPdm0mH+0rQfppwmiKRr5UAUWMtVyaWhlUtiddPo1BSBrtGchC8E4O4ghs2fhGH2TgQxsvkfNTEh7k8oL1o2gvqYiSQXfqdHr5k/E0rrkRN0eRBj5j7idMmhJYcolFkYONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049272; c=relaxed/simple;
	bh=L1ffq+YnAjiE6H9FN6/GOqUbgu3aX3Qw0xclYiGdav0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPPD+sVkhS2pUmLoxlkBGOaTxbWLKsoi9BF4QTjOt/3q6+LX3Jh/NOuMPuhRkHkQxFdU91gcbqDD7nk6uMDQb19GAYAQA2qAt8Z1hJGdeGO3d+pNjnJ2RJpqf3N7bya0/3+m2gJO0N7p0TFL6Uyh/hiKpOMFFRhzbhQe86F4md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jp/hcV3q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719g6hu006298
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 11:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y0yAyctewBGcrkhnpcRUCf+/nTscTMEDN7WOB2NFG1k=; b=Jp/hcV3qVABDrEwv
	WDncH6TBNkGa64/U7vm+13+Z/WyxPjKJMzJNHKHOcYsi/iVnshw+P6XueQPQTSvj
	JxD1bPC+L2URM7wjdGd2cFKPLJr4hsqJo3llLkwuvkGuwB4BPz/Vi7DvJd0tQThw
	8Vo1Evho5Xa4eFoMfQuIY3jYXAhwgDHPVbp5XGh8VXdey0N7rbtSFTruAGPPhGhc
	2SY2lwxv5HcS1iMpBl+M8vv+au3hBrggXhoim/EvWP8CnbRUoJWjn7qGwCha7dfe
	SFNBLsrlfSLZeRD+FWD7hp9P6Zx20v25Q5Vec6fZj7NQBj6wu9RTWqblzLim5CRK
	uG1xrg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 488u650d2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:54:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab60b83e11so3522001cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754049268; x=1754654068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0yAyctewBGcrkhnpcRUCf+/nTscTMEDN7WOB2NFG1k=;
        b=PjPo/26AADKeJ0b+a0I8vcBnPc3R3tVMtaoac39qR5BQ2crAeiPttialfyLKc1N2FZ
         8SocbyMAcdr4zYONjIR1KOCsEzxdbMpIUj2c9nW1UtVebecOBDZBus3sL++4HqsidTvU
         3JRcUsUql3JZytTAcxxVi16rEg4RUkPBIKnGR7q59PB+FNWmoD1frc3+vl6VHvimhtEl
         xmiwv2swnUot4M76lFTS2hE2guT6Z/aLw7XVF2L5/5uOv1DTj2f4RlQxTnsAC50WPrlS
         UuS32T+9hnvIyJzW63tWmsntqacDlBzrM0pIeO70Ak5mT0Sbcj4eu2heJRcox5bxwuTv
         cQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYWOy7S6oYJw8RfZZ9f2bWB7PNTpXKjOyQ2a5A/IbS41g5hTyP50anozPu+UR15/IiI29B+0BGbf2RFFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8T8FtqFvB2l9Sqd9GUGRKudjLXwRNKNduQxL106NrcWLDQbi
	+fOPh+vPIavyFSbhsQN/e0ts5KCjKykEezTNEYe5H8DZ9UNQUuNXoITB5gS+IIr/4HjwTGlaWjk
	JcFcM6cR5YHgAAwqggP6JFWDiVLKNGycnzxBWft15WrDfm8Ho814ehsOtNUuVy/2N4rM=
X-Gm-Gg: ASbGncu84KH5o7rjKKoVWJynouiBd1F1MF5NZASPMyiZiD+inX4VfBAd9U7DnT8HNuq
	EyTSZOxB7vhVkxefVbXjptkuMEcWEkqVRLdXz7TlADd2JaxG7Y7xDdysQUkkYdKhVWF9V1I3tBc
	upH8pQ1rifJBd3O5Kiabjy9APFNgDBuE+65FoeMxFO3jeNOcZLm+u/zCMw2BCPRmyn4xYLM2sog
	/HNPPvfWPqqh3Y8BaI6MDFeXokwLIPtcufFCZn5NTEHmO6dLJls7qSunAH85haWcext4NePbE6v
	mZllsqt2RQSd8FqbF7kC1FhXQnD4NE42UEBdTw+23sS3DJWTvYghDRhLZxhOY5PJFdZwSzfaZI5
	K6an2LK1NE32FvwraPA==
X-Received: by 2002:ac8:7f8f:0:b0:494:b722:141a with SMTP id d75a77b69052e-4aedbc28da8mr7053031cf.13.1754049268001;
        Fri, 01 Aug 2025 04:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCLWAyERKRPjTr99qlj++Pgz2FeFXYlRWohtNL2x48UgquA0olCovFHymfIyPzxvQjxQn5kA==
X-Received: by 2002:ac8:7f8f:0:b0:494:b722:141a with SMTP id d75a77b69052e-4aedbc28da8mr7052851cf.13.1754049267571;
        Fri, 01 Aug 2025 04:54:27 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c10asm277886566b.116.2025.08.01.04.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 04:54:26 -0700 (PDT)
Message-ID: <d2c17575-f188-4154-bb63-e0b1b89d8100@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 13:54:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] clk: qcom: Add TCSR clock driver for Glymur
To: Abel Vesa <abel.vesa@linaro.org>, Taniya Das <taniya.das@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-3-227cfe5c8ef4@oss.qualcomm.com>
 <aIoBFeo00PPZncCs@linaro.org>
 <784545d0-2173-4a8b-9d5d-bee11226351e@oss.qualcomm.com>
 <aIxRKHKdBHDefDs2@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aIxRKHKdBHDefDs2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: O7qihFxg2eZA46kO-rts4zg_SfGh-r8U
X-Proofpoint-GUID: O7qihFxg2eZA46kO-rts4zg_SfGh-r8U
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=688caaf4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=pJtBvqx0UPjT60PkLbkA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4NyBTYWx0ZWRfXyRu/0sPhcdNZ
 VZYwSz1IGBZBz7aH2XCFWwfH0VyOgDTrhDYEq2eHvjHLI7ojw7UtmXwDDGfvj6kqNVMmynnEJeK
 K/XhHw3roQaCyokNuZVDL3Jcc6eq/h1UPhVftvaRjiHRLznz5ZeDOETWYUHvJofjlZ6XYwTLNR+
 30aMUWmVBCEbRYp1gvcvruTOMvzIucd7bfVBhTrDHU9F0+D3xsREPTRqywDde5pgZhvuF+fNiNL
 c78K9rUDepensBOBkSbYzli9TkAZNs7rzGgncWLqIg8Tp/UCmiF999iisYQPAIQua3nFa3nsJyr
 dnkucoctPz+pxfyivbJ7ZNQlR3DAC9ZoHwaohnE45FAMp8Dc/IIrmq0/VfjTzs20tjFRM49e42E
 xdCBTT3N1tRad4Lz2w5AlwiLkiSIw658e+4tGNUcJxZmkMlcXWIpdV09jvg7frtM2D+GQh+I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010087

On 8/1/25 7:31 AM, Abel Vesa wrote:
> On 25-08-01 10:02:15, Taniya Das wrote:
>>
>>
>> On 7/30/2025 4:55 PM, Abel Vesa wrote:
>>> On 25-07-29 11:12:37, Taniya Das wrote:
>>>> Add a clock driver for the TCSR clock controller found on Glymur, which
>>>> provides refclks for PCIE, USB, and UFS.
>>>>
>>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>>> ---
>>>>  drivers/clk/qcom/Kconfig         |   8 ++
>>>>  drivers/clk/qcom/Makefile        |   1 +
>>>>  drivers/clk/qcom/tcsrcc-glymur.c | 257 +++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 266 insertions(+)
>>>>
>>>
>>> [...]
>>>
>>>> +
>>>> +static struct clk_branch tcsr_edp_clkref_en = {
>>>> +	.halt_reg = 0x1c,
>>>> +	.halt_check = BRANCH_HALT_DELAY,
>>>> +	.clkr = {
>>>> +		.enable_reg = 0x1c,
>>>> +		.enable_mask = BIT(0),
>>>> +		.hw.init = &(const struct clk_init_data) {
>>>> +			.name = "tcsr_edp_clkref_en",
>>>> +			.ops = &clk_branch2_ops,
>>>
>>> As discussed off-list, these clocks need to have the bi_tcxo as parent.
>>>
>>> Otherwise, as far as the CCF is concerned these clocks will have rate 0,
>>> which is obviously not the case.
>>>
>>> Bringing this here since there is a disconnect between X Elite and
>>> Glymur w.r.t this now.
>>
>>
>> The ref clocks are not required to be have a parent of bi_tcxo as these
>> ideally can be left enabled(as a subsystem requirement) even if HLOS
>> (APSS) goes to suspend. With the bi_tcxo parent the ARC vote from
>> HLOS/APSS will not allow APSS to collapse.
> 
> Is there a scenario where the APSS is collapsed and still the ref clock
> needs to stay enabled ? Sorry, this doesn't make sense to me.

MDSS is capable of displaying things from a buffer when the CPU is off,
AFAICU

We can do CXO_AO instead to have it auto-collapse if it's just Linux
requesting it to stay on, I think.

Konrad

