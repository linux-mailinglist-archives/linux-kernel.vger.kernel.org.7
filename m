Return-Path: <linux-kernel+bounces-833799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC21BA31B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADFE323D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DC529898B;
	Fri, 26 Sep 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cmaCLpTk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56C5279798
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878325; cv=none; b=RANfpt/DoiQKmekXLYUadEwENNGUOHLvk5rB11vPNlcmVs+0QJIoM5NHhr01bywq9QtZfO1TLu0xKSTAonBDpsoOIphOJE8ZluRl2Or9zJBuvT484PV57cR99yqXmEbuo2JQW+3BBAIV+RG45rK4URq3ZPK18yJX847CayQwnRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878325; c=relaxed/simple;
	bh=rvO3y3/5JAXHInb4ycTcmOW2bVUrrDYIJ2o+IzNAf0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFr4Q7HDidFG7IvVf9Uo0QmcBxtMH0gxpvQ99kKwDwWZ0AhRfN4gLR8n1Zuy0hx3dJNimUWJsSzxhN6dc4kbR6/IDP9d+4dWu75MWHHFE9DLKbO2u/QO+4cKAvuwyE99QTRxlcmfySDcROQ+6If7I8ERp2CJm0trE/DaSOotDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cmaCLpTk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vhUN020770
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rOinGqMz0tMy8RVDVP13kAvHKKpdZ8bA0MN36ekzJAk=; b=cmaCLpTkhocavNRl
	lPz/e9Qigm1zvnFtNb/NJtYqx/wMYenNj+jJi+YcsX/La+4w7bAKF7bkrLUR/a5a
	a8Vjknvg5SkbRuUcIwsjPFd/KvlzTxJXkPSfcGpAD3sLo4TJveXvEGUbecmJkyCZ
	iF5xQNnXaYul98pS6gzFLsurGrfuXQNx0YMNcFAQpLNMhkcUX2nygeuVorxCoroc
	UUQgTGyP1YfrZaAGWSrGutqwJU5jC/XSaGwm4pF21obGc0si4y0vQvL/AuDVw2WI
	HY38CSMCMH2n4vMAz3OCHywSuWRpamI7LrNEUnhQipnI+z5WJWFKrBuFKNuDfimG
	jTie4g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qt8q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:18:42 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b549a25ade1so2460020a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758878321; x=1759483121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOinGqMz0tMy8RVDVP13kAvHKKpdZ8bA0MN36ekzJAk=;
        b=t/OXQhmZeR3VFKMJZlkbWnXksAoT1cjFmjxvqquPdwjEdI2YSxiUdkggMJa4E8GbNk
         n7z0T26hah2P+BFlZgF2weilgdYEEHXsbLyhas+UP/jg6RmHG7xXiZ5GtUU4q1infFlJ
         vHJTt6Bs5VyonkH70DHeP6WxytSsVr3QX2iL5bW0MPWFAmvGDMpJ6R0wgMFbdHRhEiL3
         eWKFGtueBRkuTArLqHVZxKM+wTWSOFmvHtxyucAGlEkiOgnkT1tL5MC9LceFpdAR6oyB
         tYf7niRjOr2s8w83tfrUBjkJWFEzry2AfpUB1/PUc9QIh7AcmImJrCSfypR2hySLqdOm
         fF1A==
X-Forwarded-Encrypted: i=1; AJvYcCVViFPKVyFCFv1vTh5tWgmJi4g+cAHbojKWq4LY9+Z4XIH9IPpqeDHTsedI5kSFMfYmMNObYV3yIqxqREc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7l3zkRVXEue+XK0n7WeHtIs6YvpsOdAuRqba7w1bUsZBP83K9
	lkuSG4sO3xL5nInXHSllvgvK1HgkuNQgJir22Tj0qBhzcwbYcleodHI7/PRKI3s5EbXfdfjCGar
	xsy1XibFSsYrRoKLc7n7vFL+4lswWmRBFK5WI9AnkcPjTmmdQRoZpkhS/mgCsLfzM9ls=
X-Gm-Gg: ASbGncuBehYNSlG2fKsU7UrV0bHoQ7MZLlQSVSsWC5/0tQakugCr/4jTC+Rw6LmIcc3
	8enozOoGU3z8JgiLb2vhE1BCXa212f4a8cJ0DVlLo8xTjo9J61WTHbiVurfhJWPjFLx2owY53sJ
	UMdaeXzIntde0AGJy9VP8A+5qUuHBmxBLbkmTlEsbCB2WyE0Q1nFJocdFfisYJLZlu1pME+5ykg
	4vph/6ig/ch/6nYsZyFlYdnEMa1eLXFmMG3MnZ4msQdLbm3BAWt9BiDlc20rRSoS0bV2c0w5iw4
	5eCzOf6dyw7x0inpP2MVeGwVt/caCtViXz4OdGsH+X77KT+mJ9/hOOEwB9Y1DGyq07Gj
X-Received: by 2002:a17:90a:a783:b0:330:6c5a:4af4 with SMTP id 98e67ed59e1d1-3342a2df0e7mr5798186a91.35.1758878321222;
        Fri, 26 Sep 2025 02:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE2VmbA3V5xKxzDOD6PkH2qKlTH1jNQO9LGj1hh8V7XSD/77IMu25QlmTn9kHgwhzPfubZyA==
X-Received: by 2002:a17:90a:a783:b0:330:6c5a:4af4 with SMTP id 98e67ed59e1d1-3342a2df0e7mr5798146a91.35.1758878320750;
        Fri, 26 Sep 2025 02:18:40 -0700 (PDT)
Received: from [10.217.216.188] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53db8d2sm4185722a12.24.2025.09.26.02.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:18:40 -0700 (PDT)
Message-ID: <555039f9-a168-4a9c-b45c-d4583c553bc9@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 14:48:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: qcom: Add SM8750 video clock
 controller
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250829-sm8750-videocc-v2-v2-0-4517a5300e41@oss.qualcomm.com>
 <EAIobHjo8rM1e0LwqDqaUllC0qjV5ElMMhk6KgT1oNnFt_-k7ctM2_6kym9OjEtse5o4pOFM7yCkXgrSGRZhuw==@protonmail.internalid>
 <20250829-sm8750-videocc-v2-v2-2-4517a5300e41@oss.qualcomm.com>
 <d965949c-a7a0-43df-9bf1-c1232fc7e38e@linaro.org>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <d965949c-a7a0-43df-9bf1-c1232fc7e38e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: J9S41w2-w-CL96_6yY0XUGq9O9To388g
X-Proofpoint-ORIG-GUID: J9S41w2-w-CL96_6yY0XUGq9O9To388g
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=68d65a72 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=iWq2tNaQHCMtPVGnXkoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXxLqr5Bet5+HR
 4tCUOXihm2x6vUEYQebY9gYox/9tkIGxrcGKCS7W20kAwDPmCYmkSkXFO8rCREz9GsDKn0uQkXE
 kaGCe3havSbsow9xNQC1rq9JsbehPvZjYolHyd3nUtP6+CV5oSkykpskB12H7qgd6CybtyDIBby
 BHpgyE0gdCt8vnGTO2DA1Oofg+I6EOEP7BT+TNzo4Zje3z058WkJ+mVZu6rs7LFrfgGeWcS7GHH
 ZXeRXC9aZW8FitIYZLl+lNx3q4Jc+G5XnXGyrQLWiag9WmyEUOwD4+zFeAoai1mspFOkZGvM59n
 c1Bf3ENCdeGF6Veip12g2O1B+JM19hrrVTD/Vz4YHAgA95+vrzy0wqvble3TAWr/+WJadpIrZ71
 51BnV15c/+mOI+w7M547VVfuxXX0tA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171



On 9/15/2025 4:28 PM, Bryan O'Donoghue wrote:
> On 29/08/2025 11:15, Taniya Das wrote:
>> Add compatible string for SM8750 video clock controller and the bindings
>> for SM8750 Qualcomm SoC.
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>>   .../bindings/clock/qcom,sm8450-videocc.yaml        |  5 ++-
>>   include/dt-bindings/clock/qcom,sm8750-videocc.h    | 40 ++++++++++++
>> ++++++++++
>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-
>> videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-
>> videocc.yaml
>> index
>> fcd2727dae46711650fc8fe71221a06630040026..b31bd833552937fa896f69966cfe5c79d9cfdd21 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   title: Qualcomm Video Clock & Reset Controller on SM8450
>>
>>   maintainers:
>> -  - Taniya Das <quic_tdas@quicinc.com>
>> +  - Taniya Das <taniya.das@oss.qualcomm.com>
>>     - Jagadeesh Kona <quic_jkona@quicinc.com>
>>
>>   description: |
>> @@ -17,6 +17,7 @@ description: |
>>     See also:
>>       include/dt-bindings/clock/qcom,sm8450-videocc.h
>>       include/dt-bindings/clock/qcom,sm8650-videocc.h
>> +    include/dt-bindings/clock/qcom,sm8750-videocc.h
>>
>>   properties:
>>     compatible:
>> @@ -25,6 +26,7 @@ properties:
>>         - qcom,sm8475-videocc
>>         - qcom,sm8550-videocc
>>         - qcom,sm8650-videocc
>> +      - qcom,sm8750-videocc
> 
> Shouldn't this be qcom,pakala-videocc now ?
> 

As of now, Bryan, all of Pakala is using the SM8750. We can migrate
everything together to maintain consistency.


-- 
Thanks,
Taniya Das


